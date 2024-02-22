Return-Path: <linux-kernel+bounces-76634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3CE85FA4A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91036289EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AEB135A4A;
	Thu, 22 Feb 2024 13:52:08 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CE936AE9;
	Thu, 22 Feb 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609927; cv=none; b=hBY6f0KeqKfxYbVcTc+3LLLh1FVyHFJtFWeeRoblOOJtqVtUSlJLjysBnxQSHneb8ZLGjr6P19kEmZFwfqMrv+Ea61hmLjiBKTDruvC3/YDk83ptHGIYp2D1xSoNxFais/R51pxF20wge2yypYCzb3ynRldDxglEGUlu1UbfEE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609927; c=relaxed/simple;
	bh=OhYf/fW/BjNkoGq5NK11PhQu8qy/+qzAGmgOcQGQMss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTzl9OTW1+ds2jgfKIJqpHRdejNb5TSUa1san/++nSCVMHTrNNGxCTUBtmAGBWldXoQUgACHg5F370UrCAVN1vhbQ7V+bgAg/vQ0/tpNnYPXqViP/wwE5lT4y039ZegeD6QgWYi3Fl3aN+uNN6RxPD3nvizP8Q3im8s5C9NYKrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id cf2c27720063d7a6; Thu, 22 Feb 2024 14:52:02 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 889F966A2AE;
	Thu, 22 Feb 2024 14:52:01 +0100 (CET)
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
 [PATCH v2.2 1/6] thermal: core: Store zone trips table in struct
 thermal_zone_device
Date: Thu, 22 Feb 2024 14:52:01 +0100
Message-ID: <12406375.O9o76ZdvQC@kreacher>
In-Reply-To: <1883976.tdWV9SEqCh@kreacher>
References: <4551531.LvFx2qVVIh@kreacher> <1883976.tdWV9SEqCh@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggdehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The current code expects thermal zone creators to pass a pointer to a
writable trips table to thermal_zone_device_register_with_trips() and
that trips table is then used by the thermal core going forward.

Consequently, the callers of thermal_zone_device_register_with_trips()
are required to hold on to the trips table passed to it until the given
thermal zone is unregistered, at which point the trips table can be
freed, but at the same time they are not expected to access that table
directly.  This is both error prone and confusing.

To address it, turn the trips table pointer in struct thermal_zone_device
into a flex array (counted by its num_trips field), allocate it during
thermal zone device allocation and copy the contents of the trips table
supplied by the zone creator (which can be const now) into it, which
will allow the callers of thermal_zone_device_register_with_trips() to
drop their trip tables right after the zone registration.

This requires the imx thermal driver to be adjusted to store the new
temperature in its internal trips table in imx_set_trip_temp(), because
it will be separate from the core's trips table now and it has to be
explicitly kept in sync with the latter.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---

v2.1 -> v2.2:
   * Add missing kfree(trips) to thermal_of_zone_register() (Daniel).

v2 -> v2.1:
   * Remove the trips table freeing from thermal_of (Daniel).
   * Add R-by from Daniel.

v1 -> v2:
   * Rebase.
   * Drop all of the redundant trips[] checks against NULL.
   * Add imx change to still allow it to use its local trips table.
   * Add R-by from Stanislaw (which is still applicable IMV).

