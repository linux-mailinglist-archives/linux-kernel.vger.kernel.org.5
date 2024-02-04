Return-Path: <linux-kernel+bounces-51518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75695848C1D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A12B1C2100E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761E811CBF;
	Sun,  4 Feb 2024 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E9cnJY86"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2594111713;
	Sun,  4 Feb 2024 08:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707035071; cv=none; b=MF0UyPpC5Mrcdas3SynwJw7Imtzvlwzb8F974e4lnEkFg0ylbeEUO/rQVDgGImDguxfvL7tG9lJVyaikv06Zg3YooKDlbQpEnmDx/QGB+hrX9kDywmDXyDtU6gWlnXZZvyHJqWIELRdQ5emclnq6OTami/rtRvGSeieoywHLo4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707035071; c=relaxed/simple;
	bh=5J+cliO+JfXljBtGpCxBP37ieE0cdrIyo1s8/G5n0vM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XjGoY+cJhuJyaJLI+uWmX2Om7MQDFgj+nd/ZPGd5eryitk3tdkMoJWntyIJ2xD5s+2ip5Qhp1qogP6A67qb7f5K6UdQtPqgc0lOK1qSgE+2D2Ah6fBn1aElOSyBzR3k3Cc4RDScEFceWra+i3P/ldLbQKOseVRV/GayKg5Ivivc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E9cnJY86; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6hr8j
	nxuo0qxber3AjHkZ7sw07jBpaZDRkw/V8bFWuU=; b=E9cnJY86fbOiNGulMVQbc
	Cr45HoPhTbyTNDDetFyxr6RWX84azZ7B7y+XcV6HovA47UjkSxcZnqRMVVsVRQVL
	5kkzScCqqQNm8/ra1vT1gEyoD4RrmA3FJXqFmUoIqDnkrBBlcGE2p/lCpwdtBHWY
	fHRWJ4d/C64lo4mPtDoBuA=
Received: from localhost.localdomain (unknown [111.202.47.2])
	by gzga-smtp-mta-g1-1 (Coremail) with SMTP id _____wCHD26ASb9lFOq2Ag--.34886S2;
	Sun, 04 Feb 2024 16:23:29 +0800 (CST)
From: Keqi Wang <wangkeqi_chris@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Keqi Wang <wangkeqi_chris@163.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] connector/cn_proc: cn_netlink_has_listeners replaces proc_event_num_listeners
Date: Sun,  4 Feb 2024 16:22:51 +0800
Message-Id: <20240204082251.5118-1-wangkeqi_chris@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHD26ASb9lFOq2Ag--.34886S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Xry5uF1kur1xur4DJrW3Awb_yoW3Jr1UpF
	Z09r9xtrWDKr17Wwn8A3Wq9rnxZa4kXayUCFWxKwn3Ar1fKr1kJFW8JanxAF1fJ34kKr17
	Za17KFWa9F4DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRqsUNUUUUU=
X-CM-SenderInfo: 5zdqwy5htlsupkul2qqrwthudrp/xtbBzwZ63GV4HslgngAAsb

It is not accurate to reset proc_event_num_listeners according to
cn_netlink_send_mult() return value -ESRCH.

In the case of stress-ng netlink-proc, -ESRCH will always be returned,
because netlink_broadcast_filtered will return -ESRCH,
which may cause stress-ng netlink-proc performance degradation.

proc_event_num_listeners cannot accurately reflect whether
the listener exists, so add cn_netlink_has_listeners() functon
and use that instead of proc_event_num_listeners.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202401112259.b23a1567-oliver.sang@intel.com
Fixes: c46bfba1337d ("connector: Fix proc_event_num_listeners count not cleared")
Signed-off-by: Keqi Wang <wangkeqi_chris@163.com>
---
 drivers/connector/cn_proc.c   | 46 +++++++++++++++++------------------
 drivers/connector/connector.c |  9 +++++++
 include/linux/connector.h     |  2 ++
 3 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 3d5e6d705..5d0339ee7 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -36,7 +36,6 @@ static inline struct cn_msg *buffer_to_cn_msg(__u8 *buffer)
 	return (struct cn_msg *)(buffer + 4);
 }
 
-static atomic_t proc_event_num_listeners = ATOMIC_INIT(0);
 static struct cb_id cn_proc_event_id = { CN_IDX_PROC, CN_VAL_PROC };
 
 /* local_event.count is used as the sequence number of the netlink message */
