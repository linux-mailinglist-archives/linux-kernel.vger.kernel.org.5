Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9821C7FE87E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 06:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344410AbjK3FIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 00:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3FIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 00:08:02 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7731910D7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 21:08:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu4YgfU1v/BWJ9lwbeD3OmOimK3SBvPzmYaEVntIjMkxTUJOW8+O90C6Jx0Y4goJ+gFS3FCCYg+J2BUkQYJkEyPMmPFStv1jBSjRA6DSI3R9W6Be2UPfbbj28mTeEryfHzfFe9og3YblAqe2Wnge/TGf3Eh1JdU0vYmj6Ffs6orRAeSrz0yeCfMTf7YXKaO05dAwXAqLMLe0VCBuYtLUQyNPsktD7C+6LoH13W0xVqwTJyGHfL3fQG6WiFLMNh9blBgMOhGZb5+Seuzjn40xuKjf/l9GWwGQD5L+oRLx+ZUFXCL0JCo9pmBWH7lRDItXBJpvWrMu/R7+Dg1/jV70rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0reaFcgCCoZXlj8g1Ey06Xqwpl99666H4zzIUZoF2k=;
 b=cvCxqVUqjPf/+U7NEtvlv9QCT4NqJpvqER4rDWsKL0aLzvYQ7NdNxfLs+UYHy0m1qqmOeJMwi/krMQDjIXycJV75abEe4LJjgqRYy62OUUDafzu5z6bgd5WTpRfOlmQi25i4QTr3ZXQjJ0Zy9eeWPBb+z13TKBzNVUpipXr2iwhBOrKI6WrC+IHw8gsKGmiBA8ErNo4aoVxyULNdz05LGMqYX4CDXYMIURn672C2fcHWkec4nar1/0iKF1CGZVCAfh8912dcOVEvaTIyI6SBkm21bfDxU/Hi4WPGzPhSvKVh1HoFpX61se4HmV4v088LEbNrdZZNyxFMdRMqT0Zw9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0reaFcgCCoZXlj8g1Ey06Xqwpl99666H4zzIUZoF2k=;
 b=oVq7/veEsahssKVqgmT1Z4KduYugDppgJbUh5/1jKcrlygBNZQlJ6CpGSAtbH7boBCkG+O7k3QsFtD09kUlG0LW3w+w/cV86vhP4xgZPSS6KFKlfZ1djbso0n6aNEv3j+wCJcpaKeE33SI10jikpYQvQQU8TuaP4MRZx8IZl82xvad8S0utpM7N+jSSKan1tCeUYpnQe8gR80nHLafMsGNSrGc3kzGfE9VuCstwZ0YrGwtuENXsM4xsQwM64aXqkYgqIamRFLJc4E39hb8ZgKjonr1VkkIQ56xJPI0kBmSTF78pRqRri96JCDC+QYC90ym6NavuENSFaXNVt278zVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Thu, 30 Nov
 2023 05:08:04 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::b8a:1b58:1edf:90e6%7]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 05:08:03 +0000
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231115163018.1303287-15-ryan.roberts@arm.com>
 <87fs0xxd5g.fsf@nvdebian.thelocal>
 <3b4f6bff-6322-4394-9efb-9c3b9ef52010@arm.com>
 <87y1eovsn5.fsf@nvdebian.thelocal>
 <8fca9ed7-f916-4abe-8284-6e3c9fa33a8c@arm.com>
 <87wmu3pro8.fsf@nvdebian.thelocal>
 <26c78fee-4b7a-4d73-9f8b-2e25bbae20e8@arm.com>
 <87o7fepdun.fsf@nvdebian.thelocal>
 <b4906e1e-8009-4097-8d17-642374a049fe@arm.com>
 <b6d4b33b-6224-444f-9542-d3cb95afd382@arm.com>
User-agent: mu4e 1.8.13; emacs 29.1
From:   Alistair Popple <apopple@nvidia.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] arm64/mm: Add ptep_get_and_clear_full() to
 optimize process teardown
