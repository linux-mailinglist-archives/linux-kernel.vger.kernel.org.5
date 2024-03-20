Return-Path: <linux-kernel+bounces-108300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E518808E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB973B217AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD0A566A;
	Wed, 20 Mar 2024 01:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PmDEmScE"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C75231
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710896994; cv=fail; b=cMGlIxDLlmEXJ0hLWv6oOVRHJAvl9+ti9NUvpZDzy/6ZxQ55yYwNnCOASfubuSHyOqxQrHH3ezopHNbhQNYAj+0Fn5HK/AqWZEqX03JVv8vNd/boug2qEA/7GcC51OREgDu27jzDm0MA6rZLP1MGkEepIcjFr85PoHc/vR+zjco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710896994; c=relaxed/simple;
	bh=h7HdS0nkpgONDOcs8PdZ2aQFtRQ8FJ0G2VGdcjP58M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MqoaYdDjzWDg2rJF+BtHPcAd4wqpDIjbNzfFzPm2ExjqHBN8EwBuB1UaNzVUWVULB/tkl4AOWDgSq9NwB4RfjT+rUL6hv39WFcv/tNRdkK767JTITPD+OcbI+qP1bO776F9rVWPyvvAJS9D5eeCLDxqDq8u+6oTdpvfcOyDB89Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PmDEmScE; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMNM2f14iOEYJZvpr8XlA2v2Uz+Go+eC1cOjT1zPEnPPrJekQidcCKxTEM9Kd0qpHwfUe27K40yd4RddLOYS3H3ez5xQPnXg3zHQp4RaLWZWBZJmGBQO+SWdPB2bmT2CPTwmbqiZpObijQOrRrp1sYMUMqD8ZTiF6+1cge8YAgaj6au9Zs/AHq9IRG/+8ngR3EIIqxJAJMlTqaj7E2s9HWv6w5kmPeOfnR4yzBRiQno9Tlil3Wz1ClfTPvZgy0pXiKAWfV2eGAAg5GzpBIyqjfB8l18/Ja7z84nVTTk1zAqlfldorTJJOTvT5D6OzJb6NCigP/ng6wUoZImJ569/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANU5OHqoNGMpJekj6kldbNryCQXLMekUJeU9FHCdChE=;
 b=SEmiABZZKvAqfmnXBp3NiQNr0AtGmKi+wPDlSXsrjfDGcwXv/L3Qfepmz+MT6utayHw0LzUjRC8UKfHgy2lsF51v8cwOBmxv1UiOJfBmx1RL3nJH1G4pmoobP9bC7zrKf1Q+LZFUqlknvU1FLprvfcfee2brktumQybHgUVlAaEhMxxdk6DBZZ3quNirHED5niXYw6UrdQ2JOzEOFH69XFymwVwb0u02x65y6RbZ6NcMWFxk71nlqOZyBe0KolRCHJqFhPwVM0bcItZmsUdrqpgiJ+eLHBuFk+U/t1veJ/AIo5sHB/7BG2ispwdNSuptzf7j/GAXA0/av6vjwvlQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANU5OHqoNGMpJekj6kldbNryCQXLMekUJeU9FHCdChE=;
 b=PmDEmScEtkyIWYOZHVfJM4pWFCPkCJiygxXnxTDcLVG7LMP0eLE77W2hqE35ZXfptWOrr7eqiWFBA/wYCbBx4w7OZR7XxB209g98PU34tTxRPeTWP4MzrExaj1QkDSqMeUx/moC+9QTCTnKIWgg1hSAIqZSOjaIj+YMpeKP2UYx0wXrI+LMqh/v3OKOvNcXzH1yD65ZssjMsmglZztDq/q5GcEe17D+fOL73yF+dIp/zemXcta+WysoHLexOUqzdmMFzf8tO8lR2KHyd59AR3Crl8lfB9vFAA4O+4P5zXGgAabsNLQkXa3DzvgjqF9XiwwapUuJlyHUkPDIss3r/Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.26; Wed, 20 Mar 2024 01:09:48 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 01:09:48 +0000
From: Zi Yan <ziy@nvidia.com>
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/migrate: split source folio if it is on deferred
 split list
