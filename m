Return-Path: <linux-kernel+bounces-65738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3BE8550FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056B6291ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FA4127B74;
	Wed, 14 Feb 2024 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GzKXdL0L"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC341272CD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933462; cv=fail; b=tVw+Z4RJBzUsfkblqBfJPgUPFk5L2fNoyhY90eOVB9+qhCRs+kj6Votqog3BBRc23X3sNbvWetpUhxfjnLeNXDKdlOc5Z9Cvkp9JKl6caytkN3gjCbW91lHXZTckaovdjxd3U1npWwWVfPXdZjgMzqjYUDMX230v3Fgb7dRTcZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933462; c=relaxed/simple;
	bh=c/etlVcmwaoSNVwSeS/5GbjezvcUCmwXr/DT29LHonI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NQU/R0gTrjg9jRqyaEgCH9+PvM2B9rpBk3BD/Y0yuoVgE1Qp8+AuL3eu7YFJJQh7UiiCG7n7ZiL7gt0y7L28B0wIp+V6rRWN3sTjIfmmA3U/5xnaFEfIa9EvsL9pfYxYVKZxJ9Tgsz7vH7z7lTmcBPlFCSddmzoMtBA99cGdjDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GzKXdL0L; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USugUtaFTkSUxzI1R6y22dV/G2C9YihqkUpvS4W7QF193VJ4GnBjpiC3En+N8fsDg6nTqSncr8014V6hSg9ABzGbVhYp5Xy8H8UfGy3d6cZ6JM9K0SGMym3/gxcyLpha68Y2FSCUvpMPd/+L7UASz/RJZp5g7SSQfDoSpryajfvEXCBCl03SG6RYTeY4tAaa0YpgoHLw1fogcfMiSKR+Haz+V3fx0KXN+y+utFhE5Sj/v2MGJ12UZ2bKO3PiIUVFtC2Mm5bLqzMKyHGGhdiYIH36BMtADiIaVhzdUp/lpPa5xhyPQ4HxpbgW7bccF8fueMvYuZKDhr+vTtSoH4rXVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZGNK5X9CRHquNaajxS3fxzz3WUsStgAW5GJCX3wOyI=;
 b=fePaHbMeRd2BN3JkkX16pdVkPrm/DNEO+CjzaRK2kmrZtW4h0DjllUjyH6pWhOa8dfKZAtpnN/ttlxXF3CZnlQuXY3WhH05wpbZDjEgjVAQYtyYEP4iZmsqdNPlm74ygVSMeIFnOwkVbkQDlwSzFSnRKearVnvqSyMMM4wCA13jcYIdBqTHH0rGYhEYb/SUBd8YqD5ukIrk5QZDTQPyXA7bD8Orlx00zJaAlbDbYd/2GTsQQBKicDn09pUCRLs7EfFPLNzx/vxu4aKOHa5P6saRuQFRAOtraKv//KGo6PKvA52T8OBtOhuqlT2CO7tGPVbseThed0mnNwyq8/jgxIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZGNK5X9CRHquNaajxS3fxzz3WUsStgAW5GJCX3wOyI=;
 b=GzKXdL0LFrvhin64uQtdf5t6yYkFemQw/o22CNtbPRdFIx7fT16FUesCwDb8r/SOjFMbPMUv3gOfUFC+4rSd5cuIVjzt05uj+TzcS65dSLUUW3x0ErUelk4Wcn3FgpTMDodpxOTJloopXsQRibeS5/xzD9Itb1uFaJU+O+6YRpsdvkxOvqzKSyNWhzp0EnkcZ7xID5UGOmlZKLs5z7dt14amTFO8LJoeSNrfFAp92lc9X5yn3xyankVBCrLNnkK5+RBH8Ffdi1xqeaTYlhXSjTKsE3yjV1MNIGaI14KX/pBrjtXL0AELc0xnRJTynSlYN17xYAHIdZTk+zjsljpT0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Wed, 14 Feb
 2024 17:57:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 17:57:35 +0000
