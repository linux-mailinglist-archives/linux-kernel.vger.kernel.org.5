Return-Path: <linux-kernel+bounces-99492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1022878926
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EC01F218A7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EA55644B;
	Mon, 11 Mar 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M0cUH2XO"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15144206B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710186987; cv=fail; b=LfB1wIqXBChMG7NjVvylVTp9My2ol2ZUW9yXxph0pFl1J48X++tS5cSx2brcOa7jM8KlJjhj5MTAKklmiMiuDHbDwko1L+O+70/FakFBMZwWIQ+HnMhU4cPZ85WsalqkAh63pYAzXwDtK2rnYyzsVq8RL/jNfb6Uk69/t7DQTko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710186987; c=relaxed/simple;
	bh=Xj6lVndAY6INgRwstYT3BoHxPNUQKT23GEDnjjXXZuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=feMwyiljyFklyB1/M6bi5DOlgLFV45ih2PhYYYxinrQz/eztSL/TEINvyeDojZGRLroomOCSDskep+ICVqgeLe6dfLo0PF0HeFVKZ7ueFPzz6Z36Z5raj4Oyefc36Q2ZAlHppDvu0LPENJ52Sf7Ca152kYg9btuh9O76eSDzeZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M0cUH2XO; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuqRrfC53hQ1wYc9GPqIrDoeQn8UwiKjb0WyjLHemjlC8lI4TAkYD10WFDesNVRnFtelc1zdRAGjDcci0wTIrj2/+6k8EUWp8+31WcZM4QhJwsBLKYAOMMUs8x24deR+0E750akkuSnIlmARG666J/R3uZwgGe+faSZwdu1MWyjom1RRKtbad+DVCXPz9B02uLKWn4eUMJxtinvgWDr+sSi+p5+nEQw5BHS8mCkM45Zg+FqnmwPmOtvrQscocKrHUX15HQao5F3RbUhuTbulx+ZwlIyxtf9qQRvRe2Ju0LYJgkdXCNv9aq2ZTCXGsixd7cKAitkioHVTLpatshgR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUE40bL1Dmr+b27r0DtVf2AdRcOOpVP1zDb4jHk3SLs=;
 b=DLGVE2K2hNKGzePikuwfFw28ob4+cWGFgF3yt4lLRZtpF/EphjrPeGdeDESiRyyZL9SBxSQ5tM5Uu/XkYiIJOQH9SxyOLp8jNOlMJ9vEs4QqyOtoepa89oUzXem2//lZHkVT353BIaA3Hl3YtHYlwCEPq8jHIJLi2hg8dzfPiV8gKZL+L7MPg4ThYjbUuxSGsOdtZG71aSkZ6vPj0WYCgOWNVX1f9sQl7ZJlCrmHPzn51jl1zqJfh2b8cBwKEzYJWNDwdFQ+byOp+YCCEf3EOpUd36JtT7BHNGcl2FYlu39LmqPUXneBKjSSGFnodCZ2mwSyCFy9fX4fJ1LlbrjTKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUE40bL1Dmr+b27r0DtVf2AdRcOOpVP1zDb4jHk3SLs=;
 b=M0cUH2XO4KzZxbN08zqYw6UNBBxi8tuqy+atypJQaXjsDrYbN4WsdVDjMgg/4WZzAWtsWeq/jj4fkkQoorbSJoGh8Oz/tRfvgu2P664rcM/6BoOEdDbWdd8iAFjdqu4v5LcxItTOzoMFpzeyu4lDa949NYkRp0l3Rxabxr4CcxEpiZx8LOyQ8cNEFMsAAtF9yZzws8VWbC0LmLfUiDTCgDKNa1mSO48FT/cVEyzpGflk9q5juddhFSHyjy2q5rDSDNJGZ+lcRXPgEeN9UnSSmshBHLqd/4smb7/xUO7hBCfBjaO/4sF9AsANM2CnGz36VpsaYriiSd3U7IjXzKYE0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 19:56:18 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::dc5c:2cf1:d5f5:9753%6]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 19:56:18 +0000
From: Zi Yan <ziy@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Huang Ying <ying.huang@intel.com>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: put dest folio on deferred split list if
 source was there.
