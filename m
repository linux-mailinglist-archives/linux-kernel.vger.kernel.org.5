Return-Path: <linux-kernel+bounces-59437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3818284F71E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48866B228B3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F6D7B3CA;
	Fri,  9 Feb 2024 14:14:52 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E026A76030;
	Fri,  9 Feb 2024 14:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488091; cv=none; b=iIc9OP4zGRWic6WH6vgulM8m7ww6KOMjPzFtslPg62oOLfg3zDLCkq34UqNmseWBF4OfLdA/xug2ibPRx3TIL9HKC4Q1Iqqr0rCfDwYT2mu7w4AhjXrZEgaVcRkQW+8CSCGfZ1p/x5OeQ4C6P/vLMcp93KKUwNYSoQu7G+qh6YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488091; c=relaxed/simple;
	bh=+KbFPLKFarXbzcGKuv+nofQctSKPrpZXPXB6iN4Pydk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLl/hZ7dFrEj2lsiN/D2Wwp3JuawQWnMormPc5eBGx1wzHEYfoCkLG4g5LTdcTUus7fO8t06vpE5JD1CgaEGqvZWglcAOgyb5P1ANrWRUrsrAZTD7JVW89lv+gjR+cTn1GQInDWrej33WFebNZawaNLnY7x0l0ztjmWwnidQj8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 84c3107030d7e6c7; Fri, 9 Feb 2024 15:14:45 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 39131669C4D;
	Fri,  9 Feb 2024 15:14:45 +0100 (CET)
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
Subject:
 [PATCH v1 4/9] thermal: intel: Set THERMAL_TRIP_WRITABLE_TEMP directly
Date: Fri, 09 Feb 2024 15:07:48 +0100
Message-ID: <2619930.Lt9SDvczpP@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigdeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeduiedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsthgr
 nhhishhlrgifrdhgrhhushiikhgrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepshhrihhnihhvrghsrdhprghnughruhhvrggurgeslhhinhhugidrihhnthgvlhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=16 Fuz1=16 Fuz2=16

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some Intel thermal drivers need/want the temperature of their trip
points to be set by user space via sysfs and so they pass nonzero
writable trip masks during thermal zone registration for this purpose.

It is now possible to achieve the same result by setting the
THERMAL_TRIP_WRITABLE_TEMP trip flag directly, so modify the drivers
in question to do that instead of using a nonzero writable trips mask.

No intentional functional impact.

Note that this change is requisite for dropping the mask argument from
thermal_zone_device_register_with_trips() going forward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c         |    8 -
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c |    3 
 drivers/thermal/intel/intel_quark_dts_thermal.c                      |   20 --
 drivers/thermal/intel/intel_soc_dts_iosf.c                           |   73 ++++------
 drivers/thermal/intel/intel_soc_dts_iosf.h                           |    1 
 drivers/thermal/intel/x86_pkg_temp_thermal.c                         |    4 
 6 files changed, 43 insertions(+), 66 deletions(-)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -130,7 +130,6 @@ struct int34x_thermal_zone *int340x_ther
 	struct thermal_trip *zone_trips;
 	unsigned long long trip_cnt = 0;
 	unsigned long long hyst;
-	int trip_mask = 0;
 	acpi_status status;
 	int i, ret;
 
@@ -151,10 +150,8 @@ struct int34x_thermal_zone *int340x_ther
 		int34x_zone->ops->get_temp = get_temp;
 
 	status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
-	if (ACPI_SUCCESS(status)) {
+	if (ACPI_SUCCESS(status))
 		int34x_zone->aux_trip_nr = trip_cnt;
-		trip_mask = BIT(trip_cnt) - 1;
-	}
 
 	zone_trips = kzalloc(sizeof(*zone_trips) * (trip_cnt + INT340X_THERMAL_MAX_TRIP_COUNT),
 			     GFP_KERNEL);
@@ -166,6 +163,7 @@ struct int34x_thermal_zone *int340x_ther
 	for (i = 0; i < trip_cnt; i++) {
 		zone_trips[i].type = THERMAL_TRIP_PASSIVE;
 		zone_trips[i].temperature = THERMAL_TEMP_INVALID;
+		zone_trips[i].flags |= THERMAL_TRIP_WRITABLE_TEMP;
 	}
 
 	trip_cnt = int340x_thermal_read_trips(adev, zone_trips, trip_cnt);
@@ -186,7 +184,7 @@ struct int34x_thermal_zone *int340x_ther
 	int34x_zone->zone = thermal_zone_device_register_with_trips(
 							acpi_device_bid(adev),
 							zone_trips, trip_cnt,
-							trip_mask, int34x_zone,
+							0, int34x_zone,
 							int34x_zone->ops,
 							&int340x_thermal_params,
 							0, 0);
