Return-Path: <linux-kernel+bounces-156799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6BE8B0853
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BE52873A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C7715A4A4;
	Wed, 24 Apr 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RDt5I5gV"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A309159914;
	Wed, 24 Apr 2024 11:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713958203; cv=fail; b=FT871Tq7mwVXQohq01s4Sz6KhYmg0wzLwrnyG4rN4vm6P+ABs0kfELlyUA1CqzJRWmHnQ1A1D3mSMJKOekFESXPbn2Sc93sZHa66xh0lmXof8E9orMZDqAAHfjJlpXrCzbhkw8Dg0I8giPvG8/39pl4gEnLKLIdh5VBeXUV/V0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713958203; c=relaxed/simple;
	bh=FdfEUcAUJBYQFs9XmoOEzlo2xYVXVp2nX1osCQmDSWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IeFPa2iqtlkA1HoOihG78AcRdbqABSgJvzn786d1fMQB4FE0Zrg49rhvJEsDlG9kERALj4ExpGQpg7nrFQ2ONKyrvjHPUOqHdtWV9o/hhDJ6gETeWHR3TmdkEsqIqgXfuNaQnKMDiaVLlVejmQJT4vPizBTWK5nS6hIeZT48CgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RDt5I5gV; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTZIdSEbAaHNg8mcYP4NyajNMVsAb/QHwZDm+Cv1Nv+ygkhNvWskXWAyEMp8mGHv5ThSYNmGOlAswbvq18ImMM1OrSfwg+B6LOjwKZzTHg+ppbMNsSMWaT3xDE9wdNpf5xEsc9d40O9wRV2oGM1fY1l8an0i7qXl2mOSjW9TSHqrnTpfm5Ppumxg7PV81PpgAlDrGc68t3P7WD4WVy458Lfi4YdF8vEobC5Ljo4hA71I5UsD9Gqogp5bTjl8DuFDKpPC4mX8m4M/mGS/Nsix06ZtlRdin/4m6cnkxvu1MAZIT3Q+38gjujcCALqXgHvS8v6OlsPYJQ0EXKS7yNr/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCBGOmeUyq6IRlbQEjM/TLjwZ2CsFiZK+xL3v76/+Pg=;
 b=iYPUsXqZlYpv/NCHuCLZutJQWcwBbQv7kZ9IXg5sd2VhJeNMrQ49Qt+pZ3zitsAV21CpRUFnKrSWvB3QT8mMsyHl+Fmul0zDoOZYvJdH8Ja/80U6GsQi9hlOVkj20xdInjQGB266U4JcFoOgNm0CYvHPziH8gmDHW2wVfagwbis5ZYXsBV6YT1fJQLmcqg1lXbjKvCgoWYUk1K7gPCCR6VWgNhOqEw4/kQhdSUff52MA6nK/w4E3JV6FAINXs8UafBwaQaWhb9j5rgpKJ1gQdwyN4UJJuli13nFt6IDF3QL44jLTseVE4Dwkaxrt0eztNXERnVcTtBGc6rqkWwKspQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCBGOmeUyq6IRlbQEjM/TLjwZ2CsFiZK+xL3v76/+Pg=;
 b=RDt5I5gVic8tEqSkumcuYN7Erl1Z4r3ctT1waT7Gcuozo+ybGnnT+NlS5nmecz35wKUJ0k3eBLrLYSW60STYQ/quTbA3wdnv002YeOrKnm130b++TEqr3qG87TClli1E1kBrzF+fiB8bUSW9i4dFyMv0MJwHFSeeaiK/KnmnGnA=
