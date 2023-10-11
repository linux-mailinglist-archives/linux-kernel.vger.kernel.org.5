Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E839A7C58AC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjJKP5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjJKP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:57:33 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAE691
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCM/LnwWHVMMYBK5MQKrdcKrrzL42Wh90z5gc5iJH/Oyxuf9HbRQ5tWIQRhIOvvTbh/wp4rth3Nqtp5VFdxuOoli3ow+msL5jDeAbeuS2IyW0ecdiqpyOVFyFY4iGHJLTBJbnEOMYxkcrk5ED9LAP+4vraUHaBDvBHFtv4EZPrw0akwE1+SbQphOit4zY7bjI0QWuRU22gFR+eKa8kfilyJY8KyJKrIbdVgPSp+R6/XeKrp6NOLUOcPb0IHLoZOwJIdscbqjMNEtfyyT0x5EksmDCZ0gOwQfZdJ9nJI/RwgG66Oq8OzYJrenokaUZe4oc2Wxv8JFSdQ9Kyxs7wmydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A9QL/CwsjXZQyLS6Cqt3xXf7Rr4IfZbzdZwWPo6d49A=;
 b=jUzCO/7GuCo1f03yTwEkNgsXpjzbcgrIdVIC6TjNagU2eivlBrCzW0LIjQ6ruuUHpKUR7kg10zWT12okCKbI2tF+kR9h110i+1mX0zdbsOi7U4HsBEXg40vA81GIHwL71/1Q39JX5q0hSjG68/W1LQYr/dz9bG2FYMCMiz+gvaCAq/ffb/6w5tEmYfPbvsuuVBLror7Feu8IvCg5oA4BmQSXt2Qay541mQfbDK36sh1JtDxAn7ky9WZ39Y2n0xXWETkbITKWhTeubwYn3fMbWhspHOldkcLz0uHP2PVkaZTGoAzW4bki7P166qCUvjLQc3tBaqHC20kygVuLNFTq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A9QL/CwsjXZQyLS6Cqt3xXf7Rr4IfZbzdZwWPo6d49A=;
 b=GI3va7QMJMtYACv23LgsiZxTpmodvNLUhdzKHSQbTq5Lbgp0FLuPOrD9cDb20E1TraH+/y31w45c73WTSey9Gz8mYqfqUvIHhe16rJcwfauNnQeguQ+WI5XKF7dz45Dw7khKOYr5HMjYwq9inuXYZp6KoP++yDmbK4Yen53pFRU3Wy0ZCnHhKHZOxWtgsmMoZgbubIV084sLFBlOTXPJ4uUXlNeJhdLyzxj0/ctzJJcgRFIHBruHNx9sA1Hf+fxk34jPS7xzBBhIPU72Ip7WMKTadq+mMlhGMjvAVJKREv7v7ubcD25R6AFaGMQvdoHidll6hVRt8vuhkEHIaAQzCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 LV8PR12MB9208.namprd12.prod.outlook.com (2603:10b6:408:182::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 15:57:28 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 15:57:28 +0000
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
Date:   Wed, 11 Oct 2023 11:57:25 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <0D740F12-1431-4844-B285-3D9BDFA351D9@nvidia.com>
In-Reply-To: <20231011154532.GB461170@cmpxchg.org>
References: <762CA634-053A-41DD-8ED7-895374640858@nvidia.com>
 <D4F59724-61EB-4DA5-94DF-59E79F0F1FB3@nvidia.com>
 <505e7f55-f63a-b33d-aa10-44de16d2d3cc@redhat.com>
 <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
 <92AE29D4-E715-447C-AF99-ECF42383C74D@nvidia.com>
 <20230926173939.GA348484@cmpxchg.org>
 <0D2BD71D-5E65-4175-8872-5E70278C57DA@nvidia.com>
 <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
 <20231010211200.GA129823@cmpxchg.org> <20231011152525.GA461170@cmpxchg.org>
 <20231011154532.GB461170@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_53CDA1A5-7300-42AE-9DA0-B2A9C4EE08AE_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR20CA0054.namprd20.prod.outlook.com
 (2603:10b6:208:235::23) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|LV8PR12MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f3b374-8642-4a6e-928f-08dbca72c4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCQlsi3YG0E6l16b3/IRAbVbU5uSV+okOuS3CpWJC7CBWyfu6eJx3836Y7CBmwSyZ6/iiqVux5eKbSDZ71GHKy7InFxrNBm2K7c3r9EDLhtcOEG1wp4J1Kwq0kDzyLQIPWHaNTHUZfooWmsDGRT6v2pt37aHWfyh+rBjgULv8fg/ucf5Wg10g5EX6GHR6mZ3vz6f12ee7/5A8Rm/vhPOqeo0NZOJQzML1lPpW4afdm9O0bgcsR/jQwGYHO5423mfxASGLbLv2Hys02UefEkyIsmKfIiqkD0tQp3MxM/GC1W5NM8jgWkGF7jGxioUNaXKy378AYy9Y3dSrD8MScHVrk4vAIx0Ob8RGwaPCKfvX/x5HBB8/s24keGROUYb5XXS24vCQ2fqIBs6PjLRuEEI+ldP22QHiB+dVmcEMHCSq8zGfNM+dczLYyIYKoO2zpfC3NYYHd2olvUGvixX3ITzaJaib6HOVCwXFCLOB5wq3frvvz9XMU55SXCaPvX6lYlT4m+iUFtXTRdp9u7OebA9hVKWM4SvOxRM7cKwujAWsuaU6X0xqMAWpS6uLVXv01H3uYsUNuU8z6Y1cghWkavuUDitCGqqWWGnmNWlQlXQ0AGD6wYFlELG8NEtkIwa/PtY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(53546011)(26005)(6506007)(2616005)(83380400001)(54906003)(38100700002)(66946007)(6512007)(66556008)(66476007)(6486002)(6666004)(6916009)(316002)(478600001)(8936002)(5660300002)(86362001)(41300700001)(8676002)(4326008)(36756003)(33656002)(7416002)(235185007)(2906002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w5UNaumTcGBoPK8WvNmr+mZzo0TGyq7qWyIz+SgVbsSew5IxfRtoD2iMoL49?=
 =?us-ascii?Q?7p2qEQXCsPbZyRHzUCj6Z2OSogaod8OpBsq+aWTyhsMbgyNJQOj2cmcm97dH?=
 =?us-ascii?Q?rodcEo+7wbaTpeEV4ZRQinSci8A8d0vNTUNLPF5S36Zl+PCZYwUDSRoh5zsf?=
 =?us-ascii?Q?Frvx5PBZcYKTDw3ao0svKkrARa7h6B1J8LEBV06tLj7GQnSa9AQcdp7I+EEi?=
 =?us-ascii?Q?POHoWI3IqC2Dvtd+R4Z5yvrLWtowhjmwdphyHKCXqw/SKiy5J4z/Z6h0euLD?=
 =?us-ascii?Q?M22xUxrGJRrJAlkVi4Y3QxDpfUstsVK87DP4I5gL4HEZ0XkWmYGuuahL/Y4N?=
 =?us-ascii?Q?ZT01NwT3J0jg40QIXPvMar++2oHP9xA2OakxgwMKKH1aA4O/Aj3gn/9Yz1C4?=
 =?us-ascii?Q?LBo901iQrT8VU+19QYB9FHoP/6QhI2ywQye9iyijc8eTgj5wyMvkjvbQqAoQ?=
 =?us-ascii?Q?3Pv+z8H1StqD1rYNA6O4JqVY5tS77anT6aaWmN/+QHMMUEWzqWnmRfXZlKFs?=
 =?us-ascii?Q?o6JO2SjgNdJKlyTjZHbM/pTERR2o/cl7V1xAubi65gw93w73FerRx/QQxGyH?=
 =?us-ascii?Q?p4dcvz8MRsh6QQDiAgntO0fcd/zQ14qkxrwYRvuhxuIG+tesOLJkqaVGmijY?=
 =?us-ascii?Q?EGrUYL15rqaHVsNyEJzVoMUS4O+ETqE9+DrQf7xT/XNFCjxrtwjMrEfTgPr7?=
 =?us-ascii?Q?t0E5p3QyA+sw/PtaFNaAS2jwOKKvJLNLVdChISn0MaCBIShtcjp4SUWG1cUV?=
 =?us-ascii?Q?sP913YJI+Wni9qwncnhrbE8pOoS6k1tyzXdCKSq92GOA1WcXj1SsUf93cKUm?=
 =?us-ascii?Q?/I4fhiNHGm4+RK9euhwUHmlD/Q3jJhikwlvp/jce7Qpoc6p10Hy0vypATZan?=
 =?us-ascii?Q?8NU6bwYn5cLAIsiRqTMcqo7XhrlD5KfOKrXKtOFGokT9EFwt5OUvc5Q1DpEM?=
 =?us-ascii?Q?L8KcyuDn0wpcNc9oUDet/UHO0+uFasjD398qaJWVP6Xd7jAv0iIjaXwk6ksn?=
 =?us-ascii?Q?7dT6qjLAV2Vk902YMyPJnEySy1PKY2D4yqMjGwI+4Ft6XUdWSMXnl8mdvpX5?=
 =?us-ascii?Q?XnCOxV2m4TDzYUe8/i0uR3lT+eFsBFEkjSkubOoB8HnF71GYHiMp9MlyCBZ6?=
 =?us-ascii?Q?3npdGI3G4QpFJ7YmoDkUHfHalJCgeKYnp6RzevGSPsVXWtiA+2xbMoF+yggA?=
 =?us-ascii?Q?LOV2LpTO5umml9OaJHLREGgzRMsgVBSmf0t6oL9XuIiDU2wn25P50RWcEBtp?=
 =?us-ascii?Q?+mUx16bp3hscwi9IqeQDmtqo+sZKoTbh53SN/y4RovZs/IOTjt8AfvsrUj58?=
 =?us-ascii?Q?Gf/9YhbTqSLh+cu3PxJX5NrYAI+mm7HqT6efRWcAgu5qJVENzYITuCwZ2Cj2?=
 =?us-ascii?Q?oTsvBmWmQzkZrga4Rt8zeztkYFWqMU3aFxz16XJkqMYcOIfy05OFRIfICqSE?=
 =?us-ascii?Q?QvgnOB8h20tjSqfDUhvCidZO2up98mjIaS8iuXknKWRn0VrseVK60G0IPU/P?=
 =?us-ascii?Q?BZRMdjMs+s4kVy4+U0X+yUeDuwKhRNtlXEhB+e/6HL1TODLvQGiep1kb2HWr?=
 =?us-ascii?Q?zsrLnhxL4KDUnv9l3HiWvNcphsxGBZ8HUnax0SXh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f3b374-8642-4a6e-928f-08dbca72c4ed
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 15:57:28.4646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3g8P1njmFZvDzHBQvF9k7DbTT0vvCfgQvZ4foUIlOBQ/c+p5zrSpJn0RnGL4Ge/h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9208
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_53CDA1A5-7300-42AE-9DA0-B2A9C4EE08AE_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 11 Oct 2023, at 11:45, Johannes Weiner wrote:

> On Wed, Oct 11, 2023 at 11:25:27AM -0400, Johannes Weiner wrote:
>> On Tue, Oct 10, 2023 at 05:12:01PM -0400, Johannes Weiner wrote:
>>> On Mon, Oct 02, 2023 at 10:26:44PM -0400, Zi Yan wrote:
>>>> @@ -1614,10 +1652,43 @@ static int move_freepages(struct zone *zone,=
 unsigned long start_pfn,
>>>>
>>>>  		order =3D buddy_order(page);
>>>>  		move_to_free_list(page, zone, order, old_mt, new_mt);
>>>> +		/*
>>>> +		 * set page migratetype 1) only after we move all free pages in
>>>> +		 * one pageblock and 2) for all pageblocks within the page.
>>>> +		 *
>>>> +		 * for 1), since move_to_free_list() checks page migratetype with=

>>>> +		 * old_mt and changing one page migratetype affects all pages
>>>> +		 * within the same pageblock, if we are moving more than
>>>> +		 * one free pages in the same pageblock, setting migratetype
>>>> +		 * right after first move_to_free_list() triggers the warning
>>>> +		 * in the following move_to_free_list().
>>>> +		 *
>>>> +		 * for 2), when a free page order is greater than pageblock_order=
,
>>>> +		 * all pageblocks within the free page need to be changed after
>>>> +		 * move_to_free_list().
>>>
>>> I think this can be somewhat simplified.
>>>
>>> There are two assumptions we can make. Buddies always consist of 2^n
>>> pages. And buddies and pageblocks are naturally aligned. This means
>>> that if this pageblock has the start of a buddy that straddles into
>>> the next pageblock(s), it must be the first page in the block. That i=
n
>>> turn means we can move the handling before the loop.
>>
>> Eh, scratch that. Obviously, a sub-block buddy can straddle blocks :(
>
> I apologize for the back and forth, but I think I had it right the
> first time. Say we have order-0 frees at pfn 511 and 512. Those can't
> merge because their order-0 buddies are 510 and 513 respectively. The
> same keeps higher-order merges below block size within the pageblock.
> So again, due to the pow2 alignment, the only way for a buddy to
> straddle a pageblock boundary is if it's >pageblock_order.
>
> Please double check me on this, because I've stared at your patches
> and the allocator code long enough now to thoroughly confuse myself.
>
> My proposal for the follow-up changes still stands for now.

Sure. I admit that current alloc_contig_range() code is too complicated
and I am going to refactor it.

find_straddling_buddy() looks good to me. You will this change in
alloc_contig_range() to replace get_freepage_start_pfn():

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a86025f5e80a..e8ed25c94863 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6209,7 +6209,6 @@ int alloc_contig_range(unsigned long start, unsigne=
d long end,
                       unsigned migratetype, gfp_t gfp_mask)
 {
        unsigned long outer_start, outer_end;
-       int order;
        int ret =3D 0;

        struct compact_control cc =3D {
@@ -6283,21 +6282,13 @@ int alloc_contig_range(unsigned long start, unsig=
ned long end,
         * isolated thus they won't get removed from buddy.
         */

-       order =3D 0;
-       outer_start =3D get_freepage_start_pfn(start);
-
-       if (outer_start !=3D start) {
-               order =3D buddy_order(pfn_to_page(outer_start));
-
-               /*
-                * outer_start page could be small order buddy page and
-                * it doesn't include start page. Adjust outer_start
-                * in this case to report failed page properly
-                * on tracepoint in test_pages_isolated()
-                */
-               if (outer_start + (1UL << order) <=3D start)
-                       outer_start =3D start;
-       }
+       /*
+        * outer_start page could be small order buddy page and it doesn'=
t
+        * include start page. outer_start is set to start in
+        * find_straddling_buddy() to report failed page properly on trac=
epoint
+        * in test_pages_isolated()
+        */
+       outer_start =3D find_straddling_buddy(start);

        /* Make sure the range is really isolated. */
        if (test_pages_isolated(outer_start, end, 0)) {

Let me go through your move_freepages() in details and get back to you.

Thank you for the feedback!

--
Best Regards,
Yan, Zi

--=_MailMate_53CDA1A5-7300-42AE-9DA0-B2A9C4EE08AE_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUmxeUPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU0qsP/0kHPM0TjVikubTlgBdp/8CeBk0HfeOK4Rgh
p5XOQQlFLgyYS3LcvhmfTOIHzLZwuoR+CNuu2j7XpiNV0FnKx72d/5bngsg9sg7A
Bg2PqLONezHXjIYlG65o4xg5Bse+rMNDDTE6yWgqrnFifIZ1sGpiJB/95akYmpDp
ExsUWtAkZ/tDRrb8TUj130w1pxZaWgt0Cohjw/JhFYRxZM0OAitTqrb56hNGyD2w
k8NbamsVL7LJeO0pnNLpplYsFQk0502V0MvcytLgpL6FWfFy4ZAWR3KoE8Q2cLyn
NFh8svzL7QOnrsNF/DEIZHburbfid4pj89UOUxX5oV/rOtX6F5lp2FJfvnHvNdBI
zdzP39nxLDlL4OxB9K0blwS/wf752kQYHlHWGfDmdMykWrz0H+qtWoXFkpg1oxd0
ozvFUpRuzMyfGeEK/ph9tFnqnymPkt4Yr3Erl/VuJQ2BGhyoeONL+++g5EU4URZU
C8g2xrqfhquAR4104In60qZG8XciHnufmkeaZW4XnuhpqWo/2Rn7VTCYlqF0W8H2
FdGmzb8xladdK6omq1DrcT6H3lGjURu4IDOnE2iUMlmvbCfk3LsUgwSpovjt8Pxm
J3x7QwsVX73S4VervFabex/3XKcpbuBvMtfXKJCD/6wacxmLgW4tYEuNHJvnxlnb
0QAoOnCS
=9Nrb
-----END PGP SIGNATURE-----

--=_MailMate_53CDA1A5-7300-42AE-9DA0-B2A9C4EE08AE_=--
