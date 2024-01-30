Return-Path: <linux-kernel+bounces-44428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3906E8421F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B92296546
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D367664AB;
	Tue, 30 Jan 2024 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yCUrT+NS"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98872657BC;
	Tue, 30 Jan 2024 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706611769; cv=fail; b=JGRqtkdXK0b8xwyrR7S7G7r1vhkH/9v1Yr526Dhc6YsOMKKvK3nJPymGaoFaqsyNKiEuA4B52hnWlrvpq2+5oE/g8snWbJ9NE59Y99zpdzjdnB66YdMS1HYoelVo9ZZHJsb069BXX9r7tfH4XbSyi76+kMTva/3UFcNUIKdMxuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706611769; c=relaxed/simple;
	bh=rfKB6Tjw513uE/Mn59JQN06GgBjAn6OG1rKqvXyxNC8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArPCOLP1BLhf82nX68RQUXDs4ddp2Ug79UZry1D1jqw3WWCyZTx4VfrhHbHIQ4eSG9IOOCNnhmK7ZfrL0t1HeYMG/kYAwS66hyQymgf+ijeIVr14Uc3DlmE1J86WiZALeIDwt8x7oeXRFLI5o5HkzkuqgKpkNjM8Di0Y43RBmJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yCUrT+NS; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eH5OHh7OxbefTIaiW5rILgvADlMF7P19bc3SmsJxoHOlmzIceWGEuj2d4DP71BmTewYNbaC/C43ApLzBhgtJGNUMO2qMHPNqUIvzj6iwUT4CgVbT196YmxCWyLbQJehKHLdvtDuOR5PE6uDA3LTPeB+KCnBss8c3/bISBNTeeo2UlakVy+9JRMdDOoCDQCGCsSVwOuxY+D6QPyChD8Ue37uSzSiO5FeRBiQzxNLS+Kcy3uGOnSB/yihE9J1AdErMq3MKJZ5ZQzBvY3MgOTdJDDCn5cJIxJqDUZuZkpdgK3U8MK9MkStL1soT8+bvhrPiFAHTERVHwzmIJCuN1gjYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3vQd3iu1TOr+f1V8gLySnLPSkuaLzFhNYZYEgmFLGU=;
 b=VtX5/JE1NdBBi4FtGThVm/UJ1AGQDVqVJ6faNQZfrDzsB1wPOo/rCH+HwMuNZnQMzmic6fMkF05YmP6FRY3jcENvs8hQbRtXMtCcglIEKYnFP4Pb8r6OrUNQ27srPuLMBEpmqvnAxcb0avU4Klf1bwPWWImZBUPa8myC8LuOOX0JY1I79z77xYdOS3Q8rHarqywn44NO1Ffyj0a6C+ljnDmLsACh+z1x20yYnTQ7qm3e1txvHe/ebhvGJpLFUhm7nkwlgw6VNxt6A/06j/xxw9R3OQPuRwBZ8fyLYcUJgE6foqFY0IFNbzE9nWcN5wpaP+olrHapKxqKYA1jJALeqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3vQd3iu1TOr+f1V8gLySnLPSkuaLzFhNYZYEgmFLGU=;
 b=yCUrT+NS+DvW8GBmnEKW/oylv48qByoocoWgLJBFpqlzG8FGH5FDxZi4IIgZbMhS5lEZ8bXZcCRbYwV89A+ZBs918hHznoqjOjycxvkD555s/JRtyBPrXX0VucNrLdr0+VK/BuqiTsNni7iDk6FSS0x9oW7chByEn4xc4vVxuWg=
