Return-Path: <linux-kernel+bounces-44481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A6A8422A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D1B1C21B18
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F7966B4A;
	Tue, 30 Jan 2024 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="1lPMjJgz"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F6274E0D;
	Tue, 30 Jan 2024 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613219; cv=none; b=NTmg5F1FQWf83lhqxDdjVXonyiSZsDSUnZw6mY6aZxBqcsMEHXImpA07CxQRWU0r2aL+0l7c8rcpeXV0FNO15ixX2RgLFXo4YYTJP6uX0Ze9pPrIIyHwfGI1r842Kk+UqZ409GASG1e4eThcZs0R3nLy6M7WufDEHRVtJSZOVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613219; c=relaxed/simple;
	bh=jX8eexMy1avLh8dlPbkEyo4c5yBA7XPn/CK+R650NbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNVaqNxAXpB49wac9i9G/Vzsk/7M0p5ZowglsoYR6W1/Ubu4roTmCrn7AVqBYFtlSfhi9SY6JtRlrp6+aI8LvSeEpvib+aEqWz7CofqGFlaMHiXVJltpNCJ8aWjBzCP/VTtdFR3TzMHE3SpzSZNgMMtKQCT4QxBA32/2Pei29bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=1lPMjJgz; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706613216;
	bh=jX8eexMy1avLh8dlPbkEyo4c5yBA7XPn/CK+R650NbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1lPMjJgzotfkB90XRVoWGZlENgOEHhc7wkebDfMVFSons4LdaXxnWLlgTJHquu3bj
	 qUlJ/KqMhF7Uc0qtf1K+jYdXnrE7z+HcfdPmomI02IXIZHGrZCRVDj+2t+rZewbuW4
	 n598Lj0/FjURzHIjqSgv2/oqR1kf253bx9CdsfW0H9eSlo8+uPYsxDlPabyqpH1o8V
	 L7Xr3HvHtpGH5eJVVzO2ReIXQrIQiIsz5zK4C7IKCz1Y3O847OruuGHb4hd4L2sJ+9
	 OcxXiixsSuIFTxXRN060iKRrO5hTnD7grEagsne3m7VK4O2rPBVmQmISKwnNEZXYX1
	 65zueO5ac3IxA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7A9043782081;
	Tue, 30 Jan 2024 11:13:34 +0000 (UTC)
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
Subject: [PATCH v1 12/18] thermal: int340x: processor: Migrate to thermal_zone_device_register()
Date: Tue, 30 Jan 2024 12:12:44 +0100
Message-ID: <20240130111250.185718-13-angelogioacchino.delregno@collabora.com>
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
 .../processor_thermal_device_pci.c            | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index d7495571dd5d..3170eab57e32 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -242,13 +242,19 @@ static struct thermal_zone_device_ops tzone_ops = {
 	.set_trip_temp	= sys_set_trip_temp,
 };
 
-static struct thermal_zone_params tzone_params = {
-	.governor_name = "user_space",
-	.no_hwmon = true,
-};
-
 static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	struct thermal_zone_device_params tzdp = {
+		.tzp = {
+			.type = "TCPU_PCI",
+			.mask = 1,
+			.no_hwmon = true,
+			.ops = &tzone_ops,
+		},
+	};
+	struct thermal_governor_params tgp = {
+		.governor_name = "user_space"
+	};
 	struct proc_thermal_device *proc_priv;
 	struct proc_thermal_pci *pci_info;
 	int irq_flag = 0, irq, ret;
@@ -289,10 +295,12 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 
 	psv_trip.temperature = get_trip_temp(pci_info);
 
-	pci_info->tzone = thermal_zone_device_register_with_trips("TCPU_PCI", &psv_trip,
-							1, 1, pci_info,
-							&tzone_ops,
-							&tzone_params, 0, 0);
+	tzdp.tzp.devdata = pci_info;
+	tzdp.tzp.trips = &psv_trip;
+	tzdp.tzp.num_trips = 1;
+	tzdp.tgp = &tgp;
+
+	pci_info->tzone = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(pci_info->tzone)) {
 		ret = PTR_ERR(pci_info->tzone);
 		goto err_del_legacy;
-- 
2.43.0


