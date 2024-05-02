Return-Path: <linux-kernel+bounces-167037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9001B8BA3C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18A901F24C82
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13D046B80;
	Thu,  2 May 2024 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="PblnF1lh"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2103.outbound.protection.outlook.com [40.107.236.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823451D54F;
	Thu,  2 May 2024 23:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691329; cv=fail; b=KRo5L5pFwN7e7IJf9qavhs+Z1ZyukXG+qISmMRgSTrxHn6e65cHWhy9/JLCLlKYJkrkvzVZRVYSlvwC12fT1Ju93Luc4KIloaP6WwP/s/7T0TB1d0G+C0465+LvTTti9zNu/mKhG/B2eGLYBklSB5ZwWXpcNTLOoesKm19wv2R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691329; c=relaxed/simple;
	bh=+epCM4pz2bFObX9MU8Wf8GrnBOEzozP6MvJZPwlfEXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2W0N00qchLTg2D8OfeiofcgUsqcLaqWK4e3bJxhIauLK6OFqIiWtGf3qSOdeW1rG1TfAoS7OvKXj+UHzs90RK9HWunPwM/lqY31Ar70HDA9vucTFmrD6YXe+lJNtYZTpYWPZeKU/jXwLvfc8bCxLp7xLxUjQ2yo0lKJ/WWSysI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=PblnF1lh; arc=fail smtp.client-ip=40.107.236.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzIZRGns7Uz2U/PFNNBUEIozzg8jaHQkJM08Dtpxox7ZTNMaEC7iRUv9CNKn2LeX/o1shmkbfBX5PeshCgKkVIFm8vf49Pk9OkWNobGcQwCiLrJbDaJLKsrsg6GkcyMU7OXlW0oQLlvm67Yi0XCd0wZzJhSGDgsbQVFKrtGzvcdIQSuBUicyf/9b5AvHfsVPPA4K8lN0FWGG7YspxAedLH6EpdXLiyRwjRqG6o4Q07GXZFAisQjTgAIc40ZvEK+wPwyUPWwz8tYuOFQdii5P6hlZJLfZecv4+/e5bXiFhSVq+feIGOQlbY2tl4Rtmil+2FLZSHrLuBWdCgRMwbFPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoXGj126LCgxbFRXRpkgIVISSxeP/vVG/GMOqDQLheQ=;
 b=E/WWDIGLE4fMKfh2TFCrQV6xixYWbDfVT2iQvYeF8ymh1BWLJ3afNop9pwRocg77M87spU+SPM4Pz3oAM6l4QRsZ4IIRGqRyi74lOE/S+CNNA4syL2rl4kxa9LCzDDunEnlIVMcCSJCctQDKSQaTGfAFFGPq0pmNuBo80zksRQmpaPFjj7hc993vzbB/6XNEcXJuTu4UgXtuxlpcV9b5Ehh1UWxt8nhdu+/1zV7mnF5p5rQq0GGOHzqVZeC0g5rw0TGvfW31ZKB/vSqNdf50EDiGc0swF1nBI7JgvWi3YUhEfJM2WKaAcKa4RpPri4oOrQjeW9QSwdwljZSDnBgjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoXGj126LCgxbFRXRpkgIVISSxeP/vVG/GMOqDQLheQ=;
 b=PblnF1lhp6Bp/h6VFWxRgDo1REOM+SjoiFiQ/RPxw41V/lc8en1nWOQXOXeH6j9db4c+bMPMosa95acB1eccOwJYjQo/ZhisHx7KORqPBpdd19NuJjhj94jXpME+QSULeAeuA8MMdCK109n0ik1vDdwv6JcejpEYm+sowaPOMjs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by CH4PR22MB5918.namprd22.prod.outlook.com (2603:10b6:610:232::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 23:08:43 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 23:08:43 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: nm@ti.com,
	vigneshr@ti.com,
	kristo@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de,
	w.egorov@phytec.de
Subject: [PATCH 2/4] arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth phy
Date: Thu,  2 May 2024 16:08:27 -0700
Message-Id: <20240502230829.1983678-3-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502230829.1983678-1-nmorrisson@phytec.com>
References: <20240502230829.1983678-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:610:77::19) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|CH4PR22MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 825fcf21-5ec8-49c0-6bdf-08dc6afccfb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|366007|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oa4rS6MQ7yuQE6i1uNvkgLaxTYrakW1ijZNHYBXqye8TdzJF3KWhPzoFyx6u?=
 =?us-ascii?Q?vPmKxbdiW9qS48+Ddx2oCcPKO+Vfgf1fANHHspPDdfFDH2izO8i7zvFu2rOs?=
 =?us-ascii?Q?0kzyQl8ghOfftTK3HrLqsS8gzYy0D+v+pQwmHsSYmBrvLYmUYA0pmTLJN8FZ?=
 =?us-ascii?Q?6Bs+wFeAXhTibtdtgZaPbAfLDej93AXf1SDhy7bnK3SYeyy2N/lpJhWQP+Sm?=
 =?us-ascii?Q?CxCzpXTm3d7PdL9bY4XYASgcJUGPQvvri0DJQPSAaHcsIjX7o1J+qFgWjKgC?=
 =?us-ascii?Q?gJCGamuc86rtIEvDl4lVI3KCXH7DSpMDPTOLijZ5Z42kVpNwUnd59Ejax03M?=
 =?us-ascii?Q?iys3q3rOMRGB2w+Ne1gxdQXXZAFhxnzxTTlkrBTxPyuvcU6nlJZ6bNznBEyi?=
 =?us-ascii?Q?Nqwp6pi0PfcIEDy9FvwI0KJL2S/sxu9BW1NbD2GfXK9/gEUAdQfsE/htqfc0?=
 =?us-ascii?Q?wHHF1upNamszMZO/dO1JtpSvpUvl2cy2h7y/eW8tiwO8MkcF+jzpYBn2VC0Q?=
 =?us-ascii?Q?xrUyxFUbyp1LgG76/X1ZHlXp7Mzaq7szrzGSKc80c/emSS73NdY3PCwRVpFz?=
 =?us-ascii?Q?OJ4H6gAOJjsTaw5YTixhQSwt5Zs9pJNfDWCTPoTcSX2fL7kRaSbn5cm0v/rD?=
 =?us-ascii?Q?+E3dqaDaKrsn72NW2v4qpkRJCLhzIh/ACLHBe0x/1IV/JOr+nKNZYErmriyC?=
 =?us-ascii?Q?i+a4kZozAuhock+3HqyxVBa+slWirvy2CZ/X9yig5m0iod2JsmXxWVaq+9BL?=
 =?us-ascii?Q?MRreG/AcC8oebNPf3KMG259SOQPd20HQWPX/ce99A038hhw/3l/Dt0j1FXXt?=
 =?us-ascii?Q?vXMpqDjhVqMuGQnGFPdNeDr1P7ydyParK8nIIZ023g6nQwTHtOURLPZUPiR9?=
 =?us-ascii?Q?j1Dvf6WO7IIQp5W7J5pPddkTeZ6vqk8duSajmNTHj8z36IG0z+GB4voEtS4p?=
 =?us-ascii?Q?QsJVvmYmT1DMOVmhB5OkRGdwPbrmDos/iH1khxhXD0Fm8wzTbIWLV1QjyEUG?=
 =?us-ascii?Q?g50Gw8YlJPmkxaPVA5PprzMwH2ztUSdrU8lIillGvXLl7qKHvddJXGJV+ovL?=
 =?us-ascii?Q?uwz9+itHBYvT37dwrDA3AnFZ06dK4naEZTSFWz2/WVtVFctKwuekDDUhr6CE?=
 =?us-ascii?Q?/EcJeJhtpnIpaaEt2OR2mACeZgpx6+m+DEQkX7G9hMT+8B1JETYbdwaGyVsH?=
 =?us-ascii?Q?0tkWsdtMnrtHKl3EXos60KGTaxmYUeST6ze61mxrBSdiKvccOOkLWpSnacxo?=
 =?us-ascii?Q?kCF+MfAVhi39BRjixh+39FVL1LpETNasozy2SJ2xZeeYZfsferTHJQbA54Sn?=
 =?us-ascii?Q?Zxx6LIuNY3Tox8eak2gGazmfAjPrOXGz/w5EP/DmsmJXdw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SDrKS3aqmP9QQ+W5F5+8z9DOiLyNeDyiqePmrZlV4NRo868F3VPhguWWGJO7?=
 =?us-ascii?Q?YGsRwk6Xq9mrw5W1G7nHCVCKlt/oSLFccVXGATAnZke1x5Y6t6JXgXeTXZZ8?=
 =?us-ascii?Q?tyJWHeu8uqlZMGOp7S7QAveEtXYKYJSzgsHtZkuQ4oLQA0VPC203ymfGXJ/Z?=
 =?us-ascii?Q?El2FmPosYp9miqSLMqsESBBQ5pGWGRin1wX7d0dDfxSVqcIMBmGBZCPD5BPP?=
 =?us-ascii?Q?UK0QaZ+zonrLKXLB2KlzIgfBfiLAwLo00T4Hrs1TjJS1+klsw+qssyFwT0n5?=
 =?us-ascii?Q?Ik/wEi/754TjUwiq2KGHJb201oENV6sVXFKiMv2Kb75hed1cHSylVSsmwOTN?=
 =?us-ascii?Q?WUb8rY+1TcH+grtwb3QPj+/h6COOfnjQZ/oZ7c5bFD1gTWow6Wmy8uE9oFyR?=
 =?us-ascii?Q?zkweqBjV01bfYTAIJ0uNjpjufbf8v9eiFIKaQdOWLrLW3iXs87f+K/5s4nOF?=
 =?us-ascii?Q?cyCzBQniHCp9QeA2A1KxdOUO3VMHO1dow+aXF546BBNqC77ZKQja5vVzYh/e?=
 =?us-ascii?Q?eRlRjj61unwDirAO03l5nJ3yicWNZfVAAVnHFOVmPg+jnxmW+vMA4Zga0M0/?=
 =?us-ascii?Q?y12t46WOprNoV+4k2C3LSsX3Ouxi0AUrH+zXEHJ2X4Oyl1LprHO7xZfNIuYT?=
 =?us-ascii?Q?kBSTdKsPl26zVxghr9KYO67TW/mbj/eH9s1rpTU8PNhwFamMs7s7B2SFf+Mf?=
 =?us-ascii?Q?qROIqXPLBoSMDhAUwPiEhzAoqkaAAQ5uA+5Uo8pikfriVGKsjdw2gClexelz?=
 =?us-ascii?Q?Fs3xUdWGP/601Y5XCQkZuMJymDFIqq5fxdl9HVZtpMvqdMS+2aq1o000NYuN?=
 =?us-ascii?Q?FBL7UoAgAMbIsV0jRGtyGnYFxQkcVtGctD5Dcv/tAysjhHhy0EX8gChj49TM?=
 =?us-ascii?Q?LN4P07XVzgmNmEutSRCrgBKbsAkI3i4GNI6Re+yFalnkHtP9wYg+sXyTI+tb?=
 =?us-ascii?Q?u2D7nilStf0FWJV1MhzDw1QOGrtNbYnHv8xP2V+v7ddy8AJui+gw0m6zd9OT?=
 =?us-ascii?Q?F9MTIjJ7n4qmkOaa2gYwNlODytw7oiB1ZCfqLWUkpQF2eKZVlFloc47VXk7P?=
 =?us-ascii?Q?t4/EESrdvZerN5xJGyl8s14cfRuEl+xRamdb618A3iy4pc8sndNIDeefQMwz?=
 =?us-ascii?Q?51Pv2hICtv/F+PeVsxEvNev3YwQs2SkYhfPJvyUVoDC7zniHvxb60Ky5DJm2?=
 =?us-ascii?Q?m8m2DQBr2pb2fcbEbJ6A4+X8hAp2LAqA6YfYuEq/7qabD0tWNc1hJyIvvULL?=
 =?us-ascii?Q?3xRSzkWT9FOb4YPp8yp7D78T2eYbtOR0NiDEc8QEMsHtEB83m3DooMB390rc?=
 =?us-ascii?Q?MzkcbgiRbrwikNcfNEBFVVOBD1xNtudVdzjVcw8iksdyltdZ/j10jSx1vCqo?=
 =?us-ascii?Q?w/8yqh7iG39Glj2dD6I5f2cdw623iZR2eK/eya+xqym1X5gf1kRIpv8XSrbd?=
 =?us-ascii?Q?6dzATetP9R6gJw/FFx93sIeiIxgyn6gVSpGdbAYM6OIL2O0MsUh8WDCbl8gV?=
 =?us-ascii?Q?/LIKodtOJ3LnRz2OvBebaEGATHwPUjhgS+M0C1+r2w0w0vV50eyI/wFE63ua?=
 =?us-ascii?Q?FW8PSX4hGFu/g8W2HczOrEAq9064X1EW1qKFymg2?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825fcf21-5ec8-49c0-6bdf-08dc6afccfb8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 23:08:43.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHzKClIM6pXTvvBQTQi0sKH0FY5Wpuh/8v9SM5ol66aBwfi8trLNrUQj0rdovmgotcO99bMzsGPG6Df/ep6XkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR22MB5918

Add an overlay to disable the eth phy for all am6xx-phycore-som
boards.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  3 +++
 .../ti/k3-am6xx-phycore-disable-eth-phy.dtso  | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 9a722c2473fb..030c47b2d7de 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -53,6 +53,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-tqma64xxl-mbax4xxl.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-sdcard.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
 
+# Common overlays for the phyCORE-AM6* family of boards
+dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-eth-phy.dtbo
+
 # Boards with AM65x SoC
 k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb \
 	k3-am654-base-board-rocktech-rk101-panel.dtbo \
diff --git a/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
new file mode 100644
index 000000000000..356c82bbe143
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2023 PHYTEC America, LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
+ *
+ * Copyright (C) 2024 PHYTEC America, LLC
+ * Author: Nathan Morrisson <nmorrisson@phytec.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&cpsw3g_phy1 {
+	status = "disabled";
+};
+
+&cpsw_port1 {
+	status = "disabled";
+};
-- 
2.25.1


