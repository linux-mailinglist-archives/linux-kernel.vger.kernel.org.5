Return-Path: <linux-kernel+bounces-76791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E01185FCA4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B83286461
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C089214D45C;
	Thu, 22 Feb 2024 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sUC9aYru"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2078.outbound.protection.outlook.com [40.107.95.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66E7150993;
	Thu, 22 Feb 2024 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616358; cv=fail; b=MEg1s+by47U292Pzd/QPvkanEDz0CkDbjMVZb39o3M5d+mfYEEgGy2y3l2i/0cUlsBlGFdjQfMJn8IGdGkt/kqDZhQK+addIffwLKXpDWGm0gafqAEOz1roPWNOXqWesy3K3kRtXlv95JD4XdqPhEkHjT1ynD/dFge+i8IfhHY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616358; c=relaxed/simple;
	bh=1PKypLK2oER96MwVi6ukeVIyBLYb4YYpkyI91O/2gI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZ+TOdlPs2W9AjBbji+4xyH4CToMhXNGciMsp+BcQDz2vexis+BQw2HbB/RylPhM3w8xVIqB5jSedQx0Gu8tz0NL+0AxYcpQw4EHVnShHZ5fHtL0mRC80fsnSZhwnmrMd/HTlH3OEgYrs5ObnhIrdq2TWSu/CwcjC97QtyKg2R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sUC9aYru; arc=fail smtp.client-ip=40.107.95.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfFlIxyjqGymg1To4zdxOfub+3v3boceeAMcx0eKvtcl0Wg68M8ZHfa7nBPKe38ZO8ULjrDNQGg2J+jpJI13xVSDrVxhqp10b8jgU23P2lLgTFbzgdfLYXGfEfG2izxT4DzGLJsMlsUOvJysEBj89hg0KTc4Yw4agDA44woz8uQnBQ3dVAAyBkjPUa027kZP0E66D1caesfD0zL7NknNouzshsITSNpquLBgWQPsdQV3DpxU2BCj65QjNcqU5e73hai8d1V/43d5tVhZzxEcvqj7cz+QIibACc9rWUE2hDUmtXwJYgkG7re8B2QYt/O/SkSf6/+MrXXDJfPh/Lfcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Jyx6kzP7fUom9fCjOWZFl/O6SQxEPBB9/Nh0WvrjGs=;
 b=csjzH+pNYpVInXB1p4n5cs+ons7WWDb0LHHaMgycIRzO5mFo5TyW2dobxeu91gW7IHyyliugg5sJ7cx7dUCJJHsAiWtlq4FsnPin9HsPAA9fxk1z+jdXbQJvOCr0NCbwvIEwjLGUxQl4IkhzuzUqvHjBhfZzn808I7TH342kVhCTEA/xuckupbXhKxb+BHY2qof+WY8VNZm7tEDzEI4DBvsgVY3AC5UHrkGwDCdiHohsQMBwIO3fWkg4l+sRFxyxnuNlw3FC7EsfKXhKKPQZK+DunposQTiJJOZaJxNJ0axvtsbC56+YIQvBLlJ0W16fX7AUQTMICVgSnHSdkNYa0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Jyx6kzP7fUom9fCjOWZFl/O6SQxEPBB9/Nh0WvrjGs=;
 b=sUC9aYrupW304aMvoz2/tM6mmVmIPQuUEEwKUAKelebyhS1ddkZbI+HdTgxBxvecFPT7m9rgdImTihEUm3o5mhtF+5tDP8gmvwX0pYkNcxAgjxN6OBiZ4tBeB+MsXU8ObH9aHW9I5Pkx3ZUA+OgRU0lsneMtnUWUTk+pLib7TU8=
