Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E1E7BE0C6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377411AbjJINnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377403AbjJINnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:43:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF4F91
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3sV/+fRwN5C8BuIIIwUKcA/a8v4z0H2ksNimzWO7BcJQc1SH8uhMVQ/dYplCrJ3jqCCJwTUknHd+a1SMT98ygpl3Hilcq9FkCLHkht61q1X3hmkxCuWgDLy+aMR2Nmwy0SwUZvD13Fe/Xlh+6W8d40/empcqVABMwA+lbi5qXRamU2VKDdoO7Ge82cnSq/SlomJtB5nYhk/8ooVZPJgb7rInmQM9rCb+xPS9ARLTI5mC6YD1rIi6vgWFdAic/JQjqbQrxfazt536vbPFgUVIuPpFnvkNHqPyY7+FqkMDIcajo37gVy2V8shtymC+ENIMMeRI8acNSJGwnkSO/l9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jb8dbOgMzELxJivu109W123rIL1tWsdZV+1jhYDVaR8=;
 b=hSo/kY/CNsE5kac+rrR2upkYUtan2Z6aqfhn3hsNqDKCXGN6MD/6WbihdcxUwMVhExQ9QNg0Dad0xltGU5/Raelh9a2wV+FBQeEPFdaDcqBExTOUe8Dr5VeXxZ8Kb0H3MgEScpLjd0rOKNsmDrL/CSZGI5Lnf3iDGdLeueef3u7Rmp+VLqd3iBC3SjSBW4twq1d3+vHQ6/TY7zjt5pSsmaEYbk87PE8Yc2O9r6RDIoW1rsgbvXdbj8LSDBnl/08uucw0RoNtCUB/eqz2C+J+an+l1sh5tI0iplBj06F/yJyoLhD9XEMZ7snZpIJIQC4r0cswHykH0+wVJ/k5sBZeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jb8dbOgMzELxJivu109W123rIL1tWsdZV+1jhYDVaR8=;
 b=GU7wuwNWBhCNuq35RGFlZy83abqCv1yNhsKLylJfsmCcrq4cmBu4NELOtNNRrSe60fCPLO9MoXXjVrYDZXpOe12hnw210GVOoYj8hJ8snrkxYXc1H0aQmRvsDYvO9t2MTn+cbZz9YzlFkC0Z3Ugz63BsCht+iaUN/Qwi5KL1nRDcs7t5cXQCCCxrqvCPuuDiMn4Zase4ITFTwGX08FcWEOWetYxqTjcKG7pu2Q+iRUMGNqRgo5Axd7WSiOkWvdcUYow/eeA9BGYzdkHzFL5H4P53uA4JrkF4x4PkjlnQ9J1sRGcmWfzaT64qgwIulGXpKdQ8JBDkNgo5F/D6v0OseA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH8PR12MB7302.namprd12.prod.outlook.com (2603:10b6:510:221::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Mon, 9 Oct
 2023 13:43:41 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 13:43:41 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     "\"Huang, Ying\"" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ryan Roberts <ryan.roberts@arm.com>,
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
Date:   Mon, 09 Oct 2023 09:43:38 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <14089E95-251E-43A4-AF32-C9773723C810@nvidia.com>
In-Reply-To: <87a5ssjmld.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <87a5ssjmld.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_44785DF2-B4E2-4DDD-90D3-0DBA62E328B3_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:208:239::33) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|PH8PR12MB7302:EE_
X-MS-Office365-Filtering-Correlation-Id: 434199f7-2415-40d4-47d0-08dbc8cdbf82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNSWoxzamO938ijWeNyq8JciFF+BNWTzmnorDO1hE0RFdMKvjy9/9E1A0tjPeK6EJ4QKQAXRoGeSO/uULv/9fgHZECTpgRIVSP6W94OiN4LTHhI6o2cUJ+RRy0QPPymrHQqHLjkFTlUtmXAloda09/b8oEvkham6TjYEANt0KC3ESrEFM7Sm/td8ouHngLctbURClgrC07azcxJXqam12S9wGQFi7J3E40FD6F/MmppiIADUfeoSFJC8bHPCOaCePm/vkKdTLWvFeyMNdeRlXRe1vbBl+j+c7xxyR+oXxuhC7DN56Hyud1qWeyfAGtJVezYu8Y+1J7jKQ8OteOIgKiQFkx11aHdh4zlaRHfIlpmxuDfn9LpDHwbmyHtqE0PsqE8s+7zLp1MIxRNlYfuWLkPulRbBPZt5alporOobqcq8z1GWELkPWVgOBqAmRfg9fcFI9XRvPpiiEN6xQ49pM9OxOHnbzDj7gePgjSUj85Xlle053Bk0hGn1izAMQ/pS0pkwVBd0jmJpxCSyGjcoDyY/kp966ZZ1x2ez+ZaXloD33gqlvfMGcLIdqlXSKQtOtBEuPHkagkNA3ftXM4a5lUUGIakA/GTJIl8oKnVHFgVANXwdbH6lbw6T+6DRVqh1J8yVYi6STiCM1nNQIVEktu0xsmDu48vmfEqtd37RiVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6666004)(36756003)(2906002)(33656002)(2616005)(107886003)(7416002)(53546011)(235185007)(83380400001)(38100700002)(26005)(6486002)(6506007)(86362001)(6512007)(54906003)(8936002)(66476007)(4326008)(41300700001)(66946007)(316002)(6916009)(966005)(8676002)(5660300002)(66556008)(478600001)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/GLM7KLTTkChDiG7AZ5MJR35i6eD/Ea+bDq0wdH04C7EIgykLu0NmSBNLza/?=
 =?us-ascii?Q?KbhJmcUVSM1mv7NF4IR0KylZV4SLFZRhAKlNB9ww41am9Pvycj62MFjEWyBd?=
 =?us-ascii?Q?Kg8SFE3mJZaWvtz0tnMDC/1bZWF0bRZ55YbqIstrh0yPew/RKeBePyqYGq/q?=
 =?us-ascii?Q?QuyYwCBYcjOJh2suQ1ydqLcPBbHW+hZwL5SXYKFmezFWJF8D28vBRV01Exvb?=
 =?us-ascii?Q?uC48ypbCVaOYI4PhwBaxWqXOx3oMgMjIWnK3UQNE6ldKWoEe5KaaRf3QP4BN?=
 =?us-ascii?Q?j0JjUwYiX5Vrf5LNew64OcA7WfeYnU8dS3cqDnMlx3xMxLxGG/sNPpndNRdx?=
 =?us-ascii?Q?qOfyQzpubxqJk+htgkaEYM/lwqeN4NhzLkXYQYaLbTr7pc2O6378SDONR4bt?=
 =?us-ascii?Q?VrwRql9iYOzaB/7TXqKAm/3Xc6r6mlLTPGOmUAT4sXPfyONvPjcffUQ5i6mG?=
 =?us-ascii?Q?WPGbDHTaZ7vp5uLacU2VXU33loTohIcMMMxvwbiaIBYgBnlMGBJXlwoaWLJ9?=
 =?us-ascii?Q?36pQVCfzmU6wvac61IyczgZthAKfb3XYCkz0vyOufRXufEDIVwlgLE8dv26P?=
 =?us-ascii?Q?AnyGm1B4IYF7au/jLPvEf17K1qc5NZmkqu6b8MshWUQD5R2U+I9cI0doS8e/?=
 =?us-ascii?Q?7/tHsxUrVQWQJ9mKcXhQLoVnZa8b+S5SdFtl7AJPtPsKNHGRiq20/HZ92dWR?=
 =?us-ascii?Q?apV4ly6njcLkCgy041C8cEti7y8musMGNtGT8sYoVF2CJKKg0xitjR+w/mYw?=
 =?us-ascii?Q?HSj82r5r0LmAF4o8VybkHxwWDVHWSPkn1xczNxVoNNLMxwfSdwGwQmO8kJd2?=
 =?us-ascii?Q?BMomemyJN+Uvy8UalF73qMM3/aqUWfHMrCrth6UG1huDoy7idV97kEjdWsbo?=
 =?us-ascii?Q?ttYpdy+1vTg17aNxmKiReT8UQp1thU5etyhPQI0f0TFWlku+8lGkI+ECM+w9?=
 =?us-ascii?Q?KXj3EQ1Ultmw7tjfIbPRL2wBN1V5f1GfGWeo2onoh/2pwYQbpBq6Pbsy5tng?=
 =?us-ascii?Q?tlswAB/73MkZrmChGPxkBUnDVWJKAYBPX6+8f8X7/+TzvS885YHF1sgug562?=
 =?us-ascii?Q?JxOj+Kjs2UUVrvcKElnjnVG+GdpoGVNPejdVboLj4noWOHxVKTA6T41RV7+p?=
 =?us-ascii?Q?v/IyiUi33KGpQOd+ql7otzuVwSjX9DWvZKfyPFl7pH1/GrdM2Mc0c2QQxHTA?=
 =?us-ascii?Q?nI7s929jXAYafxWyWs3puIhFtQaXT2Qiw9QqwRMSUugo/jk3FIw4Ut5u4ZF1?=
 =?us-ascii?Q?J5Kea3eIRrQpeJ81HbS99ahrGCGIPYZuom8bLuw0kmYiCJfG+YFAXExhxJMz?=
 =?us-ascii?Q?y5tKEuXlgelKdFUDa7SaVtW4VxRrbhsXZxyt8qIImlwjPxjzJsFKB+E2ci7c?=
 =?us-ascii?Q?ZpiGaI/lhmVOwKmu8fwH3I4BOd+0FjSzsHdPAV54ncCQU5WfBa7Jm00/lIXp?=
 =?us-ascii?Q?MW/PB79jy+Azojx0Wu4S54uEFfZWEoH+388XDdLfaKEkKpZAvyeUeYw2b97L?=
 =?us-ascii?Q?UDQnNXDrXK/45PMwSD7RIGXU/h/OQT4wC57JgujFDSmGM69+AxkzPuaz1LMz?=
 =?us-ascii?Q?HjJK0kKBKOHMk+VvXfJGEK0EfxwAzEn86O+wFnc9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434199f7-2415-40d4-47d0-08dbc8cdbf82
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 13:43:41.1273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TGdZszRqwx2FDPmL2NQ8oUIqnZ5jC4EQgIelOLGtgf28S28wury2EJrbDPWFDRLa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7302
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_44785DF2-B4E2-4DDD-90D3-0DBA62E328B3_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 9 Oct 2023, at 3:12, Huang, Ying wrote:

