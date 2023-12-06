Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F49806DF6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377630AbjLFLau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377687AbjLFLam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:30:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D96DADE;
        Wed,  6 Dec 2023 03:30:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8044150C;
        Wed,  6 Dec 2023 03:31:31 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.1.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 762793F5A1;
        Wed,  6 Dec 2023 03:30:44 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH 1/5] thermal: core: Add callback for governors with cooling instances change
Date:   Wed,  6 Dec 2023 11:31:34 +0000
Message-Id: <20231206113138.3576492-2-lukasz.luba@arm.com>
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

Allow governors to react to the changes in the cooling instances list.
That makes possible to move memory allocations related to the number of
cooling instances out of the throttle() callback. The throttle() callback
is called much more often thus the cost of managing allocations there is
an extra overhead. The list of cooling instances is not changed that often
and it can be handled in dedicated callback. That will save CPU cycles
in the throttle() code path.  Both callbacks code paths are protected with
the same thermal zone lock, which guaranties the list of cooling instances
is consistent.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.c | 14 ++++++++++++++
 include/linux/thermal.h        |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 625ba07cbe2f..c993b86f7fb5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -314,6 +314,15 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz,
 		       def_governor->throttle(tz, trip);
 }
 
+static void handle_instances_list_update(struct thermal_zone_device *tz)
+{
+
+	if (!tz->governor || !tz->governor->instances_update)
+		return;
+
+	tz->governor->instances_update(tz);
+}
+
 void thermal_zone_device_critical(struct thermal_zone_device *tz)
 {
 	/*
@@ -723,6 +732,8 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 		list_add_tail(&dev->tz_node, &tz->thermal_instances);
 		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
 		atomic_set(&tz->need_update, 1);
+
+		handle_instances_list_update(tz);
 	}
 	mutex_unlock(&cdev->lock);
 	mutex_unlock(&tz->lock);
@@ -781,6 +792,9 @@ int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
 		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
 			list_del(&pos->tz_node);
 			list_del(&pos->cdev_node);
+
+			handle_instances_list_update(tz);
+
 			mutex_unlock(&cdev->lock);
 			mutex_unlock(&tz->lock);
 			goto unbind;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c7190e2dfcb4..e7b2a1f4bab0 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -195,6 +195,9 @@ struct thermal_zone_device {
  *			thermal zone.
  * @throttle:	callback called for every trip point even if temperature is
  *		below the trip point temperature
+ * @instances_update:	callback called when thermal zone instances list
+ *	i		has changed (e.g. added new or removed), which
+ *			may help to offload work for governor like allocations
  * @governor_list:	node in thermal_governor_list (in thermal_core.c)
  */
 struct thermal_governor {
@@ -203,6 +206,7 @@ struct thermal_governor {
 	void (*unbind_from_tz)(struct thermal_zone_device *tz);
 	int (*throttle)(struct thermal_zone_device *tz,
 			const struct thermal_trip *trip);
+	void (*instances_update)(struct thermal_zone_device *tz);
 	struct list_head	governor_list;
 };
 
-- 
2.25.1

