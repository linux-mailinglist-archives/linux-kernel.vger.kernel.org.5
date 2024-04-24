Return-Path: <linux-kernel+bounces-157267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8F18B0F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71942983B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B2515F406;
	Wed, 24 Apr 2024 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gfH9k7Z1"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFFD15FD07
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974265; cv=fail; b=h59fvd1+cPiqoSIa24PGyENbIo6SumaG8DDP9SaJokMlwZRBPpQbs9sU5Eow4zO/QUUCQxbPeNF0IrP+kwcgE5fDcIv5vUtb1YRFMImi0CJzMo+zuyuVDiyFAm2ju9likksi2iBD/W5RPuVQfrgWk5YtWh2JSqVg3i86Lr/0tNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974265; c=relaxed/simple;
	bh=+OrYPkjh3Q6puJcaNoDurC0scj+4ta9Bbhcz0jWmLh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kBG0Un7Nks9/fEopo0Lc8Lh7JpAsjwjzzK+tw9kstT6498j/P8cOUq656NTpWLUhr5NNDD3POGGELAjOdSnGDlIuazZ1tFkcTi8yEU6/B5kaUmO6tEiIPGGwQw+b/kNxyk39he00M/eY1KnexvAUAANiuxzSXdmWdTN2yHA4yKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gfH9k7Z1; arc=fail smtp.client-ip=40.107.236.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxvTMUOXMr9APFogAfeKly4M/WRa2w7fFywmUXzCFhRgsSHCxsrmLxrIrCe5lv9HR6DsrEf64PIY5OSrlfVQbnDbTVws83BrFG9gG6eaWGc5DrDNqOA0gT9zLJCsC4wT3cZFVRD5nRSkTYLa3szYL4uVx5hgxKKuvbhVSdyTOU6hHIn4KxWe7qPzJwQDqcjUHDlyy6XsQ4s6anbo6pumEV+vlqRx/U1py+RIX1bPjtGoeds+FNvczKn/ZwJpCvEEZxSYZgjW6iq/hCxyKLoWMf9wpJAGlEMJePSVEE3MI7puu45RktL3cKUN9J7A31RmgzNnsZX0V/9SB6OZzFpc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3LwPQp/GnE468KZ0BHICYU5Dn45qqj4KuIYMkaUFvI=;
 b=RokLOpaGJUdux4iNuOeI/jmaVFap1ryxLJae46iKgz+Jk8FVug2ywWNE4OEIl7nqC71ZDyhnCeVIzsSkk3DpktsTI2Gp/Urvn/fDJnU0ei4zxlNW1PHvj4JDSok0bXSg3SqWzEgBiD+iPgJoE+gz4C2zrYvJe3FqsavX229kHq5puZLW7sRGQqhxaZpI8ufo6zsguf0Cx27epVkSgNcA8yCm30xIlMNAAiav53BGyn/8fKoVQm262jnoTtnRTOQTOL3RTqjFnoxI5KRHTolrTUiQBOlsXLPWlssnb9Lg1N/7p/iogIWRqzkjLpVQNX9L+l2LSsi87Cv7WoZ4gTzvAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3LwPQp/GnE468KZ0BHICYU5Dn45qqj4KuIYMkaUFvI=;
 b=gfH9k7Z130H9sUL1Ca6djLRVI7/Z+CToR5cY0RAKBb1luRgTr2FW/SiNBFHuioVgw3p7OLItHk+jrCJX8hlnR2tIEkUBy5uMkSD8RzN+bXN2l0siTfHRQr1LF5St8lgdsBZdGxbzde+rbx0inc1uYHCgjIpDBckl71mxr3hkJyFFH/EgqgpAZwWt3Jm9dK6cOoMmLICCERUKti6YiDOdnMvStEL4DQ+J75WISp7VgOfx5Ztl1Uww0TKNLfHSi5laB+t+UpzZjTNPBECq2cKkkXi7JZYnHDopZ4o0wkCZ1rSrfmG6c4H6eSl3N2JOIYde+Hwhdip3rcgpt/LDxG3Z9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 15:57:40 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 15:57:40 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, Lance Yang <ioworker0@gmail.com>,
 akpm@linux-foundation.org, maskray@google.com, ryan.roberts@arm.com,
 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm/vmscan: avoid split PMD-mapped THP during
 shrink_folio_list()