Date: Wed, 14 Feb 2024 13:57:35 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240214175735.GG1088888@nvidia.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZczntnbWpxUFLxjp@C02YVCJELVCG.dhcp.broadcom.net>
X-ClientProxiedBy: BL1PR13CA0304.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: fd6e93a3-4ed4-4c28-e264-08dc2d866d02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UiYoDoTdXLBtx+hVT3fitwVFeSl5MrthMr9VK0wXQx7/nZk7gMdWPvybICU7+BEI7tp/C2+IFgv8EPWBpkJ479nglEpM8iaP+qKQ1GzDdnjZcX//2olfOqe08aONp0QEtv9PpB/rjOi/rL8m3faoqfegpsVcWXI8BqNO0lOyIGGBMopOqVcq01qQN5krQoSKoiYBnvKuV//EqHpdcb6iyRAQfKfBOWbSf7iNjijjCYKLrsSz2R/D8QAi+1E6sneXJR+FQc+60+57z5q3T+WVrJrLQpCzFKuZSqAvLsUV7aXzO0IuzxBZ9Ut7UiJ9KTgcBV3ItDRzTNJJNhjxtVM4yv9K0tJZl+emSZfz+Pe4bVTJM5yWWJaiK6TRWIzXJfifJ9zcrj7D2GJdwOaAvx+zdvrPscBDBCYXjWqd0olrEHD9KViNke5hZ9Alek6tVMzWEP5Be1tN8sdfIRVWya5zzcuAKrYFc5NhUYa3B2i4GB0RmOdJuH3pZsCi+ExDpaXESk9O7UDACJcaV3slP8YnFXY9lZnq6YjCnT4RXumRGrKdEZ9WGFU7ZQNxokRyFNzT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4326008)(66476007)(5660300002)(6916009)(66899024)(8936002)(8676002)(66946007)(66556008)(2906002)(54906003)(86362001)(83380400001)(26005)(1076003)(33656002)(36756003)(38100700002)(316002)(41300700001)(2616005)(478600001)(6506007)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DFjPydKxraIO4K1QbyxoN4/RhPMOuIjom6E2P3sq2hCIm34aBMlYYvf5mdNY?=
 =?us-ascii?Q?HMooPmYqXJB3F5MpG98VEfAHRPbTSjedH2NjX3HKFXdwDbpH45Prf617PjBC?=
 =?us-ascii?Q?aIAeEQ8H9IYvYho/xYq3qKZ91Bi7F3Z5xESvDXu0TbLlsiGe8Ww7Mj35X93x?=
 =?us-ascii?Q?y3EUHROB2YUznA4JRQh9GHDA4UCgpCow50MX8HhWsou2ThMazScPSTcXDnbg?=
 =?us-ascii?Q?8hbe67v0vyf6xkszyycoitYwNfjKPowWmXpcP3i12bsA7VcD9eBklx32H56f?=
 =?us-ascii?Q?l0bybcQhExx8rG/NXkwaPeuGHMdw7TTZNVeHuwXwdCZ2YOOCFAhvI+f60Z8e?=
 =?us-ascii?Q?tCV2+pmOdBHfZOPP4OymkijbXibhbunP8Jfq4dmUw8Wi4ie+kwx9sVVXIfIH?=
 =?us-ascii?Q?OHsJ/WHhOiks7/LzY5b3f64J9IFX+mDdZpIxpapgOLa79qYrvzdQMxc/xFYD?=
 =?us-ascii?Q?AH7N2VVdJmsJ3FF79+kGMIHrCsObfjqHwlYA8yETjEUy2xqoIFWziRwopQh/?=
 =?us-ascii?Q?q9YGyv6VdhRzPhmJ/1G0pgyss8x0GDR7hSCnR1IiC2PqfWvDri7UiDAsc+gK?=
 =?us-ascii?Q?0TDELgEwX2J+7GeQRwgMIzKmlgGkFVQtoTTQP8xuNkxpzCVmXcWmmdSYctBR?=
 =?us-ascii?Q?tp/MoBdT1krZULrgPTeIsINijLRIzSLwlURhKn14Nf4rbBtQCu9wqrRd8aUW?=
 =?us-ascii?Q?Df/QcUUh0/c5RDsyyviThobQjRqprdVQP7JHOrQC4hNThfELpvMVqNSrV702?=
 =?us-ascii?Q?dx6P4NTxRbYUDJQxsRR1TYGfnn0lEsIbt2sDKMxZXQbLx5ZhS3KuhAQaQBoS?=
 =?us-ascii?Q?ss5PBAe2DIwhgv2IoBOk/f8qJuLfPOb5A6dizlFSuHq4r1veFG1EtLxJ8jvP?=
 =?us-ascii?Q?Iu1cizjiestqPvjijn390iAMdqZidbgXPwg8n+Qz3+FlEVzqJCjobewzRc6T?=
 =?us-ascii?Q?hgvBSuqzCvns9un7IFS7wStM9VVeciW6XBCHzoWK8bM94qPsurGNQXkJkNqZ?=
 =?us-ascii?Q?QJP3GJOqGYGkbZtA33DpJsjXGkMnD7OaV+FAMeciVaQY9ttOWSEAl7ECfT5O?=
 =?us-ascii?Q?8ZiPG78UqjOytKeVlXF1HNixqfrkCIVBGF7n6x38oSVWFmJ4ZyMIuXyGKZ9o?=
 =?us-ascii?Q?Z6fenTNGE1N1ZurzdJKwdwims3l4ogqBzaxVqHjFTD64n811NAOV0sJT8ghh?=
 =?us-ascii?Q?7dZVzOuzOvfY0JyQ0igAHfgqiRX6duPIGrbYQ4BPWnDgzoQkhDUrQAIdF9vF?=
 =?us-ascii?Q?Dk8FOJD7sfYrDpWpgmcsHSoKPnj4xG/ToAXHf5ekb7O17ttkoGc+2cJwlPUQ?=
 =?us-ascii?Q?Cr2hgMEZuaIZNh8RZlURIv9AJrDm2NgoY132P05pk4yK2VAUHptmym4968WO?=
 =?us-ascii?Q?+yarohCv+XFUzog9EnWqGsRJ7SQ/M7mXtaHYQ8j52iWQawGaH+2SqmFfquE7?=
 =?us-ascii?Q?GT1/DBoMm7zZqJlZh+cvcIDcF7Wsg7U4EmC8zhvkQlRkLdkAKg5nxjBoflj3?=
 =?us-ascii?Q?qBtTAvlxdARLFXNv1Ft7v/SpdSS/DE5fw+DiubRPYfIqq0I9wps+2dvkaoim?=
 =?us-ascii?Q?y7j6lfacrgzWqS9qajQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6e93a3-4ed4-4c28-e264-08dc2d866d02
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:57:35.8591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jP6jPse+oa1LZSGvxpd5cN+ft+bT/2KQbJgPM2NxG2sT2a9GrHIjgm6w4Btwf5UD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892

