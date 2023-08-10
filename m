Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4936177813F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbjHJTRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbjHJTRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:17:47 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8842717;
        Thu, 10 Aug 2023 12:17:46 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.2.0)
 id 1a9d5b36f8f22aa9; Thu, 10 Aug 2023 21:17:45 +0200
Authentication-Results: v370.home.net.pl; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=rjwysocki.net 
   (client-ip=195.136.19.94; helo=[195.136.19.94]; 
   envelope-from=rjw@rjwysocki.net; receiver=<UNKNOWN>)
Received: from kreacher.localnet (unknown [195.136.19.94])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id C4FAB662742;
        Thu, 10 Aug 2023 21:17:44 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 6/7] thermal: intel: intel_soc_dts_iosf: Rework critical trip setup
Date:   Thu, 10 Aug 2023 21:16:14 +0200
Message-ID: <8269586.T7Z3S40VBb@kreacher>
In-Reply-To: <5713357.DvuYhMxLoT@kreacher>
References: <5713357.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrleeigddufeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohephedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdp
 rhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=5 Fuz1=5 Fuz2=5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Critical trip points appear in the DTS thermal zones only after those
thermal zones have been registered via intel_soc_dts_iosf_init().
Moreover, they are "created" by changing the type of an existing trip
point from THERMAL_TRIP_PASSIVE to THERMAL_TRIP_CRITICAL via
intel_soc_dts_iosf_add_read_only_critical_trip(), the caller of which
has to be careful enough to pass at least 1 as the number of read-only
trip points to intel_soc_dts_iosf_init() beforehand.

This is questionable, because user space may have started to use the
trips at the time when intel_soc_dts_iosf_add_read_only_critical_trip()
runs and there is no synchronization between it and sys_set_trip_temp().

To address it, use the observation that nonzero number of read-only
trip points is only passed to intel_soc_dts_iosf_init() when critical
trip points are going to be used, so in fact that function may get all
of the information regarding the critical trip points upfront and it
can configure them before registering the corresponding thermal zones.

Accordingly, replace the read_only_trip_count argument of
intel_soc_dts_iosf_init() with a pair of new arguments related to
critical trip points: a bool one indicating whether or not critical
trip points are to be used at all and an int one representing the
critical trip point temperature offset relative to Tj_max.  Use these
arguments to configure the critical trip points before the registration
of the thermal zones and to compute the number of writeable trip points
in add_dts_thermal_zone().

Modify both callers of intel_soc_dts_iosf_init() to take these changes
into account and drop the intel_soc_dts_iosf_add_read_only_critical_trip()
call, that is not necessary any more, from intel_soc_thermal_init(),
which also allows it to return success right after requesting the IRQ.

Finally, drop intel_soc_dts_iosf_add_read_only_critical_trip()
altogether, because it does not have any more users.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c |    2 
 drivers/thermal/intel/intel_soc_dts_iosf.c                                  |   51 +++-------
 drivers/thermal/intel/intel_soc_dts_iosf.h                                  |    8 -
 drivers/thermal/intel/intel_soc_dts_thermal.c                               |   17 ---
 4 files changed, 27 insertions(+), 51 deletions(-)

Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -257,11 +257,11 @@ static void remove_dts_thermal_zone(stru
 }
 
 static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
