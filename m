Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4E2772DBE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjHGSVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjHGSVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:21:01 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9AEDE;
        Mon,  7 Aug 2023 11:20:59 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id efd8927cb8f9f9b8; Mon, 7 Aug 2023 20:20:57 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 07F096625B2;
        Mon,  7 Aug 2023 20:20:57 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5 06/11] ACPI: thermal: Introduce struct acpi_thermal_trip
Date:   Mon, 07 Aug 2023 20:10:06 +0200
Message-ID: <21971973.EfDdHjke4D@kreacher>
In-Reply-To: <4503814.LvFx2qVVIh@kreacher>
References: <13318886.uLZWGnKmhe@kreacher> <4503814.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add struct acpi_thermal_trip to contain the temperature and valid flag
of each trip point in the driver's local data structures.

This helps to make the subsequent changes more straightforward.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

New patch in v5.

---
 drivers/acpi/thermal.c |   96 ++++++++++++++++++++++---------------------------
 1 file changed, 45 insertions(+), 51 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -92,34 +92,27 @@ MODULE_PARM_DESC(psv, "Disable or overri
 
 static struct workqueue_struct *acpi_thermal_pm_queue;
 
-struct acpi_thermal_critical {
-	unsigned long temperature;
-	bool valid;
-};
-
-struct acpi_thermal_hot {
+struct acpi_thermal_trip {
 	unsigned long temperature;
 	bool valid;
 };
 
 struct acpi_thermal_passive {
+	struct acpi_thermal_trip trip;
 	struct acpi_handle_list devices;
-	unsigned long temperature;
 	unsigned long tc1;
 	unsigned long tc2;
 	unsigned long tsp;
-	bool valid;
 };
 
 struct acpi_thermal_active {
+	struct acpi_thermal_trip trip;
 	struct acpi_handle_list devices;
-	unsigned long temperature;
-	bool valid;
 };
 
 struct acpi_thermal_trips {
-	struct acpi_thermal_critical critical;
-	struct acpi_thermal_hot hot;
+	struct acpi_thermal_trip critical;
+	struct acpi_thermal_trip hot;
 	struct acpi_thermal_passive passive;
 	struct acpi_thermal_active active[ACPI_THERMAL_MAX_ACTIVE];
 };
@@ -250,9 +243,9 @@ static void __acpi_thermal_trips_update(
 	}
 
 	/* Passive (optional) */
-	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.valid) ||
+	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.trip.valid) ||
 	    flag == ACPI_TRIPS_INIT) {
-		valid = tz->trips.passive.valid;
+		valid = tz->trips.passive.trip.valid;
 		if (psv == -1) {
 			status = AE_SUPPORT;
 		} else if (psv > 0) {
@@ -264,44 +257,44 @@ static void __acpi_thermal_trips_update(
 		}
 
 		if (ACPI_FAILURE(status)) {
-			tz->trips.passive.valid = false;
+			tz->trips.passive.trip.valid = false;
 		} else {
-			tz->trips.passive.temperature = tmp;
-			tz->trips.passive.valid = true;
+			tz->trips.passive.trip.temperature = tmp;
+			tz->trips.passive.trip.valid = true;
 			if (flag == ACPI_TRIPS_INIT) {
 				status = acpi_evaluate_integer(tz->device->handle,
 							       "_TC1", NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->trips.passive.valid = false;
+					tz->trips.passive.trip.valid = false;
 				else
 					tz->trips.passive.tc1 = tmp;
 
 				status = acpi_evaluate_integer(tz->device->handle,
 							       "_TC2", NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->trips.passive.valid = false;
+					tz->trips.passive.trip.valid = false;
 				else
 					tz->trips.passive.tc2 = tmp;
 
 				status = acpi_evaluate_integer(tz->device->handle,
 							       "_TSP", NULL, &tmp);
 				if (ACPI_FAILURE(status))
-					tz->trips.passive.valid = false;
+					tz->trips.passive.trip.valid = false;
 				else
 					tz->trips.passive.tsp = tmp;
 			}
 		}
 	}
-	if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.passive.valid) {
+	if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.passive.trip.valid) {
 		memset(&devices, 0, sizeof(struct acpi_handle_list));
 		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
 						 NULL, &devices);
 		if (ACPI_FAILURE(status)) {
 			acpi_handle_info(tz->device->handle,
 					 "Invalid passive threshold\n");
-			tz->trips.passive.valid = false;
+			tz->trips.passive.trip.valid = false;
 		} else {
-			tz->trips.passive.valid = true;
+			tz->trips.passive.trip.valid = true;
 		}
 
 		if (memcmp(&tz->trips.passive.devices, &devices,
@@ -312,24 +305,24 @@ static void __acpi_thermal_trips_update(
 		}
 	}
 	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
-		if (valid != tz->trips.passive.valid)
+		if (valid != tz->trips.passive.trip.valid)
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 	}
 
 	/* Active (optional) */
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
-		valid = tz->trips.active[i].valid;
+		valid = tz->trips.active[i].trip.valid;
 
 		if (act == -1)
 			break; /* disable all active trip points */
 
 		if (flag == ACPI_TRIPS_INIT || ((flag & ACPI_TRIPS_ACTIVE) &&
-		    tz->trips.active[i].valid)) {
+		    tz->trips.active[i].trip.valid)) {
 			status = acpi_evaluate_integer(tz->device->handle,
 						       name, NULL, &tmp);
 			if (ACPI_FAILURE(status)) {
-				tz->trips.active[i].valid = false;
+				tz->trips.active[i].trip.valid = false;
 				if (i == 0)
 					break;
 
@@ -337,35 +330,36 @@ static void __acpi_thermal_trips_update(
 					break;
 
 				if (i == 1)
-					tz->trips.active[0].temperature = celsius_to_deci_kelvin(act);
+					tz->trips.active[0].trip.temperature =
+							celsius_to_deci_kelvin(act);
 				else
 					/*
 					 * Don't allow override higher than
 					 * the next higher trip point
 					 */
-					tz->trips.active[i-1].temperature =
+					tz->trips.active[i-1].trip.temperature =
 						min_t(unsigned long,
-						      tz->trips.active[i-2].temperature,
+						      tz->trips.active[i-2].trip.temperature,
 						      celsius_to_deci_kelvin(act));
 
 				break;
 			} else {
-				tz->trips.active[i].temperature = tmp;
-				tz->trips.active[i].valid = true;
+				tz->trips.active[i].trip.temperature = tmp;
+				tz->trips.active[i].trip.valid = true;
 			}
 		}
 
 		name[2] = 'L';
-		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.active[i].valid) {
+		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.active[i].trip.valid) {
 			memset(&devices, 0, sizeof(struct acpi_handle_list));
 			status = acpi_evaluate_reference(tz->device->handle,
 							 name, NULL, &devices);
 			if (ACPI_FAILURE(status)) {
 				acpi_handle_info(tz->device->handle,
 						 "Invalid active%d threshold\n", i);
-				tz->trips.active[i].valid = false;
+				tz->trips.active[i].trip.valid = false;
 			} else {
-				tz->trips.active[i].valid = true;
+				tz->trips.active[i].trip.valid = true;
 			}
 
 			if (memcmp(&tz->trips.active[i].devices, &devices,
@@ -376,10 +370,10 @@ static void __acpi_thermal_trips_update(
 			}
 		}
 		if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))
-			if (valid != tz->trips.active[i].valid)
+			if (valid != tz->trips.active[i].trip.valid)
 				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
 
-		if (!tz->trips.active[i].valid)
+		if (!tz->trips.active[i].trip.valid)
 			break;
 	}
 
