Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A38580EE06
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376287AbjLLNsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376346AbjLLNr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:47:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01F4F112;
        Tue, 12 Dec 2023 05:48:02 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FA2A175A;
        Tue, 12 Dec 2023 05:48:49 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7F0223F738;
        Tue, 12 Dec 2023 05:48:01 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH v2 4/8] thermal: gov_power_allocator: Simplify checks for valid power actor
Date:   Tue, 12 Dec 2023 13:48:40 +0000
Message-Id: <20231212134844.1213381-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212134844.1213381-1-lukasz.luba@arm.com>
References: <20231212134844.1213381-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a need to check if the cooling device in the thermal zone
supports IPA callback and is set for control trip point.
Refactor the code which validates the power actor capabilities and
make it more consistent in all places.

No intentional functional impact.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 41 +++++++++++----------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 3328c3ec71f2..1a605fd9c8c6 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -85,6 +85,13 @@ struct power_allocator_params {
 	u32 *weighted_req_power;
 };
 
+static bool power_actor_is_valid(struct power_allocator_params *params,
+				 struct thermal_instance *instance)
+{
+	return ((instance->trip == params->trip_max) &&
+		 cdev_is_power_actor(instance->cdev));
+}
+
 /**
  * estimate_sustainable_power() - Estimate the sustainable power of a thermal zone
  * @tz: thermal zone we are operating in
@@ -105,14 +112,10 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
 	u32 min_power;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		cdev = instance->cdev;
-
-		if (instance->trip != params->trip_max)
-			continue;
-
-		if (!cdev_is_power_actor(cdev))
+		if (!power_actor_is_valid(params, instance))
 			continue;
 
+		cdev = instance->cdev;
 		if (cdev->ops->state2power(cdev, instance->upper, &min_power))
 			continue;
 
@@ -407,8 +410,7 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 		return -ENODEV;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-		if ((instance->trip == params->trip_max) &&
-		    cdev_is_power_actor(instance->cdev))
+		if (power_actor_is_valid(params, instance))
 			total_weight += instance->weight;
 
 	/* Clean all buffers for new power estimations */
@@ -421,14 +423,10 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 	weighted_req_power = params->weighted_req_power;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		cdev = instance->cdev;
-
-		if (instance->trip != params->trip_max)
-			continue;
-
-		if (!cdev_is_power_actor(cdev))
+		if (!power_actor_is_valid(params, instance))
 			continue;
 
+		cdev = instance->cdev;
 		if (cdev->ops->get_requested_power(cdev, &req_power[i]))
 			continue;
 
@@ -458,10 +456,7 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 
 	i = 0;
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != params->trip_max)
-			continue;
-
-		if (!cdev_is_power_actor(instance->cdev))
+		if (!power_actor_is_valid(params, instance))
 			continue;
 
 		power_actor_set_power(instance->cdev, instance,
@@ -546,12 +541,11 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 	u32 req_power;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		cdev = instance->cdev;
-
-		if (instance->trip != params->trip_max ||
-		    !cdev_is_power_actor(instance->cdev))
+		if (!power_actor_is_valid(params, instance))
 			continue;
 
+		cdev = instance->cdev;
+
 		instance->target = 0;
 		mutex_lock(&cdev->lock);
 		/*
@@ -664,8 +658,7 @@ static void power_allocator_update_tz(struct thermal_zone_device *tz,
 	switch (reason) {
 	case THERMAL_INSTANCE_LIST_UPDATE:
 		list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-			if ((instance->trip == params->trip_max) &&
-			    cdev_is_power_actor(instance->cdev))
+			if (power_actor_is_valid(params, instance))
 				num_actors++;
 
 		if (num_actors == params->num_actors)
-- 
2.25.1

