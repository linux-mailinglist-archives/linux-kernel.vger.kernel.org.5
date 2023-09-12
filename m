Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A2D79D916
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbjILSsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbjILSry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:47:54 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23751722;
        Tue, 12 Sep 2023 11:47:45 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id d5ab5436fc065d13; Tue, 12 Sep 2023 20:47:44 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id AAB59663BE5;
        Tue, 12 Sep 2023 20:47:43 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 2/9] ACPI: thermal: Fold acpi_thermal_get_info() into its caller
Date:   Tue, 12 Sep 2023 20:36:21 +0200
Message-ID: <2296248.ElGaqSPkdT@kreacher>
In-Reply-To: <5708760.DvuYhMxLoT@kreacher>
References: <5708760.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrudeiiedgudeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehs
 rhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is only one caller of acpi_thermal_get_info() and the code from
it can be folded into its caller just fine, so do that.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c |   52 +++++++++++++++++--------------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -846,38 +846,6 @@ static void acpi_thermal_aml_dependency_
 	acpi_evaluate_integer(handle, "_TMP", NULL, &value);
 }
 
-static int acpi_thermal_get_info(struct acpi_thermal *tz)
-{
-	int result;
-
-	if (!tz)
-		return -EINVAL;
-
-	acpi_thermal_aml_dependency_fix(tz);
-
-	/* Get trip points [_CRT, _PSV, etc.] (required) */
-	result = acpi_thermal_get_trip_points(tz);
-	if (result)
-		return result;
-
-	/* Get temperature [_TMP] (required) */
-	result = acpi_thermal_get_temperature(tz);
-	if (result)
-		return result;
-
-	/* Set the cooling mode [_SCP] to active cooling (default) */
-	acpi_execute_simple_method(tz->device->handle, "_SCP",
-				   ACPI_THERMAL_MODE_ACTIVE);
-
-	/* Get default polling frequency [_TZP] (optional) */
-	if (tzp)
-		tz->polling_frequency = tzp;
-	else
-		acpi_thermal_get_polling_frequency(tz);
-
-	return 0;
-}
-
 /*
  * The exact offset between Kelvin and degree Celsius is 273.15. However ACPI
  * handles temperature values with a single decimal place. As a consequence,
@@ -940,10 +908,28 @@ static int acpi_thermal_add(struct acpi_
 	strcpy(acpi_device_class(device), ACPI_THERMAL_CLASS);
 	device->driver_data = tz;
 
-	result = acpi_thermal_get_info(tz);
+	acpi_thermal_aml_dependency_fix(tz);
+
+	/* Get trip points [_CRT, _PSV, etc.] (required). */
+	result = acpi_thermal_get_trip_points(tz);
 	if (result)
 		goto free_memory;
 
+	/* Get temperature [_TMP] (required). */
+	result = acpi_thermal_get_temperature(tz);
+	if (result)
+		goto free_memory;
+
+	/* Set the cooling mode [_SCP] to active cooling. */
+	acpi_execute_simple_method(tz->device->handle, "_SCP",
+				   ACPI_THERMAL_MODE_ACTIVE);
+
+	/* Determine the default polling frequency [_TZP]. */
+	if (tzp)
+		tz->polling_frequency = tzp;
+	else
+		acpi_thermal_get_polling_frequency(tz);
+
 	acpi_thermal_guess_offset(tz);
 
 	result = acpi_thermal_register_thermal_zone(tz);