Date: Mon, 11 Mar 2024 15:56:16 -0400
X-Mailer: MailMate (1.14r6018)
Message-ID: <260C6C62-1BFB-41A0-A433-AD282AF8F23D@nvidia.com>
In-Reply-To: <93f05080-1a31-4f59-828e-f5294561a99f@arm.com>
References: <20240311193641.133981-1-zi.yan@sent.com>
 <93f05080-1a31-4f59-828e-f5294561a99f@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_1B58DD02-7015-4815-B354-729BBA140DE8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR01CA0046.prod.exchangelabs.com (2603:10b6:208:23f::15)
 To DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: c418492f-c51a-43d3-79ea-08dc420550ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5fa3XeC3A5x2fdxGrNWiP75q4WTckujLXuNcBd7iir5RK0TBQ8yqLxo4L0s/MCm5vCK54cWVFLnk4vrH6XJej0ZbUdCf6XVG8GZCXjUEuOGbujU3y2kNTlEKiVWetBZyNsuyCJVbLZmrDeg+h5LUNyfclv/DBUC2mNVjIHHVCDcNHyVdx32p5lpOVFJp6Qipd0SPmSgaByG7O10fC+SJfwBUDO7RvbqykpRrRYZtrb4R45E223OaPKukTjn706dfwY73AkZ5wxUw8nuplWkU5Nlez64Kx6J/WKXq/7xq+4fJv8gA4ch0Bg+p4GT7cDGyQY8wBhlQBX6EPCNdRVaMmfUpT1aqdV+VW7y0EamiHkF5T5asVN99tsF4vN452hcya5h6hvrNNpz9ZKM9jjZ9JYmmQUOaQy3eYDQHVv5cpO7TSachv1VcMuZyYa+i0Ocrc2fSUatc9ClKlaqR769RjmPvAg1zAcnB8VXfN4Y96VSIAru59Dm+rn70YayHTFvdDa8JZhTbU7XBvH/fOTmXg7QeHa20FsjN/X9Y+KUJ0LLeEBBZsCuKp4XXkoSroRXUmvBFsihiaLIJt0QgGtMuSBak07hbC8YJ9JEMMBw0eBMB0oETxKJnnhOv0UpbQg8CF2Jy3QMQAyPVUWInsyqUmMWPssktvLyQSDIH3P0eBx8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QN9it//rlZks1gP0UXdsAiyGrdfWn8IKdJfyzj+pyHHH1UTGDDv0qXOL7ydt?=
 =?us-ascii?Q?Gjn5IFmGSq12e3MxnPK4lFg8iZwq9cm732isalGyBtf8X88DPU2VB6hxPE/P?=
 =?us-ascii?Q?96JHbV4T8PtnfvgwpYtO4GMH84afv4YIkucjnkcm/fncBudMR7wj03eAGJkJ?=
 =?us-ascii?Q?HFl/XV37WPUoAKR/utTc2Ttev4CtZym+YluNtB878qdBCNIz/CZilJaRBWk7?=
 =?us-ascii?Q?9SPSkroGpxBl2KWB/R+cjsbiLopo2cmz/5v3RkbG5KQjVB4tCfOuHUAWtTD2?=
 =?us-ascii?Q?gJEE1CUyKBtI7CU7rU8Z5fi8xrQ48OZzBCG37TKZ0cqDPqTGzK+ww+jLu+oY?=
 =?us-ascii?Q?CJT4gHOXjlEF6NfWxnkpx6RO+GJTdBpKMKgG3Y1B+Ak2iIJMuXBM/Sq77Ka8?=
 =?us-ascii?Q?tURFJoDRM4nddpOHG/V8xvvihnSbkO3QD0YMR43ehdpWI6o9uUiqT5Ek3uFH?=
 =?us-ascii?Q?RJxa0efrholhKm9VXAC4z2ZWCjNnP1y5snRimvD2Mf78hROxnOAAJboMuNOv?=
 =?us-ascii?Q?YBTXpSbn0tNZyCaFBnaoiWvEqkGJw1s8SIbs1bJGV2ijQESsei2RPG+e4Ifk?=
 =?us-ascii?Q?cSk/8hX7cjsyoZ/ljeUa28Tt/zcGd+R3ETeogR3snOlPNKsmUQzZfRediK7T?=
 =?us-ascii?Q?0I4lKoWvdOCyrSJOy+lQ+EdxuuRstk8tJ8PjyhBAckKX5CWu1Wq/wQ90CSwu?=
 =?us-ascii?Q?H7T0LV4BpoKMR5UUaS8X4xcs42P+2DLUyNa6RnJ4EZDxvdpIpfI4ZzkDWunb?=
 =?us-ascii?Q?NjFpffpVl+Fq6CxOUPqXToDVLefKAW1woB0SSbv1rsJTvjA2KxPN4LYWBu1i?=
 =?us-ascii?Q?s0mr/j55VZaBHOAapVGUamt0WajqrQX8xN3XIj7VSqcF00ioCO2oM5jkQHX3?=
 =?us-ascii?Q?C2Ukr7/ms4IZXExlNnOg9crcfMteJVNzHlR6fm66nmSHb8ssxdFZkpTasPds?=
 =?us-ascii?Q?Bk6PT+qBS/xs4H37NqR7u54c6NE9NSzcPbTr4DoR3HxQA1ew2JdPxHwiU73f?=
 =?us-ascii?Q?zjWCINb5qs3h7vkczlA5zE4GgRFVHZ/RTXiRJRa/bPE4xuqjf7S/j//6mWiY?=
 =?us-ascii?Q?9sfHKVL+Is6RQTkut4X3XEing+CcgK80ot1/UVo314Y4qbW+UwuuojRaNRFu?=
 =?us-ascii?Q?QJKx5pFdtNna+zqnDmZmlleZXTACII3T2dOOSrvuHRc5JDd8IXpTFgxA72kj?=
 =?us-ascii?Q?ZzusKOCdZjW7O30i3okjiuWwwYsWRuxVmlvws73mWVG9loU/WVImgnW5b26i?=
 =?us-ascii?Q?AlRMOR7z30rSjhZqYkCWucLlp7Ka9suNew6YLeRHhiMSvc82d1PprUlFblCv?=
 =?us-ascii?Q?wWqLhJ6IFU1Mrs2m4LZrwKlfa2BxB0v83/wGDoRita65fgsgMQzgayJkDXSN?=
 =?us-ascii?Q?eLqklq5sP62LETBqXnDJ74YUp3M6+Cr4UtF6Tbv5I6+iO5hPcn/bR5tgdwY5?=
 =?us-ascii?Q?uXtN/LdvtXmabepcnXIS0WffsXlGghwkLn19L2NQoF7U0osGcg4AEGRQmFs5?=
 =?us-ascii?Q?jdtZUygfEoAj0Qhv9BCO9HrY02Rn7/OISjjQN2FbpSgwdvRQsaQ3ic/Srg3w?=
 =?us-ascii?Q?GfZgPGgVm/vEZF9Re1o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c418492f-c51a-43d3-79ea-08dc420550ff
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 19:56:18.2378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fd340MTFtYCWHjojh7Yf7UPKlt9lmnl3XD7sbnePAMcm5UZAYepDDA9UKitbJDIl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882

