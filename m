Return-Path: <linux-kernel+bounces-8382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D30481B66E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFC91F25E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0252C79472;
	Thu, 21 Dec 2023 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qVC94pb6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EBD73183;
	Thu, 21 Dec 2023 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162922;
	bh=ets5nsuLlL8i2zc6z+9zFMpYPN9x47J3B6r/zyrf0o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVC94pb6NlGn9J1easJVCRLh0S7amPjKMQr1Hz0ix0GAY1zpO8002qwQ4e+yEcwiT
	 Uh/+Lm2zTx6s6uSsb/GV6X8/oXMSgEGdbBwdjk9BfhAt6fylqZWPlwQBQh/ftLnVyT
	 6Ux63gwR4HWGbOGvDLBRxfX9senJxLWhGCbLLfQCxSjwpjZhyBlxiK5PiUovHK0EJ1
	 YVjzXD7ZbzRZY2DkMWAHlGumKiRmCbHzAzO+5LHgijH7zGTBBANkPN9xk1xXRpZytz
	 pXq5mR2+L1xtFxgOcqcXuydCj+lVO72M9DA0ZkHKKUd6Wiv3C3+mbaLEfnjDXhYE0T
	 yZQ5l3sS30BCw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D1843378201A;
	Thu, 21 Dec 2023 12:48:41 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 13/26] thermal: int340x: processor: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:12 +0100
Message-ID: <20231221124825.149141-14-angelogioacchino.delregno@collabora.com>
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
 .../processor_thermal_device_pci.c            | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
index d7495571dd5d..1e7b9172e11d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.c
@@ -242,13 +242,17 @@ static struct thermal_zone_device_ops tzone_ops = {
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
+		.type = "TCPU_PCI",
+		.tzp = {
+			.governor_name = "user_space",
+			.no_hwmon = true,
+		},
+		.ops = &tzone_ops,
+		.mask = 1,
+	};
 	struct proc_thermal_device *proc_priv;
 	struct proc_thermal_pci *pci_info;
 	int irq_flag = 0, irq, ret;
@@ -289,10 +293,11 @@ static int proc_thermal_pci_probe(struct pci_dev *pdev, const struct pci_device_
 
 	psv_trip.temperature = get_trip_temp(pci_info);
 
-	pci_info->tzone = thermal_zone_device_register_with_trips("TCPU_PCI", &psv_trip,
-							1, 1, pci_info,
-							&tzone_ops,
-							&tzone_params, 0, 0);
+	tzdp.devdata = pci_info;
+	tzdp.trips = &psv_trip;
+	tzdp.num_trips = 1;
+
+	pci_info->tzone = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(pci_info->tzone)) {
 		ret = PTR_ERR(pci_info->tzone);
 		goto err_del_legacy;
-- 
2.43.0


