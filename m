Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1A97CCDA5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbjJQUMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 16:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjJQUMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:12:48 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58156FAA;
        Tue, 17 Oct 2023 13:12:45 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id b9b0ec6ca16d320a; Tue, 17 Oct 2023 22:12:44 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 7ACE7666BCD;
        Tue, 17 Oct 2023 22:12:43 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 2/3] ACPI: thermal_lib: Add functions returning temperature in deci-Kelvin
Date:   Tue, 17 Oct 2023 22:06:52 +0200
Message-ID: <4861460.GXAFRqVoOG@kreacher>
In-Reply-To: <5740803.DvuYhMxLoT@kreacher>
References: <5740803.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddugeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
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

Because the ACPI thermal driver generally operates temperature values
in deci-Kelvin, it needs the library functions returning temperature
for various trip point types to use deci-Kelvin too.

To address that, arrange the ACPI thermal library code in three levels
of functions where the high-level ones will return temperature in
milli-Celsius, as needed by the thermal core and the majority of
thermal drivers, the mid-level ones will return temperature in
deci-Kelvin and will be called internally by the corresponding high-
level functions, and all of the mid-level functions will call the same
low-level one, acpi_trip_temp(), to actually evaluate ACPI objects to
retrieve themperature values from the platform firmware.

Going forward, this will allow the ACPI thermal driver to use the
mid-level functions to provide temperature values needed by it, so as
to reduce code duplication related to evaluating trip temperature ACPI
control methods.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal_lib.c |   75 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 60 insertions(+), 15 deletions(-)

Index: linux-pm/drivers/acpi/thermal_lib.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal_lib.c
+++ linux-pm/drivers/acpi/thermal_lib.c
@@ -3,8 +3,8 @@
  * Copyright 2023 Linaro Limited
  * Copyright 2023 Intel Corporation
  *
- * Library routines for populating a generic thermal trip point structure
- * with data obtained by evaluating a specific object in the ACPI Namespace.
+ * Library routines for retrieving trip point temperature values from the
+ * platform firmware via ACPI.
  */
 #include <linux/acpi.h>
 #include <linux/units.h>
@@ -17,11 +17,11 @@
  * firmware. Any values out of these boundaries may be considered
  * bogus and we can assume the firmware has no data to provide.
  */
-#define TEMP_MIN_DECIK	2180
-#define TEMP_MAX_DECIK	4480
+#define TEMP_MIN_DECIK	2180ULL
+#define TEMP_MAX_DECIK	4480ULL
 
-static int thermal_acpi_trip_temp(struct acpi_device *adev, char *obj_name,
-				  int *ret_temp)
+static int acpi_trip_temp(struct acpi_device *adev, char *obj_name,
+			  int *ret_temp)
 {
 	unsigned long long temp;
 	acpi_status status;
@@ -33,7 +33,7 @@ static int thermal_acpi_trip_temp(struct
 	}
 
 	if (temp >= TEMP_MIN_DECIK && temp <= TEMP_MAX_DECIK) {
-		*ret_temp = deci_kelvin_to_millicelsius(temp);
+		*ret_temp = temp;
 	} else {
 		acpi_handle_debug(adev->handle, "%s result %llu out of range\n",
 				  obj_name, temp);
@@ -43,6 +43,44 @@ static int thermal_acpi_trip_temp(struct
 	return 0;
 }
 
+int acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
+{
+	char obj_name[] = {'_', 'A', 'C', '0' + id, '\0'};
+
+	if (id < 0 || id > 9)
+		return -EINVAL;
+
+	return acpi_trip_temp(adev, obj_name, ret_temp);
+}
+
+int acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
+{
+	return acpi_trip_temp(adev, "_PSV", ret_temp);
+}
+
+int acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
+{
+	return acpi_trip_temp(adev, "_HOT", ret_temp);
+}
+
+int acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
+{
+	return acpi_trip_temp(adev, "_CRT", ret_temp);
+}
+
+static int thermal_temp(int error, int temp_decik, int *ret_temp)
+{
+	if (error)
+		return error;
+
+	if (temp_decik == THERMAL_TEMP_INVALID)
+		*ret_temp = THERMAL_TEMP_INVALID;
+	else
+		*ret_temp = deci_kelvin_to_millicelsius(temp_decik);
+
+	return 0;
+}
+
 /**
  * thermal_acpi_active_trip_temp - Retrieve active trip point temperature
  * @adev: Target thermal zone ACPI device object.
@@ -57,12 +95,10 @@ static int thermal_acpi_trip_temp(struct
  */
 int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
 {
-	char obj_name[] = {'_', 'A', 'C', '0' + id, '\0'};
-
-	if (id < 0 || id > 9)
-		return -EINVAL;
+	int temp_decik;
+	int ret = acpi_active_trip_temp(adev, id, &temp_decik);
 
-	return thermal_acpi_trip_temp(adev, obj_name, ret_temp);
+	return thermal_temp(ret, temp_decik, ret_temp);
 }
 EXPORT_SYMBOL_GPL(thermal_acpi_active_trip_temp);
 
@@ -78,7 +114,10 @@ EXPORT_SYMBOL_GPL(thermal_acpi_active_tr
  */
 int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
 {
-	return thermal_acpi_trip_temp(adev, "_PSV", ret_temp);
+	int temp_decik;
+	int ret = acpi_passive_trip_temp(adev, &temp_decik);
+
+	return thermal_temp(ret, temp_decik, ret_temp);
 }
 EXPORT_SYMBOL_GPL(thermal_acpi_passive_trip_temp);
 
@@ -95,7 +134,10 @@ EXPORT_SYMBOL_GPL(thermal_acpi_passive_t
  */
 int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
 {
-	return thermal_acpi_trip_temp(adev, "_HOT", ret_temp);
+	int temp_decik;
+	int ret = acpi_hot_trip_temp(adev, &temp_decik);
+
+	return thermal_temp(ret, temp_decik, ret_temp);
 }
 EXPORT_SYMBOL_GPL(thermal_acpi_hot_trip_temp);
 
@@ -111,6 +153,9 @@ EXPORT_SYMBOL_GPL(thermal_acpi_hot_trip_
  */
 int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
 {
-	return thermal_acpi_trip_temp(adev, "_CRT", ret_temp);
+	int temp_decik;
+	int ret = acpi_critical_trip_temp(adev, &temp_decik);
+
+	return thermal_temp(ret, temp_decik, ret_temp);
 }
 EXPORT_SYMBOL_GPL(thermal_acpi_critical_trip_temp);



