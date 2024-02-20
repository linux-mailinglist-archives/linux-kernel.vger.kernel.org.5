Return-Path: <linux-kernel+bounces-72970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D564885BB4A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077AB1C24F11
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD5867E67;
	Tue, 20 Feb 2024 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="G3HImeI5"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2071.outbound.protection.outlook.com [40.107.13.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C63967C7B;
	Tue, 20 Feb 2024 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430441; cv=fail; b=QWb2NglN1e+w4NBLW6RFYX3sWFOIKjIhCai6iig/rqOvmJJeJ6EbLySlL0FgtvS/t5JikMi0fJKsmYGKGKEoi72Eh6khHgOdxty0LDJyAlrtyhtidGG0i8NcPw42OV8yWD9pMeVsgnyQmBiCe1+T3nk0KPHMPXZLMDIgHdzrYxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430441; c=relaxed/simple;
	bh=hBJYtvzCqK4bjtjNskkAyjPrNCbW87eKF+Joa4yX2AA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Lk7dR4FoyfXY6HOmZK3EuHPQtf0CAAlKB4qH7vdm+nBkh7ocriSxw3OzHKWUCsUy9pYZaOY/1T75Hfj9dAaWxTMltzqs95EDJ/tLbPi0OZphkIM7a4j8p+PfXjlzctCKisb3bRht63BE/PMSxvTAGnKSbEt/krX0XVN8fxqBZu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=G3HImeI5; arc=fail smtp.client-ip=40.107.13.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOfnnk0Rn3Lr4+DmRVuZOuq0GyL59GF4xxwv6t0q91dyEKLNytruOaCK8UWaiSVSkzjJ//tbY0E7MGkKnXeRryD88vBvr8mOADLIFPi7Y1VtbCcS6V3IgogHDO/5Owqu7EMmvmuydPtMDFafCnEMW38zL2DV3MULh0f0nIgKoV7nvjUdKdIu1NFziLJrSi9RYxfGpx0WkxtmrQ2dw0ISzkht4Ea3mU1CAxtfznvL4UZEkV7I184AZk66o8F5qgG7yifA1GT3rFYU+uTe2Oo/ZNllO9CASOT+EghE6fvyK8LA+4JjAIGmJqrg31bT2sCy5jJDWgqOYRFrCsYBjnS0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzzdcudvdkHNgi4N8pigKYmK//NqwWyKzJKnYOQOFw0=;
 b=SVn1AlX3aaKT2+ofGlnsYNs8ZqHgpTQWrdhuUhNc7N6FWRa2aq9P143jBTB34LbZ1Z0PO+YvqRwCDvgrcWxDlg1mI8OMMLiti7einQpHOahq0C6vSN1FMXbsCVMBh10ow4eNDtShAVwXTh5Y1mdGw2Z7GoSlHO19Mt1BeWjvMZSy9QS4MT0FNvm3TXtnPwR7q1i+D13zL/TyVRZrxnp75Lh3PJTjtWuO8W4INaNcCUN/PxhbYmp4NkWleDGtwwFTn3qn64z92Dk0TpJF2fJbhND9fkXxhE8g0RUkGuEWPgnVHJVNPH7CRw1rCJh58BaRt2I/8fywPQrYJo2kO+/Cbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=davemloft.net smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzzdcudvdkHNgi4N8pigKYmK//NqwWyKzJKnYOQOFw0=;
 b=G3HImeI5iuJLz5Bi/rz2WbCv4/5s/2m9zRHR1v03wX5gCMrvsXKGLjujdwRsjXsuepzHQU9yj/8Hcb06iMC0Y+8JHGreNSgykQ9hrSKR+3FGchtROyaQpIgVN+Ypuw7/BRpkjD9bYnikJCLbGRu5jmhY05woT1Ra+OCqa4xno1I=
Received: from AS9PR06CA0282.eurprd06.prod.outlook.com (2603:10a6:20b:45a::26)
 by PAXPR02MB7213.eurprd02.prod.outlook.com (2603:10a6:102:1bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 12:00:34 +0000
Received: from AM3PEPF0000A78F.eurprd04.prod.outlook.com
 (2603:10a6:20b:45a:cafe::b7) by AS9PR06CA0282.outlook.office365.com
 (2603:10a6:20b:45a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38 via Frontend
 Transport; Tue, 20 Feb 2024 12:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A78F.mail.protection.outlook.com (10.167.16.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 20 Feb 2024 12:00:33 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Feb
 2024 13:00:33 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 20 Feb
 2024 13:00:33 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 20 Feb 2024 13:00:33 +0100
Received: from pc55637-2337.se.axis.com (pc55637-2337.se.axis.com [10.88.4.11])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 2265314AC1;
	Tue, 20 Feb 2024 13:00:33 +0100 (CET)
Received: by pc55637-2337.se.axis.com (Postfix, from userid 363)
	id 1E5C8236949A; Tue, 20 Feb 2024 13:00:33 +0100 (CET)
From: Jesper Nilsson <jesper.nilsson@axis.com>
Date: Tue, 20 Feb 2024 13:00:22 +0100
Subject: [PATCH v2] net: stmmac: mmc_core: Drop interrupt registers from
 stats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240220-stmmac_stats-v2-1-0a78863bec70@axis.com>
X-B4-Tracking: v=1; b=H4sIAFWU1GUC/3XMQQrCMBCF4auUWRvJpGkUV95DioRmYmeRVjKhV
 Ervbuze5f/gfRsIZSaBW7NBpoWF56mGOTUwjH56keJQG4w2Vht0SkpKfnhK8UUUtZ3DYJ0OmqB
 e3pkirwf36GuPLGXOn0Nf8Lf+gRZUqC7addFbh2283v3Kch7mBP2+719HGxKTpwAAAA==
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708430433; l=3666;
 i=jesper.nilsson@axis.com; s=20240216; h=from:subject:message-id;
 bh=hBJYtvzCqK4bjtjNskkAyjPrNCbW87eKF+Joa4yX2AA=;
 b=iiesv1bp0is9dBFTNZZGyIE6OLENAt4pTnbzaEuncAR8hAQMVAGSQMVzg2nva7X55AEu4roew
 30a4X5PIGN6AWUWKhqsCUmCaVzbPLRQq+g6KVPZ+Enp+zaXzbP3GWmz
X-Developer-Key: i=jesper.nilsson@axis.com; a=ed25519;
 pk=RDobTFVrTaE8iMP112Wk0CDiLdcV7I+OkaCECzhr/bI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78F:EE_|PAXPR02MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: ec25a5f5-4f43-4896-931c-08dc320b8afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rdpyOHJUWVgtuYB273Zk0GCVxknZziDIaIbU/q1sHQwVZ3JWm9FkDW3HS0bkFhBWPsG9qO2uZFgQTfHC8YHjJmTJsavrwCZZcCIKtiuOyzy2/qBAVUJ8UCKUM9/kaoHzmba3G9V7RvJv0WwOwB2XzOG+PfhCLPo6d6hH+NK1+K6vRaf2I6W/WnLP1TjDcOIyLIERb9IgeBSVbKD3dODICYzlH2kNiCfQ0bWTOqpkLLtK9OX2O7qPbjhNWaCyHfKjXQGwE59OWBJ6e/QzV+kdYm7JRL2fwFunv5IPfu7fPfoUdTpjm6K4+lwQaa20mCTE5zSCSCEd5CfYUQGXy1C1w/5kMijkCHUX/B7HiB3HUoScQY0Fh2oE11HBTtu5pqeH7eQiqrCAm/NfuyqehZMjhM+fF4IB3Y34H2Shkzag5ZjugVWx56Zsl9WvyRG9Bv7rnfD2jGn7ZyY/q+N0mfMiMifFRLywM4tKgXHmTgyINZs+u/HtdVHwPO9QkHGzlgxkoXl94AawHfpBg/esh54VJi7jIwqVLckC9L7mj/pnUrgM5Y4awze4YScN6aq73MeJmQsXbTVcE39tRipVzDe54TD6t016y4bbyvjxiNGyAkOdBVEgjIJwRcGV/3iLhTjKO/ol44L5sI+Ww12dTEFwWw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(40470700004)(46966006);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 12:00:33.7227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec25a5f5-4f43-4896-931c-08dc320b8afb
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7213

The MMC IPC interrupt status and interrupt mask registers are
of little use as Ethernet statistics, but incrementing counters
based on the current interrupt and interrupt mask registers
makes them actively misleading.

For example, if the interrupt mask is set to 0x08420842,
the current code will increment by that amount each iteration,
leading to the following sequence of nonsense:

mmc_rx_ipc_intr_mask: 969816526
mmc_rx_ipc_intr_mask: 1108361744

These registers have been included in the Ethernet statistics
since the first version of MMC back in 2011 (commit 1c901a46d57).
That commit also mentions the MMC interrupts as
"something to add later (if actually useful)".

If the registers are actually useful, they should probably
be part of the Ethernet register dump instead of statistics,
but for now, drop the counters for mmc_rx_ipc_intr and
mmc_rx_ipc_intr_mask completely.

Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
Changes in v2:
- Drop the misleading registers completely
- Link to v1: https://lore.kernel.org/r/20240216-stmmac_stats-v1-1-7065fa4613f8@axis.com
---
 drivers/net/ethernet/stmicro/stmmac/mmc.h            | 3 ---
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c       | 3 ---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 --
 3 files changed, 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc.h b/drivers/net/ethernet/stmicro/stmmac/mmc.h
index a0c05925883e..8cfba817491b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc.h
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc.h
@@ -78,9 +78,6 @@ struct stmmac_counters {
 	unsigned int mmc_rx_fifo_overflow;
 	unsigned int mmc_rx_vlan_frames_gb;
 	unsigned int mmc_rx_watchdog_error;
-	/* IPC */
-	unsigned int mmc_rx_ipc_intr_mask;
-	unsigned int mmc_rx_ipc_intr;
 	/* IPv4 */
 	unsigned int mmc_rx_ipv4_gd;
 	unsigned int mmc_rx_ipv4_hderr;
diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index 6a7c1d325c46..ab3b7770f62d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -279,9 +279,6 @@ static void dwmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
 	mmc->mmc_rx_fifo_overflow += readl(mmcaddr + MMC_RX_FIFO_OVERFLOW);
 	mmc->mmc_rx_vlan_frames_gb += readl(mmcaddr + MMC_RX_VLAN_FRAMES_GB);
 	mmc->mmc_rx_watchdog_error += readl(mmcaddr + MMC_RX_WATCHDOG_ERROR);
-	/* IPC */
-	mmc->mmc_rx_ipc_intr_mask += readl(mmcaddr + MMC_RX_IPC_INTR_MASK);
-	mmc->mmc_rx_ipc_intr += readl(mmcaddr + MMC_RX_IPC_INTR);
 	/* IPv4 */
 	mmc->mmc_rx_ipv4_gd += readl(mmcaddr + MMC_RX_IPV4_GD);
 	mmc->mmc_rx_ipv4_hderr += readl(mmcaddr + MMC_RX_IPV4_HDERR);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index f628411ae4ae..28accdc98282 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -236,8 +236,6 @@ static const struct stmmac_stats stmmac_mmc[] = {
 	STMMAC_MMC_STAT(mmc_rx_fifo_overflow),
 	STMMAC_MMC_STAT(mmc_rx_vlan_frames_gb),
 	STMMAC_MMC_STAT(mmc_rx_watchdog_error),
-	STMMAC_MMC_STAT(mmc_rx_ipc_intr_mask),
-	STMMAC_MMC_STAT(mmc_rx_ipc_intr),
 	STMMAC_MMC_STAT(mmc_rx_ipv4_gd),
 	STMMAC_MMC_STAT(mmc_rx_ipv4_hderr),
 	STMMAC_MMC_STAT(mmc_rx_ipv4_nopay),

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240216-stmmac_stats-e3561d460d0e

Best regards,
-- 

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com


