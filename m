Return-Path: <linux-kernel+bounces-55715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDAD84C0B9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD2F1F25370
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630CC1CD13;
	Tue,  6 Feb 2024 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rG3HuoVC"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD71C69E;
	Tue,  6 Feb 2024 23:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261339; cv=fail; b=izgVLfySh6tt/2SpbtOGwgkTHZmJwGmc7NngD+xSea/PJ2B1Mk5ImTgKZmAA9XUZtUjorm8MEM/iAF3URz+2ouTV5AY/PuLeo9m93qVTWQxHVMYPr7M4CSqWLBuyI6kAXW4Px4QKjJX8AeZokdUUHYubyA2n7c1kwQO+fcfPUNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261339; c=relaxed/simple;
	bh=ekdZtquM5ZvkaTP42Nr1xIUNCdxJritmhLrvLhC5gvI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fm2oAvVMaMOSErG7bV2aabcjIPsOpZoEgq4nOJGdgJvE+nJ+B1Qns8ASicximw4WAd5THD/AHYld0/zT8fi0j9y8UU8TzW/B5u6PVsi54sDrgeMK7L+GPMCZwRiBcLFv9tDIEir+93QWfh8gGtW9x6axUp1Eqo9AqPtlUF+J+TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rG3HuoVC; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAolQ2qTP5J37bndKtkIW2UQbcS/s0A/ftBmllUaTOJCoICmLNnR0XojuD/ehEWembORS+gy4iDu2Z59W8MwaTi1vMD79GAvvNIU3HmGAAUx6v3f/tRH+vEfHGxoRBeFrN4LR9HkdW0an/Ar6cNZN2myC/0lYufi6CNV3KVpdivYvGUmr00udfwxtwePRSu0OKnUCactI91JOdXdV1YmV0qHCeVMbRvaKRTwLuhTd675RqOZ+0ZtIneTY8N7CZFME/A+eTgzdWzU0Umnvg99VKPjOb74fmj0o5YBojBRiCfbAQWtOGZ1WzMUXR7PbkpydLrYkkB27qACT4b5qc47OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqyQHHISHEqH1KQUqGOijkZx83gPcuKZ+HpLzFTm020=;
 b=MO6fLEjZrf3aKCiIupAZRhS8DYWVgHQCcFsUNhHcMFwookPvaIvV0oh9uvLFHbqTRIfJO95hCqMioNccgbybQjVHQE/bvpmYfQgFP/wuRgWzW0Gahxfzx2nW1W3KdRwbWszEPVu4m33Lq/QcyYXOUVDPT1TZpyKEnW17QnZ89EKUSp9d3VPQUumCHxLmpS6sgbm7NbkePT4ZZC8R3mVBWBTl9AU0r4y3YjCRlGY2LKdXyMG8mKbFsNwpxbuyLV1tzJQmCUjmOPh3rAUiOO4Ka1AjokRseEm4uI8lRohECM+y+ydORdwaSSB6G2LxiTszNHZ6KocGWsg1wzgCB9RgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqyQHHISHEqH1KQUqGOijkZx83gPcuKZ+HpLzFTm020=;
 b=rG3HuoVCHspLlGB+0OF5N/Jct/3kCyMhEMqwHqBMjVwfEDpj1GiHDZyBTAdBpCJAgmsF53zNHop40qcbduqMEVjaFEzTXOF6H28PnWo4/EhB/583rVj3KW+zItggKvjASpmhB9Ve1/bVbIRn5qQwax4L5F0KYjbpQbOpRY09gnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8406.eurprd04.prod.outlook.com (2603:10a6:102:1c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 23:15:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 23:15:34 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] arm64: dts: lx2160a: Fix DTS for full PL011 UART
