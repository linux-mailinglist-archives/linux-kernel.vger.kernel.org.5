Return-Path: <linux-kernel+bounces-96088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C322C8756F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F8C2839CE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B0E136989;
	Thu,  7 Mar 2024 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PUwUcVsB"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2065.outbound.protection.outlook.com [40.107.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF621332B3;
	Thu,  7 Mar 2024 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839179; cv=fail; b=DIV+Majz2+Szo4ibCLTtIaDkxizFk7o57PeXjPBtyvIW5aBJjXybHzUdrnXBZXSXo3dfLmQKA2ifwbVWl7UhXZIlsFugizkpBXaNv2GR9nPtvyvTC6I2Tm2r5s7XLFmjUX/yuKaOStaLkQkjbrJHss59QOhAJbv+GTWmR27BWcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839179; c=relaxed/simple;
	bh=1syz/aUeJNCMRuMdqZfLAmwttcSh8oLFScKSrTznruE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=e7f/xdr+oeg3mkFH/xnbqcF2nJ607qAvrKHKv7edf0oy++XsCbVa3mIwta0IPNJafNHm5z2W1JhkKvs/7QJFy0DggDs0gk67PTtmw0fLRpU1SfjqDcSmXS44OBlglBc0t0DkZIt6BKpCDHrLGUuU5Wrve9AqONSGb6f2FohjknM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PUwUcVsB; arc=fail smtp.client-ip=40.107.22.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBZ6j1GjY7AyK/RsLNAcQvD8ZLwj7qtYWksyX9c4ly/xbdyZcgaQ5RuI0XC0iPGCVmNLLEQkgoFJQly72Ipax3YSuBVXyrRpIKk+z8pHhH30P+PfJRDwjmBkgiJYKU8K+mn4NOm4Yw5R5XqNqZzFksyLpssPTpVRP3cQweeOa/Sdg94yarHRNQfCnLfCa2cAnSYVfSmYhyxFNDX3hvAvNdy3Nfx/PB3qz3LOiD4qct4NMLlKOtkF+IXG/AWirHEnA4TuxNsv3m4gZlt4y/MC6M46bqw9Ts15iB02Y9Oihy+zzidcCULoua6zZeVhRkrhJGLcA8NBoHvlTyLl8CWfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+87M1nJCCt3nFThf9vTFK1j4y9JjuhQ/XCHl3Fycsc=;
 b=R56U2xuxf5QQa0uctMl0IQA6jMpHs5EJEPqLLJv9rfVb+FgR/U+RJU6febiTHYSrzvNX5mVfUncxocBp3htpQCDrzIrtJuMD4hYk+2rwt2zYpu7AGsKvmPAM0A/MnbHRDEaW7L2KgK5ckAOlS4Eh5G2/pkV452kZyTM797MJ5BsMS3x12fkbenKSx0dUpgIBAeTsb1Clzk63/fOHA1Q1JVTvUbSKbnodc8gLRp0/rFasskPdZ0ve+2aw8aSFBSbiUnBPIkE1c4LnoS56eYKmfd3VzWgpXVH2h4YP2Sr7rOjMyo8PfKLPTTVpUgskSEIZtSS2A8w7aBJP01jzv30OoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+87M1nJCCt3nFThf9vTFK1j4y9JjuhQ/XCHl3Fycsc=;
 b=PUwUcVsB8xF7Vmul9yQntakOno0q3Or6clPF47PSgLH5Y5ANF4jVlDyttB+aFZ1WGlFr1iNbELAswl49AJjjiw7J2+7/+ky4zYMFpd7nI6kNiMLcomOosrOLQt04moDW0gY5VCPmARp1hgYVle1fSzIpvSck+OMdbRUHBTmQCHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 19:19:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 19:19:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 07 Mar 2024 14:19:08 -0500
