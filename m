Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA95753DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbjGNOlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbjGNOlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:41:18 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C6A1BC9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 07:41:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhjpVMwhqyHWHUR61LVO2tVfVwxiGFRc+sObun0m+wyROrKgyLEYZrcoBGAMYJaoiP2h+14yqVuV0TksdqL2Ek2+MeUchDzDdTcTdqv+s1wYTac96mlCoeWiLRrxBO5Bpy3tcz5xdZfKFXL6bz+p0SrZxnWPRc2cfTXhLYNbuQo7Kty9QWujSCjk0/s79sV+oV7dw16RHChvdvjX/ZyX48fy9CmYzOsEfrkXjwmQeTls+fF+T04VgBPYNuBsis/VLAby2HJJ7ygN/g771MuqqbliN3W0jQiG4n2lfgJMAq6MZJP20wDzOI6duhU9dyBjzhlCz80+e50mIGc3l45qDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbjTGF2dKbqCKx7zIhoNtbRhC7gI3l6F9ZRnXnySpSs=;
 b=QMVdpbpzN1dymvqdJizehpJcGbSAfpCUOBCocPe9mQCSxXiqdTORUAXa4EGkLlo+3QBFCaodDDebShwtky5TTYKfF1UNH3RLpWqVtEKQoHlECbC30kBnlrF+QrajuRkPMFGS+DouDMY80TqTyE5XYEQhDJ67+E6xeTi9Zs5tRYyB/Osxs+/+TS3RzE1Tmq5Ul46Ks7uEjoIE4twCMnLrpm/Qa+GIAp7n6Olu3SFnod7rjXfK6rBtnW7x3J56DD8/ZLJUJG/6kIgEzPDAmohxbI1cYcG0gDpAiTTowDzFnGNs5AjhZzMIfHzidRipsdSyzsP9hwmoK+IxzR2R4sY6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbjTGF2dKbqCKx7zIhoNtbRhC7gI3l6F9ZRnXnySpSs=;
 b=E8H9CCZ27OeWK5AbFxDkEaCpkXL3Bd8EThFTiof0AcV8fDvQFKIIjSC2GIH8TBjKUPGYmwRcjuy0b1T6X2zf9rUzPoAJOyjDy4d0DEhJqU3a1G6G3J34Q3tshAxm7KJA9UbmBz9VIuMEiHJ+7eLaY5pfJJ2dsG2/RjiOlreKLcQX2/n1ET6hL4qLuq+kO25aOm4WHYvcP5+C+W6O4TlVGooOYzlZwtxPl6wK+cwcIG9nm2kEaO5UvQoFwiagy66eU9Bh+x9kDxm95dsOYcM3/NXDaFT3uuoSY1EbV0ThjHFWKnFpjeKjoBW5NijtoXNvnty32Xt17ZdZR1KIId8rlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Fri, 14 Jul
 2023 14:41:14 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::12b7:fbc0:80e1:4b8b%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 14:41:13 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, ryan.roberts@arm.com, shy828301@gmail.com,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
Date:   Fri, 14 Jul 2023 10:41:10 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <6C3EFBC6-DC59-4167-B51A-7231A55FE1D5@nvidia.com>
In-Reply-To: <d024fa03-ca51-632b-9a01-bbdc75543f5d@redhat.com>
References: <20230713150558.200545-1-fengwei.yin@intel.com>
 <CAOUHufb0zxKvmvEXfG4kySenxyPtagnr_cf4Ms-6si3bQTybGQ@mail.gmail.com>
 <8547495c-9051-faab-a47d-1962f2e0b1da@intel.com>
 <CAOUHufY-edD2j2Nfz3xrObF2ERAGKecjFr_1Qarh5aDwyDGS2A@mail.gmail.com>
 <d024fa03-ca51-632b-9a01-bbdc75543f5d@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_E6DA2779-B820-4542-8AC2-6C252D4A82D8_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR22CA0019.namprd22.prod.outlook.com
 (2603:10b6:208:238::24) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|SJ2PR12MB8955:EE_
