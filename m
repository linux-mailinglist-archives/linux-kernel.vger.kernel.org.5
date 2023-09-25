Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82287AE094
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjIYVMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjIYVMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:12:53 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FD2109
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 14:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7XCzwn2q58EFp/0Z8w4Vdbku/nokicSUo1mnNnotvH5/FoNi8WCCLmCBw3mc1vqeRVk534RYabAA84HFU3q5ygV36trb/vYfmtfv/zwbyGqtesLN2IP46SaXurcpJcyiMR5JQKUauvFoXcpmk30xflSCzcaAybsaTOwE0wjBvsi7YBcPEplMxFXgD7X52pAFP4towULs2MYcXfU5v8S6qwUbS/9/beXk11eUPvFCJL6ZcgjTlCND0esEPy+8hvw6peqN3MyRkjwhNs9U0bBpV9vAvvV9RYsFuVBONmDZB1SuEonSBl5Te6qhrjVA4tD4B8Hs73/4kTmC0KCtqa7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oOzKJw1gP700V5UZoSUGR0xjG9MaUyXY9VPq8d3PQ0=;
 b=OuHMza2LCK3xnBQEDN6bqWqnWw5nZR8l0Bz2iTAEqCfDE69FzqYc6hkBZF8PooH/CuO3C9OG72rpC9PDE1oo37rF+8OiNdQFISfZVWPRag4l+Moju2AmtB/cElSG0XOThzUUHXfoFZ4lzDEpqDRw4V+HXVobPP+cbM1YLFHIv84QPQB2tOJnOEIksfytJap7WWDZobuR/cpY+mPWRTAHe32DgJ/1i75zLUIUPt/qOwiIpoY3g9W3rX0T7Nn8f1nV0YocZRDCjE/gQ7VmKUemckU8SVjcY0CYzczTXuJlwO4EQQS0+0Y1oMcjMqqDOFCJeMRLjnuUJCIxbcScoj7MXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oOzKJw1gP700V5UZoSUGR0xjG9MaUyXY9VPq8d3PQ0=;
 b=erSdkuv1pi1//BrDEn5AGS/O5SyzvBL/P35oC//Kemzyf3YBHSiosFDZVTOd7DF19EgiZCQ1MgyiwJ2xBkSFNKe88eEvdmav5CRG3ryq0vWOdDxTxZfBf9aljf8Q/JY5u0sl1D/b/FHKC4r2OCT28akqs6K8R242NlcW6Z4uD0WZJWy34hI9ESaddpiFgIA846C0xf2uNBK/9fKV6rErZOgThsbRxvQTGdRTFPRbXrn6IwIcHvcQaVRiXm4CTqnRhvLqXrCozE3xmThUid50tV+F/5d62mwA43OV1YdoL54T5EcPr2ZHU83RzQB8dJDhFibZmUzmqdnSdtQvrX5MDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN0PR12MB6366.namprd12.prod.outlook.com (2603:10b6:208:3c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 25 Sep
 2023 21:12:41 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 21:12:41 +0000
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
Date:   Mon, 25 Sep 2023 17:12:38 -0400
X-Mailer: MailMate (1.14r5984)
Message-ID: <92AE29D4-E715-447C-AF99-ECF42383C74D@nvidia.com>
In-Reply-To: <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
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
Content-Type: multipart/signed;
 boundary="=_MailMate_D3509A16-2E23-4036-85E2-6E8ABAD9711A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:208:134::15) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN0PR12MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: b804451b-0637-4009-6200-08dbbe0c273e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nB6J3TyHQGXb7mmjMFrGLaO+nxdjgHPuMIUSX/Gv15OXw897gtRd9WgkEO15dkcaayc8mMDTLmvHRdDzrtCuIDX+XO/98ZhWMw4zHyOR2lIZVXfgAqpr2wjYriTGtZHOCztGmREfLtcJrsjNPG3ni6jO7tTCzh4m5NnSh1G1Z+hlJ9CZNHD+MbdPou9KuIWAIHVDWBdw5yBQpZ+zi2l1CC3uUVAjhudLd8pe5rgHo5uhOiip6n4rrvn1xL0En54fg2OUMYCEAaIuhjuHO8RZL1Y2xI5vZjXgXUfUxMkuxRrIsO9pHsgY4e5j5/8XZZA2WZfcWkwHDVP/Nnn6BCuu55qPls4prPPfF4/vxTJGIBVfjSAZtLRqshb5mzJoHeV+drQqEwow33E7y1k3c9MxFHx+KOZ1foca6EZqj7U+HCH2QrMqs/ch7AyGcg1/Wc7hXeY9Wr7VK8UP4ciPq+7vKGxg0PJz+KHggil2xbEYeXwdit33MWxRQdtS+8PHW4ui/UON7259KDXY+nUcTl6XpoaKCwvS0VkHZbmtIL39EZg4VAKZsGAOBNi16XjYLmP0xufnK8Up152a9sV96t/uPa/WiXfv/1jAoVMxuDYNUsQ9rLVYKha0lRZxkb6ZaDRU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(451199024)(1800799009)(66946007)(66476007)(41300700001)(66556008)(4326008)(8676002)(8936002)(6916009)(478600001)(54906003)(316002)(5660300002)(33656002)(235185007)(7416002)(2906002)(83380400001)(38100700002)(26005)(53546011)(6512007)(86362001)(6506007)(2616005)(36756003)(6666004)(6486002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YJiV2sEhvr+2aP99cwLxC+QPk0B5uvLWW5W4Pn9zvEvteY355rLKyDbpQIE/?=
 =?us-ascii?Q?MC1Yw7nAhLwhUO5RooXThNJxdb+0BaaRAcR79KW/1Sm2o6W1pHqL4CrmRTtW?=
 =?us-ascii?Q?GxFAsRJn0HGINfXxP3dz+LSSZdgMJlYYG1Roj/gxA9SAksTxOXcTch+FsH2z?=
 =?us-ascii?Q?eBIR4YVpQYQF0Hka9y2zBo0i9r+dIohdOJVL4qvesE1oI7B5hZbU4PJ1HSjt?=
 =?us-ascii?Q?gWi8k4XDJqfvVAVC/MbfQIf96Et9ZZ3lAe/MSFPnPeYsFvCmDbyaCAFKWmNh?=
 =?us-ascii?Q?cR+EgYB7DpXJBDAU6n+H9fV2nSHnwTpdR6LkQLqI65BQ589g4QywZ/ryUXje?=
 =?us-ascii?Q?6Y54GfV2kSshUpEiFm2C5D3fGFn6kJniAeROQAFEcUOhHFpGedVslk67+53c?=
 =?us-ascii?Q?TV1yquffQLsvtvwxASm8rnHCQc4WZX0PvB3qEWKgBJWMqEZ7MYnciMtmNxjo?=
 =?us-ascii?Q?06nWr3M6Ow1OIR6EOZ4TqxQjYEPln4ZiXLkLEiI2ZreLUtuOZxdHk4xCo/Rw?=
 =?us-ascii?Q?K+fME8wNLQSPdCZlStCz/IN2K5a7GHLp7mdflJTwVMT+uR8T0c3qAkCUYLun?=
 =?us-ascii?Q?MKrVtw3OhXRxLGzJR0buE4oEg7tqTcC+jhRucCXpESAkEggCzmiy0z5LpqN4?=
 =?us-ascii?Q?wTHO+Up2xOTKGB7qYy7aTSPM6fFOtx6t+8uwTr+fC/NJFQqpUTiyVMSsIg0e?=
 =?us-ascii?Q?WtX9MHSuA9UmSAF+w1KhMFt7bDNPa4Ux+Pn+X3MHgp0+HajOWEptR0q630Cm?=
 =?us-ascii?Q?LZtW5/nWyNFCMwiTjXgi+mxPdc7JHipEF8y3BD3HlxztpwQvL9uhVxnnmv4n?=
 =?us-ascii?Q?VNVO8I0+XtGPUcSXml3JbOKIJOR9efJSAx2DD5gWtjZPPSqbAFInyyi8YOex?=
 =?us-ascii?Q?awcqRvSi2SjmwfvG8pMEgxFwyqbjwA5YxCBr8yBvdNWt0/zVmaD5S5MMW80l?=
 =?us-ascii?Q?0AAHxbTfE829EB4CHEQpFvC4OfG+Kmqq07zIMWm4gGde/KHAwH+bWV7kiQ+P?=
 =?us-ascii?Q?dLqjjaNLAE7vcVWJ+z21q/aImjhO716t90zYRo4IYMIF17UwKqZI8dcFl3hH?=
 =?us-ascii?Q?vPVlDtlbtc+/wYMYVmNDZ3waygIDbIKfPI9oApPLxxoervj93hDLa+bd/PKq?=
 =?us-ascii?Q?spD183yBZyUlNMoNZiKV9lwxBvL07E2D+eT8gH0A1hH8Bb4zPXlPW3fhq+G2?=
 =?us-ascii?Q?ynGOkASlOnIu5DF8arAyhouv38WLXpfTx7pPRvJ7o81BSv0V2FVfvABaqOVn?=
 =?us-ascii?Q?/oQyJxJql2e3K0trbuQb59GotMwyzXPhM6yQGcvG35N7j9vYlmf7UrA/X6CO?=
 =?us-ascii?Q?jspryqh8v84Qk8iNH7QzpDVhBHGlyYEMXxV5KMXWWgiRPwuCpuejqRnuzhqt?=
 =?us-ascii?Q?LMpkShstGkiZPwxOUJTO46nurxlrqWSiixMsdGRCx4MwU3FAFYxs4PdpKjUH?=
 =?us-ascii?Q?KNMjwb3hXPUrMVmfbKouLfAcFvv1E2QMpYR5JuWYgjUrG5EB1a55vjAM5nN0?=
 =?us-ascii?Q?2QXrHYi7yMq9iclzF0fNtK6YEP6njHEC2Wk9mvWBPiWc7IvnSN2bBhsUicOs?=
 =?us-ascii?Q?PAiy0L05O44RNBCs364=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b804451b-0637-4009-6200-08dbbe0c273e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 21:12:41.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0quZtwzZoCRTj+Vcd/MbDL3xWyda84bfGL0H4jXSsvoeBQRGk7m4Gi+C4RPVXbc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6366
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_D3509A16-2E23-4036-85E2-6E8ABAD9711A_=
Content-Type: multipart/mixed;
 boundary="=_MailMate_FB65EABD-9F1F-4B2C-9210-43596C3140C9_="


