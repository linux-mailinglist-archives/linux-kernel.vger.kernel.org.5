Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699E07BE57A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376859AbjJIPw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377729AbjJIPwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:52:19 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146DA18C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:52:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0x1n0HgUi/I5CAEBdeNapBD4+Qv3ByHSQFtT5SDX0sWXTWusnaOck7SurVzv+hYSlAhzBJHiaHs3o+FBZWn4aNAHFN24DXjOJDdxrquLkyeav8yL9YauHusn5nHroLyYC90ZtcydSc/DoZsqn8Awksqm8jHJCThtiUzgumdeK7xFM/xARBIjeBF7PbnhlzJ/uCqlCRyLLI3fnqVSsH6f4GFfU+khkICan46/BIsqsNSYBpjCE0ycefmkl+XqElauWcrhQOH+axqAUM7y6/f/hUFvrZyDTG03t1xIReiNKtRdwfQTOR0JgAn6uaG6XcEl2vgQKrl7cyn9Pf+amAxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0YU45x6w2xyYMTKOuUFaY4XsHmUYFoLuWjyYoi0J/o=;
 b=NYvIyHociBn+y2zsSSp8yH318sb9xsfeowsdZDaouk9lUxZYyAeiBYiv/DZkkm0ZoW25gIVLhrxkTGxBjmR5p65AiqqlF7YsU1tuOHx27CEv4bt5vq4ABhnb/+WktbzjZPETAtn6yra0MIkGFtlaV9g6/wbIrm3x8o82dRi/M8FSGj2Pyn7dBFkmcur2zMSJ/hvvY7lUZOIWmptZ5iR4GfOJesux8eCKE2a6WCKhGoRGIUGGZyFbjqoj8gXxfc3W6KhGbG81EKGIcZ4l/V2ejVdhd5VFCLB10iZbc5kpLSq4K5RRzoIfszwKOQx0DjFdR/mcBVK2QME/P4W8t6Kl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0YU45x6w2xyYMTKOuUFaY4XsHmUYFoLuWjyYoi0J/o=;
 b=JHAVnp4k94RrGrtrJ9J+Z78kGRPZQ+C/XsL9zGmFzT+d/5eHhG8g03w5y6nqUWQr68p5fHoWyV0pwTOK24pk5HmrAdCFebdL3cMZCVz1dYDqYQlKSdJRg1yIs4gABrYWGfOCNK/VBZQ3K23bO3HEUMooVMNXmbT1627OjDgcnM7/UPS9z0jz/y4FcyvGk4wE4NNVsWzpq6+OIFBw+klooOHvVbXdux5lWKq7SS0hdtARATuNgtp0VANVMPG48k/Lz6pmPKOQtnZ8FcIVW2xS1j+V41Nbwa3DFJEW+Tqmjz4eeUAc+Jj8Xx0nYEEF6h8pT6EDezy+UIhVhAowhcMVVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM4PR12MB6206.namprd12.prod.outlook.com (2603:10b6:8:a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.36; Mon, 9 Oct 2023 15:52:09 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 15:52:08 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "\"Yin, Fengwei\"" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 0/4] Enable >0 order folio memory compaction
Date:   Mon, 09 Oct 2023 11:52:05 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <96622D29-4CC6-4281-96B1-319E5F317EDD@nvidia.com>
In-Reply-To: <13347394-fc63-44b2-9fa0-455f56d9b19d@arm.com>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <5caf5aee-9142-46f6-9a04-5b6e36880b21@arm.com>
 <3430F048-0B75-4D2F-A097-753E8B1866B2@nvidia.com>
 <13347394-fc63-44b2-9fa0-455f56d9b19d@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_5593C552-5640-4E79-8774-EA5DE6D413DB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL0PR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:207:3d::25) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM4PR12MB6206:EE_
