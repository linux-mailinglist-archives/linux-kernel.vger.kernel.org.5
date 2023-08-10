Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0262F7781C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbjHJTqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjHJTqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:46:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E36012B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:46:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQOm6O5dLDiMB3KtK7zgfCP1wLk91dUC9bePHxcqjCcd9d+ABSZD5rXhADqY5VF1uQ61Je6PsLio6K3AiTxvpP/3Z942C9vcOCav4RScuzdCZJ1CAJTC81/bzOAMJdrBFo2O39FB7cb80Sp1o0DqGzNYba09Iu2XjKxDQDA+BWIlwK3xwGTb5uB2wDf8yeoZJaRodZJN+i3dJvtc2W9/hevOYPsdJSEdMUsTd7Jmcs6e8jw62ZaNbl0dQhlLgKdmUDd8dJ4ovk7Y02hLxDfRS0cm8VGpGpB/v++GyoAK0G/tAoWaoG98SZ+WSYwaiFV39qhNDEeQO0HmdhPLmRWocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuD/OzmtWUaDphSMH9xeN8B8LCwnTtORPE9Nf7b46Z4=;
 b=c3PgNbCPc81BhEKZCxV+0JdTUb7Oe7R/Oj3jrCkxexJHbTAg74P81jA1PFEVWHucdEu1kmiaRklBA7E4c4cGSKHPPqFQ/UeJLGCwnH0Mdd8DHmlHUKUC6cMBxCvoWA1fJ3BoIfMoHdbz0flzO1TeKfPisE5RZ82PuL4wPbGB3JC0mBhHdHMlAAcZxDCcXMZLoGPh0feqFqFoVXpdNMysVUc6uQiRPLcNB8QoA2ZjUSvqyMBACcR2gHaZ2NMIE1PibDInSne9mXyC8pqnEBFfq2rA2RYD4/AL+sn7dzc/cyWY2hJ/NqyoETxxunqfRTpTrROf1m4cplaL9vQJnbiRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuD/OzmtWUaDphSMH9xeN8B8LCwnTtORPE9Nf7b46Z4=;
 b=NopgOebKp/PdUXIMlXS67kgaCraTL1m/EBQudsie1PAf78M/aTpwnxvJj5m7rPhdywUWVw889W+tvlCjQoHncgKjn+WxKhiivjLCgqFZmIJTbtdqyTy/9IHbocstJGYbF0DfCORpLliP29Ljp73mWdWpymr8pCz+qahPUG2ZBIk2j3n2f2sVgo8WecTOrmbPFRSm+29kFfrWyo5iB3tBO7bVev6Fy3q7k7evdNGkQIraXqrkRoTsp/k4LjujvwDpca644gizL2tSpLElHgB7IZCOzDjFcegxIA4hmByoZ5gJxDH+H6iD+XzbhkOa/co9C7Ub1gVsnl82LSaOZuxAUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 19:46:42 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 19:46:42 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
