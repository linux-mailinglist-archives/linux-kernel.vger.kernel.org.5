Return-Path: <linux-kernel+bounces-114504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAF2888B78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB193B28BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF8D181310;
	Sun, 24 Mar 2024 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBfWQ287"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5240149005;
	Sun, 24 Mar 2024 23:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322126; cv=none; b=ez096SgB5xzHQKqcgbjxh+buhKxc6OBYWl6q/+1dSjTFQwZIiSac03Tu0UPFT1QRIsqDesfDWZVbmwaCRYzDwKuana02QcSGi0d6QjOM4rZAqMnBH3x1sUMqmty3YgNjIWMJO8jy7zSseeoIW1IT4dObKLJAqm0TEJtuMVwA/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322126; c=relaxed/simple;
	bh=7Y6wW8VR7Mkl+Z6V+Slt9WktYEGYcO4hLKmJOEdjeZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmD7puWRxsLXoB1mGKabHGzQ2CyrURaSFvuWFi6YDtGJoKJY/Sj/jFUcoFbWXrxfT2wvJvu4FkhTXAXASVOvbuAmJGuPWDLONBPwc0yuyKZoc8BngPLeFWgy/Wccyix7P+1P7ADXGHSbexDgMuXsGs41/KXwHc1/dcnvZJci9Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBfWQ287; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188B8C433F1;
	Sun, 24 Mar 2024 23:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322125;
	bh=7Y6wW8VR7Mkl+Z6V+Slt9WktYEGYcO4hLKmJOEdjeZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dBfWQ287mF4JBIZdbh6UZUii2IoPQnUnoUn9daQ3x2tbg6AAVCSWu/NRaYSLNcEk8
	 yQxP2+FQhvHYufRQdao2atntlcBmmsHG5l4xciY0VwFLOVEeRxPGYQv1oBWiVPUYCN
	 kFv2OYsmonzSlQxpHrfExiuQRemu5x11dsXnm/TcJ1JDobva6WKszK4UqAkmfml/Dk
	 hBoQo9bz0ATMpk4g4EMtAbAHZFzhtKq5uQEkrWTkRnGtaQBXYpDBVjzleOlyV2qQLI
	 RfLyIc2H47y6B77v1PUmcX8SE9K2XNUYm1+20i1TZY95MAZMYbrzXBNfy4JDrKib3i
	 zXugJa4sp9BgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 201/451] Bluetooth: hci_core: Cancel request on command timeout
Date: Sun, 24 Mar 2024 19:07:57 -0400
Message-ID: <20240324231207.1351418-202-sashal@kernel.org>
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

[ Upstream commit 63298d6e752fc0ec7f5093860af8bc9f047b30c8 ]

If command has timed out call __hci_cmd_sync_cancel to notify the
hci_req since it will inevitably cause a timeout.

This also rework the code around __hci_cmd_sync_cancel since it was
wrongly assuming it needs to cancel timer as well, but sometimes the
timers have not been started or in fact they already had timed out in
which case they don't need to be cancel yet again.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Stable-dep-of: 2615fd9a7c25 ("Bluetooth: hci_sync: Fix overwriting request callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci_sync.h |  2 +-
 net/bluetooth/hci_core.c         | 86 +++++++++++++++++++++-----------
 net/bluetooth/hci_request.c      |  2 +-
 net/bluetooth/hci_sync.c         | 20 ++++----
 net/bluetooth/mgmt.c             |  2 +-
 5 files changed, 72 insertions(+), 40 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 2fa976c466b80..59d15b1a978ab 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -39,7 +39,7 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev, u16 opcode, u32 plen,
 void hci_cmd_sync_init(struct hci_dev *hdev);
 void hci_cmd_sync_clear(struct hci_dev *hdev);
 void hci_cmd_sync_cancel(struct hci_dev *hdev, int err);
-void __hci_cmd_sync_cancel(struct hci_dev *hdev, int err);
+void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err);
 
 int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			void *data, hci_cmd_sync_work_destroy_t destroy);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a7e6ce2e61c5e..edf7af2e13557 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1492,10 +1492,11 @@ static void hci_cmd_timeout(struct work_struct *work)
 					    cmd_timer.work);
 
 	if (hdev->sent_cmd) {
-		struct hci_command_hdr *sent = (void *) hdev->sent_cmd->data;
-		u16 opcode = __le16_to_cpu(sent->opcode);
+		u16 opcode = hci_skb_opcode(hdev->sent_cmd);
 
 		bt_dev_err(hdev, "command 0x%4.4x tx timeout", opcode);
+
+		hci_cmd_sync_cancel_sync(hdev, ETIMEDOUT);
 	} else {
 		bt_dev_err(hdev, "command tx timeout");
 	}
@@ -2822,6 +2823,23 @@ int hci_unregister_suspend_notifier(struct hci_dev *hdev)
 	return ret;
 }
 
+/* Cancel ongoing command synchronously:
+ *
+ * - Cancel command timer
+ * - Reset command counter
+ * - Cancel command request
+ */
+static void hci_cancel_cmd_sync(struct hci_dev *hdev, int err)
+{
+	bt_dev_dbg(hdev, "err 0x%2.2x", err);
+
+	cancel_delayed_work_sync(&hdev->cmd_timer);
+	cancel_delayed_work_sync(&hdev->ncmd_timer);
+	atomic_set(&hdev->cmd_cnt, 1);
+
+	hci_cmd_sync_cancel_sync(hdev, -err);
+}
+
 /* Suspend HCI device */
 int hci_suspend_dev(struct hci_dev *hdev)
 {
@@ -2839,7 +2857,7 @@ int hci_suspend_dev(struct hci_dev *hdev)
 		return 0;
 
 	/* Cancel potentially blocking sync operation before suspend */
-	__hci_cmd_sync_cancel(hdev, -EHOSTDOWN);
+	hci_cancel_cmd_sync(hdev, -EHOSTDOWN);
 
 	hci_req_sync_lock(hdev);
 	ret = hci_suspend_sync(hdev);
@@ -4119,6 +4137,33 @@ static void hci_rx_work(struct work_struct *work)
 	}
 }
 
