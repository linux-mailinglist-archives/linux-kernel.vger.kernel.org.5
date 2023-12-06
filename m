Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC6E806DFB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377595AbjLFLaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377577AbjLFLan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:30:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF0DCD3;
        Wed,  6 Dec 2023 03:30:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABB1D1570;
        Wed,  6 Dec 2023 03:31:34 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.1.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6BE953F5A1;
        Wed,  6 Dec 2023 03:30:47 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH 3/5] thermal: gov_power_allocator: Move memory allocation out of throttle()
Date:   Wed,  6 Dec 2023 11:31:36 +0000
Message-Id: <20231206113138.3576492-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206113138.3576492-1-lukasz.luba@arm.com>
References: <20231206113138.3576492-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new thermal callback allows to react to the change of cooling
instances in the thermal zone. Move the memory allocation to that new
callback and save CPU cycles in the throttle() code path.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 137 ++++++++++++++++++++------
 1 file changed, 106 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 38e1e89ba10c..1b55d00fc12b 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -61,6 +61,13 @@ static inline s64 div_frac(s64 x, s64 y)
  *			@trip_switch_on should be NULL.
  * @trip_max:		last passive trip point of the thermal zone. The
  *			temperature we are controlling for.
+ * @num_actors:		number of cooling devices supporting IPA callbacks
+ * @buffer_size:	IPA internal buffer size
+ * @req_power:		IPA buffer for requested power
+ * @max_power:		IPA buffer for max allocatable power
+ * @granted_power:	IPA buffer for granted power
+ * @extra_actor_power:	IPA buffer for extra power
+ * @weighted_req_power:	IPA buffer for weighted requested power
  */
 struct power_allocator_params {
 	bool allocated_tzp;
@@ -69,6 +76,13 @@ struct power_allocator_params {
 	u32 sustainable_power;
 	const struct thermal_trip *trip_switch_on;
 	const struct thermal_trip *trip_max;
+	int num_actors;
+	int buffer_size;
+	u32 *req_power;
+	u32 *max_power;
+	u32 *granted_power;
+	u32 *extra_actor_power;
+	u32 *weighted_req_power;
 };
 
 /**
@@ -387,39 +401,24 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 	u32 *weighted_req_power;
 	u32 power_range, weight;
 	int total_weight = 0;
-	int num_actors = 0;
 	int i = 0;
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+	if (!params->num_actors)
+		return -ENODEV;
+
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
 		if ((instance->trip == params->trip_max) &&
-		    cdev_is_power_actor(instance->cdev)) {
-			num_actors++;
+		    cdev_is_power_actor(instance->cdev))
 			total_weight += instance->weight;
-		}
-	}
-
-	if (!num_actors)
-		return -ENODEV;
 
-	/*
-	 * We need to allocate five arrays of the same size:
-	 * req_power, max_power, granted_power, extra_actor_power and
-	 * weighted_req_power.  They are going to be needed until this
-	 * function returns.  Allocate them all in one go to simplify
-	 * the allocation and deallocation logic.
-	 */
-	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*max_power));
-	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*granted_power));
-	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*extra_actor_power));
-	BUILD_BUG_ON(sizeof(*req_power) != sizeof(*weighted_req_power));
-	req_power = kcalloc(num_actors * 5, sizeof(*req_power), GFP_KERNEL);
-	if (!req_power)
-		return -ENOMEM;
+	/* Clean all buffers for new power estimations */
+	memset(params->req_power, 0, params->buffer_size);
 
-	max_power = &req_power[num_actors];
-	granted_power = &req_power[2 * num_actors];
-	extra_actor_power = &req_power[3 * num_actors];
-	weighted_req_power = &req_power[4 * num_actors];
+	req_power = params->req_power;
+	max_power = params->max_power;
+	granted_power = params->granted_power;
+	extra_actor_power = params->extra_actor_power;
+	weighted_req_power = params->weighted_req_power;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		cdev = instance->cdev;
@@ -453,7 +452,7 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 
 	power_range = pid_controller(tz, control_temp, max_allocatable_power);
 
