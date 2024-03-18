Return-Path: <linux-kernel+bounces-106540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E6E87F01A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2AB2839E0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FEA56464;
	Mon, 18 Mar 2024 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a5K0xWXr"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2068.outbound.protection.outlook.com [40.107.241.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686F56460;
	Mon, 18 Mar 2024 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788462; cv=fail; b=n90/ykJRqqaPTxa/MTr5UzAQY3BO588fL0+eHGSqwV3FyUGrd4Nv0XfDbQJ43EHtqVsIHtBvtn71gBJE9x78DS3ytrR19mrklZBUxNB2I4Gwf+Q6zkXzp4LqZYs4GzYJk0fgBNOca5rHkJada+m2SOcYcY4K0PqN13PQox8RONY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788462; c=relaxed/simple;
	bh=fm3dmQASVS7dADMDSVhVSWFwpxhdorpuXG2ia+uUfzI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fvcAlMrpPA3zkKSRTI43XRU5LjO/3zRoXAJN8OIGZBjDBPOhRCKGkb4vyLr9+p8pnET7J84TDfwYxK6vREAK0loER8+IB5MfHnvxRVfbbHUDnP/Tg/XwVNyPywbGv6BzB3T1vDi86xpirPGbihAkXFTKD4opcwpEWXwS6MBbgFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=a5K0xWXr; arc=fail smtp.client-ip=40.107.241.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHRIrRutkqTtQjs9j0RZ+vNL09QNFsTqtz/YFJyBP8QyNze85QMxyFAaOAc9WvA7X+CyJDiETWibuApEKy6tN64shBYA0bmbkFykL0t+/V2KzBQnrqa36xQHngoXsRKV2Bd1dEY54B/5qhcohOWfWkjOo//Oyf7XpiF3Kg3KcX3+GMixp240Mm9h3pPv4HHiGx+4PN1EuPkiPuviMF6t0AC2hhWFAp76AuxLYwZ4/SeTDYQFvws7WL5H2qklBVEY2McsALqX3cAW01KTNSkIDBmIBiUfb1ZpiI4Os8r+HhBkjfmH539EgnhJReEO+AB4D/ERcAvEr2txMjVABD3CfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jcy9MfhtKZUWdIStJBpPxcppMP2LQsPyG/iYyluN14Q=;
 b=aWPc7yUndQNeOnnELfjBPE0SPkXp+0iMfxnnfIZ03G9gkiMElJm8Mp1HcTSvuteqKYjuXKDxVYzlBTNyjpys1KKgov3p38d9k2vQMGjkE4Q5UhGc2vKzxPfbZogsao5t4FXnoGhR641h8BB2f8HoCldKLFccc6v7zdZM7CT9Q0+CTVVD90E1aLmIxiACi37DsvxuHTvP9rITsqghNC3VdmRQIkc9zuiOTlE7ludXRATOgTxdocPfXTR3FYOGuFDScj/wU3UlU80Y/bToHRs22MxOCI8P76uhEZOvYfqTQMxNQDbknTjkJZoFZtCvYDPTj/Dx89GM6J899QVBee2sgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jcy9MfhtKZUWdIStJBpPxcppMP2LQsPyG/iYyluN14Q=;
 b=a5K0xWXrUJMIcwKV6bEhrfP/wYqCF6njnhSkyFFTY3aKaEv8uO3/CMLW3b39UFSbE11iQ/42ReApTsSVZmy9DmnwC0ojHcKKi1DtBp4PQXICTmE5m2Jk2oBeT7NOz4m5dp4C+SS1vdd8GXjxr6orSj5/8KgOMi4IWrWMOYmM3/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7119.eurprd04.prod.outlook.com (2603:10a6:800:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 19:00:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 19:00:57 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Mar 2024 15:00:09 -0400
Subject: [PATCH v7 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-asrc_8qxp-v7-3-01ce5264a761@nxp.com>
References: <20240318-asrc_8qxp-v7-0-01ce5264a761@nxp.com>
In-Reply-To: <20240318-asrc_8qxp-v7-0-01ce5264a761@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710788441; l=1171;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fm3dmQASVS7dADMDSVhVSWFwpxhdorpuXG2ia+uUfzI=;
 b=yGPHpA5Ip6792M669/HdEtwiZprkLdYcHMynxBJsN8weHCZ2lBt1nEUPVmJCS2ZDn93MtuOYm
 o0Wqrs/bw6/AT8fp88zwwI0e5Wl2m3Y4xtmPL3uz01VoUoHMLUNvb2f
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::31) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 5662f9db-65fb-4b24-9fe6-08dc477dbea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rcbTpmZ3BI1TqQG3vyUzMt8VaWZarwixCHNlMwsnoOkC9AziJQIbpAcBcHPRDiXPyxlFOYsQDTfvcreCUYJFeIX3QEpHCAjcYq7AoSpeTkehBzOQGup80mLt3GQ51Nk5cLhQXzsw/IsT+9zKpZ1zU8Zws7sUhbVgFZyMOgT2UA2bOJ35ZqThqK0rhiJxlyY85dfiRJ9dupvDQvGdGaAhXP04qEFR1HSOJO3jMd0+dQZo/fD+9KABnPlHbFQFgdwCoUWN/AJW8KagIQwsArOPSqwaAxVCY9qWexk9VqepCNj73F/6KP0rsDdgCuwlcw9AQ3qIkDizMriCugOuemN87uU7NqZETTAshRIoeFmbvTafaq3cpI+Az/OpMhPerptW1+AdbBbobiBF8LGvOoEosok+dAsjZryMjdk/dq8YbkCoj231IBP5IdGI4UNWMzwnStVVvrHvt2yGE8VhunxUDU1IJl/W6E1d9nZu7ohTPlQp4pjqpe+kQgWDBOhyvWZ8KnXXXSSQC4f8R4XdcPWJ0YnemvdYbq5TL7/u4oFpHF7hHAyBOao4yHrefdrmqZkOISs26ShEs7SY8zbefODiRvJTCouN69QIiRXBhal+41/hI20B5fgLOzhzWjySvZr/XZgs2qXTiygr/bnNuUqUXflgv6pPnm8QRgXHBDkPLbj/bM7+1qCdF7x3CmiozQHcIdffozZg2s2Xv8ZJqUulEsxFLWmFoGSJIacAFz04QrI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(366007)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUFkN00zM0llYkR2dlIxTVdxdXZTdk5lZGZxbGZGVkdydWRpSUtGZGg1TjlC?=
 =?utf-8?B?ajZJRkNLcEtBd2Rvek40T3FZYWpkaDhReFhDOEpzKytXQk4xakZRY0sxbVRn?=
 =?utf-8?B?a2RHWmlvbDdxd2N5T3lJTWJCc2NQZStUdG5oaFVPZ29uNEdtYVREK1hWbWxm?=
 =?utf-8?B?a1daakw4WnhSVVJnQXl6ZzRacktCdDhJZU9qaU1IR0gwYjk1OTlweVBSVHZC?=
 =?utf-8?B?VHdOS29oVEY3UUFQN2xSZ2FrTEVYUldxYmRZTjAySDhtV0tNRnhuano5QjUr?=
 =?utf-8?B?UnJ3SDBpYmx6Q3l3NVhDenFOMXpnNTBBRDNuenBCYnZCZG5IVnBRYUowTFRP?=
 =?utf-8?B?b2hBeFVUM3V0NndQYTVoOVJqMWhCcWtGZGJCdUxNazdqQ1NlUm5qZTltcHcv?=
 =?utf-8?B?VVJFd08rcDlTSzFrRjJEalVNVVkrT1hIVWdpaHFZQ1cyWDdlK2RaVm9ZK3hk?=
 =?utf-8?B?bTNaTnFTVXRpTVM2NFF4YkFXMUdoeUFyTnYzazh1T3A3N2xQYkN6dFZqNnFj?=
 =?utf-8?B?RXdqYTR3OFIvdmRhODhkazhCRDN3WUNhbmtRWkEzZVhCejEweFVNT3Qxb1hl?=
 =?utf-8?B?Q0VpMHBjWjNML2c3bEpHdEx2bGgzOC9EazYzZUdHMUhwSE5lakxyOUdjc0pi?=
 =?utf-8?B?Sy9lU3puT3VsRUZKVEZEeFNONHRKUzVSYk4rUkJVdXBFZW9xY3JXdExmdy9s?=
 =?utf-8?B?a2RaT24wWHpWbmlWTVc1blM3ZU5HeWEwTjhEOVRqdXNxSXF0aEwxamhnaGhm?=
 =?utf-8?B?anFQWXcrYmRGU203OUU4N3g0V2J2WXJZc3FQcVdvWjZ4Qy9aR2J3S2lkWllk?=
 =?utf-8?B?bm9EcUFDNjJyR2V2eUU0TU5kZ3JjZFAzTnluL3BaenpEWGlXWDJRV2hsUkY2?=
 =?utf-8?B?b1UvYUNMRjJ3d3d1ell2cHg3elF1MStNVUErOWdOWjRvNjU2M0N5czljakxl?=
 =?utf-8?B?NURnVTFDTk9MWFM5UHJiL1dSVDVhdjc4ejF6dEFtdnBITElEQmVMaUVMRFl5?=
 =?utf-8?B?aVphemdsbEREYUI1ZkdJdlZGL0lKck1jbEZaTU55eUFqYjA0VC9QUlIyNGJY?=
 =?utf-8?B?dVlVL1JNNElpYUtxemFuQ3hDQTVQYW1HTEwzWjFhNWJoRGUyczJxUFl0dnJJ?=
 =?utf-8?B?UTNxWXNEcWt2eUJGMUxTNUVwcFUxUnE5cWFrVWt4TldsRFplTDNVZ3c5QWUw?=
 =?utf-8?B?Mk1DRDVOUUN6SEtqZ3gwbkZFcnpDYTAreEoxdWRiNERueG5sYnZ0Y0VYSUlQ?=
 =?utf-8?B?a0pSUThpeTlJbzhGdGVIT2E2a2NQZzZIc2VGQ1l3OFF1WWpPNU1HTHYxTksr?=
 =?utf-8?B?SllPQTFHS21OM1BuZVV2a29ybTRuWlgxUTJOaStqQ3RqbDFLaGVpWDJtRjRh?=
 =?utf-8?B?Vnk1RnRIV3pQbnM4WmhOTXU4WFN5bk05aUhjVTNCME9uRUxsWXVmYis2c3hp?=
 =?utf-8?B?OWVzWkxMVUk3MTlSWDZyUytvMWdQaEoyUndBSThlSHJ3TGVBQVRQeHpESEQw?=
 =?utf-8?B?NjNqZFdjSGVhWlM5WnlwRk1QbFV0Sm9mclZCU0pRUXdOWFJJdFhSWUxMdjhL?=
 =?utf-8?B?cFVNeDIreEVQclBRb3RVT2FMN1Q3alZUQUM0RnFaOHQ5L09NL3dtcmF1UGg0?=
 =?utf-8?B?RDFTRTJYZUNUaURRNlExMUcwRElGaklDS3FralBiaUpWUEtORlZ2L0F3R01l?=
 =?utf-8?B?YkJYbHVQWVF0N3JyZTg2Q2lNa1Z1ckxUbTA3SGVXRm5HZ2hZRHFYTHRGTEdC?=
 =?utf-8?B?RkRNazVBeTRNSGNoQUFWalFGbzNlN1VaRmlpM0k4RnRrUy81WklvekMzV2Q0?=
 =?utf-8?B?cVJNZ3VXYndYcjBjY0llVE9nZXhTcEtTMzFZamlxTTdvOXVXb2pFZjBBV0hw?=
 =?utf-8?B?QXJURm5WT3N2MmlpUjlUaUVIQ2NCdktWQjloam1BYUZjTWlzMU8zVUNCeUlR?=
 =?utf-8?B?S0NmbUttZEExSWhPTVJXRnhxbVZkc2RwOENjNCtyVmFxU3N4MU5iSi9MNG1q?=
 =?utf-8?B?M2hmZ3pFaEVGbnZrcG9kaVJaTjRFaUpnWDhOTWpaTWtzaUpJazhtN3FtL0xJ?=
 =?utf-8?B?V2ZIVUNFWExtb25KTGM0ZnMybEhpWlJGSDNiMW9nM04zeWNwWUtPVzQ0QW52?=
 =?utf-8?Q?bl1s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5662f9db-65fb-4b24-9fe6-08dc477dbea3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 19:00:57.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXjBpt8KfLR3e1DbjnmW75p5wDoymlbe3msVtbey+VaDCHZ+2KQ0+g6Zzle7ovDXpm+7J+5c7Nc19kzN3XkmXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7119

Some sai only connect one direction dma (rx/tx) in SOC. For example:
imx8qxp sai5 only connect tx dma channel. So allow only one "rx" or "tx"
for dma-names.

Remove description under dmas because no user use index to get dma channel.
All user use 'dma-names' to get correct dma channel. dma-names already in
'required' list.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,sai.yaml | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,sai.yaml b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
index 2456d958adeef..a5d9c246cc476 100644
--- a/Documentation/devicetree/bindings/sound/fsl,sai.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,sai.yaml
@@ -81,14 +81,12 @@ properties:
 
   dmas:
     minItems: 1
-    items:
-      - description: DMA controller phandle and request line for RX
-      - description: DMA controller phandle and request line for TX
+    maxItems: 2
 
   dma-names:
     minItems: 1
     items:
-      - const: rx
+      - enum: [ rx, tx ]
       - const: tx
 
   interrupts:

-- 
2.34.1


