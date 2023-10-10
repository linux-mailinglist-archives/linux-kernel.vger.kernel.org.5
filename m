Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280BF7C01EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbjJJQsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjJJQsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:48:33 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFB4B0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QxadM1MKR4X/IO017A1bn8wtcOU/cP0fjET7fZlFnPYQwk62VjW9Bm7kGvZCB/rBvE1Ro7N2O1sKYF0bizAYs6XJXwzTbcsxjVFjWNip7QVWqdxwGlg15YAAGzm6r9fMZbikOmE+//DbI6aSENM88V5ViRF8j0Xvt1lYdrI2R5ig3UAzoqyvAf6Ry4jkcZ5KETb5PqlJsl64pN5Oy4zLM5iu/+dTOlGgPxW7FuOusxldG4gqWGUTT+D/RBuTqkDVPgMKRZksS3jY9HTsCz/y3jt1UJKBlmFEZAdLayPG1bExpft6lSbF9WkRXecKmrsBfG/+ruxMKHNAlK8UkmecSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwnxxRbVLBZ5bF95JXk+D4T3Uckl+pqirxwjlJXiXkM=;
 b=CaIKx0k9V43w9eKOUVXrsmcTq1clTUfJPN9VU12X/MdS1tcvBc+CnHjbeGtt3HOY3nKC+Zkb0n7FYeEonhtOlBON8N5EN20RLPVs66JyvReNuFQSYSo11tkYCpgmaVI+q59i/r4V+UYlTd7/rCUKnOOukzd26euWFGOmo2k8x9U6U8DFwqpxFlUiJNT34Fet/l97vt8qYh53T4aRrJ20vi5fQ6/ArO4nqGNs3lm7HKoslCI3YiYm416ssqHfaekRp8JiYeToSuFbQoSxaK0hBpNht4cdtq2d5MdtH082jiRb5Lgz+jrRwILflJFvZItsd0wu6ef/6c3R0P35mNWu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwnxxRbVLBZ5bF95JXk+D4T3Uckl+pqirxwjlJXiXkM=;
 b=bD6+APAVAnENWKq0757hXCAaG+p2c63loUHVGPSv+3RAjO+cxjyPPImo258PS1QDT/I7RDLlgNGya3yu/2HZFcuSc+m4j/JAfljJHUN2cxkWXxBZTbHh51L4S7kjXy8bwIayrmDC6eTIpiIlxGcL4oIvYYvZmgILEf79U3jH7gGMXBtmtYTvSIyBAGmx/hVIntNxP1/J0sMpQ41hSQ1TK0Nc97z4nGju3ixHbT7LF+4v0RNCF4z/9T9IwQE9Yd+6+dn3HBf9E2SPcf7+PbCYBbeWOZ135YF4MvvnwdAjuuYcxvosOZZ3XBocTQuhi9MOTySNhzlYEpaBs28q/Vzrrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 CH2PR12MB4860.namprd12.prod.outlook.com (2603:10b6:610:6c::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 16:48:29 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::4b09:197c:609a:1013%7]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 16:48:29 +0000
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
Date:   Tue, 10 Oct 2023 12:48:25 -0400
X-Mailer: MailMate (1.14r5994)
Message-ID: <30D10C9B-A785-4360-9548-A1325D436A95@nvidia.com>
In-Reply-To: <87r0m3ggc7.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20230912162815.440749-1-zi.yan@sent.com>
 <87a5ssjmld.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <14089E95-251E-43A4-AF32-C9773723C810@nvidia.com>
 <87r0m3ggc7.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_054B0155-2AFC-40FB-8372-4B8185BC0BB0_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0356.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::31) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|CH2PR12MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: d6548e44-7cf5-4738-94b9-08dbc9b0bad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kbT3/B6o9bxXHjKRlqsaTFo6VL5Jqhq4xiEsWE1UCye6wf+VvJd/M+uF32Y/N8Nci1o5wMeBLAETvPxvWpSxaT22MIkhuPdkvvXau3EQJb0dotD5RxOHpj2YNvXGszV2TwZ18olHxJauMUrZRfN7fwLmsoFstgbUrN9eTh1Gw5sZuBMJyBgYQPU4tQfZBP50VJxbI3V8uC+bS7uhOqQlk1CZAV+D1idD6sjtXu4ytssWlneRUguf9TSS5yPIrWxE/um7gMUz5kcx40JiJpyOfxc9yC8BAbKxZKs2WNQhpFkTtCC+n2Sk4AQepyGXP3Qz8cw7WTTStMNr+lqEsj50PuCV1zRc4VecruWPS//V6s9FJ5Go4zmq54YcX9JmjudV5yi5oIIxUcEiWY+3JkOe+0M75wj+MbSb7leEEyE9hSMSR+UqQcaZUVIkhcN9+SNLAfPDJYI6oVwL+h/a7TjXE9CW0stJNI/gc5Tj/Yr8C0nl9aKkf/R0Cq7EmO8lDdfeAaZLyjTvxKEUMSWBog/2SO9zhawVJdAkzRZ0IiWJ66Pj0dQpMfi9DQrtyYBK1O0CCCxfFvGg90oS5LtI761SmqEBZVAtUAlD7r8xf7uYOIuo4YeGK9yG3VCcjubdwVA6SxDZ1329gUxK6D5er2w9BanWRIIYPrgQwmfw+G6B35M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(107886003)(2616005)(26005)(7416002)(66946007)(66476007)(6916009)(316002)(33656002)(41300700001)(53546011)(54906003)(66556008)(38100700002)(8676002)(4326008)(8936002)(235185007)(2906002)(5660300002)(6666004)(6512007)(6506007)(86362001)(966005)(36756003)(478600001)(6486002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2/4FVwkjqZKUamr6htfgqPSojqATi4z9AO/FlRMCso5pObwGBeFE3cVc8a0J?=
 =?us-ascii?Q?BT5fIAQQGj3pw/bF/uq5QCMN/4zVpaaEf7JjWuNdQjNZC0Su9M4IGEuOVxS2?=
 =?us-ascii?Q?FioATMbAk/Q0awyIiZRpVbm0gKETkeM6FA+gZWsQ0kaESchLWKoxWjWF+Z2r?=
 =?us-ascii?Q?vKBTfTBVbpR4ZRsPSKEXGSyomDusy/Q8TPXzhDDIQNEt3TkvflplAuFD1AtU?=
 =?us-ascii?Q?1ZK7V/M7Hkue2d73Asc/dRQOiFYLGqcuzFYcB0TImoRU69rufaJ/pig8Hcku?=
 =?us-ascii?Q?p+mXe1//vuCzdU6Jx2Ew48XuY/yDAym4svQWU78FYS21Vljkpy3QiJwO2p3P?=
 =?us-ascii?Q?p933A0fppSjN6+xXn/EepwMZX82Y6w8Lb7SEipykwjbNgksRORr52ruLIsax?=
 =?us-ascii?Q?jXxSjIFITNFtLhJbO89t1jvaNM3JkAIrog/39IrMlUrW/bD3UBuHA7fN/W4D?=
 =?us-ascii?Q?7ddT8akHAon2ttfM4n86hGDDgxKTrIOlpE/X0Ory32SfdM8ElLDvBk4k4kTd?=
 =?us-ascii?Q?FJblgWNBhgoRwbmOh7VR5oQX0/aqv2gBeNg/F7VNcMV3/1PI8veZ+Pn1KRCr?=
 =?us-ascii?Q?HeP8tKAKO5OIfFQ4qZgfkTYRJhp5giChhwWAGtQQ4sAnxnTnr4s8trovmpVu?=
 =?us-ascii?Q?XEsweTDhoTTpUrmrK1yVpINKi+VBbkXXGbKkSXwQwDSohrlAhmsDc0uvgu+9?=
 =?us-ascii?Q?WIO9bZWp0Wuc8IHbmfSJpngfbl0F9gatz3ajgs8I1dxwymdvBU+b+KbNgH6u?=
 =?us-ascii?Q?u1sy7XkYmXFIhag6ZbSfSKzXijGVUKyuvXlw1K81P2n5VXvCd2y5eIraDrqu?=
 =?us-ascii?Q?ZxVLRxUrMo4t79cHHHeopDtERb+4wpTg7rN+jrT/Dwc1E/fdxeTrr2OfKeHW?=
 =?us-ascii?Q?z5EPlZUNiYT+dO4MPr6U+Fc0wDMwXej53kRPMMxLvoeJMm5h9ecSlD22BU7t?=
 =?us-ascii?Q?eG5bQ9GGl9LUSta3mY91AnlXv4gbSxLXTJgqUladcsUXPmV5UfR6BaqKhEnm?=
 =?us-ascii?Q?WDBT+WnNS5WiIE6EWVlYN90nE4VExSvvS+xxv3euuDiswmsmFyQJ1NvUgHKp?=
 =?us-ascii?Q?ScOPBJKM9LDg40Ec2qsGr+OeFd9+IRlVA2BVFknze8v21XzQJIeIVuaDi5mO?=
 =?us-ascii?Q?yLnFDyX/HyLBPWJetSbS0/lHwu8ZLHe2HGf7HTSwrE0RvZfmixeVM3xs0UHq?=
 =?us-ascii?Q?lGKLAehgV1E0ckpavwspSbirTprZ3EW7zsFDTg896oapeSqlEcqDShVKhnmn?=
 =?us-ascii?Q?0Qv55MA3wWS44pq1B8/dt7AsJEHAUl1ZEc+U52pK+pQl2egiPGW4eLzFNfPn?=
 =?us-ascii?Q?f6xJvQOLAstAlsOMxPBWCdnS5wOlYCD0YeV4PihJ13Q+sU4XMY+xMxYk5x4B?=
 =?us-ascii?Q?AcdI6Eqa3IxLUcOLS8a/ih1i6aRkG1s2eUB3fkOulwrqA6sr0oSLUheOHVTo?=
 =?us-ascii?Q?Esqq1ADAR3R/nRs/BedJsftjN8o7m4iUtn8mGp7jUfOJqEQLEVrpHr+upoUs?=
 =?us-ascii?Q?VuAANOBcALsUDSzMhDtb0wKmqYjkN1SA3U7QMQfMN6uvYl/mD754prngqJ7g?=
 =?us-ascii?Q?CJhDgT/DMX1eNVzI0wEmzLU4JAko4IDILMrgsl0R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6548e44-7cf5-4738-94b9-08dbc9b0bad8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 16:48:29.0758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSMaEjyVmPoPs+fqaxxgce4GmYhOT/2ueRCwXPEitnupBvYOvKae3aa3Oe4PLyut
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4860
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_054B0155-2AFC-40FB-8372-4B8185BC0BB0_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 10 Oct 2023, at 2:08, Huang, Ying wrote:

