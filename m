Return-Path: <linux-kernel+bounces-44486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 334458422D8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F9CB30144
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E66A823D5;
	Tue, 30 Jan 2024 11:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lNNKbDd2"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376E281AB6;
	Tue, 30 Jan 2024 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613230; cv=none; b=bXTqBA7jp54pcN82n5KJM1st9DraB6YKNgzkxpcwrngPx120Em6qlQfHTjg23Op+QX8KHqiLPSKh6F3d/c6xeKDJ9UKU/cO/b+EyeOyWjWz3pQhKvarBj207tvwH/bV8dixGFtJPI/N7vfX+tdG9lE4/6lZrncNIWoGPq9C9x2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613230; c=relaxed/simple;
	bh=2ZKqENqpAr73vIHtNbsLJ6VTnTTnQUPyIm0ECac1PpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7oHnU2mWIhlUy6ORMc5ZyV2QtDcH8ULzvD+D6ISxXcvybgaGc/YF6B+kXpPE/shwHnlpkAxa2M7yQwlsvPvDJYd8j9nq/LxG117lv9LO3o6+iBL/FpDV1Zyfcsce90vG6xtRhuS+wmjTWg/PeGTSqDxewWZP6bbw5m+S8oqMNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lNNKbDd2; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613227;
	bh=2ZKqENqpAr73vIHtNbsLJ6VTnTTnQUPyIm0ECac1PpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNNKbDd230nPVBc5Dswzw1++sfC6N1W7A5bjffWPJyPxl1qXg+utW4brmK9q344sh
	 orLi0A4xhEJWRQMRACKu65cbxxI519HRkCPMMUO/ifl5xxEiaAJl/y8MFjOVETSHx7
	 ZMgVajrBdjGyRpBGeTuvdXyuRxuht8AzFzygiAg6yzt8oA/l3iSe/QwaWZ4L7Nb86i
	 kP2lqQLMebNDDP4GsXjt875WjeRicU9+3fZuvBfuVD8LA1FzCqGla1VB3gTKGyalgO
	 t1CfatFej3rXJSqnpVaaNSoEq17i7YTR6nWhkqr7tvDfH6JRK7QKMPWpqQnN1doOxd
	 1D+j1fbzGALIA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 92A673782091;
	Tue, 30 Jan 2024 11:13:45 +0000 (UTC)
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
Subject: [PATCH v1 17/18] thermal/drivers/spear: Migrate to thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:49 +0100
Message-ID: <20240130111250.185718-18-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/spear_thermal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 60a871998b07..7d65f4bc95be 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -88,6 +88,12 @@ static SIMPLE_DEV_PM_OPS(spear_thermal_pm_ops, spear_thermal_suspend,
 
 static int spear_thermal_probe(struct platform_device *pdev)
 {
+	struct thermal_zone_device_params tzdp = {
+		.tzp = {
+			.type = "spear_thermal",
+			.ops = &ops
+		}
+	};
 	struct thermal_zone_device *spear_thermal = NULL;
 	struct spear_thermal_dev *stdev;
 	struct device_node *np = pdev->dev.of_node;
@@ -122,8 +128,8 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	stdev->flags = val;
 	writel_relaxed(stdev->flags, stdev->thermal_base);
 
-	spear_thermal = thermal_tripless_zone_device_register("spear_thermal",
-							      stdev, &ops, NULL);
+	tzdp.tzp.devdata = stdev;
+	spear_thermal = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(spear_thermal)) {
 		dev_err(&pdev->dev, "thermal zone device is NULL\n");
 		ret = PTR_ERR(spear_thermal);
-- 
2.43.0


