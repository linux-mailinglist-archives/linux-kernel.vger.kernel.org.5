Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5507B6A7A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbjJCN1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbjJCN0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:26:52 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D237A7;
        Tue,  3 Oct 2023 06:26:49 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id d9a2b773432a5c26; Tue, 3 Oct 2023 15:26:47 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 37B3F6659AF;
        Tue,  3 Oct 2023 15:26:47 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 4/6] ACPI: thermal: Use thermal_zone_for_each_trip() for updating trips
Date:   Tue, 03 Oct 2023 15:24:12 +0200
Message-ID: <1954465.PYKUYFuaPT@kreacher>
In-Reply-To: <4846448.GXAFRqVoOG@kreacher>
References: <4846448.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfeeigdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphht
 thhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
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

Rearrange the code handling notifications from the platform firmware
regarding trip point updates to carry out one loop over trip points
instead of two of them by using thermal_zone_for_each_trip() for that,
which is more straightforward than using a combination of
thermal_zone_device_exec() and for_each_thermal_trip(), each with its
own callback function.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Rebase on top of the previous patches.
   * Add active_trip_index() for computing active trip point indices instead
     of storing them.

---
 drivers/acpi/thermal.c |   78 +++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 41 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -177,6 +177,15 @@ static bool acpi_thermal_trip_valid(stru
 	return acpi_trip->temp_dk != THERMAL_TEMP_INVALID;
 }
 
+static int active_trip_index(struct acpi_thermal *tz,
+			     struct acpi_thermal_trip *acpi_trip)
+{
+	struct acpi_thermal_active *active;
+
+	active = container_of(acpi_trip, struct acpi_thermal_active, trip);
+	return active - tz->trips.active;
+}
+
 static long get_passive_temp(struct acpi_thermal *tz)
 {
 	unsigned long long tmp;
@@ -213,21 +222,18 @@ static long get_active_temp(struct acpi_
 }
 
 static void acpi_thermal_update_trip(struct acpi_thermal *tz,
-				     int index)
+				     const struct thermal_trip *trip)
 {
-	struct acpi_thermal_trip *acpi_trip;
-
-	acpi_trip = index == ACPI_THERMAL_TRIP_PASSIVE ?
-			&tz->trips.passive.trip : &tz->trips.active[index].trip;
-	if (!acpi_thermal_trip_valid(acpi_trip))
-		return;
+	struct acpi_thermal_trip *acpi_trip = trip->priv;
 
-	if (index == ACPI_THERMAL_TRIP_PASSIVE) {
+	if (trip->type == THERMAL_TRIP_PASSIVE) {
 		if (psv > 0)
 			return;
 
 		acpi_trip->temp_dk = get_passive_temp(tz);
 	} else {
+		int index = active_trip_index(tz, acpi_trip);
+
 		acpi_trip->temp_dk = get_active_temp(tz, index);
 	}
 
@@ -267,31 +273,39 @@ static bool update_trip_devices(struct a
 	return true;
 }
 
-static void acpi_thermal_update_trip_devices(struct acpi_thermal *tz, int index)
+static void acpi_thermal_update_trip_devices(struct acpi_thermal *tz,
+					     struct thermal_trip *trip)
 {
-	struct acpi_thermal_trip *acpi_trip;
-
-	acpi_trip = index == ACPI_THERMAL_TRIP_PASSIVE ?
-			&tz->trips.passive.trip : &tz->trips.active[index].trip;
-	if (!acpi_thermal_trip_valid(acpi_trip))
-		return;
+	struct acpi_thermal_trip *acpi_trip = trip->priv;
+	int index = trip->type == THERMAL_TRIP_PASSIVE ?
+			ACPI_THERMAL_TRIP_PASSIVE : active_trip_index(tz, acpi_trip);
 
-	if (update_trip_devices(tz, acpi_trip, index, true)) {
+	if (update_trip_devices(tz, acpi_trip, index, true))
 		return;
-	}
 
 	acpi_trip->temp_dk = THERMAL_TEMP_INVALID;
 	ACPI_THERMAL_TRIPS_EXCEPTION(tz, "state");
 }
 
+struct adjust_trip_data {
+	struct acpi_thermal *tz;
+	u32 event;
+};
+
 static int acpi_thermal_adjust_trip(struct thermal_trip *trip, void *data)
 {
 	struct acpi_thermal_trip *acpi_trip = trip->priv;
-	struct acpi_thermal *tz = data;
+	struct adjust_trip_data *atd = data;
+	struct acpi_thermal *tz = atd->tz;
 
-	if (!acpi_trip)
+	if (!acpi_trip || !acpi_thermal_trip_valid(acpi_trip))
 		return 0;
 
+	if (atd->event == ACPI_THERMAL_NOTIFY_THRESHOLDS)
+		acpi_thermal_update_trip(tz, trip);
+	else
+		acpi_thermal_update_trip_devices(tz, trip);
+
 	if (acpi_thermal_trip_valid(acpi_trip))
 		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
 	else
@@ -300,25 +314,6 @@ static int acpi_thermal_adjust_trip(stru
 	return 0;
 }
 
-static void acpi_thermal_adjust_thermal_zone(struct thermal_zone_device *thermal,
-					     unsigned long data)
-{
-	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
-	int i;
-
-	if (data == ACPI_THERMAL_NOTIFY_THRESHOLDS) {
-		acpi_thermal_update_trip(tz, ACPI_THERMAL_TRIP_PASSIVE);
-		for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-			acpi_thermal_update_trip(tz, i);
-	} else {
-		acpi_thermal_update_trip_devices(tz, ACPI_THERMAL_TRIP_PASSIVE);
-		for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++)
-			acpi_thermal_update_trip_devices(tz, i);
-	}
-
-	for_each_thermal_trip(tz->thermal_zone, acpi_thermal_adjust_trip, tz);
-}
-
 static void acpi_queue_thermal_check(struct acpi_thermal *tz)
 {
 	if (!work_pending(&tz->thermal_check_work))
@@ -327,17 +322,18 @@ static void acpi_queue_thermal_check(str
 
 static void acpi_thermal_trips_update(struct acpi_thermal *tz, u32 event)
 {
+	struct adjust_trip_data atd = { .tz = tz, .event = event };
 	struct acpi_device *adev = tz->device;
 
 	/*
-	 * Use thermal_zone_device_exec() to carry out the trip points
+	 * Use thermal_zone_for_each_trip() to carry out the trip points
 	 * update, so as to protect thermal_get_trend() from getting stale
 	 * trip point temperatures and to prevent thermal_zone_device_update()
 	 * invoked from acpi_thermal_check_fn() from producing inconsistent
 	 * results.
 	 */
-	thermal_zone_device_exec(tz->thermal_zone,
-				 acpi_thermal_adjust_thermal_zone, event);
+	thermal_zone_for_each_trip(tz->thermal_zone,
+				   acpi_thermal_adjust_trip, &atd);
 	acpi_queue_thermal_check(tz);
 	acpi_bus_generate_netlink_event(adev->pnp.device_class,
 					dev_name(&adev->dev), event, 0);



