Return-Path: <linux-kernel+bounces-37972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 603B783B8FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 06:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B72D6B246CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 05:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDFF10A17;
	Thu, 25 Jan 2024 05:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kBpDiFno"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2049.outbound.protection.outlook.com [40.107.249.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD33E101CE;
	Thu, 25 Jan 2024 05:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706159758; cv=fail; b=SSekxvp4a2ISDAQ2hlkp+0rfoLwi0qDa35Wu9OPIgcNM7ezVQU5PwgyNRc9r9nDAcR63N72qnjRi7+a0rlGlnqo0wb1bjN5BDuqESAarayv/9qbXNaNmH/klh3VlgVFvhTIM8oggCa9JPXAGllBShMjG7uAtzRSkO4yGKp9r7qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706159758; c=relaxed/simple;
	bh=y8d3shlmpQjzrDZ9JDw/i68gdDwSy5L/3QrefzQO4kE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=b3jCrzI4opYVUkzzOKuOTeT4yxojt1KdxLc+2ttfhhrFSv+mxi+oTIIMy2BYM4aCMmKBUWQ/S89A2pimUS33BcBAMnbcFq2SsnvdxTcG8cYGdyoI7RyW9L6bA+vwrgg5YPhhckTIRg7wbEKmMOECG90AD2Y+ooFMAydN8TVUq0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kBpDiFno; arc=fail smtp.client-ip=40.107.249.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRXlOW0OO6ZpcFyjkk7imr/GA0iQ1iI7PxdOljZjulxOtgfW0xoAnxXvE9ARo3rv1c/IOwz4r/s0HK40vtrMQWBXdWwj0bQj13rtABzuWGm3qejs15M1UYcyeX+Wvs+HpKv3KaNyEfGD6vlJEETE3Aqur4FKwIyMUBCA8/HjSNMM4qVOdtkc631UsOO2CF9qiohiwA/OARhsh9KPFHbe4WHYmyzpP56KeqK/S8+blaUqjkrtasQNlKOR/BVHrm6+oXoBrtMGbHxjhHnj8jw18IJQbtfEOB13ZNkCMrzHm/D67vliIgE4p4uLdEGn2wFd2V5jZgC3MaEHv2rRPL9Vbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee1Dli3O1FXVow7SMu8mJze7edWHgMfSVr6Wxc9+jYI=;
 b=WMc4QfAKH3Uvs4AKhEQ0rTD64Kx568D5ioKX2yapnn0D9H9gU420m2OXr7OxBQfHDUWKIfv64APUPbZ3LxwiBLcXYplejonWij+vPRUqCM9SWeYi1DaUa0PDsPVSlhN5X+baOe5Gvh51miBZfLWFGw9nRzJ46bNngHay36OHoYsCv4AbEe22DgBwpzAgtMB9xcU4jACT7FeHHhTfTRkW51TXuUy+j3wERauksiX9ZmIeUnhvOQk3hK8//KADW/4eX2ffXZl2BGy2jhLNOFUF9asUMuiYRN9bYprtCbnxltqg4S/17QF1xF+JrdMuCs8dbUlJYsJjdWmjzC129LXOnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ee1Dli3O1FXVow7SMu8mJze7edWHgMfSVr6Wxc9+jYI=;
 b=kBpDiFnoPZ5OdLTP4j/UWfWigny9U6Kx8uWczefQf+glE63eqUuUXyb+2jHU/Z5QDqh9tyqRwcZfRlnTq/t9iEkKKsP+HXlL4uj+lEvM+MDmjqLYvbFaEdiPS7KNz9nSK6dfyUHNjPFseU5tXnqh60sL1wvM3i16Bml+CI6kIcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 05:15:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 05:15:53 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 25 Jan 2024 13:20:03 +0800
Subject: [PATCH v4 1/4] dt-bindings: mailbox: fsl,mu: add i.MX95
 Generic/ELE/V2X MU compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-imx-mailbox-v4-1-800be5383c20@nxp.com>
