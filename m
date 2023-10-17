Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD80C7CCDA2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjJQUMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJQUMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:12:47 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E4D6FAC;
        Tue, 17 Oct 2023 13:12:44 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 5ff2401e82b762db; Tue, 17 Oct 2023 22:12:43 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 72FA9666BCD;
        Tue, 17 Oct 2023 22:12:42 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 3/3] ACPI: thermal: Use library functions to obtain trip point temperature values
Date:   Tue, 17 Oct 2023 22:12:33 +0200
Message-ID: <2926905.e9J7NaK4W3@kreacher>
In-Reply-To: <5740803.DvuYhMxLoT@kreacher>
References: <5740803.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddugeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify the ACPI thermal driver to use functions from the ACPI thermal
library to obtain trip point temperature values instead of duplicating
them locally.

Among other things, this requires the functions in question to be
exported to it, because it can be built as a module.

It effectively changes the behavior of the driver to treat temperature
values out of the reasonable range (-55 centigrade to 175 centigrade) as
invalid, but there is no other expected functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/internal.h    |    5 +++
 drivers/acpi/thermal.c     |   57 +++++++++++++++++++--------------------------
 drivers/acpi/thermal_lib.c |    4 +++
 3 files changed, 34 insertions(+), 32 deletions(-)

Index: linux-pm/drivers/acpi/thermal_lib.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal_lib.c
+++ linux-pm/drivers/acpi/thermal_lib.c
@@ -52,21 +52,25 @@ int acpi_active_trip_temp(struct acpi_de
 
 	return acpi_trip_temp(adev, obj_name, ret_temp);
 }
+EXPORT_SYMBOL_NS_GPL(acpi_active_trip_temp, ACPI_THERMAL);
 
 int acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
 {
 	return acpi_trip_temp(adev, "_PSV", ret_temp);
 }
+EXPORT_SYMBOL_NS_GPL(acpi_passive_trip_temp, ACPI_THERMAL);
 
 int acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
 {
 	return acpi_trip_temp(adev, "_HOT", ret_temp);
 }
+EXPORT_SYMBOL_NS_GPL(acpi_hot_trip_temp, ACPI_THERMAL);
 
 int acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
 {
 	return acpi_trip_temp(adev, "_CRT", ret_temp);
 }
+EXPORT_SYMBOL_NS_GPL(acpi_critical_trip_temp, ACPI_THERMAL);
 
 static int thermal_temp(int error, int temp_decik, int *ret_temp)
 {
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -85,6 +85,11 @@ bool acpi_scan_is_offline(struct acpi_de
 acpi_status acpi_sysfs_table_handler(u32 event, void *table, void *context);
 void acpi_scan_table_notify(void);
 
+int acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp);
+int acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp);
+int acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp);
+int acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
+
 /* --------------------------------------------------------------------------
                      Device Node Initialization / Removal
    -------------------------------------------------------------------------- */
Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -31,6 +31,8 @@
 #include <linux/uaccess.h>
 #include <linux/units.h>
 
+#include "internal.h"
+
 #define ACPI_THERMAL_CLASS		"thermal_zone"
 #define ACPI_THERMAL_DEVICE_NAME	"Thermal Zone"
 #define ACPI_THERMAL_NOTIFY_TEMPERATURE	0x80
