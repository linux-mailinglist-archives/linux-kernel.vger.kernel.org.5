Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276EE7B6A77
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjJCN04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjJCN0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:26:51 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F9BA1;
        Tue,  3 Oct 2023 06:26:47 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 790a30df8c9ae96b; Tue, 3 Oct 2023 15:26:46 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B05B36659AF;
        Tue,  3 Oct 2023 15:26:45 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 6/6] thermal: int340x: Use thermal_zone_for_each_trip()
Date:   Tue, 03 Oct 2023 15:26:35 +0200
Message-ID: <3532950.iIbC2pHGDl@kreacher>
In-Reply-To: <4846448.GXAFRqVoOG@kreacher>
References: <4846448.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrfeeigdeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphht
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

Modify int340x_thermal_update_trips() to use thermal_zone_for_each_trip()
for walking trips instead of using the trips[] table passed to the
thermal zone registration function.

For this purpose, store active trip point indices in the priv fieids of
the corresponding thermal_trip structures.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Mo changes

---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |   76 +++++------
 1 file changed, 41 insertions(+), 35 deletions(-)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -67,6 +67,16 @@ static struct thermal_zone_device_ops in
 	.critical	= int340x_thermal_critical,
 };
 
+static inline void *int_to_trip_priv(int i)
+{
+	return (void *)(long)i;
+}
+
+static inline int trip_priv_to_int(const struct thermal_trip *trip)
+{
+	return (long)trip->priv;
+}
+
 static int int340x_thermal_read_trips(struct acpi_device *zone_adev,
 				      struct thermal_trip *zone_trips,
 				      int trip_cnt)
@@ -101,6 +111,7 @@ static int int340x_thermal_read_trips(st
 			break;
 
 		zone_trips[trip_cnt].type = THERMAL_TRIP_ACTIVE;
+		zone_trips[trip_cnt].priv = int_to_trip_priv(i);
 		trip_cnt++;
 	}
 
@@ -212,45 +223,40 @@ void int340x_thermal_zone_remove(struct
 }
 EXPORT_SYMBOL_GPL(int340x_thermal_zone_remove);
 
-void int340x_thermal_update_trips(struct int34x_thermal_zone *int34x_zone)
+static int int340x_update_one_trip(struct thermal_trip *trip, void *arg)
 {
-	struct acpi_device *zone_adev = int34x_zone->adev;
-	struct thermal_trip *zone_trips = int34x_zone->trips;
-	int trip_cnt = int34x_zone->zone->num_trips;
-	int act_trip_nr = 0;
-	int i;
-
-	mutex_lock(&int34x_zone->zone->lock);
-
-	for (i = int34x_zone->aux_trip_nr; i < trip_cnt; i++) {
-		int temp, err;
-
-		switch (zone_trips[i].type) {
-		case THERMAL_TRIP_CRITICAL:
-			err = thermal_acpi_critical_trip_temp(zone_adev, &temp);
-			break;
-		case THERMAL_TRIP_HOT:
-			err = thermal_acpi_hot_trip_temp(zone_adev, &temp);
-			break;
-		case THERMAL_TRIP_PASSIVE:
-			err = thermal_acpi_passive_trip_temp(zone_adev, &temp);
-			break;
-		case THERMAL_TRIP_ACTIVE:
-			err = thermal_acpi_active_trip_temp(zone_adev, act_trip_nr++,
-							    &temp);
-			break;
-		default:
-			err = -ENODEV;
-		}
-		if (err) {
-			zone_trips[i].temperature = THERMAL_TEMP_INVALID;
-			continue;
-		}
+	struct acpi_device *zone_adev = arg;
+	int temp, err;
 
-		zone_trips[i].temperature = temp;
+	switch (trip->type) {
+	case THERMAL_TRIP_CRITICAL:
+		err = thermal_acpi_critical_trip_temp(zone_adev, &temp);
+		break;
+	case THERMAL_TRIP_HOT:
+		err = thermal_acpi_hot_trip_temp(zone_adev, &temp);
+		break;
+	case THERMAL_TRIP_PASSIVE:
+		err = thermal_acpi_passive_trip_temp(zone_adev, &temp);
+		break;
+	case THERMAL_TRIP_ACTIVE:
+		err = thermal_acpi_active_trip_temp(zone_adev,
+						    trip_priv_to_int(trip),
+						    &temp);
+		break;
+	default:
+		err = -ENODEV;
 	}
+	if (err)
+		temp = THERMAL_TEMP_INVALID;
 
-	mutex_unlock(&int34x_zone->zone->lock);
+	trip->temperature = temp;
+	return 0;
+}
+
+void int340x_thermal_update_trips(struct int34x_thermal_zone *int34x_zone)
+{
+	thermal_zone_for_each_trip(int34x_zone->zone, int340x_update_one_trip,
+				   int34x_zone->adev);
 }
 EXPORT_SYMBOL_GPL(int340x_thermal_update_trips);
 



