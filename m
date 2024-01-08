Return-Path: <linux-kernel+bounces-19795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4033E827421
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C639828689A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D2B53E1E;
	Mon,  8 Jan 2024 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UTRSeTvD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CFB54279;
	Mon,  8 Jan 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nv1Ft3jDhSiqxlLgBoF7RLvEvoDUj7zufqQ3JcMBCJEfTb5oM/Wj1VdcQWqjObB0b38ahTGE1o9rh6hVZllE37BFTX0hBKN9yrUBqAK/JVCwQhV7Y5eSiMlNrOklgFMQvhQzpWWNEEqK3MrFRUxm/KENCKOpXB0K8FdUuhdSVlDEIfUhOeLdEkKvQkaydicU0FL6iY73Z+zMWw8j9T6wCo+zkQ40NqJ7kCiTNxAeSxhdvvsLVvVJYXNz4BzRqjRx09t1z++PE9SON/z23vFOKdpMQMH61tZ+1qvHOVEr2Q0pZNMynt+Ihq5dt0Up/l7JWFcOzl7xY/c9zwHaSqmNxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2ti7ZOmmmoXPlTGGeQtyFCpcX4pyLNFij82zh2mNIg=;
 b=jPclbdG4cHHUpHCNRXejE4NghPtugXhEfKgkE1KdaR5/wY6SKxOdDzdKK8o4hUWzQsJV+t1GSxJHnh/IiVK7xBa6F2e+cnlvL5koJLPWGojzBfQlV683u4vEi+rzAJISdCJ5N6loIe64/6vSHIu+DJpJhvMPjdxWAHUMzSmvYecvv7fPhLqUV+DWL1tsMsd/RrwqVtSvlm91KA5ye1u0b67Hhe8biXy1mDchwXSGhwqkTtl1uprThYZaC+04Id78BYVTdHJKzeyDpabGHP2FLvZBGf/G6120Z9Ylz9TrLKGgpANR5FHTlc3a8ybMud5V8uttj3MaMIUOdN7hsTVY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2ti7ZOmmmoXPlTGGeQtyFCpcX4pyLNFij82zh2mNIg=;
 b=UTRSeTvDOX0AMDcvvt6r12J0gYp60x6I6fUYGnL3ZlgfZGQRzGEpSTBZUUhIq2OTydoAuk8dgt9Kdd735ixZCil4+GNj52aBd6llV2+eK6fLh+eAExDcM+XfLkUFaGugrWvWZA2uhxpq0vzO2c/fTu3F4Gpp+mDAYkDC0Row1Z0=
Received: from MN2PR13CA0008.namprd13.prod.outlook.com (2603:10b6:208:160::21)
 by CH2PR12MB4280.namprd12.prod.outlook.com (2603:10b6:610:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 15:41:56 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::c) by MN2PR13CA0008.outlook.office365.com
 (2603:10b6:208:160::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14 via Frontend
 Transport; Mon, 8 Jan 2024 15:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 15:41:56 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 09:41:52 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 13/14] arm64: zynqmp: Comment all smmu entries
Date: Mon, 8 Jan 2024 16:39:24 +0100
Message-ID: <bdb012b1c86abb0d9aa88954196d886d1283e9b1.1704728353.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1704728353.git.michal.simek@amd.com>
References: <cover.1704728353.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10136; i=michal.simek@amd.com; h=from:subject:message-id; bh=4KjDOH59epC2I4LJ/dgBOHg1jAl3CY5vFPuDD0ydYWg=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ54lpmjIfefup7l/PR0LhHIFRuX4mF+Fmppyy3Kmc/c eR3KLLpiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABO5/5hhQeeHs5uVWVPdN/tu fPwu9/xirRv7JBjmmW/4JbYrtOwqE9tV3jKD/Wc/KiuIAwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|CH2PR12MB4280:EE_
X-MS-Office365-Filtering-Correlation-Id: f8aaa117-ae01-4be2-d25f-08dc10605878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ya64Wevfp3fla4AXFjDYAX/RdDMZGb3gs4zS9UJZcbK0BBSXwJVUOxuTDuIkFhMP7Wkrhxg8RLr7alC+SJ78u6hYoCfQL249DFuFMT+FcR21bEiMOnx0AdkV76VqJe8nkBfr85a6vAXxwHbowU/MMg6s1aOz/YT5aZIg/MDnNL0AefDhVA4zygbwZLnAZwG9lrLMrK1rHR8WMXGkHmcLpl1kyL77QweVSj9BHAeBPZdKkoa+wnCNcGTETpSQLpVq30TIc+deOsvMSrapsDNjepnFrAmugKS0dtnNqbJAn/tjBK+XmL+uT4RLmrrQYt7xVg5JU//jWs+dXtUVeMUXXsrzDsCVm4WvF9IH1KPeW4ILIS/DWVQZDvyNgeN0BaF9fKgSimGAr6ZnT/+lxbrSa1osihyGZ9NsbFuzzJ3BDqGixZTAO/v2sLGUe738VuxKR1SlqTeV6IzFAeZyy7H6ABOdbujuN73AL+FZJs/6QFwyqWUUqljwhmHAOqwtIYg9AwkA706JeBRgcRKUws2A+Lo3krFxgFFGtCutgriPtIVuCnhme8d8vTyc2JsrLc92WE2pgN+rO+sMZiPkSKusa1V1iP8tiyi5IFOj1OPdgvgexiuZennlXAaMYj1TG2CHzZGhH/tmbSjs5QJ+FgeOJUaZNseE3yNZqU/ggwZ0SrkwvwGvz07xBU/F3GTx9u7xLuqOMXAxHWlhV8MZhbBGWbzYD+nbBVlUuhX7/KTOpVyFu+Gc15JpawB0k3+CT5gNRStnTdOS/oRPAJJnzw9Ky/YohIrUQoR45mMQ8Nrgr4Q=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(4326008)(70206006)(70586007)(47076005)(316002)(8676002)(8936002)(26005)(478600001)(426003)(16526019)(336012)(2616005)(83380400001)(2906002)(41300700001)(5660300002)(82740400003)(81166007)(356005)(40480700001)(86362001)(36860700001)(6666004)(110136005)(54906003)(36756003)(40460700003)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:41:56.6517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8aaa117-ae01-4be2-d25f-08dc10605878
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4280

