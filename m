Return-Path: <linux-kernel+bounces-131907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3AF898D78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EAF3B246C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9101812F590;
	Thu,  4 Apr 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EuNjKIZE"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2119.outbound.protection.outlook.com [40.107.244.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9A130A79;
	Thu,  4 Apr 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252858; cv=fail; b=Z+xlFG6DXKxUObD3gmJN2x8DXODxwF9+vo5OczX7J5+Hzzbdb7bwdm8S8Zf+5j2IftONfTmUTx69jzb40f5AGKdLWuWgxhrsQ5B/SsJIQT7P/Se/DOlMVpZuTbRL6tbTTnpXbyBiOxye9/y2wyPSjFw9684uMz13RbGAKJo4Eoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252858; c=relaxed/simple;
	bh=sViG2C1LP/9aQ01le6cmbRXM9CBfzrxG1tii7dM/S+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mweAmvNR6h5g4hVdUa5xJbRf05Y0q8j8pD9qv+WjgLQ5HpxFPa9xWxT2JGawkQxMx/BeIbMU7JzjzQLts8eLJaMBEAwFzAAtA8kpRI9/QvmHtePl8Ce+qCotK+iLNKyWLVnuE13FZ/tz5whBUNJNt00yLOITFgwZLxzwydTtSuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EuNjKIZE; arc=fail smtp.client-ip=40.107.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dax0qgIAQB+l+xNoLzSD4nb9VgRdW3rNjj0WxMBd5ZxMyqCECaKyquhaiOeWlV2SO/5GmGBjahGT83ND5jp/X9vuRVNXBlLPLk1HK0yqVyGL43fvcW1JoZMzjqRXFdBFvLfsbv8tv6B/PSV6CdpU6R2J8WSJ8ZOv/tf1r4WfCi+9c4be7EbynbNKXKzS5m6Fxf8icbH+G1ybtiuK5p0DbvnbUxdkWQ+XZ/saGRIqwBQsQcOP2CFsdkzmY1aKRY6AaaA5/c4FLO2eW9aaEF5+jrEiVUFBZmUxwYg9d8Sqnv0NYueJdSAc1tNz4OcmY3igKiScSIG/eXONKkgsa0cywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7kKxurETM0YQrWvsMPiQ9buoAz6EA/a17VtAuLVAbM=;
 b=eCFotiOBxpbjJEaX0HT6flbUL2g5dSL7m5nKomdpilkajhzQ9XD+qAWQrZ7QS8iLRhln4PnYbPnTsVEElV2c0FkXCECCFe4Y5a/6e866Eida//OJRXqCP+f7AbSzN7asAryH0+RVY+rx+pEupgEA6CVGO7X6blRYcIYyWlOx50NQt1i4SkxPE3LWuIdYATSqSC8JfHAi2N0ezc0GdNEfKprW8qFeH8E2u5zaoie9JZjj3U0wdD3SESnj7/j8Zbq3NuCiQT7d+/hoQq/a6GdH0zJtu11HUpSx6CYQz5e7PiLbxgYRg/ytma2FSjD/36KXjPxzf3468yHCdNr3Th/HqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7kKxurETM0YQrWvsMPiQ9buoAz6EA/a17VtAuLVAbM=;
 b=EuNjKIZETGZEtlYrx/ySTWJGhrmeXN9tyzUbbMwZVQVSGSROFIbqXp/qbXzn9HgE7e9lvR4+WL8eTCq5BXy+DUA3QFSnLqOMgoQF4z0aMwXIJqM9TXIsuZFwpdoJOGQllIStHznegZ+wS8g68+6edr2YUrPojuxJEenMY/k4V7YliRLW+I7dQzzvSqi+f6AnKIpH3vbyvpLJuNCKdBjiJ06mBXEPim90M2O6zcQBfVXEQEJSZ+579xq2AilqxygFL4+MbwuP9L7tjcTksoYF/9hr2qIkRBMOGtKXn6IVJpQ6kKI9BVvMmUh4ygXC/qcXXAR7A9wBqq6OtT1QLcYORg==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 17:47:30 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 17:47:30 +0000
Date: Thu, 4 Apr 2024 14:47:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
	Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	linux-kernel@vger.kernel.org,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240404174728.GL1723999@nvidia.com>
References: <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184832.GO11187@unreal>
 <cefa2b9a-4227-969e-d31e-c19a552b9c1c@gmail.com>
 <20240403190012.GV11187@unreal>
 <d75ee9d5-36a9-4056-a0f3-0c05b2e744aa@kernel.org>
 <20240403170149.7d2b8f2b@kernel.org>
 <20240404122338.GI1723999@nvidia.com>
 <20240404074850.19ecd52e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404074850.19ecd52e@kernel.org>
