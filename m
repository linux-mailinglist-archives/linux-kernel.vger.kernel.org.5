Return-Path: <linux-kernel+bounces-21046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B139A8288FB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9E62862AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3358539FE0;
	Tue,  9 Jan 2024 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CkEVnK+T"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DE639FD5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsNVICd0ShTtLgGN0M8C9AxOt3u87H3oloi7qPDX1GuIpX0b+rh4ltmAwL7iego31lgAFMwHLw7zlItvjBjWKxQp8i3fINjuLgAQEN1feWSYC+kx+8b6s7cp7U4ZMuabqJsVY3UEJ1VwgLQMMwNZ+u70v9Z2CkUu/fwXVeGoo+a09EgG7DF+qtYNZkbk5dbPELr9hl0DW0KMKec8pZ6ZokUkxlFEQAGbhSLowpOitqFCN4JkRtfbpyg2BYVceXzM4Jp402br5SOozQT781xvR66eTwEROqKOOatVBiY4WW1DuatdocE3hgQfXrVAenaEQmZBrV/QGfO7ggEKI5cZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrcsHKw3vh2AoTeymOCf/uB2YtnOMdhiyBZ+mLbWk10=;
 b=arZQfCj1WaiVvtL2nhu08LsHvbmho3TnGkFD8HNrBcwFilEtHgBAW/hiQaB4de6O9sATXlsRcfgVdciqogmn6QtP2+OE6k4+1kLPRcHAnXi+Tv9gT+Tr7y/w73JRpaTuWfuajVaGGkURGvl4iDp3owRDlAsfe2R1MTma8oExc0LkXUrfSAhluV2/yD13aQLUZDagCFtCiHUWh4jCbsS+d3DIYsiNusoHLknXAD5veshJWnmIBx/Y6mCkuYJ3oAkIrj3BNoV8+qK9Y8zVxw7QaPXz4TDGCa3DM++iv9CM/jj18js4rpAL0Eu6kfslZIbsLEBOT0PulzoDzmbKHVsNqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrcsHKw3vh2AoTeymOCf/uB2YtnOMdhiyBZ+mLbWk10=;
 b=CkEVnK+T7tpxW8ZVIRz8BVdLtr4rhL23JDlp4nSbovhayxgOgL0S3e8BdrixXb2ijuFvYHVm2CJrc9LWogqxryqBY1gt2mH39jEEjnTpz4ouJ77oJ7yJRxSORyksdOTse/gN1zSw4OJ5jn4EqmQAO1c32KyRi3VrnRpBl1x/IFsYE/54TxkpVhTbUMUkyStIw7kmua30RmaalweS3SVnYqNoIBaS1bsGdpfvPPVqeD8/xTXCD4aw5r2IOWHVqe4UB07rqpNncHZRHM0bkVfYwj96Kav3a1aav5zcGn0KapDSnK3+VsQ2Box2cwkQilO7j/E+a0MSG3n/YxT8Hm2G3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 15:25:28 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99b6:1e06:1e8b:4324]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::99b6:1e06:1e8b:4324%5]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 15:25:28 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "\"Huang, Ying\"" <ying.huang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v1 2/4] mm/compaction: add support for >0 order folio
 memory compaction.
