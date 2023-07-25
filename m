Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02D8761844
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjGYMZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjGYMZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:25:32 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A889D1718;
        Tue, 25 Jul 2023 05:25:30 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id b8c0db411b4055ad; Tue, 25 Jul 2023 14:25:29 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 1D6AF661B0E;
        Tue, 25 Jul 2023 14:25:28 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v3 6/8] ACPI: thermal: Use trip point table to register thermal zones
Date:   Tue, 25 Jul 2023 14:20:57 +0200
Message-ID: <3177785.5fSG56mABF@kreacher>
In-Reply-To: <12254967.O9o76ZdvQC@kreacher>
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedriedtgdehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgt
 phhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make the ACPI thermal driver use thermal_zone_device_register_with_trips()
to register its thermal zones.

For this purpose, make it create a trip point table and pass it to
thermal_zone_device_register_with_trips() as an argument and use the
struct thermal_trip_ref introduced previously to connect the generic
thermal trip structures to the internal data structures representing
trip points in the driver.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Fix error code path memory leak in acpi_thermal_register_thermal_zone().
   * Notice that the critical and hot trips never change after initialization,
     so don't add struct thermal_trip_ref to any of them.

v1 -> v2:
   * Use thermal_zone_device_lock()/thermal_zone_device_unlock() in
     acpi_thermal_check_fn() explicitly and call __thermal_zone_device_update()
     from there without unlocking the thermal zone.
   * Export __thermal_zone_device_update() to modules (so it can be called by
     the ACPI thermal code).

---
 drivers/acpi/thermal.c         |  106 ++++++++++++++++++++++++++++++++++++++---
 drivers/thermal/thermal_core.c |    1 
 include/linux/thermal.h        |    2 
 3 files changed, 102 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -107,6 +107,7 @@ struct acpi_thermal_hot {
 };
 
 struct acpi_thermal_passive {
+	struct thermal_trip_ref trip_ref;
 	struct acpi_handle_list devices;
 	unsigned long temperature;
 	unsigned long tc1;
@@ -116,6 +117,7 @@ struct acpi_thermal_passive {
 };
 
 struct acpi_thermal_active {
+	struct thermal_trip_ref trip_ref;
 	struct acpi_handle_list devices;
 	unsigned long temperature;
 	bool valid;
@@ -137,6 +139,7 @@ struct acpi_thermal {
 	unsigned long polling_frequency;
 	volatile u8 zombie;
 	struct acpi_thermal_trips trips;
+	struct thermal_trip *trip_table;
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int kelvin_offset;	/* in millidegrees */
@@ -190,6 +193,14 @@ static int acpi_thermal_get_polling_freq
 	return 0;
 }
 
+static void acpi_thermal_trip_update_temp(struct acpi_thermal *tz,
+					  struct thermal_trip *trip,
+					  long temperature)
+{
+	trip->temperature = deci_kelvin_to_millicelsius_with_offset(temperature,
+								    tz->kelvin_offset);
+}
+
 static void __acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 {
 	acpi_status status;
@@ -756,6 +767,7 @@ static void acpi_thermal_zone_sysfs_remo
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 {
+	struct thermal_trip *trip;
 	int passive_delay = 0;
 	int trip_count = 0;
 	int result;
@@ -776,12 +788,54 @@ static int acpi_thermal_register_thermal
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].valid; i++)
 		trip_count++;
 
-	tz->thermal_zone = thermal_zone_device_register("acpitz", trip_count, 0,
-							tz, &acpi_thermal_zone_ops,
-							NULL, passive_delay,
-							tz->polling_frequency * 100);
-	if (IS_ERR(tz->thermal_zone))
-		return -ENODEV;
+	trip = kcalloc(trip_count, sizeof(*trip), GFP_KERNEL);
+	if (!trip)
+		return -ENOMEM;
+
+	tz->trip_table = trip;
+
+	if (tz->trips.critical.valid) {
+		trip->type = THERMAL_TRIP_CRITICAL;
+		acpi_thermal_trip_update_temp(tz, trip,
+					      tz->trips.critical.temperature);
+		trip++;
+	}
+
+	if (tz->trips.hot.valid) {
+		trip->type = THERMAL_TRIP_HOT;
+		acpi_thermal_trip_update_temp(tz, trip,
+					      tz->trips.hot.temperature);
+		trip++;
+	}
+
+	if (tz->trips.passive.valid) {
+		trip->type = THERMAL_TRIP_PASSIVE;
+		acpi_thermal_trip_update_temp(tz, trip,
+					      tz->trips.passive.temperature);
+		trip->driver_ref = &tz->trips.passive.trip_ref;
+		trip++;
+	}
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].valid; i++) {
+		trip->type = THERMAL_TRIP_ACTIVE;
+		acpi_thermal_trip_update_temp(tz, trip,
+					      tz->trips.active[i].temperature);
+		trip->driver_ref = &tz->trips.active[i].trip_ref;
+		trip++;
+	}
+
+	tz->thermal_zone = thermal_zone_device_register_with_trips("acpitz",
+								   tz->trip_table,
+								   trip_count,
+								   0, tz,
+								   &acpi_thermal_zone_ops,
+								   NULL,
+								   passive_delay,
+								   tz->polling_frequency * 100);
+	if (IS_ERR(tz->thermal_zone)) {
+		result = PTR_ERR(tz->thermal_zone);
+		goto free_trip_table;
+	}
 
 	result = acpi_thermal_zone_sysfs_add(tz);
 	if (result)
