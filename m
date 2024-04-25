Return-Path: <linux-kernel+bounces-158065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DB38B1AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE6F281DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E5F5BACF;
	Thu, 25 Apr 2024 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lDkg45ZB"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00013F9D2;
	Thu, 25 Apr 2024 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026273; cv=fail; b=mu+/NoH2524OjKN/fsLnfRXmwT/uHImo/YcqMs1kT0HWUL7h7KILz+UFCucgh0BxYMDP4zeIGPGAHKQ4BvxN2tQ/Qo/MxnwLMWWEE9vAbMyZQ3T8pF+WqkFmjxwflWKN0XroXAi8oa50Wv1mI2zEWJyA4rvsgSyKaTPn/nDr7Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026273; c=relaxed/simple;
	bh=uUt3d81Zv1AeBFJfxdI7Xd6PqsnBukPxPcNMTrGBo1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QFJPAqei+y9VKwBg76yxT/0Y9mS5R7tscQTKcuq0/CSfPTWdtS+odxeJ0RwanzaDjNd3urcIImO+ugNh3S2eW0x1kMfIE2L1SFZ4Topt8115SJQX9KdbxJeu6w/7cbnJujwZ7O/Ozqh7kfSNCRozmJQDcbcYSk4t0+z7eqdW2sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lDkg45ZB; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2t1+1+UKkpKj8B3ojUZ9TlJEEXNSasInd+37o1XeyVsuPidV1eKSl1mXrUqhk1bMkv0iFf8CuJTrtzvrUq7E7k0pCjEmLnB+8HdAuDt4nWo61IuM+ZkxUqIbtxBMZxTEylCoCtFfq/n2Xhq67PPjyuVjoHNfZyHjLFaBbpTAWojrSYfIzrKMbQ6emvoPz3j/QhnDqqOC3oYU3Bzu9RNb8k+2vRBlrZ0QFWHjO2xTUphVItJsSkgRUPb9Zho8CGzmX12iED3U109MgXnwTR0w2AVQMa+IPan397CQ1lPk36r9jaoeJbq7gcmspy3FXc6k7BfFYFGHZZ08avKnxz9yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf3KdAqZ6cg50SPuHKL3lcPOTwEGzOwx4dc0+xTXB7g=;
 b=Igs+WOtEdpG2ysZVQ/iCon9jfDURcqKrDFVy+ju+dPOm4laaNrNjK8g0fQvPXOzmJekXpx9q5AfCA5Y2QE/KTvt1QtsD5L8uEcijVVc4U4t6uc3CXcbApXN6X9rpLWh3Pp14AkZrrepw6E5uqnXrkJG2gO7bKF7Ea5AajEbs4Czlg//Ddlp8/oJJsKJbj4V8voCGYWLVhZS9lOOBG+NKy8pFNjBXJ2a+Uzo9mfr0d7lJSB/08YoaCATMpCST/G0qYfeFe2ohhiAovRvOloLpGIRpxOT7N74OFpTwnqWE0HigJmfpKWE4Nrrx1Hxw07q9eebKK1wbBXbSgZjRRQoipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf3KdAqZ6cg50SPuHKL3lcPOTwEGzOwx4dc0+xTXB7g=;
 b=lDkg45ZBp8pCjKmKcZ1wG3r0Cftwr0QKEwbEyHFob8Z7NKwovqVfPHowCBp4cvxL9u+y6Q69UGO7AnLmnPB45Tx964WVyFfo1CJT4svrJu2lF54xjzBVNB602tbyfY/ovEReczEVO6fj6wCVYxexjPdECjuEkE5KpFQOA/rSATU=
