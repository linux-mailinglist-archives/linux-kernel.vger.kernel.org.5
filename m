Return-Path: <linux-kernel+bounces-7623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E23E81AAED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507441C21CDF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5674B143;
	Wed, 20 Dec 2023 23:16:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C3C482E6;
	Wed, 20 Dec 2023 23:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D6671063;
	Wed, 20 Dec 2023 15:17:40 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F29473F64C;
	Wed, 20 Dec 2023 15:16:53 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Subject: [PATCH v3 1/9] thermal: core: Add governor callback for thermal zone change
Date: Wed, 20 Dec 2023 23:17:45 +0000
Message-Id: <20231220231753.1824364-2-lukasz.luba@arm.com>
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

Add a new callback to the struct thermal_governor. It can be used for
updating governors when there is a change in the thermal zone internals,
e.g. thermal cooling device is bind to the thermal zone.

That makes possible to move some heavy operations like memory allocations
related to the number of cooling instances out of the throttle() callback.

Both callback code paths (throttle() and update_tz()) are protected with
the same thermal zone lock, which guaranties the consistency.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/thermal_core.c | 14 ++++++++++++++
 drivers/thermal/thermal_core.h |  2 ++
 include/linux/thermal.h        |  6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 0d761afb7cbc..62979c5401c3 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -311,6 +311,15 @@ static void handle_non_critical_trips(struct thermal_zone_device *tz,
 		       def_governor->throttle(tz, trip);
 }
 
+void thermal_governor_update_tz(struct thermal_zone_device *tz,
+				enum thermal_notify_event reason)
+{
+	if (!tz->governor || !tz->governor->update_tz)
+		return;
+
+	tz->governor->update_tz(tz, reason);
+}
+
 static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool shutdown)
 {
 	/*
@@ -727,6 +736,8 @@ int thermal_bind_cdev_to_trip(struct thermal_zone_device *tz,
 		list_add_tail(&dev->tz_node, &tz->thermal_instances);
 		list_add_tail(&dev->cdev_node, &cdev->thermal_instances);
 		atomic_set(&tz->need_update, 1);
+
+		thermal_governor_update_tz(tz, THERMAL_TZ_BIND_CDEV);
 	}
 	mutex_unlock(&cdev->lock);
 	mutex_unlock(&tz->lock);
@@ -785,6 +796,9 @@ int thermal_unbind_cdev_from_trip(struct thermal_zone_device *tz,
 		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
 			list_del(&pos->tz_node);
 			list_del(&pos->cdev_node);
+
+			thermal_governor_update_tz(tz, THERMAL_TZ_UNBIND_CDEV);
+
 			mutex_unlock(&cdev->lock);
 			mutex_unlock(&tz->lock);
 			goto unbind;
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index b5e6743bd157..e6a2b6f97be8 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -115,6 +115,8 @@ int thermal_build_list_of_policies(char *buf);
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event);
 void thermal_zone_device_critical_reboot(struct thermal_zone_device *tz);
+void thermal_governor_update_tz(struct thermal_zone_device *tz,
+				enum thermal_notify_event reason);
 
 /* Helpers */
 #define for_each_trip(__tz, __trip)	\
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c0fabbcdefb9..1b76878cea46 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -51,6 +51,8 @@ enum thermal_notify_event {
 	THERMAL_DEVICE_POWER_CAPABILITY_CHANGED, /* power capability changed */
 	THERMAL_TABLE_CHANGED, /* Thermal table(s) changed */
 	THERMAL_EVENT_KEEP_ALIVE, /* Request for user space handler to respond */
+	THERMAL_TZ_BIND_CDEV, /* Cooling dev is bind to the thermal zone */
+	THERMAL_TZ_UNBIND_CDEV, /* Cooling dev is unbind from the thermal zone */
 };
 
 /**
@@ -197,6 +199,8 @@ struct thermal_zone_device {
  *			thermal zone.
  * @throttle:	callback called for every trip point even if temperature is
  *		below the trip point temperature
+ * @update_tz:	callback called when thermal zone internals have changed, e.g.
+ *		thermal cooling instance was added/removed
  * @governor_list:	node in thermal_governor_list (in thermal_core.c)
  */
 struct thermal_governor {
@@ -205,6 +209,8 @@ struct thermal_governor {
 	void (*unbind_from_tz)(struct thermal_zone_device *tz);
 	int (*throttle)(struct thermal_zone_device *tz,
 			const struct thermal_trip *trip);
+	void (*update_tz)(struct thermal_zone_device *tz,
+			  enum thermal_notify_event reason);
 	struct list_head	governor_list;
 };
 
-- 
2.25.1


