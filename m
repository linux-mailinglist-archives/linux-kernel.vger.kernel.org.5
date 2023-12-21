Return-Path: <linux-kernel+bounces-8377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60AD81B663
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30CC0B25FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790DC77B2D;
	Thu, 21 Dec 2023 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="5gsJOMjM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7893276DC5;
	Thu, 21 Dec 2023 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162920;
	bh=4bQSiBNgTYsHNVsUGFRKvfMVMntQwjwyam0YGEYDVaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=5gsJOMjM+R1c++SVL+sieGiuK8C69VmwTXpogKpOQABSM2muR8tPbe8GF5t1/1q8f
	 5pVBvKJVYMDTcQOEU4M4T5muSmmSJ8sgFDKNP+XvzSG7CtY00hVcZK0/BOhYMHyH0k
	 sqJYD/flhie/WKUmvhzedY12KM0Cp4PRzJC1uU8CTiItEDarkoXT3cYR6WxCQH36hg
	 DPitOMeUvU7BGd2vEnFGplNuylD4Xg2bvW6sH3/xqtDXjHIVf2bJutn41k7yLoxvu4
	 zCtr4fWtfcuSJU2f4a9xYbet1ZDl7ofwrPgS2yc7FP+MGtGwrnxycBvn4AKdYPsZwX
	 9SkNk0ml4frjA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 85E283782012;
	Thu, 21 Dec 2023 12:48:39 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 10/26] thermal: intel: quark_dts: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:09 +0100
Message-ID: <20231221124825.149141-11-angelogioacchino.delregno@collabora.com>
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
 .../thermal/intel/intel_quark_dts_thermal.c   | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/intel/intel_quark_dts_thermal.c b/drivers/thermal/intel/intel_quark_dts_thermal.c
index 646ca8bd40a9..aba2db87c140 100644
--- a/drivers/thermal/intel/intel_quark_dts_thermal.c
+++ b/drivers/thermal/intel/intel_quark_dts_thermal.c
@@ -320,10 +320,14 @@ static void free_soc_dts(struct soc_sensor_entry *aux_entry)
 
 static struct soc_sensor_entry *alloc_soc_dts(void)
 {
+	struct thermal_zone_device_params tzdp = {
+		.type = "quark_dts",
+		.ops = &tzone_ops,
+		.polling_delay = polling_delay,
+	};
 	struct soc_sensor_entry *aux_entry;
 	int err;
 	u32 out;
-	int wr_mask;
 
 	aux_entry = kzalloc(sizeof(*aux_entry), GFP_KERNEL);
 	if (!aux_entry) {
@@ -339,10 +343,10 @@ static struct soc_sensor_entry *alloc_soc_dts(void)
 
 	if (out & QRK_DTS_LOCK_BIT) {
 		aux_entry->locked = true;
-		wr_mask = QRK_DTS_WR_MASK_CLR;
+		tzdp.mask = QRK_DTS_WR_MASK_CLR;
 	} else {
 		aux_entry->locked = false;
-		wr_mask = QRK_DTS_WR_MASK_SET;
+		tzdp.mask = QRK_DTS_WR_MASK_SET;
 	}
 
 	/* Store DTS default state if DTS registers are not locked */
@@ -368,12 +372,11 @@ static struct soc_sensor_entry *alloc_soc_dts(void)
 	aux_entry->trips[QRK_DTS_ID_TP_HOT].temperature = get_trip_temp(QRK_DTS_ID_TP_HOT);
 	aux_entry->trips[QRK_DTS_ID_TP_HOT].type = THERMAL_TRIP_HOT;
 
-	aux_entry->tzone = thermal_zone_device_register_with_trips("quark_dts",
-								   aux_entry->trips,
-								   QRK_MAX_DTS_TRIPS,
-								   wr_mask,
-								   aux_entry, &tzone_ops,
-								   NULL, 0, polling_delay);
+	tzdp.devdata = aux_entry;
+	tzdp.trips = aux_entry->trips;
+	tzdp.num_trips = QRK_MAX_DTS_TRIPS;
+
+	aux_entry->tzone = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(aux_entry->tzone)) {
 		err = PTR_ERR(aux_entry->tzone);
 		goto err_ret;
-- 
2.43.0