Date:   Thu, 10 Aug 2023 15:46:39 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <16B84D1E-F234-414E-BA54-5893B6318E57@nvidia.com>
In-Reply-To: <f97446e3-85d8-4d14-9fc0-683b31925325@arm.com>
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
 <20230810142942.3169679-4-ryan.roberts@arm.com>
 <CAOUHufbUGwc2XvZOBmTCzMsOHxP-eLB60EdysKYzrkRMScOyMg@mail.gmail.com>
 <f97446e3-85d8-4d14-9fc0-683b31925325@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_CE1DA73D-40DB-489F-B55B-A006B0273569_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:208:234::10) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|LV3PR12MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 51842869-24f2-40aa-4fbe-08db99da8569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLp7RtAIvovgpbTsB0V9vj70v9BoF5pn5nw638YUGCTStz/kBvM/k5cRGd5cDPCszH62/QFO21BLsV+EeLaWirdbU0QrrL/IRN4Mmk0dEg7TjdSPxr/SEyvAxdnYaEbj4jZ0aEGxWi3VuXaZ5UOJ3xwkGe7YnqbOvqdXXHkSKzQ3HUtsJfz+9EvtasW1ctVWH+EQYxkuyqYrRKx027HYhT43w5+NFULYYLne1vaDa3nesdXvpkVs8KjDLYkAC1TTNnD5iDp/1T+KNEIvA2pZiRRDzWcX3rsQtuqfUT8PG2sfXMu7jr+iv32CYAPT5Hjs591iBNQ/1abDvfih3aoG05segTsJd+Q2oh/if5Rs4DrmpZs2ghSsiOUBlvkDPINqsr2PHdTcef95ArRVn/HSthqcGwHlCwEiN4pYyNInXbe77uw5leZCLss9KkJKwaNg+d6Xo9/ZjUYxPDRM5uYwhSTidUUMT7koMxcoYdajV2ASh82mKHwizFcqcT5oU4iTeKenqRZhfU6yskd7a6GeYPrqvC24snEkcZtN3sIKVOxjuP0il+w92Oby3BDrKVnIDJBf8WcP5kk2OHh1iUxFBqBd8fPjzbcf64W2SmEO7o3ys64/nWg4U30LEGi3/VPf2EAa/yJYsIGgzUniOJPK18FdCPvdrw8bg2ami66c2oljzqxsZt88nT1I8k/2y5lN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199021)(1800799006)(186006)(33964004)(6486002)(966005)(6512007)(86362001)(26005)(53546011)(6506007)(83380400001)(2616005)(36756003)(38100700002)(33656002)(6666004)(2906002)(8676002)(66476007)(66556008)(66946007)(6916009)(4326008)(7416002)(8936002)(316002)(5660300002)(41300700001)(478600001)(235185007)(54906003)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2dCRzV4K2hIQ3dQUHhrMGE1TkxPNk82OXpMY2dSV1VNUGpYZWNKZmphMmFr?=
 =?utf-8?B?QkYweDU0RUQ1S1p5TmdOQ0JZTjFKT2RWVGwxRHVaNzVPVDR2T0lkVUJMNytu?=
 =?utf-8?B?NmkyZEVTUXFZM0pISzZEeHBPYTB6a3diNG9FY2UxREJzV200NWdZTUYwTzBt?=
 =?utf-8?B?T0JEZWJRcFhpR1lveW9TVWdnME9rR09Dd0lxSSsrMkE1cnVkdzNWOVZLa1lE?=
 =?utf-8?B?SkNQZDVFUy9HK2laTVNjcHBsVEVEcDdvRFF2S3BzRXhhRjhVODA1aTRyRS9Y?=
 =?utf-8?B?TkxIa3RZcS9vNndBbEtCZkZvN3M1eTB5a0o0bjVWeEt4V2tSNDVLVUZDVndj?=
 =?utf-8?B?QWhJd1ExY1N3R0lsM1kxdXE2NDlFblhNRGNwMHRQQTdwdUZPQk5xQzgvNVBh?=
 =?utf-8?B?TWx1anVqNTR6S3dxMHNoMXBIUXF1bkRnRVFkNGxQamN5TFB6ampnZ21CTnV3?=
 =?utf-8?B?YWUvQUNDUk1mcXk0dXRlTkZ4bDBBYmpRbkVxSEx0ODd5dU01S2NRbldLKzg4?=
 =?utf-8?B?MHVNNG95RGRkMkpGcmhNbTNlV25rOUd3MUZQZFR3QVh6WWM0THFLYmFSNFJN?=
 =?utf-8?B?WEJaeG05c0tuUkZHcjVJaW0wdmFRbC8zSFhlelhqRmNxRmpycFVldmE4cG5s?=
 =?utf-8?B?QVZFQXhHakpHeU55UmE1VTh2aCtEaUs2ajhpN3Y3MFB1RnhmeU02RUVMdDNj?=
 =?utf-8?B?MG9MTDlPMldFNnNzTFM2bnZWRjlVL2VFdnk4djlQUkxnVERyVWJHUmJGcVY1?=
 =?utf-8?B?WmNKNzRES1QyUHJmSVE2cE10SHlDODBocDJxV3dvRjA5RXZGMFhEeGNxUENG?=
 =?utf-8?B?dlVVc3lwRExOckxyd29ycUJOZmVkTkhGbjc5b01ZVEw3MlB2Z2l6alNpdUx0?=
 =?utf-8?B?M2lTOVVPSkZsV1ZmSmExcld5SkVKZUxTSEQ0d3lIbHFtOXhSZHpSbDZPRjBB?=
 =?utf-8?B?MHphOWcvcEVmTkk2TzM2WGVOUHJCazJXQ1lJWHJlYTEzNzZkNUhRSlZWUis2?=
 =?utf-8?B?SU9TZWY5M3c4L0RXUm9mcUNFTFhMRDdRNEsvdmo1ZVRqc3pkaGZycHB4eUZ4?=
 =?utf-8?B?TEpiNmk5amZkTE8rb1lYa2ZObGtPejFiekx1M1BvS1RJT2t0TmFGb04rMFgy?=
 =?utf-8?B?SzRqODhWWnBpVEJ1TmpoNjE2UFRVcGV2UkpPRkV1a1dZTVhPVG45N0NrN3hO?=
 =?utf-8?B?aVVhaFJUdEZXMnE1T3RPcFhFWXNGRG1ic2NCMHRYMTA5V09FZVdpcE9sN3E3?=
 =?utf-8?B?a21nWkZyTFpaRk1aQzRiY1h6bEpYNzVOOWJkY09vZVQ5RmhLc3k3VnM1cTZI?=
 =?utf-8?B?aVpqZVh1QWsyeUY5cXBIVkFwVzA2RGNKdnptL293VS9nRmpSNzJ1MUt1MjVU?=
 =?utf-8?B?cm1OYUllZlJ4Q0h0WXQ3QURreE9PeTh2NGJuWFdxQ0ljdmlMTnM1M1paallY?=
 =?utf-8?B?NnVkT29nNG5vYTVPRGx3N0ZxUys5N0xaaVV3eVN6VmUxSUtRZm54N041b2RZ?=
 =?utf-8?B?ZTE0R1UwbUozdXMrYm51cVc0YVNoYnhFS2tHelE5cE8yR1lva2FNYW9jOUZM?=
 =?utf-8?B?ekdPaVVRdjZHbzFlOWxXSktUSlFuZWUvenp5eFg3U1dneUZNc2phTDQ2djVv?=
 =?utf-8?B?M1JiM2RpRGxSOHRxSy94elhmNWxkYnJoSkhnZG45eGszV1pXNmNwL1pseDFC?=
 =?utf-8?B?Z1FFSTIzNUhaQkZNWjhicThFNG53SFlWbjlRdTRYN2ExcC9yYWJhUEtlaFNE?=
 =?utf-8?B?bERFM2hqK3dudEVEbmZJQmkxakV2bktHbFh3THQzZDdUMFZ4UlhKSEdDRGQ1?=
 =?utf-8?B?ZDVic3ZiYWdCRFVpZytRd0pEbW5zT0hCdW5YcTR0MWVwSjRtdk92SDhqSFYr?=
 =?utf-8?B?SzNXZlJiaHByOWNIV1hHc3NnckZleTJyZS8yTnVaNkxCaHF2d2JYMDhRSzIx?=
 =?utf-8?B?Y09zU3dhVURsM1JOUjF6NHZ0S0J0OFNBYnlxbS9JZHdMdFQ1OVdvbEtXL0Y4?=
 =?utf-8?B?L0dBUXJ6cUJFcFBmWWlGdVdvTCs0dDhSaXpvUS82ZG9Sa2NNREJZUkN6bU9l?=
 =?utf-8?B?QmZZdk9adUFUZ1ZYeTFKWk1nK2hhYUxRMnJ3Rm05dXVkVStmb1E1MG9vUy9F?=
 =?utf-8?Q?zRclQ1f9JEpyEAxsOTQCoMCuA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51842869-24f2-40aa-4fbe-08db99da8569
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 19:46:42.5231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ladgx41P/BMv1cMqaoBcOzAtWl+QLUmeAdpPPEFDMWaKTWVyoDqUgzGFxREQja9M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_CE1DA73D-40DB-489F-B55B-A006B0273569_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10 Aug 2023, at 15:12, Ryan Roberts wrote:

