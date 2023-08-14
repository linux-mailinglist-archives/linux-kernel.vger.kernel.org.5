Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC1677B591
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjHNJgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjHNJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:35:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32D3E6E;
        Mon, 14 Aug 2023 02:35:38 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692005737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YToMCb92pJGoOfpA0SlHlPlC7zvX3PytylQ9ib/oRb8=;
        b=hhON6qyLxkzadx3OgDCdCEk3q/iU1uDdEBlnPoeSIne+SH0WhHKe3S0hiuT4+YP8wAIeBM
        ZAqwONUF9iKEaMmQVQDAopslgcmiUhzG7c0a3AsBV8s5jIGH9p61KgHjBgyywKrfyNpvKt
        seP6v7JhR2/7HRRr+ab8M/t+V0pEZcbfGw5KSyPNam4faXZpqzmEZG8bwip0RacQWWjw3e
        FsBykOZCqhY2GCZ0gvsgQYP7EAX6+zjwIwibkQucKyQ04J5Bz9rYRehxxbgJWjwX+2FJuc
        5s+Q4WHieoxmvWlat384+GqFYwKjLDIR638xsiBxwZPR8CBuaasLs2jPjkldRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692005737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YToMCb92pJGoOfpA0SlHlPlC7zvX3PytylQ9ib/oRb8=;
        b=N2kJrKFhZozdMBAGb0O42Y1xG3za2UccA4n8H+D7fyizNvjiBlS77M6fhglaE6AiQdMGNC
        Xoe5rPttJZB2iECQ==
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH net-next 1/2] net: Use SMP threads for backlog NAPI.
Date:   Mon, 14 Aug 2023 11:35:27 +0200
Message-Id: <20230814093528.117342-2-bigeasy@linutronix.de>
In-Reply-To: <20230814093528.117342-1-bigeasy@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Backlog NAPI is a per-CPU NAPI struct only (with no device behind it)
used by drivers which don't do NAPI them self and RPS.
The non-NAPI driver use the CPU local backlog NAPI. If RPS is enabled
then a flow for the skb is computed and based on the flow the skb can be
enqueued on a remote CPU. Scheduling/ raising the softirq (for backlog's
NAPI) on the remote CPU isn't trivial because the softirq is only
scheduled on the local CPU and performed after the hardirq is done.
In order to schedule a softirq on the remote CPU, an IPI is sent to the
remote CPU which schedules the backlog-NAPI on the then local CPU.

On PREEMPT_RT interrupts are force-threaded. The soft interrupts are
raised within the interrupt thread and processed after the interrupt
handler completed still within the context of the interrupt thread. The
softirq is handled in the context where it originated.

With force-threaded interrupts enabled, ksoftirqd is woken up if a
softirq is raised from hardirq context. This is the case if it is raised
from an IPI. Additionally there is a warning on PREEMPT_RT if the
softirq is raised from the idle thread.
This was done for two reasons:
- With threaded interrupts the processing should happen in thread
  context (where it originated) and ksoftirqd is the only thread for
  this context if raised from hardirq. Using the currently running task
  instead would "punish" a random task.
- Once ksoftirqd is active it consumes all further softirqs until it
  stops running. This changed recently and is no longer the case.

Instead of keeping the backlog NAPI in ksoftirqd (in force-threaded/
PREEMPT_RT setups) I am proposing NAPI-threads for backlog.
The "proper" setup with threaded-NAPI is not doable because the threads
are not pinned to an individual CPU and can be modified by the user.
Additionally a dummy network device would have to be assigned. Also
CPU-hotplug has to be considered if additional CPUs show up.
All this can be probably done/ solved but the smpboot-threads already
provide this infrastructure.

Create NAPI-threads for backlog. The thread runs the inner loop from
napi_threaded_poll(), the wait part is different.
Since there are now per-CPU threads for backlog the remote IPI for
signaling is not needed and can be removed. The NAPI for backlog can
always be scheduled as it ends in waking the corresponding thread.
Since "deferred skb free" use a similar IPI mechanism for signaling, it
is also using the backlog threads.

