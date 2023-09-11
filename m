Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1F979AFDC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379124AbjIKWlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbjIKU5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 16:57:10 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1F43AB0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 13:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaFbBD/a2bPgnE7hxBIKv6hYN5D4NBzi9jVm+gpc6HLhfqEB25L+8cUplBJztZf1aJtYB8QPfhEVIeqRpqtLIQiPQink7JB8B1y1N7RmfyCsPWRsRTmY+uccBcrNaGWKKN85oPsY40sw9n8Jfu+qq9S1lY0Y9U7MCgYINf9Qhu0zfYaLR8Yg3UicKw+XI+qrnihlvgWYRMbAYYvNUoEo9OlpQ0uTZK/tBvSgJ9XQ6NQ2GVXY867tlN+OPLmDczg1qBuT7162JJnrsYzqHKYklzL8+Szst5+R0TTYcGrpTNS0rpj+0lrtjD2aL12TB6T/0aXx5RD+mAzWpql/qIU+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nECUKcv777UyXo2G3KcOQfm8aBhz8/RLlsgt7vj0gg=;
 b=MGRBb7pGzwTsj0R5aJFBCtUPZF0wzQy7fq8RuN9qyKktW4JTHd01SZdESRF2yQtLWobWQbs/n1mZyN2bpcA2i5ghJ9AInoiPicfK7bSF9dZUGjmXSsc+UjtGH6rJEIOXbezEHl5SzPRkep02791fls/fSVJKZrmYg1gpYsCDnGqEOC8ICjQqf1Xef0w775D2MS/ILRZ4bFgpJCGsnUjY19enku45TidngVJCPG3hg1J8wbEILYuLxz4Ou3zaYCToMK9OwdI0CQxhvnbUurg7xd8O/0N+5qvpAeXL0fWtPzA2VHWw4TD+0hdjuZYtRhFpU9xOqxDTdGyoFr9LqWVP8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nECUKcv777UyXo2G3KcOQfm8aBhz8/RLlsgt7vj0gg=;
 b=YhfaElfc0lIFsxEa9pe9/SFoSO857lBXFYzlZmFQN32GGzoTsgQRJoCAJBbSeqyZ8rPLfaWYKF4VjpHQn0LFHLdqPS+yrA19KcfDR1I76FOue0i8EFA8ppDEmA0NCa+oTo0cTDeCQLKKj4/BW63o4Saz3weowiur+jkNm5Pbu1AMBlpGgMIGTL9L0dBvdY/dTfXXtW+CmU16U9TKW+2IzQ9YqrVgQaRqUUbSDQpvWLWpJ4sn2qKYD3Ze0woZnbP3zFX7kw7tsAK6lvBCgaVm7j8HMnPuAxAjFgeUQm2waXoPjS4aoRk3mz2rLZOQW69/v9XkcwlGSdcK/NpgmfI8sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.31; Mon, 11 Sep 2023 20:50:29 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6745.020; Mon, 11 Sep 2023
 20:50:29 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: page_alloc: move free pages when converting block
 during isolation
Date:   Mon, 11 Sep 2023 16:50:25 -0400
X-Mailer: MailMate (1.14r5978)
Message-ID: <1E134AC0-388E-4C24-AFE1-7B82124DB1C4@nvidia.com>
In-Reply-To: <20230911204751.GA134811@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
 <20230911195023.247694-4-hannes@cmpxchg.org>
 <23206152-6E36-453B-B118-6BBAA913441B@nvidia.com>
 <20230911204751.GA134811@cmpxchg.org>