> On 10/08/2023 18:01, Yu Zhao wrote:
>> On Thu, Aug 10, 2023 at 8:30=E2=80=AFAM Ryan Roberts <ryan.roberts@arm=
=2Ecom> wrote:
>>>
>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to =
be
>>> allocated in large folios of a determined order. All pages of the lar=
ge
>>> folio are pte-mapped during the same page fault, significantly reduci=
ng
>>> the number of page faults. The number of per-page operations (e.g. re=
f
>>> counting, rmap management lru list management) are also significantly=

>>> reduced since those ops now become per-folio.
>>>
>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>> which defaults to disabled for now; The long term aim is for this to
>>> defaut to enabled, but there are some risks around internal
>>> fragmentation that need to be better understood first.
>>>
>>> Large anonymous folio (LAF) allocation is integrated with the existin=
g
>>> (PMD-order) THP and single (S) page allocation according to this poli=
cy,
>>> where fallback (>) is performed for various reasons, such as the
>>> proposed folio order not fitting within the bounds of the VMA, etc:
>>>
>>>                 | prctl=3Ddis | prctl=3Dena   | prctl=3Dena     | prc=
tl=3Dena
>>>                 | sysfs=3DX   | sysfs=3Dnever | sysfs=3Dmadvise | sys=
fs=3Dalways
>>> ----------------|-----------|-------------|---------------|----------=
---
>>> no hint         | S         | LAF>S       | LAF>S         | THP>LAF>S=

