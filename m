Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F247CCDA7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 22:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344204AbjJQUMz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Oct 2023 16:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjJQUMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 16:12:49 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CE26FA9;
        Tue, 17 Oct 2023 13:12:46 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 25056178d9cded64; Tue, 17 Oct 2023 22:12:45 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 86C38666BCD;
        Tue, 17 Oct 2023 22:12:44 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v1 1/3] thermal: ACPI: Move the ACPI thermal library to drivers/acpi/
Date:   Tue, 17 Oct 2023 22:05:23 +0200
Message-ID: <4539892.LvFx2qVVIh@kreacher>
In-Reply-To: <5740803.DvuYhMxLoT@kreacher>
References: <5740803.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrjedvgddugeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnheptddvfeegledvfedvveevhedvteeffeehvdeuiedukeeiledttefgvdeihffgteetnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepjedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
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

The ACPI thermal library contains functions that can be used to
retrieve trip point temperature values through the platform firmware
for various types of trip points.  Each of these functions basically
evaluates a specific ACPI object, checks if the value produced by it
is reasonable and returns it (or THERMAL_TEMP_INVALID if anything
fails).

It made sense to hold it in drivers/thermal/ so long as it was only used
by the code in that directory, but since it is also going to be used by
the ACPI thermal driver, located in drivers/acpi/, move it to the latter
in order to keep the code related to evaluating ACPI objects defined in
the specification proper together.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/Kconfig                          |    4 
 drivers/acpi/Makefile                         |    1 
 drivers/acpi/thermal_lib.c                    |  116 ++++++++++++++++++++++++++
 drivers/thermal/Kconfig                       |    4 
 drivers/thermal/Makefile                      |    1 
 drivers/thermal/intel/Kconfig                 |    2 
 drivers/thermal/intel/int340x_thermal/Kconfig |    2 
 drivers/thermal/thermal_acpi.c                |  116 --------------------------
 include/linux/acpi.h                          |    7 +
 include/linux/thermal.h                       |    7 -
 10 files changed, 130 insertions(+), 130 deletions(-)

Index: linux-pm/drivers/thermal/intel/Kconfig
===================================================================
--- linux-pm.orig/drivers/thermal/intel/Kconfig
+++ linux-pm/drivers/thermal/intel/Kconfig
@@ -85,7 +85,7 @@ config INTEL_BXT_PMIC_THERMAL
 config INTEL_PCH_THERMAL
 	tristate "Intel PCH Thermal Reporting Driver"
 	depends on X86 && PCI
-	select THERMAL_ACPI if ACPI
+	select ACPI_THERMAL_LIB if ACPI
 	help
 	  Enable this to support thermal reporting on certain intel PCHs.
 	  Thermal reporting device will provide temperature reading,
Index: linux-pm/drivers/thermal/intel/int340x_thermal/Kconfig
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/Kconfig
+++ linux-pm/drivers/thermal/intel/int340x_thermal/Kconfig
@@ -9,7 +9,7 @@ config INT340X_THERMAL
 	select THERMAL_GOV_USER_SPACE
 	select ACPI_THERMAL_REL
 	select ACPI_FAN
-	select THERMAL_ACPI
+	select ACPI_THERMAL_LIB
 	select INTEL_SOC_DTS_IOSF_CORE
 	select INTEL_TCC
 	select PROC_THERMAL_MMIO_RAPL if POWERCAP
Index: linux-pm/drivers/acpi/Kconfig
===================================================================
--- linux-pm.orig/drivers/acpi/Kconfig
+++ linux-pm/drivers/acpi/Kconfig
@@ -60,6 +60,10 @@ config ACPI_CCA_REQUIRED
 config ACPI_TABLE_LIB
 	bool
 
+config ACPI_THERMAL_LIB
+       depends on THERMAL
+       bool
+
 config ACPI_DEBUGGER
 	bool "AML debugger interface"
 	select ACPI_DEBUG
