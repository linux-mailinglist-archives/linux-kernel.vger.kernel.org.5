Return-Path: <linux-kernel+bounces-44472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF0684227F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A811C26CD3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3667F6A011;
	Tue, 30 Jan 2024 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="sqhLf9jG"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64B46772E;
	Tue, 30 Jan 2024 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613202; cv=none; b=Elje3v4VWVNvGCRgdoMP+5xkvopBH3xB50kshXwdBFKnBp8YSqC7yYI5uC1WWKftonHkXGuBF8lD4eUxLR2d4iy7rFVivx0sTmSGCLOBg1Hlkvv3/wPdfuc9K3rIdFSyl4Xc35InscJw5y3l07KhXOsF6tWcjD51HKyhmq9kUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613202; c=relaxed/simple;
	bh=mEtrz7xMtfcpY7sT1iZb5MnMblxKwwvnwtCVasYjkwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUC7sXZshlbygV2lAcoCd0GkEHnJJ+2Vb9tpD9T9ZQ53cZyTp1luf8CiHi97fdKwqzzCH7uKvTCgCIgtxg3NSLv4Zkn69jjUYQAe3oJbSomAe8/emPVGWH2ye3obBb1bMU/QGukXqlO1Ex0ZAaZwbpczl9DmwcZjkWe4+KWRhhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=sqhLf9jG; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613198;
	bh=mEtrz7xMtfcpY7sT1iZb5MnMblxKwwvnwtCVasYjkwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sqhLf9jG5O6CWF4it6D6pVYOJQpzWwzFvcinU7Zeft6hwYnwmfrXbf+2t1IwFk8Q4
	 Jf/DV2lzIq8TtyVOjDcTp0VVAG5qi+hTTzkbRf0QyKwjIok6ThM8pHvLWnpvNsRgFk
	 9p1JDJ62axfSYIM9ZYQ+ZAEDWL4LY4Cuce8GziRGSHzF5hJKHD+X7u9jZEsW6Uo+Ym
	 9IHotLcKMgZG1zEBtur32SaJD1Kn9v7az07C6sw75agJ6vTBfVRNRLMyzYC4Rxsr6v
	 HVzu1FoMLTL+swrjIii3lAKVuukF8AM/JeqT8ISdofcYKLc9AwLhlvVJEhkut3blLY
	 QnEwj6svk9TLA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B3B10378208F;
	Tue, 30 Jan 2024 11:13:16 +0000 (UTC)
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
Subject: [PATCH v1 04/18] thermal/drivers/da9062: Migrate to thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:36 +0100
Message-ID: <20240130111250.185718-5-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/da9062-thermal.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index 160d64913057..13c7a6bc36c4 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -158,6 +158,13 @@ MODULE_DEVICE_TABLE(of, da9062_compatible_reg_id_table);
 
 static int da9062_thermal_probe(struct platform_device *pdev)
 {
+	struct thermal_zone_device_params tzdp = {
+		.tzp = {
+			.ops = &da9062_thermal_ops,
+			.trips = trips,
+			.num_trips = ARRAY_SIZE(trips),
+		}
+	};
 	struct da9062 *chip = dev_get_drvdata(pdev->dev.parent);
 	struct da9062_thermal *thermal;
 	const struct of_device_id *match;
@@ -196,10 +203,11 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&thermal->work, da9062_thermal_poll_on);
 	mutex_init(&thermal->lock);
 
-	thermal->zone = thermal_zone_device_register_with_trips(thermal->config->name,
-								trips, ARRAY_SIZE(trips), 0, thermal,
-								&da9062_thermal_ops, NULL, pp_tmp,
-								0);
+	tzdp.tzp.type = thermal->config->name;
+	tzdp.tzp.devdata = thermal;
+	tzdp.tzp.passive_delay = pp_tmp;
+
+	thermal->zone = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(thermal->zone)) {
 		dev_err(&pdev->dev, "Cannot register thermal zone device\n");
 		ret = PTR_ERR(thermal->zone);
-- 
2.43.0


