Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A58A7A6C93
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 22:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjISU6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 16:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbjISU55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 16:57:57 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431E2BD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 13:57:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuEKtKsxyC806tUW2/y634XoRRTeBpXytx+L1IHNlS2BX4re9f0svB3RdmASubxdgXQF4h7XxW4RnsBx8f7hUtuOoOJg3e8eqIOu0yKxhhBq3W2JdW9IAbHl3K64WKa204kWnhecf4UsvAXueGafaCsqt+R4Ks9mktecO54mW02F3J2K1fh0tEo1SjEThr97kO5oEOI58tcIu9VrJKvGrQiY12Ohq4YVXTextv8iz0/W9EbxTM43DWF0FhLQ3lzmh4jTQNA8mYldbnrSlkWWyQZRw7EIcJTobPcTPdniANdHEAynJOJq9aCI92JB+2ouDfSPtXw89CK6mqsu6mpxoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJQ0jCsTH/f6ULqxJX6AoK4IYSnx37YfXnUYObNKGsI=;
 b=JxxizRFkkkNA/CmG9GMewUUgEZGKSMpaIJ/emKUf5UKNCbhRs2LqvJ/MGRjMhbUP8M3nppxdkY+Rg1Qq99BTR6Du0MSVd1Ft1O+7fd9qJ1A9ltVOcYRph3Vzcm/JWpX2KVOGaXmKedu0mOkFcs9Vxz2Z6tRBh4M4Ngh19mvAqfNgzovyXCM8Tc9zgrjyyc7H45VfD2QyS4SjP1e6Z1GLsaY+q9bZ6R8CxZ+4rzbt98+dxXwYBfklRvr38sp6dOFFckVnl2VA/+BbWDJUbmsRrvNC7hdvaPKlvk9wbfcVAEtVHoMwTslnSqFJEZBZvIaZ6K2JKg/YEZK6a94Sr/IuIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJQ0jCsTH/f6ULqxJX6AoK4IYSnx37YfXnUYObNKGsI=;
 b=DZSjzWG90FlyDIdjQWjm4OH1L/VYWbzaoAyBio/Q055ge4WfnM6Pbg3OOPH3yb636MdgJSm2myEglkCugoMAezQ2ighCw9n9ow0v+zy0oJdDnL/89nfRnK5QQkdnYGn31UnoAB8sYELH4uPZVCuLoiIh2Mg2RzzF19Dbhg74NEEOXAnsflIKXnqPqDXWgOyoznDB0fNA35LBcl2WtpxEhYRsI06bv6d3k4uGUEktkgrYESOiNbeYfWb6gZhl3De/+NHnkn6fe8XS50QuvY4lcj+MDdrRAo5BmcSsodUiw+Ybx2ps3+NzdObl+YAjIVbfhvtH4dZqrUmPwinC0x8W1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 20:57:42 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 20:57:42 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Date:   Tue, 19 Sep 2023 16:57:39 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <C416A861-44D3-46E7-B756-63DA3731FC1E@nvidia.com>
In-Reply-To: <20230919184731.GC112714@monkey>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230914235238.GB129171@monkey> <20230915141610.GA104956@cmpxchg.org>
 <20230916195739.GB618858@monkey>
 <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
 <20230918145204.GB16104@cmpxchg.org> <20230918174037.GA112714@monkey>
 <20230919064914.GA124289@cmpxchg.org> <20230919184731.GC112714@monkey>
