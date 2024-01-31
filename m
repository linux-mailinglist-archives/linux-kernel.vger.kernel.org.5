Return-Path: <linux-kernel+bounces-47207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D9A844A89
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C561C244D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC823CF7D;
	Wed, 31 Jan 2024 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KrppY5x7"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D4D3BB32;
	Wed, 31 Jan 2024 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737849; cv=none; b=CvYRxvsrIY8lXvktBp+gwYxofkW6J3Zqf3EqT5O8+8v3/6hNfJjo6hTvPTCSXxs8s57MfDDQgviXag2IQzMswnOvnDlSjnNz4eA8U6S2sqIb7LUtrmim898nFhUdRhE3LsNk0xSp7shyN6y2Sz9u/9F46RJlKNLnhiAbn3AtTN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737849; c=relaxed/simple;
	bh=KWBqzMWfVWlDXIgmfZzA0QLJHxdPP3h7icnReoP+ao8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIaW/8TC4TiX99FbOrK8WdEqXcobFhN8bAw0BeF2ZcNkJzx5AESELOXxnv2X55iWNng6X399zuMEoYEIZAv3lgU0sapVZ4Nq+fLhtFATMwPf/nyhrn/z+ycO2v0ODaG/2LfVgXR5NMbGXaGDsJBeC7cKYpOrfu1c0lZydmSgKNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KrppY5x7; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VLojCl055159;
	Wed, 31 Jan 2024 15:50:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706737845;
	bh=2Kdumh5zzuoRvyue9vxpLhNT0R8HOCdPWNPZeVm94jM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KrppY5x7GyfHvVviZgq/WvcbpJDBh52852kjYBaTUyCTRPi8fi9rvFm0Y9Tvylm18
	 YZh/cTwP3KoKW3Anv12RtHZY9FVTphrTpyP/SjRULQv7wMvrTnrGcYHYZpWusfAD2m
	 hLbv7KA07+oE2tG26Qhkbfzuy5zphxfpUXok5cIg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VLojR7016187
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 15:50:45 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 15:50:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 15:50:44 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VLoig5062479;
	Wed, 31 Jan 2024 15:50:44 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Randolph Sapp <rs@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
Subject: [PATCH v1 3/5] mmc: sdhci_am654: Add missing OTAP/ITAP enable
Date: Wed, 31 Jan 2024 15:50:42 -0600
Message-ID: <20240131215044.3163469-4-jm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131215044.3163469-1-jm@ti.com>
References: <20240131215044.3163469-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Currently the OTAP/ITAP delay enable functionality is missing in
the am654_set_clock function which is used for MMC0 on AM62p
and AM64x devices. The OTAP delay is not enabled when timing <
SDR25 bus speed mode. The ITAP delay is not enabled for all bus
speed modes.

Add this OTAP/ITAP delay functionality according to the datasheet
[1] OTAPDLYENA and ITAPDLYENA for MMC0.

[1] https://www.ti.com/lit/ds/symlink/am62p.pdf

Fixes: 8ee5fc0e0b3b ("mmc: sdhci_am654: Update OTAPDLY writes")
Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 48 +++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index ff18a274b6f2..5ac82bc70706 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -143,6 +143,7 @@ struct sdhci_am654_data {
 	struct regmap *base;
 	int otap_del_sel[ARRAY_SIZE(td)];
 	int itap_del_sel[ARRAY_SIZE(td)];
+	u8 itap_del_ena[ARRAY_SIZE(td)];
 	int clkbuf_sel;
 	int trm_icp;
 	int drv_strength;
@@ -171,11 +172,13 @@ struct sdhci_am654_driver_data {
 };
 
 static void sdhci_am654_write_itapdly(struct sdhci_am654_data *sdhci_am654,
-				      u32 itapdly)
+				      u32 itapdly, u32 enable)
 {
 	/* Set ITAPCHGWIN before writing to ITAPDLY */
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
 			   0x1 << ITAPCHGWIN_SHIFT);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYENA_MASK,
