Return-Path: <linux-kernel+bounces-68867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49868858120
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B4EBB214FB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168111332AF;
	Fri, 16 Feb 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="BWVCT3bW"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2052.outbound.protection.outlook.com [40.107.14.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C1512FB36;
	Fri, 16 Feb 2024 15:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097087; cv=fail; b=oyGOIcvzotwl5yY2gnMxlvpv8lkj8iF/e6avIuxVZml3Gc2AmUFXjv2bGQsJaZvo9dboKlGGWk9DrhGnfr1koaK2AzfmdOCDFKMoF7dKKVSwx8eax167Uy62UmwMCM/hmH0aYHkV5yrs3ztdbT6ay3MIjo/DrEIcruuTFTbv+BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097087; c=relaxed/simple;
	bh=KLt7lkxMIDXwqVaa187HXcW2n371/Kn3gOTNz7xxQIQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=izzj9PM7sFJH+huksknSPZ3usSIzpHoyTLMd6R9ukLcZBUWfBktqv4SYt5a/Itn3j4xJCWtqfDn44SshLxtCjkrqVt3C+h4/ZSaMDuRQJWo8N/Ygx8JkBkokjKO98g09nAWqb8Bk55tSFViquxrepuGlqGwfWcdo7YgsyfAuav4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=BWVCT3bW; arc=fail smtp.client-ip=40.107.14.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gT7l+K0uiYbEZ9Btcgx18GvCiLqfYXFDto9tJJT6f3MO/dkM2wPC++AYF8/Zln/LL6a3cdirkaz+krcIrzk/+78KLM+b7+vGXgmJ30TKto5/z6EL9Stq77ym5WsXV4c7uJwKRM4hxO9IlOavj9rB4DXQox0LyzB+2VAIQCrcsf3RUWlhi9AdWuZc32PluumM82iRpAjQz7npCZDOF1QwTikqHC/pPbPVFau9zWuV7xdRLgqoMSiXXu5ZIF5S1z0OneiGjdDMbOIcywgX2VDWmKraqt5feprg4pAWhUu+uzbXUrW3wqiSMmJKqS5gJ6mQuKURimL4ZL/KGTJCKqm6QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37sPE7amiEW/LSX22nPYRRTcsfGA/KdN6cUCAu0caMo=;
 b=K6m+029TjOBDUfaggbDiCzMEYw6rXaASO0EGHx9DDYnaVetsE6RiwijLeBZyQUh21pYdm6RHS9jZ84sMztbU8c6jvHsxZvGsZFknmky5CDtBaCIBjNwMQWEU/n1bMSjT05ldUf/f5nikPV8l5JWBO57h2Az75XTcuBFsojPmALKBdVfZ+Bp/RFifFWekmv7j2r7WkHsSapBxZqEX659SZzfc0NMQSniUM+YUQ1NjlDho5WlGGjx1BhyYcYH50EvWjVYkAMoTJwgYsPVVzbhy5TW4wO7d0fa4nXHm7C4r7mkABC4l8JEDwjKWD2egoI6fsvCRZVFL6N6a8kbvr6IyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=davemloft.net smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37sPE7amiEW/LSX22nPYRRTcsfGA/KdN6cUCAu0caMo=;
 b=BWVCT3bWLezGZ4YNRA3eUmnHdFNmxIGzbiP4pWbKy1m1b6os9GvD0woLLMUSY/VciCflj6BA8J6rEyUVR1MreNqdeCiRmj1RVb0A+/nmBiUuhFeSKHtV6LURftvfJ+TOglOjgViDbyfblx/kUr+yxjs2dfA9qDrbbRU6sYqxjhE=
Received: from AM6PR02CA0036.eurprd02.prod.outlook.com (2603:10a6:20b:6e::49)
 by GVXPR02MB10805.eurprd02.prod.outlook.com (2603:10a6:150:158::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 15:24:39 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:20b:6e:cafe::3) by AM6PR02CA0036.outlook.office365.com
 (2603:10a6:20b:6e::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Fri, 16 Feb 2024 15:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 15:24:38 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 16 Feb
 2024 16:24:38 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 16 Feb 2024 16:24:38 +0100
Received: from pc55637-2337.se.axis.com (pc55637-2337.se.axis.com [10.88.4.11])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 7D2D7146C8;
	Fri, 16 Feb 2024 16:24:38 +0100 (CET)
Received: by pc55637-2337.se.axis.com (Postfix, from userid 363)
	id 805D422DFE41; Fri, 16 Feb 2024 16:24:38 +0100 (CET)
From: Jesper Nilsson <jesper.nilsson@axis.com>
Date: Fri, 16 Feb 2024 16:24:21 +0100
Subject: [PATCH] net: stmmac: mmc_core: Assign, don't add interrupt
 registers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240216-stmmac_stats-v1-1-7065fa4613f8@axis.com>
X-B4-Tracking: v=1; b=H4sIACR+z2UC/x3MQQqAIBBA0avIrBPUzEVXiQjJqWZhhSMRiHdPW
 r7F/wUYEyHDKAokfIjpOht0J2A9/LmjpNAMRhmrjHaSc4x+XTj7zBL7welgnQoKoSV3wo3efzf
 NtX7B5gzPXgAAAA==
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708097078; l=1873;
 i=jesper.nilsson@axis.com; s=20240216; h=from:subject:message-id;
 bh=KLt7lkxMIDXwqVaa187HXcW2n371/Kn3gOTNz7xxQIQ=;
 b=3AALvebc5WkJMbXlrwZxPpsh1ObS6AysvNlUkoKDysRlH9NCs9RnpgTWV+fLG7HDlSKOqIyPe
 7QLfuZE3uWxDndTDmgJVBcsqLy5Nf8nwDBFp8fi9h+qWyLn8IbDsfKR
X-Developer-Key: i=jesper.nilsson@axis.com; a=ed25519;
 pk=RDobTFVrTaE8iMP112Wk0CDiLdcV7I+OkaCECzhr/bI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|GVXPR02MB10805:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b8cb483-070b-4cda-4313-08dc2f036409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4oX4JGtheX+f2uX5984nJb+nT7QU/Rl4A8HnTm6vL2KgcQ3+uSnBGmEHt0/BkXhbCIYzyDjRZPiciAXZKAKSfNGRoK1zWxJ5izpDYP28SrAiOliulLq0lunBeXFtpTbcPTS1zZXXE0SNCgtjmn8QJ6UOqmxfig+SZmsMHY5KH80ZGgdICMTFXq0Sw8DxqZ66Luf5zGYvRtE+4VNynwZAjwJpUH+JH4ResLdsQgSRGgvj07rcvsKavb3JR01sjLIpKOSONKYjh+mGEuwCkzrW+ENMb2c7Bw7QGQkTaZfHtNyFDwTdvtKdxaS07hjHqDRs/S4dgQAXXYJRcRcrrDObULR3Qh7AgOblEHdDsv9WIoD8trooQ1+V8LporRZVdQrwE584RqumLz9NKQ0v0pIviU/WEYtMighgPMUbvp5miNziOZG5ZL4xvoPf1vCqVZrut2du23F7iW+4p2R6zzIpPZcO4Bg6xOLbdw9fJi3mIoF9mZIFKyA/o9tKdo1vVbHCv0I7Iw7vjugYWQIofT1Qm8Da1/27Tj34AwxmTQemVhYyo8GAlS6dvjSmKxEcalqQHpIAuHjDc1P7V3NzCiCV+YOwhvo22mg9O7ULrkseBq55UoSVQOX6nCTWYUZATgxmPM/EpPehkKdcAhUVzfEMG3UZTV/8DkN2vmGS6chqADU=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(36860700004)(1800799012)(46966006)(40470700004)(478600001)(2616005)(316002)(7416002)(5660300002)(44832011)(2906002)(8676002)(8936002)(4326008)(70586007)(70206006)(54906003)(110136005)(42186006)(41300700001)(6666004)(36756003)(26005)(83380400001)(426003)(107886003)(81166007)(86362001)(336012)(356005)(6266002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:24:38.9191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8cb483-070b-4cda-4313-08dc2f036409
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10805

The MMC IPC interrupt status and interrupt mask registers are of
little use as Ethernet statistics, but incrementing counters
based on the current interrupt and interrupt mask registers
makes them worse than useless.

For example, if the interrupt mask is set to 0x08420842,
the current code will increment by that amount each iteration,
leading to the following sequence of nonsense:

mmc_rx_ipc_intr_mask: 969816526
mmc_rx_ipc_intr_mask: 1108361744

Change the increment to a straight assignment to make the
statistics at least nominally useful.

Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/mmc_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index 6a7c1d325c46..6051a22b3cec 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -280,8 +280,8 @@ static void dwmac_mmc_read(void __iomem *mmcaddr, struct stmmac_counters *mmc)
 	mmc->mmc_rx_vlan_frames_gb += readl(mmcaddr + MMC_RX_VLAN_FRAMES_GB);
 	mmc->mmc_rx_watchdog_error += readl(mmcaddr + MMC_RX_WATCHDOG_ERROR);
 	/* IPC */
-	mmc->mmc_rx_ipc_intr_mask += readl(mmcaddr + MMC_RX_IPC_INTR_MASK);
-	mmc->mmc_rx_ipc_intr += readl(mmcaddr + MMC_RX_IPC_INTR);
+	mmc->mmc_rx_ipc_intr_mask = readl(mmcaddr + MMC_RX_IPC_INTR_MASK);
+	mmc->mmc_rx_ipc_intr = readl(mmcaddr + MMC_RX_IPC_INTR);
 	/* IPv4 */
 	mmc->mmc_rx_ipv4_gd += readl(mmcaddr + MMC_RX_IPV4_GD);
 	mmc->mmc_rx_ipv4_hderr += readl(mmcaddr + MMC_RX_IPV4_HDERR);

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240216-stmmac_stats-e3561d460d0e

Best regards,
-- 

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com