Index: linux-pm/drivers/thermal/Kconfig
===================================================================
--- linux-pm.orig/drivers/thermal/Kconfig
+++ linux-pm/drivers/thermal/Kconfig
@@ -76,10 +76,6 @@ config THERMAL_OF
 	  Say 'Y' here if you need to build thermal infrastructure
 	  based on device tree.
 
-config THERMAL_ACPI
-       depends on ACPI
-       bool
-
 config THERMAL_WRITABLE_TRIPS
 	bool "Enable writable trip points"
 	help
Index: linux-pm/drivers/acpi/Makefile
===================================================================
--- linux-pm.orig/drivers/acpi/Makefile
+++ linux-pm/drivers/acpi/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_ACPI_TAD)		+= acpi_tad.o
 obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI)		+= container.o
+obj-$(CONFIG_ACPI_THERMAL_LIB)	+= thermal_lib.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-$(CONFIG_ACPI_PLATFORM_PROFILE) 	+= platform_profile.o
 obj-$(CONFIG_ACPI_NFIT)		+= nfit/
Index: linux-pm/drivers/thermal/Makefile
===================================================================
--- linux-pm.orig/drivers/thermal/Makefile
+++ linux-pm/drivers/thermal/Makefile
@@ -13,7 +13,6 @@ thermal_sys-$(CONFIG_THERMAL_NETLINK)		+
 # interface to/from other layers providing sensors
 thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
 thermal_sys-$(CONFIG_THERMAL_OF)		+= thermal_of.o
-thermal_sys-$(CONFIG_THERMAL_ACPI)		+= thermal_acpi.o
 
 # governors
 CFLAGS_gov_power_allocator.o			:= -I$(src)
Index: linux-pm/include/linux/acpi.h
===================================================================
--- linux-pm.orig/include/linux/acpi.h
+++ linux-pm/include/linux/acpi.h
@@ -439,6 +439,13 @@ extern int acpi_blacklisted(void);
 extern void acpi_osi_setup(char *str);
 extern bool acpi_osi_is_win8(void);
 
