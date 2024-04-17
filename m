Return-Path: <linux-kernel+bounces-148477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE79D8A832B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEF721C21097
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE52713D2BF;
	Wed, 17 Apr 2024 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MO8I9vkU"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9F413D24C;
	Wed, 17 Apr 2024 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713356973; cv=fail; b=ZjKCs/oUz05JoV00SfItw+e1DCKD8ns7RhEcF88kfOOQK9q7NYY3P2falfRmbFSDNieByt1jON8TkdTleIpQ55upMEks130DKHYz+4G7iY5ZGmnej+u6hbe5EDyi9ms2Fz9KxL22f//BuvnVURf9cqnXFSrLQZ11aMXE1I6u5zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713356973; c=relaxed/simple;
	bh=IDA+9w6J53N30anf5jZ6uqBrADudEDixujxRawrVvNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GSP5b7IFF6BVZnWBpcnnYz24uV14xENQwr4SE+w5s7DgyCAYdJ5R2GwXt4wkggfm30sor/7R8oikcsXq2dpG0qetEWUBVBXa5XU5cP5JBksAZY1+ntDrTmctxwofw4qROvtSvTw/tXFrnJ1r8ruU5opvFiMXekwHOA/AyLoR8jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MO8I9vkU; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvDfiOrq2F4nd6PukFmpnjGNB/YuKm7r12E/HTnljOs1QdquBffjwU6FS1FfUwf7Bco0KlHM5INkXcN34QV04orGMufR1QR/VQ3d2HAWkgGVWtsnQQ2+Ris0vIoxAYAFiEn7bHUTrJARARDxEM7Npl7iMPfE77qQOIhOgnqNI9u5oi2Hp9RvcCVKR1t3JvEx3vESzSnk0rNeJBKpbGI8IAJIvMKd3FidAJwdf+hVyI3vTDXmfzzJbNMPB65RBY5qlSc9bvh+AfL4C+cEaVPCg53fZ4BUO3uzfvjnM/d2sUNAybnrHtXk/Me/IWUf4D1i5W3952Mv8oiRScvEUEpBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wBfN0pdREFAR1+verlsyb/fU3Wmc5ldBlPtUvhGvmk=;
 b=RwPkDfpmNXdm1Pz4rfoiBkQhpVG2PJBEaSNpA2RgDEcpT2OW0UCADiK2gnaQ4ueOhhRH/HZOqy/9NP8ZuPuYtpW0IuEGbIwXXYZEHd/kn4oZkgrPx4d8YeP3swC3+Ny6fq0qKEnOYXqHPVr+adXSAQi10zhDCk53Kdu1daI/D8516rWoNmhgbYDc2MO+7rLIKywH100U0ODcComgUuriQko/3BsSpkzZb0MzTyN618pPAd7d/yEI1kVoVhLPQESL7If2rSrIidRlcmkaWX+p+sJxcIahAUOIhzOdgqyyFTNpVRshO8en7hiNqowKjisCpnIjLibaNG5N9Gg9BEnO3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wBfN0pdREFAR1+verlsyb/fU3Wmc5ldBlPtUvhGvmk=;
 b=MO8I9vkU7SQ37fYNcRkI8ZoXlfhW//8STDAGdvFYT8lSliBISrImA3pQXwNhf4hN0BrXSQB2Ic4E1EOuyYSzUbFlEQfxiwBpM+up7wHwItKvPzZeU11qQThEmAStaNUgyoVKzeLRXA+If6NeWeFkz8XF6E7Z8jCGfCePjP1jziEQAmJpyOuHBhBrcmyTgdSiJ0Ne29QWJT3vSN9BZmDnFGtJsfIQ2vRJbMgTb7LoIJzSdg/Z6T09k/JYdotjU70NPAN+ye66lyBiqoNnSv9SfV43uxc7dwsv5nVjiceZe2iEIgrebp0oETNfp5hED/g3cPGlgTI2OAAc2fgciGlpyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 12:29:28 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 12:29:28 +0000
