Return-Path: <linux-kernel+bounces-85578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FD086B7F1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D405289B91
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A49474412;
	Wed, 28 Feb 2024 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G8mdfAl6"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74A415B10D;
	Wed, 28 Feb 2024 19:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147682; cv=fail; b=nLWQ40rqrbfUzYl/lDygF8ILG7L5h/lCsGDTh2rz1G4BwXuA+2LDHCIqb4W25UsDegtgqVc6SQXNEHKKch/Ecn113brHK04ZQbkc/OsmcGNlmjwNOsHfX9IH3PYpITWkCuFbTsjGyH8iPxQQ+Wv6pADP5G/1v8jUDBJ79eUj/80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147682; c=relaxed/simple;
	bh=FO83phglkervfVlCZJOD886uH/HW6BUeeW2qKw50lK0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZScC6tBq9qt9aymdu7yk/s6GVdrzuUzss/r0pKo3B0SSjUuBMKB+V3H16RmSHZFPUN8DqwKMr3yYtKVi8ZfV8Buw6akG5cjPw350V1ivae4k7NUbk6pHXmh9c2CYRtnaRlI7RBMbbyedp8oHAnupX1AJU5Veei8gimYDhuT1NPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=G8mdfAl6; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJtG2wA4JVdHNsFVJ6YFPScJLhhk8yGougcXw1SXaTC7O+FwKNpMXLQt2REtgg+t87Esa637aWYE6SFFVwJ/KUsUfO2NP7g7e13sSzRb8MpEpJEjkTFqbDcWTR5Dk+BvX6Q3c3sQoo8lj12ywGuGiKVTB6V4UixzO7cw9CJ3ES+IOBAGzJRYRJeOgY9izMl/8LdipOWflsmfcZHMs7mTa7vzRgMrp/KzaHm8QCfYx1wFHJw9ZBQpvZ2Rj2jDZv1ovtejSEuZvN39tyGHiyCXOs/9lZl22TJG1qymHW9N83RbjYkC0FACLCABf8gvGMoJ8opfKt9M//CutyIpjC01+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmjAsQ0nniAzcGp7r48rUQoZhUYjRyGE/fPpYj7W5J0=;
 b=cAjEkvfmPTTQKCy/zBXoX7rTE0/YhDtFLzJWdXwdNayxZsF6wrAhkQNzykjH5+/TDTlDt622lZgw13q4cbnbj147/Dxhu2ECmzQSK7iRhzLufBGowkMEpPwp1N5CAeix3mMJtYtHXYH/LAg1sm4ka6JkUUN8QutSvDyXf+EHADxaNl1jDHPlj7FQydq8yR+AGuG3yPLxXjc/IK3arU2LJ3B/n1K0eOOZuCmCg1f7aFmQgSUck8Wp0coNi4M9re248HjdYUsL1uwzF7fwJCPBJmS7JibeJ1BR4q1FwunQIAL8EvrAEIjwNC2pHLMrxJZ+O8cFyU8uivwgSewF/FVfkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmjAsQ0nniAzcGp7r48rUQoZhUYjRyGE/fPpYj7W5J0=;
 b=G8mdfAl65GyVx+ekrH4zVd35FDQ87C6LXne/Cwp/0FBQH7NQyrtbIN8ndscKjCzQU3+OZXgA7EAxfhDKcrJO/ugATwyjQJcHiaLsjxFhJHJIL8lWH/tCBtO4t+R86aEuxLztrdSAoS0ZqhEWujPL+3fD2Co7I6OYKeKUwVg4FNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9835.eurprd04.prod.outlook.com (2603:10a6:800:1e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 19:14:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:14:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Feb 2024 14:14:14 -0500
Subject: [PATCH v3 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-asrc_8qxp-v3-2-d4d5935fd3aa@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709147666; l=1336;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=FO83phglkervfVlCZJOD886uH/HW6BUeeW2qKw50lK0=;
 b=bRI8MK50d5FYDbvP+LIt+nfidFgDO9Umi2ai0+3sAsE7bEYQ7GCjjp/WPNpn0kuI7PllZQNZR
 ywkuI00yK3jBTHKKsiL7Uxond7wOLL4ngFCT2qYNDe8yag+xAlVPzt8
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e22b0ac-3661-4544-f0cc-08dc389181d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RXCS4inEGxEshf6UvgBoE6RLjrZw9kDKXVqpIaBbvIO3huUSKG5REPvRWXpeKrNQmd/YEl3O1C077jWxZy+9r6UX+Teu5GxuPT1y5JKJo95rFneD7G17yGcx74/m2cs2OqzApCwhQrq1xDnz51CR52gEpk0xEw7xXPpInJ1U37RFKcuwFJI/SJV2Pk76EU2hpdnWkBavzUr4eTzbeFEfoejBVTobkzme4o8O4sZVcfByIYxw8eH3KDgdjMoM1KRgQpdlHOQx4PzxVv/Yld/hsWb+VH7FGVGji5XfIUpOrFS+hh+CYIr7EkhM2Q8VLvwIDyzKE2wjG3BVpTLiMaGyqCKDhuIrJze9T9drQf/cLBwtxg8uwwg9ZbfJT42NdWxT5DNpsxeJratJ6DiMZZE66UV/2JKXfL+3UYbEmG0zx9rIhpKGzSyKLvvspRgYwADwoQcc8elTe12vsDQeynOXzdV4vSNaDttuiZFY86ogthNEU/q2LY5lsFeVgTx8FO0z/YSw202DaT6m040qbu9DR549e8jzVUzaTDgokj/JukXudidQ2VQ84aI8QHHT623SbVktTzTcPwpdHDy+g7coQz5euIcGvrTp3cSv10tYE+XIE93Vs97bg+0HyHGZzUNVtQ3gfZVpDaDh6lAJ9znbPbml0zI5HCl35v2OQeiomVH7bF8G2QgLonbTiI0UDZJyeK+3zQq+f2j6G2Kj6Clron1ULAMnO6VdgAzKe3l5FAc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUhUMGV2ZDdlaExXMmx6UURvUGdFMG1TenNza2d4bHMzMkpCeWRmak5wanIw?=
 =?utf-8?B?ZGZIajJuSm11cFQvbmlFWHpCeTk2T3BjcDZNTVF3MGdxRHB6VzV5S0dEUDIw?=
 =?utf-8?B?MHBMRWc0SmRNR2NmSjB3VE9QV0RiOFliSVVNM2JGd05uNlViYUo3UklYNWts?=
 =?utf-8?B?akZaZ2pKNXZDaHBucWVyTVA4NU5MdXBGanRtSm8rVXRRdDMzQUxYb2RvRkdG?=
 =?utf-8?B?cGNvV2NycE5WdG40K2I3ZE5JZStsZ1FPM1hFSzBQcTNKMThFVWVZNkhQc0RK?=
 =?utf-8?B?R1lUQTV5dUkvRVVrUUlGbzF1K3hjNGhWMHZOb0FLeXRFdW5DL2F6SExPS0dz?=
 =?utf-8?B?M0hLN1RrTzlwQkppMmRneGNVMFB2VHlDZUl0Wk1zMThTTWJyZWtZeDQxSmk1?=
 =?utf-8?B?ZGhQZUlRMzZBajVtVzZ1bnRXZ0ZPSmdvdUN5bjlZc0xiVWxMNTBwVUtrS24w?=
 =?utf-8?B?NDVvY3FZMTErK2ljNHMvN0ZNTkYvbkE2RmJJRXJwNjZJTHJiWWZ1ZVZLRXJJ?=
 =?utf-8?B?MXp3ZSs3K29Bc0JnN2h5MTZ5eTVLZFluQjlqQ3RKYjNFK1lBTlhxeGg1MlJh?=
 =?utf-8?B?dm0va2tORFpLRTJRS1U5ei9iZU1ZZ3hGeTFVYVZmRHpyQUR1LzVmajc3dXVQ?=
 =?utf-8?B?QzVzZy9JZ3ZZWTBrbHdET29rV1pJR2MzVFJoMGJJZnpMc0JNNGRieDhZOUZF?=
 =?utf-8?B?MEpLZlJOT3QvMVg0dXdBaHY5b0w2dit1M1F0Zy9aN2YwazI5Q05NQmNJMkJS?=
 =?utf-8?B?RHpvM2UwcGhPd1l1TnZqZHBYeWlqVFNPUUZ2MllJMS9RWmVjaTc0azl4ekwy?=
 =?utf-8?B?VlZaaVB3U0p3WENHQzFpNis5UU0zamdnTnk5S3lmZEtwU1BmRzlySVBQZU40?=
 =?utf-8?B?bFRldUNXTFRaSStSN3dUZ3ZvdHJnNnNjNndCQk1HTk1wcS9UbjVlT1FqREhn?=
 =?utf-8?B?UWpMUjE3YVNqTHhiRHovYmFIMFR0cUdpOWs1NVArOFE2WlJYeDFpUVZ2Y3Vn?=
 =?utf-8?B?aWtaSUtFbVd2Q0VEakExZUV4QTJaRHZxMnRMblYvTVNyeEYyMG1wclpmb0J6?=
 =?utf-8?B?NThhVG54KzVnU3hYSjZiREttQlBlWUJ6Tlk4NWh0aDkrWnlNSnFZQ2JtckVZ?=
 =?utf-8?B?SmxnZC9mZmNreWJyZTZ1VUpnazVrQ21yQjdqNE9rU3EwUkxoZWE2YWhPR1FR?=
 =?utf-8?B?alZQMmNVOHZlR3NweTZGOG9VRTg4T1lESWd0UFNhSjFGMWVJcVpDY2svM1lK?=
 =?utf-8?B?QU85WklTY2tNdWVZanZxU1FsakRHdmVNTEZSYkgvVkk1cGxMU1lJdlMvN2J5?=
 =?utf-8?B?RkM1WmQyZDRaWU9qL1Z2OTdKQWtUM2kwRFN1OExCS2JlZmtmVVdzaUlaRFYz?=
 =?utf-8?B?RDk2c1kxcmgzdVB1S1RkSWliWUlGb1BzVlJuUTVpSFM1MjdMalZkdithSzJn?=
 =?utf-8?B?WHZJOE91d09aVGcrSXk3SVpCbnpJQVhrMzlCRzNYWUJsSXVYVmNrd2E2ek4x?=
 =?utf-8?B?c01NUU9FWW81dzQ5R1VtUE5Mb09VV1hFUmlUWS9pZXhpMk5zZ3pJc3lUejVO?=
 =?utf-8?B?Y3dIZGJaTEx5WVY0dzRKeis0OGFmQ0RwUEsvSHFCREViZ29iOWg0UEQreWYx?=
 =?utf-8?B?UHR0SGV0SFYyOGh3TTVNMzRhWFJETG1jOVp6eUx0UjJiRUZRbm9iTitSNWdp?=
 =?utf-8?B?ai9uOUt6dGo1R2g0ZHpxL0REWHpQNnhMd0JGd1ZQZ0txdnJzc2pFUkJuVDVX?=
 =?utf-8?B?dDRMMHcrbUZKazBqUHlCZUhhejVmaERuUVZJSWZPT3hVamVEUHB2Q2RGalVO?=
 =?utf-8?B?VUhXZnV2Q3pJdklyeFQ3VDdNc1pBcjFVcE05SVZpT3NjdE1lOWtURmVnQ2VG?=
 =?utf-8?B?ajIzZEc5OEZiNkNNaUFKcnI1dWRJSzdSU0R2clErSjJJSlI4aXVZcXVVUTEx?=
 =?utf-8?B?Nlp6SjZ1cmVCSXJWVnlsM1NEV1RSazVJdDJqb2w1WWlLaWxHNGRMWWRUcGtI?=
 =?utf-8?B?OGlScjNTNkFKRktyVndIR0RrNnBMNDRmV1FFem1VTUNKUEJMZGNlSUNjd3Az?=
 =?utf-8?B?S0wwWWQ2R3ZGK3g3cGpsU1hzQ2taWDJOS1hhN041UWhxNXowTWtqUU5iNTcz?=
 =?utf-8?Q?W7f10UlOlMF5Bgr8Hbt0bw7G7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e22b0ac-3661-4544-f0cc-08dc389181d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:14:38.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qbivTQsU2CQesfxKYqw0nzmF7slTqAHRI5eP3MslYK2iBA0cIW61WdUud/HgzD8haOsi9IOyd24kWWqlz6iATg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9835

fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
have 1 interrupt.

Increase max interrupt number to 2 and add restriction for platforms except
i.MX8QXP and i.MX8QM.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/sound/fsl,spdif.yaml         | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 82430f1d5e5a2..785f7997eea82 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
@@ -31,7 +31,8 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   dmas:
     items:
@@ -100,6 +101,23 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx35-spdif
+            - fsl,vf610-spdif
+            - fsl,imx6sx-spdif
+            - fsl,imx8mq-spdif
+            - fsl,imx8mm-spdif
+            - fsl,imx8mn-spdif
+            - fsl,imx8ulp-spdif
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+
 examples:
   - |
     spdif@2004000 {

-- 
2.34.1


