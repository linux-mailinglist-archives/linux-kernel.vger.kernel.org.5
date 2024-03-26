Return-Path: <linux-kernel+bounces-119253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE45988C630
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722213062E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495CC13C806;
	Tue, 26 Mar 2024 15:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AzIwzKYo"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2096.outbound.protection.outlook.com [40.107.94.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5713C683
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465287; cv=fail; b=J+BaSGARbuyyKzGtGnTg4MHBvl5img1LZJzzUyU2G6ea4c/ok3sPLRH5S9wnFNfSP20RTnsvBONLukE2gQp8SZzwdkq0b1wlPY39wKZped4CFLuWlIMvSBV0A8Bf9OEQF41J5WJfwoR9Ka3903c2vDNiDhnGai+Y70dsh6IGoG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465287; c=relaxed/simple;
	bh=eI7ijINAmGV5QpMXXHfpeTEGXYWX0G5pF/NeOjeim40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ghn2ZwAewWsM9IKHUSkDLzDmJDGouDfnbSzDBw2fKqWMQJj4w80qt9gn/4CNLGu7pThN4t5n3PdmO4WCUScsfLyglS0HcMtoRP6JE/cDHOtf0m7fLab5z1HKR4pbN1iVhbR+2UntecXNOMmW8EzKzxSodnEn0p/AEaVAEH6yt+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AzIwzKYo; arc=fail smtp.client-ip=40.107.94.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QY1Nmg5bdAPpix/Cv+74S2PJMf1f9XvwoyEbHTOvMG37mrd94Be/4dwAFxAKUCoNGlwzinr94DBblVX5sDcmJJsQjQy104PtUT7vYU+f53tZmpVxzcNkhyFdgv5g+X0siGnbo5svHbYuDueX5gRN+04vFcH3AEzSM5h/Oq8LW8K707Ck32ULSY6otAecqGsChxd3e+xAI3+3Sag3MQdahprEv94Ay2Os5UZ0REk7GbcCuWDpy33kTyHqgKiOdECgMtcRJHavJetpXR8qvG9QgCYxZEp83L4Apc+G6hmLvpd+IFiKQP8vsV6knLU7dzN9HJNjorjxVsIyTRJmruuq3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIBoei//BfDnZeMNg9YABkJNGg8n7I+ShdQoEZxmHFQ=;
 b=ZWgyFvxYzz0+eRToDo6mLRFUnbuG5Nx/LC3K0LQqUggtwmMqvufVj4pCh8BSXb7ksAHZ4Eedyf+cYUTbrs4vLiw3IiE5ItyvxaxHBGt+ODlSIoEgc8iflKjSsuJIh0TlLyPxBSymSNfjkhWzfq/q5x1P/Gq2MCdVJIn7It+RBiDBa0xPZKsPDRLQV7Nw5iGi1BgOotYx2rDN9AOC4rVBVdPN7Hdegt/xE7Q2nuRYRC5TsSNM1RtFBqUTYf1B5T2fbAeGikll2TMWuWbjsaySU42F2z1QwRwonqsHNc0UH4DQZzqbQSKwcoSIBs1vf9R8JfUqmZVWRpsDVmdZu1HiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIBoei//BfDnZeMNg9YABkJNGg8n7I+ShdQoEZxmHFQ=;
 b=AzIwzKYoleKG8MetlOmQibKZRhyN47nY8Pj/gYhdLNn5JkX3nl+Yk/LJP2bqbYUFMdYX7I3EuUXqIzof3zSzKuTH9tM4J31fnrBd47bQpu48pDlIhyuiUMqmMfDafgBpKJcRRf5PCw0Ynoq8yeVjpwKfs4PXJCyKFijp1pQWSHsTlSUqJzHYKDiWqndWAtHR5bOyR0XTXweIpTlrgNYWm1pAdGhHlM6ddsDHjjCXkHZyqOjhCPmDwQK1TqXfB807TkRqFvw3o5X0M4c9Aq/sJEVH3SozazJZMEhO6IXLWfi9rUhEmGAVAeFOGT9neXxpCmA9lQ1tbdx+nZopmsj8YA==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 15:01:21 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 15:01:19 +0000