X-MS-Office365-Filtering-Correlation-Id: 614696a2-9429-45aa-110d-08db84785f3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBKAohMiqIb3xg9FxQrCe/2EvWJT31sKlf2yBy9FSUI2FlQyP0eNK1iWHyJP1QOmgUcUMt2nhmO++TVfkTEbUJ8fHywsBfvU0t22WTlHG857DdFUnQ4gsTRJHEiNFukeTzhZvnhM3eJ9wdLxtkyFwwUxF8yyPN8m0REaTdCest3ieuYEK7gDTb5EXbBom/d1LjRUJgRcK65aB9JL3kM2N+pJU45bs6jtMhsyc+EyUxkNzYNMP60fiBF1uqnJ7cQtDt1NZ4Y5zVeXoYNQpAu9rY4pHQ+A5ye2jr6/GuuA/Mwm4iW1WjamOHoEnOABVz9URauNE5VAm+z6SEzTmwylQ1bLTwhmxMzeXy6oMV17Ag5JB8wfmsvOFliF0EbuwK66qmzNHOJdjLWsmEaR+uGBzD3EmbtLcB3GTGMV1zEDmVUo0nMH0NM4dPtfU8/e/PzYfNitEAZqZVtAySQ3jhVGIMpfOC/lfQdqawwE2v1PSOu6Fqr1y2yjbUDPLPbCSuamHFaAC5LGNr8Jn/eRTPZjpsRx/3xSQiEh+L/LFZaQSIgQkUU7rxwd286bQS4NDD6+3+RB/35Lk8NK49+z6VMxiBwLgDk1rg3LvxVZyfm4wJVN991n9f7PPAeH26qFeZwQQZFKqxm9uuLovuxXLk8A5u7WbuJc8WMFu1XLNWUltPzgZtFm5lNQm/Dwjndq54X+aKFfEDE3gNys1wJvoVp3Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199021)(186003)(6512007)(5660300002)(33656002)(26005)(966005)(53546011)(2616005)(6916009)(4326008)(235185007)(2906002)(8936002)(41300700001)(316002)(66946007)(66556008)(7416002)(478600001)(83380400001)(66476007)(8676002)(33964004)(54906003)(36756003)(6506007)(6486002)(86362001)(38100700002)(66899021)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zitxemh4dEhqaW9MYUp5eEYrRnI3b2Q2OEE1VlNEYmRFR3VSRkQxUDVaRmxy?=
 =?utf-8?B?RlRwa1daMjhQbnVrb2FEd24wS3JFQ0orZHZwVTRmd1FJSTZvMmFwUTJWVU1I?=
 =?utf-8?B?RzZmSG9DYldqb2UxL0Fqa3BJUFhoT044R29kYkZxRmxpeXlUY3EveE9hTXJ1?=
 =?utf-8?B?N2o4KzU0bEhFeisyYW9hL1FOTFVCNlVqSUhvMGFYdWxpVHI0amlRSmFjRThr?=
 =?utf-8?B?Z01nYWFDOHRrbnMrUnpxR0NtOVI4eUlnOVFHbVNBYUthejJDcUJOQStxaW41?=
 =?utf-8?B?RHJoeEZUajhkMW0yTDhKak55OVBWTC9vTjVBbzFCMXNyRUxLS2hXdUxBKzcx?=
 =?utf-8?B?QjZGMzdqSVlqY0dqU0xVMnphMVVaZ2x2NXl2Uk1QZWtrUnl6Wjg0WmJOTlJq?=
 =?utf-8?B?QW1TNGxQeHJ4T1BFclJvZ1FQbmxxRlQzczRKODc1OGFUT0RuM2RZMUpYYVVG?=
 =?utf-8?B?czBGTHZvRSsza3lkYXB6NjkxUTY0TXA3MVVnMnF0QmhUYzdOYkI4UVFnTmFC?=
 =?utf-8?B?VmtISFVsaTNQaUoyUmtpMUMvY0tWL3FVNDN1WThiV2o4WXdtQlBWaHdWeEFo?=
 =?utf-8?B?aG9tbzl4NGs2alYwY3JiMFpWZEcycTRhZzk0QkN4ZXo5TDhoV1hnZ25MQnUv?=
 =?utf-8?B?L1E3dDh5NnAvaFN3QThUTDYxcm53NDNhMlN6OGRNUEZvUDRWZmxKbUNUUzJp?=
 =?utf-8?B?cWs2Z1FRODV0cDNIVkt3c3BydDYwQWRsRjdsYWJiMGplMXp5NWpWQ0JKQ2Mx?=
 =?utf-8?B?bGIyVURlZzdoclFDK1VMdFdNS2hEWStBc0RObW9JUU1IbDJYZFl0QXJOUmtG?=
 =?utf-8?B?Nlg2dmoyWWtQaEFCQklXcmxFRHM4Ni9GeVN5dkhzRmdnRDh0S0h0ditOSmJO?=
 =?utf-8?B?ZGNwSzE4QVRRay95eStuZ0ZHN3FES2RtUFR4QU1zL1I5cDB3d0tSSXBlSHBK?=
 =?utf-8?B?OElMbnAxL0RSWWIrV2ZONjZKaERKcWo5RW1GM3BsY0JmUnpDRmUwRmFJRUpq?=
 =?utf-8?B?ZklKYUR0TzMvR3MwYWs1aUxIelVGaUY5OHBMTTJWSm9uRFluQkpneFBreklp?=
 =?utf-8?B?RUpKbWpIQWtWSGVBREJqZ3VBT3EvUU9WS2NYcG4zUVlaSlU3M0xuQnF1U1p1?=
 =?utf-8?B?aUFLYVFWSHhWZ0NYd29FRTlQUWZMOEdsNkRzNEYyUHhuL2NYblAzc0FLaDdx?=
 =?utf-8?B?OWhlTnNDbHVMMnp5K0ZHRUZUMklwcWxnYmF2aFR0TGlzN1NWdlZyQ0ZyazZu?=
 =?utf-8?B?VFFTeDRyazhkM2psT1J1MmU3UTFneDMzV3V1NmNmb2ZJNHFqSFlEakpHU2ds?=
 =?utf-8?B?cndONHBvYjJYOXNjUkd0WUc4MDUrTkxJZVVYdmVkbDIzcjlmSVhwWVBDd0ll?=
 =?utf-8?B?RERpWDFJVEFqM3BCME1sWnBtaGNiK1VDeXpuSnNtUDVBdG5JSlJwT3Vabjl4?=
 =?utf-8?B?V1J0Z1d0VUc1d0VUczlqaVR1VXB3eVdieXNFelJWa3pPcTlEWGZidlpzRHhz?=
 =?utf-8?B?UUNUeERFRXdTRnFRa1JzN0h6eWlrSEtHOWNsdkhZN3MwellVRVRVbWg5U3pB?=
 =?utf-8?B?RmNUS04vbTlvQlUxbkNXT1NIclJvOFhOUVBidzRkM0NhanNFd3ZGTElVWVJF?=
 =?utf-8?B?L1hXSWJ5cTZZZWxMN0doR0pjWktETVg3ckdzT1lueEtRdEUzMmQ1anh0QzFT?=
 =?utf-8?B?UU9Ob05YRE5ZenZIZ2ZVUUxkZkkzVUQzUkVFdmlYTytmK3NicUI1RGZxY00z?=
 =?utf-8?B?cUxhbCs4Nm9kajNZS0d4LzFUVFc4bVpOTzRhY21rNTJvT3RwMEZtTGtxUDUr?=
 =?utf-8?B?WXpLMzVXWGJGU1VmWGdpQUExdHZWTzd6NXVTWDVlSE5rQ21sU0dqcUM3OGVk?=
 =?utf-8?B?SVlKYWVnQy9vTk9DNHlMd3M3aytYb0o3enNoL1hMenp4UVJnbmNkbjZLa2Y2?=
 =?utf-8?B?blJ2dDhzSysvY092SkNwMzFJelJyTXZXbEo1NE12ejdpdWxaTW1MS0NDYkp5?=
 =?utf-8?B?TXU4NitPTGw0eXkwbmM0d1lkN3ZzWVhXeDlYNjdQMy9Hanl0SkhYTVZtNU40?=
 =?utf-8?B?Ym55a1NiMFJReGdrdU9JZkxNQzBUcDRzMkZkQkxuekd4OXdPUzRWL0xyR1BS?=
 =?utf-8?Q?VWUQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614696a2-9429-45aa-110d-08db84785f3d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 14:41:13.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+8RY6LpF2Ak16j21jrInhr9RnjdbVdzUrtd7l6j0j9l/+lZYIoo8wciOd9YgQPn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_E6DA2779-B820-4542-8AC2-6C252D4A82D8_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 14 Jul 2023, at 3:31, David Hildenbrand wrote:

