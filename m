Return-Path: <linux-kernel+bounces-83998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2F086A132
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627B51F243D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E4B14EFCE;
	Tue, 27 Feb 2024 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GFU3u2fJ"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2859948CFC;
	Tue, 27 Feb 2024 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067283; cv=fail; b=a5uGX+g9/3Hme7HLWDtiC9A8gUoIQ3RmLdX8z7dWiQg+9QXz3AS0pMwYZ+/rVwjsUc5Co1b8L1PvJIkzcfe7Yuk3Lc6WF3wbvZksI/NrBgt1XvAdnuDAqwMlbFsJkp5m4foaTcSkxGedXuGMnX+YpFyRc57tUusJd3egNx/wHRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067283; c=relaxed/simple;
	bh=bTEL8cpYR0lINtMwm/0JO/ZlPNMQfhBbmqa+1uBAeJc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=UeA4fhf/5ynEs2wwCS1IjCqqxZ6+DXTp75c/NeG9otaBcDqh0M1/ZnGLdfWt90ZsbZjTi62izSHPl4p+6xixt6moZhHM9+POqc9jzqrehZCFTRaVuK4w6Kp8d5aWmcoKZ1gzGSq4u1Cv+0HfKQL1Fj2fFChD/mBj4eac4zAOoXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GFU3u2fJ; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjokheYCLdrtANTx7YJEIwE5RthF2eBX0qxXZVd59RBU/yR0f357+3lii4pF9OAR/gUqTsMWUIsuRf/xf2+43qSbNSRQlpDfYnZUWSKrF6BoNA/bD5N0nAC69B15f3tUP5abmtITkkbjPlJoDzJ6CrYwnjXdYFCtEI3z9837YAqZ6Rg2qfU+C3KFHcMbNiip/eVUMMsoUKnYy710dHmhPu5HMtB2PpVLxBX+ibGhfgcTHvBCP67qS59fiA4ZicYtFFj/cddkgHY7DoxERhfi8emfJdiTluLrhcaSYWf6vqfHg5QWb/48w3TX2XOZO7zkiLsomfksplja5h4ggLfxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=poAaR/WFJsnv6f1TO4H8wapR9IobjGw6T5L1MZZUN4s=;
 b=Feu2dDms9A+vUXyx4VSilTIEo+MR81CVHWgyx2s2BT/IQ/JQEvHB7+UIpjo72z68LYqwoAvaiN74lKlC2VLL8/9kD9NA9PxeHv2Ef1CeJlUZZx+XH5YelGSRfXkK0GjfDM1vgrzXHNRTy5C5ut2nR8sRDDZ4kYhfLKbl3+6yYff6qrKfTqO8CobqAJQAr92BttIIF4WM89a2ZWncawrE/qanUuPCyEa2X5Po6YJjgi2Nnozc18XBwRRwZ5Z9GSo4XFMbB24mzgTVGBqy82tvRplgkGG7WJ0QDT34At6NzJ028JgSArNcqc5f7y+elvc6YZ9P7aeYT5g2IFXcVxyLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poAaR/WFJsnv6f1TO4H8wapR9IobjGw6T5L1MZZUN4s=;
 b=GFU3u2fJAX68E8OUzv98x1kc0zi1dqOGAW2I9egKhfSFELd5Jj+RHCcGv0wsYXx7epPMxW1MMa5HCX49L7yrDZ/RJutT1VfpHczH7IndwGUNch9REW+xKePIPdQx9E7hjbR23G/WT4/gCceJSvhZ/aq+uGVLouzT6VLgFspgwTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8229.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Tue, 27 Feb
 2024 20:54:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 20:54:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/4] arm64: dts: imx8qxp add asrc and sai
