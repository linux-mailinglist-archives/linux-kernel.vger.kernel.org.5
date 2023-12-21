Return-Path: <linux-kernel+bounces-8087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B9381B202
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 003D2B27584
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB318219F1;
	Thu, 21 Dec 2023 09:05:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7528208D6;
	Thu, 21 Dec 2023 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B27092F4;
	Thu, 21 Dec 2023 01:06:28 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.87.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E09F03F5A1;
	Thu, 21 Dec 2023 01:05:41 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	m.majewski2@samsung.com,
	bzolnier@gmail.com,
	m.szyprowski@samsung.com,
	krzysztof.kozlowski@linaro.org,
	linux-samsung-soc@vger.kernel.org
Subject: [RFC PATCH] thermal: Add API to update framework with known temperature
Date: Thu, 21 Dec 2023 09:06:37 +0000
Message-Id: <20231221090637.1996394-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some thermal drivers support trip point interrupts. These IRQs are
triggered when the defined temperature threshold value is reached. This
information is enough to say what is the temperature. Therefore, create
a new API, which allows to provide temperature value as an argument and
avoid reading the temperature again by in the framework function. This
would also avoid scenario when the temperature which is later read via
update_temperature() is different than the one which triggered the IRQ.
This issue has been reported on some mainline boards.

It should also improve performance in such scenario, since there is no
call to __thermal_zone_get_temp() in the code path (which might be heavy,
when temperature sensor is connected via slow interface).

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
Hi all,

This is a RFC with proposal to skip reading temperature using get_temp()
callback when calling thermal_zone_device_update() from thermal driver IRQ
hanlder. There was a discussion [1] that reading temperature after the IRQ
might give different value than that IRQ trip threshold was programmed. 

Therefore, this proposal aims to solve the situation and feed temperature
to the thermal fwk as an argument.

Regards,
Lukasz

[1] https://lore.kernel.org/lkml/20231113130435.500353-1-m.majewski2@samsung.com/


 drivers/thermal/thermal_core.c  | 29 ++++++++++++++++++++++++-----
 drivers/thermal/thermal_core.h  |  3 ++-
 drivers/thermal/thermal_sysfs.c |  6 ++++--
 drivers/thermal/thermal_trip.c  |  2 +-
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 62979c5401c3..9f25c62bd3cd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -417,10 +417,16 @@ static void handle_thermal_trip(struct thermal_zone_device *tz,
 		handle_non_critical_trips(tz, trip);
 }
 
-static void update_temperature(struct thermal_zone_device *tz)
+static void update_temperature(struct thermal_zone_device *tz, bool read_temp,
+			       int known_temp)
 {
 	int temp, ret;
 
+	if (!read_temp) {
+		temp = known_temp;
+		goto set_temperature;
+	}
+
 	ret = __thermal_zone_get_temp(tz, &temp);
 	if (ret) {
 		if (ret != -EAGAIN)
@@ -430,6 +436,7 @@ static void update_temperature(struct thermal_zone_device *tz)
 		return;
 	}
 
+set_temperature:
 	tz->last_temperature = tz->temperature;
 	tz->temperature = temp;
 
@@ -449,7 +456,8 @@ static void thermal_zone_device_init(struct thermal_zone_device *tz)
 }
 
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
-				  enum thermal_notify_event event)
+				  enum thermal_notify_event event,
+				  bool read_temp, int temp)
 {
 	struct thermal_trip *trip;
 
@@ -459,7 +467,7 @@ void __thermal_zone_device_update(struct thermal_zone_device *tz,
 	if (!thermal_zone_device_is_enabled(tz))
 		return;
 
-	update_temperature(tz);
+	update_temperature(tz, read_temp, temp);
 
 	__thermal_zone_set_trips(tz);
 
@@ -491,7 +499,7 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 	if (!ret)
 		tz->mode = mode;
 
-	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+	__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED, true, 0);
 
 	mutex_unlock(&tz->lock);
 
@@ -532,11 +540,22 @@ void thermal_zone_device_update(struct thermal_zone_device *tz,
 {
 	mutex_lock(&tz->lock);
 	if (thermal_zone_is_present(tz))
-		__thermal_zone_device_update(tz, event);
+		__thermal_zone_device_update(tz, event, true, 0);
 	mutex_unlock(&tz->lock);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_update);
 
+void thermal_zone_device_update_with_temp(struct thermal_zone_device *tz,
+					  enum thermal_notify_event event,
+					  int temp)
+{
+	mutex_lock(&tz->lock);
+	if (thermal_zone_is_present(tz))
+		__thermal_zone_device_update(tz, event, false, temp);
+	mutex_unlock(&tz->lock);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_update_with_temp);
+
 static void thermal_zone_device_check(struct work_struct *work)
 {
 	struct thermal_zone_device *tz = container_of(work, struct
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index e6a2b6f97be8..2d73847fcfea 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -113,7 +113,8 @@ void thermal_unregister_governor(struct thermal_governor *);
 int thermal_zone_device_set_policy(struct thermal_zone_device *, char *);
 int thermal_build_list_of_policies(char *buf);
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
-				  enum thermal_notify_event event);
+				  enum thermal_notify_event event,
+				  bool read_temp, int temp);
 void thermal_zone_device_critical_reboot(struct thermal_zone_device *tz);
 void thermal_governor_update_tz(struct thermal_zone_device *tz,
 				enum thermal_notify_event reason);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 5abf6d136c24..9062545f314e 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -131,7 +131,8 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 
 		thermal_zone_set_trip_temp(tz, trip, temp);
 
-		__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+		__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED,
+					     true, 0);
 	}
 
 unlock:
@@ -256,7 +257,8 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 		ret = tz->ops->set_emul_temp(tz, temperature);
 
 	if (!ret)
-		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
+		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED,
+					     true, 0);
 
 	mutex_unlock(&tz->lock);
 
diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index a1ad345c0741..77dc433e6e1c 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -158,7 +158,7 @@ void thermal_zone_trip_updated(struct thermal_zone_device *tz,
 	thermal_notify_tz_trip_change(tz->id, thermal_zone_trip_id(tz, trip),
 				      trip->type, trip->temperature,
 				      trip->hysteresis);
-	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
+	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED, true, 0);
 }
 
 void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
-- 
2.25.1


