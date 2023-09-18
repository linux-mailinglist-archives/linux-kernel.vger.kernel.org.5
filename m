Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD36C7A5077
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjIRRGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjIRRGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:06:42 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34458E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:06:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKMgLt3I7gWAqr6ygperhv29Drl3EHNQwaz4Zn73aB0xHMgg08cHYGZ4jwCW2W+VbwWP02IRpq/URFAIzmi2ADm5DjMppmU7/SNJYu/DPFMncs2rUfypxiJ5Cs63ZaI3eqy9YahVXG5JDj506TdELBwjRJc/v7tQC/bIFwx1WmTLW9YPsRQvraxyxzeVvdKMD+OtLagbwOGNs6dqKcqLOGBaDZF0CuKItjrPMTRYo/Xsi160zlqwasJI9JaPbbKlFrOTs2S09RBTaY1oCBcrj4y8X5xDwrO8j35qxMeQrwShfc56Bba/W9pgE4jj0MtpUBxY1HiGfDqfgGVWNSAtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TgCtATbs/lDULaRElGjRPGGvA3DQj6PpX4ir17KTy4=;
 b=PDnCm9e1WzQWvCwo9N67DLgUosDkryyPfbhYtl6QB2Fy3jadgLA3U1dvBzuxXbZn9hiKa2f9PVEgW5cL39D+eSQFf2PVFxGxJjl4wRIZ4ucszdcvoDvwOBW3LnhZnh/Cp2/IofPvgt49YDJGwjqN2MWBNO57AdyRVnunSrJ1gYxI4fYRa6pRGOu1VF1rc72LnGlNscXcojhyoEqgeSWCo5vV0QqneAtkaXpm30TUdYivtT4lA9SsgJmNqdINA0H4Tsfb+QMUdbsxDoccSDG/1rTIonsUgrRqUT7yTchEVFhW13aUYGgfZJppr40eFsHua+mMKzfhqKVVX/+OW1D/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TgCtATbs/lDULaRElGjRPGGvA3DQj6PpX4ir17KTy4=;
 b=kOcndnlqGaCTt1eyQ+e+AdEfLxoEK2e5t5tfWIoS3ap8kY3iQCDyMWwRkGXePU3V+33AEtTZE6HiXg6IcJYIVVTaRbdvEyP6otn1LXXHEOAD5ngWNyNeCAzP7SDXEnNtcD3rgpBAeSHsNV3zaPcNKWo5yQ/VbIjQ3CkTS7TIFV8qEcETXd5QoPKmTnbsAi5U6oeHkIURtq1BnVu4n31eRvuirpOj9Phx2497VhGUfJFIxuG3U4jpNnOWy9gTP8g8riYeuEsYsesiBQtgO0LeWsLtLen7x5uuu7Qx23ecJojaQRUTfcUOT8dsVwpkF/bT+C85dReL7fHdn+qmfV1hlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Mon, 18 Sep 2023 17:06:28 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6792.020; Mon, 18 Sep 2023
 17:06:28 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "\"Yin, Fengwei\"" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 1/4] mm/compaction: add support for >0 order folio
 memory compaction.
