Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A657CB4E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjJPUsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjJPUst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:48:49 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5687EE1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDv4Y/0JKFWY5hi7DJSclRUe4CQGSQ8qsjiPtpbootMHbvj+/fRJuFtSYa7+m6wKKLzD9EnXypNrDNlNvHCdkS5TgkMOh3fGSO0gCpZu6rGmF0tc5WED8XMpqZgR6SKfgKBRlhGH6UtEmjDxVrT/GALcNCmfUokecrZEKXm4Fd0nwXY2MK1PkxMQ3gXKcWur0vXHC7mXRRgVvF0Y+eY2LL04FM0eUMnChsg3EWUvkKEaovd0ZJER64LFjxftIhvNiBhp5wGaobf5Cj7iWpn68Yvq3ltoS75oLSfuIB8JLTp9L4wHvEmWlweybB+4Wyqn3XY3wJbuslwOr+2hlUkTaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbMFXUclETGkHjziGXcJygLwmqJnAsspOspKKCXnxh8=;
 b=Z0+EPE4thKYSsCDBRQ2xBcWpkn9rv1QqyPhavXEVU1m1ssbZm5I0VLOCWBLucoUG1NG/Ao+M3N9zwxNrOPfDjGRda8XB6j/adx1q4yeWjFKWx+tUEJeF8/sHl3Ku7/fL+FaZxhnEUmb/FrLVIf1SSw9r/3W1jEcaG3VRcaO4pU/rH0/GMk4XuRPEbTqzugv3doQTJzLPPukic8DGyHNY1X6++geCW5+g/8Bh5WzoMUFt2P4MUqYYLI4zHY1L5Nj60TP0OLQpKp1fHLmsZ/EqdWuQlFTt0ZfUTqlfcR1fDk7CtaHTHMgWwORqRyk7G6BmolaTfphW06lirrIksgf0rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbMFXUclETGkHjziGXcJygLwmqJnAsspOspKKCXnxh8=;
 b=JNsxn45kqk2McXH6A0v/+hjjXQv/18GUXaoTZkmLWPZHOrHjIIvfOSa1g/9EOqyf2HPsbddRdA/aWFrld4I0t2kMnn+Es3sd312el6xTG5dLv1Wnqs6ifGnxyOsTwhQ8tCE7ohM9qikN7oQk/80gaSxlz49bHVIYDoqdlle1OhuMdudbPsfZPL3TvQPaD8POp0zAaEiOfkhwJWaAXemc5D9s6/bp4eiOWveHRDqcJw8iV2rpoVC5HVaLhEDr18Bb43cmqV55WHGrOyMDeBRSihGqCgUP87QsddO9qw2cR7q3F6tBWv+j0+xvlgHoMYJMxWOpxVxVycqQkqhQiseRow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CY5PR12MB6383.namprd12.prod.outlook.com (2603:10b6:930:3d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.34; Mon, 16 Oct 2023 20:48:43 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 20:48:43 +0000
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
Date:   Mon, 16 Oct 2023 16:48:41 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <236FF93B-FDBC-4168-AD9F-28F53CC1B6C0@nvidia.com>
In-Reply-To: <20231016203935.GB1042487@cmpxchg.org>
References: <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
 <20231010211200.GA129823@cmpxchg.org>
 <D6A142AB-08F6-4335-8D08-1743DFAAD10C@nvidia.com>
 <43350F6E-E56D-41C8-8441-A96D83B7D7C1@nvidia.com>
 <ED43DACB-C77F-40D3-8806-D3F26AD95E8D@nvidia.com>
 <20231016143717.GH470544@cmpxchg.org>
 <5B61B70F-E85D-4E6F-8856-17A90B899F98@nvidia.com>
 <20231016185113.GI470544@cmpxchg.org>
 <6F2C52B6-2031-4694-A124-0DFDE9F88E88@nvidia.com>
 <20231016202629.GA1042487@cmpxchg.org> <20231016203935.GB1042487@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_E0A22BE6-DC02-49A9-A978-5B75737F4F7A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:208:160::40) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CY5PR12MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: ae4b9abc-9215-4675-935a-08dbce8948f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tECs8O++TjIUF/h6wx4hnwekg7LckZ6ueJeFb5Uf2UX+hBIWbMq/tdmESvor5K32ITp7ssX1YLIcle9cyz8kviTsCqyDN7XCTOigxAiFrumbdOLaEZ0hY9z4oxKPZzC5wHRKVU8mMf0ZIQSpP81QauqmF/yXB1Uznnj07mjbUL55CSmq8eVjsZE7thoHvJdlAGjo6S6QGanGUjwsnKg+qJHrA0GSLOBebsOwR6Sryx6tbyrCvr6nxpdgwyo+h7JkPGKAL+rkZ25n1yfeua3CkaZnfzYknfoABUPZP1kLHMmCfbWayuNlzQXUg8/2MZt1+L14GYdCr8Nn92d3JIu98ZOkSjHKK3suHOr9+zq1Ai43szwl0S7aHo6ufaeDYC2A4+asmlQobg2eo8qfpYkC6og8T6Eiaz18vwc2Trc9HMP+czQb6Of/zimU2qjvaXnQF0sXdzLowRQiKC7B2AKOSh1XCA6HQu8zfe99tNT8kmGYhX3jJ7zF5NFxCtX/bS+uvcYKRE+Cer+JBGU6CYHO9Np9SpVuvgy3vjtVdpZmctx10vhKQ5dndgpKu33sXSOuyoCT1Csl4c89EwrrqyWj7KrMnsPSum745tAi/5tAUjSDRaKO5LKFxcqHlV/+Rkqq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(5660300002)(235185007)(2616005)(7416002)(83380400001)(54906003)(66476007)(66556008)(66946007)(6916009)(8936002)(4326008)(8676002)(316002)(6512007)(41300700001)(53546011)(6506007)(2906002)(478600001)(6486002)(38100700002)(33656002)(86362001)(36756003)(26005)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E8WbG9vP23ZmFL560jMlXI4kmsDLRoO7fdCdX9106TbAA4lt8jwrtwS3br0C?=
 =?us-ascii?Q?OAeIPICN4CVMciRoUPVWJ+Z3J6Od/hNi/ACGtjzITX9dpI2OnltGyDqKicsq?=
 =?us-ascii?Q?TzOYvmkdEFL3cdkUPn5okShkNGODJAh41WtlhTuCYyqHOB+gRxpFOyBwEvdk?=
 =?us-ascii?Q?lHSm24Qwfz3wqwVMYwDtwmuv9zx8qSGv5N/W07NHgN9pMAknaPBgetB3dA+r?=
 =?us-ascii?Q?nHSm6aGw5EnV9Dw4sT+MwRfWKlNUkLPAUq4sRq5TPGN2qLQQG7245YDIA9nX?=
 =?us-ascii?Q?IfqcTzQN79jeIGlzQZSUXBdEOvlZJL3jKuGh5MOcnBQV+wsXw1tMQ92vHe6V?=
 =?us-ascii?Q?OQ2LQ+uF3EFRYFkEIjgUVc9PoIApdYHt/DqXi/ACHVsSt/90m3O1I9efSeo3?=
 =?us-ascii?Q?fjIEZYXtuNyQs+AszB2MVGGtTkuRql0oT1i1gTAq5rBBmQQDKoSFmF3Ec+Vp?=
 =?us-ascii?Q?5uiz6s0799fVWzxsWMpofBgsxjvHP7i7UtJu1X0LR4Qe6vTSNkX0k/Mem7rx?=
 =?us-ascii?Q?eXiQWdFDQZyVvyyU0WUF2FKZtcxTfwsKZVVkAitNEDUmNzf2T4f+8rW4km/K?=
 =?us-ascii?Q?dWHzsP9e2lPxJZfX3MEYUdGgQkd+NMjG8lp3ww88ZPZnZdQNdo6qUPBMpbQb?=
 =?us-ascii?Q?H3/jfzcsXv80zWDw0gTnidokiXJkMhWbITCsJ7ob+NyCGcYscQ0ZkU4umbig?=
 =?us-ascii?Q?Ij4svAYX4l3HXy/C71aWt2pOwnGINbsVZH9PiHdBhY5xviZxntffFr6QXF4k?=
 =?us-ascii?Q?WwYZncZ5Hky11ULqJXY7H3Ib746jyPa0w+lij3IG2ncthfWr7Z5vlWzo4jAg?=
 =?us-ascii?Q?R21ytO807b/DJN5NwnqSmniGaS9pKf3FBCwdU+5mFzxY1kGhbrqa1UFWrLbj?=
 =?us-ascii?Q?tcNkLIIBE0etQuQ3nbkFux7HQcu87v3IImrvWG3fA0n/0EiPH+zWXYdmebfM?=
 =?us-ascii?Q?85T/fDpY4HYWveRo77UWSvuLhZ4Tebtns4dcUZS6ImgmNQccERzo4q4l6DRO?=
 =?us-ascii?Q?1po2H+mkdRZXrNztsv6yTd4QdW5SHoDqRtp9JjXGdNRFzafGVMwsfRYAy7GM?=
 =?us-ascii?Q?SJAyOF/Zo/Cq+WRwcGP0oLZzk1fiCDNcqRlmFfWgrZfHTbg5O+RvijygLiML?=
 =?us-ascii?Q?Vw4LcU8XJ04bVKsvqqm/0wNocBRAZPHXp42e/9gIhllY5FvWGnGZJwXIV6D8?=
 =?us-ascii?Q?WQT5TtrQVZ6Vhv7u8WfmaH09fW35+FZAM4wXkE74dyIXKOsQcT/c23LKKYSc?=
 =?us-ascii?Q?D3w2HK/k8RMoTZNN4LTnEEfl5tuTl1gNHhlga9+5w/m+Y+sK83MbTX0NJQhg?=
 =?us-ascii?Q?dNULTMSNWVRhGy95NeDK/HI8OGIO9gXD7M3W44sz73BX7lDn78diqTz1iflX?=
 =?us-ascii?Q?5cV2Av5ou7w03kdYTXqgkbsL2bHY5lhFAEQfP0BIaRRyQLtDxB9shA1Yk4SK?=
 =?us-ascii?Q?TafRAY7VsaSpTNnH5W17Fxw5vZ8prbx7OemZwchM7Ep8ZFtOR70qtf+/qYe8?=
 =?us-ascii?Q?yY4H52UGvIYZr0hJRSKHOMjizgs1LEuV/LufVMNksIu0D3U7vJ4FNu3CW1rg?=
 =?us-ascii?Q?rG/Sf/58JQLSQXs+J9Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae4b9abc-9215-4675-935a-08dbce8948f7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 20:48:43.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cldVyUmhlYmXh/v+6xrG3R4Ds1HBGuM7FO0dhzfHP0Mw6su1CV437FUGwymCSpxn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6383
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_E0A22BE6-DC02-49A9-A978-5B75737F4F7A_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 16 Oct 2023, at 16:39, Johannes Weiner wrote:

> On Mon, Oct 16, 2023 at 04:26:30PM -0400, Johannes Weiner wrote:
>> On Mon, Oct 16, 2023 at 03:49:49PM -0400, Zi Yan wrote:
>>> On 16 Oct 2023, at 14:51, Johannes Weiner wrote:
>>>
>>>> On Mon, Oct 16, 2023 at 11:00:33AM -0400, Zi Yan wrote:
>>>>> On 16 Oct 2023, at 10:37, Johannes Weiner wrote:
>>>>>
>>>>>> On Mon, Oct 16, 2023 at 09:35:34AM -0400, Zi Yan wrote:
>>>>>>>> The attached patch has all the suggested changes, let me know ho=
w it
>>>>>>>> looks to you. Thanks.
>>>>>>>
>>>>>>> The one I sent has free page accounting issues. The attached one =
fixes them.
>>>>>>
>>>>>> Do you still have the warnings? I wonder what went wrong.
>>>>>
>>>>> No warnings. But something with the code:
>>>>>
>>>>> 1. in your version, split_free_page() is called without changing an=
y pageblock
>>>>> migratetypes, then split_free_page() is just a no-op, since the pag=
e is
>>>>> just deleted from the free list, then freed via different orders. B=
uddy allocator
>>>>> will merge them back.
>>>>
>>>> Hm not quite.
>>>>
>>>> If it's the tail block of a buddy, I update its type before
>>>> splitting. The splitting loop looks up the type of each block for
>>>> sorting it onto freelists.
>>>>
>>>> If it's the head block, yes I split it first according to its old
>>>> type. But then I let it fall through to scanning the block, which wi=
ll
>>>> find that buddy, update its type and move it.
>>>
>>> That is the issue, since split_free_page() assumes the pageblocks of
>>> that free page have different types. It basically just free the page
>>> with different small orders summed up to the original free page order=
=2E
>>> If all pageblocks of the free page have the same migratetype, __free_=
one_page()
>>> will merge these small order pages back to the original order free pa=
ge.
>>
>> duh, of course, you're right. Thanks for patiently explaining this.
>>
>>>>> 2. in my version, I set pageblock migratetype to new_mt before spli=
t_free_page(),
>>>>> but it causes free page accounting issues, since in the case of hea=
d, free pages
>>>>> are deleted from new_mt when they are in old_mt free list and the a=
ccounting
>>>>> decreases new_mt free page number instead of old_mt one.
>>>>
>>>> Right, that makes sense.
>>>>
>>>>> Basically, split_free_page() is awkward as it relies on preset migr=
atetypes,
>>>>> which changes migratetypes without deleting the free pages from the=
 list first.
