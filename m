Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5227F7B37D2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjI2QVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjI2QVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:21:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F43C199;
        Fri, 29 Sep 2023 09:21:30 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696004488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oH1uS+2V/Ibq2G2ithVQNTHtD9Fj/zibRpTz9llRJ9E=;
        b=miX5aQ2DbHHNMXI6G2+FgwDxi24Mm+sYKhCcD65i36jFqFi1PHRlpY13PXOEAHgFezrPeD
        FPLp6cXPihqtJhJ3V6imspB9zgZA2T6V2jJcKTx81tgDsMYQMFpfdmiPNz8Q8v8qGPD1rc
        r8wqAlG+L0ZHjSE5Ef8J/Ko3mqi1pXYK02AZyGiDEGs3J3ecGaO2Ukcl9yEvxF5fzOcZn5
        P4PXvhFHatwGAkQI3QSd8fc5rHCay+OUopZ4hOIUDQA4poLiLmjdMShwaiG1YlMhtFIyEP
        vSvx3fdXFr93w1iRhjBcpqBvDj3gZuMECUX0lRTYs+jm+D5MngnNlde0syKXbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696004488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oH1uS+2V/Ibq2G2ithVQNTHtD9Fj/zibRpTz9llRJ9E=;
        b=eilRes0Gotk/U2IRQpQlhlTA7EjtupTl6tXNbLCHNtNSFQ1YXQ7edDCIgqARpN1DxpSaO2
        OGqczZ5S0LTCfeBQ==
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <hawk@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 2/2] net: Allow to use SMP threads for backlog NAPI.
Date:   Fri, 29 Sep 2023 18:20:20 +0200
Message-ID: <20230929162121.1822900-3-bigeasy@linutronix.de>
In-Reply-To: <20230929162121.1822900-1-bigeasy@linutronix.de>
References: <20230929162121.1822900-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Backlog NAPI is a per-CPU NAPI struct only (with no device behind it)
used by drivers which don't do NAPI them self, RPS and parts of the
stack which need to avoid recursive deadlocks while processing a packet.

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

Sending UDP packets over loopback expects that the packet is processed
within the call. Delaying it by handing it over to the thread hurts
performance. It is not beneficial to the outcome if the context switch
happens immediately after enqueue or after a while to process a few
packets in a batch.
There is no need to always use the thread if the backlog NAPI is
requested on the local CPU. This restores the loopback throuput. The
performance drops mostly to the same value after enabling RPS on the
loopback comparing the IPI and the tread result.

Create NAPI-threads for backlog if request during boot. The thread runs
the inner loop from napi_threaded_poll(), the wait part is different. It
checks for NAPI_STATE_SCHED (the backlog NAPI can not be disabled).
Since there are now per-CPU threads for backlog the remote IPI for
signaling is not needed and can be removed. The NAPI for backlog can
always be scheduled as it ends in waking the corresponding thread.
Add a shortcut to ____napi_schedule() to use local poll_list (instead of
the thread) if backlog is requested for the local CPU.
Since "deferred skb free" use a similar IPI mechanism for signaling, it
is also using the backlog threads.

This makes NAPI threads for backlog optional, it has to be enabled via
the boot argument "thread_backlog_napi". It is mandatory for PREEMPT_RT
to avoid the wakeup of ksoftirqd from the IPI.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h |   1 +
 net/core/dev.c            | 173 ++++++++++++++++++++++++++++++--------
 net/core/skbuff.c         |   4 +-
 3 files changed, 139 insertions(+), 39 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7e520c14eb8c6..bcaa967b8ddf9 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3288,6 +3288,7 @@ static inline void dev_xmit_recursion_dec(void)
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
=20
+void net_trigger_defer_list_processing(unsigned int cpu);
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
=20
diff --git a/net/core/dev.c b/net/core/dev.c
index 606a366cc2095..ec319e5dcb086 100644
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
@@ -4409,6 +4410,46 @@ EXPORT_SYMBOL(__dev_direct_xmit);
 /*************************************************************************
  *			Receiver routines
  *************************************************************************/
+static DEFINE_PER_CPU(struct task_struct *, backlog_napi);
+
+#ifndef CONFIG_PREEMPT_RT
+
+static DEFINE_STATIC_KEY_FALSE(use_backlog_threads_key);
+
+static int __init setup_backlog_napi_threads(char *arg)
+{
+	static_branch_enable(&use_backlog_threads_key);
+	return 0;
+}
+early_param("thread_backlog_napi", setup_backlog_napi_threads);
+
+static bool use_backlog_threads(void)
+{
+	return static_branch_unlikely(&use_backlog_threads_key);
+}
+
+#else
+
+static bool use_backlog_threads(void)
+{
+	return true;
+}
+
+#endif
+
+void net_trigger_defer_list_processing(unsigned int cpu)
+{
+	struct softnet_data *sd;
+
+	sd =3D &per_cpu(softnet_data, cpu);
+	if (use_backlog_threads()) {
+		__napi_schedule(&sd->backlog);
+		return;
+	}
+
+	if (!cmpxchg(&sd->defer_ipi_scheduled, 0, 1))
+		smp_call_function_single_async(cpu, &sd->defer_csd);
+}
=20
 int netdev_max_backlog __read_mostly =3D 1000;
 EXPORT_SYMBOL(netdev_max_backlog);
