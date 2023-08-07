Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D86772DA9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjHGSVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjHGSU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:20:58 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194A3194;
        Mon,  7 Aug 2023 11:20:56 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id e153a7dfbe3fa879; Mon, 7 Aug 2023 20:20:55 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id B19566625B2;
        Mon,  7 Aug 2023 20:20:54 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5 09/11] ACPI: thermal: Rework thermal_get_trend()
Date:   Mon, 07 Aug 2023 20:17:07 +0200
Message-ID: <8296661.NyiUUSuA9g@kreacher>
In-Reply-To: <4503814.LvFx2qVVIh@kreacher>
References: <13318886.uLZWGnKmhe@kreacher> <4503814.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrledtgdduudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
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

Rework the ACPI thermal driver's .get_trend() callback function,
thermal_get_trend(), so that it does not call thermal_get_trip_type()
and thermal_get_trip_temp() which are going to be dropped.

This reduces the overhead of the function too, because it will always
carry out a trip point lookup once after the change.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v4 -> v5:
   * Rebase on top of patches [07-08/11].

v3 -> v4:
   * Adjust for the lack of a direct way to get from the local trip point
     representations to trips[i].

v2 -> v3: Rebase on top of the v2 of the previous patch.

v1 -> v2:
   * Do not acquire thermal_check_lock in thermal_get_trend() (lockdep
     would complain about this, because it is hold around thermal zone
     locking and .get_trend() runs under the thermal zone lock).  The
     thermal zone locking added in the previous patches is sufficient
     to protect this code.
   * Check trips against invalid temperature values.
   * Return an error for trips other than passive and active.

---
 drivers/acpi/thermal.c |   68 +++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 30 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -597,46 +597,54 @@ static int thermal_get_crit_temp(struct
 }
 
 static int thermal_get_trend(struct thermal_zone_device *thermal,
-			     int trip, enum thermal_trend *trend)
+			     int trip_index, enum thermal_trend *trend)
 {
 	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
-	enum thermal_trip_type type;
-	int i;
+	struct acpi_thermal_trip *acpi_trip;
+	int t, i;
 
-	if (thermal_get_trip_type(thermal, trip, &type))
+	if (!tz || trip_index < 0)
 		return -EINVAL;
 
-	if (type == THERMAL_TRIP_ACTIVE) {
-		int trip_temp;
-		int temp = deci_kelvin_to_millicelsius_with_offset(
-					tz->temperature, tz->kelvin_offset);
-		if (thermal_get_trip_temp(thermal, trip, &trip_temp))
-			return -EINVAL;
+	if (tz->trips.critical.valid)
+		trip_index--;
 
-		if (temp > trip_temp) {
+	if (tz->trips.hot.valid)
+		trip_index--;
+
+	if (trip_index < 0)
+		return -EINVAL;
+
+	acpi_trip = &tz->trips.passive.trip;
+	if (acpi_trip->valid && !trip_index--) {
+		t = tz->trips.passive.tc1 * (tz->temperature -
+						tz->last_temperature) +
+			tz->trips.passive.tc2 * (tz->temperature -
+						acpi_trip->temperature);
+		if (t > 0)
 			*trend = THERMAL_TREND_RAISING;
-			return 0;
-		} else {
-			/* Fall back on default trend */
-			return -EINVAL;
-		}
+		else if (t < 0)
+			*trend = THERMAL_TREND_DROPPING;
+		else
+			*trend = THERMAL_TREND_STABLE;
+
+		return 0;
 	}
 
-	/*
-	 * tz->temperature has already been updated by generic thermal layer,
-	 * before this callback being invoked
-	 */
-	i = tz->trips.passive.tc1 * (tz->temperature - tz->last_temperature) +
-	    tz->trips.passive.tc2 * (tz->temperature - tz->trips.passive.trip.temperature);
-
-	if (i > 0)
-		*trend = THERMAL_TREND_RAISING;
-	else if (i < 0)
-		*trend = THERMAL_TREND_DROPPING;
-	else
-		*trend = THERMAL_TREND_STABLE;
+	t = acpi_thermal_temp(tz, tz->temperature);
+
+	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
+		acpi_trip = &tz->trips.active[i].trip;
+		if (acpi_trip->valid && !trip_index--) {
+			if (t > acpi_thermal_temp(tz, acpi_trip->temperature)) {
+				*trend = THERMAL_TREND_RAISING;
+				return 0;
+			}
+			break;
+		}
+	}
 
-	return 0;
+	return -EINVAL;
 }
 
 static void acpi_thermal_zone_device_hot(struct thermal_zone_device *thermal)



