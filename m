Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FD77A0814
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbjINO5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234000AbjINO5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:57:11 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068F91FC7;
        Thu, 14 Sep 2023 07:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcV3ZT2KQMQsohI/AIuyJPttxkRLH27/sX6tQWF/Xx++G+Y5C15qTAvbhBVBx+pajv2RkuELtBF8dHOIN4gRxEYu0r9S+Yi8zpc5iDBtX+3l08zdFAEB2Mm88s9AFzuKtnHLpeLbeLQ4igZtPM46Zwysj8VclYdfO2g947AFF52wmah8pGgtYChimxD+vqnrIR2G/2RcdQXYkD+YfOZLTU8XiBhQHvQb3HChT7zfP5bSTnCdlx/oP1Qkoy5zWsmderLcOyZYN4Le2W7NuuYL1Xsq7vtc3jMEaUpVFJqIdIOik+r+mhN7VtV8fp8MyUg/UiIZ2j5GW/RwH76POdd2qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpB8xU1eXhJHyYI6ZZQRg4LgYCYDbKTblEMSWdko7x0=;
 b=bwqGzlbXv8M2myXzP14jS2h2cZdnB18KYu3bgVGw5DhQy1z8KI2DoXiC2dYReUGwrh5bBqSm8KyGIsykqoTChFFfyMAxH4aPlmDIia5K0BoxAYEUTaWi5n0rSRAO+VnGWfiotHkY6Gg33tORT7gcr822tLnPLm2rvFmzN/jn89Iyv3W1Qh1N7Ai37kpKsGWZvzDGb/PM2v7zKB//OVDjBF3r521HIlGHAwXJdXP9IPBU7856kqKk292a3+rIrZ0+FgacIg4mLcUyhibo+RlegixBzSJ8eVPrn3cjqbt89pCz5RflCmjB902qnW3yRhXuiH8zu3a4yXMi+NdRhbqz8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpB8xU1eXhJHyYI6ZZQRg4LgYCYDbKTblEMSWdko7x0=;
 b=aKUAFPfypRA/UESS50kCD77iRoQRq8jCGwodWFXIOL8nBA61fibX3zAg1K2NmkReGrOppAbdMcJcuCihsbOxy5tQlCGqiv6aie4K0N/kOxcQr+BRoRnY0szxgfoGCnOUDgCElPGDQi3+51VRGYvqg2JsOYgWqDacUfLi+5Tc6XU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by PAXPR04MB8142.eurprd04.prod.outlook.com (2603:10a6:102:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 14:57:04 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 14:57:04 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH] arm64: dts: ls208xa: use a pseudo-bus to constrain usb dma size
