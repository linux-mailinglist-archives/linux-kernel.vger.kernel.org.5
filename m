Return-Path: <linux-kernel+bounces-142793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4105E8A3026
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95778B21979
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8925985948;
	Fri, 12 Apr 2024 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YdwWtAAM"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F883CDD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930810; cv=fail; b=bg6GlBQhRHUI0EwzC2B05X9KWq0D8Yi3wtaT918HhKUJBDtzsdklyUuQ3DZSaX971bMvhNrzY3T9Bm+yJrUxx2gIqodlAKtuEH5pH9/ja7xXIK5LN83sBVkZB7/dLAWlYGRryYVF4EDrEJMjwrHb8vJZFmLx0uPO0q5+iPFt6to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930810; c=relaxed/simple;
	bh=mDjS5QWqfeF+rp2q060aR1G/vL7qcmoJPEz1q7D4cnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dd53w7kuGo6V0+kY0Zx0xxCSDsPltEDqWLn55/KlcBTO6NZI7x0tWaoriAZauHO7/CIzFCvPhfUhIYCA9Ck+y4zqt/sjtB2oEGl48LOnkI6rwF9gxm4VEsE3p6BWfqMrhiN0EoFfL083BFZFs9m+wfdosPq43zVqrWFyXKnEJ28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YdwWtAAM; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAYUR4PpY5wOa3b/V7vd0dRxCFPdHm+uiduAgeCYccXssd3/KK+Vv6lQ0AaU7O7v5u3xh1ygb7QSFLsDR9ekPtyqjpLu9bJSG2pB3ZtM0yGfEfyAp9lr0U268rYPWrhzhN5A98ghQs1iazdnRJizXwKj5Tm2cnnnsI7n27WQqDLvetzinIUb/Jr8dbA4zAHNlffGvh2hcgV4hOHg1kqtrNT1MuUPbGoKpENujSBFXwfqsTAs3zPirqkhsIiWBVIce6Eg0R9qpQmycrr5JUU82a31Vtuyp+/FN9MDmcAZNGuHpb0DdMV1AUyCxLHhh0ogoR8L1Sp5JlAXNxn7dihvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1RML+Muh9EBClz3HBwkDiqWVITYPrEPUq5mLS0eRFw=;
 b=Q4cQYDzx6cH9zKHCDp8BgaabaQ+gWEtvvfogXS3xoNV3x+SXig3dEW6mp2TXx6JN+/4FDCD9Ubt0x868s/ylb+2kgTjAucoM3YgePsqI95E+DtHWmdhjynIBdwCGzCX4CdK+RyVdU0VHSK95J6uKnab6DRQj7lJoyevk4Plo4u85acx0zLDxJWvZ86QlgQxRwMrgiYu7Lsv0mobAXziFfOmwrhz4acvhA9pBu8nEgS1cLHJm31Kmn2dfVVGQUihezvJWwqGQSDWEpnh2v/ZD1OM8UFPwTFF0BlonJA2YIyn2/6psEuWq1De9bpflEJNd3zwABHeH3Ntf2aIcD6k0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1RML+Muh9EBClz3HBwkDiqWVITYPrEPUq5mLS0eRFw=;
 b=YdwWtAAMe4vZzqymOkyY3a0TnwZu6Sg47QvbBQnn1MvJEJAPZznphVxhh88SpMsPwvHGVqtpyyk3CtfRSJpMokH0lD8TYu2r/cuTYJlu7aSa4HzEPt11B67qI8+EZW/eF0GItF6q6GRrEIBClUMTS+J5Ct+ijqwPKGM/MYiAO7M+s5DBCi4Gphp0yALZ6Dmn+bnYqHghxoPv5eo6CbM03jwM9Ig6j63pob37+kzloL8YIADRaWHJ+97JO3IvOCaeA9108bfKtdr+7ST78ScUq76Gx6SDqBuPmbn2YWwBjxetY4V8ICI7pCtArTqytdgIarFwHOnphoO83TT5kuhCQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Fri, 12 Apr 2024 14:06:41 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 14:06:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org,
 mgorman@techsingularity.net, vbabka@suse.cz, 21cnbao@gmail.com,
 ryan.roberts@arm.com, david@redhat.com, ying.huang@intel.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: page_alloc: allowing mTHP compaction to capture the
 freed page directly