--=_MailMate_FB65EABD-9F1F-4B2C-9210-43596C3140C9_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 21 Sep 2023, at 10:47, Zi Yan wrote:

> On 21 Sep 2023, at 6:19, David Hildenbrand wrote:
>
>> On 21.09.23 04:31, Zi Yan wrote:
>>> On 20 Sep 2023, at 13:23, Zi Yan wrote:
>>>
>>>> On 20 Sep 2023, at 12:04, Johannes Weiner wrote:
>>>>
>>>>> On Wed, Sep 20, 2023 at 09:48:12AM -0400, Johannes Weiner wrote:
>>>>>> On Wed, Sep 20, 2023 at 08:07:53AM +0200, Vlastimil Babka wrote:
>>>>>>> On 9/20/23 03:38, Zi Yan wrote:
>>>>>>>> On 19 Sep 2023, at 20:32, Mike Kravetz wrote:
>>>>>>>>
>>>>>>>>> On 09/19/23 16:57, Zi Yan wrote:
>>>>>>>>>> On 19 Sep 2023, at 14:47, Mike Kravetz wrote:
>>>>>>>>>>
>>>>>>>>>>> 	--- a/mm/page_alloc.c
>>>>>>>>>>> 	+++ b/mm/page_alloc.c
>>>>>>>>>>> 	@@ -1651,8 +1651,13 @@ static bool prep_move_freepages_block=
(struct zone *zone, struct page *page,
>>>>>>>>>>>   		end =3D pageblock_end_pfn(pfn) - 1;
>>>>>>>>>>>
>>>>>>>>>>>   		/* Do not cross zone boundaries */
>>>>>>>>>>> 	+#if 0
>>>>>>>>>>>   		if (!zone_spans_pfn(zone, start))
>>>>>>>>>>> 			start =3D zone->zone_start_pfn;
>>>>>>>>>>> 	+#else
>>>>>>>>>>> 	+	if (!zone_spans_pfn(zone, start))
>>>>>>>>>>> 	+		start =3D pfn;
>>>>>>>>>>> 	+#endif
>>>>>>>>>>> 	 	if (!zone_spans_pfn(zone, end))
>>>>>>>>>>> 	 		return false;
>>>>>>>>>>> 	I can still trigger warnings.
>>>>>>>>>>
>>>>>>>>>> OK. One thing to note is that the page type in the warning cha=
nged from
>>>>>>>>>> 5 (MIGRATE_ISOLATE) to 0 (MIGRATE_UNMOVABLE) with my suggested=
 change.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Just to be really clear,
>>>>>>>>> - the 5 (MIGRATE_ISOLATE) warning was from the __alloc_pages ca=
ll path.
>>>>>>>>> - the 0 (MIGRATE_UNMOVABLE) as above was from the alloc_contig_=
range call
>>>>>>>>>    path WITHOUT your change.
>>>>>>>>>
>>>>>>>>> I am guessing the difference here has more to do with the alloc=
ation path?
>>>>>>>>>
>>>>>>>>> I went back and reran focusing on the specific migrate type.
>>>>>>>>> Without your patch, and coming from the alloc_contig_range call=
 path,
>>>>>>>>> I got two warnings of 'page type is 0, passed migratetype is 1'=
 as above.
>>>>>>>>> With your patch I got one 'page type is 0, passed migratetype i=
s 1'
>>>>>>>>> warning and one 'page type is 1, passed migratetype is 0' warni=
ng.
>>>>>>>>>
>>>>>>>>> I could be wrong, but I do not think your patch changes things.=

>>>>>>>>
>>>>>>>> Got it. Thanks for the clarification.
>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> One idea about recreating the issue is that it may have to do=
 with size
>>>>>>>>>>> of my VM (16G) and the requested allocation sizes 4G.  Howeve=
r, I tried
>>>>>>>>>>> to really stress the allocations by increasing the number of =
hugetlb
>>>>>>>>>>> pages requested and that did not help.  I also noticed that I=
 only seem
>>>>>>>>>>> to get two warnings and then they stop, even if I continue to=
 run the
>>>>>>>>>>> script.
>>>>>>>>>>>
>>>>>>>>>>> Zi asked about my config, so it is attached.
>>>>>>>>>>
>>>>>>>>>> With your config, I still have no luck reproducing the issue. =
I will keep
>>>>>>>>>> trying. Thanks.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Perhaps try running both scripts in parallel?
>>>>>>>>
>>>>>>>> Yes. It seems to do the trick.
>>>>>>>>
>>>>>>>>> Adjust the number of hugetlb pages allocated to equal 25% of me=
mory?
>>>>>>>>
>>>>>>>> I am able to reproduce it with the script below:
>>>>>>>>
>>>>>>>> while true; do
>>>>>>>>   echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugep=
ages&
>>>>>>>>   echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugep=
ages&
>>>>>>>>   wait
>>>>>>>>   echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepage=
s
>>>>>>>>   echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugep=
ages
>>>>>>>> done
>>>>>>>>
>>>>>>>> I will look into the issue.
>>>>>>
>>>>>> Nice!
>>>>>>
>>>>>> I managed to reproduce it ONCE, triggering it not even a second af=
ter
>>>>>> starting the script. But I can't seem to do it twice, even after
>>>>>> several reboots and letting it run for minutes.
>>>>>
>>>>> I managed to reproduce it reliably by cutting the nr_hugepages
>>>>> parameters respectively in half.
>>>>>
>>>>> The one that triggers for me is always MIGRATE_ISOLATE. With some
>>>>> printk-tracing, the scenario seems to be this:
>>>>>
>>>>> #0                                                   #1
>>>>> start_isolate_page_range()
>>>>>    isolate_single_pageblock()
>>>>>      set_migratetype_isolate(tail)
>>>>>        lock zone->lock
>>>>>        move_freepages_block(tail) // nop
>>>>>        set_pageblock_migratetype(tail)
>>>>>        unlock zone->lock
>>>>>                                                       del_page_from=
_freelist(head)
>>>>>                                                       expand(head, =
head_mt)
>>>>>                                                         WARN(head_m=
t !=3D tail_mt)
>>>>>      start_pfn =3D ALIGN_DOWN(MAX_ORDER_NR_PAGES)
>>>>>      for (pfn =3D start_pfn, pfn < end_pfn)
>>>>>        if (PageBuddy())
>>>>>          split_free_page(head)
>>>>>
>>>>> IOW, we update a pageblock that isn't MAX_ORDER aligned, then drop =
the
>>>>> lock. The move_freepages_block() does nothing because the PageBuddy=
()
>>>>> is set on the pageblock to the left. Once we drop the lock, the bud=
dy
>>>>> gets allocated and the expand() puts things on the wrong list. The
>>>>> splitting code that handles MAX_ORDER blocks runs *after* the tail
>>>>> type is set and the lock has been dropped, so it's too late.
>>>>
>>>> Yes, this is the issue I can confirm as well. But it is intentional =
to enable
>>>> allocating a contiguous range at pageblock granularity instead of MA=
X_ORDER
>>>> granularity. With your changes below, it no longer works, because if=
 there
>>>> is an unmovable page in
>>>> [ALIGN_DOWN(start_pfn, MAX_ORDER_NR_PAGES), pageblock_start_pfn(star=
t_pfn)),
>>>> the allocation fails but it would succeed in current implementation.=

>>>>
>>>> I think a proper fix would be to make move_freepages_block() split t=
he
>>>> MAX_ORDER page and put the split pages in the right migratetype free=
 lists.
>>>>
>>>> I am working on that.
>>>
>>> After spending half a day on this, I think it is much harder than I t=
hought
>>> to get alloc_contig_range() working with the freelist migratetype hyg=
iene
>>> patchset. Because alloc_contig_range() relies on racy migratetype cha=
nges:
>>>
>>> 1. pageblocks in the range are first marked as MIGRATE_ISOLATE to pre=
vent
>>> another parallel isolation, but they are not moved to the MIGRATE_ISO=
LATE
>>> free list yet.
>>>
>>> 2. later in the process, isolate_freepages_range() is used to actuall=
y grab
>>> the free pages.
>>>
>>> 3. there was no problem when alloc_contig_range() works on MAX_ORDER =
aligned
>>> ranges, since MIGRATE_ISOLATE cannot be set in the middle of free pag=
es or
>>> in-use pages. But it is not the case when alloc_contig_range() work o=
n
>>> pageblock aligned ranges. Now during isolation phase, free or in-use =
pages
>>> will need to be split to get their subpages into the right free lists=
=2E
>>>
>>> 4. the hardest case is when a in-use page sits across two pageblocks,=
 currently,
>>> the code just isolate one pageblock, migrate the page, and let split_=
free_page()
>>> to correct the free list later. But to strictly enforce freelist migr=
atetype
>>> hygiene, extra work is needed at free page path to split the free pag=
e into
>>> the right freelists.
>>>
>>> I need more time to think about how to get alloc_contig_range() prope=
rly.
>>> Help is needed for the bullet point 4.
>>
>>
>> I once raised that we should maybe try making MIGRATE_ISOLATE a flag t=
hat preserves the original migratetype. Not sure if that would help here =
in any way.
>
> I have that in my backlog since you asked and have been delaying it. ;)=
 Hopefully
