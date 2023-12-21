Return-Path: <linux-kernel+bounces-8374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3506A81B65D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679AC1C22F74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BB176DC0;
	Thu, 21 Dec 2023 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X0kpciBk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFEF760B4;
	Thu, 21 Dec 2023 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162917;
	bh=lN2kEBY91fJMh8nUO8EEJ+b8UdVj8nBk40WMG7UhE1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X0kpciBkLzwodvPTU/VviekD45Ye51zgVzk4Wh8IaaFSJrjmLzD0A0Yqa9yzgh/hg
	 YgmgDct4djWi3LV1rWVAiwUyo6zoblAKu8v95CacQYYN2dXE0LMtXLbsv9AOhFC+uo
	 00dn4kDKIODoEYrKSpMDz1NKJ+SGvDgFdIwwYj/vAPM7fOrpEt1UC2undAnn5zmt6r
	 qK4/ArbXmGJqVPgvLUOnk7LiBzZqJ5SgyB1jwcpFd65BQh+3c/Fw7ax/2bfdlafTzh
	 AiDrL1UFLgt/ZrxqR1kWe6Aev7PK1BHumN9xUD0vopvDhGmbMx9qQcYUn0OxkXSvyl
	 2RcD5mfsqSCoQ==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3571F378200A;
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
Subject: [RFC PATCH 07/26] thermal/drivers/rcar: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:06 +0100
Message-ID: <20231221124825.149141-8-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/rcar_thermal.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index feb848d595fa..71bc7353285d 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -488,10 +488,15 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 						dev, i, priv,
 						&rcar_thermal_zone_ops);
 		} else {
-			priv->zone = thermal_zone_device_register_with_trips(
-				"rcar_thermal", trips, ARRAY_SIZE(trips), 0, priv,
-						&rcar_thermal_zone_ops, NULL, 0,
-						idle);
+			struct thermal_zone_device_params tzdp = {
+				.type = "rcar_thermal",
+				.ops = &rcar_thermal_zone_ops,
+				.devdata = priv,
+				.trips = trips,
+				.num_trips = ARRAY_SIZE(trips),
+				.polling_delay = idle,
+			};
+			priv->zone = thermal_zone_device_register(&tzdp);
 
 			ret = thermal_zone_device_enable(priv->zone);
 			if (ret) {
-- 
2.43.0


