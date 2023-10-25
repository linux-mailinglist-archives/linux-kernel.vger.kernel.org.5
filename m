Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456B27D7428
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjJYTVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjJYTVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:21:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB8E013D;
        Wed, 25 Oct 2023 12:21:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50C091424;
        Wed, 25 Oct 2023 12:22:28 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.81.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7ABB43F738;
        Wed, 25 Oct 2023 12:21:45 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH 4/7] thermal: gov_power_allocator: Rearrange the order of variables
Date:   Wed, 25 Oct 2023 20:22:22 +0100
Message-Id: <20231025192225.468228-5-lukasz.luba@arm.com>
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

Rearrange the order of variables in function and make them aligned with
the standard order for the kernel coding style. Also, move some variables
defined in nested code into the top of the function, to improve visibility
off all variables used.

This change is not expected to alter the general functionality.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 39 ++++++++++++++-------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 4b9ef04577a9a..79621b42ead38 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -84,13 +84,14 @@ struct power_allocator_params {
  */
 static u32 estimate_sustainable_power(struct thermal_zone_device *tz)
 {
-	u32 sustainable_power = 0;
-	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
+	struct thermal_cooling_device *cdev;
+	struct thermal_instance *instance;
+	u32 sustainable_power = 0;
+	u32 min_power;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		struct thermal_cooling_device *cdev = instance->cdev;
-		u32 min_power;
+		cdev = instance->cdev;
 
 		if (instance->trip != params->trip_max)
 			continue;
@@ -211,10 +212,10 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 			  int control_temp,
 			  u32 max_allocatable_power)
 {
+	struct power_allocator_params *params = tz->governor_data;
 	s64 p, i, d, power_range;
 	s32 err, max_power_frac;
 	u32 sustainable_power;
-	struct power_allocator_params *params = tz->governor_data;
 
 	max_power_frac = int_to_frac(max_allocatable_power);
 
@@ -373,20 +374,20 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 		}
 }
 
-static int allocate_power(struct thermal_zone_device *tz,
-			  int control_temp)
+static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 {
-	struct thermal_instance *instance;
+	u32 total_req_power, max_allocatable_power, total_weighted_req_power;
+	u32 *req_power, *max_power, *granted_power, *extra_actor_power;
 	struct power_allocator_params *params = tz->governor_data;
 	const struct thermal_trip *trip_max = params->trip_max;
-	u32 *req_power, *max_power, *granted_power, *extra_actor_power;
-	u32 *weighted_req_power;
-	u32 total_req_power, max_allocatable_power, total_weighted_req_power;
 	u32 total_granted_power, power_range;
-	int i, num_actors, total_weight, ret = 0;
+	struct thermal_cooling_device *cdev;
+	struct thermal_instance *instance;
+	u32 *weighted_req_power;
+	int i, weight, ret = 0;
+	int total_weight = 0;
+	int num_actors = 0;
 
-	num_actors = 0;
-	total_weight = 0;
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if ((instance->trip == trip_max) &&
 		    cdev_is_power_actor(instance->cdev)) {
@@ -424,8 +425,7 @@ static int allocate_power(struct thermal_zone_device *tz,
 	max_allocatable_power = 0;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		int weight;
-		struct thermal_cooling_device *cdev = instance->cdev;
+		cdev = instance->cdev;
 
 		if (instance->trip != trip_max)
 			continue;
@@ -547,12 +547,13 @@ static void reset_pid_controller(struct power_allocator_params *params)
 
 static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
 {
-	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
+	struct thermal_cooling_device *cdev;
+	struct thermal_instance *instance;
 	u32 req_power;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		struct thermal_cooling_device *cdev = instance->cdev;
+		cdev = instance->cdev;
 
 		if (instance->trip != params->trip_max ||
 		    !cdev_is_power_actor(instance->cdev))
@@ -619,8 +620,8 @@ static int check_power_actors(struct thermal_zone_device *tz,
  */
 static int power_allocator_bind(struct thermal_zone_device *tz)
 {
-	int ret;
 	struct power_allocator_params *params;
+	int ret;
 
 	params = kzalloc(sizeof(*params), GFP_KERNEL);
 	if (!params)
-- 
2.25.1

