Return-Path: <linux-kernel+bounces-121659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0952B88EBCD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9C31C2BF91
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2890E149C57;
	Wed, 27 Mar 2024 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gaEPcowU"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA7D12EBE7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711558680; cv=fail; b=n9UJ9IaUeN4DFj8IqQsvoy8GMdF/DaYtdyErt96IMRwL2XZecSZzx2H5Vb4Pyf38sFj6cqnSN1nKRaGPllSt3ibxpVl+69kiRIXFGAy9emrIihFKD+yTPMhbv/KeUx4D3b1UUH75gjl9H4dgPCld+xgdGbY1Zle+P++rpUWGdO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711558680; c=relaxed/simple;
	bh=DqErITtunagzlr78oZLQXE8C5kqAWMh1jfY1H2KiKew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=czS3XULGXRSOzJlc07RrU4VmYVydQTnuyT7BDjk70Qm7aanJmscd8sQNADwr6GvqVsYE0fmhZkCZx/VERTwv2hi92fngzeiOwbTJ35WUembbL/07SsnawtW9vbLHHJw/X1Y21ZMKz0vlRSpmLCl56rxFO5/x1R8R/P75QrccpQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gaEPcowU; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz8p+80xrwTK3+fJhz9kHzazJysneXsEVoXcVuiSS7CCHwRaHIY6S5KxoTv9IN/ypHtY1Vf5mYc3fXexwptK65pIuAPNtuYFF1lrHOIRVsGNb355g5HTNcNyUH8mzjUOtng+XaVOqzmRpms6IH5OJPkK8iwSDfr2NXD8W+OZj0VJMd8V0bP9hTPh8R08cPGJ4LG1HK2Q8Lg/M3VoO1cKrPdkL/f+xzPsMMFefIDgwumHVcRcWODEiEq1DT2IYMTABOdYuBCW93z04Zgsl5EM1+IbaGKsZH53L5jxyh37jRA/IHQv3QqoDbg/ldvJPNQ064PifG76wgZfMmzpKfUuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCQhU37QYQOjMz6CJgPpU+krFxTpkd5EvI+bNS/3oUM=;
 b=VMqzmZKMOm64Rwg5y+hT9jI18PeFmUJcMuRCGGOE0FFQJzDQSZB5fSVGz4ebV21XDueRBufBVjyU7YcSgN3RWU3guKVPglQZVA5I1cKVyjrZDb5Me+EFSIli0Jd0yQPkf48ff7KPfODMfK/ateSyuopBDTcdpG5wY8gO2RmEP/slvKzcu5upZfw3cr7Z9STsd944uq3KiMFC2zw4VnSIfXSpR/ETCQtuVZp3JXJ2uyH+1ZeR9wGwYDbloCf3uGn21b7EeYEMagqUuL2vdYL4udReGGxic1RmEVm9+XcFZ/RTUwkZ/tnw7GCB1v6AxKjBYVcVBj6/9PTnZwALc/zdHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCQhU37QYQOjMz6CJgPpU+krFxTpkd5EvI+bNS/3oUM=;
 b=gaEPcowUXcHDE0nMm3AnXzCJ3qqCQnnU5fxyO2R6qddcl2oBEvQl08SmVONcdp99XXnyvsUWI+Teffg4ycaMVw5HnzgLT6QxKcUyRkXYWECkZ7m7Jfqgwh8cydCm9TiPlB9jC6+qqGWpapLfHJBtGKlqwBaRpc8Od+TBf+/pV8Q3U1V9Uf+PWjeKpDTxIu4AYxeOTZVmKDaLVCjU5asKXFm2AQJYSWCane4PxWHE1WNtFAcuTHkOTV2skHaoM/Bx+CxrZIHCGYFkO7TZFky+9BdkoCJqfElPDfzeeRfOCvef1nUJqvgKJ4kaAGJvjXMUtJiR4Qb32lQAKIwMM7j3Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 16:57:55 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 16:57:55 +0000
Date: Wed, 27 Mar 2024 13:57:54 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 1/8] mm: Provide pagesize to pmd_populate()
Message-ID: <20240327165754.GM946323@nvidia.com>
References: <cover.1711377230.git.christophe.leroy@csgroup.eu>
 <54d78f1b7e7f1c671e40b7c0c637380bcb834326.1711377230.git.christophe.leroy@csgroup.eu>
 <20240325161919.GD6245@nvidia.com>
 <6e16e042-0143-4a52-b4b7-09cf0022bc3e@csgroup.eu>
 <20240326150118.GI6245@nvidia.com>
 <9703878c-c0b0-48ff-a356-d43e8f7391f3@csgroup.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9703878c-c0b0-48ff-a356-d43e8f7391f3@csgroup.eu>
