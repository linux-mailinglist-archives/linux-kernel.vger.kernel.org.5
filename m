Return-Path: <linux-kernel+bounces-33139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836C0836517
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D05E28A7D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6709F3D981;
	Mon, 22 Jan 2024 14:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UwgLpneQ"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2082.outbound.protection.outlook.com [40.107.15.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DFF3D549;
	Mon, 22 Jan 2024 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705932386; cv=fail; b=cW+ERNwao+4UR101PQvPjGKvsxqrfSAYsWzc3sjAiZbU9TMX2y6FpdjdodD7IL5cN4uMZ2Ucj8J3EIx3Qn0cNdBHVqsF+vGdMiRt5WgkreTbF1QmT02BltnLhbg+jox8QHPJNccdKdhC1ogXtLyVgDguwr4sag3KntyBAP6umGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705932386; c=relaxed/simple;
	bh=sGBU0K3HePQw36RfS6U7HPUJhykZxMp/i3dadPX40Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kbp9USe5LRLQ9IVnbZzrKrEad1a23WErEgrqEJuGOD9fYP1kldo7UdtU2udJ/qe0zv0T6ehBm1HkyGBc9PJU0XcY5K1jT5YxoO02ZcCEUN54eT4XG/yi93vzqlp5vzQ8xSq33dsOabeZSV0pnXPNXepzKMIYxNBYJmKnt2Qbg4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=UwgLpneQ; arc=fail smtp.client-ip=40.107.15.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9htmxVDGXfI43m7xRVGtUWVV9b5NQKPhdZKx8KxOzaQb61HQhEURDJzVAiBP8A9tGxIbCJffFeMQ9n2oTpxdtGbfVuXhCpcLYy7bc1sCG1fwWf7TaEvLpESyF58CmviNIDlleDYWLwUxWPV6ha5TJGeeYvALepdD2r1XWStjA3RqAVzkvYIkOjqQ+XH3H2B7ZDHYRJRqr0JhO9oTj4WV7JpC8F1c9dva6knGfjvk40Y9kzgZTdXyulKLIA1Yg69FXL+Q3tUSx2V2ke3nkPc6edMF6/U6qHGIdHc5Gnuqwr15KPCKgkCtzrYfx2JXVam6DE4GvpfJKDkCVyOCmDVcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLGY3CEeZ95A3cvRWlQoLVkz0Jw2+YffZ/FS0N+GIFw=;
 b=H9sBQHATeb6oo71PXIWBqRMc36lZBJQ0qjKhK0AJSM08do4BXodppPvj/z01o6Uei4ZVOZ0tP7NPt0PhMbqNClLyS8yQaGp7Xz36BkjNqworUca9H3SrtGfNX3I0pOdfJI5WalOpU0VA5F9KhdQLiB/E1r2RcAuf5WyQt7AmRwsadei/WY1g+FFlvdoj3dcrRqmlgVysO0TYMMLnfj0NX8ukN1yr1B6AgDrCc7qOhi85YTb3x/QenV+Z5xlDOyAwvn3Zh+9u94+bl7rFqbhdZNg8uAF7Xf8LcaY2OZpgxL1j0IM00Cwo/pfcGTWnSeAwB+OR3vbcr+Eev+tNdfHULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLGY3CEeZ95A3cvRWlQoLVkz0Jw2+YffZ/FS0N+GIFw=;
 b=UwgLpneQmB258JylS0N8m+C9J9Ujs0H7Svl3BIwBuz8C72D/5s8uZv6hVT3pScS4NIP1DRpQTmTVOMtvJS9UKHZYObw6UJeqtbXZozzJ4HBg2yqJUp7WBHcDEn/1Kv6HCcmfe2ZUpXgRiUab0y5xBg5ovnVQqCp00QljGtbV2QY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by AM9PR04MB7635.eurprd04.prod.outlook.com (2603:10a6:20b:285::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 14:06:21 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 14:06:21 +0000
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
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
Subject: [PATCH v2 1/2] arm64: dts: s32g: add SCMI firmware node
Date: Mon, 22 Jan 2024 16:06:00 +0200
Message-ID: <20240122140602.1006813-2-ghennadi.procopciuc@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122140602.1006813-1-ghennadi.procopciuc@oss.nxp.com>
References: <20240122140602.1006813-1-ghennadi.procopciuc@oss.nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0294.eurprd07.prod.outlook.com
 (2603:10a6:800:130::22) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|AM9PR04MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 5575c1b6-bbb9-4f20-9f4b-08dc1b534f5b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	p8cwq85LqbS8iMwCpzZOGxwAFDkyee6LGC67WWJJzLfqtjT2w+ZCn2aEP5dltui6Yx0Et+RccQGly4bhvC5ngLdxFWVtg2Asp9BHzNeYNoEH7aMRZI1Fi5rYOmBWJBClCkK1mnrVw7b6SkzeADq/+9ibpxX0Siz0Ei6S0Z2LLDjTmJA3cLxSemFuoJwmrWayDgf4JT3JUGM03ibxaSSzfNmPoibvlesGhjMHhZ/rMBoIVH7LRfMn8QltP9O3WDj5qG9Xim8/9GIVp6Xj60nSJNtEn+TbfR9Ci54TVpF/tW9vpuhQJmh2R9x4NixjnOgpiDSneKTLMzJO3BILc1Q/NbPuSeiGIPY3Coi5nPq9e0/yxpPo/2e6MeZcpYa+vPrt2akpzMkQHJeMOAjfWKVNqYGmC+B6vsZQog8NCEpxtKAXw8j/K3LHF2Z8z7nli8BiQbRH4N0aVbd2kubi0kUqmT1WRtQWgpFEpz1cV6saYX9/3C2089y0Uw16/O11fzE4bC9xRO1zBTmIiRXZzJS3BYxbAcCtdH88T8uO9jk3hgOauw6uvUkJDIlBTbVabToBo9nO5lu9YwSvCavbD3dURBx3CbY9DZsVaRfrN1Sjxxf4p6UvrCMn9fZGGkqZsmsLelExOOqyqqKXkENUezIFhQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38350700005)(921011)(2906002)(66476007)(54906003)(66946007)(66556008)(26005)(6486002)(6666004)(6506007)(110136005)(478600001)(52116002)(316002)(4326008)(8936002)(8676002)(6512007)(7416002)(5660300002)(1076003)(44832011)(2616005)(83380400001)(38100700002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7axplFPevzsInJWY5dConZQm4f5H1ltMYHFeXuifMVPJRg9iSNE4VbsqUm63?=
 =?us-ascii?Q?mpbezZpM7g9Cxgw6d6lSIZ6oCGbfrVoO4dNYjTupwzfU2I/+2tnAk3omKIl6?=
 =?us-ascii?Q?vQEP91U4e/odBbHMlJHrGk06k0RnafPSgIweEcyZq+rlLvsAFd3jl/Z8xeYB?=
 =?us-ascii?Q?LmGuL0T6v5frldyFLncW0qI7efRymz0WX2G8jpyPXFNAq7/8h2UGjTdMpIr/?=
 =?us-ascii?Q?BmOyOVD3VXjiHEf8cbMz1DnayXsWw/puwAf53EKmX7ZfOxNSeIcfDj8qMual?=
 =?us-ascii?Q?JJq7ZvWc+9lRBfUogLZzBbQkq4byX6KQWFBtJqRcSqHVN5V4rm2yBLyf4fKc?=
 =?us-ascii?Q?88F58hs1FR1+ZoRII4Fq6fRk9bCCZ5e8NfAVERn+4oTEcdfHxnaQSQook3ve?=
 =?us-ascii?Q?UggxV9eCGWNmYB5ztHmeKEDOM0tNpVjWem0T0b9GXUE6f7ZCUnI8xQjwoxXQ?=
 =?us-ascii?Q?MaDgOqYjwRkoJcnbEkLonHiau2wZJjdOVOYBXW4HiUOYxm4jzv534UuPb8p0?=
 =?us-ascii?Q?qKsp/1pmEG0EyvuPec6WZvRfucT1Nz6GBVTv62Efa7KfAu3oijCpWnVsYAEI?=
 =?us-ascii?Q?QKtGLbfDx6ZiuitFdiln1WVydOz7mUBnMxpPuCe5qeBRaXyMD5AUlQaHUqma?=
 =?us-ascii?Q?BfBHhgXNdPjBI9OzwQeBAcGsODPZ1ibqEgw3KNUwI0fDW0TwuZOC7kll3R1q?=
 =?us-ascii?Q?B70G9uJZpk5dcMrmPxyn5aAv9hq3CTHXzGpW+W8nw1N8MWb2txUAJQAKRDuk?=
 =?us-ascii?Q?kPF3+cMe/84mYvPuYnjC5jPH/eDWPFMP2ayDQ8wS6se4zrxIPVmBPFyd6krU?=
 =?us-ascii?Q?17JmZ6MYp0Oequ4b2pOKrRyi/1SpIphEGX9elzaX7c18PbolVzgEYYoQMRQR?=
 =?us-ascii?Q?rirRwokC6iHv6J1TykYtWG+Yv4boIBucETq+Yh4jHz8kTPTnpLeEa4jrSOHv?=
 =?us-ascii?Q?Koyzw/0MHmLIswua0OqXIcYZVVBOav85m6fH3d638a/3GVtM9XQMROn611gf?=
 =?us-ascii?Q?KOo/LMepnrSz3jqzvdjo3KHYEZCoFqRBAMDK1FyGwrOP/gPFoTW8VVbU/ujq?=
 =?us-ascii?Q?Th/ZwdfT8XHyRkiboPxa/l7fZ+Sos1wRtBSOUpKikz4Fd8Xz59XZwPZptwu9?=
 =?us-ascii?Q?Io7awXWRywzMB2O/YyOR2Dj1+KCaxBa7H+ASHlVCXnweypxVeZZAIPtcq78G?=
 =?us-ascii?Q?pKs0Xk3tmQ7ZUEXIjwyBimO4eLW+tucFG7CZFVcvxAYfsnpBy7N0S9qyrN74?=
 =?us-ascii?Q?b0jiKUFC1UM6nCsc+egSzuLYGqJq7cFYCjgC7MprS6kpMK2feJJV0HSl1ygH?=
 =?us-ascii?Q?ElozauEuYMtnNVhQKEPJM+7bEfCdY6un6s5M2/9MokuRg1GtUqBUKaUvYEzZ?=
 =?us-ascii?Q?M/BphG4oFLYDE2LDsmMv/zFIsnVoREvcTIAy5gcA8+/LTRA8Geso+24IpL9j?=
 =?us-ascii?Q?lVYqoZKLxOY7WKgU26PwgxsDvr6J5z3jsaANqknljsL0VLOkVDdN5s4xwQId?=
 =?us-ascii?Q?/0QfAQ+MgSUYhfqxQnz9goyO7yUnl6FsbwccKTEhKVaEeK34T0duH+9lczBZ?=
 =?us-ascii?Q?xivXxJrnAmiUDVnL6q9RCBoN8407qlrUSblHI2iolZ9N4HTmBjbvuPP+ih0A?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5575c1b6-bbb9-4f20-9f4b-08dc1b534f5b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:06:20.9924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vEVWKNFcBC1wqdcyws0oALNy+HYJEpxEuW6M46ysT9NYpIDjTLr0EZBerxZr44fPylO6KSurBdCZ4lxHvhYv++g/9NTg46NKBmauNGAXMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7635

From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>

Linux controls the clocks over SCMI on S32G SoCs. Therefore,
add the SCMI device tree node and the reserved region for SCMI
messages.

Signed-off-by: Catalin Udma <catalin-dan.udma@nxp.com>
Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
---
 arch/arm64/boot/dts/freescale/s32g2.dtsi | 27 +++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
index 5ac1cc9ff50e..ef1a1d61f2ba 100644
--- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
+++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
@@ -3,7 +3,7 @@
  * NXP S32G2 SoC family
  *
  * Copyright (c) 2021 SUSE LLC
- * Copyright (c) 2017-2021 NXP
+ * Copyright 2017-2021, 2024 NXP
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -14,6 +14,18 @@ / {
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
@@ -77,6 +89,19 @@ timer {
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


