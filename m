Return-Path: <linux-kernel+bounces-117147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8C888AF24
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B82C41BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C616D156875;
	Mon, 25 Mar 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SYvtx7Pn"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4456D13D526
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711373313; cv=fail; b=Xv9vrJr47FBvTmhk+Axx6n7JyJc9ckJSqozVym0MoaJmLqd2XCt2x79R9oQMR0QnHOAHy57xTrHUq3dgKmveRvEKLIaoOSKmuZiz14JdbBxvLOvUcegsQvGkH71fQwBfNGG+hlaI3tF2/W3FuIl9C/oZx+JMumedVx3eOGFUEgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711373313; c=relaxed/simple;
	bh=ogoUMXO90XIUOv2BxHxhQBwjX1ZolmiNcs7tcRdX0Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nTg5aiU82vLpJwZ3fQT4hMipFeNMm3CYJeVivD5qHMG6HorqwEgHmjO/vy2Q9MbXyJvpuUfA/I+voGRQqze4Gym8AeEQ+wkUH40YEOKjajcdytDA0dr1uMXJ3tvsG8aGmv8LBdbJGOiHt0jvVuVF0qapYftxgaddAgr+6DyXW3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SYvtx7Pn; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDonj8lwTO28/Abb91vCBHkcPBtkW0UTBtLHlligdEwi0s4MCvhMjO/TpWEL68XP76VfU7tUPCzqebSWRICSobdc+6srjMIxXhswArhHmOgucOsOul78v+fD1uZwsfMCbsaBwnhntacBr+LijPWDIKI8FLA09BiKfDK7FRpN6BXjgXazMeIAXFO5CWi9dGUQMTqtwsU/99BBjRRxJ4F/Rfh/wrdbKUH2tEUYsCJX7KEMUait4kQNYsV/FFO/ld3Q44QnjBcx+O66kRGwePvNYnDkUlc+1BSFYW9CHoNgMKyy/DJwTHFLCG2Fc5ZdtinYGom3DHW1JRWhXQkIRaPZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8RzvTUPE3KdTikn0a0slWcTcHZOLCNSjIWKJWWfFtM=;
 b=Honl5LGO5U5ZVMO7S3Db1wUm6/VTVrUs5/P/KwAP7776dOedm2XEUVwEUuGz5RgVlHn28UMpz7HaCd4JxOkIdY/VumhGDFnvegDn58wCD9lOQrjEDvnlLIhNesHUNehjPnJ9isgpchG8CZfGB13O0i8qe52W3P2kiPzVZredkZuNPne6+LcFeyAJyHV4fPmpoMaN60q7yYwBPSnMlHF70cEPbOHigPnuifSCgKJPUHNAQ84mCGyji9EtD8CD7ncTYzwoRebdY0keO9tMCvAg4KQU8iD3j7W36XZDhcitNMgA7o67/+YndnkOVSa/WqvDvtqYQwy/XdL3uP897VafCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8RzvTUPE3KdTikn0a0slWcTcHZOLCNSjIWKJWWfFtM=;
 b=SYvtx7PnYEbAvAeD1sfPKG0/62VgXQ+iMx2rggVqy7n2nQ8zM3/oyzK8alytv4l//rOlYw0mqwoTcf/dONbP4c8piI3fAdupe2C8+J9/OC9BOrxw1IB7YWFFXyHtP3bhW9sYruB8jKICyWqpRAbGlBC8xMv/ro77gNclkrxHD66ilimh/1ynJZ4SoHR2aEyuuOFvDH9ZVGcVJ/ajRIY22nLpUD1q4lu2R0qY9KAeNdsIBcUSAjcP9tcqPkAQgckSnk9leB+YG0opEMXdSnJrRMNqL1vHyZXtLusP1kr2MkoJR3dRR5F2JFHwG4FEMIPCCwJTJlLGg9SeBMhxRsbvwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 13:28:26 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 13:28:19 +0000
From: Zi Yan <ziy@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] huge_memory.c: document huge page splitting rules more
 thoroughly
