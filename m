Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93397AA139
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjIUU7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjIUU65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:58:57 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ED7AF947;
        Thu, 21 Sep 2023 11:07:30 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 6e5678acd76eb7ac; Thu, 21 Sep 2023 20:07:28 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 0322B664EC0;
        Thu, 21 Sep 2023 20:07:28 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 05/13] thermal: core: Store trip pointer in struct thermal_instance
Date:   Thu, 21 Sep 2023 19:52:44 +0200
Message-ID: <1977624.usQuhbGJ8B@kreacher>
In-Reply-To: <1957441.PYKUYFuaPT@kreacher>
References: <1957441.PYKUYFuaPT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhn
 thgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Replace the integer trip number stored in struct thermal_instance with
a pointer to the relevant trip and adjust the code using the structure
in question accordingly.

The main reason for making this change is to allow the trip point to
cooling device binding code more straightforward, as illustrated by
subsequent modifications of the ACPI thermal driver, but it also helps
to clarify the overall design and allows the governor code overhead to
be reduced (through subsequent modifications).

The only case in which it adds complexity is trip_point_show() that
needs to walk the trips[] table to find the index of the given trip
point, but this is not a critical path and the interface that
trip_point_show() belongs to is problematic anyway (for instance, it
doesn't cover the case when the same cooling devices is associated
with multiple trip points).

This is a preliminary change and the affected code will be refined by
a series of subsequent modifications of thermal governors, the core and
the ACPI thermal driver.

