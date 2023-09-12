Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BC979D903
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236045AbjILSrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjILSrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:47:40 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEC810D3;
        Tue, 12 Sep 2023 11:47:36 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id d591d3eab9350a03; Tue, 12 Sep 2023 20:47:33 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id BAB64663C2D;
        Tue, 12 Sep 2023 20:47:32 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 9/9] ACPI: thermal: Drop valid flag from struct acpi_thermal_trip
Date:   Tue, 12 Sep 2023 20:47:23 +0200
Message-ID: <9162925.CDJkKcVGEf@kreacher>
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

Notice that the valid flag in struct acpi_thermal_trip is in fact
redundant, because the temperature field of invalid trips is always
equal to THERMAL_TEMP_INVALID, so drop it from there and adjust the
code accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   49 +++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -81,7 +81,6 @@ static struct workqueue_struct *acpi_the
 
 struct acpi_thermal_trip {
 	unsigned long temperature;
-	bool valid;
 };
 
 struct acpi_thermal_passive {
@@ -175,11 +174,9 @@ static int acpi_thermal_temp(struct acpi
 						       tz->kelvin_offset);
 }
 
-static void update_acpi_thermal_trip_temp(struct acpi_thermal_trip *acpi_trip,
-					  int temp)
+static bool acpi_thermal_trip_valid(struct acpi_thermal_trip *acpi_trip)
 {
-	acpi_trip->valid = temp != THERMAL_TEMP_INVALID;
-	acpi_trip->temperature = temp;
+	return acpi_trip->temperature != THERMAL_TEMP_INVALID;
 }
 
 static long get_passive_temp(struct acpi_thermal *tz)
@@ -198,11 +195,11 @@ static void acpi_thermal_update_passive_
 {
 	struct acpi_thermal_trip *acpi_trip = &tz->trips.passive.trip;
 
-	if (!acpi_trip->valid || psv > 0)
+	if (!acpi_thermal_trip_valid(acpi_trip) || psv > 0)
 		return;
 
-	update_acpi_thermal_trip_temp(acpi_trip, get_passive_temp(tz));
-	if (!acpi_trip->valid)
+	acpi_trip->temperature = get_passive_temp(tz);
+	if (!acpi_thermal_trip_valid(acpi_trip))
 		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
@@ -231,13 +228,13 @@ static void acpi_thermal_update_passive_
 {
 	struct acpi_thermal_trip *acpi_trip = &tz->trips.passive.trip;
 
-	if (!acpi_trip->valid)
+	if (!acpi_thermal_trip_valid(acpi_trip))
 		return;
 
 	if (update_passive_devices(tz, true))
 		return;
 
-	update_acpi_thermal_trip_temp(acpi_trip, THERMAL_TEMP_INVALID);
+	acpi_trip->temperature = THERMAL_TEMP_INVALID;
 	ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
@@ -268,11 +265,11 @@ static void acpi_thermal_update_active_t
 {
 	struct acpi_thermal_trip *acpi_trip = &tz->trips.active[index].trip;
 
-	if (!acpi_trip->valid)
+	if (!acpi_thermal_trip_valid(acpi_trip))
 		return;
 
-	update_acpi_thermal_trip_temp(acpi_trip, get_active_temp(tz, index));
-	if (!acpi_trip->valid)
+	acpi_trip->temperature = get_active_temp(tz, index);
+	if (!acpi_thermal_trip_valid(acpi_trip))
 		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
@@ -303,13 +300,13 @@ static void acpi_thermal_update_active_d
 {
 	struct acpi_thermal_trip *acpi_trip = &tz->trips.active[index].trip;
 
-	if (!acpi_trip->valid)
+	if (!acpi_thermal_trip_valid(acpi_trip))
 		return;
 
 	if (update_active_devices(tz, index, true))
 		return;
 
-	update_acpi_thermal_trip_temp(acpi_trip, THERMAL_TEMP_INVALID);
+	acpi_trip->temperature = THERMAL_TEMP_INVALID;
 	ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
@@ -321,7 +318,7 @@ static int acpi_thermal_adjust_trip(stru
 	if (!acpi_trip)
 		return 0;
 
-	if (acpi_trip->valid)
+	if (acpi_thermal_trip_valid(acpi_trip))
 		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temperature);
 	else
 		trip->temperature = THERMAL_TEMP_INVALID;
@@ -465,11 +462,11 @@ static bool acpi_thermal_init_passive_tr
 	if (!update_passive_devices(tz, false))
 		goto fail;
 
-	update_acpi_thermal_trip_temp(&tz->trips.passive.trip, temp);
+	tz->trips.passive.trip.temperature = temp;
 	return true;
 
 fail:
-	update_acpi_thermal_trip_temp(&tz->trips.passive.trip, THERMAL_TEMP_INVALID);
+	tz->trips.passive.trip.temperature = THERMAL_TEMP_INVALID;
 	return false;
 }
 
@@ -487,11 +484,11 @@ static bool acpi_thermal_init_active_tri
 	if (!update_active_devices(tz, false, index))
 		goto fail;
 
-	update_acpi_thermal_trip_temp(&tz->trips.active[index].trip, temp);
+	tz->trips.active[index].trip.temperature = temp;
 	return true;
 
 fail:
-	update_acpi_thermal_trip_temp(&tz->trips.active[index].trip, THERMAL_TEMP_INVALID);
+	tz->trips.active[index].trip.temperature = THERMAL_TEMP_INVALID;
 	return false;
 }
 
@@ -545,7 +542,7 @@ static int thermal_get_trend(struct ther
 		return -EINVAL;
 
 	acpi_trip = trip->priv;
-	if (!acpi_trip || !acpi_trip->valid)
+	if (!acpi_trip || !acpi_thermal_trip_valid(acpi_trip))
 		return -EINVAL;
 
 	switch (trip->type) {
@@ -618,7 +615,7 @@ static int acpi_thermal_cooling_device_c
 	if (tz->trips.hot_valid)
 		trip++;
 
-	if (tz->trips.passive.trip.valid) {
+	if (acpi_thermal_trip_valid(&tz->trips.passive.trip)) {
 		trip++;
 		for (i = 0; i < tz->trips.passive.devices.count; i++) {
 			handle = tz->trips.passive.devices.handles[i];
@@ -643,7 +640,7 @@ static int acpi_thermal_cooling_device_c
 	}
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!tz->trips.active[i].trip.valid)
+		if (!acpi_thermal_trip_valid(&tz->trips.active[i].trip))
 			break;
 
 		trip++;
@@ -949,7 +946,7 @@ static int acpi_thermal_add(struct acpi_
 	}
 
 	acpi_trip = &tz->trips.passive.trip;
-	if (acpi_trip->valid) {
+	if (acpi_thermal_trip_valid(acpi_trip)) {
 		passive_delay = tz->trips.passive.tsp * 100;
 
 		trip->type = THERMAL_TRIP_PASSIVE;
@@ -961,7 +958,7 @@ static int acpi_thermal_add(struct acpi_
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
 		acpi_trip =  &tz->trips.active[i].trip;
 
-		if (!acpi_trip->valid)
+		if (!acpi_thermal_trip_valid(acpi_trip))
 			break;
 
 		trip->type = THERMAL_TRIP_ACTIVE;
@@ -1038,7 +1035,7 @@ static int acpi_thermal_resume(struct de
 		return -EINVAL;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!tz->trips.active[i].trip.valid)
+		if (!acpi_thermal_trip_valid(&tz->trips.active[i].trip))
 			break;
 
 		for (j = 0; j < tz->trips.active[i].devices.count; j++) {