Date: Fri, 12 Apr 2024 10:06:39 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <A8A8D662-478C-4A42-AB5F-C840A2DF6B55@nvidia.com>
In-Reply-To: <8118a5d66a034736a48433beddaca60ed78577c4.1712892329.git.baolin.wang@linux.alibaba.com>
References: <8118a5d66a034736a48433beddaca60ed78577c4.1712892329.git.baolin.wang@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_726461F8-174E-4D4B-ABC6-4D4C2DC4F38C_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0133.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::18) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB6255:EE_
X-MS-Office365-Filtering-Correlation-Id: 822e9934-7b3c-4fd6-b7e0-08dc5af9c72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8SM1YD9lElMjEgdTxYmXR6wL2F5mOg1+ezY9CE3q3zPYA0iOR25NTTkmYEJZikKf0tKYt1KfIpW6Tnwu/+g4rqQYX4ykxus7LZeeRCXJC3LnOK91OxrlvwRZx18qQ1+K7QQ+RFR4gg0Z43BuuzXGbZzXTzpduo7aTVMDY4t8m4tAkQfCe9ZRRT2UGJ2C95o+wxPr8wkAgpzIBjTjsY2uVznDkJyx0Ff/kojePMjpb0B7Qw9Y/4LSAnLvhJnUWXnIgeMJrTRyTl0zO84Ohax4LqBbHfgmLvy0zi8oYRyZUMA7U+29RKBZ3EjIGjlHwRv9lbtCK09VHrqtieHbzogc/RTQ8EKY7NZBQ9uhHwdm20RAwxpyDJHYIHuY6i/EravujZjyqSrtvhtTB1JjxZE+VgYYMIx1eTlFkLIjgFOPqCC+Gn7ksDpE8WZtuiHoOUyO/1RceNbMW0+EywV8DK0eXQfSDl6znAyvjBcrNSUD9VNe74OmF0IOqBvWC3Y1YHiCgkmtiCfUMjoKSO2HrpwmESGMhluhdCaQzbnCFRBwv99EOSSg95p4y1vEIZ5zsSunGyeq2oPCImkYz0dXARchqQwc+C6afYiRPEdQAl3Y/xTcWlnGHSecnCyFDnBsB8Vt10OQo5+qZwycXqJYAH/Z0qfYCiJlwtIbhMpuqo3wtjA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NWus0DRVVZEGg/1SB732Iwh+IWbpLM3aGV3gicGeBIcJzs/oDHdoHXcx1xp3?=
 =?us-ascii?Q?wdTWs0+waYDzE/xy9LvoDZCrZlbUyukHOjY1rxivQkXMyyamKbqtjRWRFTI8?=
 =?us-ascii?Q?LhML6quGcrNk4c68yccPGt6p7ixOIdgRjFZVL4pkNnEYeTtBK6ye7azjuMwi?=
 =?us-ascii?Q?fL+iUakNZoeTinmClWaqvxCByNGx0iMa8Kegf+fiwhFQc0OKNkRapcrfLSr3?=
 =?us-ascii?Q?23mdXUmfieC9i4yLRf4XXZyXJUxb/t7w2YE4WjqekmWup+BNTiWeU0n1qp1B?=
 =?us-ascii?Q?UZ/p8b8azEZwP7XracXL/dze4nP1Q92s9GvG12E/rlf8DXXqg5r3CcvCH+g8?=
 =?us-ascii?Q?JvZ7AQvDa4IETh8jBKPK9+wt7LwZ+4vlxGoPoIejEjd6RxYJSRC3HzdXpZD8?=
 =?us-ascii?Q?bjDghyzC8pUXzIvtbsxpb6ub5UgTUtiwxSxf6xpgKZPjy0Wesf8+vMoV2qFF?=
 =?us-ascii?Q?FGTUQdccwE+uZo0ib6mIM4yAjS+ouyhHVFLaADuQgNcGAe+83Nj3JQQKaVyK?=
 =?us-ascii?Q?lWePXKBoVuVPfdGJeVeT9+mXHm6FAyIX7+8LByo1SRs/zHhLFtsTBac14oT1?=
 =?us-ascii?Q?+r6UMF/wQBdEUm5teevRSRZtyYg/VU2dCIQGnBDnRqRlBpZNStJ3CGiCF/x3?=
 =?us-ascii?Q?F41tLSKv6Iuu9nMUN+VwX0IIT1oLSvasbQV7aHh1pFZFXIMZ8UFzYiK7IFi7?=
 =?us-ascii?Q?56Ire2V2fu2szyMyQ1hYcRK8d059nkNK21BzmduGnJH9rPJI7wFZ7gOY85+r?=
 =?us-ascii?Q?/HOXd5DhxqTt/ezAWPPWOpAVG0wx1Pyw2YVPz85i2GF7h8k2gEG4mR9WH8kV?=
 =?us-ascii?Q?23Nnr0+/s7CbpekT5W5wr5AtwlVDPg0QuSgBn3FaIbmKjgaxUVJDeDI5MEyv?=
 =?us-ascii?Q?TJqkjJSYv7L+Lj67J1fzH+Xf3y34vSm5VG1shoU/Vjby1JfYGq8Guv7Eaj4/?=
 =?us-ascii?Q?qbZsObcsA4P9aoUxRjXvH4dJzPNQ4MrjH38Z6xScJAYY6Yy+eBR/I5N0i0hV?=
 =?us-ascii?Q?RNz0jLbBSi6aZZdZxVaBZZdyJnsT9SZD7wl49WhFD+6AAO5HDp0804YJwPg+?=
 =?us-ascii?Q?Ycf+rXqkD4WPrMa3ljzR8J1m8fLdivbM6S7ZKlTRyYcpn2rMhOnnkGKzl9+H?=
 =?us-ascii?Q?g5X8Kuo5u7TMA9sQb10sQq49C66nwt2kMxBtns5ZbNZ5NWLf0bGOYNRLJFNf?=
 =?us-ascii?Q?+3MOsx+brq8d9qsxNWbZBbzWpfBoqLO8JSjW94aK2ufvTFPhTTw9WZwlI62X?=
 =?us-ascii?Q?k07mLs3D0FqiuNdlvhFFS09SF42O75aDl5YUooJGMK0ODAkXMG43JyBTC1R5?=
 =?us-ascii?Q?n7RnZVTagT2yZ+WZXDrElsVUX2pVFRbVrQw1M8BkMQlwafsgI2++rLudJPce?=
 =?us-ascii?Q?UW/ynUeioFO7Tbnq+F8Lv4uYttBTFncqrgpCAHQB/in/T41gYnwtjZcwiUkv?=
 =?us-ascii?Q?ZkaydaxdXsqpaMTEfi14oBr/Gj6ha5dxoy7mk7Hk078tw4i+Y8Gpw6NTyNLd?=
 =?us-ascii?Q?BKUMxcO6uokD3VhcAy8QIB0HtVmrJrBAbwf4y/8QfuCg7fJ5RyeiJ+R0Shza?=
 =?us-ascii?Q?u04Aeb7YR2NIwO1auk4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822e9934-7b3c-4fd6-b7e0-08dc5af9c72e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 14:06:41.6083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +V9d6BjCUD4CNlRSDJ5N16KWsv8xo04MKiSSInfQNJs2TsMI6/XkOi7KgNUC6sKO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255

