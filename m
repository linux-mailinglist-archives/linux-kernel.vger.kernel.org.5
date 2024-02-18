Return-Path: <linux-kernel+bounces-70225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DED6859504
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 07:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9923CB20AB3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 06:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A96E546;
	Sun, 18 Feb 2024 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R5x0ww7+"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8705F610D;
	Sun, 18 Feb 2024 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708237865; cv=fail; b=bFXQl8LNNXxzn+UrVjws29dNWjVTDOhkU1j89za84EqHr1MiYeRwm8rhTTHgFYDiPaUs82RKOLpJiEN2BBUE9e0HkzYWy6qIwHqABGWtdOPWQZGeVVzF3kJy1ybY9kbYP3a/kmaEzS7LbV6HJ7uZazRn3aoHO58L5JlWXTNLXto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708237865; c=relaxed/simple;
	bh=ac0gW7DuvVz2NhIaYyaQc60m/+iGpuPKG6gUld/LLK0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dSTl+zCfdnyj8kFvj4BJg/Aan5bIhue3YfL0z0XBDK4AsHM149mfNv995A3w6s4jAY5yHHKo5jnG4SMXntzQk71KjV32p9aqOAImnItfAIIfz/yj1bU4uK/8tnIvumC8soV+ikyDR34hWQuQ3t0GPrfAW6DBkAWb9T0Hkzzyg4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=R5x0ww7+; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwQECsbFRMlDlUDXNR3uHGrkZR2WVfdeUH4WKqbAeWKQywSTr0LUDDi83UhQ8Iqx2eYnH5bRQ77GxM9HCaKZ5XSYPB0x4VPo5npzCFZT9mIXtlJ4xX5ueg692aVPtji6i8/GzRXP61J8Oja7uQSmLOrzGOe6ZTvYMKEszExBVlKApV6pogIP+DsY5u+Okq1x2M0jXdjfreItcJrSDrz5gfQv7Bwf7zGzLEsBHnXokP5+v9FWSev/3ciWLTRjFXxZB1IrwVYC7ldLK9LasOH86HKGJZe+2Fs+J31FXI0EL0opZWcIQyebWzTWrztrdKT1Qd2Dy1clplz7XaC9C/9vqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G96qlGv6dMlmY+StA9TyQqlFyDEu+NXIUbqtMWZnzPA=;
 b=bgy2beV5fQQzJBy36bRcQnD75JLOApe+drM3m4e/jK2PJOjuPKc54JwGld7l2towbB2ehzHuzK/5nw06bUehc0zgHbfI7icUCqp0vzxlGFxkfB7zXe7EvfvxQ+WavVRh7jBxY7EF8RKy7e4FWLmUytSKdKJ20m43+Wu+PdmC2r5nARS7cESaVPuezLiuiN42gMQmg8o0409nwL+2QvT1OPE2wJX06OohcrwzWGz0847x58TOR1y+MArh2OzON7oNUQRlzD5MYrp915HBp/2Q+bR1FiPJOqUtVY1nAY+JlNJkWQF4QFELHWWJk+D26cK+sjBZb9HKrdlOfkwiKqVZxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G96qlGv6dMlmY+StA9TyQqlFyDEu+NXIUbqtMWZnzPA=;
 b=R5x0ww7+U4EuBgdDlgxZlHlwoDHX9GMv61YSIgwk2owGSgwQktgRrzrLXGcV+cTCFoUnp3Q4nTo90sRTJVHNnGNLUs+B7c91ddXAL+vfQkUKGo9SBgLnj1abSJrs7ZSllYA79PWlTjP4mGPL3KSZMhxldNruSLyukbpRZH2+FCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8321.eurprd04.prod.outlook.com (2603:10a6:20b:3ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Sun, 18 Feb
 2024 06:30:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 06:30:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 18 Feb 2024 14:38:51 +0800
Subject: [PATCH 1/3] dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-imx95-dts-v1-1-2959f89f2018@nxp.com>
References: <20240218-imx95-dts-v1-0-2959f89f2018@nxp.com>
In-Reply-To: <20240218-imx95-dts-v1-0-2959f89f2018@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Li Yang <leoyang.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708238355; l=885;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ytlKsDsqTUO7erOW0c3oD442TVAJWkJ2iuO86kjfkQI=;
 b=PPWTk6qAi2IzHi6wuSVUEOkUyM4tfe6pPI0f23ob+atcNRrptgxtIEDwrq7bKbLY2dtt4/mRJ
 Fxbe3raM0GVCAIn9Bs3eyPCJ6aOf29CvVwboxA1hx2tkC3E4kCz0gcR
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR03CA0127.apcprd03.prod.outlook.com
 (2603:1096:4:91::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ec078e-abab-4c00-3950-08dc304b2aad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C4nqAFfHZJKgDsxVYcKyrK7j0oQN+TzTwtR1JomsOJ1rd1yTjGmPQCsMPJ54ehxb3MovmcUyyvf3MqB/MagCiBQFy4rFZVZMWLGoKuqbo+VA3HW2p3Dn7C49c0aA1vzXF5Jxk4kYEjAmVD6amT4qHz5dU2ma7XzeOOqS6wsgFZ1NTDzpqShIrWU0Kbu6179Xo/ofL7v344eDG5844xn8/1VKsXYf+p1w9lHZFp/6O2D/+bOyfPzwoE6pC4oSoUbo0++nrrsB99Af4s0/8E1q+edJR610wqY6HpxVC9l7NvFnTIqZ+QSG1TvkmQIRTvFofrwNUYmBuVtN0h6rUcHEhl1uUXs1TnJcyIn9v2sTSsehTpYvcqGGCqy82ZiQuNTyi391fCO0HNJxRpbY5PIgalHQwSg2S46UpIvOt2/6m063raMeH0GseCGjcXlMvpvtkSu7qNVYI09C7WivSXgzFWO9G+CEgcH0LLV/a021qX40Zr2x64fCPCQ+k6ootYVbngqE0U+JqZihB+d6fEGv7bhcmaDM8Pne4ZVKnvFNZdBWfDjXRDYbSZjx31sbTE5Td8lZMqXoC24dYG8e4oLhgI8LIN8bg5I0vsV8V7bvjsuKYRG8RQhI6Fu3NSfaBKfZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(2906002)(4744005)(7416002)(5660300002)(4326008)(8676002)(8936002)(86362001)(41300700001)(316002)(66556008)(66476007)(66946007)(6486002)(6512007)(9686003)(478600001)(6666004)(110136005)(6506007)(52116002)(38350700005)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGs1SzdjczZQcWR1eGZJNFc0NWNUL2NUK3IySVVNamVUQ0kwaTM2QXFjZzRZ?=
 =?utf-8?B?TWZGcW1ZM2lKcHpPcGJvT3ZJQk50ejhJeEJSbzZCY2JvK1ZLUW9PR3pNdUtp?=
 =?utf-8?B?SlpTdzV6Wkg1bFJHOExwdG1HSm1hY2RKcVFyUGNtNDlvckxGUDdaK2RPYWcw?=
 =?utf-8?B?WGl3cm9nRy9UZEQ5N05vYkpwa1JqcmpCYkM5RVc0RlZFV0lRRHlqUU85R0tJ?=
 =?utf-8?B?SUNxMVdqeExyQ1V3VEg3UWVyUmRUSkg2bXh0NTVSdXlUOXo5WkNaRk40d29R?=
 =?utf-8?B?UUxaTGZmQ2F1ZHl0VGROdlRaQjdZbnhPdUVkTisremdzTHRjQ3cveXhCaHJy?=
 =?utf-8?B?VThjMnJlbHd0R2hDMzVzRjFicERINjcxdmxDdWRpbEUyZkxZVGw5Q1JPekJ5?=
 =?utf-8?B?V3RLQ1dadmxGcXFnZ0RwNjFlOXJMallOaVZYUHQyUllqOGtUdW9nMzBPeXJJ?=
 =?utf-8?B?ZXpsUXJzdU9UY3NGbFA2YU5xSUkxTXBvc0trSEJxSElCOHZvdW9rQTFZV3RZ?=
 =?utf-8?B?bDJVZFRmc2tZMDVZeHJFUDNHT0NhU2tYQlhwVllvejZnUVorVEErbkRJNmM3?=
 =?utf-8?B?T0lxQnJHMjNjY3FZNmJPNHZNYVlGTFhYQ0FhcHMzeEZFQ0NFTnBvckIzdlJo?=
 =?utf-8?B?OUtTcDhrQW5UUlhUbHc0cHFTWTBEd2x4cGwxa09kQlRTZE1wbGJCUXBNYnRC?=
 =?utf-8?B?cjAvbEVycll2NGlDTjFqU2tUVmgrd25vYXVuVzg3QWhxSEV0eDRQdXdpWG05?=
 =?utf-8?B?VnBlQVZnbzA4WnlpRlhWSjhGUVpBeFhHQWJKTmlHQlBKZE9YeEFXQ21hb3RJ?=
 =?utf-8?B?bGtQRTJXVWVlaGNoem1LelZEbFdvclUrK2NQRnV0NnZMdTQ2NnVwM2IycW01?=
 =?utf-8?B?M0RKN21nYlJMbWQ1dFBRSEtCQWlaNWFwcFdkTllxWjhRNDcrV0owY2VDRWFr?=
 =?utf-8?B?MURhNng4TmRnbGlvNEdQa0JtNFhWZEtrdlU3d0VaNEM4L25FYWZDMHU0K3BF?=
 =?utf-8?B?eXdRZFV5dDVnZHZPYjdsWm1tVDlxRUttaDBtM0lSTUR5SUl5YmZsT1B3ZEM2?=
 =?utf-8?B?RDBpZk5MUmxFSE5ESURXa2hXZFlhZVZFcEJyb0xoZzhIREhTQ2NoWndtSHQ0?=
 =?utf-8?B?dTZXU2JPQ1BXRGFVdW9EdG1OTGJVRWM1aEo0WjJUVUxtbnhrZkpFUnBZQ2RD?=
 =?utf-8?B?aGdJTmlCRU00L1ZJUjZmOXdwQ0RadEpPYitDN1RLSjNXZU82TWF6NjVaTFRB?=
 =?utf-8?B?SG50L2I2bllkdGJjdGpmaFNMTW1ILytaWlQrRVdtYXJod045Q1VyOHVXUFpi?=
 =?utf-8?B?OXE2VExlTGc3OWJYcXdUUXBKd0xmUVFMWm9HWG9YNWxkV3ZySzNFSEFRQjlH?=
 =?utf-8?B?bjZ6Wm1jRzhMWGw0Nm5qSThldWdJbkhiRVg5SVJ5MVN2NmdVamxUK1ArVXd6?=
 =?utf-8?B?Umc4VjlCbHEvNkllL2syWnFWeTBWdFFnUm4xMEFXUFZqTVg4V1NxemZPQkRp?=
 =?utf-8?B?OWVqQnk0WFhuTE8xY0xWSjB5N0ppYzUzTk9jRTFDZlp5ek5pNllrV3RDL1p3?=
 =?utf-8?B?RmZRK2dyMUNCclExK1c2bnVCVXNLNWZ3Z0NkQXcrdVZzMCswcEYzbkpDYy9r?=
 =?utf-8?B?cEI3NUl3MVhjWTAzU1NYejNUOUZTSFE3NVBwMkRrMTVrRVowYjlXUEVGTEIw?=
 =?utf-8?B?RGhWY0FQQ0Y3dVZaeUFvTnpYMWw4MXNGTXFZWDVUdXpreWovZmhZR2s5bVVO?=
 =?utf-8?B?UTRhenMrSGNqNDlkUmpvVVdnRHhaUjEzUENGMjZ5bHluZUVKMEkwMlErL2t0?=
 =?utf-8?B?TVpiWW5RNERKeFUrTWkwQjMvQm5CMi9lc0g3eXpWWlk2NXROZXpidGQ3MmJV?=
 =?utf-8?B?bzRZOHV1clVOTzZ1L2ZHR0txS3dmc0dBTHE0ZUNSalpmSVpXcUZCaVZQTHk5?=
 =?utf-8?B?dGZIWFU3MmdQSjNyNEtsSFNSUTVrbjhET3JPVlE4YzVjZ0lRRGRHTzZ1NDhN?=
 =?utf-8?B?R1diVURnNVBrOHZWZlpWenJmYnFQVW0vaE1idVUzVGxaemEvTnVFWW0zcElu?=
 =?utf-8?B?Q1h2S2dEUE1SYzNBbENDU2dReXo0RXdVeU5rdnJIRjJvK0ZRVmdmTWxWUCt4?=
 =?utf-8?Q?ObO30+mRjvfARgRbBTbxMfO2T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ec078e-abab-4c00-3950-08dc304b2aad
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 06:30:57.7372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gblz+6qB9gaDy+sESZznzmT+Iie6ET5PGnhapGk/tyUnetMKri8gmzynUYsQDzJVqlkjgGLCOKkyLpEfiWDPcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8321

From: Peng Fan <peng.fan@nxp.com>

Add DT compatible string for NXP i.MX95 19x19 EVK board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 39378879777b..3b318c518e35 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1264,6 +1264,12 @@ properties:
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
           - const: fsl,imx93
 
+      - description: i.MX95 based Boards
+        items:
+          - enum:
+              - fsl,imx95-19x19-evk       # i.MX95 19x19 EVK Board
+          - const: fsl,imx93
+
       - description: i.MXRT1050 based Boards
         items:
           - enum:

-- 
2.37.1