Index: linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -235,6 +235,7 @@ static int get_trip_temp(struct proc_the
 
 static struct thermal_trip psv_trip = {
 	.type = THERMAL_TRIP_PASSIVE,
+	.flags = THERMAL_TRIP_WRITABLE_TEMP,
 };
 
 static struct thermal_zone_device_ops tzone_ops = {
@@ -290,7 +291,7 @@ static int proc_thermal_pci_probe(struct
 	psv_trip.temperature = get_trip_temp(pci_info);
 
 	pci_info->tzone = thermal_zone_device_register_with_trips("TCPU_PCI", &psv_trip,
-							1, 1, pci_info,
+							1, 0, pci_info,
 							&tzone_ops,
 							&tzone_params, 0, 0);
 	if (IS_ERR(pci_info->tzone)) {
Index: linux-pm/drivers/thermal/intel/intel_quark_dts_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_quark_dts_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_quark_dts_thermal.c
@@ -93,10 +93,6 @@
 
 /* Quark DTS has 2 trip points: hot & catastrophic */
 #define QRK_MAX_DTS_TRIPS	2
-/* If DTS not locked, all trip points are configurable */
-#define QRK_DTS_WR_MASK_SET	0x3
-/* If DTS locked, all trip points are not configurable */
-#define QRK_DTS_WR_MASK_CLR	0
 
 #define DEFAULT_POLL_DELAY	2000
 
@@ -323,7 +319,6 @@ static struct soc_sensor_entry *alloc_so
 	struct soc_sensor_entry *aux_entry;
 	int err;
 	u32 out;
-	int wr_mask;
 
 	aux_entry = kzalloc(sizeof(*aux_entry), GFP_KERNEL);
 	if (!aux_entry) {
@@ -337,13 +332,7 @@ static struct soc_sensor_entry *alloc_so
 	if (err)
 		goto err_ret;
 
-	if (out & QRK_DTS_LOCK_BIT) {
-		aux_entry->locked = true;
-		wr_mask = QRK_DTS_WR_MASK_CLR;
-	} else {
-		aux_entry->locked = false;
-		wr_mask = QRK_DTS_WR_MASK_SET;
-	}
+	aux_entry->locked = !!(out & QRK_DTS_LOCK_BIT);
 
 	/* Store DTS default state if DTS registers are not locked */
 	if (!aux_entry->locked) {
@@ -360,6 +349,9 @@ static struct soc_sensor_entry *alloc_so
 				    &aux_entry->store_ptps);
 		if (err)
 			goto err_ret;
+
+		trips[QRK_DTS_ID_TP_CRITICAL].flags |= THERMAL_TRIP_WRITABLE_TEMP;
+		trips[QRK_DTS_ID_TP_HOT].flags |= THERMAL_TRIP_WRITABLE_TEMP;
 	}
 
 	aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].temperature = get_trip_temp(QRK_DTS_ID_TP_CRITICAL);
@@ -371,8 +363,8 @@ static struct soc_sensor_entry *alloc_so
 	aux_entry->tzone = thermal_zone_device_register_with_trips("quark_dts",
 								   aux_entry->trips,
 								   QRK_MAX_DTS_TRIPS,
-								   wr_mask,
-								   aux_entry, &tzone_ops,
+								   0, aux_entry,
+								   &tzone_ops,
 								   NULL, 0, polling_delay);
 	if (IS_ERR(aux_entry->tzone)) {
 		err = PTR_ERR(aux_entry->tzone);
Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -129,22 +129,6 @@ err_restore_ptps:
 	return status;
 }
 
-static int configure_trip(struct intel_soc_dts_sensor_entry *dts,
-			  int thres_index, enum thermal_trip_type trip_type,
-			  int temp)
-{
-	int ret;
-
-	ret = update_trip_temp(dts->sensors, thres_index, temp);
-	if (ret)
-		return ret;
-
-	dts->trips[thres_index].temperature = temp;
-	dts->trips[thres_index].type = trip_type;
-
-	return 0;
-}
-
 static int sys_set_trip_temp(struct thermal_zone_device *tzd, int trip,
 			     int temp)
 {
@@ -217,16 +201,10 @@ static void remove_dts_thermal_zone(stru
 	thermal_zone_device_unregister(dts->tzone);
 }
 
-static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
-				bool critical_trip)
+static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts)
 {
-	int writable_trip_cnt = SOC_MAX_DTS_TRIPS;
 	char name[10];
-	unsigned long trip;
-	int trip_mask;
-	unsigned long ptps;
 	u32 store_ptps;
-	unsigned long i;
 	int ret;
 
 	/* Store status to restor on exit */
@@ -237,27 +215,21 @@ static int add_dts_thermal_zone(int id,
 
 	dts->id = id;
 
-	if (critical_trip)
-		writable_trip_cnt--;
-
-	trip_mask = GENMASK(writable_trip_cnt - 1, 0);
-
 	/* Check if the writable trip we provide is not used by BIOS */
 	ret = iosf_mbi_read(BT_MBI_UNIT_PMC, MBI_REG_READ,
 			    SOC_DTS_OFFSET_PTPS, &store_ptps);
-	if (ret)
-		trip_mask = 0;
-	else {
-		ptps = store_ptps;
-		for_each_set_clump8(i, trip, &ptps, writable_trip_cnt * 8)
-			trip_mask &= ~BIT(i / 8);
+	if (!ret) {
+		int i;
+
+		for (i = 0; i <= 1; i++) {
+			if (store_ptps & (0xFFU << i * 8))
+				dts->trips[i].flags &= ~THERMAL_TRIP_WRITABLE_TEMP;
+		}
 	}
-	dts->trip_mask = trip_mask;
 	snprintf(name, sizeof(name), "soc_dts%d", id);
 	dts->tzone = thermal_zone_device_register_with_trips(name, dts->trips,
 							     SOC_MAX_DTS_TRIPS,
-							     trip_mask,
-							     dts, &tzone_ops,
+							     0, dts, &tzone_ops,
 							     NULL, 0, 0);
 	if (IS_ERR(dts->tzone)) {
 		ret = PTR_ERR(dts->tzone);
@@ -315,8 +287,16 @@ EXPORT_SYMBOL_GPL(intel_soc_dts_iosf_int
 
 static void dts_trips_reset(struct intel_soc_dts_sensors *sensors, int dts_index)
 {
-	configure_trip(&sensors->soc_dts[dts_index], 0, 0, 0);
-	configure_trip(&sensors->soc_dts[dts_index], 1, 0, 0);
+	update_trip_temp(sensors, 0, 0);
+	update_trip_temp(sensors, 1, 0);
+}
+
+static void set_trip(struct thermal_trip *trip, enum thermal_trip_type type,
+		     u8 flags, int temp)
+{
+	trip->type = type;
+	trip->flags = flags;
+	trip->temperature = temp;
 }
 
 struct intel_soc_dts_sensors *
@@ -346,29 +326,36 @@ intel_soc_dts_iosf_init(enum intel_soc_d
 
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
 		enum thermal_trip_type trip_type;
+		u8 trip_flags;
 		int temp;
 
 		sensors->soc_dts[i].sensors = sensors;
 
-		ret = configure_trip(&sensors->soc_dts[i], 0,
-				     THERMAL_TRIP_PASSIVE, 0);
+		ret = update_trip_temp(sensors, 0, 0);
 		if (ret)
 			goto err_reset_trips;
 
+		set_trip(&sensors->soc_dts[i].trips[0], THERMAL_TRIP_PASSIVE,
+			 THERMAL_TRIP_WRITABLE_TEMP, 0);
+
 		if (critical_trip) {
 			trip_type = THERMAL_TRIP_CRITICAL;
+			trip_flags = 0;
 			temp = sensors->tj_max - crit_offset;
 		} else {
 			trip_type = THERMAL_TRIP_PASSIVE;
+			trip_flags = THERMAL_TRIP_WRITABLE_TEMP;
 			temp = 0;
 		}
-		ret = configure_trip(&sensors->soc_dts[i], 1, trip_type, temp);
+		ret = update_trip_temp(sensors, 1, temp);
 		if (ret)
 			goto err_reset_trips;
+
+		set_trip(&sensors->soc_dts[i].trips[1], trip_type, trip_flags, temp);
 	}
 
 	for (i = 0; i < SOC_MAX_DTS_SENSORS; ++i) {
-		ret = add_dts_thermal_zone(i, &sensors->soc_dts[i], critical_trip);
+		ret = add_dts_thermal_zone(i, &sensors->soc_dts[i]);
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
-	u32 trip_mask;
 	struct thermal_trip trips[SOC_MAX_DTS_TRIPS];
 	struct thermal_zone_device *tzone;
 	struct intel_soc_dts_sensors *sensors;
Index: linux-pm/drivers/thermal/intel/x86_pkg_temp_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ linux-pm/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -302,6 +302,7 @@ static struct thermal_trip *pkg_temp_the
 			tj_max - thres_reg_value * 1000 : THERMAL_TEMP_INVALID;
 
 		trips[i].type = THERMAL_TRIP_PASSIVE;
+		trips[i].flags |= THERMAL_TRIP_WRITABLE_TEMP;
 
 		pr_debug("%s: cpu=%d, trip=%d, temp=%d\n",
 			 __func__, cpu, i, trips[i].temperature);
@@ -345,8 +346,7 @@ static int pkg_temp_thermal_device_add(u
 	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
 	zonedev->cpu = cpu;
 	zonedev->tzone = thermal_zone_device_register_with_trips("x86_pkg_temp",
-			zonedev->trips, thres_count,
-			(thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
+			zonedev->trips, thres_count, 0,
 			zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
 	if (IS_ERR(zonedev->tzone)) {
 		err = PTR_ERR(zonedev->tzone);