Received: from BN8PR12CA0025.namprd12.prod.outlook.com (2603:10b6:408:60::38)
 by CY8PR12MB8340.namprd12.prod.outlook.com (2603:10b6:930:7a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 15:39:12 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:60:cafe::4) by BN8PR12CA0025.outlook.office365.com
 (2603:10b6:408:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 15:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 15:39:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 09:39:07 -0600
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 22 Feb 2024 09:39:03 -0600
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v2 2/4] net: macb: Add ARP support to WOL
Date: Thu, 22 Feb 2024 21:08:46 +0530
Message-ID: <20240222153848.2374782-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222153848.2374782-1-vineeth.karumanchi@amd.com>
References: <20240222153848.2374782-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|CY8PR12MB8340:EE_
X-MS-Office365-Filtering-Correlation-Id: 380395c1-66e3-443a-3642-08dc33bc6a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nIrukuAaEzigbLrbDqZPJg/t1E4QDQoD5txaLJCQsYwgb1mfZghbyyeJ0s4pr7kB40jp/eGg1+TQJfkX6FztAhh+yxoTmeqQhzPVQtAiFY9OwWsk9SpJQnObQe0DW1EGMa0aRn6Oqr588O8lmkg9U2Y19nbtVRy4uq2W7vDfMdZG4xURZXkDwNRnWEeGbIzMV/D5/wcwJs4jbly7jrD1j5kkG84EBZ0+KxRYuvBzItoN8azClOCIlMWW/6kED+sZfheyY0EyuFZMUg+in06YOkZHs+nSzYI+JuoHNOdsWPIJ0nVeXRqgCMYCos49/ZmishLKlHgSlfEbWu2mDXwQq0np8PJQQOIV5zv+/pkV64TnktR2HZvVuKIO3fnXCOG1g5bmFU2pXtrwuR1UacQjqWjNj3Tm5RZCcHxiCYU+4Zje5A6jszb2tjNtlpbPmBk75I4fAfumRFKszfe/SZq7LotFL/W4h9BrB7LuCd54G9wCKPlcsAHGIgNYoiFw2HzADhbE2p0XeVL9SRGF4AJoE5fNMhH/37hIqGcTiGJ+mMgpuP/hMCtT0H2HAkuLthlg7cRgbK9QQzDlJVMDo9W65oAlGC5ZMCp5jXQoQAXPUg4e9UoRUw+/IUBfBwdHyp1einNZxz7Ox/yEjtzpHHwoWZ5vfabcTriAMIcyDJyX6pg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 15:39:11.3831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 380395c1-66e3-443a-3642-08dc33bc6a8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8340

-Add wake-on LAN support using ARP with the provision to select
 through ethtool. Advertise wakeup capability in the probe and
 get the supported modes from OS policy (MACB_CAPS_WOL).

-Re-order MACB_WOL_<> macros for ease of extension.
-Add ARP support configurable through ethtool, "wolopts" variable in
 struct macb contains the current WOL options configured through ethtool.

-For WOL via ARP, ensure the IP address is assigned and
 report an error otherwise.

Co-developed-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb.h      |  2 +
 drivers/net/ethernet/cadence/macb_main.c | 52 +++++++++++++++++-------
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 50cd35ef21ad..c9ca61959f3c 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -738,6 +738,7 @@
 #define MACB_CAPS_MIIONRGMII			0x00000200
 #define MACB_CAPS_NEED_TSUCLK			0x00000400
 #define MACB_CAPS_QUEUE_DISABLE			0x00000800
+#define MACB_CAPS_WOL				0x00001000
 #define MACB_CAPS_PCS				0x01000000
 #define MACB_CAPS_HIGH_SPEED			0x02000000
 #define MACB_CAPS_CLK_HW_CHG			0x04000000
