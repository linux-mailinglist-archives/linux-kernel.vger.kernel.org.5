Return-Path: <linux-kernel+bounces-59888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF47E84FCEF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A421C2675B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F17283CB7;
	Fri,  9 Feb 2024 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ngUxiKny"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A942A4E1A2
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507387; cv=fail; b=iVvLbxSVLPTKLiRdiTLLtwpcMJJ/AgaLAi/Og5ddpNBJsd0InKyn6/OP3lHNVQiF4ixCEj9tJqpKPrzt/iKc0BJF2WP7m3UHx7jdtc7SzQffm+bYn/Zlg1NL3OkK8K8oUiUIORHYBQ10deyMnBChAjqxv4LSZdVD/nNCpbZ9u+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507387; c=relaxed/simple;
	bh=96cqNtjVw9PKjptxtY/RG7sL5cECeH8n6Kp2I5II0iA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p8vO5KX7Fw0WzEy7garU9gWdrOn0goyxFKzy82l4RJ4FhsiS87Lvi0S0zisKswnWElm87TXxRsRX1khGIFOE4fce8cT24qt5X4GrqmnobWdP8f4eW2QQWyfOOr+U3qvkWWPlHQ5vMyRPk3d40Ju3Gp6g7EdgLwVEF3MixrfwkKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ngUxiKny; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADRgQBch1kjnnABqNvwLIYMDRxG1YsoD/GJZ6w3eppLCoZ1O+IidZCZCwu2FClQPSwqzhCseDCJTF8tcLHygjZGVPSVnULGZMzdtO0NaX+kmH3Fg9KM1kjUJladWtYpIsjrtlISmoIhrlmLGLlpAvXb9HWcHEJS1dmTwfsGmgIs37f3I2oMts3l6X4ghofujpbruGPr7BiB/1GBmf/OZf8a8FVVVvNmFXv4XeSR/+Y3EJL/jLqkb9j807DwMEMbkCA5n/qS4urRalfY84+z4uPQi6Eq1j9u8m0UYvVBJZss9HKtrEy4e42yDXCsNg/He6pkNT+yVAHz6vqJB2ZG0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaiixobfdE2wG76JFvnY9D4lkwPpOdVbsPfBYxKufn8=;
 b=SokYcpww6itD1nODqcipDDiD3Sv4mJwHK45AgCyU9Fucr+u1wSXUi/YGwrEaaAwigraqQmyuY8h7ZFRg+pRQjD5oiMD6Q4dktVeO85o0cUJ3bDTXRL6+hVkBEaSO+leTRfLxVRi08a119iyil/o+HT4NjevTN0zAA2Gqyp7R4ZGEeq3cZNhp+yDm0sUeQjlWSyzxkzw9VPRPIejFpY1vzZnaWDb04dqP6Sv7oeebyFi+Hbmtytzb6AXuIQmuMUzRVvpu23vtJmkzVpm6d+pYAbB0h1EE1rwQJcZzrclLGAu1uOVmNm9EEbljotp5lCzxS8daTvHC4scVOsT6MB/1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaiixobfdE2wG76JFvnY9D4lkwPpOdVbsPfBYxKufn8=;
 b=ngUxiKnywRtvSKr9dRuBG+qkJ719G4+FpFDWqzAWzN5J3YBw0mH7dZXsWBIEBWerN6xQ07HR9JTT/kqwvxOvMQQik3zDsVfc9EmIRYoZ5mNLSlyZSPmlNBHHIzTV5HS6TmwDIIIvf6YIiEBTsJKcfVwM75q7FFSwBcs7zoKOiKZJm3GiO2GNft745SMa8J5+DmszkD9lbdBj+mQOE70Z0Sd6a268hBYxEnVufHK7CQYB0zieSI1UC0BbC95i6wpDHo0ZzHcP196B0lLbK1jwQA7EN8uh8MyT97T+T5HhBFJuBg0z+SwLra6L6X3dQiPMC4sMSVQJS1W1oTYYZEwWCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY8PR12MB8361.namprd12.prod.outlook.com (2603:10b6:930:7b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.11; Fri, 9 Feb 2024 19:36:19 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::db3e:28df:adc1:9c15%5]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 19:36:19 +0000
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
Subject: Re: [PATCH v3 2/3] mm/compaction: add support for >0 order folio
 memory compaction.
Date: Fri, 09 Feb 2024 14:36:16 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <5F394663-0AFE-4C12-827C-3A0723863395@nvidia.com>
In-Reply-To: <025b7e7c-b17f-47c7-8677-ee36fc6dbc52@suse.cz>
References: <20240202161554.565023-1-zi.yan@sent.com>
 <20240202161554.565023-3-zi.yan@sent.com>
 <025b7e7c-b17f-47c7-8677-ee36fc6dbc52@suse.cz>