> I can do it after I fix this. That change might or might not help only =
if we make
> some redesign on how migratetype is managed. If MIGRATE_ISOLATE does no=
t
> overwrite existing migratetype, the code might not need to split a page=
 and move
> it to MIGRATE_ISOLATE freelist?
>
> The fundamental issue in alloc_contig_range() is that to work at
> pageblock level, a page (>pageblock_order) can have one part is isolate=
d and
> the rest is a different migratetype. {add_to,move_to,del_page_from}_fre=
e_list()
> now checks first pageblock migratetype, so such a page needs to be remo=
ved
> from its free_list, set MIGRATE_ISOLATE on one of the pageblock, split,=
 and
> finally put back to multiple free lists. This needs to be done at isola=
tion stage
> before free pages are removed from their free lists (the stage after is=
olation).
> If MIGRATE_ISOLATE is a separate flag and we are OK with leaving isolat=
ed pages
> in their original migratetype and check migratetype before allocating a=
 page,
> that might help. But that might add extra work (e.g., splitting a parti=
ally
> isolated free page before allocation) in the really hot code path, whic=
h is not
> desirable.
>
>>
>> The whole alloc_contig_range() implementation is quite complicated and=
 hard to grasp. If we could find ways to clean all that up and make it ea=
sier to understand and play along, that would be nice.
>
> I will try my best to simplify it.

