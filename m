Return-Path: <linux-kernel+bounces-96407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB09E875BB5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685D01F23096
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AF125778;
	Fri,  8 Mar 2024 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sw7IFJtg"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C9B25624;
	Fri,  8 Mar 2024 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709859478; cv=none; b=rjge/f+VRVC3tT6mwgoK8wZjwl1sKKYa8Lh1ParC7DIuxpZj1+jFmb/rBGHTGlrlchjCFtswtULecXohx0iA/9zBu8ZtOzeLrsHY4ThluHhxoG7q17hrGl50ThmaOVPm1oNXYpqGvI3uKWIutB+ZsOapagn12F5J5Pzrp0XVsHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709859478; c=relaxed/simple;
	bh=DYjmT7gS8d821zBNFY1Hh6ovKhBDOzQocHR3wo9nyTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a3ROawGsJALjweuOxb/gb3fiQKaAGpy8MCb1ogV4TzwuDJPdkiQzApNn5AwqoXnU23DWzVWBt/aO9LxQPKDThF68UqL/Iis0FpLi0D2kM62whaCnhFLqGTYolpzdykMWU5DA4Mvr0FE5EWQR6c+IZMDxqE+bteUowcqedSnyR9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sw7IFJtg; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4280vkWG024607;
	Thu, 7 Mar 2024 18:57:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709859466;
	bh=pwgFknBAKkbBCs5xwLvVxmikiiu7CbAZeKOKahCMOGE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=sw7IFJtgMiqi9W1L/xRwLsgusrTZdROlHmOyx/P/9rnvpymePn8ncx60SaDAAKU0k
	 cjyptcx230Dc1F+pg/+/D6mZZte3truHFw+QAcRU1Pwz7T1RNbahnJ+zMtXdPPObVR
	 S/v+Mloxybnb4splDL+H/AUuVM6A/vSAeqBRKq+k=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4280vkPB122490
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Mar 2024 18:57:46 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Mar 2024 18:57:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Mar 2024 18:57:46 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4280vkjU055151;
	Thu, 7 Mar 2024 18:57:46 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/7] mmc: sdhci_am654: Add OTAP/ITAP delay enable
Date: Thu, 7 Mar 2024 18:57:42 -0600
Message-ID: <20240308005746.1059813-4-jm@ti.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240308005746.1059813-1-jm@ti.com>
References: <20240308005746.1059813-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Currently the OTAP/ITAP delay enable functionality is incorrect in
the am654_set_clock function. The OTAP delay is not enabled when
timing < SDR25 bus speed mode. The ITAP delay is not enabled for
timings that do not carry out tuning.

Add this OTAP/ITAP delay functionality according to the datasheet
[1] OTAPDLYENA and ITAPDLYENA for MMC0.

[1] https://www.ti.com/lit/ds/symlink/am62p.pdf

Fixes: 8ee5fc0e0b3b ("mmc: sdhci_am654: Update OTAPDLY writes")
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changelog:
v2->v3:
- Save all ITAPDLYENA changes in itap_del_ena[]
---
 drivers/mmc/host/sdhci_am654.c | 40 ++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 896d4660b535..e7ff6b841c4d 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -143,6 +143,7 @@ struct sdhci_am654_data {
 	struct regmap *base;
 	int otap_del_sel[ARRAY_SIZE(td)];
 	int itap_del_sel[ARRAY_SIZE(td)];
+	u32 itap_del_ena[ARRAY_SIZE(td)];
 	int clkbuf_sel;
 	int trm_icp;
 	int drv_strength;
@@ -239,11 +240,13 @@ static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock)
 }
 
 static void sdhci_am654_write_itapdly(struct sdhci_am654_data *sdhci_am654,
-				      u32 itapdly)
+				      u32 itapdly, u32 enable)
 {
 	/* Set ITAPCHGWIN before writing to ITAPDLY */
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
 			   1 << ITAPCHGWIN_SHIFT);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYENA_MASK,
