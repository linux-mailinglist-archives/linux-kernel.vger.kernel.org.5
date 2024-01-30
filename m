Return-Path: <linux-kernel+bounces-44480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEB88422A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C7F1C24839
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE6274E17;
	Tue, 30 Jan 2024 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="oEg3xFX7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF56EB65;
	Tue, 30 Jan 2024 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613217; cv=none; b=rZQwgzPo6l44BJPVTAyMS+3yEqNSMClciEx0ufiUfbum2+9oMWJ9tm5TPpsiHcJqjZk1xLX0AHJc3stxiASJAXEkzKRyhZh8UgLMR8ld+bPY291KQ70fb6Ow0NNFlREXP3svVbSNqwNhirNR4E8/fT4Ca8iIt3lQv5dbvwuyALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613217; c=relaxed/simple;
	bh=Cr03L1qxC5Q5WcLgoejwkJaADJOROHbQJiExrCsEGkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5l/3C8Yhq0VRCmLNk50JOrmmIuURjyn/XHCQBcq820Cg1iNzRLBkWViKbJIQeOmTfJ+r43jCd0V/wsClkBFRDwrzwLSHAmRMCNpnnQltWioua7iQMPwIU2T0+5+8lT3XH2EwpZIleeGco3gncF2JD52WuybzoNPnC3mLIQSQTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=oEg3xFX7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613214;
	bh=Cr03L1qxC5Q5WcLgoejwkJaADJOROHbQJiExrCsEGkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oEg3xFX7Jo2dtz39P1RXwHf92Vd+CpqUiqOfyEun+kFMsXU5d1P7gO3hdBRg5tOLj
	 YEmmprOkAwFT7346a1DvKeVi34HfmxdmxAaIZCeyDaN1I4GNAzdC01KHfvDZ9DxSKj
	 7kkV5gAZBwaNm464JDkFnr9lttUHscHadJ+qAZLRJw4GkxtQQkRD0Aj6YoZJY/1vRa
	 UE0bkqA7vN2O+VbW6hsmdQvMBTjgZvij+wIQDiR83c9DSMuL17CimRsKTw3Bedd1pQ
	 hIsVqzE96wp2Y7rFG3YUlQ6hzxeafJuqJoWUSm0dIxaBJAw3a/Mp77jNj3wa1wkcKV
	 KcDTQWuxsxPXQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 563763780FC7;
	Tue, 30 Jan 2024 11:13:32 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: miquel.raynal@bootlin.com,
	rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	support.opensource@diasemi.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	niklas.soderlund@ragnatech.se,
	srinivas.pandruvada@linux.intel.com,
	angelogioacchino.delregno@collabora.com,
	baolin.wang@linux.alibaba.com,
	u.kleine-koenig@pengutronix.de,
	hayashi.kunihiko@socionext.com,
	d-gole@ti.com,
	linus.walleij@linaro.org,
	DLG-Adam.Ward.opensource@dm.renesas.com,
	error27@gmail.com,
	heiko@sntech.de,
	hdegoede@redhat.com,
	jernej.skrabec@gmail.com,
	f.fainelli@gmail.com,
	bchihi@baylibre.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v1 11/18] thermal: intel: int340x: Migrate to thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:43 +0100
Message-ID: <20240130111250.185718-12-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
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
index 3e4bfe817fac..e45fdd36db55 100644
--- a/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -118,19 +118,17 @@ static int int340x_thermal_read_trips(struct acpi_device *zone_adev,
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
+	struct thermal_governor_params tgp = {
+		.governor_name = "user_space"
+	};
 	struct int34x_thermal_zone *int34x_zone;
+	struct thermal_zone_device_params tzdp;
 	struct thermal_trip *zone_trips;
 	unsigned long long trip_cnt = 0;
 	unsigned long long hyst;
-	int trip_mask = 0;
 	acpi_status status;
 	int i, ret;
 
@@ -153,7 +151,7 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 	status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
 	if (ACPI_SUCCESS(status)) {
 		int34x_zone->aux_trip_nr = trip_cnt;
-		trip_mask = BIT(trip_cnt) - 1;
+		tzdp.tzp.mask = BIT(trip_cnt) - 1;
 	}
 
 	zone_trips = kzalloc(sizeof(*zone_trips) * (trip_cnt + INT340X_THERMAL_MAX_TRIP_COUNT),
@@ -183,13 +181,15 @@ struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
 
 	int34x_zone->lpat_table = acpi_lpat_get_conversion_table(adev->handle);
 
-	int34x_zone->zone = thermal_zone_device_register_with_trips(
-							acpi_device_bid(adev),
-							zone_trips, trip_cnt,
-							trip_mask, int34x_zone,
-							int34x_zone->ops,
-							&int340x_thermal_params,
-							0, 0);
+	tzdp.tzp.type = acpi_device_bid(adev);
+	tzdp.tzp.ops = int34x_zone->ops;
+	tzdp.tzp.devdata = int34x_zone;
+	tzdp.tzp.trips = zone_trips;
+	tzdp.tzp.num_trips = trip_cnt;
+	tzdp.tzp.no_hwmon = true;
+	tzdp.tgp = &tgp;
+
+	int34x_zone->zone = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(int34x_zone->zone)) {
 		ret = PTR_ERR(int34x_zone->zone);
 		goto err_thermal_zone;
-- 
2.43.0