X-ClientProxiedBy: BLAPR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:208:32d::14) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: 4168e448-ebac-4e51-c2b3-08dc4e7f0c1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qqI1ezaBmCrs6j15bti/7D+7u7bs9Vh954rvvfbh3FqY0YKiVMsz+9C2aonwlk9w1kp3UjSqKguQBhtnOzMpT874ywoq5eBE2jzoX7Pbf2lGKbsLwcykGzMicJC9btvLsNisSyK50ZIIGnmkBP5lLGFiadPQ/BjqrAP3wEGHKEPqJt0uFpYFbsnF1Mq7wWZm/JX+2F6I236sPFGJxWP3e0O8baqh7DPGhH1tZTT1Xu/EbnKvsE1Jp7jd/TpE9F55Smo7gKqrNZj6exrDM2xCuJu4GnG1Z2AEwhLbJVU6msyDPN/6Ue2HCYPNSRa5EKcT/MDNCO7azoR5gyFny7CocDVbgRGGoMxnAaw3GuyOz+a0LOQ4bgy4WTIOclFdXCfg9Dt1zth1cCXWktpn+wokHnzsLO/6t/pQhROFjlNuuX7RkXAjGTQgEUI8HQW0nSrU7UC/Hrn5qGgrvpXVrue7BooCoF/jmBnnFmf5TYUmqXoiTKJbuMpnsBJL3K/iBDvqdRpGDSUSdJrGNL05OAB0YS+z/W07IkH1uzsSNv3fMrM0uU65pu7IpnKytGTe37/jrGuGJTKG/Ix5yB1wXRGOg91525LIOwvunM1+HCiKelpi0CJaUWPRLqlkJlBEhJT0G38pDPSV/X1GMJMgiZkJiiwkgQYnp3vDFOm2YczZmf4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UFcX41rQNJOxi+P7L3uCouOW7O1GOq8HC0kaCjvUs9zQadcbWeTlIXtlOQAF?=
 =?us-ascii?Q?PVk+iewfjMw2nxI09UicHku2ORH3FvEeW42hn8hEG2F4QcZxItYuWJQuorYk?=
 =?us-ascii?Q?ascN4jmg8xjxF5rX65mT7a7Yz0ietLKD+2zRi/mt8R8aBmdFiBszi1qdO24m?=
 =?us-ascii?Q?vyBbcTpC5KPWNwNQ7tEzFCxRrVdhH0pv8i979a8v7Mwtu5Za7y0MTzwACUb+?=
 =?us-ascii?Q?e90+rNvqxwhFBI3ot7MMOCnv1QIHXugiX+0NNWEZDp/ARshhkw9SdJj2CT0J?=
 =?us-ascii?Q?P3pCTnu+gHDkcw84BtwM5iOjsTMb/o9hdbt3Kraxq5pnNNhOKX/wKfVOu7FD?=
 =?us-ascii?Q?iookODuCL1VMGjpEQwsw81jcdMVH3Zo1ORHHotHpDpczljNX8ehcBA4gdogf?=
 =?us-ascii?Q?4tTLF2A9K2+a+ycBRaizcUPIMy1DIE6gGJTU/sKsBq5g8jxqjFl6KxcPzL7H?=
 =?us-ascii?Q?SbJBGFgBSnO0+NIeFQ6YOrA8JLevkUSf76BTaWu6XotmNPxy2NTyKy6fXdIb?=
 =?us-ascii?Q?yQZ5ePacR4nOEVfHR+wMXD6kb8AMggm1zkYvfOmlt3mPArmo25nfQA7o1Nla?=
 =?us-ascii?Q?VnAPYLDZm/5Oaq4sJCbpB/M91rrLK/QOIuL0JLH6I9+0hJ3+KWWG0zFJF3oB?=
 =?us-ascii?Q?jeOdJ7Opn35wyu1Pe0PfqCnI2XOJskpGDvf/1K1f/h1qHeaonn+qTaSRLb8d?=
 =?us-ascii?Q?/Z3czsM8zMlLR4UMiRbEgblP5yprauQFoEfDUSweE1C64la/LS0oqVAeDWGO?=
 =?us-ascii?Q?NNQfjFn/AAcXp++/A2J3J4NRvh7eI+taZkLlLlJ8cuYgxPtgu+/IDkd04pMC?=
 =?us-ascii?Q?94PkTbT4gB4eAucbPrqFATHYIYKK7CBbgwjnS1T/6ZU2w6h/PtOVf5ig2tmC?=
 =?us-ascii?Q?aSrUvHve4t3A7Su4HMOtuVANBMuObI0Z3OfTGeynM/NOXeJVGQNaSAfNloWo?=
 =?us-ascii?Q?y949y+NGt8mtnTg1v+qTsGcB8Pm5IqayKqdgYis9be0ctngb6bU0EDl0L3Hh?=
 =?us-ascii?Q?slpDKuUMMp0PHvt/jXeR3GJeVW9/A+Q7BUrx84ln1FP3eu8YaYL+da0nWA+w?=
 =?us-ascii?Q?q5gSu+1N/zgNMX6a8B+6LkBbg3BK9TBISsBaXAAn5Y1DB+rydqW1Bmp1C7mO?=
 =?us-ascii?Q?DL7oXjYdsCsVjjwqVL81+k3JS2NiApG9Rf965akg97P/Wl2RSYmeIC51NBH5?=
 =?us-ascii?Q?OXjlseA6GB0/02w807SQiQA6hS3Gbq+I/ASQtCrC/P4hJJjDdG286cCV8Eng?=
 =?us-ascii?Q?uws76d+9U0M8uX1EKayXnfRkGQ+xqBlOFyvBSEve3H2dUobex1zNiU5PYxAD?=
 =?us-ascii?Q?HLMB5uqzF08FTJCZC+8gid3ZX+10N+xRjm23t6uXtQHbmjXBu4OXMCKJVceA?=
 =?us-ascii?Q?Dv6NcEROKi9kNOadSZcv5lXWEfLetT5u5rjO/XrbE+t6R9a8fytJi8R6y9TI?=
 =?us-ascii?Q?Aia9R6ufsJMvpjUEAJlJ5RnR7WHEkU8hFl+ecONgv1i09TbdMpfrmOPhjYN7?=
 =?us-ascii?Q?57gDT1w91vi7slokJYdtrPusdQ+pPJqGjUqs+bDx0zsLEkWLeEWQjsrTGTy6?=
 =?us-ascii?Q?CeR6pcT/Qt3Pv3tZgb7Kyc6uGiJteqWgphC8CMDu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4168e448-ebac-4e51-c2b3-08dc4e7f0c1d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 16:57:55.1915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/QQTHNKIUIFS5bJVUKR0YeWZHtqKJ0dTkn3aXZv6CBjUV/Joibr3x9+J/TSxbj/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423

