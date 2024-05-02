Return-Path: <linux-kernel+bounces-165897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BC98B9319
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A877F2835F0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3B812E75;
	Thu,  2 May 2024 01:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WL0XkNGr"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F212B87;
	Thu,  2 May 2024 01:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714613254; cv=fail; b=ggL4Xl+w4S91OdhlkZULqdtCh+eQJNVBaIDh1M8MUdfhtaSwa/v3sul+yPztIdDi9WsgJ2UaILG4z+eMf/kI4VHIlhE9e2Zk6OWQRfjlhkkgCOwapCgdCVPSqdSKzYMzPehNnXaxOKQBXkpF17DlKEguGQLJNugO/pLaBBsY7+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714613254; c=relaxed/simple;
	bh=BvHnWlYEh15aNmuFOyTj+zQGsfup/5G+4BczRMrOc1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mG5Zc6n/7WNcfqyYyRsYFIycVlUTAIUn7xZq/mUTkwM6Ldr+y4pv6jNJ+yEwleMcmhGbwFaOyouL8ladqrOxMKGYttuCDc4BlatsbDHbEyTfUzCkpCY1gccao2B+VP2Ah/QGp8SiZB5KTRU46Eoo8cvOaJ5lrB403rTQ5BMKT+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WL0XkNGr; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLBRT0dmO1ZlPd3lE7lHIkOdBQVTvgq9BeQsDpD0idHstRBWGv/N0Xgo723o6QZY0DCUL5AZ42Ikwncv32xNNkZMt5ReJxUik71uyOcmzdWrhhZNTnj6Tq0+Zlzsvc0zgynsy+PmsctwtwJMLCPdloxuMmV/eLVdkhvpUQXracRtk2PB1ZBFkNEzexzlhTFHjBEU0Dt46ZHZHW5X77jWFsnJ5Ve7bVq2fTYwbeG5eQxqZmQqOfnmDCyjZg+GsyIons/1s6BkTk5gMKn1op2G2Rz52kuOJhKfdud6H+eAND/v4KNkFnp9rNg7XH/06SQ5EwkE6+j1ckeUfNKQYZOc0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yg7ibwM48FmNV4ZOs4OxbUoOv4uxcNol0PNS2TOR5W4=;
 b=ZzoDtonv9at3Csk6lPt6aLtqzDvPH54aDcDFLThPZFkIKU3VZULrwi++5OldHqFCiv4MPeKx9EKiRI4hThmE46DDYeKUQxoa4IXko/1gmUfar/XexDE9nMmC3l5fvezvLlV78HAp6F1MIlipJbml2HTiQrWkz82CNdD3HczeGQrSR7tBtY/2Yvw5ZKPr77j+NBCcyS4Dv5R8I9hBgVhBynYrWBZI0Se+y5CzAGRPUh55JIzefGYRH8dn353UPq20P5rWL6VBfpt+O+w9uUjFOU7bKA8kPlIjoRHUB7Oys4K28UpqTjkotGsFoLPk6f/bj3ypFX5cK2ONRO/xavMG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg7ibwM48FmNV4ZOs4OxbUoOv4uxcNol0PNS2TOR5W4=;
 b=WL0XkNGrqF/lEiMHVnZiddIlOEeGRh87tPWGFeu4AZQh1snL0w+oYwYC/UZbifJpvRp3yz7BKDgmRNOFe519+/7ze9bK1ERfG/V4KFF7Oh6Wzx/SBzJGWvPMQhV7lMVYLsxKBUebd5IdYpp6jDwPj6h8uuJ1buYMF4WgQHRUYaijQ5iuLd6gRNYp3n8DRtnpOX+BkpFDpg3KPEx1AIaPC4b3yjJwaL0yZhhG9NVPqaFIQEgIKILXHusp2SAC92rM3CDt1aXwmW6pPi6S1SBWTt8ZDgQEsKy/1AvnJ60ieJjiBaEk1HSsX03/Rgt2VTjvFAxwBbb5ZMUCkq89lSoL5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY5PR12MB6432.namprd12.prod.outlook.com (2603:10b6:930:38::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.29; Thu, 2 May 2024 01:27:29 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%3]) with mapi id 15.20.7544.023; Thu, 2 May 2024
 01:27:29 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: Fix race between __split_huge_pmd_locked() and
 GUP-fast
Date: Wed, 01 May 2024 21:27:26 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <4992C22D-D7B7-4B6F-8A50-E084163BEF42@nvidia.com>
In-Reply-To: <20240501143310.1381675-1-ryan.roberts@arm.com>
References: <20240501143310.1381675-1-ryan.roberts@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_8785460F-D7C1-49E2-A915-6322DAE5CB54_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0165.namprd03.prod.outlook.com
 (2603:10b6:208:32f::9) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY5PR12MB6432:EE_