Date: Wed, 24 Apr 2024 11:57:37 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <333181FE-C2E6-4859-AF6A-0667A1F42037@nvidia.com>
In-Reply-To: <1a0ca018-8ad3-42b0-b98a-8e6b6862fc7a@redhat.com>
References: <20240422055213.60231-1-ioworker0@gmail.com>
 <ZiiHSwG_bnLJbwfb@casper.infradead.org>
 <1a0ca018-8ad3-42b0-b98a-8e6b6862fc7a@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_A1F0F6A5-B89E-4673-BBC2-D899DA1157F2_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:208:335::28) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN2PR12MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: 9762596a-15f9-4ee7-074e-08dc647744cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fa5fJxgU1tpEY6HdwaUQu+hhc9wHI+14/fM14s3+4uliCuedZ3Rj+Exalpb2?=
 =?us-ascii?Q?8z8Hqjyj+m8lLIM5vXC2pltMYPgTwxU6uqDAqhjybd5XvrsmfRQjk95hb9p0?=
 =?us-ascii?Q?dDrb0SNEtFdA8Z+U7729GLyxuXi0dcMvpjCiLrWpmlGvM+3YUMBL3xgcHOtO?=
 =?us-ascii?Q?k0/kLVnvq4D9+yNvOqYrRfWtReTVoYh0o2GD1ccWTaXugyRtXCIy7wzBRTml?=
 =?us-ascii?Q?pceXDCuKtYbNjtIJWOxb4AWMZwVjpFGIrpxr8vltgavrlri0khugoYaAsyN8?=
 =?us-ascii?Q?W+Or9+laSBJyHFE2mlbD64u62rSSjJL2NDEhOwUlgV3azRrv0PC8k4IlEHpg?=
 =?us-ascii?Q?6U3yKnjBP46/awS2WcC+6DfjN9r8dQqmM9TAJhhBL9MRSt+7d1AO7wFN89Kw?=
 =?us-ascii?Q?IXLVST5Dz6KkqEpV3dX+7PjvozeyYez+hhCXpXjRnXgeAz1zeRtZPqswn60n?=
 =?us-ascii?Q?q1ctDUNJHFTaZpSANbdJhqTuFue7iPeUzQQCkPfkgR+XBPZLh9pZbKns3NKG?=
 =?us-ascii?Q?d0dvQmHvvFYx9oW7WbqUsMC526WOB+BeUJ8AYXaQJXhUxeOF5+NlDfuN81tG?=
 =?us-ascii?Q?qx5cpUJhLYaT0dOD1ka/6Chyj90KrP5fN3lViXEgWzdyjJlf1Vc31tK7z6Hr?=
 =?us-ascii?Q?4UMT0WVXdbQas3G/ZsfhjVkrhQG3FS+yRbiJTkxWr0rygdlZh055piDpb0aj?=
 =?us-ascii?Q?dF6AvB2gAbpREGrvHCrhy+bibFwYnSUYHJv0IgQLB1QXauCFSCtotETFZ+Xi?=
 =?us-ascii?Q?/Y7hX3V2D0M11/0Cy4lrXIMYpE/gS6FLqz+SIH/CKU1nRtkQd9FRqVWgv8bm?=
 =?us-ascii?Q?t3236mng1dtYgdr/YplIXXd9a5CvTgAZrjXh0/6Oz5SfdoDLBk+ALetyFNo0?=
 =?us-ascii?Q?bfuaqFZJcM5BuVW8vjGpZ7LhhwPyInxumqC8fyU1EoEPy0QjzfHph4PUA2x4?=
 =?us-ascii?Q?gne/LPdqA+524XLpJARFsB1CpZe9KYjxdSFZ9YXns6wqPTRbYcuqy6fyU4pr?=
 =?us-ascii?Q?WKgrAJJ/BrI0Jcip9H1HOH2LZC3JwnbAAs7LHlWd7RWu9SH9W6pDEjy/40Ur?=
 =?us-ascii?Q?+K4RU4LCzJMGAfDsfrNxr6WCrux9q9MolgMbFnAhmgPdkn3YQx4o+3DWqJPU?=
 =?us-ascii?Q?WT0eIgLl2SLZ5SrJKla/huk9QNVlduUbp+wQ48ghJ7Jv1Ltez0ISLz8IURGn?=
 =?us-ascii?Q?3reg9wCtvhgTbMZ/+mGeiclxcHDEZcx1h8hONkCxjoduOpZpBsejDdWZZ5S9?=
 =?us-ascii?Q?rl6vqoO6vPMUvyjkCeXYBooReRIkNsdpOcHE0390FA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+aLBVLpcXuwQ0Eyec3KqcykslQdcZ1ivYLL05xaz3/+2lqZsZK6jiKvk2TvP?=
 =?us-ascii?Q?Q6xHWT50aDXiJAqSrvgInWmhAh8ByWmbho+s+e67b4IuYLqNM6D8JUlr26Mm?=
 =?us-ascii?Q?+kujnaB8FbRnBHsz9uKqULAajwfTTht2uKywD98NpWr8U+DJ23N0djfXpEhK?=
 =?us-ascii?Q?1sDtbcGtnyZv9U0XbxJLofUOTKCd8s7otfea5+GTcdImyAXmzX2LvJMRH5kh?=
 =?us-ascii?Q?SJJId9H9iBoPrcXrhNk3ZU7Dk0tH7lxWvtOj8r8Zu5eZ+eiDUNWaC1eHZsJm?=
 =?us-ascii?Q?mpJvslTJbc07GZ+fGoWzQu+ojPLdD+vlH/JFH3w2UuJIQpr5IKGwYdA84ouA?=
 =?us-ascii?Q?YwW9sUdy+BEGcezXYVPV9sq3SakW46F47FCocJEZ9p0SKifbkrZcf/7QLV78?=
 =?us-ascii?Q?B2hsO01pgS+xDE8ehRsln1t4xzuDBNM5SI+kDP4LKXgrPKB0l2YzGUVamQJH?=
 =?us-ascii?Q?w4JhPyrfl653sLCz5+cN5yLm2KHKs22qBKo1TdItKmySjJI7E1R13q+3QEib?=
 =?us-ascii?Q?KOW1B/8kG4BqjYluyRUlVsotnjmcR9OdcY4EYY4l9dlR8HtTOmKnhFASLqkH?=
 =?us-ascii?Q?1KaBDAOgmJmxm6UZtyln991OXdLzXcfk3isZ1NOubQNefCifWqldlbiPVLZ4?=
 =?us-ascii?Q?+GkSFZQsxxM4ZZ1gyauYla6aI0U9UzpSIObWz+ih4TvgWHn+EwuLZmZQy1Kg?=
 =?us-ascii?Q?jGP+Ez5ojxKOIkrLiXRBI276ZvEoe7+ZIP5mUE/BmytslE5amqnGUGo3HlUu?=
 =?us-ascii?Q?AFlHCr3aBMV43Ow7X3N+63GXQOoJbqe6ktPJVgspIjCw9MFgfzvEW0ztlE9F?=
 =?us-ascii?Q?9W8yL18nE/4pY4GbZkreuZ1jeZ/806ZdpR6dkapjvPd+x0tp4sdxYMkqoWy7?=
 =?us-ascii?Q?dxVSluvjlEOUrvR2wnaMTdEKTp/KMfrpy6YBGaSIy5muLu5BVWXaEqI0y0NN?=
 =?us-ascii?Q?EbmnH9npd80s2vBVPa9M54flxsZBLCrTJ/T2ETAYx+5Ru0z2wGCOfjx6E1XT?=
 =?us-ascii?Q?7cg8Tm8uAAUDIXw3mQiBpgbPYgsPNpHQojz/rFgXrddzbD6pZRAtxa2C537i?=
 =?us-ascii?Q?RPJYmySiNjfqHJkhIXErHjpQmtnTxLdOmyC2G1818iynacVuAuPrhjiENl4a?=
 =?us-ascii?Q?n3YaUuSQqffdK/8/x+pWYguRZIB/eH0QIYveJ2kMhViM1QHIge/5GW7LWG4I?=
 =?us-ascii?Q?+usCK04nAkoP3zzc4U86M3BaJI7i7QyC8Z17iLKMrJSX9YXQKo16eQXHIcv7?=
 =?us-ascii?Q?CfCZBKU8/bkpF9tIEnot0u8udSSLJYXqekca4fNJODwFzy1uMWrwjCJ0EFBQ?=
 =?us-ascii?Q?P37Vj58wlTOvq8BxUntyWXB6ufkSVASTuoZrS2MCm1A1CCvJJnWXnPh5t75E?=
 =?us-ascii?Q?126Wt1UEB+/zd4kpOTXokdTiU4lkC4js/AtKqdYd4j9TB0QWi4oD7CxWzbf6?=
 =?us-ascii?Q?Uymv9cs562/ur9Wc0jt6u8Ebdauc8yhCTkWjPU9VHcV2TcTHosGoJaNF0AX+?=
 =?us-ascii?Q?i5+Hgm2JIZgl+iDOt8agSz2PGMQBw/t3fOdamKTFQTMod2P4HxM93Ihu1bPH?=
 =?us-ascii?Q?mYma41QKALyPqt3ZV3E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9762596a-15f9-4ee7-074e-08dc647744cc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:57:39.9154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0/E93HIP2E+yVgytJdiOq50XYsSlufiUohhUMQgnkXsY++pBn6dw8XJxs8wEY1B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344

