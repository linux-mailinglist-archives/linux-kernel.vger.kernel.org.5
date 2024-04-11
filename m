Return-Path: <linux-kernel+bounces-141378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B968A1D74
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759BE1C21581
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D77B1DED9B;
	Thu, 11 Apr 2024 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AhrHvZF1"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44E41DED8A;
	Thu, 11 Apr 2024 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855301; cv=fail; b=arY1ypHHSXDj4/ARplWvXMoj+YocuDFpu/ndiihceh8xjvb06HlVcGfW/ZxtuQiBl/WE+8+M+15ysEQoaieGBTW/NrSmDFRQdg/G95bfn9fI+6ux3EzqR1Q3St8p5cIDqRg8NKZTQRmOXKW35bhJbsgmytPkA0/0608KplYOU8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855301; c=relaxed/simple;
	bh=NFjI6LIz6OYpL61fsJMKvKuixRn6jpdydO3y8TbiXHs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FGtAome7Vm2ZQU573MfuNrGdZBibLlpyEXkKw1pO2esd6fON1kqss+53j7usIoeCZSVMiyVNUsivMoWzAobk/cAc3X/h5dEVQP5vy9aWGMGYiG6cIAqNEEI1QGH4CKOZb4NwxArGPDlZXvQS8tyQk4hKbi19Nnicv/hcCIGeqXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AhrHvZF1; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8wnqIAHt4LTYia5FDSGtelTNEqpOKY6/u4Whh0j9ZeEJnydNgbb/N93OJkyXoPpTCww7BHP/40VmU6zuKpy96nBilJOuUNS2QohWSKcpRihtCmKAWE140v0TZLuORJdWiete63FrYART2iiABN3JRcOM9qKtHZvF4m87CchXYDHykJLnfuHiVCf2ET+pRIH5D936ctNXgyOWvTYhpFnEhRabjfXI+TxR3QITW1ayIhUWG4g4+BHq2hRZaZe6yNwTLdH82uOvAJng0GpH2ye1skBwogtkPR9MziZYHH1BrctZpf5fyDbhyvDo5IrreoiFJp6nBZ2U3KPJF+AUlMxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AK9j0Uhb4lqyPPTha0iiczA88pt9c98ZZLWYRvlmbI8=;
 b=WqEq6l+7hqe/GGte8umQnqaXV6Ezt4O7Ry7NzaEtcg0T6Ijv1dx+VUyklNPYxoo8qQOqHPJS58Xq8cpahAgvuHHxRPv+B75/pBbiHih3vPFN52xakLU+NNj7ELHVRSvl6xJpT1ggv9N5Osh+yKNv/eGUTZJ3zmReEiBBN19J16cb1nRweqU7WMxNSGmOFApur/s8beohpZIijaYzI0ABdN26t9bmCgglw42dKoBU+jg0tYW7rB6X+XGYnhOHncVb+d/fF9XXwCdl8OZNlfQflYyOd5w1/X0qJYLyb+xo6NPRrMh1vBp1JI3pAS5U2hCOwoAuaxrCVwKONi9NTDBUwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AK9j0Uhb4lqyPPTha0iiczA88pt9c98ZZLWYRvlmbI8=;
 b=AhrHvZF1V1aTzGqLQqiG3xZtrDuWMZzmBRfpTp4E+C1c/MBg0enzTe2a0XnSppBy0IcvXNUh6X6rNrf6HaMVADmmhgBsySWM1vHBKhYPe/LEedugXbl4j5Ad1C8EUXIO3uivmVxYYALzRzA6t7kwdmsknQ92HQSl4crJkvNwtng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8394.eurprd04.prod.outlook.com (2603:10a6:10:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 17:08:17 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::1d91:1c96:1413:3ab0]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::1d91:1c96:1413:3ab0%6]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 17:08:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 11 Apr 2024 13:07:46 -0400