Received: from DS7PR05CA0044.namprd05.prod.outlook.com (2603:10b6:8:2f::10) by
 SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 06:24:28 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com (2603:10b6:8:2f::4)
 by DS7PR05CA0044.outlook.office365.com (2603:10b6:8:2f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.25 via Frontend Transport; Thu, 25 Apr 2024 06:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 06:24:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 01:24:27 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 25 Apr 2024 01:24:21 -0500
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <p.zabel@pengutronix.de>,
	<laurent.pinchart@ideasonboard.com>, <radhey.shyam.pandey@amd.com>,
	<parth.gajjar@amd.com>, <u.kleine-koenig@pengutronix.de>,
	<tglx@linutronix.de>, <julien.malik@unseenlabs.fr>, <ruanjinjie@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <srinivas.goud@amd.com>, <shubhrajyoti.datta@amd.com>,
	<manion05gk@gmail.com>, Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: [PATCH V3 2/3] arm64: zynqmp: Add resets property for UART nodes
Date: Thu, 25 Apr 2024 11:53:57 +0530
Message-ID: <20240425062358.1347684-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425062358.1347684-1-manikanta.guntupalli@amd.com>
References: <20240425062358.1347684-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: manikanta.guntupalli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: df56bc42-53e5-4b6f-f453-08dc64f05c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400014|7416005|1800799015|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b71/yPqAXsVjLPoI5A+TsViR5OWTUkoOCfajjfQj4dmqLScLEgVRottFHza4?=
 =?us-ascii?Q?mpsQwCKfh7IyJnuLCmBmyicmkC1AFN6BKyaOQ0tmml0BGs7NQnrbr6IcFtep?=
 =?us-ascii?Q?m1U4btmtZAQ3kBwotxpPCWyvEfnOW2t5EeZM9HSoB/wRoZK2bnTZlVCikR8h?=
 =?us-ascii?Q?yRzl7TGUSPFuIOoxLjbcFLVi1SrlTrFYDX9ugoion7AHQlQ+OyW6kd91GtRR?=
 =?us-ascii?Q?Az6hJVu3kzsVFnSZooe6tjGpxj4ImeiN8JeC+13rJnhmlw/78ZXzYo9lwskz?=
 =?us-ascii?Q?1+nDru05rid/lV1dgmk5uZ38MLaH1uD9DxGcDw3M6cyCj8eZK6Ld0faZqlZs?=
 =?us-ascii?Q?FxjcIp/s8I6lgZcCsijinajPx4IuE442fYKUzEeysS/iCCInlgPujNmpCfba?=
 =?us-ascii?Q?TRuX1tZZhaex+BtGR9o0a3JxO7jbliGhiGY3UR4l1Px0Il0x0mI9FN4aZMjO?=
 =?us-ascii?Q?Lbj7DB3e2aQ5Tr4FdzoJzZBBUj+f5ASMZguRLG7EnlZxcCOGrm4Z9RNTfksv?=
 =?us-ascii?Q?YM7OzqDROGPFQUQYbU6BdmYBGrshyNPHGMyP8/9pq16/c7JqsOGc4gJDuke7?=
 =?us-ascii?Q?5wV588TUoAwhAdEuwo8dNelHVC2hFClAgi9Ytg7bHP/Am6Zh7PBfJndS2UUj?=
 =?us-ascii?Q?iyolezB97pnbZvArPxqJjhVYd7grO2Z4A73FS6OlD0tvQ2RJkTNtyoi7+t5w?=
 =?us-ascii?Q?jXbK6pinUV5IZoucRVX9UMGt4Xrp6+ierX91ZDKtaFh4fCjUxDHLHDMzqBBC?=
 =?us-ascii?Q?bmqm0CamIGjj7b9pnNP8K+3GiSUVSLS41UTNlwjgBWQlYOOjV769/jphw0DO?=
 =?us-ascii?Q?jnmK907dK9uI6sEosFtFOlac6pIAclY0umSiTc5i1H1DynGyBPbxhSwtKGQa?=
 =?us-ascii?Q?O1i9n5rVlO0ll05L+1+xnhUeXP7vC/EJ2uEWMfu2h5EQm+iJ41X8mh+CnbG1?=
 =?us-ascii?Q?ak+k298qYPgXNgj4e8FNe6/tD4hT7BKmkEq3GK/DCzinbT2BBxgjtrUIpAtb?=
 =?us-ascii?Q?3e+JU6r/1o2+Qn/gMVtwiCMuIfB6h0Qo8wUb/Duv/Kn8vfyNyUBeJdpcabQd?=
 =?us-ascii?Q?zzdRu0mxTDGl36bBtoL5hpv9G29znu6ETZ0PZXdpw0OWYkcXsv+lXjWhic1x?=
 =?us-ascii?Q?aZbBNJx5A7DBviT27qhYvMzmIbGKi3/wkEVMRr4K1cSj8SfrV/Rl0RUHkJKi?=
 =?us-ascii?Q?6pMCvHLQyjl2XW/6CrGm7OdO9xoI0c6ZITTRXaNM0Q3nn5lPpGN/Cjw0snaB?=
 =?us-ascii?Q?PuxrakqxrMHOV4rmMa9neA7y76wZzgeuzkZjkkwelKrOEyoFa1SEGc+cQbGz?=
 =?us-ascii?Q?24GdmtU6d9cI1w2X92LO8dvDXBoPdqeN6y8py2n+f1ItFblLewBTo6UDPm5G?=
 =?us-ascii?Q?P/jup/pM7jOT7OXD/VMgagXasihv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(7416005)(1800799015)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:24:28.0274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df56bc42-53e5-4b6f-f453-08dc64f05c2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

Add resets property for UART0 and UART1 nodes

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
None.
Changes for V3:
None.
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 25d20d803230..935504424ec6 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -906,6 +906,7 @@ uart0: serial@ff000000 {
 			reg = <0x0 0xff000000 0x0 0x1000>;
 			clock-names = "uart_clk", "pclk";
 			power-domains = <&zynqmp_firmware PD_UART_0>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_UART0>;
 		};
 
 		uart1: serial@ff010000 {
@@ -917,6 +918,7 @@ uart1: serial@ff010000 {
 			reg = <0x0 0xff010000 0x0 0x1000>;
 			clock-names = "uart_clk", "pclk";
 			power-domains = <&zynqmp_firmware PD_UART_1>;
+			resets = <&zynqmp_reset ZYNQMP_RESET_UART1>;
 		};
 
 		usb0: usb@ff9d0000 {
-- 
2.25.1


