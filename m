Return-Path: <linux-kernel+bounces-44226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F03D841F17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9FAA1F2BA14
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733D9664CC;
	Tue, 30 Jan 2024 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRBtlYbN"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42C466B2B;
	Tue, 30 Jan 2024 09:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605996; cv=none; b=u+H/mwIb4aRt11gjl51I+uvJevWRNnYDpgRBQqgUWL+jUjcKWkuKhjC5D3sMKOQnadFhpvET3ywn+fAWuYDJkajZeD0A+4zO/D3uKbI3iPmqlIJ4z+YpbHoAPUNH4tIfpTGw5cm2qolKrfK8xwP6Z6ZUjg7H5x5sC7BcA2jsZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605996; c=relaxed/simple;
	bh=R1ACoB28rY6p8+XZEPrUMweeKHn7QHqywci7Ubfb9rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxvVXGZcngXt9KPjIm2Di0OlAEu6CvNdRvYbmZS02eJkxQMf5mlm23kmAqVn5AQpSxZ5sRIbo0qjNNDQdd6FOXtlsB/3vxn0Td5V/AU/hsOTRoudZNgtzGQbiQ0I+p3Ro0di5OHlC1lFn8+ESJkNRkb6vM24aqwBRTq541NemPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRBtlYbN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-29065efa06fso2913236a91.1;
        Tue, 30 Jan 2024 01:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706605994; x=1707210794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLAiJpm0LtH5vcnMce7MYOvEWmNX9nkZqVGOHKY+ODc=;
        b=lRBtlYbNdOaf5OU+UVPPbH22zXuN9DeXBVc0q1HKlBeNTVMUj5UHelju1gDt+bko2U
         LLd6bb5wcaGL4+nL1ZOzCWEu5LbP9iG0ihBrMV/uM7TIko/Pc9YPfVjkO5Q412us6uVG
         PPzz+UN3bvI10FuqQmOHK9H8jjGFh8yqcHwFHvRSGvz+NkNkNSJ6P4L9Ik0I8vdKRmew
         3seQ4+YAo5H6apKhpdetmwFKARQDB9Q7oSNqOgQTGl9UmcnboIdLNBM+w9NIYFwpHnbq
         SN0nEbzvDGTac5QV8bUe7/B5k01jaWU4nwGrCntOEZ48puitgioWxfV2pt8R4ZuNP3n7
         Sq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706605994; x=1707210794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kLAiJpm0LtH5vcnMce7MYOvEWmNX9nkZqVGOHKY+ODc=;
        b=DzIz+O+jFuaRrEN+tkpC57y9qMJoIXRxmfVncamtOE5CvBAE1tHPtL4lrXY/wk9QRP
         b06YOitTCa1xcNGWfcIbNRSoV1yAXcc0nGxSHoJ2Ze0qu43/bTDE5MlDV0z5Isy2EOH+
         om/ITR0IUVflUazO7DWLWxatIaN7cxqDTtzaS2Sw45zepnz7cDFgluetgb6zbqxxO4En
         MMaWq2QnCOX7vMSnB1HPcfLkWi6NP+rCE6bcEVyBBdaZQ865a9qd/fZEkbX761laTO4w
         44nrhKwZo6OBC+q88Vle6XWGSZiAgYY9B5Jjtak3De9u2P3OR9aQoiR87AhPyKW7rYnd
         oGFg==
X-Gm-Message-State: AOJu0YxPvCvMcY3FbJzMUXiI7fJdadsAyWvCxF27PDWwMfySIFUrMgjm
	LveIEEQrnXpzVPgUb1kplVF0uvWxmyKrdFqvrqwiiicPwkEzsw99
X-Google-Smtp-Source: AGHT+IF3b/+kojapfeRuhsR/j4T111w0CzhWh5Et0GGp61tD12NEkGqgoWCAncjIhdgx+EW/PRYQVQ==
X-Received: by 2002:a17:90b:610:b0:292:6b60:ef6e with SMTP id gb16-20020a17090b061000b002926b60ef6emr5168649pjb.46.1706605994100;
        Tue, 30 Jan 2024 01:13:14 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id bg3-20020a17090b0d8300b002949d9767acsm7146273pjb.4.2024.01.30.01.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 01:13:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mpatocka@redhat.com
Cc: linux-kernel@vger.kernel.org,
	dm-devel@lists.linux.dev,
	msnitzer@redhat.com,
	ignat@cloudflare.com,
	damien.lemoal@wdc.com,
	bob.liu@oracle.com,
	houtao1@huawei.com,
	peterz@infradead.org,
	mingo@kernel.org,
	netdev@vger.kernel.org,
	allen.lkml@gmail.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6/8] net: tcp: tsq: Convert from tasklet to BH workqueue
Date: Mon, 29 Jan 2024 23:11:53 -1000
Message-ID: <20240130091300.2968534-7-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130091300.2968534-1-tj@kernel.org>
References: <20240130091300.2968534-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only generic interface to execute asynchronously in the BH context is
tasklet; however, it's marked deprecated and has some design flaws. To
replace tasklets, BH workqueue support was recently added. A BH workqueue
behaves similarly to regular workqueues except that the queued work items
are executed in the BH context.

This patch converts TCP Small Queues implementation from tasklet to BH
workqueue.

Semantically, this is an equivalent conversion and there shouldn't be any
user-visible behavior changes. While workqueue's queueing and execution
paths are a bit heavier than tasklet's, unless the work item is being queued
every packet, the difference hopefully shouldn't matter.

