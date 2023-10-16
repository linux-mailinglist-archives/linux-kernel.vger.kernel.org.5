Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F4C7CB37B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 21:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbjJPTuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 15:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbjJPTt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 15:49:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9409F
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 12:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmhpoLl424smsZ8huo4ykYjqbIngEwyOoPRAIamaTJHZCPWhWjswDXaNvoa7zhe+xbJ5zZOQy8vorCasAp+WZJD9ngHNUQfkAtm7JeZ8PsGeM60H/Bgef82oZGVuI9P1eWMmuf7BJ9/d0J/N2/VrjypupaIDScoNqLs35QKDN6mqJkAqFScNY/cRbCQAPggnSAf8pO7U5LAAXJqMqINHAAjteBHs9FFJWWy8lcTERQiHk6hjZJUeyCyIlPgjgPCSYzevIXYzI42+UCY5+g5ICWJmM8JKlhec4h4V1zQehwhxfQlLOsbNrI4zkz3DRw1nLHb872J+0rr5bI4Llamjqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GBIfXII0zd3jhXYuBApwlcUvOvw5ERKcNMxZdocntQ=;
 b=KMu80WzIgpf1tH/sPhU6Ru8m8m+Z+1S542UwEqDy1UNy8hrvPEQTY8DnORCZ/OoaD3afqYep5xyMwyfJLRxmbs0nN6JJ5MT7RbMzqbxxrdjDHfhaPtJvhXIzo5RgC1MblbnvkdAEB8Y9bprkYJvWdIBKKZskoLhfy75Tp+cM5j3q6C9m7P5+YAxLdvJl0pOa1Php0LkseNpoM+pLWvNFE4AE7gDofLTd6V1JtdcN9uhqlMLkaGL9F7UmkWFurpynLmV6m1PDxlKXKGiGfqzPree/h6Ko5j1YAGjkR+y2GY/gkMc1ci6u8gMzZZ2vdJKqA2S5gUCTh9W38MdgQdQR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GBIfXII0zd3jhXYuBApwlcUvOvw5ERKcNMxZdocntQ=;
 b=jEeMO8L24C8+raPlIboEMQeqW7W5Ec9C4UCU/DvmD+sd/37uhyHN8gHg1A/JJvuq417lgqtRR1ez1o5ffy6zkrY7iMo11rsLST110qUJtipBxD6QoYi1IfpfJH/gIfDSpQnmCiUslycYcL7Djp0bhediiL2SshYvyOkm48NGPDuJ7EvrI/FhJaGuGExcd/UxTBqtYPaX0rvhAGmTN28/kl5/wuHgGgRx28SiHUwX0QruMHlfo6lmZL1/eKIloIDxvpgXpj/F51pQ8LXWrmTOkfpHrB/4ZMyUgugNwukY/lPFn18t3t8ATUTHGH4kB0d/SlZWxInR47bFP/x8Cb4I8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB9163.namprd12.prod.outlook.com (2603:10b6:a03:559::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Mon, 16 Oct
 2023 19:49:52 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 19:49:52 +0000
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
Date:   Mon, 16 Oct 2023 15:49:49 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <6F2C52B6-2031-4694-A124-0DFDE9F88E88@nvidia.com>
In-Reply-To: <20231016185113.GI470544@cmpxchg.org>
References: <92AE29D4-E715-447C-AF99-ECF42383C74D@nvidia.com>
 <20230926173939.GA348484@cmpxchg.org>
 <0D2BD71D-5E65-4175-8872-5E70278C57DA@nvidia.com>
 <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
 <20231010211200.GA129823@cmpxchg.org>
 <D6A142AB-08F6-4335-8D08-1743DFAAD10C@nvidia.com>
 <43350F6E-E56D-41C8-8441-A96D83B7D7C1@nvidia.com>
 <ED43DACB-C77F-40D3-8806-D3F26AD95E8D@nvidia.com>
 <20231016143717.GH470544@cmpxchg.org>
 <5B61B70F-E85D-4E6F-8856-17A90B899F98@nvidia.com>
 <20231016185113.GI470544@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_67713C20-204D-4A8B-86F2-4C5F24BB1DC8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0388.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::33) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB9163:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e423cef-641e-4520-5b7b-08dbce811057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Igja+MpiI52co2DDuD+gf9HH+7IBKeB7lpFxoq6+HIUqaT/pJBxyPiejNa30u4U2P0nK8phvIypKXh8HjXnOjVy//ErkLoViK10wTyh3FfrH/b6NmDMmE2oG1140zpcbpvPTwe+mhpYzJtC9AoVfLBOhJenXkK08cmS0QSIiqPG0zF1mP4sPU/DV32taInkOrkCXbBXnqpQqFrNX8Uk038DP9v+Ffil3bOmgRNJN5z86f+uVKqbBCJPkrFYUCfX/ci7RS4HzFXp2cIohYEzp419jMbm3O8SJVE7HdKC/ljyBdxVgcHeGRA4HnnXoVIUc+cg6riW8wqjdiVh8WyhOPOFhiLJAh7EdosAPCv1Ve1lzTlNxnH5usrwLQo2a/F3mnf6vwxXqLyWtRCoCVwHeKP9+Wlvm5/qsl4y7bG/gXj2buzrlRaXlc9YlQeXZ2a5ZZ3mfGP4E4gQI5tJoB+Pb/l40zmSLaC/rvk5IdJb03Icvd+ghOvcjxujHrta5+vfSlzgg/xV2Sp+kuSQ1cJpUER9mcnUzfTDq3t+JBxWclROXGYd0bQVj8OI8aWX6ONLKqT+ewddoN/dZFQqwzzCbQ6Mr1TMM/iaOEXaFyedYgyLcFIGKBS7gKF5svk/tC1k7t6u9z14S3i0/Jepz3mmyBWJ6v84ewNdUJi3c1bSSwXIfe9yqyNsZw+SXAQffhkS1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66899024)(2616005)(53546011)(6512007)(36756003)(33656002)(86362001)(38100700002)(2906002)(83380400001)(26005)(7416002)(30864003)(8936002)(6506007)(478600001)(6486002)(6666004)(4326008)(8676002)(6916009)(316002)(54906003)(66946007)(235185007)(5660300002)(66476007)(41300700001)(66556008)(21314003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?//qiy2PO1et1rZrgBPBf4FYnthrxwyKab8YfuhO19X7/YB8SjxZVm86HgG/U?=
 =?us-ascii?Q?KEbcqJ3VTQFBx0/C1OJd1KNx8ualsXIQX5okG9qIEy5lqAYfahZIPZ3D7z8p?=
 =?us-ascii?Q?nwRFLKHCpLm2OCrXPt+GJUctyFmWXli3cTtmhj/0IczsmVvqmLmPpppsaBXO?=
 =?us-ascii?Q?PbRm8jVBGAl/TKWrAuODN3zMTyN2mTyck3EdQQsAcEOUDeIrhdgTiNCXgoQj?=
 =?us-ascii?Q?oD5iPni0dCm7+aEgtm4DYKHnIQytPXWLW4h7xu249wvXIX2oHNA57Zkkn5KU?=
 =?us-ascii?Q?qv2hEtlvW4pV+6wAmlyaIC73tys5ZSmDsgXtI2WkUUA6KPeD9o1c0a7Rk7Tc?=
 =?us-ascii?Q?2qTk7u2y4Zv9sultBKIrTkIsUIYWYknTOvwvyg9fZSNABbUhGWhaI2c7GgH8?=
 =?us-ascii?Q?pUd4yBohoV0d/mH7vj4b6R5skLBwmV1bZEbgaz4pSrQdWSVgHzPCGRRPpuJw?=
 =?us-ascii?Q?+2om7FsPpAdPItF/2ZsLjC1YbdKrKX9lb0N/uKRwRrsR6VN5m/wqDhRAMIE9?=
 =?us-ascii?Q?lljqFisXF85/CMJRE1X8EhrDbOZkCfbKFQMiV1kv/FUyxcCkjpL/a3X52JD2?=
 =?us-ascii?Q?BIfYxtCjCks2B64uaxDuit+dtCoEYtDnFPvA5pj1+S9XB8ZGsVoNRFlmKVDo?=
 =?us-ascii?Q?9I7zrPjyChiZswMmKt4k+v0lH5XKzArtTiAQ1FbreGqbbwcGcmPspZskDwIt?=
 =?us-ascii?Q?6GJkhuFcmMnC8oq6a6ntihUAB7o9WRXA+1fWTyzQCCtz8FNCX/attiUa5/8u?=
 =?us-ascii?Q?KA1bNs9A+esZffEp4K3rXTFGgqUfXkIdU96cnyd2s5IWcN33c2Ev8ASjqnnc?=
 =?us-ascii?Q?0PQ+t8XfGIWxyks0JD36MeCnrsHZ0ZbA+kQkmvZRQSlanTXUaj5PHmKtxvMz?=
 =?us-ascii?Q?4KyWROgJ74gERqcKOmR+dUsdzzS2Te8nBYiqXLG249pifVLsRL00UkXqqyl0?=
 =?us-ascii?Q?f5nR18CwELdqrnc1MO5uAjkD/t+clYjKP3ZSCjLworXXeSlMZN9kd4+zW169?=
 =?us-ascii?Q?nKiyCQBcoMnVfryGBXEcAMq3hzIx8y3sclS5Zt3oRbQ0FE1EJpyGtdGQn8ty?=
 =?us-ascii?Q?iK9Jzbnz8PL05MZ9WipMyYn6Qlnl4dovpC6hGr6BOvOoVAtF0aVTkwLVkRx6?=
 =?us-ascii?Q?z2Y0mFZdTybiruUAYUxWLHmn9VG7yRQzy+7CbxOrviX5MHE/dbiFjTBIHbPP?=
 =?us-ascii?Q?KY+gauq6QqpdddQ4gZroiiGIZLsbDRAiU1/Awp+lE7UN0uy85JEdth9636lv?=
 =?us-ascii?Q?F4TC4RQcRnwcyXpLawUc6VxoRf8AVjWljGO8rdMkxshpSvG4Dct2fzT8fn2S?=
 =?us-ascii?Q?5fAVdf5uQqPHa5zZPmYtWQUHT3O2d0qrQMyY7+M/cmiyPuN3h13p1Ouv0Y79?=
 =?us-ascii?Q?vRYhHNoZRe89duybuPDxzvZuimPdAxnrcVi6UM8ae6Dg9AK3JVwgUYEYjXkM?=
 =?us-ascii?Q?k0K3YLS0x1KZiGJu/LxEV/ylrRZBXOhirAM4L3hMBAFiuQgm0T2k/+EvIBr5?=
 =?us-ascii?Q?TcWLhfSqvHtHYACbYfUZQXxQAqEYAuwVTUwo9HFYaWKR0enEJIpL+8BtYmzX?=
 =?us-ascii?Q?LwGC+spOik37lvl1H6o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e423cef-641e-4520-5b7b-08dbce811057
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 19:49:52.5033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xtu9EpTIir31rhrSWWaj+yNme6/d1zJMkhBkIHf96Zhu4VeoUZbs7amySbz+Irl3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9163
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_67713C20-204D-4A8B-86F2-4C5F24BB1DC8_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 16 Oct 2023, at 14:51, Johannes Weiner wrote:

> On Mon, Oct 16, 2023 at 11:00:33AM -0400, Zi Yan wrote:
>> On 16 Oct 2023, at 10:37, Johannes Weiner wrote:
>>
>>> On Mon, Oct 16, 2023 at 09:35:34AM -0400, Zi Yan wrote:
>>>>> The attached patch has all the suggested changes, let me know how i=
t
>>>>> looks to you. Thanks.
>>>>
>>>> The one I sent has free page accounting issues. The attached one fix=
es them.
>>>
>>> Do you still have the warnings? I wonder what went wrong.
>>
>> No warnings. But something with the code:
>>
>> 1. in your version, split_free_page() is called without changing any p=
ageblock
>> migratetypes, then split_free_page() is just a no-op, since the page i=
s
>> just deleted from the free list, then freed via different orders. Budd=
y allocator
>> will merge them back.
>
> Hm not quite.
>
> If it's the tail block of a buddy, I update its type before
> splitting. The splitting loop looks up the type of each block for
> sorting it onto freelists.
>
> If it's the head block, yes I split it first according to its old
> type. But then I let it fall through to scanning the block, which will
> find that buddy, update its type and move it.

That is the issue, since split_free_page() assumes the pageblocks of
that free page have different types. It basically just free the page
with different small orders summed up to the original free page order.
If all pageblocks of the free page have the same migratetype, __free_one_=
page()
will merge these small order pages back to the original order free page.

