Return-Path: <linux-kernel+bounces-17041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B019382477B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBF12861DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E31286BB;
	Thu,  4 Jan 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ReDjxyv1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF2A286B1;
	Thu,  4 Jan 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404AF2II021043;
	Thu, 4 Jan 2024 09:30:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=+WG/kg7A
	naWaSZdtZa4RS3yirZT8LfAXiAzW6sHOpEo=; b=ReDjxyv1s61tzxxsZy3wa1l6
	udlB20uavMm+g7ySvSlX4F8pB7fSQQ1zi+OuYU5AkeVOXuay5pEniZL58y7vq6SR
	ioIQi7mJGvS5CUj0dLXn9Un5nXOtPNGYuWRARZ3o++BUFA1kBGFO91HTwcXOB+xF
	tsrDX4mTYJHVaNCaNHLPwQajAAp5J1iTu+hfom7Th8qq7ACXbG9Su/1bz0SsRX3A
	h4fS0vHxXe8r5fjBw6mOW+YoZZmpB5riU8z0w8xZoToaN3SZlyP+TJRk9A5R46ay
	BuFoIvUYzgNVbHdPpobgy1oNqeIeBXH5i6qwW9aJdjroSfsUc4oW9SZjSj3JRg==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vd39qfped-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 09:30:41 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 4 Jan
 2024 09:30:39 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 4 Jan 2024 09:30:39 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 7C58E3F7089;
	Thu,  4 Jan 2024 09:30:37 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <huziji@marvell.com>, <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v2] mmc: xenon: Add ac5 support via bounce buffer
Date: Thu, 4 Jan 2024 19:30:33 +0200
Message-ID: <20240104173033.2836110-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: n50KVCbTpi0aMhP8-GEBvRh6kMk7havc
X-Proofpoint-GUID: n50KVCbTpi0aMhP8-GEBvRh6kMk7havc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

AC5/X/IM SOCs has a variant of the Xenon eMMC controller,
in which only 31-bit of addressing pass from the controller
on the AXI bus.
Since we cannot guarantee that only buffers from the first 2GB
of memory will reach the driver, the driver is configured for
SDMA mode, without 64-bit mode, overriding the DMA mask to 34-bit
to support the DDR memory mapping, which starts at offset 8GB.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/mmc/host/sdhci-xenon.c | 31 +++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-xenon.h |  3 ++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 25ba7aecc3be..0e52867f6e91 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -18,6 +18,8 @@
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
 
 #include "sdhci-pltfm.h"
 #include "sdhci-xenon.h"
@@ -422,6 +424,7 @@ static int xenon_probe_params(struct platform_device *pdev)
 	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	u32 sdhc_id, nr_sdhc;
 	u32 tuning_count;
+	struct sysinfo si;
 
 	/* Disable HS200 on Armada AP806 */
 	if (priv->hw_version == XENON_AP806)
@@ -450,6 +453,23 @@ static int xenon_probe_params(struct platform_device *pdev)
 	}
 	priv->tuning_count = tuning_count;
 
+	/*
+	 * AC5/X/IM HW has only 31-bits passed in the crossbar switch.
+	 * If we have more than 2GB of memory, this means we might pass
+	 * memory pointers which are above 2GB and which cannot be properly
+	 * represented. In this case, disable ADMA, 64-bit DMA and allow only SDMA.
+	 * This effectively will enable bounce buffer quirk in the
+	 * generic SDHCI driver, which will make sure DMA is only done
+	 * from supported memory regions:
+	 */
+	if (priv->hw_version == XENON_AC5) {
+		si_meminfo(&si);
+		if (si.totalram * si.mem_unit > SZ_2G) {
+			host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
+			host->quirks2 |= SDHCI_QUIRK2_BROKEN_64_BIT_DMA;
+		}
+	}
+
 	return xenon_phy_parse_params(dev, host);
 }
 
@@ -562,6 +582,16 @@ static int xenon_probe(struct platform_device *pdev)
 		goto remove_sdhc;
 
 	pm_runtime_put_autosuspend(&pdev->dev);
+	/*
+	 * If we previously detected AC5 with over 2GB of memory,
+	 * then we disable ADMA and 64-bit DMA.
+	 * This means generic SDHCI driver has set the DMA mask to
+	 * 32-bit. Since DDR starts at 0x2_0000_0000, we must use
+	 * 34-bit DMA mask to access this DDR memory:
+	 */
+	if (priv->hw_version == XENON_AC5 &&
+	    host->quirks2 & SDHCI_QUIRK2_BROKEN_64_BIT_DMA)
+		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(34));
 
 	return 0;
 
@@ -680,6 +710,7 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
 	{ .compatible = "marvell,armada-ap807-sdhci", .data = (void *)XENON_AP807},
 	{ .compatible = "marvell,armada-cp110-sdhci", .data =  (void *)XENON_CP110},
 	{ .compatible = "marvell,armada-3700-sdhci", .data =  (void *)XENON_A3700},
+	{ .compatible = "marvell,ac5-sdhci",	     .data =  (void *)XENON_AC5},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
diff --git a/drivers/mmc/host/sdhci-xenon.h b/drivers/mmc/host/sdhci-xenon.h
index 3e9c6c908a79..0460d97aad26 100644
--- a/drivers/mmc/host/sdhci-xenon.h
+++ b/drivers/mmc/host/sdhci-xenon.h
@@ -57,7 +57,8 @@ enum xenon_variant {
 	XENON_A3700,
 	XENON_AP806,
 	XENON_AP807,
-	XENON_CP110
+	XENON_CP110,
+	XENON_AC5
 };
 
 struct xenon_priv {
-- 
2.25.1


