Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127507FEC0E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjK3JmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjK3JmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:42:00 -0500
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 03E1BD4A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:42:05 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id D6D701898505CF;
        Thu, 30 Nov 2023 17:41:59 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 30 Nov 2023 17:41:59 +0800
Date:   Thu, 30 Nov 2023 17:41:47 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   tiozhang <tiozhang@didiglobal.com>
To:     <rostedt@goodmis.org>, <bigeasy@linutronix.de>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <zyhtheonly@gmail.com>, <tiozhang@didiglobal.com>,
        <zyhtheonly@yeah.net>
Subject: [PATCH v2] sched/cputime: exclude ktimers threads in
 irqtime_account_irq
Message-ID: <20231130094130.GA12116@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: rostedt@goodmis.org, bigeasy@linutronix.de,
        tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, zyhtheonly@gmail.com, zyhtheonly@yeah.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231127130754.3affb908@gandalf.local.home>
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
so when accounting CPUTIME_SOFTIRQ, ktimers need to be excluded
as well as ksoftirqd.
Also add this_cpu_ktimers to keep consistency with this_cpu_ksoftirqd.

Signed-off-by: tiozhang <tiozhang@didiglobal.com>
---
 include/linux/interrupt.h | 5 +++++
 kernel/sched/cputime.c    | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

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
index af7952f12e6c..fd3610353e12 100644
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
 
-- 
2.17.1

