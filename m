Return-Path: <linux-kernel+bounces-115924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3D98896A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593FA1C3047F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CEE38BD0F;
	Mon, 25 Mar 2024 03:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnKQW8s5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5960227E28;
	Sun, 24 Mar 2024 23:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322125; cv=none; b=KPnFzDqald8hWxAJ7MGl/hXpQChnWmCQv/MV+VF7Ea0LYpeHBjwREsOfGJ6NZR4W0PXs1158q5zBY6Uy/g423Ar+K2D4WNDRbVVB3qgbzAMnxOoKjrPTyhpTaVvJipv+uU2z5EBfVyiO5mXWNOCJY8dtxFssxK45UV2hItkIq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322125; c=relaxed/simple;
	bh=/iltADc8l2zhQeJxuwN2UVfQnCtixoSnnwPZjU5+KiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/SFluf09uyzo2Xba7513oFvmJSVEoUQzaLlovlDJbJT0JEsu0v4QaRDdMevm2DFMn9BOZW4IkTxwO3QU1Tj1sH9qgZY+DJrjnmA59CBuNBHpaEEqaPbHMPcX480sti5ISn/Xnegjzfkc1+Z9ybrn/WW1hOeZoyAEShiM79m1xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnKQW8s5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BC6C43394;
	Sun, 24 Mar 2024 23:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322124;
	bh=/iltADc8l2zhQeJxuwN2UVfQnCtixoSnnwPZjU5+KiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cnKQW8s5fS+rCeIySTkfANrEMOqSs3KVlj5hFCy1H1qxVs/LhpXAOTsyiFm7wngKS
	 iAQFD3PxxsPehtNwfnl9ACGe/eSyhH/rQi78BtUeCN++prRTymJ2Q7dW04zq2HNtjL
	 H0P+AeoKOF2F6NJF/WI5s1Q7eGl1Zl0WSrQVyIS6fltzo34/+ELaq+wDHNWdUif7te
	 mvE00/eLmBhizUf2HiBM5iHp8ht8Fmhwq398zv/YneKk+nMIfNct72kxaD6skvUDVO
	 y0kNUFEotuVgt7jrmDjU5Nzbhf76uftr3JRQQe1OMEtbZG4O0ujs0iKnttbvA4YlyC
	 /+ApwLHz3YjJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 200/451] Bluetooth: hci_conn: Consolidate code for aborting connections
Date: Sun, 24 Mar 2024 19:07:56 -0400
Message-ID: <20240324231207.1351418-201-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit a13f316e90fdb1fb6df6582e845aa9b3270f3581 ]