+			   enable << ITAPDLYENA_SHIFT);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYSEL_MASK,
 			   itapdly << ITAPDLYSEL_SHIFT);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
@@ -249,7 +252,8 @@ static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock,
 		return;
 	}
 
-	sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing]);
+	sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing],
+				  sdhci_am654->itap_del_ena[timing]);
 }
 
 static void sdhci_am654_setup_delay_chain(struct sdhci_am654_data *sdhci_am654,
@@ -263,8 +267,8 @@ static void sdhci_am654_setup_delay_chain(struct sdhci_am654_data *sdhci_am654,
 	mask = SELDLYTXCLK_MASK | SELDLYRXCLK_MASK;
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask, val);
 
-	sdhci_am654_write_itapdly(sdhci_am654,
-				  sdhci_am654->itap_del_sel[timing]);
+	sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing],
+				  sdhci_am654->itap_del_ena[timing]);
 }
 
 static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
@@ -273,20 +277,17 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	u32 otap_del_sel;
-	u32 otap_del_ena;
 	u32 mask, val;
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK, 0);
 
 	sdhci_set_clock(host, clock);
 
-	/* Setup DLL Output TAP delay */
+	/* Setup Output TAP delay */
 	otap_del_sel = sdhci_am654->otap_del_sel[timing];
-	otap_del_ena = (timing > MMC_TIMING_UHS_SDR25) ? 1 : 0;
 
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
-	val = (otap_del_ena << OTAPDLYENA_SHIFT) |
-	      (otap_del_sel << OTAPDLYSEL_SHIFT);
+	val = (0x1 << OTAPDLYENA_SHIFT) | (otap_del_sel << OTAPDLYSEL_SHIFT);
 
 	/* Write to STRBSEL for HS400 speed mode */
 	if (timing == MMC_TIMING_MMC_HS400) {
@@ -319,14 +320,20 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	u32 otap_del_sel;
+	u32 itap_del_ena;
 	u32 mask, val;
 
-	/* Setup DLL Output TAP delay */
+	/* Setup Output TAP delay */
 	otap_del_sel = sdhci_am654->otap_del_sel[timing];
 
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
-	val = (0x1 << OTAPDLYENA_SHIFT) |
-	      (otap_del_sel << OTAPDLYSEL_SHIFT);
+	val = (0x1 << OTAPDLYENA_SHIFT) | (otap_del_sel << OTAPDLYSEL_SHIFT);
+
+	itap_del_ena = sdhci_am654->itap_del_ena[timing];
+
+	mask |= ITAPDLYENA_MASK;
+	val |= (itap_del_ena << ITAPDLYENA_SHIFT);
+
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
@@ -503,12 +510,8 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 
 	memset(fail_window, 0, sizeof(fail_window[0]) * ITAPDLY_LENGTH);
 
-	/* Enable ITAPDLY */
-	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYENA_MASK,
-			   1 << ITAPDLYENA_SHIFT);
-
 	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
-		sdhci_am654_write_itapdly(sdhci_am654, itap);
+		sdhci_am654_write_itapdly(sdhci_am654, itap, 1);
 
 		curr_pass = !mmc_send_tuning(host->mmc, opcode, NULL);
 
@@ -532,7 +535,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
 					  (sdhci_am654->dll_enable ? true : false));
 
-	sdhci_am654_write_itapdly(sdhci_am654, itap);
+	sdhci_am654_write_itapdly(sdhci_am654, itap, 1);
 
 	return 0;
 }
@@ -681,9 +684,12 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
 				host->mmc->caps2 &= ~td[i].capability;
 		}
 
-		if (td[i].itap_binding)
-			device_property_read_u32(dev, td[i].itap_binding,
-						 &sdhci_am654->itap_del_sel[i]);
+		if (td[i].itap_binding) {
+			ret = device_property_read_u32(dev, td[i].itap_binding,
+						       &sdhci_am654->itap_del_sel[i]);
+				if (!ret)
+					sdhci_am654->itap_del_ena[i] = 0x1;
+		}
 	}
 
 	return 0;
-- 
2.34.1


