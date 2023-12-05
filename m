Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F826805E79
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345220AbjLETSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLETSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:18:37 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304EA135;
        Tue,  5 Dec 2023 11:18:41 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id d4c9c53a51f2fd46; Tue, 5 Dec 2023 20:18:39 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 71BA06687D9;
        Tue,  5 Dec 2023 20:18:39 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v1] thermal: trip: Send trip change notifications on all trip updates
Date:   Tue, 05 Dec 2023 20:18:39 +0100
Message-ID: <5737811.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehruhhirdii
 hhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The _store callbacks of the trip point temperature and hysteresis sysfs
attributes invoke thermal_notify_tz_trip_change() to send a notification
regarding the trip point change, but when trip points are updated by the
platform firmware, trip point change notifications are not sent.

To make the behavior after a trip point change more consistent,
modify all of the 3 places where trip point temperature is updated
to use a new function called thermal_zone_set_trip_temp() for this
purpose and make that function call thermal_notify_tz_trip_change().

Note that trip point hysteresis can only be updated via sysfs and
trip_point_hyst_store() calls thermal_notify_tz_trip_change() already,
so this code path need not be changed.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Depends on https://lore.kernel.org/linux-pm/12337662.O9o76ZdvQC@kreacher/

---
 drivers/acpi/thermal.c                                       |    7 +++--
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |    8 +++---
 drivers/thermal/thermal_sysfs.c                              |    4 +--
 drivers/thermal/thermal_trip.c                               |   14 ++++++++++-
 include/linux/thermal.h                                      |    2 +
 5 files changed, 27 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/thermal/thermal_sysfs.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_sysfs.c
+++ linux-pm/drivers/thermal/thermal_sysfs.c
@@ -146,9 +146,9 @@ trip_point_temp_store(struct device *dev
 				goto unlock;
 		}
 
-		trip->temperature = temp;
+		thermal_zone_set_trip_temp(tz, trip, temp);
 
-		thermal_zone_trip_updated(tz, trip);
+		__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
 	}
 
 unlock:
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -152,7 +152,6 @@ int thermal_zone_trip_id(struct thermal_
 	 */
 	return trip - tz->trips;
 }
-
 void thermal_zone_trip_updated(struct thermal_zone_device *tz,
 			       const struct thermal_trip *trip)
 {
@@ -161,3 +160,16 @@ void thermal_zone_trip_updated(struct th
 				      trip->hysteresis);
 	__thermal_zone_device_update(tz, THERMAL_TRIP_CHANGED);
 }
+
+void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
+				struct thermal_trip *trip, int temp)
+{
+	if (trip->temperature == temp)
+		return;
+
+	trip->temperature = temp;
+	thermal_notify_tz_trip_change(tz->id, thermal_zone_trip_id(tz, trip),
+				      trip->type, trip->temperature,
+				      trip->hysteresis);
+}
+EXPORT_SYMBOL_GPL(thermal_zone_set_trip_temp);
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -289,6 +289,8 @@ int thermal_zone_for_each_trip(struct th
 			       int (*cb)(struct thermal_trip *, void *),
 			       void *data);
 int thermal_zone_get_num_trips(struct thermal_zone_device *tz);
+void thermal_zone_set_trip_temp(struct thermal_zone_device *tz,
+				struct thermal_trip *trip, int temp);
 
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
 
Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -294,6 +294,7 @@ static int acpi_thermal_adjust_trip(stru
 	struct acpi_thermal_trip *acpi_trip = trip->priv;
 	struct adjust_trip_data *atd = data;
 	struct acpi_thermal *tz = atd->tz;
+	int temp;
 
 	if (!acpi_trip || !acpi_thermal_trip_valid(acpi_trip))
 		return 0;
@@ -304,9 +305,11 @@ static int acpi_thermal_adjust_trip(stru
 		acpi_thermal_update_trip_devices(tz, trip);
 
 	if (acpi_thermal_trip_valid(acpi_trip))
-		trip->temperature = acpi_thermal_temp(tz, acpi_trip->temp_dk);
+		temp = acpi_thermal_temp(tz, acpi_trip->temp_dk);
 	else
-		trip->temperature = THERMAL_TEMP_INVALID;
+		temp = THERMAL_TEMP_INVALID;
+
+	thermal_zone_set_trip_temp(tz->thermal_zone, trip, temp);
 
 	return 0;
 }
Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -225,7 +225,8 @@ EXPORT_SYMBOL_GPL(int340x_thermal_zone_r
 
 static int int340x_update_one_trip(struct thermal_trip *trip, void *arg)
 {
-	struct acpi_device *zone_adev = arg;
+	struct int34x_thermal_zone *int34x_zone = arg;
+	struct acpi_device *zone_adev = int34x_zone->adev;
 	int temp, err;
 
 	switch (trip->type) {
@@ -249,14 +250,15 @@ static int int340x_update_one_trip(struc
 	if (err)
 		temp = THERMAL_TEMP_INVALID;
 
-	trip->temperature = temp;
+	thermal_zone_set_trip_temp(int34x_zone->zone, trip, temp);
+
 	return 0;
 }
 
 void int340x_thermal_update_trips(struct int34x_thermal_zone *int34x_zone)
 {
 	thermal_zone_for_each_trip(int34x_zone->zone, int340x_update_one_trip,
-				   int34x_zone->adev);
+				   int34x_zone);
 }
 EXPORT_SYMBOL_GPL(int340x_thermal_update_trips);
 