Date:   Thu, 30 Nov 2023 16:07:09 +1100
In-reply-to: <b6d4b33b-6224-444f-9542-d3cb95afd382@arm.com>
Message-ID: <87leafg768.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0034.ausprd01.prod.outlook.com
 (2603:10c6:10:eb::21) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS7PR12MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 98cdcf10-4bdc-45b0-4725-08dbf16254a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIbLrGq7udl178uQ/Q9S8gWRxtf0I/GDS5ECRWy5Hs5gOx3HytifbPbAE8e91htoCDsFwR/2GE5Ndu/7SEzV/wGBTJ2xrMxADxSO9U2wtj97F7AYCpIjmt3BvlOlqqYBK/U7m3RMS8/u0blLtqvC/alcTds7e10L7eHcwaV8RsCXe9tZ5xdu0oqt6a+xjnA4C5nQ69FVTxh+yFYFhJfy3Cv7co1DhJqY/lWFS6BmQFso0enqZQaCwc785RUqz8HaH/+Q9yiZgKc46Ur+y8NU0fpRaG1fsNwcieFPk6YhqdQTOkErbhwNhO8hnUV5EBPNWDn5KL+dJnCMKICyme/8mu2HhReq8JZ+Kn8QhDOokF8TVGjYRLBXvnpxwUsr8ZstjavbQoM6xbecuvWCMoi6MHH+lkbdiccBhzdfZSkOMbQ65DZEWj4l0RE0akuBD8gZsThStm+YD24SrPuA21cMCNfSXj8yCWA3uwRA9Penp5P8kUxzzvbSDfIrRcuh1eepLfQTkNG8t3oz4xI+HoRnp6IpyGyTxjwIkaOOjFdWzaL5QKB5rivYY7YTlWxmiYTsLODZtvXMsxXqMKy0cnacZkH13QgIToS6URRIPmHThxiHCb7s6TJ/4tVij2OsDAMB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6506007)(66946007)(54906003)(6916009)(66556008)(41300700001)(316002)(66476007)(6512007)(9686003)(202311291699003)(478600001)(6486002)(66899024)(38100700002)(83380400001)(26005)(86362001)(30864003)(2906002)(8936002)(8676002)(4326008)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jw5RhUP2lQtc1PiJxaEaes4uN1tDlcayJwaAfBFxFYJs92mGqKokTPJ6LiSq?=
 =?us-ascii?Q?hUPKQGEI2a0WBG2gMWLGGFCtE7uZNih6ufTq7M212SRLBYl/0k29GcLALw9D?=
 =?us-ascii?Q?cnKybkUFGOiTGevDX49oAE7TkjMhIO8ws7oTGQaQlfs/fr/t3U8/6+sDyWiX?=
 =?us-ascii?Q?ZDG6RPLUpEkW8WLCawrtWCV9uWiGLWEoYBdSxEpzZsuuGzvlsmN02NS2h2uE?=
 =?us-ascii?Q?7wA+N5mq/FMhYp5O+D7o3g9Vsx2cEvtq6N2zEwsqoo1O8fXLxGQuoX2/ooed?=
 =?us-ascii?Q?e6zoy1YE6M4mviwAF4Qqj1WuQdhm0figvr9YCzPf/3AxkBCQHs8Q8BeInVos?=
 =?us-ascii?Q?p4xbwlI3QMJUMNT+5Hz0VRjUNOSYerLFbr8Y29KSGFilZk4ipi4xJ6h3erTL?=
 =?us-ascii?Q?rEcBj7aKp8elsq16QeIpi4dwjW95EwcXsJWqcJZQKEy30vX7lo9hcflDI0QE?=
 =?us-ascii?Q?pdtRWdiOqm8HESz5+mpi4aghg8qZzq6DRC+/ebA3lIC1MSGlxDCWMVjrknum?=
 =?us-ascii?Q?h1SUQsKXHuVO4UXaYRTBTr3N0MuRLRqGGxKO53Q7HWsGxiHQYtZARtLZhWrw?=
 =?us-ascii?Q?shjLVgnPb1XMYSMCax8gsN+7qzSYcWevqQGcoU1CughU8qVXxatMy4wDu+AU?=
 =?us-ascii?Q?NI4vXnjmNVLXBdIxIq/ewF5La0VIvF8FnA5Z5Aze4zu4KJ+/Em2WxjwQJ8kY?=
 =?us-ascii?Q?AetS2mGAgAdGD+1F8i0GUOcfckiSQkjdn+Wm04KdD7DZWeNatzZ/Uvbei6MZ?=
 =?us-ascii?Q?o3JlurrHkzWPjI3k0EadINL4AnDQSlUFuHCFb77l3g0DAYYIpXP/ZFP4Quff?=
 =?us-ascii?Q?QLGf/VasZ/z8CHVjF5+KKIHtXS47VePQIQf5h6PM8yCWHHocek+QyNq062i7?=
 =?us-ascii?Q?O/G6xD3VnanvAY8GHFmjuRH36bxCXdFzwuYy9gdxc7D0jXi587pIoDPd0bFh?=
 =?us-ascii?Q?LLfm4g7r8Fa7dMbvhT+8EHdEr+pDNBHVbxqAUIxWRvf+z1YJf+bxVekWpM4K?=
 =?us-ascii?Q?iHiacl42wl0V+1LwWVKDMTtkVIOsZ3KAMz9PHeqiZ/C5B9p7Dv6ha2qieXUh?=
 =?us-ascii?Q?pWXES1i+hPITOgsB2C4yXAL9mKGl2bg2WnhaGDrmnHuGjZmPk/YeILGovtVa?=
 =?us-ascii?Q?aZgNDnoameMmPIlQUk0bR1qTxtYW6qq5gC0CfbPazxe4ZnXYhtyAswg7UuUj?=
 =?us-ascii?Q?nxNc8elWZ6Y8fo5uKMTSbqwdcNUnwYH//CKEb0cJmH00GBNNxu7TmwbuFjDm?=
 =?us-ascii?Q?2EUo5shNTiQCsO0rZRSpXseyQ8HSxE1JSR64dhldGHlHks/ABa5SJwSqMwZm?=
 =?us-ascii?Q?KUwfuM2WqUjE1diQDTOeZWl5ny0qS7oDSZvepI7xYkaIvMSkQoYQzWHVj9gy?=
 =?us-ascii?Q?WGZcRB9YMhDwYgz+vw5qRlsmY4O+aR2m9IKbzWdn5h0V9eDEtQ9f4mdBwfqW?=
 =?us-ascii?Q?MXBLxvArSMmeZoNhDOX1gZjqh+xI6gICf4eGK9NGqvhs2qdFobKv1yZ7gn43?=
 =?us-ascii?Q?BmzYyD4zPseJPCMDHklggjf1vhgVZ2WXCIFBc1yfqRTuueUDynsiyehGnqiU?=
 =?us-ascii?Q?AGxfEOZUD2MHb2odLYVX7vZpfbaBQKppfRYlTsbD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98cdcf10-4bdc-45b0-4725-08dbf16254a7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 05:08:03.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGrTMpMbImHAL8H+UrJxjICOSDQ0eDtiY2Cde9YyMwNoP2LbhIRhhIv3jiF7zemOuW2FVvlaQVKBt1RtYdJK3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5744
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ryan Roberts <ryan.roberts@arm.com> writes:

>>>> So if we do need to deal with racing HW, I'm pretty sure my v1 implementation is
>>>> buggy because it iterated through the PTEs, getting and accumulating. Then
>>>> iterated again, writing that final set of bits to all the PTEs. And the HW could
>>>> have modified the bits during those loops. I think it would be possible to fix
>>>> the race, but intuition says it would be expensive.
>>>
>>> So the issue as I understand it is subsequent iterations would see a
>>> clean PTE after the first iteration returned a dirty PTE. In
>>> ptep_get_and_clear_full() why couldn't you just copy the dirty/accessed
>>> bit (if set) from the PTE being cleared to an adjacent PTE rather than
>>> all the PTEs?
>> 
>> The raciness I'm describing is the race between reading access/dirty from one
>> pte and applying it to another. But yes I like your suggestion. if we do:
>> 
>> pte = __ptep_get_and_clear_full(ptep)
>> 
>> on the target pte, then we have grabbed access/dirty from it in a race-free
>> manner. we can then loop from current pte up towards the top of the block until
>> we find a valid entry (and I guess wrap at the top to make us robust against
>> future callers clearing an an arbitrary order). Then atomically accumulate the
>> access/dirty bits we have just saved into that new entry. I guess that's just a
>> cmpxchg loop - there are already examples of how to do that correctly when
>> racing the TLB.
>> 
>> For most entries, we will just be copying up to the next pte. For the last pte,
>> we would end up reading all ptes and determine we are the last one.
>> 
>> What do you think?
>
> OK here is an attempt at something which solves the fragility. I think this is
> now robust and will always return the correct access/dirty state from
> ptep_get_and_clear_full() and ptep_get().
>
> But I'm not sure about performance; each call to ptep_get_and_clear_full() for
> each pte in a contpte block will cause a ptep_get() to gather the access/dirty
> bits from across the contpte block - which requires reading each pte in the
> contpte block. So its O(n^2) in that sense. I'll benchmark it and report back.
>
> Was this the type of thing you were thinking of, Alistair?

Yes, that is along the lines of what I was thinking. However I have
added a couple of comments inline. 

