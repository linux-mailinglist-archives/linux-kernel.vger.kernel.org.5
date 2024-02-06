Return-Path: <linux-kernel+bounces-54748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A1684B328
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 027E3B27573
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A587130AFA;
	Tue,  6 Feb 2024 11:08:30 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B68D12F5A7;
	Tue,  6 Feb 2024 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217709; cv=none; b=ODG9qXwwfQAbRF3t35mw2jV0JBKGX7tPlWbxIaQ4vtdpy8+nb+wNgtwhUxJazl3DkT0tJUI+KtNtSPsHB9NmBsB3lrZbZ2JHW5PxzQ4psVgIGnGpIpKt7fpRJ7v5MmafPY0hdotC0AY3lalpp4tDWrCRDj0u3Nj151nl6Vt0+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217709; c=relaxed/simple;
	bh=EnOhTqPvgj9xcSMFrgx/TfuG+Cf6a+W8/5nn1ZEUXOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGcn1rbbzriZsecN0xxNBw10QfC2bX6i7q0tpyvCn6xkNM/x8U+j4nhX1GMk+5LHmTJ5gBGcf+UKBvh1zhpZvn2IA00JiTPDj62LOaLKNjBFdJAUnq8s85sv+1Hv5OajQCt2e6PflvShNpk8i9h4ryj3i9k3ZMcmAI+03rhNsgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TTgTf17BBz9sdL;
	Tue,  6 Feb 2024 12:08:22 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 1/2] Bluetooth: hci_conn: Only do ACL connections sequentially
Date: Tue,  6 Feb 2024 12:08:13 +0100
Message-ID: <20240206110816.74995-2-verdre@v0yd.nl>
In-Reply-To: <20240206110816.74995-1-verdre@v0yd.nl>
References: <20240206110816.74995-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TTgTf17BBz9sdL

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

Note that this causes a test failure in mgmt-tester (test "Pair Device
- Power off 1") because the hci_abort_conn_sync() changes the error we
return on timeout of the "Create Connection". We'll fix this on the
mgmt-tester side by adjusting the expected error for the test.
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_sync.h |  3 ++
 net/bluetooth/hci_conn.c         | 69 ++++---------------------------
 net/bluetooth/hci_sync.c         | 70 ++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 60 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index aa6c69053d..08cb5cb249 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -437,6 +437,7 @@ enum {
 #define HCI_NCMD_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 #define HCI_ACL_TX_TIMEOUT	msecs_to_jiffies(45000)	/* 45 seconds */
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
+#define HCI_ACL_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
 #define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
 #define HCI_LE_AUTOCONN_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index e2582c2425..824660f8f3 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -138,3 +138,6 @@ int hci_le_terminate_big_sync(struct hci_dev *hdev, u8 handle, u8 reason);
 int hci_le_big_terminate_sync(struct hci_dev *hdev, u8 handle);
 
 int hci_le_pa_terminate_sync(struct hci_dev *hdev, u16 handle);
+
+int hci_acl_create_connection_sync(struct hci_dev *hdev,
+				   struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fc4d72f83a..816be7667a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -178,64 +178,6 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 	hci_dev_put(hdev);
 }
 
-static void hci_acl_create_connection(struct hci_conn *conn)
-{
-	struct hci_dev *hdev = conn->hdev;
-	struct inquiry_entry *ie;
-	struct hci_cp_create_conn cp;
-
-	BT_DBG("hcon %p", conn);
-
-	/* Many controllers disallow HCI Create Connection while it is doing
-	 * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
-	 * Connection. This may cause the MGMT discovering state to become false
-	 * without user space's request but it is okay since the MGMT Discovery
-	 * APIs do not promise that discovery should be done forever. Instead,
-	 * the user space monitors the status of MGMT discovering and it may
-	 * request for discovery again when this flag becomes false.
-	 */
-	if (test_bit(HCI_INQUIRY, &hdev->flags)) {
-		/* Put this connection to "pending" state so that it will be
-		 * executed after the inquiry cancel command complete event.
-		 */
-		conn->state = BT_CONNECT2;
-		hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
-		return;
-	}
-
-	conn->state = BT_CONNECT;
-	conn->out = true;
-	conn->role = HCI_ROLE_MASTER;
-
-	conn->attempt++;
-
-	conn->link_policy = hdev->link_policy;
-
-	memset(&cp, 0, sizeof(cp));
-	bacpy(&cp.bdaddr, &conn->dst);
-	cp.pscan_rep_mode = 0x02;
-
-	ie = hci_inquiry_cache_lookup(hdev, &conn->dst);
-	if (ie) {
-		if (inquiry_entry_age(ie) <= INQUIRY_ENTRY_AGE_MAX) {
-			cp.pscan_rep_mode = ie->data.pscan_rep_mode;
-			cp.pscan_mode     = ie->data.pscan_mode;
-			cp.clock_offset   = ie->data.clock_offset |
-					    cpu_to_le16(0x8000);
-		}
-
-		memcpy(conn->dev_class, ie->data.dev_class, 3);
-	}
-
-	cp.pkt_type = cpu_to_le16(conn->pkt_type);
-	if (lmp_rswitch_capable(hdev) && !(hdev->link_mode & HCI_LM_MASTER))
-		cp.role_switch = 0x01;
-	else
-		cp.role_switch = 0x00;
-
-	hci_send_cmd(hdev, HCI_OP_CREATE_CONN, sizeof(cp), &cp);
-}
-
 int hci_disconnect(struct hci_conn *conn, __u8 reason)
 {
 	BT_DBG("hcon %p", conn);
@@ -1696,10 +1638,17 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 
 	acl->conn_reason = conn_reason;
 	if (acl->state == BT_OPEN || acl->state == BT_CLOSED) {
+		int err;
+
 		acl->sec_level = BT_SECURITY_LOW;
 		acl->pending_sec_level = sec_level;
 		acl->auth_type = auth_type;
-		hci_acl_create_connection(acl);
+
+		err = hci_acl_create_connection_sync(hdev, acl);
+		if (err) {
+			hci_conn_del(acl);
+			return ERR_PTR(err);
+		}
 	}
 
 	return acl;
@@ -2654,7 +2603,7 @@ void hci_conn_check_pending(struct hci_dev *hdev)
 
 	conn = hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT2);
 	if (conn)
-		hci_acl_create_connection(conn);
+		hci_acl_create_connection_sync(hdev, conn);
 
 	hci_dev_unlock(hdev);
 }
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 1122296ce3..617407b81f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6492,3 +6492,73 @@ int hci_update_adv_data(struct hci_dev *hdev, u8 instance)
 	return hci_cmd_sync_queue(hdev, _update_adv_data_sync,
 				  UINT_PTR(instance), NULL);
 }
