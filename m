Return-Path: <linux-kernel+bounces-44471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA76984227D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE29F1C26C72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DDC67E9A;
	Tue, 30 Jan 2024 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z9tPo+Z7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112BD66B5E;
	Tue, 30 Jan 2024 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613200; cv=none; b=hbk9tC1LPtbNWJNo7ovBwOYvy9mIfmi1EuKepMJuVR+gPapso26JV0FJd1A3KHMx/EitL1I3dsFoi85qyCXIIimzEESI6yIqHm2UoUu0w8012xcrjDXn0y3teYOE0qbCh5fVj84kVrWbH2ja60undy5EAyB1KNbH2RUgS4GHE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613200; c=relaxed/simple;
	bh=K9DIWCqRftNmAdLpTI5zlUjzjPBqeZyH/4bsZP2hZCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhYsd+XyVo2eL/unuwl4dbCkEjEDskx8WmJA4HqamZW1+aep1nx+AL+6xRpIyduesr7XjoeAaKg0NoxkoBtYHUfT06lUT8b0k4p3IEz/VU9FeFTYQfA/6blUx9a3cJ4IkCVYlQTr8ljz1zwj8vmRAnNUJWH+KqGCAtgPMYavYno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z9tPo+Z7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613196;
	bh=K9DIWCqRftNmAdLpTI5zlUjzjPBqeZyH/4bsZP2hZCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z9tPo+Z7eXCToDiRV5CgFUeD7VDvEgBUavru6Wjyv3bYY3CqzRuXhqFubn01Zg+pG
	 ldrgAOOMyXzZZ0U8z3WbHXRRBPMT9Lsx0kPWyQKwZWJcY3xvegg4jj9/20tnloT03O
	 IWhb9n4qixWGyLN25VoXy4m25qA8tTMTQwGAOsILnwR2rGRSmrpPzQ6ilraDwtOmC0
	 g6nCHVDVf6sa+qb/D77cFN7CBctxOrisV1MLZGRwlukCMkzdKi4BLVpH2QbwGaHs9z
	 7brVnKi0PrbmDLRiAKKHYAcNdGIB+5Isk0jxaJw327X4HUwzfzggEfEJeR1Jvs3vBj
	 c6rkSk9IEMlNw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 738AD378208C;
	Tue, 30 Jan 2024 11:13:14 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: miquel.raynal@bootlin.com,
	rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	support.opensource@diasemi.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	niklas.soderlund@ragnatech.se,
	srinivas.pandruvada@linux.intel.com,
	angelogioacchino.delregno@collabora.com,
	baolin.wang@linux.alibaba.com,
	u.kleine-koenig@pengutronix.de,
	hayashi.kunihiko@socionext.com,
	d-gole@ti.com,
	linus.walleij@linaro.org,
	DLG-Adam.Ward.opensource@dm.renesas.com,
	error27@gmail.com,
	heiko@sntech.de,
	hdegoede@redhat.com,
	jernej.skrabec@gmail.com,
	f.fainelli@gmail.com,
	bchihi@baylibre.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v1 03/18] thermal: Directly use thermal_zone_platform_params for thermal_zone_device
Date: Tue, 30 Jan 2024 12:12:35 +0100
Message-ID: <20240130111250.185718-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove all duplicate members from thermal_zone_device and directly
use the corresponding ones from struct thermal_zone_platform_params.

Please note that this also changes thermal_zone_device's type member
from char[THERMAL_NAME_LENGTH] to a const char *pointer, as the only
reason for this to not be const was that thermal_core was performing
a string copy operation, which is no more.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/gov_user_space.c  |  2 +-
 drivers/thermal/thermal_core.c    | 65 ++++++++++++++-----------------
 drivers/thermal/thermal_core.h    |  6 ++-
 drivers/thermal/thermal_helpers.c | 14 +++----
 drivers/thermal/thermal_hwmon.c   |  8 ++--
 drivers/thermal/thermal_of.c      | 12 +++---
 drivers/thermal/thermal_sysfs.c   | 48 +++++++++++------------
 drivers/thermal/thermal_trace.h   |  8 ++--
 drivers/thermal/thermal_trip.c    | 14 +++----
 include/linux/thermal.h           | 10 -----
 10 files changed, 87 insertions(+), 100 deletions(-)

