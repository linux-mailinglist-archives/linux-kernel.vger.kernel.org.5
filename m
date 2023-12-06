Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB6F806DFE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377593AbjLFLbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377613AbjLFLap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:30:45 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD59E137;
        Wed,  6 Dec 2023 03:30:51 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EC1B150C;
        Wed,  6 Dec 2023 03:31:37 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.1.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5E7873F5A1;
        Wed,  6 Dec 2023 03:30:50 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH 5/5] thermal: gov_power_allocator: Refactor checks in divvy_up_power()
Date:   Wed,  6 Dec 2023 11:31:38 +0000
Message-Id: <20231206113138.3576492-6-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206113138.3576492-1-lukasz.luba@arm.com>
References: <20231206113138.3576492-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code and remove one extra 'if' block.

No intentional functional impact.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 8f2d2ee3def0..350a39c23ac4 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -349,7 +349,8 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 			   u32 total_req_power, u32 power_range,
 			   u32 *granted_power, u32 *extra_actor_power)
 {
-	u32 extra_power, capped_extra_power;
+	u32 capped_extra_power = 0;
+	u32 extra_power = 0;
 	int i;
 
 	/*
@@ -358,8 +359,6 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 	if (!total_req_power)
 		total_req_power = 1;
 
-	capped_extra_power = 0;
-	extra_power = 0;
 	for (i = 0; i < num_actors; i++) {
 		u64 req_range = (u64)req_power[i] * power_range;
 
@@ -375,7 +374,7 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 		capped_extra_power += extra_actor_power[i];
 	}
 
-	if (!extra_power)
+	if (!extra_power || !capped_extra_power)
 		return;
 
 	/*
@@ -383,12 +382,13 @@ static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
 	 * how far they are from the max
 	 */
 	extra_power = min(extra_power, capped_extra_power);
-	if (capped_extra_power > 0)
-		for (i = 0; i < num_actors; i++) {
-			u64 extra_range = (u64)extra_actor_power[i] * extra_power;
-			granted_power[i] += DIV_ROUND_CLOSEST_ULL(extra_range,
-							 capped_extra_power);
-		}
+
+	for (i = 0; i < num_actors; i++) {
+		u64 extra_range = (u64)extra_actor_power[i] * extra_power;
+
+		granted_power[i] += DIV_ROUND_CLOSEST_ULL(extra_range,
+						 capped_extra_power);
+	}
 }
 
 static int allocate_power(struct thermal_zone_device *tz, int control_temp)
-- 
2.25.1

