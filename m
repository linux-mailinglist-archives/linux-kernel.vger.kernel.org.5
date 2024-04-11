Return-Path: <linux-kernel+bounces-141379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FBC8A1D76
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB27284443
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B781DFF99;
	Thu, 11 Apr 2024 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HKHHzb4C"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3B1DFF83;
	Thu, 11 Apr 2024 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855305; cv=fail; b=FCr5VG4KuMBQIs7C542b9lEN+rQfmWsm6ftRUOp65v9DXy22IqY/3KLUAnNKGUDndPAG0tCf5wcXAlahXpepVUttkKkdQdwWd8A/eSGk75YUD+92hO4amS1YDjfHQyoDtANQtj9bedtWhVOncYTTWD2Y3a9NzpURsVmYX1tDhFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855305; c=relaxed/simple;
	bh=txdhzgMKWLH7PYSSomyJMeLCWFmQ6y4g6vZqE/QMPWk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KBLHFE+woE7j3i6q4Q/IoihDzGSpdwrPK3NW/NGzO15A6h1yFP/pJERasq8EHkp+77fThJL3SEKwdhVkfDdPwY9IRkpOmnn5Po0BrOENa4MgE/sJGX9fjmD56AhJDu9h1PvdfLvdoTFglniL7eK8++Jh70+1qgEzMbeYJH4kx1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HKHHzb4C; arc=fail smtp.client-ip=40.107.22.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2cW2Lv+ScrgBojjr65wb4n3aDzLYLL9/zwFa6L687dKfWzUf04BJjfQjObb/28mdIDgYvJ8GodRgdVaFcGoW7uDz4OqJLENbg2v5r4ApvGoU2Q1q30JDnYUY61X/BCYcsCd1oBMwZW2DjWMosVG0zKzfWqQKOwusbWw1uObzC6LvjPPaC1r5dEp68p7LtCazQJIB/Oz8+NQyymXeHXGWE468l7abaenK3QCHXAX3vY2mPyKwZwzrq2T9/7W0K4zV22T6sNGXQbNYEzdEODDkTLLf2rgVev/BMYXf8iFa4+TgRLBiBBp8nILY3QXGGpYjP8xYO16rRrsdPayMPf5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj1U8idgGR3bJW7ZJ95N30hrkskmoj3SAMurbtwn7GI=;
 b=FNlPfGImKTKxsWpQbXNbzAzv+ZkzrwweeOqhSRvqNDm0ywVm0/pjUycwZG68FNWbCJv9q2hbJWtXwPATeQ2VE2M0japLvCaCB3dpu+HBX5vrK/GeEFU7t31jYdJL6mr2GxeCqeiU+WLnGNDjmsfJFfxx/hoHPTndCOQsNA+0dAS6YKcsD4Nx5XB7csjGbqqt/uT8UUoleyQlvZRIPr5Y6RInmfo8z3hSUiUSuhxMC0JbrvJ38HTi10Xm70ISZS8N2QmJXwcJFITgZR0fBoCQYCneuoabwBJwMu1wlIcFzQGiwrg46ZAAnica812CF7ujYUs/3LoeS+HKREX86ErQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj1U8idgGR3bJW7ZJ95N30hrkskmoj3SAMurbtwn7GI=;
 b=HKHHzb4CQLzG/JKJv5/rtFFYbQTPkitY2BQZrxZzXIvxyhSSuunNZsfnKxeZ64HJezV1aj0Asix+rddiXjWdfkUG10mkjGxx47emxuz4AOxa6Eb14Ic9C8+zWSHKenk19d4tiiqBpEFJCcNtkXazZgNZrPqsTtvgtcwNpfOuETs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8394.eurprd04.prod.outlook.com (2603:10a6:10:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 17:08:21 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::1d91:1c96:1413:3ab0]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::1d91:1c96:1413:3ab0%6]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 17:08:21 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 11 Apr 2024 13:07:47 -0400