SMMU is disabled by default and not all masters can be enabled at the same
time because of limited number of entries. That's why comment all iommu
properties but keep them for reference in DT. In XEN case they should be
added back and Xen should have SMMU enabled by default.
Also add IDs for DP and DPDMA.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 59 +++++++++++++-------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index a1a9c8fd6038..631484e17ab0 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -340,7 +340,7 @@ fpd_dma_chan1: dma-controller@fd500000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14e8>;
+			/* iommus = <&smmu 0x14e8>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -353,7 +353,7 @@ fpd_dma_chan2: dma-controller@fd510000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14e9>;
+			/* iommus = <&smmu 0x14e9>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -366,7 +366,7 @@ fpd_dma_chan3: dma-controller@fd520000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14ea>;
+			/* iommus = <&smmu 0x14ea>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -379,7 +379,7 @@ fpd_dma_chan4: dma-controller@fd530000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14eb>;
+			/* iommus = <&smmu 0x14eb>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -392,7 +392,7 @@ fpd_dma_chan5: dma-controller@fd540000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14ec>;
+			/* iommus = <&smmu 0x14ec>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -405,7 +405,7 @@ fpd_dma_chan6: dma-controller@fd550000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14ed>;
+			/* iommus = <&smmu 0x14ed>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -418,7 +418,7 @@ fpd_dma_chan7: dma-controller@fd560000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14ee>;
+			/* iommus = <&smmu 0x14ee>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -431,7 +431,7 @@ fpd_dma_chan8: dma-controller@fd570000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <128>;
-			iommus = <&smmu 0x14ef>;
+			/* iommus = <&smmu 0x14ef>; */
 			power-domains = <&zynqmp_firmware PD_GDMA>;
 		};
 
@@ -476,7 +476,7 @@ lpd_dma_chan1: dma-controller@ffa80000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x868>;
+			/* iommus = <&smmu 0x868>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -489,7 +489,7 @@ lpd_dma_chan2: dma-controller@ffa90000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x869>;
+			/* iommus = <&smmu 0x869>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -502,7 +502,7 @@ lpd_dma_chan3: dma-controller@ffaa0000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x86a>;
+			/* iommus = <&smmu 0x86a>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -515,7 +515,7 @@ lpd_dma_chan4: dma-controller@ffab0000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x86b>;
+			/* iommus = <&smmu 0x86b>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -528,7 +528,7 @@ lpd_dma_chan5: dma-controller@ffac0000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x86c>;
+			/* iommus = <&smmu 0x86c>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -541,7 +541,7 @@ lpd_dma_chan6: dma-controller@ffad0000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x86d>;
+			/* iommus = <&smmu 0x86d>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -554,7 +554,7 @@ lpd_dma_chan7: dma-controller@ffae0000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x86e>;
+			/* iommus = <&smmu 0x86e>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -567,7 +567,7 @@ lpd_dma_chan8: dma-controller@ffaf0000 {
 			clock-names = "clk_main", "clk_apb";
 			#dma-cells = <1>;
 			xlnx,bus-width = <64>;
-			iommus = <&smmu 0x86f>;
+			/* iommus = <&smmu 0x86f>; */
 			power-domains = <&zynqmp_firmware PD_ADMA>;
 		};
 
@@ -585,7 +585,7 @@ nand0: nand-controller@ff100000 {
 			clock-names = "controller", "bus";
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-			iommus = <&smmu 0x872>;
+			/* iommus = <&smmu 0x872>; */
 			power-domains = <&zynqmp_firmware PD_NAND>;
 		};
 
