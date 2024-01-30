Return-Path: <linux-kernel+bounces-44482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 311148422AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21927B24D41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5827E76917;
	Tue, 30 Jan 2024 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k+Pvr5PF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FEE76040;
	Tue, 30 Jan 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613221; cv=none; b=V/PMxD0o3Lf3swVFYHXl1UiJrRqwvelONKLbzJudhtwzlkZ1K9j+2v6+7Nzj9VmFvcVjqlw592tibO2hWWaPlY99tdQCUqa2P8iDatjSpCZ04BhtIoKlWjdNh08aOVtqRTVaXWAHe5zKR5/jABScvllLYn+mni7bWWnYrl2PvyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613221; c=relaxed/simple;
	bh=ltmDsQGVDHJUuzGsD5EBKmLtvB2i4AwTm6AwkiKQz8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dF54fArChTJG3uzj0bPxfd6536DHv1YjxAkCdri0B6E6pUf9huEDj1BuiZnBEip/EHU003LS6faTBZ4ruZjXxqUgBA3SWn1FuuRBHZDkPDLCBnlCo10ndnaN88byTcjjDrWotx2/5A9T31b6kQVgpQs57jUrOm00S/QrSPeuK5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k+Pvr5PF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613218;
	bh=ltmDsQGVDHJUuzGsD5EBKmLtvB2i4AwTm6AwkiKQz8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k+Pvr5PF/8OxlEHtizkNA/wV73S/GSrIoeFwPktq0CskoU8oQXYyLAEuk8CIaMWxn
	 8CP1kdqXu/0cmNm/3gXAwvo3oGNxPidoEY5x8GHSEJAxXfFXVeRc+IeTsDAFk7alxv
	 Poxq+hn/Khi/0drMbOAkawG7UKkBUlPWEVMRsC38VDQr8QajxwXfZbbctOLADiCaYY
	 batYvsGFo1vSTbspongqTUZXtw2xX7/byFMPIE14Bqulw0HF70MzLrdBcjvLRvhPaY
	 VKgMK7Q0lzxsC184UtpQATd5PJDool3nqAgSCweQOWiWAFdOuXNN3ig5Q/4UYqu2Sq
	 HyC5l1edePZxw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B154237811F4;
	Tue, 30 Jan 2024 11:13:36 +0000 (UTC)
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
Subject: [PATCH v1 13/18] thermal: intel: x86_pkg_temp: Migrate to thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:45 +0100
Message-ID: <20240130111250.185718-14-angelogioacchino.delregno@collabora.com>
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
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 22 +++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 11a7f8108bbb..0bdc1d1855e2 100644
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
@@ -312,6 +308,13 @@ static struct thermal_trip *pkg_temp_thermal_trips_init(int cpu, int tj_max, int
 
 static int pkg_temp_thermal_device_add(unsigned int cpu)
 {
+	struct thermal_zone_device_params tzdp = {
+		.tzp = {
+			.type = "x86_pkg_temp",
+			.ops = &tzone_ops,
+			.no_hwmon = true,
+		}
+	};
 	int id = topology_logical_die_id(cpu);
 	u32 eax, ebx, ecx, edx;
 	struct zone_device *zonedev;
@@ -344,10 +347,13 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 
 	INIT_DELAYED_WORK(&zonedev->work, pkg_temp_thermal_threshold_work_fn);
 	zonedev->cpu = cpu;
-	zonedev->tzone = thermal_zone_device_register_with_trips("x86_pkg_temp",
-			zonedev->trips, thres_count,
-			(thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01,
-			zonedev, &tzone_ops, &pkg_temp_tz_params, 0, 0);
+
+	tzdp.tzp.devdata = zonedev;
+	tzdp.tzp.trips = zonedev->trips;
+	tzdp.tzp.num_trips = thres_count;
+	tzdp.tzp.mask = (thres_count == MAX_NUMBER_OF_TRIPS) ? 0x03 : 0x01;
+
+	zonedev->tzone = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(zonedev->tzone)) {
 		err = PTR_ERR(zonedev->tzone);
 		goto out_kfree_trips;
-- 
2.43.0


