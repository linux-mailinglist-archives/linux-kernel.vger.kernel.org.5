Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022F57A6AF1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjISSyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjISSys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:54:48 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C6C9;
        Tue, 19 Sep 2023 11:54:41 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id a2509b7e76b7d4b3; Tue, 19 Sep 2023 20:54:38 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id F1CD06646D4;
        Tue, 19 Sep 2023 20:54:37 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH v1] thermal: core: Drop trips_disabled bitmask
Date:   Tue, 19 Sep 2023 20:54:37 +0200
Message-ID: <12296181.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudekuddguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeffffffkefgheehffelteeiveeffeevhfelteejvddvieejjeelvdeiheeuveeuffenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhr
 tghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehiughoshgthhesnhhvihguihgrrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After recent changes, thermal_zone_get_trip() cannot fail, as invoked
from thermal_zone_device_register_with_trips(), so the only role of
the trips_disabled bitmask is struct thermal_zone_device is to make
handle_thermal_trip() skip trip points whose temperature was initially
zero.  However, since the unit of temperature in the thermal core is
millicelsius, zero may very well be a valid temperature value at least
in some usage scenarios and the trip temperature may as well change
later.  Thus there is no reason to permanently disable trip points
with initial temperature equal to zero.

Accordingly, drop the trips_disabled bitmask along with the code
related to it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   13 -------------
 include/linux/thermal.h        |    2 --
 2 files changed, 15 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -347,10 +347,6 @@ static void handle_thermal_trip(struct t
 {
 	struct thermal_trip trip;
 
-	/* Ignore disabled trip points */
-	if (test_bit(trip_id, &tz->trips_disabled))
-		return;
-
 	__thermal_zone_get_trip(tz, trip_id, &trip);
 
 	if (trip.temperature == THERMAL_TEMP_INVALID)
@@ -1231,7 +1227,6 @@ thermal_zone_device_register_with_trips(
 	struct thermal_zone_device *tz;
 	int id;
 	int result;
-	int count;
 	struct thermal_governor *governor;
 
 	if (!type || strlen(type) == 0) {
@@ -1328,14 +1323,6 @@ thermal_zone_device_register_with_trips(
 	if (result)
 		goto release_device;
 
-	for (count = 0; count < num_trips; count++) {
-		struct thermal_trip trip;
-
-		result = thermal_zone_get_trip(tz, count, &trip);
-		if (result || !trip.temperature)
-			set_bit(count, &tz->trips_disabled);
-	}
-
 	/* Update 'this' zone's governor information */
 	mutex_lock(&thermal_governor_lock);
 
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -122,7 +122,6 @@ struct thermal_cooling_device {
  * @devdata:	private pointer for device private data
  * @trips:	an array of struct thermal_trip
  * @num_trips:	number of trip points the thermal zone supports
- * @trips_disabled;	bitmap for disabled trips
  * @passive_delay_jiffies: number of jiffies to wait between polls when
  *			performing passive cooling.
  * @polling_delay_jiffies: number of jiffies to wait between polls when
@@ -163,7 +162,6 @@ struct thermal_zone_device {
 	void *devdata;
 	struct thermal_trip *trips;
 	int num_trips;
-	unsigned long trips_disabled;	/* bitmap for disabled trips */
 	unsigned long passive_delay_jiffies;
 	unsigned long polling_delay_jiffies;
 	int temperature;



