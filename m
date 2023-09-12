Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB01E79D91A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbjILSsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237610AbjILSry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:47:54 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C988A1725;
        Tue, 12 Sep 2023 11:47:46 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id cd625864ca82de2a; Tue, 12 Sep 2023 20:47:45 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C09AD663BE5;
        Tue, 12 Sep 2023 20:47:44 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 1/9] ACPI: thermal: Simplify initialization of critical and hot trips
Date:   Tue, 12 Sep 2023 20:35:40 +0200
Message-ID: <4858652.31r3eYUQgx@kreacher>
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

Use the observation that the critical and hot trip points are never
updated by the ACPI thermal driver, because the flags passed from
acpi_thermal_notify() to acpi_thermal_trips_update() do not include
ACPI_TRIPS_CRITICAL or ACPI_TRIPS_HOT, to move the initialization
of those trip points directly into acpi_thermal_get_trip_points() and
reduce the size of __acpi_thermal_trips_update().

Also make the critical and hot trip points initialization code more
straightforward and drop the flags that are not needed any more.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |  130 ++++++++++++++++++++++++-------------------------
 1 file changed, 66 insertions(+), 64 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -43,17 +43,13 @@
 #define ACPI_THERMAL_MAX_ACTIVE		10
 #define ACPI_THERMAL_MAX_LIMIT_STR_LEN	65
 
-#define ACPI_TRIPS_CRITICAL	BIT(0)
-#define ACPI_TRIPS_HOT		BIT(1)
-#define ACPI_TRIPS_PASSIVE	BIT(2)
-#define ACPI_TRIPS_ACTIVE	BIT(3)
-#define ACPI_TRIPS_DEVICES	BIT(4)
+#define ACPI_TRIPS_PASSIVE	BIT(0)
+#define ACPI_TRIPS_ACTIVE	BIT(1)
+#define ACPI_TRIPS_DEVICES	BIT(2)
 
 #define ACPI_TRIPS_THRESHOLDS	(ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE)
 
-#define ACPI_TRIPS_INIT		(ACPI_TRIPS_CRITICAL | ACPI_TRIPS_HOT | \
-				 ACPI_TRIPS_PASSIVE | ACPI_TRIPS_ACTIVE | \
-				 ACPI_TRIPS_DEVICES)
+#define ACPI_TRIPS_INIT		(ACPI_TRIPS_THRESHOLDS | ACPI_TRIPS_DEVICES)
 
 /*
  * This exception is thrown out in two cases:
@@ -196,62 +192,6 @@ static void __acpi_thermal_trips_update(
 	bool valid = false;
 	int i;
 
-	/* Critical Shutdown */
-	if (flag & ACPI_TRIPS_CRITICAL) {
-		status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
-		tz->trips.critical.temperature = tmp;
-		/*
-		 * Treat freezing temperatures as invalid as well; some
-		 * BIOSes return really low values and cause reboots at startup.
-		 * Below zero (Celsius) values clearly aren't right for sure..
-		 * ... so lets discard those as invalid.
-		 */
-		if (ACPI_FAILURE(status)) {
-			tz->trips.critical.valid = false;
-			acpi_handle_debug(tz->device->handle,
-					  "No critical threshold\n");
-		} else if (tmp <= 2732) {
-			pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
-			tz->trips.critical.valid = false;
-		} else {
-			tz->trips.critical.valid = true;
-			acpi_handle_debug(tz->device->handle,
-					  "Found critical threshold [%lu]\n",
-					  tz->trips.critical.temperature);
-		}
-		if (tz->trips.critical.valid) {
-			if (crt == -1) {
-				tz->trips.critical.valid = false;
-			} else if (crt > 0) {
-				unsigned long crt_k = celsius_to_deci_kelvin(crt);
-
-				/*
-				 * Allow override critical threshold
-				 */
-				if (crt_k > tz->trips.critical.temperature)
-					pr_info("Critical threshold %d C\n", crt);
-
-				tz->trips.critical.temperature = crt_k;
-			}
-		}
-	}
-
-	/* Critical Sleep (optional) */
-	if (flag & ACPI_TRIPS_HOT) {
-		status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &tmp);
-		if (ACPI_FAILURE(status)) {
-			tz->trips.hot.valid = false;
-			acpi_handle_debug(tz->device->handle,
-					  "No hot threshold\n");
-		} else {
-			tz->trips.hot.temperature = tmp;
-			tz->trips.hot.valid = true;
-			acpi_handle_debug(tz->device->handle,
-					  "Found hot threshold [%lu]\n",
-					  tz->trips.hot.temperature);
-		}
-	}
-
 	/* Passive (optional) */
 	if (((flag & ACPI_TRIPS_PASSIVE) && tz->trips.passive.trip.valid) ||
 	    flag == ACPI_TRIPS_INIT) {
@@ -451,11 +391,73 @@ static void acpi_thermal_trips_update(st
 					dev_name(&adev->dev), event, 0);
 }
 
+static void acpi_thermal_get_critical_trip(struct acpi_thermal *tz)
+{
+	unsigned long long tmp;
+	acpi_status status;
+
+	if (crt > 0) {
+		tmp = celsius_to_deci_kelvin(crt);
+		goto set;
+	}
+	if (crt == -1) {
+		acpi_handle_debug(tz->device->handle, "Critical threshold disabled\n");
+		goto fail;
+	}
+
+	status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(tz->device->handle, "No critical threshold\n");
+		goto fail;
+	}
+	if (tmp <= 2732) {
+		/*
+		 * Below zero (Celsius) values clearly aren't right for sure,
+		 * so discard them as invalid.
+		 */
+		pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
+		goto fail;
+	}
+
+set:
+	tz->trips.critical.valid = true;
+	tz->trips.critical.temperature = tmp;
+	acpi_handle_debug(tz->device->handle, "Critical threshold [%lu]\n",
+			  tz->trips.critical.temperature);
+	return;
+
+fail:
+	tz->trips.critical.valid = false;
+	tz->trips.critical.temperature = THERMAL_TEMP_INVALID;
+}
+
+static void acpi_thermal_get_hot_trip(struct acpi_thermal *tz)
+{
+	unsigned long long tmp;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &tmp);
+	if (ACPI_FAILURE(status)) {
+		tz->trips.hot.valid = false;
+		tz->trips.hot.temperature = THERMAL_TEMP_INVALID;
+		acpi_handle_debug(tz->device->handle, "No hot threshold\n");
+		return;
+	}
+
+	tz->trips.hot.valid = true;
+	tz->trips.hot.temperature = tmp;
+	acpi_handle_debug(tz->device->handle, "Hot threshold [%lu]\n",
+			  tz->trips.hot.temperature);
+}
+
 static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 {
 	bool valid;
 	int i;
 
+	acpi_thermal_get_critical_trip(tz);
+	acpi_thermal_get_hot_trip(tz);
+	/* Passive and active trip points (optional). */
 	__acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
 
 	valid = tz->trips.critical.valid |



