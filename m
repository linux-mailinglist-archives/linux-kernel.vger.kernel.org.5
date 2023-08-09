Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66837776A04
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjHIU20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjHIU2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:28:24 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C24D2103;
        Wed,  9 Aug 2023 13:28:23 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 25c1ff97abbd2ea3; Wed, 9 Aug 2023 22:28:21 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 570A06625DB;
        Wed,  9 Aug 2023 22:28:21 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 1/2] thermal: intel: intel_soc_dts_iosf: Always use 2 trips
Date:   Wed, 09 Aug 2023 22:27:18 +0200
Message-ID: <4860900.31r3eYUQgx@kreacher>
In-Reply-To: <12271935.O9o76ZdvQC@kreacher>
References: <12271935.O9o76ZdvQC@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrleeggddugeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdp
 rhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Both the existing callers of intel_soc_dts_iosf_init() pass 2 as the trip
count argument, so it can be replaced with SOC_MAX_DTS_TRIPS everywhere in
the code and the trip_count argument of that function can be dropped.

This also allows the trip_count field to be dropped from struct
intel_soc_dts_sensor_entry, as it is always equal to 2, and some
related code can be simplified.

Make changes accordingly.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c |    2 
 drivers/thermal/intel/intel_soc_dts_iosf.c                                  |   26 +++-------
 drivers/thermal/intel/intel_soc_dts_iosf.h                                  |    9 +--
 drivers/thermal/intel/intel_soc_dts_thermal.c                               |    2 
 4 files changed, 15 insertions(+), 24 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -37,9 +37,6 @@
 /* DTS encoding for TJ MAX temperature */
 #define SOC_DTS_TJMAX_ENCODING		0x7F
 
-/* Only 2 out of 4 is allowed for OSPM */
-#define SOC_MAX_DTS_TRIPS		2
-
 /* Mask for two trips in status bits */
 #define SOC_DTS_TRIP_MASK		0x03
 
@@ -253,12 +250,10 @@ static void remove_dts_thermal_zone(stru
 }
 
 static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
-				bool notification_support, int trip_cnt,
-				int read_only_trip_cnt)
+				bool notification_support, int read_only_trip_cnt)
 {
 	char name[10];
 	unsigned long trip;
-	int trip_count = 0;
 	int trip_mask = 0;
 	int writable_trip_cnt = 0;
 	unsigned long ptps;
@@ -274,8 +269,7 @@ static int add_dts_thermal_zone(int id,
 
 	dts->id = id;
 	if (notification_support) {
-		trip_count = min(SOC_MAX_DTS_TRIPS, trip_cnt);
-		writable_trip_cnt = trip_count - read_only_trip_cnt;
+		writable_trip_cnt = SOC_MAX_DTS_TRIPS - read_only_trip_cnt;
 		trip_mask = GENMASK(writable_trip_cnt - 1, 0);
 	}
 
@@ -290,10 +284,9 @@ static int add_dts_thermal_zone(int id,
 			trip_mask &= ~BIT(i / 8);
 	}
 	dts->trip_mask = trip_mask;
-	dts->trip_count = trip_count;
 	snprintf(name, sizeof(name), "soc_dts%d", id);
 	dts->tzone = thermal_zone_device_register(name,
-						  trip_count,
+						  SOC_MAX_DTS_TRIPS,
 						  trip_mask,
 						  dts, &tzone_ops,
 						  NULL, 0, 0);
@@ -324,11 +317,10 @@ int intel_soc_dts_iosf_add_read_only_cri
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
 		struct intel_soc_dts_sensor_entry *entry = &sensors->soc_dts[i];
 		int temp = sensors->tj_max - critical_offset;
-		unsigned long count = entry->trip_count;
 		unsigned long mask = entry->trip_mask;
 
-		j = find_first_zero_bit(&mask, count);
-		if (j < count)
+		j = find_first_zero_bit(&mask, SOC_MAX_DTS_TRIPS);
+		if (j < SOC_MAX_DTS_TRIPS)
 			return update_trip_temp(entry, j, temp, THERMAL_TRIP_CRITICAL);
 	}
 
@@ -372,8 +364,7 @@ void intel_soc_dts_iosf_interrupt_handle
 EXPORT_SYMBOL_GPL(intel_soc_dts_iosf_interrupt_handler);
 
 struct intel_soc_dts_sensors *intel_soc_dts_iosf_init(
-	enum intel_soc_dts_interrupt_type intr_type, int trip_count,
-	int read_only_trip_count)
+	enum intel_soc_dts_interrupt_type intr_type, int read_only_trip_count)
 {
 	struct intel_soc_dts_sensors *sensors;
 	bool notification;
@@ -384,7 +375,7 @@ struct intel_soc_dts_sensors *intel_soc_
 	if (!iosf_mbi_available())
 		return ERR_PTR(-ENODEV);
 
-	if (!trip_count || read_only_trip_count > trip_count)
+	if (read_only_trip_count > SOC_MAX_DTS_TRIPS)
 		return ERR_PTR(-EINVAL);
 
 	tj_max = intel_tcc_get_tjmax(-1);
@@ -406,8 +397,7 @@ struct intel_soc_dts_sensors *intel_soc_
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
 		sensors->soc_dts[i].sensors = sensors;
 		ret = add_dts_thermal_zone(i, &sensors->soc_dts[i],
-					   notification, trip_count,
-					   read_only_trip_count);
+					   notification, read_only_trip_count);
 		if (ret)
 			goto err_free;
 	}
Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.h
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.h
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.h
@@ -12,6 +12,9 @@
 /* DTS0 and DTS 1 */
 #define SOC_MAX_DTS_SENSORS	2
 
