Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3F3761842
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjGYMZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjGYMZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:25:32 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66976172A;
        Tue, 25 Jul 2023 05:25:31 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 3810275855d39208; Tue, 25 Jul 2023 14:25:29 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 5404B661B0E;
        Tue, 25 Jul 2023 14:25:29 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v3 5/8] ACPI: thermal: Hold thermal zone lock around trip updates
Date:   Tue, 25 Jul 2023 14:16:33 +0200
Message-ID: <7552439.EvYhyI6sBW@kreacher>
In-Reply-To: <12254967.O9o76ZdvQC@kreacher>
References: <13318886.uLZWGnKmhe@kreacher> <12254967.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedriedtgdehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrghlrdifihhltgiihihnshhkihesihhnthgvlhdrtghomhdprhgt
 phhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

To address this, make acpi_thermal_trips_update() hold the thermal zone
lock across the entire update of trip points.

While at it, change the acpi_thermal_trips_update() return data type
to void as that function always returns 0 anyway.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: No changes.

v1 -> v2:
   * Hold the thermal zone lock instead of thermal_check_lock around trip
     point updates (this also helps to protect thermal_get_trend() from using
     stale trip temperatures).
   * Add a comment documenting the purpose of the locking.
   * Make acpi_thermal_trips_update() void.

---
 drivers/acpi/thermal.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

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
@@ -398,17 +398,28 @@ static int acpi_thermal_trips_update(str
 			ACPI_THERMAL_TRIPS_EXCEPTION(flag, tz, "device");
 		}
 	}
+}
 
-	return 0;
+static void acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
+{
+	/*
+	 * The locking is needed here to protect thermal_get_trend() from using
+	 * a stale passive trip temperature and to synchronize with the trip
+	 * temperature updates in acpi_thermal_check_fn().
+	 */
+	thermal_zone_device_lock(tz->thermal_zone);
+
+	__acpi_thermal_trips_update(tz, flag);
+
+	thermal_zone_device_unlock(tz->thermal_zone);
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



