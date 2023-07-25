Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2108761078
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjGYKS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGYKSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:18:50 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2060.outbound.protection.outlook.com [40.107.104.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672BB10CB;
        Tue, 25 Jul 2023 03:18:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gkUK4O52fDhj0HGWncv/vmFXOTgk9MDQ3WtMyLCKzkBxB0ssw1euFg7xyu81nGqtSOqlwoRSrcqHI030Md8y5d1x9RRu8P4tQlbJASY1i/IDEceKr8Yf3fDzHMweMbjrAzs5KXkzj+5UEKZhRUCH8hP2pg6K3zQOH2OdOLHrgoW/YJP7wctU3MsXYekfPJdvdsWL6D2GGTyq7EUJ8P/L+bZ1xCvJJoDHjCt6+aQAXQ03CH92Iep14ihC4qMcQ7hj0u7CI4W9kqHwuePJMMkxB76454SBWgWzrGC8QtUOCeq33D9QeuoplXQWKUffL4Nhs9DFiMS+VtC+EFQTdYLgYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47V1T6o081l3PHsAKU10y35PkTPNI7kR9lQ4V34diZA=;
 b=bhOz3VsyCqmrnLqWPokvzHFE6uv69aaXlmhZtQqVXy2zvgT4IOwIYYtP7NNRtbIsen2t9r4Mqti3R7JlH6OJe9YeFaVDthFVbKMNaJAAlB6+eBPdZ/pta0+Q/6hdYeBr+M3sbg8fLrj9CcisSOZ00qRkgSqJL8RtL8gImCBJZP2+gwrFFU3O9xvtdz6iXdYIdSN/WWh5xt9VJ5pgtjr7N+XoWQHQKr17QfmvbP6cM18XlpR5nR0jhlilUugPR7Vo5ZOXB82Vm78MSxp95etMadHH/FLqGifshYop3LkT6B4Yx8wozK+O/DDVIh76ryiDM9OCCUFNJai1G8rOEiSz2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47V1T6o081l3PHsAKU10y35PkTPNI7kR9lQ4V34diZA=;
 b=cvqrMDiYW0RkaIdlLw62CnqERD6Kqnc3wmknSymLzwIQfTdzWLWEFYjkRqt7KzSG7uknd+10cRObtBDhyePveLdUBORx0T8sLARHaVxRHikSEvvL8/vcp72/B7qJJ6KWngYsQY+514kOK0z2EhjzfD8v1daL7cMYNaBs+8hud3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8562.eurprd04.prod.outlook.com (2603:10a6:20b:421::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 10:18:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 10:18:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, stefan@agner.ch,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: gpio: fsl-imx-gpio: support i.MX8QM/DXL
Date:   Tue, 25 Jul 2023 18:23:30 +0800
Message-Id: <20230725102330.160810-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: d3c5c056-bf7d-40a4-4785-08db8cf8876e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8v5UT8oiCduDzXIHAaUlzCPAtTB1K2pMTWeQy0H3jCO0eSUSFoSota0p5u0ZWP5vt7FEgcK+8wDba+EkgmJFeUUarBwD9RpzRRQRau24SOOf1r1VkLEHj1/e3fvcRx1rxu86mzuwR81cAzI4l6j+yltymjf+wArBZSCMOqV4yS0MCbL5RkxEHBeHyfX3fWGtINw9Ymhybkg9xtAYhgbM+uOC+ypq5JG6sppr3HFCbmT1ZoUAmZpZeTGV0rspxbDdC76TJ7MPZMoBdOIykJVfH1fg/Idcd3bIWkY/Zi9LfYZoZ/WavL3PI+g6tm+Ey8y5Qq8/kKlU6L0TWPDvih+3G9dD/Wf0f8ZcU+JwhTpI1phF6iFzjC6EXy5wt3mP5ecAhUsrx3uJb2E4VcPHmySsyR4mb6OgQqDu4z5DX3z5zl5MjkVJ8VbbViDTei9Nz1ngvg8u05uqowLzYu+dly4maT03imq/I6wC7ExkP0x2z52//DsX8WoExscIJ+oh+OH2RxxseP4XyBK1FnSPPQd0tbevyfoDrWX1RyK/gVwQjWcns9UPXu520rFqrx7mCvrNYFmWFIE8lmzVSJCV2qZ23re9ahE1SFL3C4RaBXWyO3YItVjCt73zVdu5E7MaG6S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(451199021)(4744005)(2906002)(26005)(1076003)(186003)(6506007)(52116002)(86362001)(4326008)(38350700002)(38100700002)(2616005)(41300700001)(5660300002)(66946007)(66476007)(316002)(66556008)(8676002)(8936002)(7416002)(6512007)(478600001)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1QI9AE1Q9kyV0zdgIFCUq1Gio1O/qgMKs7Jz1iOZq/HnxCGpB5ASfMQ6pqyP?=
 =?us-ascii?Q?TcdWrFd4Vhxr0AXUbYsUyW6clNgdTCTP99Hhd+UYvAgX1K8CclyC5z3E9HGT?=
 =?us-ascii?Q?b283aBV5lSpCxlWEUpHwJ4JttVaV4utxGIYTsvkvYrtqpgtnrkhj4kvxzhgh?=
 =?us-ascii?Q?RxUATO6z6THt/D8lMDzsyp/rOR7UpvGxTpD0lKyDtymcW0wQqBdwuGxIi5Uz?=
 =?us-ascii?Q?3m7S8jpeeEEURMcs1C0u9tMe2kJc7/olZ5MsFhGPMAbJd1D75QO95dMjZsbn?=
 =?us-ascii?Q?zoqGITyUaLSLbJn5lzW+ucLG39dyk3TAv3qLGA0+6LN1aj8gMG0NYW+INeQP?=
 =?us-ascii?Q?t8qkrK6qYSsFvMjq0I6zaJkMNGkFqtu9343lW1o4bvvA9GhcfXOJpl3nRfxt?=
 =?us-ascii?Q?QzGR0vb1R0S4ivH93HPTEb5gOtLZ6ADiIySpYF9hJqwwp7vBh/TiFp2Qfe7h?=
 =?us-ascii?Q?f1z0DY4KXssPHg3jJwL4gQg8BNkweEI/AdTaNtflknx6hfg+k1OAT/ooHIq2?=
 =?us-ascii?Q?0FhK31+2xEIMLb+rUlT9wFWuzdc+vDJxF2W+Xab1iGolj03BHYsTp6a60Kka?=
 =?us-ascii?Q?Du0P9dNjdjjZ/UCJHiEfNlIV2Yd0vxxP766DUEeq1zYSzPvtcQr6XL1KXcJz?=
 =?us-ascii?Q?Ny2FrXMivviCMjkK9WiqqS7yVnb6QbosOlW9EoC8BFGQv30/QTmX/2yvs2TF?=
 =?us-ascii?Q?3KuhL1nOT3V6Dhxe0BzN41N90RD/ZYOVrEVCDBkRT3+hFNGb40XO3JNnzJMu?=
 =?us-ascii?Q?YfDYThtLo8mxCboKewUPAMcw+kXDuGOCO0BExik4buhHeO4LzjlblKqGlnRp?=
 =?us-ascii?Q?kx48yMwJpS5/GLFNd1UfG2pUpxPvtQKqd1I2ZeCbKozC1O5/aoSN9WGGdn0T?=
 =?us-ascii?Q?tJcLboxlw+0W6DqXSI8ZW8k53khmYBG4gsHSFrUW3fmYkq8s5TcbG/sewyLG?=
 =?us-ascii?Q?PZ2vTVXTzS3ZVz52UwoSHQ7J3OkqsZYyvR/HotIz6nhwMDsRZhq+OaFunuxn?=
 =?us-ascii?Q?5y7dUEGO7ACRBU/QfgOZg4z9gfBU8Ty1/V/necAENnDr3Nxh/Z/MzzDiXPfK?=
 =?us-ascii?Q?nKx+Xm3CxgrkSLe9/7yBVRPUg4ToM/dp8mOW0EuwP5ufJsgC9MXOIYuFCY9/?=
 =?us-ascii?Q?gS8a0GPTdJmIJmjkQraRbFSJBPwj4LBMwyJnI0H8gquqU6u/y1t9ysvkWwdM?=
 =?us-ascii?Q?ytgFn+lVnsdQ5WIgrTQMir2xrjqCdb9t8npLZF04mU5B6Wl/mE6UMhRtyXR+?=
 =?us-ascii?Q?BZrklBXqzG4a8z2bocsVCEFNVix2WPdmLmML305Dkq7cTAqKhhoTPtt8qSUA?=
 =?us-ascii?Q?j5nkWBCAmKHTfKMLF7gxm93bqYBpVtfkcg2OJza2jfVZ/jBcErnMx2VV6a8Z?=
 =?us-ascii?Q?muNhdKlGBazvUfhnqYR9ujqowGsh/uQL5OIC45SKsDhcjM0gUaYNEQvGxHJd?=
 =?us-ascii?Q?eC1O7ywQf242AByRkPNbqhmTxl2EhHLwrcfFs9QSuqYviyhidDnU9GYP5inp?=
 =?us-ascii?Q?Jo7UC6RFGHcRFQJzM2eM1KVNtlxioDVIpNLRfcBA58U8+ujn7dvRBCfOWxxb?=
 =?us-ascii?Q?rFPzy4/O8i6boyor3vgthXP9IrerAL8y7OB3hlAJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c5c056-bf7d-40a4-4785-08db8cf8876e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 10:18:45.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFy6O0mhMHm/FoIvYi7zAS9yrmLKePDmj4DKxp0eDgqVWCCqJiZp1w/KJu/qclQA84Rvnquharkgmmbwxhnufw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8562
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8QM/DXL gpio compatible which is compatible with i.MX35.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
index ae18603697d7..d0ca2af89f1e 100644
--- a/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
@@ -32,10 +32,12 @@ properties:
               - fsl,imx6sx-gpio
               - fsl,imx6ul-gpio
               - fsl,imx7d-gpio
+              - fsl,imx8dxl-gpio
               - fsl,imx8mm-gpio
               - fsl,imx8mn-gpio
               - fsl,imx8mp-gpio
               - fsl,imx8mq-gpio
+              - fsl,imx8qm-gpio
               - fsl,imx8qxp-gpio
               - fsl,imxrt1050-gpio
               - fsl,imxrt1170-gpio
-- 
2.37.1

