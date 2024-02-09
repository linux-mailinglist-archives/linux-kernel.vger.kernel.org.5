Return-Path: <linux-kernel+bounces-59432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0812D84F707
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2AE42846F6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A2D71B34;
	Fri,  9 Feb 2024 14:14:47 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E2A69971;
	Fri,  9 Feb 2024 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488086; cv=none; b=u19bxAJaKJzlurQOvErGju53dAd8DdgC0biYH83s6f+dCtxbd2kn7DF6/+ybXlE8x4BnY51SBqREvETvhCLNjSZOh51ZjlgGCk+4Aqag5dk97bFDniIwauIC/KPnuCyG36Tc/m/ZwErOxb/MHHfrlfbrHHF/ICWQ1jwmn8XRtNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488086; c=relaxed/simple;
	bh=JCRIRi/ahdTVjHOVuAFtDP5BXnRzKIpZ4pHG+X6RGvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmA9FIhb8h+vzsBl2Sl1mH2rWLrjHz1SbHcWVRpuu5SFxScag2MrXcq0HySlc9fpOiIHV5FECxbKT6kynD542tAo0xWP7rqiPorOR4VFkT13g7hqtDpc5ZzZQkTI3DwxjH2KmTszSSR814aGlUGu/gM0ibnjMCeRz6M18Q/zDvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id e8469aef8d66b243; Fri, 9 Feb 2024 15:14:40 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 930B8669C52;
	Fri,  9 Feb 2024 15:14:39 +0100 (CET)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject: [PATCH v1 9/9] thermal: core: Eliminate writable trip points masks
Date: Fri, 09 Feb 2024 15:14:10 +0100
Message-ID: <2475159.jE0xQCEvom@kreacher>
In-Reply-To: <3232442.5fSG56mABF@kreacher>
References: <3232442.5fSG56mABF@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgr
 nhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

All of the thermal_zone_device_register_with_trips() callers pass zero
writable trip points masks to it, so drop the mask argument from that
function and update all of its callers accordingly.

