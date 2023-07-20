Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FE775AA39
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGTI6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjGTIe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:34:29 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7554A268F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:34:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=kenan.liu@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VnpHxpT_1689842064;
Received: from iZbp125ew08a9bxe5bn4s4Z.localdomain(mailfrom:Kenan.Liu@linux.alibaba.com fp:SMTPD_---0VnpHxpT_1689842064)
          by smtp.aliyun-inc.com;
          Thu, 20 Jul 2023 16:34:24 +0800
From:   "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     luoben@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] sched/fair: Export a param to control the traverse len when select idle cpu.
Date:   Thu, 20 Jul 2023 16:34:13 +0800
Message-Id: <1689842053-5291-3-git-send-email-Kenan.Liu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1689842053-5291-1-git-send-email-Kenan.Liu@linux.alibaba.com>
References: <1689842053-5291-1-git-send-email-Kenan.Liu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kenan.Liu" <Kenan.Liu@linux.alibaba.com>

The variable 'nr' decides the length of traverse when we try to find an
idle cpu in function select_idle_cpu(). A fixed value such as 4 may not
perform well in all scenes and may lead to un-acceptable overhead. Export
two sysctl parameters to enable adjustments.

Signed-off-by: Kenan.Liu <Kenan.Liu@linux.alibaba.com>
Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
---
 kernel/sched/fair.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ad7c93f..e10de3b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -125,6 +125,9 @@
 static unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
+unsigned int __read_mostly sysctl_sched_idle_search_nr_default = 4;
+unsigned int __read_mostly sysctl_sched_idle_search_nr_threshold = 4;
+
 static bool smt_neighbour_topo;
 static bool core_smt_topo_detect;
 static unsigned int smt_nr_cpu = 2;
@@ -207,6 +210,50 @@ int __weak arch_asym_cpu_priority(int cpu)
 #endif
 
 #ifdef CONFIG_SYSCTL
+static int sched_set_idle_search_nr_default(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos)
+{
+	static DEFINE_MUTEX(mutex);
+	unsigned int old_nr;
+	int ret;
+
+	mutex_lock(&mutex);
+	old_nr = sysctl_sched_idle_search_nr_default;
+	ret = proc_douintvec(table, write, buffer, lenp, ppos);
+	if (!ret && write) {
+		if (sysctl_sched_idle_search_nr_default == 0) {
+			sysctl_sched_idle_search_nr_default = old_nr;
+			mutex_unlock(&mutex);
+			return -EINVAL;
+		}
+	}
+
+	mutex_unlock(&mutex);
+	return ret;
+}
+
+static int sched_set_idle_search_nr_threshold(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos)
+{
+	static DEFINE_MUTEX(mutex);
+	unsigned int old_threshold;
+	int ret;
+
+	mutex_lock(&mutex);
+	old_threshold = sysctl_sched_idle_search_nr_threshold;
+	ret = proc_douintvec(table, write, buffer, lenp, ppos);
+	if (!ret && write) {
+		if (sysctl_sched_idle_search_nr_threshold == 0) {
+			sysctl_sched_idle_search_nr_threshold = old_threshold;
+			mutex_unlock(&mutex);
+			return -EINVAL;
+		}
+	}
+
+	mutex_unlock(&mutex);
+	return ret;
+}
+
 static struct ctl_table sched_fair_sysctls[] = {
 	{
 		.procname       = "sched_child_runs_first",
@@ -235,6 +282,20 @@ int __weak arch_asym_cpu_priority(int cpu)
 		.extra1		= SYSCTL_ZERO,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
+	{
+		.procname	= "sched_cfs_idle_search_nr_default",
+		.data		= &sysctl_sched_idle_search_nr_default,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sched_set_idle_search_nr_default,
+	},
+	{
+		.procname	= "sched_cfs_idle_search_nr_threshold",
+		.data		= &sysctl_sched_idle_search_nr_threshold,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= sched_set_idle_search_nr_threshold,
+	},
 	{}
 };
 
@@ -7027,10 +7088,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		avg_cost = this_sd->avg_scan_cost + 1;
 
 		span_avg = sd->span_weight * avg_idle;
-		if (span_avg > 4*avg_cost)
+		if (span_avg > sysctl_sched_idle_search_nr_threshold * avg_cost)
 			nr = div_u64(span_avg, avg_cost);
 		else
-			nr = 4;
+			nr = sysctl_sched_idle_search_nr_default;
 
 		time = cpu_clock(this);
 	}
-- 
1.8.3.1