Date: Tue, 27 Feb 2024 15:54:08 -0500
Message-Id: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPBL3mUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIxMDIyNz3cTiouR4i8KKAl0j08REM3MLYwsTgzQloPqCotS0zAqwWdGxtbU
 AaKAUXVsAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709067274; l=912;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bTEL8cpYR0lINtMwm/0JO/ZlPNMQfhBbmqa+1uBAeJc=;
 b=v90f3wIyCD4rwr/FcwUlNsFwssAwss+d0i/28b//bDsd7f9TyWFDIhYMTJQuFPFga2D+onlUf
 zc+sa7PcLBgB8YF6QOQ9WqFO6mO/S3oIiKhZnuXbZa5nIXiIATVyQOz
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6e2409-4a4c-4382-01fd-08dc37d64f91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ee7KEXkXnG2S3/Su/HmSH9LJIyL+M0F2OlynAarflSX0sdacgnPpSC+hXZIvr/3crFTUbtGM9OqWNq/rcKdKpq4SNl3tTCe4ojZiDV/vc39F4by40Tzy8Ngnj4y4SI1lQvW26YA1uD9DNYbY8AUpJ3OO0fEhMqqn7+wXB7DsoGm9crMqZg+48fmRoKYyYKxBL3dELfRHXEyzyur3r2xzW2CLD7zt/NcIHaiMLet8zcZWUNH5pZMxyiOKo7sQVaU5UgdR3keK38KFzoB3dPQ9bJDWqb2gcs44YbwAKaOiqFIVrahlBB/cuHbbyu1+owS1x8mvaWbjJIWCh0oy7NNzPapBI/FBa7AKByrVAfR0bzWwcvsQLq2r0MWqrsU3ks0CD0sq6EqAmDcqkiNzkb9w2vFgiVOcOO/vvSVmGJbkrq9emL3uTGFu8ni+ARDix+B0wur9xFrPiouQapPlsF9p7zr4erMhbcFsiR4JW3nKVCK2msbAGZtuB2NYDlAyaS+wjlYDtdTdJQ+QCZW8CUHr545udyfecImnLH8akB2T8dlSz3Qb4aZG7cCVK1vI8/8+ZwwMVcmTIYwgoYzDv+M1kw7neZivQhREPe6D9YmG5T1TwimdHkZwOrNyLpN31rQ6mY6ZsdsbG1/F1bBJehAieS5z8q7elRjl3ZFZFPR0K2xjOFdENKwsgG3LFafWJsMuVVqmJG2kHe/8nXSoRMqaqZntJ6ctejtbksbwi2Gx9YM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjkzQW5UVEg1aWNtZ2pkdkdTZjNlaVNYbGpScnJCMEhiOGlQUHA0TnRmaXll?=
 =?utf-8?B?OE5PNHk3R3RIK01VZkxpOVhKMnFNaXhYckVSdk0vaGhNY1RQRnJ3ZEVrRDBO?=
 =?utf-8?B?anBxRG82TzJQMkg2bit2S3pWY2ZaOFNObWczbnhabW12T1ZtRkFNSlNxY3V2?=
 =?utf-8?B?R3dtd1ZrdTM0VWdwVmNNd25NbjZabk94cDJJUUdEdWJzaUhSZDY2YUFEMThj?=
 =?utf-8?B?Zy9oM3Njdmd2TnlqZTFXTnhQRnpOY1dwR2pEWHVHZjA2Q0xlS2FIa0REdnBq?=
 =?utf-8?B?T01CRkZHWTlYMWZISmhkN2lIUklMS29TTnZHL2xtU1JQak9waG41RFFYSzZJ?=
 =?utf-8?B?Q1RFbHZSQW8yN3JhUUpua1RXRkVMNFNUVUc0Q1RGYWdKTEFmV25LNURWeCtE?=
 =?utf-8?B?WlQzZ09IQzR3V0tEaFltV1IvS3JNdUpqT2MrMUpYTC9hWjN3Q3JhdklZL0Jz?=
 =?utf-8?B?Ry9JeWpQUVIwQitKMFYrMTBEMGtRMDNWb1o3ckNqSlpzOEZEdWhocFdCZnIv?=
 =?utf-8?B?MWphSyt1dkZMeW0rTno4ZnBTV3dMbERhcm5kd0ZCTkNZVkUzTVpXTlZ5V0F3?=
 =?utf-8?B?dXM1SUNkb0RxOHN1MDB5QzJrb2pOOGdjUzdQd3RHeUQ3UWlmcmNOUzJUZkJ0?=
 =?utf-8?B?N2hsQUthNVdYWSs0MUhQZzNhSWZZZ0JoQXREdi9rZE1VUGlWSm9HeGR1ZGRh?=
 =?utf-8?B?cGR3UThiekFzbFo0T2YyODhWclovZmlQM1poRGNlUGRYUGx6SzV4SlBDVnFP?=
 =?utf-8?B?V09MU0taUU9HNFVqeXBDaysyZi8vUmh2OTRHZitBNWRZZmlhL3VialFhOVho?=
 =?utf-8?B?dnlPMlFRalpSemdORTFYcmlUZDA1ZTdRZ2FPbS9MTSs0TFM4Nlp1Vlg5b1hl?=
 =?utf-8?B?ZHZSZ2hwUnBTank3WkQrUzFCekJaallMbjVteVVvdE5PeGN0ZEFkSXI4TjFw?=
 =?utf-8?B?NmxGSHJzcG9LRUhXanBnbnNaeVVNVjd2eGprMkR6K0c2VDV6ZUREcHpGbk8w?=
 =?utf-8?B?VlNjeVh2N01wcEJiYjNNTjBGaE40NnZVQXlBM05aSytpK05JTkNmWW50U011?=
 =?utf-8?B?YmlpUE5FcjBaajk3a3VRbFQzZlFzVUJ4bnVHRDd6Ry96V1FSMEs5bHl4VkxH?=
 =?utf-8?B?TVlHQzBmS2oxVW9ONVlpbFlrM3ptRHlEYmxXM1dGL0VmSWo1c2ltNi9Xc3RD?=
 =?utf-8?B?ZytTaFNoci9UYzIybWJFM1hTZ3pJYm9Na3BZVkhnRGRBOXRqaUNmeURNd2R0?=
 =?utf-8?B?dTFTS3NZUlFKVlkvMFBUQUowVTRmYWc5MERzdmZtSUZyOEhaZmcxaDgyQzFp?=
 =?utf-8?B?TExzeGw5UlVlUUJEdURiZDQ3cWxRTlZCWXM3TkZoN0pUeHY4dTJnemtpTkJx?=
 =?utf-8?B?QkFvb2plMXo1a3U0TjBPUTR1YzFaUUpzZlVUL1BoV0k0RVdSdW1McnorblJO?=
 =?utf-8?B?RU4zRTQrcExPRFZjOFdDM01WVEtWMXhBL2x2UjNHY0QzMFNDQVZXVHZXZG41?=
 =?utf-8?B?bTk3ZUJlNExnMHpjLytMb0dvTHRNalN0bGU2d0VBZkxGcEM2ZllHOHA3WnVo?=
 =?utf-8?B?Y0dIT3YxWUhsNnlGcDUwS25xdVlzTnJzTVBsaWsySTdGdXpMNEZYamU4SFpw?=
 =?utf-8?B?d1pPUmJKYWtGMnVhVis3QlFla2h3cGVzR2FCVnp4ZDMvM2wyK0ZLTXY1cWMx?=
 =?utf-8?B?TUpzTW5kMlYwWE1kZ2ppVTdjQUFLdlRka1JhQ0pSZ3JiUGNhV1Bha1VuaitD?=
 =?utf-8?B?dGk4RUhCQWNnNGhZeDBXRDAxSS9xMEdTREQwUTVNMDJ3S3VPQVNYMEVXMUV1?=
 =?utf-8?B?RU9sbVZTZm1OU1c0aWVQTWNhSmEyVWhGM3g5Z3ZISGU1ODBlT2dkNVpTSHFJ?=
 =?utf-8?B?ODNiV0I0ZnhTV2c1SEx3enNOM1hhRU93a2Y0M0dDWmpsMmtpNkR2YXUzVGFV?=
 =?utf-8?B?TzMxcG0xN1Vud0g3ZmF3RjFXelNFQjNhampJTk8zUHM3ZlBIazlEMm1Kb2FL?=
 =?utf-8?B?K0lzZVhjS1dESy9aTyt3ZnpqNDVsRm44OGVrVW1lcjFFSFl3ZE1rSjlYbjNM?=
 =?utf-8?B?Mno3Z1BRUjdncFpBblRrT2ZhM0cwbG00cWtXaHNiSmJueVgxSzZLdm9SeUlv?=
 =?utf-8?Q?8sLo0YybAfTRRp4OtpsGeHP6Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6e2409-4a4c-4382-01fd-08dc37d64f91
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 20:54:37.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BJ1+5r8xImstSjmcFLwNvfulJARoo0jL1RvxElxptreJOfPp6qyghBWppU8vmZNZYqGmw6oYgodZIqg/MaFBvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8229

Update binding doc to avoid warning.
Change from v1 to v2
- Fixed dts DTB_CHECK warning

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (4):
      ASoC: dt-bindings: fsl,imx-asrc/spdif: Add power-domains requirement
      ASoC: dt-bindings: fsl,imx-asrc: update max interrupt numbers
      ASoC: dt-bindings: fsl-sai: allow only one dma-names
      arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif[0,1] and sai[4,5]

 .../devicetree/bindings/sound/fsl,imx-asrc.yaml    |   3 +
 .../devicetree/bindings/sound/fsl,sai.yaml         |  12 +-
 .../devicetree/bindings/sound/fsl,spdif.yaml       |  22 +-
 arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   | 304 +++++++++++++++++++++
 4 files changed, 336 insertions(+), 5 deletions(-)
---
base-commit: ca301cf599a4eeafed8e3dd87bf8d2fe810e075e
change-id: 20240227-asrc_8qxp-25aa6783840f

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>