Date: Tue,  6 Feb 2024 18:15:21 -0500
Message-Id: <20240206231521.3600089-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8406:EE_
X-MS-Office365-Filtering-Correlation-Id: af78b347-99ae-45df-0ff1-08dc2769852a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4g9oXJpZYezdwSL+N4jquQwJni5aJxQ0ODNJJJnZk1wBUr5DYKWqUjawpnZ+LJj73Q2W2rLzREblWUUkPibUvGqyRXttXUCYX26yP7ddtE0g1hdUGc9ByljAFOTyTO5cXrSaN1euLKR3bEsMLNOXS6lzfR7k0Q7THn6/yV+dNGxd2OTytTsOe/6F4Tscvw3+JJxwJvaSwjXJBGJxux1NNIyb4etePKBEbnn5kHP+aSFTee6E+XMhjjmyFONHkeiOZr2k1m2XqEK6uGYyIoPtX6JMA4yHQZ0kJ8hmfOcgrdMvW9X8+tsSrdeZEEUt3CRLHl5VIhlQylyyd8+aN+fErlFn7ykMr6eWhn1aGd6qyq+gqcI800Xuv+gVQTsbre2gm/939b7gEepAgJpBTXeQPaOo724Ez2VJNzoCUWfdhGyd0q0UkZFkpGx2P1LyyFwxy0kZsesja91zdPwvClnobiDa4RCkCDatp/PhMeG58PoOBeLFxmR6lVYVLDkt7XIoB25FRkWeSSD/m/Fqz5f1K86Cv61krHKTqoqsjRLpt+s9KeV2eqt3WzIoMag5qc5I7TgNvhgs7TMpVgebFWjDnp5ZC1eD0dqTyOEHvj5tLCJ64FZ+RUFRg0zrJr3NKd4h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(86362001)(8936002)(4326008)(8676002)(478600001)(36756003)(2616005)(6486002)(6506007)(52116002)(6512007)(6666004)(5660300002)(1076003)(110136005)(26005)(66556008)(66946007)(66476007)(316002)(38350700005)(2906002)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b/E58oGz1cwpbePPt7zSxEoY73pe7eHhD4V8uI6C17jP9gLVZ3CZo/KlFrEb?=
 =?us-ascii?Q?vz/O/6GTIjqVFyjOqupX3nR0piEbqe4seTrbnszUsdOKzghGnkb9oy35sAM6?=
 =?us-ascii?Q?nLrBQueNJIAlRKN3vvW0My9CRvGPtswdW+s+3FqcNasDHO482M6/fXNcHt9r?=
 =?us-ascii?Q?zg4AXhqxjZSWEyPmI8A3uW6GuSh3JFR/I/QOcnRCt7zkPkl8KY7mnjE5wm5I?=
 =?us-ascii?Q?l9Bl8RQcFseqa4owKgMxlEiTBF4Bm1irEs1P8ku4nhb2KyaD68tJIcawFdsu?=
 =?us-ascii?Q?Q2NQbG0lr+MRN5oyHwYobv3NIWOelmsa/AJ0hSrxIDHgRnEkfT6i3WqAYksX?=
 =?us-ascii?Q?Ybnd207AkII57omqtFfY2td11MPgcmzihB33UfU0fFfHYtHt5BaH/EgSeyP8?=
 =?us-ascii?Q?7bZDQxgtxz1d63ATc7TgRE2L6MlP4SEjjNpeQlsURt0g9P1ESoV2HsAMjxhN?=
 =?us-ascii?Q?O2SbTVa6jXgNXoZExc9CIpBmM3VZ5Rb9UPsbgUqIaWsOyr2uYbj+67kwLzP6?=
 =?us-ascii?Q?jxjardNZiAeRUTvrmPdwOyK0EngqQCkjU3omOikUBEYR4g9XtaySfvi4qyoh?=
 =?us-ascii?Q?caaI2LCtjpdVEERDKnh9ZpVEiaPPOnXdbTl0YV+k37ZBAoPY3q6SXvyJCIWQ?=
 =?us-ascii?Q?9RNMBQa3Mazr9HEkbVv4gPKqOdyLR6cdw8akDn/J1DygNIsINSbAbjg3mzLT?=
 =?us-ascii?Q?bRPFYpJgE/g3BPhsS0iuKLCzYMFEf4L0V8drhphy3pm3hrQkqOt1Ce1KmgmZ?=
 =?us-ascii?Q?6W37wUJOK0erZa/Wp3469Mjh4eiyzHRymVSWsnYVJZu+Vbs8RAC1z85RtKaD?=
 =?us-ascii?Q?a3dtQmJdfSI3dZ5S4ivGTVv5YMlUFAJYBp+RNKg5+txpnPtk4w7oFpcbHaoz?=
 =?us-ascii?Q?zkZyX7kFYwE/v56uGOP75n2h03MeY7tbipccTvuLN0mP1BlgvNQuRH9eDdZk?=
 =?us-ascii?Q?nDMucdAmHK/Hxg8Sc65GmdiC/S8Ad6Xn02R8NT5yGTao+5hvsHaLhhvEvCH3?=
 =?us-ascii?Q?7A7pVZH1VYG1c/dxJgdndjFyOuSpAfZRqyxA4A+Y9QuRsumyjowYNgObql1c?=
 =?us-ascii?Q?EOfyJ/8aWqefnx1xRJe/mKa25MNeH0BigIbxxtsi2OgisrHPbNIWldheNAzi?=
 =?us-ascii?Q?JAuT2CBRQk+cRJvUkXpU9GII2q9h/h/wsXZl439Mi2aytWmh/z8bOzTK3XbF?=
 =?us-ascii?Q?o49L2sADRyLglsmEf+v45SXeBRGFm7ZquaMyr93ulA0Y7HDZY1KPo+6xWKzQ?=
 =?us-ascii?Q?VdbpWyt4EuDDszhj81EyCw2xsAt4Oel93hqsvABcvMRcDCF4oY6MmlfKuJJa?=
 =?us-ascii?Q?Rk/EuhRitp2rQittj3EjcPMnOK5lmYwfJDvQESjI2mWLXqhq2PUVInuUQWrw?=
 =?us-ascii?Q?dChT6yr0DDab7w7FDEFV2vj+13PTR+4CpTLkRn75zHslIFfpQdXy9eVtOn8C?=
 =?us-ascii?Q?qqeSbSdS7mgyGdOkBE91IkGuLEQpRfEJ20kv0rVrFM8Xqx1qc4hjfrFTtYOg?=
 =?us-ascii?Q?ztfbOaltCDMrbkqW2Xnup9wv00fx1f2QgAeXXL+70gbPC9Bl5WvrNJXusdP+?=
 =?us-ascii?Q?+tW+BUI/yCvPghZEw/khDD8PiJtqiVD5zuvUjIYs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af78b347-99ae-45df-0ff1-08dc2769852a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 23:15:34.0498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9uQJXBu8Xo5PwEwdK1DBWsKp4Z6utoU5vQEnOn/Vl5dWhGZT+7tDgifvD0HQ8ealR4TMsHKkNkHAjY3KxkyaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8406