>>>>> That is why I came up with the new split_free_page() below.
>>>>
>>>> Yeah, the in-between thing is bad. Either it fixes the migratetype
>>>> before deletion, or it doesn't do the deletion. I'm thinking it woul=
d
>>>> be simpler to move the deletion out instead.
>>>
>>> Yes and no. After deletion, a free page no longer has PageBuddy set a=
nd
>>> has buddy_order information cleared. Either we reset PageBuddy and or=
der
>>> to the deleted free page, or split_free_page() needs to be changed to=

>>> accept pages without the information (basically remove the PageBuddy
>>> and order check code).
>>
>> Good point, that requires extra care.
>>
>> It's correct in the code now, but it deserves a comment, especially
>> because of the "buddy" naming in the new split function.
>>
>>>>> Hmm, if CONFIG_ARCH_FORCE_MAX_ORDER can make a buddy have more than=
 one
>>>>> pageblock and in turn makes an in-use page have more than one pageb=
lock,
>>>>> we will have problems. Since in isolate_single_pageblock(), an in-u=
se page
>>>>> can have part of its pageblock set to a different migratetype and b=
e freed,
>>>>> causing the free page with unmatched migratetypes. We might need to=

>>>>> free pages at pageblock_order if their orders are bigger than pageb=
lock_order.
>>>>
>>>> Is this a practical issue? You mentioned that right now only giganti=
c
>>>> pages can be larger than a pageblock, and those are freed in order-0=

