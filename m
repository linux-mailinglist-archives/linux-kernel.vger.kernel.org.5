Return-Path: <linux-kernel+bounces-44484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E44E8422B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4CA294977
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3C87E571;
	Tue, 30 Jan 2024 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pG6nb0WX"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865BB7C0A9;
	Tue, 30 Jan 2024 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613226; cv=none; b=WZ7CPUScgOcVjxiqyJGn+QteU3xrv5YA18dyy6c4fobGNoWIavmFEP8PdEaUJIAu1BCI1+IYTL0D5A+wqMbpkCHu62muqRxCcfakFXDCSgj6/8ebBGXqYzcYOgvB1vOb9XzIpGlIsNxAck1nroh37I+RXjHFxeDilFYrVJlF6ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613226; c=relaxed/simple;
	bh=74pBxa4eqyP7xDLl0IJ2wAmK6Mm6EIaDrqz4NKVOn8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwRgR6yiquABPiIngOzXybT+KGemkpOcdt8EGY85ejuI+pybNHfCV5ujc6zw4zgES8+T79M+7RypYCouZ4pJ0be+0JMc4lAWi/z4cicDELZEscKwTu8fk2onKssjzgk+kyZUVhJUsjtA+5vmNpqpEK50OW3JKUVvvhhs0kKUalw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pG6nb0WX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613223;
	bh=74pBxa4eqyP7xDLl0IJ2wAmK6Mm6EIaDrqz4NKVOn8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pG6nb0WXa9Riuum74Ymqdy/5z9NzqXRXNJst9PisOt6izsigDuGpHvC2n3Iv6wbVd
	 r/yo6W0+PKjfYEq1sAMgxznKRCJB6TBMfT1sxSK5B3rGaLdTd65hypVrylhDNH01Fu
	 RL7YivWDdBoXAfesJDhQkL7CpL5gtQBxpCZVu3WXqyhZs7/kKle4XgNNkiQY+JLCG1
	 D1G3qZW4IPOKIASzMXYIP3845Jb+j3hTxCjV422rINPbbCkFUeN7EPOZWvDZ1/eQti
	 EnHCChfSFwxxrYIYF0EftUrw/dNOLe/IZF0SSpt3pXkHzLdTYNujqFRHFWSd6a1cct
	 XVrp/WAy/LYGQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 283DE3782090;
	Tue, 30 Jan 2024 11:13:41 +0000 (UTC)
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
Subject: [PATCH v1 15/18] thermal/drivers/dove: Migrate to thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:47 +0100
Message-ID: <20240130111250.185718-16-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/dove_thermal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index ac30de3c0a5f..256c5dc45779 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -117,6 +117,12 @@ static const struct of_device_id dove_thermal_id_table[] = {
 
 static int dove_thermal_probe(struct platform_device *pdev)
 {
+	struct thermal_zone_device_params tzdp = {
+		.tzp = {
+			.type = "dove_thermal",
+			.ops = &ops
+		}
+	};
 	struct thermal_zone_device *thermal = NULL;
 	struct dove_thermal_priv *priv;
 	int ret;
@@ -139,8 +145,8 @@ static int dove_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	thermal = thermal_tripless_zone_device_register("dove_thermal", priv,
-							&ops, NULL);
+	tzdp.tzp.devdata = priv;
+	thermal = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(thermal)) {
 		dev_err(&pdev->dev,
 			"Failed to register thermal zone device\n");
-- 
2.43.0


