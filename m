Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC4B79D911
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbjILSr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237535AbjILSrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:47:45 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A7F10F6;
        Tue, 12 Sep 2023 11:47:40 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 14a9d9dd490c3409; Tue, 12 Sep 2023 20:47:39 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 81E38663C2D;
        Tue, 12 Sep 2023 20:47:38 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 5/9] ACPI: thermal: Simplify critical and hot trips representation
Date:   Tue, 12 Sep 2023 20:41:06 +0200
Message-ID: <3249479.aeNJFYEL58@kreacher>
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

Notice that the only piece of information regarding the critical and hot
trips that needs to be stored in the driver's local data structures is
whether or not these trips are valid, so drop all of the redundant
information from there and adjust the code accordingly.

Among other things, this requires acpi_thermal_add() to be rearranged
so as to obtain the critical trip temperature before populating the trip
points table and for symmetry, the hot trip temperature is obtained
earlier too.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   69 +++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 36 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -107,10 +107,10 @@ struct acpi_thermal_active {
 };
 
 struct acpi_thermal_trips {
-	struct acpi_thermal_trip critical;
-	struct acpi_thermal_trip hot;
 	struct acpi_thermal_passive passive;
 	struct acpi_thermal_active active[ACPI_THERMAL_MAX_ACTIVE];
+	bool critical_valid;
+	bool hot_valid;
 };
 
 struct acpi_thermal {
@@ -391,7 +391,7 @@ static void acpi_thermal_trips_update(st
 					dev_name(&adev->dev), event, 0);
 }
 
-static void acpi_thermal_get_critical_trip(struct acpi_thermal *tz)
+static long acpi_thermal_get_critical_trip(struct acpi_thermal *tz)
 {
 	unsigned long long tmp;
 	acpi_status status;
@@ -420,34 +420,30 @@ static void acpi_thermal_get_critical_tr
 	}
 
 set:
-	tz->trips.critical.valid = true;
-	tz->trips.critical.temperature = tmp;
-	acpi_handle_debug(tz->device->handle, "Critical threshold [%lu]\n",
-			  tz->trips.critical.temperature);
-	return;
+	tz->trips.critical_valid = true;
+	acpi_handle_debug(tz->device->handle, "Critical threshold [%llu]\n", tmp);
+	return tmp;
 
 fail:
-	tz->trips.critical.valid = false;
-	tz->trips.critical.temperature = THERMAL_TEMP_INVALID;
+	tz->trips.critical_valid = false;
+	return THERMAL_TEMP_INVALID;
 }
 
-static void acpi_thermal_get_hot_trip(struct acpi_thermal *tz)
+static long acpi_thermal_get_hot_trip(struct acpi_thermal *tz)
 {
 	unsigned long long tmp;
 	acpi_status status;
 
 	status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &tmp);
 	if (ACPI_FAILURE(status)) {
-		tz->trips.hot.valid = false;
-		tz->trips.hot.temperature = THERMAL_TEMP_INVALID;
+		tz->trips.hot_valid = false;
 		acpi_handle_debug(tz->device->handle, "No hot threshold\n");
-		return;
+		return THERMAL_TEMP_INVALID;
 	}
 
-	tz->trips.hot.valid = true;
-	tz->trips.hot.temperature = tmp;
-	acpi_handle_debug(tz->device->handle, "Hot threshold [%lu]\n",
-			  tz->trips.hot.temperature);
+	tz->trips.hot_valid = true;
+	acpi_handle_debug(tz->device->handle, "Hot threshold [%llu]\n", tmp);
+	return tmp;
 }
 
 static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
@@ -455,17 +451,9 @@ static int acpi_thermal_get_trip_points(
 	unsigned int count = 0;
 	int i;
 
-	acpi_thermal_get_critical_trip(tz);
-	acpi_thermal_get_hot_trip(tz);
 	/* Passive and active trip points (optional). */
 	__acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
 
-	if (tz->trips.critical.valid)
-		count++;
-
-	if (tz->trips.hot.valid)
-		count++;
-
 	if (tz->trips.passive.trip.valid)
 		count++;
 
@@ -578,10 +566,10 @@ static int acpi_thermal_cooling_device_c
 	int trip = -1;
 	int result = 0;
 
-	if (tz->trips.critical.valid)
+	if (tz->trips.critical_valid)
 		trip++;
 
-	if (tz->trips.hot.valid)
+	if (tz->trips.hot_valid)
 		trip++;
 
 	if (tz->trips.passive.trip.valid) {
@@ -803,10 +791,9 @@ static void acpi_thermal_aml_dependency_
  * The heuristic below should work for all ACPI thermal zones which have a
  * critical trip point with a value being a multiple of 0.5 degree Celsius.
  */
-static void acpi_thermal_guess_offset(struct acpi_thermal *tz)
+static void acpi_thermal_guess_offset(struct acpi_thermal *tz, long crit_temp)
 {
-	if (tz->trips.critical.valid &&
-	    (tz->trips.critical.temperature % 5) == 1)
+	if (tz->trips.critical_valid && crit_temp % 5 == 1)
 		tz->kelvin_offset = 273100;
 	else
 		tz->kelvin_offset = 273200;
@@ -843,6 +830,7 @@ static int acpi_thermal_add(struct acpi_
 	struct thermal_trip *trip;
 	struct acpi_thermal *tz;
 	unsigned int trip_count;
+	int crit_temp, hot_temp;
 	int passive_delay = 0;
 	int result;
 	int i;
@@ -864,6 +852,15 @@ static int acpi_thermal_add(struct acpi_
 
 	/* Get trip points [_CRT, _PSV, etc.] (required). */
 	trip_count = acpi_thermal_get_trip_points(tz);
+
+	crit_temp = acpi_thermal_get_critical_trip(tz);
+	if (tz->trips.critical_valid)
+		trip_count++;
+
+	hot_temp = acpi_thermal_get_hot_trip(tz);
+	if (tz->trips.hot_valid)
+		trip_count++;
+
 	if (!trip_count) {
 		pr_warn(FW_BUG "No valid trip points!\n");
 		result = -ENODEV;
@@ -885,7 +882,7 @@ static int acpi_thermal_add(struct acpi_
 	else
 		acpi_thermal_get_polling_frequency(tz);
 
-	acpi_thermal_guess_offset(tz);
+	acpi_thermal_guess_offset(tz, crit_temp);
 
 	trip = kcalloc(trip_count, sizeof(*trip), GFP_KERNEL);
 	if (!trip)
@@ -893,15 +890,15 @@ static int acpi_thermal_add(struct acpi_
 
 	tz->trip_table = trip;
 
-	if (tz->trips.critical.valid) {
+	if (tz->trips.critical_valid) {
 		trip->type = THERMAL_TRIP_CRITICAL;
-		trip->temperature = acpi_thermal_temp(tz, tz->trips.critical.temperature);
+		trip->temperature = acpi_thermal_temp(tz, crit_temp);
 		trip++;
 	}
 
-	if (tz->trips.hot.valid) {
+	if (tz->trips.hot_valid) {
 		trip->type = THERMAL_TRIP_HOT;
-		trip->temperature = acpi_thermal_temp(tz, tz->trips.hot.temperature);
+		trip->temperature = acpi_thermal_temp(tz, hot_temp);
 		trip++;
 	}
 



