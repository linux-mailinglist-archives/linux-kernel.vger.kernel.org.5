Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C790379D912
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbjILSsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbjILSry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:47:54 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D64E1705;
        Tue, 12 Sep 2023 11:47:41 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 25b387b3422685a1; Tue, 12 Sep 2023 20:47:40 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id CE019663BE5;
        Tue, 12 Sep 2023 20:47:39 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 4/9] ACPI: thermal: Create and populate trip points table earlier
Date:   Tue, 12 Sep 2023 20:39:15 +0200
Message-ID: <13346091.uLZWGnKmhe@kreacher>
In-Reply-To: <5708760.DvuYhMxLoT@kreacher>
References: <5708760.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgudefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehs
 rhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Create and populate the driver's trip points table in acpi_thermal_add()
so as to allow the its data structures to be simplified going forward.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |  105 ++++++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 53 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -688,53 +688,10 @@ static void acpi_thermal_zone_sysfs_remo
 }
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz,
-					      unsigned int trip_count)
+					      unsigned int trip_count,
+					      int passive_delay)
 {
-	struct acpi_thermal_trip *acpi_trip;
-	struct thermal_trip *trip;
-	int passive_delay = 0;
 	int result;
-	int i;
-
-	trip = kcalloc(trip_count, sizeof(*trip), GFP_KERNEL);
-	if (!trip)
-		return -ENOMEM;
-
-	tz->trip_table = trip;
-
-	if (tz->trips.critical.valid) {
-		trip->type = THERMAL_TRIP_CRITICAL;
-		trip->temperature = acpi_thermal_temp(tz, tz->trips.critical.temperature);
-		trip++;
-	}
-
-	if (tz->trips.hot.valid) {
-		trip->type = THERMAL_TRIP_HOT;
-		trip->temperature = acpi_thermal_temp(tz, tz->trips.hot.temperature);
-		trip++;
-	}
-
-	acpi_trip = &tz->trips.passive.trip;
-	if (acpi_trip->valid) {
-		passive_delay = tz->trips.passive.tsp * 100;
-
-		trip->type = THERMAL_TRIP_PASSIVE;
-		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temperature);
-		trip->priv = acpi_trip;
-		trip++;
-	}
-
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		acpi_trip = &tz->trips.active[i].trip;
-
-		if (!acpi_trip->valid)
-			break;
-
-		trip->type = THERMAL_TRIP_ACTIVE;
-		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temperature);
-		trip->priv = acpi_trip;
-		trip++;
-	}
 
 	tz->thermal_zone = thermal_zone_device_register_with_trips("acpitz",
 								   tz->trip_table,
@@ -744,10 +701,8 @@ static int acpi_thermal_register_thermal
 								   NULL,
 								   passive_delay,
 								   tz->polling_frequency * 100);
-	if (IS_ERR(tz->thermal_zone)) {
-		result = PTR_ERR(tz->thermal_zone);
-		goto free_trip_table;
-	}
+	if (IS_ERR(tz->thermal_zone))
+		return PTR_ERR(tz->thermal_zone);
 
 	result = acpi_thermal_zone_sysfs_add(tz);
 	if (result)
@@ -766,8 +721,6 @@ remove_links:
 	acpi_thermal_zone_sysfs_remove(tz);
 unregister_tzd:
 	thermal_zone_device_unregister(tz->thermal_zone);
-free_trip_table:
-	kfree(tz->trip_table);
 
 	return result;
 }
@@ -886,9 +839,13 @@ static void acpi_thermal_check_fn(struct
 
 static int acpi_thermal_add(struct acpi_device *device)
 {
+	struct acpi_thermal_trip *acpi_trip;
+	struct thermal_trip *trip;
 	struct acpi_thermal *tz;
 	unsigned int trip_count;
+	int passive_delay = 0;
 	int result;
+	int i;
 
 	if (!device)
 		return -EINVAL;
@@ -930,9 +887,49 @@ static int acpi_thermal_add(struct acpi_
 
 	acpi_thermal_guess_offset(tz);
 
-	result = acpi_thermal_register_thermal_zone(tz, trip_count);
+	trip = kcalloc(trip_count, sizeof(*trip), GFP_KERNEL);
+	if (!trip)
+		return -ENOMEM;
+
+	tz->trip_table = trip;
+
+	if (tz->trips.critical.valid) {
+		trip->type = THERMAL_TRIP_CRITICAL;
+		trip->temperature = acpi_thermal_temp(tz, tz->trips.critical.temperature);
+		trip++;
+	}
+
+	if (tz->trips.hot.valid) {
+		trip->type = THERMAL_TRIP_HOT;
+		trip->temperature = acpi_thermal_temp(tz, tz->trips.hot.temperature);
+		trip++;
+	}
+
+	acpi_trip = &tz->trips.passive.trip;
+	if (acpi_trip->valid) {
+		passive_delay = tz->trips.passive.tsp * 100;
+
+		trip->type = THERMAL_TRIP_PASSIVE;
+		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temperature);
+		trip->priv = acpi_trip;
+		trip++;
+	}
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		acpi_trip =  &tz->trips.active[i].trip;
+
+		if (!acpi_trip->valid)
+			break;
+
+		trip->type = THERMAL_TRIP_ACTIVE;
+		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temperature);
+		trip->priv = acpi_trip;
+		trip++;
+	}
+
+	result = acpi_thermal_register_thermal_zone(tz, trip_count, passive_delay);
 	if (result)
-		goto free_memory;
+		goto free_trips;
 
 	refcount_set(&tz->thermal_check_count, 3);
 	mutex_init(&tz->thermal_check_lock);
@@ -951,6 +948,8 @@ static int acpi_thermal_add(struct acpi_
 flush_wq:
 	flush_workqueue(acpi_thermal_pm_queue);
 	acpi_thermal_unregister_thermal_zone(tz);
+free_trips:
+	kfree(tz->trip_table);
 free_memory:
 	kfree(tz);
 



