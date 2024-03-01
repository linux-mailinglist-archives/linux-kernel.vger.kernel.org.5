Return-Path: <linux-kernel+bounces-88777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724D886E671
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1211BB23216
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46872A8D3;
	Fri,  1 Mar 2024 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QuEM5z5w"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2079.outbound.protection.outlook.com [40.107.14.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFA92AD00;
	Fri,  1 Mar 2024 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311873; cv=fail; b=fI0y48G7S32E6wPrxTIOWTlWPxIzd6ABFMq4AbMCot8qs7Z9xG/HKpyXimqDCd0sBomEsVSzzWTJTJxamFAd5pz4YIOk0+v9PwE+QT41XJ/tLOBGegP/9ri7BQm5NB0ypsxk2rsqPHLnfuUWYnm9S0R4FkjocLV8ynzDspHyI9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311873; c=relaxed/simple;
	bh=ZzmM3hZ8qFIM9cFk7NWDIbMv2eWcLzogUAmToORKlDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qG/UhxE6AYJNgKpqxKdC4Tv5gjrbwEA356X63P3FX2ugxo8ylMCvT6a8J8T11RImDWIVz2AtwutCGPC2twAZrQ1ARLuuCfpPbVE2mrKge7c5fy7g7flje7/mw7SWGaAkT8reOyYQuxH2x7rCOYuP+ksfGP4C3TZHDUdjNSjgeH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QuEM5z5w; arc=fail smtp.client-ip=40.107.14.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/VdZqS3q85HCjMLmmi+rgUMrOcYPvsE19/I4MJ+4JVeWr4ydCkj7Kztstf7jp5lroSX9ActJ/ITXnPRszeIN7Yw4mal0esbz7jGHywpssXbW/8bdr1eaSdiFvngOGWowQnWPP6pvE2k32ThpuDuzEF/qe+vE3pjRA+hKxTyDx1hUx8t/JWHuqXSBBwrgh5faUEpJ6a3mJKBK92k5IB71QZ6bqrQjaG95fUvgWcuVbP/F2+0bCQLdIYUtsTdbmlaORgf6VCxI4APpICOPEukKnXe+g3nF/a+QgJ819sSwDhMa5Pn0S3ArhCCdfeirtcLWqBIRZ1PtmcOzAW84fBxdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMmkfYwc5gJshluNpnzyBUxaxPUMakrRlWXvAVkjZxM=;
 b=RAq5zWNOqYGMD7sotPYeNeLbnd89QifOg6qfsTHPq/P9u93S7GVxioUwPbubNSSWqGWqZlCuSzJl6o0yR5fAtRo/nNuKYXRLVqj12/mUkf9LQObOmuelD8Pwf5P5imNLwpq9Stswaz6mNQItps2pNBIE7C3SACumKVJpZLXtjhHMecaYbftQBIfWf+f9hgA317AU2I6xgI7thkSeLMOXbcCp6VyQh0dJOtCZwxptKrTw4LfaBpkWf50Q9Bxs4DWfmqU/QyOpyF+uQRwuFoywVBE68Tn6Fq42MXRmGbWIsWEp4dMxDuRBVjEdzAWMwNNqHJRHlF7X5ND7vXhb4rvZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMmkfYwc5gJshluNpnzyBUxaxPUMakrRlWXvAVkjZxM=;
 b=QuEM5z5wDaN5fOJW1A6gO6gRh3DedLoWgF1aN3fugOEa9FV1bGL2ZtGLuc6jpGO2lpDd9h+DvIMUJxLdZOtXQP9BHtCs+UtMwU1ok5caER9OLUEMTjfgb84QgfpmK5AmF/9pdzmHmEjc064z2jaYqzHjAkKoobGVJuRMTM+izSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10134.eurprd04.prod.outlook.com (2603:10a6:150:1b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 16:51:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 16:51:07 +0000
Date: Fri, 1 Mar 2024 11:50:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ASoC: dt-bindings: fsl-sai: allow only one
 dma-names
Message-ID: <ZeIHck8wUqdYbzeK@lizhi-Precision-Tower-5810>
References: <20240227-asrc_8qxp-v2-0-521bcc7eb1c0@nxp.com>
 <20240227-asrc_8qxp-v2-3-521bcc7eb1c0@nxp.com>
 <20240229-husband-penalty-8c1ab0f57f55@spud>
 <ZeDbiLR8vLtVfgGX@lizhi-Precision-Tower-5810>
 <20240301-ending-resize-9ee4e1998f6c@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-ending-resize-9ee4e1998f6c@spud>
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10134:EE_
X-MS-Office365-Filtering-Correlation-Id: 945a35f8-1265-4498-c76b-08dc3a0fca45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zNFGOSTZRCcADa1bSlt24EQb2pSC1KasdGTmceW7D/IFeNUlEMBZFDGArbfN/pZlOvCuxScCJc5lPHeopoUT8GaDCxY7K2P5CrgL8EHeeocAKRU/HUuQSn3KVsFJCVczuOqT0HQ6ttSM10LvZLfG929ps/jOvrPqlFqRbt7uLhV/pvHYjeeaz9Ib3tkg0da8mQWxrYdn6bcSfG3zK71oO6Ruc19r7xdhuyrvTtZPOc0z+yZ5H2HobeR+u8OxmwZExu98ZaKEoOlST3trl8vqZMz2dqoPD90Bqz3vyZVBzjs9QyNV3fNWndq0d+oyx3d1nuY/YBWIZEtRu16jpjvSvXIeDhAh8Qbfp8OtXYEfgIShIiD3Kb2ERLpaIUMUXrX6qT5wpQmODL+N/dLyenABKBDjTtcFg09JE5p+QJNJ0HaqvvzY66xwnO1FRIVE0WBqE4JUzfJcdvsCOQxiFLLas1oFCKPTWOMOUNxdkfEfCY+pN9jCNSJaJjP7QR/jHRECPokPwN2uuCMbRUp3g+LoZ7GTpG7MQTJuZVTT5W6ddz3OHgPHDptxXwPvV7vFdQzys2GnfXmWxZRKM3NGhICVS37jDu1VOKmCxiARa4FBCQ7MOSX7nHuDB+hWXXAeMYu5ZosOVDltG13dnxpgzy+/CbKZAgsicsDWsKRpjisdKL7BLGPB57W0XdyzzzQvc5BQirXx0gxy/+xSNWX6tx4/CQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9SsNKuTz8Wupbg/O7Kc71O98RiGRWv+cg2yM796vVej673H6nsNXW3/squcl?=
 =?us-ascii?Q?tVjayZRL+pEgdvlZGL/DrdGz2U+szQBD360AsAHHIr8hLQNEmy7Camr49MEe?=
 =?us-ascii?Q?090VTDz7l7hlzOKv9qdc8Tv6M4ROzz7XyiPYCUSb0pTATfDfS9LKNjztuB+W?=
 =?us-ascii?Q?XqyOZdnD53aF8ST47aHbSOPFUGujEuslfB0pR9TXxZetX8Piq1MxttiPz8CR?=
 =?us-ascii?Q?MdK+6llDVVk7yjeoPw1yNi0n/p8voC99jDewqEvAW7YOI+kVMjfEKlziwSSo?=
 =?us-ascii?Q?s3dYP7GKSf75XRh59s1q+TIkgko7H8c8GD58hOSyKsOiAyj1QoiLH3hfLA6Q?=
 =?us-ascii?Q?Q9fxN4k0R32V3K2jHpykxzicEi1P8FdxFvUc3/tKFbR26+CuPd9r53NyyCMC?=
 =?us-ascii?Q?OUZdfC4F48YvfHUdf5ShgDvpXW/fiAXw1BolSLw/4R9f99LC1Xq6Ilwq+uqu?=
 =?us-ascii?Q?Pb5/mIFVzetlPUQe+e5ok7o2/0034S+cDMbpedFaT8/CtOzfvGyYsPyl3NkI?=
 =?us-ascii?Q?k8eGfer/Zw335CgD5LC1M2RB4ElX79t7D9UWlao/XvBo4re+m+fea+qJGhm+?=
 =?us-ascii?Q?R0fqP/4COZMm/5OYxztNVZL7kggWso3mtSk376zV0yukpIDYpCCfp8FIipSq?=
 =?us-ascii?Q?HAuk/MUd6E8DutY7/LEdfSrMLFyYApyrKB6Vi7x/FI9hu0vSfzpwWPrEgRK9?=
 =?us-ascii?Q?ERPN1DSmAmHcVp8qsPpO2WvcLxBGg1GZdsmPSeNseafVcO1mGJAm5M12yIv7?=
 =?us-ascii?Q?5DOgk2b+RXNx2xjWZc92ma2nt1T8koQKjAjfkWkuDayaTSObtlsldCcvkYyW?=
 =?us-ascii?Q?Tf9MOme/hJFcLfeHBj8oG/W1S/2ohBtN/399+4PNSPhpP8Cue508WbWTqPVY?=
 =?us-ascii?Q?Ci1fKoMoYiWvkc4Kx8k3lecBZZiI7zomLT8VNAfas/Pw3nZp2TFiiQO1ijDV?=
 =?us-ascii?Q?4pcqspME0do3b6rYGnme04T2qUJll56i3f5sKhGV14BDYhKwbPiC+a/khjLg?=
 =?us-ascii?Q?JBP7v93CAfJ1Ds7XUwxOg9K0qjK4SXKH23U6b0os5ij0WJ8u8HUVjcMB3czr?=
 =?us-ascii?Q?WnLHZxfZZc6sr1v1PKcp7uebbdWZN1+bzXCjReXW+ID/wk4DyblAiVjsf5Ty?=
 =?us-ascii?Q?vHEr8f1i70gV46mp3RCrS5VGI3ZN53VF+h4Sd7ThtB6zvDG5DZtend2iJWKc?=
 =?us-ascii?Q?+ViBc3YDTS9rmkDgAOTGZItD7WMLOQ+lNzqVZ2RdifFNiYUnCWqE9GF+UZv5?=
 =?us-ascii?Q?WMo9gTO6wHTHbhtuHd6Rbaw/b0Bm/zMcOlNcoJ9NyjKVTGjIR5KXWRpte7gE?=
 =?us-ascii?Q?fdnS2gvE0nLwa9/ld2KM2K4M/mMVYIaZHadl0yHNzqQdUueOjQtRC8d6y3H0?=
 =?us-ascii?Q?STmC2dw+bqRaC+dhxDLT2CunSQYT+4c+B29v/dhtsf6EuVc+Gfxgln3bwbDN?=
 =?us-ascii?Q?KmvRXqyAwe2zvkoyXzwtctMIVQKgDG14tFeeg4hM5LGeDxtw7HEuNHCtodkQ?=
 =?us-ascii?Q?NvUuPHG/oTbNhDND3Flckq41uFF7UeRkpVFG4G+EAjSGkw7SDk0f1UqNggC+?=
 =?us-ascii?Q?xH4I21hSYIRUKQXQ9kkz6/yS7gzO1xafnX9woMry?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945a35f8-1265-4498-c76b-08dc3a0fca45
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 16:51:07.3304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vwx2JAykdTtsPwQFgYDAzZ83nYHcqRU5BgsnCLJnFlJd+6xhaTK6kaRuW0GDbJehA+Wu9qER02BtPykVMPWQ/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10134

On Fri, Mar 01, 2024 at 04:06:35PM +0000, Conor Dooley wrote:
> On Thu, Feb 29, 2024 at 02:31:20PM -0500, Frank Li wrote:
> > On Thu, Feb 29, 2024 at 06:55:58PM +0000, Conor Dooley wrote:
> > > On Tue, Feb 27, 2024 at 03:54:11PM -0500, Frank Li wrote:
> > > > Some sai only connect one direction. So allow only "rx" or "tx" for
> > > > dma-names.
> > > 
> > > Which sai? Can you restrict this per compatible please, so that someone
> > > cannot add 2 dmas for ones where only the tx is supported.
> > 
> > SAI is exact the same. Only external connect one dma channel.
> 
> Right. The wording made it sound like some SAIs were capable of this and
> some were not, but what you actually mean is that all SAIs can sometimes
> be connected in only one direction.

IP is the same, just some instance only connect one direction dma. for
example there are 6 sai instance in SOC. sai0, ... sai4 have both rx and
tx. sai5 only connect tx. 





