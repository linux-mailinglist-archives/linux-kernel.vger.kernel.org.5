Return-Path: <linux-kernel+bounces-65215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC4385499D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1011C21ECF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246385467A;
	Wed, 14 Feb 2024 12:50:09 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3881A731;
	Wed, 14 Feb 2024 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915008; cv=none; b=g7rn+r3f01zvoLYcX5PahCEGaiZHk56Holn1rclsqDNnTelSrEE5wErcXDwWTX4jMO3APFG31xk78HydNGHlP+RJstKK7M1JVbYahHDmGHWA1RPeCES9GCq0HIA9ytUiMFoU2q7UhTKwIMVUV3L7logUZzqsPMAnho/JJ51nqVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915008; c=relaxed/simple;
	bh=B/ujohE3qiBVLmi+Jpy5fRBSCruD6diBDw5p9EMxt8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGuDPUuSTxshgFp18NoHs+7Wio196Qf4qPXPYte6QhLV99BKISfYJmVY7vZGtRSq4BgLEEG+NKVbeDXwRVdl5YSTBoqIhNyuzvYr+MCFWleCFEPolKwSCfCyjyMBIPFeDoOQV4dX3wVpX1T9+2xeOV2eld0zCZ8BzR/b4RE456I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 798074c4873750b2; Wed, 14 Feb 2024 13:49:55 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 48C0A669DB7;
	Wed, 14 Feb 2024 13:49:55 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Subject:
 [PATCH v2 4/6] thermal: core: Store zone ops in struct thermal_zone_device
Date: Wed, 14 Feb 2024 13:45:23 +0100
Message-ID: <2262393.iZASKD2KPV@kreacher>
In-Reply-To: <4551531.LvFx2qVVIh@kreacher>
References: <4551531.LvFx2qVVIh@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The current code requires thermal zone creators to pass pointers to
writable ops structures to thermal_zone_device_register_with_trips()
which needs to modify the target struct thermal_zone_device_ops object
if the "critical" operation in it is NULL.

Moreover, the callers of thermal_zone_device_register_with_trips() are
required to hold on to the struct thermal_zone_device_ops object passed
to it until the given thermal zone is unregistered.

Both of these requirements are quite inconvenient, so modify struct
thermal_zone_device to contain struct thermal_zone_device_ops as field and
make thermal_zone_device_register_with_trips() copy the contents of the
struct thermal_zone_device_ops passed to it via a pointer (which can be
const now) to that field.

Also adjust the code using thermal zone ops accordingly and modify
thermal_of_zone_register() to use a local ops variable during
thermal zone registration so ops do not need to be freed in
thermal_of_zone_unregister() any more.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---

v1 -> v2:
   * Rebase.
   * Add thermal_of modifications.
   * Add R-by from Stanislaw (still applicable IMV).

---
 drivers/thermal/thermal_core.c    |   40 +++++++++++++++++++-------------------
 drivers/thermal/thermal_helpers.c |   10 ++++-----
 drivers/thermal/thermal_hwmon.c   |    4 +--
 drivers/thermal/thermal_of.c      |   26 +++++++-----------------
 drivers/thermal/thermal_sysfs.c   |    8 +++----
 drivers/thermal/thermal_trip.c    |    4 +--
 include/linux/thermal.h           |    6 ++---
 7 files changed, 44 insertions(+), 54 deletions(-)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -189,7 +189,7 @@ struct thermal_zone_device {
 	int prev_low_trip;
 	int prev_high_trip;
 	atomic_t need_update;
-	struct thermal_zone_device_ops *ops;
+	struct thermal_zone_device_ops ops;
 	struct thermal_zone_params *tzp;
 	struct thermal_governor *governor;
 	void *governor_data;
@@ -324,14 +324,14 @@ struct thermal_zone_device *thermal_zone
 					const char *type,
 					const struct thermal_trip *trips,
 					int num_trips, void *devdata,
-					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp,
 					int passive_delay, int polling_delay);
 
 struct thermal_zone_device *thermal_tripless_zone_device_register(
 					const char *type,
 					void *devdata,
-					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp);
 
 void thermal_zone_device_unregister(struct thermal_zone_device *tz);
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -356,9 +356,9 @@ static void handle_critical_trips(struct
 	trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, trip), trip->type);
 
 	if (trip->type == THERMAL_TRIP_CRITICAL)
