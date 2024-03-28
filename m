Return-Path: <linux-kernel+bounces-122812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C797088FDB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488061F277C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4846D7E0EA;
	Thu, 28 Mar 2024 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o6QBuku6"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7975D2C6AE;
	Thu, 28 Mar 2024 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624064; cv=fail; b=qnCWyaswWTQVL+kAPf5uhPZiQPPVN0q1DR3Zoy5Z29siS2xd038gMevvvJPXWQ0nFVA8WNaUQoKRO6iE1LcKiUaTJzGqC8WvXlLD1kk6mc1M+erWUm/qQtGC/NH/LFBTOrVexCjEg4OKHktjg30jURJqm4PNX7vUOA8Yetac+k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624064; c=relaxed/simple;
	bh=N0L0DeYUU63CqTU4tjvj4Es2vglSMWPzx3eXEbXcS64=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DvCP+AVRA4kthmEQ+r78anWGLuUFuqjCVnChfJ4aWTlPfG79Nu8tLk99Wdt2qRwAjBtSgpeSPxv4cC3KrdNRWTNg2cSHadurkedr6mvcp6vOge60fEVueki/H9KTtMwkBsQ7NpT6JpOuBC3BtIzMKn/So/wbTZT2Q0h9nbAKHgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o6QBuku6; arc=fail smtp.client-ip=40.107.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoX3hiQFwxPX87Q4KADtJFm1Q1QnLulNbQED/cVp0oIJm3eP1n5AohsOthT+STBUvAkORMjwPLmPoWw7JU3T70spn7GfzjqWt6lrpUGiIbzJzI62JgL3DpWN8wX5oZwY8IeiSheFJEVn+akEu+7EiwEkepMwXSrU+eLIWGWb3dJOzY5GUqdG3x3UeFznTAI7I+V/TeQIxpFJon66upEzdm2PK9gTX87EWm3urOOnaLJ709/v25WgpklLfgFGy6sEHBJKrvRp3V+hB6rFfI55WOcPsVCmQrKnjX99XEtcDEaeyoJswHye+z8AEZwyRmUUBKA7kjDQR4z6ttMcVKqywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Et8G2vu59srS7J8zOOGchcYM2OjutpVKweGXSqJNEc=;
 b=nKl/+e1JT9Ls65bILBaz6DkhYiQXs+Repca7vbMNDPh1ETYNxsJ5ewvH7aDfjfHBOIF5Jw7kRJ+qiDexAycDSK1h7WwSLbbpjtlTMyZqAqMf/ZWggowNz4TrMWwJnlWg6paQeh0k+fHLkxOGjo6JYZ5Kc/FLX+BUCp1uIsBAqmBMfFmGc2EwQ2eoZY5h8+jQbGazgdQwMSkYlA8u8tc0d6B8mym9USTOcLoxJ7H2hGH7scKXJWuGa99JPAIYqEUsF5QQATqUl004Y5+8nob183YGv21Z4sJ3UBXfJUYuioShwcfTANorHWe7qZvxr9phs4Cf7dny3fw14rek17F/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Et8G2vu59srS7J8zOOGchcYM2OjutpVKweGXSqJNEc=;
 b=o6QBuku6ORf1WdZSuOJ5zwAbQmrOGYUZ9Qi3Ts4VSsSJ0IboMhu9JI41MZaA7ASQsMtzcoNsk7qfVJkjekHn273lVp/EJIPzYEyTnefsJ5t2+F9d0WiCrhcpgKtLBWruEY5XSZ3RWnR0nq1C4+PVWasMMsRo3t4M9A2P5IKOsw8=
