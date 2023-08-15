Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7030177C52F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 03:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjHOBlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 21:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjHOBkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 21:40:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692EE7;
        Mon, 14 Aug 2023 18:40:41 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPv7s0MXlzrSNL;
        Tue, 15 Aug 2023 09:39:21 +0800 (CST)
Received: from huawei.com (10.67.174.53) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 09:40:39 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] cpufreq: cppc: cppc_cpufreq_get_rate() returns zero in all error cases.
Date:   Tue, 15 Aug 2023 09:40:17 +0800
Message-ID: <20230815014018.4132350-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.53]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

The cpufreq framework used to use the zero of return value to reflect
the cppc_cpufreq_get_rate() had failed to get current frequecy and treat
all positive integer to be succeed. Since cppc_get_perf_ctrs() returns a
negative integer in error case, so it is better to convert the value to
zero as the return value of cppc_cpufreq_get_rate().

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 4 ++--
 include/linux/cpufreq.h        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 796bc3e19f77..1cdef2da1ea4 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -854,13 +854,13 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 
 	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
 	if (ret)
-		return ret;
+		return 0;
 
 	udelay(2); /* 2usec delay between sampling */
 
 	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
 	if (ret)
-		return ret;
+		return 0;
 
 	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
 					       &fb_ctrs_t1);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 172ff51c1b2a..99da27466b8f 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -370,7 +370,7 @@ struct cpufreq_driver {
 	int		(*target_intermediate)(struct cpufreq_policy *policy,
 					       unsigned int index);
 
-	/* should be defined, if possible */
+	/* should be defined, if possible, return 0 on error */
 	unsigned int	(*get)(unsigned int cpu);
 
 	/* Called to update policy limits on firmware notifications. */
-- 
2.25.1

