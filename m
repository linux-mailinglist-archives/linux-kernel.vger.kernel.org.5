Return-Path: <linux-kernel+bounces-115670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB93889D36
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5A01C34FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D4E257637;
	Mon, 25 Mar 2024 02:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaAWktH+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE12209E01;
	Sun, 24 Mar 2024 23:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321577; cv=none; b=lBK8Qcnp+Ic/jVzOahmhVt6weywOAGxF4F6TM/wyylzgHlEQchuJH18NU1Dlq19CKlCgk5fmKyr+LQy1KvvqJ4P143V0LrXB+DS1KWpwuMKPdXMP5qswuy3oguJ9MnXxHhDm+Zx5zt+WyLNs7PSmqvebHNssQgniblkvoqKvWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321577; c=relaxed/simple;
	bh=eJhlv2tetrciK7hb38iISK4mWU499/URLQNPHeN8B7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rs6DWwLFzl0zMnRUyWOdmytbU099FEMLYRy1ji5pvNDMvll3dmYxro3Ot9bf3WEnk+KrMHI45RL5MQ5Q/RzlPhRWsJEwj1v1BlzKsIz/TGV4HWbwGO4B2hrHFrRRGlgaBCIyD7R4uwCYZL96BlW0a9A2FGfESNmVY8MWVoXn4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaAWktH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4339AC43390;
	Sun, 24 Mar 2024 23:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321576;
	bh=eJhlv2tetrciK7hb38iISK4mWU499/URLQNPHeN8B7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gaAWktH+0fw6B7ABoh4dMnd2GgUlqszz4sWAocXqFmdwEHPjVDBdNUA7KdZV7nqxe
	 YTwBUAZBJM6T2QubOs1xkAeFqh+ya5CnvVjHZbzujPyQeWIFOEBwczECuZj6pnEsHc
	 1o2I2fVSj7jYux3p90NGFq9YWPR0qNNQg6Wz+NRsTP0Xzk/RbPdb0JCFkoCmJ8cviF
	 INzwH4oKK4OZpFpREOIytezl9YPkqDUPNLec//LLm3Lw9pvshfjG0cSXPXe4uAevqH
	 YXa3VnZ+cVnTpHN5BRTWKbC0OL8bGQj0VckIRY05rDOLSfNerghuFA4Xvn0pbKgRhh
	 /gv8wCBdqwUVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 305/638] Bluetooth: hci_sync: Fix overwriting request callback
Date: Sun, 24 Mar 2024 18:55:42 -0400
Message-ID: <20240324230116.1348576-306-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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

[ Upstream commit 2615fd9a7c2507eb3be3fbe49dcec88a2f56454a ]

In a few cases the stack may generate commands as responses to events
which would happen to overwrite the sent_cmd, so this attempts to store
the request in req_skb so even if sent_cmd is replaced with a new
command the pending request will remain in stored in req_skb.

Fixes: 6a98e3836fa2 ("Bluetooth: Add helper for serialized HCI command execution")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         |  2 +-
 net/bluetooth/hci_core.c         | 46 ++++++++++++++++++++++----------
 net/bluetooth/hci_event.c        | 18 ++++++-------
 net/bluetooth/hci_sync.c         | 21 ++++++++++++---
 5 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b83cfcf666648..103b290d6efb0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -553,6 +553,7 @@ struct hci_dev {
 	__u32			req_status;
 	__u32			req_result;
 	struct sk_buff		*req_skb;
+	struct sk_buff		*req_rsp;
 
 	void			*smp_data;
 	void			*smp_bredr_data;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6cdd2d2af2d95..1f8c8d65350c8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2936,7 +2936,7 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 		case HCI_EV_LE_CONN_COMPLETE:
 		case HCI_EV_LE_ENHANCED_CONN_COMPLETE:
 		case HCI_EVT_LE_CIS_ESTABLISHED:
-			hci_cmd_sync_cancel(hdev, -ECANCELED);
+			hci_cmd_sync_cancel(hdev, ECANCELED);
 			break;
 		}
 	}
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 539305b9a0e27..96707deef296b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1491,8 +1491,8 @@ static void hci_cmd_timeout(struct work_struct *work)
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    cmd_timer.work);
 
