Return-Path: <linux-kernel+bounces-8386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8E481B679
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4040E1C253EE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042FB7AE66;
	Thu, 21 Dec 2023 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HdlNm/lr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A73F7995E;
	Thu, 21 Dec 2023 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162925;
	bh=L31yIrmZZhUrsQD11ECO7zUb5b6T40l2nXIhxFSEcLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HdlNm/lrnFfpEGr9id8D7nnqQIUw+fEXiRCLGINaeB80x0WrR9HSKLWAcFtEX9DNY
	 MgFF/FT5bK/5RobU0AdeNvLpFOn0bwZTJdUd+H/B0ZJuGPJOBOmRq9b63ECVOZ4WzP
	 4MXqmVSIiqpWMNcF01PS+8VNt/0gQdmaYuVAvzszOaqQTamG5iC3KXdjMA39vnUgR/
	 IB4AtxXb9ScySAWL9inb9dfEk6KoqIuo394r5bgKmyKcS0D0EVYjGUhCiGYU62lRO2
	 iUi97mgYim9aVtgGDRmRwN8NwXSLZPay5SpUGqGT5XZKMGQcArwhD5I9rzXx79V3f/
	 ufuSOdsMfDcNQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E604E3782017;
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
Subject: [RFC PATCH 17/26] thermal/drivers/dove: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:16 +0100
Message-ID: <20231221124825.149141-18-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/dove_thermal.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index ac30de3c0a5f..09ed02395d12 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -117,6 +117,10 @@ static const struct of_device_id dove_thermal_id_table[] = {
 
 static int dove_thermal_probe(struct platform_device *pdev)
 {
+	struct thermal_zone_device_params tzdp = {
+		.type = "dove_thermal",
+		.ops = &ops
+	};
 	struct thermal_zone_device *thermal = NULL;
 	struct dove_thermal_priv *priv;
 	int ret;
@@ -139,8 +143,8 @@ static int dove_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	thermal = thermal_tripless_zone_device_register("dove_thermal", priv,
-							&ops, NULL);
+	tzdp.devdata = priv;
+	thermal = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(thermal)) {
 		dev_err(&pdev->dev,
 			"Failed to register thermal zone device\n");
-- 
2.43.0


