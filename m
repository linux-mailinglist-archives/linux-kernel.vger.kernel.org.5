Return-Path: <linux-kernel+bounces-141377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3768A1E62
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EADFEB275ED
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646971DED6E;
	Thu, 11 Apr 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ekk+au+Q"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A991DDD33;
	Thu, 11 Apr 2024 17:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855296; cv=fail; b=GvEM82A7+eTvtL7WErqRuxSi154l/zlmb7Ni2Jq9oe0dNKdL+7BEUWjQMwO7ljhVo4x/I0wEHN1Ghc0mYFne/iJF5FAXgHjvg7n9fkZrSKHwZqBt5fDhX4RRw18YXEyZgyzvrv0Kepm44k1CH0ADu9b+XR84vUpb7t5iSb5i/2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855296; c=relaxed/simple;
	bh=l92BHQ95KrmR8H6kbGL9BR9VdFBvYlYOm9Y/2cWW5Is=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pNcIVqdBvt9L8AIRf66q1Rlrcv/6C02UQxL1K52E23c10YwlwTfWgKpDpK//8+fA5c4nDznp7y441M2SA9bAVe5+ID0TWxVU5rTW4SICfSFXf7kwjgultU1xpi+EI2gJ1JBkYX2AjoX4EAfgyFKw7JiowL/RwDTTOXaqP6Z96ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ekk+au+Q; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vfo0cH8m2g/Zv2S003mO1xav1e8+g2RIICLkFcIq7JvxIAAGNSIEfQLce1RQ5rJTTtfixo4HhrmONYvRLTfIwypU05Y97pS7pvfy+xjjBIP6ZTXu8mAeDbCZwpix4CZ0MXfyQZPzq7jiSWlRkZn/FeXA0MO8GIBkuEKsD7qYDW8X7kJeYOq/C5H9r9fUbo0J+gGfNz4ncUTc+vBe5ifWPfkNXWVYFVwwsYnwAfcZuQlrdPVoBCVUuDVpRFjRRtqHiw5H/P6UBMcV4EDBY7ua96yJ6AO+u357/tgPd7Nrjomrn5D3okUgxgtx2a2384Ek6bhkrHXnWPVjmV8VNr3lVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ6UmR0hgSkrCsU2OYOeC64iiI24xYYxIy2g0wNcwSw=;
 b=MSp6tcKtO0i0QdFT3Q5ZFWy7THARK1YqMKyzFxquxyMG8G53EIUv4A4aR4je8Jn7JogWnyfM6ZnwPoNRU4piUDkq+552XqAenNLM0PIbB+Z0H3ikgtXK8KjKFUtsbC/rFTbQo7eNOfVK1U8LwgXs76ffc7sh8i1lUFEiEs9wnB1b97Q5UFcnrKdq6Nlv0U2dMbZKYWebct7b8/X9XqJm7meKwiSxecqXxdnueRR8BSp54aDVS5JD5iY9gTfW0wgefYC67eO6JphMfJBP/VX/SJ9AVWBTArs+5xPRyWy2ZW++Nm7eDSzhMz8ca7CEleNW03hXctX+vp96krCADRSplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ6UmR0hgSkrCsU2OYOeC64iiI24xYYxIy2g0wNcwSw=;
 b=Ekk+au+QORvzmwvvThxIU704F5xxoLXch+C4LNoGC9OAekzSmxGh7IuWImQiC4DpIuQ8RJTMbVLyXlIak7uOS8gxVN+VcGRczTkuJqfVqzWX7zOmLV2ismITj29I0XA6tDv7zLSgTFuXfwQB4W23rx3q0JG5gqjLA8UMXh29CM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8394.eurprd04.prod.outlook.com (2603:10a6:10:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 17:08:13 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::1d91:1c96:1413:3ab0]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::1d91:1c96:1413:3ab0%6]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 17:08:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 11 Apr 2024 13:07:45 -0400
