Return-Path: <linux-kernel+bounces-59952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C0784FDCE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677971C21092
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666B96FC6;
	Fri,  9 Feb 2024 20:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cANUHD8z"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCBA5C96
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511484; cv=fail; b=dl8sagzUxSNmIEmuSSI37uxYYPbPYrs4gMxX2hgUzB/27jHMjkq7wjJaAHZTBnqwDb+q/gynN1W2H9hfZN6PczSSu+3G5Apl8W0gg+S0yXU9zNZxLbcGuQIQbwrTyg+PaoTkwzeDEqK4U7sTurN/SHxk8CMgpobiM7Epnpj7ZeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511484; c=relaxed/simple;
	bh=272GveDfvtec1+c3/Hu68CfTxMIW0gHUvIdNIbATLNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QCcDJO93LwsE+5UhhHixSeKtAcW69YCDrf8u9HfmP/oG4Vs0dHZ0mBZpB9pyNEZPjGOSiyjvw3dqaLBE8nZ9ag/7x40exF35Iz/91nWa4MQpRhvRRfeNRs3H1IpNdF5u5RkF80BoHqEEggbdV2yiOXUz+c4l7hLZ6XAE+RGWfik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cANUHD8z; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5J/dwK7PPDnNv1wQs4rXt9fpF7Lib2UTg8sX1+crsfRhDCYxS++sqYUVihSQ83ZagjbMRoej6YO2FPih2BNrEiqdmWIlamYEGxFcqsT/8gDAUFFB855eMNtLmm2WLh1mjEBfw3wNMy7mdiLw3OVgFVVWbRpbTPikBAyO1jb/sGFCe2VFhXJ5UH1i2ucKjmMlEztPS97pmZWVyfK4ZVC1iC5M3YasHiFb/06i4xucMQS8UQlBHWyiWAcVu2jneMklg/MWhSXyL+17xfLu4Fpb8aMPN7VsjHze+ZVQlZIA3jHlVMrWdJHraglluBcHJbPU25Gr201Pb3d4XsdP8Ul/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a51802KhyVthJUOI0oO2padxpIc2kkvTW3cUl0ZN6Lw=;
 b=hrenBaxzOI7+P1leZvHCsM/sNDurhpFQoXVtmJlP8PiDOoe5yWPufBsNmR0ykrJC60PsCedycHkZ5t9Tg49PRaTfwQ9Um/BBqHaQBZ8s+C5N7CxAK3ytviWDH9r9rw8b4rm2oHgtDSMyP1TGroZNtxTLORjjwHTSkMMCwbJCftWJGQHGplQ9aeRL9XRqL8wgZ77yyLAL6oJ8uGExWAzVlK1nn5HpS8hRdBf88uRTkyMJZnQelO/PphAugwszuraFd5aNexMK9CII8J4yvjexoKxqzYWxEi4BQS74DpmcYSbGijEQxlKZ2CwCfVM6AgYaLK/RzRCr3WOiODaFNlZP8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a51802KhyVthJUOI0oO2padxpIc2kkvTW3cUl0ZN6Lw=;
 b=cANUHD8zEH8GXStBR3HLqjQ5eI5hgBCxfCaxjpfpXsFUpyhdkHlx/zjQE37AorNOPbuDX2PGnXzEYHmztp5efVPDq1b/B1E1PhDdZ/xle7Ydwpcs2PntlYedEBMwybeDKltRdMEQy1Zv9yPAR5R0mbLD2VERC58xvUT3K5moveMwFCDSof2A3+PVmhQ85JAhT9rpG5OcWS/BOTT9yWplDfYjI0R0mXGVp4KB6vzTQQIP0Xb60XpWm7ychdXk5GGAKYer7jbQub27XT1ebPuy46PE1inBcaCL++L5qlLXQir2TM1MJAAXtSaNZlO3gj/gc63pBmIFpd4B5nUHoSUFgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Fri, 9 Feb
 2024 20:44:38 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 20:44:38 +0000
