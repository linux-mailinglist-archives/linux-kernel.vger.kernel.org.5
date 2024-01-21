Return-Path: <linux-kernel+bounces-32002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33354835527
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F661F22097
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 10:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59D36B18;
	Sun, 21 Jan 2024 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="h6qHrT0+"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03827364C4;
	Sun, 21 Jan 2024 10:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705832287; cv=fail; b=Uy/xAeQue9ON31/yh2INggttOygM4GIwR6jD5X1vz/RgBjhmoaK//UQmQ5Nvxuas5q2Hh4V2vgzwhSlwJQJRLpkTJu7zzMa/HQ/n5wdgl+IHCCHWKyuZerBrQAia5zZUOwgQN6E5buV/Qq11FJj/EwSn/GwbtBauIojHbWi5f3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705832287; c=relaxed/simple;
	bh=Lp5urJcXxMhFvLEjMl/gU+u8bqJReXBFK776pK6/zCE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BHcHHf628IyoS4a73fMNtO2qJmvoFJhE0l87zT/NAH6vDL5cLsN9P5+pI9skBGdpgNUbTr61TWkw4hsaAlpA/ojea5y0bwM7HXnvmr8BUhvM0ZnVukZSkeMvueH6YLGY+42A2Wx3dkn4oB0fPCcZ/hMRnT/4ZThzwI5JT9szX3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=h6qHrT0+; arc=fail smtp.client-ip=40.107.247.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsHGb6uLFpc17qM9WmHYbtoPWQLujBcONhUwsw3M6VcW9ppUiJLoLuWryqGF96MeRSUQ17+I+0/WFec7BsNSPcl1QKqc1KNgnBDpKxV2cJS2yXcLJfz+v74dnox5HcueY8rjGHVotiIFbaHmV/LWTfM2rEFsc2+nRMViC1US6ycJUIV6hAHhQHgqp5eZdw070o+jOl0NnWWtvXmy2M8KHt6zxPQ/qWmHwk+Rf94ORqEUyf6cpaH4y80R6aIHGADjVuLF9AKCS1XbL2nG5EImqdUbn0R4Z3tq3BQ4VNxB76O5PkvO3vvsL2FioUIfu4YJRj+uvXJjPAx3c6LyXJgmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQmOgq15KqTro5dgNBFbE6fRWivw0EMchUXspHRUUpw=;
 b=lDgPLS9V90k/K57lmm+jlkYFosRy6kgbXd7ROdXsQ5mM6g76JYL+pbyyLV7AxGUzaPzY19Kzkp5O2Fbv+BNXBacyhOFlzPyBC8jKT2UP52XoOawuEte83ysHlS1/dk8cnUEiHzAKQA1V4TLv/QqCrJLdOk923u07RRZE81q644UBUlJzos9RxWvlv0HXWVMUXUf5yopGtUn0SFimkgkvs2K5tgBvGV2hZslMzNcpsNN4Kk8yT7kGHsX7p3JIR1f2k9RDqudFYDV33p/wcgZrrzWhuFeLK+6p7O7sy7RFIqfJMrauVzsXvkyDlt9jQk0g1eYR4r0vMwm9/HVRQDLr2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQmOgq15KqTro5dgNBFbE6fRWivw0EMchUXspHRUUpw=;
 b=h6qHrT0+AjituARmD5Owk36AXzEWLHvuQ9OvqG6xFUCEikdO7NEQ8/+qoe7h6X4m+rsO+W8GEWpYnwUN1nl3MFYpAZCBm6fYaNU4s1T5qbW1/+il/DAcLjGIqprxN9bNzQQ+4g0XebGwIMeOENwbUmWRbNcRbWYu5A7G/9vIq4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9203.eurprd04.prod.outlook.com (2603:10a6:102:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 10:18:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.028; Sun, 21 Jan 2024
 10:18:02 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 21 Jan 2024 18:21:51 +0800
Subject: [PATCH v3 2/6] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240121-pinctrl-scmi-v3-2-8d94ba79dca8@nxp.com>
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
In-Reply-To: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Oleksii Moisieiev <oleksii_moisieiev@epam.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705832540; l=2375;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xWNejZclzOUqKROUnFYHgVlFI6BqdpjzWE8+IpqHKp8=;
 b=LEO/Nb+DKYJ63eO1b4m4NCZZEg1U0e4TaNmGtWBMa/B+YNZPFphXela7t+//WeCRjVT9UZ6P2
 Ae9EAmRAwjND6NoaHAf9VEDfMhWdqUJzRVb4POxUYI28EKUTYhA7ZY/
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: e8229707-ddbc-40e5-33b5-08dc1a6a403f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iZ8E3lY7FCwS8NJmF9gO+LmBedJhHeuBCCfXApnU9chzAR0Y/PEA3JUxPx2qNY9Kk0ANDgO52iZSv2GGaFywjr7HVCuAi4gorQ+lJ4E2skijgR6l/JKMS0apsPQfbevtreMFEMRorxjCocZM4W/snubiGiL7ec0SacrA5zG3zIa1ZNOURcrj5P8sOQN5MSY7SAZ7/5FW/l6yWkj1cx2XRDCRJNs5XPxH7TSENo0+5YcEjrCUyKGd08G97PjAzcKpJJZYmrI5uBtOT25DgNn9Vz9ZlqnjwRjF7Qa+XBeYA9xBJk7QAOKYPqm2s745/rFYZc4ILfupQZ6JvtTSONEO5Hu944rdA1WgfV21REKQO1k5uXpI+BmqnqmXm6mEwKFWnyViTDMjmJxIL0BOswtU7ZnMnig7ElBWxn4LMgTR44kHACF/E1YFEgHBM0DMfZcZZgLF7/bgDCoI7eEA+aWJ+pvsbLLPGkZ0fYi+EtVuAib98PKHpWpomVjolwKthqOdzBkQu+KHDySHXt3rY7slpMAMxhNWndrBCxVzBKpF0Qypgv8T3PrdP3djN5sa5wYgEVL5lja50gxNZIa2Yrn+4m9YKhedjDldPymK86jUNkLeQNGeNsVQYxylJbjutg6r51iNzWkYFAaWin3wkOFc9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(26005)(4326008)(8676002)(8936002)(2906002)(41300700001)(5660300002)(7416002)(478600001)(52116002)(6486002)(6512007)(6666004)(9686003)(66556008)(6506007)(54906003)(66946007)(316002)(66476007)(110136005)(921011)(38350700005)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTJXeXFYemIwSytuN3hGaXpFbFRGRjdGTlNrdWlYaXk1TDlJQkttd2lRa3Rv?=
 =?utf-8?B?TmhaeG9QQk5OQ09CdEk3T3p6QWpLTmhmQnN3R01RVVFVaUdkWTRVYTNzQ3Nj?=
 =?utf-8?B?SEhvZjNRZG1GMzQwN0I4a1ppVmVoRVN6cDNtbjAyMXJvb1N6VXFxaWpyUXlZ?=
 =?utf-8?B?QVN1bUg0NWhYQStDYzBnUzgyaWFIUW9jNGlOZ3JDNDlEQURnRkJPVzdYMEJR?=
 =?utf-8?B?YmREbDludlVKMWFoQWpGRjVlVWRhczVhMTdxczZWMTJkcUVqWTlHbXJWZ2Nv?=
 =?utf-8?B?dDVDSDQzZS94OUdzZE12dlJyYWZYdjJlS01rREhJZmNGNWUrTmt1eElBcDQ0?=
 =?utf-8?B?MmEya0lzQW1tQ3JPS0JIeTBSZVJ0OE9QaTF3Y0JFekJQN2FtNm9md3FDdXh5?=
 =?utf-8?B?S2RrWXNXWlloVzRhRXBrWnUzbVpRaGV3N2N2M1c2QzdGYmtGZEtUQmJEKzM3?=
 =?utf-8?B?QTJRZzJRV1NoTkhxVTV1UEV6MFY3NjlYWGYzOXAzbnczVXp1bVZDQXNneXVx?=
 =?utf-8?B?VTZKY2dnVXNWTEw1SlExY2pDZlprTXhERmlpNWlQR3JTR3VhLzFGMzI5WnB5?=
 =?utf-8?B?Sm1HUVJuSzhKU1drcDYzcnQ0S296aFdaWnl4VVZjS0oxUEVlR05FNmgyTE9T?=
 =?utf-8?B?YWdKOW4xMncxQ2lHNE5aNXFlYjRuUWQ3MTZLYXFCb2NneVl4OGh0aFk1amYy?=
 =?utf-8?B?S2pUdUp5WGxVS2hHajBlSlR0amtyOTdCMGU2bWVZWS91OTBtdWJ1STVHN1Yv?=
 =?utf-8?B?eXZUVy9WdFlLQ1ZOcEo5NGdSczQ3SC9WQVFpQzY4anhaT01QL2UwWFZJNE82?=
 =?utf-8?B?dEQyZDZ3MFdzaVFEMlp1VlZGRkJCVlpWeGdUdnNteDRZZmsrYkxCcTFVemdT?=
 =?utf-8?B?SUxuVytxNEd2SzR2bDVDcHREMGwrRnRONm8wYkp2cFV0cVhIajBaU1dPOStR?=
 =?utf-8?B?VXd0UjJvekpIc240V093NUdON1NrRExoT3JqMnVhdHlXLy9aVzc0ckYwakI2?=
 =?utf-8?B?VlBCcThUdGdGS0QvV1VrbjNHdU1Uak9SL1AzaE5rRXQySU4wMHNCTXZCaE1H?=
 =?utf-8?B?ZFJ2ZkpvSXVZQ0xLR3RGa0MxTzJGZ0wzQ0ltSlo2SWN1U0p0RjgxY25Kanpa?=
 =?utf-8?B?M3hjSXlXNlFVZ2ZRUFJ6dXdVS25UaTBqV0hrVktjREMzdmY0Q0N0MUFHSnB2?=
 =?utf-8?B?TllNWmVjbERLUHM0ZE12Ly91cGtoZFFNOVVCL2phUmVUODdQRkgzZWxxRnVF?=
 =?utf-8?B?cUFrUDNVQlo2WG5EVU9jWDV2MVNNZWtUb1RiSmxDc1JDTmQ1Y2hsNnd2TUc1?=
 =?utf-8?B?K3BkanV5Rm1Dc2tBbDlmcEx3TitHYlc0bTZkY09BZVE0WjVTQkhGVmFiZTdR?=
 =?utf-8?B?aWwwZkZuN1l2d0QrR2Z4MitBbXp4d0M1Z24vOVlCblNLOG9LTTVrWHFHOGw4?=
 =?utf-8?B?T3crUzNiVEFNNFBaK2dlOVpVSEFxZ1hNQ1BhblRiTTVjUTNiTjkxcmR3aUxa?=
 =?utf-8?B?TEFMdGM3SjhXY2QwZU52c2FsTkRieVFVcXhZU0pPZDdnTGIvd0NwaUtoZXBu?=
 =?utf-8?B?MGFQUUN6MC83MGZLQWJaaFBHVmJCaEw1dGcrMmt5YVlERjNISXVZOFZxenhW?=
 =?utf-8?B?d3YzTXVYNXlYSE52UUlGK0NwUDdvdXI5SkRXM2JrUC9VSHRIZEZhYlNIN1RO?=
 =?utf-8?B?STVEcWRlWVA3d2Rnbm1VaG1KaUFGZTZHUXN2V2JvZFdOU0dyU3NwSzFyR05x?=
 =?utf-8?B?RFZRdXpEZlZSZE5HN2RjZ1RsMXltQ2JSOHVndXdCQTJmai9ULzZQUUl2SlBr?=
 =?utf-8?B?Ti9nbERNSmU3QXNsLzFqekZlbzE5WXk0elkvaGM5V08vWmk4RUZEQmpaTVEv?=
 =?utf-8?B?YXNuMlBYNWdDWnVUY2c4V2Z4VWZZMHhBSFVxK1lad0JtakI2ZEhHM2FaeFlM?=
 =?utf-8?B?WGM3WVR3cEFaaUhWbzdNc1d3dll0VEIzM0JkNFpoMHdVSHQ2NC9OYlJjQTkz?=
 =?utf-8?B?aXEvN2JEeUlUUnIvMm9aYjNEVC9BaUo0Z0svWFpSSFY1dHZhUWV5Ym45ck1X?=
 =?utf-8?B?aXNEWWVoZDNIUzFSRVpzWWlvT0Uzd0hwbDVSS05qaE82cE0xSFhhRVM3TjBu?=
 =?utf-8?Q?mUithoO5yjn9fLsUSRixYE+ew?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8229707-ddbc-40e5-33b5-08dc1a6a403f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 10:18:02.7609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s96m4umiT0W2+Ppb/+UeBH3xWfaqz1r6dbMcLu+Oa8NwfdUzP6Ds0rvAW2+YF3AR3U2Vi1JJX8r8P/mvS+jnmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9203

From: Peng Fan <peng.fan@nxp.com>

Add SCMI v3.2 pinctrl protocol bindings and example.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/firmware/arm,scmi.yaml     | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
index 4591523b51a0..bba4a37de6b4 100644
--- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
+++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
@@ -247,6 +247,37 @@ properties:
       reg:
         const: 0x18
 
+  protocol@19:
+    type: object
+    allOf:
+      - $ref: '#/$defs/protocol-node'
+      - $ref: /schemas/pinctrl/pinctrl.yaml
+
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        const: 0x19
+
+    patternProperties:
+      '-pins$':
+        type: object
+        allOf:
+          - $ref: /schemas/pinctrl/pincfg-node.yaml#
+          - $ref: /schemas/pinctrl/pinmux-node.yaml#
+        unevaluatedProperties: false
+
+        description:
+          A pin multiplexing sub-node describe how to configure a
+          set of pins is some desired function.
+          A single sub-node may define several pin configurations.
+          This sub-node is using default pinctrl bindings to configure
+          pin multiplexing and using SCMI protocol to apply specified
+          configuration using SCMI protocol.
+
+    required:
+      - reg
+
 additionalProperties: false
 
 $defs:
@@ -401,6 +432,25 @@ examples:
             scmi_powercap: protocol@18 {
                 reg = <0x18>;
             };
+
+            scmi_pinctrl: protocol@19 {
+                reg = <0x19>;
+
+                i2c2-pins {
+                    groups = "g_i2c2_a", "g_i2c2_b";
+                    function = "f_i2c2";
+                };
+
+                mdio-pins {
+                    groups = "g_avb_mdio";
+                    drive-strength = <24>;
+                };
+
+                keys_pins: keys-pins {
+                    pins = "gpio_5_17", "gpio_5_20", "gpio_5_22", "gpio_2_1";
+                    bias-pull-up;
+                };
+            };
         };
     };
 

-- 
2.37.1


