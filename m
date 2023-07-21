Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66D475CB58
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjGUPSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjGUPSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:18:15 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFB030DF;
        Fri, 21 Jul 2023 08:18:13 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 809219d3db5c0223; Fri, 21 Jul 2023 17:18:12 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id DC9A3661901;
        Fri, 21 Jul 2023 17:18:11 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2 6/8] ACPI: thermal: Use trip point table to register thermal zones
Date:   Fri, 21 Jul 2023 17:00:57 +0200
Message-ID: <4298510.ejJDZkT8p0@kreacher>
In-Reply-To: <5710197.DvuYhMxLoT@kreacher>
References: <13318886.uLZWGnKmhe@kreacher> <5710197.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgt
 phhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/acpi/thermal.c         |  102 ++++++++++++++++++++++++++++++++++++++---
 drivers/thermal/thermal_core.c |    1 
 include/linux/thermal.h        |    2 
 3 files changed, 100 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -97,16 +97,19 @@ MODULE_PARM_DESC(psv, "Disable or overri
 static struct workqueue_struct *acpi_thermal_pm_queue;
 
 struct acpi_thermal_critical {
+	struct thermal_trip_ref trip_ref;
 	unsigned long temperature;
 	bool valid;
 };
 
 struct acpi_thermal_hot {
+	struct thermal_trip_ref trip_ref;
 	unsigned long temperature;
 	bool valid;
 };
 
 struct acpi_thermal_passive {
+	struct thermal_trip_ref trip_ref;
 	struct acpi_handle_list devices;
 	unsigned long temperature;
 	unsigned long tc1;
@@ -116,6 +119,7 @@ struct acpi_thermal_passive {
 };
 
 struct acpi_thermal_active {
+	struct thermal_trip_ref trip_ref;
 	struct acpi_handle_list devices;
 	unsigned long temperature;
 	bool valid;
@@ -137,6 +141,7 @@ struct acpi_thermal {
 	unsigned long polling_frequency;
 	volatile u8 zombie;
 	struct acpi_thermal_trips trips;
+	struct thermal_trip *trip_table;
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int kelvin_offset;	/* in millidegrees */
@@ -190,6 +195,14 @@ static int acpi_thermal_get_polling_freq
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
@@ -756,6 +769,7 @@ static void acpi_thermal_zone_sysfs_remo
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 {
+	struct thermal_trip *trip;
 	int passive_delay = 0;
 	int trip_count = 0;
 	int result;
@@ -776,10 +790,52 @@ static int acpi_thermal_register_thermal
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].valid; i++)
 		trip_count++;
 
-	tz->thermal_zone = thermal_zone_device_register("acpitz", trip_count, 0,
-							tz, &acpi_thermal_zone_ops,
-							NULL, passive_delay,
-							tz->polling_frequency * 100);
+	tz->trip_table = kcalloc(trip_count, sizeof(*tz->trip_table), GFP_KERNEL);
+	if (!tz->trip_table)
+		return -ENOMEM;
+
+	trip = tz->trip_table;
+
+	if (tz->trips.critical.valid) {
+		trip->type = THERMAL_TRIP_CRITICAL;
+		acpi_thermal_trip_update_temp(tz, trip,
+					      tz->trips.critical.temperature);
+		trip->driver_ref = &tz->trips.critical.trip_ref;
+		trip++;
+	}
+
+	if (tz->trips.hot.valid) {
+		trip->type = THERMAL_TRIP_HOT;
+		acpi_thermal_trip_update_temp(tz, trip,
+					      tz->trips.hot.temperature);
+		trip->driver_ref = &tz->trips.hot.trip_ref;
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
 	if (IS_ERR(tz->thermal_zone))
 		return -ENODEV;
 
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



