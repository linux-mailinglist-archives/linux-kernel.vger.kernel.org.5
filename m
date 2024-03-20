Return-Path: <linux-kernel+bounces-108315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850D2880916
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D4D1C22857
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F98814A8F;
	Wed, 20 Mar 2024 01:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GRovnIgh"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E314287
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710898208; cv=fail; b=DHcLey6dZYKg5l1ekESHgypf3Y68hh/fura+Sq6nSud9nQL9+wWFLoQWoy087Zw0GjuGJ9DvaeqOiBdNCZDaFbH6nO2+fLdBjl2GPKK4HBAidZ6C/u3EcmqOQw7RurS63hIiNIY9wecnbfCKRXzeCwS1cHHgZLDAjtKZSQsxbpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710898208; c=relaxed/simple;
	bh=djiKEDHgj0uvm3kMgMrQkV4Opx5i1ELNLLr/v6WETNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YzN70qFen4F2VL7zBt4OSytlr83qDkDq191wg9jR968nWW72ZGVFYfflhZWnIsybo7gKBXoW7U6ySXgiK8Wj+oZjranHCrG42TuDLaB4lLHE36RfrxmzvL7PEtvQUvbE3z0bxeYa7s9XbdbS8Nz2+JFAceUolBnZGnIqY33rx/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GRovnIgh; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBiJk+mHcegDVbZyCJnfl5NuYn9jlzl4yl4Ib1zSlXqmnVh0vUEKSU8jKdfaEHUmWV5bFsMiDkeLh3au9ivUaWe0wE3mqMTdRX5wnSEfuzVduEr1GJ0fWyotEVGa2JwX5VGml/yw4YK0KQRIAMIL841fQ2/gMqJ3ih4JIRweSY9yIuqrlzFe1/v+ezIsxwxPkGVcoI46FyScfDH9srieRYq/BNM/P0X00AvcEVCEzBma4W40RPYIYDwCccrxwttF87bz8iotGMP7UXI8Btn4IDRCEjwoLbDB9CHecVPjrsg3VwJQeCL7anT1jgI6E08+wjB4FetlLI/sqZinibTmgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tKwk2TKFWfeRneDh+cBMsd0Bqutp3crQnh6TJaYILU=;
 b=gkT/8yqVMQnhfcLmZZjFeF18nI3PZnx6veibl+iLdTqFXohjykWM1jt36H+kC6xX8N5+2hXinCFA9efihQSGyqV3Iakse9luWKBdiIIH6fAnSuCjUlYR9qBGf6VbXlpzOlMYvAk8mSWgvHfN/Yo3C5RP+RyBSEVZJFJs4ybpaHzE/TPJsFQzXsUhHeB0xvulkMaPvH8H2/dcIybPiIbNxsdbn1AQg9nRXxELFXpTshMoulOOW0AC+I5If2xmIs77YYEywMZkbm+xZQ+CEkFcTNCjAoGjV77pAyOqsoH2viIemldQRFSEAJNPHPS6RD+pRSR8lnRlHewfnqoB4oyP/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tKwk2TKFWfeRneDh+cBMsd0Bqutp3crQnh6TJaYILU=;
 b=GRovnIghgxBmkrOghThKmLxmL6Kb4UY4K1sAdRO5/3jfWSUSsiQD4tpoGG81E1GpNTUbEW0GOWd5KVP4b3MOs7ttzEmxVbOq/l93kW3BR+MKAzhdSCtxYBsm9QD1T36Z57D4HropA9GT+4Z+dPDw8b5+FXwtTa2ZXxLsuU/nhZqi/rYvXGt463x8hveyK9P8QHbgYCS1/hsenC82NEPZNt9yftaBx8QzG3duk+N72Txj0iriQlnPCadPWtDqMnV7p3E2R3e06iZJe8rUnciOOB/YEHtkvrs+9L9Ryzu/A+5nyzSOe82Avp0AeIsfyBwS2mGBDgFXC4Q4vYGiikWQAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 01:30:02 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 01:30:02 +0000
From: Zi Yan <ziy@nvidia.com>
To: "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>
Cc: linux-mm@kvack.org, SeongJae Park <sj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/migrate: split source folio if it is on deferred
 split list
