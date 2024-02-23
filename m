Return-Path: <linux-kernel+bounces-79111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A390B861DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6352B24876
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52321146E96;
	Fri, 23 Feb 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="jgALnP+O"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2058.outbound.protection.outlook.com [40.107.20.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13D3D2E6;
	Fri, 23 Feb 2024 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720658; cv=fail; b=OKmRlG93b5eyQ8TfNnZgr/oI7U0G/MET6ao4jKkROAqHDOYieOOR4i5sLthaZkhhHzNzi5ZlTfERO5cR/QY7DKK6OGZB7Jd+G7vcPbbTooG1bxWuNTmoLqCQWmYQjVdLR83tm2xcqd5AnZoQcdmhkgaKecgYa0tRf6uTcbw6etY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720658; c=relaxed/simple;
	bh=aBWSrG5PTHNDYbjhu6vhwaGZci5zg9VS2o4mtJiReCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=tcSBSLczgkFkQpyKvkpWPRAxM8NwEeUOpMbwnYZvnHm2txiBa8hLMhhQ2y7vLimencChTvjWyv/LXWpep3EptgwYGRoQxEJYs+fbCBbOvyAjaMljmqeOtth3F1f8G4mU9RGdfnIuQURkjg1qVIwkg+NAOQomP1OJ2mgaVomjJaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=jgALnP+O; arc=fail smtp.client-ip=40.107.20.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkO2qNFNy/+9xNvcQku4DU1PCG2R48NzWgQunCmQNtu5f2A7F68kjZHmkKMxCe5UqYhUBi8KLnXP/BkROmvPYGWUvzpmIf+si6Jys9b+xoR/YHIIaP0T2z9/u4HLxk1jziHIiS6ynPtvyV9u/ZO+esY/73I5GSgYxYyCCkuQFeYF52fl/jphW6hxyykgH3qrcTDq4uqtDjPOJIAcb4xBEOkmvjioLoMN58pqdeG6rloiaiC+2LeHOg7wCm4MWFX7ZiLsVnByWJ7cTKWoWFy+jZ4ThAirQmIJw9jbUbwFBCoTMcuZed0SyEjaNrocIYKaxK1Cobxknxo/CzRdXUZydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KX2vTzEsii4NViW4fXjvR0QwyG1i8Hhyblb5tLywzXo=;
 b=UffD1wngdNVa0kcd++RDIZ+lAnKW509e4i0lgfcoMY8EU0TeCYS2hVmQu5aGE8e+YKudikKYv6D/iNVZzPNOFZfw+7eUiZ4qEIjMkso0vc9cyyfxTXTPLpF+w9CIEXbpqNGyAy5eH5eu3KQNHLeHNCnpWr88A0fI+zyHSsO73l5j9juv4kMpMQstgkw8L0/VlbTk5At4hVb/37tfez9P5i3cymnb3OCvZmlN9jROaad9LK4VtrhOm1E2pZy9LkKETmEXqEm+5+hUkzV5HCVbQRGfPqQK78CHLnefu3wvj6V24eUTr2GMG82ycG+G8BFRpAIUGbMymWhm0otomDShCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=davemloft.net smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX2vTzEsii4NViW4fXjvR0QwyG1i8Hhyblb5tLywzXo=;
 b=jgALnP+OTN74HjcmT8zsKQYAAkI+bbqBIOVbx+XpCaNFNO+o2cT93VtiWyzYqjeloXGAOx5cWcaXkASt2TfvhABV2NFNqQoaZsNP4wVpenDDb9IDrDJIVSE0w/Jm0HCqhpeOPpGN9FOeFJaEqam3SRm92KOazWkYKiVCArY0lLU=
Received: from AM6P194CA0062.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::39)
 by DB4PR02MB8462.eurprd02.prod.outlook.com (2603:10a6:10:379::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 20:37:33 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:209:84:cafe::45) by AM6P194CA0062.outlook.office365.com
 (2603:10a6:209:84::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Fri, 23 Feb 2024 20:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 20:37:32 +0000
Received: from SE-MAILARCH01W.axis.com (10.20.40.15) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Feb
 2024 21:37:31 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAILARCH01W.axis.com
 (10.20.40.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 23 Feb
 2024 21:37:31 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 23 Feb 2024 21:37:31 +0100
Received: from pc55637-2337.se.axis.com (pc55637-2337.se.axis.com [10.88.4.11])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 075D214EA7;
	Fri, 23 Feb 2024 21:37:31 +0100 (CET)
Received: by pc55637-2337.se.axis.com (Postfix, from userid 363)
	id 3BDE12369AF7; Fri, 23 Feb 2024 21:37:31 +0100 (CET)
From: Jesper Nilsson <jesper.nilsson@axis.com>
Date: Fri, 23 Feb 2024 21:37:01 +0100
Subject: [PATCH net-next v3] net: stmmac: mmc_core: Drop interrupt
 registers from stats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-stmmac_stats-v3-1-5d483c2a071a@axis.com>
X-B4-Tracking: v=1; b=H4sIAOwB2WUC/22NQQqDMBBFryKzbsok0Shd9R6llDSONQu1ZEKwi
 HdvyEpKl4/Pe38DpuCJ4VJtECh59sucQZ8qcKOdXyR8nxkUqhqVNILjNFn34GgjC9KNkX1tsEe
 CrLwDDX4tuRvMFMVMa4R7XkbPcQmf8pNk2f8nkxRStGiawdZG6qG72tXz2S1T6SR1cBX+uCq7a
 NuuM/pJrsWDu+/7Fwfma0ztAAAA
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, Serge Semin <fancer.lancer@gmail.com>, Jesper Nilsson
	<jesper.nilsson@axis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708720651; l=3843;
 i=jesper.nilsson@axis.com; s=20240216; h=from:subject:message-id;
 bh=aBWSrG5PTHNDYbjhu6vhwaGZci5zg9VS2o4mtJiReCk=;
 b=Bh+Rxs7daVj8594P6YNp7rM9ZzWAJfr4ixMYoRXeDBlqt0tXkJQRqncG/xWdtkhMSHYeXGn6X
 FRXqcrU6FBEDU7r5dMVLXT9zZSq20ZVl4QXVqoxwx5jow0QHDz45ZE+
X-Developer-Key: i=jesper.nilsson@axis.com; a=ed25519;
 pk=RDobTFVrTaE8iMP112Wk0CDiLdcV7I+OkaCECzhr/bI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|DB4PR02MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: fafa762f-109b-490f-1e30-08dc34af42a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LY4TkECqaYmAd3wTqlcI1DlcZjkfRZ9SmaPssjt6pB6WSflhBXRq/ShyNkAUETBnMdsd0JEV0a5QZEt+/nIWXyqEQM97mUf1PlEEVLUIxONFMbQxP9mG+dghRcaKqasZ6/xnwI684tK6QAjrJJYPYqO7T90e0DTs2GAppzDCKGCQNfeIPVk7iAqXHNuiR9HP/g5QVlwM//GcG5pQDVr2uj1H+MbzvWK+alR3ZCYzDHxHj1lbwsbt+iJJxHk+y7/9wej9MW/ew4ivE1eXOp/u8Goa6buPXqNoJCMsv+cHi9UM9A2OMtJ3Nl143C0MzcXXtCv9Cae1SjyWRTJTkDyIp+iGE3o7c6Yj3zrvXCjqebE3bzVltrrAItin24IUKehrQ3Wc4wb+Me5LArRUf6S3j3nEe9icFk8/E1tAaQuMLpfdN2/Y8v3ksIKn/Z04AKvq1vnCdELvUfKIFEKjnypZ64gaeljqo8cB/hAkMMymM7jOdgVAMRAMUcrdRnlfhMtdbqpFC9x3KXwJztyDuZRq30iIERbEQG0wlnAiNy9kyRPLzsxDNFIi0cleLi/xvzdqAF9pwiJ0QS7z+I0B62amFDTqtv4x/yj6VvgwaXDfC8nyNb430PG5UQoD3oJf5mQv1whhSOE6ezITZxc1mAplXg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 20:37:32.1231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fafa762f-109b-490f-1e30-08dc34af42a1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB8462

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

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
Changes in v3:
- Rebase to be against net-next
- Link to v2: https://lore.kernel.org/r/20240220-stmmac_stats-v2-1-0a78863bec70@axis.com

Changes in v2:
- Drop the misleading registers completely
- Link to v1: https://lore.kernel.org/r/20240216-stmmac_stats-v1-1-7065fa4613f8@axis.com
---
 drivers/net/ethernet/stmicro/stmmac/mmc.h            | 4 ----
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c       | 3 ---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 --
 3 files changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc.h b/drivers/net/ethernet/stmicro/stmmac/mmc.h
index 14c9d2637dfe..dff02d75d519 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc.h
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc.h
@@ -86,10 +86,6 @@ struct stmmac_counters {
 	unsigned int mmc_rx_discard_octets_gb;
 	unsigned int mmc_rx_align_err_frames;
 
-	/* IPC */
-	unsigned int mmc_rx_ipc_intr_mask;
-	unsigned int mmc_rx_ipc_intr;
-
 	/* IPv4 */
 	unsigned int mmc_rx_ipv4_gd;
 	unsigned int mmc_rx_ipv4_hderr;
diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index 8597c6abae8d..7eb477faa75a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -316,9 +316,6 @@ static void dwmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
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
index 0e44b84fb7e7..e1537a57815f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -243,8 +243,6 @@ static const struct stmmac_stats stmmac_mmc[] = {
 	STMMAC_MMC_STAT(mmc_rx_discard_frames_gb),
 	STMMAC_MMC_STAT(mmc_rx_discard_octets_gb),
 	STMMAC_MMC_STAT(mmc_rx_align_err_frames),
-	STMMAC_MMC_STAT(mmc_rx_ipc_intr_mask),
-	STMMAC_MMC_STAT(mmc_rx_ipc_intr),
 	STMMAC_MMC_STAT(mmc_rx_ipv4_gd),
 	STMMAC_MMC_STAT(mmc_rx_ipv4_hderr),
 	STMMAC_MMC_STAT(mmc_rx_ipv4_nopay),

---
base-commit: a08689109c5989acdc5c320de8e45324f6cfa791
change-id: 20240216-stmmac_stats-e3561d460d0e

Best regards,
-- 

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com