>>> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF>S=

>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>>>
>>> This approach ensures that we don't violate existing hints to only
>>> allocate single pages - this is required for QEMU's VM live migration=

>>> implementation to work correctly - while allowing us to use LAF
>>> independently of THP (when sysfs=3Dnever). This makes wide scale
>>> performance characterization simpler, while avoiding exposing any new=

>>> ABI to user space.
>>>
>>> When using LAF for allocation, the folio order is determined as follo=
ws:
>>> The return value of arch_wants_pte_order() is used. For vmas that hav=
e
>>> not explicitly opted-in to use transparent hugepages (e.g. where
>>> sysfs=3Dmadvise and the vma does not have MADV_HUGEPAGE or sysfs=3Dne=
ver),
>>> then arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whicheve=
r
>>> is bigger). This allows for a performance boost without requiring any=

>>> explicit opt-in from the workload while limitting internal
>>> fragmentation.
>>>
>>> If the preferred order can't be used (e.g. because the folio would
>>> breach the bounds of the vma, or because ptes in the region are alrea=
dy
>>> mapped) then we fall back to a suitable lower order; first
>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>
>>> arch_wants_pte_order() can be overridden by the architecture if desir=
ed.
>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contigu=
ous
>>> set of ptes map physically contigious, naturally aligned memory, so t=
his
>>> mechanism allows the architecture to optimize as required.
>>>
>>> Here we add the default implementation of arch_wants_pte_order(), use=
d
>>> when the architecture does not define it, which returns -1, implying
>>> that the HW has no preference. In this case, mm will choose it's own
>>> default order.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  include/linux/pgtable.h |  13 ++++
>>>  mm/Kconfig              |  10 +++
>>>  mm/memory.c             | 144 +++++++++++++++++++++++++++++++++++++-=
--
>>>  3 files changed, 158 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index 222a33b9600d..4b488cc66ddc 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -369,6 +369,19 @@ static inline bool arch_has_hw_pte_young(void)
>>>  }
>>>  #endif
>>>
>>> +#ifndef arch_wants_pte_order
>>> +/*
>>> + * Returns preferred folio order for pte-mapped memory. Must be in r=
ange [0,
>>> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires =
large folios
>>> + * to be at least order-2. Negative value implies that the HW has no=
 preference
>>> + * and mm will choose it's own default order.
>>> + */
>>> +static inline int arch_wants_pte_order(void)
>>> +{
>>> +       return -1;
>>> +}
>>> +#endif
>>> +
>>>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>                                        unsigned long address,
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 721dc88423c7..a1e28b8ddc24 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -1243,4 +1243,14 @@ config LOCK_MM_AND_FIND_VMA
>>>
>>>  source "mm/damon/Kconfig"
>>>
>>> +config LARGE_ANON_FOLIO
>>> +       bool "Allocate large folios for anonymous memory"
>>> +       depends on TRANSPARENT_HUGEPAGE
>>> +       default n
>>> +       help
>>> +         Use large (bigger than order-0) folios to back anonymous me=
mory where
>>> +         possible, even for pte-mapped memory. This reduces the numb=
er of page
>>> +         faults, as well as other per-page overheads to improve perf=
ormance for
>>> +         many workloads.
>>> +
>>>  endmenu
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index d003076b218d..bbc7d4ce84f7 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4073,6 +4073,123 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)=

