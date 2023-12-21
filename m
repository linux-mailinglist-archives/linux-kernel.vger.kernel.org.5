Return-Path: <linux-kernel+bounces-8371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8684881B657
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443992824A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33319760A9;
	Thu, 21 Dec 2023 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="eBhoe2sl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B974087;
	Thu, 21 Dec 2023 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162915;
	bh=wYH99HJxGwYPUgw1yllFolH3TiZQvNSnRw2wR2wMWDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBhoe2sl9Wdo73MB1dJsbH4HO8TSEMWSwSBP4KHs2bTPYVtmc4Jes2HjCmh3jzIU/
	 jNJJLnsPTG8/T8vKpTSLK+sHpMaqWVnK6WLiDNBYIVf11MHB/kv35RXmxFC5hpyTJW
	 U17OC/+3kgAe1QQRf/Y8bbZ0C3+mLYS6WgG+euz+bEY3NfyDHVS2alE4sbcP9LC9Bj
	 pqxwcQ/rDpQRnjz2j0bLwij5CsPhHhgQGmRnxWhiL8Ann4YwOH1+jNRVpSc7QKXjKm
	 Xa2ymIWDQkHB/Yjir3w/PPKpfRCrAgWcYm1Aff764fYddhQ6/Mfd0FVa+6KN87pcHw
	 JZeywBMMTFOYg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DD8083782005;
	Thu, 21 Dec 2023 12:48:34 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: daniel.lezcano@linaro.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	kernel@collabora.com
Subject: [RFC PATCH 04/26] ACPI: thermal: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:03 +0100
Message-ID: <20231221124825.149141-5-angelogioacchino.delregno@collabora.com>
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
 drivers/acpi/thermal.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index ee28ca93d983..e4f44e7bb3ec 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -664,16 +664,18 @@ static int acpi_thermal_register_thermal_zone(struct acpi_thermal *tz,
 					      unsigned int trip_count,
 					      int passive_delay)
 {
+	struct thermal_zone_device_params tzdp = {
+		.type = "acpitz",
+		.devdata = tz,
+		.ops = &acpi_thermal_zone_ops,
+		.trips = tz->trip_table,
+		.num_trips = trip_count,
+		.passive_delay = passive_delay,
+		.polling_delay = tz->polling_frequency * 100,
+	};
 	int result;
 
-	tz->thermal_zone = thermal_zone_device_register_with_trips("acpitz",
-								   tz->trip_table,
-								   trip_count,
-								   0, tz,
-								   &acpi_thermal_zone_ops,
-								   NULL,
-								   passive_delay,
-								   tz->polling_frequency * 100);
+	tz->thermal_zone = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(tz->thermal_zone))
 		return PTR_ERR(tz->thermal_zone);
 
-- 
2.43.0