On Wed, Feb 14, 2024 at 11:17:58AM -0500, Andy Gospodarek wrote:

> 1.  How someone working at a distro would be able to help/understand if
> a tool like this was run and may have programmed their hardware
> differently than a default driver or FW.

This is stepping a bit further ahead of the debug focused interfaces
mlx5ctl currently has and into configuration..

Obviously a generic FW RPC can do configuration too.

We do have alot of industry experience with configuration already.

Realistically every complex device already has on-device FLASH that
has on-device FW configuration. Formalizing what already exists and is
widely used isn't going to make the world worse.

I'm also very certain there are actual problems with FW configuration
incompatibility. eg there are PCI related configurables on mlx5 you
can set that will break everything if you are not The Special User
that the configuration was created for.

Today everyone already deals with FW version specific behavioral
differences and bugs.

FW Vers + FW Vers&Config is also the current state of affairs, and is
delt with about the same. IMHO

> due to out-of-band configuration.  One thought I had was some sort of
> journal to note that config happened from outside, but I'm not sure
> there is much value there.  

I think devices using this kind of approach need to be well behaved -
like no wild (production) access to random bits of HW. Things need to
be structured and reportable.

There is a clear split in my mind between:
 - inspection debugging
 - invasive mutating debugging
 - configuration

And maybe "invasive mutating debugging" taints the kernel or something
like that.

