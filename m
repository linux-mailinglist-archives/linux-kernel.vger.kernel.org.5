Return-Path: <linux-kernel+bounces-44479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C91084229F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C095C290C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA9B6EB66;
	Tue, 30 Jan 2024 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qPNQW+T2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4166DD09;
	Tue, 30 Jan 2024 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613215; cv=none; b=ZgBlxaFh11kKCwPQ48q92nK3gRicQO38pYtnHXcNkEnMA+zBep3zeV5WSIo5z2QZJYhrZIwFNWahhRqc7S3f+XAUEQO/82PK8bqiIk/k17JSL0fHk7k5heuG66IFKqgT3WuqT1crTKUst6vObbtLHKIna7E+XrQhkmDbjJfbwlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613215; c=relaxed/simple;
	bh=xF+/wSXIq5fE1Hx9RSY2i9M69cbEXmtjt5ngzeA8uxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qREj2fU4Okjw9eOl2i0lhkp5CMxDl5ihQBZmI5XfZrPRP1Ef6/KLL2R7SFLEkOGEi7cUBWfXWH2Jox0RkgPzb9q4uE/cnepsKdPdtrHTzFLDOhdBW62HVgfJnYmbnbIVDttneMfkKH43hhwKhiLnPLQbDbRRX3TpM570MYPlqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qPNQW+T2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613212;
	bh=xF+/wSXIq5fE1Hx9RSY2i9M69cbEXmtjt5ngzeA8uxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qPNQW+T201OxgVKSszDbRWd4p2jvdQZiIVNgD0+YhC88KZXrs8xyKLIoqBhTBe9n9
	 ZpYyl7yX7PLi3/dqS+rkh8PfILSkQvsk3thd0Lm6P3wr7rdcu04lDun1EqwB4Lx7iq
	 3G17PLpzNJ6mHBUYU2R3Js8SUe2oK6B0Kve84Ab1n5Uuu1j5wwEiqeFqA2qU1qg+Dw
	 b8s+24AN+Cw+I/M3KOknDvG04jW9+PTzAOAX6NZ6uojs0pQI8gyapk7lnXJFjP6Oky
	 txbeThlekjBx0ybhCGCWhXZuBpSGVyBQRzlAcaGvROTGSrICiKWNrOBPXLKHvnVicY
	 l3EZfinvdpXLw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 220C23782084;
	Tue, 30 Jan 2024 11:13:30 +0000 (UTC)
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
Subject: [PATCH v1 10/18] thermal: intel: soc_dts_iosf: Migrate to thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:42 +0100
Message-ID: <20240130111250.185718-11-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/intel/intel_soc_dts_iosf.c | 24 +++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index d00def3c4703..78dceb117ed8 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -220,8 +220,15 @@ static void remove_dts_thermal_zone(struct intel_soc_dts_sensor_entry *dts)
 static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 				bool critical_trip)
 {
+	struct thermal_zone_device_params tzdp = {
+		.tzp = {
+			.devdata = dts,
+			.ops = &tzone_ops,
+			.trips = dts->trips,
+			.num_trips = SOC_MAX_DTS_TRIPS,
+		}
+	};
 	int writable_trip_cnt = SOC_MAX_DTS_TRIPS;
-	char name[10];
 	unsigned long trip;
 	int trip_mask;
 	unsigned long ptps;
@@ -253,12 +260,15 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 			trip_mask &= ~BIT(i / 8);
 	}
 	dts->trip_mask = trip_mask;
-	snprintf(name, sizeof(name), "soc_dts%d", id);
-	dts->tzone = thermal_zone_device_register_with_trips(name, dts->trips,
-							     SOC_MAX_DTS_TRIPS,
-							     trip_mask,
-							     dts, &tzone_ops,
-							     NULL, 0, 0);
+
+	tzdp.tzp.type = kasprintf(GFP_KERNEL, "soc_dts%d", id);
+	if (!tzdp.tzp.type)
+		return -ENOMEM;
+
+	tzdp.tzp.mask = trip_mask;
+
+	dts->tzone = thermal_zone_device_register(&tzdp);
+	kfree(tzdp.tzp.type);
 	if (IS_ERR(dts->tzone)) {
 		ret = PTR_ERR(dts->tzone);
 		goto err_ret;
-- 
2.43.0