Subject: [PATCH v5 1/4] ASoC: dt-bindings: fsl,imx-asrc/spdif: Add
 power-domains property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240307-asrc_8qxp-v5-1-db363740368d@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709839165; l=2330;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1syz/aUeJNCMRuMdqZfLAmwttcSh8oLFScKSrTznruE=;
 b=K2sJ+YTmrQbd2VdOvbCf/fL9e1mH+eauhSmSxuWInYuVzv59D+XnmXwsO9L8UmGiLvuVrHZi4
 zX7JoX+Fa/0AWsJwdSMRi0TVtyRLDIN9SAqqGJSgJZNKTHabYq8j0+Y
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
X-MS-Office365-Filtering-Correlation-Id: f7a561bd-e629-4591-428d-08dc3edb8522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8knDGiCcaQY2EJTRMUZMyTFXJflMyNiywQ1tDzc9ahHJlmTmQvUXEGL7C2EHGT9k0nBpL1maDC+0ZKyWuW8FxpgByRB+hsxfdfxCfX7pHb3lUNznXd8L7krUv2393Y4P/GUCm9ixxtMJVKl9BgHwSzdaOFwj3r7C9XkmFPbfXCMvjyjlasRSuDvSCApoOuUgGD6K9+7DuPeAPQhsY7xeMkXRF5bK2vGrsszbtl8YxqrXnSZSNS8ppplSfMr1vFtvXv8luIB9NsZ93JUKwwpnKdguts9jjf8EExkFxdk3VlsovaMi9R0YlEiSscB1ZAvZCT81I6/RS9ry9OnkfpjmNs2oRX8kRDjV2ToqC3sH3g4dDnx3kmWDGDZhS0VVi7198eSZVIYB5O3VRYyt2ZZaal2cXfg6CL3byJG0yrA32DpaYMsWTJbuchCBnGwbmgjIwQTphNJBtIy0zqQxC0lMJjihHnLhOeG5h9NIfYv3WoTl3oF66ppMP3WebAoL/mO65u830917iOWnGnk+Xrk5A3bNbEmJzzedmAZPXzr4tsV2pKT0MEqRCiGAhTvso2A4miq5pqJ1T/FXPXFD+wmftQ7KyvEXnJw5vlzOoNyZj4Jm2iEs7ubSzJWSdSoX0GqtaJ+MnIWB7oeErK7J8nmZdZvigqHIqwVjBp3iYs9mWxPGF6AOdUQZjWaQIW3eDhzxUdXsRfc1HMndtIBsSTdBzIyMGX32Uw9byxVvxjwdQuI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTJYK085d1kzTmJTb2F5WlB2b1BPL2kvakZoSnBZODRxOWFoWHNFUFQvdWND?=
 =?utf-8?B?eG5kVUZodngzOWZic1dCbldSMklHRWtwb0Y4RG5tYWlESVJJZ3dmR3locmhJ?=
 =?utf-8?B?Nmtjd2lyQU04SjkrMGN6TmhZWm5qMnBJanU4VVZyQlhJeWRCcGhHUEU3RW9I?=
 =?utf-8?B?ZmJEMnhHR2t4bDBRUlJ4TjgzK1YyamRiRThUSEh0dHhhWU8vYk9jdFVSUVBj?=
 =?utf-8?B?eldGa3MrR3hEd0RSdlFwM1F2WGJrZ3pUME9xcGFTVnU0RGVMNStMQjlKS2t1?=
 =?utf-8?B?WHdteWxwUUhraXZIUGJNLzhxcWw2TDY2ZlJvclhpcFJuZ3dWVmtFeFl3OFBm?=
 =?utf-8?B?Nk1nN2hONDRZTnhkUlA0Tnpwemx6bTZtMkg5VGx5SFdXVGo1TXJqWEMySnJs?=
 =?utf-8?B?Rkx3eXQ4Yms4Y1pDb3BBUVBPeUhmT2NFSDZvbzJjRTQrazJsQ1RTMnJ1UmQ1?=
 =?utf-8?B?Z0czOXZuT0FidUsxTld6WVk3ZllwTXR5Vnc2VTB3TVRzUmVHSjZTZHc3cjJq?=
 =?utf-8?B?c0o3NXl3YkRRY0dROWkrRXBGcE1CTlAybE02ZzRpSGhXd3cxWGxIRmtIWjdy?=
 =?utf-8?B?RHdwQWV2M0RUUU1UZkMwcmM3SVBlblhKa3BBc1JSMXBTRUxxOFg1eFlQOWtZ?=
 =?utf-8?B?RFR0dGsxbFd3cmh6b2pURXdSZnZIUHJkWEVNUDlOZUFjNDAzMmJBWkswckFC?=
 =?utf-8?B?NGlkSndpdDFVRUJjNmRqZUZPK2MrVkRUSmRYd2FtVE5WTWJxNUE1SUVXMXI2?=
 =?utf-8?B?eVRDVXYzQXpEcWpkL2Rkc1NIQ0M1NW5MckU3L3JxSjh4ODYrRmluS2szWmRC?=
 =?utf-8?B?L3dWeHo4RUVVc2NZbUVaVTVVRS9MaHZzbkhDNnluUHRxMHliRmZIODB2dWpW?=
 =?utf-8?B?dUpUSHRoT0FJdGxhOHpqcnF6dnJJUkduQlVvMmZXQm5jcDEzNXZDaFU3M1ZW?=
 =?utf-8?B?bXdOS2dLVGlKMFg3d0IrdlY4NjNrTE9jTFFBREVPNWtRc0FtVGRYWDJYcU9k?=
 =?utf-8?B?Z3RIaFNQaXJ5bjZKL3RheWRBc3RsMXdyWXNTbHcySmdYNTBmam9sK1dLaytl?=
 =?utf-8?B?cHo1aDQxZXRpNG10OGF2ckdqNDRjejJWVzQ0K1BBQmRVa1c0TUpFQkY4Z3FR?=
 =?utf-8?B?aCt4QXIrMFB3M0tFM0JFTE1XWkFIbW9SbTNqZ3NCRmNjZ1ozQ3dtTW5ldVdO?=
 =?utf-8?B?S1Q5czR1WEZ5cC8yWnpmcVppdmRwMGNVaEJxV0x2bnJGRnBsSHhBU3JMN3Yz?=
 =?utf-8?B?WlA2ZnZCVTJ1VGR5RTdtTUcyOHpsV09ZRjNaQlNOaXJicXZHQjhTQ0doZWdI?=
 =?utf-8?B?NElKWVZ2N05ya0xIbVc0STkyaWNRY1NkQmY4ZnVsUTJ0RGxZaURPY3dsdlJv?=
 =?utf-8?B?Vm5PRTh4WmxWUFYwVVVBOFpuZWxBOVFzajl0VXFIZzFpM0o2WmdUdjBWTUpl?=
 =?utf-8?B?VUVYVUI4RVNKcitFSjU3SndINnVRckExcm9RcGNSUkVlNTVrUzZTN1FjZFJC?=
 =?utf-8?B?dWpnVXJLOStIRTRua2w4TFhVT1BsdWV4QUk0eDk2L1BuL1hwVkVyZ21DRERi?=
 =?utf-8?B?SFJRQ3NGWGo1dTI1L3pucDFPNklnRzFlMmloaWhPYnkwV29ES0xOOFhGUXhU?=
 =?utf-8?B?ZXhLN2w2NHZjaUJ1NDQ4SnY0ZFovVkFIWVJidElaQ2RCbmV5NFdoeGpmenVF?=
 =?utf-8?B?YzlxSndRNy9UNlVIejVETFY2WHhxcVlaUzM0eEIwR3kwQzNnaldqOW9Zb0hB?=
 =?utf-8?B?K2VRalhvVkFPN0RvM1NGV0QxcDJpdjcvcmhzVWlXcHliWk1jQlo2RjBUR3cw?=
 =?utf-8?B?dzFiSHhaaThCalpOTXlUYnZURmY4WDZlTUlra0UvQ2Y5WG5OZ0Flb2lPbWw0?=
 =?utf-8?B?K3ZsbGVJMi8xVHhTNzhEZGtJMktSSkZ5MG0vcS9RaVZvZXY5Ymg4eXkyUzdT?=
 =?utf-8?B?U0gzVjRZaFhJVjBlOFVKM25LNkJjWXU0V3psNkI0ajFvUVlvc254N21kenJD?=
 =?utf-8?B?NGNXYnRWcnZVMFhMM2FnN0dSRGhuSzFvdXdFOElVNG53T2FjMnNYbFZFODhm?=
 =?utf-8?B?dzBvNFNUaE5uRTJoTGl3TjMyQXp6STdhYmczRnByRFFTQnJrMzVFbFFDTlBY?=
 =?utf-8?Q?/U8+M2BsmqfCO+jyfb9BENUtV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a561bd-e629-4591-428d-08dc3edb8522
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 19:19:33.3070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGbqUsWhbndkSNNCJ1H4VsFVPf2Hx7zt8+xCyBUWnoT6wK2AOH1ws/1sf8XUIZ30SQwq3LOIzltmffvOQ7l9Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