--=_MailMate_A1F0F6A5-B89E-4673-BBC2-D899DA1157F2_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 24 Apr 2024, at 3:17, David Hildenbrand wrote:

> On 24.04.24 06:15, Matthew Wilcox wrote:
>> On Mon, Apr 22, 2024 at 01:52:13PM +0800, Lance Yang wrote:
>>> When the user no longer requires the pages, they would use
>>> madvise(MADV_FREE) to mark the pages as lazy free. IMO, they would no=
t
>>> typically rewrite to the given range.
>>>
>>> At present, PMD-mapped THPs that are marked as lazyfree during
>>> shrink_folio_list() are unconditionally split, which may be unnecessa=
ry.
>>> If the THP is clean, its PMD is also clean, and there are no unexpect=
ed
>>> references, then we can attempt to remove the PMD mapping from it. Th=
is
>>> change will improve the efficiency of memory reclamation in this case=
=2E
>>
>> Does this happen outside of benchmarks?  I'm really struggling to see
>> how we end up in this situation.  We have a clean THP without swap
>> backing, so it's full of zeroes, but for some reason we haven't used t=
he
>> shared huge zero page?  What is going on?
>
> It's not full of zeroes.
>
> User space called MADV_FREE on a PMD-mapped THP.
>
> During MADV_FREE, we mark the PTEs as clean, the folio as clean and sd =
"lazyfree" (no swap backend). If, during memory reclaim, we detect that (=
a) the folio is still clean (b) the PTEs are still clean and (c) there ar=
e no unexpected references (GUP), user space didn't re-write to that memo=
ry again, so we can just discard the memory "lazily".