-	if (hdev->sent_cmd) {
-		u16 opcode = hci_skb_opcode(hdev->sent_cmd);
+	if (hdev->req_skb) {
+		u16 opcode = hci_skb_opcode(hdev->req_skb);
 
 		bt_dev_err(hdev, "command 0x%4.4x tx timeout", opcode);
 
@@ -2796,6 +2796,7 @@ void hci_release_dev(struct hci_dev *hdev)
 	ida_destroy(&hdev->unset_handle_ida);
 	ida_simple_remove(&hci_index_ida, hdev->id);
 	kfree_skb(hdev->sent_cmd);
+	kfree_skb(hdev->req_skb);
 	kfree_skb(hdev->recv_event);
 	kfree(hdev);
 }
@@ -3125,21 +3126,33 @@ int __hci_cmd_send(struct hci_dev *hdev, u16 opcode, u32 plen,
 EXPORT_SYMBOL(__hci_cmd_send);
 
 /* Get data from the previously sent command */
-void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
+static void *hci_cmd_data(struct sk_buff *skb, __u16 opcode)
 {
 	struct hci_command_hdr *hdr;
 
-	if (!hdev->sent_cmd)
+	if (!skb || skb->len < HCI_COMMAND_HDR_SIZE)
 		return NULL;
 
-	hdr = (void *) hdev->sent_cmd->data;
+	hdr = (void *)skb->data;
 
 	if (hdr->opcode != cpu_to_le16(opcode))
 		return NULL;
 
-	BT_DBG("%s opcode 0x%4.4x", hdev->name, opcode);
+	return skb->data + HCI_COMMAND_HDR_SIZE;
+}
 
-	return hdev->sent_cmd->data + HCI_COMMAND_HDR_SIZE;
+/* Get data from the previously sent command */
+void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
+{
+	void *data;
+
+	/* Check if opcode matches last sent command */
+	data = hci_cmd_data(hdev->sent_cmd, opcode);
+	if (!data)
+		/* Check if opcode matches last request */
+		data = hci_cmd_data(hdev->req_skb, opcode);
+
+	return data;
 }
 
 /* Get data from last received event */
@@ -4040,17 +4053,19 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
 	if (!status && !hci_req_is_complete(hdev))
 		return;
 
+	skb = hdev->req_skb;
+
 	/* If this was the last command in a request the complete
-	 * callback would be found in hdev->sent_cmd instead of the
+	 * callback would be found in hdev->req_skb instead of the
 	 * command queue (hdev->cmd_q).
 	 */
-	if (bt_cb(hdev->sent_cmd)->hci.req_flags & HCI_REQ_SKB) {
-		*req_complete_skb = bt_cb(hdev->sent_cmd)->hci.req_complete_skb;
+	if (skb && bt_cb(skb)->hci.req_flags & HCI_REQ_SKB) {
+		*req_complete_skb = bt_cb(skb)->hci.req_complete_skb;
 		return;
 	}
 
-	if (bt_cb(hdev->sent_cmd)->hci.req_complete) {
-		*req_complete = bt_cb(hdev->sent_cmd)->hci.req_complete;
+	if (skb && bt_cb(skb)->hci.req_complete) {
+		*req_complete = bt_cb(skb)->hci.req_complete;
 		return;
 	}
 
@@ -4167,8 +4182,11 @@ static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 	}
 
-	if (hci_req_status_pend(hdev))
-		hci_dev_set_flag(hdev, HCI_CMD_PENDING);
+	if (hci_req_status_pend(hdev) &&
+	    !hci_dev_test_and_set_flag(hdev, HCI_CMD_PENDING)) {
+		kfree_skb(hdev->req_skb);
+		hdev->req_skb = skb_clone(skb, GFP_KERNEL);
+	}
 
 	atomic_dec(&hdev->cmd_cnt);
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 2bfc852283394..2bb8ab9302a97 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4381,7 +4381,7 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, void *data,
 	 * (since for this kind of commands there will not be a command
 	 * complete event).
 	 */
-	if (ev->status || (hdev->sent_cmd && !hci_skb_event(hdev->sent_cmd))) {
+	if (ev->status || (hdev->req_skb && !hci_skb_event(hdev->req_skb))) {
 		hci_req_cmd_complete(hdev, *opcode, ev->status, req_complete,
 				     req_complete_skb);
 		if (hci_dev_test_flag(hdev, HCI_CMD_PENDING)) {
@@ -7337,10 +7337,10 @@ static void hci_le_meta_evt(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "subevent 0x%2.2x", ev->subevent);
 
 	/* Only match event if command OGF is for LE */
-	if (hdev->sent_cmd &&
-	    hci_opcode_ogf(hci_skb_opcode(hdev->sent_cmd)) == 0x08 &&
-	    hci_skb_event(hdev->sent_cmd) == ev->subevent) {
-		*opcode = hci_skb_opcode(hdev->sent_cmd);
+	if (hdev->req_skb &&
+	    hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) == 0x08 &&
+	    hci_skb_event(hdev->req_skb) == ev->subevent) {
+		*opcode = hci_skb_opcode(hdev->req_skb);
 		hci_req_cmd_complete(hdev, *opcode, 0x00, req_complete,
 				     req_complete_skb);
 	}
@@ -7727,10 +7727,10 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	/* Only match event if command OGF is not for LE */
-	if (hdev->sent_cmd &&
-	    hci_opcode_ogf(hci_skb_opcode(hdev->sent_cmd)) != 0x08 &&
-	    hci_skb_event(hdev->sent_cmd) == event) {
-		hci_req_cmd_complete(hdev, hci_skb_opcode(hdev->sent_cmd),
+	if (hdev->req_skb &&
+	    hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) != 0x08 &&
+	    hci_skb_event(hdev->req_skb) == event) {
+		hci_req_cmd_complete(hdev, hci_skb_opcode(hdev->req_skb),
 				     status, &req_complete, &req_complete_skb);
 		req_evt = event;
 	}
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 3979c1cccb9fb..7da7f8f2026b0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -32,6 +32,10 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 	hdev->req_result = result;
 	hdev->req_status = HCI_REQ_DONE;
 
+	/* Free the request command so it is not used as response */
+	kfree_skb(hdev->req_skb);
+	hdev->req_skb = NULL;
+
 	if (skb) {
 		struct sock *sk = hci_skb_sk(skb);
 
@@ -39,7 +43,7 @@ static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode,
 		if (sk)
 			sock_put(sk);
 
-		hdev->req_skb = skb_get(skb);
+		hdev->req_rsp = skb_get(skb);
 	}
 
 	wake_up_interruptible(&hdev->req_wait_q);
@@ -187,8 +191,8 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	hdev->req_status = 0;
 	hdev->req_result = 0;
-	skb = hdev->req_skb;
-	hdev->req_skb = NULL;
+	skb = hdev->req_rsp;
+	hdev->req_rsp = NULL;
 
 	bt_dev_dbg(hdev, "end: err %d", err);
 
@@ -4904,6 +4908,11 @@ int hci_dev_open_sync(struct hci_dev *hdev)
 			hdev->sent_cmd = NULL;
 		}
 
+		if (hdev->req_skb) {
+			kfree_skb(hdev->req_skb);
+			hdev->req_skb = NULL;
+		}
+
 		clear_bit(HCI_RUNNING, &hdev->flags);
 		hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
 
@@ -5065,6 +5074,12 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 		hdev->sent_cmd = NULL;
 	}
 
+	/* Drop last request */
+	if (hdev->req_skb) {
+		kfree_skb(hdev->req_skb);
+		hdev->req_skb = NULL;
+	}
+
 	clear_bit(HCI_RUNNING, &hdev->flags);
 	hci_sock_dev_event(hdev, HCI_DEV_CLOSE);
 
-- 
2.43.0