Subject: [PATCH 3/4] arm: dts: nxp: imx6sx: fix esai related warning when
 do dtb_check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-esai_arm_dts_warning-v1-3-5e1a7c7be9b9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712855283; l=2489;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=txdhzgMKWLH7PYSSomyJMeLCWFmQ6y4g6vZqE/QMPWk=;
 b=QFb5SLBt2mOpWVSquJfbw7p36uXMCekdVLAcAyWp8vvzCLDlpNah0kwM1KNBakNrInLU1satX
 CB42MTvDVxPCx52+3COvG3hjHgPJCVZWvWOYSSur101EuNm0Q+oY34g
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
X-MS-Office365-Filtering-Correlation-Id: 1712adc2-13f0-4f1e-4a75-08dc5a49fda6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XbfK6cT1rTjNIUNVjQTnjBgRt8CP3cTqDmV//GAHAHlMDILoYvoyKebxr1qC7+OS53xC5sofA8/r3LqQk/sL8D8nElhEIbHxwDNiV2IZDK/vVilDjETHkjnbrOmy5SY9RZJaDbQyPZBij7gYPa9N7wbNRVaMH/+FWnlfwQpUCeDnTNCxqjPGp0zRlQMyzoFW194fpT3MJZWWrsXW5gt29gTXSWI00NWqbMtle9eH4YmydF0KX57njJQza++vCyeZ9+ymCDIhY5M0kPv3/ayyys3nUUwbnT7CO0pRsgGAkuE7XMV3Kl3doNvUcZ1uir/a28EQTrKjMRmRIGnpTOGZgnME4v+jiNZ0yHNRQGrX+arGpCUrMVFFHMHZX95AqiJdYIFvaPne0oW/wOQy8q7kMcf4g15e2P+w1ax65hFST/PZipkEO7waQ7DQTJPMm6iwbdtM86wGJxFur/FeG4GjY4Vuqjz8TMT5zIu/MPfTwjyvqXUMmVPL32LZjn/v38AFB86irnrfAZO1CSp27KeEF5EiSNKZInQ2qwVvySGeZH7/aEE99uzLUutRETUa3NC0zSXYVhu/jkU55zMeLMjQ7mYGsoHB+eFjZak/JqJHOOP+5BN9h6ZP9kmMMkwc9pzVk7uy05eGfavHrCTaOxCZIXBTuhowhhXoGOjS/hTkgdfbKQoBk0gdwNUPEqmNHLGM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDU5cFEyK2RXcnNMTi9qYnc1U3dRUXd4bzUySTJNYlJSQUpWeVI2MG0yUXZq?=
 =?utf-8?B?VHV1YmtJSWtJWHVvMk9Lbkp3VFNXYkh5TDl1MVBNaGZRTFpLaXpKMGhFa3Qw?=
 =?utf-8?B?ZW9ybzdNQ3NYNDlPVEhSZWtERzQvSHg3bnVQUUUxNXFZTitkaUNSU3ZPV2Fw?=
 =?utf-8?B?MU1RT0dEcGNmREIvWVhCTHE5emhOS2UyUDNjZTBibk1jTXBjNUFBR0pUVERT?=
 =?utf-8?B?ejhVZW4zOFNkVGlHcGdJWEFEN0FUc1BEMW1zWWhFUktJUElVNDRCalNISkxv?=
 =?utf-8?B?dnZ3YjlReTlRTURLWmFlRGVIS01iZWhma1ZCVmhQYmNpaVEyaWZCSldyK00r?=
 =?utf-8?B?Z2xBU0o4WkNLdkd1MUtDWVpyeFJyZm52UHl3S1ZLS3cyMGlYTEpNK056RXhS?=
 =?utf-8?B?VnZDRllLMzM2NzZoejE1ODRoV0ozRlQ1bjlKcHRibDd3THBIWFR5eVNOUk9m?=
 =?utf-8?B?TWEzNHpLN3hDc0tHN2NYQ1czQTlqcGlIRkg3RmNWUXEyS1I3NXpGLzJjMXdG?=
 =?utf-8?B?SWZMenR5c05VWS9WcWVIdSs1VFNHdDR5T0pISzRkV2V0OTB0aVdZaTRhSEpo?=
 =?utf-8?B?UXZjYUxRa0JSNmN2SkdOTWYvWDZnWkRUTlQ2cnNqWXJzS05iWGN6a2JIQ1Rw?=
 =?utf-8?B?ZHNBN2xtMEZhelY4YmJ4cmMxRVhmMkZQbjE3bG1DUlkwTUlOV29xd1g5Nmpv?=
 =?utf-8?B?QlFBdmdiV0JFV3pWMTRlQ3lmM2I5U1ZqTjhIdFQyME41QVZYMzJRNmFPbXdI?=
 =?utf-8?B?Mm5KRmNHdVNhTWk0Uk9Bayt3aUtYdmlVYlRycU0xeGs2TGdZM01VV0piRlh6?=
 =?utf-8?B?VlBzQVduVnM0c01GMlk2dmxncm52Q1lvQkFGUUhaWmIxcDhGb0dsUFpicDJy?=
 =?utf-8?B?SGEveVlDRHZ4N0R6bHRKOXg1VWc0OFl3QUZFM0s5MVhUVVBlUFA4QWR0VGYx?=
 =?utf-8?B?WUV2bWQwNWpCcnJMc2tsamZCYWhOUU9ZYjliV3dpNXY5ZjEwQUt0b3NEZ1FK?=
 =?utf-8?B?TFQ1ZUp6a3RIb1I3NEtENXFaM2pFSFFwQjFhS1kyaTVHdmFPQXdIbzZoVzlL?=
 =?utf-8?B?K1NCU09DN29uQzVrU0NKMk9JeEZ3RGxFRXJlSUcwdHZEc3FBbENlemtwc1VL?=
 =?utf-8?B?SmJMUDQ5Vkk4ak9jNDdTU3Z5bm5DSTdEODcwZjMwQ040OEpNbkI1YmZubHlr?=
 =?utf-8?B?Y1gwc2NwV2U5RWpqZWJOTFpkbXNIYm1FU0FxcWFWMXZnTDJZSDUxdG1JZFRz?=
 =?utf-8?B?aGJwZVFYbTB6K2FmZXN3ZU1oNFR1S1pFc0l6bFVTa3EwZXRWdGdFSEpjdDlG?=
 =?utf-8?B?SndCdFlPN2dxWDNxOEJWNjU4cVZzOU9BUlJqZEp3QWdKa0J4YzBsY29RM2s2?=
 =?utf-8?B?WVdLcDJhMWNrYmthNmswWWpualdwOEVJTTdZMjIwV1ZrbjUxMVhQc05OeWh6?=
 =?utf-8?B?d2pTZEFrNHBDUnlNOWdMeEpEbDdLbUYvT1J6R0tmdytBWDV2bUxiSXVqZWht?=
 =?utf-8?B?N05mZ1pGeUlHanNtdnFXZjZMbGZlWEVNZUpYT1VGR1VwNjNNMEdTUnVkWFg5?=
 =?utf-8?B?bnFIRlpXTmhOanZMZG1URXpvQmpwWCtjOU9lRVJLMlA5TVJ0aGhNQjEvV1Ew?=
 =?utf-8?B?UWVqQnNMbHFzdXJMWnlHS1RraWVkVCtDaDgrS3NBajZvMk50cHZjZ1l0SXlt?=
 =?utf-8?B?NWxzdUhqZ0ViWjZZZi9URUd4ZDl6NGEraC9Qb0wvTHRIeEIwS05JRHpXYWk0?=
 =?utf-8?B?WldoRTBwUmVNSjZaRHFGUlUrZkxzZmQyNVpSeHhPRVg3NXNBNlpmeVoyd1lm?=
 =?utf-8?B?QytJM25kdWE4V1cyZVhJUlNpbG1lUGgvMUZicjgybkdBRlZWZzdjWnE3dzNy?=
 =?utf-8?B?MUU2TXliTC92QjlMK3JrUnR6YWRGdHYxNGRzRmZhc1lTdnhjeitUYWNGdjlj?=
 =?utf-8?B?SUcyelliUFNzdHBxK01teG1mSXpmK1B6b3MvN1pUdlJIU2t5Tyt4QXRwZyt1?=
 =?utf-8?B?RG8vSlRsY1VQZTVUMzZnTzZPZXY2UHZTVkJGdWxCNmc3ZFhGcmJGL1dXa1FZ?=
 =?utf-8?B?azNWRnFPUlR6cXBpR0txbzA0bHpVWFdUMmhQZHpScXkwZ1lTSkJRaHJCYXls?=
 =?utf-8?Q?EidSkF0hrGd9hTBcXTRfKgf+c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1712adc2-13f0-4f1e-4a75-08dc5a49fda6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 17:08:21.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPuG/luo+89LHvJeJKrWQpQI+tEAoV6sjCufxkzImkcIrG90F7cJRBq6NnE/IysErB7ZgtKrDgPH0GLhw3rdXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8394