Date: Tue, 19 Mar 2024 21:09:45 -0400
X-Mailer: MailMate (1.14r6018)
Message-ID: <DEB67249-569C-4585-BB67-B4EBEE91152E@nvidia.com>
In-Reply-To: <20240320010813.136765-1-sj@kernel.org>
References: <20240320010813.136765-1-sj@kernel.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_5524859F-96E5-45DB-A489-0B3A30D1B3CD_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:208:2be::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 40c5085b-6c5e-41d3-4ad1-08dc487a700c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y23wPOZwSUDC7YMpFnhTptVMYwLdxwlzdc2Q2o0Nni/1gmm629PEaBbjl3oG1Pb9WQPkfNV2NZb3xIuj4Y5gwW72+NnQikjGtIJ1y0RwfEY44to1izlJBEp99Pc3EuuydIteChmvNCnkGcn3sC6D0NXsl3fAu8oGqElSkCbYCwmEIdtqzoJkOKYwDciKGdfd5oDMbzBErduwbsH6kVJPW4k0s+XbHK4lmtJ6Aqy0SCpEQ3G4hVdf6RcTTzITkWNrH4JcTzu5946d959DSCbCNVv0DPS+MEve79QD6YUJguEu1O2eKP2SoKaOYUrcwTH8aSfwdIT9YyLk11XbiX01/sp9ZSguD2EFFE4pQWJI+m6tl9oqWiJKJU9ye0UuEt1uppX8vk2jPTQznWGP8Xyfk9MSLn1zQ5E9ud4tfIF+YPOj5gWGPh0P/YTGms6HmPuvr+8eWmB7pbvlzHIMjOi7C0Rz6bz22mUPrr5IUK+IGeG6GDKslwBv3yd+GZP51d2URImD7CNENaSmFI/nh7RqXUMp9CaP1azZeHKnTYL6C8P0puvJUy94rGobVqK7jFssSY2kdOeAC9NcFZk1bkn3GlUC5w7bnFSPJbeEP/o4Fn3OXuiRPZfFCfz1cxe+9NqoQdL83t2qMADD3dP1c6XGSd08j/E/ycTc/kwJsrV5Kss=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5N5cHpDfkGDeI25SL8RfEr8BOzifFInJMTBvAzeHuy/Uj8cABYekxjAURF/8?=
 =?us-ascii?Q?he6CgD3bZZ4hPIUqqzIIDHRRpeth6lHOGZev0z06PzL/F2E5KtDUsI6EucO0?=
 =?us-ascii?Q?nkcnGvVbEmjqijNYO/29Y2ppACNEXrImCakEgJ3iZT6wIt/YBiSQXPjMo4r4?=
 =?us-ascii?Q?kRN4FANhmQdCDLZ9HrjAOqU+05MnETDWgzaiImyv0m1iyXADL85cjc9cvoDd?=
 =?us-ascii?Q?KjeXOCysB/smrWOG8CzkdVJI0bnoeGts2PtmX4wNgLj4tBP611LycyzGT5ii?=
 =?us-ascii?Q?hzFa9qAJ00AutBq8VhFY1Y+gR6E/mZP9KaIR/hQ/WeV/9Zw5LxCQQrLTv/z8?=
 =?us-ascii?Q?+/uh2341hUr2ezbgUJ98OGLmtGOrKnEAQJlbtGh5z/CUdoNryVyrIzhRdJI1?=
 =?us-ascii?Q?e65ZyLB4Db/o9juaFKgF0BE30vqFHzIAjLbq3WqIYk/qc5LZBzTsqzl8GWb9?=
 =?us-ascii?Q?O95g7QGD9dEvFk+eJ5Zn6es6p77Yt+KafGz2sgIiR3Ezw/va/9UWDtcGbqvq?=
 =?us-ascii?Q?Cq8poaOBhoYyQf0sd/F86iKaLtO6MXLjD4q1DWNdjwA/nrhZKfInHqiWX1pu?=
 =?us-ascii?Q?W3sH+uD34D63FNTRkxBsXo9qzSslGfNyPGR8UfQFPDPp+p3eun94KqwvULqg?=
 =?us-ascii?Q?FEhNBmyR+DCrjL9BrC+CgMuWGHQqoSNYL4a3l29w72pFPuggDfwdVXV05fjv?=
 =?us-ascii?Q?v9DwHXgAtOgNCYv1BOUEFIbsjG+Sq4K1v7EtH7KwtAzvpJuzsmr9DpJYqO2g?=
 =?us-ascii?Q?g4H/LDs0G2751guCwLAQRLijZB9KuDsr7id1j8Iy+1GPfB8MkVXYwOBgn5Yl?=
 =?us-ascii?Q?VlDzfdcKtAlVNCNqzG/ZHuNa9HVPtlolZDNeupBu2iLjLto2y1qcSohBmziG?=
 =?us-ascii?Q?pJBslP7drKukdaM4MtNw6IMDj4beSrUF4wBfjHzckXb2pS7sLuxYitYiV8+x?=
 =?us-ascii?Q?C3tHRNPiCqJyMqNQhBJcX6n8fPPqe2CqOv61xe8B70wpwgdCOCFjAyJ7j4rq?=
 =?us-ascii?Q?YqCoyIRLrYNHYcdksXJSUGi0dYhBK8zlNn4JzteduDAN/2dixDLboSAT/dZT?=
 =?us-ascii?Q?E833yFuFIe+oBmlXAfUVgX5w44QP78i1jmIkbU2/81ITgYTXJJ6qPcZjVCT3?=
 =?us-ascii?Q?beZZ/sr3mgR2bH0cUkwd6X0YEzV7oDTn8kEADb8lRVW18MjpgLsbzoB8xiDg?=
 =?us-ascii?Q?tU+McDkrE43p3wMYLRfvGk5PD9eLNsHT+80ufRDenh1tr9y3oQMS2D/BOgmS?=
 =?us-ascii?Q?hdX8xihc7rfPTUyge8Xz3NZayK5e0so09SvS061QtGot9p+9jd1H91s7rb2H?=
 =?us-ascii?Q?ShtxYcBqWaGJvOX7vwxkQA20noawQpFz020Y4sXrHniaG0RhnGqiOChreRpe?=
 =?us-ascii?Q?cfSVlO+R93gSI1E4pXqe10sjpwoS0Jv3ZV+tcWwgU9kRJb+zTZnIxr2cuwB8?=
 =?us-ascii?Q?LFBBM5zGGO+a5l93gmCCGlvxyo50P5ASEoxlU6BHQ0lDMFsNhX3kpexPethH?=
 =?us-ascii?Q?j7U8JfRtAB3PvRnTBKTd2/f7IHQJEsys8p0PWEK4SC8HaIZtxPHk0UcMiADu?=
 =?us-ascii?Q?s9L2qhXydPPeo5SGRt4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c5085b-6c5e-41d3-4ad1-08dc487a700c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 01:09:48.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ovNHFxlK+6cXzTBIaeQ3DgDekUbvn2d7Ia9N6qtxqOwOXLYCkS0Nr2o2n+S6cR/T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012

