Return-Path: <linux-kernel+bounces-7628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F9F81AAF7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B260A1C24AFC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B104CB43;
	Wed, 20 Dec 2023 23:17:04 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC8F4C61C;
	Wed, 20 Dec 2023 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91E6A152B;
	Wed, 20 Dec 2023 15:17:47 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 629193F64C;
	Wed, 20 Dec 2023 15:17:01 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v3 6/9] thermal: gov_power_allocator: Simplify checks for valid power actor
Date: Wed, 20 Dec 2023 23:17:50 +0000
Message-Id: <20231220231753.1824364-7-lukasz.luba@arm.com>
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

There is a need to check if the cooling device in the thermal zone
supports IPA callback and is set for control trip point.
Refactor the code which validates the power actor capabilities and
make it more consistent in all places.

No intentional functional impact.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 40 ++++++++++++---------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 626c635f137f..b5ec60ae7efd 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -93,6 +93,13 @@ struct power_allocator_params {
 	struct power_actor *power;
 };
 
+static bool power_actor_is_valid(struct power_allocator_params *params,
+				 struct thermal_instance *instance)
+{
+	return (instance->trip == params->trip_max &&
+		 cdev_is_power_actor(instance->cdev));
+}
+
 /**
  * estimate_sustainable_power() - Estimate the sustainable power of a thermal zone
  * @tz: thermal zone we are operating in
@@ -113,14 +120,10 @@ static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
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
 
@@ -409,8 +412,7 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 		return -ENODEV;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-		if ((instance->trip == params->trip_max) &&
-		    cdev_is_power_actor(instance->cdev))
+		if (power_actor_is_valid(params, instance))
 			total_weight += instance->weight;
 
 	/* Clean all buffers for new power estimations */
@@ -419,13 +421,10 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		struct power_actor *pa = &power[i];
 
-		cdev = instance->cdev;
-
-		if (instance->trip != params->trip_max)
+		if (!power_actor_is_valid(params, instance))
 			continue;
 
-		if (!cdev_is_power_actor(cdev))
-			continue;
+		cdev = instance->cdev;
 
 		ret = cdev->ops->get_requested_power(cdev, &pa->req_power);
 		if (ret)
@@ -459,10 +458,7 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		struct power_actor *pa = &power[i];
 
-		if (instance->trip != params->trip_max)
-			continue;
-
-		if (!cdev_is_power_actor(instance->cdev))
+		if (!power_actor_is_valid(params, instance))
 			continue;
 
 		power_actor_set_power(instance->cdev, instance,
@@ -548,12 +544,11 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
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
@@ -648,8 +643,7 @@ static void power_allocator_update_tz(struct thermal_zone_device *tz,
 	case THERMAL_TZ_BIND_CDEV:
 	case THERMAL_TZ_UNBIND_CDEV:
 		list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-			if ((instance->trip == params->trip_max) &&
-			    cdev_is_power_actor(instance->cdev))
+			if (power_actor_is_valid(params, instance))
 				num_actors++;
 
 		if (num_actors == params->num_actors)
-- 
2.25.1


