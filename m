Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E16C79C6B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjILGNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjILGNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:13:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285EBE77;
        Mon, 11 Sep 2023 23:13:16 -0700 (PDT)
Received: from kwepemd200002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RlCq00hj0zMlJ0;
        Tue, 12 Sep 2023 14:09:48 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200002.china.huawei.com
 (7.221.188.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.23; Tue, 12 Sep
 2023 14:13:14 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] cpufreq: userspace: Move is_managed indicator into per-policy structure
Date:   Tue, 12 Sep 2023 06:10:57 +0000
Message-ID: <20230912061057.2516963-2-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912061057.2516963-1-liaochang1@huawei.com>
References: <20230912061057.2516963-1-liaochang1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.28]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200002.china.huawei.com (7.221.188.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The userspace governor use the 'cpu' field of cpufreq_policy structure
to track if it is allowed to set the speed of policy.  However, there is
a window where the 'cpu' field is equal to the value of nr_cpus_id when
all affected CPUs of policy are offline, which is an illegal value to
get the per-CPU variable. To avoid this issue, this patch uses a
per-policy indicator to track if the policy is managed.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 drivers/cpufreq/cpufreq_userspace.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index 442e31060d62..2c42fee76daa 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -15,9 +15,8 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 
-static DEFINE_PER_CPU(unsigned int, cpu_is_managed);
-
 struct userspace_policy {
+	unsigned int is_managed;
 	unsigned int setspeed;
 	struct mutex mutex;
 };
@@ -37,7 +36,7 @@ static int cpufreq_set(struct cpufreq_policy *policy, unsigned int freq)
 	pr_debug("cpufreq_set for cpu %u, freq %u kHz\n", policy->cpu, freq);
 
 	mutex_lock(&userspace->mutex);
-	if (!per_cpu(cpu_is_managed, policy->cpu))
+	if (!userspace->is_managed)
 		goto err;
 
 	userspace->setspeed = freq;
@@ -85,7 +84,7 @@ static int cpufreq_userspace_policy_start(struct cpufreq_policy *policy)
 	pr_debug("started managing cpu %u\n", policy->cpu);
 
 	mutex_lock(&userspace->mutex);
-	per_cpu(cpu_is_managed, policy->cpu) = 1;
+	userspace->is_managed = 1;
 	userspace->setspeed = policy->cur;
 	mutex_unlock(&userspace->mutex);
 	return 0;
@@ -98,7 +97,7 @@ static void cpufreq_userspace_policy_stop(struct cpufreq_policy *policy)
 	pr_debug("managing cpu %u stopped\n", policy->cpu);
 
 	mutex_lock(&userspace->mutex);
-	per_cpu(cpu_is_managed, policy->cpu) = 0;
+	userspace->is_managed = 0;
 	userspace->setspeed = 0;
 	mutex_unlock(&userspace->mutex);
 }
-- 
2.34.1

