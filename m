Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EDC77D815
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241179AbjHPCBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241160AbjHPCAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:00:40 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849AA10EC;
        Tue, 15 Aug 2023 19:00:39 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RQWXP3fn1z1GDLH;
        Wed, 16 Aug 2023 09:59:17 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 10:00:36 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: Use clamp helper macro to improve the code readability
Date:   Wed, 16 Aug 2023 01:58:53 +0000
Message-ID: <20230816015853.849426-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.28]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The valid values of policy.{min, max} should be between 'min' and 'max',
so use clamp() helper macro to makes cpufreq_verify_within_limits() more
readable.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 include/linux/cpufreq.h | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 99da27466b8f..43b363a99215 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -19,6 +19,7 @@
 #include <linux/pm_qos.h>
 #include <linux/spinlock.h>
 #include <linux/sysfs.h>
+#include <linux/minmax.h>
 
 /*********************************************************************
  *                        CPUFREQ INTERFACE                          *
@@ -467,17 +468,8 @@ static inline void cpufreq_verify_within_limits(struct cpufreq_policy_data *poli
 						unsigned int min,
 						unsigned int max)
 {
-	if (policy->min < min)
-		policy->min = min;
-	if (policy->max < min)
-		policy->max = min;
-	if (policy->min > max)
-		policy->min = max;
-	if (policy->max > max)
-		policy->max = max;
-	if (policy->min > policy->max)
-		policy->min = policy->max;
-	return;
+	policy->max = clamp(policy->max, min, max);
+	policy->min = clamp(policy->min, min, policy->max);
 }
 
 static inline void
-- 
2.34.1

