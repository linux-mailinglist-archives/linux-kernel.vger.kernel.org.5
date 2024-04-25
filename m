Return-Path: <linux-kernel+bounces-157896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B688B1848
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096931F25247
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EA76AC0;
	Thu, 25 Apr 2024 01:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UXTweR7L"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769CF4C62;
	Thu, 25 Apr 2024 01:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714007116; cv=fail; b=X6cB7x2sUZ3e0fTpHPqnfmusIGnfUm7Mdz1Gjn6uFnXUDy8tmzxawt9CXRy8eLgK5W8/PTrclTbWvy+N6Malz9gNgJW1Di2V26VSl4ji+9+5rey/mV2xsmtL181kiZ3j30RIBkWDGIBOm7mps9925ntzWr/G7rw/GP/pFUxcpLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714007116; c=relaxed/simple;
	bh=9lvuWIVW+nl4Y3QGHbSkiWpd9wMEGP4/d52q+uMTPM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dUrE8c9HQlKqR1ZbQVzCj2plIQgZu+Q4N1ZDkrmqCIGzBbPm7Z3kAnhq+xrmAe1dO3ajTIXRO7QtfukkbB3gfx6Tmi9S9h+euQYHGlt/iTGl3hTXf7KJ23FDd0AgGvEYxr/rAxm1khfXjFMtr2Z3zQb+A+BKGsKmXSFtOQoKr+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UXTweR7L; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfHcRZEwMlsz1QhyC8MAQJ18nHbZmQO2fRv1CQjDsjrUN6Ly9JTy60JSkBwfH+1yud5ZdMoRVSnLwp+ifzT/N4N6/KGFfWhLLE6jILx2dBR13QL5FVUZj8U/GlA3Qbn8CxfE6Vmp7o1SAm20+hSLjHPnVN4x8p6p5gOkKg1gdB9nGVJ1O3PJqSW6mRGHqfJQoEOB691BCyMnOkXvveJZnpPWAyzjyr2UjKwORmY0NJpHUSHuHJEytX+Ak85R5I9aY9ocUpSL/3d/4hrLO0L3Vy0RLGMVYobPDxbE42YEKVuQyIwQobMUFyd0BCmWw90wPHb7Ot0Hwm61oWcHnYMS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdnG26FNnb1V36VqN0LeHs09GCMQ1QQbKL6CHdxKQuc=;
 b=C7lyI8JtZvdhXLMGGWvQKtR+YuNaVP7X8m/1ptWIQNV9Uca6I3waLxUznMsQt7Lo6RrRntKvEXa21T621fpW+7heKLAHPJiPXGyi+GvywlXT6hnD1AG7A4QvMNWMS8mfeBLJwvyYZ9Ej0tV0pZN+mp2Co5GUJUNMhBDCILXYTnSHzKTi43O+RI+qqjZdWZiuwq5SsfUxcnoAhRxx3z+j0DJmvNP4ek+gb6j4JzXLmkCS1l9KSigY6fNHqZEBjrSzbSl6s+S0JCa/M1rvdnyS+eU8c3YX1d4PaA/EhQwXUjgspus4LkFPjyk7BtyTgPh2AfF94GDwt1OhGayLuSYZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdnG26FNnb1V36VqN0LeHs09GCMQ1QQbKL6CHdxKQuc=;
 b=UXTweR7L2TyVp1vnmD8rouCA7DfEScOMHMYrslnhZY+SZr3CAuTFRRpLHM23PmRM4DqwOQDxs8E7NS1Ybw2RVgg74b56xG+NU6RFk4zJ1zUq9ste04+MVoZKQXZm/HRDxY8TL6piflWiywg1dwb7Sgel+vLKRsdSZxDkHvwmDB36bgWI0OOMIhRPWw91m9t1cbI7uvb24lM8L14EY5l+/fSvc/4+dFGCKsuvzfIkBWBHERQKEOJboKngHN2Wm2vOM17U1flTukRGUVGvDg/AXrDZOTkp78W48e84SYDBJ5iHuvrpRJzepTJ8b5vvfiGM2hjkAyRYvjdrJEmfaWUSPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA1PR12MB7198.namprd12.prod.outlook.com (2603:10b6:806:2bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 01:05:06 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 01:05:06 +0000
From: Zi Yan <ziy@nvidia.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, fstests@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org,
 hare@suse.de, john.g.garry@oracle.com, p.raghav@samsung.com,
 da.gomez@samsung.com
Subject: Re: [PATCH 2/2] mm/huge_memory: cap max length on debugfs file entry
 folio split
Date: Wed, 24 Apr 2024 21:05:04 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <AB2FFCD8-6A5B-4E0B-BFE1-4EACC996CA22@nvidia.com>
In-Reply-To: <20240424225449.1498244-3-mcgrof@kernel.org>
References: <20240424225449.1498244-1-mcgrof@kernel.org>
 <20240424225449.1498244-3-mcgrof@kernel.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_93DFCBEB-B9E7-4EDC-8EDC-CFB367B75CC1_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0421.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::6) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA1PR12MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: db4e7582-ba79-46e1-97ce-08dc64c3bed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QZJnGmEufeIJcrsvI0CWSfkKc1O5LAc3qYD2MiQWlYdR2j7oePfsDozOCfyu?=
 =?us-ascii?Q?7q7FwhSxi7eh2D5u3boiR0E2iCO23cXB1GMqfm2pMaSrAtlI7DKeNviOJTjp?=
 =?us-ascii?Q?qyOz9ch99ub9daB0IzXJiY9LWBFJcWExcIynk8D/OQEWqnNHrP1riIJySFPb?=
 =?us-ascii?Q?jLjFU8s1+cNw0lgcJpd5QlS3acUD/rIQeFlK774s0Stsle1Rbo4Uk4DHMqiG?=
 =?us-ascii?Q?WNesr+KyvKd7yZRVYcA/X28UxQpabX9Kt/yQ+wGiQHd9ug6qpuGbQCyNMJLy?=
 =?us-ascii?Q?a+AYnKweb8B9OE+MKx+LzItuLiCSPGc88i/L2esLYzUcU/YfpuaW2XdpMyPg?=
 =?us-ascii?Q?WdlXKWOY2fM93+s2k3gVEdchIwk6lwvC9xJaBfMhz6xyqRaNj9A0OhIX0qaJ?=
 =?us-ascii?Q?VDwJSo7Gm6JlAqnkf7SSq0BMf1CJyvqk2D1o4o+GliOSdVjt/HRLanAXupKb?=
 =?us-ascii?Q?hDJxpe2rtzIhR2AFrcg4+saRCfxaslatIIHqFxDKNBSudIIeBJhg8wEpUP0+?=
 =?us-ascii?Q?OPhZE5p144CAM5BFGu9XKDDVJMjOOQ9escBFjd3q6k/u2Wow1KcS98pV5rK2?=
 =?us-ascii?Q?Ylx82oQW8IMCE3sK9JRJL07/XxahdXgRp5S+u55cp9oYvZOUXNEMpiDKES1N?=
 =?us-ascii?Q?sejnUN+7ddsOXTCTc9IP98M5n+pgQYSqg1alueoq/BoGkYDN2ZveFxSSVj97?=
 =?us-ascii?Q?ut6F3o1U4aW1cfjraBA+rpqwSkcuiwFs5alIuWTcZ/mT2j2rFqH+jrOcJfRd?=
 =?us-ascii?Q?/ZMmTGM9vH03PZPYi7Uodk05huztqX5hxYOU3IPV9HpNb2pnWcTapMUhzNEs?=
 =?us-ascii?Q?OtKH6b65b7Y5+lojh7Jm1U/6i2aWwctuAWUW0+XM8T0y2P5f9NMfZXPmldjj?=
 =?us-ascii?Q?goHDF040kCuQlheSEXzs/br8ttUfIzTCV1HyPVqted+AKcOU3y/xHVKwrnHk?=
 =?us-ascii?Q?1sZy1uBnOJX5zboxwDt1nbV1iUTuquxUEv2GZenj7ipJ5UDKctS8LoM9SZBn?=
 =?us-ascii?Q?oQDeL1tjyjS6u2f3JpSFEKEiz7O6UWP5UOzltBTjbqhb8+0k5QL4VOYu5ztM?=
 =?us-ascii?Q?5QexWX9E8B3zj7U5l3G37cK0v3L+87mr2CrdJKXI5woJxpllqJ6PIzYmx/qw?=
 =?us-ascii?Q?8um3sVJb8wz02qgPg/vmjcmWCOKrttGU0IrKrSXi3nSsbrbbUjNDaHi+sw3p?=
 =?us-ascii?Q?77I9lyDZ9lFTP9c2LShEm25eZLxAKnO66KLpg4PFQotKJHgsmQxx8AA8f71l?=
 =?us-ascii?Q?d+JO18pCK7Thj2ZJQwy2XmnOY8GA36NmdXYFCQYCcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V3u6NRQbfsGiXfxGnOp848irCu7pn3FUEJ6D+GFM/ATsym+d8kqtc8U5wmZ2?=
 =?us-ascii?Q?a6HelEoT+HWwbBSq+hyUsmgqXBWcjqusrotNc88BnMqJeOm8gLxz2ku20XxC?=
 =?us-ascii?Q?3KoTTf4thbA0h+qymYVBnTt5rSepDW/1f+4JbM/ck1qnSFJlEEg82hjjhd2D?=
 =?us-ascii?Q?ye8RhfdlEh5VaPdwq5SeZVqH+jGli3D/iL9wWEI6XZVlwnU60QJYX2W0I8s7?=
 =?us-ascii?Q?vLJTda/aM/6azSmyo3Eu+FKB93JfEqqr/UV4/A/hVRNLZWpFzHstJUcGDaVb?=
 =?us-ascii?Q?UMtypNMKZdg/TNjpag/FGrupDR1hWhk9vxo13REMSb/D1/uRxyeeN1/DxdIO?=
 =?us-ascii?Q?XDdSHbfvzMgBShN7rcopB6zQR5rjowa6q7SSudPPjB2U0tacVAyiz75hZ46O?=
 =?us-ascii?Q?KmaAbQMDBBFiqRpapZoy45tOWhGaETz1W2KaQc+tGlnM6K+42zm4w4A2TWRz?=
 =?us-ascii?Q?nXqwoIcSN2ifOiP2J8Or3qvKkZq6L04ZDrkInLbkV+hitoqI7Rdw50pD0xfJ?=
 =?us-ascii?Q?Jnu2kjVB9+mKtMU8+fk/j+X9DJGllVFnGaNdJwRIYRNTGUcpazUij2LyI3Pa?=
 =?us-ascii?Q?P8NUvD+90+s5SzjOc9Pb1LWa0s8aY9E35J3QIxONo0RD1qvQO2WUlXBcdDrU?=
 =?us-ascii?Q?jONzSfR3fVZolJDMsw9fXkkdCiW1mew/eW+UhQo7QSWsJU3WhdU85AUImDkA?=
 =?us-ascii?Q?dhA82Eym5xzAohgd8wuCIv2sFL917DuwKQF7Xpj1Nj0H4PytMyWAgvZeNoWz?=
 =?us-ascii?Q?/QFtGTq6JAl1him23g0Mwdy0Sp7GVqHvVEGJ8BBu2S2/sYrvN4lETRSSRxEq?=
 =?us-ascii?Q?d67+xfMhgwMZu9oz7M+13FWKcfiQbXtoEwE3ApbpM3qBAMvnZMxvfRqks2uC?=
 =?us-ascii?Q?nMAHkd1BLmEmsOBzSNJit3kV2PytkCJNm2z5Mreu/symJRVpnyuPjZfICXtt?=
 =?us-ascii?Q?iQcuaU2gT5ySnA8FvIyjfpTxlLGGbQRidDzA9cvIPLZoCPm6om3iqY9eajm+?=
 =?us-ascii?Q?dDaupkLqHgYRnfVGcAWBLiptMusUL2Ah8iqEX/tdVYGYowyr8XgKQdFdELla?=
 =?us-ascii?Q?x30kwNXO9/5QjkVbFPX50J28qP7vEQ1vpp7ZT7SIylAN2B5FhcgMg0xnLBg8?=
 =?us-ascii?Q?KtieO5x6BLPNukTU5jCU3OyWXYrMV8BKh5nmzXCEsu8Qpj8nhFGkRaoedUgg?=
 =?us-ascii?Q?Ah8QY1y09lm4n/LyQPCjCAsK+Qf/ZsWDJgn6yosbS8pj0bodtWj9OwZ/mMsE?=
 =?us-ascii?Q?TCLGyJRtYvDkVJzgxnhR+a0DO3RxuA4BuSA1VVbWSHjI39s/ol8+I8NbsVFf?=
 =?us-ascii?Q?SksqnichuzBBWe9mh5SbaVkQ7FFohZ8iQbtFPqYqpkM1fcwdPmL29g7VA4dA?=
 =?us-ascii?Q?6CI7Epn1X6b3TVYC1/QbFDVkiGJbYasPhv5ZwBLGj76fkvT2es7wGJbVvRCG?=
 =?us-ascii?Q?F6JsW77rRnzlhnPJnkTn9AP3svZEdE1skRpbB7E2zjYrXyXiBGetBLxPF/QM?=
 =?us-ascii?Q?RU1L/ZgOJLtuAGP7Mki6G9oqEZm9BaM1RqJg9krEeKC52HG/lofVtXzfBab3?=
 =?us-ascii?Q?YKUtxrSDl3lHwfQs3YKGbisEuCWVPRA+ydKJlocQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4e7582-ba79-46e1-97ce-08dc64c3bed1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 01:05:06.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQDKPsAp3plAlnEuoaof6sqYl6Q+W08YqNnKiH+51V/rLK2C7X4Vg6L+89rszHne
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7198