@@ -809,6 +863,8 @@ remove_links:
 	acpi_thermal_zone_sysfs_remove(tz);
 unregister_tzd:
 	thermal_zone_device_unregister(tz->thermal_zone);
+free_trip_table:
+	kfree(tz->trip_table);
 
 	return result;
 }
@@ -817,6 +873,7 @@ static void acpi_thermal_unregister_ther
 {
 	acpi_thermal_zone_sysfs_remove(tz);
 	thermal_zone_device_unregister(tz->thermal_zone);
+	kfree(tz->trip_table);
 	tz->thermal_zone = NULL;
 	acpi_bus_detach_private_data(tz->device->handle);
 }
@@ -950,6 +1007,9 @@ static void acpi_thermal_check_fn(struct
 {
 	struct acpi_thermal *tz = container_of(work, struct acpi_thermal,
 					       thermal_check_work);
+	struct thermal_trip *trip;
+	long temperature;
+	int i;
 
 	/*
 	 * In general, it is not sufficient to check the pending bit, because
@@ -964,7 +1024,39 @@ static void acpi_thermal_check_fn(struct
 
 	mutex_lock(&tz->thermal_check_lock);
 
-	thermal_zone_device_update(tz->thermal_zone, THERMAL_EVENT_UNSPECIFIED);
+	thermal_zone_device_lock(tz->thermal_zone);
+
+	trip = tz->trips.passive.trip_ref.trip;
+	if (trip) {
+		/*
+		 * This means that the passive trip was valid initially, so
+		 * update its temperature in case it has changed or the trip
+		 * has become invalid.
+		 */
+		temperature = tz->trips.passive.valid ?
+				tz->trips.passive.temperature :
+				THERMAL_TEMP_INVALID;
+		acpi_thermal_trip_update_temp(tz, trip, temperature);
+	}
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		trip = tz->trips.active[i].trip_ref.trip;
+		if (trip) {
+			/*
+			 * This means that the active trip #i was valid
+			 * initially, so update its temperature in case it has
+			 * changed or the trip has become invalid.
+			 */
+			temperature = tz->trips.active[i].valid ?
+					tz->trips.active[i].temperature :
+					THERMAL_TEMP_INVALID;
+			acpi_thermal_trip_update_temp(tz, trip, temperature);
+		}
+	}
+
+	__thermal_zone_device_update(tz->thermal_zone, THERMAL_EVENT_UNSPECIFIED);
+
+	thermal_zone_device_unlock(tz->thermal_zone);
 
 	refcount_inc(&tz->thermal_check_count);
 
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -429,6 +429,7 @@ void __thermal_zone_device_update(struct
 
 	monitor_thermal_zone(tz);
 }
+EXPORT_SYMBOL_GPL(__thermal_zone_device_update);
 
 static int thermal_zone_device_set_mode(struct thermal_zone_device *tz,
 					enum thermal_device_mode mode)
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -334,6 +334,8 @@ int thermal_zone_bind_cooling_device(str
 				     unsigned int);
 int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
 				       struct thermal_cooling_device *);
+void __thermal_zone_device_update(struct thermal_zone_device *,
+				  enum thermal_notify_event);
 void thermal_zone_device_update(struct thermal_zone_device *,
 				enum thermal_notify_event);
 void thermal_zone_device_lock(struct thermal_zone_device *tz);



