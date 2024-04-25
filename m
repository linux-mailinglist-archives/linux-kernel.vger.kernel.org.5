Return-Path: <linux-kernel+bounces-159047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A497B8B289A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323061F2131C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E324F14F118;
	Thu, 25 Apr 2024 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mXM/6HzM"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4539AFD
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071512; cv=fail; b=icXOE+awXAPnepZldN5yeGMh91HH30qaJ6ykQCPhtxjx3AazAa285rHvsLK+JAfJLsYSzm2WN7VYKUWZfzmOHSKZ34Ll54Jhqanp0byOaqoBy3RQoSpq9RNlvsr7JTtmvYbxLevSwLZu010SA+PClBjtG12MdcDlrWE2IXxJUFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071512; c=relaxed/simple;
	bh=lyGuvxh2/O9vbDYhgDMA5HWIQs1evuuFY5bGyFRfVD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WbEp0ZKrCitufmwgSapurLjpQDcNOs+RRAQ1o1SY1M7GSWlDJBf7OYE/uujsy2ELkTsOKTWHig6tls3se8Ba2PhvTJy6jHslvKLon2PXwbHdVajLsV54+3Uf0IKFzOBKT/KuNmpF768EuesOh6fAMZmCWYEjWiVaazzJK3C7r2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mXM/6HzM; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PnByhZNFKLGkrSarlyN3hgnALBjHg0HQIcdlsYD2tf5cvdmzT38AIx6fbGASE/OYmfZCUaJwSbc4Yx0RtOQhB/TvEfr7pcFRoZbKJJ0ZCqn5xFBv76EqjjLfNVjsEWn0oddPiAm2KxM0oGYNcuZBspSpoPTn5sQuj87la3WLCpKabDBceoaKYVW21CBdu0pnb8TtQaJPA6OIr8xzHRdFlWjsX52moPRuQwtvQUKNy68QzKGMxoQxQG4bEF3XjAlYx/DzEXnb8MrFHQlrzwbvaFbACVLLKVNXAoDG5d08wtSoaraXZl0LXc8ca233hXmpZ17sbwapQwO+CeBNS7dPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0x2XFK151mWo9qrp4GEulz8MeAfS4YXliqIHtir0JNk=;
 b=hHV4EjIFmbS7/ShoXYe7z2tX/n26vpcrrVkn0ZWPV8AzIFZ4Gnx7y8ZFfP2BH/H/63Nl+WE3L15grgZ+Kvr3cc5f3HGQJ2T7qJaogFS6gEfo7jju9AfY71gIlNHY3jHkL824ndh9xRIV3Oe90rab/OboMAC31V0612D+kvDvwDfzhIV+l0QQPLqCJNOQDUMhgIGbm+mUQWwAVfAP6SkxjyeVNFSFGCOWVMAxICRzjXw3eQ4DHc2qDTgbF0tUPiby5wtKGZKGJ4Dvreoy0U/tTsfVbFhWGsivDr+nLqOCKmDYjy8NGVRiXvM28iWkXLEF/2R1jUyye1Lz4UvhJcB0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0x2XFK151mWo9qrp4GEulz8MeAfS4YXliqIHtir0JNk=;
 b=mXM/6HzMeW4tWhNTAmmoySxReWcxt0GrAc+i95X/haQ9Nr77MBk8h7Lh3p+S8VEiutQgaWUu5l6+Rvt89gbFp6ZVnqf/uO/O5KPqJqHGVW2lsIjE//+bDArJBYGrcfmFkLwFjZSmGFxySwuNvDydL4DgWhkFfVWL2ZBw7yuaQG+0MS2xZTT8YKspSNeySFQBcvxwMGa8vnBqNhJB3TIh505NYCkPRQbfRt0j5kxaO3JIBjRMN7lnFDqgLQqkMXBT7ZyzoJUwX26cmZC8fcCEOKF6tlmwi7jyRcuz8fWLBty7jsQ7ZUg6JorrUDTnOW1qpN1MdhXT9UaVCtayCedUVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Thu, 25 Apr 2024 18:58:27 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 18:58:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH v1] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Date: Thu, 25 Apr 2024 14:58:24 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <922F6794-1C32-4862-8A67-90D4F7DBC474@nvidia.com>
