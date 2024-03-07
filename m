Return-Path: <linux-kernel+bounces-96089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDB68756F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924451C2101A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F2D1369B9;
	Thu,  7 Mar 2024 19:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nzeEgos4"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA013667A;
	Thu,  7 Mar 2024 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839181; cv=fail; b=rK3wcFAoKpyVE2wlnJQS8BScMJyD6tpcwMk6FGmNMdyvWRkhDXdvyy8IurbZLPnsx9k9HdiNyVo/gWgGdtqcQ/YYr/Lmu7gv9HUBJ4DyJ5cMfYR/c5PVlAeVBILX+y8vaq64e/koUS9yEJaS0ygAp3Yh5Y+8ph3mBX2a+sL1xe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839181; c=relaxed/simple;
	bh=tNx5SX1FqYkCqIsK6BPCs9eWHLMa54vHs5s/kd+qzQg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=G82/xlcr2o49ySSVfpBui9Va+1FTUDvMgZGwVlS3Zmucy0NI4CkIHHEdG7mP1Ir2xrYgrSgp/QFthLJQILJi41+DJHs7i/6XViN+yaKNURawOEc16/dF9BDp33ebaWWBG1Ot0rRilbK/8gFOdj9vJJGWbdPa08stqImYzmSr7Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nzeEgos4; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOpEy5sDseJ1XvXXYekaOMidQHs+r8B0F3UwfCAvcirna4fpTiolQ90nLjCTxpMKhVW5wAma5LR5X+NmLsBaGV4sQjzpRb8W+p0J1mnMYbg80HH40NVL2RDRpZWq2Sds9qWtIKu0eeLreiSRyl+cITJRWmzekKrQQadHTimgrAz1YX1BuZVJGKpZxqLgC2OYLm+/gTd9ndOQQy4KU/U1oTJLPGIfYaTBoKM28cOTxc5aqiJEddZud7ic9eijYLZBb4pOIZPZdEPo1CuBHnAcIPrujcp6W5I2QDP8zRG0mdDt2MZxu+/USziUpAov2r83ajpompFkmohbKnOE0WuA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AG/xU5NW8MHcIRMSa0nbCb0NKxEYZ4HCA5IDZ0p/Rxc=;
 b=JmckIV+DKQScKsb9KWEHnswrYEAZyMGyao4HGt6KGE2joU5pOwpT8BZVVg6YjXQTEJEuaAfCZEWQ77NL4hCv/JNFI9ZR772hHnDtYT4xVUbCXmEiiTfBjPMJu+o0fWY7rGE197RCjrjUAOw8aGN0zFVZsEs3TNTjClAeOcbtZrhCq/0WTYD7VVPL+3ly4ZwuKmDhZsi52AgQsJfAwB4/3/O95+EuZTq6USgGVRD7ti2+o7mBTK/9TZWFCniC1gjcNtcY5HraMltbtpzEYCvJFAlwr7vdsNQGGAPT4J92O8g6NLuelrvAWHpUiZHC/Rh9UGqMYvg7KsOXB+nFQhTayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AG/xU5NW8MHcIRMSa0nbCb0NKxEYZ4HCA5IDZ0p/Rxc=;
 b=nzeEgos4zfxDUfpjsAdQbEN18s1MwlNppxlrcRYWuD7ZwUBxGDq+eYcpSBNTeVGhlowpGNAQ3TSq6f09Ms85lIEBy5n4gE3fNXN3eIHGWUv0PA05bMuv9W3yBd5hUR68BnRfp67nEeo++ZFlKdrc06dvnObP21gndNQ94fLk+jM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 19:19:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 19:19:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 07 Mar 2024 14:19:09 -0500
