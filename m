Return-Path: <linux-kernel+bounces-7627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F184981AAF5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BFD1C24B8F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B7F4C634;
	Wed, 20 Dec 2023 23:17:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60A4C3C4;
	Wed, 20 Dec 2023 23:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BEE72F4;
	Wed, 20 Dec 2023 15:17:46 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E180D3F64C;
	Wed, 20 Dec 2023 15:16:59 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v3 5/9] thermal: gov_power_allocator: Move memory allocation out of throttle()
Date: Wed, 20 Dec 2023 23:17:49 +0000
Message-Id: <20231220231753.1824364-6-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231220231753.1824364-1-lukasz.luba@arm.com>
References: <20231220231753.1824364-1-lukasz.luba@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new thermal callback allows to react to the change of cooling
instances in the thermal zone. Move the memory allocation to that new
callback and save CPU cycles in the throttle() code path.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 207 +++++++++++++++++---------
 1 file changed, 136 insertions(+), 71 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 53283fd8a944..626c635f137f 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -46,6 +46,22 @@ static inline s64 div_frac(s64 x, s64 y)
 	return div_s64(x << FRAC_BITS, y);
 }
 
+/**
+ * struct power_actor - internal power information for power actor
+ * @req_power:		requested power value (not weighted)
+ * @max_power:		max allocatable power for this actor
+ * @granted_power:	granted power for this actor
+ * @extra_actor_power:	extra power that this actor can receive
+ * @weighted_req_power:	weighted requested power as input to IPA
+ */
+struct power_actor {
+	u32 req_power;
+	u32 max_power;
+	u32 granted_power;
+	u32 extra_actor_power;
+	u32 weighted_req_power;
+};
+
 /**
  * struct power_allocator_params - parameters for the power allocator governor
  * @allocated_tzp:	whether we have allocated tzp for this thermal zone and
@@ -61,6 +77,9 @@ static inline s64 div_frac(s64 x, s64 y)
  *			@trip_switch_on should be NULL.
  * @trip_max:		last passive trip point of the thermal zone. The
  *			temperature we are controlling for.
+ * @num_actors:		number of cooling devices supporting IPA callbacks
+ * @buffer_size:	internal buffer size, to avoid runtime re-calculation
+ * @power:		buffer for all power actors internal power information
  */
 struct power_allocator_params {
 	bool allocated_tzp;
@@ -69,6 +88,9 @@ struct power_allocator_params {
 	u32 sustainable_power;
 	const struct thermal_trip *trip_switch_on;
 	const struct thermal_trip *trip_max;
+	unsigned int num_actors;
+	unsigned int buffer_size;
+	struct power_actor *power;
 };
 
 /**
@@ -303,15 +325,10 @@ power_actor_set_power(struct thermal_cooling_device *cdev,
 
 /**
  * divvy_up_power() - divvy the allocated power between the actors
- * @req_power:	each actor's requested power
- * @max_power:	each actor's maximum available power
- * @num_actors:	size of the @req_power, @max_power and @granted_power's array
- * @total_req_power: sum of @req_power
+ * @power:		buffer for all power actors internal power information
+ * @num_actors:		number of power actors in this thermal zone
+ * @total_req_power:	sum of all weighted requested power for all actors
  * @power_range:	total allocated power
- * @granted_power:	output array: each actor's granted power
- * @extra_actor_power:	an appropriately sized array to be used in the
- *			function as temporary storage of the extra power given
- *			to the actors
  *
  * This function divides the total allocated power (@power_range)
  * fairly between the actors.  It first tries to give each actor a
@@ -324,13 +341,9 @@ power_actor_set_power(struct thermal_cooling_device *cdev,
  * If any actor received more than their maximum power, then that
  * surplus is re-divvied among the actors based on how far they are
  * from their respective maximums.
- *
- * Granted power for each actor is written to @granted_power, which
- * should've been allocated by the calling function.
  */
-static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
-			   u32 total_req_power, u32 power_range,
-			   u32 *granted_power, u32 *extra_actor_power)
+static void divvy_up_power(struct power_actor *power, int num_actors,
+			   u32 total_req_power, u32 power_range)
 {
 	u32 capped_extra_power = 0;
 	u32 extra_power = 0;
@@ -343,18 +356,19 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 		total_req_power = 1;
 
 	for (i = 0; i < num_actors; i++) {
-		u64 req_range = (u64)req_power[i] * power_range;
+		struct power_actor *pa = &power[i];
+		u64 req_range = (u64)pa->req_power * power_range;
 
-		granted_power[i] = DIV_ROUND_CLOSEST_ULL(req_range,
-							 total_req_power);
+		pa->granted_power = DIV_ROUND_CLOSEST_ULL(req_range,
+							  total_req_power);
 
-		if (granted_power[i] > max_power[i]) {
-			extra_power += granted_power[i] - max_power[i];
-			granted_power[i] = max_power[i];
+		if (pa->granted_power > pa->max_power) {
+			extra_power += pa->granted_power - pa->max_power;
+			pa->granted_power = pa->max_power;
 		}
 
-		extra_actor_power[i] = max_power[i] - granted_power[i];
-		capped_extra_power += extra_actor_power[i];
+		pa->extra_actor_power = pa->max_power - pa->granted_power;
+		capped_extra_power += pa->extra_actor_power;
 	}
 
 	if (!extra_power || !capped_extra_power)
@@ -367,61 +381,44 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 	extra_power = min(extra_power, capped_extra_power);
 
 	for (i = 0; i < num_actors; i++) {
-		u64 extra_range = (u64)extra_actor_power[i] * extra_power;
+		struct power_actor *pa = &power[i];
+		u64 extra_range = pa->extra_actor_power;
 
-		granted_power[i] += DIV_ROUND_CLOSEST_ULL(extra_range,
-						 capped_extra_power);
+		extra_range *= extra_power;
+		pa->granted_power += DIV_ROUND_CLOSEST_ULL(extra_range,
+						capped_extra_power);
 	}
 }
 
 static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 {
-	u32 *req_power, *max_power, *granted_power, *extra_actor_power;
 	struct power_allocator_params *params = tz->governor_data;
+	unsigned int num_actors = params->num_actors;
+	struct power_actor *power = params->power;
 	struct thermal_cooling_device *cdev;
 	struct thermal_instance *instance;
 	u32 total_weighted_req_power = 0;
 	u32 max_allocatable_power = 0;
 	u32 total_granted_power = 0;
 	u32 total_req_power = 0;
-	u32 *weighted_req_power;
 	u32 power_range, weight;
 	int total_weight = 0;
-	int num_actors = 0;
-	int i = 0;
-
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if ((instance->trip == params->trip_max) &&
-		    cdev_is_power_actor(instance->cdev)) {
-			num_actors++;
-			total_weight += instance->weight;
-		}
-	}
+	int i = 0, ret;
 
 	if (!num_actors)
 		return -ENODEV;
 
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
+	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
+		if ((instance->trip == params->trip_max) &&
+		    cdev_is_power_actor(instance->cdev))
+			total_weight += instance->weight;
 
-	max_power = &req_power[num_actors];
-	granted_power = &req_power[2 * num_actors];
-	extra_actor_power = &req_power[3 * num_actors];
-	weighted_req_power = &req_power[4 * num_actors];
+	/* Clean all buffers for new power estimations */
+	memset(power, 0, params->buffer_size);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		struct power_actor *pa = &power[i];
+
 		cdev = instance->cdev;
 
 		if (instance->trip != params->trip_max)
@@ -430,7 +427,8 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 		if (!cdev_is_power_actor(cdev))
 			continue;
 
-		if (cdev->ops->get_requested_power(cdev, &req_power[i]))
+		ret = cdev->ops->get_requested_power(cdev, &pa->req_power);
+		if (ret)
 			continue;
 
 		if (!total_weight)
@@ -438,27 +436,29 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 		else
 			weight = instance->weight;
 
-		weighted_req_power[i] = frac_to_int(weight * req_power[i]);
+		pa->weighted_req_power = frac_to_int(weight * pa->req_power);
 
-		if (cdev->ops->state2power(cdev, instance->lower,
-					   &max_power[i]))
+		ret = cdev->ops->state2power(cdev, instance->lower,
+					     &pa->max_power);
+		if (ret)
 			continue;
 
-		total_req_power += req_power[i];
-		max_allocatable_power += max_power[i];
-		total_weighted_req_power += weighted_req_power[i];
+		total_req_power += pa->req_power;
+		max_allocatable_power += pa->max_power;
+		total_weighted_req_power += pa->weighted_req_power;
 
 		i++;
 	}
 
 	power_range = pid_controller(tz, control_temp, max_allocatable_power);
 