Received: from SJ0PR13CA0240.namprd13.prod.outlook.com (2603:10b6:a03:2c1::35)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Thu, 28 Mar
 2024 11:07:37 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::ae) by SJ0PR13CA0240.outlook.office365.com
 (2603:10b6:a03:2c1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Thu, 28 Mar 2024 11:07:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 11:07:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 06:07:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 06:07:33 -0500
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 06:07:30 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <radhey.shyam.pandey@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.simek@amd.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <git@amd.com>, <harini.katakam@amd.com>,
	<suraj.gupta2@amd.com>
Subject: [PATCH net-next v2] net: axienet: Fix kernel doc warnings
Date: Thu, 28 Mar 2024 16:37:13 +0530
Message-ID: <20240328110713.12885-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 6618f4e1-250d-404b-0f0f-08dc4f1746c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8p1BdVnx2Snp2TlKG+PCyN2OY0yN8oHI1gOcDfvWaGvgykQrKnl85f+OEVMt+OSqRRXfnDeF4XSM8+jFKGjslmIJSGbIG/CVtYH1xTWFTusFsCLaLYgrrfWWB3a3ygER11aXxv3Ncut7vEeE7tBSz76wNgTpwCtckJ4iREBxIIWFttfHKfz+G0REWxAo0Q9LWydxYWGYiXdxBse+JCOsogx+u4b/q6+FeZ2/KF3J4KpwkAGZnzvdbgqhtXZ59qP7we8H4ArvMQmtnU5wzksYUYu6aXxF+dtBMS1LKC91Gdd2Y0T8R2Qpj+H8A6uOhxWfIuj2aJITziF9m8JQh9Wtj8X03ksJz/dAfTQEllbrMpoJnD+F9vn+mpGchlvdqPLpI/lChpY1PT/WrPaGjsRnP+VH2szjnSw9+ez1DIBMbHwGz+rIjvNwtt1Za7sc+mXLr090up/xQxQF7eVwShrk7/FJOpOQxMhu5XydjSKKZAnDsjK8U+mIpZMLTs2X0D2+R+pX5IrS49rvrwYedKMZRvjYpRrJp6R9vU+MagoHZOEiiDxUHxGGy7tZTnPvmoRML0dWeBPli2e8ZuNoXM1f5piq99FFWatYD/icPPormD0Wu0eUwhEkwN2WAcOUPzdqnFi0tKAJY71LlHyAHvC3RB7uNKE/lvKmtgi0izdr8bg/uVJYK3Kgbp245Z1eDVwdzwOmbJ9w8jJQn1oVNigPUJW8z5IKEcDZCsmELcJB0OOL/DkmZyApziXerDmcs1dZ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 11:07:36.7923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6618f4e1-250d-404b-0f0f-08dc4f1746c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158

Add description of mdio enable, mdio disable and mdio wait functions.
Add description of skb pointer in axidma_bd data structure.
Remove 'phy_node' description in axienet local data structure since
it is not a valid struct member.
Correct description of struct axienet_option.

Fix below kernel-doc warnings in drivers/net/ethernet/xilinx/:
1) xilinx_axienet_mdio.c:1: warning: no structured comments found
2) xilinx_axienet.h:379: warning: Function parameter or struct member
'skb' not described in 'axidma_bd'
3) xilinx_axienet.h:538: warning: Excess struct member 'phy_node'
description in 'axienet_local'
4) xilinx_axienet.h:1002: warning: expecting prototype for struct
axiethernet_option. Prototype was for struct axienet_option instead

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes in V2:                                                             
Correct alignment of skb struct description in struct axidma_bd.

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  4 ++--
 .../net/ethernet/xilinx/xilinx_axienet_mdio.c | 23 ++++++++++++++++---
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 807ead678551..fa5500decc96 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -359,6 +359,7 @@
  * @app2:         MM2S/S2MM User Application Field 2.
  * @app3:         MM2S/S2MM User Application Field 3.
  * @app4:         MM2S/S2MM User Application Field 4.
+ * @skb:          Pointer to SKB transferred using DMA
  */
 struct axidma_bd {
 	u32 next;	/* Physical address of next buffer descriptor */
@@ -399,7 +400,6 @@ struct skbuf_dma_descriptor {
  * struct axienet_local - axienet private per device data
  * @ndev:	Pointer for net_device to which it will be attached.
  * @dev:	Pointer to device structure
- * @phy_node:	Pointer to device node structure
  * @phylink:	Pointer to phylink instance
  * @phylink_config: phylink configuration settings
  * @pcs_phy:	Reference to PCS/PMA PHY if used
@@ -537,7 +537,7 @@ struct axienet_local {
 };
 
 /**
- * struct axiethernet_option - Used to set axi ethernet hardware options
+ * struct axienet_option - Used to set axi ethernet hardware options
  * @opt:	Option to be set.
  * @reg:	Register offset to be written for setting the option
  * @m_or:	Mask to be ORed for setting the option in the register
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
index 2f07fde361aa..9ca2643c921e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
@@ -20,7 +20,14 @@
 #define DEFAULT_MDIO_FREQ	2500000 /* 2.5 MHz */
 #define DEFAULT_HOST_CLOCK	150000000 /* 150 MHz */
 
-/* Wait till MDIO interface is ready to accept a new transaction.*/
+/**
+ * axienet_mdio_wait_until_ready - MDIO wait function
+ * @lp:	Pointer to axienet local data structure.
+ *
+ * Return :	0 on success, Negative value on errors
+ *
+ * Wait till MDIO interface is ready to accept a new transaction.
+ */
 static int axienet_mdio_wait_until_ready(struct axienet_local *lp)
 {
 	u32 val;
@@ -30,14 +37,24 @@ static int axienet_mdio_wait_until_ready(struct axienet_local *lp)
 				  1, 20000);
 }
 
-/* Enable the MDIO MDC. Called prior to a read/write operation */
+/**
+ * axienet_mdio_mdc_enable - MDIO MDC enable function
+ * @lp:	Pointer to axienet local data structure.
+ *
+ * Enable the MDIO MDC. Called prior to a read/write operation
+ */
 static void axienet_mdio_mdc_enable(struct axienet_local *lp)
 {
 	axienet_iow(lp, XAE_MDIO_MC_OFFSET,
 		    ((u32)lp->mii_clk_div | XAE_MDIO_MC_MDIOEN_MASK));
 }
 
-/* Disable the MDIO MDC. Called after a read/write operation*/
+/**
+ * axienet_mdio_mdc_disable - MDIO MDC disable function
+ * @lp:	Pointer to axienet local data structure.
+ *
+ * Disable the MDIO MDC. Called after a read/write operation
+ */
 static void axienet_mdio_mdc_disable(struct axienet_local *lp)
 {
 	u32 mc_reg;
-- 
2.17.1