Date: Mon, 25 Mar 2024 09:28:17 -0400
X-Mailer: MailMate (1.14r6028)
Message-ID: <B9A3BBFA-5DE2-4C72-9CB0-38086001577F@nvidia.com>
In-Reply-To: <20240325044452.217463-1-jhubbard@nvidia.com>
References: <20240325044452.217463-1-jhubbard@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_DDAFBCDB-A1D1-423F-969B-5B792FD518AB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR15CA0023.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::36) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: acdbe4ef-8203-4c4b-bb16-08dc4ccf6fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fvcizw9KfvIvGtQf0a5QV42o2CPToD0dmFrptrL9bu2Q/EUjMCOYYXC5FOol8Own6Dm6gUKT67ox511ICSVkSEtwkQM87drKq+/Pv5H0igHAeFtJLb8DRIrsbdvJ+RPSzfVDMomyP4QZ9uBkvDkqd2MyRHbiaDYAvLj+SI+mLEOX4cmBMtKKzo58y+h55KmdA0qFpeTlnrBNZJEbCBNv2fa3BH/WvVKRh0XFQEI8njR5/UHksIW4vT5j/qr9SutfgALFRjnEJ0J7qpzJQ4NuY5p/bkqOopqmnQHPPkygmRfeOT7BUxpRtq31n1cm4MGFjlxtwKh5Ai4+I4LBpcNPqoOSNtxVNRbnmEdVG3KYPIy9GFW7d9npnKxq/HHVuVL6EkO936WPjEdZsfaGq78NAKx9XpfsCA8q4NQaUG0+H6cHGDyAGY1eesgVq+xPB8Mr2U3WqVX1/my90dvTMDLMu7kE/oc8eOlujHgQW6KQIN6oZl99OTNpqm7DrGph9IPeX+U+nWZdaHtmrvKJiHBjFB/h0aY+KyGrk+FJAPjdwYy/HCxQlgPArUMHIq5pyF+lT3Dig2PrFgSeiF6wOS1W87JQO16TcNQcdb1jcR2LJ/ewBjeq+bhDhoLkevZU+7nEA+VXn8blDRZBl1um/F5FTCLKAeiLL2cNdNfr4dxsuqI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/npDiC7tFk9If5xSrZ4c7ObCOXHifMSQp5NYm1KC2L15haJrOpYngAvlFqA+?=
 =?us-ascii?Q?n7Enufc5zEbHuluOTR2EdYrPSB1TOnLNQwlUfKZYfvusYzb8cYrMgzRFkM6N?=
 =?us-ascii?Q?OorhcPUIK7hMdtYRWqPG7TpYtsWdtfQ8B9FMIaWzdwUtm9wMgc40p91Nzwt5?=
 =?us-ascii?Q?a4CsSqkpCoLRFOw5MwAic6NOJhhEwbjVz8gxb1uWpfeZw50/ab36mEXHIHX5?=
 =?us-ascii?Q?24M56IYP5sPlcFrXuB32t16FCXysFBFSVWPTLjI4ol1ukP7Bp2v7Qtq1MZ/P?=
 =?us-ascii?Q?TCgVhLs+mbpSfBrtMbe+ArUL1xjmqcGkOTczwOQdhgFVvw6yXT+78Wis8+Lo?=
 =?us-ascii?Q?p8yphSfqTF7VAqQZb/Sibv8YXqmtBxChnQ4wcK3lgY/ES3L8WAVP6YcNItuY?=
 =?us-ascii?Q?kii4OmNhWWFhbgYxh9igBKH/ikCpFRikMbjKD6tBO6THF/V3YiFupjH78jmt?=
 =?us-ascii?Q?TbSuoFc1hLaP33rIw0XnmO8ezjVLICSSj2L9SperKMBVtVolMMaMlzoOU8v0?=
 =?us-ascii?Q?PzETDVYnIMGBumwdLEXEDUKOSh4rYPYauWw54XtXsT565+7JXgW/hxe6hBXP?=
 =?us-ascii?Q?o0kfSZCrpJhUmsae7fGrOflJk3Oea4cPv7yKuaGM91Et0gJLmHk6pQb+Oqo1?=
 =?us-ascii?Q?l4eMxAX5I9wWiKc7GaKEHmq4AvD/xQkRRNh4wOa0zo5HqsZesz+7Dm+TPhC+?=
 =?us-ascii?Q?NSDXV4/UG7p15V23YFeDjl2c6F5iQ4iy0JKQp/LWdvtKEl0p9g5pyFC2qbFY?=
 =?us-ascii?Q?pfwGWDczQ/1cbNjYNUk5jqm0CM5VcjZLHpAW41ZsifVl6niC8SG8bjpJ65l0?=
 =?us-ascii?Q?XX2qwmZ3Nm2dCpSPLD/y+s/SCFdt2vFGeW4rHdVjzFUzIFu04HbqiU1lEqjT?=
 =?us-ascii?Q?EEy58X3BTnSeVY9+GbvBIfqePE0RvmjQciOezGwmKVw6c5wY9Ov4FbVHqB/j?=
 =?us-ascii?Q?dWt13hCV2QE04VKsP+ewTvOhYrCRELLCvS9JWp78CPfmYZUqCnCzxktHu6yf?=
 =?us-ascii?Q?93vi22MIAnYO1TMP1Qc/7ogNoYddGA3VyqCH8H2zu4lKg2JrlrKP3ulRA+Sk?=
 =?us-ascii?Q?FBRtsessJpI127tEFITncDKl5AgOsBlzQ2UbJf9WeT0/+f3lkeaS+fQVM1uF?=
 =?us-ascii?Q?8NZyleFUoLYH5LbU2QgXKb0pTB9y928Sq+En/+v1l06C3ckfgH9bBjBb1wBV?=
 =?us-ascii?Q?VjaEomhdMZp8WdrvvCYA1IxWicQeXJYo8RWlLG3dBdrZybKiRLnU3Fg19xzj?=
 =?us-ascii?Q?on1f9xDgRlkm9Fte2uhHIs0b/OUdYScARU/3fjeLROhWFDv+G4P9499nNGIY?=
 =?us-ascii?Q?Qrk3Y2b0/w68HsCX+MpiY/m84OLQ6I+DDWbh9jSMGcP9tv8j90xcI+oY1mP3?=
 =?us-ascii?Q?/XmBxeQfHO5Hz/C1mjflaynNoMs2Fc85qtO1RUOjnwWES1qNFwezgl2zEQB0?=
 =?us-ascii?Q?nPTjr/hiSuSrB+rZ1nhhDsxnX/X8n1sP4qC4jcohm+gioc3Mv6ZNnA3FVPV4?=
 =?us-ascii?Q?BVauc1E70aghrvCfJwhdkdno3bY2tLwpIU3NQL7jGVeI4Z2b8WV0xTJvmkWU?=
 =?us-ascii?Q?FV450HNH/Asap4eDKC8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdbe4ef-8203-4c4b-bb16-08dc4ccf6fcb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 13:28:19.8433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSc8y8CGEUSCl8SYfLmD7awEWaegucs26EqBn57NJyBu/pJIwppkchJNkrxDqs9u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983

