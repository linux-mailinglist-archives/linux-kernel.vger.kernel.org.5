Return-Path: <linux-kernel+bounces-65213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FA7854995
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7129DB2430A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B737D537F6;
	Wed, 14 Feb 2024 12:50:07 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E5D52F72;
	Wed, 14 Feb 2024 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915007; cv=none; b=k7QGPg0oihQshW5Q8ISbYq2h68jpRHD25AKc1KWJCKHlsgh0azaWwgmrpEn2E1fHB4pNtvMQWlhxFa4gDfVfrSssMMli6H+8Gx7C3PGPBQ7W4nFtd39g1Nlyn0/hCT1fK0DvI5/AOoZDHvnGoDKPzXUNFPFVPVnANOIr2JF2ddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915007; c=relaxed/simple;
	bh=JaHBeuuIG5uZZoaEPSZ2sPa9jXgVOE0rd93vNNIckrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pFuqHO9Iko6r4jhon+5ceY/o7nwX1p1KzZT3bY4IykbdFPB8CFVdixEnTQQkySMeDhWfh5mon5tFbpOS4dLRhWMBmAne7tHYRkkp13wzKrWT5UBmeFrJaUfqS5j3yibjsoLx56m+XJlBtSTRMQ9OCv/TwJ/3+h4HLcksx8o6Py4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 88be413aea02551f; Wed, 14 Feb 2024 13:49:57 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id F0A62669DCB;
	Wed, 14 Feb 2024 13:49:56 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Subject:
 [PATCH v2 2/6] thermal: ACPI: Discard trips table after zone registration
Date: Wed, 14 Feb 2024 13:30:23 +0100
Message-ID: <13457348.uLZWGnKmhe@kreacher>
In-Reply-To: <4551531.LvFx2qVVIh@kreacher>
References: <4551531.LvFx2qVVIh@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because the thermal core creates and uses its own copy of the trips
table passed to thermal_zone_device_register_with_trips(), it is not
necessary to hold on to a local copy of it any more after the given
thermal zone has been registered.

Accordingly, modify the ACPI thermal driver to store the trips table
passed to thermal_zone_device_register_with_trips() in a local variable
which is automatically discarded when acpi_thermal_add() returns to
its caller.

Also make some additional code simplifications unlocked by the above
change.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---

v1 -> v2: Add R-by from Stanislaw.

---
 drivers/acpi/thermal.c |   57 +++++++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 37 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -47,6 +47,8 @@
 
 #define ACPI_THERMAL_TRIP_PASSIVE	(-1)
 
+#define ACPI_THERMAL_MAX_NR_TRIPS	(ACPI_THERMAL_MAX_ACTIVE + 3)
+
 /*
  * This exception is thrown out in two cases:
  * 1.An invalid trip point becomes invalid or a valid trip point becomes invalid
@@ -112,7 +114,6 @@ struct acpi_thermal {
 	unsigned long polling_frequency;
 	volatile u8 zombie;
 	struct acpi_thermal_trips trips;
-	struct thermal_trip *trip_table;
 	struct thermal_zone_device *thermal_zone;
 	int kelvin_offset;	/* in millidegrees */
 	struct work_struct thermal_check_work;
@@ -451,26 +452,19 @@ fail:
 	return false;
 }
 
-static int acpi_thermal_get_trip_points(struct acpi_thermal *tz)
+static void acpi_thermal_get_trip_points(struct acpi_thermal *tz)
 {
-	unsigned int count = 0;
 	int i;
 
-	if (acpi_thermal_init_trip(tz, ACPI_THERMAL_TRIP_PASSIVE))
-		count++;
+	acpi_thermal_init_trip(tz, ACPI_THERMAL_TRIP_PASSIVE);
 
 	for (i = 0; i < ACPI_THERMAL_MAX_ACTIVE; i++) {
-		if (acpi_thermal_init_trip(tz, i))
-			count++;
-		else
+		if (!acpi_thermal_init_trip(tz, i))
 			break;
-
 	}
 
 	while (++i < ACPI_THERMAL_MAX_ACTIVE)
 		tz->trips.active[i].trip.temp_dk = THERMAL_TEMP_INVALID;
-
-	return count;
 }
 
 /* sys I/F for generic thermal sysfs support */