Received: from BYAPR01CA0038.prod.exchangelabs.com (2603:10b6:a03:94::15) by
 SA0PR12MB7462.namprd12.prod.outlook.com (2603:10b6:806:24b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Tue, 30 Jan 2024 10:49:23 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:94:cafe::4b) by BYAPR01CA0038.outlook.office365.com
 (2603:10b6:a03:94::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 10:49:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 30 Jan 2024 10:49:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 04:49:22 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 30 Jan
 2024 04:49:01 -0600
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 30 Jan 2024 04:48:58 -0600
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <vineeth.karumanchi@amd.com>, <git@amd.com>
Subject: [PATCH net-next 3/3] net: macb: Add ARP support to WOL
Date: Tue, 30 Jan 2024 16:18:45 +0530
Message-ID: <20240130104845.3995341-4-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SA0PR12MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 6817d231-7a7d-4eb8-e473-08dc21811e97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6U3eXpwBbQyo6a1eeXWZC9ym/IfTTOaEdb1zWmXmlQHsKYwDJWLxPuxZFxH87syu7RVIsnSjJBdRav9N+xyNUFbi2Vs94fFu/knb1GxAuuPU/C1OPeL/BVO1BC4o6KoIyYF+URJO6FHQZ4QyB1yUOp4mMp8KackEDwLc6pEgHfGyyFqcGpdpa1gnpjnE/j12u8L/VhUIyiLkUG4wD9JETfkq9gso/ZOcWErbRB6z8wEGictc73a1evjtDQn4AmGfUTi1AfuUJ0W0aLJvOVWCL07oZtNCAgtJuu7PO6bIrWBP+TGpPha8pFjQGzUzxZ26TV1H5mafHBrK5v0Ez5S/AGRUiq1kAQHypgxahjpXA/kuLrtkPfYvi0hZYLiMi8HFRwdi65DA/3CDP+22ogg+lGANXVR+NBkmQaMG+WOSKCqDKHCLxFo2L3tEjIMMzMpI1wYbeqfHYq8QiWxdFOQ4jXpi2b3Hh0h8rdfNGaBTuZs0pqgqSQcfZ355e4CZfQHg87/iEZV3i0JD+jn4N3RcGcuXVJ3mKrb06pkfMITJzcw28mLiXjy+o/n+Z58zsFLP4rStLHTXbfqcoMtt12ly+3ezwjvpwEAyaWnt3w4DPbV/ijYu3ll/xGN/lztSin9xsyYM289dKuSwa2Ept3/pU+aXk1XCMtZ4/miRhyHdJBlorKGRhjQZ8w5C7NcUgyCVeglPrmnU3TnAa7UkblVKPpZLewiHWyHecq7qDaS4E83grVOZMOxFpp9WZiDC2lyyl7AesB0LXhVKmnnWqVnndh4D1fDDkRJ++0taDIOpR8o=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(8676002)(4326008)(8936002)(7416002)(2906002)(44832011)(5660300002)(86362001)(70586007)(110136005)(316002)(70206006)(54906003)(36756003)(36860700001)(47076005)(82740400003)(81166007)(356005)(6666004)(478600001)(2616005)(83380400001)(1076003)(336012)(426003)(921011)(41300700001)(26005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 10:49:22.6442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6817d231-7a7d-4eb8-e473-08dc21811e97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7462

Add wake-on LAN support using ARP with the provision to select
through ethtool. Advertise wakeup capability in the probe and
get the supported modes from the device tree.

Re-order MACB_WOL_<> macros for ease of extension.
Add ARP support configurable through ethtool, "wolopts" variable in
struct macb contains the current WOL options configured through ethtool.

For WOL via ARP, ensure the IP address is assigned and
report an error otherwise.

Co-developed-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb.h      |  1 +
 drivers/net/ethernet/cadence/macb_main.c | 54 ++++++++++++++++++------
 2 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index f68ff163aa18..db7e95dc56e3 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1306,6 +1306,7 @@ struct macb {
 	unsigned int		jumbo_max_len;
 
 	u32			wol;
+	u32			wolopts;
 
 	/* holds value of rx watermark value for pbuf_rxcutthru register */
 	u32			rx_watermark;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 47cbea58e6c3..cbe1a9de692a 100644
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
+#define MACB_WOL_HAS_ARP_PACKET	(0x1 << 2)
 
 #define HS_SPEED_10000M			4
 #define MACB_SERDES_RATE_10G		1
@@ -3276,19 +3278,21 @@ static void macb_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 {
 	struct macb *bp = netdev_priv(netdev);
 
-	if (bp->wol & MACB_WOL_HAS_MAGIC_PACKET) {
+	if (bp->wol & (MACB_WOL_HAS_MAGIC_PACKET | MACB_WOL_HAS_ARP_PACKET))
 		phylink_ethtool_get_wol(bp->phylink, wol);
+	if (bp->wol & MACB_WOL_HAS_MAGIC_PACKET)
 		wol->supported |= WAKE_MAGIC;
-
-		if (bp->wol & MACB_WOL_ENABLED)
-			wol->wolopts |= WAKE_MAGIC;
-	}
+	if (bp->wol & MACB_WOL_HAS_ARP_PACKET)
+		wol->supported |= WAKE_ARP;
+	/* Pass wolopts to ethtool */
+	wol->wolopts = bp->wolopts;
 }
 
 static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 {
 	struct macb *bp = netdev_priv(netdev);
 	int ret;
+	bp->wolopts = 0;
 
 	/* Pass the order to phylink layer */
 	ret = phylink_ethtool_set_wol(bp->phylink, wol);
@@ -3298,11 +3302,16 @@ static int macb_set_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
 	if (!ret || ret != -EOPNOTSUPP)
 		return ret;
 
-	if (!(bp->wol & MACB_WOL_HAS_MAGIC_PACKET) ||
-	    (wol->wolopts & ~WAKE_MAGIC))
+	if (!(bp->wol & (MACB_WOL_HAS_MAGIC_PACKET | MACB_WOL_HAS_ARP_PACKET)) ||
+	    (wol->wolopts & ~(WAKE_MAGIC | WAKE_ARP)))
 		return -EOPNOTSUPP;
 
 	if (wol->wolopts & WAKE_MAGIC)
+		bp->wolopts |= WAKE_MAGIC;
+	if (wol->wolopts & WAKE_ARP)
+		bp->wolopts |= WAKE_ARP;
+
+	if (bp->wolopts)
 		bp->wol |= MACB_WOL_ENABLED;
 	else
 		bp->wol &= ~MACB_WOL_ENABLED;
@@ -5086,7 +5095,10 @@ static int macb_probe(struct platform_device *pdev)
 	bp->wol = 0;
 	if (of_property_read_bool(np, "magic-packet"))
 		bp->wol |= MACB_WOL_HAS_MAGIC_PACKET;
-	device_set_wakeup_capable(&pdev->dev, bp->wol & MACB_WOL_HAS_MAGIC_PACKET);
+	if (of_property_read_bool(np, "wol-arp-packet"))
+		bp->wol |= MACB_WOL_HAS_ARP_PACKET;
+
+	device_set_wakeup_capable(&pdev->dev, (bp->wol) ? true : false);
 
 	bp->usrio = macb_config->usrio;
 
@@ -5243,6 +5255,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue;
+	struct in_ifaddr *ifa;
 	unsigned long flags;
 	unsigned int q;
 	u32 ctrlmask;
@@ -5255,6 +5268,12 @@ static int __maybe_unused macb_suspend(struct device *dev)
 		return 0;
 
 	if (bp->wol & MACB_WOL_ENABLED) {
+		/* Check for IP address in WOL ARP mode */
+		ifa = rtnl_dereference(bp->dev->ip_ptr->ifa_list);
+		if ((bp->wolopts & WAKE_ARP) && !ifa) {
+			netdev_err(netdev, "IP address not assigned\n");
+			return -EOPNOTSUPP;
+		}
 		spin_lock_irqsave(&bp->lock, flags);
 
 		/* Disable Tx and Rx engines before  disabling the queues,
@@ -5291,6 +5310,17 @@ static int __maybe_unused macb_suspend(struct device *dev)
 			if (bp->caps & MACB_CAPS_ISR_CLEAR_ON_WRITE)
 				queue_writel(queue, ISR, -1);
 		}
+
+		ctrlmask = 0;
+		if (bp->wolopts & WAKE_MAGIC)
+			ctrlmask = MACB_BIT(MAG);
+		if (bp->wolopts & WAKE_ARP) {
+			ctrlmask |= MACB_BIT(ARP);
+			/* write IP address into register */
+			ctrlmask |= cpu_to_be32p(&ifa->ifa_local)
+						& GENMASK(MACB_IP_SIZE - 1, 0);
+		}
+
 		/* Change interrupt handler and
 		 * Enable WoL IRQ on queue 0
 		 */
@@ -5306,7 +5336,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				return err;
 			}
 			queue_writel(bp->queues, IER, GEM_BIT(WOL));
-			gem_writel(bp, WOL, MACB_BIT(MAG));
+			gem_writel(bp, WOL, ctrlmask);
 		} else {
 			err = devm_request_irq(dev, bp->queues[0].irq, macb_wol_interrupt,
 					       IRQF_SHARED, netdev->name, bp->queues);
@@ -5318,7 +5348,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 				return err;
 			}
 			queue_writel(bp->queues, IER, MACB_BIT(WOL));
-			macb_writel(bp, WOL, MACB_BIT(MAG));
+			macb_writel(bp, WOL, ctrlmask);
 		}
 		spin_unlock_irqrestore(&bp->lock, flags);
 
-- 
2.34.1