Content-Type: multipart/signed;
 boundary="=_MailMate_C3686B6A-167D-443B-B02A-6619C30F4C87_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0300.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::35) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY8PR12MB8361:EE_
X-MS-Office365-Filtering-Correlation-Id: 88dde097-a4d0-465d-3587-08dc29a6637c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1dKQib3OFMGgRo5Gjn4Q6ZtDly6ZT3K+TtrEfp+P/vj142ocJgwMOCPrcE+33ceTgdybQ3a1/T5fnQTenB5U/eN8cONOE+6BwSXBxqd69M/ASVzN9lEJM2CY51ypgmey1PT4Pwq/EOXlIEhRGNkM+izksfueJPsmkZDPpwcsccPP+Uy8qiZgFtuMKPX8B5OSLwz7PCTGIVtC6mnPaGpUpEGgSzbInfSHAUQL0Yefij2lJjiz9x4YcE7JYXTZlq+PNeuFkGScedis09N+said+2F9xEwqPbSYOvebzj6t7gOzqAiDsD+OZ4jhn6vE4xfHpjzqrP8ArYnYJ7Um9049S+4i4ZT7pEnwz8NbcJY5rliAaHespZNrZt2Lt8lXq8etfiAXHI7vcVHgZx5nRNJu1K1sbmT8Iw3b1BfqmcRnz1vYkXHdb4zVHTE8mKi7jp0wSFy2sQfAypL7ZnsBWPKKsVk6GbT2D2Rt4qwT9y+wJQh+uXDqxUIBOMIugNpVqOQxU9I5cqTrDJaVKFVXRaMIZZ14KQ3Z1OxQgpSHOyjBywcJ+tlDNiZhMHfsrissqYM+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(230273577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(2616005)(6512007)(26005)(83380400001)(54906003)(66946007)(316002)(6916009)(66476007)(66556008)(53546011)(4326008)(8676002)(6666004)(6486002)(6506007)(478600001)(8936002)(33656002)(36756003)(86362001)(38100700002)(2906002)(41300700001)(7416002)(5660300002)(235185007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B9OOvf1r8Uh8/aiI0MB3QcByftAs4AUKZOtfdJK4DOJhG7FU2VXUcY+08DlI?=
 =?us-ascii?Q?eo+J4zssF6Gz9h/a6LmZxLfeLu3Jufkw7smw0Bd1Er1X/fXBuxkTQqTkIJJg?=
 =?us-ascii?Q?UxPxDRJJwgEroqbeV9sFtDCUKiIsBpDKzTHp0nQYY7jqiyjOjdeDKSB0S3i9?=
 =?us-ascii?Q?dGhAyRDAruJjt3Vt16Bzt3gnzvLwuRGGNSZ0XqyUo4AN12uX4Gxn79UnDX8A?=
 =?us-ascii?Q?ZxEuJHNvGXRDKW5slpm65vaSSsSlZLAIelAPSlUU5UYzInRMOAsnTElhjyn6?=
 =?us-ascii?Q?kt5qaeyoJwSPJLE3YFNfL5CqOvY/HWc8jTEbdRpkngeT638j1o/7iOLboTJa?=
 =?us-ascii?Q?zaZMh43Rwi1k+STnNC4OnoVuv1CdldmY/vHzCi33MWno5F4KTJW0AmyJvgKM?=
 =?us-ascii?Q?T2UNeEMPn0VGY6iNwqUiBmqt6nYVYL1hLwvDRvPYp0BAiMAJ+v8IgnKnXK5h?=
 =?us-ascii?Q?NWIcoLR7aAKA2pkhzjkw+/oMPJegColzFvrfMqbkU3iTmBQskaHhi9mqZ8wQ?=
 =?us-ascii?Q?0UHXsmjkCRblpMuHW08omgFKvvdKoYK4AoblKzxJHyQmbh/a2sNNA7TIeifP?=
 =?us-ascii?Q?lOcG2NIZdxow4UOCaE0zjJBJSb33fwXTLPYFraInmEoP3KEJIPoOdgWi3QZy?=
 =?us-ascii?Q?b0pydceqjwL9fH3xUlwhzayzKtiCQhH+o46EiBjdpg8QJ6E3XycDOdUhVbyi?=
 =?us-ascii?Q?18t2ofuzUhUWYpASPTTIfnoRrwDkyE5XtAt4gj/0nCMzB6ll0XxLkQvGhNfR?=
 =?us-ascii?Q?lZeRW/Gx6GMUnGyILq4zhFl7xx6z+l9BxwWymaVf58bfYcq++KMgFl59sW0n?=
 =?us-ascii?Q?cZa0jGIz+Eir+ofwwV4uGYNZBvD0AbwJYfOdpSJBHAOnMefzFhPcOV4sR0rs?=
 =?us-ascii?Q?iCGOW8K2Zn8xg8q5Qt1XM4iZkmOrXIcek/fkcJuWsBc43J+Wob0S0w9+24US?=
 =?us-ascii?Q?yyLwTnmkY2SUSjdJhSpQjkZ5UCigFJadhVpR4wlgYKgi9/9wqLVsYdQiqtSm?=
 =?us-ascii?Q?NM/uOD2rFtKoiHzTrX0UTJKdfm26uEyqeIUp19oRnNsBZs9PvV5nhMrc8rB+?=
 =?us-ascii?Q?TdgXnimpFjaTwLKYHm7xbiaJnEJnip2q0TWVt+JyIxQtQytgkNhsUqawWXMZ?=
 =?us-ascii?Q?07by0t/v0S5n33Y8YENqPrpxMYd07XSfnzCtjZEWoJJd8X4BAxZzYdcfQaWq?=
 =?us-ascii?Q?vA8Vz8n9Lc8jRHjPho9J+A6Km9YGjRIaUmzleVpqF/j1yAllbS3WRXDXyNMk?=
 =?us-ascii?Q?8x08lJxoIhFN20Z31sbXgYyd9XXdhVzJ81Lu9gaJ5B/QDjP5ve2s6EsnAl2h?=
 =?us-ascii?Q?yIID4AZw+ciaK2DISmeLFG9x1/p53rXzKO05Hr//5X6AYhjOKiAhBnbNXb7y?=
 =?us-ascii?Q?JBRJy9Z1OJqq9gkQp92KoJIUBlPugbl67LUlEkrtOi6J6ex8olMgY02juWtA?=
 =?us-ascii?Q?WSLTZ07ugV00T3ebfrBzMWC6UpVuwH/Ojn1BWHaiPIDOpNxot7n03GUru2us?=
 =?us-ascii?Q?abq/SP79SlRymEgsg8/XAgp1XVzSuWgHPKt4fN3hxxE+VSWr2E1+WTbXWDV8?=
 =?us-ascii?Q?dgePwW4xtnt80ppRdZQhrmJxGefXY0CspBDGMJ1s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88dde097-a4d0-465d-3587-08dc29a6637c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:36:19.1418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtsQa5AFSpdoNVu83vqHnWrFPp6f+Nq4Q+q9ysoAPtJsfs0RXBEGlMwcMgyIhwT7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8361

--=_MailMate_C3686B6A-167D-443B-B02A-6619C30F4C87_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 9 Feb 2024, at 11:37, Vlastimil Babka wrote:

> On 2/2/24 17:15, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Before last commit, memory compaction only migrates order-0 folios and=

>> skips >0 order folios. Last commit splits all >0 order folios during
>> compaction. This commit migrates >0 order folios during compaction by
>> keeping isolated free pages at their original size without splitting t=
hem
>> into order-0 pages and using them directly during migration process.
>>
>> What is different from the prior implementation:
>> 1. All isolated free pages are kept in a NR_PAGE_ORDERS array of page
>>    lists, where each page list stores free pages in the same order.
>> 2. All free pages are not post_alloc_hook() processed nor buddy pages,=

>>    although their orders are stored in first page's private like buddy=

>>    pages.
>> 3. During migration, in new page allocation time (i.e., in
>>    compaction_alloc()), free pages are then processed by post_alloc_ho=
ok().
>>    When migration fails and a new page is returned (i.e., in
>>    compaction_free()), free pages are restored by reversing the
>>    post_alloc_hook() operations using newly added
>>    free_pages_prepare_fpi_none().
>>
>> Step 3 is done for a latter optimization that splitting and/or merging=
 free
>> pages during compaction becomes easier.
>>
>> Note: without splitting free pages, compaction can end prematurely due=
 to
>> migration will return -ENOMEM even if there is free pages. This happen=
s
>> when no order-0 free page exist and compaction_alloc() return NULL.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> ...
>
>>  /*
>> @@ -1835,9 +1857,17 @@ static struct folio *compaction_alloc(struct fo=
lio *src, unsigned long data)
>>  static void compaction_free(struct folio *dst, unsigned long data)
>>  {
>>  	struct compact_control *cc =3D (struct compact_control *)data;
>> +	int order =3D folio_order(dst);
>> +	struct page *page =3D &dst->page;
>> +
>> +	folio_set_count(dst, 0);
>
> We can't change refcount to 0 like this, after it was already set to 1 =
and
> somebody else might have done get_page_unless_zero(). You need to eithe=
r
> put_page_testzero() and if it's false, consider the page lost, or leave=
 it
> refcounted and adjust the code to handle both refcounted and non-refcou=
nted
> pages on the lists (the first option is simpler and shouldn't be too ba=
d).
Got it. Will fix it with the first option. Thanks.

>
> Perhaps folio_set_count()/set_page_count() should get some comment warn=
ing
> against this kind of mistake.
>
>> +	free_pages_prepare_fpi_none(page, order);
>>
>> -	list_add(&dst->lru, &cc->freepages);
>> -	cc->nr_freepages++;
>> +	INIT_LIST_HEAD(&dst->lru);
>> +
>> +	list_add(&dst->lru, &cc->freepages[order].pages);
>> +	cc->freepages[order].nr_pages++;
>> +	cc->nr_freepages +=3D 1 << order;
>>  }
>>
>
> ...
>
>>
>>  extern void free_unref_page(struct page *page, unsigned int order);
>> @@ -473,6 +475,11 @@ int split_free_page(struct page *free_page,
>>  /*
>>   * in mm/compaction.c
>>   */
>> +
>> +struct page_list {
>> +	struct list_head	pages;
>> +	unsigned long		nr_pages;
>
> I've checked and even with patch 3/3 I don't think you actually need th=
e
> counter? The only check of the counter I noticed was to check for
> zero/non-zero, and you could use list_empty() instead.

Sure. I will remove nr_pages.

>
>> +};
>>  /*
>>   * compact_control is used to track pages being migrated and the free=
 pages
>>   * they are being migrated to during memory compaction. The free_pfn =
starts
>> @@ -481,7 +488,7 @@ int split_free_page(struct page *free_page,
>>   * completes when free_pfn <=3D migrate_pfn
>>   */
>>  struct compact_control {
>> -	struct list_head freepages;	/* List of free pages to migrate to */
>> +	struct page_list freepages[NR_PAGE_ORDERS];	/* List of free pages to=
 migrate to */
>>  	struct list_head migratepages;	/* List of pages being migrated */
>>  	unsigned int nr_freepages;	/* Number of isolated free pages */
>>  	unsigned int nr_migratepages;	/* Number of pages to migrate */
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 5be4cd8f6b5a..c7c135e6d5ee 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1179,6 +1179,12 @@ static __always_inline bool free_pages_prepare(=
struct page *page,
>>  	return true;
>>  }
>>
>> +__always_inline bool free_pages_prepare_fpi_none(struct page *page,
>> +			unsigned int order)
>> +{
>> +	return free_pages_prepare(page, order, FPI_NONE);
>> +}
>> +
>>  /*
>>   * Frees a number of pages from the PCP lists
>>   * Assumes all pages on list are in same zone.


--
Best Regards,
Yan, Zi

--=_MailMate_C3686B6A-167D-443B-B02A-6619C30F4C87_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmXGfrAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUzCwP/092D503wXTiG9qwTDAik+OqQu+E84Qcq0vT
6S5vR5z79wiJbzkWqXN/kz1UCwddS2oeETTKkM52ZhpJ8n3GCzC03shXdgi/E1Ze
DPWhuSZ1oUi0Ejfg9WTfVzMMQDPZX9YgMwJgh8A739M5h1fm3KRjdJzWvKFQNBrn
Xfz/QkCmUgIAXk7IdifnSwPn9E6J/BKbtiBEHVgOamHVKUmeyx11YqjIt9e9h0NW
MNFIOH2ZC3jeGratiCmHVh4pGZ8PTEBJBtnn4XoWdDPvy2JI+GXyOcVqmfLzQWoC
8RgtzKT3sGf4MCxBIXInn0lX8OyKZUiYJa70h+P42aJWLtTFPiE8tr4QNByVGfLF
YLw92ZUOt+HPkB5GmcO5dnVRWPJNCNdlIYaKA477rN1k1BkW0T0TiLdlZJxLr+rq
iUp6lIReO94GfBZ/Zr2KPEbjSPkSoquz2RutMaB6u1JYapz3eU70O1Z4sDzkJtZt
HIzXVXuTx3Yj/2MhQNhQEfUj0e0otkniaTP/cwv7vMqM7KW5ims33JqjzOL+bJB1
4uKk2nRcKU76CVGQsLbG0WmnKkD29A0xI+kPs3p7pLNb92bUEDtv/YddutWSaY6T
/JX8e0wR/E8TkLsoZn0oTOIvLbkRIGU+MkPDr15sP+IB+g0KN0oMWBIrhCzoZWbX
AHIp22wv
=Hv2V
-----END PGP SIGNATURE-----

--=_MailMate_C3686B6A-167D-443B-B02A-6619C30F4C87_=--

