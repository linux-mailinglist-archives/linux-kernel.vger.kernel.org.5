Return-Path: <linux-kernel+bounces-53879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EF884A791
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D982E28C5F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C6E86AFC;
	Mon,  5 Feb 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P4SZOdta"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419B64C3B3;
	Mon,  5 Feb 2024 19:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162952; cv=fail; b=JSKqwL49HdFO1KlxpA7/mfNbVuLFKKzS722ybCyoWp3dHRgkhtqrj0qxsZ/N16S9pIWt+hP9+VOJl5W6G0waYMKo/oZZKM4Q5bf718k77mDz8sj3lb+blx6gZS0b5+bi94FBAWfkLGINhtPnlzlxhdKiq9sfv8LJVgXpmt26ab4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162952; c=relaxed/simple;
	bh=Buo9G87rd0hX4tbDxNVJEAXOUugZJfT0XhbLd4z8m8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OPVASVPXeQY9pDTQGWkHJ6tF17XjeOh6D2jYZekBWOlBGhTSDx81WjsFLfhs6g6Y9939lWlyD+/h5Tbf33ghrTDRhrOANwaYjArVD03t4CafnAWBhyqOrcCsbEylcFhm/0NMT7eVEvimLuhkXpFcAtNQ4tUEVyZbVzNWVUUMZMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=P4SZOdta; arc=fail smtp.client-ip=40.107.15.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Csv7X54mOvTV+1iXQBZ29enWlTQaofV1iPBNhLiHdTJzk75TOa70CPT3xgtUc8jpszsWLa718f44ERKEoS70xaJzDnFlukcUaL/NBB016y22ZSpPYVFx+FvTTCv3gNQnCIIGshtZ/iMcLyXnN2ziwW0PKrFkF7iD0RXLgyj8S3fj1YKw9xSB+MAIsoZE0i2bxH0cY8h26rJjGwXcIY6H2uKosUXJtAddkxm0EPiHYFwyW+S1UEBAFOUd3nFpXZuBdRMKbkeB95357nYIPM6M8T16XLDnoRUozrGZCla8Uo9hEYkEZQqfoLqR3/1Z4QziqQdAdhWu4ImKWNzrwF5J9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmaz2w0WM+vxsKD+QN2iz79OLzk6f8FY0BU2IVIiaI8=;
 b=dlK13yq3C+JSPKBmhtesHJYKTF/u0Uebg2QcvDXhgMfiDbTm6Am2iKxMueOc9ri8e1GyeDD9HHE/xpyEoVFtEPm2d7+3mhQFoo1rPXl1MFUK90EGwlbD5oQ9Lmz8h6r0K5KuQn/vkRxklQDb+C75mZ03qsYC4vLRDQ44bEayjxBL4wg+IwOJ1XVDGSiT6KShFNoXrrBn4WxTKI0DJm9qi7Lw604lnzcW610NYqYyc6jaQLkBsJf0X8Z5s4mgrdZJCf2zOHddeh7vrdvtblNGiYiYHL7kXDMAMij+xkXmAP0uys9Jd7Ie3CFMlgKrszzk38sFgoF2hJIn0lHW9TxZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmaz2w0WM+vxsKD+QN2iz79OLzk6f8FY0BU2IVIiaI8=;
 b=P4SZOdtaq+4W/QiR4xyxzCnf6phzTYslB+Xioh1Q938LfcvTdnbEu627p9xPijvxvyeVXT3qTETSgwWYsDAB8lEIzXg67Zk+y9wm8Z8YDcFQ1knuGcGJkUZrLbUCZrMGDnPt6Xq+2a8ZzKSoGFS0ESPBtAxyIgbf3xAowEjJ9mM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9783.eurprd04.prod.outlook.com (2603:10a6:10:4b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 19:55:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 19:55:47 +0000
Date: Mon, 5 Feb 2024 14:55:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 0/4] Add 8qm SMMU information
Message-ID: <ZcE9OQ5Vu3nPP0Vc@lizhi-Precision-Tower-5810>
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
 <20240202110511.135d26b7@kernel.org>
 <Zb1sijexWGLG5gcH@lizhi-Precision-Tower-5810>
 <65097032-74d4-4617-8ef6-e1f76b41cce6@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65097032-74d4-4617-8ef6-e1f76b41cce6@linaro.org>
