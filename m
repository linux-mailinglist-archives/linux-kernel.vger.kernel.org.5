Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9129788D13
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 18:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbjHYQQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 12:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245225AbjHYQQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 12:16:56 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DDC1BD2;
        Fri, 25 Aug 2023 09:16:54 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 8ad44d5f7b6bf935; Fri, 25 Aug 2023 18:16:52 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id AED3D662F61;
        Fri, 25 Aug 2023 18:16:51 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>
Subject: [PATCH v1] thermal: core: Drop unused .get_trip_*() callbacks
Date:   Fri, 25 Aug 2023 18:16:51 +0200
Message-ID: <12270283.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedruddvkedgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthht
 oheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
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

After recent changes in the ACPI thermal driver and in the Intel DTS
IOSF thermal driver, all thermal zone drivers are expected to use trip
tables for initialization and none of them should implement
.get_trip_type(), .get_trip_temp() or .get_trip_hyst() callbacks, so
drop these callbacks entirely from the core.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |    2 +-
 drivers/thermal/thermal_trip.c |   22 +++-------------------
 include/linux/thermal.h        |    4 ----
 3 files changed, 4 insertions(+), 24 deletions(-)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -76,11 +76,7 @@ struct thermal_zone_device_ops {
 	int (*set_trips) (struct thermal_zone_device *, int, int);
 	int (*change_mode) (struct thermal_zone_device *,
 		enum thermal_device_mode);
-	int (*get_trip_type) (struct thermal_zone_device *, int,
-		enum thermal_trip_type *);
-	int (*get_trip_temp) (struct thermal_zone_device *, int, int *);
 	int (*set_trip_temp) (struct thermal_zone_device *, int, int);
-	int (*get_trip_hyst) (struct thermal_zone_device *, int, int *);
 	int (*set_trip_hyst) (struct thermal_zone_device *, int, int);
 	int (*get_crit_temp) (struct thermal_zone_device *, int *);
 	int (*set_emul_temp) (struct thermal_zone_device *, int);
Index: linux-pm/drivers/thermal/thermal_trip.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_trip.c
+++ linux-pm/drivers/thermal/thermal_trip.c
@@ -118,27 +118,11 @@ int __thermal_zone_get_trip(struct therm
 {
 	int ret;
 
-	if (!tz || trip_id < 0 || trip_id >= tz->num_trips || !trip)
+	if (!tz || !tz->trips || trip_id < 0 || trip_id >= tz->num_trips || !trip)
 		return -EINVAL;
 
-	if (tz->trips) {
-		*trip = tz->trips[trip_id];
-		return 0;
-	}
-
-	if (tz->ops->get_trip_hyst) {
-		ret = tz->ops->get_trip_hyst(tz, trip_id, &trip->hysteresis);
-		if (ret)
-			return ret;
-	} else {
-		trip->hysteresis = 0;
-	}
-
-	ret = tz->ops->get_trip_temp(tz, trip_id, &trip->temperature);
-	if (ret)
-		return ret;
-
-	return tz->ops->get_trip_type(tz, trip_id, &trip->type);
+	*trip = tz->trips[trip_id];
+	return 0;
 }
 EXPORT_SYMBOL_GPL(__thermal_zone_get_trip);
 
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1266,7 +1266,7 @@ thermal_zone_device_register_with_trips(
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp) && !trips)
+	if (num_trips > 0 && !trips)
 		return ERR_PTR(-EINVAL);
 
 	if (!thermal_class)