Subject: [PATCH 1/4] ASoC: dt-bindings: fsl-esai: Remove 'fsl,*' from
 required list
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-esai_arm_dts_warning-v1-1-5e1a7c7be9b9@nxp.com>
References: <20240411-esai_arm_dts_warning-v1-0-5e1a7c7be9b9@nxp.com>
In-Reply-To: <20240411-esai_arm_dts_warning-v1-0-5e1a7c7be9b9@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712855283; l=1371;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=l92BHQ95KrmR8H6kbGL9BR9VdFBvYlYOm9Y/2cWW5Is=;
 b=N/dHB1i2Ln7Z3SAaL/N0/YDPEjn2d5V+MBJI7ni+uqHchW5XEyJ7aJNjS4BmmESZeGJLbnjpt
 M7p0Wn4jewJCRNqmAArc/PYAdWSMXNAodEzwa8Plyvb7kl6NwYWzlDa
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR11CA0105.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB8394:EE_
X-MS-Office365-Filtering-Correlation-Id: 916e0522-fccc-4ed3-488f-08dc5a49f892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y5UxNhdCg4/0f42BDJ8KC5xn8LgvoKczygOSmjmHU4jtEEgwEiwQlpFfPhQtZXISfde8I2TD4rHlv6Z08xBqoZOz4UVJuG4Ctz2nORepDu7sExDQVExMjH5v43p0MY12jwh9He4xaiegnW+qW8JTpP7bPbl+ubliq7Mtj1wLw0ax/ZcosEWCzKQltSRZ45Usznh34DkjEqDdUhcfIS7Hp8ChWxwIx8B04EAAowlXKYpXoRW6i1NcizxpqJZeFCIYVHOQj4zr884z8xNsMIv3pPFnSsY+hedRt0zhKwoVyf4skUvC/9PtJPoQHJvFYOaIYBTXsLpcvS0alQ7K6hJD30emQ9AriN0nt/mZGCcZOZR4wkGmM5fq9CXXS5os4Xw561SBRb/sW7g4RREL4mKrRaz5jVKjDA7EeagJI3k7/e5RW20soZW78a6ACumazhDPL7A9ztPJN/sFB/TGRpBF0AFAlmGa8IzQaIXFSUc+Vzass5p5E9aDN2B/fFyHvCQ1mvX0o5rZjqVLHo/nRQEOF+HiS12yoCqgN+uS4h5XYBtQQveggYqf+Vx70PB+fGNIIT+rLH4ZTqwbjRIMAE9zq/oXMXYbXjRNZMOfQRxnshz7dW6dcFddNfYwqpTBJd49PHz/jwererw0DTKT2n3nykVZbxgn3d5tgKeeZ2Tp8cc4iJeBo8EQA4u/8VV254vVYOOfVTgHzAZoKtpnnWpQPKjvghEKW0HJQaBWtFVcME0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGh2WFc3RHNHZEVrWlMvckJZTm0wcGxtd1VZbFg2RU9lcDJnOEJqZGl3U2ll?=
 =?utf-8?B?czIraDRSMGhrU1FHM0x0M3pVM0ZzOXZOeEpUTGhTcHN2YzFTRlNsUUtWVlI2?=
 =?utf-8?B?NmVxS2lHL2RUN0d0UnhVTEF1UUVuT1p6OHV1RnNZVzhXME45bnJ4VlE2eEpn?=
 =?utf-8?B?TGdvNXRybTR3anVDMUQxRFNPVWtQdjFncUpyR0JrMWhJM3FSRERIbXdaREly?=
 =?utf-8?B?V3hKT2dZdUhlb2FKNThwU1RrWklkR0NzbzhjL0FnVnVPZUZTamR3TllDeWMy?=
 =?utf-8?B?THBVQXhtMTlpSWlzQ1VLcUhoeG5YY3BNeThWNnEwVThBeFhoUndzM0U4anA1?=
 =?utf-8?B?MXA3bklnUUNFa0I2WDdFQW1vN0pQSUJEVDhDZGVRWTBlaHc1Um04SDlDVHFu?=
 =?utf-8?B?NHJuekJxL1dBWC8vSzdqQ0pJd3pRTDU0WUJEbGI3bkxYOURVZ2hONXI0cGtW?=
 =?utf-8?B?LzByOHBMQmxoT0RHeUVpK1lIaVdLV1hRZ0J3YU81cFhBdEFSYTU5Um9sY2Vp?=
 =?utf-8?B?YkNyMy9mMVBxVHJ3cHVHcjV1U3NrU3E3ZW15bHErL1NGNldMS0k1SzBXUU9M?=
 =?utf-8?B?MVRweFZON2FyWGNuNEx0di9Oa1RwM0xEbkVIbXdmdmJEL0FYVEg0T1l4QXV5?=
 =?utf-8?B?VUJnUTY5QzZCaFhURENTbmlYYzdCMmRRdjd1R2lIa1k5aFdwdldpRlZ4elhH?=
 =?utf-8?B?MlJxREhnS2dnSXlUU1FmUm5QMldJb2RwVDM2T3hmOUdycGNvdGxwMVpGYTlz?=
 =?utf-8?B?eHpzTTJzNjhJR2pxcFFwVmRkdVE0dThaVlF6ZTZhQmd0eFp4bzVpMEdLcm9G?=
 =?utf-8?B?WndkV2pxZTdIeWxselNBYy95TXUrSkl3dm1mSDFHWnRnejRVRzczK2FXTkZC?=
 =?utf-8?B?VmNZd0VIRzk4U1orNlZSSU9GYkpuUEx2bUdvTFBGQUFwN3hIZC9HazllTDFG?=
 =?utf-8?B?TzdQNjY3eUhTbTA5bXFRN2VaRXYvM3RxbGUwbU0vWlpDOFRTbm9uM0lUWmoy?=
 =?utf-8?B?Y0ZqeVdMeS9rY1EvQ0dqMnY2bWEyZW9ibEppWkVNTFVpSmpjd3JmaERsWDF2?=
 =?utf-8?B?YWpkMXlHbThZUkFIOUZXNzZYMGtPT01wR2pKYWlJNG05QzZseXQyWGhnOWo1?=
 =?utf-8?B?aE1aNkw1by83YWNVNFpYV1hGK1U1KzdKemgxamcwZGIrazE4VitCNjN3K2xt?=
 =?utf-8?B?VU1ZWUVEOGROVDBWSU0ySGZRbzJQc2IxNUNzZ2JOdGRDMi8rclJGeFJTNUxp?=
 =?utf-8?B?ZjlNVlQzcHdyWUhUc3ZMcDBNbWRZYlB4c1cvY1lWZ204U3lUck5zYzJXT0dt?=
 =?utf-8?B?dENWSWtsdGhjTTZnanpMR0cramVsSUdhQmd5R09mUWFyelBEVm15R0hKNWth?=
 =?utf-8?B?UFdzZFhseXB2T2Z3V0dxbGFjUHdWWkhWZWtSNkVEOSsyMll0aVpyRkc4NFZZ?=
 =?utf-8?B?c092TTBRRExjM1ZzQWQ4M3VWY0lTdUZMdWpNeHpUUi9PZmpwWEdvSmJ1ay9L?=
 =?utf-8?B?U0tFMXFqTWNNbzdRc0xHdHBJYy9oR0xjaFFncnZhVUNGL096eVdFKzZrUUxB?=
 =?utf-8?B?aHBrSjdabzdzS3pWZDRyVWJtaGlsZkQ4NjdnSFpLeUN0d1BGNGUySm9xNFNF?=
 =?utf-8?B?REtDVzhicXJIUmdnejJUektxZmo5K2cxTFhHVTVaQ0xVUjRYL3MvMXZpTTBC?=
 =?utf-8?B?MVZ3emR4QkMzZHgzVzRIRm4yQitETFZvT25ZSlVSMm5FZmRVZHRvbDdLQldw?=
 =?utf-8?B?KzRnemtPOVpVUy8waFRvNTZWRVBOSjlPTlpIV2lMRkZKSEFTNVVmQWZxQmFZ?=
 =?utf-8?B?YUZxTVl6YVlEdHFYUEZzci9kWWRPY0xyamkydFFUNDV0Q281WW1TbTlxdzNm?=
 =?utf-8?B?MklhTGxUcVNmY0JZU0lBdE10WmVxYVkzMWwrd0w2dGNON1RxelNyZHdmNEMv?=
 =?utf-8?B?cG5kZ0pndmp4bHdjaEQ5eEMrQlpYWlN2WEhpRUI0V3FoWEtxSWRqeE9ucElx?=
 =?utf-8?B?aDRMZUxWeFpxbFJYbTg0K3gvWVdCaGJzdFl5Q2N6ZDZ1OVBrclNZTEVEVEZj?=
 =?utf-8?B?aVczcmxoVjgxZGgyM3pnTlg3VktRZWF6ZzBKakNUK092UThuNk8rZVJwRXhN?=
 =?utf-8?Q?LqLA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916e0522-fccc-4ed3-488f-08dc5a49f892
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:08:13.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NmBMBFSyu0hfNQbhEresTdAewyF8UTB2BjYKguP2lF2FCCIHkSFkc9kZIoyKkU1fQUEh+PmuqJN2YxrOjTvcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8394

fsl,fifo-depth have default value 64 in driver(sound/soc/fsl/fsl_esai.c).

fsl,esai-synchronous is flag(bool) type. It doesn't make sense to put flag
type into 'required'.

Fix warning:

arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dtb: esai@2024000: 'fsl,fifo-depth' is a required property
arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dtb: esai@2024000: 'fsl,esai-synchronous' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,esai.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.yaml b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
index f167f1634d7e3..66f20ecaa42b4 100644
--- a/Documentation/devicetree/bindings/sound/fsl,esai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
@@ -70,7 +70,7 @@ properties:
     description:
       The number of elements in the transmit and receive
       FIFOs. This number is the maximum allowed value for
-      TFCR[TFWM] or RFCR[RFWM].
+      TFCR[TFWM] or RFCR[RFWM]. Default value is 64.
 
   fsl,esai-synchronous:
     $ref: /schemas/types.yaml#/definitions/flag
@@ -95,8 +95,6 @@ required:
   - clock-names
   - dmas
   - dma-names
-  - fsl,fifo-depth
-  - fsl,esai-synchronous
 
 unevaluatedProperties: false
 

-- 
2.34.1