> Hi, Zi,
>
> Thanks for your patch!
>
> Zi Yan <zi.yan@sent.com> writes:
>
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Hi all,
>>
>> This patchset enables >0 order folio memory compaction, which is one o=
f
>> the prerequisitions for large folio support[1]. It is on top of
>> mm-everything-2023-09-11-22-56.
>>
>> Overview
>> =3D=3D=3D
>>
>> To support >0 order folio compaction, the patchset changes how free pa=
ges used
>> for migration are kept during compaction.
>
> migrate_pages() can split the large folio for allocation failure.  So
> the minimal implementation could be
>
> - allow to migrate large folios in compaction
> - return -ENOMEM for order > 0 in compaction_alloc()
>
> The performance may be not desirable.  But that may be a baseline for
> further optimization.

I would imagine it might cause a regression since compaction might gradua=
lly
split high order folios in the system. But I can move Patch 4 first to ma=
ke this
the baseline and see how system performance changes.

>
> And, if we can measure the performance for each step of optimization,
> that will be even better.

Do you have any benchmark in mind for the performance tests? vm-scalabili=
ty?

>
>> Free pages used to be split into
>> order-0 pages that are post allocation processed (i.e., PageBuddy flag=
 cleared,
>> page order stored in page->private is zeroed, and page reference is se=
t to 1).
>> Now all free pages are kept in a MAX_ORDER+1 array of page lists based=

