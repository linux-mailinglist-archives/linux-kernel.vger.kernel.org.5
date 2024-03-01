Return-Path: <linux-kernel+bounces-87902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3553186DAE0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F331C230BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD295026D;
	Fri,  1 Mar 2024 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HAa6+FCg"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5918A4EB23;
	Fri,  1 Mar 2024 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709268811; cv=fail; b=J4c5I585UGoRi2rVI4ouNDuWPCg/7vpNAsHoVXYwq91aYRGpYGoiVtNg3YqEIibxReV6frxhOna4PfCjgkZp8IiUkwfiJqJfChy5462lySuNfiKfVUyW91leC6Xw+50y1hEQclnudtyqmX4KFwxZiO/eoPAEm9ivlH3xCtpQguc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709268811; c=relaxed/simple;
	bh=3o7qJ6R2QxMkPGTXqgGJ7JdEjlmSh/VNt4bMxhtkPZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p/XPN/De5vcFTXd+5BfZLCGbMXA+UujMqGN9ja/OYON5rSADahghmMJN60PUdb8Nbtg6r8Qjs+K9ZLolxgtfcYTyB/z0aiFzTOmtzZWLqmQ5xLRhAoesa0qli9rurV0K2ftMu0Yfp/+UNdoFX3kX+FRmseaasgGwpCTYVjfnppQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HAa6+FCg; arc=fail smtp.client-ip=40.107.13.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6XrNg1Hh2xcIqpEJ8ZYlH8pesGvGZ0BZx+IMUGH0L2dMG+Syg2pmTslwG2ZytudYAAZO4uVuba/7QJa2zJ1VrgvkjCjLX8bZJ8CQp5KDobBSX5DWEcASa7x1riwkaz3mqP68qkBP1oTaFr/wShckvfD65vdS/FS/a7Uzk2ufyoUDaXFvbCR4nRaTDZ9SjW2xaraREc3yWbu08cP5pCyrpxFoPieAEnLOjZsebLQf3FtirBVvsJDqtFYKd5lF1eZ0eQMeMrBfgOHjPHavuejfEqIE0sN5DMFDksPc7g3Xc+YSIyboZEKrLrURcLmh0MNOCRXwbS9bCIEUo6tYvCQ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJpjGB7F+QJnkOhV9NZyVJSn+A/dw1ThGUXl+/0wAFg=;
 b=KkxnZ7xQxe5O/Z9KdBvbBOmihdm5i6ebHdwUHabG2ag1Qh2Bm09BrCB+gHUVNK3dMaBWLhZdZQJf9KiSxytQrFbo8/n9gnPQ8frH3IJHjfBGBHbjtldMTecFXiY3sQ5IIsZJUqizVBnUqh7p8HSfdp2RW8p9iD/TQCei/hb8FihB7L76rGsHSGrksgnOt/wQ1/5o2NC9vZOxuieeNqxKCQGjVzFoU2ObtC3LS492PnSz3I977cW04m62pren086/XWZALS8vxUCSb8HfFgKGYpxWpZna3gKfEnb4YCdIzFAyIn2biyVGdIrkY0omHRCsYrhBwLHj9A0RH/rT2SmEqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJpjGB7F+QJnkOhV9NZyVJSn+A/dw1ThGUXl+/0wAFg=;
 b=HAa6+FCgcNZrXOTrjA5TsnNk0X+1UKg3F0asZxB4wpHF/uVjG+8w6XeCPUxzUAqZxfV6WMW2Cthpl9lr7YmGpfkIU7uT0jhxROBvWomyJ4wxYBErzhCM9pDqKvUBJ/mdeXRR8wTAzLj/IIVoPFB0ZTZxyPaH9G5uVuBn+4R6Kfk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 04:53:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 04:53:24 +0000
