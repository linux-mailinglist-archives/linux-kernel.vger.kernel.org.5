Return-Path: <linux-kernel+bounces-151396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 315FF8AAE18
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20FF1F21724
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA33D8565D;
	Fri, 19 Apr 2024 12:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pQyf83Ik"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B0A81724;
	Fri, 19 Apr 2024 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713528376; cv=fail; b=kalUAgjcScEwypIX/kdijcoB/ngfRrhJYMNfBmZgvkHdaw0kwm4mIzR1LIivlR7DvovPaFjIwWq8thfd6qjrOmqHwu5vd/Jm/N0Ohl2pgMBlVGl/n1IMWjCEApViA3cYJxf2Ed8o5T6n94abiwOqZ5hP3j4YmGuUQ5sbvSMHlTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713528376; c=relaxed/simple;
	bh=NtqNTVVG5Os233tgHAEW1zQfLn7isbVl3AA/FMVxX6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoXXClOFeNDaNKVxfByUiiyPJvvLpdqADoTRrcR7F4FuYiaNbr1cUTBxP8Us1XDshrUrHyug8Fn91ZTB7MgeyLn44koE+H1zKnPEEVDMjUa2h8dHn7ES/CpoEj8qNVUD0eFLXEOqLf3UMQusFEda07S8/hWvzglnRxd8v7s9eDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pQyf83Ik; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpnFuWRw9kp8JTmeweYB5Pd9M9GwqGf2usYETm/X8Xyo0SM9YvgCG5k10eNStvrwFgh8sCsToC/AQchBAs2UbAaPo5yeQ8Z1F6WshQN1uMHLfSAnC1u2Vy9E1Du/R24NfT0VkZj9u0rbI8vsqWiNLLY87eOKc+ikuEhGK+TTc8JSCojUZ6xG34zBxs6xT7vRtPKvC2rZLesozwXEYU904MiVSEZIM7HaAOisORE6hrFOkWT7+ZvFQoca5eLpvJ5fFW0Ikkrl9JPsK7k5nwE0m5hotDfQa/x7XJYTmOJ0i3n+ric/jB0z2rykSpKALRhlZT2GPlENC+CXdhiM1xXt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2weJpxDajwLicia7zjgC3fOxN4bAk2/khpCT/w5STIs=;
 b=C3szsPoQwJzIY+l8GwMVCt0cga9WQ82hWgM4+JJcIs01qwDfMe49pFYvO00x5bwLD58ZxFYpa4NrQtYK92CsFY7c//81k57Spoyri2j1tRCuzAsKxqyrQVwQCiJdHPm1pRCgTTPJIhexYv9TCrke6feYV5X7kO+oFl5ZIBXRfTTgUERZ7QPEvMhv2MWSCIwz8x4mfR3qL6WyMV5Fx5AdNhrmV/hcwAQHOb4w21t4VnzCqIlHm+wF6+uqsubLgXt+3DrJ7n7jzUjgd0P4yXnt59Htv1eC33iv8G+5uql9/d5+KdvT78ZiTdOPtysamhyj8+e6GDq+5j+10pq8zLz9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2weJpxDajwLicia7zjgC3fOxN4bAk2/khpCT/w5STIs=;
 b=pQyf83Ik5GakSteN+HyfS2Yw0HhTUpnJKIK9V4HTYDem+uigjmTGa265Nuu57I+lp9qgPRHnEubMn3pN4OsTwcoP3n/bh2z8FIKXTiJqCc3odXGPGW+kYBj+G67y5Xu2YJ4Ezh26+YzjHy1Njlt2cgHsNCvaFytPzPn/P3vO+6E=