In-Reply-To: <20240425170704.3379492-1-ryan.roberts@arm.com>
References: <20240425170704.3379492-1-ryan.roberts@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_CF454BE4-5E59-4757-A4E1-3A9B44627BE9_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:208:23a::28) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: 084df328-181f-4b62-d20f-08dc6559b0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ioYAtmwI85yyNYbbSjFIiPtJYSKeR+g2zruibJkK4Too35NJX/8IzXVNWmVU?=
 =?us-ascii?Q?ldeKZBwg8WdBdOOMj5gdfjbSPXzBdugm+v791KueVuvcmRv9ohmy6HUdH+bY?=
 =?us-ascii?Q?KQj/PlD4YZouCJxIprf7JStHUNW7jiZ8hMT6KFJzprGMO/aT4bTpldgMEMjR?=
 =?us-ascii?Q?qNNR6LDeVbDnLfwLexsF41ZpAvaDbfFpnIE7Iykr0OI59zODlFyD2VE96ELE?=
 =?us-ascii?Q?cnVxiDLoHwIbs6Wn0aU8hCptXwTxiEZNUgMnsc1MX81SkDpJUjp+9IEbkJTu?=
 =?us-ascii?Q?w+Zhqq3m4OTfAOxFoZ9DxHzy3plUdQ0q3kBHvrD7bJsY0fYFTN6I9PDBL1cn?=
 =?us-ascii?Q?n3jzW2qU/BJvC5oyt7E4FZLp/mfqjhHLpcFjcCpUOXJClqn9cdo4lAwrYRNS?=
 =?us-ascii?Q?+W6FTH9hEQQhSK+E7KPWviPwnKqLnqu9FvLtGokRR6K80o6UzP7qQZ/4KIMK?=
 =?us-ascii?Q?/lWim6CO3THhQY5mIerbV2ykOFMtbRxtPB5yb5OZ89sapwi6sGRhNaVaoZ/i?=
 =?us-ascii?Q?DcpG1TiSEl4sfYMxyqChV38U1y0OFliSb/ClaoSg1OPj0rmlMJbx5qesKcM4?=
 =?us-ascii?Q?CFVdVLyX/HLcO5UMPvb9nRmZdBNH5gFxHinQS3IeDj7nt2EcmD0fsMuhTbf4?=
 =?us-ascii?Q?bx/SRYAIQnidG01x0UBCRcpoI4k1tzkkz0vtHgJ+kGPlpf1zZ/pzHnlBEuh2?=
 =?us-ascii?Q?Lcv59MlY8OAJ1KjnQyWfw5DXESr65UybckVR09wMnwU8x7eeAwDb7Z4Abn71?=
 =?us-ascii?Q?BAiGVC31TBRCGujJZXipi3j3G0mgNbjm7HJggbtM6gIna1KTN+6kv3CHk5Px?=
 =?us-ascii?Q?ZGJFwoGq+4lTK2bla5TXv1B2LjGiwCf0CDRa8t5C+l/ZBYPNoN2wz9Kzwxud?=
 =?us-ascii?Q?dCvB4wZO2lxcOMjVGAKmFRJAPTRIiUh3yJpivLsUH0nojFnoBDPzWJoh3jV+?=
 =?us-ascii?Q?w4dySR9LgJPDQwO2EyT9tHjYB2r7puAZBb/XEHGxlLbu/GZwZHkaYMRfnfH/?=
 =?us-ascii?Q?OhYZZxg1+P7RtJI2fZwYAJHW4Ws4Vv6Be0OBEWPtf9oa36dFUPNZrbbwADEI?=
 =?us-ascii?Q?HcxUyU+9kGMCO77McIwjivs8k3z1ITSbyA/WpP1lLxYsoSg3yrdITX5gORNE?=
 =?us-ascii?Q?GsgGpzj35h6cEI3vSRov9hRkrAcqQFpCBCNz/UQDFvkM+0wqyT9hkLLFJLCh?=
 =?us-ascii?Q?liAVLV/Zj/6ljXFJkFXud65TkcsAp6jUAlzRTed0ea9BXlca/cvZgt6vntPh?=
 =?us-ascii?Q?FafhV7+grAQH9J01Y9XQk9EAI+W1rNoPNROnmIqpug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FaKLsoOeGq9fKiy1I+70Vj20cINsKzoN5Z4RlKIZ9y2cniIJ+Q5OsX9XGaEr?=
 =?us-ascii?Q?YdUkDfsEfumqHSCr2T8x1eNghtjpi9qI119Zlz0IG8yQTE5FZlEDnFzaH6ZX?=
 =?us-ascii?Q?tzyMXnNqAsbiWkUsI7Kg6K55Wx7EEZmXaD3nqlGufv8frmreK2mSuq6BGoJj?=
 =?us-ascii?Q?WQ5YCpmgdYFEI8120LHy2Tpq2GGgCks+/6ywKhup4EpGLWYXASVg2jkLwHdG?=
 =?us-ascii?Q?Jub8aSDYzvRYbQ/dMzq5Dg1yqBq+JWFh0rHBBAOGB8UyMO/rn353Pg1oPtVX?=
 =?us-ascii?Q?Oec0KLxsqICv7KOMl7HFbBdTIbyELK0pM/JPpSvliqRiNg/psrN8Lm+fu0JY?=
 =?us-ascii?Q?fMNfh/hYexhEGKr+sxwy1uDC0cTvSIqbO6Pm5oznXWjXxsjYlEjmtEABp4Yn?=
 =?us-ascii?Q?8cavLLMIY68uB7sS+AXrLO/wVgxrePXxoK6hDWpmPG8UGOzWwf2PSotX14f4?=
 =?us-ascii?Q?zD2yDCzdOS6dhIOQfL6Y9F9j+hQNqi/R41INMyrxDwl+FHm3q1h40SDJ0ImX?=
 =?us-ascii?Q?lKmlFK5W4qs8VUj5QiH3hFQZHCpgEZch/c4HHGGgKw7OuqDickRyUUor5ou4?=
 =?us-ascii?Q?oAT/9qQzXsZLg3Sqo8QVUDt8ZCWID0CNS/rd+oIpVV5fMLXN7YiZhNqFpGhP?=
 =?us-ascii?Q?UJhD9B7XlTsWTu6gehX2eZK2s9bIljQPw1WE07re4pW2xB4mivBOjBcP2ksX?=
 =?us-ascii?Q?023Axp1mDWin0QQ/2qb89vCaV4SJkrZkr9EPWjOL96Rnq3p1CSVdA+2L4t3G?=
 =?us-ascii?Q?YmcSGowJVyj0ycrXYKZLT5U5h+pJztjB2ZoQaAqC1gT4n72zBz7SxJTiGqmG?=
 =?us-ascii?Q?STndse7sjItUnl4meKQcV0+N5XyFsfKT6/e8R2X4am1Kciwfq4qENLVTvgCc?=
 =?us-ascii?Q?/MdAME+gbCslABqJsD05e009q/Zix4ShlMkK9/7sIJPNVRAtaXtc/t+NRjOc?=
 =?us-ascii?Q?u47YDdkJKFicZnTYxDw7Mur7pGw1d+2OgDCwJk7lHuvYJi4773k7WC9xj3Gf?=
 =?us-ascii?Q?poGl9Z4LjRQYOpA1OGTWSgwOYNNxkyMQviZbFCSagd/YQ0IrAMy9zOmR3cTP?=
 =?us-ascii?Q?J5CH+pBzYPGhVgce3m/IGiVZfpPbuqRdxgfPoMFDbFSCfEKW0ijMelk8re4M?=
 =?us-ascii?Q?bYUoO3IpJVvWjj7kwVaHVtzHHEuum6RbP4Dpmq4vr7vr0Flzaptq/ngDhxCC?=
 =?us-ascii?Q?ldgsT5TQCLSNtxcMWFgTP61EqpSUXX7xyky3DbKQ46WIoClt7s6qeXOjHVd0?=
 =?us-ascii?Q?Q2JvnkAS0/u+9BH+82blfP+9xpJWIDYO0QC2j532f3ul5btQon6/xeAs2HaB?=
 =?us-ascii?Q?DIQq0g2MB5bZCzB71eBPVaUUvon/1kKSYb7iwtC6P9q8i+ohVTQnzlEzbMhA?=
 =?us-ascii?Q?Y8t561+b9eyjaBDkYzv2+84EJZ1hW0s2wiLRaYwUplfmgm5wfgluKphAjvbd?=
 =?us-ascii?Q?KUZ06JKMCL8xMkms7PJ/j3SuiVF+3rxwI5FFx96DMFLabEg+h74AJL8Wr0M8?=
 =?us-ascii?Q?aR/29rwx/Y+WgRBvQ7QEeFJfUHVy+4s0Gt6V/xQ/rZO7+YuxBKF4X9FYiLZO?=
 =?us-ascii?Q?1V7RL013QpjSKoNRm0w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084df328-181f-4b62-d20f-08dc6559b0bc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 18:58:27.3177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+BRXiqJAZdqCDJin21rR+hqeOljngrT6Wmk2DLQAZuUBamwYzokXAEpoGnXxW6i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398