+
+static int __hci_acl_create_connection_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_conn *conn = data;
+	struct inquiry_entry *ie;
+	struct hci_cp_create_conn cp;
+	int err;
+
+	/* Many controllers disallow HCI Create Connection while it is doing
+	 * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
+	 * Connection. This may cause the MGMT discovering state to become false
+	 * without user space's request but it is okay since the MGMT Discovery
+	 * APIs do not promise that discovery should be done forever. Instead,
+	 * the user space monitors the status of MGMT discovering and it may
+	 * request for discovery again when this flag becomes false.
+	 */
+	if (test_bit(HCI_INQUIRY, &hdev->flags)) {
+		err = __hci_cmd_sync_status(hdev, HCI_OP_INQUIRY_CANCEL, 0,
+					    NULL, HCI_CMD_TIMEOUT);
+		if (err)
+			bt_dev_warn(hdev, "Failed to cancel inquiry %d", err);
+	}
+
+	conn->state = BT_CONNECT;
+	conn->out = true;
+	conn->role = HCI_ROLE_MASTER;
+
+	conn->attempt++;
+
+	conn->link_policy = hdev->link_policy;
+
+	memset(&cp, 0, sizeof(cp));
+	bacpy(&cp.bdaddr, &conn->dst);
+	cp.pscan_rep_mode = 0x02;
+
+	ie = hci_inquiry_cache_lookup(hdev, &conn->dst);
+	if (ie) {
+		if (inquiry_entry_age(ie) <= INQUIRY_ENTRY_AGE_MAX) {
+			cp.pscan_rep_mode = ie->data.pscan_rep_mode;
+			cp.pscan_mode     = ie->data.pscan_mode;
+			cp.clock_offset   = ie->data.clock_offset |
+					    cpu_to_le16(0x8000);
+		}
+
+		memcpy(conn->dev_class, ie->data.dev_class, 3);
+	}
+
+	cp.pkt_type = cpu_to_le16(conn->pkt_type);
+	if (lmp_rswitch_capable(hdev) && !(hdev->link_mode & HCI_LM_MASTER))
+		cp.role_switch = 0x01;
+	else
+		cp.role_switch = 0x00;
+
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_CREATE_CONN,
+				       sizeof(cp), &cp,
+				       HCI_EV_CONN_COMPLETE,
+				       HCI_ACL_CONN_TIMEOUT, NULL);
+
+	if (err == -ETIMEDOUT)
+		hci_abort_conn_sync(hdev, conn, HCI_ERROR_LOCAL_HOST_TERM);
+
+	return err;
+}
+
+int hci_acl_create_connection_sync(struct hci_dev *hdev,
+				   struct hci_conn *conn)
+{
+	return hci_cmd_sync_queue(hdev, __hci_acl_create_connection_sync,
+				  conn, NULL);
+}
-- 
2.43.0


