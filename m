Return-Path: <linux-kernel+bounces-44425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 892248421EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A14A8B2971E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E5B6774C;
	Tue, 30 Jan 2024 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3ZtgkQCb"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB35966B22;
	Tue, 30 Jan 2024 10:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611741; cv=fail; b=JEQPRiUavcBok5tgFVFh3q7PZjpgOLUDwhudm008VkP06UpIiGP3nmMHfsnY2zLjqM77x0FcgFpFLZdcyQPZPirl8KbUDG4nAEcC1XZku/WuH33rlmsV17SgkzsaUr88ZpYSI5+ECv/W8nC4N7HwGr3+untzKuXdr+mVd3hFS9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611741; c=relaxed/simple;
	bh=Qequ1IVsS1BQdiniE5mD/vBqDc+onkO31YS0hN4l7lU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlxL2cIsNmU1dDeWT+o/Mn8j4tXXGkD3KI2KjcMsisxhTdU4LIZ4SSIawNgeD+BpkguOgOKEz0IppvkEKhyvW/nOYRhiHswzYHiIaenl0MC6mCaiu+iHYK7zjOQYg5119fBVigp4LIcC+PmkX9fPKiA9Boq68o+U+FsvRmMOciM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3ZtgkQCb; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffolRYVj2IUwCUZ6LU8Fworv+ziE/gfw/F4C6H1aDlf8xYdZ+qqMkKjBG8OOSSkQIEkExdxKWSW2hXl4Pj2h0yGNw12PWmZQ6Nw41zRQfyapwBChVAvgmepwJDa5V+Jhi2sg38jWGGL+uM+kzeN0DxvbP4l/1V3aPIUAwXZqBWqas9tAGIwTVOASRiZ0JTBlEvs/jpGnZTt7M5F12kCIiF2TX1guJONzn0XCqeGL204fxCFY0w7FE2shD/Kunat1y3dDKHVdu/PyFxCBr2k8Y1j19EYMjWrE6gv6G/jCKCJzVDOf623/FQwcD/aUArVIPKoZxzYS744RuM0UD2eh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+UW9/ESkCmmO9wG0qNOFySaz+ckqDKSNqfxL8QHC80=;
 b=BVJfWjfazwbWkvuSe7lTJIJW2hnmdyTm4JieWdfNmq5Fm7n6+ABoxxPsf+l4DlLNkThTdvtysm6jgsHaXM3c/x95MdWSW6YoUl99FSg6cKbhdcm45yY0wK5mba7IRBBJWh8YBmYXSM8NtEtE7AoSGc6k6eaLlN7NANBGEWdYzJy0NfIZgvnLQRFVNcYdfFzfKAc1gBAZrA4v+P/aTkHqumZ6AO7d2oPISoiqdwORurvS7bHdlL+ABI6AuJFlrBgtI8kWsjWZh/NU4Yq7v/FeSQevlD/elWkQasGTb5oKCmDrzGZsjfLXMMuEIELxEMCAjX1m35LgIDOfISVzCs210w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+UW9/ESkCmmO9wG0qNOFySaz+ckqDKSNqfxL8QHC80=;
 b=3ZtgkQCbbj90jFu2NMv+CaQelyEC2u9dKcTYBn2vbhfyF1h8NnjHanYcP1jQ3WXFI0myHdpxyY/ZLxhrpA4Ghrskeci1hzwOfIeO+VqjW24rMDoqakxU1mwJonHV4bizvju9bW0sYslR+ULpyFaRS90sSfTGMA/5JTHm55hR+NY=
