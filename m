Return-Path: <linux-kernel+bounces-84000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A83D86A136
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842FD1F2446B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B41F14F995;
	Tue, 27 Feb 2024 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nMEUTxWu"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51114F967;
	Tue, 27 Feb 2024 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067291; cv=fail; b=UcKHcNXtIxJwM0ySTpzgKKhM5q8TS1+seXEq9Glq7q9e+iUceTISJKWTHxNUj3DrY4IuvVZF27h8a2dNCsWNtl5K0dhSU0p6RAIy6n8Q9P1ewYWFHDD5CQ5ucVBzWXngF6FkICldv99dOOutRkuVO7i/ZTFOsIXCGBYwpseokNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067291; c=relaxed/simple;
	bh=z8N/GMm8YNPYDEX5aXs4dbUBMiBqUfzDoGwhl8BUv+Y=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UjibsFpsw+t75cytHXcyyTh9Bz/5loGqVLAOpb62qH9/ZXp51j7uZQbmYjRmyoIlXF61cfWGxPv6WNSoq6tqk7bKVdc3Ct554Cq+CT9YhwID0zk1WU1L5ZwZaf5JjVkrIXNfjwdEjox1nnSL7p44B/dR1KfGJ0S8e4Y6M0dUMYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nMEUTxWu; arc=fail smtp.client-ip=40.107.7.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo4HQVhQXY2K/ALg+tC9ODeIZUny1SaKgTPtPt1EjVOGPpO2WHrnxP3dEeG7e4gQfdBnvs0CLlgmIdz0f/F5fvWADPEKW8TjyMw3ThqV5SBRAKj5KjUZw8zyLRkBFMKDui/Q5JDzo+poaTq4EBPtuNFVMc42aTXOfsXTChNYNdJcTkeBlm5OtTWfOzpYhYRf0GKAQd/KeunkfLwC3rimdEjVO8nwR10Gcf86svXnCEINkuP68h+vwy8gEDEC9If96NqSZMkFR+hNfhnm6haigHDS9q1D/1q2Phlidb+DSZOSfeXIxczbNWDRl3qVkRYlFdK38eYNXLp83SoFVbahog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HgGHKoGD09SsdkSHsTQ0ZzVK5YH8cGI5ZeQMnqlKKPI=;
 b=kRpqs5z1GyL+DBm4v7yvjqJSOFVYyLCTvDIwo8ls4IH7IBhsFtFn+inkORo7TXNQ829hDhWlMmCskA/uzEpo9hOHxnlUuIkyCCiefr1B8SUcTZs158FrE49GGsfZKUGiDoMjsYOIuibZ/sjtxpzTtDtCmpn+TsuYB31sX8NtqIEet5BIL28LfGCH4PGE+PcqWiYofJ/HsZNXkrzI2mBiQv926OhCA2jByoVP7kk8ozTflkaibgbdVsp+sq7iOH7vaEs8uO0lRWrY22l96BVWm29x61PTK1+kQ5bgSF2mEdWtT1W2xnCrgtQrGdzEZYwlBovY/lRsROmJ+S88iHEaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgGHKoGD09SsdkSHsTQ0ZzVK5YH8cGI5ZeQMnqlKKPI=;
 b=nMEUTxWujK+3ep5D4kFOERDeEXNxjhelwTatLGE4Ahi4kSzwGjGqF94bRFdgI9wYTGlyQ3BSsJZDjJn9GK8J+5g8gJlp17GvTeVuHwxikO2ozWjXlJZRC0GHffEYPOMIbxvZCeJXlU7uS3YavymZ8foqjFDg5GQw3bmNvNlIIFw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB9200.eurprd04.prod.outlook.com (2603:10a6:150:2b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 20:54:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 20:54:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 27 Feb 2024 15:54:10 -0500
Subject: [PATCH v2 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240227-asrc_8qxp-v2-2-521bcc7eb1c0@nxp.com>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
In-Reply-To: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709067274; l=1318;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=z8N/GMm8YNPYDEX5aXs4dbUBMiBqUfzDoGwhl8BUv+Y=;
 b=HTRgNxjqU3GitI+LV0x2lS0517atR0UgOVzYcAeJa4EXF4N1VNt693RjsW95upm7+F+pUU93C
 w3a/daNyQfwAwRqPjWBnqWuw+gRs29v7dDsaZZlLgMPI6or2sfu1OmG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a03:505::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: cb286a4f-834c-44f6-3aca-08dc37d6541f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d+mlGTUQekfTyv3BgwFoOss46ibcLOCu9D4mgeMWvm2FLxQ4SG6NzqjQqH4vzadnuijIjqYQUBmWgOQv0PVg2QiAnG4f1c/0BHOC37pm1LZHmHvcRBtvuneVAsnvTZJ4HOT9g2SRVH3A4VoS8A9aNdbTWfik8htXvyZzGRwv9EDuUZXwESa0M7XHQ9vUPnr/b7d1yNXy6yTqLyq6yqVzTo6JjcMb9g3XrKGHMbrhU3uHJOMNZuJs7d89UyAyqtFasYI7T9X0rc9fCA0KvEocQ6sDWowUHxgvovoGH+z+PlMuWn107LPiwe447WBNW2eoSYyZtV0i9JtRcRS0XDMtzb/FE5oEFo39Gv+Bdv6Bvy7YSiFiouE3uikucXRVVCnkwYlMgczkg+3IdTEsgPrOn5B/eeY8QHXbtfWJy3IMFleBZG6T/KTnQXiFFIBK9tg1e57QIRtjF+hXcZHFg8TyfJy0F855NtZlegksYQd9MIst39yKucl895NukysEamSeubtmh3h1O7PTCH4wo2Y8PrayxgLTfxEWXH0fLSKlJ2iOVj3BQvb22yFyBtqlykTfASiD4bXci/TowQ5kjdZr3/R4/yxn7jssAQwAchJnK9AFDRLg+kZk/W96NZd/C6+BxzDctIa0UlESoAr5b3dw3MRRc/6vZVNIdGK/oZYOK5R/BsB5dbKXIagS77bt2fHEsu41h+sz6b9OCtDhq9pTcdLbdVbrcmJTQB9bFgVdzU8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2loWVk0V1VzMFczOUJIK0pMODB3T3NKaGsrYWNNcUZBSFh3TnJqZDgwcHk3?=
 =?utf-8?B?MDZjeGpZM0xhdmJMNHN3eTIySnJDM0FUejlxRG5YREY1MVQyQVY3bTNXWXdJ?=
 =?utf-8?B?MFFkSVk5eWNnVStVdXB0T041bDZITGpJak52VWIvSzNuUWN5VVgxOGJmamlW?=
 =?utf-8?B?UC9yRUJOTlZtUTVmQ2lhQjUxcGgrMGNpb1NhcjhSRXd4eElXY3l4ZVdTTnRl?=
 =?utf-8?B?bHZoOVpCT0JGL2RuN0dCYlpSZzB0V25WUVZrN0VMZmlwWTVoZ3V6Y2RrcDl5?=
 =?utf-8?B?b09mcEpIdHprd1RFYTIvOSttRURyMk4wUWV1ZHlnT0l6T1ZGQ1F1ak5MZEdF?=
 =?utf-8?B?Qkd5L3VrU0crTmppOWFLOEJldkZJdFAxREFTQW1ESXdLL1ZldVo2RExkby9v?=
 =?utf-8?B?ajBuS1k2QU0vVVRsK3FXOEk1akxvVFcvYXNzOHhxMUhFaDR3WUhnVXJSWk5S?=
 =?utf-8?B?MVk2U2lJcHZ6NTR6WDh1N28wYUorSHBwZmZ4b2VRMXN2cCtBdThqdlV2cHg1?=
 =?utf-8?B?dVUydzBVQ01ROVBxZ3N3cTZSbm9td2dONmVUZmYxNW9McHJtUlZCS0hvLy96?=
 =?utf-8?B?UDhEcWl0TG9DSHBkblEzQUZmUkFMK2UzcFZMTEdrdnA2T1IzckorbkpDbyt0?=
 =?utf-8?B?bVprWTMyMXFMblB5NEhUVXZRbzFlMFdyZVR6dUp3ZjJvSlZKYklkN2RzTy9R?=
 =?utf-8?B?WVVyNHc3RDAyMlhLc3NJaUpKbXpHRDg4cWhyaERiZXh2L2sybTMrY1BuYUZy?=
 =?utf-8?B?NnhEZ1p3VFlUdmhMaEhzVVlqa0tlOThtSnBUd1ozWGN4c3VNcUhYdUdPZU1E?=
 =?utf-8?B?ZHdybUtIbTlXcWEyb0hHK0NnM3ZFTThHRWJiTHpBR09VeXJJTzc5L1RTUHAx?=
 =?utf-8?B?QzJTMDYySkJJTlVjd0hJM0F4ZHB5MnUzVkJKSERRTGYyQ2tiSDZUTkNjTDE2?=
 =?utf-8?B?SUlxVncraTBBejN6Y2pEemwxcG11WHJZWTVhOUNkSStLMWl0RTVObksraXds?=
 =?utf-8?B?UEZmR1g5WlJ3RzVXZ0FIMWcrRnhDN01zbWNOb3JyWkZyN1lZVUNtWlE2dlNk?=
 =?utf-8?B?djhpRnE3cU55S2M1RnVPK2FLdGVYUDhrb3ZKTC9hL2RtSzdyN2NQY0FqNFhO?=
 =?utf-8?B?bnpTMEtjc0lLQmRESWZDeWNIL0VRQWZCQkowSmQwVEhWck4wWll4KzV4YzFY?=
 =?utf-8?B?dFozWjZMS2tIWi8zdjdIcDl3UUVHdnArdW14bWIxdk5nVmpGTi9ydmx2WUov?=
 =?utf-8?B?cnN4Uit1eDI1MWZkaXhOdmsyVnlJRjVmaDRUVVF6OGJGQnZ5WWlvMzZsNjVL?=
 =?utf-8?B?Wk1hc1R6SjNERWU0VEhmd3B4Q2VFM1o3a1hmYTk1WGJ1RU1FLzRYZXVWUW02?=
 =?utf-8?B?czdLQW4xWS9ra0hJUUZ1SFQ4WlBzM3hzT1Vya3JkOWJwOGFsSHhGS1U2ZDgw?=
 =?utf-8?B?dnc3ZWNTMzNJd3pwVmJVRENtWnkxWkJCZnZDWnRYZ2wvNWMzd1p1VTJXQjBt?=
 =?utf-8?B?Yi91YXlmaGVWblZXV3pWclE4NEc4ckJOTXJYOW5BS1Zmb0RmNWVNUmVXc2pj?=
 =?utf-8?B?ZHBpUkxsNTJ1alJCd0MrOWZpdTYzT0FYNGRrTUExZmxqZnVOZ2Fnb3hqclJO?=
 =?utf-8?B?THN6a2tKU0UwQVJuUG83dXB2aDVKQ0tscTVDZXRCOHVHOWtTcitRWnhMd1F6?=
 =?utf-8?B?bDBVM0NyZmhVbWpYSG5wSkpxb1ErcitkUWtpQ0pYMlJySmJ1bTVyUG1SNjZ4?=
 =?utf-8?B?UHQvRXZuWmNjRzdqL2FHVFVRSTZDQjNPbkRSdnBVUEFyNURlMTY2UTdXTEw5?=
 =?utf-8?B?MzhKU0tSeHQyYXZHSVVSUnFjbWN6SExaVnFtRTl6WU9wQTI3dUF3UHMvV0dm?=
 =?utf-8?B?OHZtZ0loL0dqWlltSTR6NWZ6VDJZNHljNFZ5Mk52TXpiUjh6NVhTRmpjNG9k?=
 =?utf-8?B?OHgvRGdITmdaak5FTHRucjZsTXVvSzNtNS94azRWNEtlQ09sOEpmNHJHblpW?=
 =?utf-8?B?bWJvSHplK1FoY0FKTDYwajYza1VRM2Uxa3hpU2NiTWpJV0k1aWRkYm9Dcisz?=
 =?utf-8?B?R1J0SHV0R2NqbU5ZYXhadXp1QVpsSjVlMG1xUjk5WW1qZEJDc3FQTktqdkNG?=
 =?utf-8?Q?u+HFhZy7amdMEWADK5FdGd3V+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb286a4f-834c-44f6-3aca-08dc37d6541f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 20:54:45.4628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qDdPgBstiDzYOf3jE7ozLgp+E1SFBjyf7DKrgwQ6MawKikVDhseJF8JwvVSRfiGAPYxjw2fejrskBMDo/UZVOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9200

fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
have 1 interrupt.

Increase max interrupt number to 2 and add restriction for platforms except
i.MX8QXP and i.MX8QM.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/sound/fsl,spdif.yaml          | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 82430f1d5e5a2..debf0da759924 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
@@ -31,7 +31,7 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    maxItems: 2
 
   dmas:
     items:
@@ -100,6 +100,23 @@ required:
 
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


