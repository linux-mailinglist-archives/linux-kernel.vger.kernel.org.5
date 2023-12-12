Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C364C80EDFF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376343AbjLLNr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346686AbjLLNrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:47:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D6F6CD;
        Tue, 12 Dec 2023 05:47:58 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE0491474;
        Tue, 12 Dec 2023 05:48:44 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 298873F738;
        Tue, 12 Dec 2023 05:47:57 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com
Subject: [PATCH v2 1/8] thermal: core: Add governor callback for thermal zone change
Date:   Tue, 12 Dec 2023 13:48:37 +0000
Message-Id: <20231212134844.1213381-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212134844.1213381-1-lukasz.luba@arm.com>
References: <20231212134844.1213381-1-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new callback which can update governors when there is a change in
the thermal zone internals, e.g. thermal cooling instance list changed.

That makes possible to move some heavy operations like memory allocations
related to the number of cooling instances out of the throttle() callback.

Reuse the 'enum thermal_notify_event' and extend it with a new event:
THERMAL_INSTANCE_LIST_UPDATE.

Both callback code paths (throttle() and update_tz()) are protected with
the same thermal zone lock, which guaranties the consistency.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.c | 13 +++++++++++++
 include/linux/thermal.h        |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 625ba07cbe2f..592c956f6fd5 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -314,6 +314,14 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz,
 		       def_governor->throttle(tz, trip);
 }
 
+static void handle_instances_list_update(struct thermal_zone_device *tz)
+{
+	if (!tz->governor || !tz->governor->update_tz)
+		return;
+
+	tz->governor->update_tz(tz, THERMAL_INSTANCE_LIST_UPDATE);
+}
+
 void thermal_zone_device_critical(struct thermal_zone_device *tz)
 {
 	/*
@@ -723,6 +731,8 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 		list_add_tail(&dev->tz_node, &tz->thermal_instances);
 		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
 		atomic_set(&tz->need_update, 1);
+
+		handle_instances_list_update(tz);
 	}
 	mutex_unlock(&cdev->lock);
 	mutex_unlock(&tz->lock);
@@ -781,6 +791,9 @@ int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
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
index c7190e2dfcb4..9fd0d3fb234a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -51,6 +51,7 @@ enum thermal_notify_event {
 	THERMAL_DEVICE_POWER_CAPABILITY_CHANGED, /* power capability changed */
 	THERMAL_TABLE_CHANGED, /* Thermal table(s) changed */
 	THERMAL_EVENT_KEEP_ALIVE, /* Request for user space handler to respond */
+	THERMAL_INSTANCE_LIST_UPDATE, /* List of thermal instances changed */
 };
 
 /**
@@ -195,6 +196,8 @@ struct thermal_zone_device {
  *			thermal zone.
  * @throttle:	callback called for every trip point even if temperature is
  *		below the trip point temperature
+ * @update_tz:	callback called when thermal zone internals have changed, e.g.
+ *		thermal cooling instance was added/removed
  * @governor_list:	node in thermal_governor_list (in thermal_core.c)
  */
 struct thermal_governor {
@@ -203,6 +206,8 @@ struct thermal_governor {
 	void (*unbind_from_tz)(struct thermal_zone_device *tz);
 	int (*throttle)(struct thermal_zone_device *tz,
 			const struct thermal_trip *trip);
+	void (*update_tz)(struct thermal_zone_device *tz,
+			  enum thermal_notify_event reason);
 	struct list_head	governor_list;
 };
 
-- 
2.25.1

