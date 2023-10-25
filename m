Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813577D742F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjJYTWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjJYTVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:21:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 462E0187;
        Wed, 25 Oct 2023 12:21:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5C5D1424;
        Wed, 25 Oct 2023 12:22:32 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.81.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D02F13F7C5;
        Wed, 25 Oct 2023 12:21:49 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH 7/7] thermal: gov_power_allocator: Clean needed variables at the beginning
Date:   Wed, 25 Oct 2023 20:22:25 +0100
Message-Id: <20231025192225.468228-8-lukasz.luba@arm.com>
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

Rearrange the local variables setup. This improves the reading of the code
and allows to better see the initial values;

This change is not expected to alter the general functionality.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index e6d2f0fe8d2fd..785fff14223d8 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -376,16 +376,19 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 
 static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 {
-	u32 total_req_power, max_allocatable_power, total_weighted_req_power;
 	u32 *req_power, *max_power, *granted_power, *extra_actor_power;
 	struct power_allocator_params *params = tz->governor_data;
-	u32 total_granted_power, power_range;
 	struct thermal_cooling_device *cdev;
 	struct thermal_instance *instance;
+	u32 total_weighted_req_power = 0;
+	u32 max_allocatable_power = 0;
+	u32 total_granted_power = 0;
+	u32 total_req_power = 0;
 	u32 *weighted_req_power;
+	u32 power_range, weight;
 	int total_weight = 0;
 	int num_actors = 0;
-	int i, weight;
+	int i = 0;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if ((instance->trip == params->trip_max) &&
@@ -418,11 +421,6 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 	extra_actor_power = &req_power[3 * num_actors];
 	weighted_req_power = &req_power[4 * num_actors];
 
-	i = 0;
-	total_weighted_req_power = 0;
-	total_req_power = 0;
-	max_allocatable_power = 0;
-
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		cdev = instance->cdev;
 
@@ -459,7 +457,6 @@ static int allocate_power(struct thermal_zone_device *tz, int control_temp)
 		       total_weighted_req_power, power_range, granted_power,
 		       extra_actor_power);
 
-	total_granted_power = 0;
 	i = 0;
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		if (instance->trip != params->trip_max)
-- 
2.25.1

