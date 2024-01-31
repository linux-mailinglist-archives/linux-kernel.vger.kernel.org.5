Return-Path: <linux-kernel+bounces-47204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E065844A83
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912201C23FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80603C491;
	Wed, 31 Jan 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bmVWgSK2"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193053B7A8;
	Wed, 31 Jan 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737849; cv=none; b=uB0lyfN02sTbV3anISUP2WmXbj3SBeIkfop1zSc8cQSL2gfDCTavSWRv5NtHe0iXDREg/UIMI1qAIImGvm+LTlJO6tWPS9hILZ38Q17hSXdpdKEiCFpOc/RDwODLpiWN/c4T7fzQN40JWMdGMuLLXNmu/adFA8B9zt4VYU8yBR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737849; c=relaxed/simple;
	bh=KH1Q3sZDfUSqSnHPIKLRCZuS2f4RYbCeppXn3QE9KQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvoNSP5ZVmt2r3GAzSvMfVEBmmmp/AiKpXiPL3bXFhYu7kuDxPbC7eS3GbSGg1vy20FvuWxxUPVuu8NdQ/Mx98gYZNeYicjt01bUpnh5CLbJyeYMXuWnHA3fqi0hdsW8lBXIYn7xyw1iMN89xTZUwryPIwZPZjIclk+bC7UdTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bmVWgSK2; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VLojVE123744;
	Wed, 31 Jan 2024 15:50:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706737845;
	bh=KUcW/gV7wwyp0XmBeLHfk9lN7hNL8w8B+SWfvHY8hL4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bmVWgSK2uY9ZdLY6GtBflIufyf6z81KMJtEvdVOFG8TUvQIaOsBB4fIbdDFnXcoaX
	 wkEzXCwmoODoxSpNoWYdxBlcp86F97dqFF8sEHMIqnbXgfNqJt7dsbez1nae9m2QSX
	 AxPHqUAPatA494WNBDJ49oE0Po9eMh/AwBlG+sb0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VLojsF006415
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 15:50:45 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 15:50:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 15:50:44 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VLoig4062479;
	Wed, 31 Jan 2024 15:50:44 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Randolph Sapp <rs@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
Subject: [PATCH v1 2/5] mmc: sdhci_am654: Write ITAPDLY for DDR52 timing
Date: Wed, 31 Jan 2024 15:50:41 -0600
Message-ID: <20240131215044.3163469-3-jm@ti.com>
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

For DDR52 timing, DLL is enabled but tuning is not carried
out, therefore the ITAPDLY value in PHY CTRL 4 register is
not correct. Fix this by writing ITAPDLY after enabling DLL.

Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some speed modes")
Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index a3798c9912f6..ff18a274b6f2 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -170,7 +170,19 @@ struct sdhci_am654_driver_data {
 #define DLL_CALIB	(1 << 4)
 };
 
-static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock)
+static void sdhci_am654_write_itapdly(struct sdhci_am654_data *sdhci_am654,
+				      u32 itapdly)
+{
+	/* Set ITAPCHGWIN before writing to ITAPDLY */
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
+			   0x1 << ITAPCHGWIN_SHIFT);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYSEL_MASK,
+			   itapdly << ITAPDLYSEL_SHIFT);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
+}
+
+static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock,
+				  unsigned char timing)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
@@ -236,17 +248,8 @@ static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock)
 		dev_err(mmc_dev(host->mmc), "DLL failed to relock\n");
 		return;
 	}
-}
 
-static void sdhci_am654_write_itapdly(struct sdhci_am654_data *sdhci_am654,
-				      u32 itapdly)
-{
-	/* Set ITAPCHGWIN before writing to ITAPDLY */
-	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
-			   1 << ITAPCHGWIN_SHIFT);
-	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYSEL_MASK,
-			   itapdly << ITAPDLYSEL_SHIFT);
-	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
+	sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing]);
 }
 
 static void sdhci_am654_setup_delay_chain(struct sdhci_am654_data *sdhci_am654,
@@ -298,7 +301,7 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 
 	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
-		sdhci_am654_setup_dll(host, clock);
+		sdhci_am654_setup_dll(host, clock, timing);
 		sdhci_am654->dll_enable = true;
 	} else {
 		sdhci_am654_setup_delay_chain(sdhci_am654, timing);
-- 
2.34.1