Remove undocumented compatible string 'fsl,imx6sx-esai', which never used
in driver sound/soc/fsl/fsl_esai.c.

Remove unused clock-names 'mem'.  Driver never use clock name 'mem'.

Fix below warning:

arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtb: esai@2024000: compatible:0: 'fsl,imx6sx-esai' is not one of ['fsl,imx35-esai', 'fsl,imx6ull-esai', 'fsl,imx8qm-esai', 'fsl,vf610-esai']
	from schema $id: http://devicetree.org/schemas/sound/fsl,esai.yaml#
arm/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtb: esai@2024000: compatible: ['fsl,imx6sx-esai', 'fsl,imx35-esai'] is too long
	from schema $id: http://devicetree.org/schemas/sound/fsl,esai.yaml#
arm/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtb: esai@2024000: clocks: [[2, 239], [2, 240], [2, 152], [2, 239], [2, 196]] is too long
	from schema $id: http://devicetree.org/schemas/sound/fsl,esai.yaml#
arm/boot/dts/nxp/imx/imx6sx-sdb.dtb: esai@2024000: clock-names:1: 'extal' was expected
	from schema $id: http://devicetree.org/schemas/sound/fsl,esai.yaml#
arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtb: esai@2024000: clock-names:2: 'fsys' was expected
	from schema $id: http://devicetree.org/schemas/sound/fsl,esai.yaml#
arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtb: esai@2024000: clock-names:3: 'spba' was expected
	from schema $id: http://devicetree.org/schemas/sound/fsl,esai.yaml#
arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtb: esai@2024000: clock-names: ['core', 'mem', 'extal', 'fsys', 'spba'] is too long

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index 0de359d62a472..874f33fb17227 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -339,15 +339,14 @@ uart1: serial@2020000 {
 				};
 
 				esai: esai@2024000 {
-					compatible = "fsl,imx6sx-esai", "fsl,imx35-esai";
+					compatible = "fsl,imx35-esai";
 					reg = <0x02024000 0x4000>;
 					interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SX_CLK_ESAI_IPG>,
-						 <&clks IMX6SX_CLK_ESAI_MEM>,
 						 <&clks IMX6SX_CLK_ESAI_EXTAL>,
 						 <&clks IMX6SX_CLK_ESAI_IPG>,
 						 <&clks IMX6SX_CLK_SPBA>;
-					clock-names = "core", "mem", "extal",
+					clock-names = "core", "extal",
 						      "fsys", "spba";
 					dmas = <&sdma 23 21 0>,
 					       <&sdma 24 21 0>;

-- 
2.34.1


