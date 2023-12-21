Return-Path: <linux-kernel+bounces-8383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A5C81B670
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50731F25F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E235D7994F;
	Thu, 21 Dec 2023 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qicGfq/R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE99678E6A;
	Thu, 21 Dec 2023 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162923;
	bh=0ZHYzhTVEyHVYGEu0Vbtv3RzxoA8W7+Bwiowr0GjFQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qicGfq/RblLFSM9Pq53+m0knm05zAUH9HGX+bxyrbFDrUna7hNhaCyIjgX8Wz1odN
	 /3Nz9U2MJkq3B1mlKoFZIf0leMIITRNe/54GLLcnLfSOo/WpP182iaLos9RZrUUO3T
	 v79xf5mSj7IZSwLKM9XqmNcVkziLa7HEuFWmL6v0buUcub17GdMYl7ELBddarnEauH
	 Uc8cUy7Hic0AJR5n/5GAs3IQOHquCEVERD5ep0qzjo3RkKCvBqHMVjz8QgmXHI4phg
	 VRHxyZs6aM4ciEiASZ+ypVZLGd++LBRpJcxL1bixrr68AtqhD48ttWrryEkmoX0LR5
	 Ei4e3xqd8Rhvg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 99818378201D;
	Thu, 21 Dec 2023 12:48:42 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 14/26] thermal: intel: x86_pkg_temp: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:13 +0100
Message-ID: <20231221124825.149141-15-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 11a7f8108bbb..8fdab44d28df 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -57,10 +57,6 @@ struct zone_device {
 	struct cpumask			cpumask;
 };
 
-static struct thermal_zone_params pkg_temp_tz_params = {
-	.no_hwmon	= true,
-};
-
 /* Keep track of how many zone pointers we allocated in init() */
 static int max_id __read_mostly;
 /* Array of zone pointers */
@@ -312,6 +308,11 @@ static struct thermal_trip *pkg_temp_thermal_trips_init(int cpu, int tj_max, int
 
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
+	struct thermal_zone_device_params tzdp = {
+		.type = "x86_pkg_temp",
+		.tzp = { .no_hwmon = true },
+		.ops = &tzone_ops,
+	};
 	int id = topology_logical_die_id(cpu);
 	u32 eax, ebx, ecx, edx;
 	struct zone_device *zonedev;
@@ -344,10 +345,13 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 
 	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
 	zonedev->cpu = cpu;
-	zonedev->tzone = thermal_zone_device_register_with_trips("x86_pkg_temp",
-			zonedev->trips, thres_count,
-			(thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
-			zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
+
+	tzdp.devdata = zonedev;
+	tzdp.trips = zonedev->trips;
+	tzdp.num_trips = thres_count;
+	tzdp.mask = (thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01;
+
+	zonedev->tzone = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(zonedev->tzone)) {
 		err = PTR_ERR(zonedev->tzone);
 		goto out_kfree_trips;
-- 
2.43.0


