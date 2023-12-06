Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94143806DF9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377688AbjLFLaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377692AbjLFLam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:30:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E21ED4B;
        Wed,  6 Dec 2023 03:30:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38AEF153B;
        Wed,  6 Dec 2023 03:31:33 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.1.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ECCE13F5A1;
        Wed,  6 Dec 2023 03:30:45 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH 2/5] thermal: gov_power_allocator: Refactor check_power_actors()
Date:   Wed,  6 Dec 2023 11:31:35 +0000
Message-Id: <20231206113138.3576492-3-lukasz.luba@arm.com>
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

Refactor check_power_actors() to make it possible for re-use in the
upcoming new callback.

No intentional functional impact.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/gov_power_allocator.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 785fff14223d..38e1e89ba10c 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -581,8 +581,9 @@ static void allow_maximum_power(struct thermal_zone_device *tz, bool update)
  * power actor API. The warning should help to investigate the issue, which
  * could be e.g. lack of Energy Model for a given device.
  *
- * Return: 0 on success, -EINVAL if any cooling device does not implement
- * the power actor API.
+ * Return number of cooling devices or -EINVAL if any cooling device does not
+ * implement the power actor API. Return value 0 is also valid since cooling
+ * devices might be attached later.
  */
 static int check_power_actors(struct thermal_zone_device *tz,
 			      struct power_allocator_params *params)
@@ -597,8 +598,9 @@ static int check_power_actors(struct thermal_zone_device *tz,
 		if (!cdev_is_power_actor(instance->cdev)) {
 			dev_warn(&tz->device, "power_allocator: %s is not a power actor\n",
 				 instance->cdev->type);
-			ret = -EINVAL;
+			return -EINVAL;
 		}
+		ret++;
 	}
 
 	return ret;
@@ -631,7 +633,7 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 	}
 
 	ret = check_power_actors(tz, params);
-	if (ret) {
+	if (ret < 0) {
 		dev_warn(&tz->device, "power_allocator: binding failed\n");
 		kfree(params);
 		return ret;
-- 
2.25.1