>
>> 2. in my version, I set pageblock migratetype to new_mt before split_f=
ree_page(),
>> but it causes free page accounting issues, since in the case of head, =
free pages
>> are deleted from new_mt when they are in old_mt free list and the acco=
unting
>> decreases new_mt free page number instead of old_mt one.
>
> Right, that makes sense.
>
>> Basically, split_free_page() is awkward as it relies on preset migrate=
types,
>> which changes migratetypes without deleting the free pages from the li=
st first.
>> That is why I came up with the new split_free_page() below.
>
> Yeah, the in-between thing is bad. Either it fixes the migratetype
> before deletion, or it doesn't do the deletion. I'm thinking it would
> be simpler to move the deletion out instead.

Yes and no. After deletion, a free page no longer has PageBuddy set and
has buddy_order information cleared. Either we reset PageBuddy and order
to the deleted free page, or split_free_page() needs to be changed to
accept pages without the information (basically remove the PageBuddy
and order check code).

>>>> @@ -883,6 +886,10 @@ int split_free_page(struct page *free_page,
>>>>  	mt =3D get_pfnblock_migratetype(free_page, free_page_pfn);
>>>>  	del_page_from_free_list(free_page, zone, order, mt);
>>>>
>>>> +	set_pageblock_migratetype(free_page, mt1);
>>>> +	set_pageblock_migratetype(pfn_to_page(free_page_pfn + split_pfn_of=
fset),
>>>> +				  mt2);
>>>> +
>>>>  	for (pfn =3D free_page_pfn;
>>>>  	     pfn < free_page_pfn + (1UL << order);) {
>>>>  		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
>>>
>>> I don't think this is quite right.
>>>
>>> With CONFIG_ARCH_FORCE_MAX_ORDER it's possible that we're dealing wit=
h
>>> a buddy that is more than two blocks:
>>>
>>> [pageblock 0][pageblock 1][pageblock 2][pageblock 3]
>>> [buddy                                             ]
>>>                                        [isolate range ..
>>>
>>> That for loop splits the buddy into 4 blocks. The code above would se=
t
>>> pageblock 0 to old_mt, and pageblock 1 to new_mt. But it should only
>>> set pageblock 3 to new_mt.
>>
>> OK. I think I need to fix split_free_page().
>>
>> Hmm, if CONFIG_ARCH_FORCE_MAX_ORDER can make a buddy have more than on=
e
>> pageblock and in turn makes an in-use page have more than one pagebloc=
k,
>> we will have problems. Since in isolate_single_pageblock(), an in-use =
page
>> can have part of its pageblock set to a different migratetype and be f=
reed,
>> causing the free page with unmatched migratetypes. We might need to
>> free pages at pageblock_order if their orders are bigger than pagebloc=
k_order.
>
> Is this a practical issue? You mentioned that right now only gigantic
> pages can be larger than a pageblock, and those are freed in order-0
> chunks.

Only if the system allocates a page (non hugetlb pages) with >pageblock_o=
rder
and frees it with the same order. I just do not know if such pages exist =
on
other arch than x86. Maybe I just think too much.

>
>>> How about pulling the freelist removal out of split_free_page()?
>>>
>>> 	del_page_from_freelist(huge_buddy);
>>> 	set_pageblock_migratetype(start_page, MIGRATE_ISOLATE);
>>> 	split_free_page(huge_buddy, buddy_order(), pageblock_nr_pages);
>>> 	return pageblock_nr_pages;
>>
>> Yes, this is better. Let me change to this implementation.
>>
>> But I would like to test it on an environment where a buddy contains m=
ore than
>> one pageblocks first. I probably can change MAX_ORDER of x86_64 to do =
it locally.
>> I will report back.
>
> I tweaked my version some more based on our discussion. Would you mind
> taking a look? It survived an hour of stressing with a kernel build
> and Mike's reproducer that allocates gigantics and demotes them.
>
> Note that it applies *before* consolidating of the free counts, as
> isolation needs to be fixed before the warnings are added, to avoid
> bisectability issues. The consolidation patch doesn't change it much,
> except removing freepage accounting in move_freepages_block_isolate().
>
> ---
>
> From a0460ad30a24cf73816ac40b262af0ba3723a242 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 16 Oct 2023 12:32:21 -0400
> Subject: [PATCH] mm: page_isolation: prepare for hygienic freelists
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/page-isolation.h |   4 +-
>  mm/internal.h                  |   4 -
>  mm/page_alloc.c                | 198 +++++++++++++++++++--------------=

>  mm/page_isolation.c            |  96 +++++-----------
>  4 files changed, 142 insertions(+), 160 deletions(-)
>
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolat=
ion.h
> index 8550b3c91480..c16db0067090 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -34,7 +34,9 @@ static inline bool is_migrate_isolate(int migratetype=
)
>  #define REPORT_FAILURE	0x2
>
>  void set_pageblock_migratetype(struct page *page, int migratetype);
> -int move_freepages_block(struct zone *zone, struct page *page, int mig=
ratetype);
> +
> +bool move_freepages_block_isolate(struct zone *zone, struct page *page=
,
> +				  int migratetype);
>
>  int start_isolate_page_range(unsigned long start_pfn, unsigned long en=
d_pfn,
>  			     int migratetype, int flags, gfp_t gfp_flags);
> diff --git a/mm/internal.h b/mm/internal.h
> index 3a72975425bb..0681094ad260 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -464,10 +464,6 @@ extern void *memmap_alloc(phys_addr_t size, phys_a=
ddr_t align,
>  void memmap_init_range(unsigned long, int, unsigned long, unsigned lon=
g,
>  		unsigned long, enum meminit_context, struct vmem_altmap *, int);
>
> -
> -int split_free_page(struct page *free_page,
> -			unsigned int order, unsigned long split_pfn_offset);
> -
>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>
>  /*
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6185b076cf90..17e9a06027c8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -834,64 +834,6 @@ static inline void __free_one_page(struct page *pa=
ge,
>  		page_reporting_notify_free(order);
>  }
>
> -/**
> - * split_free_page() -- split a free page at split_pfn_offset
> - * @free_page:		the original free page
> - * @order:		the order of the page
> - * @split_pfn_offset:	split offset within the page
> - *
> - * Return -ENOENT if the free page is changed, otherwise 0
> - *
> - * It is used when the free page crosses two pageblocks with different=
 migratetypes
> - * at split_pfn_offset within the page. The split free page will be pu=
t into
> - * separate migratetype lists afterwards. Otherwise, the function achi=
eves
> - * nothing.
> - */
> -int split_free_page(struct page *free_page,
> -			unsigned int order, unsigned long split_pfn_offset)
> -{
> -	struct zone *zone =3D page_zone(free_page);
> -	unsigned long free_page_pfn =3D page_to_pfn(free_page);
> -	unsigned long pfn;
> -	unsigned long flags;
> -	int free_page_order;
> -	int mt;
> -	int ret =3D 0;
> -
> -	if (split_pfn_offset =3D=3D 0)
> -		return ret;
> -
> -	spin_lock_irqsave(&zone->lock, flags);
> -
> -	if (!PageBuddy(free_page) || buddy_order(free_page) !=3D order) {
> -		ret =3D -ENOENT;
> -		goto out;
> -	}
> -
> -	mt =3D get_pfnblock_migratetype(free_page, free_page_pfn);
> -	if (likely(!is_migrate_isolate(mt)))
> -		__mod_zone_freepage_state(zone, -(1UL << order), mt);
> -
> -	del_page_from_free_list(free_page, zone, order);
> -	for (pfn =3D free_page_pfn;
> -	     pfn < free_page_pfn + (1UL << order);) {
> -		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
> -
> -		free_page_order =3D min_t(unsigned int,
> -					pfn ? __ffs(pfn) : order,
> -					__fls(split_pfn_offset));
> -		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
> -				mt, FPI_NONE);
> -		pfn +=3D 1UL << free_page_order;
> -		split_pfn_offset -=3D (1UL << free_page_order);
> -		/* we have done the first part, now switch to second part */
> -		if (split_pfn_offset =3D=3D 0)
> -			split_pfn_offset =3D (1UL << order) - (pfn - free_page_pfn);
> -	}
> -out:
> -	spin_unlock_irqrestore(&zone->lock, flags);
> -	return ret;
> -}
>  /*
>   * A bad page could be due to a number of fields. Instead of multiple =
branches,
>   * try and check multiple fields with one check. The caller must do a =
detailed
> @@ -1673,8 +1615,8 @@ static bool prep_move_freepages_block(struct zone=
 *zone, struct page *page,
>  	return true;
>  }
>
> -int move_freepages_block(struct zone *zone, struct page *page,
> -			 int migratetype)
> +static int move_freepages_block(struct zone *zone, struct page *page,
> +				int migratetype)
>  {
>  	unsigned long start_pfn, end_pfn;
>
> @@ -1685,6 +1627,117 @@ int move_freepages_block(struct zone *zone, str=
uct page *page,
>  	return move_freepages(zone, start_pfn, end_pfn, migratetype);
>  }
>
> +#ifdef CONFIG_MEMORY_ISOLATION
> +/* Look for a multi-block buddy that straddles start_pfn */
> +static unsigned long find_large_buddy(unsigned long start_pfn)
> +{
> +	int order =3D 0;
> +	struct page *page;
> +	unsigned long pfn =3D start_pfn;
> +
> +	while (!PageBuddy(page =3D pfn_to_page(pfn))) {
> +		/* Nothing found */
> +		if (++order > MAX_ORDER)
> +			return start_pfn;
> +		pfn &=3D ~0UL << order;
> +	}
> +
> +	/*
> +	 * Found a preceding buddy, but does it straddle?
> +	 */
> +	if (pfn + (1 << buddy_order(page)) > start_pfn)
> +		return pfn;
> +
> +	/* Nothing found */
> +	return start_pfn;
> +}
> +
> +/* Split a multi-block buddy into its individual pageblocks */
> +static void split_large_buddy(struct page *buddy, int order)
> +{
> +	unsigned long pfn =3D page_to_pfn(buddy);
> +	unsigned long end =3D pfn + (1 << order);
> +	struct zone *zone =3D page_zone(buddy);
> +
> +	lockdep_assert_held(&zone->lock);
> +	VM_WARN_ON_ONCE(PageBuddy(buddy));
> +
> +	while (pfn < end) {
> +		int mt =3D get_pfnblock_migratetype(buddy, pfn);
> +
> +		__free_one_page(buddy, pfn, zone, pageblock_order, mt, FPI_NONE);
> +		pfn +=3D pageblock_nr_pages;
> +		buddy =3D pfn_to_page(pfn);
> +	}
> +}
> +
> +/**
> + * move_freepages_block_isolate - move free pages in block for page is=
olation
> + * @zone: the zone
> + * @page: the pageblock page
> + * @migratetype: migratetype to set on the pageblock
> + *
> + * This is similar to move_freepages_block(), but handles the special
> + * case encountered in page isolation, where the block of interest
> + * might be part of a larger buddy spanning multiple pageblocks.
> + *
> + * Unlike the regular page allocator path, which moves pages while
> + * stealing buddies off the freelist, page isolation is interested in
> + * arbitrary pfn ranges that may have overlapping buddies on both ends=
=2E
> + *
> + * This function handles that. Straddling buddies are split into
> + * individual pageblocks. Only the block of interest is moved.
> + *
> + * Returns %true if pages could be moved, %false otherwise.
> + */
> +bool move_freepages_block_isolate(struct zone *zone, struct page *page=
,
> +				  int migratetype)
> +{
> +	unsigned long start_pfn, end_pfn, pfn;
> +	int nr_moved, mt;
> +
> +	if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn,
> +				       NULL, NULL))
> +		return false;
> +
> +	/* We're a tail block in a larger buddy */
> +	pfn =3D find_large_buddy(start_pfn);
> +	if (pfn !=3D start_pfn) {
> +		struct page *buddy =3D pfn_to_page(pfn);
> +		int order =3D buddy_order(buddy);
> +		int mt =3D get_pfnblock_migratetype(buddy, pfn);
> +
> +		if (!is_migrate_isolate(mt))
> +			__mod_zone_freepage_state(zone, -(1UL << order), mt);
> +		del_page_from_free_list(buddy, zone, order);
> +		set_pageblock_migratetype(pfn_to_page(start_pfn), migratetype);
> +		split_large_buddy(buddy, order);
> +		return true;
> +	}
> +
> +	/* We're the starting block of a larger buddy */
> +	if (PageBuddy(page) && buddy_order(page) > pageblock_order) {
> +		int mt =3D get_pfnblock_migratetype(page, pfn);
> +		int order =3D buddy_order(page);
> +
> +		if (!is_migrate_isolate(mt))
> +			__mod_zone_freepage_state(zone, -(1UL << order), mt);
> +		del_page_from_free_list(page, zone, order);
> +		set_pageblock_migratetype(page, migratetype);
> +		split_large_buddy(page, order);
> +		return true;
> +	}
> +
> +	mt =3D get_pfnblock_migratetype(page, start_pfn);
> +	nr_moved =3D move_freepages(zone, start_pfn, end_pfn, migratetype);
> +	if (!is_migrate_isolate(mt))
> +		__mod_zone_freepage_state(zone, -nr_moved, mt);
> +	else if (!is_migrate_isolate(migratetype))
> +		__mod_zone_freepage_state(zone, nr_moved, migratetype);
> +	return true;
> +}
> +#endif /* CONFIG_MEMORY_ISOLATION */
> +
>  static void change_pageblock_range(struct page *pageblock_page,
>  					int start_order, int migratetype)
>  {
> @@ -6318,7 +6371,6 @@ int alloc_contig_range(unsigned long start, unsig=
ned long end,
>  		       unsigned migratetype, gfp_t gfp_mask)
>  {
>  	unsigned long outer_start, outer_end;
> -	int order;
>  	int ret =3D 0;
>
>  	struct compact_control cc =3D {
> @@ -6391,29 +6443,7 @@ int alloc_contig_range(unsigned long start, unsi=
gned long end,
>  	 * We don't have to hold zone->lock here because the pages are
>  	 * isolated thus they won't get removed from buddy.
>  	 */
> -
> -	order =3D 0;
> -	outer_start =3D start;
> -	while (!PageBuddy(pfn_to_page(outer_start))) {
> -		if (++order > MAX_ORDER) {
> -			outer_start =3D start;
> -			break;
> -		}
> -		outer_start &=3D ~0UL << order;
> -	}
> -
> -	if (outer_start !=3D start) {
> -		order =3D buddy_order(pfn_to_page(outer_start));
> -
> -		/*
> -		 * outer_start page could be small order buddy page and
> -		 * it doesn't include start page. Adjust outer_start
> -		 * in this case to report failed page properly
> -		 * on tracepoint in test_pages_isolated()
> -		 */
> -		if (outer_start + (1UL << order) <=3D start)
> -			outer_start =3D start;
> -	}
> +	outer_start =3D find_large_buddy(start);
>
>  	/* Make sure the range is really isolated. */
>  	if (test_pages_isolated(outer_start, end, 0)) {
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 27ee994a57d3..b4d53545496d 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -178,16 +178,10 @@ static int set_migratetype_isolate(struct page *p=
age, int migratetype, int isol_
>  	unmovable =3D has_unmovable_pages(check_unmovable_start, check_unmova=
ble_end,
>  			migratetype, isol_flags);
>  	if (!unmovable) {
> -		int nr_pages;
> -		int mt =3D get_pageblock_migratetype(page);
> -
> -		nr_pages =3D move_freepages_block(zone, page, MIGRATE_ISOLATE);
> -		/* Block spans zone boundaries? */
> -		if (nr_pages =3D=3D -1) {
> +		if (!move_freepages_block_isolate(zone, page, MIGRATE_ISOLATE)) {
>  			spin_unlock_irqrestore(&zone->lock, flags);
>  			return -EBUSY;
>  		}
> -		__mod_zone_freepage_state(zone, -nr_pages, mt);
>  		zone->nr_isolate_pageblock++;
>  		spin_unlock_irqrestore(&zone->lock, flags);
>  		return 0;
> @@ -254,13 +248,11 @@ static void unset_migratetype_isolate(struct page=
 *page, int migratetype)
>  	 * allocation.
>  	 */
>  	if (!isolated_page) {
> -		int nr_pages =3D move_freepages_block(zone, page, migratetype);
>  		/*
>  		 * Isolating this block already succeeded, so this
>  		 * should not fail on zone boundaries.
>  		 */
> -		WARN_ON_ONCE(nr_pages =3D=3D -1);
> -		__mod_zone_freepage_state(zone, nr_pages, migratetype);
> +		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page, migratetype))=
;
>  	} else {
>  		set_pageblock_migratetype(page, migratetype);
>  		__putback_isolated_page(page, order, migratetype);
> @@ -373,26 +365,29 @@ static int isolate_single_pageblock(unsigned long=
 boundary_pfn, int flags,
>
>  		VM_BUG_ON(!page);
>  		pfn =3D page_to_pfn(page);
> -		/*
> -		 * start_pfn is MAX_ORDER_NR_PAGES aligned, if there is any
> -		 * free pages in [start_pfn, boundary_pfn), its head page will
> -		 * always be in the range.
> -		 */
> +
>  		if (PageBuddy(page)) {
>  			int order =3D buddy_order(page);
>
> -			if (pfn + (1UL << order) > boundary_pfn) {
> -				/* free page changed before split, check it again */
> -				if (split_free_page(page, order, boundary_pfn - pfn))
> -					continue;
> -			}
> +			/* move_freepages_block_isolate() handled this */
> +			VM_WARN_ON_ONCE(pfn + (1 << order) > boundary_pfn);
>
>  			pfn +=3D 1UL << order;
>  			continue;
>  		}
> +
>  		/*
> -		 * migrate compound pages then let the free page handling code
> -		 * above do the rest. If migration is not possible, just fail.
> +		 * If a compound page is straddling our block, attempt
> +		 * to migrate it out of the way.
> +		 *
> +		 * We don't have to worry about this creating a large
> +		 * free page that straddles into our block: gigantic
> +		 * pages are freed as order-0 chunks, and LRU pages
> +		 * (currently) do not exceed pageblock_order.
> +		 *
> +		 * The block of interest has already been marked
> +		 * MIGRATE_ISOLATE above, so when migration is done it
> +		 * will free its pages onto the correct freelists.
>  		 */
>  		if (PageCompound(page)) {
>  			struct page *head =3D compound_head(page);
> @@ -403,16 +398,15 @@ static int isolate_single_pageblock(unsigned long=
 boundary_pfn, int flags,
>  				pfn =3D head_pfn + nr_pages;
>  				continue;
>  			}
> +
> +			VM_WARN_ON_ONCE_PAGE(PageLRU(page), page);
> +
>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>  			/*
> -			 * hugetlb, lru compound (THP), and movable compound pages
> -			 * can be migrated. Otherwise, fail the isolation.
> +			 * hugetlb, and movable compound pages can be
> +			 * migrated. Otherwise, fail the isolation.
>  			 */
> -			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
> -				int order;
> -				unsigned long outer_pfn;
> -				int page_mt =3D get_pageblock_migratetype(page);
> -				bool isolate_page =3D !is_migrate_isolate_page(page);
> +			if (PageHuge(page) || __PageMovable(page)) {
>  				struct compact_control cc =3D {
>  					.nr_migratepages =3D 0,
>  					.order =3D -1,
> @@ -425,52 +419,12 @@ static int isolate_single_pageblock(unsigned long=
 boundary_pfn, int flags,
>  				};
>  				INIT_LIST_HEAD(&cc.migratepages);
>
> -				/*
> -				 * XXX: mark the page as MIGRATE_ISOLATE so that
> -				 * no one else can grab the freed page after migration.
> -				 * Ideally, the page should be freed as two separate
> -				 * pages to be added into separate migratetype free
> -				 * lists.
> -				 */
> -				if (isolate_page) {
> -					ret =3D set_migratetype_isolate(page, page_mt,
> -						flags, head_pfn, head_pfn + nr_pages);
> -					if (ret)
> -						goto failed;
> -				}
> -
>  				ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
>  							head_pfn + nr_pages);
> -
> -				/*
> -				 * restore the page's migratetype so that it can
> -				 * be split into separate migratetype free lists
> -				 * later.
> -				 */
> -				if (isolate_page)
> -					unset_migratetype_isolate(page, page_mt);
> -
>  				if (ret)
>  					goto failed;
> -				/*
> -				 * reset pfn to the head of the free page, so
> -				 * that the free page handling code above can split
> -				 * the free page to the right migratetype list.
> -				 *
> -				 * head_pfn is not used here as a hugetlb page order
> -				 * can be bigger than MAX_ORDER, but after it is
> -				 * freed, the free page order is not. Use pfn within
> -				 * the range to find the head of the free page.
> -				 */
> -				order =3D 0;
> -				outer_pfn =3D pfn;
> -				while (!PageBuddy(pfn_to_page(outer_pfn))) {
> -					/* stop if we cannot find the free page */
> -					if (++order > MAX_ORDER)
> -						goto failed;
> -					outer_pfn &=3D ~0UL << order;
> -				}
> -				pfn =3D outer_pfn;
> +
> +				pfn =3D head_pfn + nr_pages;
>  				continue;
>  			} else
>  #endif
> -- =

> 2.42.0

It looks good to me. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

--=_MailMate_67713C20-204D-4A8B-86F2-4C5F24BB1DC8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUtk90PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhURgoQAJYmD00vfvPrvq4A5JUPce5Hm6p+EkCiY9mM
YiTtUwgr0X19AAufGGn1fqxfSymhgOmpKe5kUCif04E0rvE8q/NjLv4VAbt0Zi5N
Aexdb+MvUB75kLJlIv0d1uZjTP+wjYp0jgFacOeMDNCl9aJpxsYrpUCJ6W7qGBDN
GhOM8x3FZrp6L+Iin8R3p3TixKJp6Gt733/nvSDtWMvReBusOht28IJx/5jQFK4e
Ql1gHji2Iq+GexplobxU2FpfxbHtv3Sjp20EBQjfGnPr0MxWQJ8G7UwMBjEmcrnj
7eBKKrnf88l8tqpAvGj3rSSaWr8g4PUmc0YIuD/pID0U5jxN9aAjG5ELrZRS9Uw6
3iS46C2pbsePmUqR5m7hWwcdvXAa3+GWEjfmF36Ov0LHz1IDrfEO0fdeCmWZp4Nn
4vduxqBXcUy8wpNvD1eK+IN+rHFYyRSMZG5Dk7w79fZTvcsUyfHsIMzLSeqedpq1
39204lLG1U8eCKPcIDOO5D2d4jfPQfq0JMEUX+KPsWh+Qp3Si4rQuMEz1AGzPjCi
hyq9YOPhdYyqswTJfrtzlfUjpjlAFcrmzy2Y5kJEjz41eZIzwlXW96ACb4CJEY+w
ZZJ/kpSBAydeSOMfggMURIeld7b4xOj/Ju+yZApR9KCeWnwZXqcSkPckTPu6t3Ou
ZwR3AVWY
=2/5l
-----END PGP SIGNATURE-----

--=_MailMate_67713C20-204D-4A8B-86F2-4C5F24BB1DC8_=--
