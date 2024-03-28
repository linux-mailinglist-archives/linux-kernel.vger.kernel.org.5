Return-Path: <linux-kernel+bounces-123111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B689024A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2048CB22E90
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465FC12FB34;
	Thu, 28 Mar 2024 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kfGsXdIL"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BA012F597;
	Thu, 28 Mar 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637538; cv=fail; b=n8r8fS1E5SP/y6RykCOYRsdINI/8Vye8nxFOnjk0imrc6YTboPpIfV0G6chFtnb5HWK1/kQhfJHtDcEXaG9Sf68j4yaCjz12UFKFHK0LnafV2/tvGF7coiKL/Grbek3NUcS0fNPRYYsMrQgc9NtE8YgWQEdOJyVxCRNYiQp2GIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637538; c=relaxed/simple;
	bh=X/IAnMYuCCsn7agYxlWSxyPgA7U6a0SMgUhlZXUd6aA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rxZkFq3e+Pb3b3/J5VzwuPtHGG6CC4d/fO6hDnMJowOZDbfhj9pnx5ZFbo/2ARyhKZ6kdlN46OJFKOkAynDeKqfZsecUSULO1sKvKmHbQsVyAnre4R7e/3t1htcEQ3BEBQqWP8YXyRg9uHbu7ADvS9Sn6Cvi0cxgdoKk/fOtOys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kfGsXdIL; arc=fail smtp.client-ip=40.107.7.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fywk4WfNGbfAuM0qPwvoyitZJojcGD1/XAtAry/3H2gC+WmelewnRiYUmm2ZRxd+cg4N4Z0uhBPiFRN6zi01tawscXotsCwG6FuZK8OsS9eO8LYIkk6qnuCKyzQQ9Eikz9dshxl4PBo2yQC+Hignp3scZpS4xlBUjVpe9TuNjLDmK20vn0BDixW6nwuCRD6o6SXdrCe+X8jmbxfreOemwdZBp9TEcXKdCI1aQS3wKR9bfGfRcOugyn6eMrWHuB/bmIc3zP2DSWeFGQi4JwhoXR7m/9fGis48n+vqt0De88r5PTKDKQ2jLvHZxHgwM/FROrcYcJQEgP/4zdoMpjfPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwVLaUa+FtoZhYCvJlQ2Xqx7mL2pTGh/6dw4puqx7SI=;
 b=PljxiMXsNGMXhfT9bR43KZ9gpxpdYRc02mBVDUrm2nuj8RMiaJzAhxtau4fTtnsBb0HY4IFCcbuT8bIqp59pdEtlneOwH/MA3AUnnueyyRrMZT46LjH+BieXZZYbjdr345dq7ENUjRUdWXRJZ+U8JZRQbIV29FoMI+/zx2xdjYRBTTJOV5TtrdYoq7iz4gSjMxs36E/rRoYQzEo/7cG+L5wDDRoJHvO80OCBlDw4u4AHfUdmnLPTADsnI15uigmwElV6ogpCsfz4Q/FrAQVTs4d+ot3bfhB/qH7CeEQGllVJ5h4OSMJT/wxDesmtrw7U/TO6shYo2qv57jGrlsslGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwVLaUa+FtoZhYCvJlQ2Xqx7mL2pTGh/6dw4puqx7SI=;
 b=kfGsXdIL/iKEKDPqeEjWNrnBhwd0H7IGDIJQDHUa+fOW06OSFwFChct0zJeHFPri+wIpZNRV6R8TRBMQr6n4/1ZsuMoQ9toSxyZ49DdZlgCCQfxjOdqzkvXrGdlSxMvo8BLK7XB0xmyCEJmKcwFgyTMsGyMyLp8wwsc3AoMUXJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8880.eurprd04.prod.outlook.com (2603:10a6:102:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 14:52:14 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 14:52:14 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 28 Mar 2024 10:51:35 -0400
Subject: [PATCH v8 3/5] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-asrc_8qxp-v8-3-801cd6bb5be2@nxp.com>
References: <20240328-asrc_8qxp-v8-0-801cd6bb5be2@nxp.com>
In-Reply-To: <20240328-asrc_8qxp-v8-0-801cd6bb5be2@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711637518; l=1215;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=X/IAnMYuCCsn7agYxlWSxyPgA7U6a0SMgUhlZXUd6aA=;
 b=/nvdmdqvcOIeqW/Ur0/9JkLVJsm92TWOEz4b1mdJDDOHUXko6Lz44Hgy2fwWz+8DpMPjMVXGs
 wmXjD12jgrhBn6ArP6Flxy6xJGFJYlqodY+U4cp6O1Q8sdZLalbndmC
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0087.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 4260e557-ecd8-40e4-66b4-08dc4f36a7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vsAr9PwdFtChdgSujtoD2WrNQxkOkkvZG3B9RCIxhGhR9NurnDEGvMUHR2Ocx1Zp0jvybJ/lvCGqGBC3qipPA2dNw+VI3v6/BNTlMkjXFTsPS5GV/BkDluwWVKzYhMN1nbHARBtCwR9j7B9vU1DbwU+CVGh57W6ZxetIArHcvimclPKtgT5wpfVMoMqBTVUjTM2IC4RqPXnuOOtcoOnX8EIes8Di26tGNe9QrOeYYxvGzk7z0LaZmFkoA3IbW4AToxydNnkN66GPMBLhZJyy0ITq3ch9nEe959ElAUmJKS0hIUu6rIC+cmPAsGi0GcuHh2iA3TEuZPiJeIrSUGSvdXH04oeikYv+dzH36gTvUGknn6MeX85VMjo8QtmHulWQ2kcCXS3+w6i0ITXltfGulXSoUhI2PfvAsCSwSyYZ1ziJj/hn/EyAS/DhZM040ajWS59MLzGaTYE0Z31tM5X3JZxKGHCucZIx3IpgFB91m4+T3OhV+Dsn2a3NX5rWpljmcsngDdT3C69jEBL1/Hr7Ou+g/nVaSXz3MvlIfN8nKNm0nLVMudz5gFluMSMgzwqdiJavU5QqkUZXsNHuepKAxDA7P+GVZA+pE8vymwbc7fAqUdT0KSNhI6sNVjaUrJfZgYGxQxV/xN75atr/Jfis1P9q7K+HvQt5VzSx+U+9VzyXF1DI4ef3lQiRobngjPOcErCNsLWZx78na0DVgzKzVIHOgwaMlaK1xXRlHzTV43k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUpFeTE3VThOS2NIZS8zL3YxYStra3Zta28zNHJOeEk5MndsSm5RTkhzQms0?=
 =?utf-8?B?Y0lLS2RPaHdPd0U2QTN2LzFmUy9nNU1ScGEwaWt2SURucDJQY0xMR2xreHJN?=
 =?utf-8?B?V2MvRk9QVTdBazB5V2UwQXdQNXJLUTRsL1hSdXd3ZUhOVzMzbG84dVlwRjBh?=
 =?utf-8?B?dFZoVUFpN1RCRU9vRFQzWmJwbWQ1WWx1bWppNEt2Slh0ZW8zaFg5UVpjSkM3?=
 =?utf-8?B?aDMrSDdLaFh4VUZhcGNmUExaeUFPNEtkRVZFOGhnaWpGK1V4YXFobUtxSXc0?=
 =?utf-8?B?TGlrQmdQeEZFa1hDU3ZFTTVoMzRCQ2EyVjU2V3UzRjRtSmNrRGMvU0N5ZERO?=
 =?utf-8?B?N01ISnhiTFZBYy9rWTdFM1VSQ3NWTml5UmhxS0Y5T2c4cUh2REFkZXNNU1NW?=
 =?utf-8?B?YVBqOWJETmdCNXdJVHhqeFBuUlI4QUZNeHh3alNaSS9UVS95QjFNeW85S2Fl?=
 =?utf-8?B?TSs0UW1FSEVwNHIxMVMzT3J1MEhuZ3B0OUE3Mktpc3hMdVdoM24rMTMvRkJF?=
 =?utf-8?B?ZFFxSjV6M1p2K0RINmhCRHJyRnRhNFlEQlNpVDNDalA3Sy9Xa2xBcmNaRmwx?=
 =?utf-8?B?VHo2T21NdlRPK2RINWJHWVNoUXA4UHVsTUx0RXZwRlFPS2l2elFXa2QvVjN5?=
 =?utf-8?B?L1NiNFdPK0c4azJZbnBRV0lWZ2dHRnFHSUZRYmJnNGgybHFjY2Fsd201bHpm?=
 =?utf-8?B?TmlPMkx0VGxaWmZZNStqNGY3ZHE3N0lRdkJyUTRUZ2RiZHNGT2NNdEt6Mkpj?=
 =?utf-8?B?OWE5VG9FaGo2M0Z0UXlTYVhSMEI4eUtkSER3dTdnK2I5c1dMQVJzQUhHaEdB?=
 =?utf-8?B?ZUFEdkxsK29mRXlVWWtkL2tNL2EvbmJMd1YzN01KSVJpTnFLYkpLbWxINTc5?=
 =?utf-8?B?SjBLc2ZNNytIa2hLM1ROVDlvbUhHa2FCVEdSU0cxL3N3MDREODVpQ0Z1WjhL?=
 =?utf-8?B?bm9mRGQ2Qk93Y1lZblptcVFQa2Z3dFAvbmVsZWVsaGtWQndINFpKM3VRS2pT?=
 =?utf-8?B?S3VoOVZKTHFBNEFERCtIeWNXckFxRGJUbk1FWTRoMWVnbStyRHJKSjN5R09B?=
 =?utf-8?B?NjBpbEF4WVdSTHdBeHRNd3FDQjVlS2VXVkhxcURHZzRaYUdXS0xiV3Z5K2tp?=
 =?utf-8?B?Y3pjRCtiVGEyRko5TjZDS0hKQnVPK2I2dUVpdXRNZGZZTzhubmM2cFBjNnkw?=
 =?utf-8?B?T1gvNXJmNmxWSksrREMxN1ZsN1dHU1orbUdBdHJmVG9wa2hzMzdsaHB4MG9i?=
 =?utf-8?B?TFlMamtER0NuYW9zemRudXkySjBVandXSERJbEkrczNvNWpqY09YTmxkYUVQ?=
 =?utf-8?B?TkhRTElSaGdRbTFIdm1IbU9oY3dnTFkrcVFuVnRtVk5RNzcvbU9tdkIvbjJP?=
 =?utf-8?B?ZzFoRS83WS9tUlJFbkFHWTZlUWEwS2dGZ3l2UWRtZXk5TFFkVHhUT3kxVkl6?=
 =?utf-8?B?VG1zekZlS1JQZjc0Y3pDaFJpdFBqYnRrQ2daUmJqZFMwSE8wR0VaWGR4cDVM?=
 =?utf-8?B?ZU5JUXQycVNoQmFrM2s5bDRTTzBoekdRTlU3dEZTOVFGdHA0QTk3bXFreUdu?=
 =?utf-8?B?R2dFdjdnVWZCME4vV0FBVDFJbkNPWitUY1NPanZNaUMwRWtYNGRMZk41cllE?=
 =?utf-8?B?RHJ0dDJKeVZ5RE15WU90MHUwTTBOYWtkbk8zZEo1N1Q1a3FJemt5N1FrOE1B?=
 =?utf-8?B?UktWZUxPQ2dLTE8ydkdsOGg0dzRjVWY3UmxzUEQvR3Q5VlFicFl0azJ3ZExw?=
 =?utf-8?B?RVdVcm9qOTg4Z2pMUXdLU2N3cWk5MUdUeVBQVjQ4ZjdDMFpML0tqU2VxeE9q?=
 =?utf-8?B?Ti9MMFFOMWtmMGRMK2l4RlJKQWRKOGcrdURyd05zT2VHNnVIV1MvVDZGaFlz?=
 =?utf-8?B?aWxYMVgxY3dqN2ovRnJDbHFjOWpBOGdsVEZ4bzEweVFwY3hhcTBEd3ZLNS9i?=
 =?utf-8?B?b092NnNTZzhDMnUrZG9KWHVKckRCN2tpTHJzRmM2UTlUVHpJSE50UXFvenhK?=
 =?utf-8?B?V2F2K2h4NThlbUMwR3BHTmFKTVpYZVppSjFnSUVzZ2NQWVFTaWVqeE8vSEkr?=
 =?utf-8?B?SVkydHpMVUlRL0lBYkhFVktETVRXY1BXNkwzSEZWMHIyTDN6aXFXV1Zxdzgy?=
 =?utf-8?Q?I6P93bOMmHOGgBPkhATzGwxsb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4260e557-ecd8-40e4-66b4-08dc4f36a7ac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 14:52:14.0622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQCuzW0JdAKK4dZ4EpQG2a4KVoZrn5FxudU6HM4v1V2mILDDxMqNcDHwmiVc4azd1RjMzG6VBZ0rBcfVUJhDeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8880

Some sai only connect one direction dma (rx/tx) in SOC. For example:
imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "tx"
for dma-names.

Remove description under dmas because no user use index to get dma channel.
All user use 'dma-names' to get correct dma channel. dma-names already in
'required' list.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,sai.yaml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
index 2456d958adeef..a5d9c246cc476 100644
--- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
@@ -81,14 +81,12 @@ properties:
 
   dmas:
     minItems: 1
-    items:
-      - description: DMA controller phandle and request line for RX
-      - description: DMA controller phandle and request line for TX
+    maxItems: 2
 
   dma-names:
     minItems: 1
     items:
-      - const: rx
+      - enum: [ rx, tx ]
       - const: tx
 
   interrupts:

-- 
2.34.1


