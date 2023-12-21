Return-Path: <linux-kernel+bounces-8392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3848D81B687
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1927B24DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959257C655;
	Thu, 21 Dec 2023 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bA37CyAR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA17BEF0;
	Thu, 21 Dec 2023 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162930;
	bh=afwWvYc7TNNJ91qm8hZuwUj/Kn9qVwfNFnfkz4getTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bA37CyAR/1RM6usgEvYIPl/RV//Z2SY7ur9LbLrlQYOWRuQPPU238ncLEJ7jhS1oa
	 DpAQUk2K++HBTKC0jkdEvhXdIDUkY7jfHG3pCv8NzTcNFgpjvBJvCIHaAKYXVBT89J
	 OQUGDsqZuSw7ZTWi0HoW4k3EYYVmKfiYnspBLwbGFTfq2V6pvUTQZBh5En6pOKU55O
	 ofQyak//8/BevQjIZ61pwtJ+ekrUwsqC1SeALSLd2aevG3ZYcI1pt7GysNHaWFqm0W
	 W2b9XZHtrm7/RXWkbHCu0ijM1F9b0QzSu1MAiWMeX/FA8fA9B+HomoRhMm+72ESRsa
	 Xedk3bRKVZhKQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 79A5A378201A;
	Thu, 21 Dec 2023 12:48:49 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 23/26] mlxsw: core_thermal: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:22 +0100
Message-ID: <20231221124825.149141-24-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
References: <20231221124825.149141-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The thermal API has a new thermal_zone_device_register() function which
is deprecating the older thermal_zone_device_register_with_trips() and
thermal_tripless_zone_device_register().

