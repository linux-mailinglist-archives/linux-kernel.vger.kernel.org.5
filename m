Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C2C75637B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjGQM4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGQM4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:56:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C645D10F0;
        Mon, 17 Jul 2023 05:56:13 -0700 (PDT)
Date:   Mon, 17 Jul 2023 12:56:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689598571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OMVl7qnJIHfWo+QJlDZyGzWC5ZejACaCmNuxIYmwiI4=;
        b=uFLCjlGHwCDB5nzkZsz/tdj+RefzcIkCn4Y2zxWtjHMAvzy0Ws1LCDGaQnCFOKLAi+tNCk
        HVLUwOb8W3XQzwTHIKjfl3AGOUaZjmlbtjuzkWLh3jui4ucVxkY+Vid/Dv1WhasQZRre1n
        04O+mHfrE4COkwOSIwBJ0UVSbxUjgL2G9X5++34BhbAZhQ5qw1UFbo1qmQGTNhNqY4spVw
        J697BYWMeSJqRawVC+xWbrsUNsGeBiBDS+q3xj7ADWbPQbW9QE/WpQF+Hf9SVM1xgqh9nR
        sZXMuoKD5SSqgRzZWAhp9tvM3gxHKSPU4FNhyP39z227TGnhx7b6BQzRIXiGMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689598571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OMVl7qnJIHfWo+QJlDZyGzWC5ZejACaCmNuxIYmwiI4=;
        b=5ghlVV2O3Xwh1C6Iu4ANX96jrQAI7YTVlxPhCySTKHNR/5b71CF00hd6vjijoNd/rez8Dw
        AY8aJdZy4dekGyBA==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Stabilize asym cpu capacity system idle
 cpu selection
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230711081359.868862-1-vincent.guittot@linaro.org>
References: <20230711081359.868862-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <168959857064.28540.16726800171848111975.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7ee7642c91410fb90cc45e799a3a46e1607ecd79
Gitweb:        https://git.kernel.org/tip/7ee7642c91410fb90cc45e799a3a46e1607ecd79
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 11 Jul 2023 10:13:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 13 Jul 2023 15:21:53 +02:00

sched/fair: Stabilize asym cpu capacity system idle cpu selection

select_idle_capacity() not only looks for an idle cpu that fits for the
waking task but also for cpu with highest bandwidth when no cpu fits.
Start the loop with target cpu so it will be selected 1st when no cpu fits
but several cpus shared the same bandwidth. Starting with target cpu
prevents the task to migrate between cpus with same bandwidth at every
wakeup when no cpu fits.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20230711081359.868862-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a879883..0cd1cdb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7096,7 +7096,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	util_min = uclamp_eff_value(p, UCLAMP_MIN);
 	util_max = uclamp_eff_value(p, UCLAMP_MAX);
 
-	for_each_cpu_wrap(cpu, cpus, target + 1) {
+	for_each_cpu_wrap(cpu, cpus, target) {
 		unsigned long cpu_cap = capacity_of(cpu);
 
 		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