This consolidates code for aborting connections using
hci_cmd_sync_queue so it is synchronized with other threads, but
because of the fact that some commands may block the cmd_sync_queue
while waiting specific events this attempt to cancel those requests by
using hci_cmd_sync_cancel.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h |   2 +-
 net/bluetooth/hci_conn.c         | 154 ++++++-------------------------
 net/bluetooth/hci_sync.c         |  23 +++--
 net/bluetooth/mgmt.c             |  15 +--
 4 files changed, 47 insertions(+), 147 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 09c978f3d95dc..2538f3b96623b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -739,6 +739,7 @@ struct hci_conn {
 	unsigned long	flags;
 
 	enum conn_reasons conn_reason;
+	__u8		abort_reason;
 
 	__u32		clock;
 	__u16		clock_accuracy;
@@ -758,7 +759,6 @@ struct hci_conn {
 	struct delayed_work auto_accept_work;
 	struct delayed_work idle_work;
 	struct delayed_work le_conn_timeout;
-	struct work_struct  le_scan_cleanup;
 
 	struct device	dev;
 	struct dentry	*debugfs;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 12d36875358b9..f752a9f9bb9c7 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -175,57 +175,6 @@ static void hci_conn_cleanup(struct hci_conn *conn)
 	hci_dev_put(hdev);
 }
 
-static void le_scan_cleanup(struct work_struct *work)
-{
-	struct hci_conn *conn = container_of(work, struct hci_conn,
-					     le_scan_cleanup);
-	struct hci_dev *hdev = conn->hdev;
-	struct hci_conn *c = NULL;
-
-	BT_DBG("%s hcon %p", hdev->name, conn);
-
-	hci_dev_lock(hdev);
-
-	/* Check that the hci_conn is still around */
-	rcu_read_lock();
-	list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
-		if (c == conn)
-			break;
-	}
-	rcu_read_unlock();
-
-	if (c == conn) {
-		hci_connect_le_scan_cleanup(conn, 0x00);
-		hci_conn_cleanup(conn);
-	}
-
-	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-	hci_conn_put(conn);
-}
-
-static void hci_connect_le_scan_remove(struct hci_conn *conn)
-{
-	BT_DBG("%s hcon %p", conn->hdev->name, conn);
-
-	/* We can't call hci_conn_del/hci_conn_cleanup here since that
-	 * could deadlock with another hci_conn_del() call that's holding
-	 * hci_dev_lock and doing cancel_delayed_work_sync(&conn->disc_work).
-	 * Instead, grab temporary extra references to the hci_dev and
-	 * hci_conn and perform the necessary cleanup in a separate work
-	 * callback.
-	 */
-
-	hci_dev_hold(conn->hdev);
-	hci_conn_get(conn);
-
-	/* Even though we hold a reference to the hdev, many other
-	 * things might get cleaned up meanwhile, including the hdev's
-	 * own workqueue, so we can't use that for scheduling.
-	 */
-	schedule_work(&conn->le_scan_cleanup);
-}
-
 static void hci_acl_create_connection(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -672,13 +621,6 @@ static void hci_conn_timeout(struct work_struct *work)
 	if (refcnt > 0)
 		return;
 
-	/* LE connections in scanning state need special handling */
-	if (conn->state == BT_CONNECT && conn->type == LE_LINK &&
-	    test_bit(HCI_CONN_SCANNING, &conn->flags)) {
-		hci_connect_le_scan_remove(conn);
-		return;
-	}
-
 	hci_abort_conn(conn, hci_proto_disconn_ind(conn));
 }
 
@@ -1050,7 +992,6 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
 	INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
 	INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
-	INIT_WORK(&conn->le_scan_cleanup, le_scan_cleanup);
 
 	atomic_set(&conn->refcnt, 0);
 
@@ -2837,81 +2778,46 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 	return phys;
 }
 
-int hci_abort_conn(struct hci_conn *conn, u8 reason)
+static int abort_conn_sync(struct hci_dev *hdev, void *data)
 {
-	int r = 0;
+	struct hci_conn *conn;
+	u16 handle = PTR_ERR(data);
 
-	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!conn)
 		return 0;
 
-	switch (conn->state) {
-	case BT_CONNECTED:
-	case BT_CONFIG:
-		if (conn->type == AMP_LINK) {
-			struct hci_cp_disconn_phy_link cp;
+	return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
+}
 
-			cp.phy_handle = HCI_PHY_HANDLE(conn->handle);
-			cp.reason = reason;
-			r = hci_send_cmd(conn->hdev, HCI_OP_DISCONN_PHY_LINK,
-					 sizeof(cp), &cp);
-		} else {
-			struct hci_cp_disconnect dc;
+int hci_abort_conn(struct hci_conn *conn, u8 reason)
+{
+	struct hci_dev *hdev = conn->hdev;
 
-			dc.handle = cpu_to_le16(conn->handle);
-			dc.reason = reason;
-			r = hci_send_cmd(conn->hdev, HCI_OP_DISCONNECT,
-					 sizeof(dc), &dc);
-		}
+	/* If abort_reason has already been set it means the connection is
+	 * already being aborted so don't attempt to overwrite it.
+	 */
+	if (conn->abort_reason)
+		return 0;
 
-		conn->state = BT_DISCONN;
+	bt_dev_dbg(hdev, "handle 0x%2.2x reason 0x%2.2x", conn->handle, reason);
 
-		break;
-	case BT_CONNECT:
-		if (conn->type == LE_LINK) {
-			if (test_bit(HCI_CONN_SCANNING, &conn->flags))
-				break;
-			r = hci_send_cmd(conn->hdev,
-					 HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);
-		} else if (conn->type == ACL_LINK) {
-			if (conn->hdev->hci_ver < BLUETOOTH_VER_1_2)
-				break;
-			r = hci_send_cmd(conn->hdev,
-					 HCI_OP_CREATE_CONN_CANCEL,
-					 6, &conn->dst);
-		}
-		break;
-	case BT_CONNECT2:
-		if (conn->type == ACL_LINK) {
-			struct hci_cp_reject_conn_req rej;
-
-			bacpy(&rej.bdaddr, &conn->dst);
-			rej.reason = reason;
-
-			r = hci_send_cmd(conn->hdev,
-					 HCI_OP_REJECT_CONN_REQ,
-					 sizeof(rej), &rej);
-		} else if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
-			struct hci_cp_reject_sync_conn_req rej;
-
-			bacpy(&rej.bdaddr, &conn->dst);
-
-			/* SCO rejection has its own limited set of
-			 * allowed error values (0x0D-0x0F) which isn't
-			 * compatible with most values passed to this
-			 * function. To be safe hard-code one of the
-			 * values that's suitable for SCO.
-			 */
-			rej.reason = HCI_ERROR_REJ_LIMITED_RESOURCES;
+	conn->abort_reason = reason;
 
-			r = hci_send_cmd(conn->hdev,
-					 HCI_OP_REJECT_SYNC_CONN_REQ,
-					 sizeof(rej), &rej);
+	/* If the connection is pending check the command opcode since that
+	 * might be blocking on hci_cmd_sync_work while waiting its respective
+	 * event so we need to hci_cmd_sync_cancel to cancel it.
+	 */
+	if (conn->state == BT_CONNECT && hdev->req_status == HCI_REQ_PEND) {
+		switch (hci_skb_event(hdev->sent_cmd)) {
+		case HCI_EV_LE_CONN_COMPLETE:
+		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
+		case HCI_EVT_LE_CIS_ESTABLISHED:
+			hci_cmd_sync_cancel(hdev, -ECANCELED);
+			break;
 		}
-		break;
-	default:
-		conn->state = BT_CLOSED;
-		break;
 	}
 
-	return r;
+	return hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->handle),
+				  NULL);
 }
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 31dd064d77a42..c03729c10fdd6 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5230,22 +5230,27 @@ static int hci_disconnect_sync(struct hci_dev *hdev, struct hci_conn *conn,
 }
 
 static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
