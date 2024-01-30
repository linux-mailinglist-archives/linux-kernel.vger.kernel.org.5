Return-Path: <linux-kernel+bounces-44475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D213584228D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109811C23319
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DA76BB4F;
	Tue, 30 Jan 2024 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lVC64xCk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30AF6A35F;
	Tue, 30 Jan 2024 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613208; cv=none; b=lH0sDFFCpz6KJ+s5NQreeJNo6oRfXQTUD2ZJGVQQ0kSJVKfj3EH72mJ1ZTkq6LCKpcSmtrXbPpn0gIAGsr30zDZb+l6ZDH/F+iRJOSVJc65YCfo/XOrlx7D0DKjM7GLkm9yA+gz4RFWSyH7y4YaYj/ZDSEMaH4Q8Y0kI/xKQ8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613208; c=relaxed/simple;
	bh=SKppNY4y88YWZiAw2UK5DtE27VayRH8M42y87uCkgxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GliNzxGXyUX7aOe6q7vxxZhRrQjM2YR/l2cZKiXXqfFFtsb7RzpW0jC8FbKd8rXRNVD/gKl0d+tWso16plAVMtvSm/D8tJEXXVOqlloYL0HlezcKDPcvfHm2MkQ4DQdqXBAxKIE9e2loBBGpaUx5/xO072cZIsB5cmQTgsJ85Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lVC64xCk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613205;
	bh=SKppNY4y88YWZiAw2UK5DtE27VayRH8M42y87uCkgxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lVC64xCk8sDHIzLwI/8kQl+6GHoL27D7uzAPQWBJkq5e7JFhlBhhkhJMqNBJk4bBn
	 kgfQuTfqBtn+R1qVhTIv6C/Af26MyfOrr6eBJxf5EKSl2FyRvWjZ7Y2POcJIfvCWYB
	 hGqNxr1xbCWw9fmsK4YRuFVUfRj/5f4zukWxF3N0KERLN5CBh9Tw1X1Zqy6LqsfMaG
	 ghuwbM5CuK9ntb2PXesJJsn10fwh4TfLlwN1wKLlXZUVkr3cI5BXQFdP6YgfGo8GiH
	 1zcE71dkgHMFFnsyW2+CTsDHZdYKFWdax2ZMtrLO+gBEef2YOjoh70cxKyhDClknqq
	 QWJI8+H3T6Udg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6BB713782089;
	Tue, 30 Jan 2024 11:13:23 +0000 (UTC)
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
Subject: [PATCH v1 07/18] thermal/drivers/st: Migrate to thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:39 +0100
Message-ID: <20240130111250.185718-8-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/st/st_thermal.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 0d6249b36609..2f7b22764bd0 100644
--- a/drivers/thermal/st/st_thermal.c
+++ b/drivers/thermal/st/st_thermal.c
@@ -143,9 +143,9 @@ int st_thermal_register(struct platform_device *pdev,
 	struct st_thermal_sensor *sensor;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	struct thermal_zone_device_params tzdp;
 	const struct of_device_id *match;
 
-	int polling_delay;
 	int ret;
 
 	if (!np) {
@@ -197,14 +197,17 @@ int st_thermal_register(struct platform_device *pdev,
 	if (ret)
 		goto sensor_off;
 
-	polling_delay = sensor->ops->register_enable_irq ? 0 : 1000;
-
 	trip.temperature = sensor->cdata->crit_temp;
 	trip.type = THERMAL_TRIP_CRITICAL;
 
-	sensor->thermal_dev =
-		thermal_zone_device_register_with_trips(dev_name(dev), &trip, 1, 0, sensor,
-							&st_tz_ops, NULL, 0, polling_delay);
+	tzdp.tzp.type = dev_name(dev);
+	tzdp.tzp.ops = &st_tz_ops;
+	tzdp.tzp.devdata = sensor;
+	tzdp.tzp.trips = &trip;
+	tzdp.tzp.num_trips = 1;
+	tzdp.tzp.polling_delay = sensor->ops->register_enable_irq ? 0 : 1000;
+
+	sensor->thermal_dev = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(sensor->thermal_dev)) {
 		dev_err(dev, "failed to register thermal zone device\n");
 		ret = PTR_ERR(sensor->thermal_dev);
-- 
2.43.0


