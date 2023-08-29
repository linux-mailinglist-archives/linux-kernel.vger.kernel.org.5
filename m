Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17EE78BEE9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjH2HER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjH2HDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:03:55 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F49DF;
        Tue, 29 Aug 2023 00:03:52 -0700 (PDT)
Received: from kwepemd100002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RZdd06tnbzVkJF;
        Tue, 29 Aug 2023 15:01:24 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd100002.china.huawei.com
 (7.221.188.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.23; Tue, 29 Aug
 2023 15:03:49 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] cpufreq: Avoid printing kernel addresses in cpufreq_resume()
Date:   Tue, 29 Aug 2023 07:01:50 +0000
Message-ID: <20230829070150.1217624-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.28]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100002.china.huawei.com (7.221.188.184)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer value of policy and driver structure are currently printed
in the error messages of cpufreq_resume(), this is not recommended and
helpful. In order to be consistent with the error message in
cpufreq_suspend() and easier to understand, print the name of driver
strcture and the manage CPU of policy structure individually in the
error messages of cpufreq_resume().

Link: https://lore.kernel.org/all/b7be717c-41d8-bbbf-3e97-3799948ab757@huawei.com
Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 drivers/cpufreq/cpufreq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 50bbc969ffe5..26fa99d46684 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1943,16 +1943,16 @@ void cpufreq_resume(void)
 
 	for_each_active_policy(policy) {
 		if (cpufreq_driver->resume && cpufreq_driver->resume(policy)) {
-			pr_err("%s: Failed to resume driver: %p\n", __func__,
-				policy);
+			pr_err("%s: Failed to resume driver: %s\n", __func__,
+				cpufreq_driver->name);
 		} else if (has_target()) {
 			down_write(&policy->rwsem);
 			ret = cpufreq_start_governor(policy);
 			up_write(&policy->rwsem);
 
 			if (ret)
-				pr_err("%s: Failed to start governor for policy: %p\n",
-				       __func__, policy);
+				pr_err("%s: Failed to start governor for CPU%u's policy\n",
+				       __func__, policy->cpu);
 		}
 	}
 }
-- 
2.34.1

