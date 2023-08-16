Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F153777DDE3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243627AbjHPJwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbjHPJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:51:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A638273B;
        Wed, 16 Aug 2023 02:51:24 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQjzZ0pwTz1GDHX;
        Wed, 16 Aug 2023 17:50:02 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 17:51:21 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] cpufreq: cppc: Set fie_disabled to FIE_DISABLED if fails to create kworker_fie
Date:   Wed, 16 Aug 2023 09:49:38 +0000
Message-ID: <20230816094938.862186-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.28]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function cppc_freq_invariance_init() may failed to create
kworker_fie, make it more robust by setting fie_disabled to FIE_DISBALED
to prevent an invalid pointer dereference in kthread_destroy_worker(),
which called from cppc_freq_invariance_exit().

Link: https://lore.kernel.org/all/20230816034630.a4hvsj373q6aslk3@vireshk-i7/

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 022e3555407c..bff4cde06083 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -220,6 +220,15 @@ static void cppc_cpufreq_cpu_fie_exit(struct cpufreq_policy *policy)
 	}
 }
 
+static void cppc_freq_invariance_exit(void)
+{
+	if (fie_disabled)
+		return;
+
+	kthread_destroy_worker(kworker_fie);
+	kworker_fie = NULL;
+}
+
 static void __init cppc_freq_invariance_init(void)
 {
 	struct sched_attr attr = {
@@ -249,27 +258,22 @@ static void __init cppc_freq_invariance_init(void)
 		return;
 
 	kworker_fie = kthread_create_worker(0, "cppc_fie");
-	if (IS_ERR(kworker_fie))
+	if (IS_ERR(kworker_fie)) {
+		pr_warn("%s: failed to create kworker_fie: %ld\n", __func__,
+			PTR_ERR(kworker_fie));
+		fie_disabled = FIE_DISABLED;
 		return;
+	}
 
 	ret = sched_setattr_nocheck(kworker_fie->task, &attr);
 	if (ret) {
 		pr_warn("%s: failed to set SCHED_DEADLINE: %d\n", __func__,
 			ret);
-		kthread_destroy_worker(kworker_fie);
-		return;
+		cppc_freq_invariance_exit();
+		fie_disabled = FIE_DISABLED;
 	}
 }
 
-static void cppc_freq_invariance_exit(void)
-{
-	if (fie_disabled)
-		return;
-
-	kthread_destroy_worker(kworker_fie);
-	kworker_fie = NULL;
-}
-
 #else
 static inline void cppc_cpufreq_cpu_fie_init(struct cpufreq_policy *policy)
 {
-- 
2.34.1