This makes NAPI threads mandatory for backlog and it can not be
disabled. The other visibile part with RPS (or backlog usage in general)
is that it becomes now visible in `top' while earlier it would remain
unaccounted.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h |   8 --
 net/core/dev.c            | 226 +++++++++++++-------------------------
 net/core/net-procfs.c     |   2 +-
 net/core/skbuff.c         |   2 +-
 4 files changed, 79 insertions(+), 159 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 0896aaa91dd7b..17e31a68e725e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3190,9 +3190,6 @@ struct softnet_data {
 	/* stats */
 	unsigned int		processed;
 	unsigned int		time_squeeze;
-#ifdef CONFIG_RPS
-	struct softnet_data	*rps_ipi_list;
-#endif
=20
 	bool			in_net_rx_action;
 	bool			in_napi_threaded_poll;
@@ -3221,12 +3218,8 @@ struct softnet_data {
 	unsigned int		input_queue_head ____cacheline_aligned_in_smp;
=20
 	/* Elements below can be accessed between CPUs for RPS/RFS */
-	call_single_data_t	csd ____cacheline_aligned_in_smp;
-	struct softnet_data	*rps_ipi_next;
-	unsigned int		cpu;
 	unsigned int		input_queue_tail;
 #endif
-	unsigned int		received_rps;
 	unsigned int		dropped;
 	struct sk_buff_head	input_pkt_queue;
 	struct napi_struct	backlog;
@@ -3236,7 +3229,6 @@ struct softnet_data {
 	int			defer_count;
 	int			defer_ipi_scheduled;
 	struct sk_buff		*defer_list;
-	call_single_data_t	defer_csd;
 };
=20
 static inline void input_queue_head_incr(struct softnet_data *sd)
diff --git a/net/core/dev.c b/net/core/dev.c
index 636b41f0b32d6..40103238ac0a1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -153,6 +153,7 @@
 #include <linux/prandom.h>
 #include <linux/once_lite.h>
 #include <net/netdev_rx_queue.h>
+#include <linux/smpboot.h>
=20
 #include "dev.h"
 #include "net-sysfs.h"
@@ -4658,57 +4659,8 @@ bool rps_may_expire_flow(struct net_device *dev, u16=
 rxq_index,
 EXPORT_SYMBOL(rps_may_expire_flow);
=20
 #endif /* CONFIG_RFS_ACCEL */
-
-/* Called from hardirq (IPI) context */
-static void rps_trigger_softirq(void *data)
-{
-	struct softnet_data *sd =3D data;
-
-	____napi_schedule(sd, &sd->backlog);
-	sd->received_rps++;
-}
-
 #endif /* CONFIG_RPS */
=20
-/* Called from hardirq (IPI) context */
-static void trigger_rx_softirq(void *data)
-{
-	struct softnet_data *sd =3D data;
-
-	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
-	smp_store_release(&sd->defer_ipi_scheduled, 0);
-}
-
-/*
- * After we queued a packet into sd->input_pkt_queue,
- * we need to make sure this queue is serviced soon.
- *
- * - If this is another cpu queue, link it to our rps_ipi_list,
- *   and make sure we will process rps_ipi_list from net_rx_action().
- *
- * - If this is our own queue, NAPI schedule our backlog.
- *   Note that this also raises NET_RX_SOFTIRQ.
- */
-static void napi_schedule_rps(struct softnet_data *sd)
-{
-	struct softnet_data *mysd =3D this_cpu_ptr(&softnet_data);
-
-#ifdef CONFIG_RPS
-	if (sd !=3D mysd) {
-		sd->rps_ipi_next =3D mysd->rps_ipi_list;
-		mysd->rps_ipi_list =3D sd;
-
-		/* If not called from net_rx_action() or napi_threaded_poll()
-		 * we have to raise NET_RX_SOFTIRQ.
-		 */
-		if (!mysd->in_net_rx_action && !mysd->in_napi_threaded_poll)
-			__raise_softirq_irqoff(NET_RX_SOFTIRQ);
-		return;
-	}
-#endif /* CONFIG_RPS */
-	__napi_schedule_irqoff(&mysd->backlog);
-}
-
 #ifdef CONFIG_NET_FLOW_LIMIT
 int netdev_flow_limit_table_len __read_mostly =3D (1 << 12);
 #endif
@@ -4781,7 +4733,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, in=
t cpu,
 		 * We can use non atomic operation since we own the queue lock
 		 */
 		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
-			napi_schedule_rps(sd);
+			__napi_schedule_irqoff(&sd->backlog);
 		goto enqueue;
 	}
 	reason =3D SKB_DROP_REASON_CPU_BACKLOG;
@@ -5896,63 +5848,12 @@ static void flush_all_backlogs(void)
 	cpus_read_unlock();
 }
=20
-static void net_rps_send_ipi(struct softnet_data *remsd)
-{
-#ifdef CONFIG_RPS
-	while (remsd) {
-		struct softnet_data *next =3D remsd->rps_ipi_next;
-
-		if (cpu_online(remsd->cpu))
-			smp_call_function_single_async(remsd->cpu, &remsd->csd);
-		remsd =3D next;
-	}
-#endif
-}
-
-/*
- * net_rps_action_and_irq_enable sends any pending IPI's for rps.
- * Note: called with local irq disabled, but exits with local irq enabled.
- */
-static void net_rps_action_and_irq_enable(struct softnet_data *sd)
-{
-#ifdef CONFIG_RPS
-	struct softnet_data *remsd =3D sd->rps_ipi_list;
-
-	if (remsd) {
-		sd->rps_ipi_list =3D NULL;
-
-		local_irq_enable();
-
-		/* Send pending IPI's to kick RPS processing on remote cpus. */
-		net_rps_send_ipi(remsd);
-	} else
-#endif
-		local_irq_enable();
-}
-
-static bool sd_has_rps_ipi_waiting(struct softnet_data *sd)
-{
-#ifdef CONFIG_RPS
-	return sd->rps_ipi_list !=3D NULL;
-#else
-	return false;
-#endif
-}
-
 static int process_backlog(struct napi_struct *napi, int quota)
 {
 	struct softnet_data *sd =3D container_of(napi, struct softnet_data, backl=
og);
 	bool again =3D true;
 	int work =3D 0;
=20
-	/* Check if we have pending ipi, its better to send them now,
-	 * not waiting net_rx_action() end.
-	 */
-	if (sd_has_rps_ipi_waiting(sd)) {
-		local_irq_disable();
-		net_rps_action_and_irq_enable(sd);
-	}
-
 	napi->weight =3D READ_ONCE(dev_rx_weight);
 	while (again) {
 		struct sk_buff *skb;
@@ -5977,7 +5878,7 @@ static int process_backlog(struct napi_struct *napi, =
int quota)
 			 * We can use a plain write instead of clear_bit(),
 			 * and we dont need an smp_mb() memory barrier.
 			 */
-			napi->state =3D 0;
+			napi->state =3D BIT(NAPI_STATE_THREADED);
 			again =3D false;
 		} else {
 			skb_queue_splice_tail_init(&sd->input_pkt_queue,
@@ -6634,6 +6535,8 @@ static void skb_defer_free_flush(struct softnet_data =
*sd)
 	if (!READ_ONCE(sd->defer_list))
 		return;
=20
+	smp_store_release(&sd->defer_ipi_scheduled, 0);
+
 	spin_lock(&sd->defer_lock);
 	skb =3D sd->defer_list;
 	sd->defer_list =3D NULL;
@@ -6647,39 +6550,42 @@ static void skb_defer_free_flush(struct softnet_dat=
a *sd)
 	}
 }
=20
+static void napi_threaded_poll_loop(struct napi_struct *napi)
+{
+	struct softnet_data *sd;
+
+	for (;;) {
+		bool repoll =3D false;
+		void *have;
+
+		local_bh_disable();
+		sd =3D this_cpu_ptr(&softnet_data);
+		sd->in_napi_threaded_poll =3D true;
+
+		have =3D netpoll_poll_lock(napi);
+		__napi_poll(napi, &repoll);
+		netpoll_poll_unlock(have);
+
+		sd->in_napi_threaded_poll =3D false;
+		barrier();
+
+		skb_defer_free_flush(sd);
+		local_bh_enable();
+
+		if (!repoll)
+			break;
+
+		cond_resched();
+	}
+}
+
 static int napi_threaded_poll(void *data)
 {
 	struct napi_struct *napi =3D data;
-	struct softnet_data *sd;
-	void *have;
=20
 	while (!napi_thread_wait(napi)) {
-		for (;;) {
-			bool repoll =3D false;
=20
-			local_bh_disable();
-			sd =3D this_cpu_ptr(&softnet_data);
-			sd->in_napi_threaded_poll =3D true;
-
-			have =3D netpoll_poll_lock(napi);
-			__napi_poll(napi, &repoll);
-			netpoll_poll_unlock(have);
-
-			sd->in_napi_threaded_poll =3D false;
-			barrier();
-
-			if (sd_has_rps_ipi_waiting(sd)) {
-				local_irq_disable();
-				net_rps_action_and_irq_enable(sd);
-			}
-			skb_defer_free_flush(sd);
-			local_bh_enable();
-
-			if (!repoll)
-				break;
-
-			cond_resched();
-		}
+		napi_threaded_poll_loop(napi);
 	}
 	return 0;
 }
@@ -6714,8 +6620,6 @@ static __latent_entropy void net_rx_action(struct sof=
tirq_action *h)
 				 */
 				if (!list_empty(&sd->poll_list))
 					goto start;
-				if (!sd_has_rps_ipi_waiting(sd))
-					goto end;
 			}
 			break;
 		}
@@ -6744,8 +6648,7 @@ static __latent_entropy void net_rx_action(struct sof=
tirq_action *h)
 	else
 		sd->in_net_rx_action =3D false;
=20
-	net_rps_action_and_irq_enable(sd);
-end:;
+	local_irq_enable();
 }
=20
 struct netdev_adjacent {
@@ -11157,7 +11060,7 @@ static int dev_cpu_dead(unsigned int oldcpu)
 	struct sk_buff **list_skb;
 	struct sk_buff *skb;
 	unsigned int cpu;
-	struct softnet_data *sd, *oldsd, *remsd =3D NULL;
+	struct softnet_data *sd, *oldsd;
=20
 	local_irq_disable();
 	cpu =3D smp_processor_id();
@@ -11189,22 +11092,13 @@ static int dev_cpu_dead(unsigned int oldcpu)
 							    poll_list);
=20
 		list_del_init(&napi->poll_list);
-		if (napi->poll =3D=3D process_backlog)
-			napi->state =3D 0;
-		else
+		if (!WARN_ON(napi->poll =3D=3D process_backlog))
 			____napi_schedule(sd, napi);
 	}
=20
 	raise_softirq_irqoff(NET_TX_SOFTIRQ);
 	local_irq_enable();
=20
-#ifdef CONFIG_RPS
-	remsd =3D oldsd->rps_ipi_list;
-	oldsd->rps_ipi_list =3D NULL;
-#endif
-	/* send out pending IPI's on offline CPU */
-	net_rps_send_ipi(remsd);
-
 	/* Process offline CPU's input_pkt_queue */
 	while ((skb =3D __skb_dequeue(&oldsd->process_queue))) {
 		netif_rx(skb);
@@ -11457,6 +11351,43 @@ static struct pernet_operations __net_initdata def=
ault_device_ops =3D {
  *
  */
=20
+static DEFINE_PER_CPU(struct task_struct *, backlog_napi);
+
+static int backlog_napi_should_run(unsigned int cpu)
+{
+	struct softnet_data *sd =3D per_cpu_ptr(&softnet_data, cpu);
+	struct napi_struct *napi =3D &sd->backlog;
+
+	if (READ_ONCE(sd->defer_list))
+		return 1;
+
+	return test_bit(NAPI_STATE_SCHED, &napi->state);
+}
+
+static void run_backlog_napi(unsigned int cpu)
+{
+	struct softnet_data *sd =3D per_cpu_ptr(&softnet_data, cpu);
+
+	napi_threaded_poll_loop(&sd->backlog);
+}
+
+static void backlog_napi_setup(unsigned int cpu)
+{
+	struct softnet_data *sd =3D per_cpu_ptr(&softnet_data, cpu);
+	struct napi_struct *napi =3D &sd->backlog;
+
+	napi->thread =3D this_cpu_read(backlog_napi);
+	set_bit(NAPI_STATE_THREADED, &napi->state);
+}
+
+static struct smp_hotplug_thread backlog_threads =3D {
+	.store                  =3D &backlog_napi,
+	.thread_should_run      =3D backlog_napi_should_run,
+	.thread_fn              =3D run_backlog_napi,
+	.thread_comm            =3D "backlog_napi/%u",
+	.setup			=3D backlog_napi_setup,
+};
+
 /*
  *       This is called single threaded during boot, so no need
  *       to take the rtnl semaphore.
@@ -11497,17 +11428,14 @@ static int __init net_dev_init(void)
 #endif
 		INIT_LIST_HEAD(&sd->poll_list);
 		sd->output_queue_tailp =3D &sd->output_queue;
-#ifdef CONFIG_RPS
-		INIT_CSD(&sd->csd, rps_trigger_softirq, sd);
-		sd->cpu =3D i;
-#endif
-		INIT_CSD(&sd->defer_csd, trigger_rx_softirq, sd);
 		spin_lock_init(&sd->defer_lock);
=20
 		init_gro_hash(&sd->backlog);
 		sd->backlog.poll =3D process_backlog;
 		sd->backlog.weight =3D weight_p;
+		INIT_LIST_HEAD(&sd->backlog.poll_list);
 	}
+	smpboot_register_percpu_thread(&backlog_threads);
=20
 	dev_boot_phase =3D 0;
=20
diff --git a/net/core/net-procfs.c b/net/core/net-procfs.c
index 09f7ed1a04e8a..086283cc8d47b 100644
--- a/net/core/net-procfs.c
+++ b/net/core/net-procfs.c
@@ -180,7 +180,7 @@ static int softnet_seq_show(struct seq_file *seq, void =
*v)
 		   sd->processed, sd->dropped, sd->time_squeeze, 0,
 		   0, 0, 0, 0, /* was fastroute */
 		   0,	/* was cpu_collision */
-		   sd->received_rps, flow_limit_count,
+		   0 /* was received_rps */, flow_limit_count,
 		   input_qlen + process_qlen, (int)seq->index,
 		   input_qlen, process_qlen);
 	return 0;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 33fdf04d4334d..265a8aa6b3228 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6802,7 +6802,7 @@ nodefer:	__kfree_skb(skb);
 	 * if we are unlucky enough (this seems very unlikely).
 	 */
 	if (unlikely(kick) && !cmpxchg(&sd->defer_ipi_scheduled, 0, 1))
-		smp_call_function_single_async(cpu, &sd->defer_csd);
+		__napi_schedule(&sd->backlog);
 }
=20
 static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
--=20
2.40.1

