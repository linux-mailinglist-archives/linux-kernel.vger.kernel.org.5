Return-Path: <linux-kernel+bounces-44483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5318422AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8687F294589
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31A07C0AE;
	Tue, 30 Jan 2024 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mQShp5b1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F54B77627;
	Tue, 30 Jan 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613224; cv=none; b=ejeeEIxbKDEHeUJAb8M9VSTILcYdTJ1vIND+Q3mv7FlGYehPK33L0gnHto9SgVJXgSCdesIvf9SArUJhGTyTSg4EhuZvQosY4xv8P4UOwYh+piYHINS1O0E33bnWQW0JN1Ig4ith8zDU2xScKVWLhU1fhzM2tGy5/ciF/qPtjF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613224; c=relaxed/simple;
	bh=+RsoYewyOO14ouzshvdt3gaki76JepljIejGBDHOp2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ede6puU50NDxRJ8M28WgJ+JZhUjQibl5cKmsNbWHhyK0tuDOy04pP11mH18RTHd5fXXfdnSWi42+sWUqINclT8rbUm0C9esH1BZJwVKpZbeT0sMzBx7xVUBtujq/0dUDSP4Pyqx9saVJVoOdMTEBAHGx+O9aMDnQRaycPOvJdAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mQShp5b1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613221;
	bh=+RsoYewyOO14ouzshvdt3gaki76JepljIejGBDHOp2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mQShp5b1PaO4pA1N+3guPpQZJZY4gb3CAPdmzQX6EG9oF+WTF3rCekCrmOSuETOu6
	 YtEcPGn/EqC6U2JFbtiqOk2+ZU7Q7K9DWbUM1Cy/ncgnUsLKGblrHVRN83nJClmULc
	 HqD4TzRhxRlKWOMXbznz/UNNyWdDgm/XVCbRr5lND+3/+/vcK9UR6f7Jig7il28Q5Y
	 Hq70U3yTeQMUoy0NaPd8COeuZJ1+ZMDvwqeaiRqLbQZ0DasqVXManUz2jGZFoHy/zc
	 1VJtPAoszlMx1E/Xpjqpm9fkQvdH/Qmz4VOsbbtYoalHnXlemVubDaOwVBGXVTyFmN
	 dH1HBGS/Mi9eg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E9A86378208B;
	Tue, 30 Jan 2024 11:13:38 +0000 (UTC)
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
Subject: [PATCH v1 14/18] thermal/drivers/armada: Migrate to thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:46 +0100
Message-ID: <20240130111250.185718-15-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/armada_thermal.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index f783547ef964..e07bee0440fe 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -864,8 +864,16 @@ static int armada_thermal_probe(struct platform_device *pdev)
 	 * into it, which requires the use of regmaps across all the driver.
 	 */
 	if (IS_ERR(syscon_node_to_regmap(pdev->dev.parent->of_node))) {
+		struct thermal_zone_device_params tzdp = {
+			.tzp = {
+				.ops = &legacy_ops,
+				.devdata = priv
+			}
+		};
+
 		/* Ensure device name is correct for the thermal core */
 		armada_set_sane_name(pdev, priv);
+		tzdp.tzp.type = priv->zone_name;
 
 		ret = armada_thermal_probe_legacy(pdev, priv);
 		if (ret)
@@ -876,9 +884,7 @@ static int armada_thermal_probe(struct platform_device *pdev)
 		/* Wait the sensors to be valid */
 		armada_wait_sensor_validity(priv);
 
-		tz = thermal_tripless_zone_device_register(priv->zone_name,
-							   priv, &legacy_ops,
-							   NULL);
+		tz = thermal_zone_device_register(&tzdp);
 		if (IS_ERR(tz)) {
 			dev_err(&pdev->dev,
 				"Failed to register thermal zone device\n");
-- 
2.43.0