@@ -1306,6 +1307,7 @@ struct macb {
 	unsigned int		jumbo_max_len;
 
 	u32			wol;
+	u32			wolopts;
 
 	/* holds value of rx watermark value for pbuf_rxcutthru register */
 	u32			rx_watermark;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f34933ef03b0..62d796ef4035 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -38,6 +38,7 @@
 #include <linux/ptp_classify.h>
 #include <linux/reset.h>
 #include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/inetdevice.h>
 #include "macb.h"
 
 /* This structure is only used for MACB on SiFive FU540 devices */
@@ -84,8 +85,9 @@ struct sifive_fu540_macb_mgmt {
 #define GEM_MTU_MIN_SIZE	ETH_MIN_MTU
 #define MACB_NETIF_LSO		NETIF_F_TSO
 
-#define MACB_WOL_HAS_MAGIC_PACKET	(0x1 << 0)
-#define MACB_WOL_ENABLED		(0x1 << 1)
+#define MACB_WOL_ENABLED		(0x1 << 0)
+#define MACB_WOL_HAS_MAGIC_PACKET	(0x1 << 1)
+#define MACB_WOL_HAS_ARP_PACKET		(0x1 << 2)
 
 #define HS_SPEED_10000M			4
 #define MACB_SERDES_RATE_10G		1
@@ -3278,18 +3280,18 @@ static void macb_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 {
 	struct macb *bp = netdev_priv(netdev);
 
-	if (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) {
+	if (bp->wol & (MACB_WOL_HAS_MAGIC_PACKET | MACB_WOL_HAS_ARP_PACKET))
 		phylink_ethtool_get_wol(bp->phylink, wol);
-		wol->supported |= WAKE_MAGIC;
-
-		if (bp->wol & MACB_WOL_ENABLED)
-			wol->wolopts |= WAKE_MAGIC;
-	}
+	wol->supported |= (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ? WAKE_MAGIC : 0;
+	wol->supported |= (bp->wol & MACB_WOL_HAS_ARP_PACKET) ? WAKE_ARP : 0;
+	/* Pass wolopts to ethtool */
+	wol->wolopts = bp->wolopts;
 }
 
 static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 {
 	struct macb *bp = netdev_priv(netdev);
+	bp->wolopts = 0;
 	int ret;
 
 	/* Pass the order to phylink layer */
@@ -3300,11 +3302,14 @@ static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 	if (!ret || ret != -EOPNOTSUPP)
 		return ret;
 
-	if (!(bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ||
-	    (wol->wolopts & ~WAKE_MAGIC))
+	if (!(bp->wol & (MACB_WOL_HAS_MAGIC_PACKET | MACB_WOL_HAS_ARP_PACKET)) ||
+	    (wol->wolopts & ~(WAKE_MAGIC | WAKE_ARP)))
 		return -EOPNOTSUPP;
 
-	if (wol->wolopts & WAKE_MAGIC)
+	bp->wolopts |= (wol->wolopts & WAKE_MAGIC) ? WAKE_MAGIC : 0;
+	bp->wolopts |= (wol->wolopts & WAKE_ARP) ? WAKE_ARP : 0;
+
+	if (bp->wolopts)
 		bp->wol |= MACB_WOL_ENABLED;
 	else
 		bp->wol &= ~MACB_WOL_ENABLED;
@@ -5087,7 +5092,6 @@ static int macb_probe(struct platform_device *pdev)
 	bp->wol = 0;
 	if (of_property_read_bool(np, "magic-packet"))
 		bp->wol |= MACB_WOL_HAS_MAGIC_PACKET;
-	device_set_wakeup_capable(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
 
 	bp->usrio = macb_config->usrio;
 
@@ -5115,6 +5119,11 @@ static int macb_probe(struct platform_device *pdev)
 	/* setup capabilities */
 	macb_configure_caps(bp, macb_config);
 
+	if (bp->caps & MACB_CAPS_WOL)
+		bp->wol |= (MACB_WOL_HAS_ARP_PACKET | MACB_WOL_HAS_MAGIC_PACKET);
+
+	device_set_wakeup_capable(&pdev->dev, (bp->wol) ? true : false);
+
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	if (GEM_BFEXT(DAW64, gem_readl(bp, DCFG6))) {
 		dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
@@ -5244,6 +5253,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
+	struct in_ifaddr *ifa;
 	unsigned long flags;
 	unsigned int q;
 	int err;
@@ -5256,6 +5266,12 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		return 0;
 
 	if (bp->wol & MACB_WOL_ENABLED) {
+		/* Check for IP address in WOL ARP mode */
+		ifa = rcu_dereference(__in_dev_get_rcu(bp->dev)->ifa_list);
+		if ((bp->wolopts & WAKE_ARP) && !ifa) {
+			netdev_err(netdev, "IP address not assigned\n");
+			return -EOPNOTSUPP;
+		}
 		spin_lock_irqsave(&bp->lock, flags);
 
 		/* Disable Tx and Rx engines before  disabling the queues,
@@ -5289,6 +5305,14 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		macb_writel(bp, TSR, -1);
 		macb_writel(bp, RSR, -1);
 
+		tmp = (bp->wolopts & WAKE_MAGIC) ? MACB_BIT(MAG) : 0;
+		if (bp->wolopts & WAKE_ARP) {
+			tmp |= MACB_BIT(ARP);
+			/* write IP address into register */
+			tmp |= MACB_BFEXT(IP,
+					 (__force u32)(cpu_to_be32p((uint32_t *)&ifa->ifa_local)));
+		}
+
 		/* Change interrupt handler and
 		 * Enable WoL IRQ on queue 0
 		 */
@@ -5304,7 +5328,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				return err;
 			}
 			queue_writel(bp->queues, IER, GEM_BIT(WOL));
-			gem_writel(bp, WOL, MACB_BIT(MAG));
+			gem_writel(bp, WOL, tmp);
 		} else {
 			err = devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
 					       IRQF_SHARED, netdev->name, bp->queues);
@@ -5316,7 +5340,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				return err;
 			}
 			queue_writel(bp->queues, IER, MACB_BIT(WOL));
-			macb_writel(bp, WOL, MACB_BIT(MAG));
+			macb_writel(bp, WOL, tmp);
 		}
 		spin_unlock_irqrestore(&bp->lock, flags);
 
-- 
2.34.1


