Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDDD80052A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjLAIFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjLAIFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:05:46 -0500
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 48594170B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 00:05:51 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id E5D5A1808BB6B4;
        Fri,  1 Dec 2023 16:05:49 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 1 Dec 2023 16:05:49 +0800
Date:   Fri, 1 Dec 2023 16:05:41 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   tiozhang <tiozhang@didiglobal.com>
To:     <bigeasy@linutronix.de>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <zyhtheonly@gmail.com>, <tiozhang@didiglobal.com>,
        <zyhtheonly@yeah.net>
Subject: [PATCH v3] sched/cputime: let ktimers align with ksoftirqd in
 accounting CPUTIME_SOFTIRQ
Message-ID: <20231201080522.GA31309@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: bigeasy@linutronix.de, tglx@linutronix.de,
        rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, zyhtheonly@gmail.com, zyhtheonly@yeah.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231201073240.T9bFNCkU@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.79.64.101]
X-ClientProxiedBy: ZJY01-PUBMBX-01.didichuxing.com (10.79.64.32) To
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In CONFIG_PREEMPT_RT kernel, ktimers also calls __do_softirq,
so when accounting CPUTIME_SOFTIRQ, ktimers need to be accounted the same
as ksoftirqd.

Signed-off-by: tiozhang <tiozhang@didiglobal.com>
---
 include/linux/interrupt.h | 5 +++++
 kernel/sched/cputime.c    | 6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a5091ac97fc6..a88646acaf3f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -621,6 +621,11 @@ static inline unsigned int local_pending_timers(void)
         return __this_cpu_read(pending_timer_softirq);
 }
 
+static inline struct task_struct *this_cpu_ktimers(void)
+{
+	return this_cpu_read(timersd);
+}
+
 #else
 static inline void raise_timer_softirq(void)
 {
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..2393c533314f 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -73,7 +73,8 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 	 */
 	if (pc & HARDIRQ_MASK)
 		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
-	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
+	else if (((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd() &&
+		  (!IS_ENABLED(CONFIG_PREEMPT_RT) || curr != this_cpu_ktimers()))
 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
 }
 
@@ -391,7 +392,8 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 
 	cputime -= other;
 
-	if (this_cpu_ksoftirqd() == p) {
+	if (this_cpu_ksoftirqd() == p ||
+	   (IS_ENABLED(CONFIG_PREEMPT_RT) && this_cpu_ktimers() == p)) {
 		/*
 		 * ksoftirqd time do not get accounted in cpu_softirq_time.
 		 * So, we have to handle it separately here.
-- 
2.17.1

