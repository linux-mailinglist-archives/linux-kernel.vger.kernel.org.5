Return-Path: <linux-kernel+bounces-66969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D00E856433
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E531F2658A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDEA130AC3;
	Thu, 15 Feb 2024 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LZEIjw4l"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B612C12FB13;
	Thu, 15 Feb 2024 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003305; cv=fail; b=LbOzNmL1wpK4KMG24vmhclOU61N5T7tUKPzWMwe3Wr7YPzk0RBvsBVMkEwz2HD5CwRVuaQwrRP6wrYMXHNuIT8cwsSyWeHq62liUf0ZmmDiYFxQLGrSvsNGKiGtjdBqlEuhfiz72oAnDmESjej2SfDuiN7gcnFScXaNQs3fOT/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003305; c=relaxed/simple;
	bh=mGIiE3Y+EcuMZhDR9I9BZGJyCeueBCuvW06B9RpXar0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qZwfJ9NMpuUSPNti52+5HE1e3izY7yU90dSJZVO3iOWRBAZjcV4Q3LLqiJoP7Zo25wagGgrfIMrRjEI2sLzYZw45d8KwO5f+rul24DtEWeQhkMZ5kPg+MYKsGlOXFqbiRGXUS4uxBQZB3qKh/nn7hIk1kjCvrpbnQa8eszfwjMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LZEIjw4l; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3QWRyM9LbzZSggWXrmNZfGnHPa09cR8J/mnEcjaUk8gOWlymt0eKUaYNkvcauo9XjMcjr+n9SYZ2DYFZtrqOLUopzC8F7HNJCTVI4YWHtGP9vvyI+nxyMM3sgEWZIadxfqMvdlBj8XfQqgF3uHFvYIALPfejmk7087ObCWpVN9U4lyQafyW3YvaCXtxvhlm6t8hWBKXSJ0w8KFrGoeDnoPmiFl7UBO3c8A7M2gmj9hBwEfNeHDnedDGyqhVw+mtvY91uAmyjYqeK/NoRgxyUJ7e2ZNdkpjw0QvpEzV484kdVYYG+K4AUSwKmufAXv0xhkz8ncc08amJXT7vrmTbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tY9KfPy8aQrSo4A5Kz8iCDUM3Tu6Ty8K/720IDRrf9I=;
 b=lEY0XY9OmCbMx/2m8fORx/4XMaXBEkKFx5qLLEJBVwcDFmAqcwIhFfdfS5J3LFZacD0pOYJkd9yFYkgaD9hFPdWzCTklH/zvS6wmiMps+CsrGjasgGQXx78ntA4RNbhectEpzm24dnBEfiSKw7xh/3tS+RLcICBlI2/CPIzj5uqZOGWL2ziKEV96SXHFlgLySB79z01AtmDE1dRDQVZMl2qeLt8LGVUUZ51ru4p1/kAEnm0SCF4MiySJSIYcLqJZzaXnLyydN/ZuoHzyai8fQxk3MpsRmk3Cbx2GCMqijSvT8aiAP92xyovGphod/K/g14pFIWv+YuJwEUkUg69TVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY9KfPy8aQrSo4A5Kz8iCDUM3Tu6Ty8K/720IDRrf9I=;
 b=LZEIjw4lLUOwI+QdeuAdfZkV63W4rEn+G6OYcRAD71AZkWb5UQ4SnYtqM+QlEkAA1w7b5UcpFRxG4qhp1wXX0WNxqjXIvETP7+Co99Ra1DeMH9O2VHQ4y34ooVkkCnqqgAOb0/SEoVk4u0V198tfg5vHn4Nowd79913Kgaey00/pRnp/v5DmJBvy5kXQUrCfuM71C/ei7W2LdjJUScgU+y7iQhq8NwRtN1n/3etlf5B7bjuRUxA38+h9uKP++hh278qh9U1L5s/Zq15U1jo0DWWkCxYRSHwUyO+KhFs+M7TA7V/UD4fQr4wRpADsFv3OtYUzemJorGdKndhKMi2nGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.12; Thu, 15 Feb
 2024 13:21:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7316.012; Thu, 15 Feb 2024
 13:21:40 +0000
Date: Thu, 15 Feb 2024 09:21:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Aron Silverton <aron.silverton@oracle.com>,
	andrew.gospodarek@broadcom.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Message-ID: <20240215132138.GK1088888@nvidia.com>
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org>
 <20240214074832.713ca16a@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214074832.713ca16a@kernel.org>
