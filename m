Return-Path: <linux-kernel+bounces-8384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB8481B674
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A08C1F25DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8436E7A200;
	Thu, 21 Dec 2023 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QicB7AJB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8937F78E91;
	Thu, 21 Dec 2023 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162924;
	bh=VcggBe2EeLqiQDA9strzfLU3yta4SiXSv2ot71tu2xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QicB7AJBvJbAbnQ8IX/E4WBw6nkBbaAxDgxJIHc8Li/4XOq1epT9EBbL4M4wvloeg
	 MkPxtwMcjO5rxdNpYFFTZ/04Mi+c35VpvKOXrk5jEdVXqiuQ+pIbfQg3Pz9GciRKYQ
	 9Lt0QysUjcngt2jfNX+z/LsR8rIwQPkzweqiHgKdB0zNQk3ZwHuH68Ljunq1VFwDA5
	 Hb5GF6nFWO43TOZl7m2fSRy58CvA/C+NOV6CPDf3/sEDpt1paAhfsqp6GbuS3lTA6+
	 hvNlWFYeN+58RnnTzguYtbNsoxUoNVlJM2a35sBT18UNfKbthwmmhx2+CHUTW22rXy
	 9/I5oKmGi9QPg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6135B3782021;
	Thu, 21 Dec 2023 12:48:43 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 15/26] power: supply: core: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:14 +0100
Message-ID: <20231221124825.149141-16-angelogioacchino.delregno@collabora.com>
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
 drivers/power/supply/power_supply_core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 73265001dd4b..d656a2e39157 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1297,6 +1297,12 @@ static struct thermal_zone_device_ops psy_tzd_ops = {
 
 static int psy_register_thermal(struct power_supply *psy)
 {
+	struct thermal_zone_device_params tzdp = {
+		/* Prefer our hwmon device and avoid duplicates */
+		.tzp = { .no_hwmon = IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON) },
+		.ops = &psy_tzd_ops,
+		.devdata = psy
+	};
 	int ret;
 
 	if (psy->desc->no_thermal)
@@ -1304,12 +1310,8 @@ static int psy_register_thermal(struct power_supply *psy)
 
 	/* Register battery zone device psy reports temperature */
 	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
-		/* Prefer our hwmon device and avoid duplicates */
-		struct thermal_zone_params tzp = {
-			.no_hwmon = IS_ENABLED(CONFIG_POWER_SUPPLY_HWMON)
-		};
-		psy->tzd = thermal_tripless_zone_device_register(psy->desc->name,
-				psy, &psy_tzd_ops, &tzp);
+		tzdp.name = psy->desc->name;
+		psy->tzd = thermal_zone_device_register(&tzdp);
 		if (IS_ERR(psy->tzd))
 			return PTR_ERR(psy->tzd);
 		ret = thermal_zone_device_enable(psy->tzd);
-- 
2.43.0


