Return-Path: <linux-kernel+bounces-8390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4364D81B682
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7690C1C257D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21557BF01;
	Thu, 21 Dec 2023 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PVPjgZyC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414227AE7B;
	Thu, 21 Dec 2023 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162927;
	bh=IzGXP7pU6vgksVmgOm8IVqKNTU11eGk4o8LGz/dSNic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PVPjgZyCfYFO033Aa4w6Zfpat7VbZzivozeRdDK8DYjwtiY3sdwdXsNJ3Qev1liTs
	 vxBXJOUuuzacj3D8cWibZLDKmIo4bk/NXeGNNbS7Vok9imkK8wV/dLLudEq8cf0oTf
	 /brH2cIXgJANZ8JFbicSX7exL1Jrp7RWvakS83ANrzpAITAuXKzC1v0MQtO0Nn4+JD
	 sVvXB5SsYq1ugaiSRaA47IGXEQJ/uL7iz3BzN34tauZwR8vuJXz5dfsm0iN4hLQkXA
	 XrK5t2o1WmFlYKs5g5gYb5Nt1lG/Bxhl0vijrC+EoTuFNfCdgwrE6R7F6SuuvZMM+L
	 YT/jmQwkwaRUA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 30282378200A;
	Thu, 21 Dec 2023 12:48:47 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 20/26] thermal/drivers/int340x: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:19 +0100
Message-ID: <20231221124825.149141-21-angelogioacchino.delregno@collabora.com>
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
 .../intel/int340x_thermal/int3400_thermal.c     | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
index 427d370648d5..87bfc1f9a5a4 100644
--- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
@@ -536,11 +536,6 @@ static struct thermal_zone_device_ops int3400_thermal_ops = {
 	.change_mode = int3400_thermal_change_mode,
 };
 
-static struct thermal_zone_params int3400_thermal_params = {
-	.governor_name = "user_space",
-	.no_hwmon = true,
-};
-
 static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
 {
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -571,6 +566,14 @@ static void int3400_setup_gddv(struct int3400_thermal_priv *priv)
 
 static int int3400_thermal_probe(struct platform_device *pdev)
 {
+	struct thermal_zone_device_params tzdp = {
+		.type = "INT3400 Thermal",
+		.tzp = {
+			.governor_name = "user_space",
+			.no_hwmon = true
+		},
+		.ops = &int3400_thermal_ops
+	};
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
 	struct int3400_thermal_priv *priv;
 	int result;
@@ -609,9 +612,7 @@ static int int3400_thermal_probe(struct platform_device *pdev)
 
 	evaluate_odvp(priv);
 
-	priv->thermal = thermal_tripless_zone_device_register("INT3400 Thermal", priv,
-							      &int3400_thermal_ops,
-							      &int3400_thermal_params);
+	priv->thermal = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(priv->thermal)) {
 		result = PTR_ERR(priv->thermal);
 		goto free_art_trt;
-- 
2.43.0


