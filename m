Return-Path: <linux-kernel+bounces-8389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D8681B67F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E352815D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE227B3BA;
	Thu, 21 Dec 2023 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k1b6+140"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543937A21E;
	Thu, 21 Dec 2023 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162927;
	bh=yEz5ZSUTt9k77CyhKIIQY02ps3ES7aiNgr3GDZOP2uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k1b6+140QQcj6UqlnfmAOTCoRj/GwOZfrBGDSeAgaCLa1n7BL4CNeAJKJDJxT7S3S
	 gKlKax+3MdDOtBqepo3nOZnso66aLDsC/Tlx94B/I1O+XnVus+09x6HmPjoTNrIwbl
	 80n19xvgUibKxikr+XVOMT4SjiSjExroqLUVvVtXveuXwHD0FdKSqpJx5hmJQOateG
	 ckYjE6SmjWtE4pO9xovWzEp5F2ZC5b+YmSORLoIHIl/KWlCDwPC6Z9sUocEToNmvq5
	 cAY2B5hCfk+CI7Lnouu1W0V6Pu2FE/PIRz7qFc8pvTs+Gak1NjDXETopvbf5s4qHDf
	 s6uK2eYy69wag==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6BCC63782009;
	Thu, 21 Dec 2023 12:48:46 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 19/26] thermal/drivers/spear: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:18 +0100
Message-ID: <20231221124825.149141-20-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/spear_thermal.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 60a871998b07..07006957acd5 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -88,6 +88,10 @@ static SIMPLE_DEV_PM_OPS(spear_thermal_pm_ops, spear_thermal_suspend,
 
 static int spear_thermal_probe(struct platform_device *pdev)
 {
+	struct thermal_zone_device_params tzdp = {
+		.type = "spear_thermal",
+		.ops = &ops
+	};
 	struct thermal_zone_device *spear_thermal = NULL;
 	struct spear_thermal_dev *stdev;
 	struct device_node *np = pdev->dev.of_node;
@@ -122,8 +126,8 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	stdev->flags = val;
 	writel_relaxed(stdev->flags, stdev->thermal_base);
 
-	spear_thermal = thermal_tripless_zone_device_register("spear_thermal",
-							      stdev, &ops, NULL);
+	tzdp.devdata = stdev;
+	spear_thermal = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(spear_thermal)) {
 		dev_err(&pdev->dev, "thermal zone device is NULL\n");
 		ret = PTR_ERR(spear_thermal);
-- 
2.43.0