> Something wrong with my mail box.  Sorry, if you received duplicated
> mail.
>
> Zi Yan <ziy@nvidia.com> writes:
>
>> On 9 Oct 2023, at 3:12, Huang, Ying wrote:
>>
>>> Hi, Zi,
>>>
>>> Thanks for your patch!
>>>
>>> Zi Yan <zi.yan@sent.com> writes:
>>>
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> Hi all,
>>>>
>>>> This patchset enables >0 order folio memory compaction, which is one=
 of
>>>> the prerequisitions for large folio support[1]. It is on top of
>>>> mm-everything-2023-09-11-22-56.
>>>>
>>>> Overview
>>>> =3D=3D=3D
>>>>
>>>> To support >0 order folio compaction, the patchset changes how free =
pages used
>>>> for migration are kept during compaction.
>>>
>>> migrate_pages() can split the large folio for allocation failure.  So=

>>> the minimal implementation could be
>>>
>>> - allow to migrate large folios in compaction
>>> - return -ENOMEM for order > 0 in compaction_alloc()
>>>
>>> The performance may be not desirable.  But that may be a baseline for=

>>> further optimization.
>>
>> I would imagine it might cause a regression since compaction might gra=
dually
>> split high order folios in the system.
>
> I may not call it a pure regression, since large folio can be migrated
> during compaction with that, but it's possible that this hurts
> performance.
>
> Anyway, this can be a not-so-good minimal baseline.
>
>> But I can move Patch 4 first to make this the baseline and see how
>> system performance changes.
>
> Thanks!
>
>>>
>>> And, if we can measure the performance for each step of optimization,=