X-MS-Office365-Filtering-Correlation-Id: 43656432-17d9-46d7-c3c2-08dc6a47081c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eAhqiPFWF9PK9pgmqH1lZwQCqmLYa7QJ+5HGMSCLSn5nV7jnuEqhYj895Hn8?=
 =?us-ascii?Q?Oa2qAofgL4a8Lz6DK6oXbxyHfUqvo3pd5DbToRaupcb7UVAmR6nmJQJ1+72A?=
 =?us-ascii?Q?Z/RKVokSnUHYYDcEWDmbjZaORks4m56EpnVBH5QU7NdH2kxHGJwS7/w8m8H3?=
 =?us-ascii?Q?Qsk7FW42E3IN10umv8EKP0i9GSdHbJMKt2lzs73cipkwspNF9m2PA0EafUSG?=
 =?us-ascii?Q?YCNpZbhSf5OIDVCR2MKkfP9McoMbs9tH9Ajo133jCCocqRqn6aivIVFCnEVQ?=
 =?us-ascii?Q?pIPm7Cj2CIcLSqaNNLgNTcI49RAQJAk1Z8LamE+ZhoG+CXOVyIPXJ/rxs8PA?=
 =?us-ascii?Q?PypZnkI0f/lEC5jv8JR1sfbqOhwMHxS0eVy6ZEFI22ZHdezk3+xPYSNJVVDi?=
 =?us-ascii?Q?b2hdz4++cTs44aJaW/AqawzojE/iqX5Pi+l0EOz2xzxIRepYDRq4u0Ba+9y5?=
 =?us-ascii?Q?Fz4Ko0HApPszPVbHRv7Ct7jEuwFmuX5ZrRvPsAjvcmEbJqarNpVbcLZaduDB?=
 =?us-ascii?Q?VYYRXOZk2UjcvjtuaFPJd1wHZzYWoSUighkso5OCpm3X5RVsF7mug54r1w+q?=
 =?us-ascii?Q?0cY6QxJv6C8Z3p1h6FYsIKi5vV3BDGu12vRymzA2qTGJHMg2Vvt4fBBw7xya?=
 =?us-ascii?Q?eNxLOXhB28pADr9poqGx47Fzay6NGkgCg1tEwbN6S6g4QSUjum0Wny/cAA2I?=
 =?us-ascii?Q?rzCHwntWE9BOgPkhroGBO3Hs9FvQwWyfXq3mKxmkDlQZT/4H4vLojoh7ZWsi?=
 =?us-ascii?Q?sRgKtIfXynM18gGnzNz+sU/I798l8g84JggZhHuuREIcjNDy24kvQwro1By9?=
 =?us-ascii?Q?PEKVA6Iv8B/CRftX3bDmujUnZBhFxyl07vp6ivIXVvSWTPgx2+XNKXneL7fa?=
 =?us-ascii?Q?ilKvLoo4TifTuMJ60BylWqJvB9IIbKqDWCpk3T552RHlT3BrQyAz2Ngm31zF?=
 =?us-ascii?Q?RO+ZdogFkR0fJnS589ZOSIaEjNi3hwEBWugehvinxzIpwuhH/yJEDaq8Ogv+?=
 =?us-ascii?Q?i/5o2GWUa3sBftG1rIUaa417MRo/mKMTVPi80ZhZxePbc0T7KOMBQDnXEy3+?=
 =?us-ascii?Q?PkySxsTOmwm9Ixgi66b5w8+Tod84L76Y+op5IVGN6mdcSXpTSnYBFnPUzXKG?=
 =?us-ascii?Q?JNs6EKWg/P6vuk9jxSR6E781uGsshlmFoR5oYN+uZvAhFX/zyDD30jQEo2kx?=
 =?us-ascii?Q?/gL78oCDIjXXhT5tBMM9pznaewN5xjhRcMXs0EHt5fG0B5LJVIfEvHppqm7H?=
 =?us-ascii?Q?cKjtRCrsg3E3xrR+lYIqHIc76IZ4CZF+Mm7KNEUSvg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gsQdxMwJo2aPEavqOv77d0uSBSxl0rzkPFoIUNHVGcRfEz/qg1e8pJITUp4p?=
 =?us-ascii?Q?afpY7i9qt3faJ0pQkE8p616cJ++BmP9Ij+542V9OXUgS7M7ikvC4FpZ3PSUA?=
 =?us-ascii?Q?iw3t9KALb17FwlbaW7cmfXn2hgIBqbqSIB9OM1I0urYeq41d8T69BwHUTZhr?=
 =?us-ascii?Q?Q3omUcUMsrvXlj7mtS6SOxo/dImYZ+aFlR9J9DpHwOvvB6fktxmivGwmxQ7r?=
 =?us-ascii?Q?HfQI8foq43UrruQk1p0BEapawb0JwL9oeVaidfs9MaGzOBApGaRuchIeImc8?=
 =?us-ascii?Q?Gypl2gLz/8NafSkIUtcmk8JQJ2mklOEQCZWVDw93Srpd/RKkiSZor3a7iuMb?=
 =?us-ascii?Q?uYcgZfTAi3yy0FzH8RwUVri7GDdwmUQ7LFjPJNyRAXh0H/nU7MFNjtP+HRto?=
 =?us-ascii?Q?xx0u6VLjgQb8Acj26txax30ZFanF3IvJLjECllq+9nRJcWjYNyNboQGr9y/g?=
 =?us-ascii?Q?nWbFcg9YupfWTwgEt4AvPRW7jJm4GCXx2Kv17BUQBmkxgDZTN+2DDM0v3cO4?=
 =?us-ascii?Q?uvikw4E+yTwYFOoZb749MoGeCTq5D/DIoMRSgPoOgu1kIuHSIMXr03Jl2/0Q?=
 =?us-ascii?Q?bRJ40TGPa+MuyUNYJY3mhL9xfBOUqGukeOghCQabXNYfKVMPqcMjl+nVZNsL?=
 =?us-ascii?Q?zYzRLR74slR+9MjumF26ZbziW/ZAXMH8z8rF0C4X+hUsZ3InkOuq43lHDQHK?=
 =?us-ascii?Q?vJwxRp05TQl9GOrUL2wLnDYABZL54fc5VjdGGxqlPWK3lQn5qw0KKAgRsQ9k?=
 =?us-ascii?Q?j2p8cixp3oxk/eP8OME1A7EQcdlXClIkdLyXXqYKQh6V4v6xlga+mLrNxKMn?=
 =?us-ascii?Q?AygmMgnN9+9cfxVWFaUDvwLUiUO2UV06fgdmmchbFs+vwpIfMSZg2ooXiVWs?=
 =?us-ascii?Q?sdt0nbaMZ+CgGwjYs0fpRC9xEI8fHNBHrJgzxL9RHlC1sE2PnBVqqP/jHcUD?=
 =?us-ascii?Q?ahXv50Bixf+p8+cNIYQRGAkj7oMaoSQO2GADS01nflsZR2YAtPYt2IKbQZv7?=
 =?us-ascii?Q?J5OinNL1bZqJ28+i/Q/A9DsVIuTRCI+KcJ2KZ6Nzr9GC16bdDp3cTDzaUw2u?=
 =?us-ascii?Q?8Cs0z9jgTmNE512idvu9lCsWXXVZ99gtK6+DxLcTLN6uttSvtV69RN82N2lw?=
 =?us-ascii?Q?i9NUjB37dUZKQO4oWbu0/wPPA6ouVCkrdTf8rCA1mwvLF738THCdhAdf/W4v?=
 =?us-ascii?Q?orYwd2bbRNRROHqHNXYhsUhH2CJdFtjrDM+oEHQp551nGbRodyZaHgZSR+iQ?=
 =?us-ascii?Q?PAhMWkTpO7HdtfoqTaGaTiEAQDoXinJqJzeh1xH4AB4DWQu2IiejeyfZmnXh?=
 =?us-ascii?Q?ytaS4KHE/K0vur30xjdPJ+BuUIRUl3vzyx6UAKR5WHplB+MyabvgBIz/H4fQ?=
 =?us-ascii?Q?DjIIvd62KZ83lK6XtiCTp8Y/LN3slH372npQJyXZlVju7zvza1eBsGKyDRWa?=
 =?us-ascii?Q?QqrlNEQWP2SXMiaUFCH6TDDCPNsRWbOWavqyYctFih7Wv+0ZfeLcYpyVl+a0?=
 =?us-ascii?Q?+ylsmM788+xRv0JvtXAPPBFGrb0U2cmIIkf6WR8kgQ8a9LK8duyqaeVTLB6t?=
 =?us-ascii?Q?VT8OmIaQ/AJZyRBS8ySJLgMcBbifo9zTmJmovezJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43656432-17d9-46d7-c3c2-08dc6a47081c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 01:27:29.2441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDXbk5hmjjSzPXlnbGSSAzpyLE/fck8kwj/2QpIJda7LZJly/OS+9E+507lJCfv9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6432

