Return-Path: <linux-kernel+bounces-122979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA78589009F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18CD91F25F92
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD4C823C8;
	Thu, 28 Mar 2024 13:41:14 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8A823B7;
	Thu, 28 Mar 2024 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633272; cv=none; b=uZJaac1DXD+3J3xcGr81zC/p5rpspCgTUnHMT3NM0VFO5gXluh8febN0OXJjQg0mCix8PJmiYUwN5o8nHfRbdj4rq698pnEKUdfo36baBu2Q0T4Pa6Afk5XrESXmY0oaht5Gd1Gd2p2srls2jjh0K+k4IagzerfPMM6Qy9FpPtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633272; c=relaxed/simple;
	bh=G1s28Ul5IpWN4uFA7dMKP+hw7F2xOgJDOxMyjAlfcgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnRkY0lSReE1A9i4mJ6jJqD28eHT698Ww57ssmbiwz+qKQBUMShltRWbc9bgluzjrRTATqj7uLNCF/HTHhrTjpnSpcfs9f3OQ8Q9N2zeTuoIpircNldwPoYHxEEB62WP9EFD5RrQr1+n1JVZ83NhN4EWCxTFDJL88y2tG+5y134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V54PG2BpJz29lRD;
	Thu, 28 Mar 2024 21:38:26 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id CE73C1A016F;
	Thu, 28 Mar 2024 21:41:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 21:41:06 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, Eric Dumazet <edumazet@google.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>, David Ahern <dsahern@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, Boris Pismenny <borisp@nvidia.com>,
	<bpf@vger.kernel.org>, <mptcp@lists.linux.dev>
Subject: [PATCH RFC 10/10] net: replace page_frag with page_frag_cache
Date: Thu, 28 Mar 2024 21:38:39 +0800
Message-ID: <20240328133839.13620-11-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240328133839.13620-1-linyunsheng@huawei.com>
References: <20240328133839.13620-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)

Use the newly introduced prepare/commit API to replace
page_frag with page_frag_cache for sk_page_frag().

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 drivers/net/tun.c     |  36 ++++++-----
 include/linux/sched.h |   5 +-
 include/net/sock.h    |   7 ++-
 kernel/exit.c         |   3 +-
 kernel/fork.c         |   2 +-
 net/core/skbuff.c     |  29 +++++----
 net/core/skmsg.c      |  24 +++++---
 net/core/sock.c       |  24 ++++----
 net/ipv4/ip_output.c  |  37 ++++++-----
 net/ipv4/tcp.c        |  33 +++++-----
 net/ipv4/tcp_output.c |  30 +++++----
 net/ipv6/ip6_output.c |  37 ++++++-----
 net/kcm/kcmsock.c     |  28 ++++-----
 net/mptcp/protocol.c  |  72 ++++++++++++++--------
 net/tls/tls_device.c  | 139 ++++++++++++++++++++++++------------------
 15 files changed, 290 insertions(+), 216 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 0b3f21cba552..a1c9b51e146b 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1598,10 +1598,11 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
 }
 
 static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
-				       struct page_frag *alloc_frag, char *buf,
+				       struct page_frag_cache *alloc_frag,
+				       char *buf, unsigned int offset,
 				       int buflen, int len, int pad)
 {
-	struct sk_buff *skb = build_skb(buf, buflen);
+	struct sk_buff *skb = build_skb(buf + offset, buflen);
 
 	if (!skb)
 		return ERR_PTR(-ENOMEM);
@@ -1609,9 +1610,7 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
 	skb_reserve(skb, pad);
 	skb_put(skb, len);
 	skb_set_owner_w(skb, tfile->socket.sk);
-
-	get_page(alloc_frag->page);
-	alloc_frag->offset += buflen;
+	page_frag_alloc_commit(alloc_frag, offset, buflen);
 
 	return skb;
 }
@@ -1660,9 +1659,10 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 				     struct virtio_net_hdr *hdr,
 				     int len, int *skb_xdp)
 {
-	struct page_frag *alloc_frag = &current->task_frag;
+	struct page_frag_cache *alloc_frag = &current->task_frag;
 	struct bpf_prog *xdp_prog;
 	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	unsigned int offset, size;
 	char *buf;
 	size_t copied;
 	int pad = TUN_RX_PAD;
@@ -1675,14 +1675,13 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	buflen += SKB_DATA_ALIGN(len + pad);
 	rcu_read_unlock();
 
-	alloc_frag->offset = ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
-	if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL)))
+	size = buflen;
+	buf = page_frag_alloc_prepare_align(alloc_frag, &offset, &size,
+					    SMP_CACHE_BYTES, GFP_KERNEL);
+	if (unlikely(!buf))
 		return ERR_PTR(-ENOMEM);
 
-	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
-	copied = copy_page_from_iter(alloc_frag->page,
-				     alloc_frag->offset + pad,
-				     len, from);
+	copied = copy_from_iter(buf + offset + pad, len, from);
 	if (copied != len)
 		return ERR_PTR(-EFAULT);
 
@@ -1692,8 +1691,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	 */
 	if (hdr->gso_type || !xdp_prog) {
 		*skb_xdp = 1;
-		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
-				       pad);
+		return __tun_build_skb(tfile, alloc_frag, buf, offset, buflen,
+				       len, pad);
 	}
 
 	*skb_xdp = 0;
@@ -1710,13 +1709,12 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		if (act == XDP_REDIRECT || act == XDP_TX) {
-			get_page(alloc_frag->page);
-			alloc_frag->offset += buflen;
+			page_frag_alloc_commit(alloc_frag, offset, buflen);
 		}
 		err = tun_xdp_act(tun, xdp_prog, &xdp, act);
 		if (err < 0) {
 			if (act == XDP_REDIRECT || act == XDP_TX)
-				put_page(alloc_frag->page);
+				page_frag_free_va(buf);
 			goto out;
 		}
 