From: Zi Yan <ziy@nvidia.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "\"Huang, Ying\"" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v3 1/3] mm/compaction: enable compacting >0 order folios.
Date: Fri, 09 Feb 2024 15:44:35 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <5FE83378-555A-4207-A8E2-12C820DDA666@nvidia.com>
In-Reply-To: <b1db01bc-e0a3-42d3-8193-6e4bfd7c9f86@suse.cz>
References: <20240202161554.565023-1-zi.yan@sent.com>
 <20240202161554.565023-2-zi.yan@sent.com>
 <c42a6c9f-7d45-428c-95b9-98367ddba9d3@suse.cz>
 <24D4AA55-42F5-4E9B-822D-2BE61D0FA51F@nvidia.com>
 <b1db01bc-e0a3-42d3-8193-6e4bfd7c9f86@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_66D5A86F-B943-4699-BFF0-294BC2023A29_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR22CA0006.namprd22.prod.outlook.com
 (2603:10b6:208:238::11) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a346ec7-b049-43bf-4365-08dc29afeef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+AdWq0lDvGfDDWCMNWcz12wP3j/Iw8KmI+ettYP1hI8sDlVTOtnJwtaSXAreKmjLZxt1KkwUDqrwQtnGyT2dbOs9B9MS4HANUBnDB0rh/W8NkUMF49mS3paD2pSiYAcltINLXSkMp4kG7SG+sOU3ctUKZj5VYlK/VLzVMKDuQ5FqbEoSw00nRVEgkQBQ3am4Wbxn7umjdJgEpxm77UP2otU2bsTMQ6z3mbxxi4q55hCxau1V1fSqTV73ya43ivNxz+dsZEWoVJMeE1ilBOfn17sk6041hO9b5TlllhDyAWg9B/riY0awv5zHgUdn3H0BJheuWePxV97+W2b2vnLJ8cTScuONVkjn9N1Yq/JxoBy0UHNn4wcLd5ywmN52ugYhopd6N6vcd85ki1R+//fEy/04etvxkjXWEw6QqDhqy7UQTji6ksN4mSv5xixh2d4NiBPuy0vESf7Jt3urCBK8b7oRndYU64TBJmc+9HagV1O0QxqVwF9v8SkvbtH/cvbF5BW5oZCvoVDrUTDzBu+VQTW9e4kPcQ08krt7bbdQJTIMHPGFmH1YbqUPf12lIPqXG44C/y4u03AE/ZTnac+GL+ukltCxg732jTsBBrKPz5A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6512007)(966005)(478600001)(6486002)(41300700001)(8676002)(8936002)(4326008)(7416002)(5660300002)(235185007)(6506007)(53546011)(83380400001)(6666004)(316002)(66946007)(6916009)(66556008)(54906003)(66476007)(2616005)(2906002)(86362001)(26005)(33656002)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FY4tKVxKiDIvwS1rLXzM8dLaBsZclrK0Q6CBl3/2YV7kh2jbmkST34eu9sNA?=
 =?us-ascii?Q?TAX/wsj/BZoe7hQmeHHat0evFil17xbBjGE863cWRb7sg7U/Of0EJD7DnpvD?=
 =?us-ascii?Q?sI5V1LB8adsg+HaSPoP+jiQxp8ZLyQgGLZaqHmZUSvVdUqZwPKV4FW7ffrG1?=
 =?us-ascii?Q?CSuCXsQxdP0WKxmhEMvAC3ppUOpXG+W+GQOFypxD+rStSpmz1BGtSbmVSyLW?=
 =?us-ascii?Q?Fa0yasVg5hLBnuLUjX+g/GJbfe4T8LKwu3tkfB10kqatfvqcujwWpK5Rrves?=
 =?us-ascii?Q?7/2y/lJWILJImIa6pps21ssrD4Du5R1ltOUzNyza+U2t80UfOUDnDQMLtf0a?=
 =?us-ascii?Q?mNyZOBmTQn3cFQC/dn4/IOqcLfF7ksg3QkxF4sYdVS8ZajgOr7tTImlnaG9U?=
 =?us-ascii?Q?9PXHSiMUQ34tmb+c9YqsI8qcilri1vXcgk2YHWkU44ugZOumf72IJkdpH2E8?=
 =?us-ascii?Q?4L1VTrg2PwofkA5FYlkrJmTOY1Pi34koOTvOVs1k44hsLhH90/zwhbfd4tlG?=
 =?us-ascii?Q?HTSuupaieHrZ7yBnwnGZVHj20Ow2f2/1p0QPL3Sb6CbLoR7jJ7FgmNfQfnXp?=
 =?us-ascii?Q?ML6CpRN6ZuOmX+227cLqF3cZ/VnZupnpyexEASHw7RC49UyWkhlOGyxsaFQp?=
 =?us-ascii?Q?5Ko8oA+5TEprhdDO3CA7GScFneeZbzJ8y6xGZZ4lDl3a+edZ09uZnmjtAjml?=
 =?us-ascii?Q?VKtt0NR6z+P4OqxDDrGLuzMx7Pe8lBFb4ZeztMMXbVGjX4Z0dUf/iVYgg1wU?=
 =?us-ascii?Q?8HHirquN1OEbPQ7t504M6lfuZL01IEiAr2/lCDa2shDpp9T2EOCyE1DvbkK5?=
 =?us-ascii?Q?r3m86EGKWyGFUCfsMuRa4FHY47A/m5gn5SRlxmd/78k+OyLx5NzScqVP8jsl?=
 =?us-ascii?Q?ZasvcCRxRkYy3WvZrtxsxnCKpokycudrL46y4c3Gw0Od0f9oo20EFQsXaLt7?=
 =?us-ascii?Q?jlhYAUF/1MPon6UxUJ6jgdNKYMHYZ9WYV5R6ZgodhU2a1oPBSfHrV0Hd7GK2?=
 =?us-ascii?Q?qI4EWhMjcPu0n/Yh2Tfx5M075W2OjWSQIiUTOXkd24BNHctqSW9EMYl11IzA?=
 =?us-ascii?Q?KYv5vH6nl22OVSqPBSNcdu81vETUHDsnXTjdkmfIK/+y37aZSm2UghBQU1z+?=
 =?us-ascii?Q?hRS7LDWPMVlFdRFB0ZqLNOXNRPuCwfjV6T8MmeCLlgIvQ4uf5NA+USZurXdl?=
 =?us-ascii?Q?9rpXBICUE4u4gKMO/tbl4w2bS8+aQ0vNEbUi5+A+HqPBAusNU5qqU16vglwR?=
 =?us-ascii?Q?YqhjIq2SnSTS4WAV5V1/K17MJdnf1N7Z4RR4QeaQt/x39aDwN8WcOTPdjbnV?=
 =?us-ascii?Q?xdnk7qH50SFFho4GZK+dVu1+bc1ZqDNbPHkv/Xv+VwCs9ddEtZZU0d1N+TLL?=
 =?us-ascii?Q?IiLWCCpFqWatVSBPJCWNw8c15ErsLXTU67WhzXV8fiVMfI9GjoHHMKTW14aJ?=
 =?us-ascii?Q?qV/XmqKdSQSBQ2OGHxBd0Y9qjcwAnzM9LdfzEMa/KxPSNc5v76huJ3/s/P5I?=
 =?us-ascii?Q?+rTlymddUrVODV5oB3I3DUcG7BfLhEdDVKOOpH40/ZQEn5CR+s7tEITJeBIr?=
 =?us-ascii?Q?ULSiM9HkmJWQIVBecH4kFlSWPpEfCkUkE83gpxr0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a346ec7-b049-43bf-4365-08dc29afeef6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 20:44:38.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUpkjKEaaEVc1WpXI5+epyYrxBcGxN9xdjDzq3Oo6q4Tkgh1kcbkgEAT6GeJuAm7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207