Date: Tue, 19 Mar 2024 21:30:00 -0400
X-Mailer: MailMate (1.14r6018)
Message-ID: <7DE48248-2210-487D-82A0-5FE9F2C14871@nvidia.com>
In-Reply-To: <28D1C313-8333-4F87-9B1D-47E77789A853@nvidia.com>
References: <20240320010813.136765-1-sj@kernel.org>
 <DEB67249-569C-4585-BB67-B4EBEE91152E@nvidia.com>
 <28D1C313-8333-4F87-9B1D-47E77789A853@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B4C38DB9-84A7-4953-BB67-9D9F864827AE_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR14CA0007.namprd14.prod.outlook.com
 (2603:10b6:208:23e::12) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: bf000668-c89f-415c-cb2c-08dc487d43a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DiPBn4dK3iZPAcQ3QtVDe4FemKSKV7bEeWiATzBcgjpx4UGg/or7U4V0U48xSthNdlT7QPw5fat01C0nl7ymc1G4ZowtdKHaB/T/Zk68JM1I7NTcNbi78YKKwzetb7cpspC8GLV3mbNM/HlYCGfwVVsAfuygotTWpA0hNF9Z+kE5cowYx8GhV9QClUGmX1MgDVkUndfnUtypS+AQW47iuyjBhOtHhfUwljqNshtC05aj6hFUOMJ8Csqj2p0DEEe7A+Kkjx6QaPjRx3Lkr82izbIIMU41b/8AJQQ2wWgnkpXVERmWX4IBAmxgV1clbCKOAFY18EcTBgEj0aXkfig0NxVI6TYefx/8d+RfcanaZqA4Dsqa8prKKYFIYGYH9XSHrb+T8VJLVhZRzaEpuVazCLPKd911o93u96T90pBZG9sCleFS/aTIX+BKYf8wkcvX6mwU7MBu4pf1UkGLSVZwfCriUQhWwB5aVaa4cQ3g4BxS0+1x99oHxho5B/2VMIMi2NqSuRMx/HdSjrazMMieBchPnQNppTvaII5jK+xnh/9rOtG1NwDye98HpvNSC2kLkpVAtCUz1BprVXvy79RjtteqHj2yFxpKedCizN9rrnbAGv06p8nq/+9jbqnpVF7XAZPIkGBEh3dNc3YsYVe+OgcBRt4ae9z48SwzJYgVles=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?15cg+BemVk/wAAyVsUG6y04gf9wOm2nSUrpRNLdj6u5GJFienkH1ApNWtkzB?=
 =?us-ascii?Q?H5IJlBJrnJD5QGKJBJvBheQlUs0ujy7bntMIejMqYvoV+X0HbeDyfkfFi7Jg?=
 =?us-ascii?Q?pR/DESPncYJbnCQ5fmL6NBzj1tofR8a3tDvrdNfg76bMUkSxLly23hSNpQJ5?=
 =?us-ascii?Q?v3JYk2JYFohKWh6Xz2exyjlbWLNLa7tYUdSdZKdXMe5ZfDMIxMgnUCk3qMXa?=
 =?us-ascii?Q?Gu9tBceP2fLoO2PJn/chYpXoVBJMeauSgjIA+Ve2Y8fhf/6jbsdeFApo9uck?=
 =?us-ascii?Q?BYH0oo+B42M1QBi8xHbIlC/ZGwMewzGiUmC+Hm8sieqYjhCWA1REkURM2PUp?=
 =?us-ascii?Q?1XtH18owNjgaBYmHN3LKxfsl2CRHGRgn+pWXbytwEmyVVCwbiusX3XExr7Xw?=
 =?us-ascii?Q?0ju5XyqBz+ISyODV1NmIGlRyOIrtSbT0Su/2A/QoEwmRWKkjMrcJwaWOVZ0F?=
 =?us-ascii?Q?9Q5zwRVi3rRkm27t1Fd89w0/rFA71sDoXusw1Ulj6vx4QHmvLIBsygpHofXk?=
 =?us-ascii?Q?HJiRsrtGr6H1lGMzRd3lj1eJNc7AX4HBUK1UbSZT3hbK5r5EtXpdbm82hfyi?=
 =?us-ascii?Q?z6Q9Uzg8K+tZQeLyxhRp9zWy952ZeHfJDSqymiw44vfE6aVy974CxImAhV8P?=
 =?us-ascii?Q?fQCTUD5v9l/17TCCyZds5VpKJ2ew+wHiBghECbmxTHVJDwLdivA9M2aOvGiL?=
 =?us-ascii?Q?s+wixp+4yYmappNQh+ATxlDVNXuIiMnxHh2w5yJmxBadDd6p/u4euc2A0Hj/?=
 =?us-ascii?Q?ZDF5/7FCRn+giRe6AYdw+NIzZHouGZLFLN41kX7XYh+QbRf8hOmkGtbImSIR?=
 =?us-ascii?Q?SeFXlf3ioNL/Ic7DBwkFFHeTa9eCVJ0uk05Gwtc35bLPpx4QLQs1RVCAfVGY?=
 =?us-ascii?Q?c5qEgyoSHdeTu16XoSPcp1ZXYW8YZbK+NwkmbPYUuDJ+OJ7aJlNf4yCLJzfp?=
 =?us-ascii?Q?YVQsFMBKTS3sRQAMze8FHYRgftLnHvwGqt2vo40tbaoAE4o+D5f1rOKx7H7O?=
 =?us-ascii?Q?Rg1QsojShxuGXhnVe+ifW3XUa6zTkimY39nieu9Zxiu8WGuFMcOusS3uNSTG?=
 =?us-ascii?Q?l99Ca+2NvhjBof2QVNLLzDYIGgxr1d/VQuPJMbNwj8GFfOC6OvDrwE3OgZhH?=
 =?us-ascii?Q?vyZLus+EuCeE8gtF4EYjVawQVCXVgYGcQWbVxqn7ai1nF2AjgKxrXUVnOPPG?=
 =?us-ascii?Q?4h/tBmkaXRnMNZmJsMtvK+3Hua+iyWFWfeS6wtG/4DpfIGaz4po+1+bATtBP?=
 =?us-ascii?Q?eU+BDPFuKwvgHL1SoDPXYnETP/LlM05AkmcJfKNu8lbcCyEOiYFwfR/O2VsI?=
 =?us-ascii?Q?Ore2fZxz/sWI2CWu5CpD8IawEDdHbN+oBd5DsoapYL1SN07SnHd2xAvFUvlR?=
 =?us-ascii?Q?y/8bJgZra5mYqovTpHBfsm8D1KM+H57PoK5gdKfcwY8AW0H63eAwUSmY/1pO?=
 =?us-ascii?Q?jTkB1pzKMRiXi5UXB68EUimc14B+rFxdLN+wUg4BOjWMlO0Kj386vo9VMA+a?=
 =?us-ascii?Q?LZ2yZpKvdSt8hoElaQj3d0mJrNQ+uuvKaltso17btAePaRxSol3OgI0zANPN?=
 =?us-ascii?Q?8uHJM5MCWoviQ0+cbaE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf000668-c89f-415c-cb2c-08dc487d43a3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 01:30:02.3736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ERfYLOdgctMwsEUaDDb1o2p5BRfNMDAQP0DimIBY1qYyODv+cSag0PO5cdSTdWI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685

