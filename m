Return-Path: <linux-kernel+bounces-165296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 390918B8ADA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3701C20F52
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33FE12D1F1;
	Wed,  1 May 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PiYDmMeT"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F19F56754;
	Wed,  1 May 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714568449; cv=fail; b=afiT+ETEFYQ4MelmmQRE/f/9AviHIIwXHaIY6EDjVCGEPltozEhDKmYeqZ5fMKnMJgbgdBp0IYpl2cIWxvXvBzAAGA8gcVC1AvTt186VbG4+7u8O93IddUNLG1F05al3YiP/rLhxU4A60LfVts6aFNcB/DRsHQ7OuIiD0LpVW6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714568449; c=relaxed/simple;
	bh=TMZRoVt3EAoZsd6GVOJnNRQ530WlOqmFsUhnVfWKw+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kp1Du1rJQYsyjPmKInLKfQi0PsYDV/yXULLKvKghnZXeUw9h+tzlswgkstavnmc/aArP0//+4GB8YL19ng+KZenTsT2SAYWcHSHpbgDtbJeozbSgftraLhd9TEVw/qc7bjclKRbPzBjac3KDcLZCsEFapBVsL0IrFhkL/xepNpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PiYDmMeT; arc=fail smtp.client-ip=40.107.243.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6FJdR5fee354DN3nYQJVUT3xNUjzyrTMTe6sUz4woQFX4LNY8GZ14opOIbJI20bSsM9xNbu9fhx7OQQNgSl4G81bj/2IFJnmdQkFJFfcJVRIc46Jw8dUArSxn4BsFJCMyXuoWZeJ7ypKlVb5pV7PU8X6h7TSltLKHfofqD0yc9VlwnnbH8As/NA0R/MhXwIHfdJkHDy9MxGfJchcvsb1Ptyzq305A0J6Hj9Mg92lEjqNSxdDe1WZmTNL7nH9vGpbJ1Vx/8K5SHnn6uDL4W24NKBUURTOySnBy2CphcdSuVEZYLLPmCYVbLwpgpRQl9FucTejucITP268OQcmahVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fbFwVWbDiNM5d2OdQt1vYophJYlCG5R8loKabQ+9GeE=;
 b=FWb6gFaz0Qzpmt0GKpbJf7MZJZdg3FLSGX4q7yc8fP0bR7SfpauXhJSeZs2l2Gw6aCS22EP8me99A31EJD4bryHUlWFqC+luyYvkuSsDSBn4J9bpe3yGGbrFXH+Yxs7LDW5USmBGZ+PEbdF6DYA5cQRSwlRYtiZcnQO8RisN5tc/7rM7IwjrmBZo/o9xk7f7KkqEBn5TJ1+ywGk8fOBfQoLGSR/66FeugQ4vEAW8cTeewue7fhgbYOp8eEWTNWU5hPoovDXjJRMqAxcVkgBhAKNuUyAiBJ383gPkiCPd59gzL++MPqVmbuYhx28ybdfxC3I3nna/x9KafWe5c3GrKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fbFwVWbDiNM5d2OdQt1vYophJYlCG5R8loKabQ+9GeE=;
 b=PiYDmMeTLGzsEnUNjZ64c3U4vUUfZHfpG61yeSWjyDX/rzlp08x9ly7C+VJUqmbPDDibKzJUiwXMpXmdUsGh+KgUK1VGj+3WNDt8zbuZHUMKomPHDuscB92fDshr59sKP5idWSr3REc5jdYoKFDuUq2m7pSVq4ogcntcmBDcmrvru0oywQ8KwPc6Q+0z/GDKwkBstuJEWoVOwbQGulH8dDwgSonDeglmN3cYDJJxy/wZXwVJw0IPC3mDhGNO1NGjefsBAU+mwzNvO+2lpCsJr2QwK9Vk9HddfOQFAkdjXwUtP8NJkazpv3lThiuw3mmT6lFlZgYrAvXu4FcyppCm2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 13:00:44 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7544.029; Wed, 1 May 2024
 13:00:44 +0000