X-ClientProxiedBy: MN2PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:208:a8::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 154f9bcf-bd83-4506-3f23-08dc2e290b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T9KsfuL9/6mDOeSDPHmwVcWRBnVqNGopWseyEAxNPVyGOBKbyknyB85vC3RJD4leCAxwbt2HSRrDzOiRuPph2N4k+g/MLKQm7r5XUJQ6FIK9l+TI/zuXDSzKozl/T2rL92lTOp2j7N7SLUbdr091neWlVOiBz5WmsCD/CsZcjNUTac0pvzgvttHumj44lvkAw0N5O6chSWtjk+VquMTslCgvONOx7PP+7xY+zGCLuA6Xdk+Kh+LNrJ3eOPiZuTt370UhKGQZS1d6l3HaWIzvKBEii8NkUTcnDQEgv9CBkaEcK24BFoFt9U9UtJh9iZbiRvIw9G13AtpGZS+mWYB39aO7kfSrxWmIMcapOUi7uKACGSTwy4ikHR6X8VxN6McyMceigkoLx4oxnEVscQd3eWGiQxM3LHbUIIme3mWn4cscjxM6QH3HixXDL6HcPDp4HHUZuLZJSU98GM4j//z1Gpjd+EwIg+QbsY97NFvPUT3VbQ13b4xBBIt7Vvux4uDgzvMtpaevuMAKw4VICIFZItdk7SXfONwh+qT43jejzQkvoK7HLhOd0KAe7NzUqYBc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(38100700002)(66946007)(66556008)(66476007)(8936002)(8676002)(4326008)(6916009)(7416002)(2906002)(5660300002)(26005)(2616005)(54906003)(41300700001)(316002)(1076003)(6512007)(6506007)(6486002)(478600001)(86362001)(36756003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MvvysQZiDqyfoN0a40l/rVQFQNRgcLSBQbZdzupLTwpPc0xjiYZJKrXSuhGd?=
 =?us-ascii?Q?byl6n9+ZBHEzUAAPXONovf8tBrpuKJ+liozaZ5uihb/EethrPNjdAl4sdIKJ?=
 =?us-ascii?Q?to9sWfzQHF3+ivQZcP6oX3T8zLIUwIJeR81n5mGyOhoxbfdiNp8DW2HKqmUP?=
 =?us-ascii?Q?H5YzwhaeK7I7GOHz4Y6hom8ouaKvuO/+UlqILLxvYYxCMZu6GnFJbIxQtPOy?=
 =?us-ascii?Q?3hFVixXP7XZMYe2wcqSiyBM2y23lhthmM4/MdXnePbj+IAmAPvJb2JvRnJSB?=
 =?us-ascii?Q?WzOPNMKoVxuChsTUIjTD+E2K1q+7tA6lCKGExG81NW+PJ7XafVBvMGMFBNZJ?=
 =?us-ascii?Q?Ykn4pPXwhDilj7Wp8eIeJa0A0+ykBX4j/qvw9nJn9p8wXMTCvXTsqU7HlmvY?=
 =?us-ascii?Q?fnoB1MlzaQiS7v6IPrYHSafEj1CWRhdDGeg7KLYSdhjDWygOAjpOzS/w+QR4?=
 =?us-ascii?Q?RZ360ULFv/NWYhgWYTTWhjUWfXF+N7XX1suiLAwvlvLfDhkBQ0/KRmFzpOpC?=
 =?us-ascii?Q?6Zia/qHL+M3mgTxGxS5xp2L04adTln3GuUD2g+IE1bFauAqMTQeAbZV6AEsc?=
 =?us-ascii?Q?K5ldT1MHLWRQzXdNKfe2fSSKrQBfUdJjvfikbCAl3kkaLJAZ0HeeqStM3i2G?=
 =?us-ascii?Q?hy1A5TsPTzCAwgRz5obqf079XL0mLXzEpRzvTGEkYpRe4p375fBGK8MXEpGm?=
 =?us-ascii?Q?47dEwVpNPKBNrh8ExSyScLgHqGqu6l4chAfzXwqAZXs++BBc8AkdFY0QZEmX?=
 =?us-ascii?Q?JVgjp6P/et8io4jYXWdVvac2+zm6As/HFMLpWSCBuv3LEuQITdQLiGNOMRTs?=
 =?us-ascii?Q?nzqiT6W9Fpu93MZ3vCi89kc2ZfvI3niPwyIhgUrZtebQcs39QI3VbwtOXD0I?=
 =?us-ascii?Q?f4c5bEN42ucg5ypf3ncpgYlZl0eaTWRVedWmq4mAYO++9uDrpluj4PB8/vvd?=
 =?us-ascii?Q?Wn2uWZZH2ndGJcHQQND6Se4B8mIOFZdjwQ5vDLHlVLeoKWWkBoz76N3PrM4Q?=
 =?us-ascii?Q?udg8lchmRoXH7FoWWvrM8Yhsg8tPHnJBLmWIXTVQcvByX9Bud8njq5YC2Zzn?=
 =?us-ascii?Q?du4hENtXyDlnsWsLgRN9sz5D54dFBUBcoJ3j4TdfML9RMiVuVNFMn39YJfg6?=
 =?us-ascii?Q?6PEXdD3RRpVo2LV8Sc2aYLhWrNKtgBAnLNFlAhfJaBN04Otq10+JvEvk6mYl?=
 =?us-ascii?Q?ayxV9oIDSKRs3KKHkvxWy3eICyjUkQfKQlw6E7RNzosRWGnSiTT/QrjjkSLc?=
 =?us-ascii?Q?PhNdfcoysf24gl0SBHvV7dtTu54GTXUxLklJuJ5ZQchLHyuWA/DMjnrdOflk?=
 =?us-ascii?Q?AW4qqPBp+3IJV7wfqw8vXiCBqYFOTNXAg7Wb9TKzozeSPyNY55NSEuETKx9j?=
 =?us-ascii?Q?2/msCsBl9Q2gxE0fyurkj+fR7rSwNFnxmR5NCA8rbmvkzd/+P8NrziJeMye4?=
 =?us-ascii?Q?QC1T7G+svrJWIHVF1cSSY9iww9fMjhWnwbviFWhj3qJXrRo6aIvHSP8wf7JI?=
 =?us-ascii?Q?1L1Vvl99WP61m46yteCqW+aSz/UHKQgvioLlfgAyLTTfL74CeJgrmKgA1Kj3?=
 =?us-ascii?Q?0yHbgVrSJyAzuFMVh0U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 154f9bcf-bd83-4506-3f23-08dc2e290b8c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 13:21:40.5241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hs7jX5lFC/WymGmWZGTXYgJPAF0E1o9OjnY8LDsaImHHtZHUlksVpLUylfllwnuS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622

