Return-Path: <linux-kernel+bounces-85823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2D686BBCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFC31F20F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BFF13D315;
	Wed, 28 Feb 2024 22:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M8pO9Xkp"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3533F13D30C;
	Wed, 28 Feb 2024 22:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161176; cv=fail; b=KiY7cotv4HbJvlcrCCNp3gQqNyLbp4+NWP2qFUGbEY1WSAcdVfB7Qi8vxv9fIyYzEejctNQFrKuAYAK9nQWm3fOQj4xK+37+mAwOw+BVtDCaGIR0lNRzJsbk44tqbT5gDMBz7yiT6YgJ3W3puQVe8xoU1KTmDR6mFv0GzjRcrFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161176; c=relaxed/simple;
	bh=6c/qeXAkM4WTt+H5WPDa9HqIIaNyAqU2sAYoYJDTBys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aTksa2vUntuSN4chJlH55iC2YjR5qSNvi04lF2srgT0xgs509qunicaBoo5aC6TqRydNL3Ts0HrTFrXvZEtUBmOBPrTKjI4ZL8kEHfZEQjuZpkFBwEMFwxhcvvww2SJ5D6+5Xb2l6yoHXS9MZOZB3HnB7DB2dsPRoXZo8skkEEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M8pO9Xkp; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyABQSaTBV4ZvM3SLb5cVkk6kNeRYfEOqP2m+YzdzDLIdauTK+2v8sPEArL6/HF/izCCR1167SiQtlbZYv10pYFNhkzJrjZ2XxmEfIG1zXf1S6z7et23XzU/KeKp1r7/Aumzl3DQMKpGfPSh/rtwIaIquLzZ8oh5nZJmMfB8WwMzgcUjsuIGkFDJRObmhGkKELr4kF8+laOm+W6Mbv/aomgYX5DjSA+voWa63B1xnFL8bGYtYJ6ELeO3w+XpuQEcTY7p7MXyKjGABSW/JtOY53s2WFNnS5MZ3hHC6Cd2MtJohCNh10VGzeHwFnLue6rkbNSAnuQ+i0j+JWwEXSbDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=454o32wUhxMQJq4xDHQ/PpPJSgTNAAGKSfoUpoTO3xM=;
 b=hvnXJiKNAGQ37oz46BERzRia/U6d8CC+gS19rFqju5cbT5jXK4fe2KmTO8LOkUn86IPGVjsMc59WRiPnra85Scx+4EbDF04Vu1seQaAWtDLNHJ9E6tZcgsD57IqW6QuXFwBRRWZQd49OghicD66Iv5C3RmNrfvIrhe/lGsi0JouuhjL5Vpt6KUL3EZ8cTq7Jw0giOLpChJCQqOSxYjiiaf+dd0yylz4VBzQv1rd85g513sLud+RlYNQBhBmGn+n9yw8MI1vc+HDcYmPKnerib5tr6ysBnMR8jOTeKISMRKh8HZ9BIJ2soVee1gO20ZJUpBHOBbj05om/pqmezKNCpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=454o32wUhxMQJq4xDHQ/PpPJSgTNAAGKSfoUpoTO3xM=;
 b=M8pO9Xkp4DcnGrcI7x5XDEMGThOrHr4FNet+gS8s8qBOLvDZki78BnILEjW4VLfFShYn6afMNc819uR+Db4bYNEycXGX4TAHplLFx7CF8mn/cvOtyXIwOTDpxQhNiLABSbhy9M72u1TiDgwHedA63RZukjW7cbcIR9ra58ufr11+hxvN1hWK0ZXZEpaTv8BYp11WiMWz5q+H/lJqlSzF89UuVy8OznDwgzpWjWFt8H1xCMsoCfPlqeoQDyG+TXKEUuJZaqwY2uW3637QqdIc9v3geojvh5wO5uruyjZxOL8U+pMys2OmtwQa7JHO00sdxoFxmlQUBYyueOTdELQ3DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 22:59:31 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::2e3e:c7c0:84da:3941]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::2e3e:c7c0:84da:3941%6]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 22:59:31 +0000