Date:   Mon, 18 Sep 2023 13:06:25 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <1C341528-B2DA-4122-A15B-31A8F1E766A8@nvidia.com>
In-Reply-To: <1d2e6eff-027b-bf27-924d-c232667d0845@linux.alibaba.com>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <20230912162815.440749-2-zi.yan@sent.com>
 <1d2e6eff-027b-bf27-924d-c232667d0845@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_16B02DBD-4F04-4193-8915-7FCC1EFDE83E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0368.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::13) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: aa141b33-26ba-43db-09b4-08dbb869992c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpAPkD80cipjn+mJlSh5CUCiBpDC9bakJiutBedCE1ig4CKhHclH5Oyowq9Gr2gzdNrLqY3vMkfCj5chEvqcU7gmA35Z8PN3nT1cWYu5K1uAFCeDFvWzZ8TVE3s3BgrTjSncRjJA2YVEB6CJUUrNWyd8mo9X6hh9NJOjxdzv+noHa0CO4KOUaqmmre8Fx3Z4ZJEmPgJQ4wS72R3R2/tPp5GlGWwq1/LlG8yOCNUmIslnGoPTmd6XdedS1Wj7vWZ4ZOYNCphV4N8rIj5oMyjVaFSQbyHkdtaeRpsVAzS+j1rDSvQTQq0bbZDUhPfn2R78hb0u4O3aOZMGEVRuQQ0PbCWmnFoaw/LCC0FplMUXTNVCowF9PsQfB0cO0yPC1/ppYIwDkQEh6Ks+cYfSlzQ03m40EN6mI8DvBCJmj+zbsWrMoGoVFErB5oUTGVrrdo+XWvJ8suSh1PQHvRYhLDgjuNS2cMIWGm83MiyInjYZy6JLHpLv2Y8tycIZzh9sVILz1BXAb+YLs9nTrKu7VbqS8TnrXc+wwsKYo/sCXq1v7aCaYibH4P/QOW3klmom5Zp16s4gTViGdc5S6an1qXz/Vv1mdGzIOduXL97iX/X3gEisZnjT3qlMLWoTJsswMcNv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(136003)(376002)(1800799009)(186009)(451199024)(5660300002)(2906002)(478600001)(7416002)(6666004)(38100700002)(235185007)(53546011)(6506007)(83380400001)(6486002)(107886003)(2616005)(30864003)(6512007)(26005)(8936002)(36756003)(66946007)(4326008)(54906003)(6916009)(66476007)(33656002)(86362001)(8676002)(66556008)(316002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1GoCXCGBo7BzgysYrnw0/bQfLocJkQ0kkJZKUXTPPSc2wf3Qlpa+ao0YXBct?=
 =?us-ascii?Q?A7oHQwzM/zTCZgSdQL3LCrIJKvwuCjwumzgooY9JZPKYP1RQ8Wn1RyGmoSAO?=
 =?us-ascii?Q?7JZ/Rg7bsOkgvZmqcGC3EklYxs0D7kVPj1WQSKjjWhRxj3hCRRuufw//2TU+?=
 =?us-ascii?Q?oS11tETt6TlwSmeZekMk6/6spgBQedGmjM9HEySKanNvrnXh6FeOix9z/sfq?=
 =?us-ascii?Q?7UKu/+gc8j4CGFQFtzmLUKtOpPYQ9dHZQVMleMH164tbzTE6PV/vQpHdZ+Ta?=
 =?us-ascii?Q?auxRPA4Uifa17IuIgSEZ1RAC3zUcmAkTOLwKkG9bZkHf1K72bNZFwNNv/mmO?=
 =?us-ascii?Q?Vcb3l2MP8Ui97ca5MyQ9SR0KscD7EuhosVzpgvF6523rilYO6Thr0bCbndhP?=
 =?us-ascii?Q?l+o+iNYTPqNSPx7e2wREfZvtWypDRmZTCoDfhJvx8Oq4uXBmxcqz7sZA3PRA?=
 =?us-ascii?Q?XrqgOIRpX5f6ryFkRleIpME4zkjfnZE8qNYoMFOQaf42gQgXBy3qGmuCO5Qt?=
 =?us-ascii?Q?WLKyGDI0S34B9MlBWtdq3otGRQLHrh58fdR/iR8wECeelwiNdqwcD8jQg4XC?=
 =?us-ascii?Q?SaywZ+qngfYc2iD8QjBDKG6OZpKEICdgMokzPX3P9nkdKMXYzZDFOlYX5+nX?=
 =?us-ascii?Q?YUYe/DWQ4bux7rkwWSsuCzx8GfCxjWRyLScPRRol3WLo0KGUNvHOybF5Dcz8?=
 =?us-ascii?Q?EvDQA8N5X4g1LDU2c/NSd8FdsYOdhSLw4eCUdxueaDlJCxb4+rMhMG143jYI?=
 =?us-ascii?Q?tyon46oYPVqk0I0TbJKTOQijXiJgQilCIYbUhlI5BqxlfkIscTtgt7HZy4XQ?=
 =?us-ascii?Q?+LKKGI671l6AyJ8pLHibja1nb5VxfpaBr0fphi7JW51r4wz3dieMPVakCHj3?=
 =?us-ascii?Q?eKRHbdYrSyBDm1VplmfJ7Z2KqEiO8sXKmF6GF7Uu1ZX0bgeZqFOAiZ7LNLS+?=
 =?us-ascii?Q?j+XWAYyukbtI4sLetnslohR0lK7NnrpwhbmWGFqLDQT1XaD2E6iaHl/BV3eA?=
 =?us-ascii?Q?s2K/sciiD+GgHLRj4Q95BJ91rC7NSPCdT7hOSZIGRztY3/2+3lquDO16lU++?=
 =?us-ascii?Q?DM62COAbimpXgPp7lK/j+5NH00aSmaiA6LuZG+VpaRaWVLRF8RKcgBXvm2ov?=
 =?us-ascii?Q?vVxboevPMvFhTR+fvQh6Ev+6rLcnhWBdsrIWnptyvD7lzGBdDZJJilZtkSe3?=
 =?us-ascii?Q?uvIR5ypgWVkITL/FqZfukEs3H2Wqvo2oLBg4F64ke8m7/Vl4co2D51xrsqOt?=
 =?us-ascii?Q?ZSFDx++IMjdT9UmHiV+Qpr7Gbj63ZVVWmfd+08gkY/ZgHFOqaTdefhASc+cR?=
 =?us-ascii?Q?tpqCTh6dFXpBno2BWd+esV6q3E7lihJKzYOmCPpFZjC0bhy5ykxYY0MlcJ2i?=
 =?us-ascii?Q?0hN58H9mmqO5pg22Ez2p/yd7ozxDwfHCZmSOiTL/qjR4PYIp5W5HLYQRfwWb?=
 =?us-ascii?Q?PJJP+nd7F/vjQ+BBRHLT0y8p8m9+0ZwlxvQxWp+yUm6jYcln7QjhiHhqEKwD?=
 =?us-ascii?Q?jAhPu+tTPAo9DxZsR5j8RHaDLdvvrYwLTU+zVuRe+nzpmpzknU8JREbukO+Y?=
 =?us-ascii?Q?Vil7HF0zKRL/BXII3ac=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa141b33-26ba-43db-09b4-08dbb869992c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:06:28.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dt0clHD4iAWcw47sH7UTT9iFWb9Is7RgMNia4s1nM6D5QgySlfH4f68Oe77DKxIb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_16B02DBD-4F04-4193-8915-7FCC1EFDE83E_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 15 Sep 2023, at 5:33, Baolin Wang wrote:

> On 9/13/2023 12:28 AM, Zi Yan wrote:
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
>>     where each page list stores free pages in the same order.
>> 2. All free pages are not post_alloc_hook() processed nor buddy pages,=

>>     although their orders are stored in first page's private like budd=
y
>>     pages.
>> 3. During migration, in new page allocation time (i.e., in
>>     compaction_alloc()), free pages are then processed by post_alloc_h=
ook().
>>     When migration fails and a new page is returned (i.e., in
>>     compaction_free()), free pages are restored by reversing the
>>     post_alloc_hook() operations.
>>
>> Step 3 is done for a latter optimization that splitting and/or merging=
 free
>> pages during compaction becomes easier.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   mm/compaction.c | 108 +++++++++++++++++++++++++++++++++++++++-------=
--
>>   mm/internal.h   |   7 +++-
>>   2 files changed, 94 insertions(+), 21 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 01ba298739dd..868e92e55d27 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -107,6 +107,44 @@ static void split_map_pages(struct list_head *lis=
t)
>>   	list_splice(&tmp_list, list);
>>   }
>>  +static unsigned long release_free_list(struct free_list *freepages)
>> +{
>> +	int order;
>> +	unsigned long high_pfn =3D 0;
>> +
>> +	for (order =3D 0; order <=3D MAX_ORDER; order++) {
>> +		struct page *page, *next;
>> +
>> +		list_for_each_entry_safe(page, next, &freepages[order].pages, lru) =
{
>> +			unsigned long pfn =3D page_to_pfn(page);
>> +
>> +			list_del(&page->lru);
>> +			/*
>> +			 * Convert free pages into post allocation pages, so
>> +			 * that we can free them via __free_page.
>> +			 */
>> +			post_alloc_hook(page, order, __GFP_MOVABLE);
>> +			__free_pages(page, order);
>> +			if (pfn > high_pfn)
>> +				high_pfn =3D pfn;
>> +		}
>> +	}
>> +	return high_pfn;
>> +}
>> +
>> +static void sort_free_pages(struct list_head *src, struct free_list *=
dst)
>> +{
>> +	unsigned int order;
>> +	struct page *page, *next;
>> +
>> +	list_for_each_entry_safe(page, next, src, lru) {
>> +		order =3D buddy_order(page);
>
> These pages are already isolated from the buddy system, but continue to=
 use buddy_order() to get the page order, which can be confused. Moreover=
, the buddy_order() should be under the zone lock protection.
>
> IMO, just use 'page_private()' to get the page order like split_map_pag=
es() already did, that seems more readable.

Sure. Will do in the next version. Thanks.

>
>> +
>> +		list_move(&page->lru, &dst[order].pages);
>> +		dst[order].nr_free++;
>> +	}
>> +}
>> +
>>   #ifdef CONFIG_COMPACTION
>>   bool PageMovable(struct page *page)
>>   {
>> @@ -1422,6 +1460,7 @@ fast_isolate_around(struct compact_control *cc, =
unsigned long pfn)
>>   {
>>   	unsigned long start_pfn, end_pfn;
>>   	struct page *page;
>> +	LIST_HEAD(freelist);
>>    	/* Do not search around if there are enough pages already */
>>   	if (cc->nr_freepages >=3D cc->nr_migratepages)
>> @@ -1439,7 +1478,8 @@ fast_isolate_around(struct compact_control *cc, =
unsigned long pfn)
>>   	if (!page)
>>   		return;
>>  -	isolate_freepages_block(cc, &start_pfn, end_pfn, &cc->freepages, 1,=
 false);
>> +	isolate_freepages_block(cc, &start_pfn, end_pfn, &freelist, 1, false=
);
>> +	sort_free_pages(&freelist, cc->freepages);
>>    	/* Skip this pageblock in the future as it's full or nearly full *=
/
>>   	if (start_pfn =3D=3D end_pfn && !cc->no_set_skip_hint)
>> @@ -1568,7 +1608,7 @@ static void fast_isolate_freepages(struct compac=
t_control *cc)
>>   				nr_scanned +=3D nr_isolated - 1;
>>   				total_isolated +=3D nr_isolated;
>>   				cc->nr_freepages +=3D nr_isolated;
>> -				list_add_tail(&page->lru, &cc->freepages);
>> +				list_add_tail(&page->lru, &cc->freepages[order].pages);
>
> Missed to update cc->freepages[order].nr_free?

Good catch. Thanks. Will fix it.

>
>>   				count_compact_events(COMPACTISOLATED, nr_isolated);
>>   			} else {
>>   				/* If isolation fails, abort the search */
>> @@ -1642,13 +1682,13 @@ static void isolate_freepages(struct compact_c=
ontrol *cc)
>>   	unsigned long isolate_start_pfn; /* exact pfn we start at */
>>   	unsigned long block_end_pfn;	/* end of current pageblock */
>>   	unsigned long low_pfn;	     /* lowest pfn scanner is able to scan *=
/
>> -	struct list_head *freelist =3D &cc->freepages;
>>   	unsigned int stride;
>> +	LIST_HEAD(freelist);
>>    	/* Try a small search of the free lists for a candidate */
>>   	fast_isolate_freepages(cc);
>>   	if (cc->nr_freepages)
>> -		goto splitmap;
>> +		return;
>>    	/*
>>   	 * Initialise the free scanner. The starting point is where we last=

>> @@ -1708,7 +1748,8 @@ static void isolate_freepages(struct compact_con=
trol *cc)
>>    		/* Found a block suitable for isolating free pages from. */
>>   		nr_isolated =3D isolate_freepages_block(cc, &isolate_start_pfn,
>> -					block_end_pfn, freelist, stride, false);
>> +					block_end_pfn, &freelist, stride, false);
>> +		sort_free_pages(&freelist, cc->freepages);
>>    		/* Update the skip hint if the full pageblock was scanned */
>>   		if (isolate_start_pfn =3D=3D block_end_pfn)
>> @@ -1749,10 +1790,6 @@ static void isolate_freepages(struct compact_co=
ntrol *cc)
>>   	 * and the loop terminated due to isolate_start_pfn < low_pfn
>>   	 */
>>   	cc->free_pfn =3D isolate_start_pfn;
>> -
>> -splitmap:
>> -	/* __isolate_free_page() does not map the pages */
>> -	split_map_pages(freelist);
>>   }
>>    /*
>> @@ -1763,18 +1800,21 @@ static struct folio *compaction_alloc(struct f=
olio *src, unsigned long data)
>>   {
>>   	struct compact_control *cc =3D (struct compact_control *)data;
>>   	struct folio *dst;
>> +	int order =3D folio_order(src);
>>  -	if (list_empty(&cc->freepages)) {
>> +	if (!cc->freepages[order].nr_free) {
>>   		isolate_freepages(cc);
>> -
>> -		if (list_empty(&cc->freepages))
>> +		if (!cc->freepages[order].nr_free)
>>   			return NULL;
>>   	}
>>  -	dst =3D list_entry(cc->freepages.next, struct folio, lru);
>> +	dst =3D list_first_entry(&cc->freepages[order].pages, struct folio, =
lru);
>> +	cc->freepages[order].nr_free--;
>>   	list_del(&dst->lru);
>> -	cc->nr_freepages--;
>> -
>> +	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
>> +	if (order)
>> +		prep_compound_page(&dst->page, order);
>> +	cc->nr_freepages -=3D 1 << order;
>>   	return dst;
>>   }
>>  @@ -1786,9 +1826,34 @@ static struct folio *compaction_alloc(struct f=
olio *src, unsigned long data)
>>   static void compaction_free(struct folio *dst, unsigned long data)
>>   {
>>   	struct compact_control *cc =3D (struct compact_control *)data;
>> +	int order =3D folio_order(dst);
>> +	struct page *page =3D &dst->page;
>>  -	list_add(&dst->lru, &cc->freepages);
>> -	cc->nr_freepages++;
>> +	if (order) {
>> +		int i;
>> +
>> +		page[1].flags &=3D ~PAGE_FLAGS_SECOND;
>> +		for (i =3D 1; i < (1 << order); i++) {
>> +			page[i].mapping =3D NULL;
>> +			clear_compound_head(&page[i]);
>> +			page[i].flags &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
>> +		}
>> +
>> +	}
>> +	/* revert post_alloc_hook() operations */
>> +	page->mapping =3D NULL;
>> +	page->flags &=3D ~PAGE_FLAGS_CHECK_AT_PREP;
>> +	set_page_count(page, 0);
>> +	page_mapcount_reset(page);
>> +	reset_page_owner(page, order);
>> +	page_table_check_free(page, order);
>> +	arch_free_page(page, order);
>> +	set_page_private(page, order);
>> +	INIT_LIST_HEAD(&dst->lru);
>> +
>> +	list_add(&dst->lru, &cc->freepages[order].pages);
>> +	cc->freepages[order].nr_free++;
>> +	cc->nr_freepages +=3D 1 << order;
>>   }
>>    /* possible outcome of isolate_migratepages */
>> @@ -2412,6 +2477,7 @@ compact_zone(struct compact_control *cc, struct =
capture_control *capc)
>>   	const bool sync =3D cc->mode !=3D MIGRATE_ASYNC;
>>   	bool update_cached;
>>   	unsigned int nr_succeeded =3D 0;
>> +	int order;
>>    	/*
>>   	 * These counters track activities during zone compaction.  Initial=
ize
>> @@ -2421,7 +2487,10 @@ compact_zone(struct compact_control *cc, struct=
 capture_control *capc)
>>   	cc->total_free_scanned =3D 0;
>>   	cc->nr_migratepages =3D 0;
>>   	cc->nr_freepages =3D 0;
>> -	INIT_LIST_HEAD(&cc->freepages);
>> +	for (order =3D 0; order <=3D MAX_ORDER; order++) {
>> +		INIT_LIST_HEAD(&cc->freepages[order].pages);
>> +		cc->freepages[order].nr_free =3D 0;
>> +	}
>>   	INIT_LIST_HEAD(&cc->migratepages);
>>    	cc->migratetype =3D gfp_migratetype(cc->gfp_mask);
>> @@ -2607,7 +2676,7 @@ compact_zone(struct compact_control *cc, struct =
capture_control *capc)
>>   	 * so we don't leave any returned pages behind in the next attempt.=

>>   	 */
>>   	if (cc->nr_freepages > 0) {
>> -		unsigned long free_pfn =3D release_freepages(&cc->freepages);
>> +		unsigned long free_pfn =3D release_free_list(cc->freepages);
>>    		cc->nr_freepages =3D 0;
>>   		VM_BUG_ON(free_pfn =3D=3D 0);
>> @@ -2626,7 +2695,6 @@ compact_zone(struct compact_control *cc, struct =
capture_control *capc)
>>    	trace_mm_compaction_end(cc, start_pfn, end_pfn, sync, ret);
>>  -	VM_BUG_ON(!list_empty(&cc->freepages));
>>   	VM_BUG_ON(!list_empty(&cc->migratepages));
>>    	return ret;
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 8c90e966e9f8..f5c691bb5c1c 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -465,6 +465,11 @@ int split_free_page(struct page *free_page,
>>   /*
>>    * in mm/compaction.c
>>    */
>> +
>> +struct free_list {
>> +	struct list_head	pages;
>> +	unsigned long		nr_free;
>> +};
>>   /*
>>    * compact_control is used to track pages being migrated and the fre=
e pages
>>    * they are being migrated to during memory compaction. The free_pfn=
 starts
>> @@ -473,7 +478,7 @@ int split_free_page(struct page *free_page,
>>    * completes when free_pfn <=3D migrate_pfn
>>    */
>>   struct compact_control {
>> -	struct list_head freepages;	/* List of free pages to migrate to */
>> +	struct free_list freepages[MAX_ORDER + 1];	/* List of free pages to =
migrate to */
>>   	struct list_head migratepages;	/* List of pages being migrated */
>>   	unsigned int nr_freepages;	/* Number of isolated free pages */
>>   	unsigned int nr_migratepages;	/* Number of pages to migrate */


--
Best Regards,
Yan, Zi

--=_MailMate_16B02DBD-4F04-4193-8915-7FCC1EFDE83E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUIg5EPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUSZsP/jyM8M9gvRDEmYYyRErfHV4toEJj3WcVn/IH
mVDoXiZiYc7KzX8WlStx/lrh8ilDuBimF7350N8YIF2U6AOK/37Ja1I78vncxKMl
LgVGe34KQZX+2JlzNwmtJceNHX2wp0+0EiN7G/Bj38ANltWP9vlYghxhrITVniun
vvRm34wW5Jx5AtaXec56p9sDjOHHdW9d/+dPnUkqByrRl8B9wqPMocJWLI+MuZAp
Tn3nsV3pvg45KlfY7wwCELoPKsx6pxzTQigNSzjontZD14MGkz/DQ+UC2zL9Rp1H
PCGIwgb6PR+OIanZFnq0KH8lRWh0lay7+XoWbeY4CqQyX+9uLn9sGj7lbqx5LEVz
3woBblgrnWLFsdR6N++zyJP09JvefVm419h0xH07l/+MWGs0YrssD2vCuQkQO3KJ
2IiBPFhe/k6LMlaLafIhbhk9XuDM+LMcIEfUy/Acdq8dWzY1DXLuOUXHeXuxFLja
gvJdTBj5BHfFpOPGPN4YJHP7AXFUaBO6YIHJh5kBvuk6vt1jn2J7i3M3c5lWmUwW
JnqkseMGQcuRZB/uotrUG/0VoCW/sn01e8ZZtkgJ/uX7uuS1WcIKzJ5iMhfMp1jM
t14HaiRtImaVMtLBu9g5JJHeT2OnnPR3Nl7PqxnkGJTCVteX1W1N/UYR/NBdqwXw
TZjqbxBi
=e8y/
-----END PGP SIGNATURE-----

--=_MailMate_16B02DBD-4F04-4193-8915-7FCC1EFDE83E_=--