X-ClientProxiedBy: BYAPR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:a03:100::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9783:EE_
X-MS-Office365-Filtering-Correlation-Id: 81d94bb3-4416-45af-b3f6-08dc26847215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5MWnlUNE5upPpG2nUx3KJBs6PhFGqKfL84/Uro9LekB3r9j1eJ+79IMAUWE3aMp/0h0tC+VZ/9YAWNdNka2M6LUGmmohaxArIRTec0S2XH9yfd58PQz7rwgzUdVzI9qCjdJvRq7gjCyz7vQKkFRjmNI0vnx0gYrYZMM0x+2s6KvEU+aA72xg2Ufc7NpdoEU0WHZf2wfuzIhPVFTVQup5ew5UdR1Mac1dbgxXWI0/C3Bl9uvDPgDYfyUvQDG5ItAxoF60ePM6zX/hJs4ntTgyvPNQTdaumlBCOf5aen64Pn3t0GJnRHlihuW3KTxQTAz/F3ZwsDObwcUVn5osf3XA3JnQ8ClGXTekZXg4/J+Zt6oao4uC7C16D7DoQfiIQTgDdTp7GEsNxws5lOmyQLw1MXzSMWHls+6Sd1dKcyQBBALbhp+kaTH728sz3SOhV4eg1y9aFnbKM/DNWn2ATYbgdSXlQf+qWghRE2p6WAS7ZLL7vnel80NTQhYpdhKh3dx2k9fe9tY1vz4vxeVxIhIx2rp6rFD3Vbya0caZJTLJB7xSLBkU7sS9eWgS1X4i+Q+6PmY+WmdqPqLXn7qXLInU8zWxTW1zYIzuu/d/0W4Se3w8u4sBAh2MtkEOQ5x1mwhe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(7416002)(86362001)(6916009)(316002)(66476007)(54906003)(66556008)(66946007)(4326008)(8676002)(8936002)(478600001)(6486002)(5660300002)(2906002)(26005)(6512007)(9686003)(6666004)(52116002)(83380400001)(53546011)(6506007)(38100700002)(38350700005)(33716001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NgIV8meOSYxIePEcZ+D2GdV/kqDcQ8zRElTfuWS6UEwk5gnk2isUrbEBYNy3?=
 =?us-ascii?Q?zUoHNSvKlQg04Ja24dQjJNckWPl16un9P2gQTF72rsobV31sclSYIXxVZCxY?=
 =?us-ascii?Q?zcLwfql57yaAqvWmoAdULgiywIJrrIjge9QBHzryZhQJs0kTEQe2L4UFqdZ8?=
 =?us-ascii?Q?tIwTxF3Eoi4QY/vucvxu8sGR6R8NuO6t8Aofv4W6SozeWzKZ8V+GxhZN/8el?=
 =?us-ascii?Q?LZogR63CdFvTpAeCtGGlLVP0row8BRIjOoQoM1CrHelMOYuJ8kPfZLr0vWaV?=
 =?us-ascii?Q?AVt6/aWQ75wKG5oaaJsDdbLTg1bkSRFMZycPE5bS2bYOP37bWXUZznoJbDtL?=
 =?us-ascii?Q?s9zBGZc128LI/sQMyw1y96uf7lrNcS9GzFSlF3vdnvCgGZSKvCq6vOfkAo0c?=
 =?us-ascii?Q?WZojGB+IjuxLWS3plouNo1hn53CiYIqhuqxLnf1hqmEOwNyHI4d1TGdZP50l?=
 =?us-ascii?Q?qziV3Ml9LLEWm2d5x+B4qXcX5EeMwRbaZygYMbWyunmSotvck/pwggqG18bk?=
 =?us-ascii?Q?PliceIP6ZmdcLMmcnUBGVRqpOQRCpxIN4pC5AlIPg/m5iQHFZOS8pt6xDKHg?=
 =?us-ascii?Q?VVJU7netVxUrVhiIf+fstTgzkQTgxXEOpProwmOWDYJZeBWwAaadHoeIUtQ6?=
 =?us-ascii?Q?VXmvxiUhODqbsIgQV5gwHVpSC90PePeSIEZlyL6FaKOenduX9bWC2Jijs4aU?=
 =?us-ascii?Q?tBxdKXW7O+PYrb1XV4DCD1QeTxatVNaW5ySAPzsWJKdprZSoKFxp2OQii4Cl?=
 =?us-ascii?Q?6UgjrmBgRYyr7qI0DaLMQSW7gNkNvUXCwrZCC8U+Avdc8HJsLlbwJUAbCsba?=
 =?us-ascii?Q?LeS034cScPgcoor0yVYdhlp6F2fTZpRBPiSE34f53G77UOyx9eWLTXKyPfK3?=
 =?us-ascii?Q?3z71DqImftAebgqoj54wZ54R3XFdCgp89ImMlQAYMu4NUws+7s1n+oRyIB9B?=
 =?us-ascii?Q?DKQGerLFdjtxi9uJ7NHvPlhFJbzl3ZGB8NrNV47HB9XzO8a193SjCfcQjlN4?=
 =?us-ascii?Q?rUuJIGptw4S9hyuuYLgzDQOraJj1jCIEtX1UCI4DvnuykN+ZMxx59e78WTuj?=
 =?us-ascii?Q?ZNFmoh+H6sS5hRbtlAJICe7aTLi8opPdlFPRhmJkMRmhnlGECaeKGJ3qH4hl?=
 =?us-ascii?Q?7mcX7oVHPUb21I1Q1fOV6Id8/tkLQ8Yvx5RnIxhZ8zYig9XG8+RIsPixhczL?=
 =?us-ascii?Q?wI8Y2TL0whIjdqLhC3UeYSrZ9qgy42Fmbl5D/ZBBTMs9rysTS3bHGR9BjVZe?=
 =?us-ascii?Q?v98c7tm5MAih6eifmUbFTsMy8PEUyNFOiOvB1HiCoEgNv/VXWRFjewv04gfG?=
 =?us-ascii?Q?F63r0Jwfu3T0TaxB1CHfUidvHka4OnIFo5GWkrFhf7/py6kof9Ddrp8jrhx4?=
 =?us-ascii?Q?j571fH07oiF2WAR5Z67ibvaAK54KVGlzod+CPyGB5Wp+iZeRt+Add0ofIEV8?=
 =?us-ascii?Q?+00dwTXsSl88I8ADTiugMsmYob0pCMl/xs+KJj/bKwKboWvD5CXxsMxHGoBc?=
 =?us-ascii?Q?RXzr4BCYyIR+spcTutE8hTcElNKVOHCyyuW8qQ11ZPGESupiNzbVqnuqhxtm?=
 =?us-ascii?Q?Rh95Qd3wkfzrQyT2Pqlff6PbREy3Z6vTfVZpoNbO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d94bb3-4416-45af-b3f6-08dc26847215
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 19:55:47.2479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DHapDdbvYTgl+FywBlrritrOXkWjn/3YXRWEGuXsLLaQyr/GoBo8NWFfcwfY68aYn1/3kn2lYnoneDtnLFgGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9783

On Mon, Feb 05, 2024 at 10:25:46AM +0100, Krzysztof Kozlowski wrote:
> On 02/02/2024 23:28, Frank Li wrote:
> > On Fri, Feb 02, 2024 at 11:05:11AM -0800, Jakub Kicinski wrote:
> >> On Thu, 01 Feb 2024 15:22:40 -0500 Frank Li wrote:
> >>>       dt-bindings: mmc: fsl-imx-esdhc: add iommus property
> >>>       dt-bindings: net: fec: add iommus property
> >>>       arm64: dts: imx8qm: add smmu node
> >>>       arm64: dts: imx8qm: add smmu stream id information
> >>>
> >>>  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |  3 ++
> >>>  Documentation/devicetree/bindings/net/fsl,fec.yaml |  3 ++
> >>>  arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi  |  6 ++++
> >>>  arch/arm64/boot/dts/freescale/imx8qm.dtsi          | 41 ++++++++++++++++++++++
> >>
> >> Any preference on whether all these go via a platform tree,
> >> or should we pick up the net patch to netdev? I guess taking
> >> the DTB via netdev would be the usual way to handle this?
> > 
> > Supposed dt-bindings go through netdev tree.
> > 
> > without dt-bindings, just DTB_CHECK warning. No strict dependence
> > relationship between dt-bindings doc and dts file. 
> 
> Please make it easier for maintainers and sent entirely independent
> patches for different subsystems in SEPARATE patchsets.
> 
> There is no dependency here between anything. Combining it, OTOH, brings
> the questions about such dependency and makes it a bit more difficult to
> apply for each maintainer.

Understand, but without dts change, it is not easy to understand why need
change dt-binding files.

Frank

> 
> Best regards,
> Krzysztof
> 

