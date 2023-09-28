Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70837B10F6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 04:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjI1Cvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 22:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1Cvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 22:51:33 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0271A94
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 19:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isrqBBPqQANoKP+veUJHSBqAb1yYxpwv+H8WOzZbM5Ood/RXCLpxHG7M7VqYR+eg+iHH7TVrZDjfXbrZbav0YP7tRJ9F9K03Ta3uHIau4zUxDY1cVtogtGTXCMsxhBDy72SynSjBkdclaV6VTN92I2BuoMVCiCvjdYgaKygoMDFWUsACPA1OxtpDLHrZsQxn8j1kRbSWQy+OG9pU/MqLbvV1aU1v3loZKQEiT87ELNkUfWx6XRVBT/oYe2fr+V52CReWvNaDQSKLMWBwrOlrSriYqjNjhv9USP7Gnmw+buTodbq/R3DcVu3QUya9bInsMwOHCOBgPLnkzMYkMgcM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9PY33CRDQITQVHMh7IKj1x29pFGpqgIS3njd2+ccTA=;
 b=SZVpOW7B/VfaY7nt4PsSKN209TiIT4DbaRbfjPZkGxJqI/GFjBPgYhCnsQpT/rr9xOHNxQS/7hAMqOh0lQh83YbIdJ4pBx750Q173IFiViC1hkyYoTe8bn6VYjfnp8p+xb0ANp/Ey+HUjxZB8zPk7AZQIMfQNwvAtL0cCzFICSJ3W1QHO74jjK4iXBz539fWeqOkne9E8XGZpIpHwIzXuFX8u1IStXZPjQaDC1tLg+Nx9lZH87AexiumeVzBIdU2vMNnwyB/Z67fVIWQMew8OHLZHSkOF+xKUp19GIuouF630hhNbM9E3UgpS/DNmlW0JokiNUL9ZqJHu5oISg0cjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9PY33CRDQITQVHMh7IKj1x29pFGpqgIS3njd2+ccTA=;
 b=c64GMM60jUyczrB8kj+N4kNbivltluTXgRJ3GybkNENFF2d16oSK2jpd7qJacEFdV0NI+MDUo8a0kgvnqHPcWjlUPfik5G1wgOAX2Zx6G9YWSrjbkj7OVbMIH99RMRHxHBefVKxFrg1a02I8MtS5ACCHyjt/H9BfzwjK63PvCpfVjlCyI6qll1PjvvQXND2jSKOUM/UJV26ACN2KGzIepMuGzvNHnCUph2AW/r5JFPgaY1B5FIhEuHyBq+kyibln3Uap24MHsHY5A3n4Yaw2/vyH1ZSgB7kk2kIxdUGHdENAWRQY6F42vSym6//WY7p/ECwtSIPjOoGjt6BiCklWhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY8PR12MB7753.namprd12.prod.outlook.com (2603:10b6:930:93::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.26; Thu, 28 Sep 2023 02:51:27 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6838.016; Thu, 28 Sep 2023
 02:51:26 +0000
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
Date:   Wed, 27 Sep 2023 22:51:24 -0400
X-Mailer: MailMate (1.14r5987)
Message-ID: <0D2BD71D-5E65-4175-8872-5E70278C57DA@nvidia.com>
In-Reply-To: <20230926173939.GA348484@cmpxchg.org>
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
Content-Type: multipart/signed;
 boundary="=_MailMate_0868C307-12A8-4652-B4B6-48A6710533C5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR0102CA0023.prod.exchangelabs.com
 (2603:10b6:207:18::36) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY8PR12MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: d12ce37d-82dd-4d6c-7a90-08dbbfcdcf1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AUxAvKrvUYiiHRsqelrLX5wn/6hYIkZO+84LuEqk0icZxewLnye8pPkM4ZDs/R5/fE2DAjsfSnfXKXzxo9UuCVZzjngBQ3WT1CnL7kaUWdSq/XFIqxgyAv1FRUyAz5uaUIgqqhzMp1nlMahT9vLReYHOJ3jzofs2m9Itq/R/dujiiq01BnLEotQ8t5UKcK2DqnosvUTPPrQI5+pC8ZMnUkvTmV4NAEO1gI/qrA1L78Xv6qPpRwar7/G2iUhjFIf543K9Cb5F7Nhb+a29Sdtxs3Q/nkyMhOmgrqzuq4bQ5swDRjUqX4cvyU5ypbzBnEyaBxQtVVNuEySvhqWeMo3HazcLTti9iXvYOBa1xcou2x38sKu7+M3u+TsU2DToZYJ6bTQlnuxt2OI3r8AWDNmSs/L0PCOz4lgKWDLTQDKIxrZ5JEpgfhT3PtrKVzJPYcXsN1JvHkSgIjegCDxyFQ5QV254K+UX/hs+XjsWbYXiI9kSDz6HxmEgRN7Hsd5OBNgMYNiLrd5yfg1in+bNf24dfyU07nNvKuHEXKLxFJF2t+E9Piw4G2VzoGGrEU8RMH+FSO8aNLRq69CMBrV36pRK6q2+B8ii3XAaVV5RsfL7JmlV4uJ+tftMZM+RxENQK6d59p6SClKMgEsuf8UdI5yG5xgbJ5SjzhWZHOT2HCz9jB12hsIlbAypJgG5LCnr82yk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6506007)(6486002)(53546011)(66899024)(6512007)(26005)(83380400001)(2616005)(6916009)(316002)(66556008)(66476007)(235185007)(7416002)(33656002)(4326008)(41300700001)(2906002)(54906003)(30864003)(66946007)(38100700002)(86362001)(5660300002)(8936002)(8676002)(966005)(36756003)(478600001)(21314003)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UtC7d4x5YJJlZ6yRrT4+Ok106pSOAsEwywae9fmXQbAZY/21IJcqptFfxNeP?=
 =?us-ascii?Q?YuKOM00m6tqSWmtEKDRD0gZ2/aDVMsLzVdItMSO3PFCHetZJlOq/Aqi1Bcwv?=
 =?us-ascii?Q?sWpS7I1aZvBrPRTGS4D5wHaghV3nSxerhPLSSv+07SMbPMRnQ1XxmNSqBUEK?=
 =?us-ascii?Q?7YuErqW/ebHc73sPTs4Q/c3OIbM09dbXnzQUknI1DZL6E5NvbYyKYr7J4Edn?=
 =?us-ascii?Q?6HbqlyFPi47ChzPnW0m1CnWFCqBTel5hD4ilXvTmR+DDzdEaXPq8AZzjGtJA?=
 =?us-ascii?Q?Psq38E5PyeBLkCJE7iD/5RWgzYVtPPlreT/fg/kCSxH4N0dREm4JtFWbupB6?=
 =?us-ascii?Q?Rezm7HflbJjYhDVYk/MJzt2HvWfUu+6SXT8h0zDffbsbfARAW1ClNR6XxwlJ?=
 =?us-ascii?Q?zrY5geFueRqSuCxZp230t3ooXdnV70dAPdfTW618YU5zdySpsdHemO8oQ/e7?=
 =?us-ascii?Q?7oefQ6LomaGZbHA7QCVcnXhva7zMcwgxCQowCwsegm2Ueow5/+S+2XS3r68U?=
 =?us-ascii?Q?QBbpzKLiXdAR7cGLB9uSdOaq5tyz8w5idXRdTrqKStmLz+cmdqnOIAE9HMiX?=
 =?us-ascii?Q?5/NFR5b/EIrpE/prHHaO9A80Uc+vqZ/TXIDrRAB4d1hrSeLUh7MTAZFmtDfj?=
 =?us-ascii?Q?BBNpQ3UG2fHFRvc9UBRWp8dk0/+cHsgyGymr6tw6pkjxi4WJQ4oJNatCakN6?=
 =?us-ascii?Q?+u1RfiH+f6s909YhsNXBxCT8kWxoGd/cDlcIMjB7zqCHbqtYM6OonIDcrSM+?=
 =?us-ascii?Q?TpVT04/yaIxMwIB+WTTLZrmLzODZcQ5VyY0I4J8DGWD/6HUqnY9RJFy4CKD9?=
 =?us-ascii?Q?vl7qNkF03XgjFDj1sr969Q90iTVy2Xg2nQknzCFEUWU3JXqfjxNj0XPArHXE?=
 =?us-ascii?Q?ds640KzGUQmE0UnE7pPdAQS91ZwdUqWzvvQ3M2RfEJNHYvgPE8/dii42jwdo?=
 =?us-ascii?Q?YU/zAujGA6NOhwTr2tBX3ky79dK2ZUUbR/fIgN99ggZRCvoVloY5RPZLtzML?=
 =?us-ascii?Q?1DIHl20rssOV1uPYwNFYZbPZCxunCsl8YZF3aUVqdV8GeOuKHUpL1V53JkTO?=
 =?us-ascii?Q?APCkkt1Oe6dR51pflPOoZI7LvZDE8PTMi9YmuNZvxBzHADn5MGjUDW83v3hC?=
 =?us-ascii?Q?c/xJX+u2AEQvscY5q/44Xf2P8xK3LnUGVQu3FVrxxGv5fnmjUgP8VE5WS1WV?=
 =?us-ascii?Q?AAuMSylL6rqKJYQgDVuMvR5kanoitgEA9lZO3au3K5iqs+19j0Vl3zWo0GQ7?=
 =?us-ascii?Q?tmqfZ+84WtHtCG10aeF7IqcfI+rY/58zxBDsoDFcwM9y6a62R5To3BtbUIGH?=
 =?us-ascii?Q?r5PsU83WJXZexG+xX3GEDjdvUbpkp6x4Hw5EVlp2axcajGvAI6OJ8hVpK8uU?=
 =?us-ascii?Q?pcAsiqWxwwZSiGfzSBlxd+WVSnJwkqGL6NnX6F3jMYuY/jE2dLlFfK0ODFTj?=
 =?us-ascii?Q?gwbQ4Kq6ZvzUOqS9OBTVCTPsH5433ga+W0Or8O/y2x/SUVNYG42zexm4fJmj?=
 =?us-ascii?Q?s1kpdJWI6OSjy1TrHShf2I1uu6dGy9Gokx6fs4ftabdKHzSXwXYYAjkBdkc4?=
 =?us-ascii?Q?sQUSoCXoohC1LS5ZAzg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12ce37d-82dd-4d6c-7a90-08dbbfcdcf1c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 02:51:26.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHMw+Kwo0DVBTcEo9lRGM+7VeOMDXshadS4mgeM3lXx+sYp5x4o0zvA3zvmhUzfs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7753
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0868C307-12A8-4652-B4B6-48A6710533C5_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 26 Sep 2023, at 13:39, Johannes Weiner wrote:

> On Mon, Sep 25, 2023 at 05:12:38PM -0400, Zi Yan wrote:
>> On 21 Sep 2023, at 10:47, Zi Yan wrote:
>>
>>> On 21 Sep 2023, at 6:19, David Hildenbrand wrote:
>>>
>>>> On 21.09.23 04:31, Zi Yan wrote:
>>>>> On 20 Sep 2023, at 13:23, Zi Yan wrote:
>>>>>
>>>>>> On 20 Sep 2023, at 12:04, Johannes Weiner wrote:
>>>>>>
>>>>>>> On Wed, Sep 20, 2023 at 09:48:12AM -0400, Johannes Weiner wrote:
>>>>>>>> On Wed, Sep 20, 2023 at 08:07:53AM +0200, Vlastimil Babka wrote:=

>>>>>>>>> On 9/20/23 03:38, Zi Yan wrote:
>>>>>>>>>> On 19 Sep 2023, at 20:32, Mike Kravetz wrote:
>>>>>>>>>>
>>>>>>>>>>> On 09/19/23 16:57, Zi Yan wrote:
>>>>>>>>>>>> On 19 Sep 2023, at 14:47, Mike Kravetz wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>> 	--- a/mm/page_alloc.c
>>>>>>>>>>>>> 	+++ b/mm/page_alloc.c
>>>>>>>>>>>>> 	@@ -1651,8 +1651,13 @@ static bool prep_move_freepages_blo=
ck(struct zone *zone, struct page *page,
>>>>>>>>>>>>>   		end =3D pageblock_end_pfn(pfn) - 1;
>>>>>>>>>>>>>
>>>>>>>>>>>>>   		/* Do not cross zone boundaries */
>>>>>>>>>>>>> 	+#if 0
>>>>>>>>>>>>>   		if (!zone_spans_pfn(zone, start))
>>>>>>>>>>>>> 			start =3D zone->zone_start_pfn;
>>>>>>>>>>>>> 	+#else
>>>>>>>>>>>>> 	+	if (!zone_spans_pfn(zone, start))
>>>>>>>>>>>>> 	+		start =3D pfn;
>>>>>>>>>>>>> 	+#endif
>>>>>>>>>>>>> 	 	if (!zone_spans_pfn(zone, end))
>>>>>>>>>>>>> 	 		return false;
>>>>>>>>>>>>> 	I can still trigger warnings.
>>>>>>>>>>>>
>>>>>>>>>>>> OK. One thing to note is that the page type in the warning c=
hanged from
>>>>>>>>>>>> 5 (MIGRATE_ISOLATE) to 0 (MIGRATE_UNMOVABLE) with my suggest=
ed change.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Just to be really clear,
>>>>>>>>>>> - the 5 (MIGRATE_ISOLATE) warning was from the __alloc_pages =
call path.
>>>>>>>>>>> - the 0 (MIGRATE_UNMOVABLE) as above was from the alloc_conti=
g_range call
>>>>>>>>>>>    path WITHOUT your change.
>>>>>>>>>>>
>>>>>>>>>>> I am guessing the difference here has more to do with the all=
ocation path?
>>>>>>>>>>>
>>>>>>>>>>> I went back and reran focusing on the specific migrate type.
>>>>>>>>>>> Without your patch, and coming from the alloc_contig_range ca=
ll path,
>>>>>>>>>>> I got two warnings of 'page type is 0, passed migratetype is =
1' as above.
>>>>>>>>>>> With your patch I got one 'page type is 0, passed migratetype=
 is 1'
>>>>>>>>>>> warning and one 'page type is 1, passed migratetype is 0' war=
ning.
>>>>>>>>>>>
>>>>>>>>>>> I could be wrong, but I do not think your patch changes thing=
s.
>>>>>>>>>>
>>>>>>>>>> Got it. Thanks for the clarification.
>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> One idea about recreating the issue is that it may have to =
do with size
>>>>>>>>>>>>> of my VM (16G) and the requested allocation sizes 4G.  Howe=
ver, I tried
>>>>>>>>>>>>> to really stress the allocations by increasing the number o=
f hugetlb
>>>>>>>>>>>>> pages requested and that did not help.  I also noticed that=
 I only seem
>>>>>>>>>>>>> to get two warnings and then they stop, even if I continue =
to run the
>>>>>>>>>>>>> script.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Zi asked about my config, so it is attached.
>>>>>>>>>>>>
>>>>>>>>>>>> With your config, I still have no luck reproducing the issue=
=2E I will keep
>>>>>>>>>>>> trying. Thanks.
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Perhaps try running both scripts in parallel?
>>>>>>>>>>
>>>>>>>>>> Yes. It seems to do the trick.
>>>>>>>>>>
>>>>>>>>>>> Adjust the number of hugetlb pages allocated to equal 25% of =
memory?
>>>>>>>>>>
>>>>>>>>>> I am able to reproduce it with the script below:
>>>>>>>>>>
>>>>>>>>>> while true; do
>>>>>>>>>>   echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hug=
epages&
>>>>>>>>>>   echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hug=
epages&
>>>>>>>>>>   wait
>>>>>>>>>>   echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepa=
ges
>>>>>>>>>>   echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hug=
epages
>>>>>>>>>> done
>>>>>>>>>>
>>>>>>>>>> I will look into the issue.
>>>>>>>>
>>>>>>>> Nice!
>>>>>>>>
>>>>>>>> I managed to reproduce it ONCE, triggering it not even a second =
after
>>>>>>>> starting the script. But I can't seem to do it twice, even after=

>>>>>>>> several reboots and letting it run for minutes.
>>>>>>>
>>>>>>> I managed to reproduce it reliably by cutting the nr_hugepages
>>>>>>> parameters respectively in half.
>>>>>>>
>>>>>>> The one that triggers for me is always MIGRATE_ISOLATE. With some=

>>>>>>> printk-tracing, the scenario seems to be this:
>>>>>>>
>>>>>>> #0                                                   #1
>>>>>>> start_isolate_page_range()
>>>>>>>    isolate_single_pageblock()
>>>>>>>      set_migratetype_isolate(tail)
>>>>>>>        lock zone->lock
>>>>>>>        move_freepages_block(tail) // nop
>>>>>>>        set_pageblock_migratetype(tail)
>>>>>>>        unlock zone->lock
>>>>>>>                                                       del_page_fr=
om_freelist(head)
>>>>>>>                                                       expand(head=
, head_mt)
>>>>>>>                                                         WARN(head=
_mt !=3D tail_mt)
>>>>>>>      start_pfn =3D ALIGN_DOWN(MAX_ORDER_NR_PAGES)
>>>>>>>      for (pfn =3D start_pfn, pfn < end_pfn)
>>>>>>>        if (PageBuddy())
>>>>>>>          split_free_page(head)
>>>>>>>
>>>>>>> IOW, we update a pageblock that isn't MAX_ORDER aligned, then dro=
p the
>>>>>>> lock. The move_freepages_block() does nothing because the PageBud=
dy()
>>>>>>> is set on the pageblock to the left. Once we drop the lock, the b=
uddy
>>>>>>> gets allocated and the expand() puts things on the wrong list. Th=
e
>>>>>>> splitting code that handles MAX_ORDER blocks runs *after* the tai=
l
>>>>>>> type is set and the lock has been dropped, so it's too late.
>>>>>>
>>>>>> Yes, this is the issue I can confirm as well. But it is intentiona=
l to enable
>>>>>> allocating a contiguous range at pageblock granularity instead of =
MAX_ORDER
>>>>>> granularity. With your changes below, it no longer works, because =
if there
>>>>>> is an unmovable page in
>>>>>> [ALIGN_DOWN(start_pfn, MAX_ORDER_NR_PAGES), pageblock_start_pfn(st=
art_pfn)),
>>>>>> the allocation fails but it would succeed in current implementatio=
n.
>>>>>>
>>>>>> I think a proper fix would be to make move_freepages_block() split=
 the
>>>>>> MAX_ORDER page and put the split pages in the right migratetype fr=
ee lists.
>>>>>>
>>>>>> I am working on that.
>>>>>
>>>>> After spending half a day on this, I think it is much harder than I=
 thought
>>>>> to get alloc_contig_range() working with the freelist migratetype h=
ygiene
>>>>> patchset. Because alloc_contig_range() relies on racy migratetype c=
hanges:
>>>>>
>>>>> 1. pageblocks in the range are first marked as MIGRATE_ISOLATE to p=
revent
>>>>> another parallel isolation, but they are not moved to the MIGRATE_I=
SOLATE
>>>>> free list yet.
>>>>>
>>>>> 2. later in the process, isolate_freepages_range() is used to actua=
lly grab
>>>>> the free pages.
>>>>>
>>>>> 3. there was no problem when alloc_contig_range() works on MAX_ORDE=
R aligned
>>>>> ranges, since MIGRATE_ISOLATE cannot be set in the middle of free p=
ages or
>>>>> in-use pages. But it is not the case when alloc_contig_range() work=
 on
>>>>> pageblock aligned ranges. Now during isolation phase, free or in-us=
e pages
>>>>> will need to be split to get their subpages into the right free lis=
ts.
>>>>>
>>>>> 4. the hardest case is when a in-use page sits across two pageblock=
s, currently,
>>>>> the code just isolate one pageblock, migrate the page, and let spli=
t_free_page()
>>>>> to correct the free list later. But to strictly enforce freelist mi=
gratetype
>>>>> hygiene, extra work is needed at free page path to split the free p=
age into
>>>>> the right freelists.
>>>>>
>>>>> I need more time to think about how to get alloc_contig_range() pro=
perly.
>>>>> Help is needed for the bullet point 4.
>>>>
>>>>
>>>> I once raised that we should maybe try making MIGRATE_ISOLATE a flag=
 that preserves the original migratetype. Not sure if that would help her=
e in any way.
>>>
>>> I have that in my backlog since you asked and have been delaying it. =
;) Hopefully
>>> I can do it after I fix this. That change might or might not help onl=
y if we make
>>> some redesign on how migratetype is managed. If MIGRATE_ISOLATE does =
not
>>> overwrite existing migratetype, the code might not need to split a pa=
ge and move
>>> it to MIGRATE_ISOLATE freelist?
>>>
>>> The fundamental issue in alloc_contig_range() is that to work at
>>> pageblock level, a page (>pageblock_order) can have one part is isola=
ted and
>>> the rest is a different migratetype. {add_to,move_to,del_page_from}_f=
ree_list()
>>> now checks first pageblock migratetype, so such a page needs to be re=
moved
>>> from its free_list, set MIGRATE_ISOLATE on one of the pageblock, spli=
t, and
>>> finally put back to multiple free lists. This needs to be done at iso=
lation stage
>>> before free pages are removed from their free lists (the stage after =
isolation).
>>> If MIGRATE_ISOLATE is a separate flag and we are OK with leaving isol=
ated pages
>>> in their original migratetype and check migratetype before allocating=
 a page,