@@ -1731,8 +1729,8 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 	rcu_read_unlock();
 	local_bh_enable();
 
-	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad);
-
+	return __tun_build_skb(tfile, alloc_frag, buf, offset, buflen, len,
+			       pad);
 out:
 	rcu_read_unlock();
 	local_bh_enable();
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b4..436642be0867 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -35,7 +35,7 @@
 #include <linux/sched/types.h>
 #include <linux/signal_types.h>
 #include <linux/syscall_user_dispatch_types.h>
-#include <linux/mm_types_task.h>
+#include <linux/mm_types.h>
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers_types.h>
 #include <linux/restart_block.h>
@@ -45,6 +45,7 @@
 #include <linux/rv.h>
 #include <linux/livepatch_sched.h>
 #include <linux/uidgid_types.h>
+#include <linux/page_frag_cache.h>
 #include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
@@ -1338,7 +1339,7 @@ struct task_struct {
 	/* Cache last used pipe for splice(): */
 	struct pipe_inode_info		*splice_pipe;
 
-	struct page_frag		task_frag;
+	struct page_frag_cache		task_frag;
 
 #ifdef CONFIG_TASK_DELAY_ACCT
 	struct task_delay_info		*delays;
diff --git a/include/net/sock.h b/include/net/sock.h
index 20df93699b60..9d8fb8df1ce9 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -461,7 +461,7 @@ struct sock {
 	struct sk_buff_head	sk_write_queue;
 	u32			sk_dst_pending_confirm;
 	u32			sk_pacing_status; /* see enum sk_pacing */
-	struct page_frag	sk_frag;
+	struct page_frag_cache	sk_frag;
 	struct timer_list	sk_timer;
 
 	unsigned long		sk_pacing_rate; /* bytes per second */
@@ -2560,7 +2560,7 @@ static inline void sk_stream_moderate_sndbuf(struct sock *sk)
  * Return: a per task page_frag if context allows that,
  * otherwise a per socket one.
  */
-static inline struct page_frag *sk_page_frag(struct sock *sk)
+static inline struct page_frag_cache *sk_page_frag(struct sock *sk)
 {
 	if (sk->sk_use_task_frag)
 		return &current->task_frag;
@@ -2568,7 +2568,8 @@ static inline struct page_frag *sk_page_frag(struct sock *sk)
 	return &sk->sk_frag;
 }
 
-bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag);
+void *sk_page_frag_alloc_prepare(struct sock *sk, struct page_frag_cache *pfrag,
+				 unsigned int *size, unsigned int *offset);
 
 /*
  *	Default write policy as shown to user space via poll/select/SIGIO
diff --git a/kernel/exit.c b/kernel/exit.c
index 41a12630cbbc..8203275fd5ff 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -913,8 +913,7 @@ void __noreturn do_exit(long code)
 	if (tsk->splice_pipe)
 		free_pipe_info(tsk->splice_pipe);
 
-	if (tsk->task_frag.page)
-		put_page(tsk->task_frag.page);
+	page_frag_cache_drain(&tsk->task_frag);
 
 	exit_task_stack_account(tsk);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 39a5046c2f0b..8e5abc30c47a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1158,10 +1158,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->btrace_seq = 0;
 #endif
 	tsk->splice_pipe = NULL;
-	tsk->task_frag.page = NULL;
 	tsk->wake_q.next = NULL;
 	tsk->worker_private = NULL;
 
+	page_frag_cache_init(&tsk->task_frag);
 	kcov_task_init(tsk);
 	kmsan_task_create(tsk);
 	kmap_local_fork(tsk);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e6bc0dec7463..88da8c52a121 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3017,23 +3017,24 @@ static void sock_spd_release(struct splice_pipe_desc *spd, unsigned int i)
 	put_page(spd->pages[i]);
 }
 
-static struct page *linear_to_page(struct page *page, unsigned int *len,
-				   unsigned int *offset,
-				   struct sock *sk)
+static struct page *linear_to_page(struct page_frag_cache *pfrag,
+				   struct page *page, unsigned int *offset,
+				   unsigned int *len, struct sock *sk)
 {
-	struct page_frag *pfrag = sk_page_frag(sk);
+	unsigned int new_len, new_offset;
+	void *va;
 
-	if (!sk_page_frag_refill(sk, pfrag))
+	va = sk_page_frag_alloc_prepare(sk, pfrag, &new_offset, &new_len);
+	if (!va)
 		return NULL;
 
-	*len = min_t(unsigned int, *len, pfrag->size - pfrag->offset);
+	*len = min_t(unsigned int, *len, new_len);
 
-	memcpy(page_address(pfrag->page) + pfrag->offset,
+	memcpy(va + new_offset,
 	       page_address(page) + *offset, *len);
-	*offset = pfrag->offset;
-	pfrag->offset += *len;
+	*offset = new_offset;
 
-	return pfrag->page;
+	return virt_to_page(va);
 }
 
 static bool spd_can_coalesce(const struct splice_pipe_desc *spd,
@@ -3055,19 +3056,23 @@ static bool spd_fill_page(struct splice_pipe_desc *spd,
 			  bool linear,
 			  struct sock *sk)
 {
+	struct page_frag_cache *pfrag = sk_page_frag(sk);
+
 	if (unlikely(spd->nr_pages == MAX_SKB_FRAGS))
 		return true;
 
 	if (linear) {
-		page = linear_to_page(page, len, &offset, sk);
+		page = linear_to_page(pfrag, page, &offset, len,  sk);
 		if (!page)
 			return true;
 	}
 	if (spd_can_coalesce(spd, page, offset)) {
 		spd->partial[spd->nr_pages - 1].len += *len;
+		page_frag_alloc_commit_noref(pfrag, offset, *len);
 		return false;
 	}
-	get_page(page);
+
+	page_frag_alloc_commit(pfrag, offset, *len);
 	spd->pages[spd->nr_pages] = page;
 	spd->partial[spd->nr_pages].len = *len;
 	spd->partial[spd->nr_pages].offset = offset;
diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 4d75ef9d24bf..b843083bdd4e 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -27,23 +27,26 @@ static bool sk_msg_try_coalesce_ok(struct sk_msg *msg, int elem_first_coalesce)
 int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
 		 int elem_first_coalesce)
 {
-	struct page_frag *pfrag = sk_page_frag(sk);
+	struct page_frag_cache *pfrag = sk_page_frag(sk);
 	u32 osize = msg->sg.size;
 	int ret = 0;
 
 	len -= msg->sg.size;
 	while (len > 0) {
+		unsigned int frag_offset, frag_len;
 		struct scatterlist *sge;
-		u32 orig_offset;
+		struct page *page;
 		int use, i;
+		void *va;
 
-		if (!sk_page_frag_refill(sk, pfrag)) {
+		va = sk_page_frag_alloc_prepare(sk, pfrag, &frag_offset,
+						&frag_len);
+		if (!va) {
 			ret = -ENOMEM;
 			goto msg_trim;
 		}
 
-		orig_offset = pfrag->offset;
-		use = min_t(int, len, pfrag->size - orig_offset);
+		use = min_t(int, len, frag_len);
 		if (!sk_wmem_schedule(sk, use)) {
 			ret = -ENOMEM;
 			goto msg_trim;
@@ -53,10 +56,12 @@ int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
 		sk_msg_iter_var_prev(i);
 		sge = &msg->sg.data[i];
 
+		page = virt_to_page(va);
 		if (sk_msg_try_coalesce_ok(msg, elem_first_coalesce) &&
-		    sg_page(sge) == pfrag->page &&
-		    sge->offset + sge->length == orig_offset) {
+		    sg_page(sge) == page &&
+		    sge->offset + sge->length == frag_offset) {
 			sge->length += use;
+			page_frag_alloc_commit_noref(pfrag, frag_offset, use);
 		} else {
 			if (sk_msg_full(msg)) {
 				ret = -ENOSPC;
@@ -65,14 +70,13 @@ int sk_msg_alloc(struct sock *sk, struct sk_msg *msg, int len,
 
 			sge = &msg->sg.data[msg->sg.end];
 			sg_unmark_end(sge);
-			sg_set_page(sge, pfrag->page, use, orig_offset);
-			get_page(pfrag->page);
+			sg_set_page(sge, page, use, frag_offset);
+			page_frag_alloc_commit(pfrag, frag_offset, use);
 			sk_msg_iter_next(msg, end);
 		}
 
 		sk_mem_charge(sk, use);
 		msg->sg.size += use;
-		pfrag->offset += use;
 		len -= use;
 	}
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 43bf3818c19e..e10247783ada 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2191,10 +2191,7 @@ static void __sk_destruct(struct rcu_head *head)
 		pr_debug("%s: optmem leakage (%d bytes) detected\n",
 			 __func__, atomic_read(&sk->sk_omem_alloc));
 
-	if (sk->sk_frag.page) {
-		put_page(sk->sk_frag.page);
-		sk->sk_frag.page = NULL;
-	}
+	page_frag_cache_drain(&sk->sk_frag);
 
 	/* We do not need to acquire sk->sk_peer_lock, we are the last user. */
 	put_cred(sk->sk_peer_cred);
@@ -2936,16 +2933,21 @@ bool skb_page_frag_refill(unsigned int sz, struct page_frag *pfrag, gfp_t gfp)
 }
 EXPORT_SYMBOL(skb_page_frag_refill);
 
