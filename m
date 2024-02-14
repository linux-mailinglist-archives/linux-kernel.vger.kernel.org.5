Return-Path: <linux-kernel+bounces-65214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA8B85499B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3A31C21F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C496854669;
	Wed, 14 Feb 2024 12:50:08 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EAF52F75;
	Wed, 14 Feb 2024 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915007; cv=none; b=TC1WJ84n2PqO9cfybVbxF4Jpw6bxqHr0JUU949+fp6jIVSrCp2aR6I8ENvQ4IW/FzTUyyt2ckPbucZbzjQ4n3+m2E1fDzESUzhFTk63lNWcvqS0h7LkMaIVJWbnzI1CARkK5ya06+d79HFgMjKqIVDRK0Jswrj8+4dzA3GDG69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915007; c=relaxed/simple;
	bh=lUNv/tfay4+UPX4NQWW8UfT46uIeCjBkeJxKoJms+qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJPJzsxNf/8GB2TkwyuNFKAHY/cf4Ilw1doQ/f4Ri+kzhoO1+Dprkafw3eSGLqFLFqcL7omH2IJ7acEDLwe+leBFFiMPQ/BoJ+shWIvUPItVeaSai9dxUYkSOW/Vy1SYIPoN0GfTOlS6akfLy4e2SDCNg53Nu+/ZlyZ5ZnwB6B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 048c35c836d11194; Wed, 14 Feb 2024 13:49:56 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 22C38669DCC;
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
 [PATCH v2 3/6] thermal: intel: Discard trip tables after zone registration
Date: Wed, 14 Feb 2024 13:42:16 +0100
Message-ID: <3287354.44csPzL39Z@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14 Fuz2=14

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because the thermal core creates and uses its own copy of the trips
table passed to thermal_zone_device_register_with_trips(), it is not
necessary to hold on to a local copy of it any more after the given
thermal zone has been registered.

Accordingly, modify Intel thermal drivers to discard the trips tables
passed to thermal_zone_device_register_with_trips() after thermal zone
registration, for example by storing them in local variables which are
automatically discarded when the zone registration is complete.

Also make some additional code simplifications unlocked by the above
changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rebase.

---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c         |    6 -
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h         |    1 
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c |    9 +-
 drivers/thermal/intel/intel_pch_thermal.c                            |   24 +++---
 drivers/thermal/intel/intel_quark_dts_thermal.c                      |    4 -
 drivers/thermal/intel/intel_soc_dts_iosf.c                           |   14 ++--
 drivers/thermal/intel/intel_soc_dts_iosf.h                           |    1 
 drivers/thermal/intel/x86_pkg_temp_thermal.c                         |   35 +++-------
 8 files changed, 40 insertions(+), 54 deletions(-)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -177,8 +177,6 @@ struct int34x_thermal_zone *int340x_ther
 	for (i = 0; i < trip_cnt; ++i)
 		zone_trips[i].hysteresis = hyst;
 
-	int34x_zone->trips = zone_trips;
-
 	int34x_zone->lpat_table = acpi_lpat_get_conversion_table(adev->handle);
 
 	int34x_zone->zone = thermal_zone_device_register_with_trips(
@@ -188,6 +186,8 @@ struct int34x_thermal_zone *int340x_ther
 							int34x_zone->ops,
 							&int340x_thermal_params,
 							0, 0);