-				int read_only_trip_cnt)
+				bool critical_trip)
 {
+	int writable_trip_cnt = SOC_MAX_DTS_TRIPS;
 	char name[10];
 	unsigned long trip;
-	int writable_trip_cnt;
 	int trip_mask;
 	unsigned long ptps;
 	u32 store_ptps;
@@ -276,7 +276,9 @@ static int add_dts_thermal_zone(int id,
 
 	dts->id = id;
 
-	writable_trip_cnt = SOC_MAX_DTS_TRIPS - read_only_trip_cnt;
+	if (critical_trip)
+		writable_trip_cnt--;
+
 	trip_mask = GENMASK(writable_trip_cnt - 1, 0);
 
 	/* Check if the writable trip we provide is not used by BIOS */
@@ -315,25 +317,6 @@ err_ret:
 	return ret;
 }
 
-int intel_soc_dts_iosf_add_read_only_critical_trip(
-	struct intel_soc_dts_sensors *sensors, int critical_offset)
-{
-	int i, j;
-
-	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
-		struct intel_soc_dts_sensor_entry *entry = &sensors->soc_dts[i];
-		int temp = sensors->tj_max - critical_offset;
-		unsigned long mask = entry->trip_mask;
-
-		j = find_first_zero_bit(&mask, SOC_MAX_DTS_TRIPS);
-		if (j < SOC_MAX_DTS_TRIPS)
-			return configure_trip(entry, j, THERMAL_TRIP_CRITICAL, temp);
-	}
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(intel_soc_dts_iosf_add_read_only_critical_trip);
-
 void intel_soc_dts_iosf_interrupt_handler(struct intel_soc_dts_sensors *sensors)
 {
 	u32 sticky_out;
@@ -375,8 +358,9 @@ static void dts_trips_reset(struct intel
 	configure_trip(&sensors->soc_dts[dts_index], 1, 0, 0);
 }
 
-struct intel_soc_dts_sensors *intel_soc_dts_iosf_init(
-	enum intel_soc_dts_interrupt_type intr_type, int read_only_trip_count)
+struct intel_soc_dts_sensors *
+intel_soc_dts_iosf_init(enum intel_soc_dts_interrupt_type intr_type,
+			bool critical_trip, int crit_offset)
 {
 	struct intel_soc_dts_sensors *sensors;
 	int tj_max;
@@ -386,9 +370,6 @@ struct intel_soc_dts_sensors *intel_soc_
 	if (!iosf_mbi_available())
 		return ERR_PTR(-ENODEV);
 
-	if (read_only_trip_count > SOC_MAX_DTS_TRIPS)
-		return ERR_PTR(-EINVAL);
-
 	tj_max = intel_tcc_get_tjmax(-1);
 	if (tj_max < 0)
 		return ERR_PTR(tj_max);
@@ -403,6 +384,9 @@ struct intel_soc_dts_sensors *intel_soc_
 	sensors->tj_max = tj_max * 1000;
 
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
+		enum thermal_trip_type trip_type;
+		int temp;
+
 		sensors->soc_dts[i].sensors = sensors;
 
 		ret = configure_trip(&sensors->soc_dts[i], 0,
@@ -410,15 +394,20 @@ struct intel_soc_dts_sensors *intel_soc_
 		if (ret)
 			goto err_reset_trips;
 
-		ret = configure_trip(&sensors->soc_dts[i], 1,
-				     THERMAL_TRIP_PASSIVE, 0);
+		if (critical_trip) {
+			trip_type = THERMAL_TRIP_CRITICAL;
+			temp = sensors->tj_max - crit_offset;
+		} else {
+			trip_type = THERMAL_TRIP_PASSIVE;
+			temp = 0;
+		}
+		ret = configure_trip(&sensors->soc_dts[i], 1, trip_type, temp);
 		if (ret)
 			goto err_reset_trips;
 	}
 
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
-		ret = add_dts_thermal_zone(i, &sensors->soc_dts[i],
-					   read_only_trip_count);
+		ret = add_dts_thermal_zone(i, &sensors->soc_dts[i], critical_trip);
 		if (ret)
 			goto err_remove_zone;
 	}
Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.h
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.h
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.h
@@ -42,11 +42,11 @@ struct intel_soc_dts_sensors {
 	struct intel_soc_dts_sensor_entry soc_dts[SOC_MAX_DTS_SENSORS];
 };
 
-struct intel_soc_dts_sensors *intel_soc_dts_iosf_init(
-	enum intel_soc_dts_interrupt_type intr_type, int read_only_trip_count);
+
+struct intel_soc_dts_sensors *
+intel_soc_dts_iosf_init(enum intel_soc_dts_interrupt_type intr_type,
+			bool critical_trip, int crit_offset);
 void intel_soc_dts_iosf_exit(struct intel_soc_dts_sensors *sensors);
 void intel_soc_dts_iosf_interrupt_handler(
 				struct intel_soc_dts_sensors *sensors);
-int intel_soc_dts_iosf_add_read_only_critical_trip(
-	struct intel_soc_dts_sensors *sensors, int critical_offset);
 #endif
Index: linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci_legacy.c
@@ -59,7 +59,7 @@ static int proc_thermal_pci_probe(struct
 		 * ACPI/MSR. So we don't want to fail for auxiliary DTSs.
 		 */
 		proc_priv->soc_dts = intel_soc_dts_iosf_init(
-					INTEL_SOC_DTS_INTERRUPT_MSI, 0);
+					INTEL_SOC_DTS_INTERRUPT_MSI, false, 0);
 
 		if (!IS_ERR(proc_priv->soc_dts) && pdev->irq) {
 			ret = pci_enable_msi(pdev);
Index: linux-pm/drivers/thermal/intel/intel_soc_dts_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_thermal.c
@@ -51,7 +51,8 @@ static int __init intel_soc_thermal_init
 		return -ENODEV;
 
 	/* Create a zone with 2 trips with marked as read only */
-	soc_dts = intel_soc_dts_iosf_init(INTEL_SOC_DTS_INTERRUPT_APIC, 1);
+	soc_dts = intel_soc_dts_iosf_init(INTEL_SOC_DTS_INTERRUPT_APIC, true,
+					  crit_offset);
 	if (IS_ERR(soc_dts)) {
 		err = PTR_ERR(soc_dts);
 		return err;
@@ -88,21 +89,7 @@ static int __init intel_soc_thermal_init
 		}
 	}
 
-	err = intel_soc_dts_iosf_add_read_only_critical_trip(soc_dts,
-							     crit_offset);
-	if (err)
-		goto error_trips;
-
 	return 0;
-
-error_trips:
-	if (soc_dts_thres_irq) {
-		free_irq(soc_dts_thres_irq, soc_dts);
-		acpi_unregister_gsi(soc_dts_thres_gsi);
-	}
-	intel_soc_dts_iosf_exit(soc_dts);
-
-	return err;
 }
 
 static void __exit intel_soc_thermal_exit(void)