--=_MailMate_8785460F-D7C1-49E2-A915-6322DAE5CB54_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 1 May 2024, at 10:33, Ryan Roberts wrote:

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
> lockless pgtable walker could see the migration entry pmd in this state=

> and start interpretting the fields as if it were present, leading to
> BadThings (TM). GUP-fast appears to be one such lockless pgtable walker=
=2E
>
> x86 does not suffer the above problem, but instead pmd_mkinvalid() will=

> corrupt the offset field of the swap entry within the swap pte. See lin=
k
> below for discussion of that problem.
>
> Fix all of this by only calling pmdp_invalidate() for a present pmd. An=
d
> for good measure let's add a warning to all implementations of
> pmdp_invalidate[_ad](). I've manually reviewed all other
> pmdp_invalidate[_ad]() call sites and believe all others to be
> conformant.
>
> This is a theoretical bug found during code review. I don't have any
> test case to trigger it in practice.
>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/0dd7827a-6334-439a-8fd0-43c98e6af22b@=
arm.com/
> Fixes: 84c3fc4e9c56 ("mm: thp: check pmd migration entry in common path=
")
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>
> Right v3; this goes back to the original approach in v1 to fix core-mm =
rather
> than push the fix into arm64, since we discovered that x86 can't handle=

> pmd_mkinvalid() being called for non-present pmds either.
>
> I'm pulling in more arch maintainers because this version adds some war=
nings in
> arch code to help spot incorrect usage.
>
> Although Catalin had already accepted v2 (fixing arm64) [2] into for-ne=
xt/fixes,
> he's agreed to either remove or revert it.
>
>
> Changes since v1 [1]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   - Improve pmdp_mkinvalid() docs to make it clear it can only be calle=
d for
>     present pmd (per JohnH, Zi Yan)
>   - Added warnings to arch overrides of pmdp_invalidate[_ad]() (per Zi =
Yan)
>   - Moved comment next to new location of pmpd_invalidate() (per Zi Yan=
)
>
>
> [1] https://lore.kernel.org/linux-mm/20240425170704.3379492-1-ryan.robe=
rts@arm.com/
> [2] https://lore.kernel.org/all/20240430133138.732088-1-ryan.roberts@ar=
m.com/
>
> Thanks,
> Ryan
>
>
>  Documentation/mm/arch_pgtable_helpers.rst |  6 ++-
>  arch/powerpc/mm/book3s64/pgtable.c        |  1 +
>  arch/s390/include/asm/pgtable.h           |  4 +-
>  arch/sparc/mm/tlb.c                       |  1 +
>  arch/x86/mm/pgtable.c                     |  2 +
>  mm/huge_memory.c                          | 49 ++++++++++++-----------=

>  mm/pgtable-generic.c                      |  2 +
>  7 files changed, 39 insertions(+), 26 deletions(-)

The changes in Documentation/mm and mm/* look good to me. Thanks.
Reviewed-by: Zi Yan <ziy@nvidia.com>

I wonder if making Documentation/mm and mm/* changes in a separate patch
would be better, since you will not need acks from arch maintainers and
get the patch in quicker.


--
Best Regards,
Yan, Zi

--=_MailMate_8785460F-D7C1-49E2-A915-6322DAE5CB54_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmYy6/8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUj24QAJ7zbilMbFHAiSNHI58wYRAes6x3XF1qpHv/
7XFJdwPikMP2pjg+YZ8XDWU/1sLliGusA5fcOqIrVHwrgvQO82KB6bRN8+3hEiNZ
VqQ6u+jtHzWlskIQCW0v0JFJ2k2b19uaLzKV/IxA03WfwByrJzvDnELu1tpGg75R
wGmdNvBJda0urGIaSr0prpMmnrvozSaXDvnq/dscNLqHdoEMtvRXFJ3z9lUPXbqC
2GnxruaWHSl/Jq0jRU+Mf5UGmMnoXTQ9Fa7Xbv2qGMmN/bIVqAwIsNMF8r8S95s4
bOeUa97BOqTRyVUUFX/3lGhnm4l7u64tIpX/7TfSJtwspPA6XGneERWGFIyaBwP1
7ItaFpUxJUaUiNYrZjoMo2GKqbEr4sUDaShGMW2Heqdhzr28kWDJfZ9LoQ4yBchH
bEGCvF2yb2MsWkGICmfZgOJ35prUdxxz2VwcSBWJj3nTlvs+CnkSmYwu0Iifowah
cUTEpqMK39ItYpbfgZfTD2A3OO8XbradD/q3NFbj2/d0g+ybJozIxZ3nqytaQBHr
7Rj6C7LeatfMd+59vmV0L8gTHn4ilQstLMENyFizE1Ysx8iDSM9Cnd8NkjacYZcD
P+XTK7wYbj8pjvaAjKyUdDh6TknQu77QCMS6vGAy1U7fEnBt6uiTvMdjUQR3u4jx
5re3JIIp
=ZG64
-----END PGP SIGNATURE-----

--=_MailMate_8785460F-D7C1-49E2-A915-6322DAE5CB54_=--

