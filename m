Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444127B5F1F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 04:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjJCCfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 22:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjJCCfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 22:35:18 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08834BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 19:35:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4PNXMhX/i6MyRb2AKiSqsvau3586SroC/ZOdJsKS5bTBufD2jVCffIRoWOh18kxg1cihdU5ZNf7QZDW8jO5fCT+yndKmTwY67CamLsxRD+fOcAila3ol2x6wx2swHza2zKzY4qOtuDvVjJnbgnIsIrnD1BbNo5kvq2gdEyKLo/SichrnNb20XUiOaymN+DwBDgJEIz6nJugObB64NlldvmmlEMmenuyKfSog0zZPzg0occnhWnIMo9wVSowWhdEAZb9AW9jBX/p65nEVqmFfGktPPD6Ow7zeERQyk6atzjwEzgaiPt4tA4QpG3cFyrzeGX38CUZT/DCmGmYPFK/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9KLRPZYVkmpK1RhseISmYEeL8ZC5/ardhzOLkac8ME=;
 b=oGlleoAf8v0aENA53A7DN0m/qhqB3rdX1A9eOfyKJMIwZhA8+ad2qqiREMt+Nj1tXvaCQ8cfn8rM7ipEKPBYNXCassxyG9ON11oG/DntIkLUCvisH3++LcVgrf54ob4V/JES8zOBua3mHVGh1jsq24sW313NEY+gsTPdQPPoq21kR6vYDtOSFUxEUuIhaMamVDQnJFdxQrYALqIYRwWz3JLnr3V2ewJ1WjMYLMGeRPnIL+U6Jl/aHlkCw5yM9hCAp4ONR1eHJvDZc21zOxYQ/2ziuF/clt/z1N86Cw9+SXU9FBjdQVSx8o3UH6aRCNRjbNoEiKZZdRyegy7IVVAtLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9KLRPZYVkmpK1RhseISmYEeL8ZC5/ardhzOLkac8ME=;
 b=BjdQHv4aqhQ3P9kq/tiw5TDDxy4rHL9D5ajyGWUGqknUKQjpYC3SJ2EvYzF67TN+eoA1iZ6bp/zTbgti0YNmq+vNaGWgcYJrS6iaumKi1iLkBLzwth7h6lVVpJsIae4YUG1k4u+j7Z+ruNBKJr9i3sWrtJXfZV5ksERoGJ4ci/nrJmEnxA63EzEsFnI7GpLcehyKvkTBmOJ7J8lsWb4RyDM7nv+FnN3jenman3V5ilzT8KmUPYOkTYnjaHAddgMsMkX+P1uAMn/8eCt4ClnSMjtdspeNJdPNpRhWnHv8lCRqIgDb+B3jIBlX/dQ5a/S50uFE0T5Jd38oSXnen3aCAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Tue, 3 Oct
 2023 02:35:12 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6838.016; Tue, 3 Oct 2023
 02:35:12 +0000
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
Date:   Mon, 02 Oct 2023 22:35:10 -0400
X-Mailer: MailMate (1.14r5987)
Message-ID: <6EA38E52-1E76-4A25-BC14-B5D5FC46298B@nvidia.com>
In-Reply-To: <ac73d772-c585-1d9e-c8ee-36c51b608906@redhat.com>
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
 <6DD1F426-A87D-47B7-B27F-043B399CBEDA@nvidia.com>
 <ac73d772-c585-1d9e-c8ee-36c51b608906@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_3C158B70-4045-41D7-88D6-665F331E9115_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAP220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::14) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 7785163d-f484-4b88-7af3-08dbc3b95e67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvCicecTINPPgEeyCwd/CVRgcYEz+OGOaLpsuGgz/gMfSUO1f/aEoaxhh6YwMlcEzU3pkMZxnhSTwTy2B1G6ziv6fFJYwExdSc2qBGKQ/AHlFNpseR7ywHzDNACPgj4WwhiiX1rVhzR5h/YBYEgymC3dOB3QitFB09CdLBXgS9+sgU9/holaSno/uigPJOGlX0NMhXEpsmnNGybwrE9+ogo2sfOxKG0xFUkDpqZPCwE2WtQdB3Uapq1LgT2Sbbf0BklRFSb68u3Tc/5jlChr+8gR8NWLQlsY+hLIJzOU4kTmXDQPi2yYCBp5GM2zd8nTw9zBkG4ZuAibpWOSpWvbGhjpnnDpsk+otSVA6YDpCV4st7/FWW00vJG76DWQxnT0DCcZBDa2gdKHdjYTZR/oSqB6efEOeUhaokZyHL66WY/NQvh50L5endEPNAMYvCjcqv5xkLf4xfJyjT4209ClLeGNTuCDBOfC+/mxfCSnsrHQZm7Ew9t5OmD5yGNecsjbA8k5pl4714LQ7+6gcCxInnQiWpdDoJVRajmVpunAHCTLTOccGhUtl0B+7sfZPnUw7X/CY+LIK86fehzG8eZHfp5Uu0us4auWtxjukf5efDGjqOdH4WQkc7xLe8i74w23
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38100700002)(26005)(83380400001)(8676002)(316002)(8936002)(41300700001)(66556008)(2616005)(66476007)(6916009)(66946007)(53546011)(4326008)(6512007)(6506007)(478600001)(54906003)(6486002)(5660300002)(2906002)(235185007)(86362001)(33656002)(36756003)(7416002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N1IE6VqR2S8lOus0nbDg+EgN8l2Cyro18QdxY/Nw97lPTS4l9Mg1jVbQpL8F?=
 =?us-ascii?Q?PAR92PO+dz1USnyEmUhQwSX7eQ1eLNUDkxo2xJN8uGnaC3gVlKYQMnbNTmxf?=
 =?us-ascii?Q?XLtkFpK67z9zQq2cD8q5zjeftXUCK2gUhjnM6/SxZng7Mz6dT6bM6f9hgfdf?=
 =?us-ascii?Q?vNIebdvJgieDsnnUnY3QJ+87F6VzQ7GSbJu4HgeInHEZzd4omCYPUsSSCAPm?=
 =?us-ascii?Q?gx3le339yOIBTReZKEhzJH+WDt3IR7JxQAhxXHmMnBIUsgfWwSUB4mhCLt85?=
 =?us-ascii?Q?Y17ZlFkNNnwdLAEJjd2253YtuJZTD5MvN/zefkA/BtXT6w0FDlANGMJUht2s?=
 =?us-ascii?Q?7fcRXYhzYxygtKsG+WAudrx6N39ZH36OcLP68BkhBOChS1ALfj4bbiry8W3X?=
 =?us-ascii?Q?uE7m9RBm7JvaWcCSbpW++QSREQQRoDfXvow0kx4bviYeNrBGY73eMj4TX/W/?=
 =?us-ascii?Q?v2KbCLJpqN+dvs+0AnKn7KBzs5Zx9ZBLH2CUgQnduSILBhe5l5aK1L9ZutpI?=
 =?us-ascii?Q?7ExXvZfiW9XvDbothTSKUS/u171/PwGJXEJHvjILI1MCo1N7PeRVrCOCmBTA?=
 =?us-ascii?Q?Fc73lOcsMaQgj77XiERRZ0QP1t8/lKWj0hZOv/I+svexwlliwYJ1qaUBbVb3?=
 =?us-ascii?Q?xfAYE2z/bSa/TONRIvatC8xiIPeH0TO1GQHloInrAvK8cgVfdL/GvKjlnrFv?=
 =?us-ascii?Q?C9+ydPCjHnwjhrj1d4M+p4RPXLoI/tUOW+CzNbcd+EzShFS5kZKQ0ZdswOeo?=
 =?us-ascii?Q?w4QkFFifYgGCn6D2mhBRndGTDMAivtgE8EOUa0r7NB5cG6XlzZo9swX/NYoK?=
 =?us-ascii?Q?km15HSbUxrVBW2/EcYFmeut62KBGQWfwqh8qrx9BcPAzS6OFwoBdd+UYayyo?=
 =?us-ascii?Q?XLO4OlYtcGXiif/8hJtRxT1LhJYDCRcBiaRo7/8fr8UUaihpnIMzsVlU++gc?=
 =?us-ascii?Q?yAgkcbBjNNP+tO7kISHSO4XzdHZ0ggRPlehCRovlJOTssGdX9joik9KcnXBP?=
 =?us-ascii?Q?U3P2NlkPqkDQf8OC0dYtYDRF8+KybmfK2puZDYykCWMOzczaLl9Wt2r9NDCJ?=
 =?us-ascii?Q?Bp28aq5LlbxHgWxmuHGTKWnCtJ1fRaNtBh5OxmQVQhYvyQGEOJ5vtdXVl7gW?=
 =?us-ascii?Q?WXFctTg+2/9CKKI3KvchGigu1z61vABialHA5vHRfQj2XAXHuT5SLOchbLX3?=
 =?us-ascii?Q?zSeZfHgUm4afx7Y5887sW5D2k4Ep2iGiQCLY220TYElrDAa6gwAeCgjWXnRc?=
 =?us-ascii?Q?tKtaOumi06zOcfq77FAJF5ChY0P3n2bcvgC8rCFD7BamAA2QEJTyG0T1T3jr?=
 =?us-ascii?Q?hal2j6unVUXbkHJGAk7jpjHvhu2eDB8d9yhyRaH1G2dm8UKInqpszmKSAgkB?=
 =?us-ascii?Q?sC8f6w0uzzvIVRv3O+0Xn7UYN2z/DK/mTm1FCPATb6ooHnv7qFU6CjshzQrZ?=
 =?us-ascii?Q?hO3UVDywmFaZDrABhdhkvMYLIMgmPm+SKnVA5JAXRH8+YNuetgXVqQh3A/cx?=
 =?us-ascii?Q?S81ueZbk8VFr0KvzeRmFm95w3Mvf/dwj6Hq/n7rxM5RE6sjLjF6e/VJm6Nmc?=
 =?us-ascii?Q?tJRH4zGIBBQbytd0TDWhU09RpkxySx0V9Bh5kv62?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7785163d-f484-4b88-7af3-08dbc3b95e67
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 02:35:12.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nq3lqbvs2EWZN0yUnbkxOiXIYv+VGJUBbiES8Jxd2TApA17JaNkmQIKFAGHQXR0M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_3C158B70-4045-41D7-88D6-665F331E9115_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 2 Oct 2023, at 7:43, David Hildenbrand wrote:

>>>> I can do it after I fix this. That change might or might not help on=
ly if we make
>>>> some redesign on how migratetype is managed. If MIGRATE_ISOLATE does=
 not
>>>> overwrite existing migratetype, the code might not need to split a p=
age and move
>>>> it to MIGRATE_ISOLATE freelist?
>>>
>>> Did someone test how memory offlining plays along with that? (I can t=
ry myself
>>> within the next 1-2 weeks)
>>>
>>> There [mm/memory_hotplug.c:offline_pages] we always cover full MAX_OR=
DER ranges,
>>> though.
>>>
>>> ret =3D start_isolate_page_range(start_pfn, end_pfn,
>>> 			       MIGRATE_MOVABLE,
>>> 			       MEMORY_OFFLINE | REPORT_FAILURE,
>>> 			       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
>>
>> Since a full MAX_ORDER range is passed, no free page split will happen=
=2E
>
> Okay, thanks for verifying that it should not be affected!
>
>>
>>>
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
>>>
>>> One idea was to always isolate larger chunks, and handle movability c=
hecks/split/etc
>>> at a later stage. Once isolation would be decoupled from the actual/o=
riginal migratetype,
>>> the could have been easier to handle (especially some corner cases I =
had in mind back then).
>>
>> I think it is a good idea. When I coded alloc_contig_range() up, I tri=
ed to
>> accommodate existing set_migratetype_isolate(), which calls has_unmova=
ble_pages().
>> If these two are decoupled, set_migrateype_isolate() can work on MAX_O=
RDER-aligned
>> ranges and has_unmovable_pages() can still work on pageblock-aligned r=
anges.
>> Let me give this a try.
>>
>
> But again, just some thought I had back then, maybe it doesn't help for=
 anything; I found more time to look into the whole thing in more detail.=


Sure. The devil is in the details, but I will only know the details and w=
hat works
after I code it up. :)

>>>
>>>> If MIGRATE_ISOLATE is a separate flag and we are OK with leaving iso=
lated pages
>>>> in their original migratetype and check migratetype before allocatin=
g a page,
>>>> that might help. But that might add extra work (e.g., splitting a pa=
rtially
>>>> isolated free page before allocation) in the really hot code path, w=
hich is not
>>>> desirable.
>>>
>>> With MIGRATE_ISOLATE being a separate flag, one idea was to have not =
a single
>>> separate isolate list, but one per "proper migratetype". But again, j=
ust some random
>>> thoughts I had back then, I never had sufficient time to think it all=
 through.
>>
>> Got it. I will think about it.
>>
>> One question on separate MIGRATE_ISOLATE:
>>
>> the implementation I have in mind is that MIGRATE_ISOLATE will need a =
dedicated flag
>> bit instead of being one of migratetype. But now there are 5 migratety=
pes +
>
> Exactly what I was concerned about back then ...
>
>> MIGRATE_ISOLATE and PB_migratetype_bits is 3, so an extra migratetype_=
bit is needed.
>> But current migratetype implementation is a word-based operation, requ=
iring
>> NR_PAGEBLOCK_BITS to be divisor of BITS_PER_LONG. This means NR_PAGEBL=
OCK_BITS
>> needs to be increased from 4 to 8 to meet the requirement, wasting a l=
ot of space.
>
> ... until I did the math. Let's assume a pageblock is 2 MiB.
>
> 4/(2* 1024 * 1024 * 8) =3D 0,00002384185791016 %
>
> 8/(2* 1024 * 1024 * 8) -> 1 / (2* 1024 * 1024) =3D 0,00004768371582031 =
%
>
> For a 1 TiB machine that means 256 KiB vs. 512 KiB
>
> I concluded that "wasting a lot of space" is not really the right word =
to describe that :)
>
> Just to put it into perspective, the memmap (64/4096) for a 1 TiB machi=
ne is ... 16 GiB.

