Return-Path: <linux-kernel+bounces-92771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 362128725BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9042EB290C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9D617BB6;
	Tue,  5 Mar 2024 17:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gdyk9Kaf"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A83217BCE;
	Tue,  5 Mar 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709660015; cv=fail; b=pnRoWM2yvHQefHf0tAgE0BIeagjbJDIRcXRuucODREwwZ9ctVQ9TdrN96CyghLLKhJr6BBsl7SwXilMe3ZTETT32rVA9eZ8tuLZLp32ehgk3HOEnHL6bY94A2HIpINPcpooNVUAeXTWM9RjQGRI7eMobLrZFM0yek7Q6uGqmYGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709660015; c=relaxed/simple;
	bh=zkGE4oEsHjiRRUFC7IVGVciehf/DeQc/SiSZUFb3MIw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DAfcayFXpAPfgsvJmmh3LtbDQ1fVnUeQG+NhwbJNKaxiXafM01uRsWoHk3ioH+JmZn6IKBpZcwsvBoCXQDnPhu0O5bz5QIEMo27JRJZQ+k5mDTW8W5HJeXAJm4rXx3z92WR1mX7rPGoS4muufs91qZHua3ZgSxffecTsARvsiV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gdyk9Kaf; arc=fail smtp.client-ip=40.107.104.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+B2NncYAGCJyQekeYmaR8rfmu+RPdHKpMHGWT4tYUvguk/6UFIhSVbn3Wa/lrRx8+zAXoA8AjDDkMMXNpVGfMGDCMZEU6fvu/tuKUco+Q6TlGrSWp6QSlgxxTTczcn/64sBthTiU+NdsloAn7GXAzW2ANot8EAzhXFp1aOT4TK2H9kVOtARxkYc8qGG7vLMY9X1JLxnUQNOHQkEdOvQ5wfPeHEI7UOqgMRNu/S+3LXqWJZ4oK8xM01rW/SxJ/AIQKJ6r4fvlWzIVn8VCzWu0bYdQGZllpxXoSv6ZQM/9/Q8EXm3rgpJwfVvw6VUnVef9Dah28piw05cPdHVDppJBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSno13IQ91MOG9lwdozbe3n7b5C2f7s+b2x2aTJGPMA=;
 b=iFFAgxhXddiqmRV9hpj83NaPgqkI6fp4fyOdS1LzkxCcDLzvgpfojc9RVoLaxfSx6cVo3k/HTiSaKKYyrVCsK6a+hQjIJFsXm7FNEdrUt9M4Z20M4+vDtzJ2lAOLi8MmoNtXfxEaaLBQRREFdZBk2MpfKSTxBmdslmts+yAzDvOXZml4PJEoIOhXQiODnVvRVp25CBU/w5H45PguuMYkg8+V4wZZqCmN6dtaP5gS8H/LUMq/DkKVLaZ1XRWdIi/AvcsiZsulu0DgwAiQsRjUchsXGOh8Oz6RqDMmSKiDjgpvegyWm0XHjzz1mq6GnOAQQDJMlh+f0EQsYuPgFo46+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSno13IQ91MOG9lwdozbe3n7b5C2f7s+b2x2aTJGPMA=;
 b=Gdyk9Kafw9Rn7DS8idotuJGTwYsFSPZ7HfEXQNACJpJ6ZRYf3IIzc1NTGt0Oxd6e9A6n+y6vK3qp22XrhLXipuWSpXQ5dBQLB076ctdNnhRVTc3o07cxwtmy/kEcuGR/4Ww/7+APlk3pNGwvX5gGjethOPGnXK7eCduP4LwPK/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7856.eurprd04.prod.outlook.com (2603:10a6:102:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 17:33:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 17:33:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 05 Mar 2024 12:33:03 -0500
Subject: [PATCH v4 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-asrc_8qxp-v4-2-c61b98046591@nxp.com>
References: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
In-Reply-To: <20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709659997; l=1258;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=zkGE4oEsHjiRRUFC7IVGVciehf/DeQc/SiSZUFb3MIw=;
 b=wjr/zg9qJjx/rAa/tviIiG/Oapnsc0PPUPXY3CJeZHVdAtRrG41bhEzxpt/vPdpaIk1VM3Ou6
 sPjxj5N84gwD9/sfvj4s8CcgpOkaS+xrQm2BAkeFtkhXr0pLrSleTqI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0159.namprd05.prod.outlook.com
 (2603:10b6:a03:339::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7856:EE_
X-MS-Office365-Filtering-Correlation-Id: a6dc1b79-cdfb-4dbd-7813-08dc3d3a5f14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pTB1fJBBjAt5R0/+FulemTY5gJ9MeKZCEJDG5ZtUFtCPvpSMcSYDpnPJ5NAStgPql9BGYLSsVTQNS7gk+dJmMch8SzT3W4MX5XfqlIqMiNW8WV9w0LeN9DnAha8AWjhrMBK7VaUrYBJ92V+KFIX64AW4zcCZCwj9jM1nlV1R7S07Q83eCv0eKMuV0OHEuc9d5e+cYdbXNAUhpq7xESvgRMPgqfu2gx4HqTo6FN8DayJWXB1xSxFsh6WZDy/kLBLwPW+TGHM3A9NjwavQxclf6e+L9T5K2xYndGwBwcYKoM2T3T0zVRpAn2l5ObUBSEQm5fv3s6lr7ERmk0z/z0MuFMJXRZcOxeJ3UO/Uztvlv1mzAUicvk7rt6Pu/gNlRNvmGeoMPjfhsci057MrO/hc+rsGs8vzz3Jv8ES1l7llLR7tqxdQPU1rRWxY6crXt4Vw8XtqVKLMedk/mVTXTGwl+sEzvmObCfxmW9TqtiBMPrH8XH9PRQRC+6KNF3rVvIriwmQb9dzEZXQC0ky9hM8JWA3Ex0e6fpiYjiPDvu7MiJsXypURtfgrE+bi9ZhXS+wsi7G2UYGrwvxBotkZNRINpBUaQUOGNyD9s4vz28mqdXIeHfnixYZucbGwRRp+isUHZiV+nyMwLXS07iMMua8CPRsmJcNAysIZdUsQtI5j33hk4W1MkVrhEYuNVWhk2OD3rCT2WnYjKSbqttem2/URIAr43OqcRe+0ziVtwW/RI1o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L21JRUNxYzVjS1hmZFl5TDgrdG9JcjNrUzR0V0VKbjAraWpiVWNweURJS2cy?=
 =?utf-8?B?TkhYSHlUU3F1RGJtclVOY0xscG9zd3BqY1NqcGVDSTFscnVvd1FGWFVSY1Vs?=
 =?utf-8?B?SEtSeWZHWFowTlFzTTcxT0R6TEdUeW5memtzWnR5TEQ0K01PSTBjS0x4NXF3?=
 =?utf-8?B?NEh6RTNPTmdoLysvUndaNDVwbXNrZHVSMTJMR0ZmSkV6RUNNNEFISnhnMTBE?=
 =?utf-8?B?Zkp6ZVlZUE9meFNvSy9EazFmSkFSMHAzMnVYMmw2czlBQ25qV0FjN1pwNC9U?=
 =?utf-8?B?WTdFdE9pV1pSK0NtNDNWME51b21hakZDK0JFQU9Fa3JKeWVkUW1sTHBxNmlN?=
 =?utf-8?B?TmgxcllmdTBXMW56MnRROEMwYXVjbzZxSFZab2plL0JoUDU4cWNtZEhzR2xU?=
 =?utf-8?B?dUcwNGN1VjVVWmt4OG5RSG1GaUd6VjRPNStOYTRCdzVBbHdWVlRBSGtoVTRm?=
 =?utf-8?B?QU9UMDdlQjYwckl4UXhaZHBNMWlqaTBzMWJWMWVKcElTVGgzazVuTzRUdGdU?=
 =?utf-8?B?OThSRmQzWldaRnBYL2RBdFJJaHdsK0p1M2sxS3FUaWtvR21VK0RtUnNtaTdE?=
 =?utf-8?B?bFFyTG1qRFFnekJGWXFyaDJCUm81ZEEvT0dWbVVId2ZGMVcvWTJYKzRPWGMv?=
 =?utf-8?B?RGRWVkorS2VIRmVrMmpRMkY4K3VtdmdrWU9hVFc2eWZZeFIyVkRJYnlVSlN5?=
 =?utf-8?B?M1o3cU42VEdRQVZhTExLNEZHQUQ4VWt4SEJhcEVWWHNUUlJMeDRCcm5ReHE1?=
 =?utf-8?B?VlZmSExjUXBLc0FFUDhVSmVjNmRmTjFZYWRGNDMvWXV3N3UwTktPQUdPbllF?=
 =?utf-8?B?YkxDSmlja0w1MGJaNVY4cTM3RktxVFJKcHpqL3A4MXRBQUlRL01qQkE0RjVL?=
 =?utf-8?B?SG5Fb3hhbmw3cHRCTTdRWER6b2xDdHI2T21XSzh3UkM5TnpMQ1lMZzBxdkNZ?=
 =?utf-8?B?RTlOY3d1bHRQWVdTOVN1M3NXLzJOVVgyVW1VcXUvSm1HM1IxaWhNVi9BVkVU?=
 =?utf-8?B?SERodGIvb3JsSC9ic241UTBXQWxMeEdtREdneWZSM3hjb1cxM1VJK1dVOEwy?=
 =?utf-8?B?djJKY2cwZW5UVHBwT3R1WXgrNzkwWUw1Vkh3WXBDWVBDZm5ubkhBOXJ4dkJh?=
 =?utf-8?B?Q2VQSHVvUUczbjhuNnNpemhTWjcra29kL0FrUy9XNGQ0ZjJURUZ1dDZENGEx?=
 =?utf-8?B?VGI2T21zVnltbERPMjFTcDFpUzdMQTh6andRM1ZlV2xGOXlPYUFjRlM1aDI4?=
 =?utf-8?B?U1cvTmtPVklFUlgyTFFZZ3VFUVFnQ1NVTjBHSWNhaDRiNjllNVc3UU1wenNV?=
 =?utf-8?B?Y3g2YlR4K3lkSVBGVzNya1hsamlxVVdzV3VTbnNZVWRWdFVQdUFrN0FCaEZP?=
 =?utf-8?B?eVp0QUVnb3dTMEd1a3NSOXVkQzVtRVhUSWZKUkRHUk1KWHpDQ0d6WnIvd3h0?=
 =?utf-8?B?M2RHeWV2cVRLS0ppRnVTdGdpaDdycVVCN1llRHdhNTh5RTZpQ0RPZy9BUnFM?=
 =?utf-8?B?WHZQeTNjK0E0WEt5V0pFRjRPN2NISHIrckZOc3pMYTlxbnEzQWRIMDJZNVVr?=
 =?utf-8?B?NkMxRlMzbUlIZW9vVkJMTXhiTzNCV1grbXNDY3JNQnh4Y2l3S1k1cU9MZHVk?=
 =?utf-8?B?SmREMnhSOGIveUU4RUJzZDNmeDI1YnJhUkF0L3BDVFpTZEhvUUloa25kbHNl?=
 =?utf-8?B?RTlLSlQyOXk0aGN3QzdVaUJ1UVY0YXJ5U242UmZoRjE2SDJNbU1DWDlJNVBD?=
 =?utf-8?B?c3lVWlI2S0F4eXY3bitJV3BSNklDR2x3aEQ2ZkxsN01MMCtZYTNldXNnbVFZ?=
 =?utf-8?B?NGxJVW5WeDA2bmxmNjJ2TXlKWVVOWFdQeTNaWmQ4NUVQdkYwVEZBMVlvdzlO?=
 =?utf-8?B?YmhiNGNBbVNCRmR4d1M0SDFLenNYc1ZjQTJSWUdhclVJdS9pUnIwN05DMyti?=
 =?utf-8?B?WnF3TVMwTlBQTUVaYzlJT1N2cis4ZkRhanNuYVhCS2UrM2szRjhLV2U5M0Fw?=
 =?utf-8?B?WWxTQU5tYVd5L3FxVGRUNStnRklwUUJpdGJ4cE5laGxLeC8zVkF3VkJJZGFl?=
 =?utf-8?B?ekZwbnRiOXQxRFYzdEZmNkt2Nm9zc1NDMllBM2lkQmRrdkc5a3BVa2U1cVRB?=
 =?utf-8?Q?RVlxIggL17Vq3sLW8qeSBIux4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6dc1b79-cdfb-4dbd-7813-08dc3d3a5f14
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 17:33:29.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7Jb2/TFZa/WRYF2znqcglFzyWPMrXki3NZyruWRh3BxQ+TIe0vY1kfK+Hz3GaYOVlPkThwxkj3Pafva7a3pZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7856

fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
have 1 interrupt.

Increase max interrupt number to 2 and add restriction for platforms except
i.MX8QXP and i.MX8QM.

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