Date: Tue, 26 Mar 2024 12:01:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH 1/8] mm: Provide pagesize to pmd_populate()
Message-ID: <20240326150118.GI6245@nvidia.com>
References: <cover.1711377230.git.christophe.leroy@csgroup.eu>
 <54d78f1b7e7f1c671e40b7c0c637380bcb834326.1711377230.git.christophe.leroy@csgroup.eu>
 <20240325161919.GD6245@nvidia.com>
 <6e16e042-0143-4a52-b4b7-09cf0022bc3e@csgroup.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e16e042-0143-4a52-b4b7-09cf0022bc3e@csgroup.eu>
X-ClientProxiedBy: BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::12) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA1PR12MB8986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lBGMVJ1i782Kj62nCHvTDoSeSRlfHHPLmDVlP7J7vsJxRkRMCGq5xxLf1euUWbNd52IzPH6UR7AI4nMdA8P68KyiqpPmcuBF/4eQJjK8XnYaJ0bhNO9NUz5y3y8GNn1tFSV5fVlSSoomf7lkDM+yjxb/AbV+6IySNnvCg68iNeg024JoPLGR1y9x0sIr6H44XbNecvAA/Id+2/NRB6Ehow5IQVxIBEaPTBvpg+pC3pByIND76Xh+Fg4qadhmFGncYVBIriZb+CFYLqS/NYu5U8tR4FEez6FKUX8covmxoAXNCiYHRD3r6K6yuKUGFTb8MM2gNuoFBARpKlbsXhhlaXnWGqhSwRMC8WiTPHKTTXqR4yPV/zPUvdK0yCyR9pciBb0qJhXytt/16+zX1/J6ofOlMreIWSl70S70e4JAIf3QdAScvguUrINZmDnEQ1V/1+2yoL7crblRRqN7b0orlkkrAcBvJMVgzJ1xQlWBxi+3rm5NEIS7oDdImoZAWMfaSHXEQ8bQGfKmOBFZeCA+sNPsPETvAICx8wIQiY2jb9lo7VnP/Etii0IJiX0CBBPn+LWzy9dL6OsXRseeo+Egiu8sFKH5POHkB6DJVG9pa68XSZ8wHNikqZSQxg2JnNDpIYaEH9SzTFmAeCpGlf9WRqtybFy8mDgoW10Jkcsg4vg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZoQo4pmnp7qsaVBP32roq37B79KrTyA11vdkKeV3tlwB6gwQFBiZe7LstTcX?=
 =?us-ascii?Q?SxtSH+I2xCMjI6tQlldOFaVcHD7jk4PGInH6+xQWiYhqlhHfaJm8kXRC+8s/?=
 =?us-ascii?Q?yabiseWpdlZ48ZjKri+OlTknjkGThJh6nATVugCnzym1APVcZSEmcSEZstgp?=
 =?us-ascii?Q?Pkg2spMvjh/qpZOF31DouXm1PQjEYoPNSeDCCgyqqWpYe5dJxOUAE3SWoddh?=
 =?us-ascii?Q?tQR2g25QMLBCnPjIQn0OKGcQ8e+WR9hlYJHROcaSUpJPCa5J2bYRlOOfOiCU?=
 =?us-ascii?Q?6n6LzLRB5JtsU0jzgtOTfuK1XxDtqQYBwQ/4fZSp7jEH4tB3xMvWBIiPlDKT?=
 =?us-ascii?Q?EHhOzBUA9PBwODpUcgxmgR6JYMRdtaND2dIwHrsW8N23SWoZ2JM9So3qRbD5?=
 =?us-ascii?Q?LeSZDGNrsecbyBWlScmbPOlxAiHvHWyNb0ghRVXWltmOgftUZGCIMntC93FG?=
 =?us-ascii?Q?0AG7Yc01cOUauvLkYd5ab5LdxnlRNr805S9WgLPc7qQUvtWbWutOzJQO/w1q?=
 =?us-ascii?Q?FASEh8FvH150HV9uUirt6+hjv2gWR5intP2xk5pPR0NNLWiHaOFzrXV1YqKL?=
 =?us-ascii?Q?tNLqMHTDA2RSG6htkeLNrgqjPHquEwta8IEjW1WECxEz9qOp0QjCyrrtN8ZP?=
 =?us-ascii?Q?Ia8vNM1kU0kK9VL0WUN8zcttV/ym0jAstUV0Wte9LEyzgUpyy54hQ4s6Wl5a?=
 =?us-ascii?Q?/NShY2mVQX84+NxoGK54n00NbYipjrh8bQvwmQumIkUaZPlns4KcGYWymYlQ?=
 =?us-ascii?Q?LDJmyrlZkFLFKkrZEGr/LKHfsRnLzy35V5yLWxfRrhudUfle0bx68O9N1cLd?=
 =?us-ascii?Q?a2iBencaouVSgFjkKP2f0Uku4wrxPKcKXrbpTy0X118XnlJUU4WBeSdLZ+gw?=
 =?us-ascii?Q?50DUWH+Fmw0JjtBeZ+G04yKpNUDVMuxXcT/QFR3geU4BRhxsuzJE8oOpPPln?=
 =?us-ascii?Q?VCpl8r4AmQTlHbfcuitU/QX2YYwXy/zYWLO26PSElf4h7HL1ZRwReLmq7E/4?=
 =?us-ascii?Q?L+8VpS6q3cE+eVi8ObxJteDpKaI6WniQpH3fXnw5DE6/QS0Kdr6lNwzjr3oN?=
 =?us-ascii?Q?B5h8T60KUQ6DSpGju/6Jy0VEvuKAWipz4cAL9urOhY/yK2amzEmkQtrUTPZB?=
 =?us-ascii?Q?6Ds6gMLCiFLHn//6MOGqyP7Z2PZUp0PPVVW+HGhRZZKjjCJUHiicXzKoy9pu?=
 =?us-ascii?Q?s87hxC8wZASI8nlg1aMDIiqyc1C9rjIbAc+r0+MbvauvfWp6KFr5IkRMjW5y?=
 =?us-ascii?Q?a6atebeZQJW9vRRfHgAZJ4mqRNgg4daZZEIucY6ViCVRnRzkOBFatG3PgaGu?=
 =?us-ascii?Q?sEpuAZjEe9nitBXkDHyXsq2/KEGb3/v2ZbuPrJOvdoGrBcpxLd/9ZH4rbVWw?=
 =?us-ascii?Q?cxFB/MrdsJV4us6CoDRouv+A39So72aIb8kVN8rQrAj525a+bkAViqXI2Io4?=
 =?us-ascii?Q?6fsDSs5neOZvfTjuFYDnrAZ32O7pBBdx1a3grZOeegkK+RBxPo1m3TgoDzbb?=
 =?us-ascii?Q?okEfwpfSoO1Ba2chJF5plXNpX+YfR43wn3YN8dMEYlDIf+F2yHgQrhv2S7Va?=
 =?us-ascii?Q?+Ji0pXqZHAjY4Pf4ROSMVklWvzyZT3BJUH3SLSFb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e08161f-dca7-446c-0c46-08dc4da59790
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 15:01:18.8821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFoWD8HximVzLgKaSeveenFyXnq/nHIglRgkU7JnrDz5VPvuBFtoy6atNcpKkpYk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986