My experience with the networking stack is very limited and this patch
definitely needs attention from someone who actually understands networking.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [IPv4/IPv6])
Cc: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org (open list:NETWORKING [TCP])
---
 include/net/tcp.h     |  2 +-
 net/ipv4/tcp.c        |  2 +-
 net/ipv4/tcp_output.c | 36 ++++++++++++++++++------------------
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index dd78a1181031..89f3702be47a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -324,7 +324,7 @@ extern struct proto tcp_prot;
 #define TCP_DEC_STATS(net, field)	SNMP_DEC_STATS((net)->mib.tcp_statistics, field)
 #define TCP_ADD_STATS(net, field, val)	SNMP_ADD_STATS((net)->mib.tcp_statistics, field, val)
 
-void tcp_tasklet_init(void);
+void tcp_tsq_work_init(void);
 
 int tcp_v4_err(struct sk_buff *skb, u32);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1baa484d2190..d085ee5642fe 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4772,6 +4772,6 @@ void __init tcp_init(void)
 	tcp_v4_init();
 	tcp_metrics_init();
 	BUG_ON(tcp_register_congestion_control(&tcp_reno) != 0);
-	tcp_tasklet_init();
+	tcp_tsq_work_init();
 	mptcp_init();
 }
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e3167ad96567..d11be6eebb6e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1049,15 +1049,15 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
  * needs to be reallocated in a driver.
  * The invariant being skb->truesize subtracted from sk->sk_wmem_alloc
  *
- * Since transmit from skb destructor is forbidden, we use a tasklet
+ * Since transmit from skb destructor is forbidden, we use a BH work item
  * to process all sockets that eventually need to send more skbs.
- * We use one tasklet per cpu, with its own queue of sockets.
+ * We use one work item per cpu, with its own queue of sockets.
  */
-struct tsq_tasklet {
-	struct tasklet_struct	tasklet;
+struct tsq_work {
+	struct work_struct	work;
 	struct list_head	head; /* queue of tcp sockets */
 };
-static DEFINE_PER_CPU(struct tsq_tasklet, tsq_tasklet);
+static DEFINE_PER_CPU(struct tsq_work, tsq_work);
 
 static void tcp_tsq_write(struct sock *sk)
 {
@@ -1087,14 +1087,14 @@ static void tcp_tsq_handler(struct sock *sk)
 	bh_unlock_sock(sk);
 }
 /*
- * One tasklet per cpu tries to send more skbs.
- * We run in tasklet context but need to disable irqs when
+ * One work item per cpu tries to send more skbs.
+ * We run in BH context but need to disable irqs when
  * transferring tsq->head because tcp_wfree() might
  * interrupt us (non NAPI drivers)
  */
-static void tcp_tasklet_func(struct tasklet_struct *t)
+static void tcp_tsq_workfn(struct work_struct *work)
 {
-	struct tsq_tasklet *tsq = from_tasklet(tsq,  t, tasklet);
+	struct tsq_work *tsq = container_of(work, struct tsq_work, work);
 	LIST_HEAD(list);
 	unsigned long flags;
 	struct list_head *q, *n;
@@ -1164,15 +1164,15 @@ void tcp_release_cb(struct sock *sk)
 }
 EXPORT_SYMBOL(tcp_release_cb);
 
-void __init tcp_tasklet_init(void)
+void __init tcp_tsq_work_init(void)
 {
 	int i;
 
 	for_each_possible_cpu(i) {
-		struct tsq_tasklet *tsq = &per_cpu(tsq_tasklet, i);
+		struct tsq_work *tsq = &per_cpu(tsq_work, i);
 
 		INIT_LIST_HEAD(&tsq->head);
-		tasklet_setup(&tsq->tasklet, tcp_tasklet_func);
+		INIT_WORK(&tsq->work, tcp_tsq_workfn);
 	}
 }
 
@@ -1186,11 +1186,11 @@ void tcp_wfree(struct sk_buff *skb)
 	struct sock *sk = skb->sk;
 	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned long flags, nval, oval;
-	struct tsq_tasklet *tsq;
+	struct tsq_work *tsq;
 	bool empty;
 
 	/* Keep one reference on sk_wmem_alloc.
-	 * Will be released by sk_free() from here or tcp_tasklet_func()
+	 * Will be released by sk_free() from here or tcp_tsq_workfn()
 	 */
 	WARN_ON(refcount_sub_and_test(skb->truesize - 1, &sk->sk_wmem_alloc));
 
@@ -1212,13 +1212,13 @@ void tcp_wfree(struct sk_buff *skb)
 		nval = (oval & ~TSQF_THROTTLED) | TSQF_QUEUED;
 	} while (!try_cmpxchg(&sk->sk_tsq_flags, &oval, nval));
 
-	/* queue this socket to tasklet queue */
+	/* queue this socket to BH workqueue */
 	local_irq_save(flags);
-	tsq = this_cpu_ptr(&tsq_tasklet);
+	tsq = this_cpu_ptr(&tsq_work);
 	empty = list_empty(&tsq->head);
 	list_add(&tp->tsq_node, &tsq->head);
 	if (empty)
-		tasklet_schedule(&tsq->tasklet);
+		queue_work(system_bh_wq, &tsq->work);
 	local_irq_restore(flags);
 	return;
 out:
@@ -2623,7 +2623,7 @@ static bool tcp_small_queue_check(struct sock *sk, const struct sk_buff *skb,
 	if (refcount_read(&sk->sk_wmem_alloc) > limit) {
 		/* Always send skb if rtx queue is empty or has one skb.
 		 * No need to wait for TX completion to call us back,
-		 * after softirq/tasklet schedule.
+		 * after softirq schedule.
 		 * This helps when TX completions are delayed too much.
 		 */
 		if (tcp_rtx_queue_empty_or_single_skb(sk))
-- 
2.43.0