+	kfree(zone_trips);
+
 	if (IS_ERR(int34x_zone->zone)) {
 		ret = PTR_ERR(int34x_zone->zone);
 		goto err_thermal_zone;
@@ -201,7 +201,6 @@ struct int34x_thermal_zone *int340x_ther
 err_enable:
 	thermal_zone_device_unregister(int34x_zone->zone);
 err_thermal_zone:
-	kfree(int34x_zone->trips);
 	acpi_lpat_free_conversion_table(int34x_zone->lpat_table);
 err_trips_alloc:
 	kfree(int34x_zone->ops);
@@ -215,7 +214,6 @@ void int340x_thermal_zone_remove(struct
 {
 	thermal_zone_device_unregister(int34x_zone->zone);
 	acpi_lpat_free_conversion_table(int34x_zone->lpat_table);
-	kfree(int34x_zone->trips);
 	kfree(int34x_zone->ops);
 	kfree(int34x_zone);
 }
Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
@@ -20,7 +20,6 @@ struct active_trip {
 
 struct int34x_thermal_zone {
 	struct acpi_device *adev;
-	struct thermal_trip *trips;
 	int aux_trip_nr;
 	struct thermal_zone_device *zone;
 	struct thermal_zone_device_ops *ops;
Index: linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -233,11 +233,6 @@ static int get_trip_temp(struct proc_the
 	return temp;
 }
 
-static struct thermal_trip psv_trip = {
-	.type = THERMAL_TRIP_PASSIVE,
-	.flags = THERMAL_TRIP_FLAG_RW_TEMP,
-};
-
 static struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
 	.set_trip_temp	= sys_set_trip_temp,
@@ -252,6 +247,10 @@ static int proc_thermal_pci_probe(struct
 {
 	struct proc_thermal_device *proc_priv;
 	struct proc_thermal_pci *pci_info;
+	struct thermal_trip psv_trip = {
+		.type = THERMAL_TRIP_PASSIVE,
+		.flags = THERMAL_TRIP_FLAG_RW_TEMP,
+	};
 	int irq_flag = 0, irq, ret;
 	bool msi_irq = false;
 
Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
@@ -84,7 +84,6 @@ struct pch_thermal_device {
 	void __iomem *hw_base;
 	struct pci_dev *pdev;
 	struct thermal_zone_device *tzd;
-	struct thermal_trip trips[PCH_MAX_TRIPS];
 	bool bios_enabled;
 };
 
@@ -94,7 +93,8 @@ struct pch_thermal_device {
  * passive trip temperature using _PSV method. There is no specific
  * passive temperature setting in MMIO interface of this PCI device.
  */
-static int pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd, int trip)
+static int pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
+				     struct thermal_trip *trip)
 {
 	struct acpi_device *adev;
 	int temp;
@@ -106,12 +106,13 @@ static int pch_wpt_add_acpi_psv_trip(str
 	if (thermal_acpi_passive_trip_temp(adev, &temp) || temp <= 0)
 		return 0;
 
-	ptd->trips[trip].type = THERMAL_TRIP_PASSIVE;
-	ptd->trips[trip].temperature = temp;
+	trip->type = THERMAL_TRIP_PASSIVE;
+	trip->temperature = temp;
 	return 1;
 }
 #else
-static int pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd, int trip)
+static int pch_wpt_add_acpi_psv_trip(struct pch_thermal_device *ptd,
+				     struct thermal_trip *trip)
 {
 	return 0;
 }
@@ -159,6 +160,7 @@ static const char *board_names[] = {
 static int intel_pch_thermal_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
+	struct thermal_trip ptd_trips[PCH_MAX_TRIPS] = { 0 };
 	enum pch_board_ids board_id = id->driver_data;
 	struct pch_thermal_device *ptd;
 	int nr_trips = 0;
@@ -220,21 +222,21 @@ read_trips:
 	trip_temp = readw(ptd->hw_base + WPT_CTT);
 	trip_temp &= 0x1FF;
 	if (trip_temp) {
-		ptd->trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
-		ptd->trips[nr_trips++].type = THERMAL_TRIP_CRITICAL;
+		ptd_trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
+		ptd_trips[nr_trips++].type = THERMAL_TRIP_CRITICAL;
 	}
 
 	trip_temp = readw(ptd->hw_base + WPT_PHL);
 	trip_temp &= 0x1FF;
 	if (trip_temp) {
-		ptd->trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
-		ptd->trips[nr_trips++].type = THERMAL_TRIP_HOT;
+		ptd_trips[nr_trips].temperature = GET_WPT_TEMP(trip_temp);
+		ptd_trips[nr_trips++].type = THERMAL_TRIP_HOT;
 	}
 
-	nr_trips += pch_wpt_add_acpi_psv_trip(ptd, nr_trips);
+	nr_trips += pch_wpt_add_acpi_psv_trip(ptd, &ptd_trips[nr_trips]);
 
 	ptd->tzd = thermal_zone_device_register_with_trips(board_names[board_id],
-							   ptd->trips, nr_trips,
+							   ptd_trips, nr_trips,
 							   ptd, &tzd_ops,
 							   NULL, 0, 0);
 	if (IS_ERR(ptd->tzd)) {
Index: linux-pm/drivers/thermal/intel/intel_quark_dts_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_quark_dts_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_quark_dts_thermal.c
@@ -101,7 +101,6 @@ struct soc_sensor_entry {
 	u32 store_ptps;
 	u32 store_dts_enable;
 	struct thermal_zone_device *tzone;
-	struct thermal_trip trips[QRK_MAX_DTS_TRIPS];
 };
 
 static struct soc_sensor_entry *soc_dts;
@@ -316,8 +315,8 @@ static void free_soc_dts(struct soc_sens
 
 static struct soc_sensor_entry *alloc_soc_dts(void)
 {
+	struct thermal_trip trips[QRK_MAX_DTS_TRIPS];
 	struct soc_sensor_entry *aux_entry;
-	struct thermal_trip *trips;
 	int err;
 	u32 out;
 
@@ -326,7 +325,6 @@ static struct soc_sensor_entry *alloc_so
 		err = -ENOMEM;
 		return ERR_PTR(-ENOMEM);
 	}
-	trips = aux_entry->trips;
 
 	/* Check if DTS register is locked */
 	err = iosf_mbi_read(QRK_MBI_UNIT_RMU, MBI_REG_READ,
Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -201,7 +201,8 @@ static void remove_dts_thermal_zone(stru
 	thermal_zone_device_unregister(dts->tzone);
 }
 
-static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts)
+static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
+				struct thermal_trip *trips)
 {
 	char name[10];
 	u32 store_ptps;
@@ -223,11 +224,11 @@ static int add_dts_thermal_zone(int id,
 
 		for (i = 0; i <= 1; i++) {
 			if (store_ptps & (0xFFU << i * 8))
-				dts->trips[i].flags &= ~THERMAL_TRIP_FLAG_RW_TEMP;
+				trips[i].flags &= ~THERMAL_TRIP_FLAG_RW_TEMP;
 		}
 	}
 	snprintf(name, sizeof(name), "soc_dts%d", id);
-	dts->tzone = thermal_zone_device_register_with_trips(name, dts->trips,
+	dts->tzone = thermal_zone_device_register_with_trips(name, trips,
 							     SOC_MAX_DTS_TRIPS,
 							     dts, &tzone_ops,
 							     NULL, 0, 0);
@@ -303,6 +304,7 @@ struct intel_soc_dts_sensors *
 intel_soc_dts_iosf_init(enum intel_soc_dts_interrupt_type intr_type,
 			bool critical_trip, int crit_offset)
 {
+	struct thermal_trip trips[SOC_MAX_DTS_SENSORS][SOC_MAX_DTS_TRIPS] = { 0 };
 	struct intel_soc_dts_sensors *sensors;
 	int tj_max;
 	int ret;
@@ -335,7 +337,7 @@ intel_soc_dts_iosf_init(enum intel_soc_d
 		if (ret)
 			goto err_reset_trips;
 
-		set_trip(&sensors->soc_dts[i].trips[0], THERMAL_TRIP_PASSIVE,
+		set_trip(&trips[i][0], THERMAL_TRIP_PASSIVE,
 			 THERMAL_TRIP_FLAG_RW_TEMP, 0);
 
 		if (critical_trip) {
@@ -351,11 +353,11 @@ intel_soc_dts_iosf_init(enum intel_soc_d
 		if (ret)
 			goto err_reset_trips;
 
-		set_trip(&sensors->soc_dts[i].trips[1], trip_type, trip_flags, temp);
+		set_trip(&trips[i][1], trip_type, trip_flags, temp);
 	}
 
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
-		ret = add_dts_thermal_zone(i, &sensors->soc_dts[i]);
+		ret = add_dts_thermal_zone(i, &sensors->soc_dts[i], trips[i]);
 		if (ret)
 			goto err_remove_zone;
 	}
Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.h
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.h
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.h
@@ -28,7 +28,6 @@ struct intel_soc_dts_sensors;
 struct intel_soc_dts_sensor_entry {
 	int id;
 	u32 store_status;
-	struct thermal_trip trips[SOC_MAX_DTS_TRIPS];
 	struct thermal_zone_device *tzone;
 	struct intel_soc_dts_sensors *sensors;
 };
Index: linux-pm/drivers/thermal/intel/x86_pkg_temp_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ linux-pm/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -53,7 +53,6 @@ struct zone_device {
 	u32				msr_pkg_therm_high;
 	struct delayed_work		work;
 	struct thermal_zone_device	*tzone;
-	struct thermal_trip		*trips;
 	struct cpumask			cpumask;
 };
 
@@ -268,17 +267,13 @@ static int pkg_thermal_notify(u64 msr_va
 	return 0;
 }
 
-static struct thermal_trip *pkg_temp_thermal_trips_init(int cpu, int tj_max, int num_trips)
+static int pkg_temp_thermal_trips_init(int cpu, int tj_max,
+				       struct thermal_trip *trips, int num_trips)
 {
-	struct thermal_trip *trips;
 	unsigned long thres_reg_value;
 	u32 mask, shift, eax, edx;
 	int ret, i;
 
-	trips = kzalloc(sizeof(*trips) * num_trips, GFP_KERNEL);
-	if (!trips)
-		return ERR_PTR(-ENOMEM);
-
 	for (i = 0; i < num_trips; i++) {
 
 		if (i) {
@@ -291,10 +286,8 @@ static struct thermal_trip *pkg_temp_the
 
 		ret = rdmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
 				   &eax, &edx);
-		if (ret < 0) {
-			kfree(trips);
-			return ERR_PTR(ret);
-		}
+		if (ret < 0)
+			return ret;
 
 		thres_reg_value = (eax & mask) >> shift;
 
@@ -308,11 +301,12 @@ static struct thermal_trip *pkg_temp_the
 			 __func__, cpu, i, trips[i].temperature);
 	}
 
-	return trips;
+	return 0;
 }
 
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
+	struct thermal_trip trips[MAX_NUMBER_OF_TRIPS] = { 0 };
 	int id = topology_logical_die_id(cpu);
 	u32 eax, ebx, ecx, edx;
 	struct zone_device *zonedev;
@@ -337,20 +331,18 @@ static int pkg_temp_thermal_device_add(u
 	if (!zonedev)
 		return -ENOMEM;
 
-	zonedev->trips = pkg_temp_thermal_trips_init(cpu, tj_max, thres_count);
-	if (IS_ERR(zonedev->trips)) {
-		err = PTR_ERR(zonedev->trips);
+	err = pkg_temp_thermal_trips_init(cpu, tj_max, trips, thres_count);
+	if (err)
 		goto out_kfree_zonedev;
-	}
 
 	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
 	zonedev->cpu = cpu;
 	zonedev->tzone = thermal_zone_device_register_with_trips("x86_pkg_temp",
-			zonedev->trips, thres_count,
+			trips, thres_count,
 			zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
 	if (IS_ERR(zonedev->tzone)) {
 		err = PTR_ERR(zonedev->tzone);
-		goto out_kfree_trips;
+		goto out_kfree_zonedev;
 	}
 	err = thermal_zone_device_enable(zonedev->tzone);
 	if (err)
@@ -369,8 +361,6 @@ static int pkg_temp_thermal_device_add(u
 
 out_unregister_tz:
 	thermal_zone_device_unregister(zonedev->tzone);
-out_kfree_trips:
-	kfree(zonedev->trips);
 out_kfree_zonedev:
 	kfree(zonedev);
 	return err;
@@ -457,10 +447,9 @@ static int pkg_thermal_cpu_offline(unsig
 	raw_spin_unlock_irq(&pkg_temp_lock);
 
 	/* Final cleanup if this is the last cpu */
-	if (lastcpu) {
-		kfree(zonedev->trips);
+	if (lastcpu)
 		kfree(zonedev);
-	}
+
 	return 0;
 }
 




