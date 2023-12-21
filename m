Return-Path: <linux-kernel+bounces-8395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9349081B68D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490F92837B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B637CD13;
	Thu, 21 Dec 2023 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qNepVTp1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44217BF1D;
	Thu, 21 Dec 2023 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162931;
	bh=GtlxthakiJ4lmKIfCmFvoUbrzDEnn38lk/26FiOqO1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNepVTp1SEiiRRs6475WQeA/DyE5rYMZw73vGgLmQESQT6xi/guiWTQfiitPhN+c/
	 IcuMYhgDR3FgL6zKUJyI9R9I4G+R9bMfTTBuia7E6Q0djz/x7bnQxEwOfwxhjuufkM
	 e1pPgNKbkh6I2zN7Lx+0BwxHC+W/ROPwS2R9nW6ZVHaClTa2OtBb5IdtKC8/zqCBDu
	 t9sKXER3LdAMybXq2hxyIkFl53VP6gsLhg4e5bgZq+GLHgTCJDme3HQO/mnekUyo5K
	 +sdwcZOZ4HIpzV5+on0lHT9Cdqr3JY+pi6zaA52cruxI8dm/eXrkXoJA2d3q0N8aFT
	 BmPZfvuQpLGfg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1168C3782006;
	Thu, 21 Dec 2023 12:48:51 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 25/26] thermal: Remove tripless_zone_register and register_with_trips functions
Date: Thu, 21 Dec 2023 13:48:24 +0100
Message-ID: <20231221124825.149141-26-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
References: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no more users of thermal_tripless_zone_device_register() and
thermal_zone_device_register_with_trips() functions, as they were all
converted to the new thermal_zone_device_register(): remove the former
two functions.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/thermal_core.c | 111 +++++++++------------------------
 include/linux/thermal.h        |  15 -----
 2 files changed, 29 insertions(+), 97 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6be508eb2d72..9eb0200a85ff 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1221,21 +1221,9 @@ int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp)
 EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
 
 /**
- * thermal_zone_device_register_with_trips() - register a new thermal zone device
- * @type:	the thermal zone device type
- * @trips:	a pointer to an array of thermal trips
- * @num_trips:	the number of trip points the thermal zone support
- * @mask:	a bit string indicating the writeablility of trip points
- * @devdata:	private device data
- * @ops:	standard thermal zone device callbacks
- * @tzp:	thermal zone platform parameters
- * @passive_delay: number of milliseconds to wait between polls when
- *		   performing passive cooling
- * @polling_delay: number of milliseconds to wait between polls when checking
- *		   whether trip points have been crossed (0 for interrupt
- *		   driven systems)
- *
- * This function is deprecated. See thermal_zone_device_register().
+ * thermal_zone_device_register() - register a new thermal zone device
+ * @tzdp:	Parameters of the new thermal zone device
+ *		See struct thermal_zone_device_register.
  *
  * This interface function adds a new thermal zone device (sensor) to
  * /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
@@ -1247,25 +1235,21 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
  * in case of error, an ERR_PTR. Caller must check return value with
  * IS_ERR*() helpers.
  */
