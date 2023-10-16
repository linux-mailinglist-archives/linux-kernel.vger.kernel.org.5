Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2A17CACBC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjJPPAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjJPPAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:00:40 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2077.outbound.protection.outlook.com [40.107.101.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B267EA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvIU8Wgw7TN/ZRRo/jw4i1TRNatLp4UC/8GWZxL57S9Ru0gnhaR8u3gvVReE27igBoDoW7kbuOPGYNJKoQIQxwHBf325jdEdDusSiFN/xZVapzO2VAQP1oZGW9VAuzMkUmoETWJ7MtDIC/yj+yqxcC7kKrMtsvyqWWGPJBmQQC95l9koiTkDAkPwJxYUhXi7sIcjE5t2Dr5W9ghlRPlF9e0pEa6fxu0ocjEaH6G9amYLL2k/+5PqINyDu2ZmfITGT9Dz+8FAD99bGo+bb0uMf9PaKYKph5C8bMg0GoSIW7f3mTe2umKiU8COAU0vMqU8Xqk4e+QlSOob+3FnZfRt+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njo2eUJsePtErG9DBXZ1GATvUh/SfuOwVE1oi/asRqU=;
 b=QSSYlNmDL3VDeKXkT4FG2DAe8amlaxcdN2QoeRiCqGAWeY68v4q/wvAyYRXVL7/C+AfA7tjCh7ebY4CDzTopkgzgAbcpHC3Efhg/WBmDIo9wnK99f66ZqTaBX5iuwXGOvZGo8BDN8L0rC6QwpNRx8l4S0N5sNJg6jHxetMivjAcY1JAkMXuHP5ouuP0K3RTb8Xsl5wD9IwT+6xoAEOmQZtqhfFdTnowYquAx+xssMIKnLLavlZgK2JUZx1xyLWul9ls8PWIjELLjlxJ9mO6k/Szkicw9PsFcf47nvu8zI/vKTK5kmhqJeqFl593BJ9z7nQavJkOmFAEuprttcC5/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njo2eUJsePtErG9DBXZ1GATvUh/SfuOwVE1oi/asRqU=;
 b=rO/J7UYtRrzb/4FKMHJjlpJDF55WTD3N4PSJpWZdSQts8tYZ6MZNJyWg7eIk5CBGBavTHlrmtjS+lipq9+N5AXdKNLb4ZZ/ZY6dLK+t3O1glJ+/EC3c2Csp9vIw6gx7ZVbm2g4SPr9/yL3O6ChqW8pUoNg4yltIQTDuRGJIJAuJzKwqfYgWp8PzBUlqJE9clhocQrDHNjf4du74qrfL1z2s8cPL5viG+VTWh9MN85LJtQKCRazpbGtxkszEdiZhz+IrTtM6u9pO0WlV0XzAiqQC9ZZktr4Q9WGzUKl6SrJmS6belNnOCT0SBKmqxSoWWEYVpwsKczGwsclr7TnKtCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 15:00:35 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:00:35 +0000
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
Date:   Mon, 16 Oct 2023 11:00:33 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <5B61B70F-E85D-4E6F-8856-17A90B899F98@nvidia.com>
In-Reply-To: <20231016143717.GH470544@cmpxchg.org>
References: <505e7f55-f63a-b33d-aa10-44de16d2d3cc@redhat.com>
 <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
 <92AE29D4-E715-447C-AF99-ECF42383C74D@nvidia.com>
 <20230926173939.GA348484@cmpxchg.org>
 <0D2BD71D-5E65-4175-8872-5E70278C57DA@nvidia.com>
 <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
 <20231010211200.GA129823@cmpxchg.org>
 <D6A142AB-08F6-4335-8D08-1743DFAAD10C@nvidia.com>
 <43350F6E-E56D-41C8-8441-A96D83B7D7C1@nvidia.com>
 <ED43DACB-C77F-40D3-8806-D3F26AD95E8D@nvidia.com>
 <20231016143717.GH470544@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_DCEA37A1-30FC-4B00-8E51-A4713C538391_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0162.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::17) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 7279c9e6-a3b4-47cc-d385-08dbce58a6f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQAHjPqrm8g9l9gYHET54wRdUHzhnH/9cnNLx6wxonnk6tQZ/tDWn005Vdm0e8X6WfbahreVqHXgm1uLZ1K1TrxPJPEjK3naq4MzAgdDr689z5bT3V2VfTzIh7vJnieTkzn/eTS95eVTrngp54GZrrbr7vjx86hjdjHNpZqLxuwyzLur4nJwaU8VelQw3p4Xf0P2bGhfELBI9vT/yLe2UvBfFxjR1H5Iru/n2L0p7uxjwmeBjlLZ9wRW41fMZlgarwza3xqmKIMfSpPr5au6V+EOipRf5nelWxOmC0jSgNTnNm0gysFbdb9NB5LOt9mOC+NAjUZxMlaKiICviqOD0udjxUvZhYg4MSv0XF8y2G+lQxXmQvEvV3Tv0pTDhLEiFNerNtSHa1j7hVK+pSX2bwXfht4/uVcJvYlRrQTemxm714tOPVBedwyF820F1nYl9Q7Z3ER0sYcfs47YCX0IOZsaG2t6/mkRKIeGpoKlci7CMl2C6Qj+61uC12/NDhnqBSXw1iC0Va3iSTSnPS11OCu9kn18HxgRy4BJ2LzzXjIms6CTl9LcB/Ist3kyjaVBL6PggEL1VZtpRYzM7s1kdCZ4j6V3Mtogm4d1i3om2UHva1+Me7bctlaGp51G1vxA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(36756003)(33656002)(66899024)(66556008)(66946007)(316002)(66476007)(54906003)(6916009)(86362001)(38100700002)(53546011)(83380400001)(2616005)(26005)(6512007)(6506007)(2906002)(6486002)(8936002)(478600001)(41300700001)(235185007)(7416002)(8676002)(5660300002)(4326008)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?81YgVZIsxAmKv+Gw2nY3Jpi7F22+jVYWmaWzVd+wf7TL/2UuLEm9Sshqhpga?=
 =?us-ascii?Q?fYMrdTpjfWNFDmc1OMo11pS0zo/AmiPPN8LskSYdSv3YrFUlebq9A+GaCHUF?=
 =?us-ascii?Q?bNf8Z61xJOBWJ8WlrxSGec3PNLmn4Ymbv6nsFw++m+3GC7OdB8ucxDq8J+60?=
 =?us-ascii?Q?zPLEnxRkKiixH3pT+wC6HU03PuWBYwdeT4yhzwtTfjs+zNGYUAs6NtGu7SwQ?=
 =?us-ascii?Q?jmQvoxLj0lF9je2GEftuy9ZgTfsQ3XdwfzE96xGvqQEcPcisxoIC9K9vysEc?=
 =?us-ascii?Q?rvQkO2hginS5fO6SWu+wvMUXILob8BCNUXkltyK0EzXRTCicJlSIuhTG3KPc?=
 =?us-ascii?Q?YOi24nltVDW16CX2FZwXqhcQBU9ogvzb9uipB9OXXvQ0AlTu9wvn3rx5L/Yz?=
 =?us-ascii?Q?k/aTrvp9TD0OmGfTQM6A/apJSiqipTmpNZxc/kksSVSvAUmIpMtQ2mj/ki7A?=
 =?us-ascii?Q?s2pahVoOTIlR9S4T2qs0PN1nmtHLIWl7Ied9FBx6KwoJphvbrf6XLBK0OlXO?=
 =?us-ascii?Q?Bi/TX30VCUQ+xK8qtfXXn61nYFZl0RNzo/GiKP/J0LCVbh7eWvADOg348yfv?=
 =?us-ascii?Q?g4eeY+nLYb8aXKG2pM++7U1KPh6R876TuqjbC+2YE7BNNwvIFYtrUVy1K/F4?=
 =?us-ascii?Q?u3w9+qhH8cfLSEiIHPWuq6V67SuTF7TRWJNvULP32FuX9jfoGn31YkHdMzyq?=
 =?us-ascii?Q?3LtBpyP1p0DE45MuyUOP3VkP7y1KJUsHmBLZnqA8Grw8hynPMzX8AzTL4hpm?=
 =?us-ascii?Q?jCNw8+aAf7kSDVuFfk3YzuNodJxqKiMedxP7Od4qar+/4KVuk1S+QO7uytrl?=
 =?us-ascii?Q?C3YKNCkhU/AZApfpHmYCG0wX/sbrBLLJW07PKRfHM7xETbCnWATGVMsWUdgj?=
 =?us-ascii?Q?Y1zSW5BJVJINTUpjyfiG3kApV0lUrhV7i2oUAI4QsYpZUX2FZqjxzsfsaC+u?=
 =?us-ascii?Q?oLyCmDvxGDU7jXccz/5zHzDS8ohtSdvKgzOoj9y+kOTqkCsXJP8Z3W4d6xiI?=
 =?us-ascii?Q?OLvMX4rk82rvdCYVgCgrZBsFgiNBXcC4Cv47Z2FLIIjzzoqy724WFGkrv/YO?=
 =?us-ascii?Q?mXmXJwTBeS6PxcbHZi6kkn/TvwBujE7riix57XlcRDtfiRLYZZfSuG5KgOew?=
 =?us-ascii?Q?Pt0DVRHv6CcKokvPjdEM9TjVV3hSYiOSYxOx962JP6p8NWcuSN6U1OYINpGZ?=
 =?us-ascii?Q?50HFG42r/KtlmIFCNriMhOYW56wIHZC+urwjAtNKmqFSN0Cj1QWo5p7nWyfK?=
 =?us-ascii?Q?MGurAWrdOBU22r5fhjIX17qTZI+23yJ2QqKdPAxiBKuWC2Y1wF+PUAI8PHhd?=
 =?us-ascii?Q?xxVlbwu+Lood3oP5396VlSRPn+7Kdg9gC/lhsFMsLtBGr3Kc7RWlj+GXWl7p?=
 =?us-ascii?Q?BoOPipD/yCgCcykNkQTmFZF1TSFrYfbvRtmyu6HhHzpL9V0VrwMqd79yn+RB?=
 =?us-ascii?Q?DYBVv3IjgI1b48C2fuAuIfn9LPmMwvvmYfyIOSjEdOhZlUYMU+9q3vrezJGe?=
 =?us-ascii?Q?YUp3+SM5bEviT0/vNmTeFCi4EdcJALC1b6treCwSLMAlgPh7OY+ftdr4Xl30?=
 =?us-ascii?Q?hooQhuA7sXw7IXY4xok=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7279c9e6-a3b4-47cc-d385-08dbce58a6f7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:00:35.8272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ne9VMlvPkGGAsQPBTYiN3SMEVBvGVdS2Bfx8WcPBpHtEZBdvjzg7anZzqqMKqQ6W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_DCEA37A1-30FC-4B00-8E51-A4713C538391_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 16 Oct 2023, at 10:37, Johannes Weiner wrote:

> On Mon, Oct 16, 2023 at 09:35:34AM -0400, Zi Yan wrote:
>>> The attached patch has all the suggested changes, let me know how it
>>> looks to you. Thanks.
>>
>> The one I sent has free page accounting issues. The attached one fixes=
 them.
>
> Do you still have the warnings? I wonder what went wrong.

No warnings. But something with the code:

1. in your version, split_free_page() is called without changing any page=
block
migratetypes, then split_free_page() is just a no-op, since the page is
just deleted from the free list, then freed via different orders. Buddy a=
llocator
will merge them back.

2. in my version, I set pageblock migratetype to new_mt before split_free=
_page(),
but it causes free page accounting issues, since in the case of head, fre=
e pages
are deleted from new_mt when they are in old_mt free list and the account=
ing
decreases new_mt free page number instead of old_mt one.

Basically, split_free_page() is awkward as it relies on preset migratetyp=
es,
which changes migratetypes without deleting the free pages from the list =
first.
That is why I came up with the new split_free_page() below.

>
>> @@ -883,6 +886,10 @@ int split_free_page(struct page *free_page,
>>  	mt =3D get_pfnblock_migratetype(free_page, free_page_pfn);
>>  	del_page_from_free_list(free_page, zone, order, mt);
>>
>> +	set_pageblock_migratetype(free_page, mt1);
>> +	set_pageblock_migratetype(pfn_to_page(free_page_pfn + split_pfn_offs=
et),
>> +				  mt2);
>> +
>>  	for (pfn =3D free_page_pfn;
>>  	     pfn < free_page_pfn + (1UL << order);) {
>>  		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
>
> I don't think this is quite right.
>
> With CONFIG_ARCH_FORCE_MAX_ORDER it's possible that we're dealing with
> a buddy that is more than two blocks:
>
> [pageblock 0][pageblock 1][pageblock 2][pageblock 3]
> [buddy                                             ]
>                                        [isolate range ..
>
> That for loop splits the buddy into 4 blocks. The code above would set
> pageblock 0 to old_mt, and pageblock 1 to new_mt. But it should only
> set pageblock 3 to new_mt.

OK. I think I need to fix split_free_page().

Hmm, if CONFIG_ARCH_FORCE_MAX_ORDER can make a buddy have more than one
pageblock and in turn makes an in-use page have more than one pageblock,
we will have problems. Since in isolate_single_pageblock(), an in-use pag=
e
can have part of its pageblock set to a different migratetype and be free=
d,
causing the free page with unmatched migratetypes. We might need to
free pages at pageblock_order if their orders are bigger than pageblock_o=
rder.

Which arch with CONFIG_ARCH_FORCE_MAX_ORDER can have a buddy containing m=
ore
than one pageblocks? I would like to make some tests.

>
> My proposal had the mt update in the caller:
>
>> @@ -139,6 +139,62 @@ static struct page *has_unmovable_pages(unsigned =
long start_pfn, unsigned long e
>>  	return NULL;
>>  }
>>
>> +/*
>> + * additional steps for moving free pages during page isolation
>> + */
>> +static int move_freepages_for_isolation(struct zone *zone, unsigned l=
ong start_pfn,
>> +			  unsigned long end_pfn, int old_mt, int new_mt)
>> +{
>> +	struct page *start_page =3D pfn_to_page(start_pfn);
>> +	unsigned long pfn;
>> +
>> +	VM_WARN_ON(start_pfn & (pageblock_nr_pages - 1));
>> +	VM_WARN_ON(start_pfn + pageblock_nr_pages - 1 !=3D end_pfn);
>> +
>> +	/*
>> +	 * A free page may be comprised of 2^n blocks, which means our
>> +	 * block of interest could be head or tail in such a page.
>> +	 *
>> +	 * If we're a tail, update the type of our block, then split
>> +	 * the page into pageblocks. The splitting will do the leg
>> +	 * work of sorting the blocks into the right freelists.
>> +	 *
>> +	 * If we're a head, split the page into pageblocks first. This
>> +	 * ensures the migratetypes still match up during the freelist
>> +	 * removal. Then do the regular scan for buddies in the block
>> +	 * of interest, which will handle the rest.
>> +	 *
>> +	 * In theory, we could try to preserve 2^1 and larger blocks
>> +	 * that lie outside our range. In practice, MAX_ORDER is
>> +	 * usually one or two pageblocks anyway, so don't bother.
>> +	 *
>> +	 * Note that this only applies to page isolation, which calls
>> +	 * this on random blocks in the pfn range! When we move stuff
>> +	 * from inside the page allocator, the pages are coming off
>> +	 * the freelist (can't be tail) and multi-block pages are
>> +	 * handled directly in the stealing code (can't be a head).
>> +	 */
>> +
>> +	/* We're a tail */
>> +	pfn =3D find_straddling_buddy(start_pfn);
>> +	if (pfn !=3D start_pfn) {
>> +		struct page *free_page =3D pfn_to_page(pfn);
>> +
>> +		split_free_page(free_page, buddy_order(free_page),
>> +				pageblock_nr_pages, old_mt, new_mt);
>> +		return pageblock_nr_pages;
>> +	}
>> +
>> +	/* We're a head */
>> +	if (PageBuddy(start_page) && buddy_order(start_page) > pageblock_ord=
er) {
>> +		split_free_page(start_page, buddy_order(start_page),
>> +				pageblock_nr_pages, new_mt, old_mt);
>> +		return pageblock_nr_pages;
>> +	}
>
> i.e. here ^: set the mt of the block that's in isolation range, then
> split the block.
>
> I think I can guess the warning you were getting: in the head case, we
> need to change the type of the head pageblock that's on the
> freelist. If we do it before calling split, the
> del_page_from_freelist() in there warns about the wrong type.
>
> How about pulling the freelist removal out of split_free_page()?
>
> 	del_page_from_freelist(huge_buddy);
> 	set_pageblock_migratetype(start_page, MIGRATE_ISOLATE);
> 	split_free_page(huge_buddy, buddy_order(), pageblock_nr_pages);
> 	return pageblock_nr_pages;

Yes, this is better. Let me change to this implementation.

But I would like to test it on an environment where a buddy contains more=
 than
one pageblocks first. I probably can change MAX_ORDER of x86_64 to do it =
locally.
I will report back.

--
Best Regards,
Yan, Zi

--=_MailMate_DCEA37A1-30FC-4B00-8E51-A4713C538391_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUtUBEPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUT3oP/jjZ9l7xbmy/NwpKXN67nHHdXmvU0Ekhuuwz
12bUxdX3l3hdBdrHpNH3//4n900Hgw1RIF7lKLyUzf0az9ENXkQtyJdBl8mjNlkl
8vLVWWLBTkZOmEokfIq+ae0bBcqsVNeNnQNr5gtn8yneb1w9qBNCNZMpV0kv/STO
VEWcwcLZcNy7yAYbNblHMNHo0chzauF605vpKkk5Hxg17XZn9C8L62KRQEnbBs0d
ihNDvTpHD7d4MFMnz6u/gNzaQ7/Ap5+S4gM2b6tphsnUgMAovJXESnf2mCVmDKMc
S8LV7vSxUtz3vHtZwxERiZW6jWgmD8/cwiINTYIw2HFtC4RJFP5oDFhZTeLMPuRJ
HW5Pu0z8AjNcZqSM53ZCy0bsVerMhc1Q3vW7WuLQMIq6mc1ARtoKocpZOhc5wSE5
3l68/Wulf1nF/shIDQMCB4gQqXtYEViKkT77ybto461jMtHYd9uHCd7RPBRp8Up6
RrYOLVUIDijD5B09mUjFbEIn5zqphCie6eGAre7iMu+NTlKjHfGoXsdFiAEgjwGl
EIkP4Hc8JpFmm3JoHmaZPivsFpabshQfu5g+SBTlo/x9xD6hyUpjepAGa17HOkth
A0DYdvgO40cY0b+UcN2WXgLUORRkGBXD7OzuAGTD7VNJbFoCjc/siSw5Q8l1d374
OjFBp7k4
=pauv
-----END PGP SIGNATURE-----

--=_MailMate_DCEA37A1-30FC-4B00-8E51-A4713C538391_=--