diff --git a/drivers/thermal/gov_user_space.c b/drivers/thermal/gov_user_space.c
index 7a1790b7e8f5..905f89f4aa4b 100644
--- a/drivers/thermal/gov_user_space.c
+++ b/drivers/thermal/gov_user_space.c
@@ -37,7 +37,7 @@ static int notify_user_space(struct thermal_zone_device *tz,
 
 	lockdep_assert_held(&tz->lock);
 
-	thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", tz->type);
+	thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", tz->tzp->type);
 	thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", tz->temperature);
 	thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=%d",
 				    thermal_zone_trip_id(tz, trip));
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 3150475b947f..5694e2df158e 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -75,7 +75,7 @@ static void bind_previous_governor(struct thermal_zone_device *tz,
 		if (tz->governor->bind_to_tz(tz)) {
 			dev_err(&tz->device,
 				"governor %s failed to bind and the previous one (%s) failed to bind again, thermal zone %s has no governor\n",
-				failed_gov_name, tz->governor->name, tz->type);
+				failed_gov_name, tz->governor->name, tz->tzp->type);
 			tz->governor = NULL;
 		}
 	}
@@ -156,7 +156,7 @@ int thermal_register_governor(struct thermal_governor *governor)
 			if (ret)
 				dev_err(&pos->device,
 					"Failed to set governor %s for thermal zone %s: %d\n",
-					governor->name, pos->type, ret);
+					governor->name, pos->tzp->type, ret);
 		}
 	}
 
@@ -327,7 +327,7 @@ static void thermal_zone_device_halt(struct thermal_zone_device *tz, bool shutdo
 	int poweroff_delay_ms = CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS;
 	const char *msg = "Temperature too high";
 
-	dev_emerg(&tz->device, "%s: critical temperature reached\n", tz->type);
+	dev_emerg(&tz->device, "%s: critical temperature reached\n", tz->tzp->type);
 
 	if (shutdown)
 		hw_protection_shutdown(msg, poweroff_delay_ms);
@@ -356,9 +356,9 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 	trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, trip), trip->type);
 
 	if (trip->type == THERMAL_TRIP_CRITICAL)
-		tz->ops->critical(tz);
-	else if (tz->ops->hot)
-		tz->ops->hot(tz);
+		tz->tzp->ops->critical(tz);
+	else if (tz->tzp->ops->hot)
+		tz->tzp->ops->hot(tz);
 }
 
 static void handle_thermal_trip(struct thermal_zone_device *tz,
@@ -493,8 +493,8 @@ static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 		return ret;
 	}
 
-	if (tz->ops->change_mode)
-		ret = tz->ops->change_mode(tz, mode);
+	if (tz->tzp->ops->change_mode)
+		ret = tz->tzp->ops->change_mode(tz, mode);
 
 	if (!ret)
 		tz->mode = mode;
@@ -764,10 +764,10 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 				     unsigned long upper, unsigned long lower,
 				     unsigned int weight)
 {
-	if (trip_index < 0 || trip_index >= tz->num_trips)
+	if (trip_index < 0 || trip_index >= tz->tzp->num_trips)
 		return -EINVAL;
 
-	return thermal_bind_cdev_to_trip(tz, &tz->trips[trip_index], cdev,
+	return thermal_bind_cdev_to_trip(tz, &tz->tzp->trips[trip_index], cdev,
 					 upper, lower, weight);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
@@ -823,10 +823,10 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
 				       int trip_index,
 				       struct thermal_cooling_device *cdev)
 {
-	if (trip_index < 0 || trip_index >= tz->num_trips)
+	if (trip_index < 0 || trip_index >= tz->tzp->num_trips)
 		return -EINVAL;
 
-	return thermal_unbind_cdev_from_trip(tz, &tz->trips[trip_index], cdev);
+	return thermal_unbind_cdev_from_trip(tz, &tz->tzp->trips[trip_index], cdev);
 }
 EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
 
@@ -858,7 +858,7 @@ void print_bind_err_msg(struct thermal_zone_device *tz,
 			struct thermal_cooling_device *cdev, int ret)
 {
 	dev_err(&tz->device, "binding zone %s with cdev %s failed:%d\n",
-		tz->type, cdev->type, ret);
+		tz->tzp->type, cdev->type, ret);
 }
 
 static void bind_cdev(struct thermal_cooling_device *cdev)
