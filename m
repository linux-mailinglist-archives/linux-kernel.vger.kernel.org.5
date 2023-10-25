Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201EC7D6472
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjJYIES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234253AbjJYIEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:04:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1047B137;
        Wed, 25 Oct 2023 01:04:09 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SFhDH0G2YzNpYd;
        Wed, 25 Oct 2023 15:59:59 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 25 Oct
 2023 16:04:01 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <viresh.kumar@linaro.org>, <rafael@kernel.org>
CC:     <liwei391@huawei.com>, <linux-pm@vger.kernel.org>,
        <xiexiuqi@huawei.com>, <wangxiongfeng2@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cpufreq: userspace: Keep the current frequency when set userspace policy
Date:   Wed, 25 Oct 2023 16:09:10 +0800
Message-ID: <20231025080910.3245690-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching to the userspace policy, if the current frequency is within
the range of policy's min and max values, the current frequency value
should be remained. The .limit() function is called when changing governor
or updating governor limits, so in both cases, there is no need to update
frequency if the current frequency does not exceed the threshold.

Additionally, when changing to userspace governor, the default value of
set_speed is set by reading the current frequency of the CPU, but there
is inevitable error between the frequency coming from .get_rate() interface
and the actual working frequency. Consequently, when switching to userspace
policy, keeping the current frequency can avoid unexpected changes.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/cpufreq/cpufreq_userspace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index 2c42fee76daa..fe55a7bb663c 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -117,9 +117,7 @@ static void cpufreq_userspace_policy_limits(struct cpufreq_policy *policy)
 	else if (policy->min > userspace->setspeed)
 		__cpufreq_driver_target(policy, policy->min,
 					CPUFREQ_RELATION_L);
-	else
-		__cpufreq_driver_target(policy, userspace->setspeed,
-					CPUFREQ_RELATION_L);
+	/* Otherwise, keep the current frequency. */

 	mutex_unlock(&userspace->mutex);
 }
--
2.25.1

