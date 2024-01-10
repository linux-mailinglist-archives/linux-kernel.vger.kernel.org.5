Return-Path: <linux-kernel+bounces-22459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCC6829DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D5A28584C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DD94C3C6;
	Wed, 10 Jan 2024 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jeOpFSsM"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5324C3BF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKtEpNydaC9DVTlR3rAnZj76kOl/ExDadjFR/z8uF3jvDsCX0lyVu0Csl7D6Qdj94Lk/SO/xNoSVqr8XpqKGL9DF54fEtxQbpfceMrXM0ItWzCSwQu6o/foSLO8bVHN6FJQudl02++EK/02xkC0u963NvZa/Mkot0aoyswbK1jzeCJAQyMOHA6p42uFMhBVz7DkgAxcOUy15ch2Q+yv1UJF8mZ3Wv4t3shjRFa+0cW8vrpoFA3yG4M6fS38qTyWmXDXrZUeZdvOw/TnJ8lDQ+7KJ0JbtxF8AcZL3IoxBXL1iLp+ROuXArftf+wVvZFGwia+zw35Atfi3TA5QpstaUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdhaCul/bELmhwxhn5es6/f8HXLPY1AeZkVdrtjza1M=;
 b=X1bwaPDbOkUwXbmHWmd/KTqzZFFnxLF/+jMTWtVzw/zKlE4VEYkxRSySISGlNMWWC0DtM10DwP2jPO/sMPhbw3OwSPU48+iQX2tni9Gs2AmyKBaayneBTCcGwG2oL/zEk/VZ14tPib17i3pNtQ1i8mXR0lNtoNzNWwrGSYMiB3K60BahWDs1Goieum+24koANVVYCzyby1sj69JPQV4BVmg9blX+f44/BpOPbHIb+O4MyLxdOcZubWoXT74aosXvurNfD2xZnQLWBLamgCqs8mBSQUiOEry/+9/4RSopoZlls+l0c6xOsku0O9L3IDln545b3hmkGpsPM8dhRrM2Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdhaCul/bELmhwxhn5es6/f8HXLPY1AeZkVdrtjza1M=;
 b=jeOpFSsMXSbQ2opynR4fheUELdaR0miEHE+4OSVkK1frVh9dcVjvPbP/26x4IWa2l7lkvgEAVFm1kNNo77+X9LXjWr4ohcuOVWRrePA2rsBXdHoZJXwXe42eZgKwmRj4u+p3XcfSFt96gdPYaotemimJoTiASLIulMESvmmzYt6eythho5OpeeW4wXQp8YO0UKrezO+7LEDkEZ+nnXcmp7MwOLoFkgn/1R1iBQRNtmZIaPGQQWxZb22i141OyRtKw5drcN7hZGHsc3zvhbKgzZa+HO6jMWLgvhXj75EY8VWwQHr1j4ibpeMRlJ/XZQf5IvSLRxKDZfEsKS/Q76e2Og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5200.namprd12.prod.outlook.com (2603:10b6:5:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.27; Wed, 10 Jan
 2024 15:52:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 15:52:34 +0000
Date: Wed, 10 Jan 2024 11:52:33 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Neal Gompa <neal@gompa.dev>
Cc: jirislaby@kernel.org, dhowells@redhat.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, pinskia@gmail.com,
	kent.overstreet@linux.dev
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Message-ID: <20240110155233.GA623732@nvidia.com>
References: <938ebce3-74c5-4fcf-9de3-849271d3581d@kernel.org>
 <20240110130456.142763-1-neal@gompa.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110130456.142763-1-neal@gompa.dev>
X-ClientProxiedBy: BL1P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: 944313c8-9bbd-4990-82d1-08dc11f4294c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+/3pQ3KviMqNThleCjhfWBWVt2pp7lRl1YTD4MFxuw7O4vzgnP7sDEcbkR8lByyMHV6otl5AbkBBX3KG6tbMbT2KtLF3DMlOQTljUFUkk2abe/r66aynziQ7QwuJhWgGiNRtp2ZMRq7TRypGb5B7g7adrB0FcF+OI9C+QEtSUC1/Ta/RjTNbpThvsvlwRGP4WPE1Sz/rjXI22nJhDiplXIsgBsWDfjSWixeblLJwYYOzeZ8Nj+/bX1nWvWFhRdUCNSneSLHO8OWp1HZmZuJ1xP+M03fKNGFCaXMxbhooRSSPtqKCzSEl5Ey/yRfnuF2QBxl7xtV/Pj9g+1K0lY0JGfJnh7kazpQ5Ox2PE+XTD98CB2RJOAVmjEuylRPUlwCt60KVU/rdbuAmD4iC29M0eYEeJUPx3SzUYhE57ANJGxpZi6ayi3KIW4QfTeqVf57PbHUfs3f0KpKZmfvJCkS0CehJclxTzcRY425WkJtEqcBw4HNvA3v1q6Y+vwK0cnAdsftxBJJW0r+J9s//YYJ+YVT8ZRm5WvwPbhEpbqFtpEYDui7wgDzaynEwLIAU7BlqV8JH70Fs6NfSbH0jEz5Jx+dYcpgNL3vE1w7nVJwy0/U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66899024)(478600001)(6506007)(6512007)(2616005)(1076003)(26005)(38100700002)(86362001)(33656002)(36756003)(2906002)(41300700001)(4326008)(5660300002)(66946007)(8936002)(8676002)(6486002)(66556008)(6916009)(316002)(66476007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2xd0sAaYpdZJlh8vSm1OlghLzeBpEv7OsmrJldwCwis3KXSCwOmPLi0T71Mm?=
 =?us-ascii?Q?H9iqahAoZ2q7LeAfNiiXhtnLMtOYvwcAjSkeCglF4CjCjIktscwQl7R/0/Cs?=
 =?us-ascii?Q?aGO/oR8G5FtXk9rdTYhWFvlqy9+HwCn2/tbKI0fXWdD7RuMLMnCiQJFveoQq?=
 =?us-ascii?Q?SFfOpDDStT+robULzP0TB+BQt2G63cVl+zylk4i1JETsVIGLdsq9HH4QVS0F?=
 =?us-ascii?Q?OD6Pj76UOQO8/jcosrvJADCMW8sh96aR7zMb1vpUHn8dEkZm348q9ic32ivp?=
 =?us-ascii?Q?NYAaRFS4b1J0O9xFihaqaWpFEhqUB8/snFVIS6Tm9HKdtTOs0k4SCfhtKz7g?=
 =?us-ascii?Q?8Ntti3SUw3arPWMVlISu/artqVEponpdw1VSnEnnAhYtFVQqEXEHXwUFnZ3k?=
 =?us-ascii?Q?jAJ/okHWq8B9hEEqywHl0y88Z55w7e8FkiYhJ2W7WUp+I69CCAsmMAgjQ0lV?=
 =?us-ascii?Q?qwbP8sn8ie99IiQ+TaX1/MD+GX8MxkxGG2paW7/HucpL3/oMjCBFfvPIejLV?=
 =?us-ascii?Q?+PaJ0MuRhcvbHtGtX5D5RM7kGy3xdEicwZyLjqzj9w3A7RRCsGxH3C0tOXaE?=
 =?us-ascii?Q?X3GU/pwxhAt8XE9dc4Rt3DVSBClHNqKkamlIY4PQZSqluUrGdyW00xDRqAln?=
 =?us-ascii?Q?FY1k7oORdnMy/MpnYV9AksywiUHAN22cIZSJLjelgrqqQxeC5u4TwiZ28ndU?=
 =?us-ascii?Q?vMci0TDcdmSzT/dxu0XIbNRfRLyplhDT0ftagRQy+YHYhXK0KhkFUt60c4Xy?=
 =?us-ascii?Q?tk//26Q2/Al0EV6Jfk2PMXC2Oak+JXR7x/DwtVGLmYPuvRby0xqBi2bGrwyK?=
 =?us-ascii?Q?8xOLJ/Y497XxbaVM2SW3on6DSKD5MS2sRtk9d7VFSn4rBhwwvrZqcU30Vxog?=
 =?us-ascii?Q?tq0Y7LVE5Epukin3Wg7Jxfs0PK2HOdUr+WE8E+XGQQqI58cA/PjhXsb5S+P+?=
 =?us-ascii?Q?cZzW9DfQ+jdLAQdlxXVKribS8/v1AQLs0wsfsh8ec/wOU81HiB8ZI7UpcGVG?=
 =?us-ascii?Q?mv88xtMEvHRLoywbpxGu4MDDhdQ2B/mViDzjMLyzq0Dny7K/OVAeqNA5otLS?=
 =?us-ascii?Q?QMMULi6ym9DSccfzcfjupHtYNpC5jVW3CSuCYuB0USE40HMu42oRDmEhW6eI?=
 =?us-ascii?Q?mnNO5KHlHgQXK0Z8VcIh0pmsDZ+x3ALgguRfwTyf7vbIhnNH7Vm8TWIvs/yr?=
 =?us-ascii?Q?MLsv7nX81rGzbJqh2t1n4Zo9NFBm/dtagn2i5BBoSyOACplAmazgzXh4YofY?=
 =?us-ascii?Q?gZktaljuH5y03YMzHC/FfmWpi22ln2w8dPHy6te2+/b4mDsu4mxpsGV8vtWx?=
 =?us-ascii?Q?FKnOufOS4zLkhPEbZoapnnFARqzI3LzS8bMeiqF2jteNDiOLnzi4rq1Tcl51?=
 =?us-ascii?Q?fhbcm0hx5u6U1ukzB6sXJDwTEtvnS3WK3d7vZMp6+jvI8Aof8VzQw0PpFVMq?=
 =?us-ascii?Q?rx6DHPGRwnUPlDEZLGhV+HLoH0LAXtlmxGOzYfccXcYDkOh8ADGy1ehq7Gj4?=
 =?us-ascii?Q?fOs6t8y3RhCTvsuXQ5EM7j2QU4TeH4kE/3j0Ik8NIVFSOC5+jYl41mgwAvDo?=
 =?us-ascii?Q?vAy3hPrQnaSE2TpVU1UqS0Yc0K49rgijxY5I4Fx7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944313c8-9bbd-4990-82d1-08dc11f4294c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 15:52:34.5587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyU3nm3QuxhsrF88HDuVDBw/woPA3P5MKOXCo8RL0zmPiURKS0MGLjoSyfZ6UHr2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5200

On Wed, Jan 10, 2024 at 08:04:53AM -0500, Neal Gompa wrote:
> Hey all,
> 
> I would like to speak in support of this too. It is not uncommon
> to see operating systems code written in C++ (notable examples are
> Haiku OS, Serenity OS, and Zircon/Fuschia) and I do feel that there
> are benefits to C++ for Linux code. Modern C++ (such as C++14 and
> newer), offers a lot of nice base language features that can make
> some of the kind of stuff that Linux does easier (as H. Peter Anvin
> has detailed in his post[1]).

Me too. If we are serious considering Rust I think C++20 deserves a
fair shake as well. Especially since I heard the C++ working group is
apparently looking at future C++ extensions for Rust-esque memory
safety these days.

I personally think the kernel community would have an easier and more
incremental time swallowing C++ than it would Rust, and C++17 is
already mature with fully working stable compilers. In particular I
feel someone familiar with C would have a easier ramp up to some
imagined "kernel C++20 subset" than to Rust.

Further, I feell that having a single base line of "all code compiles
in a C++20 compiler" and localized variations of what idiomatic style
and features different parts use would be ultimately more maintainable
than intermixing C and Rust togther.

I've also got a fair bit of experience with C++17 and I would add to
HPA's note that the modern idiomatic usage of C++17 is *way* different
than older versions. If someone was traumatized by early 2000's or
1990's C++ then it is not entirely fair to carry that to modern
C++17. Especially when combined with a modern environment with
something like clangd to help grok the code. (Though SFINAE is still
an inscrutable terror)

Jason