On Wed, Mar 27, 2024 at 09:58:35AM +0000, Christophe Leroy wrote:
> > Just general remarks on the ones with huge pages:
> > 
> >   hash 64k and hugepage 16M/16G
> >   radix 64k/radix hugepage 2M/1G
> >   radix 4k/radix hugepage 2M/1G
> >   nohash 32
> >    - I think this is just a normal x86 like scheme? PMD/PUD can be a
> >      leaf with the same size as a next level table.
> > 
> >      Do any of these cases need to know the higher level to parse the
> >      lower? eg is there a 2M bit in the PUD indicating that the PMD
> >      is a table of 2M leafs or does each PMD entry have a bit
> >      indicating it is a leaf?
> 
> For hash and radix there is a bit that tells it is leaf (_PAGE_PTE)
> 
> For nohash32/e500 I think the drawing is not full right, there is a huge 
> page directory (hugepd) with a single entry. I think it should be 
> possible to change it to a leaf entry, it seems we have bit _PAGE_SW1 
> available in the PTE.

It sounds to me like PPC breaks down into only a couple fundamental
behaviors
 - x86 like leaf in many page levels. Use the pgd/pud/pmd_leaf() and
   related to implement it
 - ARM like contig PTE within a single page table level. Use the
   contig sutff to implement it
 - Contig PTE across two page table levels with a bit in the
   PMD. Needs new support like you showed
 - Page table levels with a variable page size. Ie a PUD can point to
   a directory of 8 pages or 512 pages of different size. Probbaly
   needs some new core support, but I think your changes to the
   *_offset go a long way already.

> > 
> >   hash 4k and hugepage 16M/16G
> >   nohash 64
> >    - How does this work? I guess since 8xx explicitly calls out
> >      consecutive this is actually the pgd can point to 512 256M
> >      entries or 8 16G entries? Ie the table size at each level is
> >      varable? Or is it the same and the table size is still 512 and
> >      each 16G entry is replicated 64 times?
> 
> For those it is using the huge page directory (hugepd) which can be 
> hooked at any level and is a directory of huge pages on its own. There 
> is no consecutive entries involved here I think, allthough I'm not 
> completely sure.
> 
> For hash4k I'm not sure how it works, this was changed by commit 
> e2b3d202d1db ("powerpc: Switch 16GB and 16MB explicit hugepages to a 
> different page table format")
> 
> For the nohash/64, a PGD entry points either to a regular PUD directory 
> or to a HUGEPD directory. The size of the HUGEPD directory is encoded in 
> the 6 lower bits of the PGD entry.

If it is a software walker there might be value in just aligning to
the contig pte scheme in all levels and forgetting about the variable
size page table levels. That quarter page stuff is a PITA to manage
the memory allocation for on PPC anyhow..

Jason

