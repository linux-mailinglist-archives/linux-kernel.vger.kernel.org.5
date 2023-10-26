Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A39A7D8907
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjJZThW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZThU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:37:20 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F68F10E;
        Thu, 26 Oct 2023 12:37:16 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 896e23edd624b7a2; Thu, 26 Oct 2023 21:37:14 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id D30D6667401;
        Thu, 26 Oct 2023 21:37:13 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [RFC][PATCH v1] thermal: core: Add trip thresholds for trip crossing detection
Date:   Thu, 26 Oct 2023 21:37:13 +0200
Message-ID: <12326345.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrledvgddufeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghl
 rdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

On top of current linux-next.

---
 drivers/thermal/thermal_core.c |   21 ++++++++++++++-------
 include/linux/thermal.h        |    1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -345,22 +345,29 @@ static void handle_critical_trips(struct
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
+		trip->threshold = trip->temperature;
+		if (tz->temperature >= trip->temperature)
+			trip->threshold -= trip->hysteresis;
+	} else {
+		if (tz->last_temperature < trip->threshold &&
+		    tz->temperature >= trip->threshold) {
 			thermal_notify_tz_trip_up(tz->id,
 						  thermal_zone_trip_id(tz, trip),
 						  tz->temperature);
-		if (tz->last_temperature >= trip->temperature &&
-		    tz->temperature < trip->temperature - trip->hysteresis)
+			trip->threshold = trip->temperature - trip->hysteresis;
+		} else if (tz->last_temperature >= trip->threshold &&
+			   tz->temperature < trip->threshold) {
 			thermal_notify_tz_trip_down(tz->id,
 						    thermal_zone_trip_id(tz, trip),
 						    tz->temperature);
+			trip->threshold = trip->temperature;
+		}
 	}
 
 	if (trip->type == THERMAL_TRIP_CRITICAL || trip->type == THERMAL_TRIP_HOT)
@@ -403,7 +410,7 @@ static void thermal_zone_device_init(str
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
@@ -63,6 +63,7 @@ enum thermal_notify_event {
 struct thermal_trip {
 	int temperature;
 	int hysteresis;
+	int threshold;
 	enum thermal_trip_type type;
 	void *priv;
 };