>>>         return ret;
>>>  }
>>>
>>> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages=
)
>>> +{
>>> +       int i;
>>> +
>>> +       if (nr_pages =3D=3D 1)
>>> +               return vmf_pte_changed(vmf);
>>> +
>>> +       for (i =3D 0; i < nr_pages; i++) {
>>> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
>>> +                       return true;
>>> +       }
>>> +
>>> +       return false;
>>> +}
>>> +
>>> +#ifdef CONFIG_LARGE_ANON_FOLIO
>>> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
>>> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAG=
E_SHIFT)
>>> +
>>> +static int anon_folio_order(struct vm_area_struct *vma)
>>> +{
>>> +       int order;
>>> +
>>> +       /*
>>> +        * If the vma is eligible for thp, allocate a large folio of =
the size
>>> +        * preferred by the arch. Or if the arch requested a very sma=
ll size or
>>> +        * didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER, w=
hich still
>>> +        * meets the arch's requirements but means we still take adva=
ntage of SW
>>> +        * optimizations (e.g. fewer page faults).
>>> +        *
>>> +        * If the vma isn't eligible for thp, take the arch-preferred=
 size and
>>> +        * limit it to ANON_FOLIO_MAX_ORDER_UNHINTED. This ensures wo=
rkloads
>>> +        * that have not explicitly opted-in take benefit while cappi=
ng the
>>> +        * potential for internal fragmentation.
>>> +        */
>>> +
>>> +       order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER=
);
>>> +
>>> +       if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true=
))
>>> +               order =3D min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
>>> +
>>> +       return order;
>>> +}
>>
>> I don't understand why we still want to keep ANON_FOLIO_MAX_ORDER_UNHI=
NTED.
>> 1. It's not used, since no archs at the moment implement
>> arch_wants_pte_order() that returns >64KB.
>> 2. As far as I know, there is no plan for any arch to do so.
>
> My rationale is that arm64 is planning to use this for contpte mapping =
2MB
> blocks for 16K and 64K kernels. But I think we will all agree that allo=
wing 2MB
> blocks without the proper THP hinting is a bad plan.
>
> As I see it, arches could add their own arch_wants_pte_order() at any t=
ime, and
> just because the HW has a preference, doesn't mean the SW shouldn't get=
 a say.
> Its a negotiation between HW and SW for the LAF order, embodied in this=
 policy.
>
>> 3. Again, it seems to me the rationale behind
>> ANON_FOLIO_MAX_ORDER_UNHINTED isn't convincing at all.
>>
>> Can we introduce ANON_FOLIO_MAX_ORDER_UNHINTED  if/when needed please?=