X-MS-Office365-Filtering-Correlation-Id: 0981b0d4-c03b-466f-c784-08dbc8dfb1b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: howYyn+H/U03cVibfWhi8sNiqnYRcWYH4laC6FEqTRZDKystRTbbyr5p1n/h1aoxNWfGzq68s9A9t73jVuUpZVlAPT9A6kaXzufafWcKupezX8FUMio1UpalxaHBpxNJOBujP7tzzPYWVA73WKI6OMOk+zsAnz8CGBZ7NFwXOEc2qKPeEFEsd79xVBsUKDLGotQMZwxB4hHnuA0lF6epVh5/2lgOOdINuYefts256KYcGXnmjb0r7DgUzd/A/k1gmvLAo9pbS4oedGYbj+tLYC111mXLipsc8/iKwD7xZEKXTbShKPZGiVx3MGm//QSr45Xb/LouhSvl1BKDw0OMmn/SaLtShpT+159IgqZrhlCrugx2n5sHYdE8YiJijtpMxl9w2by+QEBZKbMx0D1z8a12eFHRgdp8+Ymu0M+KYoVMF1HazaVHrEy1njMlOQkdLjvvS8ilwy24SbN3VB2hdxb3+/XgeOsNp6E820vHRwShwCMYaT2+6oiMFiwa3lcT+I6c1ZHT47wV/QhMaEbrE0b9Yu9lOvWdWSxACBSYhsuTsXwUMz7Uq4AKR7vYs037Ghw4OwrqYhi51HTM126k5BuZ/Ns4iGuFuylxNw/i/c/fDViTR4lwMBKpLTEg6KZA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(235185007)(83380400001)(2616005)(107886003)(26005)(66556008)(66476007)(316002)(54906003)(66946007)(6666004)(6916009)(8676002)(7416002)(6506007)(4326008)(5660300002)(53546011)(8936002)(6512007)(478600001)(41300700001)(6486002)(33656002)(36756003)(38100700002)(86362001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NYcId5HsdCnB8smFfeebnwiK5ruMfBIoUwS9nf/swyCVy/Kr7WL44Lbs2bAl?=
 =?us-ascii?Q?Gb8uLZF5DG15maKVfZX8JODmMpwkGu8tgyWNF3RdOcviC5+9xGk6l2Me+3PK?=
 =?us-ascii?Q?pRG8hVSO46NR/6SyVxFAGiL+SgDn/QD25LelH/L3H1shHEny24M+Yb9A7sXg?=
 =?us-ascii?Q?ayWMCbGhN03zjVZzHxzW7IVYvFNlQG5URNKuiyhEfTwnGZn2MVY3+TaThuLB?=
 =?us-ascii?Q?xxHUDA9CSn/NE04wyiFXg/syZCLpLT31KhGO0vx/0nPeH6/i5FeOJBITjgSC?=
 =?us-ascii?Q?6lygXsrF/16R/KhdqvWl7wa2zBWE7FZa8ql/1uni/lr7+MkqHzYSl/QS+X5k?=
 =?us-ascii?Q?pLPSMfrFNpiruvq2ZwcNpQ/HyOLHIkj22Ol4OWcfHIg3WAnBpIy8SaAan9T+?=
 =?us-ascii?Q?v6PxYrNPwE1WD4Gk4oz15+SLRv6a5xj0EDQmD7AFKg6GkfSgiUYa943a0uKm?=
 =?us-ascii?Q?aKfeWYvvN4ySVB4Oslh0mhQOVldoxIrpGHw1AP64n4IVeVPbcrRXeQOgneCX?=
 =?us-ascii?Q?3flnmU/a0yr2EwwH5QLYH63liOyJWqnZT0jmmuRK6C1lVnzoDwJpu8uaREyk?=
 =?us-ascii?Q?0I6Z8dAbIPi84Ur0vDInUkTc8Y+cCp8RPFrpbRzD6NJogeyqBMsGMqPy84C2?=
 =?us-ascii?Q?KoS3Bx2RTy+YSthQE5C4rHzPkLJYi2OAWt1PJLSouDVLQV4xNDxIK28Mc8aa?=
 =?us-ascii?Q?pcMQDUMqggLmpKnkCu0HEqrQNZRbAa1rj1iWMDYPT/yXqng1vQXlqhwuJvKg?=
 =?us-ascii?Q?dSM9/NFskZ/LIy/MYz7EJ4cBucNH8wxWz8xkilmqGdw6k/5t3ZO7UzSA1p4x?=
 =?us-ascii?Q?2bHPP1KoBlkl/v1dfaw62GoMgUhttP2bRDfJkuLloqZr+y5o5ZKEobUBzC6J?=
 =?us-ascii?Q?AHXBcR8MiD9y+bXsD5Cal72h5mkxPXjyRS4r4pl24C+pkx0rtRCNEpN61VTg?=
 =?us-ascii?Q?dZ3mIRRlVhaHS4zTn3GKYosjWd9LQ1Tsl38IXpqBcBfZZ0RhDDJBIGmicAIw?=
 =?us-ascii?Q?bdcRXtwuYDqKh33cbE2uVQVXJklo9B1FCFxyL1STUaOdDn+3SpQbcQihde1V?=
 =?us-ascii?Q?yE9/1RWsX5X4gppJB+518xc7nLEgrvpP7+tQiq7CFzVy8qvl+iHGF7YO1jx4?=
 =?us-ascii?Q?V4Vxc9VZJmrd2dZCCxDW/89cp8ifDFpkWVRxfZmbiqY/yxt1bAeBoqISPxDe?=
 =?us-ascii?Q?UQ7RkS0iF5lf/7gHvVIM7KbYVqUkNSL3MXQKbJdii1DTQLxDAix3bQZ4CrBC?=
 =?us-ascii?Q?2/1z/66YY7chrGDeA2F8iutx5UOygSW6v7O8/r5HWgMqd5DDVMJetS2skVcX?=
 =?us-ascii?Q?zYbj2mF784uwttUZsMtFfe8XFYuQHVVhSjmcu47gLOhovetb+BgcOUR0mnL7?=
 =?us-ascii?Q?trCsgVOdyMtesag7M3sIiolXW72av6pCYmjOEFalHF9qFBDbwe+XWdsJLNgh?=
 =?us-ascii?Q?D/Wd4VivIe4MhwlS0Bj5/7+onHnHLIRwU1F3LkM0rsEJfZKFk26GZ7fyX6rP?=
 =?us-ascii?Q?JsWuEEgNdYM+vatgHsiix/05fn8zCxDU5JqlJuGH+iEyrixe85iOrUAOawXT?=
 =?us-ascii?Q?bQo6hCfsiZwyhLtHSX4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0981b0d4-c03b-466f-c784-08dbc8dfb1b5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:52:08.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJ2aA6EX19qQBd7HvUvPF0YDBUVvAJJv3Oi/xI6+2iGg3+JW7ITfz7GFJHDQj+Rs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6206
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_5593C552-5640-4E79-8774-EA5DE6D413DB_=
Content-Type: text/plain

