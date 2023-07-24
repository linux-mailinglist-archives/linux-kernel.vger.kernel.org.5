Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B07F75ED00
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjGXIBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjGXIBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:01:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B876FA;
        Mon, 24 Jul 2023 01:01:03 -0700 (PDT)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R8Xcd2kB4zVjnx;
        Mon, 24 Jul 2023 15:59:29 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 16:01:00 +0800
From:   Jie Zhan <zhanjie9@hisilicon.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <zhanjie9@hisilicon.com>,
        <xuwei5@huawei.com>, <wanghuiqiang@huawei.com>,
        <jonathan.cameron@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH] cpufreq: Support per-policy performance boost
Date:   Mon, 24 Jul 2023 15:58:27 +0800
Message-ID: <20230724075827.4160512-1-zhanjie9@hisilicon.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boost control currently applies to the whole system.  However, users
may prefer to boost a subset of cores in order to provide prioritized
performance to workloads running on the boosted cores.

Enable per-policy boost by adding a 'local_boost' sysfs interface.  This
can be found at:

	/sys/devices/system/cpu/cpufreq/policy<*>/local_boost

Same to the global boost switch, writing 1/0 to 'local_boost'
enables/disables boost on a cpufreq policy respectively.

The user view of global and local boost controls should be:

1. Enabling global boost initially enables local boost on all policies, and
local boost can then be enabled or disabled individually on each policy,
given that the platform does support so.

2. Disabling global boost makes enabling local boost illegal, while writing
0 to 'local_boost' is fine but takes no effect.

A possible question could be: why not just limiting 'scaling_max_freq'?
Well, the fundamental difference is that 'local_boost' could be more
user-friendly.  When global boost is enabled, it is not straightforward to
figure out the base frequency for setting 'scaling_max_freq' to a non-boost
value. Also, this is supposed to take effect on the physical upper
frequency limit, reflected through 'cpuinfo_max_freq'.

Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
Reviewed-by: Wei Xu <xuwei5@hisilicon.com>
---
 drivers/cpufreq/cpufreq.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |  3 +++
 2 files changed, 36 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6b52ebe5a890..14579c59f7ba 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -621,6 +621,35 @@ static ssize_t store_boost(struct kobject *kobj, struct kobj_attribute *attr,
 }
 define_one_global_rw(boost);
 
+static ssize_t show_local_boost(struct cpufreq_policy *policy, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", policy->local_boost_enabled);
+}
+
+static ssize_t store_local_boost(struct cpufreq_policy *policy,
+				 const char *buf, size_t count)
+{
+	int ret, enable;
+
+	ret = kstrtoint(buf, 10, &enable);
+	if (ret || enable < 0 || enable > 1)
+		return -EINVAL;
+
+	if (enable && !cpufreq_driver->boost_enabled)
+		return -EINVAL;
+
+	cpus_read_lock();
+	ret = cpufreq_driver->set_boost(policy, enable);
+	cpus_read_unlock();
+
+	if (ret)
+		return ret;
+
+	policy->local_boost_enabled = enable;
+
+	return count;
+}
+
 static struct cpufreq_governor *find_governor(const char *str_governor)
 {
 	struct cpufreq_governor *t;
@@ -931,6 +960,7 @@ cpufreq_freq_attr_rw(scaling_min_freq);
 cpufreq_freq_attr_rw(scaling_max_freq);
 cpufreq_freq_attr_rw(scaling_governor);
 cpufreq_freq_attr_rw(scaling_setspeed);
+cpufreq_freq_attr_rw(local_boost);
 
 static struct attribute *cpufreq_attrs[] = {
 	&cpuinfo_min_freq.attr,
@@ -944,6 +974,7 @@ static struct attribute *cpufreq_attrs[] = {
 	&scaling_driver.attr,
 	&scaling_available_governors.attr,
 	&scaling_setspeed.attr,
+	&local_boost.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(cpufreq);
@@ -2716,6 +2747,8 @@ int cpufreq_boost_trigger_state(int state)
 		ret = cpufreq_driver->set_boost(policy, state);
 		if (ret)
 			goto err_reset_state;
+
+		policy->local_boost_enabled = state;
 	}
 	cpus_read_unlock();
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 26e2eb399484..a99a48ac9fdb 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -140,6 +140,9 @@ struct cpufreq_policy {
 	 */
 	bool			dvfs_possible_from_any_cpu;
 
+	/* Per policy boost enabled flag. */
+	bool			local_boost_enabled;
+
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
 	unsigned int cached_resolved_idx;
-- 
2.30.0