You are right. I should have done the math. The absolute increase is not =
much.

>> An alternative is to have a separate array for MIGRATE_ISOLATE, which =
requires
>> additional changes. Let me know if you have a better idea. Thanks.
>
> It would probably be cleanest to just use one byte per pageblock. That =
would cleanup the whole machinery eventually as well.

Let me give this a try and see if it cleans things up.


--
Best Regards,
Yan, Zi

--=_MailMate_3C158B70-4045-41D7-88D6-665F331E9115_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUbfd4PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUl8AQAIxHpVTpydIUe7Fhd8lqkWrXy1aH+DV94I1X
0G0FfTC1Yp5Sfjrvcz1xI6VSb0WI6cCQIrv7N9sAwK10phtfQevs7zYPY3ITu4h0
TzEDZnMx+qzIRAaa1xNoO1/eTfSjpEpnNHDoEPk8HONIijw2bqkGowOsOdL+/9vr
npkAWEeXA7r+glYGYw44knf00CYcS96o6graznROBGOpCNzEQ37RFdXPOvuenX8o
G3v6nfnGy5w789LiAi6V7NLxyqK3I83KF27CUQPQHyuB/u2c823s+UTthlXQuntj
Hdg7qGbybUBcHADxiM+Mw8fpkieV+W3is4G2djYEWoe0Nuucq21A/5c8Tkpas91k
/1T9racoyu5VCWWMFhE4HJAVjAqSwQ6JOlUJJmqfnYRnnSowr0pMr2qJqkowKbzg
7vO8znDFo2ZIbdJBXv0u73SUlKMM3ybFXXVTM9DP7BqSoYcHjkXw0ZQJgIX+AXFV
EgXvXeiNdlpx40B0bqEaui94fK/5fCKiGabZFKNQ/tkckjwyCqWd9HsrBrMu/6I5
CJag3FkZc5hmc/fHnaaLB5OPYf41iLbXB6U5NZmFe8KRcJEXB6YMMwAAtisFoAeI
Fm2qApwzGKfWal0XQMxG+TBZdw7dPUTBBb40mKN7Qdy99PcvAsgwL/jZ1hzAk4Td
XDOKnT5O
=3A51
-----END PGP SIGNATURE-----

--=_MailMate_3C158B70-4045-41D7-88D6-665F331E9115_=--
