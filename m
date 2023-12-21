Return-Path: <linux-kernel+bounces-8378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC78881B664
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A879A28325A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338B277F18;
	Thu, 21 Dec 2023 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nUYtAkeQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312277762A;
	Thu, 21 Dec 2023 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162920;
	bh=+Uc91cWhTwL1vrnkQPriFheqqqM+d7m3ZfQlLpU8beI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUYtAkeQpPKWX3E+VAAwSLCrf+b+NQuQGwd6n3KzAeUG21yVxfO5YyaDxyLkPw5Kg
	 5URTEaellnolbb+I1Nq04GhdiiAejA/otM2a1Jt9AyRaXCRImM4t+Lq06iVIMH1InQ
	 SnzXEviexiI1mqPXrdhOimHIbT63uG/66aQV6GjeXsc+NaiYn4q4dAXA1oWhAjBzhL
	 1IH6g4do1u1Ypdm9SbQmlUix4872YxiO2RYqPL0GhIm3VWciVxbtZYqgogFI+xrYP+
	 X/q/vATQiZkAIFT/m+xUexn3aDwTchmdS/Bqrsmw81WjtwLkmlrypWqzDYVbUagqRa
	 PRmGTd7TdCtnA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4FA4B3782013;
	Thu, 21 Dec 2023 12:48:40 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 11/26] thermal: intel: soc_dts_iosf: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:10 +0100
Message-ID: <20231221124825.149141-12-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/intel/intel_soc_dts_iosf.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index d00def3c4703..da89e4b492b1 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -220,8 +220,13 @@ static void remove_dts_thermal_zone(struct intel_soc_dts_sensor_entry *dts)
 static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 				bool critical_trip)
 {
+	struct thermal_zone_device_params tzdp = {
+		.ops = &tzone_ops,
+		.devdata = dts,
+		.trips = dts->trips,
+		.num_trips = SOC_MAX_DTS_TRIPS,
+	};
 	int writable_trip_cnt = SOC_MAX_DTS_TRIPS;
-	char name[10];
 	unsigned long trip;
 	int trip_mask;
 	unsigned long ptps;
@@ -253,12 +258,15 @@ static int add_dts_thermal_zone(int id, struct intel_soc_dts_sensor_entry *dts,
 			trip_mask &= ~BIT(i / 8);
 	}
 	dts->trip_mask = trip_mask;
-	snprintf(name, sizeof(name), "soc_dts%d", id);
-	dts->tzone = thermal_zone_device_register_with_trips(name, dts->trips,
-							     SOC_MAX_DTS_TRIPS,
-							     trip_mask,
-							     dts, &tzone_ops,
-							     NULL, 0, 0);
+
+	tzdp.type = kasprintf(GFP_KERNEL, "soc_dts%d", id);
+	if (!tzdp.type)
+		return -ENOMEM;
+
+	tzdp.mask = trip_mask;
+
+	dts->tzone = thermal_zone_device_register(&tzdp);
+	kfree(tzdp.type);
 	if (IS_ERR(dts->tzone)) {
 		ret = PTR_ERR(dts->tzone);
 		goto err_ret;
-- 
2.43.0


