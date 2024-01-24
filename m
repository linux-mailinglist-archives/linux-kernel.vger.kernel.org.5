Return-Path: <linux-kernel+bounces-36904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002F783A875
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5081F20FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB6C1B599;
	Wed, 24 Jan 2024 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Txtcs5P4"
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F8D1AAB9;
	Wed, 24 Jan 2024 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.12.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096794; cv=none; b=R6L+SiYWg5hyZBfg99cs58T5pm4wluxFTB+gelqse5mAQUg5iqDUIS7FrQO0XNhflIFPm840gyVxuvfeaf8XXTNek1bEGp9yZvOQGjLdmVHJubr8rkI6WWHEaKDUimOylnzGkaeikIv7zWVa3dk5x0pxOMUe9DGyjXPBEBhJclU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096794; c=relaxed/simple;
	bh=5oedPBFDyGgrAqNeFwg9kzaY0HTbTyXdfLAZtKr9V48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t655NQOzr+w1BxE0xkP+cAH8c8I+jcNfGl3QF6ifRP3zr5L0wPBiz397JPkCLlVllIygdBzF/JcMFbwY1rA88mz1oK0PPZ0QjNdUs5asExq4x093wUEQa9irsOv0aNdZMYQ/svyAEylwFyJoWPRauAN20SVI60vR6hChGRexYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Txtcs5P4; arc=none smtp.client-ip=220.181.12.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wGebF
	RUnRk8fvrwL6ousNvwVdKBhNLO+VLoC9JTvANM=; b=Txtcs5P4tExeI/mRBpegJ
	NzmSVqft7aSarTNtquPL+Yu07x/N+HDxoyORWR9VC1wcH0zsBAW78vA12eSfk7WC
	coD7PX9T1E+TCccgNBvZENY7abDuSxsve0Qm3vfdg8BUWXJcI+h7/6igjOBrSDV9
	hUgZzkbPKp+NFRTfSH5JVg=
Received: from localhost.localdomain (unknown [111.202.47.2])
	by zwqz-smtp-mta-g5-2 (Coremail) with SMTP id _____wDXX41K+LBlczHnAA--.19015S2;
	Wed, 24 Jan 2024 19:45:14 +0800 (CST)
From: wangkeqi <wangkeqi_chris@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fw@strlen.de,
	wangkeqi <wangkeqiwang@didiglobal.com>,
	kernel test robot <oliver.sang@intel.com>,
	fengwei.yin@intel.com
Subject: [PATCH net v3] connector: cn_netlink_has_listeners replaces proc_event_num_listeners
Date: Wed, 24 Jan 2024 19:44:37 +0800
Message-Id: <20240124114437.160930-1-wangkeqi_chris@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXX41K+LBlczHnAA--.19015S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw4UZFW7Kr1rXF1kGr1rWFg_yoW7tFW8pF
	Z0vr9IyrWDKr17Wwn8A3Wq9r13Za4kXa1UCrWxK3s3Arn5KrykXFW8tanxZr1fJwn5Kr17
	Zw47KFWa9F4DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UDR6cUUUUU=
X-CM-SenderInfo: 5zdqwy5htlsupkul2qqrwthudrp/1tbiQBJv3GVOBNybAQAAsI

From: wangkeqi <wangkeqiwang@didiglobal.com>

It is inaccurate to judge whether proc_event_num_listeners is
cleared by cn_netlink_send_mult returning -ESRCH.
In the case of stress-ng netlink-proc, -ESRCH will always be returned,
because netlink_broadcast_filtered will return -ESRCH,
which may cause stress-ng netlink-proc performance degradation.
If the judgment condition is modified to whether there is a listener.
proc_event_num_listeners will still be wrong due to concurrency.
So replace the counter with cn_netlink_has_listeners

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401112259.b23a1567-oliver.sang@intel.com
Fixes: c46bfba133 ("connector: Fix proc_event_num_listeners count not cleared")
Signed-off-by: wangkeqi <wangkeqiwang@didiglobal.com>
Cc: fengwei.yin@intel.com
Cc: fw@strlen.de
---
 drivers/connector/cn_proc.c   | 33 +++++++++++++++++++++------------
 drivers/connector/connector.c |  9 +++++++++
 include/linux/connector.h     |  1 +
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 3d5e6d705..4898e974c 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -85,6 +85,16 @@ static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
 	return 1;
 }
 
+static int cn_netlink_has_listeners(void)
+{
+	struct sock *sk = get_cdev_nls();
+
+	if (sk)
+		return netlink_has_listeners(sk, CN_IDX_PROC);
+	else
+		return 0;
+}
+
 static inline void send_msg(struct cn_msg *msg)
 {
 	__u32 filter_data[2];
@@ -108,9 +118,8 @@ static inline void send_msg(struct cn_msg *msg)
 		filter_data[1] = 0;
 	}
 
-	if (cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
-			     cn_filter, (void *)filter_data) == -ESRCH)
-		atomic_set(&proc_event_num_listeners, 0);
+	cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
+			     cn_filter, (void *)filter_data);
 
 	local_unlock(&local_event.lock);
 }
@@ -122,7 +131,7 @@ void proc_fork_connector(struct task_struct *task)
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 	struct task_struct *parent;
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -151,7 +160,7 @@ void proc_exec_connector(struct task_struct *task)
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -176,7 +185,7 @@ void proc_id_connector(struct task_struct *task, int which_id)
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 	const struct cred *cred;
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -213,7 +222,7 @@ void proc_sid_connector(struct task_struct *task)
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -237,7 +246,7 @@ void proc_ptrace_connector(struct task_struct *task, int ptrace_id)
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -269,7 +278,7 @@ void proc_comm_connector(struct task_struct *task)
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -295,7 +304,7 @@ void proc_coredump_connector(struct task_struct *task)
 	struct task_struct *parent;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -328,7 +337,7 @@ void proc_exit_connector(struct task_struct *task)
 	struct task_struct *parent;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -370,7 +379,7 @@ static void cn_proc_ack(int err, int rcvd_seq, int rcvd_ack)
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index 7f7b94f61..42bcb39ba 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -129,6 +129,15 @@ int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 __group,
 }
 EXPORT_SYMBOL_GPL(cn_netlink_send);
 
+struct sock *get_cdev_nls(void)
+{
+	if (cn_already_initialized == 1)
+		return cdev.nls;
+	else
+		return NULL;
+}
+EXPORT_SYMBOL_GPL(get_cdev_nls);
+
 /*
  * Callback helper - queues work and setup destructor for given data.
  */
diff --git a/include/linux/connector.h b/include/linux/connector.h
index cec2d99ae..255466aea 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -127,6 +127,7 @@ int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid,
  */
 int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 group, gfp_t gfp_mask);
 
+struct sock *get_cdev_nls(void);
 int cn_queue_add_callback(struct cn_queue_dev *dev, const char *name,
 			  const struct cb_id *id,
 			  void (*callback)(struct cn_msg *, struct netlink_skb_parms *));
-- 
2.27.0


