Return-Path: <linux-kernel+bounces-147059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC288A6EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FC8284490
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C22130AE5;
	Tue, 16 Apr 2024 14:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bci4iP3o"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2085.outbound.protection.outlook.com [40.107.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588712F5BC;
	Tue, 16 Apr 2024 14:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278909; cv=fail; b=pCchlIBiCVmbmFXcR1/2mf0dYexl522Pw4lluYXi/RiK8VM5zSaB9ivs6090BAyRQ09DZKZQNB9W1XQhctYAeXTendRlq5XvWjZgfae7kEUsCBe4L8relafrdiL/uBKI7lvOlybDggzSaKmDLhx8oL3L7p5so+XdsbOggXnZzqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278909; c=relaxed/simple;
	bh=+7x8UA1qicj1CEibmw0tci4A9SpbwtehWsDk7FhER1M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RrHJbahV8/sV0XyktuVCSYGNCurfg0it0+FslJEfY1plChW08WrHD3Dey7sI/IEJD5lM5jf03Yn92NVxMELNyVrxHhVf1nMpoe7b4j/1vYBFerYncT7+H1n2JPKdU4355MZb+dH3YIp4VGarXro4Sm293fAZ73JbfYGZu7P5rhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bci4iP3o; arc=fail smtp.client-ip=40.107.8.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCo4R+3Y/qhqoP4Yq78XiyaNULkY+Ks66Y5bfpOAdCHSZgZuEcNpd/KT6kvHDX3n7NkAo8ACaPTtFClt2vFVdnjY6MuswEJDcRHVDtrDRJakTXZGWbaUtCgPvfMLouq+Ss7hUtGUwK/IzYDgnvfPJA0hAJrRk8n80SkxdZX61gYlPXxiGUtbE9g8DupsHdUi5bxb1VeT36dNkAAifbjQTjueuCbw688mV+0oXJFNuV+haU1Sqc08MtqIqmZm0klyVpKoaT55w8FXw0O4x3HODc4cL46/AjRmTFRq0EA+WLt/JnOW66iSmVG5BPyuXgUchyRx+6rnZt1QglTqZA3MWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4lRmriNWt2qlHzppt54iSflgdzmywesvvme0cB9zyA=;
 b=EVW7sMHA++eZIiCHqtHhM9KvXR/N1f17mYPb1yLoar3udq4U3Q7mu1PBgX8UtQmG06MfVcM9dNgf4AMImFmaBA5rKXwU+Oe2W3hwPOpEf6pAFvEZzyRiMHbs8CCX11Qag3UmfdXegDVZ7qTVqbvd7YFMuA9z+WryVTKgazXx5PsAM2h90EEq3OyLuVAND04Mfjte+MsLNjvCcHf/503Fr+uiElzqv8Hztop8jrrVOnC9MG55d3JLbMxf706l2jAEX0yvp/9R65y+sLjO1rJbSY/jZ4F6c0jqm45AWQM9FW4or4GISW2QEd8MZ47dC9j31TOcA2nH3fVVzGX/73VnSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4lRmriNWt2qlHzppt54iSflgdzmywesvvme0cB9zyA=;
 b=bci4iP3ocT8aK+pTA8DAHHONGiX2K2u4J3nrWKvYEc5FrLFY/e4Pdf0o/d6XN3WRRYvJogpz7jbqWZLQ/GLacCiKmimKzrF0Kpk/oYTDvSc7R3tleZEvirRW6J+VwbsI7g+I+1vEjjZrqgpFnliGD9lorBDBrbY8Cz+erR2Z47A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:48:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:48:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 16 Apr 2024 10:47:47 -0400