It seems that try_to_unmap_one() does not support unmapping PMD-mapped fo=
lios.
Maybe adding that support instead of a special case handling?

--
Best Regards,
Yan, Zi

--=_MailMate_A1F0F6A5-B89E-4673-BBC2-D899DA1157F2_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYpK/EPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUyB4P/1OyWlSbPIBlADZ1oRQmj/WmcSwS2rqNyUVB
WsCM26m1tqmzYvCT86Bn1Dw4T9IzfuOIJnrreIGWFXWZFD9kMC3p00ejcp40k3zc
Ts/7X7SANTZDD98byKj6txX4/xN2ZTMAI7/2TG+0U3Nj0W3DzwMm3ehGE84gBJrC
VuBb4cde9hXBp8K9ldYxKG0bVEjn/WHQpv3P2XmNIrvoertgpXuvIDo78VzA/wwF
tkP4bV6fZaOtYiiga+BDLnfp+FMHngoemZTCNO+iZL21/WWXzRzVu0FTOdyGKbIh
pIgRS2rlMsm11Ver1uLFH5QZPEAml7VccQc3RUWpGAKz5aBCXPLPVabGvafo5xid
M4G387Qvr3sfhEmC21mqwGzokFYCosClLQNaqi2ejZiRKfYx39kWnxIKzgiRQ5xm
YxY2uo5vP71KmflyOKYKL4g5C2x2/mvrcroUTAcUAqB0m5VZW/GqwM2G1Luk+IRZ
ZmIGHP2UcalPij9j06YB5Ob9bjUThlNZ+JVoY7v8WyFXdmkUGmS++UfObdcdTQR7
CgBtE9kKHE05bjAGp96MUUdSIrNvT0nSH5dRnMtXhLgTM6wRzJ5gx98+t9oFY+LB
K0Lcq0bMvmCVnypnh9hFYSTewCHx8SvReRclirrzcflVyIiYbs5wNudFgCNlHZq5
DnMKLS3e
=1eku
-----END PGP SIGNATURE-----

--=_MailMate_A1F0F6A5-B89E-4673-BBC2-D899DA1157F2_=--

