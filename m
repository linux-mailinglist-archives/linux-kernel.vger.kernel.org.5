Return-Path: <linux-kernel+bounces-8391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7874A81B685
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6871F26502
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D01D7C654;
	Thu, 21 Dec 2023 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZMitHe2c"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC257BEEE;
	Thu, 21 Dec 2023 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162929;
	bh=ssMjukwPYr5YFlWiAdM91Hji1S8UHvaa/NNDxIiec6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZMitHe2cFQXc5iZcG2E859bVs3QezJ9Heebe5o2HM+KroJkJxidtsnLxxrNI8YAfO
	 7AtQ3f2OB0PNRp65286MIAcIWq7KDMab7oFCpimORGlzJ7CpLe6pWhL8HARYRrHsde
	 qy8CfDcCdHx16BPNFvDRS5XrUhLbnwB9X3AQ2HAyyNTbMTskmpccCVsFnST/4VlfLq
	 XIjXCF4LS0Bmi7MqkJtwnRDOkPR8XpMwEEOwFUIiiTO61Zpea36GvsxfbU/1WgGux3
	 5SLvjx9Mtq7WIB7fBrU9mwhClmIjCiN+8Wst/diu+bzoZnVFhAM9QnLKI89yTMKEmR
	 iSlt5UdgZWzRw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B34403782013;
	Thu, 21 Dec 2023 12:48:48 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 22/26] cxgb4: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:21 +0100
Message-ID: <20231221124825.149141-23-angelogioacchino.delregno@collabora.com>
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
 .../net/ethernet/chelsio/cxgb4/cxgb4_thermal.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
index dea9d2907666..0192dba14a84 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c
@@ -37,12 +37,21 @@ static struct thermal_trip trip = { .type = THERMAL_TRIP_CRITICAL } ;
 
 int cxgb4_thermal_init(struct adapter *adap)
 {
+	struct thermal_zone_device_params tzdp = {
+		.ops = &cxgb4_thermal_ops,
+		.devdata = adap,
+		.trips = &trip,
+		.num_trips = num_trip,
+	};
 	struct ch_thermal *ch_thermal = &adap->ch_thermal;
-	char ch_tz_name[THERMAL_NAME_LENGTH];
 	int num_trip = CXGB4_NUM_TRIPS;
 	u32 param, val;
 	int ret;
 
+	tzdp.type = kasprintf("cxgb4_%s", adap->name);
+	if (!tzdp.type)
+		return -ENOMEM;
+
 	/* on older firmwares we may not get the trip temperature,
 	 * set the num of trips to 0.
 	 */
@@ -58,11 +67,8 @@ int cxgb4_thermal_init(struct adapter *adap)
 		trip.temperature = val * 1000;
 	}
 
-	snprintf(ch_tz_name, sizeof(ch_tz_name), "cxgb4_%s", adap->name);
-	ch_thermal->tzdev = thermal_zone_device_register_with_trips(ch_tz_name, &trip, num_trip,
-								    0, adap,
-								    &cxgb4_thermal_ops,
-								    NULL, 0, 0);
+	ch_thermal->tzdev = thermal_zone_device_register(&tzdp);
+	kfree(tzdp.type);
 	if (IS_ERR(ch_thermal->tzdev)) {
 		ret = PTR_ERR(ch_thermal->tzdev);
 		dev_err(adap->pdev_dev, "Failed to register thermal zone\n");
-- 
2.43.0


