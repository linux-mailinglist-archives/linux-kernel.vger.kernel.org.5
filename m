Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD60B7A8A7B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjITRXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjITRXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:23:34 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B30A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 10:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kv/2zxsUSWk4dX70Ts6FlIbsYn593cjd8CN/RFELeXZICGtsn8VuKXRBEaw7DcICAlFjn85sy+K/1QSijgWQyXmCr/urWvA1+OAP9SYfOEJAO7vtW0ws3Mq3fFZ7DRrkU29Ctn6RPeX7HyIhNmaz1lfdBZ/54QoPlhu+TOqPMLlbEWjJ7DPffz6MrEaQA4XRuy4luTmW4LzlIF2zeTmDowWGDrXimC4NBoJ0i+2cvM3v0hj6g0DJEqR0nBDdvjOhZjk+y8rnPEjlYeGHTcBsZtFxXFJZgEwIOvdLo51K8iXZu7cDc7F49zNEdBNdOxRLc4WgFROKjUWlhOX9YanTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozVANTRG0aFsAyJAB0IrqcYk2oSeRz49qpee3Msd1K0=;
 b=n7Ctx+NLmWYHgrl+jIXKvF6ioFymTdEu5xgJIRTez+mDbAndYvxWkHasO6U52SiDeVL5h58aOWxwujy15/qgdsrOFQ1xApVQdgdvDYhp8poPwM8K/3ryMExhKug56mwNwlvGOJccKr4hbtzkCsapzsBw7RYUdl6w0MMTD+cK1tExkQCmn5g2MARnByYQWQOVK7sssHnfbXxylR3NkvpuOfDjOxYcgmzcfL5Kaxjls5lLbUEaAsSoKZ7dopk3BY8eWUO5Ric9j8leVmYFirvOVOxjv4MsM0eBD18a1nuqfaZZLKqBnTmYqq0aZH2alWpiQNojZS3o7DmsEFJNTGNtOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozVANTRG0aFsAyJAB0IrqcYk2oSeRz49qpee3Msd1K0=;
 b=m5r0KMOulnB13m/6oNzcgOq71dwmyhSvpyM6jVqM37jww2mKe44dP3kwNN7V1niekT8cyMIlQ2HOyjy4UFoRjdhHZT7I9zEgt1owiAw38q0Y4Q7gW+PWZFeXtfeSzg6Dm9BkAL3cpoQMdVGuLUt7FS6+6CmM/YzSfLOYtEFeCaPBWLQk3rIiWbZ9meAsUOzyFEkkQwGCQs8Ni9YY/NgYWMu+1MZ0Do84f7hTAoZt3ZWT0pIgx8FBY6Wx6K5D5dsEBUJxQkJ1Vb85bmYNbnhlgs8AwiuKtTiUe3o2lqi2uNHk0kM6+XAAwskZnrAZ7K/n/gG8HlSosgrLsPoAPIhSbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 17:23:22 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 17:23:21 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Date:   Wed, 20 Sep 2023 13:23:18 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <762CA634-053A-41DD-8ED7-895374640858@nvidia.com>