Received: from BN0PR04CA0120.namprd04.prod.outlook.com (2603:10b6:408:ec::35)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 10:48:55 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:ec:cafe::5) by BN0PR04CA0120.outlook.office365.com
 (2603:10b6:408:ec::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 10:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7270.0 via Frontend Transport; Tue, 30 Jan 2024 10:48:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 04:48:53 -0600
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 30 Jan 2024 04:48:50 -0600
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <vineeth.karumanchi@amd.com>, <git@amd.com>
Subject: [PATCH net-next 1/3] net: macb: queue tie-off or disable during WOL suspend
Date: Tue, 30 Jan 2024 16:18:43 +0530
Message-ID: <20240130104845.3995341-2-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
References: <20240130104845.3995341-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|MN2PR12MB4287:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e4b64d-d498-46f3-34e8-08dc21810dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rbsOld1MWFe110IdbKf8rPMJ/sj55G2Owateu2jUapwFoYxB0DZYO3RL7OhsVjHW6XOFK7LCQpbMn+OzJHjwSb8Lwmkqwcj4xHR7W4oX2FBFtu+ROfjjzuTBfrXKpara1napQ+Y2uScKlqvbTNbyIU+9W3W4T7csuoyFoTlWt/1g/T3nuy/wQ2pOAXe7/L3LxY7Va2uY1TYgRrI0whYhUC1DOkKbNQEtV8H3B19KRulWczuuDyj6RvzmchydAbjQtS2bkq7lXCqevbjOmaXHBfZ+GS6dy2pIso/NiMkMA5tx31mVe1Ha0X6L6/5f/mBYRzQywvbj//15fJaJooT2wpdN5xwyQQPkHm1VipbBH0LOdEtR9GhUn1vUesPq7NY/pr/J3db7OVCGWq0TeQTK3KVbzR6J2g+L/ZX/XJidp26Lc/Upw8iGcwXH6xLAzFK01W59LJA5GFdtwTbI5yjZdcLO5TKLjh9MjlQAapcHnjfFV7J+uXwB+nukh4Yc6J8kub1uaoy0/4/xFyahEc3ZhtPHHM/3vetNFLyNzZgvc51+NeundskPZJh1qG33Yh/J6dTFKkMkOT6HE8afhAa5Bet/asXWzfCKCZ/2YUGwEfIqJXoQCEUK028zcpXMHfRBZyCvOW8lIxvQoI8yZZRPg22DKS03cz4d1cUugxOxYHBSv8CbUyNP9i8d5rVMcdL0EkTSO8beu062Fu8y+lrsD4iGCpIRMH29pX82++r7V+KFLUY71mRE8GDczAGiWRlD5+vjzNrHNbS+TOMSWzAlvAMACox/R+f4IvBPAaF03xo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(36840700001)(46966006)(40470700004)(426003)(336012)(6666004)(2616005)(83380400001)(478600001)(86362001)(110136005)(70586007)(70206006)(54906003)(316002)(41300700001)(921011)(1076003)(26005)(36860700001)(44832011)(5660300002)(8936002)(4326008)(8676002)(7416002)(356005)(81166007)(40480700001)(40460700003)(47076005)(82740400003)(15650500001)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 10:48:54.8494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e4b64d-d498-46f3-34e8-08dc21810dfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287

When GEM is used as a wake device, it is not mandatory for the RX DMA
to be active. The RX engine in IP only needs to receive and identify
a wake packet through an interrupt. The wake packet is of no further
significance; hence, it is not required to be copied into memory.
By disabling RX DMA during suspend, we can avoid unnecessary DMA
processing of any incoming traffic.

During suspend, perform either of the below operations:

tie-off/dummy descriptor: Disable unused queues by connecting
them to a looped descriptor chain without free slots.

queue disable: The newer IP version allows disabling individual queues.

Co-developed-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb.h      |  7 +++
 drivers/net/ethernet/cadence/macb_main.c | 58 +++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index aa5700ac9c00..f68ff163aa18 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -645,6 +645,9 @@
 #define GEM_T2OFST_OFFSET			0 /* offset value */
 #define GEM_T2OFST_SIZE				7
 
+/* Bitfields in queue pointer registers */
+#define GEM_RBQP_DISABLE    BIT(0)
+
 /* Offset for screener type 2 compare values (T2CMPOFST).
  * Note the offset is applied after the specified point,
  * e.g. GEM_T2COMPOFST_ETYPE denotes the EtherType field, so an offset
@@ -737,6 +740,7 @@
 #define MACB_CAPS_HIGH_SPEED			0x02000000
 #define MACB_CAPS_CLK_HW_CHG			0x04000000
 #define MACB_CAPS_MACB_IS_EMAC			0x08000000
+#define MACB_CAPS_QUEUE_DISABLE			0x00002000
 #define MACB_CAPS_FIFO_MODE			0x10000000
 #define MACB_CAPS_GIGABIT_MODE_AVAILABLE	0x20000000
 #define MACB_CAPS_SG_DISABLED			0x40000000
@@ -1254,6 +1258,7 @@ struct macb {
 	u32	(*macb_reg_readl)(struct macb *bp, int offset);
 	void	(*macb_reg_writel)(struct macb *bp, int offset, u32 value);
 
+	struct macb_dma_desc	*rx_ring_tieoff;
 	size_t			rx_buffer_size;
 
 	unsigned int		rx_ring_size;
@@ -1276,6 +1281,8 @@ struct macb {
 		struct gem_stats	gem;
 	}			hw_stats;
 
+	dma_addr_t		rx_ring_tieoff_dma;
+
 	struct macb_or_gem_ops	macbgem_ops;
 
 	struct mii_bus		*mii_bus;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 898debfd4db3..47cbea58e6c3 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2479,6 +2479,12 @@ static void macb_free_consistent(struct macb *bp)
 
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
 
+	if (bp->rx_ring_tieoff) {
+		dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
+				  bp->rx_ring_tieoff, bp->rx_ring_tieoff_dma);
+		bp->rx_ring_tieoff = NULL;
+	}
+
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		kfree(queue->tx_skb);
 		queue->tx_skb = NULL;
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
@@ -2575,6 +2591,16 @@ static int macb_alloc_consistent(struct macb *bp)
 	return -ENOMEM;
 }
 
+static void macb_init_tieoff(struct macb *bp)
+{
+	struct macb_dma_desc *d = bp->rx_ring_tieoff;
+	/* Setup a wrapping descriptor with no free slots
+	 * (WRAP and USED) to tie off/disable unused RX queues.
+	 */
+	macb_set_addr(bp, d, MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
+	d->ctrl = 0;
+}
+
 static void gem_init_rings(struct macb *bp)
 {
 	struct macb_queue *queue;
@@ -2598,6 +2624,8 @@ static void gem_init_rings(struct macb *bp)
 		gem_rx_refill(queue);
 	}
 
+	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
+		macb_init_tieoff(bp);
 }
 
 static void macb_init_rings(struct macb *bp)
