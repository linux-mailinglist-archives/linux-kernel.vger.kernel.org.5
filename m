Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366A077C52D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjHOBka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjHOBk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:40:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608EEE7;
        Mon, 14 Aug 2023 18:40:27 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPv4y18s7ztRyh;
        Tue, 15 Aug 2023 09:36:50 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 09:40:25 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] cpufreq: Prefer to print cpuid in MIN/MAX QoS register error message
Date:   Tue, 15 Aug 2023 09:40:02 +0800
Message-ID: <20230815014002.4132226-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a cpufreq_policy is allocated, the cpus, related_cpus and real_cpus
of policy are still unset. Therefore, it is preferable to print the
passed 'cpu' parameter instead of a empty 'cpus' cpumask in error
message when registering MIN/MAX QoS notifier fails.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 50bbc969ffe5..a757f90aa9d6 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1234,16 +1234,16 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	ret = freq_qos_add_notifier(&policy->constraints, FREQ_QOS_MIN,
 				    &policy->nb_min);
 	if (ret) {
-		dev_err(dev, "Failed to register MIN QoS notifier: %d (%*pbl)\n",
-			ret, cpumask_pr_args(policy->cpus));
+		dev_err(dev, "Failed to register MIN QoS notifier: %d (CPU%u)\n",
+			ret, cpu);
 		goto err_kobj_remove;
 	}
 
 	ret = freq_qos_add_notifier(&policy->constraints, FREQ_QOS_MAX,
 				    &policy->nb_max);
 	if (ret) {
-		dev_err(dev, "Failed to register MAX QoS notifier: %d (%*pbl)\n",
-			ret, cpumask_pr_args(policy->cpus));
+		dev_err(dev, "Failed to register MAX QoS notifier: %d (CPU%u)\n",
+			ret, cpu);
 		goto err_min_qos_notifier;
 	}
 
-- 
2.25.1

