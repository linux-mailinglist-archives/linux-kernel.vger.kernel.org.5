Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412337AEA05
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjIZKKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjIZKKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:10:35 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2073.outbound.protection.outlook.com [40.107.6.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0CF9D;
        Tue, 26 Sep 2023 03:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFG6mHeDxah7qyspL7vr+eS/rW94BUrC5PnT/wi3DB4j1nr5W5v0tDMqyzQzB/EU88vlCL1iov6u2rkAQp9eNnTnwZPXgSsnbeOVcMnX+7sEIgBDFj4998Viy9zqTKUr3lO5+NCBrWuecoMfp+UoouJpiujKNoMgMNhmN3FBgNCcdZfzdCwJSaYEckmvg6cav5WNzySupVAW86ven5aGmd3am8wXoSDsHFF+nbZGpdtG1k0CtsqYN28Rx6wuwXxlPk/pO3gDnuMBtaqTYh9KtgUmbSPNTYLhK9xy/v7SLOY81gfsYnErcC2JX0GgzVSohXRcUoW0XvMq89zlDdj0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDUv5bZfb8FAd7oqhZgfvJ75ZmE9DVCpifK2ygYSqRI=;
 b=ILFZFTbBW/vEvpl6RiYUk8ThfmK50soV49WTI6XJPoEUQqpcJ+Laf0yzgfYQPPLTUMt5R2zmmWB9AHsqm0UhThWDrhF5f/dQdhEme+T+na+MoGg6ieWTuNhIN6ob/WeXnJem0zB4iNAi8Y8N65N5wFyO7TvllKNEP6oAiATOipH1qP7qO+OX4g21si2E3crVF/qXnsOLjk0gNSZUSQzNxlS3H2hG66OHaCgyYcCqTItccHpCf9nLfY/FiA4QzPkjg/Gnek0WLiUgyBSZEoN1WhOq+ocSEpLYj/ZBECLkS5yzZtM7FyKQ625sE5Cbe1Tf0hgEFTcJ9CIhNMGUu6Y6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDUv5bZfb8FAd7oqhZgfvJ75ZmE9DVCpifK2ygYSqRI=;
 b=SMussPemosCEapjf+tz7WOKAT2vfi5NOlz10YcIU5BmOAVVc83hBq0rbxk3e5a0BVaxulgZjo6sC1BhaSJg1AeS2KiPF3gaEylUVyEz7FMvvvV8dPGdJkVMDChJZE9/sA02FFTcq2+c8itR8w7M9cyzPTcI0JR0yYjAl+oQBfds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PAXPR04MB8142.eurprd04.prod.outlook.com (2603:10a6:102:1ce::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 10:10:26 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::71e6:21de:ecb2:560f%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 10:10:26 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mirela.rabulea@oss.nxp.com, robh+dt@kernel.org, shawnguo@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign slot for imx jpeg encoder/decoder
Date:   Tue, 26 Sep 2023 18:10:00 +0800
Message-Id: <20230926101000.13392-2-ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230926101000.13392-1-ming.qian@nxp.com>
References: <20230926101000.13392-1-ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0209.apcprd04.prod.outlook.com
 (2603:1096:4:187::12) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|PAXPR04MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b646e0-62ba-4fc1-384f-08dbbe78cde5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0KAsj7b5xV9ZWIiD2VxEFinbmvmh4X1Iz4nsnHpKpFUwFJcQRo6E2oflDmxUY8GGY1UX8bQrcGAjE2KzvK9kwbvmlQSorSsnH9WjF/54eq5FGnJOmJPYC+1xZSOC1vmgP5d7UA66LW1qpD9Tdcofo56OHDOB3BI+d0BhUgMU3IZR5qXgT9Tggq8ZseWcydbsd8A3JuD652tc7p1yUxfJ9r47siuPX84AYyzp2kWFx9UStfcSsE1kI/4YkjzhIfIWMrF8qMKyNQ53XAY0I5hlIpWtX2pk+54BzCKYFmZJHC07q8AYDeb4c7jIt3KO7oE8q5tM5iqWD7Unjc8jUj2Y7zPFXysL6pNMiXnGrG0uBKr+L5vRVd37UclhpXky1UviEwML9nMjqBDBiIsyqkZ9NGmLNTuWJMwlGmVLW6FeT0WTH1Lx7UiB5ovwMz0YffGb3vUoWlqgQDkcXSLOkWZJrHE351Qnw8ThZlKU5IiFuhc2McPrkzx0ybOWftmEwy4IjQsxYVWJa+wDg4ZyOGtSbKvqKNNlHhgsMozE1K6LEujoZ7r53/dBpHpe0dNr5/oPWb5J9XfEj2zaKHS2S6kp8rDFpffJqkiskwpN/gyBzLgAuG8Jp7xdL3i+gpMiCdV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(1800799009)(186009)(2616005)(26005)(1076003)(52116002)(6506007)(6512007)(86362001)(38100700002)(38350700002)(36756003)(83380400001)(66476007)(316002)(41300700001)(4326008)(44832011)(8936002)(8676002)(5660300002)(66946007)(2906002)(7416002)(478600001)(6666004)(6486002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KkpEHhqOZFfr+LXFTBzd1uCJqEb55lv6he9Nwuc43E95oYDiBQTDwvYqVZoU?=
 =?us-ascii?Q?vnjXhK8pEXdlNdi1mpyVN3wcmsytWKaaWXQsI1+KYe+x00gVKY6RrSfkFST2?=
 =?us-ascii?Q?1cdJ1if7EBVYoM4yXxnvKo+JkMCof6RoEzRBfYnXAGRBemV4yhBwhJ8/Zwdw?=
 =?us-ascii?Q?t3DR/XDX+667jH7Rodez6iECsG6QZill9urfvVMJM27T7MOow33uiwZ8cbCD?=
 =?us-ascii?Q?P4zLM/6OLX6R7WWuf9fMoH26MH5u33rsXFXA4dFN0f+XqHNH36RFu6EpHpjy?=
 =?us-ascii?Q?cPh4xrKelNz2PenAch4sLepHv7aNzVYRaxbyugErRhwGQC17ChnPfPyoy9+s?=
 =?us-ascii?Q?8vNXqIHw/kcxNGIW33ZH4BTS6sHuY7JCGX4IV581M11pRSWddwk22pn+E1uE?=
 =?us-ascii?Q?jmry4pETdY7ndfr16qCg8iUfq4XGKkNBhoemb4AWaSnnTjPqFuomu4qd5tQ5?=
 =?us-ascii?Q?I+y6pMg92i+JVUeoOt7YiBuT141jlr60O7+SezEcb+YRYBhbgyN4EfGqpAJF?=
 =?us-ascii?Q?hHhyuEXzYzokhM1rWaFekzbTL3RP9WHjMzDbU3YuynyY8kAcLMYQVd5I1JCm?=
 =?us-ascii?Q?CwjfPVCTnQdq8JcP6y+8tUvOlaQmlnP2sHL/ChtS/uVSYbkU0kcPGnjkNams?=
 =?us-ascii?Q?VG4Cau5P5hpesiUhfTFQaddaSQu3QZq22LJZ2BC+r0ATWOmOCBpFBk/YtfAl?=
 =?us-ascii?Q?HQEseEqFM4WMWpfd2TfL7/f0JGJzacDUwFhyZRMOdxeMGWIhceWw/83HCPoc?=
 =?us-ascii?Q?PL+g7xP3m0Hak9nMxLKhlBZx/9ISw6EVl03HWqiSrvKhVKlsG2Hq/C7BnhuL?=
 =?us-ascii?Q?l9W/+mafmb11eXDyCzKJ5VB+Nf1wItlV7NtWh6SYDU2hutclhGOS13tyChfM?=
 =?us-ascii?Q?/I+aXhiNMd1os0HBF08MjNFyn8eK5FDqPpOv6Vzn95fL4f1z5eRPArJ53cOC?=
 =?us-ascii?Q?O0T1/5bwz4QnyjPTUutw+UHNB/frYya0HUuoKY+ss97NEoto/Ovc7nz8vmAz?=
 =?us-ascii?Q?hZUfOxK4MKBcCjNOGOHeWiw47wbnljcOrWQ28JkYMQVybYfDw9Mw70X6eFFQ?=
 =?us-ascii?Q?E9N0aZHnBNRWJG6VImMqHrpp33dbJTOwcoh+lxmmt8+be6Qvm4f3uKDER7xb?=
 =?us-ascii?Q?jzqAXDvHGj6js163tnkmjif8HOfowOn7AZgfeoW7eeQPSudPzY9ZjnArecFP?=
 =?us-ascii?Q?c69pOvcucXPqSpGGlIeZfAOuD6RJp4T6KN9eIAa14myR3LH1aEdZ6lNiIH89?=
 =?us-ascii?Q?FKMfI0Hcts9seb1IVl4JXxXQ7+eq+zhu97zZHaNdF+SoKS/d82kam7KHKra9?=
 =?us-ascii?Q?lWPJgnFKsRKrm3MIJFfdKJY2lY71rwxF5DseDdc/ZZZDJWMYdWNmSjN5vrM7?=
 =?us-ascii?Q?kTfMsYtUKIClSNoR9HPQvMDIoBCg0TbvVW6Mz0LjbCXHRwL4veWkZ9C8A0Eu?=
 =?us-ascii?Q?ckfqgH5h/1VY8QWZsK9eRiiH5y419a3s++cjGrDdy6kBgoNRl1PmKEgxH2Yg?=
 =?us-ascii?Q?mq3oxRsNMVareGsysVQHwyTUsK5Tn/mIqEX91jMfFaXVTgq0fShG3KIsngNK?=
 =?us-ascii?Q?8uAlgCtKInPn7m1M/Bm0eyvoMa+aLPHEmjhTslae?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b646e0-62ba-4fc1-384f-08dbbe78cde5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 10:10:26.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jITYJPjc2ykhK/GqA4V/B6MkdLZ9vMOUMvxO8N6vm5Q+fIqQ7Db6m4cvWoTUNGJgvRoO4D7nnpH4z68SLhoZKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8142
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are total 4 slots available in the IP, and we only need to use one
slot in one os, assign a single slot, configure interrupt and power
domain only for 1 slot, not for the all 4 slots.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
v4
- improve commit message
- don't make an ABI break
v3
- add vender prefix, change property slot to nxp,slot
- add type for property slot

 .../bindings/media/nxp,imx8-jpeg.yaml         | 45 +++++++++----------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
index 3d9d1db37040..4bcfc815c894 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
@@ -32,19 +32,26 @@ properties:
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
+    minItems: 1               # VPUMIX
+    maxItems: 2               # Wrapper and 1 slot
+
+  nxp,slot:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Integer number of slot index used. There are 4 slots available in the IP,
+      and driver can use a certain slot, it should have an associated interrupt
+      and power-domain. In theory, it supports 4 os or vm. If not specified, 0
+      is used by default.
+    minimum: 0
+    maximum: 3
 
 required:
   - compatible
@@ -62,28 +69,18 @@ examples:
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

