Return-Path: <linux-kernel+bounces-96404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32593875BAF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0271F222C2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43EF225D6;
	Fri,  8 Mar 2024 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qheYBmI2"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570D221105;
	Fri,  8 Mar 2024 00:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709859472; cv=none; b=E8nDwDifOAhjFRuysYRFB3uEQODW2SOt1r0BTWKXeKzDsWQ7CDks0qbX+PdpsnD0d2ym/r4rKZCo8/fm79DlMQgFkENjA+Ve20D7sNqqT4eFleUgUfY98CV67rBut1zSNoZWYpw7iCCEkBqkBKPTisQOZYhaIVtym+hTYUQR7Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709859472; c=relaxed/simple;
	bh=+BmrqT9EldqGk3E8dJfH5uh+7ClTvR5orE0A+AT/5zA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbI5d8f9fA4Xh6WUSCaa9ekJcO50MhPfVNuVoDLrsRCBsQ4he3zS7NNVpzcI2rThRFlbDaROxE1JrBVDg9MiPr1zSUF4JzTwn1q+ETk8yese8OMZ4zq1wpXRIS3cbF9222lNSwp1VKVBmV2u2BHdRTrAdugyJ2ka3O10hDoqb9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qheYBmI2; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4280vk6O019075;
	Thu, 7 Mar 2024 18:57:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709859466;
	bh=toZ17XNwyZWg/APELTDPzKU8naCcCbgvdpxpOCUO6aA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qheYBmI2K57H/MRv0LMlEhxqWJ1fQ2nusfpXoIMYTwnjM8hZegUbirK49KRZ2EryI
	 RGyOgDcUz4Lmm2472MkLpNKX7IHEisCoKsrRcVVrFhrRJ6BbFvVVctBJgr9HChFBAv
	 4r+Is2Sdj2i315ydkkZDxRsO+wADeLHNJAZYAB6I=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4280vkRx007746
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Mar 2024 18:57:46 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Mar 2024 18:57:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Mar 2024 18:57:46 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4280vkjX055151;
	Thu, 7 Mar 2024 18:57:46 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Andrew Davis <afd@ti.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 6/7] mmc: sdhci_am654: Add ITAPDLYSEL in sdhci_j721e_4bit_set_clock
Date: Thu, 7 Mar 2024 18:57:45 -0600
Message-ID: <20240308005746.1059813-7-jm@ti.com>
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

Add ITAPDLYSEL to sdhci_j721e_4bit_set_clock function.
This allows to set the correct ITAPDLY for timings that
do not carry out tuning.

Fixes: 1accbced1c32 ("mmc: sdhci_am654: Add Support for 4 bit IP on J721E")
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changelog:
v2->v3:
- no change
---
 drivers/mmc/host/sdhci_am654.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index d207751a63f0..a4eeaf894806 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -319,6 +319,7 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	unsigned char timing = host->mmc->ios.timing;
 	u32 otap_del_sel;
 	u32 itap_del_ena;
+	u32 itap_del_sel;
 	u32 mask, val;
 
 	/* Setup Output TAP delay */
@@ -328,13 +329,18 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	val = (0x1 << OTAPDLYENA_SHIFT) |
 	      (otap_del_sel << OTAPDLYSEL_SHIFT);
 
+	/* Setup Input TAP delay */
 	itap_del_ena = sdhci_am654->itap_del_ena[timing];
+	itap_del_sel = sdhci_am654->itap_del_sel[timing];
 
-	mask |= ITAPDLYENA_MASK;
-	val |= (itap_del_ena << ITAPDLYENA_SHIFT);
+	mask |= ITAPDLYENA_MASK | ITAPDLYSEL_MASK;
+	val |= (itap_del_ena << ITAPDLYENA_SHIFT) |
+	       (itap_del_sel << ITAPDLYSEL_SHIFT);
 
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
+			   1 << ITAPCHGWIN_SHIFT);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
-
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
 			   sdhci_am654->clkbuf_sel);
 
-- 
2.43.2