+#ifdef CONFIG_ACPI_THERMAL_LIB
+int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp);
+int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp);
+int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp);
+int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
+#endif
+
 #ifdef CONFIG_ACPI_NUMA
 int acpi_map_pxm_to_node(int pxm);
 int acpi_get_node(acpi_handle handle);
Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -294,13 +294,6 @@ int thermal_zone_get_num_trips(struct th
 
 int thermal_zone_get_crit_temp(struct thermal_zone_device *tz, int *temp);
 
-#ifdef CONFIG_THERMAL_ACPI
-int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp);
-int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp);
-int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp);
-int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
-#endif
-
 #ifdef CONFIG_THERMAL
 struct thermal_zone_device *thermal_zone_device_register_with_trips(
 					const char *type,
Index: linux-pm/drivers/acpi/thermal_lib.c
===================================================================
--- /dev/null
+++ linux-pm/drivers/acpi/thermal_lib.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Linaro Limited
+ * Copyright 2023 Intel Corporation
+ *
+ * Library routines for populating a generic thermal trip point structure
+ * with data obtained by evaluating a specific object in the ACPI Namespace.
+ */
+#include <linux/acpi.h>
+#include <linux/units.h>
+#include <linux/thermal.h>
+
+/*
+ * Minimum temperature for full military grade is 218°K (-55°C) and
+ * max temperature is 448°K (175°C). We can consider those values as
+ * the boundaries for the [trips] temperature returned by the
+ * firmware. Any values out of these boundaries may be considered
+ * bogus and we can assume the firmware has no data to provide.
+ */
+#define TEMP_MIN_DECIK	2180
+#define TEMP_MAX_DECIK	4480
+
+static int thermal_acpi_trip_temp(struct acpi_device *adev, char *obj_name,
+				  int *ret_temp)
+{
+	unsigned long long temp;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(adev->handle, obj_name, NULL, &temp);
+	if (ACPI_FAILURE(status)) {
+		acpi_handle_debug(adev->handle, "%s evaluation failed\n", obj_name);
+		return -ENODATA;
+	}
+
+	if (temp >= TEMP_MIN_DECIK && temp <= TEMP_MAX_DECIK) {
+		*ret_temp = deci_kelvin_to_millicelsius(temp);
+	} else {
+		acpi_handle_debug(adev->handle, "%s result %llu out of range\n",
+				  obj_name, temp);
+		*ret_temp = THERMAL_TEMP_INVALID;
+	}
+
+	return 0;
+}
+
+/**
+ * thermal_acpi_active_trip_temp - Retrieve active trip point temperature
+ * @adev: Target thermal zone ACPI device object.
+ * @id: Active cooling level (0 - 9).
+ * @ret_temp: Address to store the retrieved temperature value on success.
+ *
+ * Evaluate the _ACx object for the thermal zone represented by @adev to obtain
+ * the temperature of the active cooling trip point corresponding to the active
+ * cooling level given by @id.
+ *
+ * Return 0 on success or a negative error value on failure.
+ */
+int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
+{
+	char obj_name[] = {'_', 'A', 'C', '0' + id, '\0'};
+
+	if (id < 0 || id > 9)
+		return -EINVAL;
+
+	return thermal_acpi_trip_temp(adev, obj_name, ret_temp);
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_active_trip_temp);
+
+/**
+ * thermal_acpi_passive_trip_temp - Retrieve passive trip point temperature
+ * @adev: Target thermal zone ACPI device object.
+ * @ret_temp: Address to store the retrieved temperature value on success.
+ *
+ * Evaluate the _PSV object for the thermal zone represented by @adev to obtain
+ * the temperature of the passive cooling trip point.
+ *
+ * Return 0 on success or -ENODATA on failure.
+ */
+int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
+{
+	return thermal_acpi_trip_temp(adev, "_PSV", ret_temp);
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_passive_trip_temp);
+
+/**
+ * thermal_acpi_hot_trip_temp - Retrieve hot trip point temperature
+ * @adev: Target thermal zone ACPI device object.
+ * @ret_temp: Address to store the retrieved temperature value on success.
+ *
+ * Evaluate the _HOT object for the thermal zone represented by @adev to obtain
+ * the temperature of the trip point at which the system is expected to be put
+ * into the S4 sleep state.
+ *
+ * Return 0 on success or -ENODATA on failure.
+ */
+int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
+{
+	return thermal_acpi_trip_temp(adev, "_HOT", ret_temp);
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_hot_trip_temp);
+
+/**
+ * thermal_acpi_critical_trip_temp - Retrieve critical trip point temperature
+ * @adev: Target thermal zone ACPI device object.
+ * @ret_temp: Address to store the retrieved temperature value on success.
+ *
+ * Evaluate the _CRT object for the thermal zone represented by @adev to obtain
+ * the temperature of the critical cooling trip point.
+ *
+ * Return 0 on success or -ENODATA on failure.
+ */
+int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
+{
+	return thermal_acpi_trip_temp(adev, "_CRT", ret_temp);
+}
+EXPORT_SYMBOL_GPL(thermal_acpi_critical_trip_temp);
Index: linux-pm/drivers/thermal/thermal_acpi.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_acpi.c
+++ /dev/null
@@ -1,116 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright 2023 Linaro Limited
- * Copyright 2023 Intel Corporation
- *
- * Library routines for populating a generic thermal trip point structure
- * with data obtained by evaluating a specific object in the ACPI Namespace.
- */
-#include <linux/acpi.h>
-#include <linux/units.h>
-#include <linux/thermal.h>
-
-/*
- * Minimum temperature for full military grade is 218°K (-55°C) and
- * max temperature is 448°K (175°C). We can consider those values as
- * the boundaries for the [trips] temperature returned by the
- * firmware. Any values out of these boundaries may be considered
- * bogus and we can assume the firmware has no data to provide.
- */
-#define TEMP_MIN_DECIK	2180
-#define TEMP_MAX_DECIK	4480
-
-static int thermal_acpi_trip_temp(struct acpi_device *adev, char *obj_name,
-				  int *ret_temp)
-{
-	unsigned long long temp;
-	acpi_status status;
-
-	status = acpi_evaluate_integer(adev->handle, obj_name, NULL, &temp);
-	if (ACPI_FAILURE(status)) {
-		acpi_handle_debug(adev->handle, "%s evaluation failed\n", obj_name);
-		return -ENODATA;
-	}
-
-	if (temp >= TEMP_MIN_DECIK && temp <= TEMP_MAX_DECIK) {
-		*ret_temp = deci_kelvin_to_millicelsius(temp);
-	} else {
-		acpi_handle_debug(adev->handle, "%s result %llu out of range\n",
-				  obj_name, temp);
-		*ret_temp = THERMAL_TEMP_INVALID;
-	}
-
-	return 0;
-}
-
-/**
- * thermal_acpi_active_trip_temp - Retrieve active trip point temperature
- * @adev: Target thermal zone ACPI device object.
- * @id: Active cooling level (0 - 9).
- * @ret_temp: Address to store the retrieved temperature value on success.
- *
- * Evaluate the _ACx object for the thermal zone represented by @adev to obtain
- * the temperature of the active cooling trip point corresponding to the active
- * cooling level given by @id.
- *
- * Return 0 on success or a negative error value on failure.
- */
-int thermal_acpi_active_trip_temp(struct acpi_device *adev, int id, int *ret_temp)
-{
-	char obj_name[] = {'_', 'A', 'C', '0' + id, '\0'};
-
-	if (id < 0 || id > 9)
-		return -EINVAL;
-
-	return thermal_acpi_trip_temp(adev, obj_name, ret_temp);
-}
-EXPORT_SYMBOL_GPL(thermal_acpi_active_trip_temp);
-
-/**
- * thermal_acpi_passive_trip_temp - Retrieve passive trip point temperature
- * @adev: Target thermal zone ACPI device object.
- * @ret_temp: Address to store the retrieved temperature value on success.
- *
- * Evaluate the _PSV object for the thermal zone represented by @adev to obtain
- * the temperature of the passive cooling trip point.
- *
- * Return 0 on success or -ENODATA on failure.
- */
-int thermal_acpi_passive_trip_temp(struct acpi_device *adev, int *ret_temp)
-{
-	return thermal_acpi_trip_temp(adev, "_PSV", ret_temp);
-}
-EXPORT_SYMBOL_GPL(thermal_acpi_passive_trip_temp);
-
-/**
- * thermal_acpi_hot_trip_temp - Retrieve hot trip point temperature
- * @adev: Target thermal zone ACPI device object.
- * @ret_temp: Address to store the retrieved temperature value on success.
- *
- * Evaluate the _HOT object for the thermal zone represented by @adev to obtain
- * the temperature of the trip point at which the system is expected to be put
- * into the S4 sleep state.
- *
- * Return 0 on success or -ENODATA on failure.
- */
-int thermal_acpi_hot_trip_temp(struct acpi_device *adev, int *ret_temp)
-{
-	return thermal_acpi_trip_temp(adev, "_HOT", ret_temp);
-}
-EXPORT_SYMBOL_GPL(thermal_acpi_hot_trip_temp);
-
-/**
- * thermal_acpi_critical_trip_temp - Retrieve critical trip point temperature
- * @adev: Target thermal zone ACPI device object.
- * @ret_temp: Address to store the retrieved temperature value on success.
- *
- * Evaluate the _CRT object for the thermal zone represented by @adev to obtain
- * the temperature of the critical cooling trip point.
- *
- * Return 0 on success or -ENODATA on failure.
- */
-int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp)
-{
-	return thermal_acpi_trip_temp(adev, "_CRT", ret_temp);
-}
-EXPORT_SYMBOL_GPL(thermal_acpi_critical_trip_temp);