--=_MailMate_5524859F-96E5-45DB-A489-0B3A30D1B3CD_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 19 Mar 2024, at 21:08, SeongJae Park wrote:

> Hello,
>
> On Tue, 19 Mar 2024 11:47:53 -0400 Zi Yan <zi.yan@sent.com> wrote:
>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> If the source folio is on deferred split list, it is likely some subpa=
ges
>> are not used. Split it before migration to avoid migrating unused subp=
ages.
>>
>> Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path")=

>> did not check if a THP is on deferred split list before migration, thu=
s,
>> the destination THP is never put on deferred split list even if the so=
urce
>> THP might be. The opportunity of reclaiming free pages in a partially
>> mapped THP during deferred list scanning is lost, but no other harmful=

>> consequence is present[1].
>>
>> From v2:
>> 1. Split the source folio instead of migrating it (per Matthew Wilcox)=
[2].
>>
>> From v1:
>> 1. Used dst to get correct deferred split list after migration
>>    (per Ryan Roberts).
>>
>> [1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713C=
817C@nvidia.com/
>> [2]: https://lore.kernel.org/linux-mm/Ze_P6xagdTbcu1Kz@casper.infradea=
d.org/
>>
>> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/huge_memory.c | 22 ------------------
>>  mm/internal.h    | 23 +++++++++++++++++++
>>  mm/migrate.c     | 60 +++++++++++++++++++++++++++++++++++++++--------=
-
>>  3 files changed, 72 insertions(+), 33 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 9859aa4f7553..c6d4d0cdf4b3 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -766,28 +766,6 @@ pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area=
_struct *vma)
>>  	return pmd;
>>  }
>>
>> -#ifdef CONFIG_MEMCG
>> -static inline
>> -struct deferred_split *get_deferred_split_queue(struct folio *folio)
>> -{
>> -	struct mem_cgroup *memcg =3D folio_memcg(folio);
>> -	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>> -
>> -	if (memcg)
>> -		return &memcg->deferred_split_queue;
>> -	else
>> -		return &pgdat->deferred_split_queue;
>> -}
>> -#else
>> -static inline
>> -struct deferred_split *get_deferred_split_queue(struct folio *folio)
>> -{
>> -	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>> -
>> -	return &pgdat->deferred_split_queue;
>> -}
>> -#endif
>> -
>>  void folio_prep_large_rmappable(struct folio *folio)
>>  {
>>  	if (!folio || !folio_test_large(folio))
>> diff --git a/mm/internal.h b/mm/internal.h
>> index d1c69119b24f..8fa36e84463a 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -1107,6 +1107,29 @@ struct page *follow_trans_huge_pmd(struct vm_ar=
ea_struct *vma,
>>  				   unsigned long addr, pmd_t *pmd,
>>  				   unsigned int flags);
>>
>> +#ifdef CONFIG_MEMCG
>> +static inline
>> +struct deferred_split *get_deferred_split_queue(struct folio *folio)
>> +{
>> +	struct mem_cgroup *memcg =3D folio_memcg(folio);
>> +	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>> +
>> +	if (memcg)
>> +		return &memcg->deferred_split_queue;
>> +	else
>> +		return &pgdat->deferred_split_queue;
>> +}
>> +#else
>> +static inline
>> +struct deferred_split *get_deferred_split_queue(struct folio *folio)
>> +{
>> +	struct pglist_data *pgdat =3D NODE_DATA(folio_nid(folio));
>> +
>> +	return &pgdat->deferred_split_queue;
>> +}
>> +#endif
>
> I found this breaks the build when CONFIG_TRANSPARENT_HUGEPAGE is not s=
et, with
> below error:
>
>     .../lib/../mm/internal.h: In function 'get_deferred_split_queue':
>     .../lib/../mm/internal.h:1127:22: error: 'struct pglist_data' has n=
o member named 'deferred_split_queue'
>      1127 |         return &pgdat->deferred_split_queue;
>           |                      ^~
>
> Since the code was in hugepage.c, maybe the above chunk need to be wrap=
ped by
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE?  I confirmed below change is fixing=
 the
> build on my setup.

Thanks. Will fix it in the next version.

>
> [...]
>
> -------------------------------------- >8 -----------------------------=
--------
> diff --git a/mm/internal.h b/mm/internal.h
> index dce2b9f5e6cd..fe9f69ceb140 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1106,6 +1106,7 @@ struct page *follow_trans_huge_pmd(struct vm_area=
_struct *vma,
>                                    unsigned long addr, pmd_t *pmd,
>                                    unsigned int flags);
>
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #ifdef CONFIG_MEMCG
>  static inline
>  struct deferred_split *get_deferred_split_queue(struct folio *folio)
> @@ -1126,7 +1127,8 @@ struct deferred_split *get_deferred_split_queue(s=
truct folio *folio)
>
>         return &pgdat->deferred_split_queue;
>  }
> -#endif
> +#endif /* CONFIG_MEMCG */
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>
>  /*


--
Best Regards,
Yan, Zi

--=_MailMate_5524859F-96E5-45DB-A489-0B3A30D1B3CD_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmX6N1kPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUvLAP/1jb5zHbIg35G1e0/3ga48UbdrQUnZIYCgmv
UZPqWpjTaZWyKvvpwbv++yqDsg8CgwRBf2AgD2LnxuvJDSuM1/PFSM1zVo9eVrf5
5TfVOW2sDZqBfJfsa2U6NST0hBXDILzNIKSDVNiOAzLjnLUN0iRux8viEwh4oiuC
LDF4JEmv+fdAvUoGRcDAlp519BBeHk5JTss8XCQJswOjNwGR88r7xtk4tUvH7PH3
6kqQlCf6TfptS3HQVE3nk9E3uSwiSg6Xug3JkaHDpN3ftDreFw45pl9N+5XxKja7
L5pBdAa7yBCBB6athL3Q8gulnCEVRx6xTLnaCYmU/HDuZ59NHoIpwDxSVVKxIoX5
RiiRCUZMnTHRdTZjm4MYPMuNW4FnTMdEEsKD8T6KStNTGBg4H4f0UMOtXolDbqGt
K3Etv3ICY5iMljdKvgOvuxqLFxd4rbIK6C3cnHcZZlPSNi1Gd2NBw1asgORiFgTS
yW/WCEOVfKCzdnx6A4reirM6yDOZzdLbxReWijJX/FL7fZpxspHGr7AeEv6JpIms
jqnyfZz/8Hp5kjg7ktSHXZS7Ua4EFU+aPq8hNmWH4WdbdJ8/aKpnLiJD3j24CLTZ
FoWwmioYy0/7uYh4Srr1/gj/nZMoqn18mLvTvcfabrApWRLTG2ap/vzA4wHr6Z6t
URaGlrdk
=2zZk
-----END PGP SIGNATURE-----

--=_MailMate_5524859F-96E5-45DB-A489-0B3A30D1B3CD_=--