@@ -85,6 +84,16 @@ static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
 	return 1;
 }
 
+static int cn_netlink_has_listeners(void)
+{
+	struct sock *sk = cn_cdev_nls_get();
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
@@ -108,9 +117,8 @@ static inline void send_msg(struct cn_msg *msg)
 		filter_data[1] = 0;
 	}
 
-	if (cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
-			     cn_filter, (void *)filter_data) == -ESRCH)
-		atomic_set(&proc_event_num_listeners, 0);
+	cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
+			     cn_filter, (void *)filter_data);
 
 	local_unlock(&local_event.lock);
 }
@@ -122,7 +130,7 @@ void proc_fork_connector(struct task_struct *task)
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 	struct task_struct *parent;
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -151,7 +159,7 @@ void proc_exec_connector(struct task_struct *task)
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -176,7 +184,7 @@ void proc_id_connector(struct task_struct *task, int which_id)
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 	const struct cred *cred;
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -213,7 +221,7 @@ void proc_sid_connector(struct task_struct *task)
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -237,7 +245,7 @@ void proc_ptrace_connector(struct task_struct *task, int ptrace_id)
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -269,7 +277,7 @@ void proc_comm_connector(struct task_struct *task)
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -295,7 +303,7 @@ void proc_coredump_connector(struct task_struct *task)
 	struct task_struct *parent;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -328,7 +336,7 @@ void proc_exit_connector(struct task_struct *task)
 	struct task_struct *parent;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -370,7 +378,7 @@ static void cn_proc_ack(int err, int rcvd_seq, int rcvd_ack)
 	struct proc_event *ev;
 	__u8 buffer[CN_PROC_MSG_SIZE] __aligned(8);
 
-	if (atomic_read(&proc_event_num_listeners) < 1)
+	if (!cn_netlink_has_listeners())
 		return;
 
 	msg = buffer_to_cn_msg(buffer);
@@ -396,10 +404,10 @@ static void cn_proc_ack(int err, int rcvd_seq, int rcvd_ack)
 static void cn_proc_mcast_ctl(struct cn_msg *msg,
 			      struct netlink_skb_parms *nsp)
 {
-	enum proc_cn_mcast_op mc_op = 0, prev_mc_op = 0;
+	enum proc_cn_mcast_op mc_op = 0;
 	struct proc_input *pinput = NULL;
 	enum proc_cn_event ev_type = 0;
-	int err = 0, initial = 0;
+	int err = 0;
 	struct sock *sk = NULL;
 
 	/* 
@@ -436,10 +444,6 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 				err = ENOMEM;
 				goto out;
 			}
-			initial = 1;
-		} else {
-			prev_mc_op =
-			((struct proc_input *)(sk->sk_user_data))->mcast_op;
 		}
 		((struct proc_input *)(sk->sk_user_data))->event_type =
 			ev_type;
@@ -448,12 +452,8 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
 
 	switch (mc_op) {
 	case PROC_CN_MCAST_LISTEN:
-		if (initial || (prev_mc_op != PROC_CN_MCAST_LISTEN))
-			atomic_inc(&proc_event_num_listeners);
 		break;
 	case PROC_CN_MCAST_IGNORE:
-		if (!initial && (prev_mc_op != PROC_CN_MCAST_IGNORE))
-			atomic_dec(&proc_event_num_listeners);
 		((struct proc_input *)(sk->sk_user_data))->event_type =
 			PROC_EVENT_NONE;
 		break;
diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index 7f7b94f61..540249d6d 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -129,6 +129,15 @@ int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 __group,
 }
 EXPORT_SYMBOL_GPL(cn_netlink_send);
 
+struct sock *cn_cdev_nls_get(void)
+{
+	if (cn_already_initialized == 1)
+		return cdev.nls;
+	else
+		return NULL;
+}
+EXPORT_SYMBOL_GPL(cn_cdev_nls_get);
+
 /*
  * Callback helper - queues work and setup destructor for given data.
  */
diff --git a/include/linux/connector.h b/include/linux/connector.h
index cec2d99ae..ca4d0cca7 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -127,6 +127,8 @@ int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid,
  */
 int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 group, gfp_t gfp_mask);
 
+struct sock *cn_cdev_nls_get(void);
+
 int cn_queue_add_callback(struct cn_queue_dev *dev, const char *name,
 			  const struct cb_id *id,
 			  void (*callback)(struct cn_msg *, struct netlink_skb_parms *));
-- 
2.27.0