On Mon, Mar 25, 2024 at 07:05:01PM +0000, Christophe Leroy wrote:

> Not looked into details yet, but I guess so.
> 
> By the way there is a wiki dedicated to huge pages on powerpc, you can 
> have a look at it here : 
> https://github.com/linuxppc/wiki/wiki/Huge-pages , maybe you'll find 
> good ideas there to help me.

There sure are alot of page tables types here

I'm a bit wondering about terminology, eg on the first diagram "huge
pte entry" means a PUD entry that is a leaf? Which ones are contiguous
replications?

Just general remarks on the ones with huge pages:

 hash 64k and hugepage 16M/16G
 radix 64k/radix hugepage 2M/1G
 radix 4k/radix hugepage 2M/1G
 nohash 32
  - I think this is just a normal x86 like scheme? PMD/PUD can be a
    leaf with the same size as a next level table. 

    Do any of these cases need to know the higher level to parse the
    lower? eg is there a 2M bit in the PUD indicating that the PMD 
    is a table of 2M leafs or does each PMD entry have a bit
    indicating it is a leaf?

 hash 4k and hugepage 16M/16G
 nohash 64
  - How does this work? I guess since 8xx explicitly calls out
    consecutive this is actually the pgd can point to 512 256M
    entries or 8 16G entries? Ie the table size at each level is
    varable? Or is it the same and the table size is still 512 and
    each 16G entry is replicated 64 times?

    Do the offset accessors already abstract this enough?

 8xx 4K
 8xx 16K
   - As this series does?

Jason