Date:   Thu, 14 Sep 2023 17:56:52 +0300
Message-Id: <20230914145652.25728-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0078.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::19) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|PAXPR04MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 418cdd3f-9edd-4533-7771-08dbb532dbcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LzC/TCqj1IMzp7h3im0X5CqIIMrqaiRu9f3g0BKs7YOzP98FlpXMWNHrDJsGTI/JBkAjS776C71F1lhqp2QwE9h6/2WYd7D19CyBBUUpp4Xu3EFCAOdUxlCcEGy2PW/14OEmPod1fC6g5RC9nSjB8hJPXcPsz7TST0dryD0HIX9ZCq9rCm3dHlWQOgzvHuEsgRD3dssyWSKMraAYtMS5Xy3H4pQvK8Md96Eh8+nuCxiMerRKIUy81Tcxl3vFcMOVRpakvZrowlauY43Mzul4cicPz/BCPX73S34FILQiYCW/4eNSgUPsuqfOug66Zflugo7vs/NmrUlwt0C1DcMXpfxGHL1JJDtmUaLsw8MvgWp7vAPT/XVDS+rYDATdjxaay8RpEpbRHNYifWLnUpYjcGTQMUX4dUtK6KAyF+OC0qU5X1uxOI+eR8ox27gavQyZNweuzKpcgowRuzgaOY5bhiwH+t/OJcJ+4etl7DKD8XPdxoKhdXlP6azk2+CoNJLAdtuCsBGP2hUmbaF23LKrgcemtVXaDJvjycoGF+fif4ixgiZeZm7kQbk9y5D1r7/fQMwMssVC1Y6em3/zvg3Rr/4q90uxpVqmjWin55RiKLe9b+lCR4Xc8TRvRl+91nEB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9380.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199024)(186009)(1800799009)(316002)(6666004)(6506007)(52116002)(6486002)(478600001)(38100700002)(38350700002)(26005)(83380400001)(1076003)(6512007)(2616005)(41300700001)(36756003)(8676002)(86362001)(2906002)(66946007)(5660300002)(66476007)(44832011)(8936002)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JpCZHgcz9YKGlImyBOhkl/nhXIwIYGYWrDTm670BdrfbErKK8DEkdv2ffgsm?=
 =?us-ascii?Q?rCW5ZEJvdKBBa8/Eq5DdyS6EXMS9t6oB13+UNVQr3ghUuY6S1E8P7X/8fWjb?=
 =?us-ascii?Q?1K8Hvdg4fV+6EXqtEHtW88wnPpB6IRxPziQZVXzy1EEni2nIrCjgHkd5hwK9?=
 =?us-ascii?Q?6+BN7W396gkfCmMhi9lIDp4jE+ZghctgvySg/LIwlDua9CUo2lpq30GWbrKx?=
 =?us-ascii?Q?RAuXUugRYxSZvieZXfnJ7huTJTZ8RxlAgktvKmlOmxXh3tizhrydYkK7PUAT?=
 =?us-ascii?Q?dNmlt4nTQtfF7w97vDARW6mPzTOwHbqFju9qpXF7Hn73/AeaHe8IzIoy1VE/?=
 =?us-ascii?Q?VRrq8KRgdRdYmc72nxH2c6FsSzjLSPKhVqY8GP0WZmhQ+hTJUZo3tmOro8jC?=
 =?us-ascii?Q?WGZ0e3rkGnq/qbkXP5cjhocpzw8Mu/S35Id8LzF8fCCsrfivDA+dB8EOMVRo?=
 =?us-ascii?Q?TbW5xaUhqKCJY9S4omt3biglTYt7hqE/Dfy1dw/kYnQemWZFv6eGM0enDXc1?=
 =?us-ascii?Q?hfOOAUhWvpeHVnyHspO9NGQ52+omRiNbb6YQoNjGbjEBINhLLfdVvaG4OVQn?=
 =?us-ascii?Q?PBvQxxxMh+1mtgO/j7vl0UrvH1jQbC2Ug6xFaESutuTszfSx5nCUkE3PvsYK?=
 =?us-ascii?Q?r7NYCcjGSTA7TSNIC8KrH7VgK2NJKJ3qD7kWyWTbr1gpxoBJHvetamPlh80a?=
 =?us-ascii?Q?AzFI3Nfom1HMUDuVbTxC6wK2suxVWiwr8zX2LeCIwhdhx/oG8vg1o9Au9mhv?=
 =?us-ascii?Q?/QG0v3Fm8EF/D5P93rkWBK8k3C598+fjiJycgYdURwAF5oX8Fw0+Eocm7UEZ?=
 =?us-ascii?Q?f5QmuiwXbht0O9f9vQTnb4n3A1hnY2YdGX1aGXb6V2nzG1B7ZUbhvolpDsk8?=
 =?us-ascii?Q?nosgmSuJPA4wnXFoZodspMr04BSjXXxtiolyybzEQ/QqQ1zgEFLCHYiNubzm?=
 =?us-ascii?Q?g5QACUpUGnJAF+YNZmV2yQPdZVNSUpdaqQlkNS4P16RYBks7dCygoX8ge64d?=
 =?us-ascii?Q?jN0qEk5S+VGx4crrdIMQ9dMea1dtVSV7mduKyi4YNYtcDzZOA/VOz09RZcjJ?=
 =?us-ascii?Q?t0SXE5zp8phixFvcKcGHcoX96I0gV1FDu4BQl3pHSHYFTrbsYqEpEfTK+sMY?=
 =?us-ascii?Q?sx0I19fSxTpSHvWEpCzORCTcUe7eWH/mS0HFUe9jr/y3sbGT2GEokM7WsxMy?=
 =?us-ascii?Q?5XmdnSDUE7Chh+2B0hSh5wY0hym60ygXuqfCHi1OHgUTfZ3bsaZjfz4AjGPy?=
 =?us-ascii?Q?4ijCCxumbhJQESGjdpg6+u11T9jDNppAsvsJbRFKiihUIzjVq+is8wHznjlR?=
 =?us-ascii?Q?SFLsra3aFfe5+LTxqKa+IQ4QmpN6PN0MF55gx99u4BqCJ1VPezfuMw0/7uNF?=
 =?us-ascii?Q?VpdKWJ7pXetn9KcUUFfMMBGogkY4NBYCbFZ4WrSiB3YCAf3/+V+dmio/16CV?=
 =?us-ascii?Q?DwO3Ppr0u2FBwCZUKDwKa5dLbFV0vab66rsrrXRBtbLemTO5/NP5xgKFWeKW?=
 =?us-ascii?Q?KSy5IHS12MOTAEjdG8TW6uuWDYFyUHvJcqirzOqSWPHx/nQPekkH7YPXIcm3?=
 =?us-ascii?Q?Zy7yykkwvmDKpMUMhraGKcAqfxWd5nO8s4wYGrx/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418cdd3f-9edd-4533-7771-08dbb532dbcf
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:57:04.5516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1epRoF4AC8HkqkRcZr5/nexm2s7eYbdF6gVIhhPer6frVbjbfwhpWuyPfaNQjWQ57LXsx5DEi5B+4c7Hxick5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8142
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap the usb controllers in an intermediate simple-bus and use it to
constrain the dma address size of these usb controllers to the 40b
that they generate toward the interconnect. This is required because
the SoC uses 48b address sizes and this mismatch would lead to smmu
context faults [1] because the usb generates 40b addresses while the
smmu page tables are populated with 48b wide addresses.

