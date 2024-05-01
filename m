Return-Path: <linux-kernel+bounces-165660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 933468B8F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D3B1C212CD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A19612FF8F;
	Wed,  1 May 2024 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZqEWEa3k"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67512FF89;
	Wed,  1 May 2024 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714585459; cv=fail; b=VFoB0t2IG5CwgTn6NuAUCDEEujqn5XTJ3vbQCwgyDNgMD37C715l3k64agOEYy+V+w09J6L27hnZOltupRnYjfZjpA1S1RiZAUwrWPkUtHpzMsm/IUH8USR8ZmwOMC6X2WhYYSKCnS6UO5ppgDzyCfnDiIz0EIh8z82JxQcqC0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714585459; c=relaxed/simple;
	bh=hGaaiqAJqESh7Mfw7HCfKn6QlN3im4teHVHZBDBS3jM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OloxmPcXNTGia5S1w5+r0V7XKLQdLu7SW4ys9x9YYtEPhq3XSio/L44I8dFLRjpl3YX1ayeqygZTVmVszYIwvmAe1cn/Lq5RcKoizX9oB+STUXjXMG8FiYioD37XWyAWP4xqfRY3bbMVXOAek84/3LZmJOe0zwKOd++CBAYVsiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZqEWEa3k; arc=fail smtp.client-ip=40.107.94.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cA7v1e+OIdz3gIDwU3WUx3UaKVg4yvXMqQ7zG8WZ8ozkzk9/4+ce++/WwrsXGkqaTZo0VhFHSi0potMLi9XfeQtvmcwzZHwrHl5goUPZ72vnIH9/NadnSY69dpRWOjVua8uIcxsqwtV9Wbe88O7WJHp+3O54QJfmPjK/yUGcdl3M64iafQqWqf4Ue236EXJiMnZf3bZFlWgbApiWvqyP2jGwxm/XjuJ1KP6+giaum4yUZPXhulE+whWlzXIc/7dzv7P3IAq6aOHeiYkqkOVxk55JwM4Ue+CqQzZsPPn/WaBx4JO0SzwSdQG4o+4klLLLEs6KbVoPyg6vxMek+h7FSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mqMBZtrpTt49/Cdtzq5Ejr1dkQMh6WnVRJNebGCi2Ok=;
 b=gIwFmYvHoLu7/SEyerI+qnhodxNzCrMYS6m1Hzbm4pJF2JGn1wRgxNisBGeKPSl2omMiAVzB8uBIyMzqwekcgStTqt+SdnddBCqIY18f6pKZstQzYba92WiR5YJrlXBggiqvTQH/TQ1mlXAhC4IHmvchVv5NVtfzzvsVUun+6P8juAFr9M6J1ZKQsgzXqi3j7xdBaCG75dZPhjaCO8R28YCAzKjTuPB9zZ71sbuBbgl3kJAvcnx9hHUJUE8xJw+eVg6F2a3HJ99rqoxQIsSHHBs7gRwUCQCov1covnSyZ2iFgMcHLV2/BqV+89AV20x310BYnT+AJnkFZYL0uDhj7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mqMBZtrpTt49/Cdtzq5Ejr1dkQMh6WnVRJNebGCi2Ok=;
 b=ZqEWEa3kUmsR5fpIjbMvLLScq8Ol424AUccGctzR6YEWyNqGKqLIofCo6Wkdvu0O3NyUJYCjK3Y8F6J9NO5GFSw4Qtrh/Qrgm5dc6BnsCcIxLNIviX7yRVCvRXKs0SyuqPCoiKzf79LNUSLoeuQUKXefHHnOIMTJsGgQ4WGs4dX63l4B8J7NrwXOxqBqrD7KDo88lP7O/NKYs3YTFOmQevYM3gzUfvRYPGSSwGCN45pjdULwZDDJhrwKJ86+GkRUmv0PfMWF9CyLa0BdjtPJd/Ew7Y9QgcEKPcaZ1TekhGzdmp6SntazJG9DLZitSf7Q3DZ86i6DOv0RIFb96T3nSA==