-	divvy_up_power(weighted_req_power, max_power, num_actors,
-		       total_weighted_req_power, power_range, granted_power,
-		       extra_actor_power);
+	divvy_up_power(power, num_actors, total_weighted_req_power,
+		       power_range);
 
 	i = 0;
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		struct power_actor *pa = &power[i];
+
 		if (instance->trip != params->trip_max)
 			continue;
 
@@ -466,11 +466,11 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 			continue;
 
 		power_actor_set_power(instance->cdev, instance,
-				      granted_power[i]);
-		total_granted_power += granted_power[i];
+				      pa->granted_power);
+		total_granted_power += pa->granted_power;
 
-		trace_thermal_power_actor(tz, i, req_power[i],
-					  granted_power[i]);
+		trace_thermal_power_actor(tz, i, pa->req_power,
+					  pa->granted_power);
 		i++;
 	}
 
@@ -479,8 +479,6 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 				      max_allocatable_power, tz->temperature,
 				      control_temp - tz->temperature);
 
-	kfree(req_power);
-
 	return 0;
 }
 
@@ -607,6 +605,63 @@ static int check_power_actors(struct thermal_zone_device *tz,
 	return ret;
 }
 
+static int allocate_actors_buffer(struct power_allocator_params *params,
+				  int num_actors)
+{
+	int ret;
+
+	kfree(params->power);
+
+	/* There might be no cooling devices yet. */
+	if (!num_actors) {
+		ret = -EINVAL;
+		goto clean_state;
+	}
+
+	params->power = kcalloc(num_actors, sizeof(struct power_actor),
+				GFP_KERNEL);
+	if (!params->power) {
+		ret = -ENOMEM;
+		goto clean_state;
+	}
+
+	params->num_actors = num_actors;
+	params->buffer_size = num_actors * sizeof(struct power_actor);
+
+	return 0;
+
+clean_state:
+	params->num_actors = 0;
+	params->buffer_size = 0;
+	params->power = NULL;
+	return ret;
+}
+
+static void power_allocator_update_tz(struct thermal_zone_device *tz,
+				      enum thermal_notify_event reason)
+{
+	struct power_allocator_params *params = tz->governor_data;
+	struct thermal_instance *instance;
+	int num_actors = 0;
+
+	switch (reason) {
+	case THERMAL_TZ_BIND_CDEV:
+	case THERMAL_TZ_UNBIND_CDEV:
+		list_for_each_entry(instance, &tz->thermal_instances, tz_node)
+			if ((instance->trip == params->trip_max) &&
+			    cdev_is_power_actor(instance->cdev))
+				num_actors++;
+
+		if (num_actors == params->num_actors)
+			return;
+
+		allocate_actors_buffer(params, num_actors);
+		break;
+	default:
+		break;
+	}
+}
+
 /**
  * power_allocator_bind() - bind the power_allocator governor to a thermal zone
  * @tz:	thermal zone to bind it to
@@ -640,6 +695,13 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
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
@@ -664,6 +726,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	return 0;
 
 free_params:
+	kfree(params->power);
 	kfree(params);
 
 	return ret;
@@ -680,6 +743,7 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 		tz->tzp = NULL;
 	}
 
+	kfree(params->power);
 	kfree(tz->governor_data);
 	tz->governor_data = NULL;
 }
@@ -718,5 +782,6 @@ static struct thermal_governor thermal_gov_power_allocator = {
 	.bind_to_tz	= power_allocator_bind,
 	.unbind_from_tz	= power_allocator_unbind,
 	.throttle	= power_allocator_throttle,
+	.update_tz	= power_allocator_update_tz,
 };
 THERMAL_GOVERNOR_DECLARE(thermal_gov_power_allocator);
-- 
2.25.1


