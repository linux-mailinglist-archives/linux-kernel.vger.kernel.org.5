Return-Path: <linux-kernel+bounces-79049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E19861CCC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4096F28785A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD23145355;
	Fri, 23 Feb 2024 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jl73+uu8"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712F3143C70;
	Fri, 23 Feb 2024 19:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717531; cv=fail; b=k5N1TPQicNdRDfwxoHgXkoOgbwmeh6gQiG+770AKcf+F+ZHYI8MRmqRK/bD8B+qY6P8HQFCPOh32cxmCOsXWBYbdIxtvL+3xugO/GZqFm2r39wkSvqJ+o24P2ZFaLeKAXggf3OdGXTRrbjZkxsiBMtrsiS2Sec2F2TVvNpAu7mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717531; c=relaxed/simple;
	bh=cNTzwYzs0vDBcQp+QlHesLKw6m7rzGgIl7KyNHhaL1k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cf1cPtRP8S0suAxodWJ6JqZqabd/i8eX+dcItRXcgIKQWjhZMzhJF+lpRQYb8HaXX9vEWRokf0w+DN+DQvr/6v2akM/lHrIDEHlxs/AKrfXQAmSqmmLFPkZJRp53PcikRtCdeuqbW2Z/jEtVKLZzTHSGQXG1p3aROmXqHaQX6vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jl73+uu8; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJZhvXNodC7MFGsdI2jiHmIqLCkW3RKFLXQTLyn1DVr5b4dNttha6yDmNPxFj3kASII43f2dV1YUeRLoApUJ+5HWtw45HkHMqwT6CkqWQmh6H4T4AD1/XGqZmydw9Og2MgTSgh1qoE0rTLQoU9y10CoVA9z8ZgHCrglFzz3cKQvAXTQta1YRVFK6ql2Esg+83J/QXORkohV9akY5Eex08LxRvihX+NE8RpHPa8FDk51Z8C0pFnTpgXpfDbDq67UBOpGFWHy2g16RlxmqTANE+Nmzk9MLd8n6LAg8IwISC+T8rIx1HGLzs5kL8YjHHLin5Ss7iEpKsvZ40SeNt+7Vqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCdCZgZZISrdmEcxH0yjZXlt5XtX57OgcxB3iZLf/84=;
 b=aq5r7ZyLEEZXy1ImAr6PUCh5yvz21Ck50kE8GkligxGOdO/qzsAeknSAE2kg4cvEqVCwS70c4XvdS7QClb1gpYMJTfX7dr8+KbyJ+4dggVX+ePqQE8Hfy9yEphAtUYYZQicYKwsriL2NurMzhhpUF3d5Kx1bwtS6CE6EmTnRyF+GdurBfIa1cTxTqbJTcNhG/P1rvN5uNzus4GJ9+1fysLL7275JI7t6jP7TaiP1n5AKgrEywEw3pbq0yJRYOrNbwqWekE+zQLEbxU+4kPgOUAMYpF9ydbUjTehdhawzNtDcOKOrruh8YezWQjd4UiBIq90PUDTvpJDJKTe+IsvXuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=synopsys.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCdCZgZZISrdmEcxH0yjZXlt5XtX57OgcxB3iZLf/84=;
 b=Jl73+uu8e4NtfCbxwPN4TMf58vWV4l1Y9eg8ge5rdtdFCw6qy1gI0MKNE0vMHCnC5kGCRFbBtxfLiROIRWy1L36iogGmG2Ek06QD5c1RlhbUP/Mab7RboRfZJS0jH1VwS9hLHRksYcI9xGLJ27RuOdg+XXA0mdKpxC8CT01WiPk=
Received: from CH3P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::8)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 19:45:26 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::d0) by CH3P221CA0016.outlook.office365.com
 (2603:10b6:610:1e7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.45 via Frontend
 Transport; Fri, 23 Feb 2024 19:45:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 23 Feb 2024 19:45:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 13:45:25 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 23 Feb
 2024 13:45:24 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 23 Feb 2024 13:45:23 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <Thinh.Nguyen@synopsys.com>, <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH v2] usb: dwc3: core: enable CCI support for AMD-xilinx DWC3 controller