--=_MailMate_1B58DD02-7015-4815-B354-729BBA140DE8_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 11 Mar 2024, at 15:53, Ryan Roberts wrote:

> On 11/03/2024 19:36, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Commit 616b8371539a6 ("mm: thp: enable thp migration in generic path")=

>> did not check if a THP is on deferred split list before migration, thu=
s,
>> the destination THP is never put on deferred split list even if the so=
urce
>> THP might be. The opportunity of reclaiming free pages in a partially
>> mapped THP during deferred list scanning is lost, but no other harmful=

>> consequence is present[1]. Checking source folio deferred split list
>> status before page unmapped and add destination folio to the list if
>> source was after migration.
>>
>> [1]: https://lore.kernel.org/linux-mm/03CE3A00-917C-48CC-8E1C-6A98713C=
817C@nvidia.com/
>>
>> Fixes: 616b8371539a ("mm: thp: enable thp migration in generic path")
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/huge_memory.c | 22 ----------------------
>>  mm/internal.h    | 23 +++++++++++++++++++++++
>>  mm/migrate.c     | 26 +++++++++++++++++++++++++-
>>  3 files changed, 48 insertions(+), 23 deletions(-)
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
>> +
>> +
>>  /*
>>   * mm/mmap.c
>>   */
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 73a052a382f1..84ba1c65d20d 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/pagemap.h>
>>  #include <linux/buffer_head.h>
>>  #include <linux/mm_inline.h>
>> +#include <linux/mmzone.h>
>>  #include <linux/nsproxy.h>
>>  #include <linux/ksm.h>
>>  #include <linux/rmap.h>
>> @@ -1037,7 +1038,10 @@ static int move_to_new_folio(struct folio *dst,=
 struct folio *src,
>>  enum {
>>  	PAGE_WAS_MAPPED =3D BIT(0),
>>  	PAGE_WAS_MLOCKED =3D BIT(1),
>> -	PAGE_OLD_STATES =3D PAGE_WAS_MAPPED | PAGE_WAS_MLOCKED,
>> +	PAGE_WAS_ON_DEFERRED_LIST =3D BIT(2),
>> +	PAGE_OLD_STATES =3D PAGE_WAS_MAPPED |
>> +			  PAGE_WAS_MLOCKED |
>> +			  PAGE_WAS_ON_DEFERRED_LIST,
>>  };
>>
>>  static void __migrate_folio_record(struct folio *dst,
>> @@ -1168,6 +1172,17 @@ static int migrate_folio_unmap(new_folio_t get_=
new_folio,
>>  		folio_lock(src);
>>  	}
>>  	locked =3D true;
>> +	if (folio_test_large_rmappable(src) &&
>> +		!list_empty(&src->_deferred_list)) {
>> +		struct deferred_split *ds_queue =3D get_deferred_split_queue(src);
>> +
>> +		spin_lock(&ds_queue->split_queue_lock);
>> +		ds_queue->split_queue_len--;
>> +		list_del_init(&src->_deferred_list);
>> +		spin_unlock(&ds_queue->split_queue_lock);
>> +		old_page_state |=3D PAGE_WAS_ON_DEFERRED_LIST;
>> +	}
>> +
>>  	if (folio_test_mlocked(src))
>>  		old_page_state |=3D PAGE_WAS_MLOCKED;
>>
>> @@ -1307,6 +1322,15 @@ static int migrate_folio_move(free_folio_t put_=
new_folio, unsigned long private,
>>  	if (old_page_state & PAGE_WAS_MAPPED)
>>  		remove_migration_ptes(src, dst, false);
>>
>> +	if (old_page_state & PAGE_WAS_ON_DEFERRED_LIST) {
>> +		struct deferred_split *ds_queue =3D get_deferred_split_queue(src);
>
> do you mean dst here?

Right. I forgot the case of migrating from one node to another and though=
t
either src or dst works. Thanks.
>
>> +
>> +		spin_lock(&ds_queue->split_queue_lock);
>> +		ds_queue->split_queue_len++;
>> +		list_add(&dst->_deferred_list, &ds_queue->split_queue);
>> +		spin_unlock(&ds_queue->split_queue_lock);
>> +	}
>> +
>>  out_unlock_both:
>>  	folio_unlock(dst);
>>  	set_page_owner_migrate_reason(&dst->page, reason);


--
Best Regards,
Yan, Zi

--=_MailMate_1B58DD02-7015-4815-B354-729BBA140DE8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXvYeAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU41wP/RjMyagVKz9Hiy2G3hVuFs8G9cOSJbN/eFVa
sswnMcwDeMd99476Z18eATbaeGXcQiXAQ8El9o+fmuHCSjc4Su2DwBZ/mNuo1WFc
XdP5Up8f4yk03HhEArfx7YsrFr0yLN98sLOPfJjhK3dEyfDsu5bgqz3IFisFg0W9
0ylpWsBYY0TTrCM0UmRG4kbsn3OSz750BRe79NvyvHMYCEqhuq40kS1i5EiElWlc
QgFdnbqpcgSwGHWI7R+ouu6zw2hIFVh+pB7k5MfyBMDp1JDWtSVS3OLlOWTP2H09
Q0cemN4zkNl5P2VdWj0H9FLjc2FCkRURrl1CNIWTf3dSzPtwMCU1PDQSBstTQyKX
nU94hvSUq8uGnP9ZW9ksEAKC2wn1fWuSanVuLlaYPA/4kmxnOLnxXSCCqxizlt41
dF3m1PvY4LAzgmeIg/gdEu2a0bKFFQc9JAdUCfVn7uspzYx5vOshlqzCTz0bojXq
LCLbjg/wU2rzrbOcMbuqXyyCxH+lljl5HyY6cPIhc5wVnuvyS0iq+/WvB/CXdbvZ
NSLXrttsToommB7kSQk+ZViGHJ1QtC7D1U2SvwPC3I5h1fl4JJTdukH/Rj/4UOLT
W+KxAuPTxK4+QK8ltr8eF0lMtudQDUDCjmuinYWUPgAu1r3U+34rTW4Z8W/Xblt2
KRYK7rWn
=4oVT
-----END PGP SIGNATURE-----

--=_MailMate_1B58DD02-7015-4815-B354-729BBA140DE8_=--

