Return-Path: <linux-kernel+bounces-59439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF36C84F722
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE99F1C223AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139CE7BB0C;
	Fri,  9 Feb 2024 14:14:53 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FE47867D;
	Fri,  9 Feb 2024 14:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488092; cv=none; b=GFAxptUVTRP+ML8qep92bi+6VcIsmWfPy5e+ewAeQmv2fI2jiSe/ao1LCFR7cHIcoYo4TC8nnEnyq6Ev/JNp9VU+yLpiRMNjRadg55YWClOLNlMhymY9RCKTk+wP5wB9HIi90EyITzABgP7I4YCQDbNjBTnLZTOjldicwb07HUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488092; c=relaxed/simple;
	bh=iyvlwc3EOmpZ2lJqDjD3YbtFrwjtOtM4CH3EkmXDNX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzssANl7/BtvX+m2dFsYv/bkHStK9hoJ+Ad4tkxojeMS9CAxGAbDVyHuajy8VjDJZD1QWjEWrfoLuEq6yDh+bzrzhYBZN68i0Z0tt+US01gxs4kq9UOl9Zf8OLZQxpfdU7T4bg2fn2H/bGSzO+/o9QWFx6xby3AKKgi/4pwupGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id a66302ca18b67ebd; Fri, 9 Feb 2024 15:14:47 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id F0013669C4D;
	Fri,  9 Feb 2024 15:14:46 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject: [PATCH v1 2/9] thermal: core: Add flags to struct thermal_trip
Date: Fri, 09 Feb 2024 15:06:16 +0100
Message-ID: <2002876.usQuhbGJ8B@kreacher>
In-Reply-To: <3232442.5fSG56mABF@kreacher>
References: <3232442.5fSG56mABF@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdeiudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgr
 nhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In order to allow thermal zone creators to specify the writability of
trip point temperature and hysteresis on a per-trip basis, add a flags
field to struct thermal_trip and define flags to represent the desired
trip properties.

Also make thermal_zone_device_register_with_trips() set the
THERMAL_TRIP_WRITABLE_TEMP flag for all trips covered by the writable
trips mask passed to it and modify the thermal sysfs code to look at
the trip flags instead of using the writable trips mask directly or
checking the presence of the .set_trip_hyst() zone callback.

