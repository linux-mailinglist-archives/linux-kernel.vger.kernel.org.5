Return-Path: <linux-kernel+bounces-76790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E6485FCA0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B0E1C24848
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6721509A1;
	Thu, 22 Feb 2024 15:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fqXjLTxt"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D9F14D42F;
	Thu, 22 Feb 2024 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708616356; cv=fail; b=qV6nTM0kXPyMzD6WVt18EB8ANG4v8lr5soX7KpdRyZMdV71oUpd2cdZrr5j1u3Upj7oPaZ3pUyPAzA6nqc7uclEh44FEbX2kve/WE9Gu5HvGwH48n/7Ki4XQd3mish+yQYuSoI9V49QSnz9T7GN8O5YSl60JSNvlr1Ym8H6vseE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708616356; c=relaxed/simple;
	bh=WfAEceRZtG0V1VXu4bIbpDalpE3BX+aX2y67FyHyYDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rPrqEi85ArCzaX3YTNCaxIC4aYafgQA01Q3OG+B+zgfUXhPB/FBIioVpyMHcjmJFQGIv/MgIKzrjAORLW0T6c775rOcX92wDFSZPV+G1qiQNOOldP0H1xZFJrSOD4kQ0e33m/6l++bUXDEkcCyMyjamFVtk+oNB8WJVQEvV8xMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fqXjLTxt; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbX9Iz9qwgGqMOqjFpadrR/d6YU+i2K8OrB3TAygNcINou+y1jCBnZW3833RIkZebGDRgpCc4yTcDCiayZgMfwinnN0k0+9c56id7elGZkJHq6j270IiHt7g8ueIvxbPBJH2sKHWP3se/BrYI2I11uSYzsF+gC+5OLrXEIQLkpWenIzzgMnp2rmXTT3vHggRWLLfDWWRpXYCyCqaDHgM8fq/WCCGTr9XYHAuUDllchA8lPDGA9uGO+6kVRNkdaF/QVTQ1g/iVZhwkJpgdiZqHeTM4/7lM5L3raia9StNRHayuh9qngzivIibRVz5OqatyZPEw/FObu+jt0rekgWQcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sEfOiApCO1nKugYASoMo+CeWWoI3rZh0oPJ+9KQa/kQ=;
 b=MvKIOoeGpAYNxEqjnUtJHdL+DXKc5DZwvcNNA3KqivnTcg4W7LOi5E1vIsCQmUqkiqBjl1tIT8i5nocKOARXJ2TTdAMZYFGO//xnHpuazQrH9qVcPrcrBpnAhwU99l29WuAA9zmexVdT0pvN+fu2/fjGDUVSrUmV5EsE0r20LSTHM47ScXCrTMdBb4EOOD+t6sValFd8C0IharKObJa6FQuhUVMZNit4X/dmbdOsCxmkSQGnGUWikgFBIl8/o1tc4AFu2/a/F5vQ+a6mQJlDdCDeKdsQlZ34sgmwLmdsvvabvNH/UOkKTPBbkuyk0Gtq+EqzC8Hrp2Smbw7ovG1Eiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEfOiApCO1nKugYASoMo+CeWWoI3rZh0oPJ+9KQa/kQ=;
 b=fqXjLTxtF7U1bbKq0LoytU53Wmu4ZKbMCgKCU7k7+Mwlb+ycpHaxU+1EUPwvPAmsE0CeLMcDj9pqx1qJTKowxKqu1FgI6b6LJ5QeIq1zady5PYwi/2YIkfr0Izuv80iU2MTFgj1AmVvv7USTNzte5gD4zQ0A8hMnrd61TvznFfM=
Received: from BN8PR12CA0034.namprd12.prod.outlook.com (2603:10b6:408:60::47)
 by SA3PR12MB9105.namprd12.prod.outlook.com (2603:10b6:806:382::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.23; Thu, 22 Feb
 2024 15:39:12 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:60:cafe::1) by BN8PR12CA0034.outlook.office365.com
 (2603:10b6:408:60::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.41 via Frontend
 Transport; Thu, 22 Feb 2024 15:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 22 Feb 2024 15:39:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 22 Feb
 2024 09:39:11 -0600
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 22 Feb 2024 09:39:07 -0600
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v2 3/4] net: macb: Enable queue disable and WOL
Date: Thu, 22 Feb 2024 21:08:47 +0530
Message-ID: <20240222153848.2374782-4-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|SA3PR12MB9105:EE_
X-MS-Office365-Filtering-Correlation-Id: 83424f55-b7cd-406f-07db-08dc33bc6b1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5CxwMs5gkzW1KDFQ0s8r5V9e8xLsl8rqIsoNkenIhP7kbAA5xjjYCDNloLYONYlWZjvobKykvuQpIsw1W/L1oYSG1SQCzRg1UxaOkOC6nvmBsSXkZ+wM4pULpfD0XW5F8Q/NY61Y42XA67SGTvMxrc3c7645/dRrXZOoHf3uZLR6S+y+VXe/Qtzg4JwP5w/T9lJtcnqzLVPljFRFG4TLH8PCMueoQdD8oZEp9bx2970C936Gck3uyR16CL1aH8ktcXn5b6exO9Bm+FwdCamvkVCWSwQUgQFr42bmm1RhzBvO2T5neT3NuHy7D0QdqZW8ImPDda1ElI04Q/Hxs9ChTFcOhS4hDDTAqj/OQwvRXeboilQaXDhCSVLTI+99ED73fdVcUWYHQ9oJow+NBhqsTWF+Oic5EY2GAAZsUPIPZGyZdvKBYa61uVdDzbGvQqbTUNrgx81aDxikrEi94IHPyrPloFagkJhLVZ30DHr41VsqouiIa15LQJhWNXtk3QaRFwlHDl5IDJoUp9RfdiMcr/IDfnPk6otv0WyvWONSpqF2KJde5JHjox8iK7BsNa6vmm7q5+FcZhVU47959P/hW2T+2Vwhc6IyoLX27Le00OPwfqwk5u99Z3XiJbScMqEL/lTimlchIe4cd4L60FvFImrQFEbMM+H6eAIr5KlT/N0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 15:39:12.3363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83424f55-b7cd-406f-07db-08dc33bc6b1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9105

- Enable WOL for ZynqMP devices.
- Enable queue disable and WOL for Versal devices.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 62d796ef4035..55d8c1f3ee80 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4903,7 +4903,7 @@ static const struct macb_config np4_config = {
 
 static const struct macb_config zynqmp_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE |
-		MACB_CAPS_JUMBO |
+		MACB_CAPS_JUMBO | MACB_CAPS_WOL |
 		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
@@ -4954,7 +4954,9 @@ static const struct macb_config sama7g5_emac_config = {
 
 static const struct macb_config versal_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH | MACB_CAPS_NEED_TSUCLK,
+		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH |
+		MACB_CAPS_QUEUE_DISABLE | MACB_CAPS_NEED_TSUCLK |
+		MACB_CAPS_WOL,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = init_reset_optional,
-- 
2.34.1