On Wed, Feb 14, 2024 at 07:48:32AM -0800, Jakub Kicinski wrote:
> On Wed, 14 Feb 2024 00:29:16 -0800 Christoph Hellwig wrote:
> > With my busy kernel contributor head on I have to voice my
> > dissatisfaction with the subsystem maintainer overreach that's causing
> > the troubles here. 
> 
> Overreach is unfortunate, I'd love to say "please do merge it as part 
> of RDMA". You probably don't trust my opinion but Jason admitted himself
> this is primarily for RDMA.

"admitted"? You make it sound like a crime. I've been very clear on
this need from the RDMA community since the first posting.

> The problem is that some RDMA stuff is built really closely on TCP,

Huh? Since when? Are you talking about soft-iwarp? That is a reasearch
project and Bernard is very responsive, if you have issues ask him and
he will help.

Otherwise the actual HW devices are not entangled with netdev TCP, the
few iWarp devices have their own TCP implementation, in accordance
with what the IETF standardized.

> and given Jason's and co. inability to understand that good fences
> make good neighbors it will soon start getting into the netdev stack :|

I seem to recall you saying RDMA shouldn't call any netdev APIs at
all. We were unable to agree on where to build the fence for this
reason.

> Ah, and I presume they may also want it for their DOCA products. 
> So 80% RDMA, 15% DOCA, 5% the rest is my guess.

I don't know all details about DOCA, but what I know about runs over
RDMA.

> Not sure what you mean by "without lots of precedence" but you can ask
> around netdev. We have nacked such interfaces multiple times.
> The best proof the rule exists and is well established it is that Saeed
> has himself asked us a number of times to lift it.
> 
> What should be expected of us is fairness and not engaging in politics.
> We have a clear rule against opaque user space to FW interfaces,
> and I don't see how we could enforce that fairly for pure Ethernet
> devices if big vendors get to do whatever they want.

If your community is telling your rules are not working for them
anymore, it is not nice to tell them that rules exist and cannot be
questioned. Try working together toward a reasonable consensus
solution.

The world has changed alot, the use cases are different, the users are
different, the devices are different. When Dave made that prohibition
long ago it was not in a world of a multi billion transistor NIC being
deployed in uniform clusters of unimaginable size.

Jason

