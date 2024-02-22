Return-Path: <linux-kernel+bounces-76789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C24785FC9D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE46D286AA0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD04814F9E7;
	Thu, 22 Feb 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="keKtKI/3"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8FF14E2C1;
	Thu, 22 Feb 2024 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616348; cv=fail; b=uogPUzSJ4iYK8T2Wcn+jzJt7wRtMrwP3Vu0Czr36xYiqG9NCCy7QKZuDxWeYxHtnspKlSSW76STHTDZvmZx+MAfzetZBbDenWPxCLZGWQpT9+X2H9YIa55v/SyWW2Z18c8MKmgcNHAht451gbR/ABAgwxcy8uYW/ZGLRrMaWdE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616348; c=relaxed/simple;
	bh=pVgDWY7Vh3oh0pn7BCdgxn5a1A4hpSLzYjWaE6znHuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXAltRsV3kfVxy3YeGz0+r+oIwmM7rKLekSgnfLFH1XAQeApbW8eyPs5YEMaFClMxby8bhwOcwIraYllcPnu+UpWs+H+QR8jYcfAvIuGKAlnIbJPawp0bwe3dSjON+fH+GeSfs3ehPDXrGcaRBMOawaDIZMDCwPYitMUqD1QRvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=keKtKI/3; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWfnovSjWeoXuP4/jqljzMBmjbCAsTOnRf5wRc+UNqlRKSILMZk1TiUNudyDwsgLCyNVeXRHana8ls1UXHETCp/vuyvFh/WlclTAlJ1d+jzh81ki6vwqVBsNslnnEMi4RVfzcWmxI7BYBlLPPXXx7I6RRkU12fY/+TCreQtTXXiRfivXY3Pm3zWCq0R+hOmC44nglegN6SZIPBEhlgzi3xJF8M6fy/ymdkqQKeKvQhazHKYA3Xb9ZVryWcmBh7SVeKm3JLYt/28nk3yeFiRaqy3lf8aq7dgk/wrNR9i18LIPn6XfSIzNg2izOB4ilYGpSAfvgcHBxRGYwZuyn3heQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsoY10WdZw6+Rl0HTPa8ePLCVGbbC6QEqqiTEj/qlTA=;
 b=SDNTc3c4Fsg2ZONFLn3pzWQzrNQzvdDuLnTK/sCtoxj2knxfak1DSUlng+KX90swRcj343R/3htFTgQypauWCqSbFUJ7ImjT+rB6QppzWhG1MU0FbeZ87hxr/IhHZydwLRNu2MP/AkRXyB7aVbpERLU/CcbQkCRuU9yuklIXMNyzzx04WeX4uk89Se9bjdD3H2RGteNhjXxi2Awl+Z/qOqdotIspm/B4BOggNh7XHnb3OA/0ayxNQ6CcY4X6zrCvKJP93qriFOPsoa085hqVdMkuqTym5Ts+JmLy0HKsUPxD9Igbpftn2co86LghpsnZpej/0TGqZl3LL67iOQiBmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsoY10WdZw6+Rl0HTPa8ePLCVGbbC6QEqqiTEj/qlTA=;
 b=keKtKI/3l4Z3hxgkIjSso7SRClfFgFpYwpvOwARZBxILYGdBMnsr6W4Qisy3NhGWGhad62GLbfPWLLL3wEgfHibNSARMQsz8Oc27DvCHvtkpx4ZGqIEVnGn4m06b6o4vYIF4UJAlx/z6fbVdGOvgNnYklJ3/TfP/LAboGI6elVw=
