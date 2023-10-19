Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315A87D056C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346740AbjJSXgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346719AbjJSXf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:35:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABF4116;
        Thu, 19 Oct 2023 16:35:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED987C433C8;
        Thu, 19 Oct 2023 23:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697758555;
        bh=R8Atha9x2t4vsEfcPTQzyYDg3f35Pt4dzxjw+9RuuTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azl/B57WvaINso+zwnxXnpDWX0/KZd66y8FLgQUWYslMcmU/gDUg6quWS5gzUkzF1
         8jpVePGUxs33EeZfn/Zqz2Tc6LaptodpzRZDkLfQHKFghF7c5SDSDLQ9TPDZwG4woT
         Rqo5umQPJjabpDf1E9qGrsVITEI2FppPm6Pdm5ln956GPsBUf8OfcDWC7mpoHt6V5I
         DoqR2dG9Mo2SIUGvPJ3SJmqmn9nWzMk447z0bzQhW8IBaxDsLnW5617/t0IixJg4Md
         ThI3J3pK6QvsGeA3v99ErEoqbeZiN9aZZhaiof26ZSbNuGcTO8violaIBOXYgvjROU
         zjrObKodXex7g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/4] softirq: Rename __raise_softirq_irqoff() to raise_softirq_no_wake()
Date:   Fri, 20 Oct 2023 01:35:40 +0200
Message-Id: <20231019233543.1243121-2-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019233543.1243121-1-frederic@kernel.org>
References: <20231019233543.1243121-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the purpose of this function clearer.

Fixes: cff9b2332ab7 ("kernel/sched: Modify initial boot task idle setup")
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Sebastian Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 block/blk-mq.c            | 2 +-
 include/linux/interrupt.h | 2 +-
 kernel/softirq.c          | 6 +++---
 lib/irq_poll.c            | 4 ++--
 net/core/dev.c            | 8 ++++----
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1fafd54dce3c..1bda40a2aa29 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1144,7 +1144,7 @@ static int blk_softirq_cpu_dead(unsigned int cpu)
 
 static void __blk_mq_complete_request_remote(void *data)
 {
-	__raise_softirq_irqoff(BLOCK_SOFTIRQ);
+	raise_softirq_no_wake(BLOCK_SOFTIRQ);
 }
 
 static inline bool blk_mq_complete_need_ipi(struct request *rq)
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 76121c2bb4f8..558a1a329da9 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -604,7 +604,7 @@ static inline void do_softirq_post_smp_call_flush(unsigned int unused)
 
 extern void open_softirq(int nr, void (*action)(struct softirq_action *));
 extern void softirq_init(void);
-extern void __raise_softirq_irqoff(unsigned int nr);
+extern void raise_softirq_no_wake(unsigned int nr);
 
 extern void raise_softirq_irqoff(unsigned int nr);
 extern void raise_softirq(unsigned int nr);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 210cf5f8d92c..acfed6f3701d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -664,7 +664,7 @@ void irq_exit(void)
  */
 inline void raise_softirq_irqoff(unsigned int nr)
 {
-	__raise_softirq_irqoff(nr);
+	raise_softirq_no_wake(nr);
 
 	/*
 	 * If we're in an interrupt or softirq, we're done
@@ -688,7 +688,7 @@ void raise_softirq(unsigned int nr)
 	local_irq_restore(flags);
 }
 
-void __raise_softirq_irqoff(unsigned int nr)
+void raise_softirq_no_wake(unsigned int nr)
 {
 	lockdep_assert_irqs_disabled();
 	trace_softirq_raise(nr);
@@ -795,7 +795,7 @@ static void tasklet_action_common(struct softirq_action *a,
 		t->next = NULL;
 		*tl_head->tail = t;
 		tl_head->tail = &t->next;
-		__raise_softirq_irqoff(softirq_nr);
+		raise_softirq_no_wake(softirq_nr);
 		local_irq_enable();
 	}
 }
diff --git a/lib/irq_poll.c b/lib/irq_poll.c
index 2d5329a42105..193cd847fd8f 100644
--- a/lib/irq_poll.c
+++ b/lib/irq_poll.c
@@ -130,7 +130,7 @@ static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
 	}
 
 	if (rearm)
-		__raise_softirq_irqoff(IRQ_POLL_SOFTIRQ);
+		raise_softirq_no_wake(IRQ_POLL_SOFTIRQ);
 
 	local_irq_enable();
 }
@@ -197,7 +197,7 @@ static int irq_poll_cpu_dead(unsigned int cpu)
 	local_irq_disable();
 	list_splice_init(&per_cpu(blk_cpu_iopoll, cpu),
 			 this_cpu_ptr(&blk_cpu_iopoll));
-	__raise_softirq_irqoff(IRQ_POLL_SOFTIRQ);
+	raise_softirq_no_wake(IRQ_POLL_SOFTIRQ);
 	local_irq_enable();
 	local_bh_enable();
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 85df22f05c38..6f4622cc8939 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4459,7 +4459,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 	 * we have to raise NET_RX_SOFTIRQ.
 	 */
 	if (!sd->in_net_rx_action)
-		__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+		raise_softirq_no_wake(NET_RX_SOFTIRQ);
 }
 
 #ifdef CONFIG_RPS
@@ -4678,7 +4678,7 @@ static void trigger_rx_softirq(void *data)
 {
 	struct softnet_data *sd = data;
 
-	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+	raise_softirq_no_wake(NET_RX_SOFTIRQ);
 	smp_store_release(&sd->defer_ipi_scheduled, 0);
 }
 
@@ -4705,7 +4705,7 @@ static void napi_schedule_rps(struct softnet_data *sd)
 		 * we have to raise NET_RX_SOFTIRQ.
 		 */
 		if (!mysd->in_net_rx_action && !mysd->in_napi_threaded_poll)
-			__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+			raise_softirq_no_wake(NET_RX_SOFTIRQ);
 		return;
 	}
 #endif /* CONFIG_RPS */
@@ -6743,7 +6743,7 @@ static __latent_entropy void net_rx_action(struct softirq_action *h)
 	list_splice_tail(&repoll, &list);
 	list_splice(&list, &sd->poll_list);
 	if (!list_empty(&sd->poll_list))
-		__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+		raise_softirq_no_wake(NET_RX_SOFTIRQ);
 	else
 		sd->in_net_rx_action = false;
 
-- 
2.34.1

