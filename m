Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7007CAD67
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjJPPZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJPPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:25:11 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2055.outbound.protection.outlook.com [40.107.6.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911B4AC;
        Mon, 16 Oct 2023 08:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y72Q22VhM8jlQBnmH0vyFM2EatN+oR1GQqjcVVxE/eTsWHsSDvWU0b1UFfs5TH3OgX6BO7/MNA57qwalYt0TKMozVOjdm42lwn0ygLbx5rwIv7T02RQ3zyX93noOU9dI6NLBdidiYco6mRoDsYCD2JprmekLhVwMtKpT9PadgPj7O16HsLEH2LDO5Yg/OTDFctQK9qBosWfE2erFPzfuj4wyxeRBrHc0GFwqA3gnwp6eO/FSrmSKJHupb5Y6Yutvf9qwpri4eM3cSEPfI/I+zrJrd0QD/mp80BKwLWlb8cEeB98KZpVN0oVqXXGCwLcn2jMtDC8+QRDEKNuAopxuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trVV9USWD4xPQtUqV3CYyFL27JsRPY6/ZwQ10W859wU=;
 b=NSluX9uIYisNaQqz0mWAqs8VDvmXBF2pLCDuXtI/7k0lTetp0n2+7XvhA5ifeGS8NQNn/CDGv2k7zZH7KVq7zDJaYXTxSS6KcF7fPnAFFs3O9ZpCfJCddOJV/xwHWu5+k7P4xseBvK/OT9AhJxulLvQVGUI3LOY6QR3cleq9cbzLmhe2sp1vHm+pTwcfkXEOkHttLB8hEdYnT604/OO0KVSHkBUqgDXQyThl/op+TBBDT3EZEN9AthAHLMELKvwlB7nuvEn2X1brbVdtGiG+d5Ai0ic+Rmm9MZQ7YNyyJ9Yp72IllWReopRQUUYfh5OLxBRC7WJKMdiEQaE/8FcvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trVV9USWD4xPQtUqV3CYyFL27JsRPY6/ZwQ10W859wU=;
 b=qpv0EGusteIgJatmmC6wRFlJzBEcaFZACN9x4r5P8F8LIa8y/+x1RBxNwO5bpH3+mfDR7aIKh4JLwTILTdPUfcAUwAevaxUqOAOevDa5kBqtZZyy+KgtLJ/fmE7WrAkonOrVIte3xiGMrkZpwH6surPNQ6sxxtLBNOUsVsBlXCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 15:25:07 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:25:07 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, joe@perches.com,
        peng.fan@nxp.com, alexander.stein@ew.tq-group.com,
        haibo.chen@nxp.com, ping.bai@nxp.com, xiaoning.wang@nxp.com,
        Frank.Li@nxp.com, sherry.sun@nxp.com,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev
Subject: [PATCH 1/2] dt-bindings: i3c: Fix silvaco,i3c-master compatible string
Date:   Mon, 16 Oct 2023 11:24:49 -0400
Message-Id: <20231016152450.2850498-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0069.namprd11.prod.outlook.com
 (2603:10b6:a03:80::46) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e4d6e1-4c3d-4b3a-ff55-08dbce5c13de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmMsqhYXkuJhixDIzxTi1zAmPBFBSit3wDWl1VQtZsvK7UgJyPGRPZ0G5kWEkJHH0F3ZXM0zF74Ujb0eMCd7sTHRHurJNK0KDf2wSVcy209Lrv0WtWC0N8SzRTgUIa/naQeKWo/0z8zAy0K6uS2W7Qo3KHrZQ/IleNwbaQNW2N49Cw2KITDl++J3e8gR+iQRiM71UyJ8PURhF3j6aOhDlTkQ22Sn7DhnGULRfe4ynAIJA3zULjGI/FxQ1g3oho0lhtuZ2nMLqxgmX/iceXDXLMc3ertT5GAxBK/kabgvU8YRbavIOTbMWwRifEvwl0LMw6gTmxk6xPJAaPoZjW3PZdYx+GO6EjjYQZj39TsVCDZd4+hyebH2AuCbOUDcG36pTPdf3ToDVTUeztQ7sVk94J0UcaiLrkbhVlTlXoqBotOuBzU5iGzJbHLY/d7mag2naGuuEd8Ob0JrHdKgF64KxnBO2zRBBWr+TSRk2Or9c8qGdmQWKQKC/HxHroNut3tbMiLYcmsxHVpQWtgfNuzmqDK5Sg6iltKF/9P2XPV4nNBY5gzoPqLhYRMhOq7Q2rffjKDdMCqgdJkobvOyn16jOoEamCkQi2cVx8duAkSD3VFF+JVStD+GItikvA1vukStKAHYnM6e/pwwUa10YCRrCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(7416002)(2906002)(4744005)(5660300002)(41300700001)(8936002)(8676002)(316002)(66946007)(478600001)(6486002)(6506007)(6666004)(36756003)(52116002)(38350700005)(83380400001)(66556008)(66476007)(26005)(1076003)(86362001)(38100700002)(6512007)(2616005)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gYmovskGw+hSJ6jJ4g85RXHr68FmhgA/netnU/Gdp0PqvqnuRNJX+Owv/Yn9?=
 =?us-ascii?Q?/uPAuHgZIsMv3W0EkafJ8R4kICdThgQUBSIwsCWOhPEKgTnGBqFwyoZzN9FI?=
 =?us-ascii?Q?J7SAxlt0K/vMpT3f13SBMfw/wDYXfAyWt48+UgrXOG5dtlEg3iQOud5ERfbS?=
 =?us-ascii?Q?fzMxpTg5a1ZNziBPEhtNxT/RKxb/deKbhuCD8xqSNsdEIAV3BX58QAPbrqkv?=
 =?us-ascii?Q?UcI+pmnWSy6DcZc9WRfzmVe++e5mg68WFtgPIvWL5SqBEX37v22poHWwoXn2?=
 =?us-ascii?Q?QcUKPytcDXPoI02qMM4xD52915GDztRQtnCoUvsOqyEGB9ySISpUOSSk34NW?=
 =?us-ascii?Q?rzB6lS4oXDH0o0lsjdakm+49/LwCIqeq5XW9FhFmn9lbLRcrVkl/FpSaSgdH?=
 =?us-ascii?Q?DqOnpBACyJ/crwultezA2xqKfAMAUojGPca1XjrztVh9xFzFQMEtuayHB+uL?=
 =?us-ascii?Q?EP5Oiaxx74wR4eeDv07N6kAD2ohL6+lpYj+5X+7+Svuiv2Q2j84LcFW1yCO9?=
 =?us-ascii?Q?Z+/BQgadXlpngTf9gax7A5SaTAlqNaAf/xZvPMsLpOfgQhiOOnltp9hy2Vb9?=
 =?us-ascii?Q?S9W9vvvIaLz7pfL99SGVsAjNCKVUsU3GpRUTfGAi+Mmz+2ZAWhd+69AuobfL?=
 =?us-ascii?Q?pSTn+SUlZfJXMpsGWM1b64uofmhF5/UzapqjXUW0eKJ6f56n6ZpA9561UUgd?=
 =?us-ascii?Q?QyoEJUtlNQK9XM1djKYEhfIBVA2MPY8vDDTIR4k7qJt3hyuPEWCe9kGuFqqp?=
 =?us-ascii?Q?cemnBlnYUQeUNB8+SFbEEi6WU5hmBq6CxNnwsDg/wa6vS7JXHoYTjXrqshEJ?=
 =?us-ascii?Q?Ii2VXJ23G/UvkyRMg++YbR8Sk1cKUi6e8d+vgTwDn1+VpmRXwpZQeotkYvKp?=
 =?us-ascii?Q?n4CrJiCnyFvYutRX2H6XF+oKiPzSMAeiOMt57HBOziNm6imbf31QBcGnGvyS?=
 =?us-ascii?Q?mlg9ouIrTPYqomAgY35XWIQJCikn7zUhaVyYjueGUG2hwZ+7pF1ZY9SscTh9?=
 =?us-ascii?Q?wtaAu8d0U2G6EUE4AL9ZzN8WZUkBgVlV7Gkb5CfMOsS0gQumNfpbFTp33AGN?=
 =?us-ascii?Q?nWGAzO62sPxyFekxb/sahS1ESQ99BOhfHOiLjrTL8YyonBNL6ixKMT0wwalJ?=
 =?us-ascii?Q?hSMkBS9pstfelpkdVeoW8ZBOQXPda+7ACOiv6g8whfM8J5Feg0bZDtokWXOp?=
 =?us-ascii?Q?vgSyWsB3Sx+/pvQBYhq9HCzDl1DJaphw8Ng3dxXGNWD0rSfEnaKAYAFaPqOh?=
 =?us-ascii?Q?nlBINslYruRgBDIcOsEsxb8PFCLs1hVs4oCl437Dc0FOkcQ3wlDxOIOYPRJa?=
 =?us-ascii?Q?2EXGvBlbPTYwLZ16GU3i5OoI27p+Oz50Ug0LNJgOJqh7cmcFsEwbIWHu+r+a?=
 =?us-ascii?Q?/AStD1yaAKuPE09H/nUfjDvblDvKdMymw5yxnJKl8YaDcD1FLTJ2xy2CEFyj?=
 =?us-ascii?Q?YtA5Khz3oxjTobiLzepFxmxk4FEhHRgtbiWsMEwdAVSxS/6MysX9getQiamc?=
 =?us-ascii?Q?C8tpxj/9PsMmbqTefaPw8rxLXd4WeZ3GlY6wjmdoIfXStNN2GWaf0ldVFHHv?=
 =?us-ascii?Q?FtSLeYdiPeVCwEVzsrZ9C3IhcsBacOv4VIM9lbUr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e4d6e1-4c3d-4b3a-ff55-08dbce5c13de
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:25:07.2086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVUv6+wpv1dmKPsyPhv4AiglxiNjvRZbTDv6NrIi3+RNytbQs/XKQdhc65pxtk1BADMfPxjYPGFNvogJ5zo+nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In driver, compatible string is silvaco,i3c-master instead of
silvaco,i3c-master-v1.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
index 133855f11b4f..19e3f75eb45c 100644
--- a/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
+++ b/Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
@@ -14,7 +14,7 @@ allOf:
 
 properties:
   compatible:
-    const: silvaco,i3c-master-v1
+    const: silvaco,i3c-master
 
   reg:
     maxItems: 1
@@ -49,7 +49,7 @@ unevaluatedProperties: false
 examples:
   - |
     i3c-master@a0000000 {
-        compatible = "silvaco,i3c-master-v1";
+        compatible = "silvaco,i3c-master";
         clocks = <&zynqmp_clk 71>, <&fclk>, <&sclk>;
         clock-names = "pclk", "fast_clk", "slow_clk";
         interrupt-parent = <&gic>;
-- 
2.34.1

