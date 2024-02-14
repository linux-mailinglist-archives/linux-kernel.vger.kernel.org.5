Return-Path: <linux-kernel+bounces-65211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FFD854990
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220DA28560D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991155336C;
	Wed, 14 Feb 2024 12:50:05 +0000 (UTC)
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0023487BC;
	Wed, 14 Feb 2024 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707915004; cv=none; b=DjwXiE1Ih2UQgSoCZWinVgrS76wa2NzpShiXmzVfV05H1B42xQr6dKf5Js5cnvG+DdcTrsvH6sjZNcaM3SRVsL1IpqtDV35T9/kq3FASbkDfsxldWIzOHwPwJhm1gaUqRu1/6ywvrxRwVzi85vOfDMnr7MTvu+79HB5bVOrnydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707915004; c=relaxed/simple;
	bh=025zc1LDVoUvaWbk7sNmJUJz5pu2gGD8HXd5JAmh5sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EVUX/bmBImivwZs7AxGGajJ3+uvxlgW0jeLGwqXH1ebk8l9aKIWmwJxeZXmPUWhqBB4m3S1Ms+lN8yZM7da4TxPH+B06OzQQfFdDcsgVpV4YgYybu21hOuHCP4OqweoOai43CEa/d0g6UM+blHXUFuOrY1SOw0tYiGxf08SOgts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 43f8bf5cd5d58855; Wed, 14 Feb 2024 13:49:54 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B9BB4669DCB;
	Wed, 14 Feb 2024 13:49:53 +0100 (CET)
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
 [PATCH v2 6/6] thermal: intel: Adjust ops handling during thermal zone
 registration
Date: Wed, 14 Feb 2024 13:49:41 +0100
Message-ID: <3213551.5fSG56mABF@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrudejgdeggecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
 thhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomhdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=14 Fuz1=14

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Because thermal zone operations are now stored directly in struct
thermal_zone_device, thermal zone creators can discard the operations
structure after the zone registration is complete, or it can be made
read-only.

Accordingly, make int340x_thermal_zone_add() use a local variable to
represent thermal zone operations, so it is freed automatically upon the
function exit, and make the other Intel thermal drivers use const zone
operations structures.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
---

v1 -> v2:
   * Rebase.
   * Add R-by from Stanislaw.

---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c         |   26 ++--------
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h         |    1 
 drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c |    2 
 drivers/thermal/intel/intel_pch_thermal.c                            |    2 
 drivers/thermal/intel/intel_quark_dts_thermal.c                      |    2 
 drivers/thermal/intel/intel_soc_dts_iosf.c                           |    2 
 drivers/thermal/intel/x86_pkg_temp_thermal.c                         |    2 
 7 files changed, 11 insertions(+), 26 deletions(-)

Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -61,12 +61,6 @@ static void int340x_thermal_critical(str
 	dev_dbg(&zone->device, "%s: critical temperature reached\n", zone->type);
 }
 
-static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
-	.get_temp       = int340x_thermal_get_zone_temp,
-	.set_trip_temp	= int340x_thermal_set_trip_temp,
-	.critical	= int340x_thermal_critical,
-};
-
 static inline void *int_to_trip_priv(int i)
 {
 	return (void *)(long)i;
@@ -126,6 +120,11 @@ static struct thermal_zone_params int340
 struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 						     int (*get_temp) (struct thermal_zone_device *, int *))
 {
+	const struct thermal_zone_device_ops zone_ops = {
+		.set_trip_temp = int340x_thermal_set_trip_temp,
+		.critical = int340x_thermal_critical,
+		.get_temp = get_temp ? get_temp : int340x_thermal_get_zone_temp,
+	};
 	struct int34x_thermal_zone *int34x_zone;
 	struct thermal_trip *zone_trips;
 	unsigned long long trip_cnt = 0;
@@ -139,16 +138,6 @@ struct int34x_thermal_zone *int340x_ther
 
 	int34x_zone->adev = adev;
 
-	int34x_zone->ops = kmemdup(&int340x_thermal_zone_ops,
-				   sizeof(int340x_thermal_zone_ops), GFP_KERNEL);
-	if (!int34x_zone->ops) {
-		ret = -ENOMEM;
-		goto err_ops_alloc;
-	}
-
-	if (get_temp)
-		int34x_zone->ops->get_temp = get_temp;
-
 	status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
 	if (ACPI_SUCCESS(status))
 		int34x_zone->aux_trip_nr = trip_cnt;
@@ -183,7 +172,7 @@ struct int34x_thermal_zone *int340x_ther
 							acpi_device_bid(adev),
 							zone_trips, trip_cnt,
 							int34x_zone,
-							int34x_zone->ops,
+							&zone_ops,
 							&int340x_thermal_params,
 							0, 0);
 	kfree(zone_trips);