>>> that might help. But that might add extra work (e.g., splitting a par=
tially
>>> isolated free page before allocation) in the really hot code path, wh=
ich is not
>>> desirable.
>>>
>>>>
>>>> The whole alloc_contig_range() implementation is quite complicated a=
nd hard to grasp. If we could find ways to clean all that up and make it =
easier to understand and play along, that would be nice.
>>>
>>> I will try my best to simplify it.
>>
>> Hi Johannes,
>>
>> I attached three patches to fix the issue and first two can be folded =
into
>> your patchset:
>
> Hi Zi, thanks for providing these patches! I'll pick them up into the
> series.
>
>> 1. __free_one_page() bug you and Vlastimil discussed on the other emai=
l.
>> 2. move set_pageblock_migratetype() into move_freepages() to prepare f=
or patch 3.
>> 3. enable move_freepages() to split a free page that is partially cove=
red by
>>    [start_pfn, end_pfn] in the parameter and set migratetype correctly=
 when
>>    a >pageblock_order free page is moved. Before when a >pageblock_ord=
er
>>    free page is moved, only first pageblock migratetype is changed. Th=
e added
>>    WARN_ON_ONCE might be triggered by these pages.
>>
>> I ran Mike's test with transhuge-stress together with my patches on to=
p of your
>> "close migratetype race" patch for more than an hour without any warni=
ng.
>> It should unblock your patchset. I will keep working on alloc_contig_r=
ange()
>> simplification.
>>
>>
>> --
>> Best Regards,
>> Yan, Zi
>
>> From a18de9a235dc97999fcabdac699f33da9138b0ba Mon Sep 17 00:00:00 2001=