-				      struct hci_conn *conn)
+				      struct hci_conn *conn, u8 reason)
 {
+	/* Return reason if scanning since the connection shall probably be
+	 * cleanup directly.
+	 */
 	if (test_bit(HCI_CONN_SCANNING, &conn->flags))
-		return 0;
+		return reason;
 
-	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
+	if (conn->role == HCI_ROLE_SLAVE ||
+	    test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
 		return 0;
 
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_CONN_CANCEL,
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
 
-static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn)
+static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
+				   u8 reason)
 {
 	if (conn->type == LE_LINK)
-		return hci_le_connect_cancel_sync(hdev, conn);
+		return hci_le_connect_cancel_sync(hdev, conn, reason);
 
 	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
 		return 0;
@@ -5298,9 +5303,11 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	case BT_CONFIG:
 		return hci_disconnect_sync(hdev, conn, reason);
 	case BT_CONNECT:
-		err = hci_connect_cancel_sync(hdev, conn);
+		err = hci_connect_cancel_sync(hdev, conn, reason);
 		/* Cleanup hci_conn object if it cannot be cancelled as it
-		 * likelly means the controller and host stack are out of sync.
+		 * likelly means the controller and host stack are out of sync
+		 * or in case of LE it was still scanning so it can be cleanup
+		 * safely.
 		 */
 		if (err) {
 			hci_dev_lock(hdev);
@@ -6215,7 +6222,7 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 
 done:
 	if (err == -ETIMEDOUT)
-		hci_le_connect_cancel_sync(hdev, conn);
+		hci_le_connect_cancel_sync(hdev, conn, 0x00);
 
 	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 732b6cf45fbe4..fbd859e2d13ca 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3583,18 +3583,6 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
-static int abort_conn_sync(struct hci_dev *hdev, void *data)
-{
-	struct hci_conn *conn;
-	u16 handle = PTR_ERR(data);
-
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
-		return 0;
-
-	return hci_abort_conn_sync(hdev, conn, HCI_ERROR_REMOTE_USER_TERM);
-}
-
 static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 			      u16 len)
 {
@@ -3645,8 +3633,7 @@ static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 					      le_addr_type(addr->type));
 
 	if (conn->conn_reason == CONN_REASON_PAIR_DEVICE)
-		hci_cmd_sync_queue(hdev, abort_conn_sync, ERR_PTR(conn->handle),
-				   NULL);
+		hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.43.0


