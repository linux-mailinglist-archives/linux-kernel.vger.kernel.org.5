Return-Path: <linux-kernel+bounces-44469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3B4842276
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0245C2920BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4433567A03;
	Tue, 30 Jan 2024 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O3Woz7M2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C15664CC;
	Tue, 30 Jan 2024 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613198; cv=none; b=sdlA7vQgYunIVbgatbIaydNbBT0VNSXehnuKyWyVXlYFKvLWm4ZEh3u+bCA2yZXlEG0QlZMCNzg7fENC7BdiDfxSiRFcl4KLQclj0fgRniFGRrSigIuwk1q328tQ9ja/GV19+OVuv/jWA62wTHHQTo2QqLI/qtj74qoQKO+xW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613198; c=relaxed/simple;
	bh=B2pHEkbuVDb5/8B80P9qFpRxNFIT7wXDUKIRSMeB/Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSOWrwmgKz/Q7nlazPJTZjqRasJtsLHRRhyfxq39xTt/MYvGGXoiLKWjXUaVYCmLEnRVHWHkdTMB03zQpBtxSGMbLU2M11BeUKyrPJqA0DN725suI02detzNc71N5kxLyjYFLEPz8O5M4s1iCgpDXv9hrGNiWt5atpJ9tcwFs3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O3Woz7M2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613194;
	bh=B2pHEkbuVDb5/8B80P9qFpRxNFIT7wXDUKIRSMeB/Vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3Woz7M2rLFcx5Pnq4AJNqKWkGCiAcvY2Nb/QkqsuCYaNgNuHB54iWwzKBchwcorN
	 sVMIiF2DCGRlSG4agxfZtOm2eUtl48dxNAr0+A/E/SGzZ2KgLzj7dQ3Pg1RzvFKlT4
	 o7uBszLU7gNQeoaqe9wHaVRlGkg86nge2RePt64U+jzKGjK8cVwchBgNFMjKP163AP
	 ymLASSBShA3CRjyewlafPhtPELwWcWjv5SyP8a94J6TpGBTzLh2SMCniQOQhidwHPb
	 DedX2rEaXOb+C9zaAaKoKJ0BVU8MnhwdXBL4aIDtltl4f3ovlTRUmjGGs8oa08a2GT
	 ZOqWNMU0hsNyw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 35B55378208A;
	Tue, 30 Jan 2024 11:13:12 +0000 (UTC)
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
Subject: [PATCH v1 02/18] thermal: Add new structures and thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:34 +0100
Message-ID: <20240130111250.185718-3-angelogioacchino.delregno@collabora.com>
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

In preparation for extending the thermal zone devices to actually
have a name and disambiguate thermal zone types/names, and to do
a reorganization in thermal_zone_device, add some new Thermal Zone
structures:

Introduce new thermal_governor_params, thermal_zone_platform_params
and thermal_zone_device_params structures which are meant to hold
the parameters for thermal zone registration and, in the future, to
stop having a catch-all thermal_zone_device structure.

While at it, also add a new thermal_zone_device_register() function
which uses the new structure(s) for registration;
the now old functions thermal_tripless_zone_device_register() and
thermal_zone_device_register_with_trips() are now advertised as
being deprecated and changed to instead act as wrappers around the
new thermal_zone_device_register().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/gov_power_allocator.c |  38 +++----
 drivers/thermal/qcom/tsens.c          |   4 +-
 drivers/thermal/thermal_core.c        | 146 ++++++++++++++++++--------
 drivers/thermal/thermal_helpers.c     |   8 +-
 drivers/thermal/thermal_sysfs.c       |  16 +--
 include/linux/thermal.h               |  73 +++++++++++--
 6 files changed, 202 insertions(+), 83 deletions(-)

diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
index 81e061f183ad..3efbc60cd148 100644
--- a/drivers/thermal/gov_power_allocator.c
+++ b/drivers/thermal/gov_power_allocator.c
@@ -167,14 +167,14 @@ static void estimate_pid_constants(struct thermal_zone_device *tz,
 	if (!temperature_threshold)
 		return;
 
-	tz->tzp->k_po = int_to_frac(sustainable_power) /
+	tz->tgp->ipa_params.k_po = int_to_frac(sustainable_power) /
 		temperature_threshold;
 
-	tz->tzp->k_pu = int_to_frac(2 * sustainable_power) /
+	tz->tgp->ipa_params.k_pu = int_to_frac(2 * sustainable_power) /
 		temperature_threshold;
 
-	k_i = tz->tzp->k_pu / 10;
-	tz->tzp->k_i = k_i > 0 ? k_i : 1;
+	k_i = tz->tgp->ipa_params.k_pu / 10;
+	tz->tgp->ipa_params.k_i = k_i > 0 ? k_i : 1;
 
 	/*
 	 * The default for k_d and integral_cutoff is 0, so we can
@@ -199,10 +199,10 @@ static u32 get_sustainable_power(struct thermal_zone_device *tz,
 {
 	u32 sustainable_power;
 
-	if (!tz->tzp->sustainable_power)
+	if (!tz->tgp->ipa_params.sustainable_power)
 		sustainable_power = estimate_sustainable_power(tz);
 	else
-		sustainable_power = tz->tzp->sustainable_power;
+		sustainable_power = tz->tgp->ipa_params.sustainable_power;
 
 	/* Check if it's init value 0 or there was update via sysfs */
 	if (sustainable_power != params->sustainable_power) {
@@ -210,7 +210,7 @@ static u32 get_sustainable_power(struct thermal_zone_device *tz,
 				       params->trip_switch_on, control_temp);
 
 		/* Do the estimation only once and make available in sysfs */
-		tz->tzp->sustainable_power = sustainable_power;
+		tz->tgp->ipa_params.sustainable_power = sustainable_power;
 		params->sustainable_power = sustainable_power;
 	}
 
@@ -252,7 +252,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 	err = int_to_frac(err);
 
 	/* Calculate the proportional term */
-	p = mul_frac(err < 0 ? tz->tzp->k_po : tz->tzp->k_pu, err);
+	p = mul_frac(err < 0 ? tz->tgp->ipa_params.k_po : tz->tgp->ipa_params.k_pu, err);
 
 	/*
 	 * Calculate the integral term
@@ -260,10 +260,10 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 	 * if the error is less than cut off allow integration (but
 	 * the integral is limited to max power)
 	 */
-	i = mul_frac(tz->tzp->k_i, params->err_integral);
+	i = mul_frac(tz->tgp->ipa_params.k_i, params->err_integral);
 
-	if (err < int_to_frac(tz->tzp->integral_cutoff)) {
-		s64 i_next = i + mul_frac(tz->tzp->k_i, err);
+	if (err < int_to_frac(tz->tgp->ipa_params.integral_cutoff)) {
+		s64 i_next = i + mul_frac(tz->tgp->ipa_params.k_i, err);
 
 		if (abs(i_next) < max_power_frac) {
 			i = i_next;
@@ -278,7 +278,7 @@ static u32 pid_controller(struct thermal_zone_device *tz,
 	 * error (i.e. driving closer to the line) results in less
 	 * power being applied, slowing down the controller)
 	 */
-	d = mul_frac(tz->tzp->k_d, err - params->prev_err);
+	d = mul_frac(tz->tgp->ipa_params.k_d, err - params->prev_err);
 	d = div_frac(d, jiffies_to_msecs(tz->passive_delay_jiffies));
 	params->prev_err = err;
 
@@ -699,9 +699,9 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 		return ret;
 	}
 
-	if (!tz->tzp) {
-		tz->tzp = kzalloc(sizeof(*tz->tzp), GFP_KERNEL);
-		if (!tz->tzp) {
+	if (!tz->tgp) {
+		tz->tgp = kzalloc(sizeof(*tz->tgp), GFP_KERNEL);
+		if (!tz->tgp) {
 			ret = -ENOMEM;
 			goto free_params;
 		}
@@ -709,10 +709,10 @@ static int power_allocator_bind(struct thermal_zone_device *tz)
 		params->allocated_tzp = true;
 	}
 
-	if (!tz->tzp->sustainable_power)
+	if (!tz->tgp->ipa_params.sustainable_power)
 		dev_warn(&tz->device, "power_allocator: sustainable_power will be estimated\n");
 
-	estimate_pid_constants(tz, tz->tzp->sustainable_power,
+	estimate_pid_constants(tz, tz->tgp->ipa_params.sustainable_power,
 			       params->trip_switch_on,
 			       params->trip_max->temperature);
 
@@ -736,8 +736,8 @@ static void power_allocator_unbind(struct thermal_zone_device *tz)
 	dev_dbg(&tz->device, "Unbinding from thermal zone %d\n", tz->id);
 
 	if (params->allocated_tzp) {
-		kfree(tz->tzp);
-		tz->tzp = NULL;
+		kfree(tz->tgp);
+		tz->tgp = NULL;
 	}
 
 	kfree(params->power);
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 6d7c16ccb44d..9eddac93d683 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -252,8 +252,8 @@ int tsens_read_calibration_legacy(struct tsens_priv *priv,
 /*
  * Use this function on devices where slope and offset calculations
  * depend on calibration data read from qfprom. On others the slope
- * and offset values are derived from tz->tzp->slope and tz->tzp->offset
- * resp.
+ * and offset values are derived from tz->tgp->ipa_params.slope and
+ * tz->tgp->ipa_params.offset resp.
  */
 void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 			     u32 *p2, u32 mode)
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index dfaa6341694a..3150475b947f 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -141,13 +141,13 @@ int thermal_register_governor(struct thermal_governor *governor)
 
 	list_for_each_entry(pos, &thermal_tz_list, node) {
 		/*
-		 * only thermal zones with specified tz->tzp->governor_name
+		 * only thermal zones with specified tz->tgp->governor_name
 		 * may run with tz->govenor unset
 		 */
 		if (pos->governor)
 			continue;
 
-		name = pos->tzp->governor_name;
+		name = pos->tgp->governor_name;
 
 		if (!strncasecmp(name, governor->name, THERMAL_NAME_LENGTH)) {
 			int ret;
@@ -1261,6 +1261,8 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_temp);
  *		   whether trip points have been crossed (0 for interrupt
  *		   driven systems)
  *
+ * This function is deprecated. See thermal_zone_device_register().
+ *
  * This interface function adds a new thermal zone device (sensor) to
  * /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
  * thermal cooling devices registered at the same time.
@@ -1277,19 +1279,80 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 					const struct thermal_zone_params *tzp, int passive_delay,
 					int polling_delay)
 {
+	struct thermal_zone_device_params tzdp = {
+		/* Thermal Zone Platform parameters */
+		.tzp = {
+			.type = type,
+			.ops = ops,
+			.trips = trips,
+			.num_trips = num_trips,
+			.mask = mask,
+			.passive_delay = passive_delay,
+			.polling_delay = polling_delay,
+			.devdata = devdata
+		},
+	};
 	struct thermal_zone_device *tz;
+
+	/* Thermal Zone Governor parameters */
+	if (tzp) {
+		tzdp.tgp = kzalloc(sizeof(*tzdp.tgp), GFP_KERNEL);
+		if (!tzdp.tgp)
+			return ERR_PTR(-ENOMEM);
+
+		tzdp.tgp->governor_name = tzp->governor_name;
+		tzdp.tzp.no_hwmon = tzp->no_hwmon;
+		memcpy(&tzdp.tgp->ipa_params, tzp, sizeof(*tzp));
+	}
+
+	tz = thermal_zone_device_register(&tzdp);
+	kfree(tzdp.tgp);
+	return tz;
+}
+EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
+
+/* This function is deprecated. See thermal_zone_device_register(). */
+struct thermal_zone_device *thermal_tripless_zone_device_register(
+					const char *type,
+					void *devdata,
+					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_params *tzp)
+{
+	return thermal_zone_device_register_with_trips(type, NULL, 0, 0, devdata,
+						       ops, tzp, 0, 0);
+}
+EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
+
+/**
+ * thermal_zone_device_register() - register a new thermal zone device
+ * @tzdp:	Parameters of the new thermal zone device
+ *		See struct thermal_zone_device_register.
+ *
+ * This interface function adds a new thermal zone device (sensor) to
+ * /sys/class/thermal folder as thermal_zone[0-*]. It tries to bind all the
+ * thermal cooling devices registered at the same time.
+ * thermal_zone_device_unregister() must be called when the device is no
+ * longer needed. The passive cooling depends on the .get_trend() return value.
+ *
+ * Return: a pointer to the created struct thermal_zone_device or an
+ * in case of error, an ERR_PTR. Caller must check return value with
+ * IS_ERR*() helpers.
+ */
+struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_device_params *tzdp)
+{
+	struct thermal_zone_device *tz;
+	struct thermal_governor *gov;
 	int id;
 	int result;
-	struct thermal_governor *governor;
 
-	if (!type || strlen(type) == 0) {
+	if (!tzdp->tzp.type || strlen(tzdp->tzp.type) == 0) {
 		pr_err("No thermal zone type defined\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (strlen(type) >= THERMAL_NAME_LENGTH) {
+	if (strlen(tzdp->tzp.type) >= THERMAL_NAME_LENGTH) {
 		pr_err("Thermal zone name (%s) too long, should be under %d chars\n",
-		       type, THERMAL_NAME_LENGTH);
+		       tzdp->tzp.type, THERMAL_NAME_LENGTH);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -1306,17 +1369,19 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	 * Check will be true when the bit 31 of the mask is set.
 	 * 32 bit shift will cause overflow of 4 byte integer.
 	 */
-	if (num_trips > (BITS_PER_TYPE(int) - 1) || num_trips < 0 || mask >> num_trips) {
+	if (tzdp->tzp.num_trips > (BITS_PER_TYPE(int) - 1) ||
+	    tzdp->tzp.num_trips < 0 ||
+	    tzdp->tzp.mask >> tzdp->tzp.num_trips) {
 		pr_err("Incorrect number of thermal trips\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (!ops || !ops->get_temp) {
+	if (!tzdp->tzp.ops || !tzdp->tzp.ops->get_temp) {
 		pr_err("Thermal zone device ops not defined\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (num_trips > 0 && !trips)
+	if (tzdp->tzp.num_trips > 0 && !tzdp->tzp.trips)
 		return ERR_PTR(-EINVAL);
 
 	if (!thermal_class)
@@ -1326,11 +1391,17 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	if (!tz)
 		return ERR_PTR(-ENOMEM);
 
-	if (tzp) {
-		tz->tzp = kmemdup(tzp, sizeof(*tzp), GFP_KERNEL);
-		if (!tz->tzp) {
+	tz->tzp = kmemdup(&tzdp->tzp, sizeof(tzdp->tzp), GFP_KERNEL);
+	if (!tz->tzp) {
+		result = -ENOMEM;
+		goto free_tz;
+	}
+
+	if (tzdp->tgp) {
+		tz->tgp = kmemdup(tzdp->tgp, sizeof(*tzdp->tgp), GFP_KERNEL);
+		if (!tz->tgp) {
 			result = -ENOMEM;
-			goto free_tz;
+			goto free_tzp;
 		}
 	}
 
@@ -1342,27 +1413,27 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	id = ida_alloc(&thermal_tz_ida, GFP_KERNEL);
 	if (id < 0) {
 		result = id;
-		goto free_tzp;
+		goto free_tgp;
 	}
 
 	tz->id = id;
-	strscpy(tz->type, type, sizeof(tz->type));
+	strscpy(tz->type, tzdp->tzp.type, sizeof(tz->type));
 
-	if (!ops->critical)
-		ops->critical = thermal_zone_device_critical;
+	if (!tzdp->tzp.ops->critical)
+		tzdp->tzp.ops->critical = thermal_zone_device_critical;
 
-	tz->ops = ops;
+	tz->ops = tzdp->tzp.ops;
 	tz->device.class = thermal_class;
-	tz->devdata = devdata;
-	tz->trips = trips;
-	tz->num_trips = num_trips;
+	tz->devdata = tzdp->tzp.devdata;
+	tz->trips = tzdp->tzp.trips;
+	tz->num_trips = tzdp->tzp.num_trips;
 
-	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
-	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
+	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, tzdp->tzp.passive_delay);
+	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, tzdp->tzp.polling_delay);
 
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
-	result = thermal_zone_create_device_groups(tz, mask);
+	result = thermal_zone_create_device_groups(tz, tzdp->tzp.mask);
 	if (result)
 		goto remove_id;
 
@@ -1381,12 +1452,12 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	/* Update 'this' zone's governor information */
 	mutex_lock(&thermal_governor_lock);
 
-	if (tz->tzp)
-		governor = __find_governor(tz->tzp->governor_name);
+	if (tzdp->tgp)
+		gov = __find_governor(tzdp->tgp->governor_name);
 	else
-		governor = def_governor;
+		gov = def_governor;
 
-	result = thermal_set_governor(tz, governor);
+	result = thermal_set_governor(tz, gov);
 	if (result) {
 		mutex_unlock(&thermal_governor_lock);
 		goto unregister;
@@ -1394,7 +1465,7 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 
 	mutex_unlock(&thermal_governor_lock);
 
-	if (!tz->tzp || !tz->tzp->no_hwmon) {
+	if (!tzdp->tzp.no_hwmon) {
 		result = thermal_add_hwmon_sysfs(tz);
 		if (result)
 			goto unregister;
@@ -1426,24 +1497,15 @@ thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *t
 	put_device(&tz->device);
 remove_id:
 	ida_free(&thermal_tz_ida, id);
+free_tgp:
+	kfree(tz->tgp);
 free_tzp:
 	kfree(tz->tzp);
 free_tz:
 	kfree(tz);
 	return ERR_PTR(result);
 }
-EXPORT_SYMBOL_GPL(thermal_zone_device_register_with_trips);
-
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
+EXPORT_SYMBOL_GPL(thermal_zone_device_register);
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd)
 {
@@ -1514,7 +1576,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	device_del(&tz->device);
 
-	kfree(tz->tzp);
+	kfree(tz->tgp);
 
 	put_device(&tz->device);
 
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 0329f4a71b02..a72095cfb771 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -211,8 +211,8 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
  */
 int thermal_zone_get_slope(struct thermal_zone_device *tz)
 {
-	if (tz && tz->tzp)
-		return tz->tzp->slope;
+	if (tz && tz->tgp)
+		return tz->tgp->ipa_params.slope;
 	return 1;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_slope);
@@ -226,8 +226,8 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_slope);
  */
 int thermal_zone_get_offset(struct thermal_zone_device *tz)
 {
-	if (tz && tz->tzp)
-		return tz->tzp->offset;
+	if (tz && tz->tgp)
+		return tz->tgp->ipa_params.offset;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(thermal_zone_get_offset);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index f4033865b093..3f5f4a04a754 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -271,8 +271,8 @@ sustainable_power_show(struct device *dev, struct device_attribute *devattr,
 {
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 
-	if (tz->tzp)
-		return sprintf(buf, "%u\n", tz->tzp->sustainable_power);
+	if (tz->tgp)
+		return sprintf(buf, "%u\n", tz->tgp->ipa_params.sustainable_power);
 	else
 		return -EIO;
 }
@@ -284,13 +284,13 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
 	struct thermal_zone_device *tz = to_thermal_zone(dev);
 	u32 sustainable_power;
 
-	if (!tz->tzp)
+	if (!tz->tgp)
 		return -EIO;
 
 	if (kstrtou32(buf, 10, &sustainable_power))
 		return -EINVAL;
 
-	tz->tzp->sustainable_power = sustainable_power;
+	tz->tgp->ipa_params.sustainable_power = sustainable_power;
 
 	return count;
 }
@@ -302,8 +302,8 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
 	{								\
 	struct thermal_zone_device *tz = to_thermal_zone(dev);		\
 									\
-	if (tz->tzp)							\
-		return sprintf(buf, "%d\n", tz->tzp->name);		\
+	if (tz->tgp)							\
+		return sprintf(buf, "%d\n", tz->tgp->ipa_params.name);	\
 	else								\
 		return -EIO;						\
 	}								\
@@ -315,13 +315,13 @@ sustainable_power_store(struct device *dev, struct device_attribute *devattr,
 		struct thermal_zone_device *tz = to_thermal_zone(dev);	\
 		s32 value;						\
 									\
-		if (!tz->tzp)						\
+		if (!tz->tgp)						\
 			return -EIO;					\
 									\
 		if (kstrtos32(buf, 10, &value))				\
 			return -EINVAL;					\
 									\
-		tz->tzp->name = value;					\
+		tz->tgp->ipa_params.name = value;			\
 									\
 		return count;						\
 	}								\
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 65d8f92a9a0d..7a540b746703 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -149,7 +149,8 @@ struct thermal_cooling_device {
 			passive trip point.
  * @need_update:	if equals 1, thermal_zone_device_update needs to be invoked.
  * @ops:	operations this &thermal_zone_device supports
- * @tzp:	thermal zone parameters
+ * @tzp:		Thermal zone parameters
+ * @tgp:		Thermal zone governor parameters
  * @governor:	pointer to the governor for this thermal zone
  * @governor_data:	private pointer for governor data
  * @thermal_instances:	list of &struct thermal_instance of this thermal zone
@@ -184,7 +185,8 @@ struct thermal_zone_device {
 	int prev_high_trip;
 	atomic_t need_update;
 	struct thermal_zone_device_ops *ops;
-	struct thermal_zone_params *tzp;
+	struct thermal_zone_platform_params *tzp;
+	struct thermal_governor_params *tgp;
 	struct thermal_governor *governor;
 	void *governor_data;
 	struct list_head thermal_instances;
@@ -224,15 +226,12 @@ struct thermal_governor {
 	struct list_head	governor_list;
 };
 
-/* Structure to define Thermal Zone parameters */
+/* Structure to define Thermal Zone IPA parameters */
 struct thermal_zone_params {
+	/* Scheduled for removal - see struct thermal_governor_params. */
 	const char *governor_name;
 
-	/*
-	 * a boolean to indicate if the thermal to hwmon sysfs interface
-	 * is required. when no_hwmon == false, a hwmon sysfs interface
-	 * will be created. when no_hwmon == true, nothing will be done
-	 */
+	/* Scheduled for removal - see struct thermal_zone_platform_params. */
 	bool no_hwmon;
 
 	/*
@@ -274,6 +273,58 @@ struct thermal_zone_params {
 	int offset;
 };
 
+/**
+ * struct thermal_governor_params - Thermal Zone governor parameters
+ * @governor_name:	Name of the Thermal Zone governor
+ * @ipa_params:		IPA parameters for Thermal Zone governors
+ */
+struct thermal_governor_params {
+	const char *governor_name;
+	struct thermal_zone_params ipa_params;
+};
+
+/**
+ * struct thermal_zone_platform_params - Thermal Zone parameters
+ * @type:		The thermal zone device type
+ * @ops:		Standard thermal zone device callbacks
+ * @trips:		Pointer to an array of thermal trips, if any
+ * @num_trips:		Number of trip points the thermal zone support
+ * @mask:		Bit string indicating the writeablility of trip points
+ * @passive_delay:	Number of milliseconds to wait between polls when
+ *			performing passive cooling
+ * @polling_delay:	Number of milliseconds to wait between polls when checking
+ *			whether trip points have been crossed (0 for interrupt
+ *			driven systems)
+ * @devdata:		Private device data
+ * @no_hwmon:		Indicates whether the thermal to hwmon sysfs interface is
+ *			required; this means that when no_hwmon == false, a hwmon
+ *			sysfs interface will be created and when no_hwmon == true
+ *			nothing will be done
+ */
+struct thermal_zone_platform_params {
+	const char *type;
+	struct thermal_zone_device_ops *ops;
+	struct thermal_trip *trips;
+	int num_trips;
+	int mask;
+
+	int passive_delay;
+	int polling_delay;
+
+	void *devdata;
+	bool no_hwmon;
+};
+
+/**
+ * struct thermal_zone_device_params - Thermal Zone device parameters
+ * @tzp:		Thermal zone platform parameters
+ * @tgp:		Thermal zone governor parameters
+ */
+struct thermal_zone_device_params {
+	struct thermal_zone_platform_params tzp;
+	struct thermal_governor_params *tgp;
+};
+
 /* Function declarations */
 #ifdef CONFIG_THERMAL_OF
 struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, int id, void *data,
@@ -328,6 +379,8 @@ struct thermal_zone_device *thermal_tripless_zone_device_register(
 					struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp);
 
+struct thermal_zone_device *thermal_zone_device_register(struct thermal_zone_device_params *tzdp);
+
 void thermal_zone_device_unregister(struct thermal_zone_device *tz);
 
 void *thermal_zone_device_priv(struct thermal_zone_device *tzd);
@@ -390,6 +443,10 @@ static inline struct thermal_zone_device *thermal_tripless_zone_device_register(
 					const struct thermal_zone_params *tzp)
 { return ERR_PTR(-ENODEV); }
 
+static inline struct thermal_zone_device *thermal_zone_device_register(
+					struct thermal_zone_device_params *tzdp)
+{ return ERR_PTR(-ENODEV); }
+
 static inline void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 { }
 
-- 
2.43.0


