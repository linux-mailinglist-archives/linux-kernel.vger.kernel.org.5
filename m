Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC0979D907
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbjILSrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbjILSrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:47:42 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6459D10D3;
        Tue, 12 Sep 2023 11:47:38 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id c5c47177dc7dc82b; Tue, 12 Sep 2023 20:47:36 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 604C4663BE5;
        Tue, 12 Sep 2023 20:47:36 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 7/9] ACPI: thermal: Untangle initialization and updates of active trips
Date:   Tue, 12 Sep 2023 20:43:59 +0200
Message-ID: <22010294.EfDdHjke4D@kreacher>
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

Separate the code needed to update active trips (in a response to a
notification from the platform firmware) as well as to initialize them
from the code that is only necessary for their initialization and
cleanly divide it into functions that each carry out a specific action.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |  197 ++++++++++++++++++++++++-------------------------
 1 file changed, 100 insertions(+), 97 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -184,94 +184,6 @@ static int acpi_thermal_temp(struct acpi
 						       tz->kelvin_offset);
 }
 
-static void __acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
-{
-	acpi_status status;
-	unsigned long long tmp;
-	struct acpi_handle_list devices;
-	bool valid = false;
-	int i;
-
-	/* Active (optional) */
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		char name[5] = { '_', 'A', 'C', ('0' + i), '\0' };
-		valid = tz->trips.active[i].trip.valid;
-
-		if (act == -1)
-			break; /* disable all active trip points */
-
-		if (flag == ACPI_TRIPS_INIT || ((flag & ACPI_TRIPS_ACTIVE) &&
-		    tz->trips.active[i].trip.valid)) {
-			status = acpi_evaluate_integer(tz->device->handle,
-						       name, NULL, &tmp);
-			if (ACPI_FAILURE(status)) {
-				tz->trips.active[i].trip.valid = false;
-				if (i == 0)
-					break;
-
-				if (act <= 0)
-					break;
-
-				if (i == 1)
-					tz->trips.active[0].trip.temperature =
-							celsius_to_deci_kelvin(act);
-				else
-					/*
-					 * Don't allow override higher than
-					 * the next higher trip point
-					 */
-					tz->trips.active[i-1].trip.temperature =
-						min_t(unsigned long,
-						      tz->trips.active[i-2].trip.temperature,
-						      celsius_to_deci_kelvin(act));
-
-				break;
-			} else {
-				tz->trips.active[i].trip.temperature = tmp;
-				tz->trips.active[i].trip.valid = true;
-			}
-		}
-
-		name[2] = 'L';
-		if ((flag & ACPI_TRIPS_DEVICES) && tz->trips.active[i].trip.valid) {
-			memset(&devices, 0, sizeof(struct acpi_handle_list));
-			status = acpi_evaluate_reference(tz->device->handle,
-							 name, NULL, &devices);
-			if (ACPI_FAILURE(status)) {
-				acpi_handle_info(tz->device->handle,
-						 "Invalid active%d threshold\n", i);
-				tz->trips.active[i].trip.valid = false;
-			} else {
-				tz->trips.active[i].trip.valid = true;
-			}
-
-			if (memcmp(&tz->trips.active[i].devices, &devices,
-				   sizeof(struct acpi_handle_list))) {
-				memcpy(&tz->trips.active[i].devices, &devices,
-				       sizeof(struct acpi_handle_list));
-				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
-			}
-		}
-		if ((flag & ACPI_TRIPS_ACTIVE) || (flag & ACPI_TRIPS_DEVICES))
-			if (valid != tz->trips.active[i].trip.valid)
-				ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "state");
-
-		if (!tz->trips.active[i].trip.valid)
-			break;
-	}
-
-	if (flag & ACPI_TRIPS_DEVICES) {
-		memset(&devices, 0, sizeof(devices));
-		status = acpi_evaluate_reference(tz->device->handle, "_TZD",
-						 NULL, &devices);
-		if (ACPI_SUCCESS(status) &&
-		    memcmp(&tz->devices, &devices, sizeof(devices))) {
-			tz->devices = devices;
-			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
-		}
-	}
-}
-
 static void update_acpi_thermal_trip_temp(struct acpi_thermal_trip *acpi_trip,
 					  int temp)
 {
@@ -338,6 +250,78 @@ static void acpi_thermal_update_passive_
 	ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_PASSIVE, tz, "state");
 }
 