-bool sk_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
+void *sk_page_frag_alloc_prepare(struct sock *sk, struct page_frag_cache *pfrag,
+				 unsigned int *offset, unsigned int *size)
 {
-	if (likely(skb_page_frag_refill(32U, pfrag, sk->sk_allocation)))
-		return true;
+	void *va;
+
+	*size = 32U;
+	va = page_frag_alloc_prepare(pfrag, offset, size, sk->sk_allocation);
+	if (likely(va))
+		return va;
 
 	sk_enter_memory_pressure(sk);
 	sk_stream_moderate_sndbuf(sk);
-	return false;
+	return NULL;
 }
-EXPORT_SYMBOL(sk_page_frag_refill);
+EXPORT_SYMBOL(sk_page_frag_alloc_prepare);
 
 void __lock_sock(struct sock *sk)
 	__releases(&sk->sk_lock.slock)
@@ -3479,8 +3481,8 @@ void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
 	sk->sk_error_report	=	sock_def_error_report;
 	sk->sk_destruct		=	sock_def_destruct;
 
-	sk->sk_frag.page	=	NULL;
-	sk->sk_frag.offset	=	0;
+	page_frag_cache_init(&sk->sk_frag);
+
 	sk->sk_peek_off		=	-1;
 
 	sk->sk_peer_pid 	=	NULL;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 1fe794967211..2e96bf6935e1 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -952,7 +952,7 @@ static int __ip_append_data(struct sock *sk,
 			    struct flowi4 *fl4,
 			    struct sk_buff_head *queue,
 			    struct inet_cork *cork,
-			    struct page_frag *pfrag,
+			    struct page_frag_cache *pfrag,
 			    int getfrag(void *from, char *to, int offset,
 					int len, int odd, struct sk_buff *skb),
 			    void *from, int length, int transhdrlen,
@@ -1228,31 +1228,40 @@ static int __ip_append_data(struct sock *sk,
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
 			int i = skb_shinfo(skb)->nr_frags;
+			unsigned int frag_offset, frag_size;
+			struct page *page;
+			void *va;
 
 			err = -ENOMEM;
-			if (!sk_page_frag_refill(sk, pfrag))
+			va = sk_page_frag_alloc_prepare(sk, pfrag, &frag_offset,
+							&frag_size);
+			if (!va)
 				goto error;
 
+			page = virt_to_page(va);
 			skb_zcopy_downgrade_managed(skb);
-			if (!skb_can_coalesce(skb, i, pfrag->page,
-					      pfrag->offset)) {
+			copy = min_t(int, copy, frag_size);
+			if (getfrag(from, va + frag_offset, offset, copy,
+				    skb->len, skb) < 0)
+				goto error_efault;
+
+			if (!skb_can_coalesce(skb, i, page, frag_offset)) {
 				err = -EMSGSIZE;
 				if (i == MAX_SKB_FRAGS)
 					goto error;
 
-				__skb_fill_page_desc(skb, i, pfrag->page,
-						     pfrag->offset, 0);
+				__skb_fill_page_desc(skb, i, page, frag_offset,
+						     copy);
 				skb_shinfo(skb)->nr_frags = ++i;
-				get_page(pfrag->page);
+				page_frag_alloc_commit(pfrag, frag_offset,
+						       copy);
+			} else {
+				skb_frag_size_add(
+					&skb_shinfo(skb)->frags[i - 1], copy);
+				page_frag_alloc_commit_noref(pfrag, frag_offset,
+							     copy);
 			}
-			copy = min_t(int, copy, pfrag->size - pfrag->offset);
-			if (getfrag(from,
-				    page_address(pfrag->page) + pfrag->offset,
-				    offset, copy, skb->len, skb) < 0)
-				goto error_efault;
 
-			pfrag->offset += copy;
-			skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
 			skb_len_add(skb, copy);
 			wmem_alloc_delta += copy;
 		} else {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d20b62d52171..7f01d1a1e0ee 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1177,13 +1177,17 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 		if (zc == 0) {
 			bool merge = true;
 			int i = skb_shinfo(skb)->nr_frags;
-			struct page_frag *pfrag = sk_page_frag(sk);
+			struct page_frag_cache *pfrag = sk_page_frag(sk);
+			unsigned int offset, size;
+			struct page *page;
+			void *va;
 
-			if (!sk_page_frag_refill(sk, pfrag))
+			va = sk_page_frag_alloc_prepare(sk, pfrag, &offset, &size);
+			if (!va)
 				goto wait_for_space;
 
-			if (!skb_can_coalesce(skb, i, pfrag->page,
-					      pfrag->offset)) {
+			page = virt_to_page(va);
+			if (!skb_can_coalesce(skb, i, page, offset)) {
 				if (i >= READ_ONCE(sysctl_max_skb_frags)) {
 					tcp_mark_push(tp, skb);
 					goto new_segment;
@@ -1191,7 +1195,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 				merge = false;
 			}
 
-			copy = min_t(int, copy, pfrag->size - pfrag->offset);
+			copy = min_t(int, copy, size);
 
 			if (unlikely(skb_zcopy_pure(skb) || skb_zcopy_managed(skb))) {
 				if (tcp_downgrade_zcopy_pure(sk, skb))
@@ -1203,22 +1207,19 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			if (!copy)
 				goto wait_for_space;
 
-			err = skb_copy_to_page_nocache(sk, &msg->msg_iter, skb,
-						       pfrag->page,
-						       pfrag->offset,
-						       copy);
+			err = skb_copy_to_va_nocache(sk, &msg->msg_iter, skb,
+						     va + offset, copy);
 			if (err)
 				goto do_error;
 
 			/* Update the skb. */
 			if (merge) {
 				skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
+				page_frag_alloc_commit_noref(pfrag, offset, copy);
 			} else {
-				skb_fill_page_desc(skb, i, pfrag->page,
-						   pfrag->offset, copy);
-				page_ref_inc(pfrag->page);
+				skb_fill_page_desc(skb, i, page, offset, copy);
+				page_frag_alloc_commit(pfrag, offset, copy);
 			}
-			pfrag->offset += copy;
 		} else if (zc == MSG_ZEROCOPY)  {
 			/* First append to a fragless skb builds initial
 			 * pure zerocopy skb
@@ -3099,11 +3100,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 
 	WARN_ON(inet->inet_num && !icsk->icsk_bind_hash);
 
-	if (sk->sk_frag.page) {
-		put_page(sk->sk_frag.page);
-		sk->sk_frag.page = NULL;
-		sk->sk_frag.offset = 0;
-	}
+	page_frag_cache_drain(&sk->sk_frag);
 	sk_error_report(sk);
 	return 0;
 }
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e3167ad96567..b41293981066 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3927,9 +3927,12 @@ static int tcp_send_syn_data(struct sock *sk, struct sk_buff *syn)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct tcp_fastopen_request *fo = tp->fastopen_req;
-	struct page_frag *pfrag = sk_page_frag(sk);
+	struct page_frag_cache *pfrag = sk_page_frag(sk);
+	unsigned int offset, size;
 	struct sk_buff *syn_data;
 	int space, err = 0;
+	struct page *page;
+	void *va;
 
 	tp->rx_opt.mss_clamp = tp->advmss;  /* If MSS is not cached */
 	if (!tcp_fastopen_cookie_check(sk, &tp->rx_opt.mss_clamp, &fo->cookie))
@@ -3948,30 +3951,33 @@ static int tcp_send_syn_data(struct sock *sk, struct sk_buff *syn)
 
 	space = min_t(size_t, space, fo->size);
 
-	if (space &&
-	    !skb_page_frag_refill(min_t(size_t, space, PAGE_SIZE),
-				  pfrag, sk->sk_allocation))
-		goto fallback;
+	if (space) {
+		size = min_t(size_t, space, PAGE_SIZE);
+		va = page_frag_alloc_prepare(pfrag, &offset, &size,
+					     sk->sk_allocation);
+		if (!va)
+			goto fallback;
+	}
+
 	syn_data = tcp_stream_alloc_skb(sk, sk->sk_allocation, false);
 	if (!syn_data)
 		goto fallback;
 	memcpy(syn_data->cb, syn->cb, sizeof(syn->cb));
 	if (space) {
-		space = min_t(size_t, space, pfrag->size - pfrag->offset);
+		space = min_t(size_t, space, size);
 		space = tcp_wmem_schedule(sk, space);
 	}
 	if (space) {
-		space = copy_page_from_iter(pfrag->page, pfrag->offset,
-					    space, &fo->data->msg_iter);
+		space = _copy_from_iter(va + offset, space,
+					&fo->data->msg_iter);
 		if (unlikely(!space)) {
 			tcp_skb_tsorted_anchor_cleanup(syn_data);
 			kfree_skb(syn_data);
 			goto fallback;
 		}
-		skb_fill_page_desc(syn_data, 0, pfrag->page,
-				   pfrag->offset, space);
-		page_ref_inc(pfrag->page);
-		pfrag->offset += space;
+		page = virt_to_page(va);
+		skb_fill_page_desc(syn_data, 0, page, offset, space);
+		page_frag_alloc_commit(pfrag, offset, space);
 		skb_len_add(syn_data, space);
 		skb_zcopy_set(syn_data, fo->uarg, NULL);
 	}
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index b9dd3a66e423..c95dcb04c3b2 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1404,7 +1404,7 @@ static int __ip6_append_data(struct sock *sk,
 			     struct sk_buff_head *queue,
 			     struct inet_cork_full *cork_full,
 			     struct inet6_cork *v6_cork,
-			     struct page_frag *pfrag,
+			     struct page_frag_cache *pfrag,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
 			     void *from, size_t length, int transhdrlen,
@@ -1745,32 +1745,41 @@ static int __ip6_append_data(struct sock *sk,
 			copy = err;
 			wmem_alloc_delta += copy;
 		} else if (!zc) {
+			unsigned int frag_offset, frag_size;
 			int i = skb_shinfo(skb)->nr_frags;
+			struct page *page;
+			void *va;
 
 			err = -ENOMEM;
-			if (!sk_page_frag_refill(sk, pfrag))
+			va = sk_page_frag_alloc_prepare(sk, pfrag, &frag_offset,
+							&frag_size);
+			if (!va)
 				goto error;
 
+			page = virt_to_page(va);
 			skb_zcopy_downgrade_managed(skb);
-			if (!skb_can_coalesce(skb, i, pfrag->page,
-					      pfrag->offset)) {
+			copy = min_t(int, copy, frag_size);
+			if (getfrag(from, va + frag_offset, offset, copy,
+				    skb->len, skb) < 0)
+				goto error_efault;
+
+			if (!skb_can_coalesce(skb, i, page, frag_offset)) {
 				err = -EMSGSIZE;
 				if (i == MAX_SKB_FRAGS)
 					goto error;
 
-				__skb_fill_page_desc(skb, i, pfrag->page,
-						     pfrag->offset, 0);
+				__skb_fill_page_desc(skb, i, page, frag_offset,
+						     copy);
 				skb_shinfo(skb)->nr_frags = ++i;
-				get_page(pfrag->page);
+				page_frag_alloc_commit(pfrag, frag_offset,
+						       copy);
+			} else {
+				skb_frag_size_add(
+					&skb_shinfo(skb)->frags[i - 1], copy);
+				page_frag_alloc_commit_noref(pfrag, frag_offset,
+							     copy);
 			}
-			copy = min_t(int, copy, pfrag->size - pfrag->offset);
-			if (getfrag(from,
-				    page_address(pfrag->page) + pfrag->offset,
-				    offset, copy, skb->len, skb) < 0)
-				goto error_efault;
 
-			pfrag->offset += copy;
-			skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
 			skb->len += copy;
 			skb->data_len += copy;
 			skb->truesize += copy;
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 2f191e50d4fc..5e64ae32f760 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -803,13 +803,17 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	while (msg_data_left(msg)) {
 		bool merge = true;
 		int i = skb_shinfo(skb)->nr_frags;
-		struct page_frag *pfrag = sk_page_frag(sk);
+		struct page_frag_cache *pfrag = sk_page_frag(sk);
+		unsigned int offset, size;
+		struct page *page;
+		void *va;
 
-		if (!sk_page_frag_refill(sk, pfrag))
+		va = sk_page_frag_alloc_prepare(sk, pfrag, &offset, &size);
+		if (!va)
 			goto wait_for_memory;
 
-		if (!skb_can_coalesce(skb, i, pfrag->page,
-				      pfrag->offset)) {
+		page = virt_to_page(va);
+		if (!skb_can_coalesce(skb, i, page, offset)) {
 			if (i == MAX_SKB_FRAGS) {
 				struct sk_buff *tskb;
 
@@ -850,15 +854,12 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 			if (head != skb)
 				head->truesize += copy;
 		} else {
-			copy = min_t(int, msg_data_left(msg),
-				     pfrag->size - pfrag->offset);
+			copy = min_t(int, msg_data_left(msg), size);
 			if (!sk_wmem_schedule(sk, copy))
 				goto wait_for_memory;
 
-			err = skb_copy_to_page_nocache(sk, &msg->msg_iter, skb,
-						       pfrag->page,
-						       pfrag->offset,
-						       copy);
+			err = skb_copy_to_va_nocache(sk, &msg->msg_iter, skb,
+						     va + offset, copy);
 			if (err)
 				goto out_error;
 
@@ -866,13 +867,12 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 			if (merge) {
 				skb_frag_size_add(
 					&skb_shinfo(skb)->frags[i - 1], copy);
+				page_frag_alloc_commit_noref(pfrag, offset, copy);
 			} else {
-				skb_fill_page_desc(skb, i, pfrag->page,
-						   pfrag->offset, copy);
-				get_page(pfrag->page);
+				skb_fill_page_desc(skb, i, page, offset, copy);
+				page_frag_alloc_commit(pfrag, offset, copy);
 			}
 
-			pfrag->offset += copy;
 		}
 
 		copied += copy;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3a1967bc7bad..7253e4950feb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -957,17 +957,16 @@ static bool mptcp_skb_can_collapse_to(u64 write_seq,
 }
 
 /* we can append data to the given data frag if:
- * - there is space available in the backing page_frag
- * - the data frag tail matches the current page_frag free offset
+ * - the data frag tail matches the current page and offset
  * - the data frag end sequence number matches the current write seq
  */
 static bool mptcp_frag_can_collapse_to(const struct mptcp_sock *msk,
-				       const struct page_frag *pfrag,
+				       const struct page *page,
+				       const unsigned int offset,
 				       const struct mptcp_data_frag *df)
 {
-	return df && pfrag->page == df->page &&
-		pfrag->size - pfrag->offset > 0 &&
-		pfrag->offset == (df->offset + df->data_len) &&
+	return df && page == df->page &&
+		offset == (df->offset + df->data_len) &&
 		df->data_seq + df->data_len == msk->write_seq;
 }
 
@@ -1082,30 +1081,35 @@ static void mptcp_enter_memory_pressure(struct sock *sk)
 /* ensure we get enough memory for the frag hdr, beyond some minimal amount of
  * data
  */
-static bool mptcp_page_frag_refill(struct sock *sk, struct page_frag *pfrag)
+static void *mptcp_page_frag_alloc_prepare(struct sock *sk,
+					   struct page_frag_cache *pfrag,
+					   unsigned int *offset,
+					   unsigned int *size)
 {
-	if (likely(skb_page_frag_refill(32U + sizeof(struct mptcp_data_frag),
-					pfrag, sk->sk_allocation)))
-		return true;
+	void *va;
+
+	va = page_frag_alloc_prepare(pfrag, offset, size, sk->sk_allocation);
+	if (likely(va))
+		return va;
 
 	mptcp_enter_memory_pressure(sk);
-	return false;
+	return NULL;
 }
 
 static struct mptcp_data_frag *
-mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page_frag *pfrag,
-		      int orig_offset)
+mptcp_carve_data_frag(const struct mptcp_sock *msk, struct page *page,
+		      unsigned int orig_offset)
 {
 	int offset = ALIGN(orig_offset, sizeof(long));
 	struct mptcp_data_frag *dfrag;
 
-	dfrag = (struct mptcp_data_frag *)(page_to_virt(pfrag->page) + offset);
+	dfrag = (struct mptcp_data_frag *)(page_to_virt(page) + offset);
 	dfrag->data_len = 0;
 	dfrag->data_seq = msk->write_seq;
 	dfrag->overhead = offset - orig_offset + sizeof(struct mptcp_data_frag);
 	dfrag->offset = offset + sizeof(struct mptcp_data_frag);
 	dfrag->already_sent = 0;
-	dfrag->page = pfrag->page;
+	dfrag->page = page;
 
 	return dfrag;
 }
@@ -1788,7 +1792,7 @@ static u32 mptcp_send_limit(const struct sock *sk)
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
-	struct page_frag *pfrag;
+	struct page_frag_cache *pfrag;
 	size_t copied = 0;
 	int ret = 0;
 	long timeo;
@@ -1827,9 +1831,12 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	while (msg_data_left(msg)) {
 		int total_ts, frag_truesize = 0;
 		struct mptcp_data_frag *dfrag;
-		bool dfrag_collapsed;
-		size_t psize, offset;
+		bool dfrag_collapsed = false;
+		unsigned int offset, size;
+		struct page *page;
+		size_t psize;
 		u32 copy_limit;
+		void *va;
 
 		/* ensure fitting the notsent_lowat() constraint */
 		copy_limit = mptcp_send_limit(sk);
@@ -1840,12 +1847,23 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		 * page allocator
 		 */
 		dfrag = mptcp_pending_tail(sk);
-		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, pfrag, dfrag);
+		size = 32U;
+		va = mptcp_page_frag_alloc_prepare(sk, pfrag, &offset, &size);
+		if (!va)
+			goto wait_for_memory;
+
+		page = virt_to_page(va);
+		dfrag_collapsed = mptcp_frag_can_collapse_to(msk, page, offset,
+							     dfrag);
 		if (!dfrag_collapsed) {
-			if (!mptcp_page_frag_refill(sk, pfrag))
+			size = 32U + sizeof(struct mptcp_data_frag);
+			va = mptcp_page_frag_alloc_prepare(sk, pfrag, &offset,
+							   &size);
+			if (!va)
 				goto wait_for_memory;
 
-			dfrag = mptcp_carve_data_frag(msk, pfrag, pfrag->offset);
+			page = virt_to_page(va);
+			dfrag = mptcp_carve_data_frag(msk, page, offset);
 			frag_truesize = dfrag->overhead;
 		}
 
@@ -1853,8 +1871,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		 * memory accounting will prevent execessive memory usage
 		 * anyway
 		 */
-		offset = dfrag->offset + dfrag->data_len;
-		psize = pfrag->size - offset;
+		psize = size - frag_truesize;
 		psize = min_t(size_t, psize, msg_data_left(msg));
 		psize = min_t(size_t, psize, copy_limit);
 		total_ts = psize + frag_truesize;
@@ -1863,7 +1880,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			goto wait_for_memory;
 
 		ret = do_copy_data_nocache(sk, psize, &msg->msg_iter,
-					   page_address(dfrag->page) + offset);
+					   va + dfrag->offset + dfrag->data_len);
 		if (ret)
 			goto do_error;
 
@@ -1872,7 +1889,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		copied += psize;
 		dfrag->data_len += psize;
 		frag_truesize += psize;
-		pfrag->offset += frag_truesize;
 		WRITE_ONCE(msk->write_seq, msk->write_seq + psize);
 
 		/* charge data on mptcp pending queue to the msk socket
@@ -1880,11 +1896,15 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		 */
 		sk_wmem_queued_add(sk, frag_truesize);
 		if (!dfrag_collapsed) {
-			get_page(dfrag->page);
+			page_frag_alloc_commit(pfrag, offset, frag_truesize);
 			list_add_tail(&dfrag->list, &msk->rtx_queue);
 			if (!msk->first_pending)
 				WRITE_ONCE(msk->first_pending, dfrag);
+		} else {
+			page_frag_alloc_commit_noref(pfrag, offset,
+						     frag_truesize);
 		}
+
 		pr_debug("msk=%p dfrag at seq=%llu len=%u sent=%u new=%d", msk,
 			 dfrag->data_seq, dfrag->data_len, dfrag->already_sent,
 			 !dfrag_collapsed);
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index bf8ed36b1ad6..af9cf86b727a 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -255,25 +255,43 @@ static void tls_device_resync_tx(struct sock *sk, struct tls_context *tls_ctx,
 	clear_bit_unlock(TLS_TX_SYNC_SCHED, &tls_ctx->flags);
 }
 
-static void tls_append_frag(struct tls_record_info *record,
-			    struct page_frag *pfrag,
-			    int size)
+static void tls_append_pfrag(struct tls_record_info *record,
+			     struct page_frag_cache *pfrag, struct page *page,
+			     unsigned int offset, unsigned int size)
 {
 	skb_frag_t *frag;
 
 	frag = &record->frags[record->num_frags - 1];
-	if (skb_frag_page(frag) == pfrag->page &&
-	    skb_frag_off(frag) + skb_frag_size(frag) == pfrag->offset) {
+	if (skb_frag_page(frag) == page &&
+	    skb_frag_off(frag) + skb_frag_size(frag) == offset) {
 		skb_frag_size_add(frag, size);
+		page_frag_alloc_commit_noref(pfrag, offset, size);
 	} else {
 		++frag;
-		skb_frag_fill_page_desc(frag, pfrag->page, pfrag->offset,
-					size);
+		skb_frag_fill_page_desc(frag, page, offset, size);
 		++record->num_frags;
-		get_page(pfrag->page);
+		page_frag_alloc_commit(pfrag, offset, size);
+	}
+
+	record->len += size;
+}
+
+static void tls_append_page(struct tls_record_info *record, struct page *page,
+			    unsigned int offset, unsigned int size)
+{
+	skb_frag_t *frag;
+
+	frag = &record->frags[record->num_frags - 1];
+	if (skb_frag_page(frag) == page &&
+	    skb_frag_off(frag) + skb_frag_size(frag) == offset) {
+		skb_frag_size_add(frag, size);
+	} else {
+		++frag;
+		skb_frag_fill_page_desc(frag, page, offset, size);
+		++record->num_frags;
+		get_page(page);
 	}
 
-	pfrag->offset += size;
 	record->len += size;
 }
 
@@ -314,11 +332,13 @@ static int tls_push_record(struct sock *sk,
 static void tls_device_record_close(struct sock *sk,
 				    struct tls_context *ctx,
 				    struct tls_record_info *record,
-				    struct page_frag *pfrag,
+				    struct page_frag_cache *pfrag,
 				    unsigned char record_type)
 {
 	struct tls_prot_info *prot = &ctx->prot_info;
-	struct page_frag dummy_tag_frag;
+	unsigned int offset, size;
+	struct page *page;
+	void *va;
 
 	/* append tag
 	 * device will fill in the tag, we just need to append a placeholder
@@ -326,13 +346,14 @@ static void tls_device_record_close(struct sock *sk,
 	 * increases frag count)
 	 * if we can't allocate memory now use the dummy page
 	 */
-	if (unlikely(pfrag->size - pfrag->offset < prot->tag_size) &&
-	    !skb_page_frag_refill(prot->tag_size, pfrag, sk->sk_allocation)) {
-		dummy_tag_frag.page = dummy_page;
-		dummy_tag_frag.offset = 0;
-		pfrag = &dummy_tag_frag;
+	size = prot->tag_size;
+	va = page_frag_alloc_prepare(pfrag, &offset, &size, sk->sk_allocation);
+	if (unlikely(!va)) {
+		tls_append_page(record, dummy_page, 0, prot->tag_size);
+	} else {
+		page = virt_to_page(va);
+		tls_append_pfrag(record, pfrag, page, offset, prot->tag_size);
 	}
-	tls_append_frag(record, pfrag, prot->tag_size);
 
 	/* fill prepend */
 	tls_fill_prepend(ctx, skb_frag_address(&record->frags[0]),
@@ -340,23 +361,34 @@ static void tls_device_record_close(struct sock *sk,
 			 record_type);
 }
 
-static int tls_create_new_record(struct tls_offload_context_tx *offload_ctx,
-				 struct page_frag *pfrag,
+static int tls_create_new_record(struct sock *sk,
+				 struct tls_offload_context_tx *offload_ctx,
+				 struct page_frag_cache *pfrag,
 				 size_t prepend_size)
 {
 	struct tls_record_info *record;
+	unsigned int offset, size;
+	struct page *page;
 	skb_frag_t *frag;
+	void *va;
+
+	size = prepend_size;
+	va = page_frag_alloc_prepare(pfrag, &offset, &size, sk->sk_allocation);
+	if (!va) {
+		READ_ONCE(sk->sk_prot)->enter_memory_pressure(sk);
+		sk_stream_moderate_sndbuf(sk);
+		return -ENOMEM;
+	}
 
 	record = kmalloc(sizeof(*record), GFP_KERNEL);
 	if (!record)
 		return -ENOMEM;
 
+	page = virt_to_page(va);
 	frag = &record->frags[0];
-	skb_frag_fill_page_desc(frag, pfrag->page, pfrag->offset,
-				prepend_size);
+	skb_frag_fill_page_desc(frag, page, offset, prepend_size);
 
-	get_page(pfrag->page);
-	pfrag->offset += prepend_size;
+	page_frag_alloc_commit(pfrag, offset, prepend_size);
 
 	record->num_frags = 1;
 	record->len = prepend_size;
@@ -364,33 +396,21 @@ static int tls_create_new_record(struct tls_offload_context_tx *offload_ctx,
 	return 0;
 }
 
-static int tls_do_allocation(struct sock *sk,
-			     struct tls_offload_context_tx *offload_ctx,
-			     struct page_frag *pfrag,
-			     size_t prepend_size)
+static void *tls_do_allocation(struct sock *sk,
+			       struct tls_offload_context_tx *offload_ctx,
+			       struct page_frag_cache *pfrag,
+			       size_t prepend_size, unsigned int *offset,
+			       unsigned int *size)
 {
-	int ret;
-
 	if (!offload_ctx->open_record) {
-		if (unlikely(!skb_page_frag_refill(prepend_size, pfrag,
-						   sk->sk_allocation))) {
-			READ_ONCE(sk->sk_prot)->enter_memory_pressure(sk);
-			sk_stream_moderate_sndbuf(sk);
-			return -ENOMEM;
-		}
+		int ret;
 
-		ret = tls_create_new_record(offload_ctx, pfrag, prepend_size);
+		ret = tls_create_new_record(sk, offload_ctx, pfrag, prepend_size);
 		if (ret)
-			return ret;
-
-		if (pfrag->size > pfrag->offset)
-			return 0;
+			return NULL;
 	}
 
-	if (!sk_page_frag_refill(sk, pfrag))
-		return -ENOMEM;
-
-	return 0;
+	return sk_page_frag_alloc_prepare(sk, pfrag, offset, size);
 }
 
 static int tls_device_copy_data(void *addr, size_t bytes, struct iov_iter *i)
@@ -427,8 +447,8 @@ static int tls_push_data(struct sock *sk,
 	struct tls_prot_info *prot = &tls_ctx->prot_info;
 	struct tls_offload_context_tx *ctx = tls_offload_ctx_tx(tls_ctx);
 	struct tls_record_info *record;
+	struct page_frag_cache *pfrag;
 	int tls_push_record_flags;
-	struct page_frag *pfrag;
 	size_t orig_size = size;
 	u32 max_open_record_len;
 	bool more = false;
@@ -465,8 +485,13 @@ static int tls_push_data(struct sock *sk,
 	max_open_record_len = TLS_MAX_PAYLOAD_SIZE +
 			      prot->prepend_size;
 	do {
-		rc = tls_do_allocation(sk, ctx, pfrag, prot->prepend_size);
-		if (unlikely(rc)) {
+		unsigned int frag_offset, frag_size;
+		struct page *page;
+		void *va;
+
+		va = tls_do_allocation(sk, ctx, pfrag, prot->prepend_size,
+				       &frag_offset, &frag_size);
+		if (unlikely(!va)) {
 			rc = sk_stream_wait_memory(sk, &timeo);
 			if (!rc)
 				continue;
@@ -494,8 +519,7 @@ static int tls_push_data(struct sock *sk,
 
 		copy = min_t(size_t, size, max_open_record_len - record->len);
 		if (copy && (flags & MSG_SPLICE_PAGES)) {
-			struct page_frag zc_pfrag;
-			struct page **pages = &zc_pfrag.page;
+			struct page **pages = &page;
 			size_t off;
 
 			rc = iov_iter_extract_pages(iter, &pages,
@@ -507,24 +531,23 @@ static int tls_push_data(struct sock *sk,
 			}
 			copy = rc;
 
-			if (WARN_ON_ONCE(!sendpage_ok(zc_pfrag.page))) {
+			if (WARN_ON_ONCE(!sendpage_ok(page))) {
 				iov_iter_revert(iter, copy);
 				rc = -EIO;
 				goto handle_error;
 			}
 
-			zc_pfrag.offset = off;
-			zc_pfrag.size = copy;
-			tls_append_frag(record, &zc_pfrag, copy);
+			tls_append_page(record, page, off, copy);
 		} else if (copy) {
-			copy = min_t(size_t, copy, pfrag->size - pfrag->offset);
+			copy = min_t(size_t, copy, frag_size);
 
-			rc = tls_device_copy_data(page_address(pfrag->page) +
-						  pfrag->offset, copy,
-						  iter);
+			rc = tls_device_copy_data(va + frag_offset, copy, iter);
 			if (rc)
 				goto handle_error;
-			tls_append_frag(record, pfrag, copy);
+
+			page = virt_to_page(va);
+			tls_append_pfrag(record, pfrag, page, frag_offset,
+					 copy);
 		}
 
 		size -= copy;
-- 
2.33.0


