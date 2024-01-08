Return-Path: <linux-kernel+bounces-19983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025698277D8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B4F9B2316D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2511455C3F;
	Mon,  8 Jan 2024 18:40:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB555775;
	Mon,  8 Jan 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4T82sw16chz9srJ;
	Mon,  8 Jan 2024 19:39:48 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 3/4] Bluetooth: hci_conn: Only do ACL connections sequentially
Date: Mon,  8 Jan 2024 19:39:35 +0100
Message-ID: <20240108183938.468426-4-verdre@v0yd.nl>
In-Reply-To: <20240108183938.468426-1-verdre@v0yd.nl>
References: <20240108183938.468426-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pretty much all bluetooth chipsets only support paging a single device at
a time, and if they don't reject a secondary "Create Connection" request
while another is still ongoing, they'll most likely serialize those
requests in the firware.

With commit 4c67bc74f016 ("[Bluetooth] Support concurrent connect
requests") we started adding some serialization of our own in case the
adapter returns "Command Disallowed" HCI error.

This commit was using the BT_CONNECT2 state for the serialization, this
state is also used for a few more things (most notably to indicate we're
waiting for an inquiry to cancel) and therefore a bit unreliable. Also
not all BT firwares would respond with "Command Disallowed" on too many
connection requests, some will also respond with "Hardware Failure"
(BCM4378), and others will error out later and send a "Connect Complete"
event with error "Rejected Limited Resources" (Marvell 88W8897).

We can clean things up a bit and also make the serialization more reliable
by using our hci_sync machinery to always do "Create Connection" requests
in a sequential manner.

This is very similar to what we're already doing for establishing LE
connections, and it works well there.
---
 include/net/bluetooth/hci.h |  1 +
 net/bluetooth/hci_conn.c    | 37 ++++++++++++++++++++++++++-----------
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index fef723afd..f2bbc0a14 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -427,6 +427,7 @@ enum {
 #define HCI_ACL_TX_TIMEOUT	msecs_to_jiffies(45000)	/* 45 seconds */
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
 #define HCI_POWER_OFF_TIMEOUT	msecs_to_jiffies(5000)	/* 5 seconds */
+#define HCI_ACL_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
 #define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
 #define HCI_LE_AUTOCONN_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 76222565e..541d55301 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -229,11 +229,12 @@ static void hci_connect_le_scan_remove(struct hci_conn *conn)
 	schedule_work(&conn->le_scan_cleanup);
 }
 
-static void hci_acl_create_connection(struct hci_conn *conn)
+static int hci_acl_create_connection_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_dev *hdev = conn->hdev;
+	struct hci_conn *conn = data;
 	struct inquiry_entry *ie;
 	struct hci_cp_create_conn cp;
+	int err;
 
 	BT_DBG("hcon %p", conn);
 
@@ -246,12 +247,10 @@ static void hci_acl_create_connection(struct hci_conn *conn)
 	 * request for discovery again when this flag becomes false.
 	 */
 	if (test_bit(HCI_INQUIRY, &hdev->flags)) {
-		/* Put this connection to "pending" state so that it will be
-		 * executed after the inquiry cancel command complete event.
-		 */
-		conn->state = BT_CONNECT2;
-		hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
-		return;
+		err = __hci_cmd_sync_status(hdev, HCI_OP_INQUIRY_CANCEL, 0,
+					    NULL, HCI_CMD_TIMEOUT);
+		if (err)
+			bt_dev_warn(hdev, "Failed to cancel inquiry %d", err);
 	}
 
 	conn->state = BT_CONNECT;
@@ -284,7 +283,15 @@ static void hci_acl_create_connection(struct hci_conn *conn)
 	else
 		cp.role_switch = 0x00;
 
-	hci_send_cmd(hdev, HCI_OP_CREATE_CONN, sizeof(cp), &cp);
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
+				       sizeof(cp), &cp,
+				       HCI_EV_CONN_COMPLETE,
+				       HCI_ACL_CONN_TIMEOUT, NULL);
+
+	if (err == -ETIMEDOUT)
+		hci_abort_conn(conn, HCI_ERROR_LOCAL_HOST_TERM);
+
+	return err;
 }
 
 int hci_disconnect(struct hci_conn *conn, __u8 reason)
@@ -1622,10 +1629,18 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 
 	acl->conn_reason = conn_reason;
 	if (acl->state == BT_OPEN || acl->state == BT_CLOSED) {
+		int err;
+
 		acl->sec_level = BT_SECURITY_LOW;
 		acl->pending_sec_level = sec_level;
 		acl->auth_type = auth_type;
-		hci_acl_create_connection(acl);
+
+		err = hci_cmd_sync_queue(hdev, hci_acl_create_connection_sync,
+					 acl, NULL);
+		if (err) {
+			hci_conn_del(acl);
+			return ERR_PTR(err);
+		}
 	}
 
 	return acl;
@@ -2530,7 +2545,7 @@ void hci_conn_check_pending(struct hci_dev *hdev)
 
 	conn = hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT2);
 	if (conn)
-		hci_acl_create_connection(conn);
+		hci_cmd_sync_queue(hdev, hci_acl_create_connection_sync, conn, NULL);
 
 	hci_dev_unlock(hdev);
 }
-- 
2.43.0


