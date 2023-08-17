Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D11E77F179
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348608AbjHQHuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348646AbjHQHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:49:48 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E25D2D7B;
        Thu, 17 Aug 2023 00:49:44 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRHDg5yrXzrSqN;
        Thu, 17 Aug 2023 15:48:19 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 15:49:41 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] cpufreq: cppc: Set fie_disabled to FIE_DISABLED if fails to create kworker_fie
Date:   Thu, 17 Aug 2023 07:47:56 +0000
Message-ID: <20230817074756.883380-1-liaochang1@huawei.com>
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
kworker_fie, make it more robust by setting fie_disabled to FIE_DISBALED
to prevent an invalid pointer dereference in kthread_destroy_worker(),
which called from cppc_freq_invariance_exit().

v3:
Simplify cleanup code when invariance initialization fails.

v2:
Set fie_disabled to FIE_DISABLED when invariance initialization fails.

Link: https://lore.kernel.org/all/20230816034630.a4hvsj373q6aslk3@vireshk-i7/

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 022e3555407c..4d501f0bf55d 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -249,15 +249,19 @@ static void __init cppc_freq_invariance_init(void)
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
 		kthread_destroy_worker(kworker_fie);
-		return;
+		fie_disabled = FIE_DISABLED;
 	}
 }
 
@@ -267,7 +271,6 @@ static void cppc_freq_invariance_exit(void)
 		return;
 
 	kthread_destroy_worker(kworker_fie);
-	kworker_fie = NULL;
 }
 
 #else
-- 
2.34.1

