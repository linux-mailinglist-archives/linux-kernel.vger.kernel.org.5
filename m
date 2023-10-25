Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992EF7D7429
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjJYTVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjJYTVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:21:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00231137;
        Wed, 25 Oct 2023 12:21:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70B181474;
        Wed, 25 Oct 2023 12:22:25 -0700 (PDT)
Received: from e129166.arm.com (unknown [10.57.81.88])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9A9EB3F738;
        Wed, 25 Oct 2023 12:21:42 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH 2/7] thermal: gov_power_allocator: Setup trip points earlier
Date:   Wed, 25 Oct 2023 20:22:20 +0100
Message-Id: <20231025192225.468228-3-lukasz.luba@arm.com>
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

Setup the trip points at the beginning of the binding function. This
simplifies the code a bit and allows further cleaning. Add also the
check if the last passive trip point is found and fail binding if not.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 97a8a6e4e1b0b..0dfc5b5ab5235 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -617,14 +617,24 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	int ret;
 	struct power_allocator_params *params;
 
-	ret = check_power_actors(tz);
-	if (ret)
-		return ret;
-
 	params = kzalloc(sizeof(*params), GFP_KERNEL);
 	if (!params)
 		return -ENOMEM;
 
+	get_governor_trips(tz, params);
+	if (!params->trip_max) {
+		dev_warn(&tz->device, "power_allocator: missing trip_max\n");
+		kfree(params);
+		return -EINVAL;
+	}
+
+	ret = check_power_actors(tz);
+	if (ret) {
+		dev_warn(&tz->device, "power_allocator: binding failed\n");
+		kfree(params);
+		return ret;
+	}
+
 	if (!tz->tzp) {
 		tz->tzp = kzalloc(sizeof(*tz->tzp), GFP_KERNEL);
 		if (!tz->tzp) {
@@ -638,12 +648,9 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	if (!tz->tzp->sustainable_power)
 		dev_warn(&tz->device, "power_allocator: sustainable_power will be estimated\n");
 
-	get_governor_trips(tz, params);
-
-	if (params->trip_max)
-		estimate_pid_constants(tz, tz->tzp->sustainable_power,
-				       params->trip_switch_on,
-				       params->trip_max->temperature);
+	estimate_pid_constants(tz, tz->tzp->sustainable_power,
+			       params->trip_switch_on,
+			       params->trip_max->temperature);
 
 	reset_pid_controller(params);
 
-- 
2.25.1

