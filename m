Return-Path: <linux-kernel+bounces-8369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D3581B652
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37F11C24424
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19C5745CD;
	Thu, 21 Dec 2023 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Yfc+M27n"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E86F602;
	Thu, 21 Dec 2023 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162913;
	bh=CUiivx2KB9ULlkM3oFhD369DYLNqb+gWzcXQBgX77n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yfc+M27nJq5whbliK87wubRT+rAMmn7gW902W5ZtohEp5acJJgtMJnJ7cjOMEgmJn
	 ZwMXPmkDWHGQz0jl2hKe/E4ViKO8BuF+qqD+26WhFqsFOdXS1gRWEiRVBQVSWhlgwA
	 0IUiocI1rtAntsh7+IxwtO9gfh3eGl14DX3oer6uyemcrwzbkwo6CvRlnxLXGqSZAT
	 1kvLm4RbtdxeC1EH3drNQjTZklQsTXnF7b1MuCKrvXSGjyPUjCszbtAHx8cA+Q42J7
	 DNioY3SS4ZbiW2e4QnY5xewqI04i2nWPBkOWG6U1fJpMAMkenFPISzPcsPH5wmr1jv
	 5hC6wBSfcyywg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 514BF3781FFF;
	Thu, 21 Dec 2023 12:48:33 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 02/26] thermal/of: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:01 +0100
Message-ID: <20231221124825.149141-3-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/thermal_of.c | 37 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 1e0655b63259..62a903ad649f 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -471,16 +471,12 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 							    const struct thermal_zone_device_ops *ops)
 {
 	struct thermal_zone_device *tz;
-	struct thermal_trip *trips;
-	struct thermal_zone_params tzp = {};
-	struct thermal_zone_device_ops *of_ops;
+	struct thermal_zone_device_params tzdp;
 	struct device_node *np;
-	int delay, pdelay;
-	int ntrips, mask;
 	int ret;
 
-	of_ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
-	if (!of_ops)
+	tzdp.ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
+	if (!tzdp.ops)
 		return ERR_PTR(-ENOMEM);
 
 	np = of_thermal_zone_find(sensor, id);
@@ -490,30 +486,29 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 		ret = PTR_ERR(np);
 		goto out_kfree_of_ops;
 	}
+	tzdp.type = np->name;
 
-	trips = thermal_of_trips_init(np, &ntrips);
-	if (IS_ERR(trips)) {
+	tzdp.trips = thermal_of_trips_init(np, &tzdp.num_trips);
+	if (IS_ERR(tzdp.trips)) {
 		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-		ret = PTR_ERR(trips);
+		ret = PTR_ERR(tzdp.trips);
 		goto out_kfree_of_ops;
 	}
 
-	ret = thermal_of_monitor_init(np, &delay, &pdelay);
+	ret = thermal_of_monitor_init(np, &tzdp.polling_delay, &tzdp.passive_delay);
 	if (ret) {
 		pr_err("Failed to initialize monitoring delays from %pOFn\n", np);
 		goto out_kfree_trips;
 	}
 
-	thermal_of_parameters_init(np, &tzp);
+	thermal_of_parameters_init(np, &tzdp.tzp);
 
-	of_ops->bind = thermal_of_bind;
-	of_ops->unbind = thermal_of_unbind;
+	tzdp.ops->bind = thermal_of_bind;
+	tzdp.ops->unbind = thermal_of_unbind;
+	tzdp.mask = GENMASK_ULL((tzdp.num_trips) - 1, 0);
+	tzdp.devdata = data;
 
-	mask = GENMASK_ULL((ntrips) - 1, 0);
-
-	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
-						     mask, data, of_ops, &tzp,
-						     pdelay, delay);
+	tz = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(tz)) {
 		ret = PTR_ERR(tz);
 		pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
@@ -531,9 +526,9 @@ static struct thermal_zone_device *thermal_of_zone_register(struct device_node *
 	return tz;
 
 out_kfree_trips:
-	kfree(trips);
+	kfree(tzdp.trips);
 out_kfree_of_ops:
-	kfree(of_ops);
+	kfree(tzdp.ops);
 
 	return ERR_PTR(ret);
 }
-- 
2.43.0


