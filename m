Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916897D7426
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjJYTVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjJYTVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:21:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A46E13A;
        Wed, 25 Oct 2023 12:21:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB2DB2F4;
        Wed, 25 Oct 2023 12:22:26 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.81.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1143A3F738;
        Wed, 25 Oct 2023 12:21:43 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH 3/7] thermal: gov_power_allocator: Check the cooling devices only for trip_max
Date:   Wed, 25 Oct 2023 20:22:21 +0100
Message-Id: <20231025192225.468228-4-lukasz.luba@arm.com>
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

The throttling logic takes care only for the last passive trip point and
attached cooling devices to it. Therefore, there is no need to bail out if
other trip points have a cooling device which is not a supported by IPA.

Check the cooling devices only for the 'trip_max' during the binding.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 0dfc5b5ab5235..4b9ef04577a9a 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -578,6 +578,7 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
  * check_power_actors() - Check all cooling devices and warn when they are
  *			not power actors
  * @tz:		thermal zone to operate on
+ * @params:	power allocator private data
  *
  * Check all cooling devices in the @tz and warn every time they are missing
  * power actor API. The warning should help to investigate the issue, which
@@ -586,12 +587,16 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
  * Return: 0 on success, -EINVAL if any cooling device does not implement
  * the power actor API.
  */
-static int check_power_actors(struct thermal_zone_device *tz)
+static int check_power_actors(struct thermal_zone_device *tz,
+			      struct power_allocator_params *params)
 {
 	struct thermal_instance *instance;
 	int ret = 0;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
+		if (instance->trip != params->trip_max)
+			continue;
+
 		if (!cdev_is_power_actor(instance->cdev)) {
 			dev_warn(&tz->device, "power_allocator: %s is not a power actor\n",
 				 instance->cdev->type);
@@ -628,7 +633,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 		return -EINVAL;
 	}
 
-	ret = check_power_actors(tz);
+	ret = check_power_actors(tz, params);
 	if (ret) {
 		dev_warn(&tz->device, "power_allocator: binding failed\n");
 		kfree(params);
-- 
2.25.1

