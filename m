Return-Path: <linux-kernel+bounces-53970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D2584A898
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A71C1C2A72D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A86450245;
	Mon,  5 Feb 2024 21:21:19 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09184F8AB;
	Mon,  5 Feb 2024 21:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168078; cv=none; b=Zyv6N0WSOvmUBdmORiY+DoyELm8jWIKvNdPZjJCtWbjEQsc2WT2xaTZ4NqkxF8XBKLsp9e+deF8oQYMqWwIUdP6vzfugAuzJ55UGKvZsarYh528wc0S9oKYW6ZXKmXBwildXNDuxgFjtyabsFQZOaqHKfV3cedkhsPDiB/yF6Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168078; c=relaxed/simple;
	bh=nrtyd9qrnjDa31ew4XMhQisV5sxzFmovIBdXrZTqY4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Orsuk8v0NxnkFRQRCZR3Ed+hcIkUPtJMviMnpRCUjpdQ6+yMJFFsrZ4Mspq58rvLgFd3qqU4Vnv5F5eSx+9UuPFOViNTO21TDVdLC40ZXNRwhhS3/AAc1fkrsSFEt/NUNb37BdcD7mnha9Pmt+KIolvZHnTn2K+DjOQu4tsYZBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 4a2c3c8163b1cc38; Mon, 5 Feb 2024 22:21:07 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1DE03669A1B;
	Mon,  5 Feb 2024 22:21:07 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject:
 [PATCH v1 4/6] thermal: core: Store zone ops in struct thermal_zone_device
Date: Mon, 05 Feb 2024 22:18:02 +0100
Message-ID: <1888343.tdWV9SEqCh@kreacher>
In-Reply-To: <2728491.mvXUDI8C0e@kreacher>
References: <2728491.mvXUDI8C0e@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfedvuddgheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepledprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The current code requires thermal zone creators to pass pointers to
writable ops to thermal_zone_device_register_with_trips() which needs
to modify the target struct thermal_zone_device_ops object if the
"critical" operation in it is NULL.

Moreover, the callers of thermal_zone_device_register_with_trips() are
required to hold on to the struct thermal_zone_device_ops object passed
to it until the given thermal zone is unregistered.

Both of these requirements are quite inconvenient, so modify struct
thermal_zone_device to contain struct thermal_zone_device_ops as field and
make thermal_zone_device_register_with_trips() copy the contents of the
struct thermal_zone_device_ops passed to it via a pointer (which can be
const now) to that field.  Also adjust the code using thermal zone ops
accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c    |   40 +++++++++++++++++++-------------------
 drivers/thermal/thermal_helpers.c |   10 ++++-----
 drivers/thermal/thermal_hwmon.c   |    4 +--
 drivers/thermal/thermal_sysfs.c   |   12 +++++------
 drivers/thermal/thermal_trip.c    |    4 +--
 include/linux/thermal.h           |    6 ++---
 6 files changed, 38 insertions(+), 38 deletions(-)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -182,7 +182,7 @@ struct thermal_zone_device {
 	int prev_low_trip;
 	int prev_high_trip;
 	atomic_t need_update;
-	struct thermal_zone_device_ops *ops;
+	struct thermal_zone_device_ops ops;
 	struct thermal_zone_params *tzp;
 	struct thermal_governor *governor;
 	void *governor_data;
@@ -318,14 +318,14 @@ struct thermal_zone_device *thermal_zone
 					const struct thermal_trip *trips,
 					int num_trips, int mask,
 					void *devdata,
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
 
 	if (!tz->trips)
 		return -EINVAL;
@@ -1276,7 +1276,7 @@ thermal_zone_device_register_with_trips(
 					const struct thermal_trip *trips,
 					int num_trips, int mask,
 					void *devdata,
-					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp,
 					int passive_delay, int polling_delay)
 {
@@ -1350,10 +1350,10 @@ thermal_zone_device_register_with_trips(
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
 	memcpy(tz->trips, trips, num_trips * sizeof(trips[0]));
@@ -1439,7 +1439,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_device_re
 struct thermal_zone_device *thermal_tripless_zone_device_register(
 					const char *type,
 					void *devdata,
-					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp)
 {
 	return thermal_zone_device_register_with_trips(type, NULL, 0, 0, devdata,
@@ -1501,8 +1501,8 @@ void thermal_zone_device_unregister(stru
 
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
@@ -123,8 +123,8 @@ trip_point_temp_store(struct device *dev
 	trip = &tz->trips[trip_id];
 
 	if (temp != trip->temperature) {
-		if (tz->ops->set_trip_temp) {
-			ret = tz->ops->set_trip_temp(tz, trip_id, temp);
+		if (tz->ops.set_trip_temp) {
+			ret = tz->ops.set_trip_temp(tz, trip_id, temp);
 			if (ret)
 				goto unlock;
 		}
@@ -174,8 +174,8 @@ trip_point_hyst_store(struct device *dev
 	trip = &tz->trips[trip_id];
 
 	if (hyst != trip->hysteresis) {
-		if (tz->ops->set_trip_hyst) {
-			ret = tz->ops->set_trip_hyst(tz, trip_id, hyst);
+		if (tz->ops.set_trip_hyst) {
+			ret = tz->ops.set_trip_hyst(tz, trip_id, hyst);
 			if (ret)
 				goto unlock;
 		}
@@ -250,10 +250,10 @@ emul_temp_store(struct device *dev, stru
 
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