Received: from PH8PR05CA0005.namprd05.prod.outlook.com (2603:10b6:510:2cc::14)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 12:06:10 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::3a) by PH8PR05CA0005.outlook.office365.com
 (2603:10b6:510:2cc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.16 via Frontend
 Transport; Fri, 19 Apr 2024 12:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 12:06:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 07:06:07 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 19 Apr 2024 07:06:02 -0500
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
Subject: [PATCH 2/3] arm64: zynqmp: Add resets property for UART nodes
Date: Fri, 19 Apr 2024 17:35:30 +0530
Message-ID: <20240419120531.3775919-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419120531.3775919-1-manikanta.guntupalli@amd.com>
References: <20240419120531.3775919-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: 94212e1e-f179-4a50-28d4-08dc606919b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RHWvt96uGqRxgL9RyC9BlvlwFMvE34WMD43MDwot5jUeRzyM/+eQ+CmaGP5a?=
 =?us-ascii?Q?lLJ9MIkBJ2Xatrz6Ka24GDiOG/Cn2Sthp1CKCiq9ckwiVA6wcy1uWSultfeT?=
 =?us-ascii?Q?G8zknitlsFyUuJgCONAp7eGN4gF6mFms1Bs1skpxdUaXFgjYz80JaNXrJGWU?=
 =?us-ascii?Q?w9VhhvzFzf3zU6L+YsAG1Rcq6FALHlx3e7FkIplWXHT4IT2p51BlxZoNIwbo?=
 =?us-ascii?Q?74zc+47CqpJIEMSK5kT1MpMcd1k+15tXxhNh6EGTUv/duHxFDw+El90Mc6S4?=
 =?us-ascii?Q?Bz3l91E9RFMPqIfFWtXxHMOznuaKyCYJgJIPbVNuaPxb5x8K23ErfNKao4my?=
 =?us-ascii?Q?UxeFw+IzB8P7jVSergC7lPLPinHcjeZNychQaOoe7IFkqXoy/Xg3xDp9jSv+?=
 =?us-ascii?Q?cNL+OxF3IAuFl/DagOThEPUtXm23XizaGfJtvvKDh/vOx8RgVKBw5oM82DSs?=
 =?us-ascii?Q?kA8Z9H68DR9Tau0caJ8ko+Ogj3D47wKVsjV8ZgzghJjFX4nApMGyg58BDpUv?=
 =?us-ascii?Q?ROf+GtyGDYWcrYx+7IDmwr/pGChIs03yjlzzSqRcHfL0AZJ1oGobYZKwq/mj?=
 =?us-ascii?Q?F340q1lmXwVkfqU9HkuuT7kPKwlisUyeftMvui2qikgN2iocKC8So11Osbry?=
 =?us-ascii?Q?WZP+HuT+wzIbnJNiY69YggoWAA1Iryd7jWHYuy8+ovyliNc1lkOBp1yU2v0h?=
 =?us-ascii?Q?VkJcsgI92oODvW+Arku8LPvOvgkOvWXA3HjSzN2hi/Pj+hfk6CQP14y6YFn0?=
 =?us-ascii?Q?dMaBJb3JNoC14l2Nx/yH+a+YaiPQ21BnBP7p4nI+0n82D2EAI7hK6bO9ckS5?=
 =?us-ascii?Q?10zrLTqCIf19fmXZfq836w0s35nZlKYuUxcWD4k5/e3telTjSUqkdKJLBsvP?=
 =?us-ascii?Q?AJmG3PKPgkyZh85neDOOD4fJ+0ISTh/hc2qJI/awiaki0+RVg3SDLH9V9MUM?=
 =?us-ascii?Q?NnuugAPDuVZtkJRupG7HRFx9x5R36kJszrKIjaeKx/I6XkbAvAJv4uUzoWi1?=
 =?us-ascii?Q?3dnv3RKUi2RmakxZCyftMjuq02SB7mf8H47eBGtJKZc8gHAhxSNVdzyQe0vn?=
 =?us-ascii?Q?kcWkXyjwMXe6isXS5ZVFkVRxXhSC6UpyqBtFTm63tY+P7Pz4mFvSn5/PEvb1?=
 =?us-ascii?Q?L5BZx6RrsMGaDB4JJ4Vvj1+X9Af4XNP+UfkkTp3o2Eft36GgXbGxUW0ELH+n?=
 =?us-ascii?Q?T9bS2t+BTBANWJ9OJZ1MwBREDE7ewPV86jB+pDG/F1eHsZ4RzDgChbAqdNeR?=
 =?us-ascii?Q?9SRCjUFLsZg8KCY+WQk9B/56NJIKu3/mOMyaz+5HbaS4MI959lPrfbML8T07?=
 =?us-ascii?Q?tYP01ZTieBC6h5psr7nk49KkaR25OjcvnW/00rrSnXOGLl72AWTzkpXLVeyU?=
 =?us-ascii?Q?RiOwhIYvYGnSYfcpjJ40V2aXmpeT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(376005)(82310400014)(36860700004)(1800799015)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 12:06:09.6534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94212e1e-f179-4a50-28d4-08dc606919b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799

Add resets property for UART0 and UART1 nodes

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
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


