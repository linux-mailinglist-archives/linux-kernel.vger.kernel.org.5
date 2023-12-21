Return-Path: <linux-kernel+bounces-8372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D32081B659
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A831289322
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E87768F7;
	Thu, 21 Dec 2023 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ikf7JBCI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E93745DB;
	Thu, 21 Dec 2023 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162916;
	bh=YEdNV8O2ZLegd5j1TKwdVy1YO9G9N8uipcA77IFh0Is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ikf7JBCIVuDx0XjW6bUxY8Km5aIJDQ0XVnXJ8lQ36aoi766ELdxsB9EjkDO/RXatK
	 ofv6xc4Mu6qQdHFKgX1VE2dG/tQRgRISGBwDP4DZWHvr+xVGEXEsnTVUq5T0BzjVwu
	 gRfmVPYft4GxC12Qh4SIBw9y5C252zsnYFwj/FGg6MXUr8x1MGTJrA16vt/7/Mb2AT
	 7SOGuT5B4b9sD46GOOVn3nO2zcbfMLXbIEYuqKckclPsSHUgfgXbMcDJx6n2WLATHR
	 7h9DIEF1E/zrcCkQTYYAnYN1jubLUGdr1yulKU89WZ7duUddfwGvBWMfz7x2xTmYle
	 YoXgaKji/gC0Q==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AB43C3782001;
	Thu, 21 Dec 2023 12:48:35 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 05/26] thermal/drivers/da9062: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:04 +0100
Message-ID: <20231221124825.149141-6-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/da9062-thermal.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index 160d64913057..10b1fe74c43e 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -158,6 +158,11 @@ MODULE_DEVICE_TABLE(of, da9062_compatible_reg_id_table);
 
 static int da9062_thermal_probe(struct platform_device *pdev)
 {
+	struct thermal_zone_device_params tzdp = {
+		.ops = &da9062_thermal_ops,
+		.trips = trips,
+		.num_trips = ARRAY_SIZE(trips),
+	};
 	struct da9062 *chip = dev_get_drvdata(pdev->dev.parent);
 	struct da9062_thermal *thermal;
 	const struct of_device_id *match;
@@ -196,10 +201,11 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&thermal->work, da9062_thermal_poll_on);
 	mutex_init(&thermal->lock);
 
-	thermal->zone = thermal_zone_device_register_with_trips(thermal->config->name,
-								trips, ARRAY_SIZE(trips), 0, thermal,
-								&da9062_thermal_ops, NULL, pp_tmp,
-								0);
+	tzdp.type = thermal->config->name;
+	tzdp.devdata = thermal;
+	tzdp.passive_delay = pp_tmp;
+
+	thermal->zone = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(thermal->zone)) {
 		dev_err(&pdev->dev, "Cannot register thermal zone device\n");
 		ret = PTR_ERR(thermal->zone);
-- 
2.43.0


