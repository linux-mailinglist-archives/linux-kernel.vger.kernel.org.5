Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2E5784000
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbjHVLtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjHVLtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:49:11 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE468E7B;
        Tue, 22 Aug 2023 04:48:49 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 09be78d781e11d50; Tue, 22 Aug 2023 13:40:06 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 06EF4662D25;
        Tue, 22 Aug 2023 13:40:06 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH v1] thermal: core: Rework .get_trend() thermal zone callback
Date:   Tue, 22 Aug 2023 13:40:06 +0200
Message-ID: <4511659.LvFx2qVVIh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedruddvuddggedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthht
 oheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Passing a struct thermal_trip pointer instead of a trip index to the
.get_trend() thermal zone callback allows one of its 2 implementations,
the thermal_get_trend() function in the ACPI thermal driver, to be
simplified quite a bit, and the other implementation of it in the
ti-soc-thermal driver does not even use the relevant callback argument.

For this reason, change the .get_trend() thermal zone callback
definition and adjust the related code accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is based on the thermal branch in linux-pm.git (which is also
included in the linux-next branch of that tree).

---
 drivers/acpi/thermal.c                             |   41 +++++++++------------
 drivers/thermal/thermal_core.h                     |    2 -
 drivers/thermal/thermal_helpers.c                  |    3 +
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |    3 +
 include/linux/thermal.h                            |   30 +++++++--------
 5 files changed, 38 insertions(+), 41 deletions(-)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -53,6 +53,20 @@ enum thermal_notify_event {
 	THERMAL_EVENT_KEEP_ALIVE, /* Request for user space handler to respond */
 };
 
+/**
+ * struct thermal_trip - representation of a point in temperature domain
+ * @temperature: temperature value in miliCelsius
+ * @hysteresis: relative hysteresis in miliCelsius
+ * @type: trip point type
+ * @priv: pointer to driver data associated with this trip
+ */
+struct thermal_trip {
+	int temperature;
+	int hysteresis;
+	enum thermal_trip_type type;
+	void *priv;
+};
+
 struct thermal_zone_device_ops {
 	int (*bind) (struct thermal_zone_device *,
 		     struct thermal_cooling_device *);
@@ -70,26 +84,12 @@ struct thermal_zone_device_ops {
 	int (*set_trip_hyst) (struct thermal_zone_device *, int, int);
 	int (*get_crit_temp) (struct thermal_zone_device *, int *);
 	int (*set_emul_temp) (struct thermal_zone_device *, int);
-	int (*get_trend) (struct thermal_zone_device *, int,
+	int (*get_trend) (struct thermal_zone_device *, struct thermal_trip *,
 			  enum thermal_trend *);
 	void (*hot)(struct thermal_zone_device *);
 	void (*critical)(struct thermal_zone_device *);
 };
 
-/**
- * struct thermal_trip - representation of a point in temperature domain
- * @temperature: temperature value in miliCelsius
- * @hysteresis: relative hysteresis in miliCelsius
- * @type: trip point type
- * @priv: pointer to driver data associated with this trip
- */
-struct thermal_trip {
-	int temperature;
-	int hysteresis;
-	enum thermal_trip_type type;
-	void *priv;
-};
-
 struct thermal_cooling_device_ops {
 	int (*get_max_state) (struct thermal_cooling_device *, unsigned long *);
 	int (*get_cur_state) (struct thermal_cooling_device *, unsigned long *);
Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -492,26 +492,22 @@ static int thermal_get_temp(struct therm
 }
 
 static int thermal_get_trend(struct thermal_zone_device *thermal,
-			     int trip_index, enum thermal_trend *trend)
+			     struct thermal_trip *trip,
+			     enum thermal_trend *trend)
 {
 	struct acpi_thermal *tz = thermal_zone_device_priv(thermal);
 	struct acpi_thermal_trip *acpi_trip;
-	int t, i;
+	int t;
 
-	if (!tz || trip_index < 0)
+	if (!tz || !trip)
 		return -EINVAL;
 
-	if (tz->trips.critical.valid)
-		trip_index--;
-
-	if (tz->trips.hot.valid)
-		trip_index--;
-
-	if (trip_index < 0)
+	acpi_trip = trip->priv;
+	if (!acpi_trip || !acpi_trip->valid)
 		return -EINVAL;
 
-	acpi_trip = &tz->trips.passive.trip;
-	if (acpi_trip->valid && !trip_index--) {
+	switch (trip->type) {
+	case THERMAL_TRIP_PASSIVE:
 		t = tz->trips.passive.tc1 * (tz->temperature -
 						tz->last_temperature) +
 			tz->trips.passive.tc2 * (tz->temperature -
@@ -524,19 +520,18 @@ static int thermal_get_trend(struct ther
 			*trend = THERMAL_TREND_STABLE;
 
 		return 0;
-	}
-
-	t = acpi_thermal_temp(tz, tz->temperature);
 
-	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		acpi_trip = &tz->trips.active[i].trip;
-		if (acpi_trip->valid && !trip_index--) {
-			if (t > acpi_thermal_temp(tz, acpi_trip->temperature)) {
-				*trend = THERMAL_TREND_RAISING;
-				return 0;
-			}
+	case THERMAL_TRIP_ACTIVE:
+		t = acpi_thermal_temp(tz, tz->temperature);
+		if (t <= trip->temperature)
 			break;
-		}
+
+		*trend = THERMAL_TREND_RAISING;
+
+		return 0;
+
+	default:
+		break;
 	}
 
 	return -EINVAL;
Index: linux-pm/drivers/thermal/thermal_core.h
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.h
+++ linux-pm/drivers/thermal/thermal_core.h
@@ -70,7 +70,7 @@ static inline bool cdev_is_power_actor(s
 void thermal_cdev_update(struct thermal_cooling_device *);
 void __thermal_cdev_update(struct thermal_cooling_device *cdev);
 
-int get_tz_trend(struct thermal_zone_device *tz, int trip);
+int get_tz_trend(struct thermal_zone_device *tz, int trip_index);
 
 struct thermal_instance *
 get_thermal_instance(struct thermal_zone_device *tz,
Index: linux-pm/drivers/thermal/thermal_helpers.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_helpers.c
+++ linux-pm/drivers/thermal/thermal_helpers.c
@@ -22,8 +22,9 @@
 #include "thermal_core.h"
 #include "thermal_trace.h"
 
-int get_tz_trend(struct thermal_zone_device *tz, int trip)
+int get_tz_trend(struct thermal_zone_device *tz, int trip_index)
 {
+	struct thermal_trip *trip = tz->trips ? &tz->trips[trip_index] : NULL;
 	enum thermal_trend trend;
 
 	if (tz->emul_temperature || !tz->ops->get_trend ||
Index: linux-pm/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
===================================================================
--- linux-pm.orig/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
+++ linux-pm/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
@@ -109,7 +109,8 @@ static inline int __ti_thermal_get_temp(
 	return ret;
 }
 
-static int __ti_thermal_get_trend(struct thermal_zone_device *tz, int trip, enum thermal_trend *trend)
+static int __ti_thermal_get_trend(struct thermal_zone_device *tz,
+				  struct thermal_trip *trip, enum thermal_trend *trend)
 {
 	struct ti_thermal_data *data = thermal_zone_device_priv(tz);
 	struct ti_bandgap *bgp;



