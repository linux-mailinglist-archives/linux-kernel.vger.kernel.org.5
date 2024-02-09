Return-Path: <linux-kernel+bounces-59870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BBA84FCC7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B658C1C21884
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765D884A32;
	Fri,  9 Feb 2024 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KsegVMZO"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0ED7BAF5
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506713; cv=fail; b=YsVgq/tRVsDpBRm1LfB4cAHx8wB+SvyqvUEp8Z+xBry8MNxxNjdx80c+JCMYBom2qjiYngkGGKxgEOTaX825AyQNALMRRorWmCllF93u2bK7+xkycCtDF1TbG+YpqdDRkAU2nRdTqDaB27oxGkocdBGZC9BThzyBjqP/rxQGC+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506713; c=relaxed/simple;
	bh=ok5J267w2DRzUTul1eWE0I+wMpInviQRUnGut4AEPY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hBIU0yuVD/2AJci+qsQarKo+ZqvA+FQpHYcQCCW2YD/SWcHQ/BwdGNLR2ZxyVvvjtwsOQ7PO+MRrf+4UNymhTjs505WSAWkwpF/GtJ+UMt3R0J5dV7dJllGnwJRJYAe5W/NukEzRVdTUhiNM2KkkM3IJpwRNhgNf9FXQEZ+lYeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KsegVMZO; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQeXlzCh3vhACihAKyI+gVZuLnFINyAop/tHqL6Gz4ZAxd4x1dKUQ31RHvJX5MOvyL1J+srPmJ2+0xIzlf+DW5VKtstMaEs2FIRfgwAHlDWsMhFwRSRRQBxywTYZVJjdRDom2iBMpGVBaVFrLElNyVYESJUtzskXO0KG1xZFmsolqKLfSx21FFCMGSyhzMnT/jVui2J0XXzKsE3WWK/q01sJOxmiV4NPw272sOja6cg7cyi8d+qB+wPZtQDzIwYmdtkCLmSIFDfioWbnZOBDm/+rwOlNZs7ORD8MxtMiHH5lrAiSYHIaOwMRIRAPjiPZOS3drNH5VcVRewkFhyDMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQtdxzxq5WSeYgSve3oSI6kuOgyuhxXU8VSdW5kwOp8=;
 b=ePatrIrOFWE6pGqY0H8tFOicj7sp/XXH7DwhJNDDyjHqX3hxCb6vC2d62e6csRaZrQjlK9L9enCEwhDI2QQk1S02hdSeUrIZTC2k0XizFAougSQPjao9q4HEtFWikFHnj1ki1UchlL/+HA3Zi0jCNqy6NIViNNCOumWe3LoSrXVx5g7+XUxfSIb/cnU5UHe8cH4MdjyIczfHqApdl3e6Y+5ArkcffE1T1fnikNoDPp82KbjP+aJswAuCYBV1YIzdHk7d1iPVVM4ru0KA3ALKogOXp7TDjB4DJ9gmxJYkaSFtg1q06h20WYgEcJyn3clO5KQ+qbb/Jmvn4xv62qNxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQtdxzxq5WSeYgSve3oSI6kuOgyuhxXU8VSdW5kwOp8=;
 b=KsegVMZOmJ/0P1Ele+g+GmBJh442Fs5a+5DZEDVcOBukoBY8KHuccvVkzFxGp5Hj9mmE9NF2fmV7jnA9ok2KtOCtuPUYqDhhpX/HxTXIYboj+FIM1Z0+XcoxSSjBfVO62dsXrc/aKtBqixhikVeKcZtTgDV9quSH+ZhpnJxfMppk26TBJD3KGVzHO5pnESsjInBoiTQfNf44P8riukOkCssJ1HHjOQBl69sK3MfGj1m5FrDs9zVSDGaO44jzRAvBatWx/ZXA/e4vGZtOMQWawl4k6/Y/oeQdlRyBaSTcIEFcMhHNWTnR9B8lJcxejC6moGTZbIQn1yHGOsxUHCSv3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.10; Fri, 9 Feb 2024 19:25:04 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 19:25:03 +0000
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
Date: Fri, 09 Feb 2024 14:25:00 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <24D4AA55-42F5-4E9B-822D-2BE61D0FA51F@nvidia.com>
In-Reply-To: <c42a6c9f-7d45-428c-95b9-98367ddba9d3@suse.cz>
References: <20240202161554.565023-1-zi.yan@sent.com>
 <20240202161554.565023-2-zi.yan@sent.com>
 <c42a6c9f-7d45-428c-95b9-98367ddba9d3@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_FC602DB4-D4F0-4645-A5EB-64CA8A6D48E8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:208:2d::43) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: b09fc811-8827-4aa5-0b77-08dc29a4d0fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+4ycg7xqBaeMBkhD7IGSXnGUU+y++W7a9UqOQAg+PdFY9a87u4NlkLGWIelEP12jTa53y1jMY8WMYHz5Yb4GLgBNBBcOw5OBofLEovKnXNIEJ4imN495o0qJvMDQtYXcJbXVEemy+2w7pPRmmduEbV0EqzAaFhnZ99SW925glM36FJJfYtGVd/qhJa2b/+hmuMDQbR+NRnN5LjBK9wqORmXKSoSwcBRRUjpcALnREZKjUqLVcQkRw8Gs20asM+DE7mo6HkD59fHuEhR4fgo0RAfJ8wMdAjvyIMKse31cDATBd6Dmmul3d95/Fpdmv6pygitXKSwqlzI6oSiZXilbA3sl+NmUh+PIIACD7YkTysmWFROjyZ1uILdTM2QOKIYyJifQ4KVlkz7VNrhmiEzpZmIBTNJ3qWHkdxHEwdKv3QEUl7SdX3QvyBMdLrgzJN2tqWX/41Yxx24JcuyHNl/cEV0sqgfTDEN+sHSkH6MKfWrDkuCTWtlHm3Vy3eB8C65cHaoRqluu59F1uL8fS5ef/toMnVsUKbatbXIz3FpIZoku2riqh32AX3Ni+y7Z1PDhUDuScVqiajTYWspXVOLGEIEv97vqKg39cwhZ8yWHVh4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(7416002)(235185007)(2906002)(5660300002)(54906003)(26005)(6512007)(2616005)(83380400001)(33656002)(86362001)(38100700002)(36756003)(6916009)(66476007)(8676002)(4326008)(8936002)(316002)(66946007)(66556008)(53546011)(6486002)(966005)(478600001)(6506007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ct0YIRlgMmeZ8Qr5DYWDcysGxx0RMC4KzSMMhoRBJtL/qOcHQUrdvaaDRNH?=
 =?us-ascii?Q?7DlHg2UU+Rq9bITY5CiJjt8R9a3dnggOcvNR0WV12hMG59CDxwPBY4f+yNgJ?=
 =?us-ascii?Q?Z3CBQYyUwOw3onC5TWMQq3pgmMUGqmO9Y2LnoycbRzcBh+ohmWfA0I+GIlUv?=
 =?us-ascii?Q?ITo///78cgmInIPYEQev76XI/ctJxA3wOJzQdjgD778fOXVLn6OSL8tSlLGi?=
 =?us-ascii?Q?p0FcxVvKeoAhtnieT1iLjWaq21qRCdpiuXfA7f6X/8QpAoOw0iJfg2/iwA7F?=
 =?us-ascii?Q?g9M34FaFu+GrqMQuPjFfuT5R6OWdZVvPhleq02W8edl/mM9HURXy9ul/VOhW?=
 =?us-ascii?Q?vQJmrpekiO9V9Inb/00LNjVAVmao6drXRKUhHkt3quLMmonceYp9vg3ZFduz?=
 =?us-ascii?Q?0lS1/3+ODaiRd5kkJfqA8zLuoDAhj3IGS2Mo5bDGN0AwTO85UlElNpADT6ca?=
 =?us-ascii?Q?wBU/0ZmABMbDu+WDmBcrhIARYiN6lj6TJl0HDYG82l+OcBXtuee3V3buohRV?=
 =?us-ascii?Q?p2a8A/kjxQim5Ko1w03v3OYVIG0hWzs9atIGC5LeBiaqaNk9G4daW1vr/gfo?=
 =?us-ascii?Q?VZv7VZZ0VmmQ0CKsUsrO2QSlXGy5ebZ7fXwsfgDVgGzKkblpZpnY9nwzP6kj?=
 =?us-ascii?Q?uQyOf6jbp6I0HTJdRKuu+eranU+KmkjWyP7zJEqXSApwgJXdfQEPt18to+n6?=
 =?us-ascii?Q?m4u5zf206e5R0qBKeORdkaQvRimpQQOZdxIKXOXJl3PRKIIYfuLIoopYAkj6?=
 =?us-ascii?Q?YqDwliKMYMMbHnq3WsDSD+5JCKjAXI7pykXnDsZPysvPcvz4GWVeAV8X5RTE?=
 =?us-ascii?Q?7cIC54VYrJ+7T5XphqsH4ZyCdLhy69kxSzvrxICUmU19ycy/hNKcsuFLD6ML?=
 =?us-ascii?Q?gfc0FDYDVWpRT5t7KtuLYq7K6quNXfyF8M5fbzZLcNIaBoEz0hS7P1JsRKjs?=
 =?us-ascii?Q?8TfEonrwZLOUpB9doL+gmlbhyH7vG39FHHOoERv8AgBJkapp0rLbjvVTyb61?=
 =?us-ascii?Q?QzkcLq/2P1YnhkPX9yyC3AjMc46QZRay5jaKRBZwj/q6RyGr0nxIXTWdjlwx?=
 =?us-ascii?Q?w4bdsY5APY9bS6ZSSZg/cYK1eKks2rpXEciED4ubj7NFsEYa4iySiwvazEAb?=
 =?us-ascii?Q?R8u5w3QBR5o3iVzFrduwXNoSXgQyMlxFDA6MPhMCuZ/a5jOKU7fM0nmgZvA7?=
 =?us-ascii?Q?rFaMDrKE/1LSSc/yanhUJi+DDV15haz2s7dhH92Unja67W0BsRQUXifCQH8m?=
 =?us-ascii?Q?ejv28yuNtfIeF5sRceNIMH7bA+jEQwGIiMvEXelCFya6LV5BSx0NScEfmUNh?=
 =?us-ascii?Q?HKmVaJE4gn7KkbFGIWMxi+W71lhSYJh9ASKd3h+5FQLH6yCGg46pdixLbcIT?=
 =?us-ascii?Q?AnAJomQr4OO/23tVQ3JQKYgDPHfJQuTyBnIA5y2DDUinchncyQ8ejlD09OCh?=
 =?us-ascii?Q?2oE3P8lChaYfD9H8gqZZ0ElbZH+6L/zmNVkr8++kNpgdQPp7t47HMsX9kFRw?=
 =?us-ascii?Q?AFoOV1+2MJ9Nq7LsDnw6TSkr2WZGCXt+HELrhxTA2pZWALEXGNKGz8vmZD1a?=
 =?us-ascii?Q?0hXKGXiiQzfIH/PXNSAZoQBbDwWw2CvtqLNDbXMm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09fc811-8827-4aa5-0b77-08dc29a4d0fa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:25:03.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JglO+2xE0k4i/yVwJA/NgAxKPhOg8G+NcG50maLxTTrBChjHC3gPIoiTTYDaD0vT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664

--=_MailMate_FC602DB4-D4F0-4645-A5EB-64CA8A6D48E8_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 9 Feb 2024, at 9:32, Vlastimil Babka wrote:

> On 2/2/24 17:15, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> migrate_pages() supports >0 order folio migration and during compactio=
n,
>> even if compaction_alloc() cannot provide >0 order free pages,
>> migrate_pages() can split the source page and try to migrate the base =
pages
>> from the split. It can be a baseline and start point for adding suppor=
t for
>> compacting >0 order folios.
>>
>> Suggested-by: Huang Ying <ying.huang@intel.com>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/compaction.c | 43 +++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 35 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 4add68d40e8d..e43e898d2c77 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -816,6 +816,21 @@ static bool too_many_isolated(struct compact_cont=
rol *cc)
>>  	return too_many;
>>  }
>>
>> +/*
>> + * 1. if the page order is larger than or equal to target_order (i.e.=
,
>> + * cc->order and when it is not -1 for global compaction), skip it si=
nce
>> + * target_order already indicates no free page with larger than targe=
t_order
>> + * exists and later migrating it will most likely fail;
>> + *
>> + * 2. compacting > pageblock_order pages does not improve memory frag=
mentation,
>> + * skip them;
>> + */
>> +static bool skip_isolation_on_order(int order, int target_order)
>> +{
>> +	return (target_order !=3D -1 && order >=3D target_order) ||
>> +		order >=3D pageblock_order;
>> +}
>> +
>>  /**
>>   * isolate_migratepages_block() - isolate all migrate-able pages with=
in
>>   *				  a single pageblock
>> @@ -1010,7 +1025,7 @@ isolate_migratepages_block(struct compact_contro=
l *cc, unsigned long low_pfn,
>>  		/*
>>  		 * Regardless of being on LRU, compound pages such as THP and
>>  		 * hugetlbfs are not to be compacted unless we are attempting
>> -		 * an allocation much larger than the huge page size (eg CMA).
>> +		 * an allocation larger than the compound page size.
>>  		 * We can potentially save a lot of iterations if we skip them
>>  		 * at once. The check is racy, but we can consider only valid
>>  		 * values and the only danger is skipping too much.
>> @@ -1018,11 +1033,18 @@ isolate_migratepages_block(struct compact_cont=
rol *cc, unsigned long low_pfn,
>>  		if (PageCompound(page) && !cc->alloc_contig) {
>>  			const unsigned int order =3D compound_order(page);
>>
>> -			if (likely(order <=3D MAX_PAGE_ORDER)) {
>> -				low_pfn +=3D (1UL << order) - 1;
>> -				nr_scanned +=3D (1UL << order) - 1;
>> +			/*
>> +			 * Skip based on page order and compaction target order
>> +			 * and skip hugetlbfs pages.
>> +			 */
>> +			if (skip_isolation_on_order(order, cc->order) ||
>> +			    PageHuge(page)) {
>
> Hm I'd try to avoid a new PageHuge() test here.
>
> Earlier we have a block that does
>                 if (PageHuge(page) && cc->alloc_contig) {
> 			...
>
> think I'd rather rewrite it to handle the PageHuge() case completely an=
d
> just make it skip the 1UL << order pages there for !cc->alloc_config. E=
ven
> if it means duplicating a bit of the low_pfn and nr_scanned bumping cod=
e.
>
> Which reminds me the PageHuge() check there is probably still broken AT=
M:
>
> https://lore.kernel.org/all/8fa1c95c-4749-33dd-42ba-243e492ab109@suse.c=
z/
>
> Even better reason not to add another one.
> If the huge page materialized since the first check, we should bail out=
 when
> testing PageLRU later anyway.


OK, so basically something like:

if (PageHuge(page)) {
    if (cc->alloc_contig) {
        // existing code for PageHuge(page) && cc->allc_contig
    } else {
        const unsigned int order =3D compound_order(page);

        if (order <=3D MAX_PAGE_ORDER) {
            low_pfn +=3D (1UL << order) - 1;
            nr_scanned +=3D (1UL << order) - 1;
        }
        goto isolate_fail;
    }
}

=2E..

if (PageCompound(page) && !cc->alloc_contig) {
        const unsigned int order =3D compound_order(page);

        /* Skip based on page order and compaction target order. */
        if (skip_isolation_on_order(order, cc->order)) {
                if (order <=3D MAX_PAGE_ORDER) {
                        low_pfn +=3D (1UL << order) - 1;
                        nr_scanned +=3D (1UL << order) - 1;
                }
                goto isolate_fail;
        }
}

>
>> +				if (order <=3D MAX_PAGE_ORDER) {
>> +					low_pfn +=3D (1UL << order) - 1;
>> +					nr_scanned +=3D (1UL << order) - 1;
>> +				}
>> +				goto isolate_fail;
>>  			}
>> -			goto isolate_fail;
>>  		}
>>
>>  		/*
>> @@ -1165,10 +1187,11 @@ isolate_migratepages_block(struct compact_cont=
rol *cc, unsigned long low_pfn,
>>  			}
>>
>>  			/*
>> -			 * folio become large since the non-locked check,
>> -			 * and it's on LRU.
>> +			 * Check LRU folio order under the lock
>>  			 */
>> -			if (unlikely(folio_test_large(folio) && !cc->alloc_contig)) {
>> +			if (unlikely(skip_isolation_on_order(folio_order(folio),
>> +							     cc->order) &&
>> +				     !cc->alloc_contig)) {
>>  				low_pfn +=3D folio_nr_pages(folio) - 1;
>>  				nr_scanned +=3D folio_nr_pages(folio) - 1;
>>  				folio_set_lru(folio);
>> @@ -1786,6 +1809,10 @@ static struct folio *compaction_alloc(struct fo=
lio *src, unsigned long data)
>>  	struct compact_control *cc =3D (struct compact_control *)data;
>>  	struct folio *dst;
>>
>> +	/* this makes migrate_pages() split the source page and retry */
>> +	if (folio_test_large(src) > 0)
>> +		return NULL;
>> +
>>  	if (list_empty(&cc->freepages)) {
>>  		isolate_freepages(cc);
>>


--
Best Regards,
Yan, Zi

--=_MailMate_FC602DB4-D4F0-4645-A5EB-64CA8A6D48E8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXGfA0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUMkwP/if75ooda/JRISshs6F5CzqwyDxYF9mLKJb0
Fz3dgSPk3tyiats94g83sauSp+YRD9hzjf6ngCrgQhMkY3th9IxRxwsEsfGa4twv
UBrM/pct/IhOBKS8aqK0IgFWkMB2Dlo0ltNCOYNAy9Jp/vbBXNkXkFzcJPuz2EsB
sKmPZ9k5SoTEmOmClOAykHojx4ARaxq7RKPo9JjYUFalgcEYNVCkOBBer9hnHQBi
NpwstihhN+i+IXGcda6bXGT1xRamVY2aDvknwCEHHV3G9bvByCBr1jeXyw3HE1BU
j0fcx7L2hdAVH9/9F/WObjsL05lRKbaLPOiOe1SITq8k3FM3JYHnakpC3GEuSpGp
5btW41SslezJpe4Le2L/Tekhaaad8XRzHJIXXM9Uhmv7wPKcCgCDqUWy7yF6pGP/
inT36T7E428VQuZsx/KsDPJVLAkuB4qZvgqIb5NchMrMIV2GgPf1f8jO2I60pSCU
W0hznl/Rtdxnw35qqUInI4KYS29Yi2WW8tIlGTR3yN6oEO6fmwE+sCL7q04MCh/V
YFvtgeLMmGHtaBaBJYe08la8+KMU85oknsr7rRc90Mji6Pq5lpJnuKUUHoHCQ68b
nxYLUbRL7NKlXDBHdsE7JmLS5ugb7THXzgOGibeh8tLRYNp3MefBhM8+VEIWLk69
73cIRTGH
=l25k
-----END PGP SIGNATURE-----

--=_MailMate_FC602DB4-D4F0-4645-A5EB-64CA8A6D48E8_=--

