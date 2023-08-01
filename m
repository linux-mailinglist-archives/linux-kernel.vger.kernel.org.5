Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3076AB18
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjHAIb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjHAIb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:31:56 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5100AE0;
        Tue,  1 Aug 2023 01:31:54 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 3718VIAe032212;
        Tue, 1 Aug 2023 16:31:18 +0800 (+08)
        (envelope-from Di.Shen@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RFSvj5HVbz2K1r9S;
        Tue,  1 Aug 2023 16:29:37 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.63) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 1 Aug 2023 16:31:16 +0800
From:   Di Shen <di.shen@unisoc.com>
To:     <lukasz.luba@arm.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <amitk@kernel.org>, <rui.zhang@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jeson.gao@unisoc.com>, <xuewen.yan@unisoc.com>,
        <yongzhi.chen@unisoc.com>
Subject: [PATCH] thermal/core/power_allocator: enable user to change the power budget
Date:   Tue, 1 Aug 2023 16:30:25 +0800
Message-ID: <20230801083025.13912-1-di.shen@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.73.63]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL: SHSQR01.spreadtrum.com 3718VIAe032212
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For IPA, the total power budget of all cooling actors can be
calculated with the input of thermal zone temperature in PID
controller. However, in some scenarios, if user wants more
restrictive temperature control, which means lower power allocated
for all cooling devices, the power budget should be changed to be
a lower one.

In order to allow users to change the power budget value, this
patch adds a variable of power_budget. Users can write a power
budget value through the sysfs node, and then the governor will
choose the lower value (the more strict one) compared with the
power budget calculated by PID controller to be allocated for
cooling deivces.

Signed-off-by: Di Shen <di.shen@unisoc.com>
---
 drivers/thermal/gov_power_allocator.c |  3 +++
 drivers/thermal/thermal_sysfs.c       | 33 +++++++++++++++++++++++++++
 include/linux/thermal.h               |  6 +++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 8642f1096b91..c839e8277eab 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -460,6 +460,8 @@ static int allocate_power(struct thermal_zone_device *tz,
 	}
 
 	power_range = pid_controller(tz, control_temp, max_allocatable_power);
+	if (tz->tzp->power_budget && tz->tzp->power_budget < power_range)
+		power_range = tz->tzp->power_budget;
 
 	divvy_up_power(weighted_req_power, max_power, num_actors,
 		       total_weighted_req_power, power_range, granted_power,
@@ -665,6 +667,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 					       trip.temperature);
 	}
 
+	tz->tzp->power_budget = 0;
 	reset_pid_controller(params);
 
 	tz->governor_data = params;
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 6c20c9f90a05..85dd4194b5c7 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -326,6 +326,37 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
 	return count;
 }
 
+static ssize_t
+power_budget_show(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+
+	if (tz->tzp)
+		return sprintf(buf, "%u\n", tz->tzp->power_budget);
+	else
+		return -EIO;
+}
+
+static ssize_t
+power_budget_store(struct device *dev, struct device_attribute *devattr,
+		       const char *buf, size_t count)
+{
+	struct thermal_zone_device *tz = to_thermal_zone(dev);
+	u32 power_budget;
+
+	if (!tz->tzp)
+		return -EIO;
+
+	if (kstrtou32(buf, 10, &power_budget))
+		return -EINVAL;
+
+	tz->tzp->power_budget = power_budget;
+
+	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+
+	return count;
+}
+
 #define create_s32_tzp_attr(name)					\
 	static ssize_t							\
 	name##_show(struct device *dev, struct device_attribute *devattr, \
@@ -377,6 +408,7 @@ static DEVICE_ATTR_RO(temp);
 static DEVICE_ATTR_RW(policy);
 static DEVICE_ATTR_RO(available_policies);
 static DEVICE_ATTR_RW(sustainable_power);
+static DEVICE_ATTR_RW(power_budget);
 
 /* These thermal zone device attributes are created based on conditions */
 static DEVICE_ATTR_RW(mode);
@@ -391,6 +423,7 @@ static struct attribute *thermal_zone_dev_attrs[] = {
 	&dev_attr_policy.attr,
 	&dev_attr_available_policies.attr,
 	&dev_attr_sustainable_power.attr,
+	&dev_attr_power_budget.attr,
 	&dev_attr_k_po.attr,
 	&dev_attr_k_pu.attr,
 	&dev_attr_k_i.attr,
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 87837094d549..580a1e786037 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -224,6 +224,12 @@ struct thermal_zone_params {
 	 */
 	u32 sustainable_power;
 
+	/*
+	 * A power budget needed to compare with power_range of power allocator
+	 * in mW
+	 */
+	u32 power_budget;
+
 	/*
 	 * Proportional parameter of the PID controller when
 	 * overshooting (i.e., when temperature is below the target)
-- 
2.17.1