+			   enable << ITAPDLYENA_SHIFT);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYSEL_MASK,
 			   itapdly << ITAPDLYSEL_SHIFT);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
@@ -260,8 +263,8 @@ static void sdhci_am654_setup_delay_chain(struct sdhci_am654_data *sdhci_am654,
 	mask = SELDLYTXCLK_MASK | SELDLYRXCLK_MASK;
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask, val);
 
-	sdhci_am654_write_itapdly(sdhci_am654,
-				  sdhci_am654->itap_del_sel[timing]);
+	sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing],
+				  sdhci_am654->itap_del_ena[timing]);
 }
 
 static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
@@ -270,7 +273,6 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	u32 otap_del_sel;
-	u32 otap_del_ena;
 	u32 mask, val;
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK, 0);
@@ -279,10 +281,9 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	/* Setup DLL Output TAP delay */
 	otap_del_sel = sdhci_am654->otap_del_sel[timing];
-	otap_del_ena = (timing > MMC_TIMING_UHS_SDR25) ? 1 : 0;
 
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
-	val = (otap_del_ena << OTAPDLYENA_SHIFT) |
+	val = (0x1 << OTAPDLYENA_SHIFT) |
 	      (otap_del_sel << OTAPDLYSEL_SHIFT);
 
 	/* Write to STRBSEL for HS400 speed mode */
@@ -300,7 +301,8 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
 		sdhci_am654_setup_dll(host, clock);
 		sdhci_am654->dll_enable = true;
-		sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing]);
+		sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing],
+					  sdhci_am654->itap_del_ena[timing]);
 	} else {
 		sdhci_am654_setup_delay_chain(sdhci_am654, timing);
 	}
@@ -316,6 +318,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	u32 otap_del_sel;
+	u32 itap_del_ena;
 	u32 mask, val;
 
 	/* Setup DLL Output TAP delay */
@@ -324,6 +327,12 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
 	val = (0x1 << OTAPDLYENA_SHIFT) |
 	      (otap_del_sel << OTAPDLYSEL_SHIFT);
+
+	itap_del_ena = sdhci_am654->itap_del_ena[timing];
+
+	mask |= ITAPDLYENA_MASK;
+	val |= (itap_del_ena << ITAPDLYENA_SHIFT);
+
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
@@ -478,6 +487,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	unsigned char timing = host->mmc->ios.timing;
 	struct window fail_window[ITAPDLY_LENGTH];
 	u8 curr_pass, itap;
 	u8 fail_index = 0;
@@ -486,11 +496,10 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	memset(fail_window, 0, sizeof(fail_window));
 
 	/* Enable ITAPDLY */
-	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYENA_MASK,
-			   1 << ITAPDLYENA_SHIFT);
+	sdhci_am654->itap_del_ena[timing] = 0x1;
 
 	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
-		sdhci_am654_write_itapdly(sdhci_am654, itap);
+		sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
 
 		curr_pass = !mmc_send_tuning(host->mmc, opcode, NULL);
 
@@ -514,7 +523,7 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
 					  sdhci_am654->dll_enable);
 
-	sdhci_am654_write_itapdly(sdhci_am654, itap);
+	sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
 
 	return 0;
 }
@@ -663,9 +672,12 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
 				host->mmc->caps2 &= ~td[i].capability;
 		}
 
-		if (td[i].itap_binding)
-			device_property_read_u32(dev, td[i].itap_binding,
-						 &sdhci_am654->itap_del_sel[i]);
+		if (td[i].itap_binding) {
+			ret = device_property_read_u32(dev, td[i].itap_binding,
+						       &sdhci_am654->itap_del_sel[i]);
+			if (!ret)
+				sdhci_am654->itap_del_ena[i] = 0x1;
+		}
 	}
 
 	return 0;
-- 
2.43.2