---
 drivers/thermal/imx_thermal.c  |    1 +
 drivers/thermal/thermal_core.c |   18 +++++++++---------
 drivers/thermal/thermal_of.c   |    4 ++--
 drivers/thermal/thermal_trip.c |    2 +-
 include/linux/thermal.h        |   10 +++++-----
 5 files changed, 18 insertions(+), 17 deletions(-)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -130,7 +130,6 @@ struct thermal_cooling_device {
  * @trip_hyst_attrs:	attributes for trip points for sysfs: trip hysteresis
  * @mode:		current mode of this thermal zone
  * @devdata:	private pointer for device private data
- * @trips:	an array of struct thermal_trip
  * @num_trips:	number of trip points the thermal zone supports
  * @passive_delay_jiffies: number of jiffies to wait between polls when
  *			performing passive cooling.
@@ -160,6 +159,7 @@ struct thermal_cooling_device {
  * @poll_queue:	delayed work for polling
  * @notify_event: Last notification event
  * @suspended: thermal zone suspend indicator
+ * @trips:	array of struct thermal_trip objects
  */
 struct thermal_zone_device {
 	int id;
@@ -172,7 +172,6 @@ struct thermal_zone_device {
 	struct thermal_attr *trip_hyst_attrs;
 	enum thermal_device_mode mode;
 	void *devdata;
-	struct thermal_trip *trips;
 	int num_trips;
 	unsigned long passive_delay_jiffies;
 	unsigned long polling_delay_jiffies;
@@ -193,10 +192,11 @@ struct thermal_zone_device {
 	struct list_head node;
 	struct delayed_work poll_queue;
 	enum thermal_notify_event notify_event;
+	bool suspended;
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
 #endif
-	bool suspended;
+	struct thermal_trip trips[] __counted_by(num_trips);
 };
 
 /**
@@ -315,7 +315,7 @@ int thermal_zone_get_crit_temp(struct th
 #ifdef CONFIG_THERMAL
 struct thermal_zone_device *thermal_zone_device_register_with_trips(
 					const char *type,
-					struct thermal_trip *trips,
+					const struct thermal_trip *trips,
 					int num_trips, int mask,
 					void *devdata,
 					struct thermal_zone_device_ops *ops,
@@ -375,7 +375,7 @@ void thermal_zone_device_critical(struct
 #else
 static inline struct thermal_zone_device *thermal_zone_device_register_with_trips(
 					const char *type,
-					struct thermal_trip *trips,
+					const struct thermal_trip *trips,
 					int num_trips, int mask,
 					void *devdata,
 					struct thermal_zone_device_ops *ops,
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1227,9 +1227,6 @@ int thermal_zone_get_crit_temp(struct th
 	if (tz->ops->get_crit_temp)
 		return tz->ops->get_crit_temp(tz, temp);
 
-	if (!tz->trips)
-		return -EINVAL;
-
 	mutex_lock(&tz->lock);
 
 	for (i = 0; i < tz->num_trips; i++) {
@@ -1272,10 +1269,13 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_
  * IS_ERR*() helpers.
  */
 struct thermal_zone_device *
-thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int num_trips, int mask,
-					void *devdata, struct thermal_zone_device_ops *ops,
-					const struct thermal_zone_params *tzp, int passive_delay,
-					int polling_delay)
+thermal_zone_device_register_with_trips(const char *type,
+					const struct thermal_trip *trips,
+					int num_trips, int mask,
+					void *devdata,
+					struct thermal_zone_device_ops *ops,
+					const struct thermal_zone_params *tzp,
+					int passive_delay, int polling_delay)
 {
 	struct thermal_zone_device *tz;
 	int id;
@@ -1322,7 +1322,7 @@ thermal_zone_device_register_with_trips(
 	if (!thermal_class)
 		return ERR_PTR(-ENODEV);
 
-	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
+	tz = kzalloc(struct_size(tz, trips, num_trips), GFP_KERNEL);
 	if (!tz)
 		return ERR_PTR(-ENOMEM);
 
@@ -1354,7 +1354,7 @@ thermal_zone_device_register_with_trips(
 	tz->ops = ops;
 	tz->device.class = thermal_class;
 	tz->devdata = devdata;
-	tz->trips = trips;
+	memcpy(tz->trips, trips, num_trips * sizeof(*trips));
 	tz->num_trips = num_trips;
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
Index: linux-pm/drivers/thermal/imx_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/imx_thermal.c
+++ linux-pm/drivers/thermal/imx_thermal.c
@@ -354,6 +354,7 @@ static int imx_set_trip_temp(struct ther
 		return -EINVAL;
 
 	imx_set_alarm_temp(data, temp);
+	trips[IMX_TRIP_PASSIVE].temperature = temp;
 
 	pm_runtime_put(data->dev);
 
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -122,7 +122,7 @@ void __thermal_zone_set_trips(struct the
 int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			    struct thermal_trip *trip)
 {
-	if (!tz || !tz->trips || trip_id < 0 || trip_id >= tz->num_trips || !trip)
+	if (!tz || trip_id < 0 || trip_id >= tz->num_trips || !trip)
 		return -EINVAL;
 
 	*trip = tz->trips[trip_id];
Index: linux-pm/drivers/thermal/thermal_of.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_of.c
+++ linux-pm/drivers/thermal/thermal_of.c
@@ -438,12 +438,10 @@ static int thermal_of_unbind(struct ther
  */
 static void thermal_of_zone_unregister(struct thermal_zone_device *tz)
 {
-	struct thermal_trip *trips = tz->trips;
 	struct thermal_zone_device_ops *ops = tz->ops;
 
 	thermal_zone_device_disable(tz);
 	thermal_zone_device_unregister(tz);
-	kfree(trips);
 	kfree(ops);
 }
 
@@ -526,6 +524,8 @@ static struct thermal_zone_device *therm
 		goto out_kfree_trips;
 	}
 
+	kfree(trips);
+
 	ret = thermal_zone_device_enable(tz);
 	if (ret) {
 		pr_err("Failed to enabled thermal zone '%s', id=%d: %d\n",




