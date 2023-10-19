Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CDC7CEE34
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjJSCsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSCsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:48:35 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2049.outbound.protection.outlook.com [40.107.15.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1671C138;
        Wed, 18 Oct 2023 19:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npakqqRpS+dM5gAOuhsNxonZxMkG7UtPIP+3gGsg4cnep34vbpacROm8xHqt864jhNlqU/RKI3FKvVT11ptnIANCL8RFro15UFKyVZtmxrnuF6hA1FkGcskhAAcjXqfJUunbvlEIh1IRuNB/15GOQZBxvzeoL5Nw2GCXk9dk6pddcUKT0mf+Ifdxzv4xtGkRqnPLE9sQhuycxhDf5N5p0pSupp+j+DJruXT0sabY2nrF/7O/z9LNp7LKcv4Tq0zCRbwsdw5wvFlubhdKB5qjMDKbnIQMdQ0mMA72I0SI0JFqFAQKarnfmy8AnDWCAPt0EDC56VVLjUwNZDi3drI4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDkbFghCYRIxXLS77RafNyTXHs8bWVMebLyp4TESW+Y=;
 b=k0RgNyyfrDKL04ae8EV1RMZKzfjK+4wYPVLhNToyU08MQc7bOAen+M6KDpchpfHDZcTvhXV9sKyTmaTBWZ2mBuuuAWiZTPY62AyDOsbGg/Gp9fG3EIdeY5zflAX2uFQDwgbKgicaLCA92xw2TrWrtRxU3IgjfnKb44R2OZpFFK7LKFBeTvfaxCHP765oyvyr1J7xhXxwEkDC+SLs9iBX2oV4i0mKp2NOfCgZqay/w4VBKi8S24b7noajsSDfhKLKfFYGL7W4W+LP0tq13XkH7OSinOMUjO7/7Jn0Wrv21fzJz8dAWeHXWzjUK8J87FKCbdajeTSUe0qJ+3BW6i1oRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDkbFghCYRIxXLS77RafNyTXHs8bWVMebLyp4TESW+Y=;
 b=SqVn62fhKJ4z4x39dX2nKENY7kpx7iSl4fx7BCRqTeM+rRghsDARknzO+SLkyTLolQAr0hjzNdO6K2k/MuquP4pXiFWUR/SM+TePtNiUr9SGpjcESyyQ0g7meaZvCX8OicOxTUcZNh7uw+NiHy+m+N3Xsh1vpnjZsDtAglrM/zA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS5PR04MB10000.eurprd04.prod.outlook.com (2603:10a6:20b:682::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Thu, 19 Oct
 2023 02:48:27 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::6e53:39fc:f010:30d5%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 02:48:27 +0000
From:   "Ming Qian (OSS)" <ming.qian@oss.nxp.com>
To:     mirela.rabulea@oss.nxp.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        ming.qian@nxp.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/3] dt-bindings: media: imx-jpeg: Assign slot for imx jpeg encoder/decoder
Date:   Thu, 19 Oct 2023 10:48:00 +0800
Message-Id: <c7995af1f91733626ff4e86f0575dea5d2ff0bb8.1697597713.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1697597713.git.ming.qian@nxp.com>
References: <cover.1697597713.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS5PR04MB10000:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c46a79-31cc-4fa5-1503-08dbd04ddee3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oxaAzVpTSeyE0psmEMAs2O48BThD/m3vdf13CJwZxK9PlvFuZtwxDOkx8ZmvKQMavljgka7DhIblJAmiLrURz51UTKZxvICzLh4kEvJi7cIQx59ngxH+IvWZ1Hg9ztCQCPaaLwi3gncMwzVNqP4U6Mvnj1HpQQxWFrkuZLeGWRoAONZNHnk2LLxOCGrzHoMpR+j3RmONW9J9rJ6KDHTxZcY8OlzZFD2HQh/yKhqyeXwz5YY4KyQuKCXIgCpG9jik2BTcFnv4AJ0vyy/7J8Ivm5eLM1wZLGasgpgWh5g7srOkKD9vdCqT40iBFukfox2j/6Rhj/1xDVA1rk5tl4o5kErqv3L3CGxbQwoHSNDNVEn+QNCL0Y2/1SvnRT6dkA8iHi+A8pyDkAXFryVrk2L3IhE89imGzVbMtFDLChAa1yTrzt8uGAirvSk/xFdg0PtT4DFaiHfs2voxRoH+WFImvTyjl6KDn/4Pa2yiKGhOqQp1RD5JveHBpcUwWWB9TpdIIqNrfxNvDThD/rkB4Zq+teEVIjHNM12lCfccxF6DzmYLjFL6uYhS5Oa1pnForRxsgHEEgInvHtUjft1Qko5i66PyYYJT8ErV6g2dJTnl1nVaiGgjfRXP1AD3SlexVgD/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38350700005)(6512007)(86362001)(36756003)(9686003)(8676002)(66476007)(66946007)(38100700002)(316002)(83380400001)(52116002)(6506007)(6666004)(66556008)(41300700001)(6486002)(478600001)(8936002)(7416002)(5660300002)(4326008)(2906002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qnpto59hkfTOxNbb09MM+GDmjVzJgyed5YfqHVmlzs1STsOcBK4VWpKWFnbe?=
 =?us-ascii?Q?TjBdA1xEw4cp5D/VMkzDxuSQGKpIITI2lWptOoXa24hGLAATlhCLLsSfIV3u?=
 =?us-ascii?Q?lGnDb7gXcRav8hLJMWLxesvONIz9s52PUfWzkjh+DfLX0dcFfxvVl2YMhLF7?=
 =?us-ascii?Q?roonpLs9/QHIpH7HfxKERLKIXK4EMotWtKwOu0fHpUyd7MvwGT5Y7Yp0hhcY?=
 =?us-ascii?Q?Z4Gz3O7oPfJ/eGy8OoDbpiSigRwPSovifQdObergOU2kOHNTl8hRtl1Fa5LS?=
 =?us-ascii?Q?3tRFemMXw6rs9u5/Mv+MoV18Ka4ZLz5vYg8GG12gKkrWd65yamx/U9McHyAC?=
 =?us-ascii?Q?7eg5vnBxwbMB7FAtEQD6Kzmjjr7SJ/+2xEAemfy4/3KygbHxXii2Sl3XEsFz?=
 =?us-ascii?Q?OA0lekbXX+AkTArTxYtkg2Fd/W9Wi/uqhP6mhrFLOr3VK3wrc7wXQtbb7E+3?=
 =?us-ascii?Q?lWWak4835Ge/KmR2fZRlkSC1fxprsIuN/4FrVvr4NxrPR/vUAh6GHHwPliCH?=
 =?us-ascii?Q?USWK4mqzWsFvKzq5PopXY6BEXaJWX8H8yqoofaxD1djyd691FJCSC4Lx1kuY?=
 =?us-ascii?Q?JzitU0QpEgmK0jPhzG6FlkGzjISkDvhQnoa2p1BygYFAg76aEwYkR50x8RFY?=
 =?us-ascii?Q?m4/wO7yyFVq04BNzWGcU/Keq/fH2YgwJL5FCnUjOeU0ltc8RuP2tGHUpMteO?=
 =?us-ascii?Q?jQer1HK0zZxodBbQVqM69eKKILBUjtAH+YH0sXupH78NPREeTs69cm9EhUeX?=
 =?us-ascii?Q?mrIOwNpd2yLDtmSlne0LlAtV5WP5RpPfSAL251xuszVgSC8U/Xit7LTXeN+v?=
 =?us-ascii?Q?7DIbsp4pMNLvQAeB8QRGKCtDHu2JCyLO+NUcl9GPVQ98xxB2QPNjHv4ajCbF?=
 =?us-ascii?Q?HGvBx+x0pXDdGfTg72EYMb83jclN8Ez43/nJXxN4tMbUoQT/8LQy9cx6Qa18?=
 =?us-ascii?Q?jginj/g/Y7RUwRb+Y5E9C24xrQSmXkkk2sWoc+i/rkp5ZBmBLM/WoHtLW95p?=
 =?us-ascii?Q?GSksYCn6hBBySO59Pzb2b/qd/OOY/am67gM/Jzfe99wn1ejq1xwAy6mzheOz?=
 =?us-ascii?Q?DfNzctOguatDWzkpnaVQ2ZDEtAYh7P8nhPQZyWgC4li2vV9/E/uuBXYM4vs3?=
 =?us-ascii?Q?NyNsops0hATPdDQj6XxVnvT4VqlnTWaaH0P6iUuZUeUXYN0FJzFzDcxDDchq?=
 =?us-ascii?Q?7wV2i4fgMuYLLWfPNKTGVJ1IhjrAJEHWrpRub6HYHO1MykKmj+z+Y9sidDVm?=
 =?us-ascii?Q?Qe8kTQF2Diw72AYF54iqteYuqcHUSIl3KBV2Lr9qKNlW0IMJakLMh0cFsjqo?=
 =?us-ascii?Q?Nbl8UqvJVaPGroa5Hj7ymU5bpMkvnUSMRZaCLwQYAAsRzvA5ysKeeuDFq5J0?=
 =?us-ascii?Q?SIyWRhWwyZAy8AYgbcEkxyoxJHW+M6cHN/93sdMO7Kyk1nsNRVmod0Zam4Mb?=
 =?us-ascii?Q?RQCdCvhXNDP6RC9cYp5AcR+UadZyNmXD+4chaAEqTSUwtCrtfnv92m3mkoBO?=
 =?us-ascii?Q?q6eI4V6bM2u50b8mcydwLMnLBnV/mNd76gCLWSk5YgF9DRKTt4aviHo+I+3K?=
 =?us-ascii?Q?kzcadEFoATRUSsviMfACkrNXx4tlYreH/JfnaTGK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c46a79-31cc-4fa5-1503-08dbd04ddee3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:48:27.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sw00ZjvIflnSull+7kd7fN2GOrk1LEyrou2RL54OsJ7gaLWLOzgZ04aME47bUwhPdEEks3HnFL2PDLJxRcxl1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10000
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Qian <ming.qian@nxp.com>

This IP includes a jpeg wrapper and a jpeg engine, the wrapper is
working on descriptor based manner. It supports up to 4 slots, each slot
can have its own chained descriptors. Host won't configure the engine
directly, but fill some descriptors to encode or decode one jpeg
picture. Then configure the descriptors to certain slot register. The
jpeg wrapper will schedule between different slots. When some slot is
finished, the slot interrupt will be triggered. The purpose of slot is
that engine can be shared across multiple VMS and os.

Currently, power domains and interrupts are enabled for all 4 slots, but
only one slot is used. There is no benefit in using more that one slot
from within the same OS, as the slots are scheduled in round-robin
manner and not executed in parallel.

Use the property "nxp,slot" to assign a single slot, and just expose the
parts of the h/w for the assigned slot. For example, only put slot 1's
power-domains entry in the DT when slot 1 is assigned. If not specified,
0 is used by default.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v5
- improve commit message
- improve property description

v4
- improve commit message
- drop line making the property required, to avoid ABI break

v3
- add vender prefix, change property slot to nxp,slot
- add type for property slot

v2
- add a new property in bindings document

 .../bindings/media/nxp,imx8-jpeg.yaml         | 46 +++++++++----------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
index 3d9d1db37040..0961856bdcab 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
@@ -32,19 +32,27 @@ properties:
     maxItems: 1
 
   interrupts:
-    description: |
-      There are 4 slots available in the IP, which the driver may use
-      If a certain slot is used, it should have an associated interrupt
-      The interrupt with index i is assumed to be for slot i
-    minItems: 1               # At least one slot is needed by the driver
-    maxItems: 4               # The IP has 4 slots available for use
+    description:
+      Interrupt number for slot
+    maxItems: 1
 
   power-domains:
     description:
       List of phandle and PM domain specifier as documented in
       Documentation/devicetree/bindings/power/power_domain.txt
-    minItems: 2               # Wrapper and 1 slot
-    maxItems: 5               # Wrapper and 4 slots
+    minItems: 1               # Mixed power domain
+    maxItems: 2               # Wrapper and 1 slot
+
+  nxp,slot:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Integer number of slot index used. This IP includes a jpeg wrapper, the
+      wrapper is working on descriptor based manner. It supports up to 4 slots,
+      each slot can have its own chained descriptors. The purpose is to share
+      the jpeg engine across multiple VMS and os. We use this property to
+      assign a single slot. If not specified, 0 is used by default.
+    minimum: 0
+    maximum: 3
 
 required:
   - compatible
@@ -62,28 +70,18 @@ examples:
     jpegdec: jpegdec@58400000 {
         compatible = "nxp,imx8qxp-jpgdec";
         reg = <0x58400000 0x00050000 >;
-        interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
+        interrupts = <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>;
         power-domains = <&pd IMX_SC_R_MJPEG_DEC_MP>,
-                        <&pd IMX_SC_R_MJPEG_DEC_S0>,
-                        <&pd IMX_SC_R_MJPEG_DEC_S1>,
-                        <&pd IMX_SC_R_MJPEG_DEC_S2>,
-                        <&pd IMX_SC_R_MJPEG_DEC_S3>;
+                        <&pd IMX_SC_R_MJPEG_DEC_S0>;
+        nxp,slot = <0>;
     };
 
     jpegenc: jpegenc@58450000 {
         compatible = "nxp,imx8qm-jpgenc", "nxp,imx8qxp-jpgenc";
         reg = <0x58450000 0x00050000 >;
-        interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
-                     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>;
+        interrupts = <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
         power-domains = <&pd IMX_SC_R_MJPEG_ENC_MP>,
-                        <&pd IMX_SC_R_MJPEG_ENC_S0>,
-                        <&pd IMX_SC_R_MJPEG_ENC_S1>,
-                        <&pd IMX_SC_R_MJPEG_ENC_S2>,
-                        <&pd IMX_SC_R_MJPEG_ENC_S3>;
+                        <&pd IMX_SC_R_MJPEG_ENC_S0>;
+        nxp,slot = <0>;
     };
 ...
-- 
2.38.1