X-ClientProxiedBy: SA1P222CA0112.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::25) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ0PR12MB7006:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nz58+M3o/gsWyEEck0mH5eRPDoL2bkFzVEkkwnAyhQkGrS1mDHddgc3D++/1M8CasWww8vXrceoRxtwC4SIpGt0Fy0LzefaY670otMgvtNNI3YUSeJndzqNFpXF4izC/MbRVFyu8b7avXlSVXo+4m0UDlWdw0g9YLSxBRwbncDwFVj87lZvc25NrsyCdtkyVbThM6mYBzayEIWDisVkJErrguWRfkQYvLSzYrkUMbAu5QFs1mvVCAY7rXVlmh+z43+aqWLtxXjR/equiyvUIcjlDxsZWdTWy1jiVT3YJpyvckqZvVqfvgSvH2L+NgqWF+j35Lh0H5S5c/eyJBQTTcmriH+5+wsBMjqsa6kNH4M8OQjo5Np2XHAWVMR58JnEd8YbLnuwIzMEXQSmi+AOjCcUTDpF/MMJwVTgq3sep5fqLVdPhZJ/6N/x5/NpXUGKrc52/JgU2REpIyaAQjiAnl4c9zw/qzTiY7BFVrdEoy+MGLEajO08uXW+ahZPuWsYa78UoKumxSk591MpcFWtl5ph4fEMio2jY5GOr2uSFS/0uLijJwsVk4R0E3O7AFQdb1CTX1WYIgeYh9qyr6BOS/YQ2pNfkfn68YfePAzp4fcMvgr426oMRaNL7NIvJscP2XhR+hoEMoJAuB1mp5zEkMH7bamBygVv2MkPeeIQEOao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SqRC58/kOEcvh2Tz7OPuNDc0y2ABiTRT+z6ykZPQJdYSrRYvxF5fe+UOLs1E?=
 =?us-ascii?Q?HT7KUyUFjF7N3zLP+VSaauUxi07dOFOhKGZuEpGWBW//ivux8ZWxXlQEHhuR?=
 =?us-ascii?Q?9116OxaNXhw0vq1JwEx70O0vxPhHQDPg2iDL2M5yHhwbx07dQ/CsNg3xMLIv?=
 =?us-ascii?Q?YSYuYAIV4F2bKUGveH+Mtq4wHhE3kiFqxsxeiEeMKVzIxusmrm4enj4PlUlR?=
 =?us-ascii?Q?9uU3D5Bs7FGQ8R+mkDmXedSHxND4Upy2SZhwm3TI4FvPhHRheGoWYqrzP8vd?=
 =?us-ascii?Q?ms8SFpAazGKtXjZNpOS8huW4S4Z63g/8SZsf7gFDkrtGmCanV0hlonL/1FvL?=
 =?us-ascii?Q?FE1O0x+/Bitm4imOkKOrr2bg1ILItvRj7Qbz5hxdseffZvjRMqiuCgZlueco?=
 =?us-ascii?Q?6dQQ+k1Csl4D4M1lSYeTZhHcpgStcKtVyyznk8aja0E6uFVc4Dldc+vxOFNk?=
 =?us-ascii?Q?6X5KlvT/mLwLhGuXU/L9NnsbsjiWdWcQBHhwUS9UKjm123qpIud0kuSlilVD?=
 =?us-ascii?Q?U30d/ugfrvaK3J7rwx11r42z7YaIDpMPNkKFQpQAP4679ZW4d1dzOLzv/wnC?=
 =?us-ascii?Q?3pwgT8T4AJAb6Zhso2O/oaWvYJFJkOfQPCMAQn7mzGDCV22Xj8q9p+P1npST?=
 =?us-ascii?Q?VQVVIvZZBCnffege35LrlRUTeWsFUv39eHOKy56pywNNShPvS819CXFsaWFh?=
 =?us-ascii?Q?7YShoEwhC/nZTynmrddNUVlXWGjNcP0wckvBteWnHErAFlOJRm5hAHnWSpeC?=
 =?us-ascii?Q?W++/l6QlXkuGhu+fNCfyfuvmrQyGwYMqUomZ4IVWlcWTjFbteCx/0sJYTmBi?=
 =?us-ascii?Q?eKjPDxiepxAVoxMFxbHOqicTNBFTyN+J3vkNAs1v4/sSl+mjP4hp1dfAfBHW?=
 =?us-ascii?Q?/eDpFKJ9k3UDEPytvbgLKoQ02CWY5OsGR4oogD7UD26PsuRJXQWR2wGbKDMq?=
 =?us-ascii?Q?XbNlUfaKzUBP4yiaROFOrfkQVJWt9MiqLi06MpDjLO0+fij6boeAWVON3ICy?=
 =?us-ascii?Q?nw6akw2G2DJY3gX/PY2DTJZLIiXt1ZzsrpROljt7387PF/0ybMQbtoEr1UeW?=
 =?us-ascii?Q?BsSlxmR5J0iwkHvRkalrSCJEONCoS+KHbEZ4G4W1h68Jq6F0IBreWzdBrkdw?=
 =?us-ascii?Q?DlS393FaGHSWl+/WZBbjrehFHmXGMdSMzwyH505npg+M8qokmfRUAQEFTrbH?=
 =?us-ascii?Q?qaLJ1700BVYETIOgITiVpgXpYEHVRifu5RqneYAx/KgGBo8P9LInX2k3S/GU?=
 =?us-ascii?Q?FWCZ+0q4YzIeNKzV0CKDNjSFomm1epT2BXGF1E4Arwvc0fF+WUSI0+cOQSbz?=
 =?us-ascii?Q?BPGzWrbCZMmFsAJOQOWWsiYHejvpdV1amE/SlhLgarfNxxO3fgjjy3Tsni7b?=
 =?us-ascii?Q?HHgbacrQOa/u5lyRV0KOVGKP2PpMUZYkeeXpCEWByS52bhYNwx+VOuAIiZ3D?=
 =?us-ascii?Q?50GJjUMlnBk8J0SiGF8CeuF6aMfYnX2kKgLy6SiVTdP2acCXQoRHXJKdrPZM?=
 =?us-ascii?Q?NXErP6yjUv38p86iRoqK7f9zZpES73T62jnIb6wrmjegrrfskGKkJuwbiv0x?=
 =?us-ascii?Q?CUtkB5WpZ8d+UEZDrV3B4ybTECr4z+eD6rrJHFBE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45eaf2f-a72f-4ca5-0f41-08dc54cf4c93
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 17:47:30.2012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nDwOoHUft9SNPMyXykOXNHsDm0yXn3F5jbHoy7g97sNgfth+ioaEjLzbg8A/CLh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006