--=_MailMate_CF454BE4-5E59-4757-A4E1-3A9B44627BE9_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

+Anshuman, who changed pmd_present() semantics. See:
https://lore.kernel.org/all/1599627183-14453-2-git-send-email-anshuman.kh=
andual@arm.com/ and commit b65399f6111b ("arm64/mm: Change
THP helpers to comply with generic MM semantics")

On 25 Apr 2024, at 13:07, Ryan Roberts wrote:

> __split_huge_pmd_locked() can be called for a present THP, devmap or
> (non-present) migration entry. It calls pmdp_invalidate()
> unconditionally on the pmdp and only determines if it is present or not=

> based on the returned old pmd. This is a problem for the migration entr=
y
> case because pmd_mkinvalid(), called by pmdp_invalidate() must only be
> called for a present pmd.
>
> On arm64 at least, pmd_mkinvalid() will mark the pmd such that any
> future call to pmd_present() will return true. And therefore any

But pmd_mkinvalid() on x86 does not behave so. Maybe we should fix
pmd_mkinvalid() on arm64 by not setting PMD_PRESENT_INVALID when the
entry is invalid already. And add a test in mm/debug_vm_pgtable.c.

I notice that x86, risc-v, mips behave the same. loongarch also
has _PAGE_PRESENT_INVALID bit set during pmd_mkinvalid(), but its
pmd_present() makes sure _PAGE_HUEG is set before checks _PAGE_PRESENT_IN=
VALID.
So it is not a problem for loongarch. Add Huacai to confirm this.

Maybe pmd_present() on arm64 can do that too?

> lockless pgtable walker could see the migration entry pmd in this state=

> and start interpretting the fields as if it were present, leading to
> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker=
=2E
> I suspect the same is possible on other architectures.
>
> Fix this by only calling pmdp_invalidate() for a present pmd. And for
> good measure let's add a warning to the generic implementation of
> pmdp_invalidate(). I've manually reviewed all other
> pmdp_invalidate[_ad]() call sites and believe all others to be
> conformant.
>
> This is a theoretical bug found during code review. I don't have any
> test case to trigger it in practice.
>
> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path=
")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>
> Applies on top of v6.9-rc5. Passes all the mm selftests on arm64.
>
> Thanks,
> Ryan
>
>
>  mm/huge_memory.c     | 5 +++--
>  mm/pgtable-generic.c | 2 ++
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 89f58c7603b2..80939ad00718 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2513,12 +2513,12 @@ static void __split_huge_pmd_locked(struct vm_a=
rea_struct *vma, pmd_t *pmd,
>  	 * for this pmd), then we flush the SMP TLB and finally we write the
>  	 * non-huge version of the pmd entry with pmd_populate.
>  	 */
> -	old_pmd =3D pmdp_invalidate(vma, haddr, pmd);
>
> -	pmd_migration =3D is_pmd_migration_entry(old_pmd);
> +	pmd_migration =3D is_pmd_migration_entry(*pmd);
>  	if (unlikely(pmd_migration)) {
>  		swp_entry_t entry;
>
> +		old_pmd =3D *pmd;
>  		entry =3D pmd_to_swp_entry(old_pmd);
>  		page =3D pfn_swap_entry_to_page(entry);
>  		write =3D is_writable_migration_entry(entry);
> @@ -2529,6 +2529,7 @@ static void __split_huge_pmd_locked(struct vm_are=
a_struct *vma, pmd_t *pmd,
>  		soft_dirty =3D pmd_swp_soft_dirty(old_pmd);
>  		uffd_wp =3D pmd_swp_uffd_wp(old_pmd);
>  	} else {
> +		old_pmd =3D pmdp_invalidate(vma, haddr, pmd);
>  		page =3D pmd_page(old_pmd);
>  		folio =3D page_folio(page);
>  		if (pmd_dirty(old_pmd)) {
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index 4fcd959dcc4d..74e34ea90656 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -198,6 +198,7 @@ pgtable_t pgtable_trans_huge_withdraw(struct mm_str=
uct *mm, pmd_t *pmdp)
>  pmd_t pmdp_invalidate(struct vm_area_struct *vma, unsigned long addres=
s,
>  		     pmd_t *pmdp)
>  {
> +	VM_WARN_ON(!pmd_present(*pmdp));
>  	pmd_t old =3D pmdp_establish(vma, address, pmdp, pmd_mkinvalid(*pmdp)=
);
>  	flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>  	return old;
> @@ -208,6 +209,7 @@ pmd_t pmdp_invalidate(struct vm_area_struct *vma, u=
nsigned long address,
>  pmd_t pmdp_invalidate_ad(struct vm_area_struct *vma, unsigned long add=
ress,
>  			 pmd_t *pmdp)
>  {
> +	VM_WARN_ON(!pmd_present(*pmdp));  	return pmdp_invalidate(vma, addres=
s, pmdp);
>  }
>  #endif
> --
> 2.25.1


--
Best Regards,
Yan, Zi

--=_MailMate_CF454BE4-5E59-4757-A4E1-3A9B44627BE9_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYqp9EPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUDp4P/jxTdrH/3DOdmf6Y5bgVzQyskvkbkUdpDKiN
HCHL71bGxG/6veSxdzTpB2pkFS8dxHbbZsJyZ9ZNEBtTRnfKcH5++yYaZiqYWQ6P
UScgkNighIFNX8lYOAGdtp+n83RFRYiglhDsoLARipr4K4lD/8HLJs4DgBG3p5sa
4OUncWdhH9tFtMz3xdtAxA1BsNHCRSoRNH7VzXbgaSgnABkOcOmD2w5zz+arZpRW
V5BBHTDTAQeDf0W0encZ7YeCcC+5zq/eh0fKGhw7piadNlBq9JZGRQWu4WFsdxYp
/qVCujjEH31NnPm9LyDVxck2Ayo/kjD45fH38I5qq9jajT30D4bsMxtoo9gNR5/S
htJaocFgLwtbtfm9Q5NQ2D5YI920NCJh6rJWtcGY5VAqkVhVtxaae025ubsngS1r
D87cWzNriZKvGuNDZ8SOeklxbK5c9WGZpy1q5YTzPi0ybtM7UQYfAU94I46Yo2Vs
IOw5ZAJv/8FYVAmzpn57fk/ZIcaw+33atCbOL9w7bEU6a5fnJd+lXpS7LpP7mmK8
mYLuCdz4FqQLTWFDNhiA09QhihYRhwRTCymDbozOgRW+x7cfBi9aCKh/slaK73Lo
+doI27PM7vozQwAzdPpOe+ExYazIK1dgvRl+2evsO4YZB1HqZvZXki6hJrOqF/AM
3IZVc0c4
=PGBV
-----END PGP SIGNATURE-----

--=_MailMate_CF454BE4-5E59-4757-A4E1-3A9B44627BE9_=--