Subject: [PATCH v2 1/4] ASoC: dt-bindings: fsl-esai: Remove 'fsl,*' from
 required list
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-esai_arm_dts_warning-v2-1-879e59c0c3b8@nxp.com>
References: <20240416-esai_arm_dts_warning-v2-0-879e59c0c3b8@nxp.com>
In-Reply-To: <20240416-esai_arm_dts_warning-v2-0-879e59c0c3b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713278896; l=1295;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+7x8UA1qicj1CEibmw0tci4A9SpbwtehWsDk7FhER1M=;
 b=sc77Y1RNl2gn1Hop9bR/fyckM4PtAFOuYQ/ynAaZXdkOxpCE2GuAd8rStjurQvunJwmja5eNo
 DCdto4RrLAvBwImq91zt3D+viMPaLLksqG8McCA2wk73oG62ITFSp4Y
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0020.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 55230170-17fb-4eea-5e39-08dc5e244433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V2gkTWHH9CddqoN0zw9adFUnM6BO9lspYeFABroDHFvIdPY1cBtpc9J/ZRbIfAngr4EQsadEUbZ4b/K71a2C3j0D+VjH0XEt6puj3S1OobNqI2KH+Z2dwep+pgjY5/TPpybXQgL2n9hVGtr1PZ2JFas716/QaZC/xVC/SMsm1TALPK9xYpou7+E5+/qLnUIN1O+h6mzaW71nfMf0ytJooBu8e40Qps0irzuViGKE/6z9pSj6jyr6zr3MYbt0t1mPenpOboHPM8PLp98e9jcTmJZMpNw6jdJfUtA9jCx2Tdwxxkajf7YrR6gswx3uq28cnRB6acDTBlO6XpdNO0E7o/2e938PifsqJCuVq4pBOYgjYNIg954Cm97G6qVH30J1Sq+QzW5TwJkneu8iy9xoA+0uEXD69PbkQ4osEfFVUXAZ/RX4O76fW+DZzCcGJk3fAVbqaolS69hHUW41s9vHljXSAH1SvjCAcThc02SMu25T5h7gpH1212p5bPYwweFm2pCKNil0FCTIbVItKC7RflrocPn5fxLxAcmM+XleJeFyL986x+vUxB6Pm1u2bnDf7w9SorPlV2UjHLauF2gZS6EJqcXMuDwjKbyg/Udu4Btvvp8Mx5WNE1nt1PyieHI66WkwVI8H7S2JSz1DhylqUoLDkoxQ+NwEbCsDVaYv+YudkHPP0tM6vh69hTZp0QB7I3UjBwvg8VyKakR+xNHmnNZMOAhx4/0rsZiviwK8nqY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(376005)(7416005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0NuR0ZjUEU0L2RhMUNtMlRXdTZqejQ1TG0rVWlXU0RmRTJQZDVHc3ZvaE95?=
 =?utf-8?B?VHR4L29tNS9UU1Z1TWtnYy9QdDd5WUx3SXZ2S3lhYTBTakFYdHJ5N2hOeEVG?=
 =?utf-8?B?enBaN3MxN2UwT1V6NmlzaG1jajRCNlZWNlFKMU5xMW5xb3hzaHBOSUVTeGZ2?=
 =?utf-8?B?K0dkMzV2cUpGS3U3anI4TitRSzVmOGZQVUc1OGdMVm9DbnNPSnUwZEw0akJv?=
 =?utf-8?B?dGVOTUJPbHlmd3VFUnhxTXJRQlNCbC92SkhHOTZxV1I5MVZlZXo2QUZudnlW?=
 =?utf-8?B?K1FIajlQNkQxT0sra1oycGw1Qm1tbFRKdE1LaElxbWNRY3M5TDkwalNZRGkx?=
 =?utf-8?B?K3hpODJOOEFSTEVOTHlsOG1jdDc4ZGNaOUxxYWN3YkFTQ1ZKOXcxNzdWMVJQ?=
 =?utf-8?B?aVNvRE1NcVo3V1pJZGQ5WFRPbWZET3RPakI5N1RHOUJlRE40aWh4dE5oZVhr?=
 =?utf-8?B?VHVuZVRjY0JXeFdXSkxVWmt0MngxcUNWVHVITkVadzBFK1FiMnZFTHVhRkpj?=
 =?utf-8?B?UkRIZGdrRlFMaS9xRVIrb2N1ekdJYlN5UWJqRGZacDJ4WnNOV28rL3FLSUZq?=
 =?utf-8?B?TS9MSWQ1NGpkSktUbVpvamdJbDVUYjdzZ3ZKNENlclc3ekJLcjgwMThwalk3?=
 =?utf-8?B?SWJ5aEZaMUxCNm5xTmFVcHR3aFpycXU2L2IxTDVNa2ZnbmdGRHlKKzdNemMv?=
 =?utf-8?B?ZW5tS1VjUTA0Qy9vcnlCYzY0YmNVLzdRU3ptTVlMV0YyV2hTYkFtNm5SRjM5?=
 =?utf-8?B?bHpQa2dmSTVxRjg1enluNVJ2am85UitUc3BZcHQrZTVqWkpZbThHL29wNkxk?=
 =?utf-8?B?MVNkVW0vS1dyeGZ0NWFXQzNWMmNsaTlyL1A4YlBBRnVpRXp2QVFpZHJVTHNS?=
 =?utf-8?B?Y002SUQxWGxNVG5CRXhuVDF0R2V4Z1NHZE85ZkdHbDljWkZvNDVJMDJlNjAr?=
 =?utf-8?B?ckRjZW1PUjJ3ZjN1b2FBd1lSc3gvTXo1dnh0cE5xU0l2ZVp3YTY2T2xJY3Vh?=
 =?utf-8?B?dTRuT1o1Z0tzMlV2aEJRc0Z1WDVHWGpPVGgxOXJqUXZ0L0xtSmxCc1JtcjZC?=
 =?utf-8?B?YlVPdnk0ejZzWlpuZUZ0ZWtac1NvT2w1MDVrbW9uTnZHb1A3MU10bXNNZjdJ?=
 =?utf-8?B?M00xVHFQaWFKeDd2aWtUYUVZNnl6aHpkb0RVQXR1cDd5aDgwT2xiMGJjMkZn?=
 =?utf-8?B?Q0RqZHIrWkoySHFHdFErcFhvNGtZaEdTaDRkYWIwY2Z0SUFiOW1GYnpORmNO?=
 =?utf-8?B?VG9RZFdWZUdER08xTmF4a1MyRThnUnpEaXQyQkdwZ0xzY0xnU3pJKzNWQ0Nt?=
 =?utf-8?B?Y29BOXltVDNHNlFPeDJpeHNzTFVxQzNxK3ViKzdEMHpab0h6dHl5VlRFbVdG?=
 =?utf-8?B?RTJyRVo0WXZoZ3c5bHdsQ2ppM01BTUdTVCtiQ1Q3T0FVQjkzNllNZ2ZGeXJZ?=
 =?utf-8?B?UEVJNUJsQlc0dlhUbkdwSDdTU3E0dWw4SU9halM1VjRZSUNTYVM5dkV4akdk?=
 =?utf-8?B?eFFmaTl4WFdVTXRvQ1JCbE9XRitsWEt4Q25ORE5Xdi9oZVErOUd4bEdic2pl?=
 =?utf-8?B?b0xrNkxjZm9sU3lKMCs5UVVFMnY0YTFQUmlyc3UrRjlYVFY2RmhYc2YraWhw?=
 =?utf-8?B?MFlLZCsxSENqMTlrcEdHcmpEaGpuSGFkTDRMNzBWM0VFSW5hbm9PVjVjdnJR?=
 =?utf-8?B?VFE1VzN1SkV4NlJmaHRzaVdzT1JKcjViR25sbllqVHNCWE5KMndUN3VXQXBi?=
 =?utf-8?B?ZUJqSDM0cjd4M25kNzg3SWNDa1lmOUJYNjlMSjBjVElpcWlMN0FmWmNZMFR2?=
 =?utf-8?B?dlRtSk5ZVFlQNzBKSXpsUTdDZXFsdG9PS3pVcmNtaERQam50SHdQQ1M2bk9B?=
 =?utf-8?B?aFFMRldnM2NmM3hKOFhRamtFTGhpRWNwQThMeURCdE1kUURUVzhYT0J5Uk9a?=
 =?utf-8?B?Y0VGaEdORzZUYy9TN1hRNnM0dmdZbVBETEg4b05TRzloeXZXK3VRSDBXaU1N?=
 =?utf-8?B?ZVVrWW1QM0kvb2tGTzlQWVFjQ0dHZXpYVUI5cDgwdG8zN0l2anBPbTRvK211?=
 =?utf-8?B?NlNlejNyK3BpQWtxZEdqRWd3KzBFZ3Zqc3EwRnQ3Y1hyS3lQMGplSVNKMytK?=
 =?utf-8?Q?PRQDk3Pu5xIq9SZONiOQ11q7P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55230170-17fb-4eea-5e39-08dc5e244433
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 14:48:23.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p1UTlGU+xdDrB7a/VmmZD0Nx/e+2z7KQnCSe+gqAOA648zHRhyrxfPx2E4tdxMPmSPQVYeXWZzBON3PjScnlzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636

fsl,fifo-depth have default value 64 in driver(sound/soc/fsl/fsl_esai.c).

fsl,esai-synchronous is flag(bool) type. It doesn't make sense to put flag
type into 'required'.

Fix warning:

arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dtb: esai@2024000: 'fsl,fifo-depth' is a required property
arch/arm/boot/dts/nxp/imx/imx6q-sabreauto.dtb: esai@2024000: 'fsl,esai-synchronous' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,esai.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.yaml b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
index f167f1634d7e3..2a64e682b5178 100644
--- a/Documentation/devicetree/bindings/sound/fsl,esai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.yaml
@@ -67,6 +67,7 @@ properties:
 
   fsl,fifo-depth:
     $ref: /schemas/types.yaml#/definitions/uint32
+    default: 64
     description:
       The number of elements in the transmit and receive
       FIFOs. This number is the maximum allowed value for
@@ -95,8 +96,6 @@ required:
   - clock-names
   - dmas
   - dma-names
-  - fsl,fifo-depth
-  - fsl,esai-synchronous
 
 unevaluatedProperties: false
 

-- 
2.34.1