@@ -662,13 +656,14 @@ static void acpi_thermal_zone_sysfs_remo
 }
 
 static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz,
+					      const struct thermal_trip *trip_table,
 					      unsigned int trip_count,
 					      int passive_delay)
 {
 	int result;
 
 	tz->thermal_zone = thermal_zone_device_register_with_trips("acpitz",
-								   tz->trip_table,
+								   trip_table,
 								   trip_count,
 								   tz,
 								   &acpi_thermal_zone_ops,
@@ -823,10 +818,10 @@ static void acpi_thermal_free_thermal_zo
 
 static int acpi_thermal_add(struct acpi_device *device)
 {
+	struct thermal_trip trip_table[ACPI_THERMAL_MAX_NR_TRIPS] = { 0 };
 	struct acpi_thermal_trip *acpi_trip;
 	struct thermal_trip *trip;
 	struct acpi_thermal *tz;
-	unsigned int trip_count;
 	int crit_temp, hot_temp;
 	int passive_delay = 0;
 	int result;
@@ -848,21 +843,10 @@ static int acpi_thermal_add(struct acpi_
 	acpi_thermal_aml_dependency_fix(tz);
 
 	/* Get trip points [_CRT, _PSV, etc.] (required). */
-	trip_count = acpi_thermal_get_trip_points(tz);
+	acpi_thermal_get_trip_points(tz);
 
 	crit_temp = acpi_thermal_get_critical_trip(tz);
-	if (crit_temp != THERMAL_TEMP_INVALID)
-		trip_count++;
-
 	hot_temp = acpi_thermal_get_hot_trip(tz);
-	if (hot_temp != THERMAL_TEMP_INVALID)
-		trip_count++;
-
-	if (!trip_count) {
-		pr_warn(FW_BUG "No valid trip points!\n");
-		result = -ENODEV;
-		goto free_memory;
-	}
 
 	/* Get temperature [_TMP] (required). */
 	result = acpi_thermal_get_temperature(tz);
@@ -881,13 +865,7 @@ static int acpi_thermal_add(struct acpi_
 
 	acpi_thermal_guess_offset(tz, crit_temp);
 
-	trip = kcalloc(trip_count, sizeof(*trip), GFP_KERNEL);
-	if (!trip) {
-		result = -ENOMEM;
-		goto free_memory;
-	}
-
-	tz->trip_table = trip;
+	trip = trip_table;
 
 	if (crit_temp != THERMAL_TEMP_INVALID) {
 		trip->type = THERMAL_TRIP_CRITICAL;
@@ -923,9 +901,17 @@ static int acpi_thermal_add(struct acpi_
 		trip++;
 	}
 
-	result = acpi_thermal_register_thermal_zone(tz, trip_count, passive_delay);
+	if (trip == trip_table) {
+		pr_warn(FW_BUG "No valid trip points!\n");
+		result = -ENODEV;
+		goto free_memory;
+	}
+
+	result = acpi_thermal_register_thermal_zone(tz, trip_table,
+						    trip - trip_table,
+						    passive_delay);
 	if (result)
-		goto free_trips;
+		goto free_memory;
 
 	refcount_set(&tz->thermal_check_count, 3);
 	mutex_init(&tz->thermal_check_lock);
@@ -944,8 +930,6 @@ static int acpi_thermal_add(struct acpi_
 flush_wq:
 	flush_workqueue(acpi_thermal_pm_queue);
 	acpi_thermal_unregister_thermal_zone(tz);
-free_trips:
-	kfree(tz->trip_table);
 free_memory:
 	acpi_thermal_free_thermal_zone(tz);
 
@@ -966,7 +950,6 @@ static void acpi_thermal_remove(struct a
 
 	flush_workqueue(acpi_thermal_pm_queue);
 	acpi_thermal_unregister_thermal_zone(tz);
-	kfree(tz->trip_table);
 	acpi_thermal_free_thermal_zone(tz);
 }
 