@@ -2615,6 +2643,8 @@ static void macb_init_rings(struct macb *bp)
 	bp->queues[0].tx_head = 0;
 	bp->queues[0].tx_tail = 0;
 	desc->ctrl |= MACB_BIT(TX_WRAP);
+
+	macb_init_tieoff(bp);
 }
 
 static void macb_reset_hw(struct macb *bp)
@@ -4917,7 +4947,8 @@ static const struct macb_config sama7g5_emac_config = {
 
 static const struct macb_config versal_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH | MACB_CAPS_NEED_TSUCLK,
+		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
+		MACB_CAPS_QUEUE_DISABLE | MACB_CAPS_NEED_TSUCLK,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = init_reset_optional,
@@ -5214,6 +5245,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	struct macb_queue *queue;
 	unsigned long flags;
 	unsigned int q;
+	u32 ctrlmask;
 	int err;
 
 	if (!device_may_wakeup(&bp->dev->dev))
@@ -5224,6 +5256,30 @@ static int __maybe_unused macb_suspend(struct device *dev)
 
 	if (bp->wol & MACB_WOL_ENABLED) {
 		spin_lock_irqsave(&bp->lock, flags);
+
+		/* Disable Tx and Rx engines before  disabling the queues,
+		 * this is mandatory as per the IP spec sheet
+		 */
+		ctrlmask = macb_readl(bp, NCR);
+		ctrlmask &= ~(MACB_BIT(TE) | MACB_BIT(RE));
+		macb_writel(bp, NCR, ctrlmask);
+		for (q = 0, queue = bp->queues; q < bp->num_queues;
+		     ++q, ++queue) {
+			/* Disable RX queues */
+			if (bp->caps & MACB_CAPS_QUEUE_DISABLE) {
+				queue_writel(queue, RBQP, GEM_RBQP_DISABLE);
+			} else {
+				/* Tie off RX queues */
+				queue_writel(queue, RBQP,
+					     lower_32_bits(bp->rx_ring_tieoff_dma));
+				queue_writel(queue, RBQPH,
+					     upper_32_bits(bp->rx_ring_tieoff_dma));
+			}
+		}
+		/* Enable Receive engine */
+		ctrlmask = macb_readl(bp, NCR);
+		ctrlmask |= MACB_BIT(RE);
+		macb_writel(bp, NCR, ctrlmask);
 		/* Flush all status bits */
 		macb_writel(bp, TSR, -1);
 		macb_writel(bp, RSR, -1);
-- 
2.34.1