--=_MailMate_66D5A86F-B943-4699-BFF0-294BC2023A29_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 9 Feb 2024, at 15:43, Vlastimil Babka wrote:

> On 2/9/24 20:25, Zi Yan wrote:
>> On 9 Feb 2024, at 9:32, Vlastimil Babka wrote:
>>
>>> On 2/2/24 17:15, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> migrate_pages() supports >0 order folio migration and during compact=
ion,
>>>> even if compaction_alloc() cannot provide >0 order free pages,
>>>> migrate_pages() can split the source page and try to migrate the bas=
e pages
>>>> from the split. It can be a baseline and start point for adding supp=
ort for
>>>> compacting >0 order folios.
>>>>
>>>> Suggested-by: Huang Ying <ying.huang@intel.com>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>  mm/compaction.c | 43 +++++++++++++++++++++++++++++++++++--------
>>>>  1 file changed, 35 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>> index 4add68d40e8d..e43e898d2c77 100644
>>>> --- a/mm/compaction.c
>>>> +++ b/mm/compaction.c
>>>> @@ -816,6 +816,21 @@ static bool too_many_isolated(struct compact_co=
ntrol *cc)
>>>>  	return too_many;
>>>>  }
>>>>
>>>> +/*
>>>> + * 1. if the page order is larger than or equal to target_order (i.=
e.,
>>>> + * cc->order and when it is not -1 for global compaction), skip it =
since
>>>> + * target_order already indicates no free page with larger than tar=
get_order
>>>> + * exists and later migrating it will most likely fail;
>>>> + *
>>>> + * 2. compacting > pageblock_order pages does not improve memory fr=
agmentation,
>>>> + * skip them;
>>>> + */
>>>> +static bool skip_isolation_on_order(int order, int target_order)
>>>> +{
>>>> +	return (target_order !=3D -1 && order >=3D target_order) ||
>>>> +		order >=3D pageblock_order;
>>>> +}
>>>> +
>>>>  /**
>>>>   * isolate_migratepages_block() - isolate all migrate-able pages wi=
thin
>>>>   *				  a single pageblock
>>>> @@ -1010,7 +1025,7 @@ isolate_migratepages_block(struct compact_cont=
rol *cc, unsigned long low_pfn,
>>>>  		/*
>>>>  		 * Regardless of being on LRU, compound pages such as THP and
>>>>  		 * hugetlbfs are not to be compacted unless we are attempting
>>>> -		 * an allocation much larger than the huge page size (eg CMA).
>>>> +		 * an allocation larger than the compound page size.
>>>>  		 * We can potentially save a lot of iterations if we skip them
>>>>  		 * at once. The check is racy, but we can consider only valid
>>>>  		 * values and the only danger is skipping too much.
>>>> @@ -1018,11 +1033,18 @@ isolate_migratepages_block(struct compact_co=
ntrol *cc, unsigned long low_pfn,
>>>>  		if (PageCompound(page) && !cc->alloc_contig) {
>>>>  			const unsigned int order =3D compound_order(page);
>>>>
>>>> -			if (likely(order <=3D MAX_PAGE_ORDER)) {
>>>> -				low_pfn +=3D (1UL << order) - 1;
>>>> -				nr_scanned +=3D (1UL << order) - 1;
>>>> +			/*
>>>> +			 * Skip based on page order and compaction target order
>>>> +			 * and skip hugetlbfs pages.
>>>> +			 */
>>>> +			if (skip_isolation_on_order(order, cc->order) ||
>>>> +			    PageHuge(page)) {
>>>
>>> Hm I'd try to avoid a new PageHuge() test here.
>>>
>>> Earlier we have a block that does
>>>                 if (PageHuge(page) && cc->alloc_contig) {
>>> 			...
>>>
>>> think I'd rather rewrite it to handle the PageHuge() case completely =
and
>>> just make it skip the 1UL << order pages there for !cc->alloc_config.=
 Even
>>> if it means duplicating a bit of the low_pfn and nr_scanned bumping c=
ode.
>>>
>>> Which reminds me the PageHuge() check there is probably still broken =
ATM:
>>>
>>> https://lore.kernel.org/all/8fa1c95c-4749-33dd-42ba-243e492ab109@suse=
=2Ecz/
>>>
>>> Even better reason not to add another one.
>>> If the huge page materialized since the first check, we should bail o=
ut when
>>> testing PageLRU later anyway.
>>
>>
>> OK, so basically something like:
>>
>> if (PageHuge(page)) {
>>     if (cc->alloc_contig) {
>
> Yeah but I'd handle the !cc->alloc_contig first as that ends with a got=
o,
> and then the rest doesn't need to be "} else { ... }" with extra identa=
tion

OK. No problem.


--
Best Regards,
Yan, Zi

--=_MailMate_66D5A86F-B943-4699-BFF0-294BC2023A29_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXGjrMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUi4sP/jmE7G+XwVjTsP/UkOLtl9M7BfmM2NRWlaBz
O7Gw+KcX4rqBFqtFogndeaOneTqmeks+cmZvQLPXw2eir2XDhtYm0Xi0cxzWeJXs
9VNCUAdm081oWTcYpCEwMq+l2FON5GEj2vgZlsZRlg6jJiB5QbzhVOWbJjrjTJAr
SyupY0n4IwoMubNGt/ELMoH72hKaC3uWiOIjJs04yON3sZ4K1//LS3Fug++/kDRG
bIZ+LFAj7vRiaopO7+D+RAKrPrMC20y9ueMLfFJzxTZXX7qoYlI1E5x+tdU+6FO7
8SpA0XI0JJBpaYeG2iO/FRMAJCODUpVhIHVJiyFVoDRhVhH2Ht8IZS95hLqemxKX
Xk82SKhwqufAnR8G2EBDncMjEjMXLt9ft9x6GhEp7yXI3b4EokdxgwuWRO3KbfiW
3kgk+dgXQuXcDbXooz6unFt7LV0fPkXPwhX9O4Pbve2dLMS2yv3ky0ziXMVRNtgC
DCsA+V+Dx5M600t5SFXiGPqqRijTjpXUvgP7kHVty1TP0m/wzN5EzkzIlV36JFf9
psHYT6JzPCpIifgWMKRbkE0zt+HguoItlXD1DDQX9ldUM5uWpeMVvHOb2tGIXhQz
QfGFM44yrNH6cVqMmKOlvVVQzQ7BnlulJsEzs+NS6KrOe0RHvyHoENvB6qxWSZKu
dMSUn9Q1
=hMm+
-----END PGP SIGNATURE-----

--=_MailMate_66D5A86F-B943-4699-BFF0-294BC2023A29_=--

