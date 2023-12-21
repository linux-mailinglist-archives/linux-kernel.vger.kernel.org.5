Return-Path: <linux-kernel+bounces-8380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D31681B66B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23FBC285A82
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0709478E70;
	Thu, 21 Dec 2023 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tAR+vkKM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D0F77650;
	Thu, 21 Dec 2023 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162921;
	bh=amWRBEfS8645R/5+LBfYIOcKFJwKDzDQq6B0ItRjNNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tAR+vkKMQ1u39cVeSDh2DBCkh9XH9qAL22s3UcNkoWfrbVuDHBMY60t4Tor+DLFp6
	 4geaYoSj0SqKLFS7j+RfsM69lJ8xwkEpMmnwY6S2zIhrjNYLUh0vYTwErGLCwXwjvO
	 foC0mdYFf3hBx2cxqI1Hi8vepM/0RsIUOEEXIhRuzqp5KVjGTqAyLGKWUVnd/754EG
	 xmwNloeo32TNFu9rHHBephIMgTaY1p4dszg/9hoK6hcEpwjbDfPvy0vz9w/5IFjtMH
	 1YSBUjj/vQibIgSVVuY3zf+nBHGrbEdmcZSY8q20devOG0gsMTigtorTVaqv1dcVEq
	 oQGe1++PdpW/w==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 161803782016;
	Thu, 21 Dec 2023 12:48:41 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 12/26] thermal: intel: int340x: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:11 +0100
Message-ID: <20231221124825.149141-13-angelogioacchino.delregno@collabora.com>
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
 .../int340x_thermal/int340x_thermal_zone.c    | 28 +++++++++----------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
index a03b67579dd9..431f09ef65e6 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -118,19 +118,19 @@ static int int340x_thermal_read_trips(struct acpi_device *zone_adev,
 	return trip_cnt;
 }
 
-static struct thermal_zone_params int340x_thermal_params = {
-	.governor_name = "user_space",
-	.no_hwmon = true,
-};
-
 struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 						     int (*get_temp) (struct thermal_zone_device *, int *))
 {
+	struct thermal_zone_device_params tzdp = {
+		.tzp = {
+			.governor_name = "user_space",
+			.no_hwmon = true,
+		}
+	};
 	struct int34x_thermal_zone *int34x_zone;
 	struct thermal_trip *zone_trips;
 	unsigned long long trip_cnt = 0;
 	unsigned long long hyst;
-	int trip_mask = 0;
 	acpi_status status;
 	int i, ret;
 
@@ -153,7 +153,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 	status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
 	if (ACPI_SUCCESS(status)) {
 		int34x_zone->aux_trip_nr = trip_cnt;
-		trip_mask = BIT(trip_cnt) - 1;
+		tzdp.mask = BIT(trip_cnt) - 1;
 	}
 
 	zone_trips = kzalloc(sizeof(*zone_trips) * (trip_cnt + INT340X_THERMAL_MAX_TRIP_COUNT),
@@ -183,13 +183,13 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 
 	int34x_zone->lpat_table = acpi_lpat_get_conversion_table(adev->handle);
 
-	int34x_zone->zone = thermal_zone_device_register_with_trips(
-							acpi_device_bid(adev),
-							zone_trips, trip_cnt,
-							trip_mask, int34x_zone,
-							int34x_zone->ops,
-							&int340x_thermal_params,
-							0, 0);
+	tzdp.type = acpi_device_bid(adev);
+	tzdp.ops = int34x_zone->ops;
+	tzdp.devdata = int34x_zone;
+	tzdp.trips = zone_trips;
+	tzdp.num_trips = trip_cnt;
+
+	int34x_zone->zone = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(int34x_zone->zone)) {
 		ret = PTR_ERR(int34x_zone->zone);
 		goto err_thermal_zone;
-- 
2.43.0


