Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363B37C8814
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 16:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjJMOvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 10:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjJMOvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 10:51:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FD095
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 07:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMpRIS2Lc4U6zz6N0zlYPnU4D9Mrttt2QmNgl+Z3QIEmyrwH1wQKTgvMzvf07Tb9u4J7G8XVQVkhoB8Bl0xbhd33ZLbANrtHv8Tf4KCFMOqXPcS6RJ1+/9Hn+GI8N7ulEo4vltsyg6uO2yuaj0d8h+IXZTFIUW+D4gS7eiDaKYNckYeB8snIz771O3t+Fd1d98wAR51Vv//3l6jPL5mHe2SQIW0+9fHWmkhc5X+7s8f+d22Q2Z/GUsyC5UOTV+pBuvzX6CqjlslYOn9bYZO6P/NL8CNgtH24IoPgAIZ/cSO1DCmPYZPXGqBBEPBcG74bke+3PVOtKTfmIbz0pBm+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2FFfnfc6CpZ3WZCFjjLdMSxgBGozlVdV4OH8dE/eog=;
 b=SripQFbrdyr83YOk8v+ZHPkCn7Ey4RvOXv2HQwsXRBjB3vt8fb8UohlKbe1ANeaWRdnT+g4VsoUGzoafGeXA4so3JDS7LexKg/j1H/dfVkxeB5fFEZ05ZN+kXCz29IhzbjsE5i5HFJSLft1QO405th1RScIlPXwRGK8NTCCJxGztNCqE59X/G3VWZa7D/AprxLgj5AhPo+rj5V+wfgPsd6w7u5HSVtsPViEnPAoow86xjQ7FGWy93XQgItjGJkyuwIkVwpKmTuJrVMu93CYGrf+9IorDnuBBXEJ+lVRIoBrJQ+ZogxnxcUXif35c0IIyQqXX68fraeGdjc90sSDhJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2FFfnfc6CpZ3WZCFjjLdMSxgBGozlVdV4OH8dE/eog=;
 b=V0seaavpQxR28hM6kmQsvp21NNPwTP27MJNK36c33mzHDxdo044YEvFwvWf+wlmgQHpSLq3kgWfZPuGbb+9AKpWTGKkXrEybmnKdOoPoCPVXGCwxuFa3NABGpZHIyUd4WuS+GwR9QHCja4GpSLJiT5uiLuqgEeJv/b5u81w7mZxSOThhXJUsC2zyFwxujT48U6EwoTXdRrcZn9mMSVEYlkTlwRkS1uP+6wR9pbopNiZsXmJa1+uLcIwqv/tbfptxSVoTUVPS2NJhxy8SHp5dIv+Iq6nhVyFFUyCQZoqQxdGvHRrR2Kte68jn5N8vhY+YM1hGuJaGKsVNvtN9q9/cIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 14:51:26 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 14:51:26 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Date:   Fri, 13 Oct 2023 10:51:24 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <43350F6E-E56D-41C8-8441-A96D83B7D7C1@nvidia.com>