>>>> chunks.
>>>
>>> Only if the system allocates a page (non hugetlb pages) with >pageblo=
ck_order
>>> and frees it with the same order. I just do not know if such pages ex=
ist on
>>> other arch than x86. Maybe I just think too much.
>>
>> Hm, I removed LRU pages from the handling (and added the warning) but
>> I left in PageMovable(). The only users are z3fold, zsmalloc and
>> memory ballooning. AFAICS none of them can be bigger than a pageblock.=

>> Let me remove that and add a warning for that case as well.
>>
>> This way, we only attempt to migrate hugetlb, where we know the free
>> path - and get warnings for anything else that's larger than expected.=

>>
>> This seems like the safest option. On the off chance that there is a
>> regression, it won't jeopardize anybody's systems, while the warning
>> provides all the information we need to debug what's going on.
>
> This delta on top?
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b5292ad9860c..0da7c61af37e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1628,7 +1628,7 @@ static int move_freepages_block(struct zone *zone=
, struct page *page,
>  }
>
>  #ifdef CONFIG_MEMORY_ISOLATION
> -/* Look for a multi-block buddy that straddles start_pfn */
> +/* Look for a buddy that straddles start_pfn */
>  static unsigned long find_large_buddy(unsigned long start_pfn)
>  {
>  	int order =3D 0;
> @@ -1652,7 +1652,7 @@ static unsigned long find_large_buddy(unsigned lo=
ng start_pfn)
>  	return start_pfn;
>  }
>
> -/* Split a multi-block buddy into its individual pageblocks */
> +/* Split a multi-block free page into its individual pageblocks */
>  static void split_large_buddy(struct zone *zone, struct page *page,
>  			      unsigned long pfn, int order)
>  {
> @@ -1661,6 +1661,9 @@ static void split_large_buddy(struct zone *zone, =
struct page *page,
>  	VM_WARN_ON_ONCE(order < pageblock_order);
>  	VM_WARN_ON_ONCE(pfn & (pageblock_nr_pages - 1));
>
> +	/* Caller removed page from freelist, buddy info cleared! */
> +	VM_WARN_ON_ONCE(PageBuddy(page));
> +
>  	while (pfn !=3D end_pfn) {
>  		int mt =3D get_pfnblock_migratetype(page, pfn);
>
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index b4d53545496d..c8b3c0699683 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -399,14 +399,8 @@ static int isolate_single_pageblock(unsigned long =
boundary_pfn, int flags,
>  				continue;
>  			}
>
> -			VM_WARN_ON_ONCE_PAGE(PageLRU(page), page);
> -
>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
> -			/*
> -			 * hugetlb, and movable compound pages can be
> -			 * migrated. Otherwise, fail the isolation.
> -			 */
> -			if (PageHuge(page) || __PageMovable(page)) {
> +			if (PageHuge(page)) {
>  				struct compact_control cc =3D {
>  					.nr_migratepages =3D 0,
>  					.order =3D -1,
> @@ -426,9 +420,19 @@ static int isolate_single_pageblock(unsigned long =
boundary_pfn, int flags,
>
>  				pfn =3D head_pfn + nr_pages;
>  				continue;
> -			} else
> +			}
> +
> +			/*
> +			 * These pages are movable too, but they're
> +			 * not expected to exceed pageblock_order.
> +			 *
> +			 * Let us know when they do, so we can add
> +			 * proper free and split handling for them.
> +			 */
> +			VM_WARN_ON_ONCE_PAGE(PageLRU(page), page);
> +			VM_WARN_ON_ONCE_PAGE(__PageMovable(page), page);
>  #endif
> -				goto failed;
> +			goto failed;
>  		}
>
>  		pfn++;

LGTM.

I was thinking about adding

VM_WARN_ON_ONCE(order > pageblock_order, page);

in __free_pages() to catch all possible cases, but that is a really hot p=
ath.

And just for the record, we probably can easily fix the above warnings,
if they ever show up, by freeing >pageblock_order pages in unit of
pageblock_order.

--
Best Regards,
Yan, Zi

--=_MailMate_E0A22BE6-DC02-49A9-A978-5B75737F4F7A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUtoakPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUBqAQAJTmuB2otfTbttP2z1GnenhCfGOOA0oGCVIw
VUmyN8nX8As/ZT76fDsq9YzDBMI3h1yPPtF0HUyaq+ztNBOt3HbpFwy/9GZegLv9
fkUUswGsYmZcr5LtfV41tpbMulOvwjkE69zN+0a7r1v/D4feqyQv/NxZmQTxc3Lw
TpPpbfVSYTKKXWY68XSiefCHRJ3w64JnSt1xlKma14QgsE5c+2J2eXk9Cbayx14M
gM0NNOUtgF1/5E7fLt46Hp+I2MNutqHejIHhi2998vlg7WMs73pgTdVN1TJXSAiC
k8IP5NtkUU/HCqp/wx6GpAQ0oCZ2cZx+Tc+VLREUBgT0VIhOFwOhQ+FywjnhdAxY
2m8NBVbPSjkjcrE70kkCEeCt/sFAydBbj0FSqJibEvg4LclWJBQakTxllMrDaHQJ
58EsTnQ67BgpuhSi2vVzB31hXzx/GWZ674H04aSLhK2yKyb5PiC+AAAUYbe5ThbJ
UCUC4PJfQHW+dNtcDKle3Wum56Jqy+qoDDkL5o7SEWZSExiY6gEwpOKtkX75a+3e
aQo3gZsTPfXYPHjC1h96nYQiNxv6CpLQJi4q2qKtApwthd566rmnMqHVywRlYv6V
H4iCGz80H7TaDeOokDTAyVCug6svv9YJ1CwLea9Q3R67dvXMmBGZJb4e16pa2LQg
9nf4+Uz8
=c1fN
-----END PGP SIGNATURE-----

--=_MailMate_E0A22BE6-DC02-49A9-A978-5B75737F4F7A_=--