References: <20240125-imx-mailbox-v4-0-800be5383c20@nxp.com>
In-Reply-To: <20240125-imx-mailbox-v4-0-800be5383c20@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706160018; l=2505;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=1O7B9LF8rHxMfyFadGQ/lPlfemmgygQItpOgVsQLSyA=;
 b=Xui0n8jYHYXlRs2WLw/UISbfcbJwt+2f4LAhPyqjnTwWRSzWzWfzSUp9WbYXBZuVZw88FBmGP
 WMd0XYHCuzIB8Sd+yMh1vwIgAb0X/Oe7uCdEhUytOuONZRwTd8Gmk2M
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a7632fd-22ad-4c7a-8ff7-08dc1d64b42b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q0qy3Hac6o6N1aQAryDZecBrGKa27SEEgU9hqOijoEkmTgBNYJsHs+GI230LONu/EBOHY5BsoICp5aCUCb6SJkAbuLirVCLeCP4mh082mFhkiI1coZEly9VNgfDfE3AS77aH8d4s6ZJFG4RjhVsaYmGO+CyTddnDeOA/pc+bCM1awr1yArmKsCJ2xIDMjPlArw2qdjuq2USr4+BF14vYceC2KmrZ1a0M4/rxK+jQ+ubEXBkpBXueLZBW74yk9W/Q58uKBF86W0uizovqe00qOXMwDOiTxx6GZP8abs4WPB4jPOv1o4JCOIroEqwL6IsNuKcZ5gHqANfff+QaUCtDpyUgBMrV16Tm0bcXfEjZYfRIK0euracWJzkbXblWWIOtgMkPO3yGN/f+Z+PWFkevkgBudKUKCaN85LIX8Yt2ipovdNjgYniWamBcnwVbtvzEffRwG09pewNqcIfB3NUXBoJl5UJ6nt6dfp6vEJDlfVNkZHnmVidzZ5YtLkuDN3O/cdRLg2DFDfspZbQKX77M7qk1ftgWJZ9RNr4ShVUElTjP1S7lxNdKvjNPzCpaCSR36RPLls7+cXhq+RmTR++dvRmP4mpzZAKUJ7d8Wc6RoTjS7Sr0tIpJjExzc7pSIWmrmmm8Jg9RTn5robnZKd2vNtPFJ9JeyzcKWsLJ5wyLPP0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(921011)(41300700001)(26005)(38350700005)(36756003)(9686003)(52116002)(6512007)(6506007)(6666004)(478600001)(6486002)(83380400001)(38100700002)(316002)(5660300002)(66476007)(15650500001)(66556008)(66946007)(7416002)(86362001)(110136005)(2906002)(4326008)(8676002)(8936002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVB0WEtQcG9LMG9iWDdIcXJVTm5Cd2Y5eXg0UzRFY2xHZEU1MzRhd2NKc0do?=
 =?utf-8?B?UStNa0xmbkY1YTJDZFd6aWJPWWNlME1SZjJZeURYZEk1VmdWT0pmcGtCZ0lH?=
 =?utf-8?B?bVI1WWJXS25rZVA5eStqSGtkRmd0NTVqd1RUUncyam4vaTFhVzJBdGZidStI?=
 =?utf-8?B?QldnNHFGQkRhMTBkTEVDSEhDV2VVUXBHdUdUcVg4VWk1Q1RxNllQa21Fc2ky?=
 =?utf-8?B?RjNQWWJGV3Nva3R2c2s3VkVWUDdUdTkwb1Fhb21Ob1BVbUVDQS8yeVdWMWt3?=
 =?utf-8?B?UmtkcytndTdNUUI1aE51QkRtWi82OC90R3JqSnY5OTIzWXdvbGRTcHVya002?=
 =?utf-8?B?dmhRWksxeHk0a0hpR0REMTFyRWNnZ1luMHB4QzROTFNETi85Z1NvYUxYTFRi?=
 =?utf-8?B?a0tyT3pRbEtJM1BYK1NneHo1MkVEaTZXWENRb1BKaG51M0dmYzZ6b1J1SHZQ?=
 =?utf-8?B?OWg5QS90b0hsSXNZQkNnaWRzQTRXZ0dKOGlOYXJlcEZEaGZHcEFVWE45YUsy?=
 =?utf-8?B?bGV3U3pjeE1oN29td2pNNjBWRGxrY1F6eFdCVFJWbHNKaHdjcndkNnNrMTVi?=
 =?utf-8?B?RzdnRVN4clNsN3JaakpZb0VmQUJMcHUxVm1TQmNTdENYM2ZUMkZrV2lzT2Q0?=
 =?utf-8?B?a0U2Y09SbU43b3dZaGM3Tit2eDFOUno1U0FvSW1meHZtV0hjWEtYY29kZ1RE?=
 =?utf-8?B?Y2hhUjlBS3A2cHpKZWVQcXhWZXp2NVNPTUhJa0xIV0V1TzA5b2NHcmJHYjM1?=
 =?utf-8?B?VHBKTHRVTmNPNXdSZEEvNFFQYkpLcksvTGU4OTV2MWpYcXp5SFpiRHVneXdQ?=
 =?utf-8?B?OXg0dHhrQUhqWkNuMm84Q1FTYktlQjc2YlJESysza3J1SWxYSWdmODd6djNB?=
 =?utf-8?B?Nk1Yd2pDTXM0b3FyQXpoMHA3ejROeG1QWUVxOFpJOFN3VmdPcnBMV0todkp0?=
 =?utf-8?B?bGVhRTFQcXZoZnE2YkRhbm5oTmJ2YkwxSkZNeXpSRHY2SFFXWFFKV2ZyY3N0?=
 =?utf-8?B?dEd3SHlQcTRuTVN2RXk2Zi91bHRsdHBRbmw5SlU5R1FKbUdKdERkNGFLckI5?=
 =?utf-8?B?b2kyNFpvWXVqZ2lUR2ZzNDNZcEJwaHE1MEhST202SEhXNnZFbEg1WjJZelBu?=
 =?utf-8?B?UmlBVUV6aEZUT3VBcXlESlFFbkFKNVVad1NKWHlZc3Y4SXFERlpISmxoZWov?=
 =?utf-8?B?ZllGQkJKZXBTV3ZCWDN6ZUdoRnluaEszbXlPdXRVOHRUKzlSVjFpb1A2NVdU?=
 =?utf-8?B?R0pRZ2pBbHQ4NVVYT2t4NzdYZWJIQ3pDUEYvZU9VY25uQjNrYUUwYU9QeWlw?=
 =?utf-8?B?K2VSRUV2dlZ3aDRETGxXT0tiS0JJcTUyOVljRlNmbTFzZnFjTjJhazBXd21F?=
 =?utf-8?B?MDQ5eG5KOC9EZzBsYU1RNnJVYm84a093SmtVcDlHRGtndjJ1Y2xIRnhVcmNO?=
 =?utf-8?B?TjlqV01sRnlVTURrV0QveTBwV3Z6RFdLWDlQS1U2NkN0cUZIZnlhQUVPQ2M4?=
 =?utf-8?B?QTZrVm91M3lYaFBQK3p1NmJoNVZ5RFFOZzlHLzdXVHJBUGduRjJjSGhKR0ta?=
 =?utf-8?B?UU9vVnRsR3EvTXBSd3VXcmg2MU1lMDIrS3FXT1J4a0dkZzFtbjFQOHJyN2xT?=
 =?utf-8?B?MDQrWFpvMWQ3eENwRHQ4TlRvMjdhMDhuWGUrd3hBS09EdS80OWE4ZG9DSGQy?=
 =?utf-8?B?ditHNlU2MTZUSE9vNFYzUXpuOWVXTVRtMGRJRE5wd3FrZmMrUVlMWFJZbXZn?=
 =?utf-8?B?eXBoUmZtMzIweTIwaUhxWGpJVWh6YUhzWSt5SXpjRmdSZERQMnBXOE9yc1ly?=
 =?utf-8?B?YnI2SDBsMVZnYjFiVGtrNWJuaVBqVVJ6RVhCK0N6S3BJVWJQYVNuektCekFj?=
 =?utf-8?B?TElGTHR3N1lGc0tSTVIrMzdwWHFkeDF1MytQOWhsOU1GZEVleERuNUdrclo4?=
 =?utf-8?B?elNXNUNYUHVWb1JHMERycUtBM0FkbEFmYkdPQmVEaW9mR1ZDcFVCWnFlZUxh?=
 =?utf-8?B?Y1pIRXl1Z1ZSaEJYV1BjcXROUjg5UEVjWWVXNnkrRityME1FSjdzMzU0ZEw3?=
 =?utf-8?B?MTRaYXFORUh2WkYwbmRLd1VGQU1BcFFjY2FUS2xhUmpsTmQ4eUpaUWlPamNN?=
 =?utf-8?Q?eLisdsxaN/YysP6wZCKfKB/YI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7632fd-22ad-4c7a-8ff7-08dc1d64b42b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 05:15:53.7861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNHo7Akt0IUy36IbzgCN1COYxX7EF27DjNrFeXV9SHSWFMbid4ynPzkRkMlJvMb1hi6BrimqF7IIII/35HBHkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 Generic, Secure Enclave and V2X Message Unit compatible string.
And some MUs has internal RAMs for SCMI shared buffer usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/mailbox/fsl,mu.yaml        | 52 +++++++++++++++++++++-
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 12e7a7d536a3..86759831b24a 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -29,10 +29,14 @@ properties:
       - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
-      - const: fsl,imx93-mu-s4
       - const: fsl,imx8ulp-mu-s4
+      - const: fsl,imx93-mu-s4
+      - const: fsl,imx95-mu-ele
+      - const: fsl,imx95-mu-v2x
       - items:
-          - const: fsl,imx93-mu
+          - enum:
+              - fsl,imx93-mu
+              - fsl,imx95-mu
           - const: fsl,imx8ulp-mu
       - items:
           - enum:
@@ -95,6 +99,19 @@ properties:
   power-domains:
     maxItems: 1
 
+  ranges: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "^sram@[a-f0-9]+":
+    $ref: /schemas/sram/sram.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -134,3 +151,34 @@ examples:
         interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
         #mbox-cells = <2>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mu2: mailbox@445b0000 {
+        compatible = "fsl,imx95-mu", "fsl,imx8ulp-mu";
+        reg = <0x445b0000 0x10000>;
+        ranges;
+        interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        #mbox-cells = <2>;
+
+        sram@445b1000 {
+            compatible = "mmio-sram";
+            reg = <0x445b1000 0x400>;
+            ranges = <0x0 0x445b1000 0x400>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            scmi_buf0: scmi-sram-section@0 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x0 0x80>;
+            };
+
+            scmi_buf1: scmi-sram-section@80 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x80 0x80>;
+            };
+        };
+    };

-- 
2.37.1