Date: Wed, 1 May 2024 10:00:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 5/6] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <20240501130042.GC941030@nvidia.com>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <63414546b1eafdf8032ac1b95ea514da6d206d63.1714451595.git.nicolinc@nvidia.com>
 <20240430163545.GS941030@nvidia.com>
 <ZjEztwhd5AN1FTCk@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjEztwhd5AN1FTCk@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:208:91::14) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA1PR12MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: 948927d9-63ed-45d6-97f1-08dc69deb5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E5SP/ZUsl9KoTJyaM1D7L6Ph9FetoSOmrFyj/BDYl9ImgWGLaLmxGnBNlIM6?=
 =?us-ascii?Q?XglLDu07m5Zf3Su6wkt7xYACSc2wQfVEOlgaB6TRfsES/RjJIKvybalKC9mQ?=
 =?us-ascii?Q?yBGfdQSXQq/rpYAhtCKcCsd3L/lDtXltmOUdzb6I6rA/3dIyqQMjg6h7pNR5?=
 =?us-ascii?Q?y/HVa4eCSHQhrmcUnpnAllEXTZs0gbpSYQ3xe7EnjdNbn3icOGetiPzbMlP1?=
 =?us-ascii?Q?0O0JXLJjvkuk4JYX0T4GZM3S3uwnMhJBQtgiy0AtzT5zdMFZKlcRycXfThzO?=
 =?us-ascii?Q?QVVbtYA6YHA0V9GYD2fUJRIkNFktooSmrdYS2pnD35j0WvSNjwRU+1yvLKlQ?=
 =?us-ascii?Q?ABvQeM4++cJCoUcJrTzmPq8ZNaPDzGg0WlTRnaTZGCbJjHgCU6fVnUBfQZNP?=
 =?us-ascii?Q?pZr2T5E+ruV6ZAK4c0lTCIg6ZQboSpvNeAIAbhDtxXhlG2J2Nu2800ETvkOJ?=
 =?us-ascii?Q?qWJ+iceSdms/+ol2i3Uwfnzjwk2ffFAPGz0g/J+f6xx6EgsG3yc5cNUCBzlL?=
 =?us-ascii?Q?qTnsXGRou7OFLP4kDyy/Wi4vX9QF7hF24v8OoM1WlYyLGoXQyjWGAFr+sU9C?=
 =?us-ascii?Q?MXqi6lYsHW1p5GL1NIPXMg7bdpqDWLqn53doRzoc72W1PTCahSovXXWBG+i0?=
 =?us-ascii?Q?3c6ZCuPcdHEHC7J6U82suKURQo1fjwBwTDhSd4zzEc3ZkMacIlH6CFw6QyEx?=
 =?us-ascii?Q?wOLweIUly+gFoCuKVGPfKThfFIfrMr80eeOW6amm4MBmmfW1o9A7UG6hoHrL?=
 =?us-ascii?Q?5/UGVK3ELEvrtKfhMYwM4nCEwiucdSLRnYfp6p0qYuuN/1/CSupuDJRBx9xH?=
 =?us-ascii?Q?qIxjNY8MMJ9zpgZuoYdPFmaJ2sx2kI/2jSpwDYzxTivA37gXFhqZihE4WHl6?=
 =?us-ascii?Q?hS6CFZXmbaGK8LpTQNc6IqCL/EfrkBZKxHrgAVggDbZxwGLBQotu4K5muOer?=
 =?us-ascii?Q?KU7madcWqQ/spzaBpVVlInKqmA2iBl2rBG6wQUbFSX+CXLbRmcUWSHyNoDLg?=
 =?us-ascii?Q?4z4l6yS9X49YRsS8x/JDVffj6uwSRxVCSRXaK46+35zp8kegbVnCgZJPnJwt?=
 =?us-ascii?Q?6MwvlPUmPab9xPViQoYejSiYCDjQQ5zbMSk+Jt3G6b8JdzxSABxLoNnk6SpP?=
 =?us-ascii?Q?+s8FCZ9tUG/DY5rxxEr7gXUNANg5iOrOuV4FO2VUdf8f5IpC50lZs2ucxbXF?=
 =?us-ascii?Q?nWfxuevGThtQu1HKU0FRffeTr3uPAbwSsa/XMKsNgGlXyA1eZ43Di3CLSOTT?=
 =?us-ascii?Q?lVTRQ+1pU7OLNtEqLbLp90mRa7X3RrUEIoSznb3Sig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tXOOtAQVsN1dSTOQqIYZuu5rNlq6FsoS2D2NiROE+byD23Ivk2TwlsDUQzwy?=
 =?us-ascii?Q?FZrjQ/osKpArBECWmGCmJmqEm2YPFLpF92whzWcj3k2EJ0tcDvyZwh+ROORE?=
 =?us-ascii?Q?IVapbv5FGeL4TnSxUA1JxYsNHBbqqnBjgMl14Ex/lXGQSGAyXAZ2FKJes5xx?=
 =?us-ascii?Q?ieDMmSJHtFsAVmcYySBNNKWeRmaeZny1i6Sipmk0heZ0J0dlCaXb3a5xtXt7?=
 =?us-ascii?Q?DDjuB8Bl+x1xqEKxtHoY0lCgB3lwZvzn70jM70ldRwVvpFlUIJtXrvbQJVUp?=
 =?us-ascii?Q?LGYpzPZye7eSpNo4LESvZxt3IztDbvgIPSSKv6c9csGSgEoqSVRUXW1Cvk/1?=
 =?us-ascii?Q?WpbV44gnnv6aEeASNdEXFRTZNG9BVE6EOnqmCgTRxfisgN+yPADyxVgvT6J4?=
 =?us-ascii?Q?M3wIdGmwjfedy0Ymww4xevCEDnL6M34FF+fkXvvz6Mm82d1Fyu11MfSh+R/+?=
 =?us-ascii?Q?sm/JK8SkX5jvPjaXpPg2JYHE9Y80A0d6nYRJSGEwlSTzCQTfTlldxolVXUs7?=
 =?us-ascii?Q?gnh39VC0SCzF+AgPZL6JNpx/ev9shKtpabb3s0OguFzCcGa+DFeOxbvFx5Vu?=
 =?us-ascii?Q?wxV6BpCiA23LzwQSWLz2ZBPHqP975olDY0OhKRaKwT32ooHqwGyYiKntotFd?=
 =?us-ascii?Q?iC+4UYxn3GWNE+alV3cilvbaz5Bx5Jdy5LA2qwIHy+V1WIVQHs2CaZ1Gi3Lv?=
 =?us-ascii?Q?69iNQXfCMDehqddJis0AC4TWi2qsh32KA3cHGkl/ZC77JNvfdbwMlWRi1oRQ?=
 =?us-ascii?Q?rSB8hskr84LrihUBV0T6uBSxQR1sNbUPjmT14dfTFFG9Ctp10do0drCYI4Ls?=
 =?us-ascii?Q?89FAmjLF/TyNTZEaY9z4CNY7gJ6ahEm3fb+hatGtRfflsC4DrFL6CASdkSVQ?=
 =?us-ascii?Q?CFKtge+dIO68yCwlJsfCPBpeI0vNdpVoTqU9PhlnbuQ58zZmz/1MCNrN66Sc?=
 =?us-ascii?Q?A+LnVJvws8p8XpZztZPTAXQjkSB542a2pnEiq7nzIQIJhOyd3TIYmjywr04T?=
 =?us-ascii?Q?o9WE5E2e4UNGmXgapaFQGWPH6hJrji1/tWN/790Bv2775iNxO1H69Q8gwNJ5?=
 =?us-ascii?Q?tnuf7eU7lnm2LmKv2m5Lb97sj6zQ3O9n3bZmV+MTNQvkF/hWLAFkOlPT+Vuq?=
 =?us-ascii?Q?u/3HpFN7j+MGL0FQduh77TLz9zX0cPIJ4DL7gyfNYHflrwIjSj9v0zOeqYy4?=
 =?us-ascii?Q?f6Lsrso/bOrc8/T28Nnj+wMRpHL7uzy6NS5uLykTIxUJgah1IfUHI/hnmMvy?=
 =?us-ascii?Q?ZXgGJlBQWfp1I2c6qnj2+JBMoL/AhYyAwYmrocgDFF9+Es0NLdvDIwXQSpqv?=
 =?us-ascii?Q?VolA/AA/To+g2c7nXGaTJZFiKPZ+xSSGmcXO/c2dnRzak7foZJc0i1BNlVBq?=
 =?us-ascii?Q?DInjkhNwsMDl/uA9wi+IY/8B92nxR9SPDXSy66wsMiDG1HG0CjT0yCqK1IuP?=
 =?us-ascii?Q?DptrOM5pElIh1hEvwI2Nfp4gQvJduDz87Ttzv+Zk4CkhAT6eshq4ZHiemOF4?=
 =?us-ascii?Q?lgPgZT2ebDUnaXcTckegfm1bgZr677jT5whnEYyF/W40lm3sd8C6vltORMKZ?=
 =?us-ascii?Q?CPzD40MukKJSYZBIfvxmtHJbb0xwh2hVInm0Yhfu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948927d9-63ed-45d6-97f1-08dc69deb5fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 13:00:43.9155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dzfyM0hwlhReCMrRfI56emw49mmRIfgSkRtXd/iWfWu/GfAyZRcqVDIWgK/8i8dD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8697