>> on their order without post allocation process. When migrate_pages() a=
sks for
>> a new page, one of the free pages, based on the requested page order, =
is
>> then processed and given out.
>>
>>
>> Optimizations
>> =3D=3D=3D
>>
>> 1. Free page split is added to increase migration success rate in case=

>> a source page does not have a matched free page in the free page lists=
=2E
>> Free page merge is possible but not implemented, since existing
>> PFN-based buddy page merge algorithm requires the identification of
>> buddy pages, but free pages kept for memory compaction cannot have
>> PageBuddy set to avoid confusing other PFN scanners.
>>
>> 2. Sort source pages in ascending order before migration is added to
>
> Trivial.
>
> s/ascending/descending/
>
>> reduce free page split. Otherwise, high order free pages might be
>> prematurely split, causing undesired high order folio migration failur=
es.
>>
>>
>> TODOs
>> =3D=3D=3D
>>
>> 1. Refactor free page post allocation and free page preparation code s=
o
>> that compaction_alloc() and compaction_free() can call functions inste=
ad
>> of hard coding.
>>
>> 2. One possible optimization is to allow migrate_pages() to continue
>> even if get_new_folio() returns a NULL. In general, that means there i=
s
>> not enough memory. But in >0 order folio compaction case, that means
>> there is no suitable free page at source page order. It might be bette=
r
>> to skip that page and finish the rest of migration to achieve a better=