>>
>> Also you made arch_wants_pte_order() return -1, and I acknowledged [1]=
:
>>   Thanks: -1 actually is better than 0 (what I suggested) for the
>>   obvious reason.
>>
>> I thought we were on the same page, i.e., the "obvious reason" is that=

>> h/w might prefer 0. But here you are not respecting 0. But then why
>> -1?
>
> I agree that the "obvious reason" is that HW might prefer order-0. But =
the
> performance wins don't come solely from the HW. Batching up page faults=
 is a big
> win for SW even if the HW doesn't benefit. So I think it is important t=
hat a HW
> preference of order-0 is possible to express through this API. But that=
 doesn't
> mean that we don't listen to SW's preferences either.
>
> I would really rather leave it in; As I've mentioned in the past, we ha=
ve a
> partner who is actively keen to take advantage of 2MB blocks with 64K k=
ernel and
> this is the mechanism that means we don't dole out those 2MB blocks unl=
ess
> explicitly opted-in.
>
> I'm going to be out on holiday for a couple of weeks, so we might have =
to wait
> until I'm back to conclude on this, if you still take issue with the ju=
stification.

=46rom my understanding (correct me if I am wrong), Yu seems to want orde=
r-0 to be
the default order even if LAF is enabled. But that does not make sense to=
 me, since
if LAF is configured to be enabled (it is disabled by default now), user =
(and distros)
must think LAF is giving benefit. Otherwise, they will just disable LAF a=
t compilation
time or by using prctl. Enabling LAF and using order-0 as the default ord=
er makes
most of LAF code not used.

Also arch_wants_pte_order() might need a better name like
arch_wants_large_folio_order(). Since current name sounds like the specif=
ied order
is wanted by HW in a general setting, but it is not. It is an order HW wa=
nts
when LAF is enabled. That might cause some confusion.

>>
>> [1] https://lore.kernel.org/linux-mm/CAOUHufZ7HJZW8Srwatyudf=3DFbwTGQt=
yq4DyL2SHwSg37N_Bo_A@mail.gmail.com/


--
Best Regards,
Yan, Zi

--=_MailMate_CE1DA73D-40DB-489F-B55B-A006B0273569_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTVPp8PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUVYYP+wdb/yVzOth5/kFiGYNsoxjyTWvUnNFkz/rt
5jMbF6xJivX6B2iFr/Sr8h3/hnI+RLDsykufrLik3SQaDyQmT0b88HgXntwMo7pI
I0gXdEBZrPqsxVcj1PM3qvmgcgJY27V0J6RHKQRuKG/nEXzfQav4XQRlU5wBl08C
QqaQaw5VaoAXR6b1qB363z9CHtNYZHwCiwji+fphWe5wwPSN5/HvCYizw40WsufG
EI2esxYyUQpMNQZr57+dnHkxUxOXlXFFY231rvVaDJ86w5NBKPYOmJDWo8cYPmEO
43DUsmGfrUVsS7OpfiLaf2/EXuAM3hri7vcyhOAX6RDGWjFb2xgOX7X5kP+e6tLM
vEr6j1JTRd36voKJRoh85JwIvV7743Gp/MBzHGty4bOQvNpPfwdN4DdlFi8fRsCD
/+G/dKwpikMPxK4Ciq5eYhQkyPoPXJURtEQGJ1DMh5LH7hvHNBsBk4xW+V3q/uVC
j6oC4ZqZiYmO4/JzZTx+CTAD1VVCtNa0ZrTuyoWl66Cf+/3mUXIKJ+TKvtMl+J72
iZsUt13GId0GglHvrdnvmxcO90AtxGo9vRwGjmxz7+4nLA+h43T4fy7T0BkeQh5S
UwlMFk9yeu3jX1qEvnVRddZrPS5nLHMYp0C4XPoB+xGbI/dkCTOynAFX/K65hFau
+MOmWL5m
=V2DZ
-----END PGP SIGNATURE-----

--=_MailMate_CE1DA73D-40DB-489F-B55B-A006B0273569_=--