On Tue, Apr 30, 2024 at 11:08:55AM -0700, Nicolin Chen wrote:
> (Removing chunks that I simply ack)
> 
> On Tue, Apr 30, 2024 at 01:35:45PM -0300, Jason Gunthorpe wrote:
> > On Mon, Apr 29, 2024 at 09:43:48PM -0700, Nicolin Chen wrote:
> 
> > > +/* MMIO helpers */
> > > +#define cmdqv_readl(reg) \
> > > +	readl(cmdqv->base + TEGRA241_CMDQV_##reg)
> > > +#define cmdqv_readl_relaxed(reg) \
> > > +	readl_relaxed(cmdqv->base + TEGRA241_CMDQV_##reg)
> > > +#define cmdqv_writel(val, reg) \
> > > +	writel((val), cmdqv->base + TEGRA241_CMDQV_##reg)
> > > +#define cmdqv_writel_relaxed(val, reg) \
> > > +	writel_relaxed((val), cmdqv->base + TEGRA241_CMDQV_##reg)
> > 
> > Please don't hide access to a stack variable in a macro, and I'm not
> > keen on the ##reg scheme either - it makes it much harder to search
> > for things.
> 
> I can pass in cmdqv/vintf/vcmdq pointers, if it would be better.
> 
> > Really this all seems like alot of overkill to make a little bit of
> > shorthand. It is not so wordy just to type it out:
> > 
> >   readl(vintf->base + TEGRA241_VINTF_CONFIG) 
> 
> vintf_readl(vintf, CONFIG) is much shorter. Doing so reduced the
> line breaks at quite a lot places, so overall the driver looks a
> lot cleaner to me.

We don't have the strict 80 column limit now, it would be fine to go a
few extra to avoid the breaks.

Certainly preferred to these readability damaging macros.

> I can probably change these logging helpers to inline functions.

Just call the normal logging functions directly.

> > > +#define vintf_warn(fmt, ...) \
> > > +	dev_warn(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
> > > +#define vintf_err(fmt, ...) \
> > > +	dev_err(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
> > > +#define vintf_info(fmt, ...) \
> > > +	dev_info(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
> > > +#define vintf_dbg(fmt, ...) \
> > > +	dev_dbg(vintf->cmdqv->dev, "VINTF%u: " fmt, vintf->idx, ##__VA_ARGS__)
> > > +
> > > +#define vcmdq_warn(fmt, ...)                                                   \
> > > +	({                                                                     \
> > > +		struct tegra241_vintf *vintf = vcmdq->vintf;                   \
> > > +		if (vintf)                                                     \
> > > +			vintf_warn("VCMDQ%u/LVCMDQ%u: " fmt,                   \
> > > +				   vcmdq->idx, vcmdq->lidx,                    \
> > > +				   ##__VA_ARGS__);                             \
> > > +		else                                                           \
> > > +			dev_warn(vcmdq->cmdqv->dev, "VCMDQ%u: " fmt,           \
> > > +				 vcmdq->idx, ##__VA_ARGS__);                   \
> > > +	})
> 
> > Some of these are barely used, is it worth all these macros??
> 
> Only vcmdq_warn isn't called. But I think it would be useful.
> I could also find a place to call it, if that's a must.

Just call the normal logging functions, there are so few callers
typing out the VCMDQ%u is not going to be so bad



> > > +
> > > +/* Configuring and polling helpers */
> > > +#define tegra241_cmdqv_write_config(_owner, _OWNER, _regval)                   \
> > > +	({                                                                     \
> > > +		bool _en = (_regval) & _OWNER##_EN;                            \
> > > +		u32 _status;                                                   \
> > > +		int _ret;                                                      \
> > > +		writel((_regval), _owner->base + TEGRA241_##_OWNER##_CONFIG);  \
> > > +		_ret = readl_poll_timeout(                                     \
> > > +			_owner->base + TEGRA241_##_OWNER##_STATUS, _status,    \
> > > +			_en ? (_regval) & _OWNER##_ENABLED :                   \
> > > +			      !((_regval) & _OWNER##_ENABLED),                 \
> > > +			1, ARM_SMMU_POLL_TIMEOUT_US);                          \
> > > +		if (_ret)                                                      \
> > > +			_owner##_err("failed to %sable, STATUS = 0x%08X\n",    \
> > > +				     _en ? "en" : "dis", _status);             \
> > > +		atomic_set(&_owner->status, _status);                          \
> > > +		_ret;                                                          \
> > > +	})
> > 
> > I feel like this could be an actual inline function without the macro
> > wrapper with a little fiddling.
> 
> It would be unrolled to three mostly identical inline functions:
> 	tegra241_cmdqv_write_config(cmdqv, regval)
> 	tegra241_vintf_write_config(vintf, regval)
> 	tegra241_vcmdq_write_config(vcmdq, regval)

Expand the parameters in the caller:

__do_write_config(owner->base, &owner->status, _CMDQV_EN, TEGRA241_CMDQ_CONFIG,
                  TEGRA241_CMDQ_STATUS, _CMDQ_ENABLED)

> > > +#define cmdqv_write_config(_regval) \
> > > +	tegra241_cmdqv_write_config(cmdqv, CMDQV, _regval)
> > > +#define vintf_write_config(_regval) \
> > > +	tegra241_cmdqv_write_config(vintf, VINTF, _regval)
> > > +#define vcmdq_write_config(_regval) \
> > > +	tegra241_cmdqv_write_config(vcmdq, VCMDQ, _regval)
> > 
> > More hidden access to stack values
> 
> Btw, any reason for forbidding this practice? It will break the
> build if something goes wrong, which seems to be pretty easy to
> catch.

It is the kernel consensus not to do that. function-like-macros should
act like functions and not reach into some other stack frame. It makes
it very hard to follow the calling function if you can't follow where
the references are.

> > > +	/* Use SMMU CMDQ if vintfs[0] is uninitialized */
> > > +	if (!FIELD_GET(VINTF_ENABLED, atomic_read(&vintf->status)))
> > > +		return &smmu->cmdq;
> > > +
> > > +	/* Use SMMU CMDQ if vintfs[0] has error status */
> > > +	if (FIELD_GET(VINTF_STATUS, atomic_read(&vintf->status)))
> > > +		return &smmu->cmdq;
> > 
> > Why atomic_read? The unlocked interaction with
> > tegra241_cmdqv_handle_vintf0_error() doesn't seem especially sane IMHO
> 
> Race between this get_cmdq() and the isr. Any alternative practice?

It doesn't fix any real race, I'm not sure what this is supposed to be
doing. The cmdq becomes broken and you get an ISR, so before the ISR
it will still post but get stuck, during the ISR it will avoid
posting, and after it will go back to posting?

Why? Just always post to the Q and let the ISR fix it?

> > > +static void tegra241_vcmdq_hw_deinit(struct tegra241_vcmdq *vcmdq)
> > > +{
> > > +	u32 gerrorn, gerror;
> > > +
> > > +	if (vcmdq_write_config(0)) {
> > > +		vcmdq_err("GERRORN=0x%X\n", vcmdq_page0_readl_relaxed(GERRORN));
> > > +		vcmdq_err("GERROR=0x%X\n", vcmdq_page0_readl_relaxed(GERROR));
> > > +		vcmdq_err("CONS=0x%X\n", vcmdq_page0_readl_relaxed(CONS));
> > 
> > Less prints, include a unique message about why this is being
> > printed..
> 
> Something must be wrong if disabling VCMDQ fails, so the prints of
> error register values would be helpful. And "failed to disable" is
> already printed by the vcmdq_write_config() call. I can merge them
> into one vcmdq_err call though.

Print on one line
> > > +static void tegra241_vcmdq_free_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
> > > +{
> > > +	struct tegra241_cmdqv *cmdqv = vcmdq->cmdqv;
> > > +	struct arm_smmu_queue *q = &vcmdq->cmdq.q;
> > > +	size_t nents = 1 << q->llq.max_n_shift;
> > > +
> > > +	dmam_free_coherent(cmdqv->smmu->dev, (nents * CMDQ_ENT_DWORDS) << 3,
> > > +			   q->base, q->base_dma);
> > 
> > If we are calling dmam_free, do we really need devm at all?
> 
> Hmm. This is a part of SMMU's probe/device_reset().

But that is a proper device driver, this isn't.

> > > +	struct tegra241_cmdqv *cmdqv;
> > > +
> > > +	cmdqv = tegra241_cmdqv_find_resource(smmu, id);
> > > +	if (!cmdqv)
> > > +		return NULL;
> > > +
> > > +	if (tegra241_cmdqv_probe(cmdqv)) {
> > > +		if (cmdqv->irq > 0)
> > > +			devm_free_irq(smmu->dev, cmdqv->irq, cmdqv);
> > > +		devm_iounmap(smmu->dev, cmdqv->base);
> > > +		devm_kfree(smmu->dev, cmdqv);
> > > +		return NULL;
> > 
> > Oh. Please don't use devm at all in this code then, it is not attached
> > to a probed driver with the proper scope, devm isn't going to work in
> > sensible way.
> 
> Mind elaborating "it is not"? This function is called by
> arm_smmu_device_acpi_probe and arm_smmu_device_probe.

Normal devm usage will unwind the devm allocations when probe fails.

That doesn't happen here, you open coded the unwind above, and then
you have open coded freeing in another place anyhow.

So just don't use it. There is no value if the places where it should
work automatically are not functioning.

Jason