Additionally, make trip_point_temp_store() and trip_point_hyst_store()
fail with an error code if the trip passed to one of them has
THERMAL_TRIP_WRITABLE_TEMP or THERMAL_TRIP_WRITABLE_HYST,
respectively, clear in its flags.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c  |   12 +++++++++++-
 drivers/thermal/thermal_core.h  |    2 +-
 drivers/thermal/thermal_sysfs.c |   28 +++++++++++++++++++---------
 include/linux/thermal.h         |    7 +++++++
 4 files changed, 38 insertions(+), 11 deletions(-)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -64,15 +64,22 @@ enum thermal_notify_event {
  * @threshold: trip crossing notification threshold miliCelsius
  * @type: trip point type
  * @priv: pointer to driver data associated with this trip
+ * @flags: flags representing binary properties of the trip
  */
 struct thermal_trip {
 	int temperature;
 	int hysteresis;
 	int threshold;
 	enum thermal_trip_type type;
+	u8 flags;
 	void *priv;
 };
 
+#define THERMAL_TRIP_WRITABLE_TEMP	BIT(0)
+#define THERMAL_TRIP_WRITABLE_HYST	BIT(1)
+
+#define THERMAL_TRIP_WRITABLE	(THERMAL_TRIP_WRITABLE_TEMP | THERMAL_TRIP_WRITABLE_HYST)
+
 struct thermal_zone_device_ops {
 	int (*bind) (struct thermal_zone_device *,
 		     struct thermal_cooling_device *);
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1356,13 +1356,23 @@ thermal_zone_device_register_with_trips(
 	tz->devdata = devdata;
 	tz->trips = trips;
 	tz->num_trips = num_trips;
+	if (num_trips > 0) {
+		struct thermal_trip *trip;
+
+		for_each_trip(tz, trip) {
+			if (mask & 1)
+				trip->flags |= THERMAL_TRIP_WRITABLE_TEMP;
+
+			mask >>= 1;
+		}
+	}
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
 
 	/* sys I/F */
 	/* Add nodes that are always present via .groups */
-	result = thermal_zone_create_device_groups(tz, mask);
+	result = thermal_zone_create_device_groups(tz);
 	if (result)
 		goto remove_id;
 
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -131,7 +131,7 @@ void thermal_zone_trip_updated(struct th
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 
 /* sysfs I/F */
-int thermal_zone_create_device_groups(struct thermal_zone_device *, int);
+int thermal_zone_create_device_groups(struct thermal_zone_device *tz);
 void thermal_zone_destroy_device_groups(struct thermal_zone_device *);
 void thermal_cooling_device_setup_sysfs(struct thermal_cooling_device *);
 void thermal_cooling_device_destroy_sysfs(struct thermal_cooling_device *cdev);
Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -122,6 +122,11 @@ trip_point_temp_store(struct device *dev
 
 	trip = &tz->trips[trip_id];
 
+	if (!(trip->flags & THERMAL_TRIP_WRITABLE_TEMP)) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
 	if (temp != trip->temperature) {
 		if (tz->ops->set_trip_temp) {
 			ret = tz->ops->set_trip_temp(tz, trip_id, temp);
@@ -173,6 +178,11 @@ trip_point_hyst_store(struct device *dev
 
 	trip = &tz->trips[trip_id];
 
+	if (!(trip->flags & THERMAL_TRIP_WRITABLE_HYST)) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
 	if (hyst != trip->hysteresis) {
 		if (tz->ops->set_trip_hyst) {
 			ret = tz->ops->set_trip_hyst(tz, trip_id, hyst);
@@ -392,17 +402,16 @@ static const struct attribute_group *the
 /**
  * create_trip_attrs() - create attributes for trip points
  * @tz:		the thermal zone device
- * @mask:	Writeable trip point bitmap.
  *
  * helper function to instantiate sysfs entries for every trip
  * point and its properties of a struct thermal_zone_device.
  *
  * Return: 0 on success, the proper error value otherwise.
  */
-static int create_trip_attrs(struct thermal_zone_device *tz, int mask)
+static int create_trip_attrs(struct thermal_zone_device *tz)
 {
+	const struct thermal_trip *trip;
 	struct attribute **attrs;
-	int indx;
 
 	/* This function works only for zones with at least one trip */
 	if (tz->num_trips <= 0)
@@ -437,7 +446,9 @@ static int create_trip_attrs(struct ther
 		return -ENOMEM;
 	}
 
-	for (indx = 0; indx < tz->num_trips; indx++) {
+	for_each_trip(tz, trip) {
+		int indx = thermal_zone_trip_id(tz, trip);
+
 		/* create trip type attribute */
 		snprintf(tz->trip_type_attrs[indx].name, THERMAL_NAME_LENGTH,
 			 "trip_point_%d_type", indx);
@@ -458,7 +469,7 @@ static int create_trip_attrs(struct ther
 						tz->trip_temp_attrs[indx].name;
 		tz->trip_temp_attrs[indx].attr.attr.mode = S_IRUGO;
 		tz->trip_temp_attrs[indx].attr.show = trip_point_temp_show;
-		if (mask & (1 << indx)) {
+		if (trip->flags & THERMAL_TRIP_WRITABLE_TEMP) {
 			tz->trip_temp_attrs[indx].attr.attr.mode |= S_IWUSR;
 			tz->trip_temp_attrs[indx].attr.store =
 							trip_point_temp_store;
@@ -473,7 +484,7 @@ static int create_trip_attrs(struct ther
 					tz->trip_hyst_attrs[indx].name;
 		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
 		tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
-		if (tz->ops->set_trip_hyst) {
+		if (trip->flags & THERMAL_TRIP_WRITABLE_HYST) {
 			tz->trip_hyst_attrs[indx].attr.attr.mode |= S_IWUSR;
 			tz->trip_hyst_attrs[indx].attr.store =
 					trip_point_hyst_store;
@@ -505,8 +516,7 @@ static void destroy_trip_attrs(struct th
 	kfree(tz->trips_attribute_group.attrs);
 }
 
-int thermal_zone_create_device_groups(struct thermal_zone_device *tz,
-				      int mask)
+int thermal_zone_create_device_groups(struct thermal_zone_device *tz)
 {
 	const struct attribute_group **groups;
 	int i, size, result;
@@ -522,7 +532,7 @@ int thermal_zone_create_device_groups(st
 		groups[i] = thermal_zone_attribute_groups[i];
 
 	if (tz->num_trips) {
-		result = create_trip_attrs(tz, mask);
+		result = create_trip_attrs(tz);
 		if (result) {
 			kfree(groups);
 




