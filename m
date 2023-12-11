Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E15680C8EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 13:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjLKMDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 07:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjLKMCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 07:02:52 -0500
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id DFD17130
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 04:02:25 -0800 (PST)
Received: from mail.didiglobal.com (unknown [10.79.65.12])
        by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 39CD418E5212AF;
        Mon, 11 Dec 2023 20:02:20 +0800 (CST)
Received: from didi-ThinkCentre-M930t-N000 (10.79.64.101) by
 ZJY02-ACTMBX-02.didichuxing.com (10.79.65.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Dec 2023 20:02:19 +0800
Date:   Mon, 11 Dec 2023 20:02:09 +0800
X-MD-Sfrom: tiozhang@didiglobal.com
X-MD-SrcIP: 10.79.65.12
From:   Tio Zhang <tiozhang@didiglobal.com>
To:     <bigeasy@linutronix.de>, <rostedt@goodmis.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>,
        <zyhtheonly@gmail.com>, <tiozhang@didiglobal.com>,
        <zyhtheonly@yeah.net>
Subject: [PATCH v4] sched/cputime: account ksoftirqd's time on SYSTEM in
 PREEMPT_RT
Message-ID: <20231211120209.GA25877@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: bigeasy@linutronix.de, rostedt@goodmis.org,
        tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, zyhtheonly@gmail.com, zyhtheonly@yeah.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231208092616.LcwLlOyE@linutronix.de>
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

In PREEMPT_RT kernel, we dont want ksoftirqd's time accounting on SOFTIRQ
since it is available to the scheduler (while it is unpreemptable in
mainline). So we put it into SYSTEM like any other task running in SYSTEM.
With this patch, when ksoftirqd is taking CPU's time, we observe SYSTEM
in /proc/stat would be bigger than before while SOFTIRQ would be less,
which behaves in contract to mainline, but more suitable for PREEMPT_RT.

Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
---
 kernel/sched/cputime.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..6685bb46805d 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -73,7 +73,8 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
 	 */
 	if (pc & HARDIRQ_MASK)
 		irqtime_account_delta(irqtime, delta, CPUTIME_IRQ);
-	else if ((pc & SOFTIRQ_OFFSET) && curr != this_cpu_ksoftirqd())
+	else if ((pc & SOFTIRQ_OFFSET) &&
+		 (IS_ENABLED(CONFIG_PREEMPT_RT) || curr != this_cpu_ksoftirqd()))
 		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
 }
 
@@ -391,7 +392,7 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 
 	cputime -= other;
 
-	if (this_cpu_ksoftirqd() == p) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && this_cpu_ksoftirqd() == p) {
 		/*
 		 * ksoftirqd time do not get accounted in cpu_softirq_time.
 		 * So, we have to handle it separately here.
-- 
2.17.1

