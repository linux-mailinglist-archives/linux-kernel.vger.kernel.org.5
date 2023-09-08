Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1817980E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 05:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241528AbjIHDS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 23:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjIHDS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 23:18:28 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB521BD9;
        Thu,  7 Sep 2023 20:18:22 -0700 (PDT)
Received: from kwepemd200002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rhh6f5jffzGprF;
        Fri,  8 Sep 2023 11:14:34 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200002.china.huawei.com
 (7.221.188.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.23; Fri, 8 Sep
 2023 11:18:15 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: schedutil: Merge initialization code of sg_cpu in single loop
Date:   Fri, 8 Sep 2023 03:16:04 +0000
Message-ID: <20230908031604.2262422-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.28]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200002.china.huawei.com (7.221.188.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initialization code of the per-cpu sg_cpu struct is currently split
into two for-loop blocks. This can be simplified by merging the two
blocks into a single loop. This will make the code more maintainable.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 kernel/sched/cpufreq_schedutil.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4492608b7d7f..f3a95def49cc 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -767,14 +767,6 @@ static int sugov_start(struct cpufreq_policy *policy)
 
 	sg_policy->need_freq_update = cpufreq_driver_test_flags(CPUFREQ_NEED_UPDATE_LIMITS);
 
-	for_each_cpu(cpu, policy->cpus) {
-		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
-
-		memset(sg_cpu, 0, sizeof(*sg_cpu));
-		sg_cpu->cpu			= cpu;
-		sg_cpu->sg_policy		= sg_policy;
-	}
-
 	if (policy_is_shared(policy))
 		uu = sugov_update_shared;
 	else if (policy->fast_switch_enabled && cpufreq_driver_has_adjust_perf())
@@ -785,6 +777,9 @@ static int sugov_start(struct cpufreq_policy *policy)
 	for_each_cpu(cpu, policy->cpus) {
 		struct sugov_cpu *sg_cpu = &per_cpu(sugov_cpu, cpu);
 
+		memset(sg_cpu, 0, sizeof(*sg_cpu));
+		sg_cpu->cpu = cpu;
+		sg_cpu->sg_policy = sg_policy;
 		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util, uu);
 	}
 	return 0;
-- 
2.34.1