Date: Thu, 29 Feb 2024 23:53:16 -0500
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] arm64: dts: imx8qxp add asrc and sai
Message-ID: <ZeFfPMzef9GoDys/@lizhi-Precision-Tower-5810>
References: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b260c61-6209-4d4f-ebab-08dc39ab86a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WneUBLy23C9NInwUyP+xyVtwOcLa+OvJaofY3MJpRNQUi7OaQUVeyBnvnE+PtJm3MCGqWTxkDAo47+DZCm2/bDx5j8SQLp3lxwnuvxTXTIPo2uW+T4GMIQ6NuVRDQQpk/Gr49Vl3onjoVJJoE8rpBhdYuzByUFidCfUPhhGcrtbgjWSIbIX19UAS0A9CpymhHtNvI4lhJTOqA4xB+2wfrTboPaDKJBTHYqamleWBpbMzeK6CIHt4PCYoX/KCV5Otm/i106D0fdA2Ptps99+dmQanOsMyLvLTv5kFJjlbN5lkqZjINO+5IrC17r54R+gs8J/CJ34eEwQASgqozQ3fR8oclIHxQ+eZJjKfP/BbNWHZo345vbRNUQWdwmCSbdlLDFSqq3NcOQw3wqFF54VzwoPyVWKnYgFPeHAl2V4E5iJQK0XO/WufOCMiWerZOjgw6C8HcSwxiQBhC4RZHHQ5Xho9crvDRNPBpjmK0r+q53lSM0ck5WDdXAcQgl9MCWo80fabyAJ9eocFhJTDzN1B/OlKTfG7zczEhxh2P7z8rxVk7HnpKApvwJq9N1OHnELjNRUT4jhmv001mc0NDiWZ2d0JNLTYFCCQJV7B4k3Yd/5Y/BetSsRrlCETOxbltWxKn2dNSqgUnApeJSvAdDnOtIhPvzpzjs9Fx1+pEPrjEe9zrz9PkRKa+9ypnHx3X3pi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k2fNR6wiJJ33BgdHh38dv0N6fmFyVCHidn+mMBqayHTBAmAvWZc5NyH/ccTv?=
 =?us-ascii?Q?Femy0I1zdRMs9EDAZqCyb86y43Ag+frXETgst26rpBhK3XWwScv4uHdHw2pr?=
 =?us-ascii?Q?ClTiKdor8mWMovJ+BZQm2jHOHALK5dSrSYPTZZy3p39dAzEjLHpZ8Ipkyh5P?=
 =?us-ascii?Q?NTtawa+4q1MrXV0h3xKfyG3zMmAkzsk1SW45gDwnslK59g7tKb3G738QrqEt?=
 =?us-ascii?Q?Ou145N9XGNSgXdOr5tp7CLOQNhRJUwVQeuEuZbxG5BjjBFcr/sajiBi0IG5L?=
 =?us-ascii?Q?lIX3h/kd0HDK8A/yF164aV6Y/W7xVZMVq8CKIK43RkLAAqp5DOYhHKYWOcgt?=
 =?us-ascii?Q?1l2blszoH0wrgLU76OPaMpOEAuQlOPtRPBfFBhkZ5gheU+efs5TkSnpmthai?=
 =?us-ascii?Q?c9bA8TbMdDBRokeldG6FTPG5/Pb5w7XcxrTFz0M4Pu46NLqh7cWbdHBpzLJL?=
 =?us-ascii?Q?RyjUguYX8Grbi7pEmQ7LeYKQQoG2lX39+HTulp8XL4SG71vuDtJTXPeG86yB?=
 =?us-ascii?Q?Vht+974SQp+2cPR4mx1he02oIeaNn05TcjSwdH+DsVY3fHjY5+5aP+El334X?=
 =?us-ascii?Q?/AA8H+n0wg1lmP6/Sb/yf9wHD4+kVDKfBXweDLRts03iDBGV27btMNqEmRMO?=
 =?us-ascii?Q?O0+5jXu6aoOcZP6zJj/HH3umAEx7gkCFeZoeXICEqaKdR2dJQ0OE+D7x6CqW?=
 =?us-ascii?Q?6Slj5NyPmQXnf5HyQvY/PIBsBVXsF9kP0SJcsmh+/q3fxEdnPtYAvgkupbp/?=
 =?us-ascii?Q?Ro2XCS2GckW1drB5lH5KjNP18s7w0X1eC6jXNuV/ofv1XmLkZxOemLC4djIl?=
 =?us-ascii?Q?EN6m4CmsIBWvdOwyGUk0vJtdhrJP2ZNUbFEDGi/YpHwV31AXIsIz3ZD7Uldt?=
 =?us-ascii?Q?aFPw8Nh9Oq6T0NBLry/NzGQIa/5oDEtLaUADLZgduIKwbH1nRc2nn8ch3gG/?=
 =?us-ascii?Q?JEtBieYzp1SVPD+aOSWy0Up48LR1LN7cn14igPuHQD5lRtnsfDpMqpFy088i?=
 =?us-ascii?Q?KnGY8viQT/k7/N4QH1VOQE2Xeq385uFVNwXIK6eUPgkXo2/C/LpGypLTxt3j?=
 =?us-ascii?Q?lO4lwmrWk2rwSSdBf2ERQWwLHmTA+Oq1vsMvPsfuwq/u2LES50XRDaiIFnqy?=
 =?us-ascii?Q?CaJN4GHgAhiGclT3pcPLJQd8uYrzK9UzPJNORJEqjwtl577okveGCdQC+Dx0?=
 =?us-ascii?Q?987IjtZVduPnxNJrellLbiDBZWgsJLtOnUE2xwV1sl3doI3VT/GxqVu98PWC?=
 =?us-ascii?Q?e8y1HEm+S15Jb3USXMbTFg382Aen+nbv0DW/UECzee5ewSCTZo1z77Nxmf9M?=
 =?us-ascii?Q?wRv2DdWUvDExEpiB7I8ELhjg+03O0PvdcCB50r6/ETp33moRrq5dmVmiUhyV?=
 =?us-ascii?Q?rkRcO+ORthF+DSkkLIKAz5VhIFGqcnAK61fuILJMOx1bFPR6K0aEjS+Zf4Yg?=
 =?us-ascii?Q?DE0l/1XnGPkQYfgV8d9P2AotDz3lyk53avKm21282LHVx7L2e9tmFSzixGsG?=
 =?us-ascii?Q?gNzbQBEWGULaSMRPqR1j0IfTI4Ogjm6l0ntjgMSPjTKP582oB+POGOsmjk18?=
 =?us-ascii?Q?brhNi7bWIw6h0yrWT+VOj+E0TCxxV1vDHYfMzeqe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b260c61-6209-4d4f-ebab-08dc39ab86a7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 04:53:24.2520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNHYS5smXZp7PnSrxP/9T0nosR8/P30jW+VwEKnTnBEdp6NiFBu6vAE8AJll8YGe+BIob/5i0kDn0Uzi64aTiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

