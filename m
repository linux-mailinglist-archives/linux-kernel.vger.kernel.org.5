Return-Path: <linux-kernel+bounces-167038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFB18BA3C3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9550E283009
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895314CDE0;
	Thu,  2 May 2024 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="gMp46qIO"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2103.outbound.protection.outlook.com [40.107.236.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF914206A;
	Thu,  2 May 2024 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691331; cv=fail; b=NcP7u9K/V1BMS8eWWImSxdn20TPf4j87sVT889x/ItKwXWvjV0II6RYW9Koo7bfg0/v+GwAgstKgVGWlV32lNGpafmLAqFKbDHvrT9rpDh0GQeEbTSk+gEBJM9PcN12V49q1xBSzy9+BLdmi4UYAbuhPD3OWPD932O7rfWoKVCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691331; c=relaxed/simple;
	bh=UvkxN4yr3Tllbfb7dFPUGTFiKvdw2lLLBTlLO5y3w1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oemdZxgTE4rcJ8/lK7QkjNGFYdASWLaQO1MBGwjRxAVAfirQTLRjNUzo3mei1LcyQKLFYUqDAilqIKEr/CTetX5lODvp/NdNHY06Q3cfTlmcZJIcB2tFZLaUwHhQdr1cNH+GLV1TNjnLtlBC4w09hrG4RA8iTnGj+QMfSrvsLas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=gMp46qIO; arc=fail smtp.client-ip=40.107.236.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPgqifcnbf+gNbpr6nGkY79bU63jESGq0mvRj58LzVCl284S57l+tHr6qAT994JdSvrOklmf8U1QnX9kjyCpKzX4AMs5rFBszikAOEvf5iDp7m9d4SlHzg5xLGE620T5tiw5NzJHregTaRmILtIUcQbryPxap0UJsaKOf/hgdTmjNdAYCua5p7h1LsoswVoXMWO7YHHOYKudgTRFARpC6H2qhWfw8RmSfgxbuyAXJbv3xc/Umo5mnc2zphVndc5FaGAKA3sZiUJvx6eV57S3CNe9pa0vt5vrugr+gaxLvG3zIKtWcAMr9Og1KlxE/i/7e9ybMHT760tAazBfmR1muw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=od7WQQ75iW3oa619L+pJlT53xCYEGqoDIe/Otw0gg7Y=;
 b=UDxgIlUxmt3OKEOrQdpmbm/51thaFFcSQmA4GB1CT7TfrhyJ05rAkTo5GNKxJtpcCiw8JtMRA9mlNkLCyFOLXSXfYDwI53oN5GYuxMMWovjtpf929OMoiNCZwOYmWvvHxcosZBi4FHADyk44dK9IV6Ap+9PJ494GqgStszQnXFtNTsCroZlV3ZJaEgszxq1Ihlf3WpWrO8dBTKjLvRqEpq40/mYWW0FXNGx67//MmJqPkIHCHrTxFxugZud9lx05Qk/JcSuGiQULvUg9rBV5NrCMKobbFhTBuKB+Q6h35xZgt1W27E36GWEcOguCJ287yVJFEmhynVxTQVbDBoFEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od7WQQ75iW3oa619L+pJlT53xCYEGqoDIe/Otw0gg7Y=;
 b=gMp46qIOrNJDWR62OE8l79gozBrCnny6xEfp0Hcx8JNzAW1tEcwUZg9CLZCJQ0vyYpWCpjBMRuWEf2dZ/CS395KJOFBzxxEo/ygffMzzxrQFEudraQu5WeEjDlWPQcnsYXbfhF/w+zhnw33ze2KMXpoVozxe3own8TGjhmMOSKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by CH4PR22MB5918.namprd22.prod.outlook.com (2603:10b6:610:232::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 23:08:44 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 23:08:44 +0000
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
Subject: [PATCH 3/4] arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
Date: Thu,  2 May 2024 16:08:28 -0700
Message-Id: <20240502230829.1983678-4-nmorrisson@phytec.com>
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
X-MS-Office365-Filtering-Correlation-Id: fced46e7-1bd3-42d8-9ecd-08dc6afcd0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|52116005|366007|1800799015|7416005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tHFeL6xdmuaPPKzcPSLLsPpkXR3sSkx5rOXG2/7dLft944eNpOchu4kAXEO+?=
 =?us-ascii?Q?PRcDnOXqZS1qY+pgoFjTIDSH9Qd9yGybwMtYan+F3B1m4sgGukpOKePWmCXP?=
 =?us-ascii?Q?gNvNCCQQmsNPb7EEvGTl1vAvh+/qbYo1bfvtqfLDiPipFKSazFhb+KPfeHqC?=
 =?us-ascii?Q?9FX5dINm83H6CAwMyjCPICAXn2KrX7uFDjEGq9pHGQjqONvFG/TV971cXb5n?=
 =?us-ascii?Q?Hbg+TniUKGaU0A7vwApEcceJVMzcLMpfjgtzMw80UFMdwpULtHm1KBE/ciHp?=
 =?us-ascii?Q?+kiFHg9SN5AbY7inhdCOqgx4EKgi6JZnu3bXEvxieMMz0teVbQDkNo6zokR4?=
 =?us-ascii?Q?2Dg1Fk/a0rmg0WWqDQc0u0j02TqHDj8b00ilHIUmKbvPc0hFx4JWVq1omtD2?=
 =?us-ascii?Q?1M7R0RP4pp2rLebHvIn+5X39Wr7ArAyY9CumnmNiiS17sju7dPveH2IDNa7P?=
 =?us-ascii?Q?oz2R7Yk4HeB9IiNA1x5doEuDWvfW9Hq4fwgG5h7WPAqvtoyPC6RIn1Dl+DHV?=
 =?us-ascii?Q?3cq0etILJoYxmtnn2QNnrSO5uOWEXVwCJKpy6hsLTy2mx77dsZsrEvHbo7Sq?=
 =?us-ascii?Q?7wIRCyZknF3D1WSVE0JsgdZrdRB1J9aZjIoYWPBTrEDahpadk6iaDZHa59yq?=
 =?us-ascii?Q?USP8/ZtkaiMyYfB/T2k7I6jzi62S6ZBnlamMtQ8lbjbmmrHrg8qa0s7AxfLm?=
 =?us-ascii?Q?hm92rvejYEihB7otmwZfY6apAxxeVnxXsG9rnGlhQQOlSIldd/ATboqpskOU?=
 =?us-ascii?Q?Yi6sps8SjYsjKsRGB3V/RBqET01vNbvTRG5jxgcAXDL8sfFehHj1ROwTrlLc?=
 =?us-ascii?Q?Oie/rvOzJ4eeE5UjllFBoMi8iujidZ++kFtjlE/W03jH4DVy+QFfgv3mYdel?=
 =?us-ascii?Q?XCD9U3dX1Vc6KjRbYmLp2ldTRfHBNzf2BgEXI5hFGAzMvNYsX8uC7VAaBPGP?=
 =?us-ascii?Q?D+0lx8IeOpfYtffYihAXrf27ZZixGiQVwjyp8NHRkOH1k7Ut+KpyZFR7Xr4C?=
 =?us-ascii?Q?0sxBM4p6pUaZCR5c0VCMBlMAjKVYZkJbnA042rJ+mCaCknUQ67E5qmuckVtm?=
 =?us-ascii?Q?K5I/Ey5MaJjMt34OdAGHFCm1psweF6LgD8njetUbn3GNr2jwaohOjAo4Ah5B?=
 =?us-ascii?Q?reAwnK1ZWOgC7DqbarUpmUq+UCI6OfVaYKQyOFO7v3N2yNd28PEbECU6A6Wt?=
 =?us-ascii?Q?hU/Z0iOGNU4W0o10e1LOoe7dZljCFnPSK37Y+tfA8Uy/tGiOYi3XxKUwWdWI?=
 =?us-ascii?Q?q5hwZ5vauAqaoevRNoX92nlZaNhkIXcI3SSnwavBkGrVazosjyCUZyartcYa?=
 =?us-ascii?Q?9TS3yseJvIsRk0pn0K+SFcnSvw97gpEBYXZBj0yt7JL7hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(7416005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GgSvg1VEHuJ2laQx3gR/71zmLK0GIylkmmGqDTijtPK48zXT/ys7I4gbWdZm?=
 =?us-ascii?Q?lXuHLJaV/QX1h5z2EdVI8z/5EI+I2g/bbuJr8k9aFiIDAyYROKbU3xif87vV?=
 =?us-ascii?Q?h5NpOFglfPzPh+/enKH0Yw583MZXyIVPpoQHWJo3+aZ+4U6u+JQeGZXGkg69?=
 =?us-ascii?Q?yXOcI6uruFCH+X2lpQwRSwYYIQWbXZELs7wpm1bUahUmfjesSXhl1PMHxTnD?=
 =?us-ascii?Q?6n2STWgAlUH2urEu1NmCOPwZ4NbMdKFUJAxh/xVQgzHQ9RZFnZWkyuF3rJzT?=
 =?us-ascii?Q?maipcLOj+JMqTYiCFOnyZj3hO5YhFSgjUJcCF49emx74kxp07qREUxd2V+iv?=
 =?us-ascii?Q?LXArN8FTSUPhbX96hKPXiWrgVHj8Zk2TCNiWKkObPH8rVoJY6ChvKdvDuq0W?=
 =?us-ascii?Q?z+NSadBtj/qVg8BP8e79XsXyj+BOjGbGRk5bGiRXMp3R4ofL+DyhcXSl/LAi?=
 =?us-ascii?Q?Any5xseF1b5AatNvBceM2euNfVpH16u5FIozjeBdoMVQIxVI632emcRdeZAf?=
 =?us-ascii?Q?KKA5zuZbmY3YFiSxuf1qEWLPowohiy6/aTZtE0JOBiOVuq5k/zYHl5ZFg44D?=
 =?us-ascii?Q?pUUxwc1v9ae1YZY6WEwhBx8bCeL47dJaZuaQ3vGMpZA459uyQJhPmwpR3b8K?=
 =?us-ascii?Q?n/jplTFb5BxO6h7hl6OY7o5PxDaDnRB03/SeMyv854kHoWv0he++X8xxg5R5?=
 =?us-ascii?Q?gY/qqzVwg0s9xmxY5zYc1bu2PIVDASvLbYQuxfr/hRlQfDy581UEjHFwiBPi?=
 =?us-ascii?Q?aR9G4nXAYaYiRvU1EWkkSN2wvrw98vjKEhbYESpZbIF8Ea1Fiac3RFZRYR0F?=
 =?us-ascii?Q?Bzun3hwamS1NFuNAFFZDawU4I0UvwYQEpei2jFyalunGXn4rqbZDjw1SRWF1?=
 =?us-ascii?Q?aivYt2Ciyt8EStLEAcfUjyaoLnN0gV3W7nlmCnUaD0tXTQ40Nyu8MWSbUyDf?=
 =?us-ascii?Q?ocDQ7BrLE/14JlIbasilWrI/Hxf3xlab/L1w6V+1HomCikpVUKBJVLB1+sgj?=
 =?us-ascii?Q?6Y01tvD2Uws5/RnwuRcsoJI/EbGWBXR1849CqL52y1O7G7ujyTujpTaDwnpU?=
 =?us-ascii?Q?Ut5jl9vkO5oiH+a4JydcD0YmorVZ8QPf/xOvqFdzYvFLP/k9tZ75p5msKCCv?=
 =?us-ascii?Q?mrqrP/s4ROGzjgBsNCVrxv6yKi1ieh9ymnRp6UoP7rPIz3zZnLVvDWxaS0IZ?=
 =?us-ascii?Q?SDtESJkWA45fTp+/dixtyH9vFBupvqfge3qNvY6r7GpZdZdLZJA90aqz5jtJ?=
 =?us-ascii?Q?8ymrt8ngvA3jSGmOhACVPNPdamUK5oWDveFo0635K+Q8WDIijhkqVzTWJRyp?=
 =?us-ascii?Q?5cu2+WdxmO6ZzquV1y2s7Uu8ojHIiVQbrbU65t6C+hFDCqYnnVR7GkwY2B7y?=
 =?us-ascii?Q?JyBLavOE7E+u544NzRel/0w3AWbGSMPDxar58djbekpsz44B07fZCJTYGi6P?=
 =?us-ascii?Q?XU6TN1HyUowCRjw9vsgWSFcXNW+ox/kNAUch4me2Mk/ADkIwUqGYBSCgCwDr?=
 =?us-ascii?Q?LSrX1mQalHVdtdEzkHC5D2eLmexg8UxeW6zUaMEDYwGnwgOCLsvInTbAfp4n?=
 =?us-ascii?Q?hZrw6mTvgcCUOYLvZqtPYzwNzkGBBvpbVeq2Bflt?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fced46e7-1bd3-42d8-9ecd-08dc6afcd0a5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 23:08:44.5692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3jFvtfDTQOsR6283CmqLdek6QWoKHAWRrgmLOcCBa1mt9MaRMAodauGzvl0EgaNaoyUnfk5L1CrgytLLpSMCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR22MB5918

Add an overlay to disable the rtc for all am6xx-phycore-som boards.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 arch/arm64/boot/dts/ti/Makefile                   |  1 +
 .../boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 030c47b2d7de..83a108eb4a3d 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -55,6 +55,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am64-tqma64xxl-mbax4xxl-wlan.dtbo
 
 # Common overlays for the phyCORE-AM6* family of boards
 dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-eth-phy.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am6xx-phycore-disable-rtc.dtbo
 
 # Boards with AM65x SoC
 k3-am654-gp-evm-dtbs := k3-am654-base-board.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso
new file mode 100644
index 000000000000..8b24191f5948
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso
@@ -0,0 +1,15 @@
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
+&i2c_som_rtc {
+	status = "disabled";
+};
-- 
2.25.1


