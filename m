Return-Path: <linux-kernel+bounces-147061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280D58A6EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D37D1280CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D237130491;
	Tue, 16 Apr 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rnBLM6x5"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B291311A9;
	Tue, 16 Apr 2024 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278916; cv=fail; b=hY7gfZ2sSK3cwoJjQKOByePJ+CodzebzHk5IUm7r/0O/VkuHcjhwzG9L+oaJqsAEiFGV9HdeFh8QNKNLFWRD7Jmrro9a5SUX60FIF8iabjFLKpQdn1pd1kqyr9oSQVlBW0uwPALKA12NjMHfCeg9r5ad/RIVca/87XVb1NoRbUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278916; c=relaxed/simple;
	bh=txdhzgMKWLH7PYSSomyJMeLCWFmQ6y4g6vZqE/QMPWk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ET0N6/cnvbepi+xcxrzhmYkeOw3D7CEllTf9ke2K7ly1b1jMhfoimoB2dQFoNj0ln0/bMOzGsV3Lh2lrccI5ZEXwStO83Mf0fOyyQTu2vdLflxJpJ4V+/eUjba+dB5Xf1cMFNOU/dhbjEY+IzcKDkI2rbHeg+t+mbCTnfKZ6LMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rnBLM6x5; arc=fail smtp.client-ip=40.107.8.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPRnJ7cDv4yjmOFLm9Spn4P57eMCmrY9MbskLlQYOcIYpNdaX3MGdDAd749nOMFiqw0UIl9MZFequBeB+QRyOMXTSSI06LPfh/aBfI/sU44jATcDwjXmlR/ZR07qsm48YgCAgd6gyK3v23ez41O1Q+T5iitn90iarmr19YM2fRgrTspwOpiuNsv8OCipwumbliAmYXjcnw4Asks3xCerSTrylQiFCDjLb0yltrr6WJeg5flGjHIYcmMcBU+VfsGYhhKVl/l86+miNNpzdwOpoTWg1UXcxbeaHneE1iSXEnsAlqSoIJxPEsdZhKoAWQD78CaVUufO1v26Cn/bBZR5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj1U8idgGR3bJW7ZJ95N30hrkskmoj3SAMurbtwn7GI=;
 b=dymLs7GCr0i1Tcc91hJ7feJwFix56xDYXDLdTTxTteeDzy9By5KE41VKVkgv8qbELKrrB41zpNiWGrncBW6jZQ/rQoIpr2yK3M8U2KWEIvoG4lv3a2QtoxAT75EUIgD3FQ3cSvm6g967yE1zHcTZgQnAwstjpRvPzYDS48onVH1e/PqLBt4nklPRg+leWMPF95Kbno8K9K8vKzj9KrcCqh4/IXFX4Y9B4jHkfo6R53EoGZgJYp8vmXslrqr+4mn1LT7ZH6u8O/qWrGUg3Z5paxF5avskcy7oY5vOPjBIwk5nie5GAGhiiRPbD2M9yiNDtx7dsBa/iP7Fb9WsBz2Nqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj1U8idgGR3bJW7ZJ95N30hrkskmoj3SAMurbtwn7GI=;
 b=rnBLM6x5vR+9UShjxDTrFzSeHIF9YP3jE7X9BP08Vgqr2bdKRjTaMPBI8zCRXzAQUf5t3ELqnDOoBtCL3qa2GuYl7tsuAe5JluBN70Py6eqw6Ggcc5WhdmS1jJlqF46sKQb/v6uXJveDgZYqeqayKY1r6NWf9kU1P/xtbhPHO5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9636.eurprd04.prod.outlook.com (2603:10a6:10:320::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 14:48:31 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 14:48:31 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 16 Apr 2024 10:47:49 -0400
Subject: [PATCH v2 3/4] arm: dts: nxp: imx6sx: fix esai related warning
 when do dtb_check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-esai_arm_dts_warning-v2-3-879e59c0c3b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713278896; l=2489;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=txdhzgMKWLH7PYSSomyJMeLCWFmQ6y4g6vZqE/QMPWk=;
 b=1Aee7FKHHRXqDKAeShplrCoORf/6ytecvKZvqkyCXDoK3JGl0iFj2NecIBc8taJcqdXV8cX8Y
 0d1n3FpXrsbC308y2Bb5WcUTdwFbLbSel/uSSy8TBB/xmfLTV+92OIL
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
X-MS-Office365-Filtering-Correlation-Id: d2a20852-b73b-4ea5-0789-08dc5e244906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hW0MsQ2t/NFQb/dhRXzzMLMDTwh2FRVSYsSEUqmng2UtCO1lJhqFbr9GoKfuDh7H3DR9YPuhRVtnZvUD5pSRVZ13C5CnG2Tuf1XGTyodUFaEyJYXeLvnFxgmq5Txckp86ckeX71pm0q/3nQhV4E+9T8dBZozEb2qGMO1WL/Wp+lcOkx5ncsTGvmPZGsIByE7MFn/tSje1Aa6syH4O3r63r4LYQSizJ0MxRJ8zjJ/5LUfLkUmiWRmSbS3Fs9c4ELGPCku8mIo7R9TU/7JzgcqdJGF2w/srITH49ZagTP6rRh2nMJ4WJ1TD/lEQfv70p+nFC2E/B++KtxymogTWOUww4BqbWp6zAqzLJOlkv+Itod6oupRo/bkM0L87fJMVkc/LmG+px0Jp2oTcqKiCRxa18bNe20yjwDrbFVvj9tkxbDWIZWTXCsc9MwAAQ1kyZIWkHJfYSRilYf9lPVGEs6MZOoXxKgyBXGIHfv2ViDx0bkPuKoVm58stktOkHggdMtuvlxOK8HxCoEGGKURzpG7+dmT9vATI2/TPFDitU/qyjbQOdeAVpsxlHcoIz7Epvqf6r+LYTnw9ZzPaJzFZD7c6hLt+cEsa2bgOLOhtmlzBrkdF9S64D2VzaKKGEoFKowpvZpSEcTym5RUJRWgDmSeoJZDZ06ra9xJywAd+bXUG79nrjzCWvfE9kVQQWiHtQ6p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(376005)(7416005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d05sQkZnQUQ4OUNXYm1YdVNHcWR6M0hXcDRWWG44cmlVSDRsSVQwbUVLeHli?=
 =?utf-8?B?cE9VR1EzNWY0MGtLSWJoS01YVkFGMk9Kb0RhYjU2SERYQzhTWisvb1hBaEl5?=
 =?utf-8?B?aE5tS0l0T3N0eTEzbUdsZ2Q1UlBSeTAvKzc5cnJzWnVReDdvRktVU29oS2VJ?=
 =?utf-8?B?bUQ2MC9nckowTnU1cDVwVi81MU1Qblg0TlFJT1dGYld5OEtOd1pIWVZqbjFY?=
 =?utf-8?B?MmRRNmRyT0tZL2RPYkIzRXFmc2RTUmZpZGRFMEY3L1NOaTJSazNlWkl4dURM?=
 =?utf-8?B?VklVZC9EZTV2SExqTlpUQUR5NThLSDhqemIyM3RTSVVsT2gza1hZYlVBOEYz?=
 =?utf-8?B?U2E0RTNXaGhOWkFIb1c1WmNNWU96MSt3OTY2NHJOai9QZVNxY3FxTkRtaE9W?=
 =?utf-8?B?TnVIa2VpRSt0V0NqOGxkWDlwbGFUZFpReUl4L2E3RjhFRXd2L0NPa1J1aHpx?=
 =?utf-8?B?Z3JKd0EvYUxiaEdlekxPU2ExWWhlaHJlN29VUHNYQmVZbG9mampZRVhxRmVn?=
 =?utf-8?B?bXhQdXNDbUtiQVk5TlBJK0kzN0x4NlFBYWFXTE1vcEZNV1YyTHI2V3V5OVBO?=
 =?utf-8?B?SFRNUkowMWFQWWU2K3BVMFZ0Zk9ocnl2R1ZkMkdQc28vOHgraGtOVnRDeGMx?=
 =?utf-8?B?U1FJZGVLdWM3cDV2bHV1Tkl2dC9YTzNMY1dnbldia2tjZ2ZFVHBjcy95VlV5?=
 =?utf-8?B?Zi8wK095VWJzQzJ2R296MTV5QVN4V0dlRkZFTjcvOXV3anhrZ1c0NGMvRllV?=
 =?utf-8?B?OEI0MmxQeW5UZE9nL3lsOUJCdDRKUjdoYTczdTFaV2FtbGhpbllqRzVXY1kx?=
 =?utf-8?B?Z3lvVGlZaCttY0tlYUlleVQ0NEptVDFkT3huYjIxOFBFdm1iZWhyOTNsRlRl?=
 =?utf-8?B?TTY3U1UwT3hjeDhUc3NQMGZEU0N1MTM0YXJTVDJXeXI1bXVBWTBjTUFCUmFm?=
 =?utf-8?B?RnZDOTFOYS8xbkU2MkNNb3pVZ0RqZEF1U1FOa3NrOHVGMk9MYWdjeGtSVUJK?=
 =?utf-8?B?Zlhxc2VubVFWYjVud1ZRTXBmRE9GbWpaZFZMMkswM1BhNjFQMi9QN3lWMjkw?=
 =?utf-8?B?blc0cjRSMTArdjBkaThJMHJkUHhrVjVEbE9RYmRSSjF4YkorUTk4ektjeENo?=
 =?utf-8?B?bHh5cy9STXpxN3J6MjVXR3pCYklCMVdmd0U1ZVZsa0RQRlI0ZTZ1aGRwdTdX?=
 =?utf-8?B?anhwSlo2YVdOTlZCdDJKREhnUVJNZU9BTEQxbzd0MHg0QTNIajBROENrRy94?=
 =?utf-8?B?R1VqTmZHTDFkMmpPV0puS0V0NTVidkpEOVBkREF4WDlHVE84Z1diemhsN29B?=
 =?utf-8?B?cUNWUFZMS2V2SHF1ZWZTU1JCUDdTQ1pTMXJSTEFJdjVleG05Q2VzMWFpNzl2?=
 =?utf-8?B?WmFHejR2bWdpd09ETFZjWXF5YU91WHh2THlUY0k0V1NHYmxzU3ZsTUtsczln?=
 =?utf-8?B?Q2hKZmRKampRcGhXWXVNRVBvWitRcTNUZlBzSWxRaEMra3pBQkZ4UG5xUXNE?=
 =?utf-8?B?UEJMRGRPemtySnREL1Q3UjgwNHUveVc1WGhUZUI5K1g4dWJEYzd5SmZsaHNJ?=
 =?utf-8?B?YzVUcUNENnJLL1UyYzNkVTU4Z2JEdjQzM2h4NHFwTEdWUFlmZ0xvV05NRTZJ?=
 =?utf-8?B?NVJlQkNCZmxGQnVCOVVaVFZWekVlak5veTVhL05nOUV5bHoxSE5nM2N6c1VT?=
 =?utf-8?B?SDhVdFRRTXFvam9NMWYyMnJMeHQ4b3ROOFhjbGI2blRzbFA0OWJWTU94Mkoz?=
 =?utf-8?B?eUs4YlR0Zy95MVArb2ZTdUNVSkJscStxZ0FOLy9SZVpBZU1Xbi9uNXFkWENx?=
 =?utf-8?B?aGZGQmk3Z2tLNzdEOXE1WmhabVNXeVdFK1EzMkpTQWFmQ1g5UnY1TGNOMzQ1?=
 =?utf-8?B?anV5ZGh5Q3V2YmszbFRkVFh0Y1FhZ3p3UW1ZTU5Cd2JEY0VhVzlxbTNqVE15?=
 =?utf-8?B?TmpXUnY5RVZZVTJBbGVIQkptdGpiZ1JBajEvbW5uckhTdjl4Y1ZWQ2t6UzlF?=
 =?utf-8?B?eDNDSUNuU3MzTWh1S0ZwaWw5ZkVHa2JqZEJmM0hnSTFPaC9kZVNSZGs5WFk1?=
 =?utf-8?B?NS8zTlkrRVhZSUEveXNaMXRaSGl5M0NyaGhyVXY2TSs3K29WNVEvbVlWWVdy?=
 =?utf-8?Q?nDodp3vsOc6OBc6aRmiUYwRon?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a20852-b73b-4ea5-0789-08dc5e244906
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 14:48:31.7915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SppNCR7d6lt+ar2yhGTtIJfztSUQy5HiL3iSsVznzUkjdbiwkrh3i3RzQQfYkL5jcy+fvgrZXvzQDmF2dqBTUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9636

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


