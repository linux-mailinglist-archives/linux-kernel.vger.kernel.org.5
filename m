Return-Path: <linux-kernel+bounces-47209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EE0844A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B541F252BD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95303F8F9;
	Wed, 31 Jan 2024 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MvcbEgxq"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45EA3BB30;
	Wed, 31 Jan 2024 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737851; cv=none; b=TNM68Zk81hDQ7JNJ6sAIhIio78Plrd26Z5NyQGxLDjOB73Gg/JgMxXyz0UXY5B8bFKlx+hmzm0wq22QiqHF11naMiCylHZ51L6aTOEbCt6cDl1yNO8aIMFnSalQ4YItluRVEyPQrTv4AKwcJbWjidBtuR71ao1oDLro2KYb4V84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737851; c=relaxed/simple;
	bh=YhIfkP0l4zSyrOwb4XCyyWxUZospW4WQ0l6fLnmFgqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BncOckrnNOaOyxL5QhzKMlzLlfkVFCq/ILgc528jK5bnmk4SGquV+83u3RbjbQGykNGjS6rKFpdyEk7kE4r+k85aYZbt8p0vYWRTPS0ZrDaFtPWq1xjy0oQCHY1fV9gwbed53jJ3s4iify36wPYWs0DtTtXvg4q+1Sx13OiDcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MvcbEgxq; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VLoj4a055164;
	Wed, 31 Jan 2024 15:50:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706737845;
	bh=eHe2J9QDOcqKed5tvQb+FrJvtyyBTVZ3QyddNuzM7mU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MvcbEgxqrbyELU4ayYtfFns/akIjDxPpbFuVv6jSCectb9s7F9i7xtBegJl+Y8AiW
	 sfTl6OZWd9cPx6Q4pmMu/QnBRms/wWC8kViBceQtM3cIhgRp1ncxHMP9JFt4fDJUnZ
	 fizMiFHsmCZ7S+zz1Dy/hrHCVPQbN4VBzg8N/IbU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VLojAV016191
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 15:50:45 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 15:50:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 15:50:44 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VLoig7062479;
	Wed, 31 Jan 2024 15:50:44 -0600
From: Judith Mendez <jm@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
CC: Adrian Hunter <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Randolph Sapp <rs@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
Subject: [PATCH v1 5/5] mmc: sdhci_am654: Fix ITAPDLY for HS400 timing
Date: Wed, 31 Jan 2024 15:50:44 -0600
Message-ID: <20240131215044.3163469-6-jm@ti.com>
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
 drivers/mmc/host/sdhci_am654.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index f5dc981c470d..beb0ca88ba1b 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -151,6 +151,7 @@ struct sdhci_am654_data {
 	u32 flags;
 	u32 quirks;
 	bool dll_enable;
+	bool hs200_tunning;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 };
@@ -252,6 +253,10 @@ static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock,
 		return;
 	}
 
+	/* HS400 ITAPDLY should be the same as HS200 ITAPDLY*/
+	if (timing == MMC_TIMING_MMC_HS400)
+		sdhci_am654->itap_del_sel[timing] = sdhci_am654->itap_del_sel[timing - 1];
+
 	sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing],
 				  sdhci_am654->itap_del_ena[timing]);
 }
@@ -311,6 +316,9 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
 			   sdhci_am654->clkbuf_sel);
+
+	if (timing == MMC_TIMING_MMC_HS200 && sdhci_am654->dll_enable)
+		sdhci_am654->hs200_tunning = true;
 }
 
 static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
@@ -543,6 +551,10 @@ static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 
 	sdhci_am654_write_itapdly(sdhci_am654, itap, 1);
 
+	/* Save ITAPDLY for HS200 */
+	if (sdhci_am654->hs200_tunning)
+		sdhci_am654->itap_del_sel[MMC_TIMING_MMC_HS200] = itap;
+
 	return 0;
 }
 
-- 
2.34.1