Add power-domains property for asrc and spdif since fsl,imx8qm-asrc/spdif
and fsl,imx8qxp-asrc/spdif require 'power-domains'.

Set 'power-domains' as required property for compatible string
fsl,imx8qm-asrc/spdif and fsl,imx8qxp-asrc/spdif.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml | 14 ++++++++++++++
 Documentation/devicetree/bindings/sound/fsl,spdif.yaml    | 15 +++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
index bfef2fcb75b14..76aa1f2484883 100644
--- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
@@ -74,6 +74,9 @@ properties:
       - const: asrck_f
       - const: spba
 
+  power-domains:
+    maxItems: 1
+
   fsl,asrc-rate:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: The mutual sample rate used by DPCM Back Ends
@@ -131,6 +134,17 @@ allOf:
       properties:
         fsl,asrc-clk-map: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-asrc
+              - fsl,imx8qxp-asrc
+    then:
+      required:
+        - power-domains
+
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 1d64e8337aa4b..56f8c0c8afdea 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
@@ -86,6 +86,9 @@ properties:
       registers. Set this flag for HCDs with big endian descriptors and big
       endian registers.
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -97,6 +100,18 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-spdif
+              - fsl,imx8qxp-spdif
+    then:
+      required:
+        - power-domains
+
 examples:
   - |
     spdif@2004000 {

-- 
2.34.1