--=_MailMate_726461F8-174E-4D4B-ABC6-4D4C2DC4F38C_=
Content-Type: text/plain

On 11 Apr 2024, at 23:27, Baolin Wang wrote:

> Currently, compaction_capture() does not allow lower-order allocations to
> directly capture the movable free pages, even though lower-order allocations
> might also be requesting movable pages, that can lead to more compaction
> scanning. And, with the enablement of mTHP, such situations will become more
> common.
>
> Thus allowing lower-order (mTHP) allocations of movable page types directly
> capture the movable free pages can avoid unnecessary compaction scanning,
> meanwhile that won't pollute the movable pageblock. With testing 1M mTHP
> compaction, it can be seen that compaction scanning is significantly reduced.
>
>                                    mm-unstable       patched
> Ops Compaction pages isolated      116598741.00   120946702.00
> Ops Compaction migrate scanned    1764870054.00  1488621550.00
> Ops Compaction free scanned       7707879039.00  4986299318.00
> Ops Compact scan efficiency               22.90          29.85
> Ops Compaction cost                    73797.69       72933.48
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/page_alloc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_726461F8-174E-4D4B-ABC6-4D4C2DC4F38C_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYZP+8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUxQ8P/1GGS3zQeahbMOY8SPgF+oKzXED8R8CQxIx8
irb6pBv4rbj1gNkrLLYB7ucdxO42hbjX6ZI393dg/zib+N0cnov0GonwT3G3yRgz
knG3XDDL8e1d0D8eJbKQMvuNZQ5GpHz3O+dNhPLmG+Hf6AqUvwtW04vBzoq4/lYS
Qf0SUXzKeNLaTjYEcn2zw9FC7WDPuwz56K/ZM7W/i9ofj3ig2ehEe2RI8n9Ntos9
F+Zx3wC7Pb1n+fFCBlHALtr1ZtIcMOx65riohaRgHp5+8Ryke/lm7dcRxJMS9f52
icKpuKmemHPfYL7AfAsifR8fkjgUUSmHpZXu82b7LQKxN2KHA7Y3Q0fiQ+xWaGcA
aiEwZvwsa/sseoG0st7eIdVv0eiSJoK5HrXDgmKVM/IoIF1DAAqwiNYPMewsLFyD
8/ySoijSp9WINDk1AbgltDhQeherdESFj93J9j/y3sZpx79XjOz0c9okacw8vzpr
vuejmVhg8+85BpHQipW7L05xO+/pwDddaSfSIEqo1gXtwYr09t1q2uGUzhUaiB1T
nHFeNMuHheC8mrKTAXJYUHtxUjDsF8v2Gg7gGRWlD/xweO4LWECkdHheh190/00X
7DOtb8c11ONqJ+taLsi6g3FDvaDppZcitTUDiPN168YN4RkEbRgAz6Lkk1m5SZ1t
4XXu/rRl
=lZiT
-----END PGP SIGNATURE-----

--=_MailMate_726461F8-174E-4D4B-ABC6-4D4C2DC4F38C_=--

