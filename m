Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3FD777B77
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjHJO77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjHJO75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:59:57 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A9626B5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:59:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0W+oZWhGZUz3qyvVQ2Up0CW2DJzQ9ttlUBJlesCX1R/aRNszA22IPsowJ57Z/jxhGA/s+NHeCFmTBngFz3XVA6e+jzUR37ld2XHNVDLYNtyBJxKEPva9GelaI7pM4A4zqVDhYYFJUDeglIb4U8nCmpsBWs2zpw6F5TxhwZqEsALXhzZReqKl0VvXxojPlDnl0Acw6A2EAKv3f3pX8SfFRglV9/BRg2Rrni55FdoBlD+7n+Psrru2bDIO+QkFBNFo8164KawhAOzuH71d5VnVfW1jkIugSDoXBrm0mbttIReJByQaToQ/Mpc7qjWRPXp8j7aHh3d6IJKf8tMt0PocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gItAQpi2XoapnBobebnyWHyQvTy5GpeH7m2kj9kqBkM=;
 b=f0SVoEQa/jDKvLyL4Co3RKgbGrDSor1DxhmHmNIgifSmAeiAzG1+hLZbVZ5S/YGdTTTrzJBmIz39s7ze42VOUSrcnJRV1mqSjGAb9xMNSUs2M6rx2inwgBHmDWPpI7lXYjnXsmzTl+rlAzf8BFBr2GmVXIuZtFaIFt1gPXd2kAqrqFIdVukLiwyQLuaXtN6LAR9taaIgYcFtiAA9cAovRq2erNXs3bNYwYKewirvMvlsYDLVU6RoRaIhk/J2Wju2uLBL1QJXpDxMOHJm9AqIMFAN3iPfa5bOQcDUvyJaqDjC18JPkTE4yrt7fA8ffNtoCjGkBkXtkRBw8lNLXz/mdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gItAQpi2XoapnBobebnyWHyQvTy5GpeH7m2kj9kqBkM=;
 b=sWZm/CHigW64aKYDnkRQAqCOm9DwNLWjRcasBs2/FkigwrTugsiczrN3Vuv/iNgU9EIJ0FZBjKQ1SOshQP7aK++NrUCRpZMS8Fmb9OjHbAXIjSetZv75D+zRG+0NP4xVt1Y0BXok36MX9ju7fqDgae/ygzWnNSlQlVQGt2fMsZgdzl/dns1fV9G1kYU26UroTcgLHNVcpFq6Trx4NwaeTSuKIcZtMYzqAw+V0rl0qjtMdoz7GgrRO9c9es8ftm1SGSdL7+Fmg1BUvYsqCRPJ0BDXJnU3DCIyeaAcrFRXv4jj+lX+/06OHT+l05GxmAZQxy+jDWiKulmVQm5U/c+i9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Thu, 10 Aug 2023 14:59:52 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::c166:b535:d93:641e%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 14:59:51 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/4] mm/mmu_gather: Store and process pages in contig
 ranges