This also removes the artificial trip points per zone limit of 32,
related to using writable trip points masks.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/thermal.c                                               |    2 
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c                   |    2 
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c                   |    3 -
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c                          |    1 
 drivers/platform/x86/acerhdf.c                                       |    2 
 drivers/thermal/da9062-thermal.c                                     |    2 
 drivers/thermal/imx_thermal.c                                        |    2 
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c         |    2 
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c |    2 
 drivers/thermal/intel/intel_pch_thermal.c                            |    2 
 drivers/thermal/intel/intel_quark_dts_thermal.c                      |    2 
 drivers/thermal/intel/intel_soc_dts_iosf.c                           |    2 
 drivers/thermal/intel/x86_pkg_temp_thermal.c                         |    2 
 drivers/thermal/rcar_thermal.c                                       |    2 
 drivers/thermal/st/st_thermal.c                                      |    2 
 drivers/thermal/thermal_core.c                                       |   30 +---------
 drivers/thermal/thermal_of.c                                         |    2 
 include/linux/thermal.h                                              |    6 --
 18 files changed, 19 insertions(+), 49 deletions(-)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -322,8 +322,7 @@ int thermal_zone_get_crit_temp(struct th
 struct thermal_zone_device *thermal_zone_device_register_with_trips(
 					const char *type,
 					struct thermal_trip *trips,
-					int num_trips, int mask,
-					void *devdata,
+					int num_trips, void *devdata,
 					struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp,
 					int passive_delay, int polling_delay);
@@ -382,8 +381,7 @@ void thermal_zone_device_critical(struct
 static inline struct thermal_zone_device *thermal_zone_device_register_with_trips(
 					const char *type,
 					struct thermal_trip *trips,
-					int num_trips, int mask,
-					void *devdata,
+					int num_trips, void *devdata,
 					struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp,
 					int passive_delay, int polling_delay)
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1251,7 +1251,6 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_
  * @type:	the thermal zone device type
  * @trips:	a pointer to an array of thermal trips
  * @num_trips:	the number of trip points the thermal zone support
- * @mask:	a bit string indicating the writeablility of trip points
  * @devdata:	private device data
  * @ops:	standard thermal zone device callbacks
  * @tzp:	thermal zone platform parameters
@@ -1272,7 +1271,7 @@ EXPORT_SYMBOL_GPL(thermal_zone_get_crit_
  * IS_ERR*() helpers.
  */
 struct thermal_zone_device *
-thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int num_trips, int mask,
+thermal_zone_device_register_with_trips(const char *type, struct thermal_trip *trips, int num_trips,
 					void *devdata, struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp, int passive_delay,
 					int polling_delay)
@@ -1293,20 +1292,7 @@ thermal_zone_device_register_with_trips(
 		return ERR_PTR(-EINVAL);
 	}
 
-	/*
-	 * Max trip count can't exceed 31 as the "mask >> num_trips" condition.
-	 * For example, shifting by 32 will result in compiler warning:
-	 * warning: right shift count >= width of type [-Wshift-count- overflow]
-	 *
-	 * Also "mask >> num_trips" will always be true with 32 bit shift.
-	 * E.g. mask = 0x80000000 for trip id 31 to be RW. Then
-	 * mask >> 32 = 0x80000000
-	 * This will result in failure for the below condition.
-	 *
-	 * Check will be true when the bit 31 of the mask is set.
-	 * 32 bit shift will cause overflow of 4 byte integer.
-	 */
-	if (num_trips > (BITS_PER_TYPE(int) - 1) || num_trips < 0 || mask >> num_trips) {
+	if (num_trips < 0) {
 		pr_err("Incorrect number of thermal trips\n");
 		return ERR_PTR(-EINVAL);
 	}
@@ -1356,16 +1342,6 @@ thermal_zone_device_register_with_trips(
 	tz->devdata = devdata;
 	tz->trips = trips;
 	tz->num_trips = num_trips;
-	if (num_trips > 0) {
-		struct thermal_trip *trip;
-
-		for_each_trip(tz, trip) {
-			if (mask & 1)
-				trip->flags |= THERMAL_TRIP_WRITABLE_TEMP;
-
-			mask >>= 1;
-		}
-	}
 
 	thermal_set_delay_jiffies(&tz->passive_delay_jiffies, passive_delay);
 	thermal_set_delay_jiffies(&tz->polling_delay_jiffies, polling_delay);
@@ -1450,7 +1426,7 @@ struct thermal_zone_device *thermal_trip
 					struct thermal_zone_device_ops *ops,
 					const struct thermal_zone_params *tzp)
 {
-	return thermal_zone_device_register_with_trips(type, NULL, 0, 0, devdata,
+	return thermal_zone_device_register_with_trips(type, NULL, 0, devdata,
 						       ops, tzp, 0, 0);
 }
 EXPORT_SYMBOL_GPL(thermal_tripless_zone_device_register);
Index: linux-pm/drivers/acpi/thermal.c
===================================================================
--- linux-pm.orig/drivers/acpi/thermal.c
+++ linux-pm/drivers/acpi/thermal.c
@@ -670,7 +670,7 @@ static int acpi_thermal_register_thermal
 	tz->thermal_zone = thermal_zone_device_register_with_trips("acpitz",
 								   tz->trip_table,
 								   trip_count,
-								   0, tz,
+								   tz,
 								   &acpi_thermal_zone_ops,
 								   NULL,
 								   passive_delay,
Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -184,7 +184,7 @@ struct int34x_thermal_zone *int340x_ther
 	int34x_zone->zone = thermal_zone_device_register_with_trips(
 							acpi_device_bid(adev),
 							zone_trips, trip_cnt,
-							0, int34x_zone,
+							int34x_zone,
 							int34x_zone->ops,
 							&int340x_thermal_params,
 							0, 0);
Index: linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -291,7 +291,7 @@ static int proc_thermal_pci_probe(struct
 	psv_trip.temperature = get_trip_temp(pci_info);
 
 	pci_info->tzone = thermal_zone_device_register_with_trips("TCPU_PCI", &psv_trip,
-							1, 0, pci_info,
+							1, pci_info,
 							&tzone_ops,
 							&tzone_params, 0, 0);
 	if (IS_ERR(pci_info->tzone)) {
Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
@@ -235,7 +235,7 @@ read_trips:
 
 	ptd->tzd = thermal_zone_device_register_with_trips(board_names[board_id],
 							   ptd->trips, nr_trips,
-							   0, ptd, &tzd_ops,
+							   ptd, &tzd_ops,
 							   NULL, 0, 0);
 	if (IS_ERR(ptd->tzd)) {
 		dev_err(&pdev->dev, "Failed to register thermal zone %s\n",
Index: linux-pm/drivers/thermal/intel/intel_quark_dts_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_quark_dts_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_quark_dts_thermal.c
@@ -363,7 +363,7 @@ static struct soc_sensor_entry *alloc_so
 	aux_entry->tzone = thermal_zone_device_register_with_trips("quark_dts",
 								   aux_entry->trips,
 								   QRK_MAX_DTS_TRIPS,
-								   0, aux_entry,
+								   aux_entry,
 								   &tzone_ops,
 								   NULL, 0, polling_delay);
 	if (IS_ERR(aux_entry->tzone)) {
Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -229,7 +229,7 @@ static int add_dts_thermal_zone(int id,
 	snprintf(name, sizeof(name), "soc_dts%d", id);
 	dts->tzone = thermal_zone_device_register_with_trips(name, dts->trips,
 							     SOC_MAX_DTS_TRIPS,
-							     0, dts, &tzone_ops,
+							     dts, &tzone_ops,
 							     NULL, 0, 0);
 	if (IS_ERR(dts->tzone)) {
 		ret = PTR_ERR(dts->tzone);
Index: linux-pm/drivers/thermal/intel/x86_pkg_temp_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ linux-pm/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -346,7 +346,7 @@ static int pkg_temp_thermal_device_add(u
 	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
 	zonedev->cpu = cpu;
 	zonedev->tzone = thermal_zone_device_register_with_trips("x86_pkg_temp",
-			zonedev->trips, thres_count, 0,
+			zonedev->trips, thres_count,
 			zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
 	if (IS_ERR(zonedev->tzone)) {
 		err = PTR_ERR(zonedev->tzone);
Index: linux-pm/drivers/thermal/thermal_of.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_of.c
+++ linux-pm/drivers/thermal/thermal_of.c
@@ -518,7 +518,7 @@ static struct thermal_zone_device *therm
 			of_ops->critical = thermal_zone_device_critical_reboot;
 
 	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
-						     0, data, of_ops, &tzp,
+						     data, of_ops, &tzp,
 						     pdelay, delay);
 	if (IS_ERR(tz)) {
 		ret = PTR_ERR(tz);
Index: linux-pm/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
===================================================================
--- linux-pm.orig/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
+++ linux-pm/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
@@ -60,7 +60,7 @@ int cxgb4_thermal_init(struct adapter *a
 
 	snprintf(ch_tz_name, sizeof(ch_tz_name), "cxgb4_%s", adap->name);
 	ch_thermal->tzdev = thermal_zone_device_register_with_trips(ch_tz_name, &trip, num_trip,
-								    0, adap,
+								    adap,
 								    &cxgb4_thermal_ops,
 								    NULL, 0, 0);
 	if (IS_ERR(ch_thermal->tzdev)) {
Index: linux-pm/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
===================================================================
--- linux-pm.orig/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ linux-pm/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -423,7 +423,6 @@ mlxsw_thermal_module_tz_init(struct mlxs
 	module_tz->tzdev = thermal_zone_device_register_with_trips(tz_name,
 							module_tz->trips,
 							MLXSW_THERMAL_NUM_TRIPS,
-							0,
 							module_tz,
 							&mlxsw_thermal_module_ops,
 							&mlxsw_thermal_params,
@@ -551,7 +550,6 @@ mlxsw_thermal_gearbox_tz_init(struct mlx
 	gearbox_tz->tzdev = thermal_zone_device_register_with_trips(tz_name,
 						gearbox_tz->trips,
 						MLXSW_THERMAL_NUM_TRIPS,
-						0,
 						gearbox_tz,
 						&mlxsw_thermal_gearbox_ops,
 						&mlxsw_thermal_params, 0,
@@ -776,7 +774,6 @@ int mlxsw_thermal_init(struct mlxsw_core
 	thermal->tzdev = thermal_zone_device_register_with_trips("mlxsw",
 						      thermal->trips,
 						      MLXSW_THERMAL_NUM_TRIPS,
-						      0,
 						      thermal,
 						      &mlxsw_thermal_ops,
 						      &mlxsw_thermal_params, 0,
Index: linux-pm/drivers/platform/x86/acerhdf.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/acerhdf.c
+++ linux-pm/drivers/platform/x86/acerhdf.c
@@ -678,7 +678,7 @@ static int __init acerhdf_register_therm
 		return -EINVAL;
 
 	thz_dev = thermal_zone_device_register_with_trips("acerhdf", trips, ARRAY_SIZE(trips),
-							  0, NULL, &acerhdf_dev_ops,
+							  NULL, &acerhdf_dev_ops,
 							  &acerhdf_zone_params, 0,
 							  (kernelmode) ? interval*1000 : 0);
 	if (IS_ERR(thz_dev))
Index: linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
===================================================================
--- linux-pm.orig/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ linux-pm/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -694,7 +694,6 @@ static void iwl_mvm_thermal_zone_registe
 	mvm->tz_device.tzone = thermal_zone_device_register_with_trips(name,
 							mvm->tz_device.trips,
 							IWL_MAX_DTS_TRIPS,
-							0,
 							mvm, &tzone_ops,
 							NULL, 0, 0);
 	if (IS_ERR(mvm->tz_device.tzone)) {
Index: linux-pm/drivers/thermal/da9062-thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/da9062-thermal.c
+++ linux-pm/drivers/thermal/da9062-thermal.c
@@ -197,7 +197,7 @@ static int da9062_thermal_probe(struct p
 	mutex_init(&thermal->lock);
 
 	thermal->zone = thermal_zone_device_register_with_trips(thermal->config->name,
-								trips, ARRAY_SIZE(trips), 0, thermal,
+								trips, ARRAY_SIZE(trips), thermal,
 								&da9062_thermal_ops, NULL, pp_tmp,
 								0);
 	if (IS_ERR(thermal->zone)) {
Index: linux-pm/drivers/thermal/imx_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/imx_thermal.c
+++ linux-pm/drivers/thermal/imx_thermal.c
@@ -700,7 +700,7 @@ static int imx_thermal_probe(struct plat
 	data->tz = thermal_zone_device_register_with_trips("imx_thermal_zone",
 							   trips,
 							   ARRAY_SIZE(trips),
-							   0, data,
+							   data,
 							   &imx_tz_ops, NULL,
 							   IMX_PASSIVE_DELAY,
 							   IMX_POLLING_DELAY);
Index: linux-pm/drivers/thermal/rcar_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/rcar_thermal.c
+++ linux-pm/drivers/thermal/rcar_thermal.c
@@ -489,7 +489,7 @@ static int rcar_thermal_probe(struct pla
 						&rcar_thermal_zone_ops);
 		} else {
 			priv->zone = thermal_zone_device_register_with_trips(
-				"rcar_thermal", trips, ARRAY_SIZE(trips), 0, priv,
+				"rcar_thermal", trips, ARRAY_SIZE(trips), priv,
 						&rcar_thermal_zone_ops, NULL, 0,
 						idle);
 
Index: linux-pm/drivers/thermal/st/st_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/st/st_thermal.c
+++ linux-pm/drivers/thermal/st/st_thermal.c
@@ -203,7 +203,7 @@ int st_thermal_register(struct platform_
 	trip.type = THERMAL_TRIP_CRITICAL;
 
 	sensor->thermal_dev =
-		thermal_zone_device_register_with_trips(dev_name(dev), &trip, 1, 0, sensor,
+		thermal_zone_device_register_with_trips(dev_name(dev), &trip, 1, sensor,
 							&st_tz_ops, NULL, 0, polling_delay);
 	if (IS_ERR(sensor->thermal_dev)) {
 		dev_err(dev, "failed to register thermal zone device\n");