On Wed, Feb 28, 2024 at 02:14:12PM -0500, Frank Li wrote:
> Update binding doc to avoid warning.
> Change from v1 to v2
> - Fixed dts DTB_CHECK warning
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v3:
> - Fixed dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/fsl,spdif.example.dtb: spdif@2004000: interrupts: [[0, 52, 4]] is too short
> 	from schema $id: http://devicetree.org/schemas/sound/fsl,spdif.yaml#
> 
> - Link to v2: https://lore.kernel.org/r/20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com

Thanks everyone to review. I just realize this is accident out of my
mailbox. I just prepare new version and wait for finish v2's review result.
Sorry, I sent out unfinish patches out.

I will address all issue both v2 and v3.

Frank

> 
> ---
> Frank Li (4):
>       ASoC: dt-bindings: fsl,imx-asrc/spdif: Add power-domains requirement
>       ASoC: dt-bindings: fsl,imx-asrc: update max interrupt numbers
>       ASoC: dt-bindings: fsl-sai: allow only one dma-names
>       arm64: dts: imx8qxp: add asrc[0,1], esai0, spdif[0,1] and sai[4,5]
> 
>  .../devicetree/bindings/sound/fsl,imx-asrc.yaml    |   3 +
>  .../devicetree/bindings/sound/fsl,sai.yaml         |  12 +-
>  .../devicetree/bindings/sound/fsl,spdif.yaml       |  23 +-
>  arch/arm64/boot/dts/freescale/imx8-ss-audio.dtsi   | 304 +++++++++++++++++++++
>  4 files changed, 337 insertions(+), 5 deletions(-)
> ---
> base-commit: ca301cf599a4eeafed8e3dd87bf8d2fe810e075e
> change-id: 20240227-asrc_8qxp-25aa6783840f
> 
> Best regards,
> -- 
> Frank Li <Frank.Li@nxp.com>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