Received: from BN0PR04CA0117.namprd04.prod.outlook.com (2603:10b6:408:ec::32)
 by CH2PR12MB4970.namprd12.prod.outlook.com (2603:10b6:610:67::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 15:39:03 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:ec:cafe::b9) by BN0PR04CA0117.outlook.office365.com
 (2603:10b6:408:ec::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Thu, 22 Feb 2024 15:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 15:39:03 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 09:39:03 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 07:39:02 -0800
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 22 Feb 2024 09:38:58 -0600
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v2 1/4] net: macb: queue tie-off or disable during WOL suspend
Date: Thu, 22 Feb 2024 21:08:45 +0530
Message-ID: <20240222153848.2374782-2-vineeth.karumanchi@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|CH2PR12MB4970:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c73af5-5f9f-42bb-afa2-08dc33bc65f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6J2Yt+8RWBqy0yz1yVyyc7IOePaE/2cfeeNqOyBmEugQuLSyME83NzpG0kw8Xei5rIF9d/dhWuEkaPFg9du0yB2aOhjPY0qFT8n1ExW/ecc7fchS3E4qQedCGKHMnyCkpkqHaqFXAzW6Ol9M9emLZQgNSm1cM1XAQg90QNBjIWHQE1nT15KRp2zThwJ6ilZgN1ifG0rTpf1GZWChxtqoQs+5/238ptNnMKHRFGqe72Yn5ZZGFtOldN5B1dh+Y23x0oRHvf0cRKk2J2y/nIf1DsSPXbW6VxqUuHM91a6DZc6rhyPWkYNt8FngGa715gZM3ysY6XNSbU6MFwp+7kZ/6D2YanxKa/0UULtUUjpulGp2SXeYzdIlJ0whFzF53t2LxLUhB46kNWAY1eqnhPkiyCt3MO0Y52NrlWKO0zOQDfn0tIHkGx95GlTjPwPWUfN85wHrE3nypMCOL7B5E1MsO3hYxfTvIgDWQBpSdrREJU6wCd57LHCXsHoeDPBXedaNXvCUJ8zgKK2npLs2RNxtcAMZGbYzKqbot5WSZP4p6ndhQ7rG1hQi9Yuufj1k/KAYfRhIehFf7smRXmE7Bc4BMe3xaBzr3ldrI0d+mB9E2b3sM0IF8MDRDPHumd2WrD9d8JYhKCu0NPTkS4T6gxRT1hpTRabEVDigyRtdfMK84EU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 15:39:03.6505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c73af5-5f9f-42bb-afa2-08dc33bc65f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4970

When GEM is used as a wake device, it is not mandatory for the RX DMA
to be active. The RX engine in IP only needs to receive and identify
a wake packet through an interrupt. The wake packet is of no further
significance; hence, it is not required to be copied into memory.
By disabling RX DMA during suspend, we can avoid unnecessary DMA
processing of any incoming traffic.

During suspend, perform either of the below operations:

- tie-off/dummy descriptor: Disable unused queues by connecting
  them to a looped descriptor chain without free slots.

- queue disable: The newer IP version allows disabling individual queues.

Co-developed-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb.h      |  7 +++
 drivers/net/ethernet/cadence/macb_main.c | 60 ++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index aa5700ac9c00..50cd35ef21ad 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -645,6 +645,10 @@
 #define GEM_T2OFST_OFFSET			0 /* offset value */
 #define GEM_T2OFST_SIZE				7
 
+/* Bitfields in queue pointer registers */
+#define MACB_QUEUE_DISABLE_OFFSET		0 /* disable queue */
+#define MACB_QUEUE_DISABLE_SIZE			1
+
 /* Offset for screener type 2 compare values (T2CMPOFST).
  * Note the offset is applied after the specified point,
  * e.g. GEM_T2COMPOFST_ETYPE denotes the EtherType field, so an offset
@@ -733,6 +737,7 @@
 #define MACB_CAPS_NEEDS_RSTONUBR		0x00000100
 #define MACB_CAPS_MIIONRGMII			0x00000200
 #define MACB_CAPS_NEED_TSUCLK			0x00000400
+#define MACB_CAPS_QUEUE_DISABLE			0x00000800
 #define MACB_CAPS_PCS				0x01000000
 #define MACB_CAPS_HIGH_SPEED			0x02000000
 #define MACB_CAPS_CLK_HW_CHG			0x04000000
@@ -1254,6 +1259,8 @@ struct macb {
 	u32	(*macb_reg_readl)(struct macb *bp, int offset);
 	void	(*macb_reg_writel)(struct macb *bp, int offset, u32 value);
 
+	struct macb_dma_desc	*rx_ring_tieoff;
+	dma_addr_t		rx_ring_tieoff_dma;
 	size_t			rx_buffer_size;
 
 	unsigned int		rx_ring_size;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 898debfd4db3..f34933ef03b0 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2477,6 +2477,12 @@ static void macb_free_consistent(struct macb *bp)
 	unsigned int q;
 	int size;
 
+	if (bp->rx_ring_tieoff) {
+		dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
+				  bp->rx_ring_tieoff, bp->rx_ring_tieoff_dma);
+		bp->rx_ring_tieoff = NULL;
+	}
+
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -2568,6 +2574,16 @@ static int macb_alloc_consistent(struct macb *bp)
 	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
 		goto out_err;
 
+	/* Required for tie off descriptor for PM cases */
+	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
+		bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
+							macb_dma_desc_get_size(bp),
+							&bp->rx_ring_tieoff_dma,
+							GFP_KERNEL);
+		if (!bp->rx_ring_tieoff)
+			goto out_err;
+	}
+
 	return 0;
 
 out_err:
