Return-Path: <linux-kernel+bounces-8388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E51281B67D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E8C1C24CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BD37AE92;
	Thu, 21 Dec 2023 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JspRYnmA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49D873179;
	Thu, 21 Dec 2023 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162926;
	bh=/tP0vOAcAPktGngh+MT0OZObQF+qtxH8HNQl/CdWeXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JspRYnmAD49OSoc7E/ls2xadn/4qZ1yf84DDeK4ry7w6vz7aLjgsOOq0NC+cJYuhi
	 lhx+4Hazgdr4BXudJdZcehwWLsuJRGQ7q4xGPrfmPzEV+EmT2rHoqiWdrKPWhRtd/C
	 xKirkwG6PyHT+6g80f/H3h1TA7GVxZqqsM1bEtMs1csSpnDKLT0+FZExUfSHSUw/Ns
	 WkMi8dw1xzMGMU9R5OxshZsgAKEQlHC0JuaO9r7IeQ+OehWQYo8xs1pgxNvJ6xOkIt
	 4QHiIr/lAISzs2awTTF8bX2TbS0siDPWezpnFlxgvjcRDEzAh2U4qKviSBGcK2NTQ9
	 j3NjH3XPrmXgw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AC41B3782001;
	Thu, 21 Dec 2023 12:48:45 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 18/26] thermal/drivers/kirkwood: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:17 +0100
Message-ID: <20231221124825.149141-19-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/kirkwood_thermal.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index a18158ebe65f..a9ccb27b5906 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -59,6 +59,10 @@ static const struct of_device_id kirkwood_thermal_id_table[] = {
 
 static int kirkwood_thermal_probe(struct platform_device *pdev)
 {
+	struct thermal_zone_device_params tzdp = {
+		.type = "kirkwood_thermal",
+		.ops = &ops
+	};
 	struct thermal_zone_device *thermal = NULL;
 	struct kirkwood_thermal_priv *priv;
 	int ret;
@@ -71,8 +75,8 @@ static int kirkwood_thermal_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->sensor))
 		return PTR_ERR(priv->sensor);
 
-	thermal = thermal_tripless_zone_device_register("kirkwood_thermal",
-							priv, &ops, NULL);
+	tzdp.devdata = priv;
+	thermal = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(thermal)) {
 		dev_err(&pdev->dev,
 			"Failed to register thermal zone device\n");
-- 
2.43.0


