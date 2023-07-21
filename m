Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3975C90F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbjGUOHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjGUOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:07:27 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA58273F;
        Fri, 21 Jul 2023 07:07:24 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 3dc22f17bb37cb2b; Fri, 21 Jul 2023 16:07:22 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 3E98A6618EA;
        Fri, 21 Jul 2023 16:07:22 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2 1/8] thermal: core: Add mechanism for connecting trips with driver data
Date:   Fri, 21 Jul 2023 14:46:38 +0200
Message-ID: <4862397.31r3eYUQgx@kreacher>
In-Reply-To: <5710197.DvuYhMxLoT@kreacher>
References: <13318886.uLZWGnKmhe@kreacher> <5710197.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdeikecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgt
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

Some drivers need to update trip point data (temperature and/or
hysteresis) upon notifications from the platform firmware or they
may need to reprogram hardware when trip point parameters are changed
via sysfs.  For those purposes, they need to connect struct thermal_trip
to a private data set associated with the trip or the other way around
and using a trip point index for that may not always work, because the
core may need to reorder the trips during thermal zone registration (in
particular, they may need to be sorted).

To allow that to be done without using a trip point index, introduce
a new field in struct thermal_trip that can be pointed by the driver
to its own data structure containing a trip pointer to be initialized
by the core during thermal zone registration.  That pointer will then
have to be updated by the core every time the location of the given
trip point object in memory changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes.

---
 drivers/thermal/thermal_core.c |   20 +++++++++++++++++---
 include/linux/thermal.h        |   13 +++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -76,16 +76,29 @@ struct thermal_zone_device_ops {
 	void (*critical)(struct thermal_zone_device *);
 };
 
+struct thermal_trip_ref {
+	struct thermal_trip *trip;
+};
+
 /**
  * struct thermal_trip - representation of a point in temperature domain
  * @temperature: temperature value in miliCelsius
  * @hysteresis: relative hysteresis in miliCelsius
  * @type: trip point type
+ * @driver_ref: driver's reference to this trip point
+ *
+ * If @driver_ref is not NULL, the trip pointer in the object pointed to by it
+ * will be initialized by the core during thermal zone registration and updated
+ * whenever the location of the given trip object changes.  This allows the
+ * driver to access the trip point data without knowing the relative ordering
+ * of trips within the trip table used by the core and, given a trip pointer,
+ * to get back to its private data associated with the given trip.
  */
 struct thermal_trip {
 	int temperature;
 	int hysteresis;
 	enum thermal_trip_type type;
+	struct thermal_trip_ref *driver_ref;
 };
 
 struct thermal_cooling_device_ops {
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1306,14 +1306,28 @@ thermal_zone_device_register_with_trips(
 	if (result)
 		goto release_device;
 
+	mutex_lock(&tz->lock);
+
 	for (count = 0; count < num_trips; count++) {
-		struct thermal_trip trip;
+		int temperature = 0;
+
+		if (trips) {
+			temperature = trips[count].temperature;
+			if (trips[count].driver_ref)
+				trips[count].driver_ref->trip = &trips[count];
+		} else {
+			struct thermal_trip trip;
 
-		result = thermal_zone_get_trip(tz, count, &trip);
-		if (result || !trip.temperature)
+			result = __thermal_zone_get_trip(tz, count, &trip);
+			if (!result)
+				temperature = trip.temperature;
+		}
+		if (!temperature)
 			set_bit(count, &tz->trips_disabled);
 	}
 
+	mutex_unlock(&tz->lock);
+
 	/* Update 'this' zone's governor information */
 	mutex_lock(&thermal_governor_lock);
 