+static void hci_send_cmd_sync(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	int err;
+
+	bt_dev_dbg(hdev, "skb %p", skb);
+
+	kfree_skb(hdev->sent_cmd);
+
+	hdev->sent_cmd = skb_clone(skb, GFP_KERNEL);
+	if (!hdev->sent_cmd) {
+		skb_queue_head(&hdev->cmd_q, skb);
+		queue_work(hdev->workqueue, &hdev->cmd_work);
+		return;
+	}
+
+	err = hci_send_frame(hdev, skb);
+	if (err < 0) {
+		hci_cmd_sync_cancel_sync(hdev, err);
+		return;
+	}
+
+	if (hci_req_status_pend(hdev))
+		hci_dev_set_flag(hdev, HCI_CMD_PENDING);
+
+	atomic_dec(&hdev->cmd_cnt);
+}
+
 static void hci_cmd_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev, cmd_work);
@@ -4133,30 +4178,15 @@ static void hci_cmd_work(struct work_struct *work)
 		if (!skb)
 			return;
 
-		kfree_skb(hdev->sent_cmd);
-
-		hdev->sent_cmd = skb_clone(skb, GFP_KERNEL);
-		if (hdev->sent_cmd) {
-			int res;
-			if (hci_req_status_pend(hdev))
-				hci_dev_set_flag(hdev, HCI_CMD_PENDING);
-			atomic_dec(&hdev->cmd_cnt);
-
-			res = hci_send_frame(hdev, skb);
-			if (res < 0)
-				__hci_cmd_sync_cancel(hdev, -res);
-
-			rcu_read_lock();
-			if (test_bit(HCI_RESET, &hdev->flags) ||
-			    hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
-				cancel_delayed_work(&hdev->cmd_timer);
-			else
-				queue_delayed_work(hdev->workqueue, &hdev->cmd_timer,
-						   HCI_CMD_TIMEOUT);
-			rcu_read_unlock();
-		} else {
-			skb_queue_head(&hdev->cmd_q, skb);
-			queue_work(hdev->workqueue, &hdev->cmd_work);
-		}
+		hci_send_cmd_sync(hdev, skb);
+
+		rcu_read_lock();
+		if (test_bit(HCI_RESET, &hdev->flags) ||
+		    hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
+			cancel_delayed_work(&hdev->cmd_timer);
+		else
+			queue_delayed_work(hdev->workqueue, &hdev->cmd_timer,
+					   HCI_CMD_TIMEOUT);
+		rcu_read_unlock();
 	}
 }
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index f7e006a363829..4468647df6722 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -916,7 +916,7 @@ void hci_request_setup(struct hci_dev *hdev)
 
 void hci_request_cancel_all(struct hci_dev *hdev)
 {
-	__hci_cmd_sync_cancel(hdev, ENODEV);
+	hci_cmd_sync_cancel_sync(hdev, ENODEV);
 
 	cancel_interleave_scan(hdev);
 }
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index c03729c10fdd6..d0029f10d9023 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -651,7 +651,7 @@ void hci_cmd_sync_clear(struct hci_dev *hdev)
 	mutex_unlock(&hdev->cmd_sync_work_lock);
 }
 
-void __hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
+void hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
 {
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
@@ -659,15 +659,17 @@ void __hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
 		hdev->req_result = err;
 		hdev->req_status = HCI_REQ_CANCELED;
 
-		cancel_delayed_work_sync(&hdev->cmd_timer);
-		cancel_delayed_work_sync(&hdev->ncmd_timer);
-		atomic_set(&hdev->cmd_cnt, 1);
-
-		wake_up_interruptible(&hdev->req_wait_q);
+		queue_work(hdev->workqueue, &hdev->cmd_sync_cancel_work);
 	}
 }
+EXPORT_SYMBOL(hci_cmd_sync_cancel);
 
-void hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
+/* Cancel ongoing command request synchronously:
+ *
+ * - Set result and mark status to HCI_REQ_CANCELED
+ * - Wakeup command sync thread
+ */
+void hci_cmd_sync_cancel_sync(struct hci_dev *hdev, int err)
 {
 	bt_dev_dbg(hdev, "err 0x%2.2x", err);
 
@@ -675,10 +677,10 @@ void hci_cmd_sync_cancel(struct hci_dev *hdev, int err)
 		hdev->req_result = err;
 		hdev->req_status = HCI_REQ_CANCELED;
 
-		queue_work(hdev->workqueue, &hdev->cmd_sync_cancel_work);
+		wake_up_interruptible(&hdev->req_wait_q);
 	}
 }
-EXPORT_SYMBOL(hci_cmd_sync_cancel);
+EXPORT_SYMBOL(hci_cmd_sync_cancel_sync);
 
 /* Submit HCI command to be run in as cmd_sync_work:
  *
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fbd859e2d13ca..4a35535f56607 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1403,7 +1403,7 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	/* Cancel potentially blocking sync operation before power off */
 	if (cp->val == 0x00) {
-		__hci_cmd_sync_cancel(hdev, -EHOSTDOWN);
+		hci_cmd_sync_cancel_sync(hdev, -EHOSTDOWN);
 		err = hci_cmd_sync_queue(hdev, set_powered_sync, cmd,
 					 mgmt_set_powered_complete);
 	} else {
-- 
2.43.0