@@ -203,8 +192,6 @@ err_enable:
 err_thermal_zone:
 	acpi_lpat_free_conversion_table(int34x_zone->lpat_table);
 err_trips_alloc:
-	kfree(int34x_zone->ops);
-err_ops_alloc:
 	kfree(int34x_zone);
 	return ERR_PTR(ret);
 }
@@ -214,7 +201,6 @@ void int340x_thermal_zone_remove(struct
 {
 	thermal_zone_device_unregister(int34x_zone->zone);
 	acpi_lpat_free_conversion_table(int34x_zone->lpat_table);
-	kfree(int34x_zone->ops);
 	kfree(int34x_zone);
 }
 EXPORT_SYMBOL_GPL(int340x_thermal_zone_remove);
Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.h
@@ -22,7 +22,6 @@ struct int34x_thermal_zone {
 	struct acpi_device *adev;
 	int aux_trip_nr;
 	struct thermal_zone_device *zone;
-	struct thermal_zone_device_ops *ops;
 	void *priv_data;
 	struct acpi_lpat_conversion_table *lpat_table;
 };
Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
@@ -132,7 +132,7 @@ static void pch_critical(struct thermal_
 		thermal_zone_device_type(tzd));
 }
 
-static struct thermal_zone_device_ops tzd_ops = {
+static const struct thermal_zone_device_ops tzd_ops = {
 	.get_temp = pch_thermal_get_temp,
 	.critical = pch_critical,
 };
Index: linux-pm/drivers/thermal/intel/intel_quark_dts_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_quark_dts_thermal.c
+++ linux-pm/drivers/thermal/intel/intel_quark_dts_thermal.c
@@ -288,7 +288,7 @@ static int sys_change_mode(struct therma
 	return ret;
 }
 
-static struct thermal_zone_device_ops tzone_ops = {
+static const struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
 	.set_trip_temp = sys_set_trip_temp,
 	.change_mode = sys_change_mode,
Index: linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -233,7 +233,7 @@ static int get_trip_temp(struct proc_the
 	return temp;
 }
 
-static struct thermal_zone_device_ops tzone_ops = {
+static const struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
 	.set_trip_temp	= sys_set_trip_temp,
 };
Index: linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ linux-pm/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -168,7 +168,7 @@ static int sys_get_curr_temp(struct ther
 	return 0;
 }
 
-static struct thermal_zone_device_ops tzone_ops = {
+static const struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
 	.set_trip_temp = sys_set_trip_temp,
 };
Index: linux-pm/drivers/thermal/intel/x86_pkg_temp_thermal.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ linux-pm/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -166,7 +166,7 @@ sys_set_trip_temp(struct thermal_zone_de
 }
 
 /* Thermal zone callback registry */
-static struct thermal_zone_device_ops tzone_ops = {
+static const struct thermal_zone_device_ops tzone_ops = {
 	.get_temp = sys_get_curr_temp,
 	.set_trip_temp = sys_set_trip_temp,
 };