The general functionality is not expected to be affected by this change.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/gov_bang_bang.c       |   23 ++++++++---------------
 drivers/thermal/gov_fair_share.c      |    5 +++--
 drivers/thermal/gov_power_allocator.c |   11 ++++++++---
 drivers/thermal/gov_step_wise.c       |   16 +++++++---------
 drivers/thermal/thermal_core.c        |   15 ++++++++++-----
 drivers/thermal/thermal_core.h        |    4 +++-
 drivers/thermal/thermal_helpers.c     |    5 ++++-
 drivers/thermal/thermal_sysfs.c       |    3 ++-
 drivers/thermal/thermal_trip.c        |   15 +++++++++++++++
 9 files changed, 60 insertions(+), 37 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -87,7 +87,7 @@ struct thermal_instance {
 	char name[THERMAL_NAME_LENGTH];
 	struct thermal_zone_device *tz;
 	struct thermal_cooling_device *cdev;
-	int trip;
+	const struct thermal_trip *trip;
 	bool initialized;
 	unsigned long upper;	/* Highest cooling state for this trip point */
 	unsigned long lower;	/* Lowest cooling state for this trip point */
@@ -119,6 +119,8 @@ void __thermal_zone_device_update(struct
 void __thermal_zone_set_trips(struct thermal_zone_device *tz);
 int __thermal_zone_get_trip(struct thermal_zone_device *tz, int trip_id,
 			    struct thermal_trip *trip);
+int thermal_zone_trip_id(struct thermal_zone_device *tz,
+			 const struct thermal_trip *trip);
 int __thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
 
 /* sysfs I/F */
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -42,14 +42,17 @@ int get_tz_trend(struct thermal_zone_dev
 
 struct thermal_instance *
 get_thermal_instance(struct thermal_zone_device *tz,
-		     struct thermal_cooling_device *cdev, int trip)
+		     struct thermal_cooling_device *cdev, int trip_index)
 {
 	struct thermal_instance *pos = NULL;
 	struct thermal_instance *target_instance = NULL;
+	const struct thermal_trip *trip;
 
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
 
+	trip = &tz->trips[trip_index];
+
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node) {
 		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
 			target_instance = pos;
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -602,7 +602,7 @@ struct thermal_zone_device *thermal_zone
 /**
  * thermal_zone_bind_cooling_device() - bind a cooling device to a thermal zone
  * @tz:		pointer to struct thermal_zone_device
- * @trip:	indicates which trip point the cooling devices is
+ * @trip_index:	indicates which trip point the cooling devices is
  *		associated with in this thermal zone.
  * @cdev:	pointer to struct thermal_cooling_device
  * @upper:	the Maximum cooling state for this trip point.
@@ -622,7 +622,7 @@ struct thermal_zone_device *thermal_zone
  * Return: 0 on success, the proper error value otherwise.
  */
 int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
-				     int trip,
+				     int trip_index,
 				     struct thermal_cooling_device *cdev,
 				     unsigned long upper, unsigned long lower,
 				     unsigned int weight)
@@ -631,12 +631,15 @@ int thermal_zone_bind_cooling_device(str
 	struct thermal_instance *pos;
 	struct thermal_zone_device *pos1;
 	struct thermal_cooling_device *pos2;
+	const struct thermal_trip *trip;
 	bool upper_no_limit;
 	int result;
 
-	if (trip >= tz->num_trips || trip < 0)
+	if (trip_index >= tz->num_trips || trip_index < 0)
 		return -EINVAL;
 
+	trip = &tz->trips[trip_index];
+
 	list_for_each_entry(pos1, &thermal_tz_list, node) {
 		if (pos1 == tz)
 			break;
@@ -739,7 +742,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_bind_cool
  * thermal_zone_unbind_cooling_device() - unbind a cooling device from a
  *					  thermal zone.
  * @tz:		pointer to a struct thermal_zone_device.
- * @trip:	indicates which trip point the cooling devices is
+ * @trip_index:	indicates which trip point the cooling devices is
  *		associated with in this thermal zone.
  * @cdev:	pointer to a struct thermal_cooling_device.
  *
@@ -750,13 +753,15 @@ EXPORT_SYMBOL_GPL(thermal_zone_bind_cool
  * Return: 0 on success, the proper error value otherwise.
  */
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
-				       int trip,
+				       int trip_index,
 				       struct thermal_cooling_device *cdev)
 {
 	struct thermal_instance *pos, *next;
+	const struct thermal_trip *trip;
 
 	mutex_lock(&tz->lock);
 	mutex_lock(&cdev->lock);
+	trip = &tz->trips[trip_index];
 	list_for_each_entry_safe(pos, next, &tz->thermal_instances, tz_node) {
 		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
 			list_del(&pos->tz_node);
Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -13,28 +13,21 @@
 
 #include "thermal_core.h"
 
-static int thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id)
+static int thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_index)
 {
-	struct thermal_trip trip;
+	const struct thermal_trip *trip = &tz->trips[trip_index];
 	struct thermal_instance *instance;
-	int ret;
 
-	ret = __thermal_zone_get_trip(tz, trip_id, &trip);
-	if (ret) {
-		pr_warn_once("Failed to retrieve trip point %d\n", trip_id);
-		return ret;
-	}
-
-	if (!trip.hysteresis)
+	if (!trip->hysteresis)
 		dev_info_once(&tz->device,
 			      "Zero hysteresis value for thermal zone %s\n", tz->type);
 
 	dev_dbg(&tz->device, "Trip%d[temp=%d]:temp=%d:hyst=%d\n",
-				trip_id, trip.temperature, tz->temperature,
-				trip.hysteresis);
+				trip_index, trip->temperature, tz->temperature,
+				trip->hysteresis);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip_id)
+		if (instance->trip != trip)
 			continue;
 
 		/* in case fan is in initial state, switch the fan off */
@@ -52,10 +45,10 @@ static int thermal_zone_trip_update(stru
 		 * enable fan when temperature exceeds trip_temp and disable
 		 * the fan in case it falls below trip_temp minus hysteresis
 		 */
-		if (instance->target == 0 && tz->temperature >= trip.temperature)
+		if (instance->target == 0 && tz->temperature >= trip->temperature)
 			instance->target = 1;
 		else if (instance->target == 1 &&
-			 tz->temperature <= trip.temperature - trip.hysteresis)
+			 tz->temperature <= trip->temperature - trip->hysteresis)
 			instance->target = 0;
 
 		dev_dbg(&instance->cdev->device, "target=%d\n",
Index: linux-pm/drivers/thermal/gov_fair_share.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_fair_share.c
+++ linux-pm/drivers/thermal/gov_fair_share.c
@@ -49,7 +49,7 @@ static long get_target_state(struct ther
 /**
  * fair_share_throttle - throttles devices associated with the given zone
  * @tz: thermal_zone_device
- * @trip: trip point index
+ * @trip_index: trip point index
  *
  * Throttling Logic: This uses three parameters to calculate the new
  * throttle state of the cooling devices associated with the given zone.
@@ -65,8 +65,9 @@ static long get_target_state(struct ther
  *	(Heavily assumes the trip points are in ascending order)
  * new_state of cooling device = P3 * P2 * P1
  */
-static int fair_share_throttle(struct thermal_zone_device *tz, int trip)
+static int fair_share_throttle(struct thermal_zone_device *tz, int trip_index)
 {
+	const struct thermal_trip *trip = &tz->trips[trip_index];
 	struct thermal_instance *instance;
 	int total_weight = 0;
 	int total_instance = 0;
Index: linux-pm/drivers/thermal/gov_step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_step_wise.c
+++ linux-pm/drivers/thermal/gov_step_wise.c
@@ -81,26 +81,24 @@ static void update_passive_instance(stru
 
 static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id)
 {
+	const struct thermal_trip *trip = &tz->trips[trip_id];
 	enum thermal_trend trend;
 	struct thermal_instance *instance;
-	struct thermal_trip trip;
 	bool throttle = false;
 	int old_target;
 
-	__thermal_zone_get_trip(tz, trip_id, &trip);
-
 	trend = get_tz_trend(tz, trip_id);
 
-	if (tz->temperature >= trip.temperature) {
+	if (tz->temperature >= trip->temperature) {
 		throttle = true;
-		trace_thermal_zone_trip(tz, trip_id, trip.type);
+		trace_thermal_zone_trip(tz, trip_id, trip->type);
 	}
 
 	dev_dbg(&tz->device, "Trip%d[type=%d,temp=%d]:trend=%d,throttle=%d\n",
-				trip_id, trip.type, trip.temperature, trend, throttle);
+		trip_id, trip->type, trip->temperature, trend, throttle);
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
-		if (instance->trip != trip_id)
+		if (instance->trip != trip)
 			continue;
 
 		old_target = instance->target;
@@ -114,11 +112,11 @@ static void thermal_zone_trip_update(str
 		/* Activate a passive thermal instance */
 		if (old_target == THERMAL_NO_TARGET &&
 			instance->target != THERMAL_NO_TARGET)
-			update_passive_instance(tz, trip.type, 1);
+			update_passive_instance(tz, trip->type, 1);
 		/* Deactivate a passive thermal instance */
 		else if (old_target != THERMAL_NO_TARGET &&
 			instance->target == THERMAL_NO_TARGET)
-			update_passive_instance(tz, trip.type, -1);
+			update_passive_instance(tz, trip->type, -1);
 
 		instance->initialized = true;
 		mutex_lock(&instance->cdev->lock);
Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -943,7 +943,8 @@ trip_point_show(struct device *dev, stru
 	instance =
 	    container_of(attr, struct thermal_instance, attr);
 
-	return sprintf(buf, "%d\n", instance->trip);
+	return sprintf(buf, "%d\n",
+		       thermal_zone_trip_id(instance->tz, instance->trip));
 }
 
 ssize_t
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -157,3 +157,18 @@ int thermal_zone_set_trip(struct thermal
 
 	return 0;
 }
+
+int thermal_zone_trip_id(struct thermal_zone_device *tz,
+			 const struct thermal_trip *trip)
+{
+	int i;
+
+	lockdep_assert_held(&tz->lock);
+
+	for (i = 0; i < tz->num_trips; i++) {
+		if (&tz->trips[i] == trip)
+			return i;
+	}
+
+	return -ENODATA;
+}
Index: linux-pm/drivers/thermal/gov_power_allocator.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_power_allocator.c
+++ linux-pm/drivers/thermal/gov_power_allocator.c
@@ -90,12 +90,14 @@ static u32 estimate_sustainable_power(st
 	u32 sustainable_power = 0;
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
+	const struct thermal_trip *trip_max_desired_temperature =
+			&tz->trips[params->trip_max_desired_temperature];
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		struct thermal_cooling_device *cdev = instance->cdev;
 		u32 min_power;
 
-		if (instance->trip != params->trip_max_desired_temperature)
+		if (instance->trip != trip_max_desired_temperature)
 			continue;
 
 		if (!cdev_is_power_actor(cdev))
@@ -383,12 +385,13 @@ static int allocate_power(struct thermal
 {
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
+	const struct thermal_trip *trip_max_desired_temperature =
+			&tz->trips[params->trip_max_desired_temperature];
 	u32 *req_power, *max_power, *granted_power, *extra_actor_power;
 	u32 *weighted_req_power;
 	u32 total_req_power, max_allocatable_power, total_weighted_req_power;
 	u32 total_granted_power, power_range;
 	int i, num_actors, total_weight, ret = 0;
-	int trip_max_desired_temperature = params->trip_max_desired_temperature;
 
 	num_actors = 0;
 	total_weight = 0;
@@ -564,12 +567,14 @@ static void allow_maximum_power(struct t
 {
 	struct thermal_instance *instance;
 	struct power_allocator_params *params = tz->governor_data;
+	const struct thermal_trip *trip_max_desired_temperature =
+			&tz->trips[params->trip_max_desired_temperature];
 	u32 req_power;
 
 	list_for_each_entry(instance, &tz->thermal_instances, tz_node) {
 		struct thermal_cooling_device *cdev = instance->cdev;
 
-		if ((instance->trip != params->trip_max_desired_temperature) ||
+		if ((instance->trip != trip_max_desired_temperature) ||
 		    (!cdev_is_power_actor(instance->cdev)))
 			continue;
 