>>> that will be even better.
>>
>> Do you have any benchmark in mind for the performance tests? vm-scalab=
ility?
>
> I remember Mel Gorman has done some tests for defragmentation before.
> But that's for order-0 pages.

OK, I will try to find that.

>
>>>> Free pages used to be split into
>>>> order-0 pages that are post allocation processed (i.e., PageBuddy fl=
ag cleared,
>>>> page order stored in page->private is zeroed, and page reference is =
set to 1).
>>>> Now all free pages are kept in a MAX_ORDER+1 array of page lists bas=
ed
>>>> on their order without post allocation process. When migrate_pages()=
 asks for
>>>> a new page, one of the free pages, based on the requested page order=
, is
>>>> then processed and given out.
>>>>
>>>>
>>>> Optimizations
>>>> =3D=3D=3D
>>>>
>>>> 1. Free page split is added to increase migration success rate in ca=
se
>>>> a source page does not have a matched free page in the free page lis=
ts.
>>>> Free page merge is possible but not implemented, since existing
>>>> PFN-based buddy page merge algorithm requires the identification of
>>>> buddy pages, but free pages kept for memory compaction cannot have
>>>> PageBuddy set to avoid confusing other PFN scanners.
>>>>
>>>> 2. Sort source pages in ascending order before migration is added to=

