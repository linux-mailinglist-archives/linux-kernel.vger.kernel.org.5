Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1B975CB56
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjGUPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjGUPSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:18:15 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F35930DD;
        Fri, 21 Jul 2023 08:18:13 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 0a38bb1b8a5a6388; Fri, 21 Jul 2023 17:18:11 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 32225661901;
        Fri, 21 Jul 2023 17:18:11 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2 7/8] ACPI: thermal: Rework thermal_get_trend()
Date:   Fri, 21 Jul 2023 17:08:48 +0200
Message-ID: <1849104.atdPhlSkOF@kreacher>
In-Reply-To: <5710197.DvuYhMxLoT@kreacher>
References: <13318886.uLZWGnKmhe@kreacher> <5710197.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdekvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgt
 phhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
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

Rework the ACPI thermal driver's .get_trend() callback function,
thermal_get_trend(), to use trip point data stored in the generic
trip structures instead of calling thermal_get_trip_type() and
thermal_get_trip_temp().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Do not acquire thermal_check_lock in thermal_get_trend() (lockdep
     would complain about this, because it is hold around thermal zone
     locking and .get_trend() runs under the thermal zone lock).  The
     thermal zone locking added in the previous patches is sufficient
     to protect this code.
   * Check trips against invalid temperature values.
   * Return an error for trips other than passive and active.

---
 drivers/acpi/thermal.c |  106 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 78 insertions(+), 28 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -577,47 +577,97 @@ static int thermal_get_crit_temp(struct
 	return -EINVAL;
 }
 
-static int thermal_get_trend(struct thermal_zone_device *thermal,
-			     int trip, enum thermal_trend *trend)
+static struct thermal_trip *acpi_thermal_get_trip(struct acpi_thermal *tz,
+						  int trip_index)
 {
-	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
-	enum thermal_trip_type type;
+	struct thermal_trip *trip;
 	int i;
 
-	if (thermal_get_trip_type(thermal, trip, &type))
-		return -EINVAL;
+	if (!tz || trip_index < 0)
+		return NULL;
 
-	if (type == THERMAL_TRIP_ACTIVE) {
-		int trip_temp;
-		int temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->temperature, tz->kelvin_offset);
-		if (thermal_get_trip_temp(thermal, trip, &trip_temp))
-			return -EINVAL;
+	trip = tz->trips.critical.trip_ref.trip;
+	if (trip) {
+		if (!trip_index)
+			return trip;
 
-		if (temp > trip_temp) {
-			*trend = THERMAL_TREND_RAISING;
-			return 0;
-		} else {
-			/* Fall back on default trend */
-			return -EINVAL;
+		trip_index--;
+	}
+
+	trip = tz->trips.hot.trip_ref.trip;
+	if (trip) {
+		if (!trip_index)
+			return trip;
+
+		trip_index--;
+	}
+
+	trip = tz->trips.passive.trip_ref.trip;
+	if (trip) {
+		if (!trip_index)
+			return trip;
+
+		trip_index--;
+	}
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		trip = tz->trips.active[i].trip_ref.trip;
+		if (trip) {
+			if (!trip_index)
+				return trip;
+
+			trip_index--;
 		}
 	}
 
+	return NULL;
+}
+
+static int thermal_get_trend(struct thermal_zone_device *thermal,
+			     int trip_index, enum thermal_trend *trend)
+{
+	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
+	struct thermal_trip *trip;
+	long t;
+
+	trip = acpi_thermal_get_trip(tz, trip_index);
+	if (!trip || trip->temperature == THERMAL_TEMP_INVALID)
+		return -EINVAL;
+
 	/*
 	 * tz->temperature has already been updated by generic thermal layer,
-	 * before this callback being invoked
+	 * before this callback being invoked.
 	 */
-	i = tz->trips.passive.tc1 * (tz->temperature - tz->last_temperature) +
-	    tz->trips.passive.tc2 * (tz->temperature - tz->trips.passive.temperature);
+	switch (trip->type) {
+	case THERMAL_TRIP_PASSIVE:
+		t = tz->trips.passive.tc1 * (tz->temperature -
+						tz->last_temperature) +
+			tz->trips.passive.tc2 * (tz->temperature -
+						tz->trips.passive.temperature);
+		if (t > 0)
+			*trend = THERMAL_TREND_RAISING;
+		else if (t < 0)
+			*trend = THERMAL_TREND_DROPPING;
+		else
+			*trend = THERMAL_TREND_STABLE;
+
+		return 0;
+
+	case THERMAL_TRIP_ACTIVE:
+		t = deci_kelvin_to_millicelsius_with_offset(tz->temperature,
+							    tz->kelvin_offset);
+		if (t > trip->temperature) {
+			*trend = THERMAL_TREND_RAISING;
+			return 0;
+		}
 
-	if (i > 0)
-		*trend = THERMAL_TREND_RAISING;
-	else if (i < 0)
-		*trend = THERMAL_TREND_DROPPING;
-	else
-		*trend = THERMAL_TREND_STABLE;
+		fallthrough;
 
-	return 0;
+	default:
+		break;
+	}
+
+	return -EINVAL;
 }
 
 static void acpi_thermal_zone_device_hot(struct thermal_zone_device *thermal)