--=_MailMate_DDAFBCDB-A1D1-423F-969B-5B792FD518AB_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 25 Mar 2024, at 0:44, John Hubbard wrote:

> 1. Add information about the behavior of huge page splitting, with
>    respect to page/folio refcounts, and gup/pup pins.
>
> 2. Update and clarify the existing documentation, to compensate for the=

>    ravages of time and code change.
>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Zi Yan <ziy@nvidia.com>
>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>
> Hi David, Matthew, Zi,
>
> This is a follow up from our short email thread of a week ago [1].
>
> Zi, I've inflicted some minor violence upon your original wording, and
> moved it into a Prerequisites section (item 4).
>
>
> [1] https://lore.kernel.org/all/d9c06bec-805f-4d53-9f91-6b8ad29fcb6b@re=
dhat.com/
>
> thanks,
> John Hubbard
> NVIDIA
>
>  mm/huge_memory.c | 42 +++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
>
LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_DDAFBCDB-A1D1-423F-969B-5B792FD518AB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYBe/IPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUA9AQAIVyi8yvBYVeUpP/o7g+C3moGAD8TrXR/Qyn
s6LDdahfGD+03ev9hUh6VbyO8xSMF339WZq6+tcEoBAvLt0NFH5F43W3qgZ35kr2
lw6CH8nYljHlk/YYTZ6Iq/sv2P2k4kYF9raIYD1uL817MHXDCIPEEzXNINzZPWtE
G397IrfUJKyvDX8Vqi9DQhO62q5Btj5lzfnM1km1htS8kU408+D9OriSVR7L9IfK
MJNHJUoK3HtoaeS0DCGFUaBzKYHmM+1TLFIEe7ZJPmLtGtdWEerlA20keL4RiBY9
yHJ/MXEqgUvJvhci/lxiuD5Vhn7xP5XRVCj4jh8updQkocp7bM2XcAzhIhl7wDtc
jWU6esVHyefrty0yE8sKf5ov+EvvwuyEB4wXaQ40c2LH5J+RtIlc0ovNAmZOOR2+
KA4vVIxkFZlifoEB7VMy7ZMxqNsZjflk37Rf1tVtBvMozjZT1HISI7pWC202Lv/9
5KxUy4bZQexhsbea7ZL95Lzl/0CyvBrYLQk7KdTH0CY2QIBtiBeYMzsLb9/O7Woz
THF2LyMzT6F3TzcsxooUZuDp/ZiugHxOMQ4mCVT27KyjB1fUhnSKa9wOK084BuK7
A2ciKx6QpQynhVRcWlQdY6waJU1uV5ZYzcpiPS5ynHlx5uHfMz6DNJy41NzrrxBP
qZNjDLnX
=WX2j
-----END PGP SIGNATURE-----

--=_MailMate_DDAFBCDB-A1D1-423F-969B-5B792FD518AB_=--