On Thu, Apr 04, 2024 at 07:48:50AM -0700, Jakub Kicinski wrote:
> On Thu, 4 Apr 2024 09:23:38 -0300 Jason Gunthorpe wrote:
> > > "didn't understand the discussion" is an ironic thing for you to +1,
> > > David. After all my emails about HNS3 RDMA you somehow concluded today
> > > that I want to make rules for the entire kernel:
> > > https://lore.kernel.org/all/6faa47b0-27c3-47f9-94be-1ec671d9543c@kernel.org/  
> > 
> > What if (hypothetically) I tould you that the congestion control
> > settings in the device FW impacted netdev sourced ethernet trafic as
> > well? Would you be so sanguine that RDMA should have those settings?
> 
> We can lawyer the words until the cows come home.
> The team I work on takes care of both RoCE/IB/pick your fav proto
> and TCP/IP NICs. It's fairly obvious what is RoCE and what is TCP
> or user UDP when there are no incentives to act otherwise :|

Sure you can tell the difference, that isn't my hypothetical. I'm
asking what if the people who designed the device choose not to tell
the difference?

> > > And I second what Ed said. I have asked multiple vendors preaching
> > > impossibilism in this thread to start posting those knobs. I offered
> > > to do a quick off-list review of the list of knobs they have to give 
> > > a quick yay / nay, so they don't waste time implementing things that
> > > would get nacked. None of the vendors bothered taking me up on that
> > > offer.  
> > 
> > As far as configuration/provisioning goes, it is really all or
> > nothing.
> > 
> > If a specific site can configure only 90% of the stuff required
> > because you will NAK the missing 10% it then it is still not usable
> > and is a wasted effort for everyone.
> 
> (a) are you saying that the device needs 100% of the knobs to be used?
>     oof, you better warn your prospective customers :S

No, I'm saying I have 100 customers, 600 configurables and every
customer needs a partially overlapping set of 30 of them to be
different than the COTS manufacturing default.

I can implement 30 and support one customer, but I can't support all
100 customers without all 600 knobs.

> (b) as Ed pointed out some of the "knobs" are just hacks and lazy
>     workarounds so we rejected them for quality reasons; the remaining
>     rejects are because the knobs aren't really device specific, but
>     vendors don't want to extend existing APIs, as it is easier to
>     ship "features" without having a core kernel dependency...

Which is back to my point. You are picking and choosing what gets to
be supported, and the end result is none of the 100 customers get to
actually work.

It is overreach to demand that the devices be re-designed as a
condition to be part of mainline. The configurables exist as they are
and need to be supported, in one way or another, by the kernel.

> > You have never shown that there is a path to 100% with your approach
> > to devlink. In fact I believe you've said flat out that 100% is not
> > achievable. Right here you illustrate the fundamental problem again:
> > there are configurables that already exist in the device that you will
> > NAK for devlink.
> > 
> > This is fundamentally why no one is taking you up on these generous
> > offers to pre-NAK device's designs. You made it explicit that you will
> > will NAK something and then it is not 100%.
> > 
> > Saeed has said repeatedly he wants 100% of the endless configurables
> > in mlx5. You have the manual and know what they are, tell him how to
> > get to 100% in a few months of work and I will believe you that it is
> > not impossible.
> 
> Sorry, are you saying that I'm responsible for a providing a solution
> to allow arbitrary vendor tools to work and proprietary user space to
> communicate directly with the proprietary firmware?

I am responding to your remark about "vendors preaching
impossibilism". If you want me to agree with you that it is possible
then yes, you need to show a way where we get to a point that users
are actually able to solve their problems.

Otherwise all I hear is how you are going to NAK some unknowable
subset of the needed configurables. Sure sounds impossible to me.

Jason

