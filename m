Return-Path: <linux-kernel+bounces-31168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C9A832A06
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3A01F23B10
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FAD5465D;
	Fri, 19 Jan 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IAnCq3Lp"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8053E17;
	Fri, 19 Jan 2024 13:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669366; cv=fail; b=e/97jzejxINrDfz1TQ/Q8LhNhHLg2+yCLHvvWDFitRbDucp7pZHaPCM4nP7H2yJHGuE4nbrkie7P/0A/dGtxefJd+0/+B5kvAAUmPnvsebZHduW+58Z2I52wrd1qi41RkQF083jxAzgbolwADEp+jXkJxBo0XCRUi96O6z0v9Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669366; c=relaxed/simple;
	bh=y7Xz3tauJFuqjikl2phkNiewg/3APSJHkSF0hq+8fDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kGsFrlZsBAYEZ4IFIgoexrltsc4fWAB52oMqeMU71dqQJ2jQ1BYhdkPOQZKRT9fa2DTPDFxxi+fjyAEUWOspUQ+HAo/P8Jd9GnTPDdLGBpha/kRUu1fZ6bCQNzv/smBeFUNFNCenjI5DGl89a7bP5a91taaFw23KApVUiBxlHL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=IAnCq3Lp; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8rlLMfM/wgmRzHPOhodTglSqCRDONEF7C+fOTvrxrD/LuFKHq/CEcySfdq/lVUMoCPEnHu0HgqiDFTmwqyftSGBTZP6OCM9JHd0IBgLnXoV2CLYzayadPL3k8gDgf/j/36MNH7t9CezjxHT859oLc6/4Z2ZiKJYZJkrRl60M+jlURBMfffWanwQ9VmOH63JcsdT9BiTElX7UwlrNLy2HfIuMQHjGoEO85OXlQoZTZYfD9m58y40D9l/7AR7RigwPa9V3AINU2LAGF9HDFXyVTHZoLwRgf6oCWyvwgKBHP3ziDeVbxmCJJSYwhVT2gbUsrRIgAe5GUk3p63pJErUgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxFqvFcHvQYAv8nvDtu1fHZfgSLuko27eWl37SDtius=;
 b=Tq6RLQDs16R/+P2cQcGAVkNOKbkKkvvzBAPAqtnTLD4IH0DHIozolG+LVyoLN0/KPDJXrPsbnSfrfHU6gDaBT/mEG+3DtKjnOt5X7N+Vc/ttGxBAc/uyACgTWcY2029OKJtLHTA9dvElPm3qasAcM5Pd7k33LduxH9codRYLtqGCbMzPbAtuSlXsZtW+Q3PYPJP59tXm3iG6NeLnt6U9VLwL3BioliNzAc7pjNfgGo2Og0QxhdmZN5ikt//JtXikEgmQAjlYjeekb5FpYcAC9HOrM2WqwZx/1ROllw6gYdSbk3vh2NqkPMYOx7ytvINIkuAAulsGlbvbzit7Ni2w6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxFqvFcHvQYAv8nvDtu1fHZfgSLuko27eWl37SDtius=;
 b=IAnCq3LpBl1j6zZ4VTE2v98dGJQZlWtPNJNMXFblwOqmIDRcFrUCiC9vdgLGM+ohVTputfmxazfHHfycipAKMH/mrOI0VKBbM3JaPuXjSawo2tLGFL0S2763KnW0lkuVsMReqHY9wofEg6nUPvUqBXta+mc6rN0TiMWX9Cjuib0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 13:02:40 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::9398:2b64:8350:3ace]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::9398:2b64:8350:3ace%7]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 13:02:40 +0000
From: "Ghennadi Procopciuc (OSS)" <ghennadi.procopciuc@oss.nxp.com>
To: Chester Lin <chester62515@gmail.com>,
	Andreas Farber <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	ghennadi.procopciuc@oss.nxp.com