Subject: [PATCH 2/4] ASoC: dt-bindings: fsl-esai: Add ref: dai-common.yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-esai_arm_dts_warning-v1-2-5e1a7c7be9b9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712855283; l=788;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NFjI6LIz6OYpL61fsJMKvKuixRn6jpdydO3y8TbiXHs=;
 b=MLGksDKlgrtZf1ndMk6QtfEM9IeLbrv1AvGcUeZowW0ZXW4ROVRltOSfb3jNfyGdZJZT0ZjU/
 EhBCIGyG35HCWb1xYjb5W2t0mVK0MvSAsYPmYUPjyOM+di4tQN0R6rG
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
X-MS-Office365-Filtering-Correlation-Id: 08e33140-5a58-4a68-3736-08dc5a49fb21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XshAFuGK830XB//KDmenv3QguYMAmezFrev8KaBPddZQhk17NMVllOSBQ19T7OCRNoyDef4Tkx3UjcnuwAUd4sYNRX7pRmS1tU+LWpNnS6o4SkVFvEimocAMAvAvloGkRvehQuL78WsNodKk3tHuvbzJdMbEaSzEbtD5e8tAAd60msH8G/d7DL4JgVdhYWKFxHB7oGzPskvuA/SbkWnqqsfTJk8v4zwUC8bnNu8ncxuZ2WhNkyrkIO20v2XN+N5hY6b39RJvSWbbom6ZtSmSsy6jFONz1NyR2sOIrjJd8EXbOSgIHOCEtnMdGBhK9AI+I1hZgathSo67i1j6FKRgqpV7o3LIvWY4ZQdXs8XYM0fgdKkizSE7k2Fa9W4CYTbZHEmyWid0VIT3Re9rE86mFktWXOD5MM/EShBFQPRakH29Qzgt0ZHANC/kvYNnx64Giv0lUz5aLEEopegfhpVLNZkzUqxeELWwFx3WtyDqJlTBwlfuGVob2ymtX0je9NKdNokDdkRKhwgrka18RxoxAZfAxHbhEiKTnE/OzpoXf6krMx0dE01e2ccUO/zFj7UaxKbBlBLx43VAUq8bKS5wBqYXX0W1nOcBZqgkVKZCA7Xz3K96JR9CuIPQoaXnoUQ+unnnHrSujxIim1opvvEhXlRV6mTYTpT52dWRi+8dmabonREsjlDoTK2V8d6gMTCu9RJSBB6NuYPeEL4IPnFPjeUZbwTtISDcnHt4upKs3ZY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmx1U21UUS9RQ0RPM3o1WXk0VGVOTjNXRzNKSmJrUWpNaHhMRko0QUhiQWdr?=
 =?utf-8?B?aFB0MkRiaWNOK09ZZm9kTGkrelpOTFpuZk9PL2xTRHVmWmFpS3JyZDVxMlF2?=
 =?utf-8?B?SnB6L29NeTRvK1Y2cUdYdWt4SEN4dnYrWW5tZTRLVEs4MEV1ZGgzVHZyTXJo?=
 =?utf-8?B?M1o4a3I4aDVDMlpHMkUzTURxRnhlNFZLaEJYMldxZzRRZ1B5blgrbzVFT0VI?=
 =?utf-8?B?SFBzMmExN0FsNjJuMHBzdFpsR1pia0RhS2lvWDBKeWtRYjdpbnVOOEV2bGk2?=
 =?utf-8?B?Ym4wWGpscVpDcXQ5YWtBQWRpYW84UC9QOEpGblJNSXczWU14ZURxY280V0xI?=
 =?utf-8?B?MVRkbmhCb1hXRGxzWmJhblNsb3p6cnNEQ21SWEVMbk4zeWM0M05jc1hpVHdJ?=
 =?utf-8?B?NHQvMzYzV2VkL2x5ZHNSZktreHJlRDc4c1VyRkJrRkt5SE1kVkl2Q0pUMnV0?=
 =?utf-8?B?bkgxbCtscnRhZDRrOWtpbC9jSFhkMmdLc0VKSW5Tc2NDUHpIbHpjazUyZ2Mz?=
 =?utf-8?B?VGkvRlpTMWcrN2dDWTJPd3YwY1ZiYk8xRXdKM2lKTFF2WWw5c2lRbUs3c0JZ?=
 =?utf-8?B?ZDExYzNjTUtVVWxGZVd0dXByRlo4MW9OYmh6dGZEVmFSY3BMTzN2Tm53aHBL?=
 =?utf-8?B?dEFSallvd0RmdFluekkvcnA4TDdBVitnaWhScnk4dnNxeEhZSGkxUnhieitu?=
 =?utf-8?B?aWNRQnF3UkMzTGVkWEFMVTRyVzdVKzB0Mm9oTERkMGM0a3hYNXp2MWFKNHhT?=
 =?utf-8?B?TG5EVVdZeVBzS0hVVkl1R0tqUktVb2dsVWQzc0l6TkxGNGtrUW1zemdJYWR1?=
 =?utf-8?B?QUc4ZHVmckRzWTVoN0s2aW8yM2JqQVRWcG10MGF5bjBDdlVrVGZsVGlsQTdK?=
 =?utf-8?B?RkZPM1I5by9nQ2ZJOUJ6cWtwa1ZobENTdGFoSGExZGd6eTlCeGc3bDd2bklE?=
 =?utf-8?B?MklZMEhMNXFacGl1ZHF5d25FS2ZZbXNzU0g3VVkzdmRFMGgraGZjTFdSNjdL?=
 =?utf-8?B?L0tYcDVEZDdseHNDb2dBOW9aVTZsQlJDUzJqbWIrNjJkRitPazFBRFZOa2tV?=
 =?utf-8?B?enhNM0FoVzhhbjFvYWgzOXNJcVBaUVltaUZVaENmcDJXSDNSUnd2YW02bGl6?=
 =?utf-8?B?RFhGS29VOFd3YTc4a0V0Q0MzZ2hxemUwUnFOWGhpbjZ4MFBmdXBMSFBBR0ZM?=
 =?utf-8?B?eWJDQ2hVWnlLbzNQem85U2NDWDZsR0dyS3JTZ2IxWnlzeEgxeGQ5UC9CcDdz?=
 =?utf-8?B?WkFnR3BPb2xUeEROMi9GdGhZaTBpYW9heFZnZXVqTHB6UDczdjgvVm83RmFl?=
 =?utf-8?B?Z2VZZzF3ekxvcmM5THFKam00UUEyZUJIQWRHVlpZajVCVEx2bTJrelhMOHkw?=
 =?utf-8?B?QTFrL0VYT2FnU1gxZTh1S0lCVWNMRVVJL2NYbzY0UW1idnRwYU1HakRKZE55?=
 =?utf-8?B?Yk0vWHZHakl6eFR0VE5zT09wSlBqVFE1ZWtZcTNGTFJuZVg5KzB4dmpRdm5Y?=
 =?utf-8?B?SmpQUHZrVXRnZC9aMjRVNTBveWIreDl3ekJmeXJSTTJpNTg0MjUwUmNGTTA5?=
 =?utf-8?B?TGt2ZmIzd0RJa1FhSWh6TUlxMUJham9uWGVDSXNlaGRVNm5jVzU2K2REQU8v?=
 =?utf-8?B?OE5HazU3c0dGallKWlVUVWkvUDFCV2lBa3B0T1NyMDdZZWpKTTUyUGlvdGFp?=
 =?utf-8?B?S2hzckRUR3RjRml4ZEo4Uyttc0ZiYWU0UCtwMW53ekhwRFVISlYwajlld1E5?=
 =?utf-8?B?djQzYXFpN1VKdmx6aExmMTN1ZWZlM2d1Y0t5c09oa2cyTHNGb0lYUnlSUGsr?=
 =?utf-8?B?c01zNlJVK09iVlIvLzdqQ0NENzNZOHJuamtrTmllSDhWSkZKU0JiaDd2cXR6?=
 =?utf-8?B?dmV1YUlNSi9WaThERkdZdVpjZ3BRdU1hU2xCeTUvNzdHOHVaR3NNMEVuWU9C?=
 =?utf-8?B?RGhFVUUzdGd5dXRUQUtJOTBialRMUjJYQStWZTZPRFpHQmpmL0p1YkdrTkxo?=
 =?utf-8?B?WGdrM3hGdHJsaG16eU1uOWorMHlWK3dWcTR0TDExb25kUURSWVYwbDFEUnBq?=
 =?utf-8?B?MTdSUm1JM0x2a3R5NnNPeW9kcE9sZFJCNGpDTmNQSk1aOTBHNVpxbDJWVWJR?=
 =?utf-8?Q?09Ww=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e33140-5a58-4a68-3736-08dc5a49fb21
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:08:17.4509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8iKM/3HtQiLKfJTbhG6yYGfrEAQAKGGM0Skstd/KCp/NiMGoICv7vA9eJ/6gC+0Jndux9e7xR3kobcPNzz63A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8394

Add ref: dai-common.yaml to fix below warning.
arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dtb: esai@2024000: Unevaluated properties are not allowed ('#sound-dai-cells' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,esai.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.yaml b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
index 66f20ecaa42b4..80bf4a9cb30c9 100644
--- a/Documentation/devicetree/bindings/sound/fsl,esai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
@@ -98,6 +98,9 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - $ref: dai-common.yaml#
+
 examples:
   - |
     esai@2024000 {

-- 
2.34.1


