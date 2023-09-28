Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD427B1126
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 05:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjI1DWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 23:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1DWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 23:22:43 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC00599
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 20:22:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bg7PdOcv6eNMd32weH97P5lwXZpi33x/5C5F6iS9gEalJJU9wuqBbZodSONpELG3oHYcy3PPMg9u+dxAMMgr+1mAhO3KH/3hFi/xg3z+VskZnrwv4EAzxpEME4ILDbYBfBvzdKvyM6o9JkEL4MbGPaZTly2TF4PBCH1mXVQkSHqJEutUY/MoqTXs+RkLWW4cQQl79CRRKMjumq7NWJWi9E3MyZCMGYsc5wUauhWRjxyLgMqeS+l33mLpeLNVibkCswZ15BvFXtAxY6Us+98CMCjimb3o0mV/YgOpESlJpmeejr8DbweKtpcHEKt7Xrkf5HaiGkNOFUyhdjfmShPrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJwTvgqDcKTvHxq0DYa422ORBBs3ohM0Mx1elswKZyE=;
 b=T+a4qsu0pt01i1p5MgiToaNV/ti0dUN2UKcdECdgCpdyv7k9daigSEpmdfadstCUlo/ysWcKrNhNLWGAtIg6Ftmgq0C1P1/6YmaH4hVQFm3QH8HJPy16mCxEwiSDc7INv80S5gMERf3nwlnTBu2zIEWqPrZjVKU5viFXpGvCVjRvu25nJGgcdN4HgJu3PcoBunjRfANKP3EqTdkfkUmQCYEU/eHRcwSeCiYqxidQT+o1BTBHLJ5ML0YZnHNmd7NAaET99G66vcwVXWpjABPg0xbhwPOCoI8HQreMTCacFN/3JU4hAzGwOoCAktctFyLRT4yYqt+IocqhnoYeQv1AIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJwTvgqDcKTvHxq0DYa422ORBBs3ohM0Mx1elswKZyE=;
 b=uNQ9OYXsnwyQmFtRX+oKuqrpL3wgqSSJ6oYPzye8Pu+BCADWNLa4QLUgo9rdn2Kz7gsq4903Sz3U69RR0IiuBaxhVNQ75EVtHAzLj3c2g/CQ9Pb1w522nB2rkxmpZubjDlqv+GYB6mTTzx+AiNdIFp7DQWvewxdYz3EfzJOit9+MSIvnBgXC13kFD/JlVc0muzpMGROxSf9+MrpxTn72pAWWVD9k/BJBsaM/h6jXqCKlyhATOeXu+zbrhy3KQqHTNqAX8Cs9ynSiz/WmFHaUrK8zYeTAkQs1X8cDoYnuH3S2DK3uc2JsN6yuKQoBjpFnzUzMsgka4XKkjGh4gTNmuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM6PR12MB4330.namprd12.prod.outlook.com (2603:10b6:5:21d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Thu, 28 Sep 2023 03:22:39 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 03:22:39 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Date:   Wed, 27 Sep 2023 23:22:37 -0400
X-Mailer: MailMate (1.14r5987)
Message-ID: <6DD1F426-A87D-47B7-B27F-043B399CBEDA@nvidia.com>
In-Reply-To: <98f3e433-153d-5dd8-c868-30f703baeb46@redhat.com>
References: <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
 <20230918145204.GB16104@cmpxchg.org> <20230918174037.GA112714@monkey>
 <20230919064914.GA124289@cmpxchg.org> <20230919184731.GC112714@monkey>
 <C416A861-44D3-46E7-B756-63DA3731FC1E@nvidia.com>
 <20230920003239.GD112714@monkey>
 <149ACAE8-D3E4-4009-828A-D3AC881FFB9C@nvidia.com>
 <bc4bd049-1e29-0f23-cca6-493abb5e774f@suse.cz>
 <20230920134811.GB124289@cmpxchg.org> <20230920160400.GC124289@cmpxchg.org>
 <762CA634-053A-41DD-8ED7-895374640858@nvidia.com>
 <D4F59724-61EB-4DA5-94DF-59E79F0F1FB3@nvidia.com>
 <505e7f55-f63a-b33d-aa10-44de16d2d3cc@redhat.com>
 <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
 <98f3e433-153d-5dd8-c868-30f703baeb46@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_F6CE19C1-4377-4E9D-9899-60F901BAC3A7_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0049.namprd20.prod.outlook.com
 (2603:10b6:208:235::18) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM6PR12MB4330:EE_
X-MS-Office365-Filtering-Correlation-Id: ee08d4e5-977f-4f58-6b2f-08dbbfd22b42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9wUksf39AigDrDxDWxUUfi2X2/CJOirXYxtbOUVURRg9BfoH3/eP3akgTrf3VbaFj67pyGbJJlWrfFP8uiJmAMC/5rB+guUnoafOPvouP2G5A4bdP8lQIPnR/tChKSa5vGrGu8LvQY1jW3YIikpfU94Rrdsnj4VFBNQkgwwkNX3J1qWp54DLLt12CPdgo2TCJbTV0PciEe6YNvCryDOAi0yTAjGPxXI+zSmXq0BvAIZNgzorZ06AoOlWLgVrAI5Iog5NbtLR+m+NOPgHZ7RTk9eFlQyGfeU2tJPSpC2oUqItNXT8RHaVhqKRI8k3HL3TQQkdlmL9qFHELzqPca4gQCHOB8V2HON9mYWfCjdWTJPBpYg/mAy5W9UpRIYQwVhWNEB1E+q9Q5pqcLR4db4aeG7YjHTKyzmsphx+VV3B6PnnaeXdmQen8W5sHfYbu6+1vfgYMW0tljcWylp4gCJ61mUG91LL/8wl7zj/rOtnvN4CjIGgMSi7GYlASH1JFemA1rnGB9BpJ4YbglJ0iWmPCliYZYdbzodNtuNDrY1GzZhwdb7DcKeNKd7TEF1ZMfQyf++b6mNp2cKm2AqaLktoxVBxIJJzBSAOy4b7ejwsLWkEZTtcpZvXavxBcG+Db5G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(36756003)(33656002)(86362001)(66946007)(2906002)(30864003)(235185007)(2616005)(66556008)(41300700001)(54906003)(316002)(6486002)(5660300002)(478600001)(7416002)(53546011)(6506007)(6916009)(6512007)(66476007)(83380400001)(8936002)(4326008)(8676002)(26005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XpHGGnSH8zTiEK+1/KIMfPuf0C0RLu/hPm8C7y5MG3CDeGShAw1kY/h+NB+W?=
 =?us-ascii?Q?DKYnjGIWLzkmLj/M3HMR4q4MwEt4VjY5E3nLqI+M+vB/htf50JASyIMTRbcN?=
 =?us-ascii?Q?e2cL89Hh7nA2o5d1koCCycd2/VKV1WahIVn6mHTREokMZvbgQ6oom7eJUNif?=
 =?us-ascii?Q?XYaO9QBdkfh3pqXvv27HDhno36D+FW4ON4uyebuCedHU1dySYgETo1qAXI/S?=
 =?us-ascii?Q?AC7Mo0uJ6ZVn7oXNQKxcE1yemBzwS/z0ZWBZ18Hy85ZHa8zKY4YOpZTri/eu?=
 =?us-ascii?Q?zI2+a+JbTk2Rma7WyyXpGaJnCh9ttjLkg2BAH9VnsVbnTVWvRuh2cjVhVec6?=
 =?us-ascii?Q?pNTqX9NB1HJ3x0rp+MBVUtAMl25icSjykEX/5AS+3f6KVFSTcVYuqdKLQPwz?=
 =?us-ascii?Q?eSQHXb2oQE1PIiIgmqPhrxEbv38/RNnmOwV04xHh2OTA2el/TBMlfl90Qw61?=
 =?us-ascii?Q?87c+m71rZdQ/bv8neOZxodppBfXuNbSXfiP+UsX3Qx728LnZKcEv1c1VQwRf?=
 =?us-ascii?Q?0zKI434ohaLZT02YSzpJl7mSX3xvnBvDw4IuH/EX7L2VxpqHfZ8yig1BzjuO?=
 =?us-ascii?Q?40/OXAs311m3U1GBImIFeNNAl5hutkP31VzKh0iFVZ6CpAwZuwhi9NZNZtc2?=
 =?us-ascii?Q?Go1Z5HkbkGiYn083B/5wpXLL2B5fMbaKvS1cs9ogmloilzUM8EpSvm2Dvbnh?=
 =?us-ascii?Q?ENFoPN1F5MJ+7WAir52Su1A4q3juH+W+WIvKv/9Nyr7vzjIeZfaYI+IHrNDo?=
 =?us-ascii?Q?gLeY/HM5kviMhdcqJcHv30cNAzC5q43Zuj7lFKYqUx/Qoeo3/Lezo/cupp8u?=
 =?us-ascii?Q?DLupa2joQPocFlbgQ9JGQgDdYWT4vsYvNJwYx3002eQbkDTTsBAW0IhLRJUj?=
 =?us-ascii?Q?Tfb+cEOUNve2xlEpIi8oZPfeTp8CIGBbhKdbinuU/0D3zcOJ8AYwHiBPtPNz?=
 =?us-ascii?Q?Rg7yJGl3cdIFCf3jWVRp8GrHJ+d+vu+ST8oQBRmyPnm9F9x/nVmagK6wFLGA?=
 =?us-ascii?Q?/PeSA2Ibfzu87dMnfyGad5PxCFw6YEwJWBIaH0DwY5JZgWDeIPIwpBP0aZPA?=
 =?us-ascii?Q?sibI8xdWSF301k1pc7aZdMHxJ7oav8QqmUGk6yXu87iGzitj6STYy+Tkvtl+?=
 =?us-ascii?Q?ANZHWOFmLtB+350Gev0jB3oqH957E09lO/EtrvCj3tR1AnVAPT6zVXlqaF9t?=
 =?us-ascii?Q?mbAaXZYs9Lv90ahQbSm43hv4/t7sZFl1hg1g04e9Xvj+rq+2EYDQbIyTDGvn?=
 =?us-ascii?Q?rM2i3JTMUHep9DjN5+LeBRHDw9Ios3N1W9h4eoQlPYjnGoLchdjgnbCRSZN5?=
 =?us-ascii?Q?E+mM7METrqJ1qvUpu1QF+x5r+C+0xIzT/jEkVXlA4nsulca4Et/CRGyQ9FTc?=
 =?us-ascii?Q?zJpGfKNUZZNQtJOfu/7If9hBdVw538FFFKB097IZgKyPGucC0RLEQFokw7jp?=
 =?us-ascii?Q?wf9V6mesYl559SkxVeNXrIdwt6s8ZWdqbAMkCEzTelgTPwWS1giqec3GZIeD?=
 =?us-ascii?Q?DvjhIc8XVfkFLnBLIp250iPsCvyG2ENknqBifCWw6fSaKVo3VaC+h4CPsO3z?=
 =?us-ascii?Q?cOXgePdUV0ulcM7DAEG2irLaQ0swvucTGnN9hw40?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee08d4e5-977f-4f58-6b2f-08dbbfd22b42
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 03:22:39.3951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hD6mDJXV683EK93cNE+eGwdpruxtI/kEgKNDNIZ9aQF+BVl5aMItURXUo5ZnLg0/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4330
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_F6CE19C1-4377-4E9D-9899-60F901BAC3A7_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Sep 2023, at 14:19, David Hildenbrand wrote:

> On 21.09.23 16:47, Zi Yan wrote:
>> On 21 Sep 2023, at 6:19, David Hildenbrand wrote:
>>
>>> On 21.09.23 04:31, Zi Yan wrote:
>>>> On 20 Sep 2023, at 13:23, Zi Yan wrote:
>>>>
>>>>> On 20 Sep 2023, at 12:04, Johannes Weiner wrote:
>>>>>
>>>>>> On Wed, Sep 20, 2023 at 09:48:12AM -0400, Johannes Weiner wrote:
>>>>>>> On Wed, Sep 20, 2023 at 08:07:53AM +0200, Vlastimil Babka wrote:
>>>>>>>> On 9/20/23 03:38, Zi Yan wrote:
>>>>>>>>> On 19 Sep 2023, at 20:32, Mike Kravetz wrote:
>>>>>>>>>
>>>>>>>>>> On 09/19/23 16:57, Zi Yan wrote:
>>>>>>>>>>> On 19 Sep 2023, at 14:47, Mike Kravetz wrote:
>>>>>>>>>>>
>>>>>>>>>>>> 	--- a/mm/page_alloc.c
>>>>>>>>>>>> 	+++ b/mm/page_alloc.c
>>>>>>>>>>>> 	@@ -1651,8 +1651,13 @@ static bool prep_move_freepages_bloc=
k(struct zone *zone, struct page *page,
>>>>>>>>>>>>    		end =3D pageblock_end_pfn(pfn) - 1;
>>>>>>>>>>>>
>>>>>>>>>>>>    		/* Do not cross zone boundaries */
>>>>>>>>>>>> 	+#if 0
>>>>>>>>>>>>    		if (!zone_spans_pfn(zone, start))
>>>>>>>>>>>> 			start =3D zone->zone_start_pfn;
>>>>>>>>>>>> 	+#else
>>>>>>>>>>>> 	+	if (!zone_spans_pfn(zone, start))
>>>>>>>>>>>> 	+		start =3D pfn;
>>>>>>>>>>>> 	+#endif
>>>>>>>>>>>> 	 	if (!zone_spans_pfn(zone, end))
>>>>>>>>>>>> 	 		return false;
>>>>>>>>>>>> 	I can still trigger warnings.
>>>>>>>>>>>
>>>>>>>>>>> OK. One thing to note is that the page type in the warning ch=
anged from
>>>>>>>>>>> 5 (MIGRATE_ISOLATE) to 0 (MIGRATE_UNMOVABLE) with my suggeste=
d change.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Just to be really clear,
>>>>>>>>>> - the 5 (MIGRATE_ISOLATE) warning was from the __alloc_pages c=
all path.
>>>>>>>>>> - the 0 (MIGRATE_UNMOVABLE) as above was from the alloc_contig=
_range call
>>>>>>>>>>     path WITHOUT your change.
>>>>>>>>>>
>>>>>>>>>> I am guessing the difference here has more to do with the allo=
cation path?
>>>>>>>>>>
>>>>>>>>>> I went back and reran focusing on the specific migrate type.
>>>>>>>>>> Without your patch, and coming from the alloc_contig_range cal=
l path,
>>>>>>>>>> I got two warnings of 'page type is 0, passed migratetype is 1=
' as above.
>>>>>>>>>> With your patch I got one 'page type is 0, passed migratetype =
is 1'
>>>>>>>>>> warning and one 'page type is 1, passed migratetype is 0' warn=
ing.
>>>>>>>>>>
>>>>>>>>>> I could be wrong, but I do not think your patch changes things=
=2E
>>>>>>>>>
>>>>>>>>> Got it. Thanks for the clarification.
>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> One idea about recreating the issue is that it may have to d=
o with size
>>>>>>>>>>>> of my VM (16G) and the requested allocation sizes 4G.  Howev=
er, I tried
>>>>>>>>>>>> to really stress the allocations by increasing the number of=
 hugetlb
>>>>>>>>>>>> pages requested and that did not help.  I also noticed that =
I only seem
>>>>>>>>>>>> to get two warnings and then they stop, even if I continue t=
o run the
>>>>>>>>>>>> script.
>>>>>>>>>>>>
>>>>>>>>>>>> Zi asked about my config, so it is attached.
>>>>>>>>>>>
>>>>>>>>>>> With your config, I still have no luck reproducing the issue.=
 I will keep
>>>>>>>>>>> trying. Thanks.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Perhaps try running both scripts in parallel?
>>>>>>>>>
>>>>>>>>> Yes. It seems to do the trick.
>>>>>>>>>
>>>>>>>>>> Adjust the number of hugetlb pages allocated to equal 25% of m=
emory?
>>>>>>>>>
>>>>>>>>> I am able to reproduce it with the script below:
>>>>>>>>>
>>>>>>>>> while true; do
>>>>>>>>>    echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hug=
epages&
>>>>>>>>>    echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hug=
epages&
>>>>>>>>>    wait
>>>>>>>>>    echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepa=
ges
>>>>>>>>>    echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hug=
epages
>>>>>>>>> done
>>>>>>>>>
>>>>>>>>> I will look into the issue.
>>>>>>>
>>>>>>> Nice!
>>>>>>>
>>>>>>> I managed to reproduce it ONCE, triggering it not even a second a=
fter
>>>>>>> starting the script. But I can't seem to do it twice, even after
>>>>>>> several reboots and letting it run for minutes.
>>>>>>
>>>>>> I managed to reproduce it reliably by cutting the nr_hugepages
>>>>>> parameters respectively in half.
>>>>>>
>>>>>> The one that triggers for me is always MIGRATE_ISOLATE. With some
>>>>>> printk-tracing, the scenario seems to be this:
>>>>>>
>>>>>> #0                                                   #1
>>>>>> start_isolate_page_range()
>>>>>>     isolate_single_pageblock()
>>>>>>       set_migratetype_isolate(tail)
>>>>>>         lock zone->lock
>>>>>>         move_freepages_block(tail) // nop
>>>>>>         set_pageblock_migratetype(tail)
>>>>>>         unlock zone->lock
>>>>>>                                                        del_page_fr=
om_freelist(head)
>>>>>>                                                        expand(head=
, head_mt)
>>>>>>                                                          WARN(head=
_mt !=3D tail_mt)
>>>>>>       start_pfn =3D ALIGN_DOWN(MAX_ORDER_NR_PAGES)
>>>>>>       for (pfn =3D start_pfn, pfn < end_pfn)
>>>>>>         if (PageBuddy())
>>>>>>           split_free_page(head)
>>>>>>
>>>>>> IOW, we update a pageblock that isn't MAX_ORDER aligned, then drop=
 the
>>>>>> lock. The move_freepages_block() does nothing because the PageBudd=
y()
>>>>>> is set on the pageblock to the left. Once we drop the lock, the bu=
ddy
>>>>>> gets allocated and the expand() puts things on the wrong list. The=

>>>>>> splitting code that handles MAX_ORDER blocks runs *after* the tail=

>>>>>> type is set and the lock has been dropped, so it's too late.
>>>>>
>>>>> Yes, this is the issue I can confirm as well. But it is intentional=
 to enable
>>>>> allocating a contiguous range at pageblock granularity instead of M=
AX_ORDER
>>>>> granularity. With your changes below, it no longer works, because i=
f there
>>>>> is an unmovable page in
>>>>> [ALIGN_DOWN(start_pfn, MAX_ORDER_NR_PAGES), pageblock_start_pfn(sta=
rt_pfn)),
>>>>> the allocation fails but it would succeed in current implementation=
=2E
>>>>>
>>>>> I think a proper fix would be to make move_freepages_block() split =
the
>>>>> MAX_ORDER page and put the split pages in the right migratetype fre=
e lists.
>>>>>
>>>>> I am working on that.
>>>>
>>>> After spending half a day on this, I think it is much harder than I =
thought
>>>> to get alloc_contig_range() working with the freelist migratetype hy=
giene
>>>> patchset. Because alloc_contig_range() relies on racy migratetype ch=
anges:
>>>>
>>>> 1. pageblocks in the range are first marked as MIGRATE_ISOLATE to pr=
event
>>>> another parallel isolation, but they are not moved to the MIGRATE_IS=
OLATE
>>>> free list yet.
>>>>
>>>> 2. later in the process, isolate_freepages_range() is used to actual=
ly grab
>>>> the free pages.
>>>>
>>>> 3. there was no problem when alloc_contig_range() works on MAX_ORDER=
 aligned
>>>> ranges, since MIGRATE_ISOLATE cannot be set in the middle of free pa=
ges or
>>>> in-use pages. But it is not the case when alloc_contig_range() work =
on
>>>> pageblock aligned ranges. Now during isolation phase, free or in-use=
 pages
>>>> will need to be split to get their subpages into the right free list=
s.
>>>>
>>>> 4. the hardest case is when a in-use page sits across two pageblocks=
, currently,
>>>> the code just isolate one pageblock, migrate the page, and let split=
_free_page()
>>>> to correct the free list later. But to strictly enforce freelist mig=
ratetype
>>>> hygiene, extra work is needed at free page path to split the free pa=
ge into
>>>> the right freelists.
>>>>
>>>> I need more time to think about how to get alloc_contig_range() prop=
erly.
>>>> Help is needed for the bullet point 4.
>>>
>>>
>>> I once raised that we should maybe try making MIGRATE_ISOLATE a flag =
that preserves the original migratetype. Not sure if that would help here=
 in any way.
>>
>> I have that in my backlog since you asked and have been delaying it. ;=
) Hopefully
>
> It's complicated and I wish I would have had more time to review it
> back then ... or now to clean it up later.
>
> Unfortunately, nobody else did have the time to review it back then ...=
 maybe we can
> do better next time. David doesn't scale.
>
> Doing page migration from inside start_isolate_page_range()->isolate_si=
ngle_pageblock()
> really is sub-optimal (and mostly code duplication from alloc_contig_ra=
nge).

I felt the same when I wrote the code. But I thought it was the only way =
out.

>
>> I can do it after I fix this. That change might or might not help only=
 if we make
>> some redesign on how migratetype is managed. If MIGRATE_ISOLATE does n=
ot
>> overwrite existing migratetype, the code might not need to split a pag=
e and move
>> it to MIGRATE_ISOLATE freelist?
>
> Did someone test how memory offlining plays along with that? (I can try=
 myself
> within the next 1-2 weeks)
>
> There [mm/memory_hotplug.c:offline_pages] we always cover full MAX_ORDE=
R ranges,
> though.
>
> ret =3D start_isolate_page_range(start_pfn, end_pfn,
> 			       MIGRATE_MOVABLE,
> 			       MEMORY_OFFLINE | REPORT_FAILURE,
> 			       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);

Since a full MAX_ORDER range is passed, no free page split will happen.

>
>>
>> The fundamental issue in alloc_contig_range() is that to work at
>> pageblock level, a page (>pageblock_order) can have one part is isolat=
ed and
>> the rest is a different migratetype. {add_to,move_to,del_page_from}_fr=
ee_list()
>> now checks first pageblock migratetype, so such a page needs to be rem=
oved
>> from its free_list, set MIGRATE_ISOLATE on one of the pageblock, split=
, and
>> finally put back to multiple free lists. This needs to be done at isol=
ation stage
>> before free pages are removed from their free lists (the stage after i=
solation).
>
> One idea was to always isolate larger chunks, and handle movability che=
cks/split/etc
> at a later stage. Once isolation would be decoupled from the actual/ori=
ginal migratetype,
> the could have been easier to handle (especially some corner cases I ha=
d in mind back then).

I think it is a good idea. When I coded alloc_contig_range() up, I tried =
to
accommodate existing set_migratetype_isolate(), which calls has_unmovable=
_pages().
If these two are decoupled, set_migrateype_isolate() can work on MAX_ORDE=
R-aligned
ranges and has_unmovable_pages() can still work on pageblock-aligned rang=
es.
Let me give this a try.

>
>> If MIGRATE_ISOLATE is a separate flag and we are OK with leaving isola=
ted pages
>> in their original migratetype and check migratetype before allocating =
a page,
>> that might help. But that might add extra work (e.g., splitting a part=
ially
>> isolated free page before allocation) in the really hot code path, whi=
ch is not
>> desirable.
>
> With MIGRATE_ISOLATE being a separate flag, one idea was to have not a =
single
> separate isolate list, but one per "proper migratetype". But again, jus=
t some random
> thoughts I had back then, I never had sufficient time to think it all t=
hrough.

Got it. I will think about it.

One question on separate MIGRATE_ISOLATE:

the implementation I have in mind is that MIGRATE_ISOLATE will need a ded=
icated flag
bit instead of being one of migratetype. But now there are 5 migratetypes=
 +
MIGRATE_ISOLATE and PB_migratetype_bits is 3, so an extra migratetype_bit=
 is needed.
But current migratetype implementation is a word-based operation, requiri=
ng
NR_PAGEBLOCK_BITS to be divisor of BITS_PER_LONG. This means NR_PAGEBLOCK=
_BITS
needs to be increased from 4 to 8 to meet the requirement, wasting a lot =
of space.
An alternative is to have a separate array for MIGRATE_ISOLATE, which req=
uires
additional changes. Let me know if you have a better idea. Thanks.



--
Best Regards,
Yan, Zi

--=_MailMate_F6CE19C1-4377-4E9D-9899-60F901BAC3A7_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUU8X0PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUPdUP/iuE+RZBQJdFPOMzq+Bjz776V+XoqBjK48iU
eJVVnbI5kfFckXNoREDZDLho06Xtg6ppVGXmCzAdO14xcwEZyTlhQmV9dMavFyYD
HUWZ0uTH8ccnOU8XiF27A0a57hCNSeqYPPiQtqisD7d06aXkTbTPdHU5FUb0psqW
5e8MWD17yHV+1AV8iaAawc2IPgkZblqVg2PvqJxgeHoa4yLY1I75/r9KQdY8imKF
esjokEO4ByFaoPn4W2F6P1n9/wwYbofnQM7OxhWf3oid8+JRGF/eteGD4iJa8mmt
/qMxdAUqYsZw45ocRwNliT6FWdV4eQnYnFvlgKpcxA1hQUSfc6kqFY3J/BYbFXCw
FAlkuzv6u7s/3EQ0lFfscAAHq8q9DIO03ZvRxCxsFxV0Ra8heil2LEfv064tsAKc
ygiqSvSewYo8wdkzV1xDWO6uwHfv0WYLIHveEJeR46GUx4oZR8m/fC0Mq8o2hJGF
MEuCmBXTMdOi3S8LDDn8DwnTZv+NjAn1UhWRuIR6hEm8X5wKD+P9SWUSw1ZOrErV
2fPRRa3RWFzBhp8Y6vGc5wBeZI1JiYEGdv0lHMl84tzB73k3Zcunw0wcHhYQkwG0
GVpmeoa6XBYurq1bA2EqcorRr+mmmewIYvzyfgtO/+Kjd5l3zCHIdNMYI9PKN3W9
sVolXKo8
=pGLW
-----END PGP SIGNATURE-----

--=_MailMate_F6CE19C1-4377-4E9D-9899-60F901BAC3A7_=--
