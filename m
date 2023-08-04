Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20AF770AD7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjHDV0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjHDV0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:26:10 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751A2E60;
        Fri,  4 Aug 2023 14:26:08 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 3627b7821fbcc242; Fri, 4 Aug 2023 23:26:06 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 4E705661680;
        Fri,  4 Aug 2023 23:26:06 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 07/10] ACPI: thermal: Use trip point table to register thermal zones
Date:   Fri, 04 Aug 2023 23:18:10 +0200
Message-ID: <1987843.usQuhbGJ8B@kreacher>
In-Reply-To: <4878513.31r3eYUQgx@kreacher>
References: <13318886.uLZWGnKmhe@kreacher> <4878513.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggdduheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
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

Make the ACPI thermal driver use thermal_zone_device_register_with_trips()
to register its thermal zones.

For this purpose, make it create a trip point table that will be passed to
thermal_zone_device_register_with_trips() as an argument.

Also use the thermal_zone_update_trip_temp() helper introduced
previously to update temperatures of the passive and active trip
points after a trip points change notification from the platform
firmware.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4:
   * Rework to use thermal_zone_update_trip_temp() for updating trip point
     temperatures.
   * Rebase on top of the new version of the previous patch.

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
 drivers/acpi/thermal.c |   95 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -137,6 +137,7 @@ struct acpi_thermal {
 	unsigned long polling_frequency;
 	volatile u8 zombie;
 	struct acpi_thermal_trips trips;
+	struct thermal_trip *trip_table;
 	struct acpi_handle_list devices;
 	struct thermal_zone_device *thermal_zone;
 	int kelvin_offset;	/* in millidegrees */
@@ -190,6 +191,22 @@ static int acpi_thermal_get_polling_freq
 	return 0;
 }
 
+static int acpi_thermal_temp(struct acpi_thermal *tz, int temp_deci_k)
+{
+	if (temp_deci_k == THERMAL_TEMP_INVALID)
+		return THERMAL_TEMP_INVALID;
+
+	return deci_kelvin_to_millicelsius_with_offset(temp_deci_k,
+						       tz->kelvin_offset);
+}
+
+static void acpi_thermal_update_trip_temp(struct acpi_thermal *tz,
+					  void *trip_priv, int temp_deci_k)
+{
+	thermal_zone_update_trip_temp(tz->thermal_zone, trip_priv,
+				      acpi_thermal_temp(tz, temp_deci_k));
+}
+
 static void __acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 {
 	acpi_status status;
@@ -403,7 +420,28 @@ static void __acpi_thermal_trips_update(
 static void acpi_thermal_adjust_thermal_zone(struct thermal_zone_device *thermal,
 					     unsigned long data)
 {
-	__acpi_thermal_trips_update(thermal_zone_device_priv(thermal), data);
+	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
+	int i;
+
+	__acpi_thermal_trips_update(tz, data);
+
+	if (tz->trips.passive.valid)
+		acpi_thermal_update_trip_temp(tz, &tz->trips.passive,
+					      tz->trips.passive.temperature);
+	else
+		thermal_zone_update_trip_temp(tz->thermal_zone,
+					      &tz->trips.passive,
+					      THERMAL_TEMP_INVALID);
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		if (tz->trips.active[i].valid)
+			acpi_thermal_update_trip_temp(tz, &tz->trips.active[i],
+						      tz->trips.active[i].temperature);
+		else
+			thermal_zone_update_trip_temp(tz->thermal_zone,
+						      &tz->trips.active[i],
+						      THERMAL_TEMP_INVALID);
+	}
 }
 
 static void acpi_queue_thermal_check(struct acpi_thermal *tz)
@@ -768,6 +806,7 @@ static void acpi_thermal_zone_sysfs_remo
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz)
 {
+	struct thermal_trip *trip;
 	int passive_delay = 0;
 	int trip_count = 0;
 	int result;
@@ -788,12 +827,50 @@ static int acpi_thermal_register_thermal
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
+	if (tz->trips.passive.valid) {
+		trip->type = THERMAL_TRIP_PASSIVE;
+		trip->temperature = acpi_thermal_temp(tz, tz->trips.passive.temperature);
+		trip->priv = &tz->trips.passive;
+		trip++;
+	}
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE && tz->trips.active[i].valid; i++) {
+		trip->type = THERMAL_TRIP_ACTIVE;
+		trip->temperature = acpi_thermal_temp(tz, tz->trips.active[i].temperature);
+		trip->priv = &tz->trips.active[i];
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
@@ -821,6 +898,8 @@ remove_links:
 	acpi_thermal_zone_sysfs_remove(tz);
 unregister_tzd:
 	thermal_zone_device_unregister(tz->thermal_zone);
+free_trip_table:
+	kfree(tz->trip_table);
 
 	return result;
 }
@@ -829,6 +908,7 @@ static void acpi_thermal_unregister_ther
 {
 	acpi_thermal_zone_sysfs_remove(tz);
 	thermal_zone_device_unregister(tz->thermal_zone);
+	kfree(tz->trip_table);
 	tz->thermal_zone = NULL;
 	acpi_bus_detach_private_data(tz->device->handle);
 }