> On 14.07.23 05:23, Yu Zhao wrote:
>> On Thu, Jul 13, 2023 at 9:10=E2=80=AFPM Yin, Fengwei <fengwei.yin@inte=
l.com> wrote:
>>>
>>>
>>>
>>> On 7/14/2023 10:08 AM, Yu Zhao wrote:
>>>> On Thu, Jul 13, 2023 at 9:06=E2=80=AFAM Yin Fengwei <fengwei.yin@int=
el.com> wrote:
>>>>>
>>>>> Current madvise_cold_or_pageout_pte_range() has two problems for
>>>>> large folio support:
>>>>>    - Using folio_mapcount() with large folio prevent large folio fr=
om
>>>>>      picking up.
>>>>>    - If large folio is in the range requested, shouldn't split it
>>>>>      in madvise_cold_or_pageout_pte_range().
>>>>>
>>>>> Fix them by:
>>>>>    - Use folio_estimated_sharers() with large folio
>>>>>    - If large folio is in the range requested, don't split it. Leav=
e
>>>>>      to page reclaim phase.
>>>>>
>>>>> For large folio cross boundaries of requested range, skip it if it'=
s
>>>>> page cache. Try to split it if it's anonymous folio. If splitting
>>>>> fails, skip it.
>>>>
>>>> For now, we may not want to change the existing semantic (heuristic)=
=2E
>>>> IOW, we may want to stick to the "only owner" condition:
>>>>
>>>>    - if (folio_mapcount(folio) !=3D 1)
>>>>    + if (folio_entire_mapcount(folio) ||
>>>>    +     (any_page_within_range_has_mapcount > 1))
>>>>
>>>> +Minchan Kim
>>> The folio_estimated_sharers() was discussed here:
>>> https://lore.kernel.org/linux-mm/20230118232219.27038-6-vishal.moola@=
gmail.com/
>>> https://lore.kernel.org/linux-mm/20230124012210.13963-2-vishal.moola@=
gmail.com/
>>>
>>> Yes. It's accurate to check each page of large folio. But it may be o=
ver killed in
>>> some cases (And I think madvise is one of the cases not necessary to =
be accurate.
>>> So folio_estimated_sharers() is enough. Correct me if I am wrong).
>>
>> I see. Then it's possible this is also what the original commit wants
>> to do -- Minchan, could you clarify?
>>
>> Regardless, I think we can have the following fix, potentially cc'ing =
stable:
>>
>> -  if (folio_mapcount(folio) !=3D 1)
>> +  if (folio_estimated_sharers(folio) !=3D 1)
>>
>> Sounds good?
>
> Adding to the discussion, currently the COW selftest always skips a PTE=
-mapped THP.
>
>
> For example:
>
> # [INFO] Anonymous memory tests in private mappings
> # [RUN] Basic COW after fork() ... with base page
> ok 1 No leak from parent into child
> # [RUN] Basic COW after fork() ... with swapped out base page
> ok 2 No leak from parent into child
> # [RUN] Basic COW after fork() ... with THP
> ok 3 No leak from parent into child
> # [RUN] Basic COW after fork() ... with swapped-out THP
> ok 4 No leak from parent into child
> # [RUN] Basic COW after fork() ... with PTE-mapped THP
> ok 5 No leak from parent into child
> # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP
> ok 6 # SKIP MADV_PAGEOUT did not work, is swap enabled?
> ...
>
>
> The commit that introduced that change is:
>
> commit 07e8c82b5eff8ef34b74210eacb8d9c4a2886b82
> Author: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Date:   Wed Dec 21 10:08:46 2022 -0800
>
>     madvise: convert madvise_cold_or_pageout_pte_range() to use folios
>
>     This change removes a number of calls to compound_head(), and saves=

