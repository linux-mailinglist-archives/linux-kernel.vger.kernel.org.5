Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68E97AA1C9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjIUVGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbjIUVFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:05:20 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2A1AF69F;
        Thu, 21 Sep 2023 11:07:23 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 36cbd7be29a8bf2c; Thu, 21 Sep 2023 20:07:22 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id D268B664EBE;
        Thu, 21 Sep 2023 20:07:21 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 12/13] ACPI: thermal: Drop critical_valid and hot_valid trip flags
Date:   Thu, 21 Sep 2023 20:04:49 +0200
Message-ID: <2375603.NG923GbCHz@kreacher>
In-Reply-To: <1957441.PYKUYFuaPT@kreacher>
References: <1957441.PYKUYFuaPT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeekpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhn
 thgvlhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
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

The critical_valid and hot_valid flags in struct acpi_thermal_trips are
only used during initialization and they are only false if the
corresponding trip temperatures are equal to THERMAL_TEMP_INVALID, so
drop them and use THERMAL_TEMP_INVALID checks instead of them where
applicable.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -100,8 +100,6 @@ struct acpi_thermal_active {
 struct acpi_thermal_trips {
 	struct acpi_thermal_passive passive;
 	struct acpi_thermal_active active[ACPI_THERMAL_MAX_ACTIVE];
-	bool critical_valid;
-	bool hot_valid;
 };
 
 struct acpi_thermal {
@@ -355,13 +353,13 @@ static long acpi_thermal_get_critical_tr
 	}
 	if (crt == -1) {
 		acpi_handle_debug(tz->device->handle, "Critical threshold disabled\n");
-		goto fail;
+		return THERMAL_TEMP_INVALID;
 	}
 
 	status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
 	if (ACPI_FAILURE(status)) {
 		acpi_handle_debug(tz->device->handle, "No critical threshold\n");
-		goto fail;
+		return THERMAL_TEMP_INVALID;
 	}
 	if (tmp <= 2732) {
 		/*
@@ -369,17 +367,12 @@ static long acpi_thermal_get_critical_tr
 		 * so discard them as invalid.
 		 */
 		pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
-		goto fail;
+		return THERMAL_TEMP_INVALID;
 	}
 
 set:
-	tz->trips.critical_valid = true;
 	acpi_handle_debug(tz->device->handle, "Critical threshold [%llu]\n", tmp);
 	return tmp;
-
-fail:
-	tz->trips.critical_valid = false;
-	return THERMAL_TEMP_INVALID;
 }
 
 static long acpi_thermal_get_hot_trip(struct acpi_thermal *tz)
@@ -389,12 +382,10 @@ static long acpi_thermal_get_hot_trip(st
 
 	status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &tmp);
 	if (ACPI_FAILURE(status)) {
-		tz->trips.hot_valid = false;
 		acpi_handle_debug(tz->device->handle, "No hot threshold\n");
 		return THERMAL_TEMP_INVALID;
 	}
 
-	tz->trips.hot_valid = true;
 	acpi_handle_debug(tz->device->handle, "Hot threshold [%llu]\n", tmp);
 	return tmp;
 }
@@ -789,7 +780,7 @@ static void acpi_thermal_aml_dependency_
  */
 static void acpi_thermal_guess_offset(struct acpi_thermal *tz, long crit_temp)
 {
-	if (tz->trips.critical_valid && crit_temp % 5 == 1)
+	if (crit_temp != THERMAL_TEMP_INVALID && crit_temp % 5 == 1)
 		tz->kelvin_offset = 273100;
 	else
 		tz->kelvin_offset = 273200;
@@ -850,11 +841,11 @@ static int acpi_thermal_add(struct acpi_
 	trip_count = acpi_thermal_get_trip_points(tz);
 
 	crit_temp = acpi_thermal_get_critical_trip(tz);
-	if (tz->trips.critical_valid)
+	if (crit_temp != THERMAL_TEMP_INVALID)
 		trip_count++;
 
 	hot_temp = acpi_thermal_get_hot_trip(tz);
-	if (tz->trips.hot_valid)
+	if (hot_temp != THERMAL_TEMP_INVALID)
 		trip_count++;
 
 	if (!trip_count) {
@@ -886,13 +877,13 @@ static int acpi_thermal_add(struct acpi_
 
 	tz->trip_table = trip;
 
-	if (tz->trips.critical_valid) {
+	if (crit_temp != THERMAL_TEMP_INVALID) {
 		trip->type = THERMAL_TRIP_CRITICAL;
 		trip->temperature = acpi_thermal_temp(tz, crit_temp);
 		trip++;
 	}
 
-	if (tz->trips.hot_valid) {
+	if (hot_temp != THERMAL_TEMP_INVALID) {
 		trip->type = THERMAL_TRIP_HOT;
 		trip->temperature = acpi_thermal_temp(tz, hot_temp);
 		trip++;