Date: Sat, 24 Feb 2024 01:15:23 +0530
Message-ID: <1708717523-4006664-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0f0f12-f707-4997-526f-08dc34a7fb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wn1q26rprMhChTqrbrgAel/NVx/xvOJZG29IqkHHnlIUiVKZW15SCxZ4DBuCwGF/ZjQLNiexUyHXb6gEQpkKiIz4mW/qkgJEz/A779+crxojGao32JmTeBbPMNaaYlLYcsxjUBSX6P5Jg/J1toXV7Qfj8204jXkWDemqGchgqiKob6X2C+tABcGm7DCt0si2u7+MrEqKZaAu6LS4k3ASs1Fc94h8y+VgpR2eTYnCEl2pCFds0a24iYf0yi5JxQ0CBolpKR6fzssdQigecPFPSZms2P0zXwSB+J37PIS6p9ZY9GaWNDY6iqkhNLOceJZ93cx/OezG1sm1vikWfvEsX3+XjOkie2GGVw8k+rlwOsA6WZJw1gmjPr0ksqgH8EjjAb9vYUKSDinI1oCOxC6PM5NYBbJkEJkclVgqQ2DMV128o2tZAQhmfNenPDMW8p64XPhoD50+JvqKxQRs5689rihK/+3wrPT/LIccz/rM9E/B+ZzUrUWT6GiuLjc6yCVnBoZEmxb82Z526iB6mhHx42H0KqrbI6TJP1jxwIXL5ylXet4aFz/mzBKLXUy1RCgvIsYMkaKf2z0PQ4H9WILFknrDGa+416v5DVvMkGn2382IneLkF/mZP/sMLaEvt6clyP9o+bFlaDjg0DicSFU9aA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 19:45:26.4102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0f0f12-f707-4997-526f-08dc34a7fb96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212

From: Piyush Mehta <piyush.mehta@amd.com>

The GSBUSCFG0 register bits [31:16] are used to configure the cache type
settings of the descriptor and data write/read transfers (Cacheable,
Bufferable/ Posted). When CCI is enabled in the design, DWC3 core GSBUSCFG0
cache bits must be updated to support CCI enabled transfers in USB.

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
----
changes for v2:
Make GSBUSCFG0 configuration specific to AMD-xilinx platform.
Taken reference from existing commit ec5eb43813a4 ("usb: dwc3: core:
add support for realtek SoCs custom's global register start address")

v1 link:
https://lore.kernel.org/all/20231013053448.11056-1-piyush.mehta@amd.com
---
 drivers/usb/dwc3/core.c | 26 ++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h |  5 +++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3e55838c0001..3acd4ab3fcca 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/pinctrl/consumer.h>
@@ -559,6 +560,29 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 		parms->hwparams9 = dwc3_readl(dwc->regs, DWC3_GHWPARAMS9);
 }
 
+static void dwc3_config_soc_bus(struct dwc3 *dwc)
+{
+	if (dwc->dev->of_node) {
+		struct device_node *parent = of_get_parent(dwc->dev->of_node);
+
+		if (of_device_is_compatible(parent, "xlnx,zynqmp-dwc3") ||
+		    of_device_is_compatible(parent, "xlnx,versal-dwc3")) {
+			if (of_dma_is_coherent(dwc->dev->of_node)) {
+				u32 reg;
+
+				reg = dwc3_readl(dwc->regs, DWC3_GSBUSCFG0);
+				reg |= DWC3_GSBUSCFG0_DATRDREQINFO_MASK |
+					DWC3_GSBUSCFG0_DESRDREQINFO_MASK |
+					DWC3_GSBUSCFG0_DATWRREQINFO_MASK |
+					DWC3_GSBUSCFG0_DESWRREQINFO_MASK;
+				dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, reg);
+			}
+		}
+
+		of_node_put(parent);
+	}
+}
+
 static int dwc3_core_ulpi_init(struct dwc3 *dwc)
 {
 	int intf;
@@ -1256,6 +1280,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_set_incr_burst_type(dwc);
 
+	dwc3_config_soc_bus(dwc);
+
 	ret = dwc3_phy_power_on(dwc);
 	if (ret)
 		goto err_exit_phy;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 25dc0599345e..bf19a20e240f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -175,6 +175,11 @@
 #define DWC3_LLUCTL		0xd024
 
 /* Bit fields */
+/* Global SoC Bus Configuration Register: AHB-prot/AXI-cache/OCP-ReqInfo */
+#define DWC3_GSBUSCFG0_DATRDREQINFO_MASK	GENMASK(31, 28)
+#define DWC3_GSBUSCFG0_DESRDREQINFO_MASK	GENMASK(27, 24)
+#define DWC3_GSBUSCFG0_DATWRREQINFO_MASK	GENMASK(23, 20)
+#define DWC3_GSBUSCFG0_DESWRREQINFO_MASK	GENMASK(19, 16)
 
 /* Global SoC Bus Configuration INCRx Register 0 */
 #define DWC3_GSBUSCFG0_INCR256BRSTENA	(1 << 7) /* INCR256 burst */
-- 
2.34.1


