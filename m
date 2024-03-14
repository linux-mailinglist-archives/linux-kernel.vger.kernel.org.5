Return-Path: <linux-kernel+bounces-103294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A11F587BDA3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9A6283FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB06E6FE13;
	Thu, 14 Mar 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hhBSmvM4"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F037B6FE09;
	Thu, 14 Mar 2024 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710422844; cv=fail; b=KwWM2Hc4VM67DdZLzHK2IkM6SuLiSS1q3Vep67XMrTkY5/tytb1wMQbwA+gG6ukR0UHtzsjOr17X5b337iTlygk2NTAfYpTAuFcoKPwJNorKp+V46PAC7Wo6Nz06Ko6e1KgAmQQh376DcysxbRFvOPu1mN94107d3S1nN5UhGHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710422844; c=relaxed/simple;
	bh=Lp5urJcXxMhFvLEjMl/gU+u8bqJReXBFK776pK6/zCE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ecybaI2Iq6fO0U5Wjj5WavpZx0jVav0dF2JGPCqQD481PCYeaapQW2xF+zomCMG3zTaVL18LnCGpufWsYHhbnkT+Uf/ptmi9cM+9fCtpYFBxSys2FM1h7fuo1dlyny97XW0p+zTgJ/GD4xgghcxMCUFb88UpwjmVNwKbiDvjtSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hhBSmvM4; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAKD4grpspoj7J5gHC+MzGYTrNmDEzFzNNnkD2wHs62IB7N9+UVtSuNIz2y6CVzBgjnnMHr/SnRZC2Ldi3+GvjkioeSi23jBs09gK21qmZbZZ7ZztL86cjRTJoDoclqo2+ksj1IAs9q7bfqZJGvGo9f7ZHgjtYLa6g8cjj2o2i489c1ex6RTgZL8/XcyHHoJ3tl/AxfMzi5GyUm3m4KdCf+PJyvDp3rZ0ZqF3iNahp2bXZRmUhLzbjCmC9kwBX4YYtQofsrtz+eeViymQT6eJKPCzLQKOh8iwplF9VuQgC9nPZ4+s7JyfMlg6ulAyYaBb9P1a4PAyHzaz73KKxl2+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQmOgq15KqTro5dgNBFbE6fRWivw0EMchUXspHRUUpw=;
 b=j7v+PwdeXN+tVZBfF9jlsi28Pk10CR0GRTZxos7pDOrPF+mFFDZq9F4qmvHnuZZj+WaL5JU0V16lWp/lhT9muG/HiROo/df1uksPWFSiRVQH4vLvDBc/0G4aFF7tB2wuy5U1Fl6S/+cGK8OoyvWy9MxKfRF6Lh0xjErHJVIL6ZE7ur+ncwrgutWUa7qOW0jTwfKGW7Fu6VOsjBlXXUqH4zLAMZmbt2bQyxbED8Plp75pEJ2MEN4T8BKzkAXmNCcB+wOYRVnd4F9U6b4CfteqLWmbpo+oSI+mt5ucBdFkaRcfRKN7dPJQcf7GDv97fvIE2BMgiUOrvSzRkAy9h12zrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQmOgq15KqTro5dgNBFbE6fRWivw0EMchUXspHRUUpw=;
 b=hhBSmvM4/tTRD9MBw+9EgNZhmqQ4+N1zAwMlZ/cKJcuuZW/y9j8bzTkC3cy9NcUkAOw2jyAg+OHMNqkjYGhSGG6ibRc4D6Ua0/B1m0Rh7AYl8+qMSN3Ff8zIy1NVkfOfq1BEJPbcaOYRWaq4E/Te91X2ph3i7tO4NeNlX3JHL5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAWPR04MB9861.eurprd04.prod.outlook.com (2603:10a6:102:381::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 13:27:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 13:27:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 14 Mar 2024 21:35:19 +0800
Subject: [PATCH v5 2/4] dt-bindings: firmware: arm,scmi: support pinctrl
 protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-pinctrl-scmi-v5-2-b19576e557f2@nxp.com>
References: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
In-Reply-To: <20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710423327; l=2375;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=xWNejZclzOUqKROUnFYHgVlFI6BqdpjzWE8+IpqHKp8=;
 b=317nGOwnn1TiMFVscUa4xs9xpYTG+IsZ3UdOHV3mWSBSPM0cAYedarba1fh/a23ZeoMIfBvx+
 t3NSj+vfz8TAoHt98WX99DWTDHX/afcb4DAfgArQU8oUPkW+22RzR5L
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0188.apcprd06.prod.outlook.com (2603:1096:4:1::20)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAWPR04MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: 45fcbd0a-12b1-4975-93f4-08dc442a797d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U97MrxKMY5B+dHDlv/+GIeKn2ViEhvJQO3elMrFtD7ay7HKUClOQVaVhpBNFMOpeTj6VbB1ZVCutIS9h5OP4lDXR6yGJbqtxtqcB4wVBdiyn3GMAAJoDuI8o2NQMutWcB2d2Dk8mEE9qlWDYyr0y56sPHfRGkq/44yEkFRm8CHv+JmaW9PpKDewbgRcUEq4PQkJgV03atICWSm5zoSyQq/3n09jMuDmHYoJYnEkN9Vro/LjnWIZHjRcq66TIvuIzvBdnCTzE3G3XALo2WDyIbXYfAtIEZjGaVh5qYHoHUn0zpA0nYgPwP+QOXzTuikj2yGicFnf8JuP8x8UMQc6ZcGftPmM5jFHpkMvKvwBXJkNpLnwgXqBr4OG3f8Bed/JR6xlThisGgg5IhejqSEDZFBrbqRcY1vjDbU0HnIZff7dimWpykutq5E9HT0j4qlZzy+IfwK6d6nH4ictrq6ImTKWUXJHwNYr9gaiIMb2S+hnnmFNwxOnOiL1OeSV5TTjbej+bM5S4qRpzlPCZelENDZp3RLJANYlebx/7sXvoHmSpSvoP9CWXuAfRiIkHefc9g/Xfg3JNoCqv2LAx01KmWXIoTQ47amk6+xxVxKU3thxPP0hYsPtrkUuI3yOAEltn7uPNtYjl+I4C2FTGGoDSB0XWSqbfrb8fFfP/8wre8aPF3pqDrge2rcMvpp6DqZBJpujYanS2V+XOd/fkPrP+I6gREKo1bMfOkLxxEPTnzDg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(7416005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDV2VHRiaXNoNFpqRXlrRnE4YzNyTDRQdmc3QmR5TUlGUi9iVERVQU9nYmtw?=
 =?utf-8?B?VExZL1V0aHpIY2tyemhldkc0TTR3Uno2ak9maTJjVVpKTmJ5aE9qNDIyejlz?=
 =?utf-8?B?emVlYm9YSTRycWJKTnR5VjA2R2lyTWEyWXFZaXBsaEZ3Rm12Y0plRjE3WXhr?=
 =?utf-8?B?aUpSeVNsMzc5WUdINjZKekd3dWtYRzdER1FuTk1SZ001TUtYWDlwRXFEOUdU?=
 =?utf-8?B?azlkbmg3T0tpUk5WZ3lnVTlFUU54UXVkNk5KN3E5T2NqUHVXaGR1Sk1PaXdy?=
 =?utf-8?B?bVdBQVdsNGNSb1JOZFFvMXg2SUMzTkJ5VnBSZzZWYW5EckpJenppWjR2b29T?=
 =?utf-8?B?NFdsNTJRUWpnb0p0K3BQYWpTNDBiOWtSUnE1aGp6ZXh5UWMrb2YzdktBaC9X?=
 =?utf-8?B?SXNOZjZuR1dVeVVvTHlyenJVZjk2N1kzUzMxUE1ZT0I5OWd2b2ppUXJCTVVq?=
 =?utf-8?B?MGs4V1J3RUFzWGpldFp3OWZvWFZMVUxQUE9KZEdDTXY2RTh6M2x5Q0x2eGJR?=
 =?utf-8?B?TzdsdkVCd2l0V1ZIQzUza3NDa1pIVmU4L0N6ZXBNK24venpXRmFjMlBPNWR5?=
 =?utf-8?B?cTFWZnJwamx3S0l1WjZyU2JZcEphS3o3R1cxVkRhcEhjL3lqUXlmMTJvSGZ1?=
 =?utf-8?B?OHJ3REdhYmpqclBuZTQyZUtKR0VkRVUvcjVaSUZwcWdjbjgrTUFjRE9HUzZq?=
 =?utf-8?B?OEJubkJsdkQ4VU9HQmN2RnZaZ29DVXQ3L2VRN1c2MlFnS3F6MlZUWDlLdnJm?=
 =?utf-8?B?Y1ZaY3ZlckZsQnpUVFM0S1lzSjFyMGwraGIzaHpkQmNER1g3N0pOUWJtM0NK?=
 =?utf-8?B?ZjgxR1FBakJGUU5BTlFTdGtHWW1vTlk0aG02QUpWS3Z5WUxCMW1xZDhFWmVt?=
 =?utf-8?B?SkRyVjlDVkZEVjdzd3JtblhxMDNKREgvVDJSd2lHTzFrSU51cWZzQXkybTJN?=
 =?utf-8?B?UnNSeDdJZC9zTTM5Q0YyRDU4dXdXbzB0b0RhaC92OGw1SkxPVkJaanB1QjNY?=
 =?utf-8?B?V1I0TElQQ1M4ZmdJM1JxZFNBMklTTk04akw1VFBtR1ZKVUo2NUtMdmZjMjZ4?=
 =?utf-8?B?eWcxb242dzFOUWJQOTlJUFFtVXZnUFdHNHFqNHZXVUpKZ1JCZlIvb250QTdi?=
 =?utf-8?B?LzllZHR4aE1UK2ZYdHMyMEg2SlJBNTZGOEM5T1BJUUp2cnFkdUtuZi9kclBr?=
 =?utf-8?B?SFVrOUo1bEFTQmdiQzhTdUlmOUNCbDhmdG1iVnp5eWFBa2MrVXZ6ZXF0Z1Vx?=
 =?utf-8?B?UUZudG0yRituaENnY1BqWlBTNW9lRDNqY0hkTkJRUFhIRmNteVd4cng3M0g4?=
 =?utf-8?B?WnpNV1lCSElmajRQOWludVluUHY3ajN6STdiZEFqR25TWWJOd3RDYjhDbW1N?=
 =?utf-8?B?UjJuNThOVmNyZkJNT2dISkZ1bDJMVXpXTWtxUGRYdGFRMW1sZkRVSHVYZCsz?=
 =?utf-8?B?VVp3ZzVJa2srZEZYZGovVFZEQkRFRmZQWlNjQ1E3ZEZoZHJENmFNRkxZZXU3?=
 =?utf-8?B?SkE5ZGVmcHM2RUZmbkk2NHJrVnZGSm80YXZLdXlYS2hvdDBVV2ltMWlKWDFK?=
 =?utf-8?B?UmJRZ1cxcHdkNWcwdHkzazcxRUl3bElDMW1mL0ZpejJlY3V0QXFzdzJiQnZk?=
 =?utf-8?B?a3o2cmg2aHdRdGpzMk0rT09NMVl6R0k3ZHhycmpRdkdvc2RFNE5mZTdHZkFh?=
 =?utf-8?B?aUtQcXRRa3hHZzZndzRQdFJvVnhBeTlQSWhQQ1FSclJReGlOczBLNU9WZ0tq?=
 =?utf-8?B?NzBxZlZnZ0xUZnVDMjA3dmFidXFDak9ya1BBOG1BbHBVblFQZ3lqU0V0a08r?=
 =?utf-8?B?b2xvM2hseUhva00zNkNtbkwrSjl0VjNIWTZicnVleXhVRHBXWmREV2Nubkpi?=
 =?utf-8?B?TXAzTDR0ZFpFRkpTTUROSFZNRGliTkMrV1IxSk0xazFhL3lrSElWUEFCTWdN?=
 =?utf-8?B?aFRmZWZFaklyVkNVaTRsaXRkaTFrSGdtRjF2bWRqVkQ1QnQwWCtTZVNrOHl4?=
 =?utf-8?B?ZXVONkhHVHdsLzIxZlN5ZFk1YlF2ZmVEdWQrZUsyWlBVODZYUFNEcGk2VjA2?=
 =?utf-8?B?a3V1T01hUXdCdmkrSnc1aGVaVCsvOXRzTXI3bUM3ZGVIdGdsckYzdlNGRXVl?=
 =?utf-8?Q?XchIfu9+LNMMwvmOxsg+2bOiE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fcbd0a-12b1-4975-93f4-08dc442a797d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:27:19.8345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyNqA3iCfLowopmS4Mf/+GMrj9sNHR6lgaVUY/+8f615iKLSt3W46U/oKvIimN56ODQKyUdzkZdDycQYT+6zvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9861

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