@@ -867,8 +867,8 @@ static void bind_cdev(struct thermal_cooling_device *cdev)
 	struct thermal_zone_device *pos = NULL;
 
 	list_for_each_entry(pos, &thermal_tz_list, node) {
-		if (pos->ops->bind) {
-			ret = pos->ops->bind(pos, cdev);
+		if (pos->tzp->ops->bind) {
+			ret = pos->tzp->ops->bind(pos, cdev);
 			if (ret)
 				print_bind_err_msg(pos, cdev, ret);
 		}
@@ -1184,8 +1184,8 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	/* Unbind all thermal zones associated with 'this' cdev */
 	list_for_each_entry(tz, &thermal_tz_list, node) {
-		if (tz->ops->unbind)
-			tz->ops->unbind(tz, cdev);
+		if (tz->tzp->ops->unbind)
+			tz->tzp->ops->unbind(tz, cdev);
 	}
 
 	mutex_unlock(&thermal_list_lock);
@@ -1199,13 +1199,13 @@ static void bind_tz(struct thermal_zone_device *tz)
 	int ret;
 	struct thermal_cooling_device *pos = NULL;
 
-	if (!tz->ops->bind)
+	if (!tz->tzp->ops->bind)
 		return;
 
 	mutex_lock(&thermal_list_lock);
 
 	list_for_each_entry(pos, &thermal_cdev_list, node) {
-		ret = tz->ops->bind(tz, pos);
+		ret = tz->tzp->ops->bind(tz, pos);
 		if (ret)
 			print_bind_err_msg(tz, pos, ret);
 	}
@@ -1224,17 +1224,17 @@ int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int i, ret = -EINVAL;
 
-	if (tz->ops->get_crit_temp)
-		return tz->ops->get_crit_temp(tz, temp);
+	if (tz->tzp->ops->get_crit_temp)
+		return tz->tzp->ops->get_crit_temp(tz, temp);
 
-	if (!tz->trips)
+	if (!tz->tzp->trips)
 		return -EINVAL;
 
 	mutex_lock(&tz->lock);
 
-	for (i = 0; i < tz->num_trips; i++) {
-		if (tz->trips[i].type == THERMAL_TRIP_CRITICAL) {
-			*temp = tz->trips[i].temperature;
+	for (i = 0; i < tz->tzp->num_trips; i++) {
+		if (tz->tzp->trips[i].type == THERMAL_TRIP_CRITICAL) {
+			*temp = tz->tzp->trips[i].temperature;
 			ret = 0;
 			break;
 		}
@@ -1417,16 +1417,11 @@ struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_dev
 	}
 
 	tz->id = id;
-	strscpy(tz->type, tzdp->tzp.type, sizeof(tz->type));
 
 	if (!tzdp->tzp.ops->critical)
 		tzdp->tzp.ops->critical = thermal_zone_device_critical;
 
-	tz->ops = tzdp->tzp.ops;
 	tz->device.class = thermal_class;
-	tz->devdata = tzdp->tzp.devdata;
-	tz->trips = tzdp->tzp.trips;
-	tz->num_trips = tzdp->tzp.num_trips;
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, tzdp->tzp.passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, tzdp->tzp.polling_delay);
@@ -1509,13 +1504,13 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_register);
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
 {
-	return tzd->devdata;
+	return tzd->tzp->devdata;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_priv);
 
 const char *thermal_zone_device_type(struct thermal_zone_device *tzd)
 {
-	return tzd->type;
+	return tzd->tzp->type;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_device_type);
 
@@ -1561,8 +1556,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	/* Unbind all cdevs associated with 'this' thermal zone */
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
-		if (tz->ops->unbind)
-			tz->ops->unbind(tz, cdev);
+		if (tz->tzp->ops->unbind)
+			tz->tzp->ops->unbind(tz, cdev);
 
 	mutex_unlock(&thermal_list_lock);
 
@@ -1607,7 +1602,7 @@ struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name)
 
 	mutex_lock(&thermal_list_lock);
 	list_for_each_entry(pos, &thermal_tz_list, node)
-		if (!strncasecmp(name, pos->type, THERMAL_NAME_LENGTH)) {
+		if (!strncasecmp(name, pos->tzp->type, THERMAL_NAME_LENGTH)) {
 			found++;
 			ref = pos;
 		}
diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index e9c099ecdd0f..b09c23a7a764 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -120,8 +120,10 @@ void thermal_governor_update_tz(struct thermal_zone_device *tz,
 				enum thermal_notify_event reason);
 
 /* Helpers */
-#define for_each_trip(__tz, __trip)	\
-	for (__trip = __tz->trips; __trip - __tz->trips < __tz->num_trips; __trip++)
+#define for_each_trip(__tz, __trip)				\
+	for (__trip = __tz->tzp->trips;				\
+	     __trip - __tz->tzp->trips < __tz->tzp->num_trips;	\
+	     __trip++)
 
 void __thermal_zone_set_trips(struct thermal_zone_device *tz);
 int thermal_zone_trip_id(const struct thermal_zone_device *tz,
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index a72095cfb771..f6d55ba853b5 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -26,8 +26,8 @@ int get_tz_trend(struct thermal_zone_device *tz, const struct thermal_trip *trip
 {
 	enum thermal_trend trend;
 
-	if (tz->emul_temperature || !tz->ops->get_trend ||
-	    tz->ops->get_trend(tz, trip, &trend)) {
+	if (tz->emul_temperature || !tz->tzp->ops->get_trend ||
+	    tz->tzp->ops->get_trend(tz, trip, &trend)) {
 		if (tz->temperature > tz->last_temperature)
 			trend = THERMAL_TREND_RAISING;
 		else if (tz->temperature < tz->last_temperature)
@@ -50,7 +50,7 @@ get_thermal_instance(struct thermal_zone_device *tz,
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 
-	trip = &tz->trips[trip_index];
+	trip = &tz->tzp->trips[trip_index];
 
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
 		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
@@ -74,8 +74,8 @@ EXPORT_SYMBOL(get_thermal_instance);
  * When a valid thermal zone reference is passed, it will fetch its
  * temperature and fill @temp.
  *
- * Both tz and tz->ops must be valid pointers when calling this function,
- * and the tz->ops->get_temp callback must be provided.
+ * Both tz and tz->tzp->ops must be valid pointers when calling this function,
+ * and the tz->tzp->ops->get_temp callback must be provided.
  * The function must be called under tz->lock.
  *
  * Return: On success returns 0, an error code otherwise
@@ -88,7 +88,7 @@ int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	lockdep_assert_held(&tz->lock);
 
-	ret = tz->ops->get_temp(tz, temp);
+	ret = tz->tzp->ops->get_temp(tz, temp);
 
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
 		for_each_trip(tz, trip) {
@@ -132,7 +132,7 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
 
 	mutex_lock(&tz->lock);
 
-	if (!tz->ops->get_temp) {
+	if (!tz->tzp->ops->get_temp) {
 		ret = -EINVAL;
 		goto unlock;
 	}
diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index 252116f1e535..38edad3865f8 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -80,7 +80,7 @@ temp_crit_show(struct device *dev, struct device_attribute *attr, char *buf)
 
 	mutex_lock(&tz->lock);
 
-	ret = tz->ops->get_crit_temp(tz, &temperature);
+	ret = tz->tzp->ops->get_crit_temp(tz, &temperature);
 
 	mutex_unlock(&tz->lock);
 
@@ -99,7 +99,7 @@ thermal_hwmon_lookup_by_type(const struct thermal_zone_device *tz)
 
 	mutex_lock(&thermal_hwmon_list_lock);
 	list_for_each_entry(hwmon, &thermal_hwmon_list, node) {
-		strcpy(type, tz->type);
+		strcpy(type, tz->tzp->type);
 		strreplace(type, '-', '_');
 		if (!strcmp(hwmon->type, type)) {
 			mutex_unlock(&thermal_hwmon_list_lock);
@@ -132,7 +132,7 @@ thermal_hwmon_lookup_temp(const struct thermal_hwmon_device *hwmon,
 static bool thermal_zone_crit_temp_valid(struct thermal_zone_device *tz)
 {
 	int temp;
-	return tz->ops->get_crit_temp && !tz->ops->get_crit_temp(tz, &temp);
+	return tz->tzp->ops->get_crit_temp && !tz->tzp->ops->get_crit_temp(tz, &temp);
 }
 
 int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
@@ -153,7 +153,7 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&hwmon->tz_list);
-	strscpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
+	strscpy(hwmon->type, tz->tzp->type, THERMAL_NAME_LENGTH);
 	strreplace(hwmon->type, '-', '_');
 	hwmon->device = hwmon_device_register_for_thermal(&tz->device,
 							  hwmon->type, hwmon);
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 4d6c22e0ed85..9f4c2c0cd7d8 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -274,7 +274,7 @@ static struct device_node *thermal_of_zone_get_by_name(struct thermal_zone_devic
 	if (!np)
 		return ERR_PTR(-ENODEV);
 
-	tz_np = of_get_child_by_name(np, tz->type);
+	tz_np = of_get_child_by_name(np, tz->tzp->type);
 
 	of_node_put(np);
 
@@ -310,7 +310,7 @@ static int __thermal_of_unbind(struct device_node *map_np, int index, int trip_i
 
 	ret = thermal_zone_unbind_cooling_device(tz, trip_id, cdev);
 	if (ret)
-		pr_err("Failed to unbind '%s' with '%s': %d\n", tz->type, cdev->type, ret);
+		pr_err("Failed to unbind '%s' with '%s': %d\n", tz->tzp->type, cdev->type, ret);
 
 	return ret;
 }
@@ -345,7 +345,7 @@ static int __thermal_of_bind(struct device_node *map_np, int index, int trip_id,
 					       cooling_spec.args[0],
 					       weight);
 	if (ret)
-		pr_err("Failed to bind '%s' with '%s': %d\n", tz->type, cdev->type, ret);
+		pr_err("Failed to bind '%s' with '%s': %d\n", tz->tzp->type, cdev->type, ret);
 
 	return ret;
 }
@@ -438,8 +438,8 @@ static int thermal_of_unbind(struct thermal_zone_device *tz,
  */
 static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 {
-	struct thermal_trip *trips = tz->trips;
-	struct thermal_zone_device_ops *ops = tz->ops;
+	struct thermal_trip *trips = tz->tzp->trips;
+	struct thermal_zone_device_ops *ops = tz->tzp->ops;
 
 	thermal_zone_device_disable(tz);
 	thermal_zone_device_unregister(tz);
@@ -529,7 +529,7 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	ret = thermal_zone_device_enable(tz);
 	if (ret) {
 		pr_err("Failed to enabled thermal zone '%s', id=%d: %d\n",
-		       tz->type, tz->id, ret);
+		       tz->tzp->type, tz->id, ret);
 		thermal_of_zone_unregister(tz);
 		return ERR_PTR(ret);
 	}
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 3f5f4a04a754..87a20ced7864 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -28,7 +28,7 @@ type_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 
-	return sprintf(buf, "%s\n", tz->type);
+	return sprintf(buf, "%s\n", tz->tzp->type);
 }
 
 static ssize_t
@@ -88,7 +88,7 @@ trip_point_type_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_type", &trip_id) != 1)
 		return -EINVAL;
 
-	switch (tz->trips[trip_id].type) {
+	switch (tz->tzp->trips[trip_id].type) {
 	case THERMAL_TRIP_CRITICAL:
 		return sprintf(buf, "critical\n");
 	case THERMAL_TRIP_HOT:
@@ -120,11 +120,11 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&tz->lock);
 
-	trip = &tz->trips[trip_id];
+	trip = &tz->tzp->trips[trip_id];
 
 	if (temp != trip->temperature) {
-		if (tz->ops->set_trip_temp) {
-			ret = tz->ops->set_trip_temp(tz, trip_id, temp);
+		if (tz->tzp->ops->set_trip_temp) {
+			ret = tz->tzp->ops->set_trip_temp(tz, trip_id, temp);
 			if (ret)
 				goto unlock;
 		}
@@ -150,7 +150,7 @@ trip_point_temp_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_temp", &trip_id) != 1)
 		return -EINVAL;
 
-	return sprintf(buf, "%d\n", tz->trips[trip_id].temperature);
+	return sprintf(buf, "%d\n", tz->tzp->trips[trip_id].temperature);
 }
 
 static ssize_t
@@ -171,11 +171,11 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&tz->lock);
 
-	trip = &tz->trips[trip_id];
+	trip = &tz->tzp->trips[trip_id];
 
 	if (hyst != trip->hysteresis) {
-		if (tz->ops->set_trip_hyst) {
-			ret = tz->ops->set_trip_hyst(tz, trip_id, hyst);
+		if (tz->tzp->ops->set_trip_hyst) {
+			ret = tz->tzp->ops->set_trip_hyst(tz, trip_id, hyst);
 			if (ret)
 				goto unlock;
 		}
@@ -201,7 +201,7 @@ trip_point_hyst_show(struct device *dev, struct device_attribute *attr,
 	if (sscanf(attr->attr.name, "trip_point_%d_hyst", &trip_id) != 1)
 		return -EINVAL;
 
-	return sprintf(buf, "%d\n", tz->trips[trip_id].hysteresis);
+	return sprintf(buf, "%d\n", tz->tzp->trips[trip_id].hysteresis);
 }
 
 static ssize_t
@@ -250,10 +250,10 @@ emul_temp_store(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&tz->lock);
 
-	if (!tz->ops->set_emul_temp)
+	if (!tz->tzp->ops->set_emul_temp)
 		tz->emul_temperature = temperature;
 	else
-		ret = tz->ops->set_emul_temp(tz, temperature);
+		ret = tz->tzp->ops->set_emul_temp(tz, temperature);
 
 	if (!ret)
 		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
@@ -405,22 +405,22 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 	int indx;
 
 	/* This function works only for zones with at least one trip */
-	if (tz->num_trips <= 0)
+	if (tz->tzp->num_trips <= 0)
 		return -EINVAL;
 
-	tz->trip_type_attrs = kcalloc(tz->num_trips, sizeof(*tz->trip_type_attrs),
+	tz->trip_type_attrs = kcalloc(tz->tzp->num_trips, sizeof(*tz->trip_type_attrs),
 				      GFP_KERNEL);
 	if (!tz->trip_type_attrs)
 		return -ENOMEM;
 
-	tz->trip_temp_attrs = kcalloc(tz->num_trips, sizeof(*tz->trip_temp_attrs),
+	tz->trip_temp_attrs = kcalloc(tz->tzp->num_trips, sizeof(*tz->trip_temp_attrs),
 				      GFP_KERNEL);
 	if (!tz->trip_temp_attrs) {
 		kfree(tz->trip_type_attrs);
 		return -ENOMEM;
 	}
 
-	tz->trip_hyst_attrs = kcalloc(tz->num_trips,
+	tz->trip_hyst_attrs = kcalloc(tz->tzp->num_trips,
 				      sizeof(*tz->trip_hyst_attrs),
 				      GFP_KERNEL);
 	if (!tz->trip_hyst_attrs) {
@@ -429,7 +429,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		return -ENOMEM;
 	}
 
-	attrs = kcalloc(tz->num_trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
+	attrs = kcalloc(tz->tzp->num_trips * 3 + 1, sizeof(*attrs), GFP_KERNEL);
 	if (!attrs) {
 		kfree(tz->trip_type_attrs);
 		kfree(tz->trip_temp_attrs);
@@ -437,7 +437,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 		return -ENOMEM;
 	}
 
-	for (indx = 0; indx < tz->num_trips; indx++) {
+	for (indx = 0; indx < tz->tzp->num_trips; indx++) {
 		/* create trip type attribute */
 		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_type", indx);
@@ -464,7 +464,7 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 			tz->trip_temp_attrs[indx].attr.store =
 							trip_point_temp_store;
 		}
-		attrs[indx + tz->num_trips] = &tz->trip_temp_attrs[indx].attr.attr;
+		attrs[indx + tz->tzp->num_trips] = &tz->trip_temp_attrs[indx].attr.attr;
 
 		snprintf(tz->trip_hyst_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_hyst", indx);
@@ -474,15 +474,15 @@ static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
 					tz->trip_hyst_attrs[indx].name;
 		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
 		tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
-		if (tz->ops->set_trip_hyst) {
+		if (tz->tzp->ops->set_trip_hyst) {
 			tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
 			tz->trip_hyst_attrs[indx].attr.store =
 					trip_point_hyst_store;
 		}
-		attrs[indx + tz->num_trips * 2] =
+		attrs[indx + tz->tzp->num_trips * 2] =
 					&tz->trip_hyst_attrs[indx].attr.attr;
 	}
-	attrs[tz->num_trips * 3] = NULL;
+	attrs[tz->tzp->num_trips * 3] = NULL;
 
 	tz->trips_attribute_group.attrs = attrs;
 
@@ -522,7 +522,7 @@ int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
 	for (i = 0; i < size - 2; i++)
 		groups[i] = thermal_zone_attribute_groups[i];
 
-	if (tz->num_trips) {
+	if (tz->tzp->num_trips) {
 		result = create_trip_attrs(tz, mask);
 		if (result) {
 			kfree(groups);
@@ -543,7 +543,7 @@ void thermal_zone_destroy_device_groups(struct thermal_zone_device *tz)
 	if (!tz)
 		return;
 
-	if (tz->num_trips)
+	if (tz->tzp->num_trips)
 		destroy_trip_attrs(tz);
 
 	kfree(tz->device.groups);
diff --git a/drivers/thermal/thermal_trace.h b/drivers/thermal/thermal_trace.h
index 459c8ce6cf3b..4bd8b0be4280 100644
--- a/drivers/thermal/thermal_trace.h
+++ b/drivers/thermal/thermal_trace.h
@@ -28,14 +28,14 @@ TRACE_EVENT(thermal_temperature,
 	TP_ARGS(tz),
 
 	TP_STRUCT__entry(
-		__string(thermal_zone, tz->type)
+		__string(thermal_zone, tz->tzp->type)
 		__field(int, id)
 		__field(int, temp_prev)
 		__field(int, temp)
 	),
 
 	TP_fast_assign(
-		__assign_str(thermal_zone, tz->type);
+		__assign_str(thermal_zone, tz->tzp->type);
 		__entry->id = tz->id;
 		__entry->temp_prev = tz->last_temperature;
 		__entry->temp = tz->temperature;
@@ -73,14 +73,14 @@ TRACE_EVENT(thermal_zone_trip,
 	TP_ARGS(tz, trip, trip_type),
 
 	TP_STRUCT__entry(
-		__string(thermal_zone, tz->type)
+		__string(thermal_zone, tz->tzp->type)
 		__field(int, id)
 		__field(int, trip)
 		__field(enum thermal_trip_type, trip_type)
 	),
 
 	TP_fast_assign(
-		__assign_str(thermal_zone, tz->type);
+		__assign_str(thermal_zone, tz->tzp->type);
 		__entry->id = tz->id;
 		__entry->trip = trip;
 		__entry->trip_type = trip_type;
diff --git a/drivers/thermal/thermal_trip.c b/drivers/thermal/thermal_trip.c
index c875a26d5adf..9cccda973756 100644
--- a/drivers/thermal/thermal_trip.c
+++ b/drivers/thermal/thermal_trip.c
@@ -42,7 +42,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_for_each_trip);
 
 int thermal_zone_get_num_trips(struct thermal_zone_device *tz)
 {
-	return tz->num_trips;
+	return tz->tzp->num_trips;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
 
@@ -56,7 +56,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_num_trips);
  * driver to let it set its own notification mechanism (usually an
  * interrupt).
  *
- * This function must be called with tz->lock held. Both tz and tz->ops
+ * This function must be called with tz->lock held. Both tz and tz->tzp->ops
  * must be valid pointers.
  *
  * It does not return a value
@@ -70,7 +70,7 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 
 	lockdep_assert_held(&tz->lock);
 
-	if (!tz->ops->set_trips)
+	if (!tz->tzp->ops->set_trips)
 		return;
 
 	for_each_trip(tz, trip) {
@@ -114,7 +114,7 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 	 * Set a temperature window. When this window is left the driver
 	 * must inform the thermal core via thermal_zone_device_update.
 	 */
-	ret = tz->ops->set_trips(tz, low, high);
+	ret = tz->tzp->ops->set_trips(tz, low, high);
 	if (ret)
 		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
 }
@@ -122,10 +122,10 @@ void __thermal_zone_set_trips(struct thermal_zone_device *tz)
 int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			    struct thermal_trip *trip)
 {
-	if (!tz || !tz->trips || trip_id < 0 || trip_id >= tz->num_trips || !trip)
+	if (!tz || !tz->tzp->trips || trip_id < 0 || trip_id >= tz->tzp->num_trips || !trip)
 		return -EINVAL;
 
-	*trip = tz->trips[trip_id];
+	*trip = tz->tzp->trips[trip_id];
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__thermal_zone_get_trip);
@@ -150,7 +150,7 @@ int thermal_zone_trip_id(const struct thermal_zone_device *tz,
 	 * Assume the trip to be located within the bounds of the thermal
 	 * zone's trips[] table.
 	 */
-	return trip - tz->trips;
+	return trip - tz->tzp->trips;
 }
 void thermal_zone_trip_updated(struct thermal_zone_device *tz,
 			       const struct thermal_trip *trip)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 7a540b746703..65db38acd20b 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -122,16 +122,12 @@ struct thermal_cooling_device {
 /**
  * struct thermal_zone_device - structure for a thermal zone
  * @id:		unique id number for each thermal zone
- * @type:	the thermal zone device type
  * @device:	&struct device for this thermal zone
  * @removal:	removal completion
  * @trip_temp_attrs:	attributes for trip points for sysfs: trip temperature
  * @trip_type_attrs:	attributes for trip points for sysfs: trip type
  * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
  * @mode:		current mode of this thermal zone
- * @devdata:	private pointer for device private data
- * @trips:	an array of struct thermal_trip
- * @num_trips:	number of trip points the thermal zone supports
  * @passive_delay_jiffies: number of jiffies to wait between polls when
  *			performing passive cooling.
  * @polling_delay_jiffies: number of jiffies to wait between polls when
@@ -148,7 +144,6 @@ struct thermal_cooling_device {
  * @prev_high_trip:	the above current temperature if you've crossed a
 			passive trip point.
  * @need_update:	if equals 1, thermal_zone_device_update needs to be invoked.
- * @ops:	operations this &thermal_zone_device supports
  * @tzp:		Thermal zone parameters
  * @tgp:		Thermal zone governor parameters
  * @governor:	pointer to the governor for this thermal zone
@@ -164,7 +159,6 @@ struct thermal_cooling_device {
  */
 struct thermal_zone_device {
 	int id;
-	char type[THERMAL_NAME_LENGTH];
 	struct device device;
 	struct completion removal;
 	struct attribute_group trips_attribute_group;
@@ -172,9 +166,6 @@ struct thermal_zone_device {
 	struct thermal_attr *trip_type_attrs;
 	struct thermal_attr *trip_hyst_attrs;
 	enum thermal_device_mode mode;
-	void *devdata;
-	struct thermal_trip *trips;
-	int num_trips;
 	unsigned long passive_delay_jiffies;
 	unsigned long polling_delay_jiffies;
 	int temperature;
@@ -184,7 +175,6 @@ struct thermal_zone_device {
 	int prev_low_trip;
 	int prev_high_trip;
 	atomic_t need_update;
-	struct thermal_zone_device_ops *ops;
 	struct thermal_zone_platform_params *tzp;
 	struct thermal_governor_params *tgp;
 	struct thermal_governor *governor;
-- 
2.43.0


