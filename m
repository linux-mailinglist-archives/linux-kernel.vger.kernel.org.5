Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1A27D742E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbjJYTV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjJYTVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:21:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE0E9183;
        Wed, 25 Oct 2023 12:21:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B7962F4;
        Wed, 25 Oct 2023 12:22:31 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.81.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 663653F7C5;
        Wed, 25 Oct 2023 12:21:48 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH 6/7] thermal: gov_power_allocator: Remove unneeded local variables
Date:   Wed, 25 Oct 2023 20:22:24 +0100
Message-Id: <20231025192225.468228-7-lukasz.luba@arm.com>
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

There is no need to keep some variables. We have a shorter name variables
in the governor private structure 'trip_max'. Remove the local 'trip_max'
and 'ret' variables from the allocate_power().

This change is not expected to alter the general functionality.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 0f7f8278eacc5..e6d2f0fe8d2fd 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -379,17 +379,16 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 	u32 total_req_power, max_allocatable_power, total_weighted_req_power;
 	u32 *req_power, *max_power, *granted_power, *extra_actor_power;
 	struct power_allocator_params *params = tz->governor_data;
-	const struct thermal_trip *trip_max = params->trip_max;
 	u32 total_granted_power, power_range;
 	struct thermal_cooling_device *cdev;
 	struct thermal_instance *instance;
 	u32 *weighted_req_power;
-	int i, weight, ret = 0;
 	int total_weight = 0;
 	int num_actors = 0;
+	int i, weight;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if ((instance->trip == trip_max) &&
+		if ((instance->trip == params->trip_max) &&
 		    cdev_is_power_actor(instance->cdev)) {
 			num_actors++;
 			total_weight += instance->weight;
@@ -427,7 +426,7 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		cdev = instance->cdev;
 
-		if (instance->trip != trip_max)
+		if (instance->trip != params->trip_max)
 			continue;
 
 		if (!cdev_is_power_actor(cdev))
@@ -463,7 +462,7 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 	total_granted_power = 0;
 	i = 0;
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip_max)
+		if (instance->trip != params->trip_max)
 			continue;
 
 		if (!cdev_is_power_actor(instance->cdev))
@@ -484,7 +483,7 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 
 	kfree(req_power);
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.25.1