From: Heinz Wrobel <Heinz.Wrobel@nxp.com>

The prior configuration was an SBSA UART that can't be configured or
modified, or even enabled if it isn't the boot console. With properly
defined clocks, the PL011 configuration can be used.

Signed-off-by: Heinz Wrobel <Heinz.Wrobel@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 32 ++++++++++++++-----
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 6640b49670ae5..e665c629e1a1f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -949,34 +949,50 @@ QORIQ_CLK_PLL_DIV(8)>,
 		};
 
 		uart0: serial@21c0000 {
-			compatible = "arm,sbsa-uart","arm,pl011";
+			compatible = "arm,pl011", "arm,primecell";
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>;
+			clock-names = "uartclk", "apb_pclk";
 			reg = <0x0 0x21c0000 0x0 0x1000>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-			current-speed = <115200>;
 			status = "disabled";
 		};
 
 		uart1: serial@21d0000 {
-			compatible = "arm,sbsa-uart","arm,pl011";
+			compatible = "arm,pl011", "arm,primecell";
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>;
+			clock-names = "uartclk", "apb_pclk";
 			reg = <0x0 0x21d0000 0x0 0x1000>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
-			current-speed = <115200>;
 			status = "disabled";
 		};
 
 		uart2: serial@21e0000 {
-			compatible = "arm,sbsa-uart","arm,pl011";
+			compatible = "arm,pl011", "arm,primecell";
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>;
+			clock-names = "uartclk", "apb_pclk";
 			reg = <0x0 0x21e0000 0x0 0x1000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-			current-speed = <115200>;
 			status = "disabled";
 		};
 
 		uart3: serial@21f0000 {
-			compatible = "arm,sbsa-uart","arm,pl011";
+			compatible = "arm,pl011", "arm,primecell";
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(8)>;
+			clock-names = "uartclk", "apb_pclk";
 			reg = <0x0 0x21f0000 0x0 0x1000>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-			current-speed = <115200>;
 			status = "disabled";
 		};
 
-- 
2.34.1