Received: from PH8PR07CA0014.namprd07.prod.outlook.com (2603:10b6:510:2cd::25)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 17:44:10 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::8) by PH8PR07CA0014.outlook.office365.com
 (2603:10b6:510:2cd::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Wed, 1 May 2024 17:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Wed, 1 May 2024 17:44:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 May 2024
 10:43:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 1 May 2024
 10:43:41 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 1 May 2024 10:43:40 -0700
Date: Wed, 1 May 2024 10:43:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v6 5/6] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <ZjJ/S1bawYkfs1I4@Asurada-Nvidia>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <63414546b1eafdf8032ac1b95ea514da6d206d63.1714451595.git.nicolinc@nvidia.com>
 <20240430163545.GS941030@nvidia.com>
 <ZjEztwhd5AN1FTCk@Asurada-Nvidia>
 <20240501130042.GC941030@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240501130042.GC941030@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|CY5PR12MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a79739c-2540-48ef-658a-08dc6a064e14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PHLxILkMYN6OtsdgXa+Q52Pe/rjzPTnBBiAYe6LWoviFa/2gK6xO6HYovpvK?=
 =?us-ascii?Q?bM3XdjlCAhEa/Edv3xYHNXU1CZKqxYgb/I7ilneGqY7vC23ra6raaoLV6cta?=
 =?us-ascii?Q?MgvTSW5mq2JxF9xU0VryVH9JyPBRNZ9ZmIiPIVoFuUpXFq9S7kmBXjjB1bxv?=
 =?us-ascii?Q?ZBLCcHr5rl76BggcQ02H2URQQRH9Ulnnr0m1yZhyaQ0tEwMg4aFU5jKiCgw9?=
 =?us-ascii?Q?nF/eJZE0UK3j+OI1SgIepFhjENLSsXtwPuwjNMtQXa8+ld4A9LMhNvOTAH3I?=
 =?us-ascii?Q?2dZPBB5yzLkO1KBsX0KfWYzYmR/0/98l1R4teRTXCrahau/5JkIgDsVOn1lm?=
 =?us-ascii?Q?TBBpBiLQCGmG1AOHYSEO6dSllO5IN+pguuyy+DOg7XX6QHvZ3gxVsmFkhwg2?=
 =?us-ascii?Q?1ORoZg3RceLFrfStPff3kafRqiZzZGkIvlgcF1KZF91asmAc7tRZJJfOVwYt?=
 =?us-ascii?Q?QPFl73VGOH3f4nTvenY+hEyuElvMENdJXvkX8oSn8v8q/AvQlyVGFl+4E2tP?=
 =?us-ascii?Q?5/qMVDlfytCzWqQSpVF3NFS1etbUqikqf0F4I4lTTkj295T99br78+61rfgr?=
 =?us-ascii?Q?LmjTeESuR65FNACj/Tvd65bOjeYc3DLWgeyQd7OpBksCRkxhXVJqABBB44GG?=
 =?us-ascii?Q?dGL4q0NzJylv60bigduNY+kjS7+UdY78JWXV0pCGKQbh+xG/o7dsnDAcW4hg?=
 =?us-ascii?Q?O9RxlKb1f38U6l63SbeN0ZoPQtOAnEeOM7a1NIQgPXDLKqKcxKI1rAXYmg/s?=
 =?us-ascii?Q?JGbsruoJ0o7net+dR9UjBLB3Fu0F7Eh3FLf/6tB8VbA8oOYymJP3r4TLL9HR?=
 =?us-ascii?Q?zwRpzG3ZFoLUivBU+aILmI8SoUUzdl7U6qa7Nh6tu3/s3wnyemG1cSCmHqsA?=
 =?us-ascii?Q?IzmdMaVIn9Jkbe5doUv+BY+5qqioZUyhAs6+/qn94wyeSLryAwCrchbwcgLZ?=
 =?us-ascii?Q?Q4nuGCtgXgZADfK+B7UUBPBvh+Cb/dlbL1rbB6jG6D+kKf/RDecBJstLAUBw?=
 =?us-ascii?Q?mmjwzcYmDuCv5IwxTlBMvpTUzvndvBs9U8TU0NbICL15cWAj70LSaXglHPiV?=
 =?us-ascii?Q?YCurX93/MBkMZpkEoyAs+QhtC54t8nlKL4BGen/w1aXZcGwfJ67Yx561EmFj?=
 =?us-ascii?Q?ZFyzbzOeBSOdlNUmOdf5i0iM5FXu+T2G5QBiUgMdBtxMN0i2wqcD+HyarRo3?=
 =?us-ascii?Q?7KHo0c8olAPJBx4zGrnx5fR2u9xWw0F8ku/GlE9qfvb5npL2HPmNRb/9Jb9q?=
 =?us-ascii?Q?oFKnmCmBSgAQfaMwKVpXsCMoa3ELZLWagTjiAggSnoJm2/lt6ZC0SKpxySr7?=
 =?us-ascii?Q?MoLtBGCwEnzd5O+njADSrpDF3kkbh4f7/8MswtyomaNSoUendSZrHQy2Oo63?=
 =?us-ascii?Q?rpLgfL66sqIZ51+xSmkLakbWLmkr?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 17:44:09.0669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a79739c-2540-48ef-658a-08dc6a064e14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252

On Wed, May 01, 2024 at 10:00:42AM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 11:08:55AM -0700, Nicolin Chen wrote:
> > On Tue, Apr 30, 2024 at 01:35:45PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Apr 29, 2024 at 09:43:48PM -0700, Nicolin Chen wrote:
> > > Really this all seems like alot of overkill to make a little bit of
> > > shorthand. It is not so wordy just to type it out:
> > > 
> > >   readl(vintf->base + TEGRA241_VINTF_CONFIG) 
> > 
> > vintf_readl(vintf, CONFIG) is much shorter. Doing so reduced the
> > line breaks at quite a lot places, so overall the driver looks a
> > lot cleaner to me.
> 
> We don't have the strict 80 column limit now, it would be fine to go a
> few extra to avoid the breaks.
> 
> Certainly preferred to these readability damaging macros.