@@ -429,10 +423,10 @@ static int acpi_thermal_get_trip_points(
 
 	valid = tz->trips.critical.valid |
 		tz->trips.hot.valid |
-		tz->trips.passive.valid;
+		tz->trips.passive.trip.valid;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-		valid = valid || tz->trips.active[i].valid;
+		valid = valid || tz->trips.active[i].trip.valid;
 
 	if (!valid) {
 		pr_warn(FW_BUG "No valid trip found\n");
@@ -485,7 +479,7 @@ static int thermal_get_trip_type(struct
 		trip--;
 	}
 
-	if (tz->trips.passive.valid) {
+	if (tz->trips.passive.trip.valid) {
 		if (!trip) {
 			*type = THERMAL_TRIP_PASSIVE;
 			return 0;
@@ -493,7 +487,7 @@ static int thermal_get_trip_type(struct
 		trip--;
 	}
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].valid; i++) {
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].trip.valid; i++) {
 		if (!trip) {
 			*type = THERMAL_TRIP_ACTIVE;
 			return 0;
@@ -533,10 +527,10 @@ static int thermal_get_trip_temp(struct
 		trip--;
 	}
 
-	if (tz->trips.passive.valid) {
+	if (tz->trips.passive.trip.valid) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips.passive.temperature,
+					tz->trips.passive.trip.temperature,
 					tz->kelvin_offset);
 			return 0;
 		}
@@ -544,10 +538,10 @@ static int thermal_get_trip_temp(struct
 	}
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE &&
-		tz->trips.active[i].valid; i++) {
+		tz->trips.active[i].trip.valid; i++) {
 		if (!trip) {
 			*temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->trips.active[i].temperature,
+					tz->trips.active[i].trip.temperature,
 					tz->kelvin_offset);
 			return 0;
 		}
@@ -603,7 +597,7 @@ static int thermal_get_trend(struct ther
 	 * before this callback being invoked
 	 */
 	i = tz->trips.passive.tc1 * (tz->temperature - tz->last_temperature) +
-	    tz->trips.passive.tc2 * (tz->temperature - tz->trips.passive.temperature);
+	    tz->trips.passive.tc2 * (tz->temperature - tz->trips.passive.trip.temperature);
 
 	if (i > 0)
 		*trend = THERMAL_TREND_RAISING;
@@ -654,7 +648,7 @@ static int acpi_thermal_cooling_device_c
 	if (tz->trips.hot.valid)
 		trip++;
 
-	if (tz->trips.passive.valid) {
+	if (tz->trips.passive.trip.valid) {
 		trip++;
 		for (i = 0; i < tz->trips.passive.devices.count; i++) {
 			handle = tz->trips.passive.devices.handles[i];
@@ -679,7 +673,7 @@ static int acpi_thermal_cooling_device_c
 	}
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!tz->trips.active[i].valid)
+		if (!tz->trips.active[i].trip.valid)
 			break;
 
 		trip++;
@@ -775,12 +769,12 @@ static int acpi_thermal_register_thermal
 	if (tz->trips.hot.valid)
 		trip_count++;
 
-	if (tz->trips.passive.valid) {
+	if (tz->trips.passive.trip.valid) {
 		trip_count++;
 		passive_delay = tz->trips.passive.tsp * 100;
 	}
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].valid; i++)
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].trip.valid; i++)
 		trip_count++;
 
 	tz->thermal_zone = thermal_zone_device_register("acpitz", trip_count, 0,
@@ -1060,7 +1054,7 @@ static int acpi_thermal_resume(struct de
 		return -EINVAL;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!tz->trips.active[i].valid)
+		if (!tz->trips.active[i].trip.valid)
 			break;
 
 		for (j = 0; j < tz->trips.active[i].devices.count; j++) {



