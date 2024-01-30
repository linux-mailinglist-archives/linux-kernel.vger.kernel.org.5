Return-Path: <linux-kernel+bounces-44485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E308422B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3F8294C95
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B2F8120E;
	Tue, 30 Jan 2024 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s72H3QsU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EFC7E578;
	Tue, 30 Jan 2024 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613228; cv=none; b=FIyGAxUuAJ5PzWnAyEXyscpdVys9vbv1kcMERFEcOg7aEtmb1lUsA4mug33QaqAxQoJyvn68iGQZivcPqlbCJ8nH32RSzdgEsscbac/NIVX2Pip5D8mXPl341XxhYFB0dhXPXbIQdVkdzkHQ2M7b9mZVvBcOpifO5bt6MWFCyAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613228; c=relaxed/simple;
	bh=lvc56XBEENzj3l1vBHl7W+VJWa9O58KHS2L6cWEnb0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCI2lDpPsqLzNCmHAOZDTU+9nYyV3nm+x8H4qrtTj4xihiEaGvyCr+CIcvw407FiFJBunYXeRwmYwkbh+KOZvi9wfAo05PYgEQeV8nyo/1Uzkrp3AxcNAH9EhubAJI7qlVDCk4ZT3ynLszu3GJZsOjq+g2payNYoIeHJITUce6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=s72H3QsU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613225;
	bh=lvc56XBEENzj3l1vBHl7W+VJWa9O58KHS2L6cWEnb0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s72H3QsUQJtWRsvyRQo2gC69r8xWecWDNtEu34plUdOpog/Hur9EDM0g+aCe08MxJ
	 YOA4Qu0/x5kpR4+jO1IB0l+U2xa9VSjbAXnLYIfTQu2R3dMjk1S9LSv5uzkQez/vE/
	 8icQBb2gXuJ+2KTC41lYp0YzpsAWXPJCAiyejzit/s5yqoPLhwt51J2C86uCQGK1T+
	 jCGbNe+Dg4B2xdBI4gfs0ulYbYZiQ1vy6yXMqYbrPqKAhpcHPraKVXWfFyPuKPPjt+
	 0HIzjC16W+YWOV/lyHwygw9Dui/JIaoNyjpjPmoKldYhog3+LsTlXYsgvV57eRIGRL
	 TyqycCMQP/9ew==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5C188378208C;
	Tue, 30 Jan 2024 11:13:43 +0000 (UTC)
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
Subject: [PATCH v1 16/18] thermal/drivers/kirkwood: Migrate to thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:48 +0100
Message-ID: <20240130111250.185718-17-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/kirkwood_thermal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index a18158ebe65f..0e4f24a91bb0 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -59,6 +59,12 @@ static const struct of_device_id kirkwood_thermal_id_table[] = {
 
 static int kirkwood_thermal_probe(struct platform_device *pdev)
 {
+	struct thermal_zone_device_params tzdp = {
+		.tzp = {
+			.type = "kirkwood_thermal",
+			.ops = &ops
+		}
+	};
 	struct thermal_zone_device *thermal = NULL;
 	struct kirkwood_thermal_priv *priv;
 	int ret;
@@ -71,8 +77,8 @@ static int kirkwood_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->sensor))
 		return PTR_ERR(priv->sensor);
 
-	thermal = thermal_tripless_zone_device_register("kirkwood_thermal",
-							priv, &ops, NULL);
+	tzdp.tzp.devdata = priv;
+	thermal = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(thermal)) {
 		dev_err(&pdev->dev,
 			"Failed to register thermal zone device\n");
-- 
2.43.0


