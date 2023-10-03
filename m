Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD207B5F0D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 04:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjJCC1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 22:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjJCC1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 22:27:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073E2BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 19:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+V5DZ/3Y3IuGCibLiK43m1q0r6eNFNqcfnIY0k9Lm05mEnN+okwS49aPtVjNzAhninc29pPoW0jnCNqarVs5nnu8OwLDRlba0m8EBHjXeh9mYc36INVs6gJB3FUmn97qGLNyEIY7eDxZYyBnZedY24llzKHNKYQI8qMKmC4OOkH1wLHHfv8hiSyEUD8GWGY7gsexwHCfck2DGXt80uPk5xgDRg5lyMnAKwm91tjHLuTQBFCJLMQRzXVcnJIU2SHpw9ytLCldAJ9gdaoZH8CvStkAnLBc7P7Cz6Dg8jtVL6RvXhbiGWCZgBAF11EpwXIeGNUtcb1TSVzhY2QYNHvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWhC73HWakV/qY4l3Nlr0Do15yp82LigS3qSA3Vgz/w=;
 b=jpgB7eHRLdvMWHMFCa7gte/3CY9cNO6yA/KrnsWm2bcwvaBfZhUKdCtJ2PTbx8K952GMfvlvbt8zoIBIkWwPJOdhJCFAtWnNg6SNwNMpCeChUy5ZI/ESRE8rcs/Sf11xFro/FfVhXUbI9lnuUsJJUvINx2XPafg+aUzGs8zhD5oKXQlwOS2i4Ahe05F2fDiCQ10sAu63OG2332Ij/vKyIW0nX57D95FKaFO3GcMtZlwxxcPPL4DL829lDH8BXXX5L9yMVA337/tApxwD9p4UfT99kauRkl9hnctdtf4fXOZhhlqBpolANNoMw0pd1uW2YObBWa6mhcOlY+bxmOY46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWhC73HWakV/qY4l3Nlr0Do15yp82LigS3qSA3Vgz/w=;
 b=JZAvm6prze1VETJiB8T2aOKAlqMiQpHuPL7kl8D2cXPEMG4G6fA1pR8xmq/mXLgwKj5v4F/emNCV2/XtFk1AemSG25Ar2NbLZBG9F1RKq17b2JoPf0TPHcT9H7Hv00K/N2LjE4T0OW9Pdn7V6J3zRUPjmPNYM6yihwWyy0ygorBMY/MY02VzcyIffeOO+KawSMLp4/XEcsOzokbE5qdzL0fTcTpt5TaVnKbGqmLgsMkUXDxr9otNSx7HDxKBEswJn9ZiwiHbjd8FRChqRxoF/OfJDTjcdfkojBourVtZgKQ/qi2O8I57xaaxnap5SE9orvwsiV+azdIQQqQwNFV0VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 3 Oct
 2023 02:26:47 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6838.016; Tue, 3 Oct 2023
 02:26:47 +0000
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
Date:   Mon, 02 Oct 2023 22:26:44 -0400
X-Mailer: MailMate (1.14r5987)
Message-ID: <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
In-Reply-To: <0D2BD71D-5E65-4175-8872-5E70278C57DA@nvidia.com>
References: <20230920003239.GD112714@monkey>
 <149ACAE8-D3E4-4009-828A-D3AC881FFB9C@nvidia.com>
 <bc4bd049-1e29-0f23-cca6-493abb5e774f@suse.cz>
 <20230920134811.GB124289@cmpxchg.org> <20230920160400.GC124289@cmpxchg.org>
 <762CA634-053A-41DD-8ED7-895374640858@nvidia.com>
 <D4F59724-61EB-4DA5-94DF-59E79F0F1FB3@nvidia.com>
 <505e7f55-f63a-b33d-aa10-44de16d2d3cc@redhat.com>
 <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
 <92AE29D4-E715-447C-AF99-ECF42383C74D@nvidia.com>
 <20230926173939.GA348484@cmpxchg.org>
 <0D2BD71D-5E65-4175-8872-5E70278C57DA@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_3F821280-010D-460B-B686-6CE960EA35BB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0188.namprd13.prod.outlook.com
 (2603:10b6:208:2be::13) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 2789fa59-c757-428f-c8c3-08dbc3b8314a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AJeYxergOxhHcxHGKxEgsVAXfUSKEh178KNTZxyJ/CUyJZOmCbHgmjOiOLget76P4p6LvbXsbnkMe81HkbcAj7tXNBppjeE05WJjt8ZdKLwYWiBtlS9hBwDP2YqWfIRTLlhiAFG7jT5ku2G+n6iGGpgihjEiugAMOc02sW9EttKRVxE2qAPalttg54iHgedUIg131+z2ydgwIWe3jGlC+VPHMO6iG/pCiHtyXBVcu8eN1UkVUkwnqLwSkIM81K/uCwd4rdT9gba2cgqkKvZm6JXJS+hVBKFbNUtGchtbbfBLY9TKQg6SvQo5byQRXeDyzQtCQJ48RkVgdYJEyF0tsbTw8KVCaRXR84K/Zy7wdgBFwfV08Hj1I8L3/ct1JBZqftfiZq2WvQoaY5SPac8AFZzXSin5oNRVF89dObqT0zH/jxjyyoNkwUNjqB9SNGLce/3rmExDepd2yOBk/b9/gKoeuUiQoQFHaCT87BRHMbs8Bufg2ttC7VkbcyS+SXamKBCeaEMm57PGYnbEHm2xD6PkMnO25pQAQ5M6dtPQTfOccheW3ve86MuRaHhWKPkAo7alnhSOGFdLzT+r3W6qmxdluPpBpTGVtI9L1tGzoz5+Kkzusedf38Z6s9uxilfJ/Ht8wuDWGNMDHmChiQogws9qq4vMgZx5ahdWpk51cKejJ1FYi+RlzrCDspNO65oG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(235185007)(6512007)(7416002)(2906002)(66899024)(30864003)(5660300002)(53546011)(6506007)(6486002)(2616005)(26005)(33656002)(36756003)(83380400001)(41300700001)(86362001)(6666004)(38100700002)(6916009)(8676002)(966005)(8936002)(4326008)(478600001)(66556008)(66946007)(66476007)(54906003)(316002)(21314003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9grQuYq7Qmu/BSpQfWxiLilZcwPWf1Oh7ByKNLN5tSOwzuauwg4Pg90e9Gal?=
 =?us-ascii?Q?lZYM1QBKx8r7RpYhlUY1iNQNbvBaQU1QQwIRnl2PUQBAw+sbCV78UJttuLxi?=
 =?us-ascii?Q?QtkZcV2d3MfO7b9WJ9zkCKmxlcBitfx5Epvt3nrnRp8j/YN4Jx0wohIXvGya?=
 =?us-ascii?Q?hSg6heaC7h/3HieMYYgA8FUkLxBj2IKmh5Kp35bYvCSYIQX+SXBzawyKp5rr?=
 =?us-ascii?Q?bDOVvzuQJo3SMy/19qlBkFJwAkKUQrP+diB1aoMT+b4HEJOD98Hg3uC18AV5?=
 =?us-ascii?Q?RTmeXsDP6KR5gyA1ar+wx6k2USbtQ9U4TG6hjFCnTnsOF+7mZNnWwLlju+yG?=
 =?us-ascii?Q?MM2kBn8Lp0D07hxR4AqehFvLJZK7MEg5f7KRIURISkat0PxjS/hhqUbWSHeE?=
 =?us-ascii?Q?R4E1cwIPoKC6wz7Lz90b+zVqnKLL/NmiS+piRDqqKuCj95AsYXNDokjAUPuG?=
 =?us-ascii?Q?fZP+UbCPmtNLQ7CmssJf1vuDDE6Ao12InH49wLgQPYSl/ODiz1r9/xbBq946?=
 =?us-ascii?Q?B5lnHSVyOy6/j/loSLfjzSAnr1rNRxVp9N76kR22QGJ6nqhtDY5uQzTUwW6K?=
 =?us-ascii?Q?spGE9k9ZiKfiVdPBFslGgA7aM33AnG69/YuL8hgiiJOOBW5bT1KLxt6RlYnz?=
 =?us-ascii?Q?C64PWMc9x0NRWRDB/l3VEkfhLwEENfJTMyEZciuU0sItuU2rD0hZ9BoqqUTh?=
 =?us-ascii?Q?FSJufM5a863v4nBur5qQJWd0Tz4/ac2DhRQ57cWWYa3bZTutVQzlcyBe7/bj?=
 =?us-ascii?Q?gPxVaqAqfrVvg6KYZ2LPV0C/0/u7pPyUVlYeqbhjGsqFVMwlepw9fMqypCTd?=
 =?us-ascii?Q?NJ860nHTDnvQKEQnHZySm0jDUyJaHuhvd0iIIVb8XUhmFQJfap2KNI8L9vuf?=
 =?us-ascii?Q?mgNAYojqT6Tk0/7/tqDu9d30Stzv4W5q3javPPsbgVqEPh8iMKhI+4pYCWwk?=
 =?us-ascii?Q?uvdPehIeerdnz4H/9UxPedzah+FXU6PS7uti8yzwDBet0whJuB8vMWrQBH8s?=
 =?us-ascii?Q?SAvT+TOVJ7afCiNP/4gXtVbR4KHHpUzIRCNSwvM4CqUysInbfBZ5r09JdqzY?=
 =?us-ascii?Q?HQNQXcqid20h3HOnaCT46LJ7YcQoRH4lWt7VkvhvUjxnULkAZnKIdnj7/oH5?=
 =?us-ascii?Q?mAXMew1Fql3dvCGUCkM0Br7VAhivJ58TL0BHpizNfDfkue/yfia5VxsyhTTe?=
 =?us-ascii?Q?sD2uZwQPXWd/UqDTBR3QJt+r3IOG3i2NfKPBTuh5pJLywmJoNJXu9lc7ji4M?=
 =?us-ascii?Q?F4UTYdq3GkA1fm8ZGAot3qQ98beO0Xg/JFFYMap0MmEdOCVictTP7kFW9FzM?=
 =?us-ascii?Q?ScmYAANCnANbWR9De8E9DOn2eN6qNpwmA4XMK0mfiPGC4dBTsU7Oq8V+xnVi?=
 =?us-ascii?Q?AN9TvgMLX5c6jh2nv4cOHZZ1AW93BF+5ddZzuDmNX3mq/gLKoI3srKVTLSWd?=
 =?us-ascii?Q?CLHFVUbkg+CHCi7jBheSENnKa94HTWLU8zAv2chHhqHdX6MoN2dc8xtdtagT?=
 =?us-ascii?Q?gjrB90PthFfwZ5EtjIAT447Iju1kBUoDA4tNBVBGA031WcLX+9qUHFoTIbMZ?=
 =?us-ascii?Q?UuBkrxOymrRLgOH7BP4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2789fa59-c757-428f-c8c3-08dbc3b8314a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 02:26:47.3380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qFFr2FSCQcVOuc+qUS4sW1GGbliUpY0g7H19NEzkvgrRIqLxG54xHk4zuTj7YKHr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_3F821280-010D-460B-B686-6CE960EA35BB_=
Content-Type: multipart/mixed;
 boundary="=_MailMate_1C4697CD-F1ED-4740-AE59-9B412363D6D0_="


--=_MailMate_1C4697CD-F1ED-4740-AE59-9B412363D6D0_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 27 Sep 2023, at 22:51, Zi Yan wrote:

> On 26 Sep 2023, at 13:39, Johannes Weiner wrote:
>
>> On Mon, Sep 25, 2023 at 05:12:38PM -0400, Zi Yan wrote:
>>> On 21 Sep 2023, at 10:47, Zi Yan wrote:
>>>
>>>> On 21 Sep 2023, at 6:19, David Hildenbrand wrote:
>>>>
>>>>> On 21.09.23 04:31, Zi Yan wrote:
>>>>>> On 20 Sep 2023, at 13:23, Zi Yan wrote:
>>>>>>
>>>>>>> On 20 Sep 2023, at 12:04, Johannes Weiner wrote:
>>>>>>>
>>>>>>>> On Wed, Sep 20, 2023 at 09:48:12AM -0400, Johannes Weiner wrote:=

>>>>>>>>> On Wed, Sep 20, 2023 at 08:07:53AM +0200, Vlastimil Babka wrote=
:
>>>>>>>>>> On 9/20/23 03:38, Zi Yan wrote:
>>>>>>>>>>> On 19 Sep 2023, at 20:32, Mike Kravetz wrote:
>>>>>>>>>>>
>>>>>>>>>>>> On 09/19/23 16:57, Zi Yan wrote:
>>>>>>>>>>>>> On 19 Sep 2023, at 14:47, Mike Kravetz wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>> 	--- a/mm/page_alloc.c
>>>>>>>>>>>>>> 	+++ b/mm/page_alloc.c
>>>>>>>>>>>>>> 	@@ -1651,8 +1651,13 @@ static bool prep_move_freepages_bl=
ock(struct zone *zone, struct page *page,
>>>>>>>>>>>>>>   		end =3D pageblock_end_pfn(pfn) - 1;
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>   		/* Do not cross zone boundaries */
>>>>>>>>>>>>>> 	+#if 0
>>>>>>>>>>>>>>   		if (!zone_spans_pfn(zone, start))
>>>>>>>>>>>>>> 			start =3D zone->zone_start_pfn;
>>>>>>>>>>>>>> 	+#else
>>>>>>>>>>>>>> 	+	if (!zone_spans_pfn(zone, start))
>>>>>>>>>>>>>> 	+		start =3D pfn;
>>>>>>>>>>>>>> 	+#endif
>>>>>>>>>>>>>> 	 	if (!zone_spans_pfn(zone, end))
>>>>>>>>>>>>>> 	 		return false;
>>>>>>>>>>>>>> 	I can still trigger warnings.
>>>>>>>>>>>>>
>>>>>>>>>>>>> OK. One thing to note is that the page type in the warning =
changed from
>>>>>>>>>>>>> 5 (MIGRATE_ISOLATE) to 0 (MIGRATE_UNMOVABLE) with my sugges=
ted change.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Just to be really clear,
>>>>>>>>>>>> - the 5 (MIGRATE_ISOLATE) warning was from the __alloc_pages=
 call path.
>>>>>>>>>>>> - the 0 (MIGRATE_UNMOVABLE) as above was from the alloc_cont=
ig_range call
>>>>>>>>>>>>    path WITHOUT your change.
>>>>>>>>>>>>
>>>>>>>>>>>> I am guessing the difference here has more to do with the al=
location path?
>>>>>>>>>>>>
>>>>>>>>>>>> I went back and reran focusing on the specific migrate type.=

>>>>>>>>>>>> Without your patch, and coming from the alloc_contig_range c=
all path,
>>>>>>>>>>>> I got two warnings of 'page type is 0, passed migratetype is=
 1' as above.
>>>>>>>>>>>> With your patch I got one 'page type is 0, passed migratetyp=
e is 1'
>>>>>>>>>>>> warning and one 'page type is 1, passed migratetype is 0' wa=
rning.
>>>>>>>>>>>>
>>>>>>>>>>>> I could be wrong, but I do not think your patch changes thin=
gs.
>>>>>>>>>>>
>>>>>>>>>>> Got it. Thanks for the clarification.
>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> One idea about recreating the issue is that it may have to=
 do with size
>>>>>>>>>>>>>> of my VM (16G) and the requested allocation sizes 4G.  How=
ever, I tried
>>>>>>>>>>>>>> to really stress the allocations by increasing the number =
of hugetlb
>>>>>>>>>>>>>> pages requested and that did not help.  I also noticed tha=
t I only seem
>>>>>>>>>>>>>> to get two warnings and then they stop, even if I continue=
 to run the
>>>>>>>>>>>>>> script.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Zi asked about my config, so it is attached.
>>>>>>>>>>>>>
>>>>>>>>>>>>> With your config, I still have no luck reproducing the issu=
e. I will keep
>>>>>>>>>>>>> trying. Thanks.
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Perhaps try running both scripts in parallel?
>>>>>>>>>>>
>>>>>>>>>>> Yes. It seems to do the trick.
>>>>>>>>>>>
>>>>>>>>>>>> Adjust the number of hugetlb pages allocated to equal 25% of=
 memory?
>>>>>>>>>>>
>>>>>>>>>>> I am able to reproduce it with the script below:
>>>>>>>>>>>
>>>>>>>>>>> while true; do
>>>>>>>>>>>   echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hu=
gepages&
>>>>>>>>>>>   echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hu=
gepages&
>>>>>>>>>>>   wait
>>>>>>>>>>>   echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugep=
ages
>>>>>>>>>>>   echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hu=
gepages
>>>>>>>>>>> done
>>>>>>>>>>>
>>>>>>>>>>> I will look into the issue.
>>>>>>>>>
>>>>>>>>> Nice!
>>>>>>>>>
>>>>>>>>> I managed to reproduce it ONCE, triggering it not even a second=
 after
>>>>>>>>> starting the script. But I can't seem to do it twice, even afte=
r
>>>>>>>>> several reboots and letting it run for minutes.
>>>>>>>>
>>>>>>>> I managed to reproduce it reliably by cutting the nr_hugepages
>>>>>>>> parameters respectively in half.
>>>>>>>>
>>>>>>>> The one that triggers for me is always MIGRATE_ISOLATE. With som=
e
>>>>>>>> printk-tracing, the scenario seems to be this:
>>>>>>>>
>>>>>>>> #0                                                   #1
>>>>>>>> start_isolate_page_range()
>>>>>>>>    isolate_single_pageblock()
>>>>>>>>      set_migratetype_isolate(tail)
>>>>>>>>        lock zone->lock
>>>>>>>>        move_freepages_block(tail) // nop
>>>>>>>>        set_pageblock_migratetype(tail)
>>>>>>>>        unlock zone->lock
>>>>>>>>                                                       del_page_f=
rom_freelist(head)
>>>>>>>>                                                       expand(hea=
d, head_mt)
>>>>>>>>                                                         WARN(hea=
d_mt !=3D tail_mt)
>>>>>>>>      start_pfn =3D ALIGN_DOWN(MAX_ORDER_NR_PAGES)
>>>>>>>>      for (pfn =3D start_pfn, pfn < end_pfn)
>>>>>>>>        if (PageBuddy())
>>>>>>>>          split_free_page(head)
>>>>>>>>
>>>>>>>> IOW, we update a pageblock that isn't MAX_ORDER aligned, then dr=
op the
>>>>>>>> lock. The move_freepages_block() does nothing because the PageBu=
ddy()
>>>>>>>> is set on the pageblock to the left. Once we drop the lock, the =
buddy
>>>>>>>> gets allocated and the expand() puts things on the wrong list. T=
he
>>>>>>>> splitting code that handles MAX_ORDER blocks runs *after* the ta=
il
>>>>>>>> type is set and the lock has been dropped, so it's too late.
>>>>>>>
>>>>>>> Yes, this is the issue I can confirm as well. But it is intention=
al to enable
>>>>>>> allocating a contiguous range at pageblock granularity instead of=
 MAX_ORDER
>>>>>>> granularity. With your changes below, it no longer works, because=
 if there
>>>>>>> is an unmovable page in
>>>>>>> [ALIGN_DOWN(start_pfn, MAX_ORDER_NR_PAGES), pageblock_start_pfn(s=
tart_pfn)),
>>>>>>> the allocation fails but it would succeed in current implementati=
on.
>>>>>>>
>>>>>>> I think a proper fix would be to make move_freepages_block() spli=
t the
>>>>>>> MAX_ORDER page and put the split pages in the right migratetype f=
ree lists.
>>>>>>>
>>>>>>> I am working on that.
>>>>>>
>>>>>> After spending half a day on this, I think it is much harder than =
I thought
>>>>>> to get alloc_contig_range() working with the freelist migratetype =
hygiene
>>>>>> patchset. Because alloc_contig_range() relies on racy migratetype =
changes:
>>>>>>
>>>>>> 1. pageblocks in the range are first marked as MIGRATE_ISOLATE to =
prevent
>>>>>> another parallel isolation, but they are not moved to the MIGRATE_=
ISOLATE
>>>>>> free list yet.
>>>>>>
>>>>>> 2. later in the process, isolate_freepages_range() is used to actu=
ally grab
>>>>>> the free pages.
>>>>>>
>>>>>> 3. there was no problem when alloc_contig_range() works on MAX_ORD=
ER aligned
>>>>>> ranges, since MIGRATE_ISOLATE cannot be set in the middle of free =
pages or
>>>>>> in-use pages. But it is not the case when alloc_contig_range() wor=
k on
>>>>>> pageblock aligned ranges. Now during isolation phase, free or in-u=
se pages
>>>>>> will need to be split to get their subpages into the right free li=
sts.
>>>>>>
>>>>>> 4. the hardest case is when a in-use page sits across two pagebloc=
ks, currently,
>>>>>> the code just isolate one pageblock, migrate the page, and let spl=
it_free_page()
>>>>>> to correct the free list later. But to strictly enforce freelist m=
igratetype
>>>>>> hygiene, extra work is needed at free page path to split the free =
page into
>>>>>> the right freelists.
>>>>>>
>>>>>> I need more time to think about how to get alloc_contig_range() pr=
operly.
>>>>>> Help is needed for the bullet point 4.
>>>>>
>>>>>
>>>>> I once raised that we should maybe try making MIGRATE_ISOLATE a fla=
g that preserves the original migratetype. Not sure if that would help he=
re in any way.
>>>>
>>>> I have that in my backlog since you asked and have been delaying it.=
 ;) Hopefully
>>>> I can do it after I fix this. That change might or might not help on=
ly if we make
>>>> some redesign on how migratetype is managed. If MIGRATE_ISOLATE does=
 not
>>>> overwrite existing migratetype, the code might not need to split a p=
age and move
>>>> it to MIGRATE_ISOLATE freelist?
>>>>
>>>> The fundamental issue in alloc_contig_range() is that to work at
>>>> pageblock level, a page (>pageblock_order) can have one part is isol=
ated and
>>>> the rest is a different migratetype. {add_to,move_to,del_page_from}_=
free_list()
>>>> now checks first pageblock migratetype, so such a page needs to be r=
emoved
>>>> from its free_list, set MIGRATE_ISOLATE on one of the pageblock, spl=
it, and
>>>> finally put back to multiple free lists. This needs to be done at is=
olation stage
>>>> before free pages are removed from their free lists (the stage after=
 isolation).
>>>> If MIGRATE_ISOLATE is a separate flag and we are OK with leaving iso=
lated pages
>>>> in their original migratetype and check migratetype before allocatin=
g a page,
>>>> that might help. But that might add extra work (e.g., splitting a pa=
rtially
>>>> isolated free page before allocation) in the really hot code path, w=
hich is not
>>>> desirable.
>>>>
>>>>>
>>>>> The whole alloc_contig_range() implementation is quite complicated =
and hard to grasp. If we could find ways to clean all that up and make it=
 easier to understand and play along, that would be nice.
>>>>
>>>> I will try my best to simplify it.
>>>
>>> Hi Johannes,
>>>
>>> I attached three patches to fix the issue and first two can be folded=
 into
>>> your patchset:
>>
>> Hi Zi, thanks for providing these patches! I'll pick them up into the
>> series.
>>
>>> 1. __free_one_page() bug you and Vlastimil discussed on the other ema=
il.
>>> 2. move set_pageblock_migratetype() into move_freepages() to prepare =
for patch 3.
>>> 3. enable move_freepages() to split a free page that is partially cov=
ered by
>>>    [start_pfn, end_pfn] in the parameter and set migratetype correctl=
y when
>>>    a >pageblock_order free page is moved. Before when a >pageblock_or=
der
>>>    free page is moved, only first pageblock migratetype is changed. T=
he added
>>>    WARN_ON_ONCE might be triggered by these pages.
>>>
>>> I ran Mike's test with transhuge-stress together with my patches on t=
op of your
>>> "close migratetype race" patch for more than an hour without any warn=
ing.
>>> It should unblock your patchset. I will keep working on alloc_contig_=
range()
>>> simplification.
>>>
>>>
>>> --
>>> Best Regards,
>>> Yan, Zi
>>
>>> From a18de9a235dc97999fcabdac699f33da9138b0ba Mon Sep 17 00:00:00 200=
1
>>> From: Zi Yan <ziy@nvidia.com>
>>> Date: Fri, 22 Sep 2023 11:11:32 -0400
>>> Subject: [PATCH 1/3] mm: fix __free_one_page().
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  mm/page_alloc.c | 6 +-----
>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 7de022bc4c7d..72f27d14c8e7 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -787,8 +787,6 @@ static inline void __free_one_page(struct page *p=
age,
>>>  	VM_BUG_ON_PAGE(bad_range(zone, page), page);
>>>
>>>  	while (order < MAX_ORDER) {
>>> -		int buddy_mt;
>>> -
>>>  		if (compaction_capture(capc, page, order, migratetype))
>>>  			return;
>>>
>>> @@ -796,8 +794,6 @@ static inline void __free_one_page(struct page *p=
age,
>>>  		if (!buddy)
>>>  			goto done_merging;
>>>
>>> -		buddy_mt =3D get_pfnblock_migratetype(buddy, buddy_pfn);
>>> -
>>>  		if (unlikely(order >=3D pageblock_order)) {
>>>  			/*
>>>  			 * We want to prevent merge between freepages on pageblock
>>> @@ -827,7 +823,7 @@ static inline void __free_one_page(struct page *p=
age,
>>>  		if (page_is_guard(buddy))
>>>  			clear_page_guard(zone, buddy, order);
>>>  		else
>>> -			del_page_from_free_list(buddy, zone, order, buddy_mt);
>>> +			del_page_from_free_list(buddy, zone, order, migratetype);
>>>  		combined_pfn =3D buddy_pfn & pfn;
>>>  		page =3D page + (combined_pfn - pfn);
>>>  		pfn =3D combined_pfn;
>>
>> I had a fix for this that's slightly different. The buddy's type can't=

>> be changed while it's still on the freelist, so I moved that
>> around. The sequence now is:
>>
>> 	int buddy_mt =3D migratetype;
>>
>> 	if (unlikely(order >=3D pageblock_order)) {
>> 		/* This is the only case where buddy_mt can differ */
>> 		buddy_mt =3D get_pfnblock_migratetype(buddy, buddy_pfn);
>> 		// compat checks...
>> 	}
>>
>> 	del_page_from_free_list(buddy, buddy_mt);
>>
>> 	if (unlikely(buddy_mt !=3D migratetype))
>> 		set_pageblock_migratetype(buddy, migratetype);
>>
>>
>>> From b11a0e3d8f9d7d91a884c90dc9cebb185c3a2bbc Mon Sep 17 00:00:00 200=
1
>>> From: Zi Yan <ziy@nvidia.com>
>>> Date: Mon, 25 Sep 2023 16:27:14 -0400
>>> Subject: [PATCH 2/3] mm: set migratetype after free pages are moved b=
etween
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
>> This makes the code much cleaner, thank you!
>>
>>> From 75a4d327efd94230f3b9aab29ef6ec0badd488a6 Mon Sep 17 00:00:00 200=
1
>>> From: Zi Yan <ziy@nvidia.com>
>>> Date: Mon, 25 Sep 2023 16:55:18 -0400
>>> Subject: [PATCH 3/3] mm: enable move_freepages() to properly move par=
t of free
>>>  pages.
>>>
>>> alloc_contig_range() uses set_migrateype_isolate(), which eventually =
calls
>>> move_freepages(), to isolate free pages. But move_freepages() was not=
 able
>>> to move free pages partially covered by the specified range, leaving =
a race
>>> window open[1]. Fix it by teaching move_freepages() to split a free p=
age
>>> when only part of it is going to be moved.
>>>
>>> In addition, when a >pageblock_order free page is moved, only its fir=
st
>>> pageblock migratetype is changed. It can cause warnings later. Fix it=
 by
>>> set all pageblocks in a free page to the same migratetype after move.=

>>>
>>> split_free_page() is changed to be used in move_freepages() and
>>> isolate_single_pageblock(). A common code to find the start pfn of a =
free
>>> page is refactored in get_freepage_start_pfn().
>>>
>>> [1] https://lore.kernel.org/linux-mm/20230920160400.GC124289@cmpxchg.=
org/
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  mm/page_alloc.c     | 75 ++++++++++++++++++++++++++++++++++++-------=
--
>>>  mm/page_isolation.c | 17 +++++++---
>>>  2 files changed, 73 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 7c41cb5d8a36..3fd5ab40b55c 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -866,15 +866,15 @@ int split_free_page(struct page *free_page,
>>>  	struct zone *zone =3D page_zone(free_page);
>>>  	unsigned long free_page_pfn =3D page_to_pfn(free_page);
>>>  	unsigned long pfn;
>>> -	unsigned long flags;
>>>  	int free_page_order;
>>>  	int mt;
>>>  	int ret =3D 0;
>>>
>>> -	if (split_pfn_offset =3D=3D 0)
>>> -		return ret;
>>> +	/* zone lock should be held when this function is called */
>>> +	lockdep_assert_held(&zone->lock);
>>>
>>> -	spin_lock_irqsave(&zone->lock, flags);
>>> +	if (split_pfn_offset =3D=3D 0 || split_pfn_offset >=3D (1 << order)=
)
>>> +		return ret;
>>>
>>>  	if (!PageBuddy(free_page) || buddy_order(free_page) !=3D order) {
>>>  		ret =3D -ENOENT;
>>> @@ -900,7 +900,6 @@ int split_free_page(struct page *free_page,
>>>  			split_pfn_offset =3D (1UL << order) - (pfn - free_page_pfn);
>>>  	}
>>>  out:
>>> -	spin_unlock_irqrestore(&zone->lock, flags);
>>>  	return ret;
>>>  }
>>>  /*
>>> @@ -1589,6 +1588,25 @@ static inline struct page *__rmqueue_cma_fallb=
ack(struct zone *zone,
>>>  					unsigned int order) { return NULL; }
>>>  #endif
>>>
>>> +/*
>>> + * Get first pfn of the free page, where pfn is in. If this free pag=
e does
>>> + * not exist, return the given pfn.
>>> + */
>>> +static unsigned long get_freepage_start_pfn(unsigned long pfn)
>>> +{
>>> +	int order =3D 0;
>>> +	unsigned long start_pfn =3D pfn;
>>> +
>>> +	while (!PageBuddy(pfn_to_page(start_pfn))) {
>>> +		if (++order > MAX_ORDER) {
>>> +			start_pfn =3D pfn;
>>> +			break;
>>> +		}
>>> +		start_pfn &=3D ~0UL << order;
>>> +	}
>>> +	return start_pfn;
>>> +}
>>> +
>>>  /*
>>>   * Move the free pages in a range to the freelist tail of the reques=
ted type.
>>>   * Note that start_page and end_pages are not aligned on a pageblock=

>>> @@ -1598,9 +1616,29 @@ static int move_freepages(struct zone *zone, u=
nsigned long start_pfn,
>>>  			  unsigned long end_pfn, int old_mt, int new_mt)
>>>  {
>>>  	struct page *page;
>>> -	unsigned long pfn;
>>> +	unsigned long pfn, pfn2;
>>>  	unsigned int order;
>>>  	int pages_moved =3D 0;
>>> +	unsigned long mt_change_pfn =3D start_pfn;
>>> +	unsigned long new_start_pfn =3D get_freepage_start_pfn(start_pfn);
>>> +
>>> +	/* split at start_pfn if it is in the middle of a free page */
>>> +	if (new_start_pfn !=3D start_pfn && PageBuddy(pfn_to_page(new_start=
_pfn))) {
>>> +		struct page *new_page =3D pfn_to_page(new_start_pfn);
>>> +		int new_page_order =3D buddy_order(new_page);
>>> +
>>> +		if (new_start_pfn + (1 << new_page_order) > start_pfn) {
>>> +			/* change migratetype so that split_free_page can work */
>>> +			set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
>>> +			split_free_page(new_page, buddy_order(new_page),
>>> +					start_pfn - new_start_pfn);
>>> +
>>> +			mt_change_pfn =3D start_pfn;
>>> +			/* move to next page */
>>> +			start_pfn =3D new_start_pfn + (1 << new_page_order);
>>> +		}
>>> +	}
>>
>> Ok, so if there is a straddle from the previous block into our block
>> of interest, it's split and the migratetype is set only on our block.
>
> Correct. For example, start_pfn is 0x200 (2MB) and the free page starti=
ng from 0x0 is order-10 (4MB).
>
>>
>>> @@ -1615,10 +1653,24 @@ static int move_freepages(struct zone *zone, =
unsigned long start_pfn,
>>>
>>>  		order =3D buddy_order(page);
>>>  		move_to_free_list(page, zone, order, old_mt, new_mt);
>>> +		/*
>>> +		 * set page migratetype for all pageblocks within the page and
>>> +		 * only after we move all free pages in one pageblock
>>> +		 */
>>> +		if (pfn + (1 << order) >=3D pageblock_end_pfn(pfn)) {
>>> +			for (pfn2 =3D pfn; pfn2 < pfn + (1 << order);
>>> +			     pfn2 +=3D pageblock_nr_pages) {
>>> +				set_pageblock_migratetype(pfn_to_page(pfn2),
>>> +							  new_mt);
>>> +				mt_change_pfn =3D pfn2;
>>> +			}
>>
>> But if we have the first block of a MAX_ORDER chunk, then we don't
>> split but rather move the whole chunk and make sure to update the
>> chunk's blocks that are outside the range of interest.
>>
>> It looks like either way would work, but why not split here as well
>> and keep the move contained to the block? Wouldn't this be a bit more
>> predictable and easier to understand?
>
> Yes, having a split here would be consistent.
>
> Also I want to spell out the corner case I am handling here (and I will=
 add
> it to the comment): since move_to_free_list() checks page's migratetype=

> with old_mt and changing one page' migratetype affects all pages within=

> the same pageblock, if we are moving more than one free pages that are
> in the same pageblock, setting migratetype right after move_to_free_lis=
t()
> triggers the warning.
>
>>> +		}
>>>  		pfn +=3D 1 << order;
>>>  		pages_moved +=3D 1 << order;
>>>  	}
>>> -	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
>>> +	/* set migratetype for the remaining pageblocks */
>>> +	for (pfn2 =3D mt_change_pfn; pfn2 <=3D end_pfn; pfn2 +=3D pageblock=
_nr_pages)
>>> +		set_pageblock_migratetype(pfn_to_page(pfn2), new_mt);
>>
>> I think I'm missing something for this.
>>
>> - If there was no straddle, there is only our block of interest to
>>   update.
>>
>> - If there was a straddle from the previous block, it was split and
>>   the block of interest was already updated. Nothing to do here?
>>
>> - If there was a straddle into the next block, both blocks are updated=

>>   to the new type. Nothing to do here?
>>
>> What's the case where there are multiple blocks to update in the end?
>
> When a pageblock has free pages at the beginning and in-use pages at th=
e end.
> The pageblock migratetype is not changed in the for loop above, since f=
ree
> pages do not cross pageblock boundary. But these free pages are moved
> to a new mt free list and will trigger warnings later.
>
> Also if multiple pageblocks are filled with only in-use pages, the for =
loop
> does nothing either. Their pageblocks will be set at this moment. I not=
ice
> it might be a change of behavior as I am writing, but this change might=

> be better. Before, in-page migrateype might or might not be changed,
> depending on if there is a free page in the same pageblock or not, mean=
ing
> there will be migratetype holes in the specified range. Now the whole r=
ange
> is changed to new_mt. Let me know if you have a different opinion.
>
>
>>> @@ -380,8 +380,15 @@ static int isolate_single_pageblock(unsigned lon=
g boundary_pfn, int flags,
>>>  			int order =3D buddy_order(page);
>>>
>>>  			if (pfn + (1UL << order) > boundary_pfn) {
>>> +				int res;
>>> +				unsigned long flags;
>>> +
>>> +				spin_lock_irqsave(&zone->lock, flags);
>>> +				res =3D split_free_page(page, order, boundary_pfn - pfn);
>>> +				spin_unlock_irqrestore(&zone->lock, flags);
>>> +
>>>  				/* free page changed before split, check it again */
>>> -				if (split_free_page(page, order, boundary_pfn - pfn))
>>> +				if (res)
>>>  					continue;
>>
>> At this point, we've already set the migratetype, which has handled
>> straddling free pages. Is this split still needed?
>
> Good point. I will remove it. Originally, I thought it should stay to h=
andle
> the free page coming from the migration below. But unless a greater tha=
n pageblock
> order in-use page shows up in the system and it is freed directly via _=
_free_pages(),
> any free page coming from the migration below should be put in the righ=
t
> free list.
>
> Such > pageblock order pages are possible, only if we have >PMD order T=
HPs
> or __PageMovable. IIRC, both do not exist yet.
>
>>
>>> @@ -426,9 +433,11 @@ static int isolate_single_pageblock(unsigned lon=
g boundary_pfn, int flags,
>>>  				/*
>>>  				 * XXX: mark the page as MIGRATE_ISOLATE so that
>>>  				 * no one else can grab the freed page after migration.
>>> -				 * Ideally, the page should be freed as two separate
>>> -				 * pages to be added into separate migratetype free
>>> -				 * lists.
>>> +				 * The page should be freed into separate migratetype
>>> +				 * free lists, unless the free page order is greater
>>> +				 * than pageblock order. It is not the case now,
>>> +				 * since gigantic hugetlb is freed as order-0
>>> +				 * pages and LRU pages do not cross pageblocks.
>>>  				 */
>>>  				if (isolate_page) {
>>>  					ret =3D set_migratetype_isolate(page, page_mt,
>>
>> I hadn't thought about LRU pages being constrained to single
>> pageblocks before. Does this mean we only ever migrate here in case
>
> Initially, I thought a lot about what if a high order folio crosses
> two adjacent pageblocks, but at the end I find that __find_buddy_pfn()
> does not treat pfns from adjacent pageblocks as buddy unless order
> is greater than pageblock order. So any high order folio from
> buddy allocator does not cross pageblocks. That is a relief.
>
> Another (future) possibility is once anon large folio is merged and
> my split huge page to any lower order patches are merged, a high order
> folio might not come directly from buddy allocator but from a huge page=

> split. But that requires a > pageblock order folio exist first, which
> is not possible either. So we are good.
>
>> there is a movable gigantic page? And since those are already split
>> during the free, does that mean the "reset pfn to head of the free
>> page" part after the migration is actually unnecessary?
>
> Yes. the "reset pfn" code could be removed.
>
> Thank you for the review. Really appreciate it. Let me revise my
> patch 3 and send it out again.

It turns out that there was a bug in my patch 2: set_pageblock_migratetyp=
e()
is used by isolated_page case too, thus cannot be removed unconditionally=
=2E

I attached my revised patch 2 and 3 (with all the suggestions above).


--
Best Regards,
Yan, Zi

--=_MailMate_1C4697CD-F1ED-4740-AE59-9B412363D6D0_=
Content-Disposition: attachment;
 filename=v2-0001-mm-set-migratetype-after-free-pages-are-moved-bet.patch
Content-ID: <FD2D4D86-BE5A-4282-816A-87012540B746@nvidia.com>
Content-Type: text/plain;
 name=v2-0001-mm-set-migratetype-after-free-pages-are-moved-bet.patch
Content-Transfer-Encoding: quoted-printable

=46rom 1c8f99cff5f469ee89adc33e9c9499254cad13f2 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 25 Sep 2023 16:27:14 -0400
Subject: [PATCH v2 1/2] mm: set migratetype after free pages are moved be=
tween
 free lists.

This avoids changing migratetype after move_freepages() or
move_freepages_block(), which is error prone. It also prepares for upcomi=
ng
changes to fix move_freepages() not moving free pages partially in the
range.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_alloc.c     | 10 +++-------
 mm/page_isolation.c |  7 +++----
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d839311d7c6e..928bb595d7cc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1617,6 +1617,7 @@ static int move_freepages(struct zone *zone, unsign=
ed long start_pfn,
 		pfn +=3D 1 << order;
 		pages_moved +=3D 1 << order;
 	}
+	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
 =

 	return pages_moved;
 }
@@ -1838,7 +1839,6 @@ static void steal_suitable_fallback(struct zone *zo=
ne, struct page *page,
 	if (free_pages + alike_pages >=3D (1 << (pageblock_order-1)) ||
 			page_group_by_mobility_disabled) {
 		move_freepages(zone, start_pfn, end_pfn, block_type, start_type);
-		set_pageblock_migratetype(page, start_type);
 		block_type =3D start_type;
 	}
 =

@@ -1910,7 +1910,6 @@ static void reserve_highatomic_pageblock(struct pag=
e *page, struct zone *zone)
 	if (migratetype_is_mergeable(mt)) {
 		if (move_freepages_block(zone, page,
 					 mt, MIGRATE_HIGHATOMIC) !=3D -1) {
-			set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
 			zone->nr_reserved_highatomic +=3D pageblock_nr_pages;
 		}
 	}
@@ -1995,7 +1994,6 @@ static bool unreserve_highatomic_pageblock(const st=
ruct alloc_context *ac,
 			 * not fail on zone boundaries.
 			 */
 			WARN_ON_ONCE(ret =3D=3D -1);
-			set_pageblock_migratetype(page, ac->migratetype);
 			if (ret > 0) {
 				spin_unlock_irqrestore(&zone->lock, flags);
 				return ret;
@@ -2607,10 +2605,8 @@ int __isolate_free_page(struct page *page, unsigne=
d int order)
 			 * Only change normal pageblocks (i.e., they can merge
 			 * with others)
 			 */
-			if (migratetype_is_mergeable(mt) &&
-			    move_freepages_block(zone, page, mt,
-						 MIGRATE_MOVABLE) !=3D -1)
-				set_pageblock_migratetype(page, MIGRATE_MOVABLE);
+			if (migratetype_is_mergeable(mt))
+			    move_freepages_block(zone, page, mt, MIGRATE_MOVABLE);
 		}
 	}
 =

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b5c7a9d21257..5f8c658c0853 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -187,7 +187,6 @@ static int set_migratetype_isolate(struct page *page,=
 int migratetype, int isol_
 			spin_unlock_irqrestore(&zone->lock, flags);
 			return -EBUSY;
 		}
-		set_pageblock_migratetype(page, MIGRATE_ISOLATE);
 		zone->nr_isolate_pageblock++;
 		spin_unlock_irqrestore(&zone->lock, flags);
 		return 0;
@@ -261,10 +260,10 @@ static void unset_migratetype_isolate(struct page *=
page, int migratetype)
 		 * should not fail on zone boundaries.
 		 */
 		WARN_ON_ONCE(nr_pages =3D=3D -1);
-	}
-	set_pageblock_migratetype(page, migratetype);
-	if (isolated_page)
+	} else {
+		set_pageblock_migratetype(page, migratetype);
 		__putback_isolated_page(page, order, migratetype);
+	}
 	zone->nr_isolate_pageblock--;
 out:
 	spin_unlock_irqrestore(&zone->lock, flags);
-- =

2.40.1


--=_MailMate_1C4697CD-F1ED-4740-AE59-9B412363D6D0_=
Content-Disposition: attachment;
 filename=v2-0002-mm-enable-move_freepages-to-properly-move-part-of.patch
Content-ID: <37919E81-4BE6-4FD8-B340-6B571FE60D45@nvidia.com>
Content-Type: text/plain;
 name=v2-0002-mm-enable-move_freepages-to-properly-move-part-of.patch
Content-Transfer-Encoding: quoted-printable

=46rom 1734bb24a38052f13e3f2ddb26b82aa043638c95 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 25 Sep 2023 16:55:18 -0400
Subject: [PATCH v2 2/2] mm: enable move_freepages() to properly move part=
 of
 free pages.

alloc_contig_range() uses set_migrateype_isolate(), which eventually call=
s
move_freepages(), to isolate free pages. But move_freepages() was not abl=
e
to move free pages partially covered by the specified range, leaving a ra=
ce
window open[1]. Fix it by teaching move_freepages() to split a free page
when only part of it is going to be moved.

In addition, when a >pageblock_order free page is moved, only its first
pageblock migratetype is changed. It can cause warnings later. Fix it by
set all pageblocks in a free page to the same migratetype after move.

split_free_page() is changed to be used in move_freepages() and
isolate_single_pageblock(). A common code to find the start pfn of a free=

page is refactored in get_freepage_start_pfn().

[1] https://lore.kernel.org/linux-mm/20230920160400.GC124289@cmpxchg.org/=


Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_alloc.c     | 94 +++++++++++++++++++++++++++++++++++++--------
 mm/page_isolation.c | 38 +++++-------------
 2 files changed, 88 insertions(+), 44 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 928bb595d7cc..a86025f5e80a 100644
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
@@ -1588,6 +1587,25 @@ static inline struct page *__rmqueue_cma_fallback(=
struct zone *zone,
 					unsigned int order) { return NULL; }
 #endif
 =

+/*
+ * Get first pfn of the free page, where pfn is in. If this free page do=
es
+ * not exist, return the given pfn.
+ */
+static unsigned long get_freepage_start_pfn(unsigned long pfn)
+{
+	int order =3D 0;
+	unsigned long start_pfn =3D pfn;
+
+	while (!PageBuddy(pfn_to_page(start_pfn))) {
+		if (++order > MAX_ORDER) {
+			start_pfn =3D pfn;
+			break;
+		}
+		start_pfn &=3D ~0UL << order;
+	}
+	return start_pfn;
+}
+
 /*
  * Move the free pages in a range to the freelist tail of the requested =
type.
  * Note that start_page and end_pages are not aligned on a pageblock
@@ -1597,9 +1615,29 @@ static int move_freepages(struct zone *zone, unsig=
ned long start_pfn,
 			  unsigned long end_pfn, int old_mt, int new_mt)
 {
 	struct page *page;
-	unsigned long pfn;
+	unsigned long pfn, pfn2;
 	unsigned int order;
 	int pages_moved =3D 0;
+	unsigned long mt_changed_pfn =3D start_pfn - pageblock_nr_pages;
+	unsigned long new_start_pfn =3D get_freepage_start_pfn(start_pfn);
+
+	/* split at start_pfn if it is in the middle of a free page */
+	if (new_start_pfn !=3D start_pfn && PageBuddy(pfn_to_page(new_start_pfn=
))) {
+		struct page *new_page =3D pfn_to_page(new_start_pfn);
+		int new_page_order =3D buddy_order(new_page);
+
+		if (new_start_pfn + (1 << new_page_order) > start_pfn) {
+			/* change migratetype so that split_free_page can work */
+			set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
+			split_free_page(new_page, buddy_order(new_page),
+					start_pfn - new_start_pfn);
+
+			mt_changed_pfn =3D start_pfn;
+			/* move to next page */
+			start_pfn =3D new_start_pfn + (1 << new_page_order);
+		}
+	}
+
 =

 	for (pfn =3D start_pfn; pfn <=3D end_pfn;) {
 		page =3D pfn_to_page(pfn);
@@ -1614,10 +1652,43 @@ static int move_freepages(struct zone *zone, unsi=
gned long start_pfn,
 =

 		order =3D buddy_order(page);
 		move_to_free_list(page, zone, order, old_mt, new_mt);
+		/*
+		 * set page migratetype 1) only after we move all free pages in
+		 * one pageblock and 2) for all pageblocks within the page.
+		 *
+		 * for 1), since move_to_free_list() checks page migratetype with
+		 * old_mt and changing one page migratetype affects all pages
+		 * within the same pageblock, if we are moving more than
+		 * one free pages in the same pageblock, setting migratetype
+		 * right after first move_to_free_list() triggers the warning
+		 * in the following move_to_free_list().
+		 *
+		 * for 2), when a free page order is greater than pageblock_order,
+		 * all pageblocks within the free page need to be changed after
+		 * move_to_free_list().
+		 */
+		if (pfn + (1 << order) > pageblock_end_pfn(pfn)) {
+			for (pfn2 =3D pfn;
+			     pfn2 < min_t(unsigned long,
+					  pfn + (1 << order),
+					  end_pfn + 1);
+			     pfn2 +=3D pageblock_nr_pages) {
+				set_pageblock_migratetype(pfn_to_page(pfn2),
+							  new_mt);
+				mt_changed_pfn =3D pfn2;
+			}
+			/* split the free page if it goes beyond the specified range */
+			if (pfn + (1 << order) > (end_pfn + 1))
+				split_free_page(page, order, end_pfn + 1 - pfn);
+		}
 		pfn +=3D 1 << order;
 		pages_moved +=3D 1 << order;
 	}
-	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
+	/* set migratetype for the remaining pageblocks */
+	for (pfn2 =3D mt_changed_pfn + pageblock_nr_pages;
+	     pfn2 <=3D end_pfn;
+	     pfn2 +=3D pageblock_nr_pages)
+		set_pageblock_migratetype(pfn_to_page(pfn2), new_mt);
 =

 	return pages_moved;
 }
@@ -6213,14 +6284,7 @@ int alloc_contig_range(unsigned long start, unsign=
ed long end,
 	 */
 =

 	order =3D 0;
-	outer_start =3D start;
-	while (!PageBuddy(pfn_to_page(outer_start))) {
-		if (++order > MAX_ORDER) {
-			outer_start =3D start;
-			break;
-		}
-		outer_start &=3D ~0UL << order;
-	}
+	outer_start =3D get_freepage_start_pfn(start);
 =

 	if (outer_start !=3D start) {
 		order =3D buddy_order(pfn_to_page(outer_start));
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 5f8c658c0853..e053386f5e3a 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -380,11 +380,8 @@ static int isolate_single_pageblock(unsigned long bo=
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
@@ -408,8 +405,6 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, int flags,
 			 * can be migrated. Otherwise, fail the isolation.
 			 */
 			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
-				int order;
-				unsigned long outer_pfn;
 				int page_mt =3D get_pageblock_migratetype(page);
 				bool isolate_page =3D !is_migrate_isolate_page(page);
 				struct compact_control cc =3D {
@@ -427,9 +422,11 @@ static int isolate_single_pageblock(unsigned long bo=
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
@@ -451,25 +448,8 @@ static int isolate_single_pageblock(unsigned long bo=
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

2.40.1


--=_MailMate_1C4697CD-F1ED-4740-AE59-9B412363D6D0_=--

--=_MailMate_3F821280-010D-460B-B686-6CE960EA35BB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUbe+UPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUyfYQAIAbNWc6MXBxE+1umVjFoe/arHmvQVG2rw0B
eygo64HOt9vmz4Nbz5bs/4rr+eEOShQpBi+sczTbdb2BS2omcduy0h/mcq86/0uf
tC/PuLF4EVzEDhqd733BRlleKAy2WpV5AnZxOczZGeg+7en1MGOS1MtBaB8n10+0
5r5tgTHJhdpl2vk0KIUVNfy6L5O5g4Rch/+uJghOvGkmv6CaVrKiu72dzt9o3s7Y
/BfqsePAFeXyjtNa+coEBgB1Z0ylEzkK99BBdzKEUKvvi0MxpD2G0gHXG78EY/ym
GKzBTY2WS76+df+uDZ6bcj3XwTM1wYJgA6nLc6YsGqN+lUSjM1HS5v+ZKWuBFjUq
CCAqMVXXM+sAQaAsC7YQUy51MmhvpUWaEUeDh7O0gukSfRVK3dptC/cu/BatMl6+
GTBBEXDp+HMXhOD4uwXfQKEfVhx7rKc8cQex8Cnww4YwUAyMM2sV8+PB4oVLdKKL
LJy25xmeZPG0+1LbSKPvJTc4Db/IPoeSBPSP4yvjkMjeK9fW3m1jE9ItpyRfBENk
YmQrFqIPNHApOz2Cj4YIKVz2sVublTPi5UdhiSXwgIIxwnOrh5QxA/xVbD8THncy
YgXkCrxyqNTyZp3JQTfWE2OWUp21XILkGvBCgp2Jsr3TnMnMrGN7buW4MHVnuSiG
8vbfwrAE
=Xrkx
-----END PGP SIGNATURE-----

--=_MailMate_3F821280-010D-460B-B686-6CE960EA35BB_=--
