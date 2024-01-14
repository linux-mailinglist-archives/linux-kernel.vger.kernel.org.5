Return-Path: <linux-kernel+bounces-25522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CC582D1C8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 18:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB82C1F21555
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 17:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC51079B;
	Sun, 14 Jan 2024 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="G8/lsiwd"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6182BF9D0;
	Sun, 14 Jan 2024 17:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40EFrbhI014352;
	Sun, 14 Jan 2024 09:22:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=QQNf0lKyajsE6Luo4IJ5sBtXhUXF5LYFHu/e6XK5dmg=; b=G8/
	lsiwd0GmCFpnkzD6MHMPsw8tQnZDR3glMsGv/bJayu9Nhbp2CW/YfhWJgHcZvfs4
	MRzyzCOjvJwyVFlnyRA/5J4/nLX0h/AYADP0JkWO9umCiI7N/MuWld6BAWx2DOLv
	TE0b1EQbXv+GLpATW9hAQA+Kj5k0gjlYqJXNiCr4JnQ6pvf7ogF3LuSYncg79mhp
	q2idmfAqL+AW3+EANnsEyCJ36RW7aR+V08r0Zwr8Z3vuEx2CzS78H61FtyBbiTPy
	xXcM1Rw9bLKWHXeaks3KDLdq4GdFTlrHeXbi7weyjJkbAnp5iYit2WVdHUdy4ZSZ
	GBVX9Zp/XzkAT+x9sbw==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vktwkafqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 14 Jan 2024 09:22:05 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 14 Jan
 2024 09:22:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 14 Jan 2024 09:22:03 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 7D0025E6873;
	Sun, 14 Jan 2024 09:22:01 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <gregkh@linuxfoundation.org>,
        rowland.harvard.edu@mx0b-0016f401.pphosted.com, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v4 2/2] usb: host: Add ac5 to EHCI Orion
Date: Sun, 14 Jan 2024 19:21:54 +0200
Message-ID: <20240114172154.2622275-3-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240114172154.2622275-1-enachman@marvell.com>
References: <20240114172154.2622275-1-enachman@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6g2FV-TDOt1RYnH2hzDVuTU4ot22dik8
X-Proofpoint-GUID: 6g2FV-TDOt1RYnH2hzDVuTU4ot22dik8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Add support for ac5 to the EHCI Orion platform driver.
The ac5 SOC has DDR starting at offset 0x2_0000_0000,
Hence it requires a larger than 32-bit DMA mask to operate.
Move the dma mask to be pointed by the OF match data, and
use that match data when initializng the DMA mask.

Signed-off-by: Elad Nachman <enachman@marvell.com>
---
 drivers/usb/host/ehci-orion.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 6c47ab0a491d..ad145a54ca74 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -65,6 +65,15 @@ struct orion_ehci_hcd {
 
 static struct hc_driver __read_mostly ehci_orion_hc_driver;
 
+/*
+ * Legacy DMA mask is 32 bit.
+ * AC5 has the DDR starting at 8GB, hence it requires
+ * a larger (34-bit) DMA mask, in order for DMA allocations
+ * to succeed:
+ */
+static const u64 dma_mask_orion =	DMA_BIT_MASK(32);
+static const u64 dma_mask_ac5 =		DMA_BIT_MASK(34);
+
 /*
  * Implement Orion USB controller specification guidelines
  */
@@ -211,6 +220,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 	int irq, err;
 	enum orion_ehci_phy_ver phy_version;
 	struct orion_ehci_hcd *priv;
+	u64 *dma_mask_ptr;
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -228,7 +238,8 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 	 * set. Since shared usb code relies on it, set it here for
 	 * now. Once we have dma capability bindings this can go away.
 	 */
-	err = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	dma_mask_ptr = (u64 *)of_device_get_match_data(&pdev->dev);
+	err = dma_coerce_mask_and_coherent(&pdev->dev, *dma_mask_ptr);
 	if (err)
 		goto err;
 
@@ -332,8 +343,9 @@ static void ehci_orion_drv_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ehci_orion_dt_ids[] = {
-	{ .compatible = "marvell,orion-ehci", },
-	{ .compatible = "marvell,armada-3700-ehci", },
+	{ .compatible = "marvell,orion-ehci", .data = &dma_mask_orion},
+	{ .compatible = "marvell,armada-3700-ehci", .data = &dma_mask_orion},
+	{ .compatible = "marvell,ac5-ehci", .data = &dma_mask_ac5},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ehci_orion_dt_ids);
-- 
2.25.1