Content-Type: multipart/signed;
 boundary="=_MailMate_A66AC274-9A2A-4104-B81D-144E7F13127D_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR12CA0008.namprd12.prod.outlook.com
 (2603:10b6:208:a8::21) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: e0fdafd5-f7dd-4005-d4e1-08dbb9531114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibkajCGR8ACAWcZq/x9I+5si69ObSIDarppRT6bPuwn+bTIdt3A9EbaAurZKuEj4xGndCFa+AidIIBRH7H9xvPOtfPuXkxPvOUa0NyJJqVWyW/SYRsQmiP5Pxk0xDKqAQgcuxETR5wpSP/+lQNheYCTQCtIgSVxMafLgUyEum5m8IWJXW1PVnvpfTf7P3Qz5Rp9XSDqcmdndho7gFYIOJVNUH7WIB8bn8mogaNCxL1TZSW6ucddJ9qUcUjqIfjo2G6mNQORXxfD3usta/YY3jn9aByouVKLf9+X5K0rMDlRIiUI5cvdxjfsbUBzwM5WVE+Rnyam39FBuA6pPlAnNnFfXthAOYYl86gVYhKvspwLDD7TgXGwZuL2lNpr6tJPoQNDFvJ/rP0Pa3EKkjkn2ZZI2r+93c6jvW3XUAGVeNWdPPnOf1ZMaBDKumIBIw/glyLFX9+LKz1DLsyemR98n3NWmbiaj51xSvxMTQ3B6n02qxoV3bOyRzuIEl+nvyYyKjbJ8HZSSrqrccYJnEdAaSo4Gv6qI/VFvPv+7UIRHTaJ/sblRBwYKe1oZt594Y+u/krRyTEUhb1TjD5RaRk3OL5N6I/CrVnBvWXjCSfMTr99VqlwF+0XiACd4o1HqlHZE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(1800799009)(451199024)(186009)(6512007)(4326008)(53546011)(6486002)(6506007)(26005)(2616005)(8936002)(83380400001)(8676002)(2906002)(36756003)(41300700001)(66476007)(86362001)(66946007)(66556008)(54906003)(6916009)(316002)(38100700002)(30864003)(33656002)(6666004)(45080400002)(5660300002)(478600001)(235185007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0PMOSkwWFYCWwox/9gXrE5XCOYIiMzZemqsgYycJgONtBnuMk04KsEGrFqaB?=
 =?us-ascii?Q?vb1+nJXY05FCIKDYU2rGdG6pn7ghAM5qSG+nDEKGC6N9pu+CkIL64atOyTIp?=
 =?us-ascii?Q?pvChv+GgMyxx3mE0SQ1Dv2/FzQ/8mq+vx6FDU2rXUUFPSeOE20yHJDjKNHSj?=
 =?us-ascii?Q?Dqc2ZaX/24mDeFVvATyrF5AfNjlTZR3+r4Xk2EQTEH3SoJFm21YNn3oqrDt+?=
 =?us-ascii?Q?Il17LBROh/gofL9q+sTjBVEJl+F0JQmQ41B7k0/unArEHDvLdDYdvkpPiRjO?=
 =?us-ascii?Q?Lnnj+a/9Gb+nf3X61tSnyqacxHFniEha9GwOfl/BQRQf+KPbJKVlLPyfQUpa?=
 =?us-ascii?Q?tfjNlUfz2ZXnYuL7zSI+ACHguyUCNTRwTagLQ7Vu2mh2ju8HpjBWZ9TuDe7Y?=
 =?us-ascii?Q?Fkuayfm8M/zsP5kJ+3z0bvRophkgFm9hS0w7PvoBPtE3rVDkttpJtXb/7mQi?=
 =?us-ascii?Q?Vw4DwrI7ERirCpC8t/eaP+HNBcLVEC8xiPgCU4s0jSBMDILL2EO7PC7BvR7Z?=
 =?us-ascii?Q?AC95T+ZF/XQnD6ouSvNEqm97X6jMmxE4SkeopJ8bcX0XaVzayesk9s12LFcL?=
 =?us-ascii?Q?ty9rKX9DECiI6hl3MvbZj3po2lQTY4wYbFtaU3sHjStpLcjvQnIHVgIafNGV?=
 =?us-ascii?Q?w78N4dl0xwccIDvAlSnNFxqAAn4Ta+hdaMDXKAumBFuJa6vEjwnfAYqiXpcp?=
 =?us-ascii?Q?UvFVOKc/JI5EkeRxxKkziueaiiHmb7YsdeyAqHguvT3Temd3zW2bWhS5+YDT?=
 =?us-ascii?Q?YYYFwhCWMpt2N0wY8ykgo6J4RcyTKZ+5SyGfWGfxOhRdVpXeCqTihyj4yj2d?=
 =?us-ascii?Q?SM9q88GgK0cGsvuI0rL13sHopbt6M+HR4EDEDDaiPybyvqWexAjQiluB+P1/?=
 =?us-ascii?Q?IVikGwB1SgaHb+Dss7hthLNNbZH9IhoJa9YbFm2B/rEm1j1RJEz8mtXOOJXv?=
 =?us-ascii?Q?8OdY0+2R/ocuavcA17Pof4jgZ/b1b0hTFamcoEPDf9cyMCwws6eIz8sZi1nb?=
 =?us-ascii?Q?du8la3fhuZiUp/EYb5VzqxfCYi6zpMmazNsamKhUiNvlyqa0OPQCeArzK5qT?=
 =?us-ascii?Q?C/+TreIBgR3fp5isdx2AMZqvsqP9hg0bT17V1AikMvEJdNVBBmhYIRyZYElU?=
 =?us-ascii?Q?ruq+DEpXID72C9BM1+FIyBJOU5Z0UK2i1fnC8qWTjN/wt98QW7PHBn8SLYjf?=
 =?us-ascii?Q?PHDLukxxJhM48JOsKjlTKY6ShrLI3WfbqUwk9aeUNtMb4Ed9ddJnSyZfVOLA?=
 =?us-ascii?Q?j7fwLo7XhnuNeJ8m1V4H+UmiXYRZzY6hThTzMaxXJcc5htt60xHjOJLXONYR?=
 =?us-ascii?Q?NqX3HYMw2ob9zn4j76j97HpJCaNJByx/vDI7b/XrFUV0Icc9HLIVah1vB7AS?=
 =?us-ascii?Q?H9MRO5TIHdAAvd6vN1mU5tg/8M9Holm4peZKb7NIJleyFPN1YoF7g02KeQrD?=
 =?us-ascii?Q?IiKC2nU+z5NnMUz19f8qdBguRZS26fiOTQW4EyKMt4Dyyg9au87DaJhhnNhj?=
 =?us-ascii?Q?1ixZ8wrNkLE3gyAI8tDOieLUaFOwf0zh6j9LvY8KqtwX8aMQDONIkVtuq/H2?=
 =?us-ascii?Q?kpjYgacq5MSaPPikojWdr/TYq3OegchsiHRcLhJk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0fdafd5-f7dd-4005-d4e1-08dbb9531114
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 20:57:42.4760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04o4nX2DJb2cIqpjI4XBx4OL52Qw4Dn4JEZB9oJp55jBmnCsrE7vXrBiK3T/X71X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_A66AC274-9A2A-4104-B81D-144E7F13127D_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 19 Sep 2023, at 14:47, Mike Kravetz wrote:

> On 09/19/23 02:49, Johannes Weiner wrote:
>> On Mon, Sep 18, 2023 at 10:40:37AM -0700, Mike Kravetz wrote:
>>> On 09/18/23 10:52, Johannes Weiner wrote:
>>>> On Mon, Sep 18, 2023 at 09:16:58AM +0200, Vlastimil Babka wrote:
>>>>> On 9/16/23 21:57, Mike Kravetz wrote:
>>>>>> On 09/15/23 10:16, Johannes Weiner wrote:
>>>>>>> On Thu, Sep 14, 2023 at 04:52:38PM -0700, Mike Kravetz wrote:
>>>>>>
>>>>>> With the patch below applied, a slightly different workload trigge=
rs the
>>>>>> following warnings.  It seems related, and appears to go away when=

>>>>>> reverting the series.
>>>>>>
>>>>>> [  331.595382] ------------[ cut here ]------------
>>>>>> [  331.596665] page type is 5, passed migratetype is 1 (nr=3D512)
>>>>>> [  331.598121] WARNING: CPU: 2 PID: 935 at mm/page_alloc.c:662 exp=
and+0x1c9/0x200
>>>>>
>>>>> Initially I thought this demonstrates the possible race I was sugge=
sting in
>>>>> reply to 6/6. But, assuming you have CONFIG_CMA, page type 5 is cma=
 and we
>>>>> are trying to get a MOVABLE page from a CMA page block, which is so=
mething
>>>>> that's normally done and the pageblock stays CMA. So yeah if the wa=
rnings
>>>>> are to stay, they need to handle this case. Maybe the same can happ=
en with
>>>>> HIGHATOMIC blocks?
>>
>> Ok, the CMA thing gave me pause because Mike's pagetypeinfo didn't
>> show any CMA pages.
>>
>> 5 is actually MIGRATE_ISOLATE - see the double use of 3 for PCPTYPES
>> and HIGHATOMIC.
>>
>>>> This means we have an order-10 page where one half is MOVABLE and th=
e
>>>> other is CMA.
>>
>> This means the scenario is different:
>>
>> We get a MAX_ORDER page off the MOVABLE freelist. The removal checks
>> that the first pageblock is indeed MOVABLE. During the expand, the
>> second pageblock turns out to be of type MIGRATE_ISOLATE.
>>
>> The page allocator wouldn't have merged those types. It triggers a bit=

>> too fast to be a race condition.
>>
>> It appears that MIGRATE_ISOLATE is simply set on the tail pageblock
>> while the head is on the list, and then stranded there.
>>
>> Could this be an issue in the page_isolation code? Maybe a range
>> rounding error?
>>
>> Zi Yan, does this ring a bell for you?
>>
>> I don't quite see how my patches could have caused this. But AFAICS we=

>> also didn't have warnings for this scenario so it could be an old bug.=

>>
>>>> Mike, could you describe the workload that is triggering this?
>>>
>>> This 'slightly different workload' is actually a slightly different
>>> environment.  Sorry for mis-speaking!  The slight difference is that =
this
>>> environment does not use the 'alloc hugetlb gigantic pages from CMA'
>>> (hugetlb_cma) feature that triggered the previous issue.
>>>
>>> This is still on a 16G VM.  Kernel command line here is:
>>> "BOOT_IMAGE=3D(hd0,msdos1)/vmlinuz-6.6.0-rc1-next-20230913+
>>> root=3DUUID=3D49c13301-2555-44dc-847b-caabe1d62bdf ro console=3Dtty0
>>> console=3DttyS0,115200 audit=3D0 selinux=3D0 transparent_hugepage=3Da=
lways
>>> hugetlb_free_vmemmap=3Don"
>>>
>>> The workload is just running this script:
>>> while true; do
>>>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>>>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/demote
>>>  echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
>>> done
>>>
>>>>
>>>> Does this reproduce instantly and reliably?
>>>>
>>>
>>> It is not 'instant' but will reproduce fairly reliably within a minut=
e
>>> or so.
>>>
>>> Note that the 'echo 4 > .../hugepages-1048576kB/nr_hugepages' is goin=
g
>>> to end up calling alloc_contig_pages -> alloc_contig_range.  Those pa=
ges
>>> will eventually be freed via __free_pages(folio, 9).
>>
>> No luck reproducing this yet, but I have a question. In that crash
>> stack trace, the expand() is called via this:
>>
>>  [  331.645847]  get_page_from_freelist+0x3ed/0x1040
>>  [  331.646837]  ? prepare_alloc_pages.constprop.0+0x197/0x1b0
>>  [  331.647977]  __alloc_pages+0xec/0x240
>>  [  331.648783]  alloc_buddy_hugetlb_folio.isra.0+0x6a/0x150
>>  [  331.649912]  __alloc_fresh_hugetlb_folio+0x157/0x230
>>  [  331.650938]  alloc_pool_huge_folio+0xad/0x110
>>  [  331.651909]  set_max_huge_pages+0x17d/0x390
>>
>> I don't see an __alloc_fresh_hugetlb_folio() in my tree. Only
>> alloc_fresh_hugetlb_folio(), which has this:
>>
>>         if (hstate_is_gigantic(h))
>>                 folio =3D alloc_gigantic_folio(h, gfp_mask, nid, nmask=
);
>>         else
>>                 folio =3D alloc_buddy_hugetlb_folio(h, gfp_mask,
>>                                 nid, nmask, node_alloc_noretry);
>>
>> where gigantic is defined as the order exceeding MAX_ORDER, which
>> should be the case for 1G pages on x86.
>>
>> So the crashing stack must be from a 2M allocation, no? I'm confused
>> how that could happen with the above test case.
>
> Sorry for causing the confusion!
>
> When I originally saw the warnings pop up, I was running the above scri=
pt
> as well as another that only allocated order 9 hugetlb pages:
>
> while true; do
> 	echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> 	echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> done
>
> The warnings were actually triggered by allocations in this second scri=
pt.
>
> However, when reporting the warnings I wanted to include the simplest
> way to recreate.  And, I noticed that that second script running in
> parallel was not required.  Again, sorry for the confusion!  Here is a
> warning triggered via the alloc_contig_range path only running the one
> script.
>
> [  107.275821] ------------[ cut here ]------------
> [  107.277001] page type is 0, passed migratetype is 1 (nr=3D512)
> [  107.278379] WARNING: CPU: 1 PID: 886 at mm/page_alloc.c:699 del_page=
_from_free_list+0x137/0x170
> [  107.280514] Modules linked in: rfkill ip6table_filter ip6_tables sun=
rpc snd_hda_codec_generic joydev 9p snd_hda_intel netfs snd_intel_dspcfg =
snd_hda_codec snd_hwdep 9pnet_virtio snd_hda_core snd_seq snd_seq_device =
9pnet virtio_balloon snd_pcm snd_timer snd soundcore virtio_net net_failo=
ver failover virtio_console virtio_blk crct10dif_pclmul crc32_pclmul crc3=
2c_intel ghash_clmulni_intel serio_raw virtio_pci virtio virtio_pci_legac=
y_dev virtio_pci_modern_dev virtio_ring fuse
> [  107.291033] CPU: 1 PID: 886 Comm: bash Not tainted 6.6.0-rc2-next-20=
230919-dirty #35
> [  107.293000] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 1.16.2-1.fc37 04/01/2014
> [  107.295187] RIP: 0010:del_page_from_free_list+0x137/0x170
> [  107.296618] Code: c6 05 20 9b 35 01 01 e8 b7 fb ff ff 44 89 f1 44 89=
 e2 48 c7 c7 d8 ab 22 82 48 89 c6 b8 01 00 00 00 d3 e0 89 c1 e8 e9 99 df =
ff <0f> 0b e9 03 ff ff ff 48 c7 c6 10 ac 22 82 48 89 df e8 f3 e0 fc ff
> [  107.301236] RSP: 0018:ffffc90003ba7a70 EFLAGS: 00010086
> [  107.302535] RAX: 0000000000000000 RBX: ffffea0007ff8000 RCX: 0000000=
000000000
> [  107.304467] RDX: 0000000000000004 RSI: ffffffff8224e9de RDI: 0000000=
0ffffffff
> [  107.306289] RBP: 00000000001ffe00 R08: 0000000000009ffb R09: 0000000=
0ffffdfff
> [  107.308135] R10: 00000000ffffdfff R11: ffffffff824660e0 R12: 0000000=
000000001
> [  107.309956] R13: ffff88827fffcd80 R14: 0000000000000009 R15: 0000000=
0001ffc00
> [  107.311839] FS:  00007fabb8cba740(0000) GS:ffff888277d00000(0000) kn=
lGS:0000000000000000
> [  107.314695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  107.316159] CR2: 00007f41ba01acf0 CR3: 0000000282ed4006 CR4: 0000000=
000370ee0
> [  107.317971] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> [  107.319783] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> [  107.321575] Call Trace:
> [  107.322314]  <TASK>
> [  107.323002]  ? del_page_from_free_list+0x137/0x170
> [  107.324380]  ? __warn+0x7d/0x130
> [  107.325341]  ? del_page_from_free_list+0x137/0x170
> [  107.326627]  ? report_bug+0x18d/0x1c0
> [  107.327632]  ? prb_read_valid+0x17/0x20
> [  107.328711]  ? handle_bug+0x41/0x70
> [  107.329685]  ? exc_invalid_op+0x13/0x60
> [  107.330787]  ? asm_exc_invalid_op+0x16/0x20
> [  107.331937]  ? del_page_from_free_list+0x137/0x170
> [  107.333189]  __free_one_page+0x2ab/0x6f0
> [  107.334375]  free_pcppages_bulk+0x169/0x210
> [  107.335575]  drain_pages_zone+0x3f/0x50
> [  107.336691]  __drain_all_pages+0xe2/0x1e0
> [  107.337843]  alloc_contig_range+0x143/0x280
> [  107.339026]  alloc_contig_pages+0x210/0x270
> [  107.340200]  alloc_fresh_hugetlb_folio+0xa6/0x270
> [  107.341529]  alloc_pool_huge_page+0x7d/0x100
> [  107.342745]  set_max_huge_pages+0x162/0x340
> [  107.345059]  nr_hugepages_store_common+0x91/0xf0
> [  107.346329]  kernfs_fop_write_iter+0x108/0x1f0
> [  107.347547]  vfs_write+0x207/0x400
> [  107.348543]  ksys_write+0x63/0xe0
> [  107.349511]  do_syscall_64+0x37/0x90
> [  107.350543]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> [  107.351940] RIP: 0033:0x7fabb8daee87
> [  107.352819] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f=
 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f =
05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [  107.356373] RSP: 002b:00007ffc02737478 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000001
> [  107.358103] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fa=
bb8daee87
> [  107.359695] RDX: 0000000000000002 RSI: 000055fe584a1620 RDI: 0000000=
000000001
> [  107.361258] RBP: 000055fe584a1620 R08: 000000000000000a R09: 00007fa=
bb8e460c0
> [  107.362842] R10: 00007fabb8e45fc0 R11: 0000000000000246 R12: 0000000=
000000002
> [  107.364385] R13: 00007fabb8e82520 R14: 0000000000000002 R15: 00007fa=
bb8e82720
> [  107.365968]  </TASK>
> [  107.366534] ---[ end trace 0000000000000000 ]---
> [  121.542474] ------------[ cut here ]------------
>
> Perhaps that is another piece of information in that the warning can be=

> triggered via both allocation paths.
>
> To be perfectly clear, here is what I did today:
> - built next-20230919.  It does not contain your series
>   	I could not recreate the issue.
> - Added your series and the patch to remove
>   VM_BUG_ON_PAGE(is_migrate_isolate(mt), page) from free_pcppages_bulk
> 	I could recreate the issue while running only the one script.
> 	The warning above is from that run.
> - Added this suggested patch from Zi
> 	diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> 	index 1400e674ab86..77a4aea31a7f 100644
> 	--- a/mm/page_alloc.c
> 	+++ b/mm/page_alloc.c
> 	@@ -1651,8 +1651,13 @@ static bool prep_move_freepages_block(struct zo=
ne *zone, struct page *page,
>  		end =3D pageblock_end_pfn(pfn) - 1;
>
>  		/* Do not cross zone boundaries */
> 	+#if 0
>  		if (!zone_spans_pfn(zone, start))
> 			start =3D zone->zone_start_pfn;
> 	+#else
> 	+	if (!zone_spans_pfn(zone, start))
> 	+		start =3D pfn;
> 	+#endif
> 	 	if (!zone_spans_pfn(zone, end))
> 	 		return false;
> 	I can still trigger warnings.

OK. One thing to note is that the page type in the warning changed from
5 (MIGRATE_ISOLATE) to 0 (MIGRATE_UNMOVABLE) with my suggested change.

>
> One idea about recreating the issue is that it may have to do with size=

> of my VM (16G) and the requested allocation sizes 4G.  However, I tried=

> to really stress the allocations by increasing the number of hugetlb
> pages requested and that did not help.  I also noticed that I only seem=

> to get two warnings and then they stop, even if I continue to run the
> script.
>
> Zi asked about my config, so it is attached.

With your config, I still have no luck reproducing the issue. I will keep=

trying. Thanks.


--
Best Regards,
Yan, Zi

--=_MailMate_A66AC274-9A2A-4104-B81D-144E7F13127D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUKC0MPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUuL0P/iRASOQHMiMhXWB7HzCQTbkmN77JswWjL+Mq
DNCmaOO7oix5csYy8SxUSEdSVqrgFCBHkb30AtiSK3fH4RMh9uRjRnEQ8t4QC7NB
LKFsN72N+nXDtTLJs7d0+ze8LszPFmQEl4xLDdyOhyjWTFseNYuwGeJiA2A3Sclt
y3E7ITOHEkJokhljeuhFUZLmU0DUOlzgs3beuNePXiv/lDbRw2+uM1MOQMN6lwO1
PygWTfJleqpZeVLSTbDyfZzGRVdAVO9CC5RNn7KsoRk29To7vXI3U3qn+ucX7Adx
opMGhwYRANsiFSuaDuoOIeUKLldqsJ5o338xvq7ftK2n5uPPhf8kShQ6DunYgv9Z
UeeRJi0aPc5d1LVipTiXlyqODiB1hYoLKiMAvccW6rR/LE+VI7hhL5XbqhMC2gVo
qM6hxu9rRnAumRhfmKO5kKk20pdi+mhOKq/a7yD3QBbjaiG2nwVGXhhniAsiq+z2
1x1pCDcdpUggNu+aodDWl8SBKdDFjhJGSwSLN8CDY1pQSnY0CWHdd+dpvspYChIb
t+sX+ISDDLer6VL8i3RKAkO8aoJhhnoxLZytiEUYclwZYKoYNI+x57ldwiB4WRbK
Me/rTJIPS24TLwWGOpw81Pcup55+ZfUpsrxmR029s0PXiDad24dmmBRMb27LTEIw
GpHTL7z5
=OR7q
-----END PGP SIGNATURE-----

--=_MailMate_A66AC274-9A2A-4104-B81D-144E7F13127D_=--
