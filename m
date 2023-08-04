Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB15B770ADA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjHDV0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjHDV0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:26:10 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EC8B1;
        Fri,  4 Aug 2023 14:26:08 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 6d6d931799418004; Fri, 4 Aug 2023 23:26:07 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id F0C4C661680;
        Fri,  4 Aug 2023 23:26:06 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v4 06/10] ACPI: thermal: Carry out trip point updates under zone lock
Date:   Fri, 04 Aug 2023 23:13:08 +0200
Message-ID: <3205670.5fSG56mABF@kreacher>
In-Reply-To: <4878513.31r3eYUQgx@kreacher>
References: <13318886.uLZWGnKmhe@kreacher> <4878513.31r3eYUQgx@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggdduheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
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

There is a race condition between acpi_thermal_trips_update() and
acpi_thermal_check_fn(), because the trip points may get updated while
the latter is running which in theory may lead to inconsistent results.
For example, if two trips are updated together, using the temperature
value of one of them from before the update and the temperature value
of the other one from after the update may not lead to the expected
outcome.

Moreover, if thermal_get_trend() runs when a trip points update is in
progress, it may end up using stale trip point temperatures.

To address this, make acpi_thermal_trips_update() call
thermal_zone_device_adjust() to carry out the trip points update and
provide a new  acpi_thermal_adjust_thermal_zone() wrapper around
__acpi_thermal_trips_update() as the callback function for the latter.

While at it, change the acpi_thermal_trips_update() return data type
to void as that function always returns 0 anyway.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4:
   * Rework to use thermal_zone_device_adjust() and the .update() callback
     instead of using the (exported) zone lock directly.
   * Call acpi_queue_thermal_check() from acpi_thermal_trips_update() which
     allows code duplication in acpi_thermal_notify() to be reduced.

v2 -> v3: No changes.

v1 -> v2:
   * Hold the thermal zone lock instead of thermal_check_lock around trip
     point updates (this also helps to protect thermal_get_trend() from using
     stale trip temperatures).
   * Add a comment documenting the purpose of the locking.
   * Make acpi_thermal_trips_update() void.

---
 drivers/acpi/thermal.c |   41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -190,7 +190,7 @@ static int acpi_thermal_get_polling_freq
 	return 0;
 }
 
-static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
+static void __acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
 {
 	acpi_status status;
 	unsigned long long tmp;
@@ -398,17 +398,39 @@ static int acpi_thermal_trips_update(str
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 		}
 	}
+}
 
-	return 0;
+static void acpi_thermal_adjust_thermal_zone(struct thermal_zone_device *thermal,
+					     unsigned long data)
+{
+	__acpi_thermal_trips_update(thermal_zone_device_priv(thermal), data);
+}
+
+static void acpi_queue_thermal_check(struct acpi_thermal *tz)
+{
+	if (!work_pending(&tz->thermal_check_work))
+		queue_work(acpi_thermal_pm_queue, &tz->thermal_check_work);
+}
+
+static void acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
+{
+	/*
+	 * Use thermal_zone_device_adjust() to carry out the trip points
+	 * update, so as to protect thermal_get_trend() from getting stale
+	 * trip point temperatures and to prevent thermal_zone_device_update()
+	 * invoked from acpi_thermal_check_fn() from producing inconsistent
+	 * results.
+	 */
+	thermal_zone_device_adjust(tz->thermal_zone, flag);
+	acpi_queue_thermal_check(tz);
 }
 
 static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 {
-	int i, ret = acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
 	bool valid;
+	int i;
 
-	if (ret)
-		return ret;
+	__acpi_thermal_trips_update(tz, ACPI_TRIPS_INIT);
 
 	valid = tz->trips.critical.valid |
 		tz->trips.hot.valid |
@@ -715,6 +737,7 @@ static struct thermal_zone_device_ops ac
 	.get_trend = thermal_get_trend,
 	.hot = acpi_thermal_zone_device_hot,
 	.critical = acpi_thermal_zone_device_critical,
+	.update = acpi_thermal_adjust_thermal_zone,
 };
 
 static int acpi_thermal_zone_sysfs_add(struct acpi_thermal *tz)
@@ -815,12 +838,6 @@ static void acpi_thermal_unregister_ther
                                  Driver Interface
    -------------------------------------------------------------------------- */
 
-static void acpi_queue_thermal_check(struct acpi_thermal *tz)
-{
-	if (!work_pending(&tz->thermal_check_work))
-		queue_work(acpi_thermal_pm_queue, &tz->thermal_check_work);
-}
-
 static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_device *device = data;
@@ -835,13 +852,11 @@ static void acpi_thermal_notify(acpi_han
 		break;
 	case ACPI_THERMAL_NOTIFY_THRESHOLDS:
 		acpi_thermal_trips_update(tz, ACPI_TRIPS_THRESHOLDS);
-		acpi_queue_thermal_check(tz);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						dev_name(&device->dev), event, 0);
 		break;
 	case ACPI_THERMAL_NOTIFY_DEVICES:
 		acpi_thermal_trips_update(tz, ACPI_TRIPS_DEVICES);
-		acpi_queue_thermal_check(tz);
 		acpi_bus_generate_netlink_event(device->pnp.device_class,
 						dev_name(&device->dev), event, 0);
 		break;