Received: from BLAPR03CA0078.namprd03.prod.outlook.com (2603:10b6:208:329::23)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.45; Wed, 24 Apr
 2024 11:29:59 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::39) by BLAPR03CA0078.outlook.office365.com
 (2603:10b6:208:329::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Wed, 24 Apr 2024 11:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 11:29:59 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 06:29:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 04:29:58 -0700
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 06:29:53 -0500
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
Subject: [PATCH V2 2/3] arm64: zynqmp: Add resets property for UART nodes
Date: Wed, 24 Apr 2024 16:59:32 +0530
Message-ID: <20240424112933.3528590-3-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424112933.3528590-1-manikanta.guntupalli@amd.com>
References: <20240424112933.3528590-1-manikanta.guntupalli@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: 445f1f55-0553-4269-6cae-08dc6451e027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lSvaTj0zEv2dmcUrUQRys1ymXED5EUF917Z99eZ1jzM43CajgOHeWhYaohkI?=
 =?us-ascii?Q?PgVuX0+5pFWVC5NSI4sh+rXiviUn2UxZxaxQicaI6JTy+d6QZDi5X2hUM4Qi?=
 =?us-ascii?Q?K4mYHmyKIUrQ+GIcpeWba/dovHGvfOHLbOmzmhe4M/VxUWMo0nqakEnVaKBa?=
 =?us-ascii?Q?cVHHrvWdjZL3aQ4BG2ZZp5+uV5YQsS2SQyeKg0p9Z37OVCQnooBQ4WQ1Dix6?=
 =?us-ascii?Q?Xnm33LCQalg4HHbb1SCdJljH2RZZiZ2MakD6dov1S288C24Thm4+ZUjll30g?=
 =?us-ascii?Q?8r5s4Jyp7UowmBqwIlyJf3YQwUBRQkyP4Y3NxUr/SC3pWgFgwy0PQEGYd2TI?=
 =?us-ascii?Q?C5NmK7MrJ9TSpqw4tZxN5ZpUztVvmXrE8AKQ7jmZH4GxnyqNEFQyynfF9e1i?=
 =?us-ascii?Q?YOU6Fpk/1xIx1BM0AkfCm6jL4594uddw79mw0z3djMSy6xxRQsYsb0kU7WnS?=
 =?us-ascii?Q?w7qwmfx17IBfl8iKXdX92AB4pdntzFMsuhhbLcy7MAHVOT8TtTeVJgwIHDd2?=
 =?us-ascii?Q?HlvoZ7laRmAAZmJFUgV9LrvVitOmdacCgKI0D7ITcRUXHfb1pLl8CtGMjp+A?=
 =?us-ascii?Q?TMeihkWmkSVJpj6FKXShyMtw4usvy1MF1+30yXbI5cDynmznw2gJRNEvExwQ?=
 =?us-ascii?Q?Qtytl9xX1FFVqoRsbxGkw1FmV7qHYlIVIwb8Pm8owlZKc8wn6oJfi/gelqBL?=
 =?us-ascii?Q?So2BoSfF6rSlwu8QiknxFl3FXiTTgekg8GbVb9owq5QggTyZPe2s307b5Ixz?=
 =?us-ascii?Q?QejnzPPAf3aw7Pet9XHBm0Tb/S5VZs+Up1eeJwHsH92ZW5iYFw6W8dqRg+Aa?=
 =?us-ascii?Q?qRm0H70874NP3v6R3Y6UWMO+D4mA8IlAL+DYcANm9J5f4Cz1RrjGysaqNhWz?=
 =?us-ascii?Q?/7yZkAQW5am8CyUbuWeEl1dfTfp6LZeavMo8+tc/qamQdfO49cAPq0ocEKZC?=
 =?us-ascii?Q?v0peNB75HYVFdvySsnSMxaDl42kaQngSdpGDxKf6P/OyIFnQIP/9R8W4svyd?=
 =?us-ascii?Q?yQ/+Upk9v+XK8jroLA81bDzv3rpUTjHSfqShMbPGPgSBpPgagNsQucZPvfs5?=
 =?us-ascii?Q?tuV5qwuxfL4it2+vPyPYWSQHg20RLoKpy30yuSxYq27Pbytg4BOmZX19SzGM?=
 =?us-ascii?Q?2fkvvTLxVa1CJT58XLiG1jiyHNdPT7ZtbkGDRyK9+NFchH9ZjCycWuQt8Psw?=
 =?us-ascii?Q?JoL9Bzn1xNZWxnSzZcsfO7wsxg5ocLjZ+8FDj2P2cMFVMRKYHxom6hLI3WwX?=
 =?us-ascii?Q?pbPflNL2EqA+RM8oOXypnYMKj8q4INjQmB0pYuLNZgG0bm6g4ymZ/yX15kAP?=
 =?us-ascii?Q?YyPshj8KweDKMTPP7noA4tUVNfrAytBlkaVU/QUGk4mp1SYgF8y7b+6Mvjv5?=
 =?us-ascii?Q?PuORR1cv1Zp9PJl/Q9P0OC15V4SX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(7416005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 11:29:59.5107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 445f1f55-0553-4269-6cae-08dc6451e027
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536

Add resets property for UART0 and UART1 nodes

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
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


