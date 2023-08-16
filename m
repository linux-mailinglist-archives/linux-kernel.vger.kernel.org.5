Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D881D77D8D6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241501AbjHPDHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241549AbjHPDHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:07:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D4FE6B;
        Tue, 15 Aug 2023 20:07:35 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQXz61nNpzNmsS;
        Wed, 16 Aug 2023 11:04:02 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 11:07:33 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: cppc: Add missing error pointer check
Date:   Wed, 16 Aug 2023 03:05:49 +0000
Message-ID: <20230816030549.849824-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.28]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function cppc_freq_invariance_init() may failed to create
kworker_fie, make it more robust by checking the return value to prevent
an invalid pointer dereference in kthread_destroy_worker(), which called
from cppc_freq_invariance_exit().

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 022e3555407c..4432398c8592 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -220,7 +220,7 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
 	}
 }
 
-static void __init cppc_freq_invariance_init(void)
+static int __init cppc_freq_invariance_init(void)
 {
 	struct sched_attr attr = {
 		.size		= sizeof(struct sched_attr),
@@ -246,19 +246,23 @@ static void __init cppc_freq_invariance_init(void)
 	}
 
 	if (fie_disabled)
-		return;
+		return 0;
 
 	kworker_fie = kthread_create_worker(0, "cppc_fie");
-	if (IS_ERR(kworker_fie))
-		return;
+	if (IS_ERR(kworker_fie)) {
+		ret = PTR_ERR(kworker_fie);
+		kworker_fie = NULL;
+		return ret;
+	}
 
 	ret = sched_setattr_nocheck(kworker_fie->task, &attr);
 	if (ret) {
 		pr_warn("%s: failed to set SCHED_DEADLINE: %d\n", __func__,
 			ret);
 		kthread_destroy_worker(kworker_fie);
-		return;
+		kworker_fie = NULL;
 	}
+	return ret;
 }
 
 static void cppc_freq_invariance_exit(void)
@@ -279,8 +283,9 @@ static inline void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
 {
 }
 
-static inline void cppc_freq_invariance_init(void)
+static inline int cppc_freq_invariance_init(void)
 {
+	return 0;
 }
 
 static inline void cppc_freq_invariance_exit(void)
@@ -969,7 +974,9 @@ static int __init cppc_cpufreq_init(void)
 		return -ENODEV;
 
 	cppc_check_hisi_workaround();
-	cppc_freq_invariance_init();
+	ret = cppc_freq_invariance_init();
+	if (ret < 0)
+		return ret;
 	populate_efficiency_class();
 
 	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
-- 
2.34.1