>> From: Zi Yan <ziy@nvidia.com>
>> Date: Fri, 22 Sep 2023 11:11:32 -0400
>> Subject: [PATCH 1/3] mm: fix __free_one_page().
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/page_alloc.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 7de022bc4c7d..72f27d14c8e7 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -787,8 +787,6 @@ static inline void __free_one_page(struct page *pa=
ge,
>>  	VM_BUG_ON_PAGE(bad_range(zone, page), page);
>>
>>  	while (order < MAX_ORDER) {
>> -		int buddy_mt;
>> -
>>  		if (compaction_capture(capc, page, order, migratetype))
>>  			return;
>>
>> @@ -796,8 +794,6 @@ static inline void __free_one_page(struct page *pa=
ge,
>>  		if (!buddy)
>>  			goto done_merging;
>>
>> -		buddy_mt =3D get_pfnblock_migratetype(buddy, buddy_pfn);
>> -
>>  		if (unlikely(order >=3D pageblock_order)) {
>>  			/*
>>  			 * We want to prevent merge between freepages on pageblock
>> @@ -827,7 +823,7 @@ static inline void __free_one_page(struct page *pa=
ge,
>>  		if (page_is_guard(buddy))
>>  			clear_page_guard(zone, buddy, order);
>>  		else
>> -			del_page_from_free_list(buddy, zone, order, buddy_mt);
>> +			del_page_from_free_list(buddy, zone, order, migratetype);
>>  		combined_pfn =3D buddy_pfn & pfn;
>>  		page =3D page + (combined_pfn - pfn);
>>  		pfn =3D combined_pfn;
>
> I had a fix for this that's slightly different. The buddy's type can't
> be changed while it's still on the freelist, so I moved that
> around. The sequence now is:
>
> 	int buddy_mt =3D migratetype;
>
> 	if (unlikely(order >=3D pageblock_order)) {
> 		/* This is the only case where buddy_mt can differ */
> 		buddy_mt =3D get_pfnblock_migratetype(buddy, buddy_pfn);
> 		// compat checks...
> 	}
>
> 	del_page_from_free_list(buddy, buddy_mt);
>
> 	if (unlikely(buddy_mt !=3D migratetype))
> 		set_pageblock_migratetype(buddy, migratetype);
>
>
>> From b11a0e3d8f9d7d91a884c90dc9cebb185c3a2bbc Mon Sep 17 00:00:00 2001=

>> From: Zi Yan <ziy@nvidia.com>
>> Date: Mon, 25 Sep 2023 16:27:14 -0400
>> Subject: [PATCH 2/3] mm: set migratetype after free pages are moved be=
tween
>>  free lists.
>>
>> This avoids changing migratetype after move_freepages() or
>> move_freepages_block(), which is error prone. It also prepares for upc=
oming
>> changes to fix move_freepages() not moving free pages partially in the=

>> range.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> This makes the code much cleaner, thank you!
>
>> From 75a4d327efd94230f3b9aab29ef6ec0badd488a6 Mon Sep 17 00:00:00 2001=

>> From: Zi Yan <ziy@nvidia.com>
>> Date: Mon, 25 Sep 2023 16:55:18 -0400
>> Subject: [PATCH 3/3] mm: enable move_freepages() to properly move part=
 of free
>>  pages.
>>
>> alloc_contig_range() uses set_migrateype_isolate(), which eventually c=
alls
>> move_freepages(), to isolate free pages. But move_freepages() was not =
able
>> to move free pages partially covered by the specified range, leaving a=
 race
>> window open[1]. Fix it by teaching move_freepages() to split a free pa=
ge
>> when only part of it is going to be moved.
>>
>> In addition, when a >pageblock_order free page is moved, only its firs=
t
>> pageblock migratetype is changed. It can cause warnings later. Fix it =
by
>> set all pageblocks in a free page to the same migratetype after move.
>>
>> split_free_page() is changed to be used in move_freepages() and
>> isolate_single_pageblock(). A common code to find the start pfn of a f=
ree
>> page is refactored in get_freepage_start_pfn().
>>
>> [1] https://lore.kernel.org/linux-mm/20230920160400.GC124289@cmpxchg.o=
rg/
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/page_alloc.c     | 75 ++++++++++++++++++++++++++++++++++++--------=
-
>>  mm/page_isolation.c | 17 +++++++---
>>  2 files changed, 73 insertions(+), 19 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 7c41cb5d8a36..3fd5ab40b55c 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -866,15 +866,15 @@ int split_free_page(struct page *free_page,
>>  	struct zone *zone =3D page_zone(free_page);
>>  	unsigned long free_page_pfn =3D page_to_pfn(free_page);
>>  	unsigned long pfn;
>> -	unsigned long flags;
>>  	int free_page_order;
>>  	int mt;
>>  	int ret =3D 0;
>>
>> -	if (split_pfn_offset =3D=3D 0)
>> -		return ret;
>> +	/* zone lock should be held when this function is called */
>> +	lockdep_assert_held(&zone->lock);
>>
>> -	spin_lock_irqsave(&zone->lock, flags);
>> +	if (split_pfn_offset =3D=3D 0 || split_pfn_offset >=3D (1 << order))=

>> +		return ret;
>>
>>  	if (!PageBuddy(free_page) || buddy_order(free_page) !=3D order) {
>>  		ret =3D -ENOENT;
>> @@ -900,7 +900,6 @@ int split_free_page(struct page *free_page,
>>  			split_pfn_offset =3D (1UL << order) - (pfn - free_page_pfn);
>>  	}
>>  out:
>> -	spin_unlock_irqrestore(&zone->lock, flags);
>>  	return ret;
>>  }
>>  /*
>> @@ -1589,6 +1588,25 @@ static inline struct page *__rmqueue_cma_fallba=
ck(struct zone *zone,
>>  					unsigned int order) { return NULL; }
>>  #endif
>>
>> +/*
>> + * Get first pfn of the free page, where pfn is in. If this free page=
 does
>> + * not exist, return the given pfn.
>> + */
>> +static unsigned long get_freepage_start_pfn(unsigned long pfn)
>> +{
>> +	int order =3D 0;
>> +	unsigned long start_pfn =3D pfn;
>> +
>> +	while (!PageBuddy(pfn_to_page(start_pfn))) {
>> +		if (++order > MAX_ORDER) {
>> +			start_pfn =3D pfn;
>> +			break;
>> +		}
>> +		start_pfn &=3D ~0UL << order;
>> +	}
>> +	return start_pfn;
>> +}
>> +
>>  /*
>>   * Move the free pages in a range to the freelist tail of the request=
ed type.
>>   * Note that start_page and end_pages are not aligned on a pageblock
>> @@ -1598,9 +1616,29 @@ static int move_freepages(struct zone *zone, un=
signed long start_pfn,
>>  			  unsigned long end_pfn, int old_mt, int new_mt)
>>  {
>>  	struct page *page;
>> -	unsigned long pfn;
>> +	unsigned long pfn, pfn2;
>>  	unsigned int order;
>>  	int pages_moved =3D 0;
>> +	unsigned long mt_change_pfn =3D start_pfn;
>> +	unsigned long new_start_pfn =3D get_freepage_start_pfn(start_pfn);
>> +
>> +	/* split at start_pfn if it is in the middle of a free page */
>> +	if (new_start_pfn !=3D start_pfn && PageBuddy(pfn_to_page(new_start_=
pfn))) {
>> +		struct page *new_page =3D pfn_to_page(new_start_pfn);
>> +		int new_page_order =3D buddy_order(new_page);
>> +
>> +		if (new_start_pfn + (1 << new_page_order) > start_pfn) {
>> +			/* change migratetype so that split_free_page can work */
>> +			set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
>> +			split_free_page(new_page, buddy_order(new_page),
>> +					start_pfn - new_start_pfn);
>> +
>> +			mt_change_pfn =3D start_pfn;
>> +			/* move to next page */
>> +			start_pfn =3D new_start_pfn + (1 << new_page_order);
>> +		}
>> +	}
>
> Ok, so if there is a straddle from the previous block into our block
> of interest, it's split and the migratetype is set only on our block.

Correct. For example, start_pfn is 0x200 (2MB) and the free page starting=
 from 0x0 is order-10 (4MB).

>
>> @@ -1615,10 +1653,24 @@ static int move_freepages(struct zone *zone, u=
nsigned long start_pfn,
>>
>>  		order =3D buddy_order(page);
>>  		move_to_free_list(page, zone, order, old_mt, new_mt);
>> +		/*
>> +		 * set page migratetype for all pageblocks within the page and
>> +		 * only after we move all free pages in one pageblock
>> +		 */
>> +		if (pfn + (1 << order) >=3D pageblock_end_pfn(pfn)) {
>> +			for (pfn2 =3D pfn; pfn2 < pfn + (1 << order);
>> +			     pfn2 +=3D pageblock_nr_pages) {
>> +				set_pageblock_migratetype(pfn_to_page(pfn2),
>> +							  new_mt);
>> +				mt_change_pfn =3D pfn2;
>> +			}
>
> But if we have the first block of a MAX_ORDER chunk, then we don't
> split but rather move the whole chunk and make sure to update the
> chunk's blocks that are outside the range of interest.
>
> It looks like either way would work, but why not split here as well
> and keep the move contained to the block? Wouldn't this be a bit more
> predictable and easier to understand?

Yes, having a split here would be consistent.

Also I want to spell out the corner case I am handling here (and I will a=
dd
it to the comment): since move_to_free_list() checks page's migratetype
with old_mt and changing one page' migratetype affects all pages within
the same pageblock, if we are moving more than one free pages that are
in the same pageblock, setting migratetype right after move_to_free_list(=
)
triggers the warning.

>> +		}
>>  		pfn +=3D 1 << order;
>>  		pages_moved +=3D 1 << order;
>>  	}
>> -	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
>> +	/* set migratetype for the remaining pageblocks */
>> +	for (pfn2 =3D mt_change_pfn; pfn2 <=3D end_pfn; pfn2 +=3D pageblock_=
nr_pages)
>> +		set_pageblock_migratetype(pfn_to_page(pfn2), new_mt);
>
> I think I'm missing something for this.
>
> - If there was no straddle, there is only our block of interest to
>   update.
>
> - If there was a straddle from the previous block, it was split and
>   the block of interest was already updated. Nothing to do here?
>
> - If there was a straddle into the next block, both blocks are updated
>   to the new type. Nothing to do here?
>
> What's the case where there are multiple blocks to update in the end?

When a pageblock has free pages at the beginning and in-use pages at the =
end.
The pageblock migratetype is not changed in the for loop above, since fre=
e
pages do not cross pageblock boundary. But these free pages are moved
to a new mt free list and will trigger warnings later.

Also if multiple pageblocks are filled with only in-use pages, the for lo=
op
does nothing either. Their pageblocks will be set at this moment. I notic=
e
it might be a change of behavior as I am writing, but this change might
be better. Before, in-page migrateype might or might not be changed,
depending on if there is a free page in the same pageblock or not, meanin=
g
there will be migratetype holes in the specified range. Now the whole ran=
ge
is changed to new_mt. Let me know if you have a different opinion.


>> @@ -380,8 +380,15 @@ static int isolate_single_pageblock(unsigned long=
 boundary_pfn, int flags,
>>  			int order =3D buddy_order(page);
>>
>>  			if (pfn + (1UL << order) > boundary_pfn) {
>> +				int res;
>> +				unsigned long flags;
>> +
>> +				spin_lock_irqsave(&zone->lock, flags);
>> +				res =3D split_free_page(page, order, boundary_pfn - pfn);
>> +				spin_unlock_irqrestore(&zone->lock, flags);
>> +
>>  				/* free page changed before split, check it again */
>> -				if (split_free_page(page, order, boundary_pfn - pfn))
>> +				if (res)
>>  					continue;
>
> At this point, we've already set the migratetype, which has handled
> straddling free pages. Is this split still needed?

Good point. I will remove it. Originally, I thought it should stay to han=
dle
the free page coming from the migration below. But unless a greater than =
pageblock
order in-use page shows up in the system and it is freed directly via __f=
ree_pages(),
any free page coming from the migration below should be put in the right
free list.

Such > pageblock order pages are possible, only if we have >PMD order THP=
s
or __PageMovable. IIRC, both do not exist yet.

>
>> @@ -426,9 +433,11 @@ static int isolate_single_pageblock(unsigned long=
 boundary_pfn, int flags,
>>  				/*
>>  				 * XXX: mark the page as MIGRATE_ISOLATE so that
>>  				 * no one else can grab the freed page after migration.
>> -				 * Ideally, the page should be freed as two separate
>> -				 * pages to be added into separate migratetype free
>> -				 * lists.
>> +				 * The page should be freed into separate migratetype
>> +				 * free lists, unless the free page order is greater
>> +				 * than pageblock order. It is not the case now,
>> +				 * since gigantic hugetlb is freed as order-0
>> +				 * pages and LRU pages do not cross pageblocks.
>>  				 */
>>  				if (isolate_page) {
>>  					ret =3D set_migratetype_isolate(page, page_mt,
>
> I hadn't thought about LRU pages being constrained to single
> pageblocks before. Does this mean we only ever migrate here in case

Initially, I thought a lot about what if a high order folio crosses
two adjacent pageblocks, but at the end I find that __find_buddy_pfn()
does not treat pfns from adjacent pageblocks as buddy unless order
is greater than pageblock order. So any high order folio from
buddy allocator does not cross pageblocks. That is a relief.

Another (future) possibility is once anon large folio is merged and
my split huge page to any lower order patches are merged, a high order
folio might not come directly from buddy allocator but from a huge page
split. But that requires a > pageblock order folio exist first, which
is not possible either. So we are good.

> there is a movable gigantic page? And since those are already split
> during the free, does that mean the "reset pfn to head of the free
> page" part after the migration is actually unnecessary?

Yes. the "reset pfn" code could be removed.

Thank you for the review. Really appreciate it. Let me revise my
patch 3 and send it out again.


--
Best Regards,
Yan, Zi

--=_MailMate_0868C307-12A8-4652-B4B6-48A6710533C5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUU6iwPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUQ+MQAKJuCHXIi3u/CRg6NpllS9Ow7k6+7hlbEooU
00G7cJPenKiiWrpn2selTj/ig3z6fq7ezXsT+kGv71bq9aQRNCQiGdtv5X8+9Eb3
BgN/FaGUj6+ahqLwE5oueNWt3b8A3EYLOSOqwdHUUkHdb9smXdV5mc4y+oVIABW3
scyjsIF1wbKZxs/JISmSly5pJKarZ+oYobv8R2jAZhmXRA5DDrqk9yLPl81i9ehp
EU3UWWHXYcjO8/X5HzzsncFB4xKqOc+WVJ6V1E/57hWzIB0in+aITS9PZ9siOO+m
WyO9L+8Zo8w2qEa4jv8L2ZYLdENpPmSRbYDaJD65PJgPomEjSmn/dxzqucSO8Cwa
OipXoO1LWLHvMZCfTkQyDXrcbWD6yiumDZY0VKwvaqSwMBHyotkWnpSpA483jmLf
HIiGgnbqzNITU4nweEpJ7xI7RkSTCbhJlyXkVXrzSKCxjYPD/Iex55s7Mp8oLQg+
fYb+2M7Ac6Csx/cbMQv3ucOxMXNLsKX+vDeYFgwH+8sHss0A7Fwj6Pk0RhqMMaWS
qK6o4zSHE4sqEqvxnyVIZhCv4WVnFwPJwlnpGmjE6o2y7KssYs/7ws1oJrG4ei63
9JlusQ2Y7o80tw+Am2Q58796lOIdKymcJmH210ETzUwXPkkmJ1WoTxBATgpHpfmT
3CjpVws9
=CPbs
-----END PGP SIGNATURE-----

--=_MailMate_0868C307-12A8-4652-B4B6-48A6710533C5_=--