@@ -597,7 +597,7 @@ gem0: ethernet@ff0b0000 {
 				     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0b0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			iommus = <&smmu 0x874>;
+			/* iommus = <&smmu 0x874>; */
 			power-domains = <&zynqmp_firmware PD_ETH_0>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM0>;
 			reset-names = "gem0_rst";
@@ -611,7 +611,7 @@ gem1: ethernet@ff0c0000 {
 				     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0c0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			iommus = <&smmu 0x875>;
+			/* iommus = <&smmu 0x875>; */
 			power-domains = <&zynqmp_firmware PD_ETH_1>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM1>;
 			reset-names = "gem1_rst";
@@ -625,7 +625,7 @@ gem2: ethernet@ff0d0000 {
 				     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0d0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			iommus = <&smmu 0x876>;
+			/* iommus = <&smmu 0x876>; */
 			power-domains = <&zynqmp_firmware PD_ETH_2>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM2>;
 			reset-names = "gem2_rst";
@@ -639,7 +639,7 @@ gem3: ethernet@ff0e0000 {
 				     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff0e0000 0x0 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
-			iommus = <&smmu 0x877>;
+			/* iommus = <&smmu 0x877>; */
 			power-domains = <&zynqmp_firmware PD_ETH_3>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_GEM3>;
 			reset-names = "gem3_rst";
@@ -707,7 +707,7 @@ pcie: pcie@fd0e0000 {
 					<0x0 0x0 0x0 0x2 &pcie_intc 0x2>,
 					<0x0 0x0 0x0 0x3 &pcie_intc 0x3>,
 					<0x0 0x0 0x0 0x4 &pcie_intc 0x4>;
-			iommus = <&smmu 0x4d0>;
+			/* iommus = <&smmu 0x4d0>; */
 			power-domains = <&zynqmp_firmware PD_PCIE>;
 			pcie_intc: legacy-interrupt-controller {
 				interrupt-controller;
@@ -726,7 +726,7 @@ qspi: spi@ff0f0000 {
 			num-cs = <1>;
 			reg = <0x0 0xff0f0000 0x0 0x1000>,
 			      <0x0 0xc0000000 0x0 0x8000000>;
-			iommus = <&smmu 0x873>;
+			/* iommus = <&smmu 0x873>; */
 			power-domains = <&zynqmp_firmware PD_QSPI>;
 		};
 
@@ -758,8 +758,7 @@ sata: ahci@fd0c0000 {
 			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
 			power-domains = <&zynqmp_firmware PD_SATA>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_SATA>;
-			iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
-				 <&smmu 0x4c2>, <&smmu 0x4c3>;
+			/* iommus = <&smmu 0x4c0>, <&smmu 0x4c1>, <&smmu 0x4c2>, <&smmu 0x4c3>; */
 		};
 
 		sdhci0: mmc@ff160000 {
@@ -770,7 +769,7 @@ sdhci0: mmc@ff160000 {
 			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff160000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
-			iommus = <&smmu 0x870>;
+			/* iommus = <&smmu 0x870>; */
 			#clock-cells = <1>;
 			clock-output-names = "clk_out_sd0", "clk_in_sd0";
 			power-domains = <&zynqmp_firmware PD_SD_0>;
@@ -785,7 +784,7 @@ sdhci1: mmc@ff170000 {
 			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff170000 0x0 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
-			iommus = <&smmu 0x871>;
+			/* iommus = <&smmu 0x871>; */
 			#clock-cells = <1>;
 			clock-output-names = "clk_out_sd1", "clk_in_sd1";
 			power-domains = <&zynqmp_firmware PD_SD_1>;
@@ -931,7 +930,7 @@ dwc3_0: usb@fe200000 {
 					     <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "bus_early", "ref";
-				iommus = <&smmu 0x860>;
+				/* iommus = <&smmu 0x860>; */
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,resume-hs-terminations;
 				/* dma-coherent; */
@@ -960,7 +959,7 @@ dwc3_1: usb@fe300000 {
 					     <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "bus_early", "ref";
-				iommus = <&smmu 0x861>;
+				/* iommus = <&smmu 0x861>; */
 				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,resume-hs-terminations;
 				/* dma-coherent; */
@@ -1018,6 +1017,7 @@ zynqmp_dpdma: dma-controller@fd4c0000 {
 			interrupt-parent = <&gic>;
 			clock-names = "axi_clk";
 			power-domains = <&zynqmp_firmware PD_DP>;
+			/* iommus = <&smmu 0xce4>; */
 			#dma-cells = <1>;
 		};
 
@@ -1032,6 +1032,7 @@ zynqmp_dpsub: display@fd4a0000 {
 			reg-names = "dp", "blend", "av_buf", "aud";
 			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-parent = <&gic>;
+			/* iommus = <&smmu 0xce3>; */
 			clock-names = "dp_apb_clk", "dp_aud_clk",
 				      "dp_vtc_pixel_clk_in";
 			power-domains = <&zynqmp_firmware PD_DP>;
-- 
2.36.1