--=_MailMate_93DFCBEB-B9E7-4EDC-8EDC-CFB367B75CC1_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 24 Apr 2024, at 18:54, Luis Chamberlain wrote:

> Don't allow to query beyond a mapped file's length. Since this is just
> a debugfs interface allow userspace to be lazy and use a large value so=

> we can just use the entire file.
>
> Without this we can end up wasting cycles looking for folios which
> just don't exist for no good reason.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  mm/huge_memory.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 8386d24a163e..86a8c7b3b8dc 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3535,7 +3535,7 @@ static int split_huge_pages_in_file(const char *f=
ile_path, pgoff_t off_start,
>  	struct file *candidate;
>  	struct address_space *mapping;
>  	int ret =3D -EINVAL;
> -	pgoff_t index;
> +	pgoff_t index, fsize;
>  	int nr_pages =3D 1;
>  	unsigned long total =3D 0, split =3D 0;
>
> @@ -3547,11 +3547,14 @@ static int split_huge_pages_in_file(const char =
*file_path, pgoff_t off_start,
>  	if (IS_ERR(candidate))
>  		goto out;
>
> +	mapping =3D candidate->f_mapping;
> +	fsize =3D i_size_read(mapping->host);
> +	if (off_end > fsize)
> +		off_end =3D fsize;
> +
>  	pr_debug("split file-backed THPs in file: %s, page offset: [0x%lx - 0=
x%lx]\n",
>  		 file_path, off_start, off_end);
>
> -	mapping =3D candidate->f_mapping;
> -
>  	for (index =3D off_start; index < off_end; index +=3D nr_pages) {
>  		struct folio *folio =3D filemap_get_folio(mapping, index);

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_93DFCBEB-B9E7-4EDC-8EDC-CFB367B75CC1_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYprEAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUoa0QAJFvYFTTzizyPC8tlq87XYVxqPXn+BTz6K1B
m86NEIR3LxM59xEwGbmT/ReMR628Qs4nj9S86v5WGN09NaPyArNQcOoW9PR9NZD0
II/ldsGg7U7xrev80vfyRIQ+VUZutz8Oaoe41OfmGAMrp/5S2Kpz73knf2Zxd7KN
M71TQlzwJntdx+XK+alQnJj4UcgyMq3HMvA6Yr2lmgQ85Et7LWrCgo5W3oovz+n5
kB57Y2JFZyZkaDKZKJIM4M7LYSuvJYxrjMVLQZi5pETSgfYYZwlul2br+KXrlAAP
suV+K+VyWsTZ0rgQCHHZx1v4DLH2EBbkqQKLOfyPu/+m7PuxsKCAhTvh4PAMSz3h
UvpcYLYVPWh0dsDHPhhGp7+cABwahwAsT6HC5/MfnZepBbvrHRIs+MJIpO1fv+mi
qF7p7MBfwyKXSueS7MnYfEFqiQBoZNoh0PfJ7Hvw54YrzSy5uqgPr7PpZorw/mkX
fj0+dgyQOJZ63FAb9pq+veqT2kCqAp9IGMnPsnZ3UWx9M0l+XlRSljhZ1IEYt+UB
2aC4kkWhyBFxQ3Y2XmUXR5quI2uifBeX8jLxOwuOUf1yNEIsXVLKvUPaWrDI4dH7
r4H3/o1r+bgLhU0ZRjqdYvAy7CpauZcQNL0Z2Rt/FArZ1ph/QKB8JfgHaLKDhY7B
8WPHmg6D
=CPe/
-----END PGP SIGNATURE-----

--=_MailMate_93DFCBEB-B9E7-4EDC-8EDC-CFB367B75CC1_=--