>>>
>>> Trivial.
>>>
>>> s/ascending/descending/
>>>
>>>> reduce free page split. Otherwise, high order free pages might be
>>>> prematurely split, causing undesired high order folio migration fail=
ures.
>>>>
>>>>
>>>> TODOs
>>>> =3D=3D=3D
>>>>
>>>> 1. Refactor free page post allocation and free page preparation code=
 so
>>>> that compaction_alloc() and compaction_free() can call functions ins=
tead
>>>> of hard coding.
>>>>
>>>> 2. One possible optimization is to allow migrate_pages() to continue=

>>>> even if get_new_folio() returns a NULL. In general, that means there=
 is
>>>> not enough memory. But in >0 order folio compaction case, that means=

>>>> there is no suitable free page at source page order. It might be bet=
ter
>>>> to skip that page and finish the rest of migration to achieve a bett=
er
>>>> compaction result.
>>>
>>> We can split the source folio if get_new_folio() returns NULL.  So, d=
o
>>> we really need this?
>>
>> It depends. The situation it can benefit is that when the system is go=
ing
>> to allocate a high order free page and trigger a compaction, it is pos=
sible to
>> get the high order free page by migrating a bunch of base pages instea=
d of
>> splitting a existing high order folio.
>>
>>>
>>> In general, we may reconsider all further optimizations given splitti=
ng
>>> is available already.
>>
>> In my mind, split should be avoided as much as possible.
>
> If so, should we use "nosplit" logic in migrate_pages_batch() in some
> situation?

A possible future optimization.

>
>> But it really depends
>> on the actual situation, e.g., how much effort and cost the compaction=
 wants
>> to pay to get memory defragmented. If the system really wants to get a=
 high
>> order free page at any cost, split can be used without any issue. But =
applications
>> might lose performance because existing large folios are split just to=
 a
>> new one.
>
> Is it possible that splitting is desirable in some situation?  For
> example, allocate some large DMA buffers at the cost of large anonymous=