Content-Type: multipart/signed;
 boundary="=_MailMate_DEC40EE0-4DC9-4E20-87D2-4B50903A008E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: YQXPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::35) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 76353000-cb1d-403b-e606-08dbb308bb6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0TSO7j2N9QB4ohQwzpBpIQL38dr210FcoHslXWOLLgy/tBrtuGl/LBa4uOmarr7BDYtfK8pSzQHSiw82PPM0V5YD3umz+yQzDyadTp8sja/fJLOp7Eca6bZp7PUOWuyQx92dpy9tcmNh9cOJ32ArmSojgvSSHInFaq8Zk28FfbRzfbNkt0OeoPI9Sst0CF2T76E/q1p1Dg3i0FYume1ZLthKvEGVb3Kj+gk49hOpsFtF9dnww/tuEESr+VFVlbl+kC7d6LV5oI4+fo5n1G7PRD1MRlnCzrf4wAq4m6vvJpzdIgBe/qS7sgPJcD37vdVAOrc3p9FwjC2WvMj6H170guq/SZkBsompFrMct0BJV5gkz6p9PDHvJ3GFQ9JorkTaBWn2hk55Jke6WFvS4HPABSgkavmTxIwabcN5Z9qGLxB9hTwoSGWbkW/kUoDDJ1rYE4j4L7zj7MH1obJ/HZdE3gN9oHMrePtN1GcyIC8eu8wZ6eR13XYck2qQxEUce6m+zWegbkAeb0HzR63s8+hTuFenjeB9+2gd6mZTLDqaOYKPSpYxcp3t2HgOxtar7eZapuPoJ6n5xjruJc72WdnYlmuZ8k6+2Lq5vL+SCWG7lZhPFsYVDNChwllEudcYlGhM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(53546011)(6512007)(478600001)(83380400001)(2616005)(2906002)(26005)(66476007)(6916009)(66946007)(66556008)(54906003)(235185007)(5660300002)(4326008)(8676002)(8936002)(316002)(36756003)(86362001)(33656002)(38100700002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0D/rFqiYPs13XkITQXwCkYZYQi2DWnXLcNWjelJFKrGalJMPxqz0jhk1T8KV?=
 =?us-ascii?Q?tnVxem3FFeU1fOGZ16Pn4GatOyvBcyuZ3f/5VEf1dU1LWDGiLsV2eTpi7qwW?=
 =?us-ascii?Q?DPxoMNGcn7fx6q1jwWmSjc8iNL8iZHf4MO/YBtTp8Bi49yXeZZp+7Z7hVFAF?=
 =?us-ascii?Q?Z0hLUkti5LS7USOKOIF9NLACqb+V+cxXU6pYMjfQaPgMo1ceNxsP3qePqNeF?=
 =?us-ascii?Q?krgRBj97DIR/I+94GcKcmXTLE9csPgvKOIFVM3u+X9U+aCAZu/VC4MtRhpX5?=
 =?us-ascii?Q?saxzyxt3CGylmwyjuWIWMQSrrC8bYFobd4Pvl5eEWDUnGaaN1D30Rfbk/pcV?=
 =?us-ascii?Q?79x+EeabflbGldwdTr/T6gz0aeFtUKJpOBxHrjQrAaoW17lyJkUEuYdkVRX6?=
 =?us-ascii?Q?OcpIgR+LILIBzVmr8GXIUeyl6XH9k/VZVesaT0+R+3ClKtr/GpbR3VHbxoE8?=
 =?us-ascii?Q?PQBtmER/pbIWeQZKKXkoKKLcfD/en+RkxiCxxO2C5mSAABwnPHabbtUa3MLN?=
 =?us-ascii?Q?uEK9hWSEeK1WJ71yNAQ6pzK8dWNzm4ovJtEdtfFy/x3Gh/1DeOZRaeojyU9x?=
 =?us-ascii?Q?sUnk9qD61eB+UgbNp5dh2mltonJf+pHM3T9itELfPbjLBODc+ymWxmHXTtat?=
 =?us-ascii?Q?TLeKUqNDIdGdWOpXcgzbzmZA1Ni/fOhNZA5ZOw9+t42xUvzvytONJzmIdu+U?=
 =?us-ascii?Q?4STiBBjKtDjFBZUmGKScphxPFB5noNKMfP/l69Grsy7wZrtLpJ13oNP95Q4d?=
 =?us-ascii?Q?adP8ZMd+5rgXrrgwvn1+hnSiaSXH1Yam5nFKWk0muwvy8zWi440Z0tHQ6gtG?=
 =?us-ascii?Q?S0d3GGz9iO0yXhd7XChCMhPW6pXxP7z5b24ChGZHo+UTWc0WJjGLIdiTtHCR?=
 =?us-ascii?Q?3bs4xMNk9wl/wb7NshHGIaNAdf/OS7aQBqKjIAm2K7hp8THwkZCTuvIjKxxU?=
 =?us-ascii?Q?zWsn7npREDV+zJXKyfJRaSBqZQK2gi9y2K+C+ikCH07tVTjspBsAa2XEJUCo?=
 =?us-ascii?Q?zwvmyCTTtAW5/Se6g8uYuru97Z3qggsF/X+f4j9/75jIvEAuTYFbeVb4kpp2?=
 =?us-ascii?Q?IYOlUrkIj0hB3tRcJhfTs/1K7mYyXlnSoFhaRoppAl4uh/K/wTzYfKnGUeq3?=
 =?us-ascii?Q?venM/aWbMTjTwZ5GFcafKUqHYDzqsAyu2uCb6K+0ld2Qr0/3JWQ2B7wdw3av?=
 =?us-ascii?Q?hI/R1ckEAEUnFQWypxa7nFLfSIp1Y75YwKkGaD3Foq19zIUnELYZYO25lrXn?=
 =?us-ascii?Q?IAKADCtb48LaMo1T4g0bzD6TIP3VOOzInXamJmgTVW+Yhi1V/DHP7eAFRVGb?=
 =?us-ascii?Q?i3ljBmNtM6YU/1qYwOUrngK8MTVC29IxYQBIm9e29s7d0z5PFzEuS7puhfI/?=
 =?us-ascii?Q?PJOkG+UcWcQxMj6Fz2ZVafA5x1NvF7FApQfN1jfbnXSI6BBrm5+gkyzzSGzD?=
 =?us-ascii?Q?bGedjHwiGf25n/NSLOsxORify3LQIZk1dnXNpyMXuiSjnFfnmLTGFuypeFB3?=
 =?us-ascii?Q?2ViPyz4kI4uPEBUE3stUO01JJ3Ib49MNb8tXGJ1tKU9Iro9XvRYWY4UQGDuQ?=
 =?us-ascii?Q?tW5QnDsuXcYWHr9tQKEjY87npsrkAsXPnnIOymMS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76353000-cb1d-403b-e606-08dbb308bb6f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 20:50:29.0344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4zrOOqiV+H3SdjtsVegeKFq88AJw9J2l2TFyhQQn1Neah5ZmU4D5b6J/13H9eos
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_DEC40EE0-4DC9-4E20-87D2-4B50903A008E_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 11 Sep 2023, at 16:47, Johannes Weiner wrote:

> On Mon, Sep 11, 2023 at 04:17:07PM -0400, Zi Yan wrote:
>> On 11 Sep 2023, at 15:41, Johannes Weiner wrote:
>>
>>> When claiming a block during compaction isolation, move any remaining=

>>> free pages to the correct freelists as well, instead of stranding the=
m
>>> on the wrong list. Otherwise, this encourages incompatible page mixin=
g
>>> down the line, and thus long-term fragmentation.
>>>
>>> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
>>> ---
>>>  mm/page_alloc.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>> index 3db405414174..f6f658c3d394 100644
>>> --- a/mm/page_alloc.c
>>> +++ b/mm/page_alloc.c
>>> @@ -2548,9 +2548,12 @@ int __isolate_free_page(struct page *page, uns=
igned int order)
>>>  			 * Only change normal pageblocks (i.e., they can merge
>>>  			 * with others)
>>>  			 */
>>> -			if (migratetype_is_mergeable(mt))
>>> +			if (migratetype_is_mergeable(mt)) {
>>>  				set_pageblock_migratetype(page,
>>>  							  MIGRATE_MOVABLE);
>>> +				move_freepages_block(zone, page,
>>> +						     MIGRATE_MOVABLE, NULL);
>>> +			}
>>>  		}
>>>  	}
>>>
>>> -- =

>>> 2.42.0
>>
>> Is this needed?
>
> Yes, the problem is if we e.g. isolate half a block, then we'll
> convert the type of the whole block but strand the half we're not
> isolating. This can be a couple of hundred pages on the wrong list.
>
>> And is this correct?
>>
>> __isolate_free_page() removes the free page from a free list, but the =
added
>> move_freepages_block() puts the page back to another free list, making=

>> __isolate_free_page() not do its work. OK. the for loop is going throu=
gh
>> the pages within the pageblock, so move_freepages_block() should be us=
ed
>> on the rest of the pages on the pageblock.
>>
>> So to make this correct, the easies change might be move
>> del_page_from_free_list(page, zone, order) below this code chunk.
>
> There is a del_page_from_freelist() just above this diff hunk. That
> takes the page off the list and clears its PageBuddy.
>
> move_freepages_block() will then move only the remainder of the block
> that's still on the freelist with a mismatched type (move_freepages()
> only moves buddies).

Ah, I missed __ClearPageBuddy() in del_page_from_free_list(). Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>


--
Best Regards,
Yan, Zi

--=_MailMate_DEC40EE0-4DC9-4E20-87D2-4B50903A008E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmT/fZIPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUzNoP/iv0jK2wQedBte4dYtXx/54P6wuo3UqgvAcO
MNxQVoEi6wlqQXqQ4p3hiPXEA83dtIoo9PyC8UpSeLhoa3q5pFBIWueRzfv4Grm3
Y0d0VFvxDNazBQb+SEPpIDDs5XcKDedA9QetHxFAu2GdclOz5RPPGDB3fkvIo0pR
Pbsl37CaCmbQoeIaE6qfvyZinRAr3UTNxS3HywqfHZEaa9wcvD87hIzS7tp7zcv3
AsnfblTPNd2tT/gUniLjAAOkXfahha/ov7xgGYEZ2+dryyyoI7O3otu80/CoXwDi
/9T4jk6liO4SoTvlFlELeY+g2bvXnUZueY4K7aw6XJ3zfoqd4bI5VPBE6pz8Jt58
NClxj10xyAUD8mYxGkZRVAuDnGzGyKtfU2omyDLWZAWvC6CfeNE4m9nsxVHOdR4x
4piB96wDFIz99TbThjQb9geTpGFa20aoWXvQ/2LQ0NXiOPkc7g6sBX5IcctGp1bY
sIr0m9JQjIpc6mDbv+ga1RONASavYKpWMUPLxYzCfQ8uDxuXoxHqHmA9oL4qier1
55mo0DLzEeUD2owQHYs3GNzK3+mgyrkON3AEpHTMq2WXW41z1xzJoXBUslQY+P7e
7RgtM1maamc6KmRz2fs3QwRv9tDi7xXXRHixpQQ2SFYW16CUC+RMeod5cz4rDrEt
X9rrFz1o
=YHNl
-----END PGP SIGNATURE-----

--=_MailMate_DEC40EE0-4DC9-4E20-87D2-4B50903A008E_=--
