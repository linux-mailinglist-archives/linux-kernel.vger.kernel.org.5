Return-Path: <linux-kernel+bounces-73237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0038085BFD4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AC1D282B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF6876031;
	Tue, 20 Feb 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QvzBDbJI"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A466BB3C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442861; cv=fail; b=aZXUtNlR2jb4KNpknSCmH+3gnyeCjLj2HjRSZtdMtP3Gqvxp4n82N6SLjPStV4hLLVmo4BC5CZu5Ko5xbAh1HDeSuGYHNHp3sSncZiTzwkEyuFUoKa1tWLVhy1r27/4AbI5E+NxlfyA0CMnUl+7qqX5ow9xn4V3BqSj0OJ6ojTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442861; c=relaxed/simple;
	bh=R3BTPJQBqCaqRdcxVA8uk1Czm+CpphmVBlCUzqkLt7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KhICa4apcw0SZHDdPRHrM0sVvFLDNzJabXt/kcl/9gIPA8N8enomCzmMroqUGcyxJXiYR9SOmlUtBll2vHh5CLUuBNBj7ce8PnwLHtCPxnDK/QjWIVLC6F1SXmXPcYXVff12tEZyYvoy1l10t4HmkzQ/ydwLTQ02AIGnxYBcgMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QvzBDbJI; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlKEDd5v8PghDZLPBZIlQd8NGzJK3xVoeN1k4FlNigkOQaBoCpPro9Rz5NqqvSfwkuKwrJCu0yvKnecltZFQd3F1FRNqY2Sd38RGRSXEDam88twhkZzpD4vCmSySmwe8dFe1Qf4P8hTKbySEGNO5Xwjc6LCk5146jl1YFZZxCXCmen5YEwqzwFAxPURydsLx1XpzBEqJ245dAMK9VtUaHcVOTMWHuyzppiSHs8sG1Dn9FaT87JMLepXlHj+RyQqQIJ2zJ4cD3Zc9qN103xP8xs7ZFx9bXWcydS/LmQMAGYrA6F88p0yxcAdS09KT6NM9iQ3SnV2BUNNA1CfuI51IpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nxWFJB90gbNZQsWcogfDqtdcbBqqspezF/mb4mzN+I=;
 b=dlc6Wp+/4vru3GFBDt11IjX0qVyDUGsDI/ROpuXCwHFOypqQp1ZfllycveFyGWGlIblMgNUtKZJCv/vPOWKUDcE3TxxLQGV9dp0byEgPs9GOKE/oqbgcpumB7nAuf7bg7KUhsT0d+Dmtzi+TkpXEcENL6dEP8Mk8YvkmqpHOZ8u8bM9n+8i+4jo4VZLzDy1uZpCQ4UoECB6kAeCIV6NyWdgj2RbOLOFY/C7M2aCUkz5b07Gk1yizcOMkIzElhdq2JgVc36+GyEj/J7zjLPumGJO4kUD1cclAEdOvNcpF4tmwTdhAkFUixTHwvWHAjcRZBNsgd3FIu8qxZyANTJ5IXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nxWFJB90gbNZQsWcogfDqtdcbBqqspezF/mb4mzN+I=;
 b=QvzBDbJICP/m8p0tQpv1FzJnu3+nPHAyavxsAh3M2r7Q/vEBikT/3PX79Hi4+YFragMaCaBopaqxmE+rA+A4AInu8nRwqLyEgQPRRQ1MZUI+jKnlgLcCnXlj+Y3n/tDM7TagxKx4mnGfrmSvC3jshZO+9mUyGSruXuSmxQ7rK/e9U0qcgR6Mrgs/ldPO7v14u/LZ3AQPGSTJlBlqJF3x7t9WJg3GirvwFf2+0laRTHV5JXP441nCSG/McbhcOUTzwPpjbdiZyQ3rkZeZpo9OKOJssqsnwm8aNTtE4E3orDgj3L4Js840SMS5CRWuDnM/DBBi6zwNlc6aejIy2MakQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH0PR12MB5058.namprd12.prod.outlook.com (2603:10b6:610:e1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.17; Tue, 20 Feb 2024 15:27:36 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 15:27:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "\"Huang, Ying\"" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
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
Subject: Re: [PATCH v6 2/4] mm/compaction: enable compacting >0 order folios.
Date: Tue, 20 Feb 2024 10:27:33 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <42FD6CCE-C3F7-4E5D-86C1-C2FE2EF06818@nvidia.com>
In-Reply-To: <416d1450-6480-4113-b778-689a8f1d4e42@redhat.com>
References: <20240216170432.1268753-1-zi.yan@sent.com>
 <20240216170432.1268753-3-zi.yan@sent.com>
 <416d1450-6480-4113-b778-689a8f1d4e42@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_EFFE56B8-C35C-45B0-B11A-1A1A9CF07B67_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR1501CA0009.namprd15.prod.outlook.com
 (2603:10b6:207:17::22) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH0PR12MB5058:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b66417-2430-4cc2-8c8c-08dc322876fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RttCaIFKb/XTHxM9bhOsat70/wovuwcURUQoU4R47vyg98BhSXcahaWQdYIMiPg3kQsIXnwu8cUyuRwfMvDcl4DLTQvLgsbaStH10Xte2ixGa8yqv36zy9FarIYywK2sxhYNLaoQTaiILtwUdu6Bx+AO91WKjauqKpjf2kdcPHR7cx4K4KADte+3Uz98a5zfSRdY48MHbutX8yfNcoWMCzKhQ/0nLZ6MJrRxsQeQNHDT/jvDsk2oKQQnpoC97FH7Pg7moyRe7Qu3JkxvRlxrFFQ/aNd+rShmxGxzPvXHEb2hAQ2q3ukt2vQNSKHaOZcEr0b4pm+8+HlbX3V2sGdyAvHEUUNKhce4DwdvwxzZ/3fkW6fLi+JeBuE4DjT1UYTlFPINLhw6AiwLhzuANIIxqN5Im4kTRMdpUvC65OyfFiqKAt6mLRiRfE12i1qrme+OM5EUxJD6yojrnDfK5xwWnvtCRt+mpRR6youFuyShutQBsJOOMHLWQAJO9c0oQ3w/7o6xYxFEHp32MxKfUBgtSxwrdCjAGse29eVLK/OPylA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sv7OHzEgX5R0Gp14bnLrayq0vO+hHS8TN+oE3kT1z5NN01Z9/V20GngGo0TK?=
 =?us-ascii?Q?HjyMzR8O2rXd3zX8yB+FUI4cvUp7YqCSS9DL21Itgq0QkLnIyrOvjxdlodls?=
 =?us-ascii?Q?B/ecZVHWZOlxQA9uqASRrZ8mPoahaJiCIAKpIn+qmXLe3xsT6nlzLgvBDNxr?=
 =?us-ascii?Q?kWUA1Va25GoMi4UTl3ZXpntufOXsYGIHe0saOVk1fEqLYeO3LP1mmTaVXnKN?=
 =?us-ascii?Q?XnAF/7OFTeYgWAIFWj2AIhLZcD2AiUErgLLLq3AIaWGABGzPpfAGYPrT9Z9T?=
 =?us-ascii?Q?jnwlHi17FcqXBl1MbSLbMg0XkwcfdIZ/ifKV0sCbpyO5VQe0wk+YkkyKSps8?=
 =?us-ascii?Q?ONNiG0n2ym5gshVVrIsxj2uGlujqWHxKUeHr7rff0H6idAa3Weho0vl31v1F?=
 =?us-ascii?Q?wdmBpwQ8IGDUhuRW22RxiGIFuPOGXOWxeB68yimj6+qt5+Rq7ohkETytfin4?=
 =?us-ascii?Q?WxlI1EmLQz9S5pvFl1cP0h9mUkCBlKk2M9OB7NsLyGhFYzHzEd4EKosz99t9?=
 =?us-ascii?Q?BqbGhEXBUBnWZUWnjfVPnSq3qOrwzuDqwl8MerP1HDNKgwpI12hcapxC72yD?=
 =?us-ascii?Q?zyeF5tiIOmK3xPJ7cC3E8ME3r+j5TIf5l0y+QpusGlQqBUbOmHUeq+OJrjcx?=
 =?us-ascii?Q?e51nv/loKxjr30bPFc0TjcuOIKuSfst2HrfGL+Mz/XglGH0rcFWGLtx3pdb/?=
 =?us-ascii?Q?I3SgxrwPxM69RBEHnEa4ZhtpmGi1eq2g5I11aPb/rb7LjRjQO8/oShJxJWyk?=
 =?us-ascii?Q?ZzxCDgfnwapqsAhqXEhnoIJdM+XuVBtaOYOl6mjmD0hLbhDrjHckOGCwo8xl?=
 =?us-ascii?Q?aTfSAzDRWQgVz0ub+T1OaDogeqFI6Mdwsfqqdoy7jhLGSbaSsIqvsnPM3Ge6?=
 =?us-ascii?Q?FGOcp6aT/Nm8mh/a0ARZvBbz9jXkUz9cSxQWay0WK5uVtBhprErKnemopWDK?=
 =?us-ascii?Q?tE7b4Gp/1wOOghY69Ev4YbO0iEyW0tKAR/bhHzIIhbIOZx3WqJJZ4Noo1B65?=
 =?us-ascii?Q?ifpuBUBWTZVBmCYEj8KUUaxmroZKrnXagwtDEGEHtktC8U2uEEl8A2EpYFz/?=
 =?us-ascii?Q?BF1a9iPpooHR/H1gyTrX2h0FcmW20kQS7Rw2rc7EvnRwWdQGySn+/wssHOxB?=
 =?us-ascii?Q?1IZEPfaytpjxAia3QqpyDQVO7Zz4aA8Q4wrgJ9Dh1odMsihxkwnNrXI0u3nQ?=
 =?us-ascii?Q?naEQwUZcBzuw5Z3DbKtI8bShLmMcgr9hJDw4vtyr6/LD8Wl/WumobgJJLMls?=
 =?us-ascii?Q?HaHfl5JiyFiy6kRRLPqiHBjXJ11gB9MT7gR030JgCPS+hoD8SAue+flg5Q39?=
 =?us-ascii?Q?/bxRII6tkdwp5WMr1a2mC3bgI1sh4raVoMrCpLLrCBRAE5iJUJhDD1P5Vd48?=
 =?us-ascii?Q?98DBrAFJH8ihpZtPezhLxRY8opWedfaOk+daFVj+D6wBU5sHmSEqeg3bPCWf?=
 =?us-ascii?Q?LS22U7/3iIPM81c7IpHPVrBatkhfZj6gH6z5LQxyFrnilYUgEHbXVOa0NB4/?=
 =?us-ascii?Q?QVzERGwjnJJxPaPPjfF75dFoktH+ttc7GIafaiG+xZNmQWhxhLNdpiJLbb+4?=
 =?us-ascii?Q?KpnE4Nr91eNXwcVktBQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b66417-2430-4cc2-8c8c-08dc322876fb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 15:27:35.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8wN/2Izu/lGcujts9Js9zy/mKFheOro5rs/N6bSR+CR1kXZ8b76Es0KuslsOCwb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5058

--=_MailMate_EFFE56B8-C35C-45B0-B11A-1A1A9CF07B67_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 20 Feb 2024, at 4:03, David Hildenbrand wrote:

> On 16.02.24 18:04, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> migrate_pages() supports >0 order folio migration and during compactio=
n,
>> even if compaction_alloc() cannot provide >0 order free pages,
>> migrate_pages() can split the source page and try to migrate the base
>> pages from the split.  It can be a baseline and start point for adding=

>> support for compacting >0 order folios.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> Suggested-by: Huang Ying <ying.huang@intel.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>> Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Tested-by: Yu Zhao <yuzhao@google.com>
>> Cc: Adam Manzanares <a.manzanares@samsung.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Luis Chamberlain <mcgrof@kernel.org>
>> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Vishal Moola (Oracle) <vishal.moola@gmail.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Yin Fengwei <fengwei.yin@intel.com>
>> ---
>>   mm/compaction.c | 66 ++++++++++++++++++++++++++++++++++++++---------=
--
>>   1 file changed, 52 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index cc801ce099b4..aa6aad805c4d 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -816,6 +816,21 @@ static bool too_many_isolated(struct compact_cont=
rol *cc)
>>   	return too_many;
>>   }
>>  +/*
>
>
> Can't you add these comments to the respective checks? Like
>
> static bool skip_isolation_on_order(int order, int target_order)
> {
> 	/*
> 	 * Unless we are performing global compaction (targert_order <
> 	 * 0), skip any folios that are larger than the target order: we
> 	 * wouldn't be here if we'd have a free folio with the desired
> 	 * target_order, so migrating this folio would likely fail
> 	 * later.
> 	 */
> 	if (target_order !=3D -1 && order >=3D target_order)
> 		return true;
> 	/*
> 	 * We limit memory compaction to pageblocks and won't try
> 	 * creating free blocks of memory that are larger than that.
> 	 */
> 	return order >=3D pageblock_order;
> }
>
> Then, add a simple expressive function documentation (if really require=
d) that doesn't contain all these details.
>

