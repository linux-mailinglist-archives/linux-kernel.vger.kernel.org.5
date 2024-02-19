Return-Path: <linux-kernel+bounces-70723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683E7859B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA29281A46
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C45200B8;
	Mon, 19 Feb 2024 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WxesPZ6y"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753CA1CF81;
	Mon, 19 Feb 2024 05:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319668; cv=fail; b=dkawiK2BrxMfBoduq43apynD3bbWFoAY2FIBsx7Mc6Imkj8PYKan5ODdTzX6HjSyiV3Ns0GkePDEqL5ilA26XIPnNXr5pLTAHOxt0knTXyr8TRrB+BI7JRjuVpWoVDXMTYV7sjocHiMwiTiBnb1nocAz/63e3SKr3zzNaa1LJg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319668; c=relaxed/simple;
	bh=MM4hGelQPWJBCNSBHauYYOUJtAGkks0oEt/r7CVecMg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pJfR9YgE84CMmuwI7B7F1kPkq62P33fIJDSMaevlrIqFsL98+wUSMZnAjpGXTU4bbigmWiRcL5XrmSlmh9IoZQ8TA8O3U2/XEABJP8aO8wt0qTtRCoPO22toBDXGDGYv0ksO1iJSw6KEiimQ9Y4k/9nefcgqTcKbpIxloMxvDvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=WxesPZ6y; arc=fail smtp.client-ip=40.107.13.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvduVTptUOrSloxS1V4ej6XVP8fyu3j6ExTRwgLViCde0Qu1nIZETbV3KyPivkINqeOYkmDjMHxnATKWymoIsAgz+K8JIL42Ej3oNJuVYL8RpZMgbJbGpQVJKKYpz4rPGU80jbVFjbH1comns0gY8NxahnfnqHBcIq+rtmsZRnifv7vbknaAWstbG7t1rJUG4LcZ7PcEEiW2suz2Itj9HEfi1DQ6UKJBiijxjkbCtoXz9ubikOk//YuHhjB4ORnzULI7a+DftW4ZCeDmH3oWp2U+EcTlR9ui4EeAC/FJCnw6GCYtu/+zPgfpBD2dt9GjF48PDLL3K+el8kBPbJclpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KvOi/dUrQ1BiOs5m/DkXp9FaTqjukDIJmIW7LA79+g=;
 b=UyaOKh9BpXvsVIdD0qsZQvDEdYS8HqQhjvBMD9pmC2qGDEkFGwHdVjHfbVdjTwY+ql8EQM7pt3GcHsJuTeSyR9OIOQNW2MxC7Aj0qaiLP5jR557btSZNzqfZkF4tyjH5RhORk0ZFbapc3xLvVpDgEFoXSw5SN6AECUYRNdGRP5955FDe2cF0fblq3wLEKHZWwM3M2UlrIPYSvOc/75xLP3D7/wyZ/2JAiDjxud9oHDFfOJ7W2V47OePUgFno+P1PD3QmcSBuluacFaPAmX5bHTgh94eqmN14EkSuQogQ4H3EdDfb1mgSEq4OzTDmOjTydrUb+loudt0lKesUIivZgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KvOi/dUrQ1BiOs5m/DkXp9FaTqjukDIJmIW7LA79+g=;
 b=WxesPZ6yxzK5ZSya/OMygVANp3f6S1E68fP/nDcEuyPj7G1dYKCnQjg0wN84ZTJvm9dVHw94l3ymmTwSgz5yTCRa7ZtGbqGxizmaqWdla3MUdjAb0AtPRAH6gXr/maQwItTjNuj813cQuIKD6ZN5UZHmGqYr9G1QZuix5+tF/rw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 05:14:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 05:14:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 19 Feb 2024 13:22:36 +0800
