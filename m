Return-Path: <linux-kernel+bounces-8375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E79A81B65F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0BE1C237DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168DE77622;
	Thu, 21 Dec 2023 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0rXki/i7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA6876900;
	Thu, 21 Dec 2023 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162918;
	bh=p/EOsjlnUG8TWP5dtPJrrTSLSXOX9zk6B1BSsJtTuDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0rXki/i7WMZ5tTuOkWXzYijiL60wn+uxW5CzF708Pd9ZGIjF2XenuOGQKkCDNDz0B
	 Efnzm5IvxZsSzj3O4Qer/vrxpTgxSV3qAHm49rVvPQaI7r6v4QK243V5fwl2Vmzx2k
	 80mH6QJwBqy7VQxL5b2eS6rc5REF/LcvAc/QAFRksHGudONXupFywD9jpOoXBQdOmq
	 /w7SkHiWLU/gwytAbcZdvZmAA9xGGOaQDhCsXUD9nv4mVM6+pwDJPin3Ij/vZINJ8K
	 go4OIZSOad9kM5Bwv+8blxAjdPdEfwENZ7ixPBxY+hFqd+xOQ25ZMMQI6Zx9iBTjkm
	 LSQjhJhM1pwUw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F11143782007;
	Thu, 21 Dec 2023 12:48:37 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 08/26] thermal/drivers/st: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:07 +0100
Message-ID: <20231221124825.149141-9-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/st/st_thermal.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
index 0d6249b36609..ff4fe417a99b 100644
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
+	tzdp.type = dev_name(dev);
+	tzdp.ops = &st_tz_ops;
+	tzdp.devdata = sensor;
+	tzdp.trips = &trip;
+	tzdp.num_trips = 1;
+	tzdp.polling_delay = sensor->ops->register_enable_irq ? 0 : 1000;
+
+	sensor->thermal_dev = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(sensor->thermal_dev)) {
 		dev_err(dev, "failed to register thermal zone device\n");
 		ret = PTR_ERR(sensor->thermal_dev);
-- 
2.43.0


