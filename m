Return-Path: <linux-kernel+bounces-119158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FD988C4EF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7EA1F3B419
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EECE12C804;
	Tue, 26 Mar 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="obHF9FjI"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2104.outbound.protection.outlook.com [40.107.8.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CD212C546;
	Tue, 26 Mar 2024 14:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462473; cv=fail; b=Ssa0ZuBONvHB+itelGAU+By1xrV3nUvOOLEgMHH3JVOsj1/125I1gXfVZgUQo1KU4ml9jOCCurXccLXkMGHClHx042hOGJyYBTYTD0mr0FObXqDBfG4j/8X4cXolefeaFHabP0FcSpdqCeRuwIPasIxWWRawJ7Lqu6pLlu93rIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462473; c=relaxed/simple;
	bh=fi5TjXe/7vNreKSk6/HGt5MHb10MpDbkvNh2BMpp9Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WjwTHaxapKgGMiOK/ed3axQchD7uUlBGAbTmIdU6AGzixljBbMgUES1ehOUlaB50lSjXyecfiQpNMkQw4LHwsRJUrh5m5O9WcDRB6FstYp5TjTzDpYkzvuRYltZVsPxa2UPi/ufJIZl24DiHZYV1rzc8nx+ZzaEgqpH/zPYFQbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=obHF9FjI; arc=fail smtp.client-ip=40.107.8.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z83ZFIWvdUFBTw/cWv7x/x7nfEKp4Tfj0blp33//TdYRNF/pndeHjbQYvy+OVd9e29ZoxK6pIu+XVYgOUFSd4foYrQP1qKcNIj0QApcWdWpbWmZugd/RCFdN8POD3GnOdGdHIu0IeGHj4wXOOo6fh1k3JAGylmq4vaPqctgo5Flc0J8xTaKgbbWBBBkxnzVPpp9woBd2kOMpY7tMFqklFAAhkGYYcZvEgt2TbajM/VKPFcBwJionfgOb1a80iMWK9DV5gt6BFZm8arx3JdX4HVofDQKVl/71X5TzX06t3C8wcMoFGy3K7SXfwf5fgkfMlsMcl1NgnL8+Ls42D2awrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHINh3znD6VRNJK0fC0Sn1bdx0//xaggWKbhVnJ+fo4=;
 b=miMGEg/7aB7kB28tuy3+0QUudUqy/kQPeUVeuevl8zm+yPe8kaMEAELeXlbU+i8luqYPJBK4DkuzoB6j543bnsxmJwNMN92YdqCfujkO1TurmMCeIYDV519Adwav4Bq74tQypVj79OJ3qbbdxUfBRptiS2G8pV+W29E/XDooyNjGmRUWZlU8F4LXoTappTbmErAwyrlw95WpzgutI/KpuLzvLot6AEZcOLPLvMrTfEjtqt9BOxngaaD5RSlpZJTLzR7c2pYcGp1GekoggY0dpWHAIwOLlRGode7qKFYexHvvW+j3QRC1N8A6r84iu8u/YSq6YjZBZ5B+qIoegwjjlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHINh3znD6VRNJK0fC0Sn1bdx0//xaggWKbhVnJ+fo4=;
 b=obHF9FjIWy91Mks5HKZyrUfcGNF6sYgpKY/YmjUDLDEtJciiggk9lyCIgtiOaJv7QvzB3coOckKZBT/Zu7AlZGffpFMrZF0swwx8PK+jr2x7hbTQ9ZRzQzDMPGv/F8LmelZTaXeR3mysJ2BXdj98yCYw42nalb5JMoc6Xg4E/QU=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9683.eurprd04.prod.outlook.com (2603:10a6:20b:473::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 14:14:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 14:14:27 +0000
Date: Tue, 26 Mar 2024 10:14:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 0/4] arm64: dts: imx8qxp add asrc and sai
Message-ID: <ZgLYOYFRxVqK30Z1@lizhi-Precision-Tower-5810>
References: <20240318-asrc_8qxp-v7-0-01ce5264a761@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-asrc_8qxp-v7-0-01ce5264a761@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9683:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8QXLHyr7r7o68kTaurmkF1aBQsJIh1bjujgYxfLq4PJ9A5G7E+VNE3UWWPjcX5Wk+5z0Fo2JqxOooHfo33ypyRmwiZ+X7MBbeqZ7QNRWQdLbHWGJBRwQzJl/pvsyZuU2cIgZGHf5OcF7p8PWMXSGxyWAUo0ZF0x4MD/KLp6Vz/kGLjBtlb1CcRSdlLmviR18siyI1vV6JobwKj5dL9ccOtaJGooHEy1JXXTu3M00w+MWCvqbk2XNr88ZUvRh089Q8X7/kamrq4Ra+4oC1Letr9sT/l/l/PbHBJfDIJ/+3zw1wOhwHp+gilyEuwICR3XINpuAAtyHpP/1fVJOhXmoyL6eiN8Y7qJ7xei+t4j5TLK5g5qK37rw1RUclwVsO2DQJavTMvFUJPDpsDyme2W+QBAoUyZOo8QCd7Zldp+tSfN2FmtieEsnPWK4VwW+IGaNY56rQUdzWyDlJ5npr+SRDdSAAT5MgS7d6IJad5JQVL1FVIVIUnLNxakdIHKhLK/aiRAtIU9JeEZUFU8g/CEUZoI6/Ifg3Nfl/j0RNMYXylIbt2Mv5aoppm8wWlbG92nwQN3YBXQ/Z9nTbf+AXZ6P1wrw/qoiIjB/rMvwDDTTHHmbojPCng5i4GUITy9mfepCt9x2b70BfL/cV3q87NOk9oAKJCvQ/moFAkbylQ5Rw6Hu46swObrQV9HHQjLDP6l3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(376005)(7416005)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n7JsXgM7DnSFXYzn0RdkTfXpdj8UJaFFVBdhy2G5352Iwd47qemBI9TNsEj6?=
 =?us-ascii?Q?LskCYitpg0vVmaQQJ4sbkfwKs0EgsilBYKfnKzmii1lpbiJFjioMyRfJYlGf?=
 =?us-ascii?Q?J512G5CilYuWHjtNbRHiRqnt+6x0hDXwcAQMnui7LpoAXDok8taYhTFJS2AZ?=
 =?us-ascii?Q?Nw5LflQ4luSWMTBmScsCuWZOWYaNwW98QZ0vuvIQ9GUxj56larbORUxKxrqy?=
 =?us-ascii?Q?BEIsvhR4T6rIHlIkC4DGb25JZO7Ghq3rqt1wq3ju2tYcMLBrgPZB4da7o18Q?=
 =?us-ascii?Q?62GDqv+0ntuzHfTcdaYO3tTV8GhF4fe1WsFWcEJ533fJUU8JCAtDpVrghmJa?=
 =?us-ascii?Q?dpJKuuGEYpGBAZagRN6cDbN3QZQEtJoLXO4nz0X1ChHt2/S2C8x0BQujJ/ZG?=
 =?us-ascii?Q?tEF5wBpVF5rS/tT/Nfr4iLjpa9AU0n7HCabRPAGG99ilkEmKpLOx7QnTWafu?=
 =?us-ascii?Q?idHHqeasGyr33YhgAwfW2Djb7TAfQhX3paAxLR+aF9rGthJKCc/tHuzLIJlo?=
 =?us-ascii?Q?QpkOBBuwcHPMAReU+kYu/umhYQHYd73Xj+4u5zojP3lucPp5/b3Tf3rVVHpp?=
 =?us-ascii?Q?brpq/h6ErPudAsmEPYahXOEmjcXpIW4kotnL+gz8e7LPhs3xvpd2qgCcXlJ1?=
 =?us-ascii?Q?fV6zzv3cAWGPhQtGqGSfukY9E84PxXizdrHGOq8nKAiBQOCSfpkzqZbzSo98?=
 =?us-ascii?Q?K4ZTIUO/3S5eo/3kkv5/ujeK+Z8SpsZe4Y27QDPoVSmdr2Bu7Tw31jCwgFPM?=
 =?us-ascii?Q?fjHA7WheXpGqS0zozfjnl3Aa1Duvl4oeFNdl3jDAfUEvRZVbdu3ajFGoX4S2?=
 =?us-ascii?Q?Uh7p6lh/z7sVU3/+dVCAl8hDthFe9jFxKzJ1NLFnf5ZMG/M/S+ECkkGBSO8q?=
 =?us-ascii?Q?MvhUz1WUdp5SKEyh8LaSpOEVDwAqD++bzPakNApdp+hrC+IhMi6AR7ieWtNU?=
 =?us-ascii?Q?xBgFvCMzfZc6PmGK/eDtHjhsHREAPOHzdsOvQAJSn6JfwfvYggmX5xY62WSt?=
 =?us-ascii?Q?Z/tqtrB+CULvbZBaU+4lqTQb69JXrDbiclxevTVDurXKrCOOyjeL0hjVA7S5?=
 =?us-ascii?Q?htTODCkH/7Ch0DHtYStdnS2A/0jC5OTj/Qjp0mrn04Kxh+btUDg/939JQ9dW?=
 =?us-ascii?Q?oN81rfUe7d7kZQ1dhquL0JMrssFSJNX66nl+MdAlleUwYzNkZ7p0iUIWjckj?=
 =?us-ascii?Q?zuxGu9lYo4hD4YFq7GzY4/8si8muktRO2Q4yERBpsXaopGOoUDAHCbKCz9Nt?=
 =?us-ascii?Q?73FarytpvQJ16ySejsQvWAhJQyQhdhf2YfnKwTKId0zTPJd4dnzUtbIQX9go?=
 =?us-ascii?Q?1W+EVOpjfya8wXQe5HiKaTSF4tgbLM5qjGgp6dH5yDay6GODIQx2mmPa2Mzf?=
 =?us-ascii?Q?yWtK6w3GZt0EKJI49CQItAE2Ya7TdDwxRGVbEia/365J4lHrUhOgzuNoHxev?=
 =?us-ascii?Q?2p89BFq/72PzfKIaOwdc6xaKwskexeSilO98X60FeKiTRrfExQ/PdkC6Wpac?=
 =?us-ascii?Q?4vyyr/CvrHXdtH+0j4F9FUp8q69TpFLZ7C3Hm8HGvPUwC69Vg6YFJEU22sYb?=
 =?us-ascii?Q?+VKq8yjNuY1/sswfAdU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c92fe5-1fe5-4d89-c26e-08dc4d9f0bff
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 14:14:27.7363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnKuJhoAGDPS8Td+BEXJF3fEBj9nfx4pEzNihrzsa1cOK3CM7tq8l3audyr8GC+OYATLTdI7tuKcdbPwT3u5Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9683

On Mon, Mar 18, 2024 at 03:00:06PM -0400, Frank Li wrote:
> Update binding doc to avoid warning.
> Change from v1 to v2
> - Fixed dts DTB_CHECK warning
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v7:
> - Using rob method for dma-names
> - Drop conor acked tag form dma-names and interrupt patches
> - Fixed warning for interrupts
> - Pass dt_bindng check
> 
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,sai.yaml
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/sound/fsl,sai.example.dts
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK Documentation/devicetree/bindings/sound/fsl,sai.example.dtb
> 
>  make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,spdif.yaml
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/sound/fsl,spdif.example.dts
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK Documentation/devicetree/bindings/sound/fsl,spdif.example.dtb
> 
> make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx-asrc.yaml
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/sound/fsl,imx-asrc.example.dts
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC_CHK Documentation/devicetree/bindings/sound/fsl,imx-asrc.example.dtb
> 
> - Pass DTB_CHECK, below warning exist because binding doc still be txt.
> 
> from schema $id: http://devicetree.org/schemas/dma/fsl,edma.yaml#
> arch/arm64/boot/dts/freescale/imx8dxl-evk.dtb: /bus@59000000/amix@59840000: failed to match any schema with compatible: ['fsl,imx8qm-audmix']
> 
> - Link to v6: https://lore.kernel.org/r/20240308-asrc_8qxp-v6-0-e08f6d030e09@nxp.com
> 
> Changes in v6:
> - Add interrupt description in binding doc according to rob suggestion
> - Link to v5: https://lore.kernel.org/r/20240307-asrc_8qxp-v5-0-db363740368d@nxp.com
> 
> Changes in v5:
> - using rob's suggest logic after fix maxItems.
> - sort dts nodes.
> - remove spdif1. Add later when do 8qm upstream
> - Link to v4: https://lore.kernel.org/r/20240305-asrc_8qxp-v4-0-c61b98046591@nxp.com
> 
> Changes in v4:
> Combine comments' from v2 and v3. I hope I address everythings.
> 
> - Krzysztof's comments
>   - add reson about why change
> 
> - rob's comments
>   using rob's suggest logic to restrict interrupt number
>   but for dma-names, still need use oneOf to cover 3 case
>   - [rx, tx]
>   - [rx]
>   - [tx]
> 
>   oneOf
>     - items:
>         - tx
>         - rx
>     - enums: [rx, tx]
> 
> - Conor's comments
>   - add power-domains required for imx8qxp and imx8qm
>   - remove dmas descript, not allow use index to get dma-channel. Current
> no user using this method.
> 
> - Link to v3: https://lore.kernel.org/r/20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com
> 
> Changes in v3:
> - Fixed dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/fsl,spdif.example.dtb: spdif@2004000: interrupts: [[0, 52, 4]] is too short
> 	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#
> 
> - Link to v2: https://lore.kernel.org/r/20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com
> 
> ---
> Frank Li (4):
>       ASoC: dt-bindings: fsl,imx-asrc/spdif: Add power-domains property
>       ASoC: dt-bindings: fsl,imx-asrc: update max interrupt numbers
>       ASoC: dt-bindings: fsl-sai: allow only one dma-names

@Mark Brown:

	Could you please pick dt-bindings part? Reviewed by dt team.

Frank

>       arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif0 and sai[4,5]
> 
>  .../devicetree/bindings/sound/fsl,imx-asrc.yaml    |  14 ++
>  .../devicetree/bindings/sound/fsl,sai.yaml         |   6 +-
>  .../devicetree/bindings/sound/fsl,spdif.yaml       |  35 ++-
>  arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   | 267 +++++++++++++++++++++
>  4 files changed, 317 insertions(+), 5 deletions(-)
> ---
> base-commit: 8552c902efe7ef670b6961fb8885b67961aeb629
> change-id: 20240227-asrc_8qxp-25aa6783840f
> 
> Best regards,
> -- 
> Frank Li <Frank.Li@nxp.com>
> 

