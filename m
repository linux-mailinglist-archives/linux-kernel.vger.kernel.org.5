Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EEE7AA016
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjIUUcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjIUUcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:32:00 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCA1AF94C;
        Thu, 21 Sep 2023 11:07:31 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id c8dfa8de6a80f189; Thu, 21 Sep 2023 20:07:29 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 1A650664EBE;
        Thu, 21 Sep 2023 20:07:28 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 04/13] ACPI: thermal: Merge trip initialization functions
Date:   Thu, 21 Sep 2023 19:51:19 +0200
Message-ID: <1785516.VLH7GnMWUR@kreacher>
In-Reply-To: <1957441.PYKUYFuaPT@kreacher>
References: <1957441.PYKUYFuaPT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhn
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

In order to reduce code duplicationeve further, merge
acpi_thermal_init_passive/active_trip() into one function called
acpi_thermal_init_trip() that will be used for initializing both
the passive and active trip points.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   64 ++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 34 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -399,72 +399,68 @@ static long acpi_thermal_get_hot_trip(st
 	return tmp;
 }
 
-static bool acpi_thermal_init_passive_trip(struct acpi_thermal *tz)
+static bool passive_trip_params_init(struct acpi_thermal *tz)
 {
 	unsigned long long tmp;
 	acpi_status status;
-	int temp;
-
-	if (psv == -1)
-		goto fail;
-
-	if (psv > 0) {
-		temp = celsius_to_deci_kelvin(psv);
-	} else {
-		temp = get_passive_temp(tz);
-		if (temp == THERMAL_TEMP_INVALID)
-			goto fail;
-	}
 
 	status = acpi_evaluate_integer(tz->device->handle, "_TC1", NULL, &tmp);
 	if (ACPI_FAILURE(status))
-		goto fail;
+		return false;
 
 	tz->trips.passive.tc1 = tmp;
 
 	status = acpi_evaluate_integer(tz->device->handle, "_TC2", NULL, &tmp);
 	if (ACPI_FAILURE(status))
-		goto fail;
+		return false;
 
 	tz->trips.passive.tc2 = tmp;
 
 	status = acpi_evaluate_integer(tz->device->handle, "_TSP", NULL, &tmp);
 	if (ACPI_FAILURE(status))
-		goto fail;
+		return false;
 
 	tz->trips.passive.tsp = tmp;
 
-	if (!update_trip_devices(tz, &tz->trips.passive.trip,
-				 ACPI_THERMAL_TRIP_PASSIVE, false))
-		goto fail;
-
-	tz->trips.passive.trip.temperature = temp;
 	return true;
-
-fail:
-	tz->trips.passive.trip.temperature = THERMAL_TEMP_INVALID;
-	return false;
 }
 
-static bool acpi_thermal_init_active_trip(struct acpi_thermal *tz, int index)
+static bool acpi_thermal_init_trip(struct acpi_thermal *tz, int index)
 {
+	struct acpi_thermal_trip *acpi_trip;
 	long temp;
 
-	if (act == -1)
-		goto fail;
+	if (index == ACPI_THERMAL_TRIP_PASSIVE) {
+		acpi_trip = &tz->trips.passive.trip;
+
+		if (psv == -1)
+			goto fail;
+
+		if (!passive_trip_params_init(tz))
+			goto fail;
+
+		temp = psv > 0 ? celsius_to_deci_kelvin(psv) :
+				 get_passive_temp(tz);
+	} else {
+		acpi_trip = &tz->trips.active[index].trip;
+
+		if (act == -1)
+			goto fail;
+
+		temp = get_active_temp(tz, index);
+	}
 
-	temp = get_active_temp(tz, index);
 	if (temp == THERMAL_TEMP_INVALID)
 		goto fail;
 
-	if (!update_trip_devices(tz, &tz->trips.active[index].trip, index, false))
+	if (!update_trip_devices(tz, acpi_trip, index, false))
 		goto fail;
 
-	tz->trips.active[index].trip.temperature = temp;
+	acpi_trip->temperature = temp;
 	return true;
 
 fail:
-	tz->trips.active[index].trip.temperature = THERMAL_TEMP_INVALID;
+	acpi_trip->temperature = THERMAL_TEMP_INVALID;
 	return false;
 }
 
@@ -473,11 +469,11 @@ static int acpi_thermal_get_trip_points(
 	unsigned int count = 0;
 	int i;
 
-	if (acpi_thermal_init_passive_trip(tz))
+	if (acpi_thermal_init_trip(tz, ACPI_THERMAL_TRIP_PASSIVE))
 		count++;
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (acpi_thermal_init_active_trip(tz, i))
+		if (acpi_thermal_init_trip(tz, i))
 			count++;
 		else
 			break;



