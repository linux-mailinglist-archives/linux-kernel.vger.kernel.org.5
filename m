Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6283E761073
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjGYKRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGYKRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:17:37 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2F310C9;
        Tue, 25 Jul 2023 03:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqJDhAH4+gTHeJ9UyB/SEQWnkK/6L/aAGhIvDvhbNbaEDTJNl+eYtrnaHT/rJ2rB9Gm0ZUSzI/BjTTrghXIvkov97v0WtvzE7fGDOjULY0HSb0kFNCjbPxLLZH22nWofrYFPqGmt7MScB6IFEhKdW46AMrMiyG12xtW6sR4sHmXTyTF2klq2nlsxJwprvUm5mhib3gA1Hz0l2NonTNm/1buTVdgvdHTvnrmm+Le0Sc8lYzGpPL/D/xCqERWcPCn6B+diSFQeTIGurm0hTkNekUE3AW4luxH+FkBRvCCzUH5lEeSG2qLIEbXjfi59YZlSWkLnffXrCVAXmHIVDWdqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ho9sAejhyzUIuZ8GfOLIQlIiC9pakn7jKZjO3YFKMR0=;
 b=Wc3OO13uRpUC2MaMe4GB/RbeatLjH/Ub6pdzuNOqEb1gJybuqHNfYdPRi6aOKOkMOUo+2ku0ECk5Ns6t1A9yqMiwn70kdxLGuo94W9o1qzp5PFLfc7RhU1WrPqAsy/BTLnsM7pAZnVo8h06zgJY56VPFO95odjUaK7UcHDUyDlF9vFd9ri3f4nposG/ly+tgr+J00fDMGlpKiuRsNAIcrtwsW1T47yWBEbmk0QygyQiMGnqegyN3yokPA0T44urdPvTFtLUPsfOfR60J0dZDWchbDfl1N9y2UCQX1ye1wdVbC24zQZz0hcZCrRmMeQMyNQoJsijubhthL1PZNEvZ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ho9sAejhyzUIuZ8GfOLIQlIiC9pakn7jKZjO3YFKMR0=;
 b=Bo8B/wd+11y6VEbpY1OUW552Ms2lXYktvU8CXQ40bxbaOhoa8SFEYKABuigFcnz+dVAIcO5LP+Y+uAD/OKdhyIcNOeHETNUlaCcLo+w5as4BIWCWlVR6pYp1d961U/AO2+7o9ipc0epZ9M1797vK5HkH1zffMQa2OtSAOJZ4pm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7667.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 10:17:31 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 10:17:31 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, maz@kernel.org
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: interrupt-controller: fsl,intmux: Add power-domains property
Date:   Tue, 25 Jul 2023 18:22:15 +0800
Message-Id: <20230725102215.109895-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 1622861d-a5ff-4197-3961-08db8cf85b38
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zs00E50j3VGB0Vr835XlRzYXsZ4u9tAGdfxX+FnP7P21Buy4EXxS293O8fxehP629aO2r53WgTPnMPWKHvAyfe12ryeucIo71O9VYyDgUu7odp4XRIDmiApB+gTPEbvFHNpf4NY4Sp28OvQjVk8GC8BRLJ0WeVKnspOYX+ubIzT1wWm+odUSxgezhn8r7iJwup5ryJStvZONddLYBfxbsF9Q6U4acA/FHSB+KY7CLMO6uNvtRCXdtf3MtMS4eCcDVGlc+MvTkcxo6S1gd/3lbWl2xBNppRuUfnuy6qVb6UDd2a1YjTeAwkcbY9wwRgN7tu/WdBzi20qA5jwnpc+P+46GfxZ7CklPr7B1TtxDUQkL59ZPos7KYn0+arT1bQKfLRwKYj78WtMTIcoWbxOqvRzw8jwYdEcWICa97Y/2I5OQkfa0mt1Mjv8BY0Uz5STOo+8M/SMZdF89WhEuw9rfYzE+l3/Nlc9YuG7glFE5vhQ7ATncQ+5VkTZOw/ywpcKORc2Zi2HiSywCT+vyy1tabeKDR9qL+bmvCbO9GX7EMcaQM/MjYOCbL9Af+VOtlNIZH527zViyYEFh8w+KA6SFOvw+4vMXFaMIvFcCQ2pceDTGz0OzquPbJelC6kzGbeTQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(451199021)(86362001)(4744005)(2906002)(83380400001)(186003)(6506007)(1076003)(26005)(6666004)(38350700002)(6512007)(38100700002)(6486002)(52116002)(478600001)(4326008)(316002)(66946007)(66556008)(8936002)(66476007)(2616005)(8676002)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W/z/uHS+CJgkF9fmtvVuyrjAobqI6W3P+ScgDGLpAjs+rKf27EK/heLoIBMp?=
 =?us-ascii?Q?VJVluBCGZDhJEC/pWsoFzE/GPqgzjqs/sMneiNhz+22Icoz5DKayWl9w50ap?=
 =?us-ascii?Q?rhAqgeHpMgAKalKVoXNwumca+DG5ecMEEmkXUzq//syJMeSyTMp1vWo65rs7?=
 =?us-ascii?Q?wTZaesuBjiZZP4yAWUfkKbE5L18oxVik7x5+kMoA/W9R2g0tFDSE4RnWjeoZ?=
 =?us-ascii?Q?BIWlearc07s7+ybfXQujULYNDeHTvWl6KgFtt62inGji6jTFiyxs+GafN5lM?=
 =?us-ascii?Q?yoMCz+rtgxed80DbXlDNuX5tC8hzyS01dacQN6bhF081IuiM/EFydXSyGy3y?=
 =?us-ascii?Q?/E0SmNNmL3FNFCR5k67xxTsIPMRU/We7zz+5pWawUytmbhe9NF2iOlhpR6au?=
 =?us-ascii?Q?3I+bztyq2GvU2SUlZz2AfiVGvKdqaAu1Wke38izERavpi439rYbh36pTXaC1?=
 =?us-ascii?Q?+9A4wclms3QBn+sKXXP9hBMTamrDN4JBnsY+Au5aoKb04KJSXfiN7d903ybM?=
 =?us-ascii?Q?5NuJ8PufiHAcl31sJj6Yt+RuO8HnebaF7lk8AnqYOqeh1Z1y0xwEFZs6xz9C?=
 =?us-ascii?Q?shCAwkGrHh6mC0bGxf5m+RomKaU//H91TjROpmV/5J9XNbq38r17DLCmL8Gy?=
 =?us-ascii?Q?dCBYamsNFgjYfYDPVJO1aDT3UBXq2ukMYuxQtE1lPaD9nYmxl3bDTrB7Igv1?=
 =?us-ascii?Q?b8xM4VrdJOtaLJO44OeFI+iu3Rg+5MMC166E41TTq95f6KffE4OQ+IfPN0vy?=
 =?us-ascii?Q?7p7YA79PMZcdXTuz+DrLbJ9QwB21ZzYludGXo7Sr7S2ehFsIuOX8+c3WzAUl?=
 =?us-ascii?Q?sv8yV2dgy4MKnbGqxbNM8Czg1Nm+mp/FfNjgXWm2d+XXJ6OMIAtaUTtynlSt?=
 =?us-ascii?Q?mjOpZnk4kWmEpCvdVvBo/hqpJmKr1WpjeDE1eiSVsP3kTVEBjWLyaj4JqXZZ?=
 =?us-ascii?Q?SSp6rAD7E+qOhObxry8wmS9mAzicCITxQ8Qj0+3HPmhk+8nXuvaJYZ9FjQCK?=
 =?us-ascii?Q?JcNichmWxOtIyRJ6iq8lmJmRim28wcc3tQNLtBUbCSLktGQ+J8iSmnn0gzPo?=
 =?us-ascii?Q?TbwGHDgEbHKlepOauInWCQhvaSfrqKoJvXigUDK1HWnAviDCgBOwqBOp6gsm?=
 =?us-ascii?Q?RbcEBKtS+gtOwZPWPrU38YBhkdPBHfgZCaBzu6rw4ec51aryCQyKTSUB66Kt?=
 =?us-ascii?Q?cu4UGDZwbzXsacrM6OlugYdhq5yytDBFjUxNg/c8tZZruNtKRSql4YkVX0IM?=
 =?us-ascii?Q?dxaD7od+h5DT+17Ybh5ApU+ME1JMiIsZFBwrYzKLAVzp7ideNZW+67ukmUT4?=
 =?us-ascii?Q?DObakGy0DPhvSmbE5Um3Wvuva+ZiAQmq6lrwBtwm0tYVhM671pbdLmjtUqK+?=
 =?us-ascii?Q?Ae2wsZsV+K6oLSOLqlbS7nyytUEIs2qC3rQ1f4b0qbzan1t5sbZvvlZ4rPBh?=
 =?us-ascii?Q?8FIbmSzrL2GE6BWqNJfPo4sRr5Nh5yZY5LBmhz+YgDioaZW+2kBA6ivoa7M5?=
 =?us-ascii?Q?d8+X8m01gkmdad07koaAVNOMrGrasTYEFq4I3SrzfjtWiOK0Nw3kFkJTRCzR?=
 =?us-ascii?Q?Yu/24i88QQRk+hxebdYlfUfsEUvgsM4ytdJTgUkA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1622861d-a5ff-4197-3961-08db8cf85b38
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 10:17:31.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N4XQ3ptsEa9CTtiDkk6LR/oHN9V6/ufCLrUrkrt/cMZnm0d2cseVAQ5wUGtEJvAqgVAmZVwe1IkTOy/Qj9enWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7667
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

On some i.MX SoCs, intmux may have a power-domain dependency to be on
before accessing. So add it in dt-binding doc.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/interrupt-controller/fsl,intmux.yaml   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
index 985bfa4f6fda..78baa0a571cf 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
@@ -37,6 +37,9 @@ properties:
   clock-names:
     const: ipg
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.37.1