In-Reply-To: <D6A142AB-08F6-4335-8D08-1743DFAAD10C@nvidia.com>
References: <20230920134811.GB124289@cmpxchg.org>
 <20230920160400.GC124289@cmpxchg.org>
 <762CA634-053A-41DD-8ED7-895374640858@nvidia.com>
 <D4F59724-61EB-4DA5-94DF-59E79F0F1FB3@nvidia.com>
 <505e7f55-f63a-b33d-aa10-44de16d2d3cc@redhat.com>
 <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
 <92AE29D4-E715-447C-AF99-ECF42383C74D@nvidia.com>
 <20230926173939.GA348484@cmpxchg.org>
 <0D2BD71D-5E65-4175-8872-5E70278C57DA@nvidia.com>
 <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
 <20231010211200.GA129823@cmpxchg.org>
 <D6A142AB-08F6-4335-8D08-1743DFAAD10C@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_5FD2B4C1-3442-4224-A04B-A3FF4E9722BC_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR19CA0016.namprd19.prod.outlook.com
 (2603:10b6:208:178::29) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: c74df89b-9492-4e31-23a7-08dbcbfbe033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYZBRqkGcaO/xzJuLJpK9QqLgVX8iJLReLKJ/SDn8ixj1mBhmdPSo1KrOL4Bt77eI1hF9xitOH1ST49aZgFMrS6tXQ8jIfOsbMtt3R1rdjLOn0tZIFYZiN90Mipuy4NKcX0fvfLoUufMrtJRPBjGBM17fSg6+uqWQTRZvUFSu/cXzEaB+cQzwo+ILZAOF/0re3rCs0Cy3aqFXtBnQsXNijOxd15VY/yq8CPdn8z1ePzxJ91SYNxGApeyhsqXcazhWXVco0ms83Gu2teraMtIZmzTGZl6YjyCufpWhLCcwNeKDZZKTfhRS0eTcnvhQOBLce6Y5CUrjwtbOS6IySuaQvgV+Vtt2LRdXSwsZZKd+OPWVPWSYC9xh6xAEAU5H0qVl+kdKzXUdDEY6t0865Q7XeNV1IFqY8wtoBosk2cWDh48ymjjFQF3dxJ/65v6JlATWz/tmuokrgYn8Prs6Wq6aFdrRK3u8kg7R88tJarYV/kzD2S3CXDOHmlD8n9DA4sN5DSlgVs5Ceo35wAo6171Dd1JMJcBCs/5stwGkPUfUygh4J3jwM3kIJ7quZOWZJodd3XuALvpcZt6gFn8ZVZzK1wjCFB3M8ARLApMP/ylD2OTzxvj4qNa+AMqQuJdgRc7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(6506007)(36756003)(83380400001)(66556008)(66946007)(54906003)(66476007)(316002)(6916009)(86362001)(6512007)(53546011)(38100700002)(2616005)(33656002)(6486002)(478600001)(2906002)(235185007)(7416002)(5660300002)(8936002)(8676002)(4326008)(41300700001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MImkBU/G6DmlgoDMB59ZJzg5jmhjYLSpZ3Qktt4zC48fD2b98NqfPFibKpMy?=
 =?us-ascii?Q?iz4VddEp9u/Bf+LupoEyQvzBwwRfDbrnHIg0bKNeyh9bt3WMrgSo8dxENE/G?=
 =?us-ascii?Q?WdYXRfs0Udg8U4OoXQChMd2U6bR7/CZ6RrzjCX88KMeVtU0hcFBSygybkUQY?=
 =?us-ascii?Q?EdJj1GjmUqcb0RzVowxwTFtg/aprSefP+3pnQhLfJ/assrMQCbk4RXLcKFVG?=
 =?us-ascii?Q?ouGOPwZnn9VBRpMCScgrqPeK95g2bIKF/UnqkFcuNfT740bAyxJF3QHs5qpY?=
 =?us-ascii?Q?dZ/9i+RSw/ltqXT40BGIIjIS8+KOXlZ2/yLzaYKVc5gKtQA5E2QtMcMCBTZv?=
 =?us-ascii?Q?guOZSGrMHFhqnIm3qrF8eeJSliuajgX0XHHuBzYmPFsLSVcc8PMFan58GELO?=
 =?us-ascii?Q?WBjqn+HG5cprYxUKeMTGIHC6U+j3TFVWZmPkYKW3pGw/0T2HzgbKsYrXFY8p?=
 =?us-ascii?Q?huhE+WeLwmblo9JwRbAMqkFPG4wNMW4karjOcBRfza9eDmEtkKcd7g0YgU4M?=
 =?us-ascii?Q?kLanVMg7WRsUesm16+Lt1bQhmBrMbGIlhCzfYAh+pEkzu355uzlDcz3HWTPO?=
 =?us-ascii?Q?hchdDs7CX9E82ItpeQAtQ3V8Pw+eAQ7YcE4HJBoWiNWE9yd+ts7L28lzlMb7?=
 =?us-ascii?Q?22dBAqO1bgaZ6Bhnv2/oYbn0xKPGrdr2gKCqTwEWaq7atmXoi9QirlxHCWoN?=
 =?us-ascii?Q?/+SX4UBhQbq8iZ9irQOkKHImIneQytkqCVpyqBdfBK3lk9WclzcMb/+gJJv/?=
 =?us-ascii?Q?3Tl28idjergzIUsvaVvaapXCfK2zZj7UI6UDQcc98FbMhYsr+JeGrKwjiutS?=
 =?us-ascii?Q?sy1amcvNFNcyb9pfMcEAbfKLnLkS8+qMnkAnaPPSeiKDpkVNy7Qp4LDP4KHs?=
 =?us-ascii?Q?VzHcxORYqKYciKWIeOy0uqZe1UQ3kh+DW0VrReBPSBMPCOycA8kFRn0bEfBl?=
 =?us-ascii?Q?6vlHw4WTlelqxqewUFeSfWAsZhuVF3WGN7ieD0RRMh9NKqOUljS6IiMjzbXr?=
 =?us-ascii?Q?NBk+8qawamWhw0aCSrd4mzveYKJny3rcVM6LkqONoDZoGwpsTp9bsGBiTcQW?=
 =?us-ascii?Q?HKgPilE1Qj/AeuLTm7lwofWWcF+0uPG9zdzG/vmQAd4cts2SRPp7U9/0VnMp?=
 =?us-ascii?Q?zBJdApcIIL44mWV4QMR8+3B9PJJZX9MXRi0EbdYllh5TDCmXobmxQjWYvFS0?=
 =?us-ascii?Q?L0noy8ba1uaeAjQlk+lHGDAmGVtwDPmfmkj57x1myoYFl5G4qBoFHsH7F0nu?=
 =?us-ascii?Q?WRNT6VWeBFcIy0d4bMO/v3fUp0ZQsj8Xqr4nJyZUpHOunBrWJ1Jg/op2Lye2?=
 =?us-ascii?Q?14spDBcdYdyn3UCc7zdYFotk6V6lO8eVivwrE53Snpq0/JTt2Io1YDuNfkor?=
 =?us-ascii?Q?k3UEytratijrCfEizgRIqn84Jknafpi2GAl34WShuu3/05IZ43ToK1TGLMrY?=
 =?us-ascii?Q?Q+FotRqW6qXJMEhKvKOmcevxfjLVFV1S7SAiImC/8f+BQI11KeEZNKs7sWlI?=
 =?us-ascii?Q?CMGdEt1HJYBkS+RmmRUCWPKVqZpI3O+/Shpj+lzGITx25Wj563uYN5T7io93?=
 =?us-ascii?Q?CC9hPqtFysGK11azDr8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74df89b-9492-4e31-23a7-08dbcbfbe033
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 14:51:26.3270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNBxbPHLw4wVZnkLLG8ZptQqcwEBGQz0JsSeDjjkGuKPP1lQj1TsTjultWdckndF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_5FD2B4C1-3442-4224-A04B-A3FF4E9722BC_=
Content-Type: multipart/mixed;
 boundary="=_MailMate_39585EC8-DEED-4F74-A86C-CCAE98F42442_="


--=_MailMate_39585EC8-DEED-4F74-A86C-CCAE98F42442_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 12 Oct 2023, at 20:06, Zi Yan wrote:

> On 10 Oct 2023, at 17:12, Johannes Weiner wrote:
>
>> Hello!
>>
>> On Mon, Oct 02, 2023 at 10:26:44PM -0400, Zi Yan wrote:
>>> On 27 Sep 2023, at 22:51, Zi Yan wrote:
>>> I attached my revised patch 2 and 3 (with all the suggestions above).=

>>
>> Thanks! It took me a bit to read through them. It's a tricky codebase!=

>>
>> Some comments below.
>>
>>> From 1c8f99cff5f469ee89adc33e9c9499254cad13f2 Mon Sep 17 00:00:00 200=
1
>>> From: Zi Yan <ziy@nvidia.com>
>>> Date: Mon, 25 Sep 2023 16:27:14 -0400
>>> Subject: [PATCH v2 1/2] mm: set migratetype after free pages are move=
d between
>>>  free lists.
>>>
>>> This avoids changing migratetype after move_freepages() or
>>> move_freepages_block(), which is error prone. It also prepares for up=
coming
>>> changes to fix move_freepages() not moving free pages partially in th=
e
>>> range.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>
>> This is great and indeed makes the callsites much simpler. Thanks,
>> I'll fold this into the series.
>>
>>> @@ -1597,9 +1615,29 @@ static int move_freepages(struct zone *zone, u=
nsigned long start_pfn,
>>>  			  unsigned long end_pfn, int old_mt, int new_mt)
>>>  {
>>>  	struct page *page;
>>> -	unsigned long pfn;
>>> +	unsigned long pfn, pfn2;
>>>  	unsigned int order;
>>>  	int pages_moved =3D 0;
>>> +	unsigned long mt_changed_pfn =3D start_pfn - pageblock_nr_pages;
>>> +	unsigned long new_start_pfn =3D get_freepage_start_pfn(start_pfn);
>>> +
>>> +	/* split at start_pfn if it is in the middle of a free page */
>>> +	if (new_start_pfn !=3D start_pfn && PageBuddy(pfn_to_page(new_start=
_pfn))) {
>>> +		struct page *new_page =3D pfn_to_page(new_start_pfn);
>>> +		int new_page_order =3D buddy_order(new_page);
>>
>> get_freepage_start_pfn() returns start_pfn if it didn't find a large
>> buddy, so the buddy check shouldn't be necessary, right?
>>
>>> +		if (new_start_pfn + (1 << new_page_order) > start_pfn) {
>>
>> This *should* be implied according to the comments on
>> get_freepage_start_pfn(), but it currently isn't. Doing so would help
>> here, and seemingly also in alloc_contig_range().
>>
>> How about this version of get_freepage_start_pfn()?
>>
>> /*
>>  * Scan the range before this pfn for a buddy that straddles it
>>  */
>> static unsigned long find_straddling_buddy(unsigned long start_pfn)
>> {
>> 	int order =3D 0;
>> 	struct page *page;
>> 	unsigned long pfn =3D start_pfn;
>>
>> 	while (!PageBuddy(page =3D pfn_to_page(pfn))) {
>> 		/* Nothing found */
>> 		if (++order > MAX_ORDER)
>> 			return start_pfn;
>> 		pfn &=3D ~0UL << order;
>> 	}
>>
>> 	/*
>> 	 * Found a preceding buddy, but does it straddle?
>> 	 */
>> 	if (pfn + (1 << buddy_order(page)) > start_pfn)
>> 		return pfn;
>>
>> 	/* Nothing found */
>> 	return start_pfn;
>> }
>>
>>> @@ -1614,10 +1652,43 @@ static int move_freepages(struct zone *zone, =
unsigned long start_pfn,
>>>
>>>  		order =3D buddy_order(page);
>>>  		move_to_free_list(page, zone, order, old_mt, new_mt);
>>> +		/*
>>> +		 * set page migratetype 1) only after we move all free pages in
>>> +		 * one pageblock and 2) for all pageblocks within the page.
>>> +		 *
>>> +		 * for 1), since move_to_free_list() checks page migratetype with
>>> +		 * old_mt and changing one page migratetype affects all pages
>>> +		 * within the same pageblock, if we are moving more than
>>> +		 * one free pages in the same pageblock, setting migratetype
>>> +		 * right after first move_to_free_list() triggers the warning
>>> +		 * in the following move_to_free_list().
>>> +		 *
>>> +		 * for 2), when a free page order is greater than pageblock_order,=

>>> +		 * all pageblocks within the free page need to be changed after
>>> +		 * move_to_free_list().
>>
>> I think this can be somewhat simplified.
>>
>> There are two assumptions we can make. Buddies always consist of 2^n
>> pages. And buddies and pageblocks are naturally aligned. This means
>> that if this pageblock has the start of a buddy that straddles into
>> the next pageblock(s), it must be the first page in the block. That in=

>> turn means we can move the handling before the loop.
>>
>> If we split first, it also makes the loop a little simpler because we
>> know that any buddies that start inside this block cannot extend
>> beyond it (due to the alignment). The loop how it was originally
>> written can remain untouched.
>>
>>> +		 */
>>> +		if (pfn + (1 << order) > pageblock_end_pfn(pfn)) {
>>> +			for (pfn2 =3D pfn;
>>> +			     pfn2 < min_t(unsigned long,
>>> +					  pfn + (1 << order),
>>> +					  end_pfn + 1);
>>> +			     pfn2 +=3D pageblock_nr_pages) {
>>> +				set_pageblock_migratetype(pfn_to_page(pfn2),
>>> +							  new_mt);
>>> +				mt_changed_pfn =3D pfn2;
>>
>> Hm, this seems to assume that start_pfn to end_pfn can be more than
>> one block. Why is that? This function is only used on single blocks.
>
> You are right. I made unnecessary assumptions when I wrote the code.
>
>>
>>> +			}
>>> +			/* split the free page if it goes beyond the specified range */
>>> +			if (pfn + (1 << order) > (end_pfn + 1))
>>> +				split_free_page(page, order, end_pfn + 1 - pfn);
>>> +		}
>>>  		pfn +=3D 1 << order;
>>>  		pages_moved +=3D 1 << order;
>>>  	}
>>> -	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
>>> +	/* set migratetype for the remaining pageblocks */
>>> +	for (pfn2 =3D mt_changed_pfn + pageblock_nr_pages;
>>> +	     pfn2 <=3D end_pfn;
>>> +	     pfn2 +=3D pageblock_nr_pages)
>>> +		set_pageblock_migratetype(pfn_to_page(pfn2), new_mt);
>>
>> If I rework the code on the above, I'm arriving at the following:
>>
>> static int move_freepages(struct zone *zone, unsigned long start_pfn,
>> 			  unsigned long end_pfn, int old_mt, int new_mt)
>> {
>> 	struct page *start_page =3D pfn_to_page(start_pfn);
>> 	int pages_moved =3D 0;
>> 	unsigned long pfn;
>>
>> 	VM_WARN_ON(start_pfn & (pageblock_nr_pages - 1));
>> 	VM_WARN_ON(start_pfn + pageblock_nr_pages - 1 !=3D end_pfn);
>>
>> 	/*
>> 	 * A free page may be comprised of 2^n blocks, which means our
>> 	 * block of interest could be head or tail in such a page.
>> 	 *
>> 	 * If we're a tail, update the type of our block, then split
>> 	 * the page into pageblocks. The splitting will do the leg
>> 	 * work of sorting the blocks into the right freelists.
>> 	 *
>> 	 * If we're a head, split the page into pageblocks first. This
>> 	 * ensures the migratetypes still match up during the freelist
>> 	 * removal. Then do the regular scan for buddies in the block
>> 	 * of interest, which will handle the rest.
>> 	 *
>> 	 * In theory, we could try to preserve 2^1 and larger blocks
>> 	 * that lie outside our range. In practice, MAX_ORDER is
>> 	 * usually one or two pageblocks anyway, so don't bother.
>> 	 *
>> 	 * Note that this only applies to page isolation, which calls
>> 	 * this on random blocks in the pfn range! When we move stuff
>> 	 * from inside the page allocator, the pages are coming off
>> 	 * the freelist (can't be tail) and multi-block pages are
>> 	 * handled directly in the stealing code (can't be a head).
>> 	 */
>>
>> 	/* We're a tail */
>> 	pfn =3D find_straddling_buddy(start_pfn);
>> 	if (pfn !=3D start_pfn) {
>> 		struct page *free_page =3D pfn_to_page(pfn);
>>
>> 		set_pageblock_migratetype(start_page, new_mt);
>> 		split_free_page(free_page, buddy_order(free_page),
>> 				pageblock_nr_pages);
>> 		return pageblock_nr_pages;
>> 	}
>>
>> 	/* We're a head */
>> 	if (PageBuddy(start_page) && buddy_order(start_page) > pageblock_orde=
r)
>> 		split_free_page(start_page, buddy_order(start_page),
>> 				pageblock_nr_pages);
>
> This actually can be:
>
> /* We're a head */
> if (PageBuddy(start_page) && buddy_order(start_page) > pageblock_order)=
 {
>         set_pageblock_migratetype(start_page, new_mt);
>         split_free_page(start_page, buddy_order(start_page),
>                         pageblock_nr_pages);
>         return pageblock_nr_pages;
> }
>
>
>>
>> 	/* Move buddies within the block */
>> 	while (pfn <=3D end_pfn) {
>> 		struct page *page =3D pfn_to_page(pfn);
>> 		int order, nr_pages;
>>
>> 		if (!PageBuddy(page)) {
>> 			pfn++;
>> 			continue;
>> 		}
>>
>> 		/* Make sure we are not inadvertently changing nodes */
>> 		VM_BUG_ON_PAGE(page_to_nid(page) !=3D zone_to_nid(zone), page);
>> 		VM_BUG_ON_PAGE(page_zone(page) !=3D zone, page);
>>
>> 		order =3D buddy_order(page);
>> 		nr_pages =3D 1 << order;
>>
>> 		move_to_free_list(page, zone, order, old_mt, new_mt);
>>
>> 		pfn +=3D nr_pages;
>> 		pages_moved +=3D nr_pages;
>> 	}
>>
>> 	set_pageblock_migratetype(start_page, new_mt);
>>
>> 	return pages_moved;
>> }
>>
>> Does this look reasonable to you?
>
> Looks good to me. Thanks.
>
>>
>> Note that the page isolation specific stuff comes first. If this code
>> holds up, we should be able to move it to page-isolation.c and keep it=

>> out of the regular allocator path.
>
> You mean move the tail and head part to set_migratetype_isolate()?
> And change move_freepages_block() to separate prep_move_freepages_block=
(),
> the tail and head code, and move_freepages()? It should work and looks
> like a similar code pattern as steal_suitable_fallback().

The attached patch has all the suggested changes, let me know how it
looks to you. Thanks.

--
Best Regards,
Yan, Zi

--=_MailMate_39585EC8-DEED-4F74-A86C-CCAE98F42442_=
Content-Disposition: attachment;
 filename=0001-mm-page_isolation-split-cross-pageblock-free-pages-d.patch
Content-ID: <D2E8F3DF-29DB-4C4D-8760-FF7CC96DDFF4@nvidia.com>
Content-Type: text/plain;
 name=0001-mm-page_isolation-split-cross-pageblock-free-pages-d.patch
Content-Transfer-Encoding: quoted-printable

=46rom 32e7aefe352785b29b31b72ce0bb8b4e608860ca Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 25 Sep 2023 16:55:18 -0400
Subject: [PATCH] mm/page_isolation: split cross-pageblock free pages duri=
ng
 isolation

alloc_contig_range() uses set_migrateype_isolate(), which eventually call=
s
move_freepages(), to isolate free pages. But move_freepages() was not abl=
e
to move free pages partially covered by the specified range, leaving a ra=
ce
window open[1]. Fix it by splitting such pages before calling
move_freepages().

A common code to find the start pfn of a free page straddling a given pfn=

is refactored in find_straddling_buddy().

[1] https://lore.kernel.org/linux-mm/20230920160400.GC124289@cmpxchg.org/=


Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page-isolation.h |  7 +++
 mm/page_alloc.c                | 94 ++++++++++++++++++++--------------
 mm/page_isolation.c            | 90 ++++++++++++++++++++------------
 3 files changed, 121 insertions(+), 70 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolatio=
n.h
index 901915747960..4873f1a41792 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -34,8 +34,15 @@ static inline bool is_migrate_isolate(int migratetype)=

 #define REPORT_FAILURE	0x2
 =

 void set_pageblock_migratetype(struct page *page, int migratetype);
+unsigned long find_straddling_buddy(unsigned long start_pfn);
 int move_freepages_block(struct zone *zone, struct page *page,
 			 int old_mt, int new_mt);
+bool prep_move_freepages_block(struct zone *zone, struct page *page,
+				      unsigned long *start_pfn,
+				      unsigned long *end_pfn,
+				      int *num_free, int *num_movable);
+int move_freepages(struct zone *zone, unsigned long start_pfn,
+			  unsigned long end_pfn, int old_mt, int new_mt);
 =

 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_=
pfn,
 			     int migratetype, int flags, gfp_t gfp_flags);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 928bb595d7cc..74831a86f41d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -865,15 +865,15 @@ int split_free_page(struct page *free_page,
 	struct zone *zone =3D page_zone(free_page);
 	unsigned long free_page_pfn =3D page_to_pfn(free_page);
 	unsigned long pfn;
-	unsigned long flags;
 	int free_page_order;
 	int mt;
 	int ret =3D 0;
 =

-	if (split_pfn_offset =3D=3D 0)
-		return ret;
+	/* zone lock should be held when this function is called */
+	lockdep_assert_held(&zone->lock);
 =

-	spin_lock_irqsave(&zone->lock, flags);
+	if (split_pfn_offset =3D=3D 0 || split_pfn_offset >=3D (1 << order))
+		return ret;
 =

 	if (!PageBuddy(free_page) || buddy_order(free_page) !=3D order) {
 		ret =3D -ENOENT;
@@ -899,7 +899,6 @@ int split_free_page(struct page *free_page,
 			split_pfn_offset =3D (1UL << order) - (pfn - free_page_pfn);
 	}
 out:
-	spin_unlock_irqrestore(&zone->lock, flags);
 	return ret;
 }
 /*
@@ -1588,21 +1587,52 @@ static inline struct page *__rmqueue_cma_fallback=
(struct zone *zone,
 					unsigned int order) { return NULL; }
 #endif
 =

+/*
+ * Scan the range before this pfn for a buddy that straddles it
+ */
+unsigned long find_straddling_buddy(unsigned long start_pfn)
+{
+	int order =3D 0;
+	struct page *page;
+	unsigned long pfn =3D start_pfn;
+
+	while (!PageBuddy(page =3D pfn_to_page(pfn))) {
+		/* Nothing found */
+		if (++order > MAX_ORDER)
+			return start_pfn;
+		pfn &=3D ~0UL << order;
+	}
+
+	/*
+	 * Found a preceding buddy, but does it straddle?
+	 */
+	if (pfn + (1 << buddy_order(page)) > start_pfn)
+		return pfn;
+
+	/* Nothing found */
+	return start_pfn;
+}
+
 /*
  * Move the free pages in a range to the freelist tail of the requested =
type.
  * Note that start_page and end_pages are not aligned on a pageblock
  * boundary. If alignment is required, use move_freepages_block()
  */
-static int move_freepages(struct zone *zone, unsigned long start_pfn,
+int move_freepages(struct zone *zone, unsigned long start_pfn,
 			  unsigned long end_pfn, int old_mt, int new_mt)
 {
-	struct page *page;
-	unsigned long pfn;
-	unsigned int order;
+	struct page *start_page =3D pfn_to_page(start_pfn);
 	int pages_moved =3D 0;
+	unsigned long pfn =3D start_pfn;
+
+	VM_WARN_ON(start_pfn & (pageblock_nr_pages - 1));
+	VM_WARN_ON(start_pfn + pageblock_nr_pages - 1 !=3D end_pfn);
+
+	/* Move buddies within the block */
+	while (pfn <=3D end_pfn) {
+		struct page *page =3D pfn_to_page(pfn);
+		int order, nr_pages;
 =

-	for (pfn =3D start_pfn; pfn <=3D end_pfn;) {
-		page =3D pfn_to_page(pfn);
 		if (!PageBuddy(page)) {
 			pfn++;
 			continue;
@@ -1613,16 +1643,20 @@ static int move_freepages(struct zone *zone, unsi=
gned long start_pfn,
 		VM_BUG_ON_PAGE(page_zone(page) !=3D zone, page);
 =

 		order =3D buddy_order(page);
+		nr_pages =3D 1 << order;
+
 		move_to_free_list(page, zone, order, old_mt, new_mt);
-		pfn +=3D 1 << order;
-		pages_moved +=3D 1 << order;
+
+		pfn +=3D nr_pages;
+		pages_moved +=3D nr_pages;
 	}
-	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
+
+	set_pageblock_migratetype(start_page, new_mt);
 =

 	return pages_moved;
 }
 =

-static bool prep_move_freepages_block(struct zone *zone, struct page *pa=
ge,
+bool prep_move_freepages_block(struct zone *zone, struct page *page,
 				      unsigned long *start_pfn,
 				      unsigned long *end_pfn,
 				      int *num_free, int *num_movable)
@@ -6138,7 +6172,6 @@ int alloc_contig_range(unsigned long start, unsigne=
d long end,
 		       unsigned migratetype, gfp_t gfp_mask)
 {
 	unsigned long outer_start, outer_end;
-	int order;
 	int ret =3D 0;
 =

 	struct compact_control cc =3D {
@@ -6212,28 +6245,13 @@ int alloc_contig_range(unsigned long start, unsig=
ned long end,
 	 * isolated thus they won't get removed from buddy.
 	 */
 =

-	order =3D 0;
-	outer_start =3D start;
-	while (!PageBuddy(pfn_to_page(outer_start))) {
-		if (++order > MAX_ORDER) {
-			outer_start =3D start;
-			break;
-		}
-		outer_start &=3D ~0UL << order;
-	}
-
-	if (outer_start !=3D start) {
-		order =3D buddy_order(pfn_to_page(outer_start));
-
-		/*
-		 * outer_start page could be small order buddy page and
-		 * it doesn't include start page. Adjust outer_start
-		 * in this case to report failed page properly
-		 * on tracepoint in test_pages_isolated()
-		 */
-		if (outer_start + (1UL << order) <=3D start)
-			outer_start =3D start;
-	}
+	/*
+	 * outer_start page could be small order buddy page and it doesn't
+	 * include start page. outer_start is set to start in
+	 * find_straddling_buddy() to report failed page properly on tracepoint=

+	 * in test_pages_isolated()
+	 */
+	outer_start =3D find_straddling_buddy(start);
 =

 	/* Make sure the range is really isolated. */
 	if (test_pages_isolated(outer_start, end, 0)) {
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 5f8c658c0853..c6a4e02ed588 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -178,15 +178,61 @@ static int set_migratetype_isolate(struct page *pag=
e, int migratetype, int isol_
 	unmovable =3D has_unmovable_pages(check_unmovable_start, check_unmovabl=
e_end,
 			migratetype, isol_flags);
 	if (!unmovable) {
-		int nr_pages;
 		int mt =3D get_pageblock_migratetype(page);
+		unsigned long start_pfn, end_pfn, free_page_pfn;
+		struct page *start_page;
 =

-		nr_pages =3D move_freepages_block(zone, page, mt, MIGRATE_ISOLATE);
 		/* Block spans zone boundaries? */
-		if (nr_pages =3D=3D -1) {
+		if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn, NULL,=
 NULL)) {
 			spin_unlock_irqrestore(&zone->lock, flags);
 			return -EBUSY;
 		}
+
+		/*
+		 * A free page may be comprised of 2^n blocks, which means our
+		 * block of interest could be head or tail in such a page.
+		 *
+		 * If we're a tail, update the type of our block, then split
+		 * the page into pageblocks. The splitting will do the leg
+		 * work of sorting the blocks into the right freelists.
+		 *
+		 * If we're a head, split the page into pageblocks first. This
+		 * ensures the migratetypes still match up during the freelist
+		 * removal. Then do the regular scan for buddies in the block
+		 * of interest, which will handle the rest.
+		 *
+		 * In theory, we could try to preserve 2^1 and larger blocks
+		 * that lie outside our range. In practice, MAX_ORDER is
+		 * usually one or two pageblocks anyway, so don't bother.
+		 *
+		 * Note that this only applies to page isolation, which calls
+		 * this on random blocks in the pfn range! When we move stuff
+		 * from inside the page allocator, the pages are coming off
+		 * the freelist (can't be tail) and multi-block pages are
+		 * handled directly in the stealing code (can't be a head).
+		 */
+		start_page =3D pfn_to_page(start_pfn);
+
+		free_page_pfn =3D find_straddling_buddy(start_pfn);
+		/*
+		 * 1) We're a tail: free_page_pfn !=3D start_pfn
+		 * 2) We're a head: free_page_pfn =3D=3D start_pfn &&
+		 *		    PageBuddy(start_page) &&
+		 *		    buddy_order(start_page) > pageblock_order
+		 *
+		 * In both cases, the free page needs to be split.
+		 */
+		if (free_page_pfn !=3D start_pfn ||
+		    (PageBuddy(start_page) &&
+		     buddy_order(start_page) > pageblock_order)) {
+			struct page *free_page =3D pfn_to_page(free_page_pfn);
+
+			set_pageblock_migratetype(start_page, MIGRATE_ISOLATE);
+			split_free_page(free_page, buddy_order(free_page),
+					pageblock_nr_pages);
+		} else
+			move_freepages(zone, start_pfn, end_pfn, mt, MIGRATE_ISOLATE);
+
 		zone->nr_isolate_pageblock++;
 		spin_unlock_irqrestore(&zone->lock, flags);
 		return 0;
@@ -380,11 +426,8 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, int flags,
 		if (PageBuddy(page)) {
 			int order =3D buddy_order(page);
 =

-			if (pfn + (1UL << order) > boundary_pfn) {
-				/* free page changed before split, check it again */
-				if (split_free_page(page, order, boundary_pfn - pfn))
-					continue;
-			}
+			VM_WARN_ONCE(pfn + (1UL << order) > boundary_pfn,
+				"a free page sits across isolation boundary");
 =

 			pfn +=3D 1UL << order;
 			continue;
@@ -408,8 +451,6 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, int flags,
 			 * can be migrated. Otherwise, fail the isolation.
 			 */
 			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
-				int order;
-				unsigned long outer_pfn;
 				int page_mt =3D get_pageblock_migratetype(page);
 				bool isolate_page =3D !is_migrate_isolate_page(page);
 				struct compact_control cc =3D {
@@ -427,9 +468,11 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, int flags,
 				/*
 				 * XXX: mark the page as MIGRATE_ISOLATE so that
 				 * no one else can grab the freed page after migration.
-				 * Ideally, the page should be freed as two separate
-				 * pages to be added into separate migratetype free
-				 * lists.
+				 * The page should be freed into separate migratetype
+				 * free lists, unless the free page order is greater
+				 * than pageblock order. It is not the case now,
+				 * since gigantic hugetlb is freed as order-0
+				 * pages and LRU pages do not cross pageblocks.
 				 */
 				if (isolate_page) {
 					ret =3D set_migratetype_isolate(page, page_mt,
@@ -451,25 +494,8 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, int flags,
 =

 				if (ret)
 					goto failed;
-				/*
-				 * reset pfn to the head of the free page, so
-				 * that the free page handling code above can split
-				 * the free page to the right migratetype list.
-				 *
-				 * head_pfn is not used here as a hugetlb page order
-				 * can be bigger than MAX_ORDER, but after it is
-				 * freed, the free page order is not. Use pfn within
-				 * the range to find the head of the free page.
-				 */
-				order =3D 0;
-				outer_pfn =3D pfn;
-				while (!PageBuddy(pfn_to_page(outer_pfn))) {
-					/* stop if we cannot find the free page */
-					if (++order > MAX_ORDER)
-						goto failed;
-					outer_pfn &=3D ~0UL << order;
-				}
-				pfn =3D outer_pfn;
+
+				pfn =3D head_pfn + nr_pages;
 				continue;
 			} else
 #endif
-- =

2.42.0


--=_MailMate_39585EC8-DEED-4F74-A86C-CCAE98F42442_=--

--=_MailMate_5FD2B4C1-3442-4224-A04B-A3FF4E9722BC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUpWWwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUsjsP/jwANgU/2QRMFotM4+nHCw4zoDs986ZOZ+fe
ztG71OAW50mVZtP3MF+5YjTLkv4/Fp/2wxsMC8wYIgmPoFnJ0+aPr8vkntgrF9VX
YqxSG5hzQWMp+O5CnMxsIb6klmOV+p/5KsNrTKp5ZThnK6gxivbB05I8WlL5UzIr
7NLxn9KIlZ9/68gJGOH2CfE2L/DXLD1YCCwH6KoYUDX+NIB0YpNu84SlWNCLDOjc
DuObqLUXfiQo8tj/5ptGKoKQ+xZ4KP9gMNWPHZLlar2o8Qb15cN/eFUEYgyqTjGY
uSvPCr7WYVty1/MKWKdC39y/95yrjJNBvddV0maHIBz9KPpQWJyPkgWlX8uh2lIO
z8sCrz7VX8EuN+E5fOt92igTTv+RKFcOt4LfVDE1SVCqWq/rH2IUr26/khQ8Nv8B
TcMnu7UBOGw5QlzbVBqTrmiDfxYNpTryVSPxb0RhfQZWkcU/IVx4djgKq6qIzLfQ
GHySkw7sB3/sVUAFi8Pm7W7zLODxVXusM9tuMn2+Owyu9Bfyk21SllSRCn1ZRB5P
ana13JRx34XUAFlBr3AlwbBdbLCi1/NYrbSYPvT7oXy5AZx9kNPz2Ea2luFuF8UK
/K/EjAULpQok7bN/6uuOdNyDtXsh5GHiho9GUJMEfx1fXgZ7mGTYEbfy5xTb4TrW
O/TTU/VY
=M57n
-----END PGP SIGNATURE-----

--=_MailMate_5FD2B4C1-3442-4224-A04B-A3FF4E9722BC_=--
