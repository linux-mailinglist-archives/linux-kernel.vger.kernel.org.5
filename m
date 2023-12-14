Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A2D812E30
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443919AbjLNLIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444044AbjLNLIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:08:35 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1D61FC1;
        Thu, 14 Dec 2023 03:07:57 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 7fda85dd752f5e20; Thu, 14 Dec 2023 12:07:56 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by cloudserver094114.home.pl (Postfix) with ESMTPSA id 888A3668A77;
        Thu, 14 Dec 2023 12:07:55 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1] ACPI: utils: Introduce helper for _DEP list lookup
Date:   Thu, 14 Dec 2023 12:07:55 +0100
Message-ID: <12358058.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudelledgvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhguvghgohgvuggvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhho
 sehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI LPSS driver and the Surface platform driver code use almost the
same code pattern for checking if one ACPI device is present in the list
returned by _DEP for another ACPI device.

To reduce the resulting code duplication, introduce a helper for that
called acpi_device_dep() and invoke it from both places.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This depends on the following series sent last week:

https://lore.kernel.org/linux-acpi/6008018.lOV4Wx5bFT@kreacher/

---
 drivers/acpi/acpi_lpss.c                       |   29 +--------------------
 drivers/acpi/utils.c                           |   33 +++++++++++++++++++++++++
 drivers/platform/surface/surface_acpi_notify.c |   28 ---------------------
 include/acpi/acpi_bus.h                        |    1 
 4 files changed, 37 insertions(+), 54 deletions(-)

Index: linux-pm/drivers/acpi/acpi_lpss.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpi_lpss.c
+++ linux-pm/drivers/acpi/acpi_lpss.c
@@ -563,31 +563,6 @@ static struct device *acpi_lpss_find_dev
 	return bus_find_device(&pci_bus_type, NULL, &data, match_hid_uid);
 }
 
-static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
-{
-	struct acpi_handle_list dep_devices;
-	bool ret = false;
-	int i;
-
-	if (!acpi_has_method(adev->handle, "_DEP"))
-		return false;
-
-	if (!acpi_evaluate_reference(adev->handle, "_DEP", NULL, &dep_devices)) {
-		dev_dbg(&adev->dev, "Failed to evaluate _DEP.\n");
-		return false;
-	}
-
-	for (i = 0; i < dep_devices.count; i++) {
-		if (dep_devices.handles[i] == handle) {
-			ret = true;
-			break;
-		}
-	}
-
-	acpi_handle_list_free(&dep_devices);
-	return ret;
-}
-
 static void acpi_lpss_link_consumer(struct device *dev1,
 				    const struct lpss_device_links *link)
 {
@@ -598,7 +573,7 @@ static void acpi_lpss_link_consumer(stru
 		return;
 
 	if ((link->dep_missing_ids && dmi_check_system(link->dep_missing_ids))
-	    || acpi_lpss_dep(ACPI_COMPANION(dev2), ACPI_HANDLE(dev1)))
+	    || acpi_device_dep(ACPI_HANDLE(dev2), ACPI_HANDLE(dev1)))
 		device_link_add(dev2, dev1, link->flags);
 
 	put_device(dev2);
@@ -614,7 +589,7 @@ static void acpi_lpss_link_supplier(stru
 		return;
 
 	if ((link->dep_missing_ids && dmi_check_system(link->dep_missing_ids))
-	    || acpi_lpss_dep(ACPI_COMPANION(dev1), ACPI_HANDLE(dev2)))
+	    || acpi_device_dep(ACPI_HANDLE(dev1), ACPI_HANDLE(dev2)))
 		device_link_add(dev1, dev2, link->flags);
 
 	put_device(dev2);
Index: linux-pm/drivers/acpi/utils.c
===================================================================
--- linux-pm.orig/drivers/acpi/utils.c
+++ linux-pm/drivers/acpi/utils.c
@@ -450,6 +450,39 @@ void acpi_handle_list_free(struct acpi_h
 }
 EXPORT_SYMBOL_GPL(acpi_handle_list_free);
 
+/**
+ * acpi_device_dep - Check ACPI device dependency
+ * @target: ACPI handle of the target ACPI device.
+ * @match: ACPI handle to look up in the target's _DEP list.
+ *
+ * Return true if @match is present in the list returned by _DEP for
+ * @target or false otherwise.
+ */
+bool acpi_device_dep(acpi_handle target, acpi_handle match)
+{
+	struct acpi_handle_list dep_devices;
+	bool ret = false;
+	int i;
+
+	if (!acpi_has_method(target, "_DEP"))
+		return false;
+
+	if (!acpi_evaluate_reference(target, "_DEP", NULL, &dep_devices)) {
+		acpi_handle_debug(target, "Failed to evaluate _DEP.\n");
+		return false;
+	}
+
+	for (i = 0; i < dep_devices.count; i++) {
+		if (dep_devices.handles[i] == match) {
+			ret = true;
+			break;
+		}
+	}
+
+	acpi_handle_list_free(&dep_devices);
+	return ret;
+}
+
 acpi_status
 acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_info **pld)
 {
Index: linux-pm/drivers/platform/surface/surface_acpi_notify.c
===================================================================
--- linux-pm.orig/drivers/platform/surface/surface_acpi_notify.c
+++ linux-pm/drivers/platform/surface/surface_acpi_notify.c
@@ -736,32 +736,6 @@ do {										\
 #define san_consumer_warn(dev, handle, fmt, ...) \
 	san_consumer_printk(warn, dev, handle, fmt, ##__VA_ARGS__)
 
-static bool is_san_consumer(struct platform_device *pdev, acpi_handle handle)
-{
-	struct acpi_handle_list dep_devices;
-	acpi_handle supplier = ACPI_HANDLE(&pdev->dev);
-	bool ret = false;
-	int i;
-
-	if (!acpi_has_method(handle, "_DEP"))
-		return false;
-
-	if (!acpi_evaluate_reference(handle, "_DEP", NULL, &dep_devices)) {
-		san_consumer_dbg(&pdev->dev, handle, "failed to evaluate _DEP\n");
-		return false;
-	}
-
-	for (i = 0; i < dep_devices.count; i++) {
-		if (dep_devices.handles[i] == supplier) {
-			ret = true;
-			break;
-		}
-	}
-
-	acpi_handle_list_free(&dep_devices);
-	return ret;
-}
-
 static acpi_status san_consumer_setup(acpi_handle handle, u32 lvl,
 				      void *context, void **rv)
 {
@@ -770,7 +744,7 @@ static acpi_status san_consumer_setup(ac
 	struct acpi_device *adev;
 	struct device_link *link;
 
-	if (!is_san_consumer(pdev, handle))
+	if (!acpi_device_dep(handle, ACPI_HANDLE(&pdev->dev)))
 		return AE_OK;
 
 	/* Ignore ACPI devices that are not present. */
Index: linux-pm/include/acpi/acpi_bus.h
===================================================================
--- linux-pm.orig/include/acpi/acpi_bus.h
+++ linux-pm/include/acpi/acpi_bus.h
@@ -33,6 +33,7 @@ bool acpi_handle_list_equal(struct acpi_
 void acpi_handle_list_replace(struct acpi_handle_list *dst,
 			      struct acpi_handle_list *src);
 void acpi_handle_list_free(struct acpi_handle_list *list);
+bool acpi_device_dep(acpi_handle target, acpi_handle match);
 acpi_status
 acpi_evaluate_ost(acpi_handle handle, u32 source_event, u32 status_code,
 		  struct acpi_buffer *status_buf);