-	divvy_up_power(weighted_req_power, max_power, num_actors,
+	divvy_up_power(weighted_req_power, max_power, params->num_actors,
 		       total_weighted_req_power, power_range, granted_power,
 		       extra_actor_power);
 
@@ -474,12 +473,10 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 
 	trace_thermal_power_allocator(tz, req_power, total_req_power,
 				      granted_power, total_granted_power,
-				      num_actors, power_range,
+				      params->num_actors, power_range,
 				      max_allocatable_power, tz->temperature,
 				      control_temp - tz->temperature);
 
-	kfree(req_power);
-
 	return 0;
 }
 
@@ -606,6 +603,74 @@ static int check_power_actors(struct thermal_zone_device *tz,
 	return ret;
 }
 
+static void _power_buffers_init(struct power_allocator_params *params,
+				u32 *req_power, u32 *max_power,
+				u32 *granted_power, u32 *extra_actor_power,
+				u32 *weighted_req_power)
+
+{
+	/* Setup internal buffers for power calculations. */
+	params->req_power = req_power;
+	params->max_power = max_power;
+	params->granted_power = granted_power;
+	params->extra_actor_power = extra_actor_power;
+	params->weighted_req_power = weighted_req_power;
+}
+
+static int allocate_actors_buffer(struct power_allocator_params *params,
+				  int num_actors)
+{
+	u32 *req_power;
+	int ret;
+
+	kfree(params->req_power);
+
+	/* There might be no cooling devices yet. */
+	if (!num_actors) {
+		ret = -EINVAL;
+		goto clean_buffers;
+	}
+
+	req_power = kcalloc(num_actors * 5, sizeof(u32), GFP_KERNEL);
+	if (!req_power) {
+		ret = -ENOMEM;
+		goto clean_buffers;
+	}
+
+	params->num_actors = num_actors;
+	params->buffer_size = num_actors * 5 * sizeof(u32);
+
+	_power_buffers_init(params, req_power, &req_power[params->num_actors],
+			    &req_power[2 * params->num_actors],
+			    &req_power[3 * params->num_actors],
+			    &req_power[4 * params->num_actors]);
+
+	return 0;
+
+clean_buffers:
+	params->num_actors = -EINVAL;
+	params->buffer_size = 0;
+	_power_buffers_init(params, NULL, NULL, NULL, NULL, NULL);
+	return ret;
+}
+
+static void power_allocator_instances_update(struct thermal_zone_device *tz)
+{
+	struct power_allocator_params *params = tz->governor_data;
+	struct thermal_instance *instance;
+	int num_actors = 0;
+
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
+		if ((instance->trip == params->trip_max) &&
+		    cdev_is_power_actor(instance->cdev))
+			num_actors++;
+
+	if (num_actors == params->num_actors)
+		return;
+
+	allocate_actors_buffer(params, num_actors);
+}
+
 /**
  * power_allocator_bind() - bind the power_allocator governor to a thermal zone
  * @tz:	thermal zone to bind it to
@@ -639,6 +704,13 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 		return ret;
 	}
 
+	ret = allocate_actors_buffer(params, ret);
+	if (ret) {
+		dev_warn(&tz->device, "power_allocator: allocation failed\n");
+		kfree(params);
+		return ret;
+	}
+
 	if (!tz->tzp) {
 		tz->tzp = kzalloc(sizeof(*tz->tzp), GFP_KERNEL);
 		if (!tz->tzp) {
@@ -663,6 +735,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	return 0;
 
 free_params:
+	kfree(params->req_power);
 	kfree(params);
 
 	return ret;
@@ -679,6 +752,7 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 		tz->tzp = NULL;
 	}
 
+	kfree(params->req_power);
 	kfree(tz->governor_data);
 	tz->governor_data = NULL;
 }
@@ -717,5 +791,6 @@ static struct thermal_governor thermal_gov_power_allocator = {
 	.bind_to_tz	= power_allocator_bind,
 	.unbind_from_tz	= power_allocator_unbind,
 	.throttle	= power_allocator_throttle,
+	.instances_update = power_allocator_instances_update,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
-- 
2.25.1