> folios?

Sure. There are definitely cases split is better than non-split. But let'=
s leave
it when large anonymous folio is deployed.

>
>> Like I said in the email, there are tons of optimizations and policies=
 for us
>> to explore. We can start with the bare minimum support (if no performa=
nce
>> regression is observed, we can even start with split all high folios l=
ike you
>> suggested) and add optimizations one by one.
>
> Sound good to me!  Thanks!
>
>>>
>>>> 3. Another possible optimization is to enable free page merge. It is=

>>>> possible that a to-be-migrated page causes free page split then fail=
s to
>>>> migrate eventually. We would lose a high order free page without fre=
e
>>>> page merge function. But a way of identifying free pages for memory
>>>> compaction is needed to reuse existing PFN-based buddy page merge.
>>>>
>>>> 4. The implemented >0 order folio compaction algorithm is quite naiv=
e
>>>> and does not consider all possible situations. A better algorithm ca=
n
>>>> improve compaction success rate.
>>>>
>>>>
>>>> Feel free to give comments and ask questions.
>>>>
>>>> Thanks.
>>>>
>>>>
>>>> [1] https://lore.kernel.org/linux-mm/f8d47176-03a8-99bf-a813-b594283=
0fd73@arm.com/
>>>>
>>>> Zi Yan (4):
>>>>   mm/compaction: add support for >0 order folio memory compaction.
>>>>   mm/compaction: optimize >0 order folio compaction with free page
>>>>     split.
>>>>   mm/compaction: optimize >0 order folio compaction by sorting sourc=
e
>>>>     pages.
>>>>   mm/compaction: enable compacting >0 order folios.
>>>>
>>>>  mm/compaction.c | 205 +++++++++++++++++++++++++++++++++++++++------=
---
>>>>  mm/internal.h   |   7 +-
>>>>  2 files changed, 176 insertions(+), 36 deletions(-)
>
> --
> Best Regards,
> Huang, Ying


--
Best Regards,
Yan, Zi

--=_MailMate_054B0155-2AFC-40FB-8372-4B8185BC0BB0_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmUlgFoPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUOM4P/0As7c8dv4FHLihPiVHOssXLw6E5WnohZzxz
nfkkCjMDSbHcN1gPPv+aFz+BhEu0HuEbarYIexiijn9k8qSa++VhrOpUuDeOzOiC
hWCzGJ9To8Dnu1Dftr737ly9GHpKLF+WRc09VTHUen3BYaYrKp96B7auI0htiIMd
KnZWG/0dyu0wsNwKlji4U7uX5rhhryL04aUMTix4BLQlbl/C+9M++1WkLE4BqaNT
ncKOwd+TL7QnIHNKoAfGkW7GcYwroUNfJGdFNvDqUGLJAaCsrSo8ndjywbKIFRCA
sXHzr+I05xex0L1momh8g035qLVmPSklVYZ3OhJ/yj7KIkbrExqg7OBoBlEdJaPO
4bHcT8Ffikze425TvYGbaumbsvYMMObrGuWVdVB0J2wPudlOlu/Wd7y1A4MPzCi6
DTCDwcu/jddUYOTt1ZhfWAS2P9UDUt6u4VltWSnzqIelC4IMMkOc6DK5v39zca+K
3JtVQnpek2w4yJlTIvTSq9RvX60V3fQwAt2+qztaviFBz7HT7RhgGrWmnXie1XaC
yvBR7K/jRI72s7FTx8ynAbHtcqzQGxUL5uHJg/OAZ1i9824LLevFQs9YmAn9tPwn
8DL8l3fphsSTi49gs8AI952j2RI9RyrFwsBdB0QU/rODPlLu3bkaNC0ab1xqxbXF
ZCzTzAAy
=4zy4
-----END PGP SIGNATURE-----

--=_MailMate_054B0155-2AFC-40FB-8372-4B8185BC0BB0_=--