@@ -188,24 +190,19 @@ static int active_trip_index(struct acpi
 
 static long get_passive_temp(struct acpi_thermal *tz)
 {
-	unsigned long long tmp;
-	acpi_status status;
+	int temp;
 
-	status = acpi_evaluate_integer(tz->device->handle, "_PSV", NULL, &tmp);
-	if (ACPI_FAILURE(status))
+	if (acpi_passive_trip_temp(tz->device, &temp))
 		return THERMAL_TEMP_INVALID;
 
-	return tmp;
+	return temp;
 }
 
 static long get_active_temp(struct acpi_thermal *tz, int index)
 {
-	char method[] = { '_', 'A', 'C', '0' + index, '\0' };
-	unsigned long long tmp;
-	acpi_status status;
+	int temp;
 
-	status = acpi_evaluate_integer(tz->device->handle, method, NULL, &tmp);
-	if (ACPI_FAILURE(status))
+	if (acpi_active_trip_temp(tz->device, index, &temp))
 		return THERMAL_TEMP_INVALID;
 
 	/*
@@ -215,10 +212,10 @@ static long get_active_temp(struct acpi_
 	if (act > 0) {
 		unsigned long long override = celsius_to_deci_kelvin(act);
 
-		if (tmp > override)
-			tmp = override;
+		if (temp > override)
+			return override;
 	}
-	return tmp;
+	return temp;
 }
 
 static void acpi_thermal_update_trip(struct acpi_thermal *tz,
@@ -339,13 +336,12 @@ static void acpi_thermal_trips_update(st
 					dev_name(&adev->dev), event, 0);
 }
 
-static long acpi_thermal_get_critical_trip(struct acpi_thermal *tz)
+static int acpi_thermal_get_critical_trip(struct acpi_thermal *tz)
 {
-	unsigned long long tmp;
-	acpi_status status;
+	int temp;
 
 	if (crt > 0) {
-		tmp = celsius_to_deci_kelvin(crt);
+		temp = celsius_to_deci_kelvin(crt);
 		goto set;
 	}
 	if (crt == -1) {
@@ -353,38 +349,34 @@ static long acpi_thermal_get_critical_tr
 		return THERMAL_TEMP_INVALID;
 	}
 
-	status = acpi_evaluate_integer(tz->device->handle, "_CRT", NULL, &tmp);
-	if (ACPI_FAILURE(status)) {
-		acpi_handle_debug(tz->device->handle, "No critical threshold\n");
+	if (acpi_critical_trip_temp(tz->device, &temp))
 		return THERMAL_TEMP_INVALID;
-	}
-	if (tmp <= 2732) {
+
+	if (temp <= 2732) {
 		/*
 		 * Below zero (Celsius) values clearly aren't right for sure,
 		 * so discard them as invalid.
 		 */
-		pr_info(FW_BUG "Invalid critical threshold (%llu)\n", tmp);
+		pr_info(FW_BUG "Invalid critical threshold (%d)\n", temp);
 		return THERMAL_TEMP_INVALID;
 	}
 
 set:
-	acpi_handle_debug(tz->device->handle, "Critical threshold [%llu]\n", tmp);
-	return tmp;
+	acpi_handle_debug(tz->device->handle, "Critical threshold [%d]\n", temp);
+	return temp;
 }
 
-static long acpi_thermal_get_hot_trip(struct acpi_thermal *tz)
+static int acpi_thermal_get_hot_trip(struct acpi_thermal *tz)
 {
-	unsigned long long tmp;
-	acpi_status status;
+	int temp;
 
-	status = acpi_evaluate_integer(tz->device->handle, "_HOT", NULL, &tmp);
-	if (ACPI_FAILURE(status)) {
+	if (acpi_hot_trip_temp(tz->device, &temp) || temp == THERMAL_TEMP_INVALID) {
 		acpi_handle_debug(tz->device->handle, "No hot threshold\n");
 		return THERMAL_TEMP_INVALID;
 	}
 
-	acpi_handle_debug(tz->device->handle, "Hot threshold [%llu]\n", tmp);
-	return tmp;
+	acpi_handle_debug(tz->device->handle, "Hot threshold [%d]\n", temp);
+	return temp;
 }
 
 static bool passive_trip_params_init(struct acpi_thermal *tz)
@@ -1142,6 +1134,7 @@ static void __exit acpi_thermal_exit(voi
 module_init(acpi_thermal_init);
 module_exit(acpi_thermal_exit);
 
+MODULE_IMPORT_NS(ACPI_THERMAL);
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Thermal Zone Driver");
 MODULE_LICENSE("GPL");