@@ -2575,6 +2591,19 @@ static int macb_alloc_consistent(struct macb *bp)
 	return -ENOMEM;
 }
 
+static void macb_init_tieoff(struct macb *bp)
+{
+	struct macb_dma_desc *desc = bp->rx_ring_tieoff;
+
+	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
+		return;
+	/* Setup a wrapping descriptor with no free slots
+	 * (WRAP and USED) to tie off/disable unused RX queues.
+	 */
+	macb_set_addr(bp, desc, MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
+	desc->ctrl = 0;
+}
+
 static void gem_init_rings(struct macb *bp)
 {
 	struct macb_queue *queue;
@@ -2598,6 +2627,7 @@ static void gem_init_rings(struct macb *bp)
 		gem_rx_refill(queue);
 	}
 
+	macb_init_tieoff(bp);
 }
 
 static void macb_init_rings(struct macb *bp)
@@ -2615,6 +2645,8 @@ static void macb_init_rings(struct macb *bp)
 	bp->queues[0].tx_head = 0;
 	bp->queues[0].tx_tail = 0;
 	desc->ctrl |= MACB_BIT(TX_WRAP);
+
+	macb_init_tieoff(bp);
 }
 
 static void macb_reset_hw(struct macb *bp)
@@ -5215,6 +5247,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	unsigned long flags;
 	unsigned int q;
 	int err;
+	u32 tmp;
 
 	if (!device_may_wakeup(&bp->dev->dev))
 		phy_exit(bp->sgmii_phy);
@@ -5224,17 +5257,38 @@ static int __maybe_unused macb_suspend(struct device *dev)
 
 	if (bp->wol & MACB_WOL_ENABLED) {
 		spin_lock_irqsave(&bp->lock, flags);
-		/* Flush all status bits */
-		macb_writel(bp, TSR, -1);
-		macb_writel(bp, RSR, -1);
+
+		/* Disable Tx and Rx engines before  disabling the queues,
+		 * this is mandatory as per the IP spec sheet
+		 */
+		tmp = macb_readl(bp, NCR);
+		macb_writel(bp, NCR, tmp & ~(MACB_BIT(TE) | MACB_BIT(RE)));
 		for (q = 0, queue = bp->queues; q < bp->num_queues;
 		     ++q, ++queue) {
+			/* Disable RX queues */
+			if (bp->caps & MACB_CAPS_QUEUE_DISABLE) {
+				queue_writel(queue, RBQP, MACB_BIT(QUEUE_DISABLE));
+			} else {
+				/* Tie off RX queues */
+				queue_writel(queue, RBQP,
+					     lower_32_bits(bp->rx_ring_tieoff_dma));
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+				queue_writel(queue, RBQPH,
+					     upper_32_bits(bp->rx_ring_tieoff_dma));
+#endif
+			}
 			/* Disable all interrupts */
 			queue_writel(queue, IDR, -1);
 			queue_readl(queue, ISR);
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, -1);
 		}
+		/* Enable Receive engine */
+		macb_writel(bp, NCR, tmp | MACB_BIT(RE));
+		/* Flush all status bits */
+		macb_writel(bp, TSR, -1);
+		macb_writel(bp, RSR, -1);
+
 		/* Change interrupt handler and
 		 * Enable WoL IRQ on queue 0
 		 */
-- 
2.34.1