Date: Wed, 28 Feb 2024 18:59:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH rc 0/3] iommufd: Fix three bugs found by Syzkaller
Message-ID: <20240228225929.GR13330@nvidia.com>
References: <cover.1708636627.git.nicolinc@nvidia.com>
 <BN9PR11MB5276D622986E55465C3977CB8C592@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D622986E55465C3977CB8C592@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: SA9PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:806:23::29) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: e4058933-0326-4cdf-39e1-08dc38b0ec4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wKjNvoNtO5J5l8P9oPnmodsMnaHoqP3NFTnpvVuZLm4BqsBvsPPYX2+NaiFh1zF5TeMcXqH4fEb1rqQ0y9+R+3NNST8PSK4BBOd9U+2bpMZEI7CuLNh7DoViHsvggzwkwy1hI5K4fyM/A7TWiaUM5EwBqC+YQFJ+nfFZcC67VaH4emOaLBw9AlZJcGVoN6N4qLu1sgGjm0m6nBhhWVrQEKNw2rMCWDcnC7HLkMGq/yFHE/PUkpJjR/NmGKQlZWRYBLpnMSU7fMlhiWTUWupokTegUoZZBHiJaLgtzgLVy/CZ9cF/7pXsf9vLfDYMXUMgn1BJAzU3tC0NihZo+XLHGUue4GF0d8s7gF6nmU2kkGpQM3Qw8kREN8Vm1M9rj/KMxSp2MYV49x3hHUb/7n/wUZ2hR9FVHEMuckRpMXp+NkB7mEQkxUKmqMeJF/TDDVOkpu1R8FVU9MqZgVXdhRN3E+chUDcSo4tObLDWmKbZ0TiQfbqVlSshpFaiG/3I4jDaCg5mvoa5ohRR3yuiJTbSUGJHGJzz79fBUwStuxL3oEcT40TibPKlKccCPYXVvVhjAsEFK+N42UM22bqMPI2Soma7xPAD/Iegw/7tMtqE7jvDhk0QZ0xWfmb8SmxMXzLOtTh4jonhb1gwCaR8iQ+GoA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cLp55OBzS7D9I/MVx0Bey+Fyacf8+yO3HXxDOlf3AqePbZfTKnI6EkyUYXAL?=
 =?us-ascii?Q?HvodTsPBXAc5mtU7Mj9gZDVEac4jTf4xf53QeIQ8lZRWrCYM80NakWvz+IW2?=
 =?us-ascii?Q?jkqSvkjPzJAh0p8L7o8UrXaT7lErguYVKEW98cPj0yNd/CFb619DOoBJJoHw?=
 =?us-ascii?Q?oE8kJ39T3mfp1uGKNBBd0xBeednNQk+Q3wXqC8R2qMlkFkKQ+ulemyqq0pbi?=
 =?us-ascii?Q?hrpH0Y4lIyafLxwJbd28nibfQuHSiWEYxGqPPkbSJqkHAtx/9Od6UvqDdVqj?=
 =?us-ascii?Q?naUcf1M0/SQzI6VlPwYLZ4v9nIm82iZvY8t/rQ+KhiAmFgZ59V0VJ/j06pZu?=
 =?us-ascii?Q?s1hqeTBcRlSkPhKA1Oil2rVqQYhiPhzxmCcK2cHn8+0C9usVzUIftPk8NO56?=
 =?us-ascii?Q?xRwONHQ79cCSscQMvqNMGvxBliSCesahkBdrDTYOEa7Dr18ciNhHIWN+H2gU?=
 =?us-ascii?Q?CEMdOUCm2Xp9ghIr56OQa9F4OshhMrvqHQBNTYG2A6lHvI4EmwhYEUcuR1mU?=
 =?us-ascii?Q?lZGnbiZEHNc7LogeEYXV15wGPhaZdIhA96kMZc+sk6WxJZ2gSZ640tg8Wq53?=
 =?us-ascii?Q?5kaVjulmC0tfqbWCUEutcUy1rBoaJZZDRscjvD7DLhNY9aPEWL6Wnuzq7cXt?=
 =?us-ascii?Q?a8t8rY9WnoqXIx/HQ/5dbiuWuPAXFO31Xqxnj9hcirwfSsvuHEzzopHBAdyS?=
 =?us-ascii?Q?h8c49bn0dg/2y9IpDA1TYtG+C/pKkCAd75xUyL7XJPhmLC38wlQNjrJ72ZPl?=
 =?us-ascii?Q?mBF77rn00J/4iHNDccZALTVcdDFjp3i+4Vgxtp4bUtcrzqgmgIv5ZsLKJc3e?=
 =?us-ascii?Q?3hfX5IWCKC4GX31vu7j4qWH6DAvXz24x0TpxdCGX+Z1Lm5K1vDxVdwjVNbuv?=
 =?us-ascii?Q?fCIenFbgD8xkkE63o/OXbWrMHzsBuKrPIAgj2GuQVT6RE+386muGrtZDe07j?=
 =?us-ascii?Q?yfegy4T04o4THXdzaTTEWMfvDgEV7ApodeRszf15++qVVrIojfao/KieVItv?=
 =?us-ascii?Q?NEPdLJzN25gO3O93SkGikbjzA1jy8OfN+PpRq9KR8KINd/fXLYtPYXS2payN?=
 =?us-ascii?Q?7CeHVY9yiR/263dHjhlS2ISNAgjXsPjd43qbekACrofxaloj2ULaPyEYd7TB?=
 =?us-ascii?Q?9eGiTwAiZVLPZU9QdV/HxifF9wiSRfH56cy7shPpnT1MRPtI6MzVNoDWjAZn?=
 =?us-ascii?Q?bu5wZUwAkUzmiiJw69VAQKUdGyJdUVQcPo3dn8YGY+7VVk6Nm+8fO40s2sVt?=
 =?us-ascii?Q?3GYpaJa81V2r/E8QQUlXNsxKo14qHfiWQFqU65qhEamNB2DqhJQIQPMXgODY?=
 =?us-ascii?Q?JbzXu+IVAOTPYVWtAKpIobTXiwMskRXo4rm4DtWULvlvArX1gwhO0+jA4dLh?=
 =?us-ascii?Q?BNDcZ1rydzCZNN8RSs8LcSXtvwgX0axybcxiJlIQepDGuGcHWHsB9pygLS1j?=
 =?us-ascii?Q?v4nIGcX9UowZvm4qS+SV2o8WrDp9NVZ7euxuDCmPqCstP0NzcQehgyPzM0nw?=
 =?us-ascii?Q?tSmUZG5RokGtmOxZsSibuXPZhr9AYcSbirQsVO92Mm8uEAXvNzyQwaEm677a?=
 =?us-ascii?Q?ZGMyjBcDmyeCezaUlko=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4058933-0326-4cdf-39e1-08dc38b0ec4e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 22:59:31.0931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6Ut08zTqhTjeOt/aQxVeZk80Po+yIZvQF2LwrQT4KW+gQrVWshROTWDyyvDxSkq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848

On Tue, Feb 27, 2024 at 03:34:11AM +0000, Tian, Kevin wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > Sent: Friday, February 23, 2024 5:24 AM
> > 
> > Jason has been running Syzkaller that found three bugs.
> 
> could you remove "Jason has been running" from all three patches?
> Just say that Syzkaller found a bug.

I will copy edit the commit messages

Thanks,
Jason

