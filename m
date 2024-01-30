Return-Path: <linux-kernel+bounces-44477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E60842295
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423972934A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17B16D1D3;
	Tue, 30 Jan 2024 11:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rUFMvo3s"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A436BB4B;
	Tue, 30 Jan 2024 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613211; cv=none; b=qgz5RtnZbliwZAK8pRS3glGgo/li0zbe5hvgZ/Wo1AY5arNt6BmjQta26PLt4AM77OgEzQbxxC5MwyPeha2MTe7FwMcebqFz9/04PgO/WBsIonqy8xCgi9nuJstfmAKx0aXHDSAQGrcVrraqi6LpKRtHu+VIR68VpL8PqgDcRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613211; c=relaxed/simple;
	bh=tALIom+m2UHdd4MK7i96Hl0n8kwKYP1fIX+bHaIVr5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSRwgsKrdKhNH5OMWQ/AyavFD80puuCq3GmmNfeC7/kuSwCxPxuxpQU7Uy25TjK0oCkbQNOuMI/l737eBFP+amB7pQl/3MdkZkeeQogyrVx+DSrinZtSWLLmRIzMBhiI8M6pTELn9Wc4vhjv+j+yT5w/PmY+n7Mr/j+95atMJIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rUFMvo3s; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613207;
	bh=tALIom+m2UHdd4MK7i96Hl0n8kwKYP1fIX+bHaIVr5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rUFMvo3sF6288p/svf/iiNTjMvBJ7/BzP6UOsscYf7QMifiGGb/vb+JQk3FOhdIlV
	 eng+RaU5Qt3T075W1v3+urH/MHY1FTo3LdDa8NoJIOiR56zC01WrRBxGL5R8qBxCZN
	 aaXVTNue3NnAdoG91/1g1oibI7B2clwdqRiimkUFJqvFDTQkmJCTlNocNxxgfA5OBi
	 b0HM2hwvOPecrep4f6scSKICFvS2pt8OdSWh8If65gshtAKNMIhZDhbtK9xE400ZXo
	 172jBuREMQ7r3jwu1zN54kdDUJHPkBOmicQKy5cikJTyUltYPFYGvBW+8VM/fLezf+
	 qt2Ro2VCKxj6Q==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A4B29378208B;
	Tue, 30 Jan 2024 11:13:25 +0000 (UTC)
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
Subject: [PATCH v1 08/18] thermal: intel: pch_thermal: Migrate to thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:40 +0100
Message-ID: <20240130111250.185718-9-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/intel/intel_pch_thermal.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/intel/intel_pch_thermal.c b/drivers/thermal/intel/intel_pch_thermal.c
index b3905e34c507..73d7c2ac7dbc 100644
--- a/drivers/thermal/intel/intel_pch_thermal.c
+++ b/drivers/thermal/intel/intel_pch_thermal.c
@@ -160,6 +160,7 @@ static int intel_pch_thermal_probe(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
 	enum pch_board_ids board_id = id->driver_data;
+	struct thermal_zone_device_params tzdp;
 	struct pch_thermal_device *ptd;
 	int nr_trips = 0;
 	u16 trip_temp;
@@ -233,10 +234,13 @@ static int intel_pch_thermal_probe(struct pci_dev *pdev,
 
 	nr_trips += pch_wpt_add_acpi_psv_trip(ptd, nr_trips);
 
-	ptd->tzd = thermal_zone_device_register_with_trips(board_names[board_id],
-							   ptd->trips, nr_trips,
-							   0, ptd, &tzd_ops,
-							   NULL, 0, 0);
+	tzdp.tzp.type = board_names[board_id];
+	tzdp.tzp.devdata = ptd;
+	tzdp.tzp.trips = ptd->trips;
+	tzdp.tzp.num_trips = nr_trips;
+	tzdp.tzp.ops = &tzd_ops;
+
+	ptd->tzd = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(ptd->tzd)) {
 		dev_err(&pdev->dev, "Failed to register thermal zone %s\n",
 			board_names[board_id]);
-- 
2.43.0