(resent as plain text)
On 9 Oct 2023, at 10:10, Ryan Roberts wrote:

> On 09/10/2023 14:24, Zi Yan wrote:
>> On 2 Oct 2023, at 8:32, Ryan Roberts wrote:
>>
>>> Hi Zi,
>>>
>>> On 12/09/2023 17:28, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> Hi all,
>>>>
>>>> This patchset enables >0 order folio memory compaction, which is one of
>>>> the prerequisitions for large folio support[1]. It is on top of
>>>> mm-everything-2023-09-11-22-56.
>>>
>>> I've taken a quick look at these and realize I'm not well equipped to provide
>>> much in the way of meaningful review comments; All I can say is thanks for
>>> putting this together, and yes, I think it will become even more important for
>>> my work on anonymous large folios.
>>>
>>>
>>>>
>>>> Overview
>>>> ===
>>>>
>>>> To support >0 order folio compaction, the patchset changes how free pages used
>>>> for migration are kept during compaction. Free pages used to be split into
>>>> order-0 pages that are post allocation processed (i.e., PageBuddy flag cleared,
>>>> page order stored in page->private is zeroed, and page reference is set to 1).
>>>> Now all free pages are kept in a MAX_ORDER+1 array of page lists based
>>>> on their order without post allocation process. When migrate_pages() asks for
>>>> a new page, one of the free pages, based on the requested page order, is
>>>> then processed and given out.
>>>>
>>>>
>>>> Optimizations
>>>> ===
>>>>
>>>> 1. Free page split is added to increase migration success rate in case
>>>> a source page does not have a matched free page in the free page lists.
>>>> Free page merge is possible but not implemented, since existing
>>>> PFN-based buddy page merge algorithm requires the identification of
>>>> buddy pages, but free pages kept for memory compaction cannot have
>>>> PageBuddy set to avoid confusing other PFN scanners.
>>>>
>>>> 2. Sort source pages in ascending order before migration is added to
>>>> reduce free page split. Otherwise, high order free pages might be
>>>> prematurely split, causing undesired high order folio migration failures.
>>>
>>> Not knowing much about how compaction actually works, naively I would imagine
>>> that if you are just trying to free up a known amount of contiguous physical
>>> space, then working through the pages in PFN order is more likely to yield the
>>> result quicker? Unless all of the pages in the set must be successfully migrated
>>> in order to free up the required amount of space...
>>
>> During compaction, pages are not freed, since that is the job of page reclaim.
>
> Sorry yes - my fault for using sloppy language. When I said "free up a known
> amount of contiguous physical space", I really meant "move pages in order to
> recover an amount of contiguous physical space". But I still think the rest of
> what I said applies; wouldn't you be more likely to reach your goal quicker if
> you sort by PFN?