-		tz->ops->critical(tz);
-	else if (tz->ops->hot)
-		tz->ops->hot(tz);
+		tz->ops.critical(tz);
+	else if (tz->ops.hot)
+		tz->ops.hot(tz);
 }
 
 static void handle_thermal_trip(struct thermal_zone_device *tz,
@@ -493,8 +493,8 @@ static int thermal_zone_device_set_mode(
 		return ret;
 	}
 
-	if (tz->ops->change_mode)
-		ret = tz->ops->change_mode(tz, mode);
+	if (tz->ops.change_mode)
+		ret = tz->ops.change_mode(tz, mode);
 
 	if (!ret)
 		tz->mode = mode;
@@ -867,8 +867,8 @@ static void bind_cdev(struct thermal_coo
 	struct thermal_zone_device *pos = NULL;
 
 	list_for_each_entry(pos, &thermal_tz_list, node) {
-		if (pos->ops->bind) {
-			ret = pos->ops->bind(pos, cdev);
+		if (pos->ops.bind) {
+			ret = pos->ops.bind(pos, cdev);
 			if (ret)
 				print_bind_err_msg(pos, cdev, ret);
 		}
@@ -1184,8 +1184,8 @@ void thermal_cooling_device_unregister(s
 
 	/* Unbind all thermal zones associated with 'this' cdev */
 	list_for_each_entry(tz, &thermal_tz_list, node) {
-		if (tz->ops->unbind)
-			tz->ops->unbind(tz, cdev);
+		if (tz->ops.unbind)
+			tz->ops.unbind(tz, cdev);
 	}
 
 	mutex_unlock(&thermal_list_lock);
@@ -1199,13 +1199,13 @@ static void bind_tz(struct thermal_zone_
 	int ret;
 	struct thermal_cooling_device *pos = NULL;
 
-	if (!tz->ops->bind)
+	if (!tz->ops.bind)
 		return;
 
 	mutex_lock(&thermal_list_lock);
 
 	list_for_each_entry(pos, &thermal_cdev_list, node) {
-		ret = tz->ops->bind(tz, pos);
+		ret = tz->ops.bind(tz, pos);
 		if (ret)
 			print_bind_err_msg(tz, pos, ret);
 	}
@@ -1224,8 +1224,8 @@ int thermal_zone_get_crit_temp(struct th
 {
 	int i, ret = -EINVAL;
 
-	if (tz->ops->get_crit_temp)
-		return tz->ops->get_crit_temp(tz, temp);
+	if (tz->ops.get_crit_temp)
+		return tz->ops.get_crit_temp(tz, temp);
 
 	mutex_lock(&tz->lock);
 
@@ -1271,7 +1271,7 @@ struct thermal_zone_device *
 thermal_zone_device_register_with_trips(const char *type,
 					const struct thermal_trip *trips,
 					int num_trips, void *devdata,
-					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp,
 					int passive_delay, int polling_delay)
 {
@@ -1333,10 +1333,10 @@ thermal_zone_device_register_with_trips(
 	tz->id = id;
 	strscpy(tz->type, type, sizeof(tz->type));
 
-	if (!ops->critical)
-		ops->critical = thermal_zone_device_critical;
+	tz->ops = *ops;
+	if (!tz->ops.critical)
+		tz->ops.critical = thermal_zone_device_critical;
 
-	tz->ops = ops;
 	tz->device.class = thermal_class;
 	tz->devdata = devdata;
 	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
@@ -1422,7 +1422,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_re
 struct thermal_zone_device *thermal_tripless_zone_device_register(
 					const char *type,
 					void *devdata,
-					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp)
 {
 	return thermal_zone_device_register_with_trips(type, NULL, 0, devdata,
@@ -1484,8 +1484,8 @@ void thermal_zone_device_unregister(stru
 
 	/* Unbind all cdevs associated with 'this' thermal zone */
 	list_for_each_entry(cdev, &thermal_cdev_list, node)
-		if (tz->ops->unbind)
-			tz->ops->unbind(tz, cdev);
+		if (tz->ops.unbind)
+			tz->ops.unbind(tz, cdev);
 
 	mutex_unlock(&thermal_list_lock);
 
Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -128,8 +128,8 @@ trip_point_temp_store(struct device *dev
 	}
 
 	if (temp != trip->temperature) {
-		if (tz->ops->set_trip_temp) {
-			ret = tz->ops->set_trip_temp(tz, trip_id, temp);
+		if (tz->ops.set_trip_temp) {
+			ret = tz->ops.set_trip_temp(tz, trip_id, temp);
 			if (ret)
 				goto unlock;
 		}
@@ -254,10 +254,10 @@ emul_temp_store(struct device *dev, stru
 
 	mutex_lock(&tz->lock);
 
-	if (!tz->ops->set_emul_temp)
+	if (!tz->ops.set_emul_temp)
 		tz->emul_temperature = temperature;
 	else
-		ret = tz->ops->set_emul_temp(tz, temperature);
+		ret = tz->ops.set_emul_temp(tz, temperature);
 
 	if (!ret)
 		__thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -26,8 +26,8 @@ int get_tz_trend(struct thermal_zone_dev
 {
 	enum thermal_trend trend;
 
-	if (tz->emul_temperature || !tz->ops->get_trend ||
-	    tz->ops->get_trend(tz, trip, &trend)) {
+	if (tz->emul_temperature || !tz->ops.get_trend ||
+	    tz->ops.get_trend(tz, trip, &trend)) {
 		if (tz->temperature > tz->last_temperature)
 			trend = THERMAL_TREND_RAISING;
 		else if (tz->temperature < tz->last_temperature)
@@ -75,7 +75,7 @@ EXPORT_SYMBOL(get_thermal_instance);
  * temperature and fill @temp.
  *
  * Both tz and tz->ops must be valid pointers when calling this function,
- * and the tz->ops->get_temp callback must be provided.
+ * and the tz->ops.get_temp callback must be provided.
  * The function must be called under tz->lock.
  *
  * Return: On success returns 0, an error code otherwise
@@ -88,7 +88,7 @@ int __thermal_zone_get_temp(struct therm
 
 	lockdep_assert_held(&tz->lock);
 
-	ret = tz->ops->get_temp(tz, temp);
+	ret = tz->ops.get_temp(tz, temp);
 
 	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
 		for_each_trip(tz, trip) {
@@ -132,7 +132,7 @@ int thermal_zone_get_temp(struct thermal
 
 	mutex_lock(&tz->lock);
 
-	if (!tz->ops->get_temp) {
+	if (!tz->ops.get_temp) {
 		ret = -EINVAL;
 		goto unlock;
 	}
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -70,7 +70,7 @@ void __thermal_zone_set_trips(struct the
 
 	lockdep_assert_held(&tz->lock);
 
-	if (!tz->ops->set_trips)
+	if (!tz->ops.set_trips)
 		return;
 
 	for_each_trip(tz, trip) {
@@ -114,7 +114,7 @@ void __thermal_zone_set_trips(struct the
 	 * Set a temperature window. When this window is left the driver
 	 * must inform the thermal core via thermal_zone_device_update.
 	 */
-	ret = tz->ops->set_trips(tz, low, high);
+	ret = tz->ops.set_trips(tz, low, high);
 	if (ret)
 		dev_err(&tz->device, "Failed to set trips: %d\n", ret);
 }
Index: linux-pm/drivers/thermal/thermal_hwmon.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_hwmon.c
+++ linux-pm/drivers/thermal/thermal_hwmon.c
@@ -80,7 +80,7 @@ temp_crit_show(struct device *dev, struc
 
 	mutex_lock(&tz->lock);
 
-	ret = tz->ops->get_crit_temp(tz, &temperature);
+	ret = tz->ops.get_crit_temp(tz, &temperature);
 
 	mutex_unlock(&tz->lock);
 
@@ -132,7 +132,7 @@ thermal_hwmon_lookup_temp(const struct t
 static bool thermal_zone_crit_temp_valid(struct thermal_zone_device *tz)
 {
 	int temp;
-	return tz->ops->get_crit_temp && !tz->ops->get_crit_temp(tz, &temp);
+	return tz->ops.get_crit_temp && !tz->ops.get_crit_temp(tz, &temp);
 }
 
 int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
Index: linux-pm/drivers/thermal/thermal_of.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_of.c
+++ linux-pm/drivers/thermal/thermal_of.c
@@ -441,12 +441,10 @@ static int thermal_of_unbind(struct ther
 static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 {
 	struct thermal_trip *trips = tz->trips;
-	struct thermal_zone_device_ops *ops = tz->ops;
 
 	thermal_zone_device_disable(tz);
 	thermal_zone_device_unregister(tz);
 	kfree(trips);
-	kfree(ops);
 }
 
 /**
@@ -472,33 +470,27 @@ static void thermal_of_zone_unregister(s
 static struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
 							    const struct thermal_zone_device_ops *ops)
 {
+	struct thermal_zone_device_ops of_ops = *ops;
 	struct thermal_zone_device *tz;
 	struct thermal_trip *trips;
 	struct thermal_zone_params tzp = {};
-	struct thermal_zone_device_ops *of_ops;
 	struct device_node *np;
 	const char *action;
 	int delay, pdelay;
 	int ntrips;
 	int ret;
 
-	of_ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
-	if (!of_ops)
-		return ERR_PTR(-ENOMEM);
-
 	np = of_thermal_zone_find(sensor, id);
 	if (IS_ERR(np)) {
 		if (PTR_ERR(np) != -ENODEV)
 			pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
-		ret = PTR_ERR(np);
-		goto out_kfree_of_ops;
+		return ERR_CAST(np);
 	}
 
 	trips = thermal_of_trips_init(np, &ntrips);
 	if (IS_ERR(trips)) {
 		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-		ret = PTR_ERR(trips);
-		goto out_kfree_of_ops;
+		return ERR_CAST(trips);
 	}
 
 	ret = thermal_of_monitor_init(np, &delay, &pdelay);
@@ -509,16 +501,16 @@ static struct thermal_zone_device *therm
 
 	thermal_of_parameters_init(np, &tzp);
 
-	of_ops->bind = thermal_of_bind;
-	of_ops->unbind = thermal_of_unbind;
+	of_ops.bind = thermal_of_bind;
+	of_ops.unbind = thermal_of_unbind;
 
 	ret = of_property_read_string(np, "critical-action", &action);
 	if (!ret)
-		if (!of_ops->critical && !strcasecmp(action, "reboot"))
-			of_ops->critical = thermal_zone_device_critical_reboot;
+		if (!of_ops.critical && !strcasecmp(action, "reboot"))
+			of_ops.critical = thermal_zone_device_critical_reboot;
 
 	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
-						     data, of_ops, &tzp,
+						     data, &of_ops, &tzp,
 						     pdelay, delay);
 	if (IS_ERR(tz)) {
 		ret = PTR_ERR(tz);
@@ -538,8 +530,6 @@ static struct thermal_zone_device *therm
 
 out_kfree_trips:
 	kfree(trips);
-out_kfree_of_ops:
-	kfree(of_ops);
 
 	return ERR_PTR(ret);
 }