Subject: [PATCH v8 1/5] dt-bindings: mailbox: fsl,mu: add i.MX95
 Generic/ELE/V2X MU compatible
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-imx-mailbox-v8-1-75535a87794e@nxp.com>
References: <20240219-imx-mailbox-v8-0-75535a87794e@nxp.com>
In-Reply-To: <20240219-imx-mailbox-v8-0-75535a87794e@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708320164; l=2741;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=C56rjccJP8TyE3Eb4IvcogQQf1ZEIotnAVpBDSA+e98=;
 b=3V0SZKQi4H/ccrA6TpxPTRRLuUcugewNkF5BqXuBFTIiYxKOz1wqbVmC3hJNuBvMh5i91ENSE
 +64+thDuENhDkzvWRdecPmCHCruO0MnNDour6Nus54CqOl3Hl1nUboI
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PR3PR04MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: e370c039-7e82-4aab-9f48-08dc3109a3a6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jOKdzU3KEW2LQm/ZJXRS2Z+26bsxgrOV596PTaP0OIdPy8o765hfgD60l1wNu8yty3nNypNZ84PDc7bNUyYyjISJfEHxIcWvwJ6SngQRCgASEpjOpIcHuR+PmdJNO/yzdjbkTSaqEGIgTuoSDp+0tDpMNqmdonZ1DSGf2Inp3XOwD3ltuOo7VCQqGRSgro/4jyngRJb0Q86AqQzS92tRQBsgkfY8x627ycKdkSGl9jtUVbc4FyT6d+O/vJDHS0Wb80L9rUFVqGfrJ4mz3TzCrQdixosqKZKAURxI9PFYl2snNpRKqNCbsVzeBIj2rzfeQEXprzANF6yBeoOMwSsEdtxGEhn/mgqVUP2JLwKHhsIdNhq8ppVIm2OMaK5an6VMk95d1bcnUhP93K2AEg8eFmAGFmeE6EThQRkphragDl0x5aP0yzfjAQw0ntlKErU/f/m0hrgkVA5t+FKZLvbrXRdMIoZHVvyqQQSJtJjq7TFcbRy/FcDIBYW27svXrLdiMJf1zhHGeuWUl80uHkiC8SjJ0OPCwAILiOCpPfzV9mk7kSOgH/pnbNCMiULwQalR77GqqiZ2+6ni0Yo9FcjB/1x1mLpYZeeZi45362GyEJ3WFl9F4Mvfz3YA+m9EFNrKhvkkbkKFEGK+9/fQP6FoyQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(8676002)(4326008)(2906002)(8936002)(66476007)(66946007)(7416002)(66556008)(38100700002)(5660300002)(15650500001)(86362001)(52116002)(6512007)(6666004)(316002)(36756003)(54906003)(6506007)(9686003)(6486002)(921011)(83380400001)(110136005)(478600001)(26005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW53WnpVZ1pxc3NCY3o1S1M1clQxS003MHllc01XSFBrSE1Ud3JkWlFrSXF2?=
 =?utf-8?B?OFVsMWhQT1NnS2RmeCtieG1KT29DREdzS1JGcUFuQU5rZll1SnNrNFEwSU5D?=
 =?utf-8?B?T3p6RXhZSHY1bzQwdW0xVFpCbUptVHlvak9reDd0ZVNuT2ZhcDdIZ2VySDA1?=
 =?utf-8?B?aHlTWmxVWXRNdmdtc3JzQlZkTEdHMmQ2Y216WlFoTGlVeElyL3pYNEFocVE3?=
 =?utf-8?B?eitTZXp5b2cwa0dpZ29IbmpleXBBK1hVMkdPL3NleW13elFDMHB4K1JleWFZ?=
 =?utf-8?B?dHRYSWlOVjZhRytIZkkzUjFnb1kvZ3hXbEpzcStHVzQ3eXpTaWxaT1lsMVZw?=
 =?utf-8?B?WHQvV1NhL1k5cnF0ZzZkZ3ZjY0pTUmJCNXBucWNwV093NXVLYWhJL0IvZTlC?=
 =?utf-8?B?dVZwTDVYZ0txb3hzTURvZVI4OThabWtITDBNVEw0OTV1dkxJeU9mWCt2dUQ4?=
 =?utf-8?B?N3J3eEVaRnVhKzBPVGFlUVVpaFRWYnQrVXA0QVUzVWVzVktUNmJyQjN2YWh2?=
 =?utf-8?B?cVh2MWVzT2lid283TVg5bWpwZU1hR1NhU2JqWGIyL2M1QnBUR0NSSHd1aXlq?=
 =?utf-8?B?ZjZXbFljaGVVQmllc0Nhcmg0cFFTWW5GcWxHczRSd2MxMzFEa3BtTDBGTEdR?=
 =?utf-8?B?eXdmMVMwR2Y4eFNBQmxzREdDUGlXTGhvNnptYTJiblU2ODJ5NDJXdHd0enFZ?=
 =?utf-8?B?aTNhZml2Z2NETC9VbjM5QUI1MzI3b0FkbnFVc1Q1d0FuS09vM3JPdGxPKzhT?=
 =?utf-8?B?VlhJV3lTT0tMK3FVRk9RNUVsVFRzK0JJd2d4MEtmNTdiaDM0TVpOVEtGdThR?=
 =?utf-8?B?eUJiVjBXRzNkS2lFMWNsYmV5RlFEdXlFVXNQUU1wVWdnN3NDaEx1UnpOUHdV?=
 =?utf-8?B?Z2ZBZ3hhejlmdTdZckdiWDF4T2crbE9zOFkxSEhXZ0pLWHNXVDMwcWdSb2Fl?=
 =?utf-8?B?NTdVc0dOM0Z2WG9iaW12MC9TZ2tLOXFZWXczSTFKZk1hOXllWjByUkxtQ0Qz?=
 =?utf-8?B?ZnA4NVBZbDlkeGtUcllpRG91MmRNS1V5ajZzRlFEWUpKdXRXZ1YzeWErbnlp?=
 =?utf-8?B?TXVIdHNDMUkzQXlQWWZjcS95MXdPbWFPNVY2YTc4R2JOcG9xMk94QUJlSkxK?=
 =?utf-8?B?aHFON0dmL1NmWUlEYmpOUXVYWmphSkNtbkVBUGRtU0NMQnhFWlc1NzVZelp6?=
 =?utf-8?B?L3I5M2twMHV1N2lFMDRvdGY3akMyQW5JSUdYVHl5YW9vT055RlhCanMrZUF6?=
 =?utf-8?B?b28xaW1JWDBUbjNhMUxnMzJ2dFJXMzc0enN5YjlhT244K1lYNHhZZUd2TFdV?=
 =?utf-8?B?cFFwU2FFcjlYTzhuYXBiV1NKT0V6SFdGYzNadFRiTDYwSDh4QkUvVlhnMTZQ?=
 =?utf-8?B?aSttZU1VZnFXUUExR0x0UFNvdzlGNFQrRWpJR0FiNUlURkYvY0w1M2xEM05X?=
 =?utf-8?B?MXlPajF4RjBqbEdsSWxzRkJsYWZ1L2FlRUlQVGRmNFhQTGx4UldyV21PMEts?=
 =?utf-8?B?WS9yQURib2FiRkxzOUMwRnB5N3RtaGpETzR1NG1IUWtDemI0MytvUXIxSDBY?=
 =?utf-8?B?aWJ4UTlEcC9Pc1Q4NDhCdEo5NlhDY2ZjemlQL3lBMDRvRkZPUXJJVERNZkhL?=
 =?utf-8?B?SW9PbVBwTjFvZWFKbmJIWXd4NzA1Q3NxQWUzTmlkZ0NFM3Mrand0dHdhVnBt?=
 =?utf-8?B?T09pdmdBQW5TSEZ3WjlOWVpFZncwdTNHUVYwSWFma0JnZWYzakZvK1lHYzI5?=
 =?utf-8?B?MEJTeFJyL003QzhOS2N2OERnRmlPQVdmOGJNMzdrUDY1eGxjb1F2U2lKYmZx?=
 =?utf-8?B?Y05tTFdYTVp5YmxGY242elFjREE1eDNrWW51Q3FGTE9yMDYrU213NzJBenFL?=
 =?utf-8?B?OUNMYWJBZ0NmSzkyNTFMYkhuV1AzckhQRXJDUUxkUno1NndXUC9CTC9nOXZw?=
 =?utf-8?B?N2NOWG53Q0N0SEgxa2VsL3NCOExjOW5qNUpTbUx4em1RQXp1UzBoZFlrNE5s?=
 =?utf-8?B?QmJNQ0FXdndvR1Rqa20zaFFCc0UwbjZKMms1elVkTGx5QjlVLzMxSktKYWZt?=
 =?utf-8?B?aEVTVE91Q0tSOWw0ZFFEaHk1emp5RXNnV3VGdVhlbUdQdzVOSDN5WFZGZWhK?=
 =?utf-8?Q?JXx85MiBa6n3cegh6K8S6ERY0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e370c039-7e82-4aab-9f48-08dc3109a3a6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 05:14:25.1165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ed4dkGAQEYN9a9O/2Vmh4MRzQbCiz3mb0siPvYncEkafazpu9ylhD1b6D21cFMR41vn9A74FDQHJTml0owYsKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 Generic, Secure Enclave and V2X Message Unit compatible string.
And the MUs in AONMIX has internal RAMs for SCMI shared buffer usage.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/mailbox/fsl,mu.yaml        | 58 +++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
index 12e7a7d536a3..00631afcd51d 100644
--- a/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+++ b/Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
@@ -29,8 +29,11 @@ properties:
       - const: fsl,imx8ulp-mu
       - const: fsl,imx8-mu-scu
       - const: fsl,imx8-mu-seco
-      - const: fsl,imx93-mu-s4
       - const: fsl,imx8ulp-mu-s4
+      - const: fsl,imx93-mu-s4
+      - const: fsl,imx95-mu
+      - const: fsl,imx95-mu-ele
+      - const: fsl,imx95-mu-v2x
       - items:
           - const: fsl,imx93-mu
           - const: fsl,imx8ulp-mu
@@ -95,6 +98,19 @@ properties:
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
@@ -122,6 +138,15 @@ allOf:
         required:
           - interrupt-names
 
+  - if:
+      not:
+        properties:
+          compatible:
+            const: fsl,imx95-mu
+    then:
+      patternProperties:
+        "^sram@[a-f0-9]+": false
+
 additionalProperties: false
 
 examples:
@@ -134,3 +159,34 @@ examples:
         interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
         #mbox-cells = <2>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    mailbox@445b0000 {
+        compatible = "fsl,imx95-mu";
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
+            scmi-sram-section@0 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x0 0x80>;
+            };
+
+            scmi-sram-section@80 {
+                compatible = "arm,scmi-shmem";
+                reg = <0x80 0x80>;
+            };
+        };
+    };

-- 
2.37.1