I think only very few folks will look up for the register macros
that are actually damaged, and these MMIO macros still look very
straightforward that we will always know the correct ->base and
register offset pair will be used.

There are four sets of ->base in the driver. Sometimes they can
be so dazzling that a wrong pair might be accidentally used. Yet
such a stupid mistake can be really difficult to catch it out --
I had a hard time earlier to sort it out..

> > I can probably change these logging helpers to inline functions.
> 
> Just call the normal logging functions directly.
.
> Just call the normal logging functions, there are so few callers
> typing out the VCMDQ%u is not going to be so bad

There're a few more in the part 2. And it's actually a bit wordy
doing "VINTF%u: LVCDMQ%u/VCMDQ%u" at every place..

> > It would be unrolled to three mostly identical inline functions:
> > 	tegra241_cmdqv_write_config(cmdqv, regval)
> > 	tegra241_vintf_write_config(vintf, regval)
> > 	tegra241_vcmdq_write_config(vcmdq, regval)
> 
> Expand the parameters in the caller:
> 
> __do_write_config(owner->base, &owner->status, _CMDQV_EN, TEGRA241_CMDQ_CONFIG,
>                   TEGRA241_CMDQ_STATUS, _CMDQ_ENABLED)

Yea, I just did something like that. _CMDQV_EN and _CMDQ_ENABLED
always equal to BIT(0), so I also move them to the common place.

> > > > +#define cmdqv_write_config(_regval) \
> > > > +	tegra241_cmdqv_write_config(cmdqv, CMDQV, _regval)
> > > > +#define vintf_write_config(_regval) \
> > > > +	tegra241_cmdqv_write_config(vintf, VINTF, _regval)
> > > > +#define vcmdq_write_config(_regval) \
> > > > +	tegra241_cmdqv_write_config(vcmdq, VCMDQ, _regval)
> > > 
> > > More hidden access to stack values
> > 
> > Btw, any reason for forbidding this practice? It will break the
> > build if something goes wrong, which seems to be pretty easy to
> > catch.
> 
> It is the kernel consensus not to do that. function-like-macros should
> act like functions and not reach into some other stack frame. It makes
> it very hard to follow the calling function if you can't follow where
> the references are.

I see.

> > > > +	/* Use SMMU CMDQ if vintfs[0] is uninitialized */
> > > > +	if (!FIELD_GET(VINTF_ENABLED, atomic_read(&vintf->status)))
> > > > +		return &smmu->cmdq;
> > > > +
> > > > +	/* Use SMMU CMDQ if vintfs[0] has error status */
> > > > +	if (FIELD_GET(VINTF_STATUS, atomic_read(&vintf->status)))
> > > > +		return &smmu->cmdq;
> > > 
> > > Why atomic_read? The unlocked interaction with
> > > tegra241_cmdqv_handle_vintf0_error() doesn't seem especially sane IMHO
> > 
> > Race between this get_cmdq() and the isr. Any alternative practice?
> 
> It doesn't fix any real race, I'm not sure what this is supposed to be
> doing. The cmdq becomes broken and you get an ISR, so before the ISR
> it will still post but get stuck, during the ISR it will avoid
> posting, and after it will go back to posting?
> 
> Why? Just always post to the Q and let the ISR fix it?

Yes, we could do so. I was thinking of the worst case by giving
the guest OS a chance to continue (though in a slower mode), if
something unrecoverable happens to the VINTF/VCMDQ part.

> > > > +	if (tegra241_cmdqv_probe(cmdqv)) {
> > > > +		if (cmdqv->irq > 0)
> > > > +			devm_free_irq(smmu->dev, cmdqv->irq, cmdqv);
> > > > +		devm_iounmap(smmu->dev, cmdqv->base);
> > > > +		devm_kfree(smmu->dev, cmdqv);
> > > > +		return NULL;
> > > 
> > > Oh. Please don't use devm at all in this code then, it is not attached
> > > to a probed driver with the proper scope, devm isn't going to work in
> > > sensible way.
> > 
> > Mind elaborating "it is not"? This function is called by
> > arm_smmu_device_acpi_probe and arm_smmu_device_probe.
> 
> Normal devm usage will unwind the devm allocations when probe fails.
> 
> That doesn't happen here, you open coded the unwind above, and then
> you have open coded freeing in another place anyhow.
> 
> So just don't use it. There is no value if the places where it should
> work automatically are not functioning.

I thought devm could work when rmmod too, not only when the probe
fails..

In that case, should we be concerned about the "rmmod arm-smmu-v3"?
There is no callback function for that yet, so memory on the cmdqv
side wouldn't be free-ed.

Thanks
Nicolin

