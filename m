Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BEF79D90E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbjILSr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbjILSro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:47:44 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBBA10DF;
        Tue, 12 Sep 2023 11:47:39 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id b410579ed5f883e6; Tue, 12 Sep 2023 20:47:38 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 36EB3663BE5;
        Tue, 12 Sep 2023 20:47:37 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 6/9] ACPI: thermal: Untangle initialization and updates of the passive trip
Date:   Tue, 12 Sep 2023 20:43:52 +0200
Message-ID: <1942063.PYKUYFuaPT@kreacher>
In-Reply-To: <5708760.DvuYhMxLoT@kreacher>
References: <5708760.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgudeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehs
 rhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Separate the code needed to update the passive trip (in a response to a
notification from the platform firmware) as well as to initialize it
from the code that is only necessary for its initialization and cleanly
divide it into functions that each carry out a specific action.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |  198 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 125 insertions(+), 73 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -192,73 +192,6 @@ static void __acpi_thermal_trips_update(
 	bool valid = false;
 	int i;
 
-	/* Passive (optional) */
-	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.trip.valid) ||
-	    flag == ACPI_TRIPS_INIT) {
-		valid = tz->trips.passive.trip.valid;
-		if (psv == -1) {
-			status = AE_SUPPORT;
-		} else if (psv > 0) {
-			tmp = celsius_to_deci_kelvin(psv);
-			status = AE_OK;
-		} else {
-			status = acpi_evaluate_integer(tz->device->handle,
-						       "_PSV", NULL, &tmp);
-		}
-
-		if (ACPI_FAILURE(status)) {
-			tz->trips.passive.trip.valid = false;
-		} else {
-			tz->trips.passive.trip.temperature = tmp;
-			tz->trips.passive.trip.valid = true;
-			if (flag == ACPI_TRIPS_INIT) {
-				status = acpi_evaluate_integer(tz->device->handle,
-							       "_TC1", NULL, &tmp);
-				if (ACPI_FAILURE(status))
-					tz->trips.passive.trip.valid = false;
-				else
-					tz->trips.passive.tc1 = tmp;
-
-				status = acpi_evaluate_integer(tz->device->handle,
-							       "_TC2", NULL, &tmp);
-				if (ACPI_FAILURE(status))
-					tz->trips.passive.trip.valid = false;
-				else
-					tz->trips.passive.tc2 = tmp;
-
-				status = acpi_evaluate_integer(tz->device->handle,
-							       "_TSP", NULL, &tmp);
-				if (ACPI_FAILURE(status))
-					tz->trips.passive.trip.valid = false;
-				else
-					tz->trips.passive.tsp = tmp;
-			}
-		}
-	}
-	if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.passive.trip.valid) {
-		memset(&devices, 0, sizeof(struct acpi_handle_list));
-		status = acpi_evaluate_reference(tz->device->handle, "_PSL",
-						 NULL, &devices);
-		if (ACPI_FAILURE(status)) {
-			acpi_handle_info(tz->device->handle,
-					 "Invalid passive threshold\n");
-			tz->trips.passive.trip.valid = false;
-		} else {
-			tz->trips.passive.trip.valid = true;
-		}
-
-		if (memcmp(&tz->trips.passive.devices, &devices,
-			   sizeof(struct acpi_handle_list))) {
-			memcpy(&tz->trips.passive.devices, &devices,
-			       sizeof(struct acpi_handle_list));
-			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
-		}
-	}
-	if ((flag & ACPI_TRIPS_PASSIVE) || (flag & ACPI_TRIPS_DEVICES)) {
-		if (valid != tz->trips.passive.trip.valid)
-			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
-	}
-
 	/* Active (optional) */
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
@@ -339,6 +272,72 @@ static void __acpi_thermal_trips_update(
 	}
 }
 