Hi Johannes,

I attached three patches to fix the issue and first two can be folded int=
o
your patchset:

1. __free_one_page() bug you and Vlastimil discussed on the other email.
2. move set_pageblock_migratetype() into move_freepages() to prepare for =
patch 3.
3. enable move_freepages() to split a free page that is partially covered=
 by
   [start_pfn, end_pfn] in the parameter and set migratetype correctly wh=
en
   a >pageblock_order free page is moved. Before when a >pageblock_order
   free page is moved, only first pageblock migratetype is changed. The a=
dded
   WARN_ON_ONCE might be triggered by these pages.

I ran Mike's test with transhuge-stress together with my patches on top o=
f your
"close migratetype race" patch for more than an hour without any warning.=

It should unblock your patchset. I will keep working on alloc_contig_rang=
e()
simplification.


--
Best Regards,
Yan, Zi

--=_MailMate_FB65EABD-9F1F-4B2C-9210-43596C3140C9_=
Content-Disposition: attachment; filename=0001-mm-fix-__free_one_page.patch
Content-ID: <CD9A53A3-59AA-47AD-960E-5706AC3EDF93@nvidia.com>
Content-Type: text/plain; name=0001-mm-fix-__free_one_page.patch
Content-Transfer-Encoding: quoted-printable

