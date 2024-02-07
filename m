Return-Path: <linux-kernel+bounces-55785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7D284C1BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC755B256AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2573D17BB3;
	Wed,  7 Feb 2024 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZwLqNosD"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53FF10A0C;
	Wed,  7 Feb 2024 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268530; cv=none; b=V+LBeqrPKTcLS1BpY/bOyDXOBTt71/bG05KvorfI+/wUhlBNEjCnTDXzlRhqgyhvh5Iq6Z9zUPw4ziTssd1jao80LdIyFMza1jPwI5uTXcBYaNrT3xnFh3pwkcbG2W1ZujA1l+GULnW4p1s4/xIe1Dc9aXEpKoR8XBF+tJ2jWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268530; c=relaxed/simple;
	bh=YHiT0xEcQ4f4FJHj3fu8Nz28E+ZFHTQmwcpnWJft308=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DeHWzYxddzn2v+SQiYlgwzoRkBbAR6jIohcOX06SKdfS9aT2XIiHuGIsRg6U+m1Av97fj3X58y6e5WEuIXSM+yhxII1stSgCvvEpAtN/DMoEmrBG0CjzA6ErnQQ6sa9iDQYA7wQxvR+WrqSK34uUQZFruvja09RfHoGs2rTVAXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZwLqNosD; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4171FK7f101973;
	Tue, 6 Feb 2024 19:15:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707268520;
	bh=/H3cqtffogPEOWqNzSU+l7+Onz5xPiqUXn0e1qs9DK0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZwLqNosDMqImhUwbSIEDaPSl+beKTIfBCUWuozuGjWL8D4FcRkoJw4FN3C7zq/a3o
	 bPfmx5GPIDz7gQgTUgk47oWZWsmkLX1PkwW+WM9yJcii8BDS3jKUwnO+KLpkdTONn0
	 SkKAvRb5rrj1e+BMjU1hiW/nfTrULBqPvxcf/+L4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4171FKoQ114481
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 19:15:20 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 19:15:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 19:15:20 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4171FKMv122103;
	Tue, 6 Feb 2024 19:15:20 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 7/7] mmc: sdhci_am654: Fix ITAPDLY for HS400 timing
Date: Tue, 6 Feb 2024 19:15:20 -0600
Message-ID: <20240207011520.3128382-8-jm@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207011520.3128382-1-jm@ti.com>
References: <20240207011520.3128382-1-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

While STRB is currently used for DATA and CRC responses, the CMD
responses from the device to the host still require ITAPDLY for
HS400 timing.

Currently what is stored for HS400 is the ITAPDLY from High Speed
mode which is incorrect. The ITAPDLY for HS400 speed mode should
be the same as ITAPDLY as HS200 timing after tuning is executed.
Add the functionality to save ITAPDLY from HS200 tuning and save
as HS400 ITAPDLY.

Fixes: a161c45f2979 ("mmc: sdhci_am654: Enable DLL only for some speed modes")
Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index f98cce69a286..280fd4c86c95 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -151,6 +151,7 @@ struct sdhci_am654_data {
 	u32 flags;
 	u32 quirks;
 	bool dll_enable;
+	bool hs200_tunning;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 };
@@ -175,6 +176,7 @@ static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	unsigned char timing = host->mmc->ios.timing;
 	int sel50, sel100, freqsel;
 	u32 mask, val;
 	int ret;
@@ -237,6 +239,10 @@ static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock)
 		dev_err(mmc_dev(host->mmc), "DLL failed to relock\n");
 		return;
 	}
+
+	/* HS400 ITAPDLY should be the same as HS200 ITAPDLY*/
+	if (timing == MMC_TIMING_MMC_HS400)
+		sdhci_am654->itap_del_sel[timing] = sdhci_am654->itap_del_sel[timing - 1];
 }
 
 static void sdhci_am654_write_itapdly(struct sdhci_am654_data *sdhci_am654,
@@ -310,6 +316,9 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
 			   sdhci_am654->clkbuf_sel);
+
+	if (timing == MMC_TIMING_MMC_HS200 && sdhci_am654->dll_enable)
+		sdhci_am654->hs200_tunning = true;
 }
 
 static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
@@ -527,6 +536,10 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 
 	sdhci_am654_write_itapdly(sdhci_am654, itap, 1);
 
+	/* Save ITAPDLY for HS200 */
+	if (sdhci_am654->hs200_tunning)
+		sdhci_am654->itap_del_sel[MMC_TIMING_MMC_HS200] = itap;
+
 	return 0;
 }
 
-- 
2.43.0