>> compaction result.
>
> We can split the source folio if get_new_folio() returns NULL.  So, do
> we really need this?

It depends. The situation it can benefit is that when the system is going=

to allocate a high order free page and trigger a compaction, it is possib=
le to
get the high order free page by migrating a bunch of base pages instead o=
f
splitting a existing high order folio.

>
> In general, we may reconsider all further optimizations given splitting=

> is available already.

In my mind, split should be avoided as much as possible. But it really de=
pends
on the actual situation, e.g., how much effort and cost the compaction wa=
nts
to pay to get memory defragmented. If the system really wants to get a hi=
gh
order free page at any cost, split can be used without any issue. But app=
lications
might lose performance because existing large folios are split just to a
new one.

Like I said in the email, there are tons of optimizations and policies fo=
r us
to explore. We can start with the bare minimum support (if no performance=

regression is observed, we can even start with split all high folios like=
 you
suggested) and add optimizations one by one.

>
>> 3. Another possible optimization is to enable free page merge. It is
>> possible that a to-be-migrated page causes free page split then fails =
to
>> migrate eventually. We would lose a high order free page without free
>> page merge function. But a way of identifying free pages for memory
>> compaction is needed to reuse existing PFN-based buddy page merge.
>>
>> 4. The implemented >0 order folio compaction algorithm is quite naive
>> and does not consider all possible situations. A better algorithm can
>> improve compaction success rate.
>>
>>
>> Feel free to give comments and ask questions.
>>
>> Thanks.
>>
>>
>> [1] https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b5942830f=
d73@arm.com/
>>
>> Zi Yan (4):
>>   mm/compaction: add support for >0 order folio memory compaction.
>>   mm/compaction: optimize >0 order folio compaction with free page
>>     split.
>>   mm/compaction: optimize >0 order folio compaction by sorting source
>>     pages.
>>   mm/compaction: enable compacting >0 order folios.
>>
>>  mm/compaction.c | 205 +++++++++++++++++++++++++++++++++++++++--------=
-
>>  mm/internal.h   |   7 +-
>>  2 files changed, 176 insertions(+), 36 deletions(-)
>
> --
> Best Regards,
> Huang, Ying


--
Best Regards,
Yan, Zi

--=_MailMate_44785DF2-B4E2-4DDD-90D3-0DBA62E328B3_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUkA4oPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU0GIP/1yOJU+pYnh4tjyapsDCMr3//3Zhe4vo5B0u
ZZc9FKfNjQCh2MccBqAIUrKx5WTFpDg4sONFnJd4VyPIrZ3feCf42d5/8KlL8H+Y
uwUC9IDT8m81HNOs3IqugN8MKeq20pNHtEm/q1Tr67kx+V0j9pgvJcYTJA4EKf5V
TBvAFTwujJozM2G38yskqKhZhQUOrcsURxfsEipnNDSL3LgdheLqk4wGeRtc2461
4V64GJV8llVzqv3IXK7owJWfVKm2IqtNxK5ruC/mP/q4urYzghquk8mx1wXIkr8A
JtbCZ7QYuGNm25Tp+1l9yydHOQ8t8Zy4iEFBDHXaZfacByjJej9Y1vjEMrqdpFws
r7BrAnT7gq7lMRu2urdVcaRjSoIhwKnGP446OISoPIyTYL97tH8TV+Dc66Z4QOC4
329JZ/XDoTvAvnPR7YWk54wb0vypqeFkOIuj4S2CoRPglUj7F00OjGwelOmQYuWN
r5ld8ET/TGQbAMmVTAcxGtzHzRI9njcqlLDKMazs08hHah/czqMK7nrjnhNHTRcP
glVyC86xm4H4UjX5JY13jXXNyBUjlR1mGbYWltSEp8jnFD+9e2iL+oHl0JlUpEnJ
l+x3AaOa9lOGn8rmcVF9LoqSUf2MIScIyHaa/2AaCxiWRyc6dWfg8ha4OZtBAbWZ
litvxK+T
=6A0y
-----END PGP SIGNATURE-----

--=_MailMate_44785DF2-B4E2-4DDD-90D3-0DBA62E328B3_=--