Cc: NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Catalin Udma <catalin-dan.udma@nxp.com>
Subject: [PATCH 2/3] arm64: dts: s32g: add SCMI firmware node
Date: Fri, 19 Jan 2024 15:02:29 +0200
Message-ID: <20240119130231.2854146-3-ghennadi.procopciuc@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119130231.2854146-1-ghennadi.procopciuc@oss.nxp.com>
References: <20240119130231.2854146-1-ghennadi.procopciuc@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::37) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|DU2PR04MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 725168e3-c79e-407f-f7dd-08dc18eeeaaf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2Ol+Uss7BlNGckRD/uSLxwe0oLhhJADtKLnOhSy1uN4Or04zlNUkCO8clnKngDtM85zCKsedKVq3cANXJ/Vx7hZFDtsomsck7FILTgwlllfHF/av9c0deHpHioS9hFUMXnyCBW0noHDd63cUdOSJVe59Bp31+1DAqOg47UiL4f/d5MDqVlUxnwRmFlUQArAPZDPBeC2O6SbaMKoQXqGEbPQpT7VSPjrw9rHbgCSOv2tFawwPtTzxsKPCzYc/kI71jc5zSfB8XVSY2grY4WkxFViYZa7S9elYyhWmzwvNxd32tYGsfX865BnM6rQyJ+V98OHedKSWDbN+Yy+iJoTWw4MP7BeecOJjLAF0dzoT1x6/Swa1m4tEIKjnnR53MRKcG3YSpxbC5rvkvJftcvmxx81yGVHxKHUnspHhTLXT3FtHHVK61fid36gYhkmd280oswSmov8wBsN0IF0QD4P3joJ2snV8tPnx3EP6TGtbpQOjJLzxIdwOvIj6c9HlI7tyXosgjDe2nmnsLrJ8hudir1z04IuRJ7crRu43g3nesRf/tUKhz9JJOhRfvcmh1/C9A7Eb1Q82nHLwmerjk5GzKY0q9G9vpAa7e3r/xcrVbXo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(366004)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(6506007)(6666004)(6512007)(1076003)(26005)(2616005)(38100700002)(86362001)(8676002)(6486002)(2906002)(83380400001)(41300700001)(4326008)(110136005)(5660300002)(921011)(8936002)(478600001)(7416002)(66946007)(66556008)(66476007)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MIZ/NDIAgrs2Aw0Hdi22xaZX6hMs5dZuEfmlP3bVYvGQUWwdHyJkLR3HQVw5?=
 =?us-ascii?Q?OZ564Epe7ca63wRKVf7dGywHaw+HL327sz/I1SGtpPKZnRKvqXPb+p3iEEE2?=
 =?us-ascii?Q?QStnyESev13uBNRfbHtbHNqHkwvkyYIcqBR2jFD3tOfZDmZFrzFjI5198AeX?=
 =?us-ascii?Q?eWZA0D2ydIY9BY8GzmKAvZ3X4M7FSwXQqzU4Vxx5+NeiEAADyazjyslKm57t?=
 =?us-ascii?Q?UdmA5Q+oWO6tNukERh+cbN4ANBUUQHwCFspgZTLFI61zYy4lllLN41uNc/Yh?=
 =?us-ascii?Q?NlkFqLSrW2XcmhotItRJqXuySqQVwbX7RopyvyNB9mWZVV03m2L41K2BswX5?=
 =?us-ascii?Q?eNAWY3We3Su9eU+Ffh82ddC95/QL7AGMNd4n09RlYaCGD71qkO9t5PxuBdBE?=
 =?us-ascii?Q?6XVtuuwutnf4geQtajpgKr2hfVYpTHd1VOVFKOYwqJB4r4xZqjOgXPcroUPr?=
 =?us-ascii?Q?QYLHLuZAUp2oeKDgGcpKncWbzYt76PHUU4nvuMWDaZfKzEA9IuSgRH4vgE42?=
 =?us-ascii?Q?3R5DNquPhaEyCYVOtVwkTaDOQJetBYa45AU2TPJNhb8xZnMwmeR05MBCjyQ9?=
 =?us-ascii?Q?zHoxmv7sd4y8EY4oZ0ALtPvp+jbGD8T4R0xd/VwpE6KByYy25n6q2TPaW8DD?=
 =?us-ascii?Q?WbfGnurjK7845jxzjbBLHo/j7mAsR0Acj0pSv7bhJzAh5HMvNuO5x+YboBcB?=
 =?us-ascii?Q?kMxGszCJ0TURdxL5sukYWfspKS9o8NAfAujzDkOKvQy0WOdY6xJ1Neh4OTZF?=
 =?us-ascii?Q?5+Bs8NkaC3rmKC/LRVpjVOj8ygUGFas8YonBI/2dV/dcaEcOVmaGmZt5gG14?=
 =?us-ascii?Q?vNq7TdLIi4BfPXPAQDXbAvqHWW+r/VezwITb3rdFkLsjx5EL8HPwgeTW5Xpe?=
 =?us-ascii?Q?bA3NFPcSvOyeyrap82ZXAyjwEfNFraNah7Ytpwlz+VHc4DBqGYDXtee++rFG?=
 =?us-ascii?Q?0yGvzxtvI1Y5DthZ5r1j7wyWIIIF+AgxalF/GZkFt3mIKhL4pmcB6xJJlWJ3?=
 =?us-ascii?Q?n5lXyduZtFnLX7yjr33vpmC1UOGaSeVNWrr4kNPHXHqR6AewNkq/HWPCMiZJ?=
 =?us-ascii?Q?UJ1Vg52DwtEvHR5MzPBCMTWdBiYmWeTzRbLLeb07u/xpe4lH5FM4I6hQA+fW?=
 =?us-ascii?Q?y1Gz/M1AbeD4ju51rm29lHOcS0EFBhy5GIlW03h6bVJ+ByyV0agQ1XMpyNFB?=
 =?us-ascii?Q?YSLdFYq01FHOUwFaMLLk4GMJWqcvGRJMr2gkc/crKHrCXzLWMliE+vFMYwCt?=
 =?us-ascii?Q?fjVgns00JD3X/o5WPiFAmXMmdwYBQXtCwPN32Nqwv++L6UMIU1uf6O/5B1hd?=
 =?us-ascii?Q?OSZXGxMKtHWg+xxerbIkFmNdfjeq8WAv5TluDwvTlh+GJFX15IyMeXpPIpjl?=
 =?us-ascii?Q?rTWIUEdKGJPzTOsEqIB2TbFfpy5Ma1aglFYefK1SgG7lDbk+JbrGQpQzjvkN?=
 =?us-ascii?Q?qlnTOKkhXVoXXdLBwtE6sQ2hLEeRzGIk1O6HoMZLl6c9PkEoA7v5HGW2/9b9?=
 =?us-ascii?Q?j8p7WNLlQt6r+Pbzo70Qyd667kNV17nkYB+1nzIknL6Fbo7NgBeVuVH38zRM?=
 =?us-ascii?Q?zHdTn4lGOM+C5jeJbugX+BWGGspdHoFh3bz6E4H2yV29CwMAjxtgard0Sf7L?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725168e3-c79e-407f-f7dd-08dc18eeeaaf
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 13:02:40.4501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X66e5O0EIR2SbTJcwEakN2KX4VAeIeOtj8Co9gSeRebPcwvfrZ4iKDEhxVIp9j477DdeTjvw78jki2bcDmMeEgiKbgUPjRA5VD2PZLZWvls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8951

