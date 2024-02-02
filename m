Return-Path: <linux-kernel+bounces-50665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF30F847C4F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 858F0284486
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588A0126F00;
	Fri,  2 Feb 2024 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="px/MNSOk"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F068060E;
	Fri,  2 Feb 2024 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912921; cv=fail; b=SqYgNjQKZjLCzkCfGr0vOqCCicZGQrwI/CCqHG+4GG86Vw3LzByJyy1sm4CPVz/Rpt5xswz1b5mZO+XDHYKA1CUti30+rUwVr/oKptI9I+M+r3VRa/ZAIe7hog9vJ7p9wRAiBaHZ/NOguBHFwqIngprIIxehlBl2rUFnJYs6Y3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912921; c=relaxed/simple;
	bh=9DuXswhwfG1WFQ/F9cV8cAm0qYnZJhicZJr9WLDPqxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pGE1FNW06PoVE4xBz9fabpK0/2EfGLJGhXwcHHBfh+ue1r/qOWulC5hVHGO7hqWTdSc25+e06Ae51JjHBbh9FO+HeWMgQlJJ2hg53LkSaFWLa2//m4+nAOVPUZGb/iHwALU77AaJs3gNyH9CwKCSNSVY1JsIv3qqtsG8+ZsVB5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=px/MNSOk; arc=fail smtp.client-ip=40.107.8.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjZZ8OkOapOrW0I+FNoK9vWRJyc2jeYJN1MZxAKxjHwi2ATyvkgXhMZKHLLzl/v6WL23uxfBLHcGmWawudyQdD8s5urVgxwuDN5HsQFLhj76SlhHUUij+FK2xcz5IBp0cTyfHfy9vi/K5djgwXZDBfc8c9SqW3IlljiT7zUqaX+6EGcyqsRATTUw86WGRdCc9Qb+8T9zvD6NlNMytIp22dyabA7iuI3ghdfdI7zoTmEvZLoIAaXOidPalBTRU9HA19cN5ZLImQMSZSnsSAs3ut/A09auxuFUx6uLJvueGeqeptx/XujCa5W90GXzJ62j2mwdHSAlA2b1LjkpFevzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHCXIc/KQJoPsJCuWRAMtN461mRFkX4g59TouOMoiv0=;
 b=X7O2A4y0hULn+Qn2BjglBOzGg95uS4Y9zpKnjORZct6XSxT61k+0jBlOxLDQGLQfUcUliuoiSQQGJUXCsuuvoZA6T2lba/LMwWZaoriuRbirYUnb75ToGsIwMLpPXOF2rOoXsMMHyBJ6Oo88KocrgdrXyatjZn7Wu7vILWxF/NXKpC8EZZ1FDMybhZu6b+lk/CgjC1y1DihPRhwaNJrIpbR7grgwxgKE/6TrhHyoBCZZxGNscL4gcWqcwb7TqbQwBM7kdKFJKio3rckd7WMh4q3zm/J1RXZUqz67GhxXlm0MAwKkh5x0rAqbroOJxLx/JTcIKO7AJyOyCzB1Cd9AWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHCXIc/KQJoPsJCuWRAMtN461mRFkX4g59TouOMoiv0=;
 b=px/MNSOkTAv60kInLKDoJnEC3JURumWuYIKOghT5SXMBVCSQWa+aiuj/axfQKjkjQSh2QBM+aizySJ0LF/E2BxcSGO04k+R19gHNtM2XqBOilViD4pw6m9yGezYE3iY4BbOOwfUlMm4Ak7H0CV4HNKbSZMp2PgeGCcdStMUgwzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8377.eurprd04.prod.outlook.com (2603:10a6:10:25c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Fri, 2 Feb
 2024 22:28:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 22:28:36 +0000
Date: Fri, 2 Feb 2024 17:28:26 -0500
From: Frank Li <Frank.li@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <Zb1sijexWGLG5gcH@lizhi-Precision-Tower-5810>
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
 <20240202110511.135d26b7@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202110511.135d26b7@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0347.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d2a845-7bc1-4d49-257b-08dc243e4c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zRT1Eg2DsesQLPu/AgNvYUKECE2uPMmlWkJI2Xyo87ncEi9DMCETq+GGIkpPRtnW/4eFUGJSDF8MqmjzBL4pm7ryT3CopZqeOvCaZ2fkJGzFkxl7zjv6ORm1TvKfN5HCYo5NJRbmB52ASes062pmtTZGNlmCbDtPP37o72bniYyw5E7SD22ppKsuD9bPMo57sUiQzOVy76HMEPNdq5blnJ2CbWjcep6/33gEzc0U3vc/yNanoEdk+e4pkz2o1WYmGXT7JVw6/FAfvGCAwTjcwuIYe88mYL79cnWYMoEEFPwgZRcKBg6Jt5K0iMu9T7z1+DgxqfRVvVgrvrOwQafNZCaN724TL4+agOvFKc+1luXOrK9mkzSzXTv7a3EhmI2+txLyq6wF6gJRnGOTgpt2p4AYdcs4JIfoy3WZCjqtG4clSEnbhdKw2I1p94FS2J/6oGp6UX9GIboWc+3+yQQ+llC5ASkSbyVWIKbiDDY/ppRwdS/bVdxWIkOJc46Y/NtuRorKURGDvthBUNApuqaj7H8ePNQ9nakPJSu7FTBGrD2B9eR1eUYaKICCljCuiu6NKqVa0tS5ixtR2APCKsdIRIoNDdSajhAJmbfCeroW8pvBy8ygdCSLI01bTfOIEEkc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(38350700005)(52116002)(6506007)(478600001)(4744005)(7416002)(38100700002)(66476007)(6916009)(54906003)(316002)(8676002)(4326008)(8936002)(66556008)(66946007)(5660300002)(2906002)(83380400001)(86362001)(26005)(33716001)(9686003)(6512007)(6486002)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fvbjC1RQbAOfy13o2ZMs8RPa6pzHGrWZvcnsER/gCgnHXZIEnAyNDd8Bmkz3?=
 =?us-ascii?Q?gyn2zshTqUZ+NvRS+Y/tjV+5/9N78oNiJvAD5m9qs2LZBJUsGdIC6dMPUTmB?=
 =?us-ascii?Q?enpIGeWq+c9SReTaDH2DcllDBv1YDiadFtZbcHKA0y1jf4zwJKi0w36oD1MG?=
 =?us-ascii?Q?HBcBXi6Kt3LiuomKF/XobCkNAgCoutLpcBrXy7VU33cUnXzZkBl02vP5eizx?=
 =?us-ascii?Q?+ID0EXA6+lT4D7ENbXlR9yllhBSUA3NwylRLIrXMyTsL5lslgw15WARrdflg?=
 =?us-ascii?Q?TSGFR+tnJk4Un6fPLf5vsk024nCs+uDQVdmZnCTjKhyWvKLKvyfNVd0fh3pS?=
 =?us-ascii?Q?F3erhBPEh7AfpVbvnoGax0/SNaEfIXusUqKgvwtkNUHIPK7+YCv56VDFDZn3?=
 =?us-ascii?Q?QpnLCz79xQW34/x55zn9A5FPuxLEHnolrcXOAtY5agqVRQQQA52mcoPrdZO/?=
 =?us-ascii?Q?kiRw9IFma/5QqyU85C703KNfo8qD8Ihh/R+xF20T8gWbtN8ZThaUMCv7VJ+d?=
 =?us-ascii?Q?C0fpYTX1v44S56BGF3PpjsmnYfdURm+jCw1It5bf97iQyXEYqoBSP3x+jDR7?=
 =?us-ascii?Q?E/3xCXRxBP1Gq99wAHHt8OVFO6kA/nEku0YFa75K8hym6uMOLFklqB/Z0jjT?=
 =?us-ascii?Q?5U2GySfaORl7aTqITIgmgv/BxYPqYuMX2AbUK1OiUBLsT5XjM2bYB2GKwwhg?=
 =?us-ascii?Q?aWBCvrIghecMhNFAWlYYf2IrNqbG258qV9p+bnC6Fnj5b5IiFHYQPnyaB94T?=
 =?us-ascii?Q?nRSA473wC9U09j2/RomXF0nUAIsrGtSPsDaQ829vfFycRx7A0c1fue8fFet6?=
 =?us-ascii?Q?LCdmtbn9o/gkq5OMOP+Au0Rqt1Qw1SbZYV9O9bcaudiLO4FTS85Hzt69YwAg?=
 =?us-ascii?Q?MjDguxxMER19Ki1bKN7HQIWp44pyiIwOO4cv1nZEVeHW99lz3t4UjDCC5jEG?=
 =?us-ascii?Q?R71kVQA6wAiSgf6z99T0SOfD1MyP/0uROb4V/gKGoC6RP/1N+mNZKByjn0Ex?=
 =?us-ascii?Q?PS20lLbgdP4tDXMywjYp0jE9WvkyUHQnEaGYghBKaQD+QZszR8f0U1pSPzgl?=
 =?us-ascii?Q?P1PyuAxT0RNtZqR8vTknrfb+2EN6nzl49T2xwhbo3nzgxBNVHdzLy2iZKEfR?=
 =?us-ascii?Q?TsdxCVCOe+z5x5aE/pmjqu/Rb7TLVUouPZEqpO8nY//zCCqE887Uv7A7gcpx?=
 =?us-ascii?Q?rQOyZnv5OHXC5dGYEnmvzfP/3yAE8DST0U0j5d2AE7Jo23oaEq+8pmtCRyHS?=
 =?us-ascii?Q?ANYTiYhmbR17VjVpnJJdhZuNryNpSfYBmtpyJZhYytGMPbMZaP4dxXY9IWD9?=
 =?us-ascii?Q?ZEfAo3SMXrLCenuD6FMrhpB3BAn1mI5JajizOggPBg5ZIISl6K64J76P9vXt?=
 =?us-ascii?Q?cUQJrGkmo8PKCwR3Jpubd3Bc3aNIchagipNi6xWFeauSuYpR65hdggXjQGky?=
 =?us-ascii?Q?HIEznfqOQhJgBgHPAMkU/7ZaYcA50Yh1GVd+KdHvrU/lCTqxaDe+ab5jKzmZ?=
 =?us-ascii?Q?M0KMiZP2zcp1x6GdHMQM9CWqAZijl2rwF64jGD48w52OUwhdliTq2kNGInsR?=
 =?us-ascii?Q?W3SoZZ8JqdAUHrJTOUpdYXiTeoUBHml2LyVAw7xz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d2a845-7bc1-4d49-257b-08dc243e4c27
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 22:28:36.5148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKMhgkZB8/3nw+OVdEmJLAyocOYvqP0GO92hpZw8IUpngnl/R0DYs7mr2LO79scj7z3H2sRM/PBpA1ERbpvY2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8377

On Fri, Feb 02, 2024 at 11:05:11AM -0800, Jakub Kicinski wrote:
> On Thu, 01 Feb 2024 15:22:40 -0500 Frank Li wrote:
> >       dt-bindings: mmc: fsl-imx-esdhc: add iommus property
> >       dt-bindings: net: fec: add iommus property
> >       arm64: dts: imx8qm: add smmu node
> >       arm64: dts: imx8qm: add smmu stream id information
> > 
> >  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     |  3 ++
> >  Documentation/devicetree/bindings/net/fsl,fec.yaml |  3 ++
> >  arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi  |  6 ++++
> >  arch/arm64/boot/dts/freescale/imx8qm.dtsi          | 41 ++++++++++++++++++++++
> 
> Any preference on whether all these go via a platform tree,
> or should we pick up the net patch to netdev? I guess taking
> the DTB via netdev would be the usual way to handle this?

Supposed dt-bindings go through netdev tree.

without dt-bindings, just DTB_CHECK warning. No strict dependence
relationship between dt-bindings doc and dts file. 

Frank