Date:   Thu, 10 Aug 2023 10:59:49 -0400
X-Mailer: MailMate (1.14r5964)
Message-ID: <90EC4C0D-0254-4B93-AFD5-3C09580A77DE@nvidia.com>
In-Reply-To: <1a0f5cb8-421c-4f28-a986-f3c381406e81@arm.com>
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
 <20230810103332.3062143-5-ryan.roberts@arm.com>
 <800937DA-BAD0-4C60-B155-AECCA21E955E@nvidia.com>
 <1a0f5cb8-421c-4f28-a986-f3c381406e81@arm.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B94567D7-43E6-44D5-9537-DADDCD6E3ED0_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:208:23a::25) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a646b67-18fb-4c25-0c8c-08db99b27307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jjWc2rgOFTjoDDndWIVXdzY3dYPm+WggFqCyEFYusu07u4nabF3D0eipjqRSW1LTvfM8yH1capdXQE26CuKL4IpN6h6IQjpGBqoV69UGDUh0XSQcWOr/08uUc6CEfeTaN6JqlvbobyWUqr2HmffEMREWlPkpaxpniQbuBGlLQqEN23rBpwIN97UJ74mFxABA+yiiwdoXJyZmfOkn0BegYu3qOhDXq9bVsVWaHCs3ayiO/YmZUKMi1aPzJTYf5UrV6Aynhn9lwVl9dtohdSiApOAlmtJ3YQOWNY0aRJ155TyNUMA30G49bMGXxwW3GlhpsrUuNFdhAE0jHqhZSs6j6IFYTInT54fxi16m1pLWryaxZYc1dggdvHYK40/IoMob9ynUtA2fPs4YxLJ7g3jdu78hLUP5u0FnoXHbwNKyCLQ1dtW2LD8mCeAPwv5sRvCt9GzJ45SszXDHpo1d7Ec3d1IZkYz0j3d526qBr81WB7Amh2Jmz177G95WW2E4LLCBdxPLsAiffAE46H4SNi6y1tv1tIBNnqY0H26eO1aeibnbnKR4KkAhzX8pcyk/E2d84Oc+cUfp8j/BIgoRZR7QS0eiX2eoTwrRzgvHE9m7DRyKXMAaK62v1S+Jm/bt79iTbhqwhdLK8zHHe7JQ0V/dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(186006)(1800799006)(6486002)(2616005)(86362001)(36756003)(53546011)(26005)(6506007)(6512007)(33656002)(7416002)(5660300002)(235185007)(38100700002)(54906003)(66946007)(66476007)(6916009)(4326008)(66556008)(316002)(478600001)(2906002)(30864003)(83380400001)(41300700001)(8676002)(8936002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1FDZhouioNInzKYXTJG/ZoyKTgCuTrllXoqgnRE+ouhEWYeAOgJY08eeoeR0?=
 =?us-ascii?Q?Gb9ReFf4tMlpMdgkW5uhqwtOy/zH0URLDofpUKWwzjZ7XkvwLAeLzRjP5QmZ?=
 =?us-ascii?Q?UaGAP02XZIEAa2F5AUETDroff4Dm77cxY+taLJyFG/FWA4rQhIxyzoYdbaj5?=
 =?us-ascii?Q?eDSQEuRiDjRmbH252Ou+8OZHHIJDr6KAaBxHQupAA8dqkrBoiAY2ArMTbIlg?=
 =?us-ascii?Q?xLjaftxrlxM7GCK/E5Xx6/j+Qv4H4ts/aaNCa8ZGodNSgbULO+UmsgTwC7QB?=
 =?us-ascii?Q?mwfrGwmAqKNNIXbtz5GvIpU/lTqOa4vywyMGUFb8wu/N8xJ1YacDbedaCADT?=
 =?us-ascii?Q?m5/F8ReOZLymMq2GN5nRCKpRf58JkLXhebNZxeyDYMfswsrHVy2DFoz0co04?=
 =?us-ascii?Q?rixUrnahAFhTOTDNhfrIk20YDOyqJEmOTJG6AdWPh/f9P/JzCtF9iSwqUsSt?=
 =?us-ascii?Q?9HpO/kj3h71dEXZYEv2FNaVnNattF1yQsA6kkAkgw7EfhmBoE4QygkqdS+Kg?=
 =?us-ascii?Q?neyBRC8QiQuvzWmTFLuuGzCNkkiuhgvOqQO5lhX4hm4EZM6r1GeZoTOzSBxw?=
 =?us-ascii?Q?/Zz3qLpZKvITkPbP5ppmH30iaVSz27cQ4F0TRqjrCQEuM3HOwB+rh5oDT0OK?=
 =?us-ascii?Q?KnXMQVUCn6zr2zzT10CNfDN01nwK0kZHb14d6wF8e/UzwTaRIzUt49ymcm76?=
 =?us-ascii?Q?Jl12rvGtqdqweMOavs+vIerM1qOHo7swEPm2R7ArB6XhnUbpBktwLZJM1DJV?=
 =?us-ascii?Q?YW1RdyRGviAhpAQoNeNL+zbH/tQkrJ87xYnSIk2pWttt/Rcs8cTlpgsEV3dc?=
 =?us-ascii?Q?ah4cIDBe3b0F1LYy1DcEdsV91ljXMQgJRZrQSLwajFIOR8Qzhp9Mqh9U5G4y?=
 =?us-ascii?Q?YqOPuI/nmO4KDzW4GUwlP8X3mrHM8nWnp5vZS2H1MZ9Hlx1A4teFn+R+0sga?=
 =?us-ascii?Q?2s8Rob7/euZ3v++5Sj0cCxLD2nTt2dag+mDK7S8zksyQaz0Qzj9fK2+rZvx7?=
 =?us-ascii?Q?W7vv5CvhIQbs/kd1MyNGezfxLfPiNryxFQ1KIR2iQt1kkKpnHNsfSpyjAicV?=
 =?us-ascii?Q?U+S1sODJAHFzC7x6WzsvzIma5qyU7E1WRqmhABLQzAhlphBXczYb98o66ABA?=
 =?us-ascii?Q?U+9doJi0g+ZIMXW9Dvp4p0jQx13+slnWmyywK3Izw8uWmiftZoS1c+0k/CuB?=
 =?us-ascii?Q?YwN6GqmIBrLVk7Zo4yFy1qLRhdWB/b9C3ZJcslLqxfXy6LrVuRpLkXJgs9qR?=
 =?us-ascii?Q?e1/4nYeIz4wMNO+HRMuSarAyui0YT4Q/pHB2mAXaMZzbgSVj9AApzoVeaixc?=
 =?us-ascii?Q?dUqO2kRAG4Eg9709p79oCZjw4YPDF8zrJWGBuSVSr8/ry75gn23lSka//y8U?=
 =?us-ascii?Q?v8GJF0ac7/1lM9O8/Gs7CuNZN/MEtRIuKvpcPLbfT8btOq+MVve1us/Bi2ng?=
 =?us-ascii?Q?rt03Bf2cLuPJPurQkTQrc1atpN1xHQyO8Qwwo+SokR6kFjrKKQmLDzx0Uk/M?=
 =?us-ascii?Q?ocnHz1XLIn4FrbXmAPn0NT2v20VGwUUDNtcnhHKbtke7xrEtpsNf0Qpjds/A?=
 =?us-ascii?Q?CRRjuMomVrpgfUIo5l4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a646b67-18fb-4c25-0c8c-08db99b27307
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 14:59:51.7780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKrh6+78ypvpQZ/UGeMPMgLea0FDhMfFNECnVPAx+1lLC/HI/5/7Eys3GPqMK96n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_B94567D7-43E6-44D5-9537-DADDCD6E3ED0_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 10 Aug 2023, at 10:55, Ryan Roberts wrote:

> On 10/08/2023 15:44, Zi Yan wrote:
>> On 10 Aug 2023, at 6:33, Ryan Roberts wrote:
>>
>>> mmu_gather accumulates a set of pages into a buffer for later rmap
>>> removal and freeing. Page pointers were previously stored in a "linke=
d
>>> list of arrays", then at flush time, each page in the buffer was remo=
ved
>>> from the rmap, removed from the swapcache and its refcount was
>>> decremented; if the refcount reached 0, then it was freed.
>>>
>>> With increasing numbers of large folios (or at least contiguous parts=
 of
>>> large folios) mapped into userspace processes (pagecache pages for
>>> supporting filesystems currently, but in future also large anonymous
>>> folios), we can measurably improve performance of process teardown:
>>>
>>> - For rmap removal, we can batch-remove a range of pages belonging to=

>>>   the same folio with folio_remove_rmap_range(), which is more effici=
ent
>>>   because atomics can be manipulated just once per range. In the comm=
on
>>>   case, it also allows us to elide adding the (anon) folio to the
>>>   deferred split queue, only to remove it a bit later, once all pages=
 of
>>>   the folio have been removed fro mthe rmap.
>>>
>>> - For swapcache removal, we only need to check and remove the folio f=
rom
>>>   the swap cache once, rather than trying for each individual page.
>>>
>>> - For page release, we can batch-decrement the refcount for each page=
 in
>>>   the folio and free it if it hits zero.
>>>
>>> Change the page pointer storage format within the mmu_gather batch
>>> structure to store "folio_range"s; a [start, end) page pointer pair.
>>> This allows us to run length encode a contiguous range of pages that =
all
>>> belong to the same folio. This likely allows us to improve cache
>>> locality a bit. But it also gives us a convenient format for
>>> implementing the above 3 optimizations.
>>>
>>> Of course if running on a system that does not extensively use large
>>> pte-mapped folios, then the RLE approach uses twice as much memory,
>>> because each range is 1 page long and uses 2 pointers. But performanc=
e
>>> measurements show no impact in terms of performance.
>>>
>>> Macro Performance Results
>>> -------------------------
>>>
>>> Test: Timed kernel compilation on Ampere Altra (arm64), 80 jobs
>>> Configs: Comparing with and without large anon folios
>>>
>>> Without large anon folios:
>>> | kernel           |   real-time |   kern-time |   user-time |
>>> |:-----------------|------------:|------------:|------------:|
>>> | baseline-laf-off |        0.0% |        0.0% |        0.0% |
>>> | mmugather-range  |       -0.3% |       -0.3% |        0.1% |
>>>
>>> With large anon folios (order-3):
>>> | kernel           |   real-time |   kern-time |   user-time |
>>> |:-----------------|------------:|------------:|------------:|
>>> | baseline-laf-on  |        0.0% |        0.0% |        0.0% |
>>> | mmugather-range  |       -0.7% |       -3.9% |       -0.1% |
>>>
>>> Test: Timed kernel compilation in VM on Apple M2 MacBook Pro, 8 jobs
>>> Configs: Comparing with and without large anon folios
>>>
>>> Without large anon folios:
>>> | kernel           |   real-time |   kern-time |   user-time |
>>> |:-----------------|------------:|------------:|------------:|
>>> | baseline-laf-off |        0.0% |        0.0% |        0.0% |
>>> | mmugather-range  |       -0.9% |       -2.9% |       -0.6% |
>>>
>>> With large anon folios (order-3):
>>> | kernel           |   real-time |   kern-time |   user-time |
>>> |:-----------------|------------:|------------:|------------:|
>>> | baseline-laf-on  |        0.0% |        0.0% |        0.0% |
>>> | mmugather-range  |       -0.4% |       -3.7% |       -0.2% |
>>>
>>> Micro Performance Results
>>> -------------------------
>>>
>>> Flame graphs for kernel compilation on Ampere Altra show reduction in=

>>> cycles consumed by __arm64_sys_exit_group syscall:
>>>
>>>     Without large anon folios: -2%
>>>     With large anon folios:    -26%
>>>
>>> For the large anon folios case, it also shows a big difference in cos=
t
>>> of rmap removal:
>>>
>>>    baseline: cycles in page_remove_rmap(): 24.7B
>>>    mmugather-range: cycles in folio_remove_rmap_range(): 5.5B
>>>
>>> Furthermore, the baseline shows 5.2B cycles used by
>>> deferred_split_folio() which has completely disappeared after
>>> applying this series.
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>  include/asm-generic/tlb.h |  7 +--
>>>  include/linux/mm.h        |  7 +++
>>>  include/linux/swap.h      |  6 +--
>>>  mm/mmu_gather.c           | 56 ++++++++++++++++++++----
>>>  mm/swap.c                 | 91 +++++++++++++++++++++++++++++++++++++=
++
>>>  mm/swap_state.c           | 11 ++---
>>>  6 files changed, 158 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>>> index d874415aaa33..fe300a64e59d 100644
>>> --- a/include/asm-generic/tlb.h
>>> +++ b/include/asm-generic/tlb.h
>>> @@ -246,11 +246,11 @@ struct mmu_gather_batch {
>>>  	struct mmu_gather_batch	*next;
>>>  	unsigned int		nr;
>>>  	unsigned int		max;
>>> -	struct page		*pages[];
>>> +	struct folio_range	ranges[];
>>>  };
>>>
>>>  #define MAX_GATHER_BATCH	\
>>> -	((PAGE_SIZE - sizeof(struct mmu_gather_batch)) / sizeof(void *))
>>> +	((PAGE_SIZE - sizeof(struct mmu_gather_batch)) / sizeof(struct foli=
o_range))
>>>
>>>  /*
>>>   * Limit the maximum number of mmu_gather batches to reduce a risk o=
f soft
>>> @@ -342,7 +342,8 @@ struct mmu_gather {
>>>  #ifndef CONFIG_MMU_GATHER_NO_GATHER
>>>  	struct mmu_gather_batch *active;
>>>  	struct mmu_gather_batch	local;
>>> -	struct page		*__pages[MMU_GATHER_BUNDLE];
>>> +	struct folio_range	__ranges[MMU_GATHER_BUNDLE];
>>> +	struct page		*range_limit;
>>>  	struct mmu_gather_batch *rmap_pend;
>>>  	unsigned int		rmap_pend_first;
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 914e08185272..f86c905a065d 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -1513,6 +1513,13 @@ static inline void folio_put_refs(struct folio=
 *folio, int refs)
>>>  		__folio_put(folio);
>>>  }
>>>
>>> +struct folio_range {
>>> +	struct page *start;
>>> +	struct page *end;
>>> +};
>>
>> I see end is used for calculating nr_pages multiple times below. Maybe=
 just
>> use nr_pages instead of end here.
>
> But then I'd need to calculate end (=3D start + nr_pages) every time
> __tlb_remove_page() is called to figure out if the page being removed i=
s the
> next contiguous page in the current range. __tlb_remove_page() gets cal=
led for
> every page, but the current way I do it, I only calculate nr_pages once=
 per
> range. So I think my way is more efficient?
>
>>
>> Also, struct page (memmap) might not be always contiguous, using struc=
t page
>> points to represent folio range might not give the result you want.
>> See nth_page() and folio_page_idx() in include/linux/mm.h.
>
> Is that true for pages within the same folio too? Or are all pages in a=
 folio
> guarranteed contiguous? Perhaps I'm better off using pfn?

folio_page_idx() says not all pages in a folio is guaranteed to be contig=
uous.
PFN might be a better choice.

>
>>
>>> +
>>> +void folios_put_refs(struct folio_range *folios, int nr);
>>> +
>>>  /*
>>>   * union release_pages_arg - an array of pages or folios
>>>   *
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index f199df803b33..06a7cf3ad6c9 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -453,7 +453,7 @@ static inline unsigned long total_swapcache_pages=
(void)
>>>
>>>  extern void free_swap_cache(struct page *page);
>>>  extern void free_page_and_swap_cache(struct page *);
>>> -extern void free_pages_and_swap_cache(struct page **, int);
>>> +extern void free_folios_and_swap_cache(struct folio_range *, int);
>>>  /* linux/mm/swapfile.c */
>>>  extern atomic_long_t nr_swap_pages;
>>>  extern long total_swap_pages;
>>> @@ -530,8 +530,8 @@ static inline void put_swap_device(struct swap_in=
fo_struct *si)
>>>   * so leave put_page and release_pages undeclared... */
>>>  #define free_page_and_swap_cache(page) \
>>>  	put_page(page)
>>> -#define free_pages_and_swap_cache(pages, nr) \
>>> -	release_pages((pages), (nr));
>>> +#define free_folios_and_swap_cache(folios, nr) \
>>> +	folios_put_refs((folios), (nr))
>>>
>>>  /* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=3D0 *=
/
>>>  #define free_swap_and_cache(e) is_pfn_swap_entry(e)
>>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>>> index 5d100ac85e21..fd2ea7577817 100644
>>> --- a/mm/mmu_gather.c
>>> +++ b/mm/mmu_gather.c
>>> @@ -22,6 +22,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>>>  	batch =3D tlb->active;
>>>  	if (batch->next) {
>>>  		tlb->active =3D batch->next;
>>> +		tlb->range_limit =3D NULL;
>>>  		return true;
>>>  	}
>>>
>>> @@ -39,6 +40,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>>>
>>>  	tlb->active->next =3D batch;
>>>  	tlb->active =3D batch;
>>> +	tlb->range_limit =3D NULL;
>>>
>>>  	return true;
>>>  }
>>> @@ -49,9 +51,11 @@ static void tlb_flush_rmap_batch(struct mmu_gather=
_batch *batch,
>>>  				 struct vm_area_struct *vma)
>>>  {
>>>  	for (int i =3D first; i < batch->nr; i++) {
>>> -		struct page *page =3D batch->pages[i];
>>> +		struct folio_range *range =3D &batch->ranges[i];
>>> +		int nr =3D range->end - range->start;
>>> +		struct folio *folio =3D page_folio(range->start);
>>>
>>> -		page_remove_rmap(page, vma, false);
>>> +		folio_remove_rmap_range(folio, range->start, nr, vma);
>>>  	}
>>>  }
>>>
>>> @@ -75,6 +79,11 @@ void tlb_flush_rmaps(struct mmu_gather *tlb, struc=
t vm_area_struct *vma)
>>>  	for (batch =3D batch->next; batch && batch->nr; batch =3D batch->ne=
xt)
>>>  		tlb_flush_rmap_batch(batch, 0, vma);
>>>
>>> +	/*
>>> +	 * Move to the next range on next page insertion to prevent any fut=
ure
>>> +	 * pages from being accumulated into the range we just did the rmap=
 for.
>>> +	 */
>>> +	tlb->range_limit =3D NULL;
>>>  	tlb_discard_rmaps(tlb);
>>>  }
>>>
>>> @@ -94,7 +103,7 @@ static void tlb_batch_pages_flush(struct mmu_gathe=
r *tlb)
>>>  	struct mmu_gather_batch *batch;
>>>
>>>  	for (batch =3D &tlb->local; batch && batch->nr; batch =3D batch->ne=
xt) {
>>> -		struct page **pages =3D batch->pages;
>>> +		struct folio_range *ranges =3D batch->ranges;
>>>
>>>  		do {
>>>  			/*
>>> @@ -102,14 +111,15 @@ static void tlb_batch_pages_flush(struct mmu_ga=
ther *tlb)
>>>  			 */
>>>  			unsigned int nr =3D min(512U, batch->nr);
>>>
>>> -			free_pages_and_swap_cache(pages, nr);
>>> -			pages +=3D nr;
>>> +			free_folios_and_swap_cache(ranges, nr);
>>> +			ranges +=3D nr;
>>>  			batch->nr -=3D nr;
>>>
>>>  			cond_resched();
>>>  		} while (batch->nr);
>>>  	}
>>>  	tlb->active =3D &tlb->local;
>>> +	tlb->range_limit =3D NULL;
>>>  	tlb_discard_rmaps(tlb);
>>>  }
>>>
>>> @@ -127,6 +137,7 @@ static void tlb_batch_list_free(struct mmu_gather=
 *tlb)
