Return-Path: <linux-kernel+bounces-90865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B52F4870642
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C1AEB2D18D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6485652F85;
	Mon,  4 Mar 2024 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JOj3IStA"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD60481D1;
	Mon,  4 Mar 2024 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566791; cv=fail; b=m+PL9t15wVGZysaqien5HB6zDoUmS+0pZTWDOjC8rFAwo9Qr9ev89wzP9lsYP91LHKZw2rUdyTCKcVFcGRyCUhUJ02IwTPfMlnIPEMuiH51Eh67b9objbSEq55140falPXdy59lZMHIEddlhgowbXVoGuDyNQBYFxckTR0ku1LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566791; c=relaxed/simple;
	bh=3M3lYfzGMgEcTEnlPQaNwcyvGXRI1fT9ehuDMVvmplA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pKYaGzsJ+zch66CE5cLDD8Jl/HnssvRnEFCOaEI31VlfdaqcKasufSzqRKGITIcOSIkRlHh/N3wpWOOW0Yre0i9cpybuThRWkeJo5avHnNrPSUvtRxO1q1NSk+W7afMvt15BqoWAYsE/3vIdZmGGt6grif/g4k7q9MG2+1VzwR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JOj3IStA; arc=fail smtp.client-ip=40.107.21.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQjoK/mvK70GtnB6Ud3CSrSuzZTHLkwvGxUgxYDbSeLmMEo8ZUDGjCAVu+6+DHOD9/XplaVnexwTsJy8vgY8QLQs9LmlOVPZwmaRvkqlJgKb2p9kTOf0gkAMejM7KW5uOIrMAlkSbrFnYL6tzT/7WiWWPCeig1W/6vebJbEc+naqKS7C0KYrnCZnBMirOGjy3+uHVN8m6l6saVWEKTdWRLogXGKVDZbNF+86DA/I8r06iOwvK8lCjMTmcvPAStW+Las/Znk4WNwRRdw+SPbPKNZI/whEVtXfYEq9dzMjAhDSSY66ldlWAZrgQxm8AwRrdXodOEzxddXbfGcmrQ8f5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lyjTYHyoTftkZdSSQCPgV5jjmYiMgEWHXa31ebmg0g=;
 b=TWKZWulzszcHgtpPDQ/eXsPbuQ4Y27L79lzcU6mIO3r+HFUr6TH3oJue1x3eGR6pMwAWxl+bXaBwXhF+kHM/wYk7afM4WmuQAWnbrDAQ8f4hDVrx/cQfi4Ok9KHvNPJo7P5u59lA9H5GvxMaL38hNrnyfXdDOG7B6304bWOOWoAXQy8dT1ElEDs2Co4IBZciTR+OnrqV1Sv8wbeHj+ICRhfsTHPc3lyYVaOeeTHGqH9MudEQzcXO/+Gd6dpw6xparruhdad8yBbzFrVO6IIGmSw+5qEEDf8fsb619MtllvNz0b17itVSboONTTh7lTmzk0K9zHH3lJdku/z55Lx1Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lyjTYHyoTftkZdSSQCPgV5jjmYiMgEWHXa31ebmg0g=;
 b=JOj3IStAMlEGcVeQNhQFjSgHmfR/S9lrd5GV/vcUAtp+SEuuFw83e8egk3PC/PYco+OI3137OGRMffPw/XAaxRH4qHlX69IEV3DuuQUIxNndupl6P8z+4QJBzK8DYLX2Jx/XVEeRRrdikPJzhNIm74oFzyojjdn5h6WWPu3vIu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8919.eurprd04.prod.outlook.com (2603:10a6:10:2e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 4 Mar
 2024 15:39:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 15:39:46 +0000
Date: Mon, 4 Mar 2024 10:39:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
Subject: Re: [PATCH v3 1/4] ASoC: dt-bindings: fsl,imx-asrc/spdif: Add
 power-domains requirement
Message-ID: <ZeXrOezAWy85IxJL@lizhi-Precision-Tower-5810>
References: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
 <20240228-asrc_8qxp-v3-1-d4d5935fd3aa@nxp.com>
 <f8ce39e9-7f06-49e7-92fa-785bd1cd2d1e@linaro.org>
 <ZeFTDSuLEeYrsbKi@lizhi-Precision-Tower-5810>
 <0cc8a370-4497-40f5-9040-1584c0c777f9@linaro.org>
 <ZeH3UhbStCTh04Ku@lizhi-Precision-Tower-5810>
 <7925ce69-0cc6-45cb-851e-75a9f19f883b@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7925ce69-0cc6-45cb-851e-75a9f19f883b@linaro.org>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4fd5ba-bedd-4b97-82dc-08dc3c61519a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E7tssP6o9u/a9W2OYjWuOqWlCDC4hWTACCTZd4VtdqrJB6xufv94dmEz0l7+VXTjydvGI7+hc260k48qm0RXAvcngbxEva8tb/fTJwyBj7p6DIaluV7Y31V7RO9MkYIAmTAleriffVC0keu3UypA3y1jkaacKDdcfehM3wwPjaPN66ioIQbWQPhvEUzRrCs9u/8dt3VZl+iLq4GwCG1TlEc+qOsQ8kzG5Wm+LlcWFJ8IQySJbpnLCX2aPAC+eVJFMZiZw77Fcr+w/tm4bNvNdBTvueyJ4Bb7uuZk9NDmNeitYlvD7bEl4m939CMYukZIOnVZ0S3HPkAuXksoGw6f0NhxB+JEYQxlls6tOA6eF/FR6GX9NMYY4DNq+VbPRTwrupGE4hD7aNpP5pMefbJ8DVbdcILHV8I6JQIahWJaKGN+wESVfa/Ay40fRsPlHPGEMxzoEqV3QJBIq8FCxo08qweaW+KNu+x+4qI6u238doadoRNkKvjntUi39CC56YoVYK1F5Ga4vMFbfHchbgRCIFs/ImhsQumuizqrzcUEUZAMJBfTeqwij+W5m9EKv/fIxvL3ZULQNFhlJQWkrLzpYg3nACIqF+LQhBuQmoD7jrw9zD2vDjOaW87sW6TpvC9PR5Hp7KFzeDmdQ9PC+HOQ7t41niA5YmZ45zqFS7aQaJzngeaCYadyXnaRtd8qYRD6xdTiEsVr99P2tNkxMnVZQJ8tpoHlciUVa4X9MnLJYLs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YzoGjkUKLJj2aRoSg/7GCP41ryDnQa7W5wq1UbmT/6eAL9VI3ljeiI9Lj2N8?=
 =?us-ascii?Q?mbcP/cNmLGe0dda5QzVvAZO5gljKXPmhn+z653T8p/3jtunqkzTy81EKOPK3?=
 =?us-ascii?Q?/ECMwXct3+VG9A9mQM5Lr4vQCn2o0X05fheQuubxkSgXJ8cYVAfunDNW875N?=
 =?us-ascii?Q?9zKHmAJS2k889LQPoBLo6VQOyQHMhFHXb3H3sd9ZoMpe4lELzlgLbaqVP/e+?=
 =?us-ascii?Q?HpZQhyDFHqHq3fI2QFLa+3LHHwzsFgi9KBJq/mhPIBNJhpL6Qlpbrm3MGHkF?=
 =?us-ascii?Q?1qF/VnyPTvCpeenPfEBco6aaOTn0h+D+BaayKHEHp3y+003IzVXGohwY4H0I?=
 =?us-ascii?Q?l69y8zLjYtmXTsnig/tlnfTbDfDL3rj32F/58pDl7rff6DNpqwi0DuHbfWZm?=
 =?us-ascii?Q?CJce2vokXEw5XNMN/3+ZHs+Toz/4F7A+rj+IAdt0Klz+XEgi+dV45IafvZ1F?=
 =?us-ascii?Q?OSfHdmHATrxqIJM25IFipOH3AyzWj7A1xJK8n0ggFDiPdda9TwYmwnMjGZ1Z?=
 =?us-ascii?Q?V7BnMgh35y65Lsgz6EpiCjNZPghIBL01EBc/R6urP5RBTbDp98IW3KXLpVvq?=
 =?us-ascii?Q?Fn48QgJ9rxnRZdkBJtrrRjiJIgkJlEg0Tv7Hli6h9FzGUDpl/UZwlki4Vyuu?=
 =?us-ascii?Q?W+fKdfpOq6JML2cDtIy/qEREsV37xT1IgrsQbXb092IRzrZ3jV5rZSBDwnqB?=
 =?us-ascii?Q?pgO+4kYBYP50WeLgLKUQto76ZAU/hf+o7yMTfbk0jIwaZAXnY6gnW6B7r3SJ?=
 =?us-ascii?Q?v+9n45Vmahd2yeYsmJDxvKwIKUM0OTaXib9+sj/kq2TUEYJSjFtsgvM1xJbW?=
 =?us-ascii?Q?GbpEJEsjFmI3lLY8vbxyJS2GKaBvV541fKemSW6EbAtRRLIhqD3pQOoUJQ5L?=
 =?us-ascii?Q?6sI7JbU09Y7tbkqJbyRBVy5QT9T03hNk8lqv7jfnbf9mRuL56HD3dRclfqdO?=
 =?us-ascii?Q?ApbtWk0OBSdMzOL5ecRyURH9IUafdlM0QT1JdcewEw9J/FG7+fngWr4c65Gm?=
 =?us-ascii?Q?IYOYr/hhHtq5VLV4/IcwtY/BrBJ6siW+EGkV2DgOMCkFX1fe4UqROCHI0kvD?=
 =?us-ascii?Q?Y4kFl56/2rnbf9T+jilkYyt5388reFfjeb6tvh69CNQygNRQWB6d9xhXUpPi?=
 =?us-ascii?Q?oyn5nu6IE0CqTCLsd4SjKhYVgsWaZievV0IGgOh7aTXrcKCwoaz2VQicsD7M?=
 =?us-ascii?Q?SG77WBLWxXWvuPA3gwkDYqPvXhuN0dcJaMcjpcrI+WaI1ozH1x2aOS0mx+nt?=
 =?us-ascii?Q?a/VLswkfqenlPupI0h5L7lGIcEeo0uWMKNku8oR4teYMZDJZR3g+FFje00D+?=
 =?us-ascii?Q?7MYCQxYtqyE2V1MANyeQwPfCYXNENQi3awyQYLVQ9CFA1rma4ABBpEsXcoTt?=
 =?us-ascii?Q?QqhJTUFl76UavJaJcITI6Yv90n2fbNoFgu8HIexC6dI0m9KtCuGgNL49U7YX?=
 =?us-ascii?Q?bfpBsaRFGVy8uaKehfuLoyfClDQFl7JD2NG2V9THueBoPTa+wgFeTHWpPVv+?=
 =?us-ascii?Q?R9R4nxuX6G45m5zJd+aJuDg0Ocy3sDIssyddmihOU/mb7h7bhqtacwzQDrIG?=
 =?us-ascii?Q?pXHJXnRgLOHDp88hZ1D5Lkuh8O4K5kzAN63z+a/A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4fd5ba-bedd-4b97-82dc-08dc3c61519a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 15:39:45.9584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5k9x7OIoI29Oo+mSMq04iaB+Ej9K/lqhLIRs0KKarORtuAgk+movQ80833kDOTyGqd8OCtPdmS45gBb7sQLgew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8919

On Mon, Mar 04, 2024 at 04:05:07PM +0100, Krzysztof Kozlowski wrote:
> On 01/03/2024 16:42, Frank Li wrote:
> > On Fri, Mar 01, 2024 at 07:30:10AM +0100, Krzysztof Kozlowski wrote:
> >> On 01/03/2024 05:01, Frank Li wrote:
> >>> On Thu, Feb 29, 2024 at 10:44:20AM +0100, Krzysztof Kozlowski wrote:
> >>>> On 28/02/2024 20:14, Frank Li wrote:
> >>>>> Add power-domains property for asrc and spdif.
> >>>>
> >>>> Why?
> >>>
> >>> i.MX8QXP i.MX8DXL and i.MX8QM need it.
> >>
> >> Where is it explained in the commit msg? What about other devices/variants?
> > 
> > I will add it. These patches are for imx8qxp\imx8dxl\imx8qm only. If other
> > platform have problem, it should be fixed by new patch. 
> 
> I would assume more responsible approach from NXP, not just "their
> problem", but anyway that's not what the comment is. Why do you say all
> the variants have power domains in one commit, but now in email says
> that they might not have? All your patches are vague in this aspect.

I am not means "their problem". What's I said is one patch just fix one
thing. If need additional fix,  I can create a new patches. I have not said
all need power domains specifically. If there are some words that let me
think all variant need power domain, please let me where, I can improve it.

Frank
> 
> Best regards,
> Krzysztof
> 

