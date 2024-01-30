Return-Path: <linux-kernel+bounces-44474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4968A842288
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC78A1F2A78E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5406A35E;
	Tue, 30 Jan 2024 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eOE1anLR"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968FC6A036;
	Tue, 30 Jan 2024 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613206; cv=none; b=Eme6cqG85gRvkZtz8jYG9aCspK14+NdBr/ldqWggMrjt9Ac2tNKhYEW6lRuc6o9nFO5iT3NKFZ3HsZxV7Sw8+A79WuW+YyqzmnBMQUaDex9JE3lqyG/O29/h1Iq0Efnkp540G0YPCMeuc1mtSNALhVYqBlKMZuS/OG+IwcreB7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613206; c=relaxed/simple;
	bh=r/xN4hRek8FnzGLHk7xH3AKDZREzhfirE5eGw3Eh9wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPrxubwrE3p2hAICLgaCTFlA4zcuMYZddKeWtOQ/9yRUbL9lZuJaoIqMa31zNtdV8shel4CWZy0ff6uvoiFsgSmtdqRd7sFTwuJc93fYJJ/SQlHkOD0tjFt42leO7mpJZ+bdJQVR2XD8p2nOmq5l1gVEzu/Lcnbr8hArN1gYVts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=eOE1anLR; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613203;
	bh=r/xN4hRek8FnzGLHk7xH3AKDZREzhfirE5eGw3Eh9wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eOE1anLR0sO7qCXb2Ly395jDZB0e2lOHZp+jq/MN4nKFjriQu6xikVzStKQwrKmOi
	 2H7ywpnHpoYkH0NSc3UHHA4WsYigVt6ai/LainhNcERcpv3SM9UvMtr0ntytWcJWMG
	 Bhluz7E0AOJWfyyfn5J9V4Ixomum4G+KWETHtLs0N3wjk+HKgTXsx1Ov8HBCUdWAjF
	 kMHAMkfNNKS9Qcn4FwcWlE7K3MnWE8wKtSdM7IpTzGiATHcMXEjjbueaZpajKy8HoD
	 YMvaKhIPPN+kQzAGAWNs25N/T0MZiYGc3sP98BHD/obDuercnC4wX8JqY0qrbcYlVn
	 Frp7116h8Pbhg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 31A333782081;
	Tue, 30 Jan 2024 11:13:21 +0000 (UTC)
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
Subject: [PATCH v1 06/18] thermal/drivers/rcar: Migrate to thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:38 +0100
Message-ID: <20240130111250.185718-7-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/rcar_thermal.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index feb848d595fa..7bf9c1611a00 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -488,10 +488,17 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 						dev, i, priv,
 						&rcar_thermal_zone_ops);
 		} else {
-			priv->zone = thermal_zone_device_register_with_trips(
-				"rcar_thermal", trips, ARRAY_SIZE(trips), 0, priv,
-						&rcar_thermal_zone_ops, NULL, 0,
-						idle);
+			struct thermal_zone_device_params tzdp = {
+				.tzp = {
+					.type = "rcar_thermal",
+					.ops = &rcar_thermal_zone_ops,
+					.devdata = priv,
+					.trips = trips,
+					.num_trips = ARRAY_SIZE(trips),
+					.polling_delay = idle,
+				}
+			};
+			priv->zone = thermal_zone_device_register(&tzdp);
 
 			ret = thermal_zone_device_enable(priv->zone);
 			if (ret) {
-- 
2.43.0