-struct thermal_zone_device *
-thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int num_trips, int mask,
-					void *devdata, struct thermal_zone_device_ops *ops,
-					const struct thermal_zone_params *tzp, int passive_delay,
-					int polling_delay)
+struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_device_params *tzdp)
 {
 	struct thermal_zone_device *tz;
 	int id;
 	int result;
 	struct thermal_governor *governor;
 
-	if (!type || strlen(type) == 0) {
+	if (!tzdp->type || strlen(tzdp->type) == 0) {
 		pr_err("No thermal zone type defined\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (strlen(type) >= THERMAL_NAME_LENGTH) {
+	if (strlen(tzdp->type) >= THERMAL_NAME_LENGTH) {
 		pr_err("Thermal zone name (%s) too long, should be under %d chars\n",
-		       type, THERMAL_NAME_LENGTH);
+		       tzdp->type, THERMAL_NAME_LENGTH);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -1282,17 +1266,18 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	 * Check will be true when the bit 31 of the mask is set.
 	 * 32 bit shift will cause overflow of 4 byte integer.
 	 */
-	if (num_trips > (BITS_PER_TYPE(int) - 1) || num_trips < 0 || mask >> num_trips) {
+	if (tzdp->num_trips > (BITS_PER_TYPE(int) - 1) || tzdp->num_trips < 0 ||
+	    tzdp->mask >> tzdp->num_trips) {
 		pr_err("Incorrect number of thermal trips\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (!ops) {
+	if (!tzdp->ops) {
 		pr_err("Thermal zone device ops not defined\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (num_trips > 0 && !trips)
+	if (tzdp->num_trips > 0 && !tzdp->trips)
 		return ERR_PTR(-EINVAL);
 
 	if (!thermal_class)
@@ -1302,12 +1287,10 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	if (!tz)
 		return ERR_PTR(-ENOMEM);
 
-	if (tzp) {
-		tz->tzp = kmemdup(tzp, sizeof(*tzp), GFP_KERNEL);
-		if (!tz->tzp) {
-			result = -ENOMEM;
-			goto free_tz;
-		}
+	tz->tzp = kmemdup(&tzdp->tzp, sizeof(tzdp->tzp), GFP_KERNEL);
+	if (!tz->tzp) {
+		result = -ENOMEM;
+		goto free_tz;
 	}
 
 	INIT_LIST_HEAD(&tz->thermal_instances);
@@ -1322,23 +1305,23 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	}
 
 	tz->id = id;
-	strscpy(tz->type, type, sizeof(tz->type));
+	strscpy(tz->type, tzdp->type, sizeof(tz->type));
 
-	if (!ops->critical)
-		ops->critical = thermal_zone_device_critical;
+	if (!tzdp->ops->critical)
+		tzdp->ops->critical = thermal_zone_device_critical;
 
-	tz->ops = ops;
+	tz->ops = tzdp->ops;
 	tz->device.class = thermal_class;
-	tz->devdata = devdata;
-	tz->trips = trips;
-	tz->num_trips = num_trips;
+	tz->devdata = tzdp->devdata;
+	tz->trips = tzdp->trips;
+	tz->num_trips = tzdp->num_trips;
 
-	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
-	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
+	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, tzdp->passive_delay);
+	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, tzdp->polling_delay);
 
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
-	result = thermal_zone_create_device_groups(tz, mask);
+	result = thermal_zone_create_device_groups(tz, tzdp->mask);
 	if (result)
 		goto remove_id;
 
@@ -1357,10 +1340,10 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	/* Update 'this' zone's governor information */
 	mutex_lock(&thermal_governor_lock);
 
-	if (tz->tzp)
-		governor = __find_governor(tz->tzp->governor_name);
-	else
+	if (strlen(tz->tzp->governor_name) == 0)
 		governor = def_governor;
+	else
+		governor = __find_governor(tz->tzp->governor_name);
 
 	result = thermal_set_governor(tz, governor);
 	if (result) {
@@ -1370,7 +1353,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 
 	mutex_unlock(&thermal_governor_lock);
 
-	if (!tz->tzp || !tz->tzp->no_hwmon) {
+	if (!tz->tzp->no_hwmon) {
 		result = thermal_add_hwmon_sysfs(tz);
 		if (result)
 			goto unregister;
@@ -1409,42 +1392,6 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	kfree(tz);
 	return ERR_PTR(result);
 }
-EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
-
-/* This function is deprecated. See thermal_zone_device_register(). */
-struct thermal_zone_device *thermal_tripless_zone_device_register(
-					const char *type,
-					void *devdata,
-					struct thermal_zone_device_ops *ops,
-					const struct thermal_zone_params *tzp)
-{
-	return thermal_zone_device_register_with_trips(type, NULL, 0, 0, devdata,
-						       ops, tzp, 0, 0);
-}
-EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
-
-/**
- * thermal_zone_device_register() - register a new thermal zone device
- * @tzdp:	Parameters of the new thermal zone device
- *		See struct thermal_zone_device_register.
- *
- * This interface function adds a new thermal zone device (sensor) to
- * /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
- * thermal cooling devices registered at the same time.
- * thermal_zone_device_unregister() must be called when the device is no
- * longer needed. The passive cooling depends on the .get_trend() return value.
- *
- * Return: a pointer to the created struct thermal_zone_device or an
- * in case of error, an ERR_PTR. Caller must check return value with
- * IS_ERR*() helpers.
- */
-struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_device_params *tzdp)
-{
-	return thermal_zone_device_register_with_trips(tzdp->type, tzdp->trips, tzdp->num_trips,
-						       tzdp->mask, tzdp->devdata, tzdp->ops,
-						       &tzdp->tzp, tzdp->passive_delay,
-						       tzdp->polling_delay);
-}
 EXPORT_SYMBOL_GPL(thermal_zone_device_register);
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index c6ed33a7e468..84b62575d93a 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -322,21 +322,6 @@ int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
 
 #ifdef CONFIG_THERMAL
-struct thermal_zone_device *thermal_zone_device_register_with_trips(
-					const char *type,
-					struct thermal_trip *trips,
-					int num_trips, int mask,
-					void *devdata,
-					struct thermal_zone_device_ops *ops,
-					const struct thermal_zone_params *tzp,
-					int passive_delay, int polling_delay);
-
-struct thermal_zone_device *thermal_tripless_zone_device_register(
-					const char *type,
-					void *devdata,
-					struct thermal_zone_device_ops *ops,
-					const struct thermal_zone_params *tzp);
-
 struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_device_params *tzdp);
 
 void thermal_zone_device_unregister(struct thermal_zone_device *tz);
-- 
2.43.0


