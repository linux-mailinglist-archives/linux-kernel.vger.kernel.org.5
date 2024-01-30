Return-Path: <linux-kernel+bounces-44473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EACF6842283
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A684A292D82
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91456A322;
	Tue, 30 Jan 2024 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ktna+Kv7"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2B367A0B;
	Tue, 30 Jan 2024 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613204; cv=none; b=bXUyspxzM9KPy8nVY1IdewpdJrrXVltlhwm+7vRv1ZX+kaEi+46CWckP2854cZIKTLWW++wcGZ5nR+pl5azVCMJB0XbFLtv4KaESd6T0yNh+8dJRdbA9OMHp9bxirSv7Q2tZ8gQUkUimAxTfHvEvw1ohAqfU2emkKy4JJrN5/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613204; c=relaxed/simple;
	bh=X32Bcgql6uQHTDnzXYAHs6Ep92uAw8IaBvn5qiYUvoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oU+ICtqbzYe+y5kq/Z0xJJeC89QeA6P17Awb0PLsczbXjghqFAsGVsDDzBQWGBd94XMDUzZYWU9rhzUEj0eHPz79pAUEz5vq21/XC+uKwW8nMtxVofEEVkxlQos1l/n0rmbRqYaPxYb0rbCQhtzcDsjv+Mlzfx+VdfMK2J1UAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ktna+Kv7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613201;
	bh=X32Bcgql6uQHTDnzXYAHs6Ep92uAw8IaBvn5qiYUvoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ktna+Kv7gfh7dk/63on+MZmh7HvZIJKzc/m0yfqmwGfo5hx0NNfEha4GXbFQvmHwR
	 OJ6fj4vz1P+UE5mn5+5GlaDR23qM5foBhIcP5qvh41k44f6y95fFJhmajFqInrtlDl
	 SEHtJY3yfUyQOELakeI944UolMKSxiqY5VPbIg3KmluUPJkE6Trjr7qcJirhFdsdrW
	 Gd90I/qARmjUPlohsvCbZMBc9ML05RSKKNkOLDS7TgXhvq7gBX4tJta6QqkFhk1pjU
	 zHCWcBu6WA9LNkz5OLhfGx4Muwjtzfwnr5khGaOQpMp03aCHRyDV7/s+LS4muL819z
	 5NFPmb2KLjhGA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EAED0378208D;
	Tue, 30 Jan 2024 11:13:18 +0000 (UTC)
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
Subject: [PATCH v1 05/18] thermal/drivers/imx: Migrate to thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:37 +0100
Message-ID: <20240130111250.185718-6-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/imx_thermal.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 7019c4fdd549..16fb49194fb3 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -599,6 +599,15 @@ static inline void imx_thermal_unregister_legacy_cooling(struct imx_thermal_data
 
 static int imx_thermal_probe(struct platform_device *pdev)
 {
+	struct thermal_zone_device_params tzdp = {
+		.tzp = {
+			.type = "imx_thermal_zone",
+			.ops = &imx_tz_ops,
+			.mask = BIT(IMX_TRIP_PASSIVE),
+			.passive_delay = IMX_PASSIVE_DELAY,
+			.polling_delay = IMX_POLLING_DELAY,
+		}
+	};
 	struct imx_thermal_data *data;
 	struct regmap *map;
 	int measure_freq;
@@ -696,13 +705,11 @@ static int imx_thermal_probe(struct platform_device *pdev)
 		goto legacy_cleanup;
 	}
 
-	data->tz = thermal_zone_device_register_with_trips("imx_thermal_zone",
-							   trips,
-							   ARRAY_SIZE(trips),
-							   BIT(IMX_TRIP_PASSIVE), data,
-							   &imx_tz_ops, NULL,
-							   IMX_PASSIVE_DELAY,
-							   IMX_POLLING_DELAY);
+	tzdp.tzp.devdata = data;
+	tzdp.tzp.trips = &trips;
+	tzdp.tzp.num_trips = ARRAY_SIZE(trips);
+
+	data->tz = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(data->tz)) {
 		ret = PTR_ERR(data->tz);
 		dev_err(&pdev->dev,
-- 
2.43.0