>     1729 bytes of kernel text.
>
>
>
> folio_mapcount(folio) is wrong, because that never works on a PTE-mappe=
d THP (well, unless only a single subpage is still mapped ...).
>
> page_mapcount(folio) was wrong, because it ignored all other subpages, =
but at least it worked in some cases.
>
> folio_estimated_sharers(folio) is similarly wrong like page_mapcount(),=
 as it's essentially a page_mapcount() of the first subpage.
>
> (ignoring that a lockless mapcount-based check is always kind-of unreli=
able, but that's msotly acceptable for these kind of things)
>
>
> So, unfortunately, page_mapcount() / folio_estimated_sharers() is best =
we can do for now, but they miss to detect some cases of sharing of the f=
olio -- false negatives to detect sharing.
>
>
> Ideally we want something like folio_maybe_mapped_shared(), and get rid=
 of folio_estimated_sharers(), we better to guess the exact number, simpl=
y works towards an answer that tells us "yep, this may be mapped by multi=
ple sharers" vs. "no, this is definitely not mapped by multiple sharers".=

>
> The "mapped" part of it indicates that this does not catch all cases of=
 sharing. But it should handle most of the cases we care about.
>
>
> There, we can then implement something better than what folio_estimated=
_sharers() currently does:
>
> static inline bool folio_maybe_mapped_shared(folio)
> {
> 	if (likely(!folio_test_large(folio)))
> 		return atomic_read(&folio->_mapcount) > 0;
>
> 	/* Mapped multiple times via PMD? */
> 	if (folio_test_pmd_mappable(folio)
> 		return folio_entire_mapcount() > 1;
>
> 	/*
> 	 * First subpage is mapped multiple times (especially also via
> 	 * PMDs)?
>          */
> 	if (page_mapcount(folio_page(folio, 0) > 1)
> 		return true;
>
> 	/* TODO: also test last subpage? */
> 	=

> 	/* Definitely shared if we're mapping a page multiple times. */
> 	return folio_total_mapcount(folio) > folio_nr_pages(folio);
> }
>
> There are some more things we could optimize for.

Before jumping into the mapcount, I would like to get some clarification
on "sharer". Does it mean a page is mapped/shared by more than one page
table entry or is mapped/shared by more than one process? Your function
indicates it is the former, but for madvise_cold_or_pageout_pte_range(),
I am not sure that is what we want. What if user wants to page out a
page that is mapped by the same process twice? With current method
or any existing proposals, it will fail undesirably. It will only work
as expect with your creator proposal[1].

Other places like auto NUMA migration also use mapcount to check if
a page is mapped by multiple process with the assumption that a page will=

only be mapped by one process once.


[1] https://lore.kernel.org/linux-mm/6cec6f68-248e-63b4-5615-9e0f3f819a0a=
@redhat.com/

--
Best Regards,
Yan, Zi

--=_MailMate_E6DA2779-B820-4542-8AC2-6C252D4A82D8_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmSxXoYPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUKswP/A77iWow5b0NgPNRriZ7pUfREjJOa6PuTvNw
gw4yXCCd57gCzINdpbcGxew0tQrC/h0haDfw9UIWSFiCofu4ET9O+6TJ3yCz4Bdv
Et2zQnwQb8HzbBhu/m9zGaIS0gjMC8t9H2pXx8gaSLez1mNECshI5Ta7nawSWdtK
QIBW0tHv9hXvwbkQjlnyrJprXJL/5i25srWWv9Rl4wcblo4LxmhZNPlAjyZCzCoT
wyuyR0jITEZnRQY/uIBjBUrtar2j1tegb+vvHQXjPYMonYZmIQ1+i+GmF+KaiBD0
WvpPeJu+9nrazf1EybqcVDwKvZu/aBdUevr5qE4Q/n7E6S723tAH6nzo3MI4NagE
1PQ+UZ/xX+ki6oC8PbG2+B7F6KRBFJ8yODr0kuyppiJdxoUw+eHZIFxkNEu43RYw
aG44mkZ84tOcjvDiYImddO1wEXxs2+GlU0NrcUBZSlqTUXQHcNVFAGLHRdWBKuXP
OoYWp8NGqRrlUKnnETvnDmbFjd77cxdI56jZemxed2vN4qZEIuD/3QrTEerQR7D1
s6ikmEeu/MLeINMmmvfnB9QgWziOeb2LG6e/f6GA1nSi1iRDGWsvp3xzQ6ElnhPK
FkNGToTzgTaQVCf9fymCLihKONCMzBwb7lNInL11AGMedMzlSovedEWn1LhT13wl
kfnGJvvt
=ZJdQ
-----END PGP SIGNATURE-----

--=_MailMate_E6DA2779-B820-4542-8AC2-6C252D4A82D8_=--