OK. No problem.

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
>
> I'm pretty sure you meant "reduce" ?

Yes.

>
>> + * skip them;
>> + */
>> +static bool skip_isolation_on_order(int order, int target_order)
>> +{
>> +	return (target_order !=3D -1 && order >=3D target_order) ||
>> +		order >=3D pageblock_order;
>> +}
>> +
>>   /**
>>    * isolate_migratepages_block() - isolate all migrate-able pages wit=
hin
>>    *				  a single pageblock
>> @@ -947,7 +962,22 @@ isolate_migratepages_block(struct compact_control=
 *cc, unsigned long low_pfn,
>>   			valid_page =3D page;
>>   		}
>>  -		if (PageHuge(page) && cc->alloc_contig) {
>> +		if (PageHuge(page)) {
>> +			/*
>> +			 * skip hugetlbfs if we are not compacting for pages
>> +			 * bigger than its order. THPs and other compound pages
>> +			 * are handled below.
>> +			 */
>> +			if (!cc->alloc_contig) {
>> +				const unsigned int order =3D compound_order(page);
>> +
>> +				if (order <=3D MAX_PAGE_ORDER) {
>> +					low_pfn +=3D (1UL << order) - 1;
>> +					nr_scanned +=3D (1UL << order) - 1;
>> +				}
>> +				goto isolate_fail;
>> +			}
>> +			/* for alloc_contig case */
>>   			if (locked) {
>>   				unlock_page_lruvec_irqrestore(locked, flags);
>>   				locked =3D NULL;
>> @@ -1008,21 +1038,24 @@ isolate_migratepages_block(struct compact_cont=
rol *cc, unsigned long low_pfn,
>>   		}
>>    		/*
>> -		 * Regardless of being on LRU, compound pages such as THP and
>> -		 * hugetlbfs are not to be compacted unless we are attempting
>> -		 * an allocation much larger than the huge page size (eg CMA).
>> -		 * We can potentially save a lot of iterations if we skip them
>> -		 * at once. The check is racy, but we can consider only valid
>> -		 * values and the only danger is skipping too much.
>> +		 * Regardless of being on LRU, compound pages such as THP
>> +		 * (hugetlbfs is handled above) are not to be compacted unless
>> +		 * we are attempting an allocation larger than the compound
>> +		 * page size. We can potentially save a lot of iterations if we
>> +		 * skip them at once. The check is racy, but we can consider
>> +		 * only valid values and the only danger is skipping too much.
>>   		 */
>>   		if (PageCompound(page) && !cc->alloc_contig) {
>>   			const unsigned int order =3D compound_order(page);
>>  -			if (likely(order <=3D MAX_PAGE_ORDER)) {
>> -				low_pfn +=3D (1UL << order) - 1;
>> -				nr_scanned +=3D (1UL << order) - 1;
>> +			/* Skip based on page order and compaction target order. */
>> +			if (skip_isolation_on_order(order, cc->order)) {
>> +				if (order <=3D MAX_PAGE_ORDER) {
>> +					low_pfn +=3D (1UL << order) - 1;
>> +					nr_scanned +=3D (1UL << order) - 1;
>> +				}
>> +				goto isolate_fail;
>>   			}
>> -			goto isolate_fail;
>>   		}
>>    		/*
>> @@ -1165,10 +1198,11 @@ isolate_migratepages_block(struct compact_cont=
rol *cc, unsigned long low_pfn,
>>   			}
>>    			/*
>> -			 * folio become large since the non-locked check,
>> -			 * and it's on LRU.
>> +			 * Check LRU folio order under the lock
>>   			 */
>> -			if (unlikely(folio_test_large(folio) && !cc->alloc_contig)) {
>> +			if (unlikely(skip_isolation_on_order(folio_order(folio),
>> +							     cc->order) &&
>> +				     !cc->alloc_contig)) {
>>   				low_pfn +=3D folio_nr_pages(folio) - 1;
>>   				nr_scanned +=3D folio_nr_pages(folio) - 1;
>>   				folio_set_lru(folio);
>> @@ -1788,6 +1822,10 @@ static struct folio *compaction_alloc(struct fo=
lio *src, unsigned long data)
>>   	struct compact_control *cc =3D (struct compact_control *)data;
>>   	struct folio *dst;
>>  +	/* this makes migrate_pages() split the source page and retry */
>> +	if (folio_test_large(src) > 0)
>> +		return NULL;
>
> Why the "> 0 " check ? Either it's large or it isn't.
Will fix it.

> Apart from that LGTM, but I am no compaction expert.

Thanks.


--
Best Regards,
Yan, Zi

--=_MailMate_EFFE56B8-C35C-45B0-B11A-1A1A9CF07B67_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXUxOUPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUfp8QAKK8/Mw+zVIYCOx0SuZJk+rY/IWYOr/QVWoc
+lMXSZ50ZvlzpmsJsBCdg+zrl0zPg1cPa66j6OrF8A8nQPvW5F/UDwMhUR1jrHJx
HjYC3qI7eA7G72J+t1FEPq41sBtS/ypiAQbRwiK6KYME0GL42oMpeEPjyi67mixl
SDv7RAOd3YsSi33LXLuSrCQ9BvrMvLMRTesLKHbi+g1xnpdxBdpoF9UdsGH63Xuk
M5ASBmbftbakOQbRvtutmW3sMkL497PToKpXwYzs2aY11zWKwcdVLTivCreFiJ4X
vAWnuY/rTEAQ0AL6sUIF7XUhGcLLsQKiaiAX8ez4IVOdkYun4qXZL8PGXKpo0BfD
DgfJJLB3nLDy1/3iruThx5pFQXDkKR9qDkUg1kFsFuAmOXUVeSp6XSBfjXNz83OH
N7/S8GwZTArb+YV0keMlmFBG2eu6ym5nWYUoOQk+KyfwbF3mF7oYyUyUAxXMYWht
gwHtA02jqyXaAXDiYNMUOtg+A4jJyPG/Al9cMQmp7EU3Z19jKYDeYC8Xe4TheUfs
ZxUD5NrQ0I3rqNpTdws/roHhD5Q+6Z4Mk7wbEcosvZ0yWJY3rKrAxa4h5i82nAEH
zlgnB7M3IlKOAfNe4xgyfjti8wFxEJvKK0dc8Gkw5Ni8z6BElirM7wsSFLYJqi2T
P59gLVCp
=FCD4
-----END PGP SIGNATURE-----

--=_MailMate_EFFE56B8-C35C-45B0-B11A-1A1A9CF07B67_=--

