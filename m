Return-Path: <linux-kernel+bounces-8370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B278581B654
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FF06286061
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E2E745EC;
	Thu, 21 Dec 2023 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="opAaJfA0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFE973177;
	Thu, 21 Dec 2023 12:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703162914;
	bh=fhqcFV2ud7MgROogm/ayFQIpUEXX1NBHic7DYueqc2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=opAaJfA0u0w2KMoTORO6QOjSNIhpp6XFQJ0q8e1g4NkZbp4NraMMhwKC/M0O9Zclg
	 QSwjDlEq1j61eTDWiyM8a+eb0hhEO81a7P7e76K/aTqL4SiaZ6BnSwmN+b986no0iV
	 DDxIBs41gDXfclttDJbEvKv9SDKNw2bShJ1QrZsx6RkDxsVMoQgYPRunnb7yiQsnFF
	 tSGXQ5vqrimhX+RTvn3z9AZtdB/4Kvpgoqg8aGBu3SrwZYW2+MS0F6X/blN6fm5PQU
	 UH+sbOBBm+/bI1casrDkAk3ki5ttyMDggMmtzjINFdkyrS3VSkZ8QgKJhyTO1RE5nQ
	 H9fl+4MI5L+LA==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1E49A3782003;
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
Subject: [RFC PATCH 03/26] platform/x86: acerhdf: Migrate to thermal_zone_device_register()
Date: Thu, 21 Dec 2023 13:48:02 +0100
Message-ID: <20231221124825.149141-4-angelogioacchino.delregno@collabora.com>
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
 drivers/platform/x86/acerhdf.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 74bcb3d13104..f7c1710f736c 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -267,14 +267,6 @@ static const struct bios_settings bios_tbl[] __initconst = {
 	{"", "", "", 0, 0, {0, 0}, 0}
 };
 
-/*
- * this struct is used to instruct thermal layer to use bang_bang instead of
- * default governor for acerhdf
- */
-static struct thermal_zone_params acerhdf_zone_params = {
-	.governor_name = "bang_bang",
-};
-
 static int acerhdf_get_temp(int *temp)
 {
 	u8 read_temp;
@@ -669,6 +661,18 @@ static void acerhdf_unregister_platform(void)
 
 static int __init acerhdf_register_thermal(void)
 {
+	struct thermal_zone_device_params tzdp = {
+		.type = "acerhdf",
+		/*
+		 * this struct is used to instruct thermal layer to use
+		 * bang_bang instead of default governor for acerhdf
+		 */
+		.tzp = { .governor_name = "bang_bang" },
+		.ops = &acerhdf_dev_ops,
+		.trips = trips,
+		.num_trips = ARRAY_SIZE(trips),
+		.polling_delay = kernelmode ? interval * 1000 : 0,
+	};
 	int ret;
 
 	cl_dev = thermal_cooling_device_register("acerhdf-fan", NULL,
@@ -677,10 +681,7 @@ static int __init acerhdf_register_thermal(void)
 	if (IS_ERR(cl_dev))
 		return -EINVAL;
 
-	thz_dev = thermal_zone_device_register_with_trips("acerhdf", trips, ARRAY_SIZE(trips),
-							  0, NULL, &acerhdf_dev_ops,
-							  &acerhdf_zone_params, 0,
-							  (kernelmode) ? interval*1000 : 0);
+	thz_dev = thermal_zone_device_register(&tzdp);
 	if (IS_ERR(thz_dev))
 		return -EINVAL;
 
-- 
2.43.0