+/* Only 2 out of 4 is allowed for OSPM */
+#define SOC_MAX_DTS_TRIPS	2
+
 enum intel_soc_dts_interrupt_type {
 	INTEL_SOC_DTS_INTERRUPT_NONE,
 	INTEL_SOC_DTS_INTERRUPT_APIC,
@@ -26,8 +29,7 @@ struct intel_soc_dts_sensor_entry {
 	int id;
 	u32 store_status;
 	u32 trip_mask;
-	u32 trip_count;
-	enum thermal_trip_type trip_types[2];
+	enum thermal_trip_type trip_types[SOC_MAX_DTS_TRIPS];
 	struct thermal_zone_device *tzone;
 	struct intel_soc_dts_sensors *sensors;
 };
@@ -41,8 +43,7 @@ struct intel_soc_dts_sensors {
 };
 
 struct intel_soc_dts_sensors *intel_soc_dts_iosf_init(
-	enum intel_soc_dts_interrupt_type intr_type, int trip_count,
-	int read_only_trip_count);
+	enum intel_soc_dts_interrupt_type intr_type, int read_only_trip_count);
 void intel_soc_dts_iosf_exit(struct intel_soc_dts_sensors *sensors);
 void intel_soc_dts_iosf_interrupt_handler(
 				struct intel_soc_dts_sensors *sensors);
Index: linux-pm/drivers/thermal/intel/intel_soc_dts_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_thermal.c
@@ -51,7 +51,7 @@ static int __init intel_soc_thermal_init
 		return -ENODEV;
 
 	/* Create a zone with 2 trips with marked as read only */
-	soc_dts = intel_soc_dts_iosf_init(INTEL_SOC_DTS_INTERRUPT_APIC, 2, 1);
+	soc_dts = intel_soc_dts_iosf_init(INTEL_SOC_DTS_INTERRUPT_APIC, 1);
 	if (IS_ERR(soc_dts)) {
 		err = PTR_ERR(soc_dts);
 		return err;
Index: linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
@@ -59,7 +59,7 @@ static int proc_thermal_pci_probe(struct
 		 * ACPI/MSR. So we don't want to fail for auxiliary DTSs.
 		 */
 		proc_priv->soc_dts = intel_soc_dts_iosf_init(
-					INTEL_SOC_DTS_INTERRUPT_MSI, 2, 0);
+					INTEL_SOC_DTS_INTERRUPT_MSI, 0);
 
 		if (!IS_ERR(proc_priv->soc_dts) && pdev->irq) {
 			ret = pci_enable_msi(pdev);



