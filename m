Return-Path: <linux-kernel+bounces-8373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B8881B65B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0475B2448C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D5A7691F;
	Thu, 21 Dec 2023 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ixzJ9PR5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B38B745FF;
	Thu, 21 Dec 2023 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162917;
	bh=7dSyaW0hHfrvS4WptTVuedCjr1NJ6UZhYXzsUhQDe0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ixzJ9PR5Qvi8/Dv5L2i9OxPhQnafYOqL7SI7PEbPmzcJHbdzy5tgPlVb2yCNW1OuJ
	 IAp1JyD0xcm8bSioyrJyj1W2LbOjlsteD+FeNbBayNoScu473kz4z5Gj5Tbv6g0vHD
	 xKwybpGLgW1CoMtRcTGvij9ahpd7IAxPYSgJRhgVO4VKvMzmC+Yr+K7WVKG243d3U0
	 oP00LSC6k1jbuPGuvUGWBa8dyHzFBmIt6DdssXnd5Pf+5gStHnE0ZLQW5TmbTwQ5s+
	 4w3S76UeVnqpTBbP2C/Xp04tCJurF4yce8a4pRpVyHPdAwSqIXuBlY44aTaUF2DGX/
	 Vccj3R9MksCdg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 68CED3782009;
	Thu, 21 Dec 2023 12:48:36 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 06/26] thermal/drivers/imx: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:05 +0100
Message-ID: <20231221124825.149141-7-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/imx_thermal.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 7019c4fdd549..61b332e1b899 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -599,6 +599,13 @@ static inline void imx_thermal_unregister_legacy_cooling(struct imx_thermal_data
 
 static int imx_thermal_probe(struct platform_device *pdev)
 {
+	struct thermal_zone_device_params tzdp = {
+		.type = "imx_thermal_zone",
+		.ops = &imx_tz_ops,
+		.mask = BIT(IMX_TRIP_PASSIVE),
+		.passive_delay = IMX_PASSIVE_DELAY,
+		.polling_delay = IMX_POLLING_DELAY,
+	};
 	struct imx_thermal_data *data;
 	struct regmap *map;
 	int measure_freq;
@@ -696,13 +703,11 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		goto legacy_cleanup;
 	}
 
-	data->tz = thermal_zone_device_register_with_trips("imx_thermal_zone",
-							   trips,
-							   ARRAY_SIZE(trips),
-							   BIT(IMX_TRIP_PASSIVE), data,
-							   &imx_tz_ops, NULL,
-							   IMX_PASSIVE_DELAY,
-							   IMX_POLLING_DELAY);
+	tzdp.devdata = data;
+	tzdp.trips = &trips;
+	tzdp.num_trips = ARRAY_SIZE(trips);
+
+	data->tz = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(data->tz)) {
 		ret = PTR_ERR(data->tz);
 		dev_err(&pdev->dev,
-- 
2.43.0