Date: Wed, 17 Apr 2024 09:29:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH v5 0/6] Add Tegra241 (Grace) CMDQV Support (part 1/2)
Message-ID: <20240417122926.GP3637727@nvidia.com>
References: <cover.1712977210.git.nicolinc@nvidia.com>
 <20240415171426.GF3637727@nvidia.com>
 <f92efdb774cc4cd48a59495e7cb69c27@huawei.com>
 <ba3047f946c6475aaf30800f9d3f9afb@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba3047f946c6475aaf30800f9d3f9afb@huawei.com>
X-ClientProxiedBy: SA1PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::16) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 444ffe45-907b-49bb-181b-08dc5eda0623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IdGf9MCQyAdOUDHxjhq3hWDIkKlrqft/MNwZ1CH7vWt0iaTRYJPHQYFAHqa1CWrA06NujWt5E9yqrb/3ME9RunggCrjv49UtLGY7PpqsQuPo3pkjatRauyCVNWYI/r5mMaqYORh9W39eU4Jg+vBsa4EMJBRVZmQmWQooySN88P/djYoukMRRTW82AaABzM5hXKOAHaiQDjXuO0/w0h1/Et79fvgnTI2WiwSmf64wxKmBfq29nJOhiII1JMkzPqO/cCKsuONS+D66GBLyZsQLhKRbFsu2eE4qDM8em6niD/Jg15n5TY2gZDzU+uca+wob+qCvIdcLKoKicPHSY3RTPzmAaId1LlDZlF6MeFfTOT2HMU2TNVqLh3nTWpOUO0ggnp3diyhu0bBqjRQPWMrhcTntMahLUHug+0dC0p0iFvJi8XHCOBF/InRHEk5Ytsfj3TTNf83cAZu2pKhJYSytwT3MTzGDI1TnP4YP/SMTC5/EBm1aoourbvmFInd6DuyhrXY8H5fMeXb/PhaiPpvT3V1dgX3/5MFMPR4XxbeEzI4zPkJs7WLtrkq9dftsAle+U94O2ItXgJyjIurUWi/ujPhBoFFPcMLpYuzjk7DTJWzaO52oYwDCHgDya5sy5LngLvneOIBAFiHTwRousytiuNqY3tTDfaKOh06AUkn599A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4cVz43wrINHdkUSLD+gXJtpNKDUgt89p67Q01QDfnrDJtC7MF867Dnh4B4Ji?=
 =?us-ascii?Q?rPCQEkmvRW3yyrVQ8hIxx+hPAFH9HIcfZtRwjdTIK1zzPq67EMuJbn29Va7W?=
 =?us-ascii?Q?/wVB48luRFGjC6hkpR57Y93pLLYsSb2CSRg5dEzFxjNtoiMfx/+yCVCsH6tG?=
 =?us-ascii?Q?Zs/oSreMudyf+vpL7l2lC+1VVKySoXdZMqXXUYMmm/2MwqVW0lcY27a3AwqB?=
 =?us-ascii?Q?d5lWU0AHIgoVpaOHKlG8NI82jloh2UJIfhVtyacYoc45lwY1nCetLZdH0hrk?=
 =?us-ascii?Q?dbU9OC0HiTRtCqPeoYU0CYkyhQa+vuZDgbj+yBcjnS032beC+8pZqhC5MISp?=
 =?us-ascii?Q?mT5bVZ5Fr4p437IJnMUEpPD6AX61y0BsG4RvhWknP6m38EKlZS/nODjMIcVy?=
 =?us-ascii?Q?U0pVTNGw+WfO3KsQiYIrZuMlzbzHkAcQ/UcOV3vdYrmVTWwSnLp/u7oml7EM?=
 =?us-ascii?Q?lJmYoRbd1J3BbAQLag4slBgCvAD7YuNHEax082yjy1l5BGa+wuNAtPVpBYE9?=
 =?us-ascii?Q?k8OhaEal81Jw42yF4oB+6y12mNIFNfn5ioMkGBHqm8v3slWQVblWbErRDJ5/?=
 =?us-ascii?Q?fJZwJY5xmWhTdICexUgV2+7c8LIaxmAbUfCo0EPKlNlllxZvcb1R6w5CzyKU?=
 =?us-ascii?Q?YHO4UTOaR8tAvwf40J3tSL37UxMffbHBwYzolV+0tG13X656NJE3867cfFnb?=
 =?us-ascii?Q?hC67VLwjTmgkBbQrMfrzdIrZzAn4UTE1j3wB7nQDn7ptGsOLLqFkbCP1YYo4?=
 =?us-ascii?Q?pFhjucA8jeU3ZhXuQGrd07BcvbmpWdNsDAb/5/nPDLraBfaiEb6Za2i/H9Ns?=
 =?us-ascii?Q?/rteyt3lzX8eFOqdBjTa2c3ir0yU5im4mizs3IbYXu6eo9tmOVtBHBrEx12y?=
 =?us-ascii?Q?5k2oAOXEw5XonBLuoiXGIHGU5HTePVqDdZr9s+45IekZ8IvZHsLh56k113tp?=
 =?us-ascii?Q?HKE3B7gIv0Sqr6dHmXlz0xpb+AnJbYlJ+UY2l6EB/PKbKlP2GP2wPINOVPmp?=
 =?us-ascii?Q?ljM7MTIr1s1q4Kjv2qJtuLg2TYhffn2/7I7T6yWjWAVkYZdUkXuSbB9135gz?=
 =?us-ascii?Q?WgAqmlOHO0NuzKhgDZ77lDXDRq0d+F8vZVuWM9N30m0/cw2Js5INiGtYOqPc?=
 =?us-ascii?Q?sDag+HuhHYBdAVk49XAwgtujftrf8nre+t2Y4Ot0mG0UGd6FsFbw6NBj4DKh?=
 =?us-ascii?Q?xDIuda0pdMhWrCTL4arGOtpqqciW54CdCG47+hmU3FifxSsSwZUateOMHCF6?=
 =?us-ascii?Q?5VLl5bpt+6jNVBKtvZo8Zn1leU7nQu88oT0SLfwBUQJ8nZOlj+UmI4orhIt8?=
 =?us-ascii?Q?N9rk4CvEz5steF4HwQFUG8PxcmJhHUSz1jCCt4PX++A/CeCe32HHydosvGg8?=
 =?us-ascii?Q?hmcmFLU5V6jHJkpAPksCo45glkYGbyHMur2rDsI9gPa4m2FIpjIHejawLK8X?=
 =?us-ascii?Q?ynwAYo6G3iUXBFqZD17akmUOFhH/Y55Ps5662AEZMq9s0rXbFmH6uF9ezbHq?=
 =?us-ascii?Q?xamGGaj40NguhBZx1aCQYc1tF2sGIyaptNMcBz7Iytb0mWslLBTNHDeD1wBS?=
 =?us-ascii?Q?4/bx7IowmKLhJWPNia5WkmyFXXXx2PTzjBka0d3o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444ffe45-907b-49bb-181b-08dc5eda0623
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 12:29:28.0650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: whjMYDbNimAc6soZq315X8vmYwE1o101j0MdVM39DFaLqK21SIBNwnx0r+z+c+2v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257

On Wed, Apr 17, 2024 at 09:45:34AM +0000, Shameerali Kolothum Thodi wrote:

> Just to add to that. One idea could be like to have a case where when ECMDQs are 
> detected, use that for issuing limited set of cmds(like stage 1 TLBIs) and use the
> normal cmdq for rest. Since we use stage 1 for both host and for Guest nested cases
> and TLBIs are the bottlenecks in most cases I think this should give performance
> benefits.

There is definately options to look at to improve the performance
here.

IMHO the design of the ECMDQ largely seems to expect 1 queue per-cpu
and then we move to a lock-less design where each CPU uses it's own
private per-cpu queue. In this case a VMM calling the kernel to do
invalidation would often naturally use a thread originating on a pCPU
bound to a vCPU which is substantially exclusive to the VM.

Jason