Not always. If the in-use folios on the left are order-2, order-2, order-4
(all contiguous in one pageblock) and free pages on the right are order-4 (pageblock N),
order-2, order-2 (pageblock N-1) and it is not a single order-8, since there are
in-use folios in the middle), going in PFN order will not get you an order-8 free
page, since first order-4 free page will be split into two order-2 for the first
two order-2 in-use folios. But if you migrate in the the descending order of
in-use page orders, you can get an order-8 free page at the end.

The patchset minimizes free page splits to avoid the situation described above,
since once a high order free page is split, the opportunity of migrating a high order
in-use folio into it is gone and hardly recoverable.


>> The goal of compaction is to get a high order free page without freeing existing
>> pages to avoid potential high cost IO operations. If compaction does not work,
>> page reclaim would free pages to get us there (and potentially another follow-up
>> compaction). So either pages are migrated or stay where they are during compaction.
>>
>> BTW compaction works by scanning in use pages from lower PFN to higher PFN,
>> and free pages from higher PFN to lower PFN until two scanners meet in the middle.
>>
>> --
>> Best Regards,
>> Yan, Zi


Best Regards,
Yan, Zi

--=_MailMate_5593C552-5640-4E79-8774-EA5DE6D413DB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmUkIaUPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKokcP/iC9ZEnr/GDwRev/LUGsZPX/niZ6iQoNTf4x
QcQb1BgZ5G1t7yltPdAcV1HwjTT+FuibjJP6EgJJHTcouFepKdq/RhiIaJoZLA3I
SX1x2XobFDnrqBk3miKgA+huqzdxCUcfGGiCBo7KP78K5C47pTC8NK8P5uEsKd9N
M5kV5GbbtjtYaR8P1HOHki1i8Sm9oRsKCAkIXIRq8QwOfkuGFngspGVUeqOBYC6A
RFrKZVcIPMXb7wmVruRWJksx/xm+UyM6MlsY6xOteFp9litWtwsy5NwIu/moHdL1
an6OAWjBtXtAmYK08VBiwazvT9P/K3Mtqk7n5m9fPAXI7ecqQ3a7GUDTs0UEVfvy
piY3Nyx0A5wEBRTYTqvL47ZXbmgTRbIw3Zdmk1NYoB+06JIiKg9zVIE5FnqwB2t4
NuCcAHsj8z98QQJJH5FViFyMDKCcBFH/VGUm5D+PFPpKCTihn6gO1kIxoDRuRWS5
aALVgS3FJdPL6Ks1X02UTROzct8nxd1R5cUK1qTuo4kQevwnPk81zTW1Ct0M/q8P
JT7fyUsVaaIjl96pM6xAzNJT6tQ63jbAVWWx6XD0U/6xpdH94YGd+2eO2zKJf/tz
ec6g03T2jofF9r/q1M8a3abXpaVz/znrTWxDuxKyFD6GqTLRBuzJVIbl8xDuQJxm
iVYJGNfu
=wmnM
-----END PGP SIGNATURE-----

--=_MailMate_5593C552-5640-4E79-8774-EA5DE6D413DB_=--
