Return-Path: <linux-kernel+bounces-44478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1668422B8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D2EB24236
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51046DD0D;
	Tue, 30 Jan 2024 11:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="tWaiuBHN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7365D6D1C2;
	Tue, 30 Jan 2024 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613213; cv=none; b=idnZdRo5ZzvIy01zCX3gB3tmp85ewV8VlQ8+4Mp2CfPGifoAlkrJOwk4HAOXNff2CftbtxNligzgX1VOWOlg9FyBTB9yVDNA1GoqbBCm0tlkIAso97eDZLYSPzuedqzPDms7S/CaqkQ9ryc58C2A5KMcccAzsVFXobBmCqEbUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613213; c=relaxed/simple;
	bh=8N3xJcRXf5FIbTK9mPZ0ZQQ16s2NrrH6F3ME5uc5zQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQS5DZL0appBnpHmLD51H0QB2KhZColBWmle1B/P01nzzBDaHmYvVcaQeUTelU0oTqoagDVqr7zlBdMZeumU6fkaBKWAE7Erb87oQ6nGqETKooh/CtfeLZYrZz9lclNbPehjmQIT53RFRPSZZSdWwIzfchGM943rxoJotKCOliE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=tWaiuBHN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613209;
	bh=8N3xJcRXf5FIbTK9mPZ0ZQQ16s2NrrH6F3ME5uc5zQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tWaiuBHNkYHdwGEZcneAwBntZrHzXW7ISd87Cvuu5+408yDYsOzKNRnEFUUez+XUf
	 7FwwYW6QEa6WduKNur0YASEp2wWVy8IrRF8cckY7rbHNlPtL6oewASwConO4RSbKi2
	 jLgQgE0VX03qVmZq5gPx4lPPZ/nZBqNvQpWzZn4AWWaBarl+tzh+ocwt9EkyNHdrEY
	 QT2nAEUAwZ05ZL99FEYAiaK4fsbjMOFlYQm3IOVsDELaG0H1CPn2GexXNrvyQK1c98
	 xMBUq03IsVewGMSN/pBHme2dby0PVyhgGMAHR6pdZ1fdkB3LvTxQtQfelJKlHwoXSH
	 pReTHx90gVLsg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E3823378208C;
	Tue, 30 Jan 2024 11:13:27 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: miquel.raynal@bootlin.com,
	rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	support.opensource@diasemi.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	amitk@kernel.org,
	thara.gopinath@gmail.com,
	niklas.soderlund@ragnatech.se,
	srinivas.pandruvada@linux.intel.com,
	angelogioacchino.delregno@collabora.com,
	baolin.wang@linux.alibaba.com,
	u.kleine-koenig@pengutronix.de,
	hayashi.kunihiko@socionext.com,
	d-gole@ti.com,
	linus.walleij@linaro.org,
	DLG-Adam.Ward.opensource@dm.renesas.com,
	error27@gmail.com,
	heiko@sntech.de,
	hdegoede@redhat.com,
	jernej.skrabec@gmail.com,
	f.fainelli@gmail.com,
	bchihi@baylibre.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH v1 09/18] thermal: intel: quark_dts: Migrate to thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:41 +0100
Message-ID: <20240130111250.185718-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
References: <20240130111250.185718-1-angelogioacchino.delregno@collabora.com>
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
 .../thermal/intel/intel_quark_dts_thermal.c   | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/intel/intel_quark_dts_thermal.c b/drivers/thermal/intel/intel_quark_dts_thermal.c
index 646ca8bd40a9..381a806d5f62 100644
--- a/drivers/thermal/intel/intel_quark_dts_thermal.c
+++ b/drivers/thermal/intel/intel_quark_dts_thermal.c
@@ -320,10 +320,16 @@ static void free_soc_dts(struct soc_sensor_entry *aux_entry)
 
 static struct soc_sensor_entry *alloc_soc_dts(void)
 {
+	struct thermal_zone_device_params tzdp = {
+		.tzp = {
+			.type = "quark_dts",
+			.ops = &tzone_ops,
+			.polling_delay = polling_delay,
+		}
+	};
 	struct soc_sensor_entry *aux_entry;
 	int err;
 	u32 out;
-	int wr_mask;
 
 	aux_entry = kzalloc(sizeof(*aux_entry), GFP_KERNEL);
 	if (!aux_entry) {
@@ -339,10 +345,10 @@ static struct soc_sensor_entry *alloc_soc_dts(void)
 
 	if (out & QRK_DTS_LOCK_BIT) {
 		aux_entry->locked = true;
-		wr_mask = QRK_DTS_WR_MASK_CLR;
+		tzdp.tzp.mask = QRK_DTS_WR_MASK_CLR;
 	} else {
 		aux_entry->locked = false;
-		wr_mask = QRK_DTS_WR_MASK_SET;
+		tzdp.tzp.mask = QRK_DTS_WR_MASK_SET;
 	}
 
 	/* Store DTS default state if DTS registers are not locked */
@@ -368,12 +374,11 @@ static struct soc_sensor_entry *alloc_soc_dts(void)
 	aux_entry->trips[QRK_DTS_ID_TP_HOT].temperature = get_trip_temp(QRK_DTS_ID_TP_HOT);
 	aux_entry->trips[QRK_DTS_ID_TP_HOT].type = THERMAL_TRIP_HOT;
 
-	aux_entry->tzone = thermal_zone_device_register_with_trips("quark_dts",
-								   aux_entry->trips,
-								   QRK_MAX_DTS_TRIPS,
-								   wr_mask,
-								   aux_entry, &tzone_ops,
-								   NULL, 0, polling_delay);
+	tzdp.tzp.devdata = aux_entry;
+	tzdp.tzp.trips = aux_entry->trips;
+	tzdp.tzp.num_trips = QRK_MAX_DTS_TRIPS;
+
+	aux_entry->tzone = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(aux_entry->tzone)) {
 		err = PTR_ERR(aux_entry->tzone);
 		goto err_ret;
-- 
2.43.0


