Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8481813937
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbjLNR6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjLNR6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:58:03 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B78A6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yY5KuZVKWaXiPKW8THuGvJguIS1QJ2wAyKcO5bW1t1M=;
  b=AAiE2rEgrdU+tE6fwbJ917yjzfdxpcjx7sS4KIAtcpbj+E8enhGctNbk
   rKXaR9633eQVAFduks/72vLJfgB6bIMfAGaU31jmWXlF4Qusyj/bkzAIx
   YC7Bd/LxvzGjIoalBP8APur2oXQ1d77Xfme7J9O7vUGD0YpvE2XHO5Mo3
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=keisuke.nishimura@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,276,1695679200"; 
   d="scan'208";a="142377319"
Received: from dt-aponte.paris.inria.fr (HELO keisuke-XPS-13-7390.tailde312.ts.net) ([128.93.67.66])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 18:58:06 +0100
From:   Keisuke Nishimura <keisuke.nishimura@inria.fr>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Abel Wu <wuyun.abel@bytedance.com>, Josh Don <joshdon@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Xunlei Pang <xlpang@linux.alibaba.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        linux-kernel@vger.kernel.org,
        Keisuke Nishimura <keisuke.nishimura@inria.fr>
Subject: [PATCH 2/2] sched/fair: take into account scheduling domain in select_idle_core()
Date:   Thu, 14 Dec 2023 18:55:51 +0100
Message-Id: <20231214175551.629945-2-keisuke.nishimura@inria.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214175551.629945-1-keisuke.nishimura@inria.fr>
References: <20231214175551.629945-1-keisuke.nishimura@inria.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When picking out a CPU on a task wakeup, select_idle_smt() has to take
into account the scheduling domain where the function looks for the CPU.
This is because cpusets and isolcpus can remove CPUs from the domain
to isolate them from other SMT siblings.

This change replaces the set of CPUs allowed to run the task from
p->cpus_ptr by the intersection of p->cpus_ptr and sched_domain_span(sd)
which is stored in the cpus argument provided by select_idle_cpu.

Fixes: 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")
Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 71306b48cf68..3b7d32632674 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7262,7 +7262,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 		if (!available_idle_cpu(cpu)) {
 			idle = false;
 			if (*idle_cpu == -1) {
-				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, p->cpus_ptr)) {
+				if (sched_idle_cpu(cpu) && cpumask_test_cpu(cpu, cpus)) {
 					*idle_cpu = cpu;
 					break;
 				}
@@ -7270,7 +7270,7 @@ static int select_idle_core(struct task_struct *p, int core, struct cpumask *cpu
 			}
 			break;
 		}
-		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, p->cpus_ptr))
+		if (*idle_cpu == -1 && cpumask_test_cpu(cpu, cpus))
 			*idle_cpu = cpu;
 	}
 
-- 
2.34.1