+static long get_active_temp(struct acpi_thermal *tz, int index)
+{
+	char method[] = { '_', 'A', 'C', '0' + index, '\0' };
+	unsigned long long tmp;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(tz->device->handle, method, NULL, &tmp);
+	if (ACPI_FAILURE(status))
+		return THERMAL_TEMP_INVALID;
+
+	/*
+	 * If an override has been provided, apply it so there are no active
+	 * trips with thresholds greater than the override.
+	 */
+	if (act > 0) {
+		unsigned long long override = celsius_to_deci_kelvin(act);
+
+		if (tmp > override)
+			tmp = override;
+	}
+	return tmp;
+}
+
+static void acpi_thermal_update_active_trip(struct acpi_thermal *tz, int index)
+{
+	struct acpi_thermal_trip *acpi_trip = &tz->trips.active[index].trip;
+
+	if (!acpi_trip->valid)
+		return;
+
+	update_acpi_thermal_trip_temp(acpi_trip, get_active_temp(tz, index));
+	if (!acpi_trip->valid)
+		ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_ACTIVE, tz, "state");
+}
+
+static bool update_active_devices(struct acpi_thermal *tz, int index, bool compare)
+{
+	char method[] = { '_', 'A', 'L', '0' + index, '\0' };
+	struct acpi_handle_list devices;
+	acpi_status status;
+
+	memset(&devices, 0, sizeof(devices));
+
+	status = acpi_evaluate_reference(tz->device->handle, method, NULL, &devices);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_info(tz->device->handle,
+				 "Missing device list for active threshold %d\n",
+				 index);
+		return false;
+	}
+
+	if (compare && memcmp(&tz->trips.active[index].devices, &devices, sizeof(devices)))
+		ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_ACTIVE, tz, "device");
+
+	memcpy(&tz->trips.active[index].devices, &devices, sizeof(devices));
+	return true;
+}
+
+static void acpi_thermal_update_active_devices(struct acpi_thermal *tz, int index)
+{
+	struct acpi_thermal_trip *acpi_trip = &tz->trips.active[index].trip;
+
+	if (!acpi_trip->valid)
+		return;
+
+	if (update_active_devices(tz, index, true))
+		return;
+
+	update_acpi_thermal_trip_temp(acpi_trip, THERMAL_TEMP_INVALID);
+	ACPI_THERMAL_TRIPS_EXCEPTION(ACPI_TRIPS_ACTIVE, tz, "state");
+}
+
 static int acpi_thermal_adjust_trip(struct thermal_trip *trip, void *data)
 {
 	struct acpi_thermal_trip *acpi_trip = trip->priv;
@@ -358,18 +342,18 @@ static void acpi_thermal_adjust_thermal_
 					     unsigned long data)
 {
 	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
-	int flag;
+	int i;
 
 	if (data == ACPI_THERMAL_NOTIFY_THRESHOLDS) {
 		acpi_thermal_update_passive_trip(tz);
-		flag = ACPI_TRIPS_THRESHOLDS;
+		for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
+			acpi_thermal_update_active_trip(tz, i);
 	} else {
 		acpi_thermal_update_passive_devices(tz);
-		flag = ACPI_TRIPS_DEVICES;
+		for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
+			acpi_thermal_update_active_devices(tz, i);
 	}
 
-	__acpi_thermal_trips_update(tz, flag);
-
 	for_each_thermal_trip(tz->thermal_zone, acpi_thermal_adjust_trip, tz);
 }
 
@@ -498,6 +482,28 @@ fail:
 	return false;
 }
 
+static bool acpi_thermal_init_active_trip(struct acpi_thermal *tz, int index)
+{
+	long temp;
+
+	if (act == -1)
+		goto fail;
+
+	temp = get_active_temp(tz, index);
+	if (temp == THERMAL_TEMP_INVALID)
+		goto fail;
+
+	if (!update_active_devices(tz, false, index))
+		goto fail;
+
+	update_acpi_thermal_trip_temp(&tz->trips.active[index].trip, temp);
+	return true;
+
+fail:
+	update_acpi_thermal_trip_temp(&tz->trips.active[index].trip, THERMAL_TEMP_INVALID);
+	return false;
+}
+
 static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 {
 	unsigned int count = 0;
@@ -506,11 +512,8 @@ static int acpi_thermal_get_trip_points(
 	if (acpi_thermal_init_passive_trip(tz))
 		count++;
 
-	/* Active trip points (optional). */
-	__acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
-
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (tz->trips.active[i].trip.valid)
+		if (acpi_thermal_init_active_trip(tz, i))
 			count++;
 		else
 			break;



