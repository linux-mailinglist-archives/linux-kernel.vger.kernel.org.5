Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9973D7D7424
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjJYTVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJYTVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:21:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E4BC137;
        Wed, 25 Oct 2023 12:21:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05D521424;
        Wed, 25 Oct 2023 12:22:24 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.81.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FF523F738;
        Wed, 25 Oct 2023 12:21:41 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH 1/7] thermal: gov_power_allocator: Rename trip_max_desired_temperature
Date:   Wed, 25 Oct 2023 20:22:19 +0100
Message-Id: <20231025192225.468228-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231025192225.468228-1-lukasz.luba@arm.com>
References: <20231025192225.468228-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the code and drop the long name for the trip point. There is
a comment describing the field properly. Use shorten variable name so that
allow to make the code cleaner a bit.

This change is not expected to alter the general functionality.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 40 ++++++++++++---------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 83d4f451b1a97..97a8a6e4e1b0b 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -59,9 +59,8 @@ static inline s64 div_frac(s64 x, s64 y)
  *			governor switches on when this trip point is crossed.
  *			If the thermal zone only has one passive trip point,
  *			@trip_switch_on should be NULL.
- * @trip_max_desired_temperature:	last passive trip point of the thermal
- *					zone.  The temperature we are
- *					controlling for.
+ * @trip_max:		last passive trip point of the thermal zone. The
+ *			temperature we are controlling for.
  */
 struct power_allocator_params {
 	bool allocated_tzp;
@@ -69,7 +68,7 @@ struct power_allocator_params {
 	s32 prev_err;
 	u32 sustainable_power;
 	const struct thermal_trip *trip_switch_on;
-	const struct thermal_trip *trip_max_desired_temperature;
+	const struct thermal_trip *trip_max;
 };
 
 /**
@@ -93,7 +92,7 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
 		struct thermal_cooling_device *cdev = instance->cdev;
 		u32 min_power;
 
-		if (instance->trip != params->trip_max_desired_temperature)
+		if (instance->trip != params->trip_max)
 			continue;
 
 		if (!cdev_is_power_actor(cdev))
@@ -379,8 +378,7 @@ static int allocate_power(struct thermal_zone_device *tz,
 {
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
-	const struct thermal_trip *trip_max_desired_temperature =
-					params->trip_max_desired_temperature;
+	const struct thermal_trip *trip_max = params->trip_max;
 	u32 *req_power, *max_power, *granted_power, *extra_actor_power;
 	u32 *weighted_req_power;
 	u32 total_req_power, max_allocatable_power, total_weighted_req_power;
@@ -390,7 +388,7 @@ static int allocate_power(struct thermal_zone_device *tz,
 	num_actors = 0;
 	total_weight = 0;
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if ((instance->trip == trip_max_desired_temperature) &&
+		if ((instance->trip == trip_max) &&
 		    cdev_is_power_actor(instance->cdev)) {
 			num_actors++;
 			total_weight += instance->weight;
@@ -429,7 +427,7 @@ static int allocate_power(struct thermal_zone_device *tz,
 		int weight;
 		struct thermal_cooling_device *cdev = instance->cdev;
 
-		if (instance->trip != trip_max_desired_temperature)
+		if (instance->trip != trip_max)
 			continue;
 
 		if (!cdev_is_power_actor(cdev))
@@ -465,7 +463,7 @@ static int allocate_power(struct thermal_zone_device *tz,
 	total_granted_power = 0;
 	i = 0;
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip_max_desired_temperature)
+		if (instance->trip != trip_max)
 			continue;
 
 		if (!cdev_is_power_actor(instance->cdev))
@@ -531,13 +529,13 @@ static void get_governor_trips(struct thermal_zone_device *tz,
 
 	if (last_passive) {
 		params->trip_switch_on = first_passive;
-		params->trip_max_desired_temperature = last_passive;
+		params->trip_max = last_passive;
 	} else if (first_passive) {
 		params->trip_switch_on = NULL;
-		params->trip_max_desired_temperature = first_passive;
+		params->trip_max = first_passive;
 	} else {
 		params->trip_switch_on = NULL;
-		params->trip_max_desired_temperature = last_active;
+		params->trip_max = last_active;
 	}
 }
 
@@ -556,8 +554,8 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		struct thermal_cooling_device *cdev = instance->cdev;
 
-		if (instance->trip != params->trip_max_desired_temperature ||
-		    (!cdev_is_power_actor(instance->cdev)))
+		if (instance->trip != params->trip_max ||
+		    !cdev_is_power_actor(instance->cdev))
 			continue;
 
 		instance->target = 0;
@@ -642,12 +640,10 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 
 	get_governor_trips(tz, params);
 
-	if (params->trip_max_desired_temperature) {
-		int temp = params->trip_max_desired_temperature->temperature;
-
+	if (params->trip_max)
 		estimate_pid_constants(tz, tz->tzp->sustainable_power,
-				       params->trip_switch_on, temp);
-	}
+				       params->trip_switch_on,
+				       params->trip_max->temperature);
 
 	reset_pid_controller(params);
 
@@ -688,7 +684,7 @@ static int power_allocator_throttle(struct thermal_zone_device *tz,
 	 * We get called for every trip point but we only need to do
 	 * our calculations once
 	 */
-	if (trip != params->trip_max_desired_temperature)
+	if (trip != params->trip_max)
 		return 0;
 
 	trip = params->trip_switch_on;
@@ -702,7 +698,7 @@ static int power_allocator_throttle(struct thermal_zone_device *tz,
 
 	tz->passive = 1;
 
-	return allocate_power(tz, params->trip_max_desired_temperature->temperature);
+	return allocate_power(tz, params->trip_max->temperature);
 }
 
 static struct thermal_governor thermal_gov_power_allocator = {
-- 
2.25.1