@@ -4441,6 +4482,9 @@ static inline void ____napi_schedule(struct softnet_d=
ata *sd,
 		 */
 		thread =3D READ_ONCE(napi->thread);
 		if (thread) {
+			if (use_backlog_threads() && thread =3D=3D raw_cpu_read(backlog_napi))
+				goto use_local_napi;
+
 			/* Avoid doing set_bit() if the thread is in
 			 * INTERRUPTIBLE state, cause napi_thread_wait()
 			 * makes sure to proceed with napi polling
@@ -4453,6 +4497,7 @@ static inline void ____napi_schedule(struct softnet_d=
ata *sd,
 		}
 	}
=20
+use_local_napi:
 	list_add_tail(&napi->poll_list, &sd->poll_list);
 	WRITE_ONCE(napi->list_owner, smp_processor_id());
 	/* If not called from net_rx_action()
@@ -4696,6 +4741,10 @@ static void napi_schedule_rps(struct softnet_data *s=
d)
 {
 	struct softnet_data *mysd =3D this_cpu_ptr(&softnet_data);
=20
+	if (use_backlog_threads()) {
+		__napi_schedule_irqoff(&sd->backlog);
+		return;
+	}
 #ifdef CONFIG_RPS
 	if (sd !=3D mysd) {
 		sd->rps_ipi_next =3D mysd->rps_ipi_list;
@@ -5921,7 +5970,7 @@ static void net_rps_action_and_irq_enable(struct soft=
net_data *sd)
 #ifdef CONFIG_RPS
 	struct softnet_data *remsd =3D sd->rps_ipi_list;
=20
-	if (remsd) {
+	if (!use_backlog_threads() && remsd) {
 		sd->rps_ipi_list =3D NULL;
=20
 		local_irq_enable();
@@ -5936,7 +5985,7 @@ static void net_rps_action_and_irq_enable(struct soft=
net_data *sd)
 static bool sd_has_rps_ipi_waiting(struct softnet_data *sd)
 {
 #ifdef CONFIG_RPS
-	return sd->rps_ipi_list !=3D NULL;
+	return !use_backlog_threads() && sd->rps_ipi_list !=3D NULL;
 #else
 	return false;
 #endif
@@ -5980,7 +6029,7 @@ static int process_backlog(struct napi_struct *napi, =
int quota)
 			 * We can use a plain write instead of clear_bit(),
 			 * and we dont need an smp_mb() memory barrier.
 			 */
-			napi->state =3D 0;
+			napi->state &=3D NAPIF_STATE_THREADED;
 			again =3D false;
 		} else {
 			skb_queue_splice_tail_init(&sd->input_pkt_queue,
@@ -6650,40 +6699,42 @@ static void skb_defer_free_flush(struct softnet_dat=
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
-	while (!napi_thread_wait(napi)) {
-		for (;;) {
-			bool repoll =3D false;
+	while (!napi_thread_wait(napi))
+		napi_threaded_poll_loop(napi);
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
-	}
 	return 0;
 }
=20
@@ -11220,7 +11271,7 @@ static int dev_cpu_dead(unsigned int oldcpu)
=20
 		list_del_init(&napi->poll_list);
 		if (napi->poll =3D=3D process_backlog)
-			napi->state =3D 0;
+			napi->state &=3D NAPIF_STATE_THREADED;
 		else
 			____napi_schedule(sd, napi);
 	}
@@ -11228,12 +11279,14 @@ static int dev_cpu_dead(unsigned int oldcpu)
 	raise_softirq_irqoff(NET_TX_SOFTIRQ);
 	local_irq_enable();
=20
+	if (!use_backlog_threads()) {
 #ifdef CONFIG_RPS
-	remsd =3D oldsd->rps_ipi_list;
-	oldsd->rps_ipi_list =3D NULL;
+		remsd =3D oldsd->rps_ipi_list;
+		oldsd->rps_ipi_list =3D NULL;
 #endif
-	/* send out pending IPI's on offline CPU */
-	net_rps_send_ipi(remsd);
+		/* send out pending IPI's on offline CPU */
+		net_rps_send_ipi(remsd);
+	}
=20
 	/* Process offline CPU's input_pkt_queue */
 	while ((skb =3D __skb_dequeue(&oldsd->process_queue))) {
@@ -11487,6 +11540,49 @@ static struct pernet_operations __net_initdata def=
ault_device_ops =3D {
  *
  */
=20
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
+static void backlog_napi_park(unsigned int cpu)
+{
+	struct softnet_data *sd =3D per_cpu_ptr(&softnet_data, cpu);
+
+	skb_defer_free_flush(sd);
+}
+
+static struct smp_hotplug_thread backlog_threads =3D {
+	.store			=3D &backlog_napi,
+	.thread_should_run	=3D backlog_napi_should_run,
+	.thread_fn		=3D run_backlog_napi,
+	.thread_comm		=3D "backlog_napi/%u",
+	.setup			=3D backlog_napi_setup,
+	.park			=3D backlog_napi_park,
+};
+
 /*
  *       This is called single threaded during boot, so no need
  *       to take the rtnl semaphore.
@@ -11537,7 +11633,10 @@ static int __init net_dev_init(void)
 		init_gro_hash(&sd->backlog);
 		sd->backlog.poll =3D process_backlog;
 		sd->backlog.weight =3D weight_p;
+		INIT_LIST_HEAD(&sd->backlog.poll_list);
 	}
+	if (use_backlog_threads())
+		smpboot_register_percpu_thread(&backlog_threads);
=20
 	dev_boot_phase =3D 0;
=20
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 2198979470ecf..30cdb008dd65c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6844,8 +6844,8 @@ nodefer:	__kfree_skb(skb);
 	/* Make sure to trigger NET_RX_SOFTIRQ on the remote CPU
 	 * if we are unlucky enough (this seems very unlikely).
 	 */
-	if (unlikely(kick) && !cmpxchg(&sd->defer_ipi_scheduled, 0, 1))
-		smp_call_function_single_async(cpu, &sd->defer_csd);
+	if (unlikely(kick))
+		net_trigger_defer_list_processing(cpu);
 }
=20
 static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
--=20
2.42.0

