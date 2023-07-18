Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E50975849F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGRSVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjGRSVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:21:34 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DB4196;
        Tue, 18 Jul 2023 11:21:26 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 3d43d9bec74791c9; Tue, 18 Jul 2023 20:21:25 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E303C6614F7;
        Tue, 18 Jul 2023 20:21:24 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 5/7] ACPI: thermal: Use trip point table to register thermal zones
Date:   Tue, 18 Jul 2023 20:06:57 +0200
Message-ID: <3760707.kQq0lBPeGt@kreacher>
In-Reply-To: <13318886.uLZWGnKmhe@kreacher>
References: <13318886.uLZWGnKmhe@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgrlhdrfihilhgtiiihnhhskhhisehinhhtvghlrdgtohhmpdhr
 tghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
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
 drivers/acpi/thermal.c |  100 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 4 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -93,16 +93,19 @@ MODULE_PARM_DESC(psv, "Disable or overri
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
@@ -112,6 +115,7 @@ struct acpi_thermal_passive {
 };
 
 struct acpi_thermal_active {
+	struct thermal_trip_ref trip_ref;
 	struct acpi_handle_list devices;
 	unsigned long temperature;
 	bool valid;
@@ -133,6 +137,7 @@ struct acpi_thermal {
 	unsigned long polling_frequency;
 	volatile u8 zombie;
 	struct acpi_thermal_trips trips;
+	struct thermal_trip *trip_table;
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int kelvin_offset;	/* in millidegrees */
@@ -186,6 +191,18 @@ static int acpi_thermal_get_polling_freq
 	return 0;
 }
 
+static void acpi_thermal_trip_set_temp(struct acpi_thermal *tz,
+				       struct thermal_trip *trip,
+				       long temperature)
+{
+	/* Ignore unititialized trips */
+	if (!trip)
+		return;
+
+	trip->temperature = deci_kelvin_to_millicelsius_with_offset(temperature,
+								    tz->kelvin_offset);
+}
+
 static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 {
 	acpi_status status;
@@ -745,6 +762,7 @@ static void acpi_thermal_zone_sysfs_remo
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 {
+	struct thermal_trip *trip;
 	int passive_delay = 0;
 	int trip_count = 0;
 	int result;
@@ -765,10 +783,52 @@ static int acpi_thermal_register_thermal
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
+		acpi_thermal_trip_set_temp(tz, trip,
+					   tz->trips.critical.temperature);
+		trip->driver_ref = &tz->trips.critical.trip_ref;
+		trip++;
+	}
+
+	if (tz->trips.hot.valid) {
+		trip->type = THERMAL_TRIP_HOT;
+		acpi_thermal_trip_set_temp(tz, trip,
+					   tz->trips.hot.temperature);
+		trip->driver_ref = &tz->trips.hot.trip_ref;
+		trip++;
+	}
+
+	if (tz->trips.passive.valid) {
+		trip->type = THERMAL_TRIP_PASSIVE;
+		acpi_thermal_trip_set_temp(tz, trip,
+					   tz->trips.passive.temperature);
+		trip->driver_ref = &tz->trips.passive.trip_ref;
+		trip++;
+	}
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].valid; i++) {
+		trip->type = THERMAL_TRIP_ACTIVE;
+		acpi_thermal_trip_set_temp(tz, trip,
+					   tz->trips.active[i].temperature);
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
 
@@ -806,6 +866,7 @@ static void acpi_thermal_unregister_ther
 {
 	acpi_thermal_zone_sysfs_remove(tz);
 	thermal_zone_device_unregister(tz->thermal_zone);
+	kfree(tz->trip_table);
 	tz->thermal_zone = NULL;
 	acpi_bus_detach_private_data(tz->device->handle);
 }
@@ -939,6 +1000,9 @@ static void acpi_thermal_check_fn(struct
 {
 	struct acpi_thermal *tz = container_of(work, struct acpi_thermal,
 					       thermal_check_work);
+	struct thermal_trip *trip;
+	long temperature;
+	int i;
 
 	/*
 	 * In general, it is not sufficient to check the pending bit, because
@@ -953,6 +1017,34 @@ static void acpi_thermal_check_fn(struct
 
 	mutex_lock(&tz->thermal_check_lock);
 
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
+		acpi_thermal_trip_set_temp(tz, trip, temperature);
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
+			acpi_thermal_trip_set_temp(tz, trip, temperature);
+		}
+	}
+
 	thermal_zone_device_update(tz->thermal_zone, THERMAL_EVENT_UNSPECIFIED);
 
 	refcount_inc(&tz->thermal_check_count);