> With the ability to dump regs with devlink health it's possible to
> know that values may have changed, so I'm not concerned about this
> since that infra exists.

Distros need good tooling to report the state of HW in distro problem
reports. If something is lacking we should improve on it.

TBH I'd pick "report current status" over "journaling" because devices
have FLASH and configuration changes can typically be permanent across
reboots.

Also, I would generally frown on designs changing OS visible behavior
without running the device through a FLR.

> 2.  If one can make configuration changes to hardware without kernel
> APIs (devlink et al), will people still develop new kernel APIs?  

Sure? Why not? Every vendor has existing tooling to do this
configuration stuff. mlx5's existing tooling runs in userspace and
uses /sys/../resource. *Everyone* has been using this for the last 15
years. So whatever impact it has is long since baked in.

> I think the answer to this is 'yes' as realistically using default tools
> is much better than using vendor tools for regular configuration.  

Personally I think the answer is more nuanced. Users have problems
they want to solve. If your problem is "provision my HW from the
factory" you may be perfectlly happy with a shared userspace program
that can do that for all the HW vendors at the site. No artificial
kernel enforced commonality required.

IMHO as kernel people we often look at the hammer we have and fall
into these patterns where "only the kernel can do abstractions!" but
it isn't true, we can very effectively make abstractions in userspace
too.

> if vendors provide shortcuts to program hardware for eval/testing/debug
> my experience is that these are not acceptable long-term.  Requests are always
> made to include this type of changes in future releases.  So I'm not too
> concerned about the ossification of kernel APIs due to this being included.

Nor am I. Users will ask for the things that work best for them and
vendors have been historically good at responding.

I also look at RDMA, which is deeply down this path of not doing
common interfaces in the kernel. We have alot of robust open source
now! The common interfaces that the userspace community developed are
wildly different and much more useful than what the prior effort to
build kernel common interfaces was creating. In fact there are now
competing ideas on what those interfaces should be and alot of
interesting development.

The kernel common APIs that were developed before turned out to be
such a straight jacket that it held back so much stuff and forced
people into out-of-tree and badly harmed community forming in the
userspace side.

In other words, allowing userspace to have freedom has really pushed
things forward in good ways.

> So if there is general agreement that this is acceptable (especially
> compared to other out-of-tree drivers, I think a few who find this
> useful should sync on the best way forward; I'm not sure a separate
> driver for each vendor is the right approach.

I also like this, I don't want the outcome of this discussion to be
that only mlx5ctl gets merged. I want all the HW that has this problem
to have support in the mainline kernel.

I want to see a robust multi-vendor userspace community that houses
alot of stuff and is working to solve user problems. To me this point
is the big win for the community.

If we need a formally named kernel subsystem to pull that community
together then lets do that.  We can probably have some common ioctls
and shared uABI marshaling/discovery/etc like nvme does.  At the end
it can't really be abstracted too much, the user facing API is really
going to be "send a FW RPC" like mlx5/nvme-vendor does.

Honestly it will be easier to discuss and document the overall design
and what devices have to do to be compliant within a tidy subsytem
with a name that people can identify as a thing. Naming things and
having spaces is really important to build community around them.

Certainly, I am up for this. If you have a similar usage flows I'm
quite happy to work with everyone to launch a new mini-subystem. If
other people are reading this and think they want to take part too
please speak up.

> If upstream (and therefore distros) are going to accept this we probably
> owe it to them to not have misc drivers for every different flavor of
> hardware out there when it might be possible to add a generic driver
> that can connect to a PCI device via new (auxiliary bus?) API.
 
Distros often prefer if they have less packaging, versioning and
community to deal with :)

I'm inspired by things like nvme-cli that show a nice way forward
where there can be vendor plugins and a shared github with a common
shared umbrella of CLI, documentation and packaging.

With some co-operation from the distros we can push vendors to
participate in the shared userspace, and we can push vendors from the
kernel by denying kernel driver support without basic integration to
the userspace (like DRM does with mesa).

Thanks,
Jason