>>>  bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *pag=
e, int page_size)
>>>  {
>>>  	struct mmu_gather_batch *batch;
>>> +	struct folio_range *range;
>>>
>>>  	VM_BUG_ON(!tlb->end);
>>>
>>> @@ -135,11 +146,37 @@ bool __tlb_remove_page_size(struct mmu_gather *=
tlb, struct page *page, int page_
>>>  #endif
>>>
>>>  	batch =3D tlb->active;
>>> +	range =3D &batch->ranges[batch->nr - 1];
>>> +
>>> +	/*
>>> +	 * If there is a range being accumulated, add the page to the range=
 if
>>> +	 * its contiguous, else start the next range. range_limit is always=
 NULL
>>> +	 * when nr is 0, which protects the batch->ranges[-1] case.
>>> +	 */
>>> +	if (tlb->range_limit && page =3D=3D range->end) {
>>> +		range->end++;
>>> +	} else {
>>> +		struct folio *folio =3D page_folio(page);
>>> +
>>> +		range =3D &batch->ranges[batch->nr++];
>>> +		range->start =3D page;
>>> +		range->end =3D page + 1;
>>> +
>>> +		tlb->range_limit =3D &folio->page + folio_nr_pages(folio);
>>> +	}
>>> +
>>> +	/*
>>> +	 * If we have reached the end of the folio, move to the next range =
when
>>> +	 * we add the next page; Never span multiple folios in the same ran=
ge.
>>> +	 */
>>> +	if (range->end =3D=3D tlb->range_limit)
>>> +		tlb->range_limit =3D NULL;
>>> +
>>>  	/*
>>> -	 * Add the page and check if we are full. If so
>>> -	 * force a flush.
>>> +	 * Check if we are full. If so force a flush. In order to ensure we=

>>> +	 * always have a free range for the next added page, the last range=
 in a
>>> +	 * batch always only has a single page.
>>>  	 */
>>> -	batch->pages[batch->nr++] =3D page;
>>>  	if (batch->nr =3D=3D batch->max) {
>>>  		if (!tlb_next_batch(tlb))
>>>  			return true;
>>> @@ -318,8 +355,9 @@ static void __tlb_gather_mmu(struct mmu_gather *t=
lb, struct mm_struct *mm,
>>>  	tlb->need_flush_all =3D 0;
>>>  	tlb->local.next =3D NULL;
>>>  	tlb->local.nr   =3D 0;
>>> -	tlb->local.max  =3D ARRAY_SIZE(tlb->__pages);
>>> +	tlb->local.max  =3D ARRAY_SIZE(tlb->__ranges);
>>>  	tlb->active     =3D &tlb->local;
>>> +	tlb->range_limit =3D NULL;
>>>  	tlb->batch_count =3D 0;
>>>  	tlb->rmap_pend	=3D &tlb->local;
>>>  	tlb->rmap_pend_first =3D 0;
>>> diff --git a/mm/swap.c b/mm/swap.c
>>> index b05cce475202..e238d3623fcb 100644
>>> --- a/mm/swap.c
>>> +++ b/mm/swap.c
>>> @@ -1041,6 +1041,97 @@ void release_pages(release_pages_arg arg, int =
nr)
>>>  }
>>>  EXPORT_SYMBOL(release_pages);
>>>
>>> +/**
>>> + * folios_put_refs - batched folio_put_refs()
>>> + * @folios: array of `struct folio_range`s to release
>>> + * @nr: number of folio ranges
>>> + *
>>> + * Each `struct folio_range` describes the start and end page of a r=
ange within
>>> + * a folio. The folio reference count is decremented once for each p=
age in the
>>> + * range. If it fell to zero, remove the page from the LRU and free =
it.
>>> + */
>>> +void folios_put_refs(struct folio_range *folios, int nr)
>>> +{
>>> +	int i;
>>> +	LIST_HEAD(pages_to_free);
>>> +	struct lruvec *lruvec =3D NULL;
>>> +	unsigned long flags =3D 0;
>>> +	unsigned int lock_batch;
>>> +
>>> +	for (i =3D 0; i < nr; i++) {
>>> +		struct folio *folio =3D page_folio(folios[i].start);
>>> +		int refs =3D folios[i].end - folios[i].start;
>>> +
>>> +		/*
>>> +		 * Make sure the IRQ-safe lock-holding time does not get
>>> +		 * excessive with a continuous string of pages from the
>>> +		 * same lruvec. The lock is held only if lruvec !=3D NULL.
>>> +		 */
>>> +		if (lruvec && ++lock_batch =3D=3D SWAP_CLUSTER_MAX) {
>>> +			unlock_page_lruvec_irqrestore(lruvec, flags);
>>> +			lruvec =3D NULL;
>>> +		}
>>> +
>>> +		if (is_huge_zero_page(&folio->page))
>>> +			continue;
>>> +
>>> +		if (folio_is_zone_device(folio)) {
>>> +			if (lruvec) {
>>> +				unlock_page_lruvec_irqrestore(lruvec, flags);
>>> +				lruvec =3D NULL;
>>> +			}
>>> +			if (put_devmap_managed_page(&folio->page))
>>> +				continue;
>>> +			if (folio_put_testzero(folio))
>>> +				free_zone_device_page(&folio->page);
>>> +			continue;
>>> +		}
>>> +
>>> +		if (!folio_ref_sub_and_test(folio, refs))
>>> +			continue;
>>> +
>>> +		if (folio_test_large(folio)) {
>>> +			if (lruvec) {
>>> +				unlock_page_lruvec_irqrestore(lruvec, flags);
>>> +				lruvec =3D NULL;
>>> +			}
>>> +			__folio_put_large(folio);
>>> +			continue;
>>> +		}
>>> +
>>> +		if (folio_test_lru(folio)) {
>>> +			struct lruvec *prev_lruvec =3D lruvec;
>>> +
>>> +			lruvec =3D folio_lruvec_relock_irqsave(folio, lruvec,
>>> +									&flags);
>>> +			if (prev_lruvec !=3D lruvec)
>>> +				lock_batch =3D 0;
>>> +
>>> +			lruvec_del_folio(lruvec, folio);
>>> +			__folio_clear_lru_flags(folio);
>>> +		}
>>> +
>>> +		/*
>>> +		 * In rare cases, when truncation or holepunching raced with
>>> +		 * munlock after VM_LOCKED was cleared, Mlocked may still be
>>> +		 * found set here.  This does not indicate a problem, unless
>>> +		 * "unevictable_pgs_cleared" appears worryingly large.
>>> +		 */
>>> +		if (unlikely(folio_test_mlocked(folio))) {
>>> +			__folio_clear_mlocked(folio);
>>> +			zone_stat_sub_folio(folio, NR_MLOCK);
>>> +			count_vm_event(UNEVICTABLE_PGCLEARED);
>>> +		}
>>> +
>>> +		list_add(&folio->lru, &pages_to_free);
>>> +	}
>>> +	if (lruvec)
>>> +		unlock_page_lruvec_irqrestore(lruvec, flags);
>>> +
>>> +	mem_cgroup_uncharge_list(&pages_to_free);
>>> +	free_unref_page_list(&pages_to_free);
>>> +}
>>> +
>>>  /*
>>>   * The folios which we're about to release may be in the deferred lr=
u-addition
>>>   * queues.  That would prevent them from really being freed right no=
w.  That's
>>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>>> index 73b16795b0ff..526bbd5a2ce1 100644
>>> --- a/mm/swap_state.c
>>> +++ b/mm/swap_state.c
>>> @@ -304,15 +304,16 @@ void free_page_and_swap_cache(struct page *page=
)
>>>  }
>>>
>>>  /*
>>> - * Passed an array of pages, drop them all from swapcache and then r=
elease
>>> - * them.  They are removed from the LRU and freed if this is their l=
ast use.
>>> + * Passed an array of folio ranges, drop all folios from swapcache a=
nd then put
>>> + * a folio reference for each page in the range.  They are removed f=
rom the LRU
>>> + * and freed if this is their last use.
>>>   */
>>> -void free_pages_and_swap_cache(struct page **pages, int nr)
>>> +void free_folios_and_swap_cache(struct folio_range *folios, int nr)
>>>  {
>>>  	lru_add_drain();
>>>  	for (int i =3D 0; i < nr; i++)
>>> -		free_swap_cache(pages[i]);
>>> -	release_pages(pages, nr);
>>> +		free_swap_cache(folios[i].start);
>>> +	folios_put_refs(folios, nr);
>>>  }
>>>
>>>  static inline bool swap_use_vma_readahead(void)
>>> -- =

>>> 2.25.1
>>
>>
>> --
>> Best Regards,
>> Yan, Zi


--
Best Regards,
Yan, Zi

--=_MailMate_B94567D7-43E6-44D5-9537-DADDCD6E3ED0_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmTU+2UPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU/DMP/1Pha/gDlWRhBkaiKe+LbKiut8xtsSCLMkFg
DZnY7cro8eLGMRFjvc2l05T5fmFQmqOLxIAy+dqAtJ0G8QjQKQQuNMIZ7uspLF6r
3KHv64+7o6I1eGq0gk8igZAbyB6jIq5k9lYJEe2HNMS7RgjZOeK9FPJrTF/dQ7Nu
nOuFG75y50Ph26xlMSRWwvaBtigURBg6fmL5FPrfGQ1utwQ1Bs7AL/w1v4rbbD5n
yL5rXBc0ba9XTxMCG0PMRCIA2Zmo3YZyQ8ixcvs3sLUTji8dhyMclCIRJfAohqLf
5vv3j6JpZyqstBR16FlXJsNR1XnnbK0kee/gWsuZ1kEU5JIDY/f3c/6wCmDfgDFq
KKMYMSsNxIIkfyrvxUI2e+ca56oBVixidaH9zikgxhTOKBYBGKXOMqu4w3kQGMEu
miQY65dQe+mhAVtjtxkLy7AaZkbVBuvtSpePV5RMGMrnocA1EQn+w5C+I28W8GBb
6cx76TzmXeA5keLx16Rel5pcaKKy/llrFkNjtyX22X8oiBM3zb7u5TjzqImgthFZ
xWsTKA/gkYJ9IIv26wdohBYbi29bWT0OyoOW80OBX9uJjRfaLLuspCpvz8ey2ANZ
Ba6PNnTnCYAUDhVMSk6HKZ/6i7WEFDVVsbtT9783R37261/bTSxR8tjS55bcslhT
GLzMviDH
=7Kcd
-----END PGP SIGNATURE-----

--=_MailMate_B94567D7-43E6-44D5-9537-DADDCD6E3ED0_=--
