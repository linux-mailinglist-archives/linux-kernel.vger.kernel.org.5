Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAB07E6CD1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbjKIPB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjKIPBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:01:54 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55E72D62;
        Thu,  9 Nov 2023 07:01:51 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.3.0)
 id a42070ca4c13ac30; Thu, 9 Nov 2023 16:01:49 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id EB14B667CDF;
        Thu,  9 Nov 2023 16:01:48 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v3] thermal: core: Add trip thresholds for trip crossing detection
Date:   Thu, 09 Nov 2023 16:01:48 +0100
Message-ID: <12346243.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddvuddgjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghl
 rdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The trip crossing detection in handle_thermal_trip() does not work
correctly in the cases when a trip point is crossed on the way up and
then the zone temperature stays above its low temperature (that is, its
temperature decreased by its hysteresis).  The trip temperature may
be passed by the zone temperature subsequently in that case, even
multiple times, but that does not count as the trip crossing as long as
the zone temperature does not fall below the trip's low temperature or,
in other words, until the trip is crossed on the way down.

|-----------low--------high------------|
             |<--------->|
             |    hyst   |
             |           |
             |          -|--> crossed on the way up
             |
         <---|-- crossed on the way down

However, handle_thermal_trip() will invoke thermal_notify_tz_trip_up()
every time the trip temperature is passed by the zone temperature on
the way up regardless of whether or not the trip has been crossed on
the way down yet.  Moreover, it will not call thermal_notify_tz_trip_down()
if the last zone temperature was between the trip's temperature and its
low temperature, so some "trip crossed on the way down" events may not
be reported.

To address this issue, introduce trip thresholds equal to either the
temperature of the given trip, or its low temperature, such that if
the trip's threshold is passed by the zone temperature on the way up,
its value will be set to the trip's low temperature and
thermal_notify_tz_trip_up() will be called, and if the trip's threshold
is passed by the zone temperature on the way down, its value will be set
to the trip's temperature (high) and thermal_notify_tz_trip_down() will
be called.  Accordingly, if the threshold is passed on the way up, it
cannot be passed on the way up again until its passed on the way down
and if it is passed on the way down, it cannot be passed on the way down
again until it is passed on the way up which guarantees correct
triggering of trip crossing notifications.

If the last temperature of the zone is invalid, the trip's threshold
will be set depending of the zone's current temperature: If that
temperature is above the trip's temperature, its threshold will be
set to its low temperature or otherwise its threshold will be set to
its (high) temperature.  Because the zone temperature is initially
set to invalid and tz->last_temperature is only updated by
update_temperature(), this is sufficient to set the correct initial
threshold values for all trips.

Link: https://lore.kernel.org/all/20220718145038.1114379-4-daniel.lezcano@linaro.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: Take possible changes of trip point temperature or hysteresis into
          account.

v1 (RFC) -> v2: Add missing description of a new struct thermal_trip field.

---
 drivers/thermal/thermal_core.c |   43 ++++++++++++++++++++++++++++++++++-------
 include/linux/thermal.h        |    2 +
 2 files changed, 38 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -345,22 +345,51 @@ static void handle_critical_trips(struct
 }
 
 static void handle_thermal_trip(struct thermal_zone_device *tz,
-				const struct thermal_trip *trip)
+				struct thermal_trip *trip)
 {
 	if (trip->temperature == THERMAL_TEMP_INVALID)
 		return;
 
-	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
-		if (tz->last_temperature < trip->temperature &&
-		    tz->temperature >= trip->temperature)
+	if (tz->last_temperature == THERMAL_TEMP_INVALID) {
+		/* Initialization. */
+		trip->threshold = trip->temperature;
+		if (tz->temperature >= trip->threshold)
+			trip->threshold -= trip->hysteresis;
+	} else if (tz->last_temperature < trip->threshold) {
+		/*
+		 * The trip threshold is equal to the trip temperature, unless
+		 * the latter has changed in the meantime.  In either case,
+		 * the trip is crossed if the current zone temperature is at
+		 * least equal to its temperature, but otherwise ensure that
+		 * the threshold and the trip temperature will be equal.
+		 */
+		if (tz->temperature >= trip->temperature) {
 			thermal_notify_tz_trip_up(tz->id,
 						  thermal_zone_trip_id(tz, trip),
 						  tz->temperature);
-		if (tz->last_temperature >= trip->temperature &&
-		    tz->temperature < trip->temperature - trip->hysteresis)
+			trip->threshold = trip->temperature - trip->hysteresis;
+		} else {
+			trip->threshold = trip->temperature;
+		}
+	} else {
+		/*
+		 * The previous zone temperature was above or equal to the trip
+		 * threshold, which would be equal to the "low temperature" of
+		 * the trip (its temperature minus its hysteresis), unless the
+		 * trip temperature or hysteresis had changed.  In either case,
+		 * the trip is crossed if the current zone temperature is below
+		 * the low temperature of the trip, but otherwise ensure that
+		 * the trip threshold will be equal to the low temperature of
+		 * the trip.
+		 */
+		if (tz->temperature < trip->temperature - trip->hysteresis) {
 			thermal_notify_tz_trip_down(tz->id,
 						    thermal_zone_trip_id(tz, trip),
 						    tz->temperature);
+			trip->threshold = trip->temperature;
+		} else {
+			trip->threshold = trip->temperature - trip->hysteresis;
+		}
 	}
 
 	if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)
@@ -403,7 +432,7 @@ static void thermal_zone_device_init(str
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
 				  enum thermal_notify_event event)
 {
-	const struct thermal_trip *trip;
+	struct thermal_trip *trip;
 
 	if (atomic_read(&in_suspend))
 		return;
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -57,12 +57,14 @@ enum thermal_notify_event {
  * struct thermal_trip - representation of a point in temperature domain
  * @temperature: temperature value in miliCelsius
  * @hysteresis: relative hysteresis in miliCelsius
+ * @threshold: trip crossing notification threshold miliCelsius
  * @type: trip point type
  * @priv: pointer to driver data associated with this trip
  */
 struct thermal_trip {
 	int temperature;
 	int hysteresis;
+	int threshold;
 	enum thermal_trip_type type;
 	void *priv;
 };



