Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384E179D915
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237519AbjILSsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237590AbjILSry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:47:54 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9C21716;
        Tue, 12 Sep 2023 11:47:43 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 1f78031281b7904c; Tue, 12 Sep 2023 20:47:42 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id E0F5A663BE5;
        Tue, 12 Sep 2023 20:47:41 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 3/9] ACPI: thermal: Determine the number of trip points earlier
Date:   Tue, 12 Sep 2023 20:37:59 +0200
Message-ID: <1863318.tdWV9SEqCh@kreacher>
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

Compute the number of trip points in acpi_thermal_add() so as to allow the
driver's data structures to be simplified going forward.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   60 +++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -452,7 +452,7 @@ static void acpi_thermal_get_hot_trip(st
 
 static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 {
-	bool valid;
+	unsigned int count = 0;
 	int i;
 
 	acpi_thermal_get_critical_trip(tz);
@@ -460,18 +460,24 @@ static int acpi_thermal_get_trip_points(
 	/* Passive and active trip points (optional). */
 	__acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
 
-	valid = tz->trips.critical.valid |
-		tz->trips.hot.valid |
-		tz->trips.passive.trip.valid;
-
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-		valid = valid || tz->trips.active[i].trip.valid;
-
-	if (!valid) {
-		pr_warn(FW_BUG "No valid trip found\n");
-		return -ENODEV;
+	if (tz->trips.critical.valid)
+		count++;
+
+	if (tz->trips.hot.valid)
+		count++;
+
+	if (tz->trips.passive.trip.valid)
+		count++;
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		if (tz->trips.active[i].trip.valid)
+			count++;
+		else
+			break;
+
 	}
-	return 0;
+
+	return count;
 }
 
 /* sys I/F for generic thermal sysfs support */
@@ -681,29 +687,15 @@ static void acpi_thermal_zone_sysfs_remo
 	sysfs_remove_link(&tzdev->kobj, "device");
 }
 
-static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
+static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz,
+					      unsigned int trip_count)
 {
 	struct acpi_thermal_trip *acpi_trip;
 	struct thermal_trip *trip;
 	int passive_delay = 0;
-	int trip_count = 0;
 	int result;
 	int i;
 
-	if (tz->trips.critical.valid)
-		trip_count++;
-
-	if (tz->trips.hot.valid)
-		trip_count++;
-
-	if (tz->trips.passive.trip.valid) {
-		trip_count++;
-		passive_delay = tz->trips.passive.tsp * 100;
-	}
-
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].trip.valid; i++)
-		trip_count++;
-
 	trip = kcalloc(trip_count, sizeof(*trip), GFP_KERNEL);
 	if (!trip)
 		return -ENOMEM;
@@ -724,6 +716,8 @@ static int acpi_thermal_register_thermal
 
 	acpi_trip = &tz->trips.passive.trip;
 	if (acpi_trip->valid) {
+		passive_delay = tz->trips.passive.tsp * 100;
+
 		trip->type = THERMAL_TRIP_PASSIVE;
 		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temperature);
 		trip->priv = acpi_trip;
@@ -893,6 +887,7 @@ static void acpi_thermal_check_fn(struct
 static int acpi_thermal_add(struct acpi_device *device)
 {
 	struct acpi_thermal *tz;
+	unsigned int trip_count;
 	int result;
 
 	if (!device)
@@ -911,9 +906,12 @@ static int acpi_thermal_add(struct acpi_
 	acpi_thermal_aml_dependency_fix(tz);
 
 	/* Get trip points [_CRT, _PSV, etc.] (required). */
-	result = acpi_thermal_get_trip_points(tz);
-	if (result)
+	trip_count = acpi_thermal_get_trip_points(tz);
+	if (!trip_count) {
+		pr_warn(FW_BUG "No valid trip points!\n");
+		result = -ENODEV;
 		goto free_memory;
+	}
 
 	/* Get temperature [_TMP] (required). */
 	result = acpi_thermal_get_temperature(tz);
@@ -932,7 +930,7 @@ static int acpi_thermal_add(struct acpi_
 
 	acpi_thermal_guess_offset(tz);
 
-	result = acpi_thermal_register_thermal_zone(tz);
+	result = acpi_thermal_register_thermal_zone(tz, trip_count);
 	if (result)
 		goto free_memory;
 