Migrate to the new thermal zone device registration function.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../ethernet/mellanox/mlxsw/core_thermal.c    | 93 ++++++++++---------
 1 file changed, 50 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index f1b48d6615f6..5ad9f90d096d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -226,10 +226,6 @@ static int mlxsw_thermal_get_temp(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
-static struct thermal_zone_params mlxsw_thermal_params = {
-	.no_hwmon = true,
-};
-
 static struct thermal_zone_device_ops mlxsw_thermal_ops = {
 	.bind = mlxsw_thermal_bind,
 	.unbind = mlxsw_thermal_unbind,
@@ -408,28 +404,30 @@ static const struct thermal_cooling_device_ops mlxsw_cooling_ops = {
 static int
 mlxsw_thermal_module_tz_init(struct mlxsw_thermal_module *module_tz)
 {
-	char tz_name[THERMAL_NAME_LENGTH];
+	struct thermal_zone_device_params tzdp = {
+		.tzp = { .no_hwmon = true },
+		.ops = &mlxsw_thermal_module_ops,
+		.devdata = module_tz,
+		.trips = module_tz->trips,
+		.num_trips = MLXSW_THERMAL_NUM_TRIPS,
+		.mask = MLXSW_THERMAL_TRIP_MASK,
+		.polling_delay = module_tz->parent->polling_delay
+	};
 	int err;
 
 	if (module_tz->slot_index)
-		snprintf(tz_name, sizeof(tz_name), "mlxsw-lc%d-module%d",
-			 module_tz->slot_index, module_tz->module + 1);
+		tzdp.type = kasprintf("mlxsw-lc%d-module%d",
+				      module_tz->slot_index, module_tz->module + 1);
 	else
-		snprintf(tz_name, sizeof(tz_name), "mlxsw-module%d",
-			 module_tz->module + 1);
-	module_tz->tzdev = thermal_zone_device_register_with_trips(tz_name,
-							module_tz->trips,
-							MLXSW_THERMAL_NUM_TRIPS,
-							MLXSW_THERMAL_TRIP_MASK,
-							module_tz,
-							&mlxsw_thermal_module_ops,
-							&mlxsw_thermal_params,
-							0,
-							module_tz->parent->polling_delay);
-	if (IS_ERR(module_tz->tzdev)) {
-		err = PTR_ERR(module_tz->tzdev);
-		return err;
-	}
+		tzdp.type = kasprintf("mlxsw-module%d", module_tz->module + 1);
+
+	if (!tzdp.type)
+		return -ENOMEM;
+
+	module_tz->tzdev = thermal_zone_device_register(&tzdp);
+	kfree(tzdp.type);
+	if (IS_ERR(module_tz->tzdev))
+		return PTR_ERR(module_tz->tzdev);
 
 	err = thermal_zone_device_enable(module_tz->tzdev);
 	if (err)
@@ -536,23 +534,28 @@ mlxsw_thermal_modules_fini(struct mlxsw_thermal *thermal,
 static int
 mlxsw_thermal_gearbox_tz_init(struct mlxsw_thermal_module *gearbox_tz)
 {
-	char tz_name[40];
+	struct thermal_zone_device_params tzdp = {
+		.tzp = { .no_hwmon = true },
+		.ops = &mlxsw_thermal_gearbox_ops,
+		.devdata = gearbox_tz,
+		.trips = gearbox_tz->trips,
+		.num_trips = MLXSW_THERMAL_NUM_TRIPS,
+		.mask = MLXSW_THERMAL_TRIP_MASK,
+		.polling_delay = gearbox_tz->parent->polling_delay
+	};
 	int ret;
 
 	if (gearbox_tz->slot_index)
-		snprintf(tz_name, sizeof(tz_name), "mlxsw-lc%d-gearbox%d",
-			 gearbox_tz->slot_index, gearbox_tz->module + 1);
+		tzdp.type = kasprintf("mlxsw-lc%d-gearbox%d",
+				      gearbox_tz->slot_index, gearbox_tz->module + 1);
 	else
-		snprintf(tz_name, sizeof(tz_name), "mlxsw-gearbox%d",
-			 gearbox_tz->module + 1);
-	gearbox_tz->tzdev = thermal_zone_device_register_with_trips(tz_name,
-						gearbox_tz->trips,
-						MLXSW_THERMAL_NUM_TRIPS,
-						MLXSW_THERMAL_TRIP_MASK,
-						gearbox_tz,
-						&mlxsw_thermal_gearbox_ops,
-						&mlxsw_thermal_params, 0,
-						gearbox_tz->parent->polling_delay);
+		tzdp.type = kasprintf("mlxsw-gearbox%d", gearbox_tz->module + 1);
+
+	if (!tzdp.type)
+		return -ENOMEM;
+
+	gearbox_tz->tzdev = thermal_zone_device_register(&tzdp);
+	kfree(tzdp.type);
 	if (IS_ERR(gearbox_tz->tzdev))
 		return PTR_ERR(gearbox_tz->tzdev);
 
@@ -695,6 +698,12 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 		       const struct mlxsw_bus_info *bus_info,
 		       struct mlxsw_thermal **p_thermal)
 {
+	struct thermal_zone_device_params tzdp = {
+		.type = "mlxsw",
+		.tzp = { .no_hwmon = true },
+		.ops = &mlxsw_thermal_ops,
+		.mask = MLXSW_THERMAL_TRIP_MASK
+	};
 	char mfcr_pl[MLXSW_REG_MFCR_LEN] = { 0 };
 	enum mlxsw_reg_mfcr_pwm_frequency freq;
 	struct device *dev = bus_info->dev;
@@ -770,14 +779,12 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 				 MLXSW_THERMAL_SLOW_POLL_INT :
 				 MLXSW_THERMAL_POLL_INT;
 
-	thermal->tzdev = thermal_zone_device_register_with_trips("mlxsw",
-						      thermal->trips,
-						      MLXSW_THERMAL_NUM_TRIPS,
-						      MLXSW_THERMAL_TRIP_MASK,
-						      thermal,
-						      &mlxsw_thermal_ops,
-						      &mlxsw_thermal_params, 0,
-						      thermal->polling_delay);
+	tzdp.devdata = thermal;
+	tzdp.trips = thermal->trips;
+	tzdp.num_trips = MLXSW_THERMAL_NUM_TRIPS;
+	tzdp.polling_delay = thermal->polling_delay;
+
+	thermal->tzdev = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(thermal->tzdev)) {
 		err = PTR_ERR(thermal->tzdev);
 		dev_err(dev, "Failed to register thermal zone\n");
-- 
2.43.0


