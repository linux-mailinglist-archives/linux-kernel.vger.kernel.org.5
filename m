Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDA67C75EE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 20:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379683AbjJLSfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344130AbjJLSfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:35:02 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E896E83;
        Thu, 12 Oct 2023 11:34:59 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 5003f7b6f6215e85; Thu, 12 Oct 2023 20:34:58 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 551E6666869;
        Thu, 12 Oct 2023 20:34:57 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v2 6/6] thermal: core: Pass trip pointer to governor throttle callback
Date:   Thu, 12 Oct 2023 20:34:50 +0200
Message-ID: <10368493.nUPlyArG6x@kreacher>
In-Reply-To: <5734364.DvuYhMxLoT@kreacher>
References: <5734364.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedriedtgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgv
 lhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify the governor .throttle() callback definition so that it takes a
trip pointer instead of a trip index as its second argument, adjust the
governors accordingly and update the core code invoking .throttle().

This causes the governors to become independent of the representation
of the list of trips in the thermal zone structure.

This change is not expected to alter the general functionality.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---

v1 -> v2: Add the tag from Daniel.

---
 drivers/thermal/gov_bang_bang.c       |    8 +++--
 drivers/thermal/gov_fair_share.c      |    6 ++--
 drivers/thermal/gov_power_allocator.c |    4 +-
 drivers/thermal/gov_step_wise.c       |   12 ++++----
 drivers/thermal/gov_user_space.c      |    8 +++--
 drivers/thermal/thermal_core.c        |   50 +++++++++++++++++-----------------
 drivers/thermal/thermal_core.h        |    2 -
 drivers/thermal/thermal_helpers.c     |    3 --
 include/linux/thermal.h               |    3 +-
 9 files changed, 51 insertions(+), 45 deletions(-)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -199,7 +199,8 @@ struct thermal_governor {
 	char name[THERMAL_NAME_LENGTH];
 	int (*bind_to_tz)(struct thermal_zone_device *tz);
 	void (*unbind_from_tz)(struct thermal_zone_device *tz);
-	int (*throttle)(struct thermal_zone_device *tz, int trip);
+	int (*throttle)(struct thermal_zone_device *tz,
+			const struct thermal_trip *trip);
 	struct list_head	governor_list;
 };
 
Index: linux-pm/drivers/thermal/gov_bang_bang.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_bang_bang.c
+++ linux-pm/drivers/thermal/gov_bang_bang.c
@@ -13,9 +13,10 @@
 
 #include "thermal_core.h"
 