=46rom a18de9a235dc97999fcabdac699f33da9138b0ba Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Fri, 22 Sep 2023 11:11:32 -0400
Subject: [PATCH 1/3] mm: fix __free_one_page().

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_alloc.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7de022bc4c7d..72f27d14c8e7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -787,8 +787,6 @@ static inline void __free_one_page(struct page *page,=

 	VM_BUG_ON_PAGE(bad_range(zone, page), page);
 =

 	while (order < MAX_ORDER) {
-		int buddy_mt;
-
 		if (compaction_capture(capc, page, order, migratetype))
 			return;
 =

@@ -796,8 +794,6 @@ static inline void __free_one_page(struct page *page,=

 		if (!buddy)
 			goto done_merging;
 =

-		buddy_mt =3D get_pfnblock_migratetype(buddy, buddy_pfn);
-
 		if (unlikely(order >=3D pageblock_order)) {
 			/*
 			 * We want to prevent merge between freepages on pageblock
@@ -827,7 +823,7 @@ static inline void __free_one_page(struct page *page,=

 		if (page_is_guard(buddy))
 			clear_page_guard(zone, buddy, order);
 		else
-			del_page_from_free_list(buddy, zone, order, buddy_mt);
+			del_page_from_free_list(buddy, zone, order, migratetype);
 		combined_pfn =3D buddy_pfn & pfn;
 		page =3D page + (combined_pfn - pfn);
 		pfn =3D combined_pfn;
-- =

2.40.1


--=_MailMate_FB65EABD-9F1F-4B2C-9210-43596C3140C9_=
Content-Disposition: attachment;
 filename=0002-mm-set-migratetype-after-free-pages-are-moved-betwee.patch
Content-ID: <456E1F58-9992-4475-A00A-89AF100F9B2E@nvidia.com>
Content-Type: text/plain;
 name=0002-mm-set-migratetype-after-free-pages-are-moved-betwee.patch
Content-Transfer-Encoding: quoted-printable

=46rom b11a0e3d8f9d7d91a884c90dc9cebb185c3a2bbc Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 25 Sep 2023 16:27:14 -0400
Subject: [PATCH 2/3] mm: set migratetype after free pages are moved betwe=
en
 free lists.

This avoids changing migratetype after move_freepages() or
move_freepages_block(), which is error prone. It also prepares for upcomi=
ng
changes to fix move_freepages() not moving free pages partially in the
range.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/page_alloc.c     | 10 +++-------
 mm/page_isolation.c |  2 --
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 72f27d14c8e7..7c41cb5d8a36 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1618,6 +1618,7 @@ static int move_freepages(struct zone *zone, unsign=
ed long start_pfn,
 		pfn +=3D 1 << order;
 		pages_moved +=3D 1 << order;
 	}
+	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
 =

 	return pages_moved;
 }
@@ -1839,7 +1840,6 @@ static void steal_suitable_fallback(struct zone *zo=
ne, struct page *page,
 	if (free_pages + alike_pages >=3D (1 << (pageblock_order-1)) ||
 			page_group_by_mobility_disabled) {
 		move_freepages(zone, start_pfn, end_pfn, block_type, start_type);
-		set_pageblock_migratetype(page, start_type);
 		block_type =3D start_type;
 	}
 =

@@ -1911,7 +1911,6 @@ static void reserve_highatomic_pageblock(struct pag=
e *page, struct zone *zone)
 	if (migratetype_is_mergeable(mt)) {
 		if (move_freepages_block(zone, page,
 					 mt, MIGRATE_HIGHATOMIC) !=3D -1) {
-			set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
 			zone->nr_reserved_highatomic +=3D pageblock_nr_pages;
 		}
 	}
@@ -1996,7 +1995,6 @@ static bool unreserve_highatomic_pageblock(const st=
ruct alloc_context *ac,
 			 * not fail on zone boundaries.
 			 */
 			WARN_ON_ONCE(ret =3D=3D -1);
-			set_pageblock_migratetype(page, ac->migratetype);
 			if (ret > 0) {
 				spin_unlock_irqrestore(&zone->lock, flags);
 				return ret;
@@ -2608,10 +2606,8 @@ int __isolate_free_page(struct page *page, unsigne=
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
index b5c7a9d21257..ee7818ff4e12 100644
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
@@ -262,7 +261,6 @@ static void unset_migratetype_isolate(struct page *pa=
ge, int migratetype)
 		 */
 		WARN_ON_ONCE(nr_pages =3D=3D -1);
 	}
-	set_pageblock_migratetype(page, migratetype);
 	if (isolated_page)
 		__putback_isolated_page(page, order, migratetype);
 	zone->nr_isolate_pageblock--;
-- =

2.40.1


--=_MailMate_FB65EABD-9F1F-4B2C-9210-43596C3140C9_=
Content-Disposition: attachment;
 filename=0003-mm-enable-move_freepages-to-properly-move-part-of-fr.patch
Content-ID: <0246F8C9-6146-44B0-9E32-0F5D894F349D@nvidia.com>
Content-Type: text/plain;
 name=0003-mm-enable-move_freepages-to-properly-move-part-of-fr.patch
Content-Transfer-Encoding: quoted-printable

=46rom 75a4d327efd94230f3b9aab29ef6ec0badd488a6 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 25 Sep 2023 16:55:18 -0400
Subject: [PATCH 3/3] mm: enable move_freepages() to properly move part of=
 free
 pages.

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
 mm/page_alloc.c     | 75 ++++++++++++++++++++++++++++++++++++---------
 mm/page_isolation.c | 17 +++++++---
 2 files changed, 73 insertions(+), 19 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7c41cb5d8a36..3fd5ab40b55c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -866,15 +866,15 @@ int split_free_page(struct page *free_page,
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
@@ -900,7 +900,6 @@ int split_free_page(struct page *free_page,
 			split_pfn_offset =3D (1UL << order) - (pfn - free_page_pfn);
 	}
 out:
-	spin_unlock_irqrestore(&zone->lock, flags);
 	return ret;
 }
 /*
@@ -1589,6 +1588,25 @@ static inline struct page *__rmqueue_cma_fallback(=
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
@@ -1598,9 +1616,29 @@ static int move_freepages(struct zone *zone, unsig=
ned long start_pfn,
 			  unsigned long end_pfn, int old_mt, int new_mt)
 {
 	struct page *page;
-	unsigned long pfn;
+	unsigned long pfn, pfn2;
 	unsigned int order;
 	int pages_moved =3D 0;
+	unsigned long mt_change_pfn =3D start_pfn;
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
+			mt_change_pfn =3D start_pfn;
+			/* move to next page */
+			start_pfn =3D new_start_pfn + (1 << new_page_order);
+		}
+	}
+
 =

 	for (pfn =3D start_pfn; pfn <=3D end_pfn;) {
 		page =3D pfn_to_page(pfn);
@@ -1615,10 +1653,24 @@ static int move_freepages(struct zone *zone, unsi=
gned long start_pfn,
 =

 		order =3D buddy_order(page);
 		move_to_free_list(page, zone, order, old_mt, new_mt);
+		/*
+		 * set page migratetype for all pageblocks within the page and
+		 * only after we move all free pages in one pageblock
+		 */
+		if (pfn + (1 << order) >=3D pageblock_end_pfn(pfn)) {
+			for (pfn2 =3D pfn; pfn2 < pfn + (1 << order);
+			     pfn2 +=3D pageblock_nr_pages) {
+				set_pageblock_migratetype(pfn_to_page(pfn2),
+							  new_mt);
+				mt_change_pfn =3D pfn2;
+			}
+		}
 		pfn +=3D 1 << order;
 		pages_moved +=3D 1 << order;
 	}
-	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
+	/* set migratetype for the remaining pageblocks */
+	for (pfn2 =3D mt_change_pfn; pfn2 <=3D end_pfn; pfn2 +=3D pageblock_nr_=
pages)
+		set_pageblock_migratetype(pfn_to_page(pfn2), new_mt);
 =

 	return pages_moved;
 }
@@ -6214,14 +6266,7 @@ int alloc_contig_range(unsigned long start, unsign=
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
index ee7818ff4e12..b5f90ae03190 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -380,8 +380,15 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, int flags,
 			int order =3D buddy_order(page);
 =

 			if (pfn + (1UL << order) > boundary_pfn) {
+				int res;
+				unsigned long flags;
+
+				spin_lock_irqsave(&zone->lock, flags);
+				res =3D split_free_page(page, order, boundary_pfn - pfn);
+				spin_unlock_irqrestore(&zone->lock, flags);
+
 				/* free page changed before split, check it again */
-				if (split_free_page(page, order, boundary_pfn - pfn))
+				if (res)
 					continue;
 			}
 =

@@ -426,9 +433,11 @@ static int isolate_single_pageblock(unsigned long bo=
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
-- =

2.40.1


--=_MailMate_FB65EABD-9F1F-4B2C-9210-43596C3140C9_=--

--=_MailMate_D3509A16-2E23-4036-85E2-6E8ABAD9711A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUR98YPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUoZgP/34z0jj0Rhy7zSGTlzUNnaG5MqTM2zB5S7WS
HdaID/pyRcIWonDtCJRfMfyQHLrjk2ftSh9tpu8hbfIauES/l8Sw6Zr8yh5Xy7Ab
94rwUwmYv6N9XNjw7ya1bDmxqMe7y0g2g1M/G71YTHyxFrgMO862N7YCzbWCTr3z
++z4uBqd+S+wLSyrjmQtVEqzPcTN1Mj4e8sqfWdeXbiewWancYy18nS2JEpg4ve1
brfeOcRsGD1hSRii4sBL0s4SejYbNd5OlbLUmrg3XO4hskjTOG0zPFaGDokIMNoF
6VHV4YjdcquxMTFg1UxMwdNRKZrEaOdnQgz9ROJSsOtnr1YjxxR049RIg0V557yJ
twTrhb3A0EqJ4GPtPLt/soyhSY8deNd+ftxcpb/gmcRAm+FhDHzCRpa6OEKtbLOB
3MI2lZ1LhoegNV87V7+c+vD1jx8hp2Y0W64h7PAGf/cX4qUcWEAQZ2RGRPbiFvWh
BlAR5eD9fPwwAQhBuC7VaRW0DrIinpLlJT54BBnheH73KISjWnrwWCX7Ae8ii+zu
pSBbNie+lXZjWD1lEVG3vnERAwfET0wfwezleFpFGpbVG+ExYwsq3Mi4hOQT7rCV
8jNnA5RyavvgPmoZtbkJAMD+sVYUywOLHzZN1Ye1jtyN2lsh6HuOc1zx+3Fao1h3
7SpZoFkv
=Bejz
-----END PGP SIGNATURE-----

--=_MailMate_D3509A16-2E23-4036-85E2-6E8ABAD9711A_=--
