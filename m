Return-Path: <linux-kernel+bounces-44487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DA38422BD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B112953D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B8C82D9A;
	Tue, 30 Jan 2024 11:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HlU33HM8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AE56EB50;
	Tue, 30 Jan 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613232; cv=none; b=de3e41KbJzTCrRGcIsvKrM9xsWOQw5+8tayIIFiSQmmPcpkw5yp/0s8non8PoE/PuLJyTT6GXUm9fq0mV+TIxMoiAekGjXViBmSJfBzIo9gqxjumNZwoSGa3JsfjxP+diVBZaNaZV8MA6C57ejNjt01K53L79WaY8n6ptMLiGG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613232; c=relaxed/simple;
	bh=1MaXaoAlGaux22185ES05zD+Vc6KSQlHot9SWkJLGp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/TtpW19r7WBY8lBgKcbGa/sVEKE1PDQeaiJpBOxQuOiBUbPQfTLJhPxXuP4wFISCSYKQHSaG/DmtCkSrroMqUh+R1XomHpaslMYLMouxDHz49bS1AkK2C+CJDgdLvHUGUrgCUq0qKLsMU+aPEHVIg4p9pbGwMx0qGnw8iDmPVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HlU33HM8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613229;
	bh=1MaXaoAlGaux22185ES05zD+Vc6KSQlHot9SWkJLGp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HlU33HM8DXvNnHd5pfL0Un12V2JosWoeboB5m/VaZSU7mn27JZRL7n0hOSbYmEV63
	 nbQXPRYgNnV9Tg09ybHmHOhmVp5umMRDpOApeet2UUjPgeUG/2TZDKp/Kpyz+HgXZG
	 HjC+6zWpXXGHJzQMPFzdZYEqaqQZxazoLeLlMmgd8mLUOxWzvFSmQESaHg+0Dz/Gh2
	 HAyBQd2ww0Hzr2aKjZ1depqQEX+Q9jSqA9P+yS8KR91henEbqscmEDj2/qaW9sT9sq
	 9WWEE88qf6woeJXZQ4+1zKcYguqf9dKIOVMXS0iAcsTnVywM4v2EaqrU0mJlnhEql4
	 bXn5tAHgulcXA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CCFE93780FC7;
	Tue, 30 Jan 2024 11:13:47 +0000 (UTC)
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
Subject: [PATCH v1 18/18] thermal/drivers/int340x: Migrate to thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:50 +0100
Message-ID: <20240130111250.185718-19-angelogioacchino.delregno@collabora.com>
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
 .../intel/int340x_thermal/int3400_thermal.c   | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 427d370648d5..d8ca7ed37950 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -536,11 +536,6 @@ static struct thermal_zone_device_ops int3400_thermal_ops = {
 	.change_mode = int3400_thermal_change_mode,
 };
 
-static struct thermal_zone_params int3400_thermal_params = {
-	.governor_name = "user_space",
-	.no_hwmon = true,
-};
-
 static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -572,6 +567,16 @@ static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
 static int int3400_thermal_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	struct thermal_zone_device_params tzdp = {
+		.tzp = {
+			.type = "INT3400 Thermal",
+			.no_hwmon = true,
+			.ops = &int3400_thermal_ops,
+		}
+	};
+	struct thermal_governor_params tgp = {
+		.governor_name = "user_space"
+	};
 	struct int3400_thermal_priv *priv;
 	int result;
 
@@ -609,9 +614,8 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
 	evaluate_odvp(priv);
 
-	priv->thermal = thermal_tripless_zone_device_register("INT3400 Thermal", priv,
-							      &int3400_thermal_ops,
-							      &int3400_thermal_params);
+	tzdp.tgp = &tgp;
+	priv->thermal = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(priv->thermal)) {
 		result = PTR_ERR(priv->thermal);
 		goto free_art_trt;
-- 
2.43.0


