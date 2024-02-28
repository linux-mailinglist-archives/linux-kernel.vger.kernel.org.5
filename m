Return-Path: <linux-kernel+bounces-85579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E8486B7F3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE4CCB22BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BFD15E5D0;
	Wed, 28 Feb 2024 19:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aozQWElq"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2084.outbound.protection.outlook.com [40.107.13.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120874415;
	Wed, 28 Feb 2024 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147686; cv=fail; b=UZE8uOTUEDIMbH+nMkPrHpa4LFcDl1B+wKu8rqyq9H9/8SvfCR/TC0KFc2b4H2/1lavDH20xQYFNREcXLrIlw2ytKic1ItyPFhl8xx/85TgZXoZ/z6RWpQD7XmPvrJzoSN1KkxgTdtZ4uWZL9a8GJtVvlwcY+wK+YZNtfl0Lxfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147686; c=relaxed/simple;
	bh=Zr5TShgZiJta89p9a8K0vtH/7bUq8E+U8vmOaScyf2Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VuCRwD0TOvD4b0YRWFiKRDcwP9fMwBqb3dPCQbMEGCs1l3swT/Anc2p/xTI2nZGsfWbKT5klEar2afuEJGCSLsfwtH62oeZ+Z5xU1oP+pUP/gwowx+3V9WgvoR143ACPOeT1gP9vRaUOzz1s8Z9LwWJQ3xRuCBnu5qiN+ehwU1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aozQWElq; arc=fail smtp.client-ip=40.107.13.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuCHJOZ2eWgKDl0QVp65U+9yBfQGE0cmFKyLfevGgmGapVYS3ARS4FGeSNbm7IwPvIHhPRfbab9bf7bi++9gIDj0tZLts+OEHn3TY9+ASYIfJLXXdYDifSzoMXALQuIgJ9NgBfVtpk0jowKLauIlVWoM0FSD+QkgIwLWUcgDY5Tmiz9stjEPT+p2HzN7rWwPxkUlQly+BnSwfgGB0qgYisVjQgviw0toiPU5vP7ofgwXzu+Ap1Z5HBp6Z6fBW294xwvv5REZuXBIPi0GL820jmEa5dvq0GUpk6tgncIj96301rh1CPIKrISL56blcH7hyQjPEP6goZVPXs2Rnw+i7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Skl6lRl14Qap8DvLKPAl02WhkmMYsRwEI7aKW/j1Zs0=;
 b=DMDsedluH+zqvMMdn+klHaAwmRBJGuZpAgC+/e5Q19mzyQGhJpNx4hFmmraHliSBiusm0JVf/KJSZCLsPHjyR7l3qXLJlIv4zDqGfW/jGa7Eqk//JgklbcNumuGKC0zmBvE8IheZpRBP09gtxhNAWnJkEpdnj8I3wRhfOn9ZJJWSUzd0lKlZdpRQjtty+bQublFIo3Z6E/5b9ws20YxQ3AkJkVbo8XUuYANr1QX7LtO45tHxvbTHWHdoCTWuzP5m1nUO/O8ot0eMR1yb8+zhbMVOiTGr4Jgs7Oza/scWuODz0MQ/vCgc4OnWb2pZ7qQ4X7nw41RqB+N6qTVI6m96uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Skl6lRl14Qap8DvLKPAl02WhkmMYsRwEI7aKW/j1Zs0=;
 b=aozQWElqaqyp6xLjCQO0JkvHd7+1riW8Bc2GUkWMqzMOF3aDE+GbqPl5U6aOFWirr4GYY3+jX5+qU0Uo/iinrTveIXb2tXCalU1ooYDKhwO4mpbVigWQ5fTYjZfItbg3WsuhN8B9jo5sC8OhlrsGOmeAIZiMt/E9NtDErwxM5I8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8887.eurprd04.prod.outlook.com (2603:10a6:10:2e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 19:14:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:14:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Feb 2024 14:14:15 -0500
Subject: [PATCH v3 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-asrc_8qxp-v3-3-d4d5935fd3aa@nxp.com>
References: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
In-Reply-To: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
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
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709147666; l=938;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Zr5TShgZiJta89p9a8K0vtH/7bUq8E+U8vmOaScyf2Y=;
 b=LB7gjXBUEAkh69TaW44crxJQHuGSHdfydIQ9k8zVSletQxd5+EfSjDc1NIQYPVPgUry1VJuHp
 I2wGraplEbjCWDLigkSShVhLvYuruxBBHEcjvUknkUidYRYnIKa1qDu
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7f7cd7-b65f-4038-18e5-08dc38918416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ve4wglpn8Z2taSG/vYcYU9HjkWzfbKFBv8yBejI7ouMwheKALkKNGOrYfXeQLKwcDCZjqVFOxTzgMfGPm/4jE3YlXb2PaZSOkcHZi0VqWcrXldkAUu2mebhNJR+2v9H9wAg1GBxCsXcMOr0VEmFgDFn1OFYxZjoI+Homj5wZVdCDeIq/5D8BLx15vaMjJFcz9zswTRHBsjy6sgJQyVsMa0T88zKYz57Hx0tcENU+lGq0QkphhzexAcw2ITE8qGH6GHvWWBzRiEsGHB/+aNgfry8feFxB+lcm6dj/3GF6tgQe5IDIs+uFrOEsEx6fv7XpW4/LpZQXPYI9k7wCS5nPQFE6Bn9dxaH7aa2B1AdVwznv99i+RogTVaKxdJrgZRO91rKU/j0szaoKOnuJQgQwMAtCz9XeG9LLy+DSioIV540cHomj9DVdIeVd/IRV8DKF+x3dkJPxnSAPgygmhEkqp7NzuLRyfHQ0FY1mWvkACbyyZlABSjurxbxk84zI5z7XUI4v7Wg9dIBS9NPEo095nhPooCr0tFcHArA+jg+pZdxiVtFcbyRgtYzjDscpf1i8xgFup++rxBgH3Qiap3HSh9npigM9dDyoCSI/Vgev3A5Gp9p4pT8+Y7SsvxSLKQqN9BJdIVWIxKjT4a0iPQ1xxhlSqy/+nY6AXotJ1m/wv6hRd1vwooELVhwUhqyU6jNxksTFdvcFkqqBBp/qQwSQJW+IplKm1DiMU4BsfzmSULY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OExVT1NxQXZGT25jQjBEcUJyU3pCYzNqb1I0Z3BLU1VWV0Z1R1NpQzBKQ044?=
 =?utf-8?B?ZnZzTVFaQkU3cHlvM3dUNVNjOSsvdG02QzROdEk2QW8zcUxVMGU3aURZU0tB?=
 =?utf-8?B?Z2dJSTNrbWh0NzhmUDJLTG1IQzZpOElWSXRKbmJzV1BieWsxNmhnb0MycVN2?=
 =?utf-8?B?ZWxvUnA1LzAyanVQL0JON21LMVFrUk9uTXJxTlIyUWoweFpySnRzMmZrWS95?=
 =?utf-8?B?SGJqbVVQNEhtc29mdzVab3JWc2RZUHNIdmJSUXYzaFZUNHppRktVdUllVVRH?=
 =?utf-8?B?Y1lvSGZzeis4UHgraFlNY29OckNJR3k2NndkOWdEa3R0Y09YblEvM0gxeWV3?=
 =?utf-8?B?SXFZWDlnQzRRcTc0aUVrNUFzdkhydGdIQ1lZMmxHMlNtWSs4Ym5mRDZ1WTJO?=
 =?utf-8?B?djN3amJpU3JSQXNsVndIMEpkb084UzQvb1dJWk5kMjVEQnF5Y1IrQ0JIdGFq?=
 =?utf-8?B?YWN4NTNIQnV4NU1IWENsWVZ3eFNkdXpyUEVmaXJNTUF6Q1l6dXJabFVWNTh1?=
 =?utf-8?B?bXZZYWozVkFKRkU1MGNVeS9uSTMwVnRWWXo2RVpwYXVEYUFoY2tqYnFwdjdq?=
 =?utf-8?B?dWdvdmpKZTR0VnFSOE1NdXBqVy9wUmhZTFpUSVF5TEVtTWNyZ3krZmtjWUQz?=
 =?utf-8?B?ekdIMUhXRHFwNHg5dURtODN0diswNEIxenRqWmN6bmMrR3c3YmNLMUdmWGZE?=
 =?utf-8?B?Y2xtVElQY2pyaEgwUlliR0ZvbDNMcWRURGRPNksvTTFmVHlETWtqMG9FNi82?=
 =?utf-8?B?NDFmdkRlV2FwcFoyajBKM3laRHd4WmJPdW5WRDNkdTdKaDR3MW9DNVhzRXhR?=
 =?utf-8?B?d2tneHJQeFFCQWF6MGg1TE90UCt0ZnR5RVM3Q2lPNHNvTi9lMDB5aTVSd2dM?=
 =?utf-8?B?SFEyU3NMVTRaaU5qUk5TSkZtNDQzbG01OEJNRmdma1l1TjR4ZmpnTHY3dTA2?=
 =?utf-8?B?ZEUvREJNbnNiVE9YcmU4MWZXclZvV2hGSG5sYlE3Sko1RENQZ1NUTXIvcS9x?=
 =?utf-8?B?SGRGYmx0SEpXSHZONmdLUXp0WjlvcHhjNFc2UHpSM0dMalZpdTMzckNpVzN0?=
 =?utf-8?B?dm5SNjFlVUJ2SmZCQUpSZVNqQmh2eXlzdndSSEdtTGZNRXBCMzh2ejk4MnVV?=
 =?utf-8?B?bXUxWUxJcHRaa3phRzBnOGNvc2x3TFl1MXFIN0FRNGQ5YnVBYUUxZitxMkwz?=
 =?utf-8?B?UnpGeW5aUHZIemFta1ZtYkFmQjVtQ3k0Uk54eXNNNkxsM01PSUdzUkphQ004?=
 =?utf-8?B?aFA4dko2LytEVllLbTNhS0RHN3BFd3ZrUjZQakNTRmJ1Mmh5eE1uM3ZtM3BH?=
 =?utf-8?B?dEd2bmhpb0pyMUc1R0EyMXVacXh1M1RiMVFLbU14c2xWU1VXVHJUNDEzSS9K?=
 =?utf-8?B?MXM3MlNoMXBQV3FSV0JBaWpmTzAvN3BzWXRFYWNNNU9TbGlMbFh4U2JjanRJ?=
 =?utf-8?B?OEJIaWEvbGFra2tRejV2U2lLS3MxekhDQ2VPTUFuc0pPTHNpdENyeWhCU0R6?=
 =?utf-8?B?dWpxWlE0ZU5LYUU2MGhLcldVeFFIcEJnVXd5OG54T0UvNU1CNHd2NFB0SE9V?=
 =?utf-8?B?OS9wNENWM3JIenlYQWhDQXVwcTF1MGcwS3RZTFZORGt1Sk5hSFpkZ0N0SlR6?=
 =?utf-8?B?Y0NBMXZNYmdRVEpUanRjYXhXMmlsRE5BaDV3dmtIS3N4R1dFbzYyUHZGTVAv?=
 =?utf-8?B?enh0WDZmL29BWllnaDQvV3FLeFo2SmJwdWJtc2NVS0lrRFduZExMdHFhL3VR?=
 =?utf-8?B?VmtoM2RuWDdPNEh4VnhGU2ZGRTlJU3VMNHhUYjRiKzl5M3V0VDJsa3N0TVlH?=
 =?utf-8?B?OG8rMWRkR0ZsLzFVN1VKaDZlU0hQeUtJTWhENDZTZTJSdFIwdkM2OUNBNFlR?=
 =?utf-8?B?c0phaG0rZkxRMTBoNFo0NFFYc3hMVzQ3SnczRzFPWkdVaDBPZXFXWlZXbC9R?=
 =?utf-8?B?cVFmMjZoN1ZFckpOb1o1a2NQTVQxaTk3RUg4aWxJSHJjbko2WTljNmk0SWFN?=
 =?utf-8?B?YnFsOTI3RzY2dVZmU0psSDJwbFJTV0EyZExCZ3NXUUtwRFBIVGZMVXk5MXd6?=
 =?utf-8?B?VGNncHFEbGg4aFoyQnA3dDE1ajVoQkpxL20rUUgwbjdqbXRzZnM2dGRwdFFQ?=
 =?utf-8?Q?qzdmd0al77wY/A3Ebh+1OOrno?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7f7cd7-b65f-4038-18e5-08dc38918416
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:14:41.7970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aRWsqB+FFIZFNWn98VQEzy8NjTWEZYk7UQbdFbFqfT3pPQ/DON6L0f5OsKskaQF/nzMAL4d3X+8rzMrlnz4qHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8887

Some sai only connect one direction. So allow only "rx" or "tx" for
dma-names.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,sai.yaml | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
index 2456d958adeef..0302752d58a2b 100644
--- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
@@ -86,10 +86,14 @@ properties:
       - description: DMA controller phandle and request line for TX
 
   dma-names:
-    minItems: 1
-    items:
-      - const: rx
-      - const: tx
+    oneOf:
+      - items:
+          - const: rx
+          - const: tx
+      - items:
+          - enum:
+              - rx
+              - tx
 
   interrupts:
     items:

-- 
2.34.1