-static int thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_index)
+static int thermal_zone_trip_update(struct thermal_zone_device *tz,
+				    const struct thermal_trip *trip)
 {
-	const struct thermal_trip *trip = &tz->trips[trip_index];
+	int trip_index = thermal_zone_trip_id(tz, trip);
 	struct thermal_instance *instance;
 
 	if (!trip->hysteresis)
@@ -89,7 +90,8 @@ static int thermal_zone_trip_update(stru
  *     (trip_temp - hyst) so that the fan gets turned off again.
  *
  */
-static int bang_bang_control(struct thermal_zone_device *tz, int trip)
+static int bang_bang_control(struct thermal_zone_device *tz,
+			     const struct thermal_trip *trip)
 {
 	struct thermal_instance *instance;
 	int ret;
Index: linux-pm/drivers/thermal/gov_fair_share.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_fair_share.c
+++ linux-pm/drivers/thermal/gov_fair_share.c
@@ -47,7 +47,7 @@ static long get_target_state(struct ther
 /**
  * fair_share_throttle - throttles devices associated with the given zone
  * @tz: thermal_zone_device
- * @trip_index: trip point index
+ * @trip: trip point
  *
  * Throttling Logic: This uses three parameters to calculate the new
  * throttle state of the cooling devices associated with the given zone.
@@ -63,9 +63,9 @@ static long get_target_state(struct ther
  *	(Heavily assumes the trip points are in ascending order)
  * new_state of cooling device = P3 * P2 * P1
  */
-static int fair_share_throttle(struct thermal_zone_device *tz, int trip_index)
+static int fair_share_throttle(struct thermal_zone_device *tz,
+			       const struct thermal_trip *trip)
 {
-	const struct thermal_trip *trip = &tz->trips[trip_index];
 	struct thermal_instance *instance;
 	int total_weight = 0;
 	int total_instance = 0;
Index: linux-pm/drivers/thermal/gov_power_allocator.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_power_allocator.c
+++ linux-pm/drivers/thermal/gov_power_allocator.c
@@ -676,10 +676,10 @@ static void power_allocator_unbind(struc
 	tz->governor_data = NULL;
 }
 
-static int power_allocator_throttle(struct thermal_zone_device *tz, int trip_index)
+static int power_allocator_throttle(struct thermal_zone_device *tz,
+				    const struct thermal_trip *trip)
 {
 	struct power_allocator_params *params = tz->governor_data;
-	const struct thermal_trip *trip = &tz->trips[trip_index];
 	bool update;
 
 	lockdep_assert_held(&tz->lock);
Index: linux-pm/drivers/thermal/gov_step_wise.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_step_wise.c
+++ linux-pm/drivers/thermal/gov_step_wise.c
@@ -68,15 +68,16 @@ static unsigned long get_target_state(st
 	return next_target;
 }
 
-static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip_id)
+static void thermal_zone_trip_update(struct thermal_zone_device *tz,
+				     const struct thermal_trip *trip)
 {
-	const struct thermal_trip *trip = &tz->trips[trip_id];
+	int trip_id = thermal_zone_trip_id(tz, trip);
 	enum thermal_trend trend;
 	struct thermal_instance *instance;
 	bool throttle = false;
 	int old_target;
 
-	trend = get_tz_trend(tz, trip_id);
+	trend = get_tz_trend(tz, trip);
 
 	if (tz->temperature >= trip->temperature) {
 		throttle = true;
@@ -120,7 +121,7 @@ static void thermal_zone_trip_update(str
 /**
  * step_wise_throttle - throttles devices associated with the given zone
  * @tz: thermal_zone_device
- * @trip: trip point index
+ * @trip: trip point
  *
  * Throttling Logic: This uses the trend of the thermal zone to throttle.
  * If the thermal zone is 'heating up' this throttles all the cooling
@@ -128,7 +129,8 @@ static void thermal_zone_trip_update(str
  * step. If the zone is 'cooling down' it brings back the performance of
  * the devices by one step.
  */
-static int step_wise_throttle(struct thermal_zone_device *tz, int trip)
+static int step_wise_throttle(struct thermal_zone_device *tz,
+			      const struct thermal_trip *trip)
 {
 	struct thermal_instance *instance;
 
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -22,9 +22,8 @@
 #include "thermal_core.h"
 #include "thermal_trace.h"
 
-int get_tz_trend(struct thermal_zone_device *tz, int trip_index)
+int get_tz_trend(struct thermal_zone_device *tz, const struct thermal_trip *trip)
 {
-	struct thermal_trip *trip = tz->trips ? &tz->trips[trip_index] : NULL;
 	enum thermal_trend trend;
 
 	if (tz->emul_temperature || !tz->ops->get_trend ||
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -70,7 +70,7 @@ static inline bool cdev_is_power_actor(s
 void thermal_cdev_update(struct thermal_cooling_device *);
 void __thermal_cdev_update(struct thermal_cooling_device *cdev);
 
-int get_tz_trend(struct thermal_zone_device *tz, int trip_index);
+int get_tz_trend(struct thermal_zone_device *tz, const struct thermal_trip *trip);
 
 struct thermal_instance *
 get_thermal_instance(struct thermal_zone_device *tz,
Index: linux-pm/drivers/thermal/gov_user_space.c
===================================================================
--- linux-pm.orig/drivers/thermal/gov_user_space.c
+++ linux-pm/drivers/thermal/gov_user_space.c
@@ -25,11 +25,12 @@ static int user_space_bind(struct therma
 /**
  * notify_user_space - Notifies user space about thermal events
  * @tz: thermal_zone_device
- * @trip: trip point index
+ * @trip: trip point
  *
  * This function notifies the user space through UEvents.
  */
-static int notify_user_space(struct thermal_zone_device *tz, int trip)
+static int notify_user_space(struct thermal_zone_device *tz,
+			     const struct thermal_trip *trip)
 {
 	char *thermal_prop[5];
 	int i;
@@ -38,7 +39,8 @@ static int notify_user_space(struct ther
 
 	thermal_prop[0] = kasprintf(GFP_KERNEL, "NAME=%s", tz->type);
 	thermal_prop[1] = kasprintf(GFP_KERNEL, "TEMP=%d", tz->temperature);
-	thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=%d", trip);
+	thermal_prop[2] = kasprintf(GFP_KERNEL, "TRIP=%d",
+				    thermal_zone_trip_id(tz, trip));
 	thermal_prop[3] = kasprintf(GFP_KERNEL, "EVENT=%d", tz->notify_event);
 	thermal_prop[4] = NULL;
 	kobject_uevent_env(&tz->device.kobj, KOBJ_CHANGE, thermal_prop);
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -307,7 +307,8 @@ static void monitor_thermal_zone(struct
 		thermal_zone_device_set_polling(tz, tz->polling_delay_jiffies);
 }
 
-static void handle_non_critical_trips(struct thermal_zone_device *tz, int trip)
+static void handle_non_critical_trips(struct thermal_zone_device *tz,
+				      const struct thermal_trip *trip)
 {
 	tz->governor ? tz->governor->throttle(tz, trip) :
 		       def_governor->throttle(tz, trip);
@@ -329,44 +330,43 @@ void thermal_zone_device_critical(struct
 EXPORT_SYMBOL(thermal_zone_device_critical);
 
 static void handle_critical_trips(struct thermal_zone_device *tz,
-				  int trip, int trip_temp, enum thermal_trip_type trip_type)
+				  const struct thermal_trip *trip)
 {
 	/* If we have not crossed the trip_temp, we do not care. */
-	if (trip_temp <= 0 || tz->temperature < trip_temp)
+	if (trip->temperature <= 0 || tz->temperature < trip->temperature)
 		return;
 
-	trace_thermal_zone_trip(tz, trip, trip_type);
+	trace_thermal_zone_trip(tz, thermal_zone_trip_id(tz, trip), trip->type);
 
-	if (trip_type == THERMAL_TRIP_HOT && tz->ops->hot)
-		tz->ops->hot(tz);
-	else if (trip_type == THERMAL_TRIP_CRITICAL)
+	if (trip->type == THERMAL_TRIP_CRITICAL)
 		tz->ops->critical(tz);
+	else if (tz->ops->hot)
+		tz->ops->hot(tz);
 }
 
-static void handle_thermal_trip(struct thermal_zone_device *tz, int trip_id)
+static void handle_thermal_trip(struct thermal_zone_device *tz,
+				const struct thermal_trip *trip)
 {
-	struct thermal_trip trip;
-
-	__thermal_zone_get_trip(tz, trip_id, &trip);
-
-	if (trip.temperature == THERMAL_TEMP_INVALID)
+	if (trip->temperature == THERMAL_TEMP_INVALID)
 		return;
 
 	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
-		if (tz->last_temperature < trip.temperature &&
-		    tz->temperature >= trip.temperature)
-			thermal_notify_tz_trip_up(tz->id, trip_id,
+		if (tz->last_temperature < trip->temperature &&
+		    tz->temperature >= trip->temperature)
+			thermal_notify_tz_trip_up(tz->id,
+						  thermal_zone_trip_id(tz, trip),
 						  tz->temperature);
-		if (tz->last_temperature >= trip.temperature &&
-		    tz->temperature < (trip.temperature - trip.hysteresis))
-			thermal_notify_tz_trip_down(tz->id, trip_id,
+		if (tz->last_temperature >= trip->temperature &&
+		    tz->temperature < trip->temperature - trip->hysteresis)
+			thermal_notify_tz_trip_down(tz->id,
+						    thermal_zone_trip_id(tz, trip),
 						    tz->temperature);
 	}
 
-	if (trip.type == THERMAL_TRIP_CRITICAL || trip.type == THERMAL_TRIP_HOT)
-		handle_critical_trips(tz, trip_id, trip.temperature, trip.type);
+	if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)
+		handle_critical_trips(tz, trip);
 	else
-		handle_non_critical_trips(tz, trip_id);
+		handle_non_critical_trips(tz, trip);
 }
 
 static void update_temperature(struct thermal_zone_device *tz)
@@ -403,7 +403,7 @@ static void thermal_zone_device_init(str
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event)
 {
-	int count;
+	const struct thermal_trip *trip;
 
 	if (atomic_read(&in_suspend))
 		return;
@@ -422,8 +422,8 @@ void __thermal_zone_device_update(struct
 
 	tz->notify_event = event;
 
-	for (count = 0; count < tz->num_trips; count++)
-		handle_thermal_trip(tz, count);
+	for_each_trip(tz, trip)
+		handle_thermal_trip(tz, trip);
 
 	monitor_thermal_zone(tz);
 }