In-Reply-To: <20230920160400.GC124289@cmpxchg.org>
References: <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
 <20230918145204.GB16104@cmpxchg.org> <20230918174037.GA112714@monkey>
 <20230919064914.GA124289@cmpxchg.org> <20230919184731.GC112714@monkey>
 <C416A861-44D3-46E7-B756-63DA3731FC1E@nvidia.com>
 <20230920003239.GD112714@monkey>
 <149ACAE8-D3E4-4009-828A-D3AC881FFB9C@nvidia.com>
 <bc4bd049-1e29-0f23-cca6-493abb5e774f@suse.cz>
 <20230920134811.GB124289@cmpxchg.org> <20230920160400.GC124289@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_3B7556AD-BEAA-4AA3-8C02-D947E6AA43FE_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:208:32b::18) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 866729ee-02e2-4f32-c69b-08dbb9fe4a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPc1N4nnsW+lsWcW9t+FpHgROQAkxx7sbkyF7+UNahvhUnbycwq3mvu35n5JVjLaZCxhKF0ldqUSr2UfDou2ncyM85SLE2M1jrkZez9EQFY4tP+6A/pVQZ+pC5hsqZhTJw/Bv3PF/vhXa3FDIqHlTbKok6SghYKFfo5kGFSLegq6OPBseBrWiMDPl8u609WZQWRmT13MNcsXVaF0wQe6x47jUq7YZ9t5jD1PPO+UbobBFaidb8Xqj5rPh75Wn3HaSpEY7XvsJ6++mTWxovfyFT1SDtQXIoXhwUkVbTGAvsIrWE9k3fipCDZzYqrJ+oROXxXcL2eG8Pww2mT04C02r8Z8NcLcl59NAMWuQlTS90NSp5+hnAnfd3hKzv+fXkkj38IZiInMAc2Uq6FCqXImynrxunoptpZkN+EdGWJqyI25m3rgTulOlHSgmshuHNyMoNwMCqoRab0DDGVUHT6nillPCjectyfhxL8pGwVOpBu449UDjLRihCTmqiOMa7dJlC0A5sH9KoHYNV83dsWKLEp0RYnAamVkwXdX9r1jsNjZrI40ummTSVF6QppfX9KTT3jkRfTfL9/U7F2FkeG22Wz/mgVCOBRHvohoXlC6IfpUXSAI/ylz83w4EkXxN8o+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(186009)(451199024)(1800799009)(7416002)(54906003)(66476007)(316002)(6916009)(66556008)(478600001)(38100700002)(66946007)(2906002)(235185007)(8936002)(8676002)(86362001)(5660300002)(41300700001)(83380400001)(6512007)(6666004)(6486002)(53546011)(6506007)(4326008)(2616005)(26005)(36756003)(33656002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1H9wabO3DsdRsOPwiEdNIlzul0JReg6Tz2FtoRyjKVLzP7XiXCQ1j8rGsCQy?=
 =?us-ascii?Q?YE/OkWnbIuMB8/ZKtUH+boHilZMk1+XGqLSYnvoe+ZDz2u0klORpkaxVsKk4?=
 =?us-ascii?Q?c+4LLqWObZkmSuo26SKlRj14e29HtuHsPh8xM4cNRmXGxGSionu4S1x3g0Xj?=
 =?us-ascii?Q?D/Z8wPUK8LsnsFz4XslNU92dBFzdeh2wfAuVc+09gmKQowzUJJhLNmgvRSIH?=
 =?us-ascii?Q?KKf//8sKAdbrk4c7/g39dVznKC6RmOou37yGNPwEVgP14ahi2UbGTek82Tsm?=
 =?us-ascii?Q?HL3RwJBX9F16L+MdkM8B1QY2o+xGjqMw15yDQ/KqcX3dV4E8FQncI0lTVHGK?=
 =?us-ascii?Q?gf8o4HGhHuQaJaCVbN8GzBIgF3llbCiyEq/4HvIqDoPbRUqW8q/FPsavNHa1?=
 =?us-ascii?Q?0hkRQ7De77Y+a3vA8kIK1FVJF9WCw/iYig/6/0p4ahXXJMgJRL59XDmNKMV8?=
 =?us-ascii?Q?VChhD2N4UQ5m/a75rYQrjd0Vwu6QDv9n5/w/Oe3VxbS9aPhLZ+OwZUbb5jKp?=
 =?us-ascii?Q?b0M0q+YGSgxmLWcaBNWPB8CmmlUlyIHmu6sbkEBP8E6IaH33mfr/hpuvQQHB?=
 =?us-ascii?Q?NAFyRg6H5g+kT4vMTJvayOgv7eZjyCxNMHmAfx19ia9JrIFM3JhywqF+UxiW?=
 =?us-ascii?Q?JGJmIc9rwB1FY0uIxsJMHTOSxJJ8TBLfNSgTdMtDpDLrngSJ0HKcYGJnpULH?=
 =?us-ascii?Q?qGzsjtA9nc1FGtxFp2HfB5bgv39ct8axpRoeKPtZweswin6O6VnVTZ5h6KNp?=
 =?us-ascii?Q?PrEhlS8Te7Umt0oH+R7PhE1INWiY1b4+28E2pj2lRoqWT9crmRyDPkZtY2aW?=
 =?us-ascii?Q?FfCl8IKE7uHzF5Suert1En0CZbLUlUecQ1PDeeY+7OVAup1wOGzEOOYRB9A2?=
 =?us-ascii?Q?S1UPciyCbLtTmPceKU9NqrkTaSFqH1w6zSvSVV4VrDh5eMWK4WV5OIX9NU6T?=
 =?us-ascii?Q?BRhGNizr5C0gVpfNIZcfb5KcyQXyK0C/F2TQHx1mPWoKeiihWcK8TaXquhLe?=
 =?us-ascii?Q?gISo+VqEvTB1PIM5ugdK1R5h5HT0cXCdcIDXLECibbWjVjWGJd7iv4SsGsOS?=
 =?us-ascii?Q?NGq0Uq7jHim7uF3KPxxLy6QFnAlRDWZ9OZ6fyqWqZs7TYW5VVXyVODUyzLrR?=
 =?us-ascii?Q?NZBNfHyGQKtR1b8DvtPKBczfOx5A9jrdge0qLhvSbk2ly788WK/ryIDIqJuN?=
 =?us-ascii?Q?8JGGePYxGyVEiQLMyz6jpUnBgFTzEIPKGWBwr+T9TeYw1boQk2PR1cBwAhmp?=
 =?us-ascii?Q?PX+4p3a6+ce4QM6JrIi8uX+qaMKn7f7czds9bTdxx1VBZ2G14XptHsYmqITY?=
 =?us-ascii?Q?M3tA/ORG6dXE4LzjrwSENOO1LSE7QHE1Qe7oki+4OGV9YEM1AvPLLqdZPmLJ?=
 =?us-ascii?Q?/cDgTMtzxfs7fzEowiEdAVeKAfp3/TKrrLWfrowfQOgjLHsLeBKo8MYoS0th?=
 =?us-ascii?Q?g9UuuIUSXQOJw4HN49AjJdhW9Igni4pCGlTdH53YXbRgKKYyixhn+M+khUpP?=
 =?us-ascii?Q?T08D5t9iK6BrzbYWX45I8wInD0JER5JCE1fT3HHn3rtnTusoW9wLGekWvHkf?=
 =?us-ascii?Q?rZeBtwNnC84ec9Q2Rkc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866729ee-02e2-4f32-c69b-08dbb9fe4a09
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:23:21.9323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYM8dSkh0IjiChZDwaFAB8JdNvX+DQu7CFMG4intDoB0faC6dNadUAVHDpQs905N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_3B7556AD-BEAA-4AA3-8C02-D947E6AA43FE_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 20 Sep 2023, at 12:04, Johannes Weiner wrote:

> On Wed, Sep 20, 2023 at 09:48:12AM -0400, Johannes Weiner wrote:
>> On Wed, Sep 20, 2023 at 08:07:53AM +0200, Vlastimil Babka wrote:
>>> On 9/20/23 03:38, Zi Yan wrote:
>>>> On 19 Sep 2023, at 20:32, Mike Kravetz wrote:
>>>>
>>>>> On 09/19/23 16:57, Zi Yan wrote:
>>>>>> On 19 Sep 2023, at 14:47, Mike Kravetz wrote:
>>>>>>
>>>>>>> 	--- a/mm/page_alloc.c
>>>>>>> 	+++ b/mm/page_alloc.c
>>>>>>> 	@@ -1651,8 +1651,13 @@ static bool prep_move_freepages_block(str=
uct zone *zone, struct page *page,
>>>>>>>  		end =3D pageblock_end_pfn(pfn) - 1;
>>>>>>>
>>>>>>>  		/* Do not cross zone boundaries */
>>>>>>> 	+#if 0
>>>>>>>  		if (!zone_spans_pfn(zone, start))
>>>>>>> 			start =3D zone->zone_start_pfn;
>>>>>>> 	+#else
>>>>>>> 	+	if (!zone_spans_pfn(zone, start))
>>>>>>> 	+		start =3D pfn;
>>>>>>> 	+#endif
>>>>>>> 	 	if (!zone_spans_pfn(zone, end))
>>>>>>> 	 		return false;
>>>>>>> 	I can still trigger warnings.
>>>>>>
>>>>>> OK. One thing to note is that the page type in the warning changed=
 from
>>>>>> 5 (MIGRATE_ISOLATE) to 0 (MIGRATE_UNMOVABLE) with my suggested cha=
nge.
>>>>>>
>>>>>
>>>>> Just to be really clear,
>>>>> - the 5 (MIGRATE_ISOLATE) warning was from the __alloc_pages call p=
ath.
>>>>> - the 0 (MIGRATE_UNMOVABLE) as above was from the alloc_contig_rang=
e call
>>>>>   path WITHOUT your change.
>>>>>
>>>>> I am guessing the difference here has more to do with the allocatio=
n path?
>>>>>
>>>>> I went back and reran focusing on the specific migrate type.
>>>>> Without your patch, and coming from the alloc_contig_range call pat=
h,
>>>>> I got two warnings of 'page type is 0, passed migratetype is 1' as =
above.
>>>>> With your patch I got one 'page type is 0, passed migratetype is 1'=

>>>>> warning and one 'page type is 1, passed migratetype is 0' warning.
>>>>>
>>>>> I could be wrong, but I do not think your patch changes things.
>>>>
>>>> Got it. Thanks for the clarification.
>>>>>
>>>>>>>
>>>>>>> One idea about recreating the issue is that it may have to do wit=
h size
>>>>>>> of my VM (16G) and the requested allocation sizes 4G.  However, I=
 tried
>>>>>>> to really stress the allocations by increasing the number of huge=
tlb
>>>>>>> pages requested and that did not help.  I also noticed that I onl=
y seem
>>>>>>> to get two warnings and then they stop, even if I continue to run=
 the
>>>>>>> script.
>>>>>>>
>>>>>>> Zi asked about my config, so it is attached.
>>>>>>
>>>>>> With your config, I still have no luck reproducing the issue. I wi=
ll keep
>>>>>> trying. Thanks.
>>>>>>
>>>>>
>>>>> Perhaps try running both scripts in parallel?
>>>>
>>>> Yes. It seems to do the trick.
>>>>
>>>>> Adjust the number of hugetlb pages allocated to equal 25% of memory=
?
>>>>
>>>> I am able to reproduce it with the script below:
>>>>
>>>> while true; do
>>>>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages&=

>>>>  echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages&=

>>>>  wait
>>>>  echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
>>>>  echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
>>>> done
>>>>
>>>> I will look into the issue.
>>
>> Nice!
>>
>> I managed to reproduce it ONCE, triggering it not even a second after
>> starting the script. But I can't seem to do it twice, even after
>> several reboots and letting it run for minutes.
>
> I managed to reproduce it reliably by cutting the nr_hugepages
> parameters respectively in half.
>
> The one that triggers for me is always MIGRATE_ISOLATE. With some
> printk-tracing, the scenario seems to be this:
>
> #0                                                   #1
> start_isolate_page_range()
>   isolate_single_pageblock()
>     set_migratetype_isolate(tail)
>       lock zone->lock
>       move_freepages_block(tail) // nop
>       set_pageblock_migratetype(tail)
>       unlock zone->lock
>                                                      del_page_from_free=
list(head)
>                                                      expand(head, head_=
mt)
>                                                        WARN(head_mt !=3D=
 tail_mt)
>     start_pfn =3D ALIGN_DOWN(MAX_ORDER_NR_PAGES)
>     for (pfn =3D start_pfn, pfn < end_pfn)
>       if (PageBuddy())
>         split_free_page(head)
>
> IOW, we update a pageblock that isn't MAX_ORDER aligned, then drop the
> lock. The move_freepages_block() does nothing because the PageBuddy()
> is set on the pageblock to the left. Once we drop the lock, the buddy
> gets allocated and the expand() puts things on the wrong list. The
> splitting code that handles MAX_ORDER blocks runs *after* the tail
> type is set and the lock has been dropped, so it's too late.

Yes, this is the issue I can confirm as well. But it is intentional to en=
able
allocating a contiguous range at pageblock granularity instead of MAX_ORD=
ER
granularity. With your changes below, it no longer works, because if ther=
e
is an unmovable page in
[ALIGN_DOWN(start_pfn, MAX_ORDER_NR_PAGES), pageblock_start_pfn(start_pfn=
)),
the allocation fails but it would succeed in current implementation.

I think a proper fix would be to make move_freepages_block() split the
MAX_ORDER page and put the split pages in the right migratetype free list=
s.

I am working on that.

>
> I think this would work fine if we always set MIGRATE_ISOLATE in a
> linear fashion, with start and end aligned to MAX_ORDER. Then we also
> wouldn't have to split things.
>
> There are two reasons this doesn't happen today:
>
> 1. The isolation range is rounded to pageblocks, not MAX_ORDER. In
>    this test case they always seem aligned, but it's not
>    guaranteed. However,
>
> 2. start_isolate_page_range() explicitly breaks ordering by doing the
>    last block in the range before the center. It's that last block
>    that triggers the race with __rmqueue_smallest -> expand() for me.
>
> With the below patch I can no longer reproduce the issue:
>
> ---
>
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index b5c7a9d21257..b7c8730bf0e2 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -538,8 +538,8 @@ int start_isolate_page_range(unsigned long start_pf=
n, unsigned long end_pfn,
>  	unsigned long pfn;
>  	struct page *page;
>  	/* isolation is done at page block granularity */
> -	unsigned long isolate_start =3D pageblock_start_pfn(start_pfn);
> -	unsigned long isolate_end =3D pageblock_align(end_pfn);
> +	unsigned long isolate_start =3D ALIGN_DOWN(start_pfn, MAX_ORDER_NR_PA=
GES);
> +	unsigned long isolate_end =3D ALIGN(end_pfn, MAX_ORDER_NR_PAGES);
>  	int ret;
>  	bool skip_isolation =3D false;
>
> @@ -549,17 +549,6 @@ int start_isolate_page_range(unsigned long start_p=
fn, unsigned long end_pfn,
>  	if (ret)
>  		return ret;
>
> -	if (isolate_start =3D=3D isolate_end - pageblock_nr_pages)
> -		skip_isolation =3D true;
> -
> -	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock =
*/
> -	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, true,=

> -			skip_isolation, migratetype);
> -	if (ret) {
> -		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
> -		return ret;
> -	}
> -
>  	/* skip isolated pageblocks at the beginning and end */
>  	for (pfn =3D isolate_start + pageblock_nr_pages;
>  	     pfn < isolate_end - pageblock_nr_pages;
> @@ -568,12 +557,21 @@ int start_isolate_page_range(unsigned long start_=
pfn, unsigned long end_pfn,
>  		if (page && set_migratetype_isolate(page, migratetype, flags,
>  					start_pfn, end_pfn)) {
>  			undo_isolate_page_range(isolate_start, pfn, migratetype);
> -			unset_migratetype_isolate(
> -				pfn_to_page(isolate_end - pageblock_nr_pages),
> -				migratetype);
>  			return -EBUSY;
>  		}
>  	}
> +
> +	if (isolate_start =3D=3D isolate_end - pageblock_nr_pages)
> +		skip_isolation =3D true;
> +
> +	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock =
*/
> +	ret =3D isolate_single_pageblock(isolate_end, flags, gfp_flags, true,=

> +			skip_isolation, migratetype);
> +	if (ret) {
> +		undo_isolate_page_range(isolate_start, pfn, migratetype);
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>
> @@ -591,8 +589,8 @@ void undo_isolate_page_range(unsigned long start_pf=
n, unsigned long end_pfn,
>  {
>  	unsigned long pfn;
>  	struct page *page;
> -	unsigned long isolate_start =3D pageblock_start_pfn(start_pfn);
> -	unsigned long isolate_end =3D pageblock_align(end_pfn);
> +	unsigned long isolate_start =3D ALIGN_DOWN(start_pfn, MAX_ORDER_NR_PA=
GES);
> +	unsigned long isolate_end =3D ALIGN(end_pfn, MAX_ORDER_NR_PAGES);
>
>  	for (pfn =3D isolate_start;
>  	     pfn < isolate_end;


--
Best Regards,
Yan, Zi

--=_MailMate_3B7556AD-BEAA-4AA3-8C02-D947E6AA43FE_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmULKoYPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUahAP/0Z1CTfEbL2S4xW1Nxw45hVzdHeqLPuOYkud
m4QTadpl6UOUDoKoo+kpBjdmROUu0o0gYTBT5lbb2wWwNshIC8pNb1gfa4Yn99ZB
CXwJT3v23jviMkXaOPqzU7USY9DlCjJzC/hQAU5ctlnKZy1YD5xh31/FiEcq9buL
MukZ2Rs5WUkK/2B4vNvTz+B1kPXbhw0TadLViqaxkI5UUafnqx6XhMyqXZa5ftSu
z/5R/PGyYCYThJ+e5T0uayfvskGXeN5d5WrBCVbOcrPFGxLIDHqFQS4JZ6yTaxKi
z+NOf3yUpQi+7pMLQeGT1ZQFAnqlxb+bHtbW2ozg+3Y2HT/DDSgoJff4EnEIMH/U
MWtXuL6tT13LMY2ch3fEBbC3Z2Yitl2ShLyEMCOEjXCynZ4Fbx4M+bYUn18OonJi
hWhjYXMtfv+QgSgUEcWfNfvvWZTTi9GCf9C8UsMJuHeaCdS4h/+Z8fQOTCXlcSQW
Q55IC+1DXVGjdyT1zAaIemRVhHP4RPM0Wib41Ihs65GI08XnSgFM4eqGKOwPvwma
DlHFwhIHGN67dl4Fq/tAJALQWnJ1SWGgslH9oPpWo1Q1F4wO7SY8Lx0ZhQi6cRCJ
uFiSJLIIO3xUn/RpyfKXc/G0oaEIZ/3MxBsy45mXiapHSqUcaJB1DZQvRRXFZ2aN
b7LtUsLq
=Yu+t
-----END PGP SIGNATURE-----

--=_MailMate_3B7556AD-BEAA-4AA3-8C02-D947E6AA43FE_=--
