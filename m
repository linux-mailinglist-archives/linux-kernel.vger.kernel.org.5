Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B307AA122
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjIUU6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjIUU5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:57:51 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46816AF962;
        Thu, 21 Sep 2023 11:07:34 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 107c9b7d8d95f1f5; Thu, 21 Sep 2023 20:07:32 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 40739664EBE;
        Thu, 21 Sep 2023 20:07:32 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 01/13] ACPI: thermal: Add device list to struct acpi_thermal_trip
Date:   Thu, 21 Sep 2023 19:48:33 +0200
Message-ID: <7586104.EvYhyI6sBW@kreacher>
In-Reply-To: <1957441.PYKUYFuaPT@kreacher>
References: <1957441.PYKUYFuaPT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedguddulecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhn
 thgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The device lists present in struct acpi_thermal_passive and struct
acpi_thermal_active can be located in struct acpi_thermal_trip which
then will allow the same code to be used for handling both the passive
and active trip points, so make that change.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -81,11 +81,11 @@ static struct workqueue_struct *acpi_the
 
 struct acpi_thermal_trip {
 	unsigned long temperature;
+	struct acpi_handle_list devices;
 };
 
 struct acpi_thermal_passive {
 	struct acpi_thermal_trip trip;
-	struct acpi_handle_list devices;
 	unsigned long tc1;
 	unsigned long tc2;
 	unsigned long tsp;
@@ -93,7 +93,6 @@ struct acpi_thermal_passive {
 
 struct acpi_thermal_active {
 	struct acpi_thermal_trip trip;
-	struct acpi_handle_list devices;
 };
 
 struct acpi_thermal_trips {
@@ -205,6 +204,7 @@ static void acpi_thermal_update_passive_
 
 static bool update_passive_devices(struct acpi_thermal *tz, bool compare)
 {
+	struct acpi_thermal_trip *acpi_trip = &tz->trips.passive.trip;
 	struct acpi_handle_list devices;
 	acpi_status status;
 
@@ -217,10 +217,10 @@ static bool update_passive_devices(struc
 		return false;
 	}
 
-	if (compare && memcmp(&tz->trips.passive.devices, &devices, sizeof(devices)))
+	if (compare && memcmp(&acpi_trip->devices, &devices, sizeof(devices)))
 		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "device");
 
-	memcpy(&tz->trips.passive.devices, &devices, sizeof(devices));
+	memcpy(&acpi_trip->devices, &devices, sizeof(devices));
 	return true;
 }
 
@@ -276,6 +276,7 @@ static void acpi_thermal_update_active_t
 static bool update_active_devices(struct acpi_thermal *tz, int index, bool compare)
 {
 	char method[] = { '_', 'A', 'L', '0' + index, '\0' };
+	struct acpi_thermal_trip *acpi_trip = &tz->trips.active[index].trip;
 	struct acpi_handle_list devices;
 	acpi_status status;
 
@@ -289,10 +290,10 @@ static bool update_active_devices(struct
 		return false;
 	}
 
-	if (compare && memcmp(&tz->trips.active[index].devices, &devices, sizeof(devices)))
+	if (compare && memcmp(&acpi_trip->devices, &devices, sizeof(devices)))
 		ACPI_THERMAL_TRIPS_EXCEPTION(tz, "device");
 
-	memcpy(&tz->trips.active[index].devices, &devices, sizeof(devices));
+	memcpy(&acpi_trip->devices, &devices, sizeof(devices));
 	return true;
 }
 
@@ -602,6 +603,7 @@ static int acpi_thermal_cooling_device_c
 {
 	struct acpi_device *device = cdev->devdata;
 	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
+	struct acpi_thermal_trip *acpi_trip;
 	struct acpi_device *dev;
 	acpi_handle handle;
 	int i;
@@ -615,10 +617,11 @@ static int acpi_thermal_cooling_device_c
 	if (tz->trips.hot_valid)
 		trip++;
 
-	if (acpi_thermal_trip_valid(&tz->trips.passive.trip)) {
+	acpi_trip = &tz->trips.passive.trip;
+	if (acpi_thermal_trip_valid(acpi_trip)) {
 		trip++;
-		for (i = 0; i < tz->trips.passive.devices.count; i++) {
-			handle = tz->trips.passive.devices.handles[i];
+		for (i = 0; i < acpi_trip->devices.count; i++) {
+			handle = acpi_trip->devices.handles[i];
 			dev = acpi_fetch_acpi_dev(handle);
 			if (dev != device)
 				continue;
@@ -640,12 +643,13 @@ static int acpi_thermal_cooling_device_c
 	}
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!acpi_thermal_trip_valid(&tz->trips.active[i].trip))
+		acpi_trip = &tz->trips.active[i].trip;
+		if (!acpi_thermal_trip_valid(acpi_trip))
 			break;
 
 		trip++;
-		for (j = 0; j < tz->trips.active[i].devices.count; j++) {
-			handle = tz->trips.active[i].devices.handles[j];
+		for (j = 0; j < acpi_trip->devices.count; j++) {
+			handle = acpi_trip->devices.handles[j];
 			dev = acpi_fetch_acpi_dev(handle);
 			if (dev != device)
 				continue;
@@ -1035,11 +1039,13 @@ static int acpi_thermal_resume(struct de
 		return -EINVAL;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (!acpi_thermal_trip_valid(&tz->trips.active[i].trip))
+		struct acpi_thermal_trip *acpi_trip = &tz->trips.active[i].trip;
+
+		if (!acpi_thermal_trip_valid(acpi_trip))
 			break;
 
-		for (j = 0; j < tz->trips.active[i].devices.count; j++) {
-			acpi_bus_update_power(tz->trips.active[i].devices.handles[j],
+		for (j = 0; j < acpi_trip->devices.count; j++) {
+			acpi_bus_update_power(acpi_trip->devices.handles[j],
 					      &power_state);
 		}
 	}



