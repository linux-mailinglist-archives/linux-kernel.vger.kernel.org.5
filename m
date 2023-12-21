Return-Path: <linux-kernel+bounces-8385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB19081B675
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0061C251F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E0F7A212;
	Thu, 21 Dec 2023 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cv7ptrkk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EBE79475;
	Thu, 21 Dec 2023 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162924;
	bh=93ZKOVlrTVJQ0RvWV6bc6BLDjs7S1OZ1L+ZoHQabC8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cv7ptrkksutYRmpo8MnHwHmsY5ObfJ0q5g3+GHNYYFwn/gC0NK1AJBYKaz9fMQDWo
	 Kl+LvuNPs2fCdiEsiRZaSCf0ehJaB9DtBAnsSAwOV3QaA6yFrUS3D4rMZqDVE9Xyto
	 0FrCEpdRAnn02ZBfF+We1e1oO5XRNBD89hYxdrhszU17vYtuppLJNzso/4UNnNzUT0
	 M8E1oUWLT01uLwKdHm2JxnpqWNXREkJpT3drdAnOC1JhEzvKDI1gi+rh9gQcVNyJMT
	 xfwsqW7g2LUwrRAZEDjTOn4eaBNktswoccjnkGDg9kfCoRh8V63BKjaLyd+CYtudxa
	 nJpraJBEM1YrA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2ACA53781F84;
	Thu, 21 Dec 2023 12:48:44 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 16/26] thermal/drivers/armada: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:15 +0100
Message-ID: <20231221124825.149141-17-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/armada_thermal.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index f783547ef964..f48a776af147 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -864,8 +864,14 @@ static int armada_thermal_probe(struct platform_device *pdev)
 	 * into it, which requires the use of regmaps across all the driver.
 	 */
 	if (IS_ERR(syscon_node_to_regmap(pdev->dev.parent->of_node))) {
+		struct thermal_zone_device_params tzdp = {
+			.ops = &legacy_ops,
+			.devdata = priv
+		};
+
 		/* Ensure device name is correct for the thermal core */
 		armada_set_sane_name(pdev, priv);
+		tzdp.type = priv->zone_name;
 
 		ret = armada_thermal_probe_legacy(pdev, priv);
 		if (ret)
@@ -876,9 +882,7 @@ static int armada_thermal_probe(struct platform_device *pdev)
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


