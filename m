Return-Path: <linux-kernel+bounces-62213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C775F851D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E20D1F23D40
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEA74D9ED;
	Mon, 12 Feb 2024 18:42:38 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0661F46B80;
	Mon, 12 Feb 2024 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763357; cv=none; b=mrHi8YdNn89XSnWRyblASvs42OdU7tFVxE3fOw+tdxCrkruveO4r96KtKk6Ig0m1WQlrkdxSLLmBxOkuXTCOwLzfIzAlIhPbfDAitsq8e8fs4zFwNksTYMuDKzeGOmdAHESYUlV8cBDs7lLruliBP0lWUaS3pCzGGk5mKY+nBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763357; c=relaxed/simple;
	bh=wj2ycacNWn0hCZghvwjFNw/BDfk05TWUJ/+mzHxUew0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMYutbaljkvUsnMYxH9wuOrVPihTOIAyNKJ5X3OFLhrQ0L1qtTCaV55lXIsyyClDnM9MCmeIBqgTSQXzplcxPK2tRCk5oZXiubK/lGpCehF0QJ8PbDHb4rpT3tfpkvwRqPZjnU9+9LJUkKRZmJSh2plcICZhUNYsohUhdhvyguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 2db039505757ed15; Mon, 12 Feb 2024 19:42:33 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6B485669CF2;
	Mon, 12 Feb 2024 19:42:32 +0100 (CET)
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
Subject: [PATCH v2 2/9] thermal: core: Add flags to struct thermal_trip
Date: Mon, 12 Feb 2024 19:31:28 +0100
Message-ID: <2173914.irdbgypaU6@kreacher>
In-Reply-To: <6017196.lOV4Wx5bFT@kreacher>
References: <6017196.lOV4Wx5bFT@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepudeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshht
 rghnihhslhgrfidrghhruhhsiihkrgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In order to allow thermal zone creators to specify the writability of
trip point temperature and hysteresis on a per-trip basis, add a flags
field to struct thermal_trip and define flags to represent the desired
trip properties.

Also make thermal_zone_device_register_with_trips() set the
THERMAL_TRIP_FLAG_RW_TEMP flag for all trips covered by the writable
trips mask passed to it and modify the thermal sysfs code to look at
the trip flags instead of using the writable trips mask directly or
checking the presence of the .set_trip_hyst() zone callback.

Additionally, make trip_point_temp_store() and trip_point_hyst_store()
fail with an error code if the trip passed to one of them has
THERMAL_TRIP_FLAG_RW_TEMP or THERMAL_TRIP_FLAG_RW_HYST,
respectively, clear in its flags.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Rename trip flags (Stanislaw).

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
@@ -64,15 +64,23 @@ enum thermal_notify_event {
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
 
+#define THERMAL_TRIP_FLAG_RW_TEMP	BIT(0)
+#define THERMAL_TRIP_FLAG_RW_HYST	BIT(1)
+
+#define THERMAL_TRIP_FLAG_MASK_RW	(THERMAL_TRIP_FLAG_RW_TEMP | \
+					 THERMAL_TRIP_FLAG_RW_HYST)
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
+				trip->flags |= THERMAL_TRIP_FLAG_RW_TEMP;
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
 
+	if (!(trip->flags & THERMAL_TRIP_FLAG_RW_TEMP)) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
 	if (temp != trip->temperature) {
 		if (tz->ops->set_trip_temp) {
 			ret = tz->ops->set_trip_temp(tz, trip_id, temp);
@@ -173,6 +178,11 @@ trip_point_hyst_store(struct device *dev
 
 	trip = &tz->trips[trip_id];
 
+	if (!(trip->flags & THERMAL_TRIP_FLAG_RW_HYST)) {
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
+		if (trip->flags & THERMAL_TRIP_FLAG_RW_TEMP) {
 			tz->trip_temp_attrs[indx].attr.attr.mode |= S_IWUSR;
 			tz->trip_temp_attrs[indx].attr.store =
 							trip_point_temp_store;
@@ -473,7 +484,7 @@ static int create_trip_attrs(struct ther
 					tz->trip_hyst_attrs[indx].name;
 		tz->trip_hyst_attrs[indx].attr.attr.mode = S_IRUGO;
 		tz->trip_hyst_attrs[indx].attr.show = trip_point_hyst_show;
-		if (tz->ops->set_trip_hyst) {
+		if (trip->flags & THERMAL_TRIP_FLAG_RW_HYST) {
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
 