Subject: [PATCH v5 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-asrc_8qxp-v5-2-db363740368d@nxp.com>
References: <20240307-asrc_8qxp-v5-0-db363740368d@nxp.com>
In-Reply-To: <20240307-asrc_8qxp-v5-0-db363740368d@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709839165; l=1311;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=tNx5SX1FqYkCqIsK6BPCs9eWHLMa54vHs5s/kd+qzQg=;
 b=uHbZN9AG/pYVDPmrP736QtOmSaWRiaSBBHsBsi4b9T4gOk0PaW6oTyk8PR7W/KiYdJVuh47P4
 fa7iPaZRHauBtNrxyV5FgBJNChndCFbiidw6N/0rbH1BfeM8S4JjSIH
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d3f249-e139-40f3-db52-08dc3edb8782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W4/ApDtDvH3lD691kLmvADZgSLEWpymD+x2cbfSshWPdXnTh5aacBNLpKFeT4EZKQ6fWt0hq2vJrVfusC5TGdK1/XHtVgtZ+iQroP8AMtnomQyQD0D/4LE0g8L9yMCZvcjUO4EgacK2gjIFAnm620Df9pyfcNkhd+hgxetZCFNGtNte65SDE5eB7NjVFg6yU9sTVdHNBsyGv+NY75dDkZWZHwNm56WTdxjiMcT3S8o17W1mGZKQAPcRlAB5h6kqIGR8NUC6Zl43+PHjAV6ZBYtbdhGEHn6rs9+0REFYOcVm4LzpsFsQdf2s/1xng+GVCD1yBrZop8y3FwOl+Ca7ouxFm1q0Jjv3FlsccIuKJKt5/AVBMpuaWSzt+K+mWrtypegW+sf+eqYT0FXFvGbRyC0XHAhoDqXful6Onv4N0HEB+L2jdp8VAYCqQrO+do65Wy6k+NzZ17rgVbw9ePJSuE+Or9BW+FziwsTiOIe02eKxgeuG8JqF4uBshM1ICMudKk7qSehv9gBc76yCnKa+05mBBLKr6VnfFYiw1pUfUumrDCksitkzf6IfLXUrDYTJShSjVFB/E+BUNQ1LpsF5ANLasLhXPv+IEkAlh72I24+3uV7kliTnqBiPmqEZ2y+1uSAl0XTYdQ3gY6O6TKSY8R7/wl0Oqjoovnd5iKmvojw+8GnmLF+Wmh9kAXUvTW3j9K2f9pkzktdmim/Exdq3CJ8a4eqCRyhDvNR+pdxIdp1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWdNUm53aXpIcWMvTHRRZ1lVdW5yUzg5QnF1Vk9jU1BNak1ZemlnMHpzQ2o0?=
 =?utf-8?B?R2hYTDZmaElIbnRpWGRxVGY1UnBNdzYzcWVvWWg1dzNsQ2tYeHE4Q1l3NFNh?=
 =?utf-8?B?OUxkQlBXZHdwWmpYMVFTdVMxNTNvektka1o1TTQ5aFhqUGFsM0RjOFg3VmJa?=
 =?utf-8?B?SzFDbU1MMEtoM1dvMllhMUFQbUxzK0FWTHhSc3NqVTl2R1N1UkdZYkd3Vkxj?=
 =?utf-8?B?eS82SmdiQ0dra2hjcEhYRUFFY0ZmVFNNSWtlNXBhNjlpSVRwTG04ZFB0SjQr?=
 =?utf-8?B?QWFaOWJ0NHBsRlVJdCtHMW5OYTZsc2hlcGIrWWs0WXJXOWt0dmE0QW1IOHJv?=
 =?utf-8?B?Tm5BazBvZ3g3bXZ5dXhJU0VqdEtELzV4ejViMWt0anNaUkRQeWNZdGEvZmJN?=
 =?utf-8?B?YXFFSjZ0K2lyU0w5NytvaWhnWVU4WmxQSEVmeWdaVmNJOHc2Um04dUFVV0Vy?=
 =?utf-8?B?NE9uZDBOd2tQRXNYYzJZNWhYN3BSRVZiY1FHSDFVOU9oaDd2SXMyTGlMT3JD?=
 =?utf-8?B?ejRMUDFQVTlDQk1jSHpQKzVZN1pxY0ltZkZ5cFVRMFE3eXNxREN5dXlwbTVU?=
 =?utf-8?B?SzVOMW1aUTF6RGhRa25YTFVDTzgrYjZjWldxMmRjckc1NTBGNlB5RVNGaXFq?=
 =?utf-8?B?TS9DK0p2ZlVEcDBaaWdIbWZ4d1FtUy9QR0dFbGsxNzdIdDdTMUdmT0prVThq?=
 =?utf-8?B?cGRsN05ERHpnSjlHd0ZkTUxvMnJjYTNjOFo1U0FZQy9IS0l2OXNSbm5KSzli?=
 =?utf-8?B?TUw0dFBrSVNua0tENEl1SDI5ZXRycVc1T3d3SWhTSTlKTFdoaUc3Ym1TZjZt?=
 =?utf-8?B?TUpHNGRZMEZrcUpGZlQyL3BQakV3SFcxbzlWWGUvaVVnWEk0RVg2S2NkYWFs?=
 =?utf-8?B?MndkZ1ErUnVzTWtmbFVYbE41TVA5b2tNd05DMVIvWGRyd3VZM2dYUklMWXdK?=
 =?utf-8?B?Ung2TDN0R09vQWxvb2lnd3QzZFFZTHNFR08rM01tc1VRNE90WEFFNHVpUUlH?=
 =?utf-8?B?YkMwV1RINEYxamg2aCtxMU5FaFg1QWl0MnI0eGY5S2I2OFZpS251N3g1T0hn?=
 =?utf-8?B?WjdxVjVIaTVQYmJmWG1zRVFzNko2NjRJNHprV0NYNm5GWGtZeFpYL3J0VEdj?=
 =?utf-8?B?RHRkY0hibk1ZcnpUZ2FCcDVTZzRRV1UraytLemcxcTJ3bVpvNkxrZytXaHM3?=
 =?utf-8?B?Z1ptQlRFQ24yb080Sk1ld0E2VldNVHJUSzQrYjVkbTFKOTh0Vk9MRXl4Q3BL?=
 =?utf-8?B?S29BcUkvTkRFQm81OTRra2RKSkIrMmNoaFVLN01yT0FrMWFDL2NzMWo3YnBZ?=
 =?utf-8?B?Mkl0SVM3TjdsZkpvOE8wZzVVMmt3K2tGVW1BeHNCU0xHRnROLy9rR25VTTJp?=
 =?utf-8?B?VmU4c0ZkR293T1FBZ0lyeHNBd0pNalNmeWNSY0hzUm5uSS9Iam41ZExhYkNu?=
 =?utf-8?B?N2pZMjhPQ213NlFOa0xVVkovRm43WkYxTXk2NXp4MEZMaUovRFJzbjUzb1k3?=
 =?utf-8?B?VUhJSUdRUUEwOVkyV0NrTWdYNEtRWlBnN2pkVGhLVjlmWm9GdmkwMklUU05i?=
 =?utf-8?B?M0lIcGhqU3pncnNWcytYRStVN0VaY2ZLSWFTVHFWM2VMVXhONG8zU1A1M21Z?=
 =?utf-8?B?UGRpTnlhbnlWZTNURTR4OEJnWGtPenE2Yk5Zbk1ZUHc5M0Q4aC9ERkx4ZStV?=
 =?utf-8?B?TkZnYy9KWExpNHRjMjdpSFFGSTJ5NzdIVS9zUWRQTXRIVk9vZ1BTRllicmkz?=
 =?utf-8?B?aGNtY3JKYndvclBZdzJWNjNoN2w1bEJ4cUlVV0trUGppYzNnTnRBekxsaU54?=
 =?utf-8?B?emVUSWVXOXNVUWZFUTZqQlJZTjIwNlF1RFRJRlYzSTBlckQyZnFGR2xsSk03?=
 =?utf-8?B?RnBpTEthQUVaMEtvNmdiZmZEc204YVUxM1VxNkVWZ2ZmQy9pMEt5c08vZEs0?=
 =?utf-8?B?eUZUWTBqMzBRY1JndW1BclJET2t4YVJIMnA3U241dWgxNHNjVG5GNFdmVklq?=
 =?utf-8?B?ZzVpRitadFNuSDBMSnNROWNHYzNGakZBRW56aWVseWZEcVozVVh2SUNxTVkz?=
 =?utf-8?B?U0Y2RTZkZHlqRXIvMXJOSzVUV3lvbVpST2t4cTRMaWpNYVJOeHFtYWVjRGdu?=
 =?utf-8?Q?0dXzSEG7Gyw7+HwDChSQaoN3d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d3f249-e139-40f3-db52-08dc3edb8782
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 19:19:37.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHsseyS9DDUsQ0kT4CVeLWDoICIlBp+A+WNaGHcMgd5NsnokkCwgCKEJjvBxyC0B5eQ6qEGgwBUxHfkBSZNRkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
have 1 interrupt.

Increase max interrupt number to 2 and add restriction for platforms except
i.MX8QXP and i.MX8QM.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,spdif.yaml | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 56f8c0c8afdea..7f6590708e1ec 100644
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
@@ -101,6 +102,21 @@ required:
 additionalProperties: false
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8qm-spdif
+            - fsl,imx8qxp-spdif
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+
   - if:
       properties:
         compatible:

-- 
2.34.1