> --8<--
>  arch/arm64/include/asm/pgtable.h | 23 ++++++++-
>  arch/arm64/mm/contpte.c          | 81 ++++++++++++++++++++++++++++++++
>  arch/arm64/mm/fault.c            | 38 +++++++++------
>  3 files changed, 125 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 9bd2f57a9e11..6c295d277784 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -851,6 +851,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>  	return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
>  }
>
> +extern int __ptep_set_access_flags_notlbi(pte_t *ptep, pte_t entry);
>  extern int __ptep_set_access_flags(struct vm_area_struct *vma,
>  				 unsigned long address, pte_t *ptep,
>  				 pte_t entry, int dirty);
> @@ -1145,6 +1146,8 @@ extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
>  extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
>  extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>  				pte_t *ptep, pte_t pte, unsigned int nr);
> +extern pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep);
>  extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep);
>  extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
> @@ -1270,12 +1273,28 @@ static inline void pte_clear(struct mm_struct *mm,
>  	__pte_clear(mm, addr, ptep);
>  }
>
> +#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_FULL
> +static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep, int full)
> +{
> +	pte_t orig_pte = __ptep_get(ptep);
> +
> +	if (!pte_valid_cont(orig_pte))
> +		return __ptep_get_and_clear(mm, addr, ptep);
> +
> +	if (!full) {
> +		contpte_try_unfold(mm, addr, ptep, orig_pte);
> +		return __ptep_get_and_clear(mm, addr, ptep);
> +	}
> +
> +	return contpte_ptep_get_and_clear_full(mm, addr, ptep);
> +}
> +
>  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  				unsigned long addr, pte_t *ptep)
>  {
> -	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
> -	return __ptep_get_and_clear(mm, addr, ptep);
> +	return ptep_get_and_clear_full(mm, addr, ptep, 0);
>  }
>
>  #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index 2a57df16bf58..99b211118d93 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -145,6 +145,14 @@ pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte)
>  	for (i = 0; i < CONT_PTES; i++, ptep++) {
>  		pte = __ptep_get(ptep);
>
> +		/*
> +		 * Deal with the partial contpte_ptep_get_and_clear_full() case,
> +		 * where some of the ptes in the range may be cleared but others
> +		 * are still to do. See contpte_ptep_get_and_clear_full().
> +		 */
> +		if (!pte_valid(pte))
> +			continue;
> +
>  		if (pte_dirty(pte))
>  			orig_pte = pte_mkdirty(orig_pte);
>
> @@ -257,6 +265,79 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>  }
>  EXPORT_SYMBOL(contpte_set_ptes);
>
> +pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
> +					unsigned long addr, pte_t *ptep)
> +{
> +	/*
> +	 * When doing a full address space teardown, we can avoid unfolding the
> +	 * contiguous range, and therefore avoid the associated tlbi. Instead,
> +	 * just get and clear the pte. The caller is promising to call us for
> +	 * every pte, so every pte in the range will be cleared by the time the
> +	 * final tlbi is issued.
> +	 *
> +	 * This approach requires some complex hoop jumping though, as for the
> +	 * duration between returning from the first call to
> +	 * ptep_get_and_clear_full() and making the final call, the contpte
> +	 * block is in an intermediate state, where some ptes are cleared and
> +	 * others are still set with the PTE_CONT bit. If any other APIs are
> +	 * called for the ptes in the contpte block during that time, we have to
> +	 * be very careful. The core code currently interleaves calls to
> +	 * ptep_get_and_clear_full() with ptep_get() and so ptep_get() must be
> +	 * careful to ignore the cleared entries when accumulating the access
> +	 * and dirty bits - the same goes for ptep_get_lockless(). The only
> +	 * other calls we might resonably expect are to set markers in the
> +	 * previously cleared ptes. (We shouldn't see valid entries being set
> +	 * until after the tlbi, at which point we are no longer in the
> +	 * intermediate state). Since markers are not valid, this is safe;
> +	 * set_ptes() will see the old, invalid entry and will not attempt to
> +	 * unfold. And the new pte is also invalid so it won't attempt to fold.
> +	 * We shouldn't see pte markers being set for the 'full' case anyway
> +	 * since the address space is being torn down.
> +	 *
> +	 * The last remaining issue is returning the access/dirty bits. That
> +	 * info could be present in any of the ptes in the contpte block.
> +	 * ptep_get() will gather those bits from across the contpte block (for
> +	 * the remaining valid entries). So below, if the pte we are clearing
> +	 * has dirty or young set, we need to stash it into a pte that we are
> +	 * yet to clear. This allows future calls to return the correct state
> +	 * even when the info was stored in a different pte. Since the core-mm
> +	 * calls from low to high address, we prefer to stash in the last pte of
> +	 * the contpte block - this means we are not "dragging" the bits up
> +	 * through all ptes and increases the chances that we can exit early
> +	 * because a given pte will have neither dirty or young set.
> +	 */
> +
> +	pte_t orig_pte = __ptep_get_and_clear(mm, addr, ptep);
> +	bool dirty = pte_dirty(orig_pte);
> +	bool young = pte_young(orig_pte);
> +	pte_t *start;
> +
> +	if (!dirty && !young)
> +		return contpte_ptep_get(ptep, orig_pte);

I don't think we need to do this. If the PTE is !dirty && !young we can
just return it. As you say we have to assume HW can set those flags at
any time anyway so it doesn't get us much. This means in the common case
we should only run through the loop setting the dirty/young flags once
which should alay the performance concerns.

However I am now wondering if we're doing the wrong thing trying to hide
this down in the arch layer anyway. Perhaps it would be better to deal
with this in the core-mm code after all.

So how about having ptep_get_and_clear_full() clearing the PTEs for the
entire cont block? We know by definition all PTEs should be pointing to
the same folio anyway, and it seems at least zap_pte_range() would cope
with this just fine because subsequent iterations would just see
pte_none() and continue the loop. I haven't checked the other call sites
though, but in principal I don't see why we couldn't define
ptep_get_and_clear_full() as being something that clears all PTEs
mapping a given folio (although it might need renaming).

This does assume you don't need to partially unmap a page in
zap_pte_range (ie. end >= folio), but we're already making that
assumption.

> +
> +	start = contpte_align_down(ptep);
> +	ptep = start + CONT_PTES - 1;
> +
> +	for (; ptep >= start; ptep--) {
> +		pte_t pte = __ptep_get(ptep);
> +
> +		if (!pte_valid(pte))
> +			continue;
> +
> +		if (dirty)
> +			pte = pte_mkdirty(pte);
> +
> +		if (young)
> +			pte = pte_mkyoung(pte);
> +
> +		__ptep_set_access_flags_notlbi(ptep, pte);
> +		return contpte_ptep_get(ptep, orig_pte);
> +	}
> +
> +	return orig_pte;
> +}
> +EXPORT_SYMBOL(contpte_ptep_get_and_clear_full);
> +
>  int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>  					unsigned long addr, pte_t *ptep)
>  {
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index d63f3a0a7251..b22216a8153c 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -199,19 +199,7 @@ static void show_pte(unsigned long addr)
>  	pr_cont("\n");
>  }
>
> -/*
> - * This function sets the access flags (dirty, accessed), as well as write
> - * permission, and only to a more permissive setting.
> - *
> - * It needs to cope with hardware update of the accessed/dirty state by other
> - * agents in the system and can safely skip the __sync_icache_dcache() call as,
> - * like __set_ptes(), the PTE is never changed from no-exec to exec here.
> - *
> - * Returns whether or not the PTE actually changed.
> - */
> -int __ptep_set_access_flags(struct vm_area_struct *vma,
> -			    unsigned long address, pte_t *ptep,
> -			    pte_t entry, int dirty)
> +int __ptep_set_access_flags_notlbi(pte_t *ptep, pte_t entry)
>  {
>  	pteval_t old_pteval, pteval;
>  	pte_t pte = __ptep_get(ptep);
> @@ -238,10 +226,30 @@ int __ptep_set_access_flags(struct vm_area_struct *vma,
>  		pteval = cmpxchg_relaxed(&pte_val(*ptep), old_pteval, pteval);
>  	} while (pteval != old_pteval);
>
> +	return 1;
> +}
> +
> +/*
> + * This function sets the access flags (dirty, accessed), as well as write
> + * permission, and only to a more permissive setting.
> + *
> + * It needs to cope with hardware update of the accessed/dirty state by other
> + * agents in the system and can safely skip the __sync_icache_dcache() call as,
> + * like __set_ptes(), the PTE is never changed from no-exec to exec here.
> + *
> + * Returns whether or not the PTE actually changed.
> + */
> +int __ptep_set_access_flags(struct vm_area_struct *vma,
> +			    unsigned long address, pte_t *ptep,
> +			    pte_t entry, int dirty)
> +{
> +	int changed = __ptep_set_access_flags_notlbi(ptep, entry);
> +
>  	/* Invalidate a stale read-only entry */
> -	if (dirty)
> +	if (changed && dirty)
>  		flush_tlb_page(vma, address);
> -	return 1;
> +
> +	return changed;
>  }
>
>  static bool is_el1_instruction_abort(unsigned long esr)
> --8<--

