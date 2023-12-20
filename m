Return-Path: <linux-kernel+bounces-7631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B88D81AAFD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ADA6B21FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AE74D589;
	Wed, 20 Dec 2023 23:17:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597DB4A9BB;
	Wed, 20 Dec 2023 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F712152B;
	Wed, 20 Dec 2023 15:17:52 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D54F43F64C;
	Wed, 20 Dec 2023 15:17:05 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v3 9/9] thermal: gov_power_allocator: Support new update callback of weights
Date: Wed, 20 Dec 2023 23:17:53 +0000
Message-Id: <20231220231753.1824364-10-lukasz.luba@arm.com>
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

When the thermal instance's weight is updated from the sysfs the governor
update_tz() callback is triggered. Implement proper reaction to this
event in the IPA, which would save CPU cycles spent in throttle().
This will speed-up the main throttle() IPA function and clean it up
a bit.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index b5ec60ae7efd..7b6aa265ff6a 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -77,6 +77,7 @@ struct power_actor {
  *			@trip_switch_on should be NULL.
  * @trip_max:		last passive trip point of the thermal zone. The
  *			temperature we are controlling for.
+ * @total_weight:	Sum of all thermal instances weights
  * @num_actors:		number of cooling devices supporting IPA callbacks
  * @buffer_size:	internal buffer size, to avoid runtime re-calculation
  * @power:		buffer for all power actors internal power information
@@ -88,6 +89,7 @@ struct power_allocator_params {
 	u32 sustainable_power;
 	const struct thermal_trip *trip_switch_on;
 	const struct thermal_trip *trip_max;
+	int total_weight;
 	unsigned int num_actors;
 	unsigned int buffer_size;
 	struct power_actor *power;
@@ -405,16 +407,11 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 	u32 total_granted_power = 0;
 	u32 total_req_power = 0;
 	u32 power_range, weight;
-	int total_weight = 0;
 	int i = 0, ret;
 
 	if (!num_actors)
 		return -ENODEV;
 
-	list_for_each_entry(instance, &tz->thermal_instances, tz_node)
-		if (power_actor_is_valid(params, instance))
-			total_weight += instance->weight;
-
 	/* Clean all buffers for new power estimations */
 	memset(power, 0, params->buffer_size);
 
@@ -430,7 +427,7 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 		if (ret)
 			continue;
 
-		if (!total_weight)
+		if (!params->total_weight)
 			weight = 1 << FRAC_BITS;
 		else
 			weight = instance->weight;
@@ -651,6 +648,12 @@ static void power_allocator_update_tz(struct thermal_zone_device *tz,
 
 		allocate_actors_buffer(params, num_actors);
 		break;
+	case THERMAL_INSTANCE_WEIGHT_CHANGED:
+		params->total_weight = 0;
+		list_for_each_entry(instance, &tz->thermal_instances, tz_node)
+			if (power_actor_is_valid(params, instance))
+				params->total_weight += instance->weight;
+		break;
 	default:
 		break;
 	}
-- 
2.25.1