--=_MailMate_B4C38DB9-84A7-4953-BB67-9D9F864827AE_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index 9859aa4f7553..c6d4d0cdf4b3 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -766,28 +766,6 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_ar=
ea_struct *vma)
>>>>  	return pmd;
>>>>  }
>>>>
>>>> -#ifdef CONFIG_MEMCG
>>>> -static inline
>>>> -struct deferred_split *get_deferred_split_queue(struct folio *folio=
)
>>>> -{
>>>> -	struct mem_cgroup *memcg =3D folio_memcg(folio);
>>>> -	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>>>> -
>>>> -	if (memcg)
>>>> -		return &memcg->deferred_split_queue;
>>>> -	else
>>>> -		return &pgdat->deferred_split_queue;
>>>> -}
>>>> -#else
>>>> -static inline
>>>> -struct deferred_split *get_deferred_split_queue(struct folio *folio=
)
>>>> -{
>>>> -	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>>>> -
>>>> -	return &pgdat->deferred_split_queue;
>>>> -}
>>>> -#endif
>>>> -
>>>>  void folio_prep_large_rmappable(struct folio *folio)
>>>>  {
>>>>  	if (!folio || !folio_test_large(folio))
>>>> diff --git a/mm/internal.h b/mm/internal.h
>>>> index d1c69119b24f..8fa36e84463a 100644
>>>> --- a/mm/internal.h
>>>> +++ b/mm/internal.h
>>>> @@ -1107,6 +1107,29 @@ struct page *follow_trans_huge_pmd(struct vm_=
area_struct *vma,
>>>>  				   unsigned long addr, pmd_t *pmd,
>>>>  				   unsigned int flags);
>>>>
>>>> +#ifdef CONFIG_MEMCG
>>>> +static inline
>>>> +struct deferred_split *get_deferred_split_queue(struct folio *folio=
)
>>>> +{
>>>> +	struct mem_cgroup *memcg =3D folio_memcg(folio);
>>>> +	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>>>> +
>>>> +	if (memcg)
>>>> +		return &memcg->deferred_split_queue;
>>>> +	else
>>>> +		return &pgdat->deferred_split_queue;
>>>> +}
>>>> +#else
>>>> +static inline
>>>> +struct deferred_split *get_deferred_split_queue(struct folio *folio=
)
>>>> +{
>>>> +	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>>>> +
>>>> +	return &pgdat->deferred_split_queue;
>>>> +}
>>>> +#endif
>>>
>>> I found this breaks the build when CONFIG_TRANSPARENT_HUGEPAGE is not=
 set, with
>>> below error:
>>>
>>>     .../lib/../mm/internal.h: In function 'get_deferred_split_queue':=

>>>     .../lib/../mm/internal.h:1127:22: error: 'struct pglist_data' has=
 no member named 'deferred_split_queue'
>>>      1127 |         return &pgdat->deferred_split_queue;
>>>           |                      ^~
>>>
>>> Since the code was in hugepage.c, maybe the above chunk need to be wr=
apped by
>>> #ifdef CONFIG_TRANSPARENT_HUGEPAGE?  I confirmed below change is fixi=
ng the
>>> build on my setup.
>>
>> Thanks. Will fix it in the next version.
>
> Actually, since get_deferred_split_queue() is used in mm/migrate.c, tha=
t
> part needs to be guarded by CONFIG_TRANSPARENT_HUGEPAGE as well.

_deferred_list is not hidden behind CONFIG_TRANSPARENT_HUGEPAGE but
its users are all behind CONFIG_TRANSPARENT_HUGEPAGE. Should it be moved
as well? Or the other way around, moving _deferred_list users out?

Large folios should work without THP, since they would be like THP withou=
t
PMD mappings, namely mTHP. But mTHP is considered a subset of THP. It see=
ms
confusing. Maybe hiding _deferred_list behind CONFIG_TRANSPARENT_HUGEPAGE=

is better, or just do not change.

--
Best Regards,
Yan, Zi

--=_MailMate_B4C38DB9-84A7-4953-BB67-9D9F864827AE_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmX6PBgPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUwvAP/2JgpkWmP8U9vrCQeYwVNj3CKIoDD/KtxVOl
mAIEwAtehyKJjZyzUjuVNy2A6DUhn10BgLeQOT8HMHWX9jh2GmxOmoa6qEZ9ytlb
tRrSO9JmDPlw/AZ5s3QNuzuaIl+kKgSJwInxDe5TJUQptQ8grN40q8gmSq4cHkRt
9wRtoj7cUOIw4DePDSibt1132BLa/F8/E+ARqPhZoh9z3MFrxfXfPQOlkCSk14d4
1RVkUgMNg+7Iw1jX2KXAWzAau3alZZ3vReiEC4snzMxHQ/mgCBti934tfHKlbD3l
OxZEdVsBgWe4PbTd0hmNNivTYVQu8cit/XjbpbxwhC1g9CdGbQcP4bqCU7YnN2ZW
Gtx7579TcrJxTWlRblMPT3ql+/98mXp/6YnpDM9f1BGWzAMXYjFStghzr+bCD2VN
LcWDzU3z9lHSXOE1buvziIFWtWJpv40eQP6yxvo4hlm9pQrYb2s858RCnjJ2HOQl
rC26wmIjjYxHLirl0cJK1PkRjcDzhPx16V2oOP2UQSO0MBNtxAyeZpMuB93/JEec
Og9KPmyDkB9vFQc9fepjlJOueQ+2/ZA6a5YWAogyJ1I92I+32cnlNRr8TaFe82XL
QScfQ1r2aBxOKk2PmdCh/ZjuPhy3Nnebw9BDenOIj7lJtPa3n379cLqJWc0YhQWV
Lc/YfpEB
=Ki9+
-----END PGP SIGNATURE-----

--=_MailMate_B4C38DB9-84A7-4953-BB67-9D9F864827AE_=--