+static void update_acpi_thermal_trip_temp(struct acpi_thermal_trip *acpi_trip,
+					  int temp)
+{
+	acpi_trip->valid = temp != THERMAL_TEMP_INVALID;
+	acpi_trip->temperature = temp;
+}
+
+static long get_passive_temp(struct acpi_thermal *tz)
+{
+	unsigned long long tmp;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(tz->device->handle, "_PSV", NULL, &tmp);
+	if (ACPI_FAILURE(status))
+		return THERMAL_TEMP_INVALID;
+
+	return tmp;
+}
+
+static void acpi_thermal_update_passive_trip(struct acpi_thermal *tz)
+{
+	struct acpi_thermal_trip *acpi_trip = &tz->trips.passive.trip;
+
+	if (!acpi_trip->valid || psv > 0)
+		return;
+
+	update_acpi_thermal_trip_temp(acpi_trip, get_passive_temp(tz));
+	if (!acpi_trip->valid)
+		ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_PASSIVE, tz, "state");
+}
+
+static bool update_passive_devices(struct acpi_thermal *tz, bool compare)
+{
+	struct acpi_handle_list devices;
+	acpi_status status;
+
+	memset(&devices, 0, sizeof(devices));
+
+	status = acpi_evaluate_reference(tz->device->handle, "_PSL", NULL, &devices);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_info(tz->device->handle,
+				 "Missing device list for passive threshold\n");
+		return false;
+	}
+
+	if (compare && memcmp(&tz->trips.passive.devices, &devices, sizeof(devices)))
+		ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_PASSIVE, tz, "device");
+
+	memcpy(&tz->trips.passive.devices, &devices, sizeof(devices));
+	return true;
+}
+
+static void acpi_thermal_update_passive_devices(struct acpi_thermal *tz)
+{
+	struct acpi_thermal_trip *acpi_trip = &tz->trips.passive.trip;
+
+	if (!acpi_trip->valid)
+		return;
+
+	if (update_passive_devices(tz, true))
+		return;
+
+	update_acpi_thermal_trip_temp(acpi_trip, THERMAL_TEMP_INVALID);
+	ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_PASSIVE, tz, "state");
+}
+
 static int acpi_thermal_adjust_trip(struct thermal_trip *trip, void *data)
 {
 	struct acpi_thermal_trip *acpi_trip = trip->priv;
@@ -359,8 +358,15 @@ static void acpi_thermal_adjust_thermal_
 					     unsigned long data)
 {
 	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
-	int flag = data == ACPI_THERMAL_NOTIFY_THRESHOLDS ?
-				ACPI_TRIPS_THRESHOLDS : ACPI_TRIPS_DEVICES;
+	int flag;
+
+	if (data == ACPI_THERMAL_NOTIFY_THRESHOLDS) {
+		acpi_thermal_update_passive_trip(tz);
+		flag = ACPI_TRIPS_THRESHOLDS;
+	} else {
+		acpi_thermal_update_passive_devices(tz);
+		flag = ACPI_TRIPS_DEVICES;
+	}
 
 	__acpi_thermal_trips_update(tz, flag);
 
@@ -446,17 +452,63 @@ static long acpi_thermal_get_hot_trip(st
 	return tmp;
 }
 
+static bool acpi_thermal_init_passive_trip(struct acpi_thermal *tz)
+{
+	unsigned long long tmp;
+	acpi_status status;
+	int temp;
+
+	if (psv == -1)
+		goto fail;
+
+	if (psv > 0) {
+		temp = celsius_to_deci_kelvin(psv);
+	} else {
+		temp = get_passive_temp(tz);
+		if (temp == THERMAL_TEMP_INVALID)
+			goto fail;
+	}
+
+	status = acpi_evaluate_integer(tz->device->handle, "_TC1", NULL, &tmp);
+	if (ACPI_FAILURE(status))
+		goto fail;
+
+	tz->trips.passive.tc1 = tmp;
+
+	status = acpi_evaluate_integer(tz->device->handle, "_TC2", NULL, &tmp);
+	if (ACPI_FAILURE(status))
+		goto fail;
+
+	tz->trips.passive.tc2 = tmp;
+
+	status = acpi_evaluate_integer(tz->device->handle, "_TSP", NULL, &tmp);
+	if (ACPI_FAILURE(status))
+		goto fail;
+
+	tz->trips.passive.tsp = tmp;
+
+	if (!update_passive_devices(tz, false))
+		goto fail;
+
+	update_acpi_thermal_trip_temp(&tz->trips.passive.trip, temp);
+	return true;
+
+fail:
+	update_acpi_thermal_trip_temp(&tz->trips.passive.trip, THERMAL_TEMP_INVALID);
+	return false;
+}
+
 static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 {
 	unsigned int count = 0;
 	int i;
 
-	/* Passive and active trip points (optional). */
-	__acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
-
-	if (tz->trips.passive.trip.valid)
+	if (acpi_thermal_init_passive_trip(tz))
 		count++;
 
+	/* Active trip points (optional). */
+	__acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
+
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		if (tz->trips.active[i].trip.valid)
 			count++;



