Return-Path: <linux-kernel+bounces-45525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD5A843209
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D141F1F26668
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B78C522A;
	Wed, 31 Jan 2024 00:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mNAgkY2s"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CE41368;
	Wed, 31 Jan 2024 00:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661444; cv=none; b=o842fCKefa0RlYGqthzDqOR8aXNicUTEIR3MkE9EOSqGNFBEC1DeD2+GZjHtOJ5Uk+y8r6nsSP+lGjxUVsBkyi1NJGLCyuCazTKu9xba1WHI8e9qTrqHAeOiylFePZNPivhSwYxKi+9yBj3+IQRe69xJWLSFqeAmYWrqpr3jNn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661444; c=relaxed/simple;
	bh=N/wvgqoLvx08bPoO9QmgamH9P2amkLRca7A2GlFK1g4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhX5XFcJA32/urd8sPIvHop+OuEZVcs664qys79Dhpznbv9XR0Oy8COBvuI2KfEBsaedoUNVpMHPyOuP0dWShwm/dFH8PcPbCN+wdHOo4cRce/Ris+yNO6wMamJYy7MmZelEZne5/8bSRBJHFaupemVQKXEmQoFDUjCrZ0o/B1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mNAgkY2s; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V0bFux121327;
	Tue, 30 Jan 2024 18:37:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706661435;
	bh=dB3vWg8oNKa63KPtTWaKYFvtzzmYzuSTHHI9s9R+/6E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=mNAgkY2sOL+C9Mc8OMMV6BY57CYy8knr+5MscEpRcfS1eAF74FbM4C0kvHB73+Jyc
	 nednmbvGt3CvFkhVxJJLmtmmqpISf+wTUjtSmzQa+zzr3OvAS5hT+DXVzdF+lTqCGS
	 bpn9HYMFR5OfJZAqm99qlj0/E+sVZHEfeGgX9n0M=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V0bFuk007810
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jan 2024 18:37:15 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 18:37:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 18:37:14 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V0bEw9026520;
	Tue, 30 Jan 2024 18:37:15 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
        Udit Kumar
	<u-kumar1@ti.com>, Roger Quadros <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, Randolph Sapp <rs@ti.com>
Subject: [RFC PATCH 02/13] drivers: mmc: host: sdhci_am654: Write ITAPDLY for DDR52 timing
Date: Tue, 30 Jan 2024 18:37:03 -0600
Message-ID: <20240131003714.2779593-3-jm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131003714.2779593-1-jm@ti.com>
References: <20240131003714.2779593-1-jm@ti.com>
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

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 59d205511312..0a1ed2ae2eef 100644
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