From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>

Linux controls the clocks over SCMI on S32G SoCs. Therefore,
add the SCMI device tree node and the reserved region for SCMI
messages.

Signed-off-by: Catalin Udma <catalin-dan.udma@nxp.com>
Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 28 +++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 5ac1cc9ff50e..bbb5e979ba93 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -3,10 +3,11 @@
  * NXP S32G2 SoC family
  *
  * Copyright (c) 2021 SUSE LLC
- * Copyright (c) 2017-2021 NXP
+ * Copyright 2017-2021, 2024 NXP
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/s32g-scmi-clock.h>
 
 / {
 	compatible = "nxp,s32g2";
@@ -14,6 +15,18 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	reserved-memory  {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scmi_buf: shm@d0000000 {
+			compatible = "arm,scmi-shmem";
+			reg = <0x0 0xd0000000 0x0 0x80>;
+			no-map;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -77,6 +90,19 @@ timer {
 	};
 
 	firmware {
+		scmi {
+			compatible = "arm,scmi-smc";
+			arm,smc-id = <0xc20000fe>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			shmem = <&scmi_buf>;
+
+			clks: protocol@14 {
+				reg = <0x14>;
+				#clock-cells = <1>;
+			};
+		};
+
 		psci {
 			compatible = "arm,psci-1.0";
 			method = "smc";
-- 
2.43.0


