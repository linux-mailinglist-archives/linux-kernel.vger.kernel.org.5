Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999567A90E9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 04:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjIUCbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 22:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjIUCbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 22:31:38 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A5DE4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 19:31:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guHoHDvgbPkKHLDDxBsUDng65kBhYhys/C0ueArKH6n/R9xVeGea8iIkyhyX4y42cBpqK4vo4W8nkf/xQmivAUYrBlJPGy9CsKb/P5qiYavaWSqPX1AvsHMP0Qc0yFJ4Mr3gIx89jCasRgFZKdjrgLL4uxW7FEdOpekOcShwbqN9dEa3bkrn0xBmr+K5XDZr/1YBKdkKPrvPAG6aUcYwbUO/SHccQ30RK+A53a9JFBoJwegnRl/GVH8EOpezsVZB1pU+NMrdKFS8KkGckYBDM3mJXiYeQKhnVm1920VLL4EeZwnTKoQ4palZ92ea9iquP48G32kJ9BVSaJvLRSroPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAETsPNPbi6N+FFq0Izh2F125diD6hVLtGJkcUS3GvA=;
 b=Mb9Qu/zToxUIkrOGl7xvgAO/Si6F+WY+XAO7lxDQA15IyqFyFZ1WYEBboywUxeS+orjM0eDr+UYX2lfihv1KX8TBHW7CVUFbC8K9UTSUHSSy5VR6T13l8h098yfW1eDxSid5nHPkIv+fnxQgLbj1Q1N8V3gDCZxEyt4FVEuczomhrDH8zugu/+JhFwrTJqlS2jy4PeBQYT29fWeuheT+vnIpxxRC9dZxxnuhEBgtyHmwOzYwDYw7AUWhn7UicTBWoTryzyR2+8dbXRzvecdMgILLEXszULRSascFPi4mu1HMN/Z3tyUzAIVOX5e2ogBeNttVwSGznU8e/hRzPzX9YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAETsPNPbi6N+FFq0Izh2F125diD6hVLtGJkcUS3GvA=;
 b=JfRy4KDMZnaDC/Lqu44IwY2f6DzoH1P1CP11aMHoMuQCu8BZbM2MvSpdFstJG9hiP/F91VQ/faYNg2o3/5bMbPT2FVy9cHRpO6zQUgBq158cGY/yKEj1IGfa1rL7+aOyKTECVlAEqy6jtVxljojz74pyUqeqGpJQjYybUtoGS/FAF/9HtrzpLWKbXMp/mbSGld2c09mINfKE4pLi4aOze1xgznr196sn6TLjUbnov7wN5hM+U6gjdh2t05/z6/YDs3V+Xpe7xMlH3g7Nvm2b94Uw6N3TF3o18P+nNd/Pq7hvzR8mKglpQSp/b18qMby3juUIcq+TQQxQYTjINIqkcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Thu, 21 Sep 2023 02:31:29 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 02:31:29 +0000
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
Date:   Wed, 20 Sep 2023 22:31:24 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <D4F59724-61EB-4DA5-94DF-59E79F0F1FB3@nvidia.com>
In-Reply-To: <762CA634-053A-41DD-8ED7-895374640858@nvidia.com>
References: <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
 <20230918145204.GB16104@cmpxchg.org> <20230918174037.GA112714@monkey>
 <20230919064914.GA124289@cmpxchg.org> <20230919184731.GC112714@monkey>
 <C416A861-44D3-46E7-B756-63DA3731FC1E@nvidia.com>
 <20230920003239.GD112714@monkey>
 <149ACAE8-D3E4-4009-828A-D3AC881FFB9C@nvidia.com>
 <bc4bd049-1e29-0f23-cca6-493abb5e774f@suse.cz>
 <20230920134811.GB124289@cmpxchg.org> <20230920160400.GC124289@cmpxchg.org>
 <762CA634-053A-41DD-8ED7-895374640858@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_720299E0-A553-4AE1-8D14-70F247A4ABA0_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: YQBP288CA0007.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::11) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 877c03a7-72b1-4db1-ad31-08dbba4adc45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2JCfl4W869yYfD0Y+AVkdZhNJr//atbL2ElWT+ONDsMXvVg9Id3Cj6wqkp87JaeL/tQSzMgHFBKMA4kZFsBseXz+vKOn1qOws/tEWwlYfFzuAfrPpJKnB7gGHa6x+ymBvyJxpqpaCvKwl46PxvX3q2Arng03d5C54yCTRJhxjQ/7yI+F9JMjbUsCgCzaFOBODPtM/XMmwQeMAbPpaDN0UQTYfyFtWZdmaWSV3rf2cHrl6Ye69wi5qjbuvQT+K7lNLecGkQoRauz9yRROHANRPmS8a3rF8//3ZS5H8G3Sa1hhHFWVr0ahLStecjHMof1TUZIPLGKvwGykYsloBcWLaAegy8fSCd4Khz+qvMbC0xcJy5UmJhoLNAa77jlCJF41pUCSw086+1AeTIljxLV1n0rN0Q0pTBjGfeCUaAUPS6iYq12cfts1+cUKWdcD/82NkmoVGpGbd4mkaDlpPnXHAgKTlnRTs5t4H9u7c0HXx5dDquE3P2Nw8kwV17JQBbGszN3bLCqp+LIQ0ChnpzhiCZW0GV0OyYJW/PlnkG+dyf0JTzpDd8lnqViWtJ2jpnRZ0ZK5K92hB3KPhhy0DmOMoNe1ZgBrWxzGNfOLc9roRHCH7ovDzq61dPbGfyxKtQ/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199024)(186009)(1800799009)(83380400001)(6506007)(53546011)(6512007)(4326008)(5660300002)(36756003)(2906002)(6916009)(7416002)(54906003)(235185007)(8676002)(41300700001)(33656002)(8936002)(316002)(478600001)(6666004)(66946007)(2616005)(6486002)(86362001)(38100700002)(26005)(66476007)(66556008)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GzWBJbpStkoPrfxolXL4RZzXkk2B5QsIDX/5gzEqHyAH7RtGz2nJC7P29d6Q?=
 =?us-ascii?Q?zHKRyJ8TOSCL3JJSbvs9uXeR4URAwN56bZ2WB5nFe+PFlqgnWV4GVh18Auxd?=
 =?us-ascii?Q?KI/qr8n4dlwjgKa9Nt2LWui63PEcAxgIqs4OVP/otFvz4oGTOy3tQ4MsebBL?=
 =?us-ascii?Q?evPC2xtRyZdCIdsW6gwTGYAM8u2kUy8DkB28PZ9BZcDoXY6IgVKzVmVhMs51?=
 =?us-ascii?Q?dyzJmMfUOfO/7DRwTYQcT8t95YjiVNc8Xpm3kmyqybDMl6+8mKa0XsGpg+Rh?=
 =?us-ascii?Q?LU5it0rA1EoMMMIZNJa1hUQ2DJbHt7f5xzKMy8M/LcOugQuIR0EYtdJQ0tOb?=
 =?us-ascii?Q?dlhR7XvAzLCL8uX45eMfvbUm2RYGPChTIITCzBp4/TVdw9LI3ns61DuBbUb6?=
 =?us-ascii?Q?30xVmZ73P3zLSqYI3EBDuIauQa1/4cgecbwWkFBiXrYX2Z7vICVih1wUICOA?=
 =?us-ascii?Q?qYzHDwa4JWfUbu55tkeW/sk9kLOVMQYz/uUAtI8YPSLzr9bLKKpnb20jEDX1?=
 =?us-ascii?Q?Vc5p4mTr9hzTyw8oOP0jJI7Kab57AzgFp5j7S6B0OOC6g2lWMF8yI+osPQ+T?=
 =?us-ascii?Q?vuSLQi2VIntb3gopuUyL2WNqE5CT3U98bXPuxr/I7UaNgoQHaUjBjyvGwO5n?=
 =?us-ascii?Q?zHDuCkN/DfS+FPa0HVQzNpgGgYF4fPg1ReH4rk48m9T0PcUPeUHWP7BL60LY?=
 =?us-ascii?Q?hvvwAltwHF5F2ZNKcINgPCuujGWjIpmE3e8YTZTstPmSLkNBflKpphXr/L3b?=
 =?us-ascii?Q?YaEeMz7FqPlZikLfZ/l89h5vxRqPHbHgiZvODw4yuy4sdzZKE8EoDiyj3H7W?=
 =?us-ascii?Q?/MCrzd+PAnsqSeFD5E+ZhYZjDcJvPrjaQoSmQwm/9zCqLvfmUWIM8yCb7dze?=
 =?us-ascii?Q?XZYngi+1ciRjcZfVtx8YfgEjqsB/CPV8YXde3qgPYCg9tG69DMG5kfQFL+Ah?=
 =?us-ascii?Q?I9y0jncLo5urk+JJwP5JCoQtRrzZzzriCUhBxltOFk0+D9ou4dG6RXLSP22v?=
 =?us-ascii?Q?CsJq5SlnN9HVvPhDJU7gbVQ2x9cJPO1LlVz3Ygk5ilWB+ybGXjd+PDWl9IL9?=
 =?us-ascii?Q?tBks1D+5rUB93HLP8+XM13/QgouljXU1gebrs2ZzjrJzaCGvAogIn42j8FjO?=
 =?us-ascii?Q?xjSbpihC2dk60XmSSH3GLnEnJjrhX4UL/eDt8MU1bei33FV7R7tFLHbipHCf?=
 =?us-ascii?Q?rxG/8Vgi6EeYTNoZt+jfeFsbSs2wtCF7kzrf3jlm9UGQ7+ZyWrWGxG0C/sbk?=
 =?us-ascii?Q?68YIShEOjnBgMVjyukcX/AFjXrJcA2DS+qgAkopq7V2yM9tegrYte3BCaMzW?=
 =?us-ascii?Q?kwa4wH1+2c7zgF7Eoza0eTLSOCuLm5zW9Pz5+r7jbLcYlijz7rj3CXPEPvGS?=
 =?us-ascii?Q?v73iPz1vL49CfHTlgzJQ979aNdexcvpG9WWi1fHMr14AQXHRNi4oI5JGzJy0?=
 =?us-ascii?Q?tiFnC9pJmFwFcaSYnn+Fb6XwqHHu3+bNpJQFhdL81yEZdZo22sARRWnMWJZM?=
 =?us-ascii?Q?4ZGQAvZONmTiJGCSD3+w7Mto1SInf74A7dqRSu7fhmzbkdoeI63RM1qJI7Z/?=
 =?us-ascii?Q?w03RDCFYtYbT7oGUFDE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877c03a7-72b1-4db1-ad31-08dbba4adc45
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 02:31:29.0746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41+H2KR2knZXhG+HNIp59RJRtda1K7D9b7GVkETL+J1DSFfecyCnv196I1INo1xr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_720299E0-A553-4AE1-8D14-70F247A4ABA0_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 20 Sep 2023, at 13:23, Zi Yan wrote:

> On 20 Sep 2023, at 12:04, Johannes Weiner wrote:
>
>> On Wed, Sep 20, 2023 at 09:48:12AM -0400, Johannes Weiner wrote:
>>> On Wed, Sep 20, 2023 at 08:07:53AM +0200, Vlastimil Babka wrote:
>>>> On 9/20/23 03:38, Zi Yan wrote:
>>>>> On 19 Sep 2023, at 20:32, Mike Kravetz wrote:
>>>>>
>>>>>> On 09/19/23 16:57, Zi Yan wrote:
>>>>>>> On 19 Sep 2023, at 14:47, Mike Kravetz wrote:
>>>>>>>
>>>>>>>> 	--- a/mm/page_alloc.c
>>>>>>>> 	+++ b/mm/page_alloc.c
>>>>>>>> 	@@ -1651,8 +1651,13 @@ static bool prep_move_freepages_block(st=
ruct zone *zone, struct page *page,
>>>>>>>>  		end =3D pageblock_end_pfn(pfn) - 1;
>>>>>>>>
>>>>>>>>  		/* Do not cross zone boundaries */
>>>>>>>> 	+#if 0
>>>>>>>>  		if (!zone_spans_pfn(zone, start))
>>>>>>>> 			start =3D zone->zone_start_pfn;
>>>>>>>> 	+#else
>>>>>>>> 	+	if (!zone_spans_pfn(zone, start))
>>>>>>>> 	+		start =3D pfn;
>>>>>>>> 	+#endif
>>>>>>>> 	 	if (!zone_spans_pfn(zone, end))
>>>>>>>> 	 		return false;
>>>>>>>> 	I can still trigger warnings.
>>>>>>>
>>>>>>> OK. One thing to note is that the page type in the warning change=
d from
>>>>>>> 5 (MIGRATE_ISOLATE) to 0 (MIGRATE_UNMOVABLE) with my suggested ch=
ange.
>>>>>>>
>>>>>>
>>>>>> Just to be really clear,
>>>>>> - the 5 (MIGRATE_ISOLATE) warning was from the __alloc_pages call =
path.
>>>>>> - the 0 (MIGRATE_UNMOVABLE) as above was from the alloc_contig_ran=
ge call
>>>>>>   path WITHOUT your change.
>>>>>>
>>>>>> I am guessing the difference here has more to do with the allocati=
on path?
>>>>>>
>>>>>> I went back and reran focusing on the specific migrate type.
>>>>>> Without your patch, and coming from the alloc_contig_range call pa=
th,
>>>>>> I got two warnings of 'page type is 0, passed migratetype is 1' as=
 above.
>>>>>> With your patch I got one 'page type is 0, passed migratetype is 1=
'
>>>>>> warning and one 'page type is 1, passed migratetype is 0' warning.=

>>>>>>
>>>>>> I could be wrong, but I do not think your patch changes things.
>>>>>
>>>>> Got it. Thanks for the clarification.
>>>>>>
>>>>>>>>
>>>>>>>> One idea about recreating the issue is that it may have to do wi=
th size
>>>>>>>> of my VM (16G) and the requested allocation sizes 4G.  However, =
I tried
>>>>>>>> to really stress the allocations by increasing the number of hug=
etlb
>>>>>>>> pages requested and that did not help.  I also noticed that I on=
ly seem
>>>>>>>> to get two warnings and then they stop, even if I continue to ru=
n the
>>>>>>>> script.
>>>>>>>>
>>>>>>>> Zi asked about my config, so it is attached.
>>>>>>>
>>>>>>> With your config, I still have no luck reproducing the issue. I w=
ill keep
>>>>>>> trying. Thanks.
>>>>>>>
>>>>>>
>>>>>> Perhaps try running both scripts in parallel?
>>>>>
>>>>> Yes. It seems to do the trick.
>>>>>
>>>>>> Adjust the number of hugetlb pages allocated to equal 25% of memor=
y?
>>>>>
>>>>> I am able to reproduce it with the script below:
>>>>>
>>>>> while true; do
>>>>>  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages=
&
>>>>>  echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages=
&
>>>>>  wait
>>>>>  echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
>>>>>  echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages=

>>>>> done
>>>>>
>>>>> I will look into the issue.
>>>
>>> Nice!
>>>
>>> I managed to reproduce it ONCE, triggering it not even a second after=

>>> starting the script. But I can't seem to do it twice, even after
>>> several reboots and letting it run for minutes.
>>
>> I managed to reproduce it reliably by cutting the nr_hugepages
>> parameters respectively in half.
>>
>> The one that triggers for me is always MIGRATE_ISOLATE. With some
>> printk-tracing, the scenario seems to be this:
>>
>> #0                                                   #1
>> start_isolate_page_range()
>>   isolate_single_pageblock()
>>     set_migratetype_isolate(tail)
>>       lock zone->lock
>>       move_freepages_block(tail) // nop
>>       set_pageblock_migratetype(tail)
>>       unlock zone->lock
>>                                                      del_page_from_fre=
elist(head)
>>                                                      expand(head, head=
_mt)
>>                                                        WARN(head_mt !=3D=
 tail_mt)
>>     start_pfn =3D ALIGN_DOWN(MAX_ORDER_NR_PAGES)
>>     for (pfn =3D start_pfn, pfn < end_pfn)
>>       if (PageBuddy())
>>         split_free_page(head)
>>
>> IOW, we update a pageblock that isn't MAX_ORDER aligned, then drop the=

>> lock. The move_freepages_block() does nothing because the PageBuddy()
>> is set on the pageblock to the left. Once we drop the lock, the buddy
>> gets allocated and the expand() puts things on the wrong list. The
>> splitting code that handles MAX_ORDER blocks runs *after* the tail
>> type is set and the lock has been dropped, so it's too late.
>
> Yes, this is the issue I can confirm as well. But it is intentional to =
enable
> allocating a contiguous range at pageblock granularity instead of MAX_O=
RDER
> granularity. With your changes below, it no longer works, because if th=
ere
> is an unmovable page in
> [ALIGN_DOWN(start_pfn, MAX_ORDER_NR_PAGES), pageblock_start_pfn(start_p=
fn)),
> the allocation fails but it would succeed in current implementation.
>
> I think a proper fix would be to make move_freepages_block() split the
> MAX_ORDER page and put the split pages in the right migratetype free li=
sts.
>
> I am working on that.

After spending half a day on this, I think it is much harder than I thoug=
ht
to get alloc_contig_range() working with the freelist migratetype hygiene=

patchset. Because alloc_contig_range() relies on racy migratetype changes=
:

1. pageblocks in the range are first marked as MIGRATE_ISOLATE to prevent=

another parallel isolation, but they are not moved to the MIGRATE_ISOLATE=

free list yet.

2. later in the process, isolate_freepages_range() is used to actually gr=
ab
the free pages.

3. there was no problem when alloc_contig_range() works on MAX_ORDER alig=
ned
ranges, since MIGRATE_ISOLATE cannot be set in the middle of free pages o=
r
in-use pages. But it is not the case when alloc_contig_range() work on
pageblock aligned ranges. Now during isolation phase, free or in-use page=
s
will need to be split to get their subpages into the right free lists.

4. the hardest case is when a in-use page sits across two pageblocks, cur=
rently,
the code just isolate one pageblock, migrate the page, and let split_free=
_page()
to correct the free list later. But to strictly enforce freelist migratet=
ype
hygiene, extra work is needed at free page path to split the free page in=
to
the right freelists.

I need more time to think about how to get alloc_contig_range() properly.=

Help is needed for the bullet point 4.

Thanks.

PS: One observation is that after move_to_free_list(), a page's migratety=
pe
does not match the migratetype of its free list. I might need to make
changes on top of your patchset to get alloc_contig_range() working.


--
Best Regards,
Yan, Zi

--=_MailMate_720299E0-A553-4AE1-8D14-70F247A4ABA0_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmULqvwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUP5QQAJAvRq7b2SPt3BU2nszsKEtmk9SqgVrxU8TK
nRhBU/m/xS89xYfGH3PGyCkne9Lk6llbaU16q5FVtVAHwOMLRDh6khivgcV8ZF3j
xdKwzbKl2JFYWVfF4/rJGdD+6IuHMQV4iqKoCWMyy3VQt1aeORbkGmnS3F1W+M+n
noaIVVEYHQrmBbdI5qub2y6xe4ECnZPHUamWF6Uae8Af6s4IY8nXIZiIF5iiwB4A
QNa2QP3V2azQWZu4qpHMwPFNHdd0qcB2IvjbIzr6C7ZP6joLYaNQMZkswb2O1kHB
12icZzSDMgRTfwlwN/l80fLqepyD4WgTswFOBl+1R9kLlOf1zooBA4+U7j4r6yGd
qfgQOrtxaDuzsCxaiTZdv7kvyHKe6UQsgYFvGf9wAukcrkKKstln86tIKPsmbizd
PlQli+EcY/WQqSIoPOcf1aJWFEWJ1d1XfKNUeI1qgrJeXfKUNE5YBMPtIHK2K2wd
j/C1vpesTDSIhTpoVn6CKX/73KkkOtW1pHEEgvz1Mzr34Od8l5jg3qh0hKs9OT4s
DZTR9tORN678VjoeR/1aO4FjvG0YY/qEP0Ka9fxhbDpFcS7Y8i3Tlllbymcp3hV6
yu8JWd/NyKtfHRRtu1i7BQzzfVeUGlttiKYbZdjLqIqj5J5OhexPN9OxvWY/d4Xt
ovIHyXhZ
=2tAo
-----END PGP SIGNATURE-----

--=_MailMate_720299E0-A553-4AE1-8D14-70F247A4ABA0_=--
