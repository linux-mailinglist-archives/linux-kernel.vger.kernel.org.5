Return-Path: <linux-kernel+bounces-20162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2D6827AD3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D6DC1F24087
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D68257321;
	Mon,  8 Jan 2024 22:46:36 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C1E56B87;
	Mon,  8 Jan 2024 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4T88LZ21cwz9sQp;
	Mon,  8 Jan 2024 23:46:30 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 4/4] Bluetooth: Remove pending ACL connection attempts
Date: Mon,  8 Jan 2024 23:46:09 +0100
Message-ID: <20240108224614.56900-5-verdre@v0yd.nl>
In-Reply-To: <20240108224614.56900-1-verdre@v0yd.nl>
References: <20240108224614.56900-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4T88LZ21cwz9sQp

With the last commit we moved to using the hci_sync queue for "Create
Connection" requests, removing the need for retrying the paging after
finished/failed "Create Connection" requests and after the end of
inquiries.

hci_conn_check_pending() was used to trigger this retry, we can remove it
now.

Note that we can also remove the special handling for COMMAND_DISALLOWED
errors in the completion handler of "Create Connection", because "Create
Connection" requests are now always serialized.

This is somewhat reverting commit 4c67bc74f016 ("[Bluetooth] Support
concurrent connect requests").

With this, the BT_CONNECT2 state of ACL hci_conn objects should now be
back to meaning only one thing: That we received a "Connection Request"
from another device (see hci_conn_request_evt), but the response to that
is going to be deferred.
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_conn.c         | 16 ----------------
 net/bluetooth/hci_event.c        | 21 ++++-----------------
 3 files changed, 4 insertions(+), 34 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c33348ba1..7a922767d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1429,7 +1429,6 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			      u8 role);
 void hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
-void hci_conn_check_pending(struct hci_dev *hdev);
 
 struct hci_chan *hci_chan_create(struct hci_conn *conn);
 void hci_chan_del(struct hci_chan *chan);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c9a5734fc..123a3f82f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2518,22 +2518,6 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
 	}
 }
 
-/* Check pending connect attempts */
-void hci_conn_check_pending(struct hci_dev *hdev)
-{
-	struct hci_conn *conn;
-
-	BT_DBG("hdev %s", hdev->name);
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT2);
-	if (conn)
-		hci_acl_create_connection_sync(hdev, conn);
-
-	hci_dev_unlock(hdev);
-}
-
 static u32 get_link_mode(struct hci_conn *conn)
 {
 	u32 link_mode = 0;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dcbba1521..5e13b8d54 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -120,8 +120,6 @@ static u8 hci_cc_inquiry_cancel(struct hci_dev *hdev, void *data,
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 	hci_dev_unlock(hdev);
 
-	hci_conn_check_pending(hdev);
-
 	return rp->status;
 }
 
@@ -152,8 +150,6 @@ static u8 hci_cc_exit_periodic_inq(struct hci_dev *hdev, void *data,
 
 	hci_dev_clear_flag(hdev, HCI_PERIODIC_INQ);
 
-	hci_conn_check_pending(hdev);
-
 	return rp->status;
 }
 
@@ -2299,10 +2295,8 @@ static void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	bt_dev_dbg(hdev, "status 0x%2.2x", status);
 
-	if (status) {
-		hci_conn_check_pending(hdev);
+	if (status)
 		return;
-	}
 
 	set_bit(HCI_INQUIRY, &hdev->flags);
 }
@@ -2326,12 +2320,9 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 
 	if (status) {
 		if (conn && conn->state == BT_CONNECT) {
-			if (status != HCI_ERROR_COMMAND_DISALLOWED || conn->attempt > 2) {
-				conn->state = BT_CLOSED;
-				hci_connect_cfm(conn, status);
-				hci_conn_del(conn);
-			} else
-				conn->state = BT_CONNECT2;
+			conn->state = BT_CLOSED;
+			hci_connect_cfm(conn, status);
+			hci_conn_del(conn);
 		}
 	} else {
 		if (!conn) {
@@ -3023,8 +3014,6 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
-	hci_conn_check_pending(hdev);
-
 	if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
 		return;
 
@@ -3246,8 +3235,6 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 unlock:
 	hci_dev_unlock(hdev);
-
-	hci_conn_check_pending(hdev);
 }
 
 static void hci_reject_conn(struct hci_dev *hdev, bdaddr_t *bdaddr)
-- 
2.43.0


