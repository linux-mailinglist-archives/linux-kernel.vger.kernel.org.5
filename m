Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A4279C6B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjILGNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjILGNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:13:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049B7AF;
        Mon, 11 Sep 2023 23:13:16 -0700 (PDT)
Received: from kwepemd200002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RlCpz5k45zMlHw;
        Tue, 12 Sep 2023 14:09:47 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200002.china.huawei.com
 (7.221.188.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.23; Tue, 12 Sep
 2023 14:13:13 +0800
From:   Liao Chang <liaochang1@huawei.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] cpufreq: userspace: Use fine-grained mutex in userspace governor
Date:   Tue, 12 Sep 2023 06:10:56 +0000
Message-ID: <20230912061057.2516963-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
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

The userspace governor currently uses a big global mutex to avoid the
race condition on the governor_data field of cpufreq_policy structure.
This leads to a low concurrency if multiple userspace applications are
trying to set the speed of different policies at the same time. This
patch introduces a per-policy mutex to allow the updating of different
policies to be performed concurrently, improving overall concurrency.

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 drivers/cpufreq/cpufreq_userspace.c | 69 +++++++++++++++++------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index 50a4d7846580..442e31060d62 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -16,7 +16,11 @@
 #include <linux/slab.h>
 
 static DEFINE_PER_CPU(unsigned int, cpu_is_managed);
-static DEFINE_MUTEX(userspace_mutex);
+
+struct userspace_policy {
+	unsigned int setspeed;
+	struct mutex mutex;
+};
 
 /**
  * cpufreq_set - set the CPU frequency
@@ -28,19 +32,19 @@ static DEFINE_MUTEX(userspace_mutex);
 static int cpufreq_set(struct cpufreq_policy *policy, unsigned int freq)
 {
 	int ret = -EINVAL;
-	unsigned int *setspeed = policy->governor_data;
+	struct userspace_policy *userspace = policy->governor_data;
 
 	pr_debug("cpufreq_set for cpu %u, freq %u kHz\n", policy->cpu, freq);
 
-	mutex_lock(&userspace_mutex);
+	mutex_lock(&userspace->mutex);
 	if (!per_cpu(cpu_is_managed, policy->cpu))
 		goto err;
 
-	*setspeed = freq;
+	userspace->setspeed = freq;
 
 	ret = __cpufreq_driver_target(policy, freq, CPUFREQ_RELATION_L);
  err:
-	mutex_unlock(&userspace_mutex);
+	mutex_unlock(&userspace->mutex);
 	return ret;
 }
 
@@ -51,67 +55,74 @@ static ssize_t show_speed(struct cpufreq_policy *policy, char *buf)
 
 static int cpufreq_userspace_policy_init(struct cpufreq_policy *policy)
 {
-	unsigned int *setspeed;
+	struct userspace_policy *userspace;
 
-	setspeed = kzalloc(sizeof(*setspeed), GFP_KERNEL);
-	if (!setspeed)
+	userspace = kzalloc(sizeof(*userspace), GFP_KERNEL);
+	if (!userspace)
 		return -ENOMEM;
 
-	policy->governor_data = setspeed;
+	mutex_init(&userspace->mutex);
+
+	policy->governor_data = userspace;
 	return 0;
 }
 
+/*
+ * Any routine that writes to the policy struct will hold the "rwsem" of
+ * policy struct that means it is free to free "governor_data" here.
+ */
 static void cpufreq_userspace_policy_exit(struct cpufreq_policy *policy)
 {
-	mutex_lock(&userspace_mutex);
 	kfree(policy->governor_data);
 	policy->governor_data = NULL;
-	mutex_unlock(&userspace_mutex);
 }
 
 static int cpufreq_userspace_policy_start(struct cpufreq_policy *policy)
 {
-	unsigned int *setspeed = policy->governor_data;
+	struct userspace_policy *userspace = policy->governor_data;
 
 	BUG_ON(!policy->cur);
 	pr_debug("started managing cpu %u\n", policy->cpu);
 
-	mutex_lock(&userspace_mutex);
+	mutex_lock(&userspace->mutex);
 	per_cpu(cpu_is_managed, policy->cpu) = 1;
-	*setspeed = policy->cur;
-	mutex_unlock(&userspace_mutex);
+	userspace->setspeed = policy->cur;
+	mutex_unlock(&userspace->mutex);
 	return 0;
 }
 
 static void cpufreq_userspace_policy_stop(struct cpufreq_policy *policy)
 {
-	unsigned int *setspeed = policy->governor_data;
+	struct userspace_policy *userspace = policy->governor_data;
 
 	pr_debug("managing cpu %u stopped\n", policy->cpu);
 
-	mutex_lock(&userspace_mutex);
+	mutex_lock(&userspace->mutex);
 	per_cpu(cpu_is_managed, policy->cpu) = 0;
-	*setspeed = 0;
-	mutex_unlock(&userspace_mutex);
+	userspace->setspeed = 0;
+	mutex_unlock(&userspace->mutex);
 }
 
 static void cpufreq_userspace_policy_limits(struct cpufreq_policy *policy)
 {
-	unsigned int *setspeed = policy->governor_data;
+	struct userspace_policy *userspace = policy->governor_data;
 
-	mutex_lock(&userspace_mutex);
+	mutex_lock(&userspace->mutex);
 
 	pr_debug("limit event for cpu %u: %u - %u kHz, currently %u kHz, last set to %u kHz\n",
-		 policy->cpu, policy->min, policy->max, policy->cur, *setspeed);
-
-	if (policy->max < *setspeed)
-		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
-	else if (policy->min > *setspeed)
-		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
+		 policy->cpu, policy->min, policy->max, policy->cur, userspace->setspeed);
+
+	if (policy->max < userspace->setspeed)
+		__cpufreq_driver_target(policy, policy->max,
+					CPUFREQ_RELATION_H);
+	else if (policy->min > userspace->setspeed)
+		__cpufreq_driver_target(policy, policy->min,
+					CPUFREQ_RELATION_L);
 	else
-		__cpufreq_driver_target(policy, *setspeed, CPUFREQ_RELATION_L);
+		__cpufreq_driver_target(policy, userspace->setspeed,
+					CPUFREQ_RELATION_L);
 
-	mutex_unlock(&userspace_mutex);
+	mutex_unlock(&userspace->mutex);
 }
 
 static struct cpufreq_governor cpufreq_gov_userspace = {
-- 
2.34.1