[1]
xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 1
xhci-hcd xhci-hcd.0.auto: hcc params 0x0220f66d hci version 0x100 quirks 0x0000000002000010
xhci-hcd xhci-hcd.0.auto: irq 108, io mem 0x03100000
xhci-hcd xhci-hcd.0.auto: xHCI Host Controller
xhci-hcd xhci-hcd.0.auto: new USB bus registered, assigned bus number 2
xhci-hcd xhci-hcd.0.auto: Host supports USB 3.0 SuperSpeed
arm-smmu 5000000.iommu: Unhandled context fault: fsr=0x402, iova=0xffffffb000, fsynr=0x0, cbfrsynra=0xc01, cb=3

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 46 +++++++++++--------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index d2f5345d0560..47cc7699ca16 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -1186,26 +1186,34 @@
 			dma-coherent;
 		};
 
-		usb0: usb@3100000 {
-			status = "disabled";
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3100000 0x0 0x10000>;
-			interrupts = <0 80 0x4>; /* Level high type */
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
-		};
+		aux_bus: aux_bus {
+			#address-cells = <2>;
+			#size-cells = <2>;
+			compatible = "simple-bus";
+			ranges;
+			dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
+
+			usb0: usb@3100000 {
+				status = "disabled";
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3100000 0x0 0x10000>;
+				interrupts = <0 80 0x4>; /* Level high type */
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+			};
 
-		usb1: usb@3110000 {
-			status = "disabled";
-			compatible = "snps,dwc3";
-			reg = <0x0 0x3110000 0x0 0x10000>;
-			interrupts = <0 81 0x4>; /* Level high type */
-			dr_mode = "host";
-			snps,quirk-frame-length-adjustment = <0x20>;
-			snps,dis_rxdet_inp3_quirk;
-			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+			usb1: usb@3110000 {
+				status = "disabled";
+				compatible = "snps,dwc3";
+				reg = <0x0 0x3110000 0x0 0x10000>;
+				interrupts = <0 81 0x4>; /* Level high type */
+				dr_mode = "host";
+				snps,quirk-frame-length-adjustment = <0x20>;
+				snps,dis_rxdet_inp3_quirk;
+				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+			};
 		};
 
 		ccn@4000000 {
-- 
2.17.1