Date: Tue, 09 Jan 2024 10:25:25 -0500
X-Mailer: MailMate (1.14r5994)
Message-ID: <5B002327-EC00-4F0E-BB70-AA4A322EC518@nvidia.com>
In-Reply-To: <c457415c-012f-4431-83bc-ed7ed999f249@arm.com>
References: <20231113170157.280181-1-zi.yan@sent.com>
 <20231113170157.280181-3-zi.yan@sent.com>
 <c457415c-012f-4431-83bc-ed7ed999f249@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_D8F3586F-268A-4F9D-AEBD-409D4EB34F38_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR19CA0071.namprd19.prod.outlook.com
 (2603:10b6:208:19b::48) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: 354809b2-353d-4d45-cdd6-08dc11273593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DSYGN79wsMoV9ZWGSbsrAHNyLGxDDzFeHbjIRqjaYZ1P8tGOXI4ZuSqCHQ19kcmQkPA4szUeKG2CNqVsXstb+DGgcRfmIzxr3JuKXWIAoo6Wm5BFhvNNJysLH7hzv9xYoVwJjQCwvC0aDku8Ehl2MpXOGNWatjoe2LyYgiM23QpWCRF9UxhVP4mZwsmLuZkD/Q6giCWOBsNnPPwuwLDiDqXt0G1JR2y9/ZfC8ZE7Tc0hFjkaMJ+Sg92rodDuokbKrjTNHxLvYJFTIwGIPAp70uhsP/Nd96U41rLPJdmgNKS6dSQ9zXACe8oz8oNeIA+9CEMzYuv531i6zQ/hxm/c6LWMpXxXymuhfFbTlbdE5ZSah1t93sc0E7IxPqm00pnnf2rRSZxxYRw1GgFSGrarIzsQ892GuKPD1j1Jiosmjhc4ySXpSChQsQyGHD8TNcxvR/nO71gF8X5jqnyEXoG8uYytbctliYJl4ZGty9XiDLfxKZYqTfF/q50z0DewlYDylcZGUV9uzxsCs+IVGfF8r9rPhXeSRmvlRfC3zs2HJKGOneWgbeaBr+ZwVdZRWGxJqI6LPWeKprLf/msuLBZbSszFDAQqBGne19gkkgxkd6nBki5mfVwI5kGCdVHNM6tX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(86362001)(8936002)(6486002)(8676002)(6916009)(26005)(478600001)(2906002)(5660300002)(235185007)(7416002)(66476007)(36756003)(66556008)(316002)(2616005)(66946007)(54906003)(53546011)(6512007)(83380400001)(33656002)(6666004)(6506007)(4326008)(38100700002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1pv2WLtM0e2mVszP9x3MryAL14BdPu99hpVYvxYnAEvU/h1sI11kU3WTYL+a?=
 =?us-ascii?Q?YFcSZ+Fii8ANbspIJfieT4o7apO+n5MtpP2F2v4FEOc7NoSpDoJd6GB4SBI7?=
 =?us-ascii?Q?Pe9SBZ9oAGHa9LbTH1GxCa36I/VopyRD4JvUxdCjzPR+ysX4D2q6sIc259Ib?=
 =?us-ascii?Q?sPF8BmOasV8uBKAYa1BCsyEPE+4mE8KD5XDLuz9VqIabWqP9Xee2RJq6yEO8?=
 =?us-ascii?Q?w+6eJ4tNK9vXK3K0leHIQS0FL5oj1JfkAkCPmN4XW075+unr9vAPrhHIdSvU?=
 =?us-ascii?Q?trBvFb0ZmSN87ika9sVO2YvYv07BmtNJXns7giznAC6yu+QmHXrBB7xInycY?=
 =?us-ascii?Q?xhIOXWNkGzaE3BMzHCilb4pti1UqvlvRrMMAmve914wP36LmF9h80ox3L69G?=
 =?us-ascii?Q?K+CMMRjCbTBwO0ogtDjAE3j/F1xZagHc6yDjdaZSHPQnE9Ad/RRtHGZcFOUu?=
 =?us-ascii?Q?UJcjAwkqcXRL8iqPM2UzPZnjvMtGeb7Lkqy5PI4JtZDjnl3dYfmRg5uzt2T6?=
 =?us-ascii?Q?S3mm5wX45WmlxLW/6b+KidTVNfeR8zf3nj0dy9mgyUgIhm7ErEhYTsOoX61g?=
 =?us-ascii?Q?WmVRw5tTsiZEzn36QOybaDu173Sgq7sQ2lNh/XkgLIGaIY7xO0mc4J46932S?=
 =?us-ascii?Q?Pdr7FxZNu0v2hsqTalhJ547sIsUWyzwOz89nz3iolt3gmI28BIpQEEMYvgD2?=
 =?us-ascii?Q?4dxSgYNN+nZPcTrTcP0QgitvlKXOmetNG4IKV2Zpoo9q3zFj4zGnMrvnhfN/?=
 =?us-ascii?Q?x1GwYL3T0Gp1Bo7nE49yB0HSRtiiesCdJyTvQO3UlrEFY95SYvbkCuEstm5w?=
 =?us-ascii?Q?yceiroQLPPJ3X6nDdoIk3xVnThWu6EwHUchVE1VLIn9qlc+6ohMMDt5dkntW?=
 =?us-ascii?Q?SxARxk+5dShEU7rWqFUD7uH2dhqfliuIRilVZmj08Wrsyin8CA32DzboFHCy?=
 =?us-ascii?Q?RmgjDTlVjnXCVQqf6+ZJZiMfof9Dvbd+8BrbWIzOkJxsa5HNZphEQ67BZjmq?=
 =?us-ascii?Q?azK8fbnK9hEbLTW0C1DSX6odXEXrGwsXW77cA09Z0v/oX069klhvDLT6Yzgq?=
 =?us-ascii?Q?BO4x+dTxTVJ73luY9sBNHCdz/0QghxGcTBH9gipKiKW/e6caRsjD86xN+BsZ?=
 =?us-ascii?Q?lXfthUEOo7qYWu2GR2S5YGMctteI5AxjNG1ltl0Q+mkn2L82qBBDYqz0tXkT?=
 =?us-ascii?Q?gJuSLObITYdzypIII3XHwu7OPcRfCY/OiQmyWQUQCxLu/vgoZUAOPs6w8UuQ?=
 =?us-ascii?Q?LpTTWeydibq5eQTIAwRMfmayQcD07g9GTIsrsGJUG3+6LDohts3EODVL19pD?=
 =?us-ascii?Q?P1FR9YoqGDLyIgZW1M8EPmpakq7EXGa5sHN2VFHuhkAbGAh19/K7I+iPYMp4?=
 =?us-ascii?Q?KvNbo37OooPWPGmIoWMKwu/Sx6j7dht57dnY/q7bB6XuDwfb5ByzZ349QYJ1?=
 =?us-ascii?Q?1RlAYAJZ9iY5MmRbJ5qoiw7vqy+BwOGVujp/m6kbB7yQ76lYsombqWWywvqU?=
 =?us-ascii?Q?ETqIxem6sKjFFFJc1ZfvfJDrz8nlyWieRzCZBCKiLH7zCxVvqs07Tl2W/+2Q?=
 =?us-ascii?Q?47Gq8VNoA0haEZC7lI6oQzDfsNdgXMOIRyceR5Ep?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354809b2-353d-4d45-cdd6-08dc11273593
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 15:25:28.1530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d9Ytg1KO4FXhwti17s7QqJluNo9eu9cxGh9R7yYLi1uiOPgvv8WqvL9XiBrd0sVP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403

--=_MailMate_D8F3586F-268A-4F9D-AEBD-409D4EB34F38_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 9 Jan 2024, at 10:18, Ryan Roberts wrote:

> On 13/11/2023 17:01, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Before, memory compaction only migrates order-0 folios and skips >0 or=
der
>> folios. This commit adds support for >0 order folio compaction by keep=
ing
>> isolated free pages at their original size without splitting them into=

>> order-0 pages and using them directly during migration process.
>>
>> What is different from the prior implementation:
>> 1. All isolated free pages are kept in a MAX_ORDER+1 array of page lis=
ts,
>>    where each page list stores free pages in the same order.
>> 2. All free pages are not post_alloc_hook() processed nor buddy pages,=

>>    although their orders are stored in first page's private like buddy=

>>    pages.
>> 3. During migration, in new page allocation time (i.e., in
>>    compaction_alloc()), free pages are then processed by post_alloc_ho=
ok().
>>    When migration fails and a new page is returned (i.e., in
>>    compaction_free()), free pages are restored by reversing the
>>    post_alloc_hook() operations.
>>
>> Step 3 is done for a latter optimization that splitting and/or merging=
 free
>> pages during compaction becomes easier.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/compaction.c | 160 ++++++++++++++++++++++++++++++-----------------=
-
>>  mm/internal.h   |   7 ++-
>>  2 files changed, 108 insertions(+), 59 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 5217dd35b493..ec6b5cc7e907 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -66,45 +66,64 @@ static inline void count_compact_events(enum vm_ev=
ent_item item, long delta)
>>  #define COMPACTION_HPAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
>>  #endif
>>
>> -static unsigned long release_freepages(struct list_head *freelist)
>> +static void init_page_list(struct page_list *p)
>>  {
>> -	struct page *page, *next;
>> -	unsigned long high_pfn =3D 0;
>> -
>> -	list_for_each_entry_safe(page, next, freelist, lru) {
>> -		unsigned long pfn =3D page_to_pfn(page);
>> -		list_del(&page->lru);
>> -		__free_page(page);
>> -		if (pfn > high_pfn)
>> -			high_pfn =3D pfn;
>> -	}
>> -
>> -	return high_pfn;
>> +	INIT_LIST_HEAD(&p->pages);
>> +	p->nr_pages =3D 0;
>>  }
>>
>> -static void split_map_pages(struct list_head *list)
>> +static void split_map_pages(struct page_list *freepages)
>>  {
>>  	unsigned int i, order, nr_pages;
>>  	struct page *page, *next;
>>  	LIST_HEAD(tmp_list);
>>
>> -	list_for_each_entry_safe(page, next, list, lru) {
>> -		list_del(&page->lru);
>> +	for (order =3D 0; order <=3D MAX_ORDER; order++) {
>> +		freepages[order].nr_pages =3D 0;
>> +
>> +		list_for_each_entry_safe(page, next, &freepages[order].pages, lru) =
{
>> +			list_del(&page->lru);
>>
>> -		order =3D page_private(page);
>> -		nr_pages =3D 1 << order;
>> +			nr_pages =3D 1 << order;
>>
>> -		post_alloc_hook(page, order, __GFP_MOVABLE);
>> -		if (order)
>> -			split_page(page, order);
>> +			post_alloc_hook(page, order, __GFP_MOVABLE);
>> +			if (order)
>> +				split_page(page, order);
>>
>> -		for (i =3D 0; i < nr_pages; i++) {
>> -			list_add(&page->lru, &tmp_list);
>> -			page++;
>> +			for (i =3D 0; i < nr_pages; i++) {
>> +				list_add(&page->lru, &tmp_list);
>> +				page++;
>> +			}
>> +			freepages[order].nr_pages +=3D nr_pages;
>>  		}
>> +		list_splice(&tmp_list, &freepages[order].pages);
>
> I think this should be list_splice_init() since you are reusing tmp_lis=
t in each
> iteration of the outer loop?

Right. Will fix it in the next version. Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_D8F3586F-268A-4F9D-AEBD-409D4EB34F38_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmWdZWUPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUB4MQAIFN1hvUH6R1XG5YeE6NgFTOLYW+jEi+LB2H
iY07Hn+5d9YlQei+iRmVqmGDa6+ZnI5El9Qf2bZc9LR1F622vBTUPvLGCO9cayG1
YgnB/E1JSH0RVO2rUsk0H/F8ddJpA0eLMHruPR4UdGmAFW7g61eK54A9WY/YDaau
yLHIaM3eCX+vR2HR659sQ8H84/YB2NlsCKFK+jXSmYEvX8NIzjpDK7JE34thXsOS
5LOYSgkl2ZQf4ExZhj2V4tbkTcX2jalTm4upio6Oc9v3ezg4ijDMVsVQlwxUTsHU
RFA61VmKrNxbN/bLIf/AmWiUeQxkBOA8hxGNc6yLxAg1L53ZFmTg10f2tfzfa/in
61AMyoHvqp1JF61gwUyrYfsYEU7SiWDg69fZJzmhlX/t7lembm4SZ5lRxYtPLJKI
AhSjHSIIVW8wV9yeI8KjygweW2YH7zP3WWW5lIkdyILsvOFNGWWItv0la8Dsw/2D
w7GgJ0HXVtk8gA5H/pf+OJIKlBcTEfnOhddcslO/ba/9esyZ8vMaKyFJhhw6C0Ay
ApQgEPbduO+E0+EblheIka94kNKfXwznJ2j+LnDFHW2quvqi+rnOuH8HY9AYkAvc
Dxj/ToYSv64H8ZLvnUXEsZKsze1L7yez9pnzDDeTH7T5hBfcAm5l6JB6SEqp8FQF
bOvTV2Oa
=Eay7
-----END PGP SIGNATURE-----

--=_MailMate_D8F3586F-268A-4F9D-AEBD-409D4EB34F38_=--

