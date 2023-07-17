Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE687566C2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjGQOsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjGQOsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:48:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD63BE45
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:47:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C241B13D5;
        Mon, 17 Jul 2023 07:48:40 -0700 (PDT)
Received: from [10.57.76.30] (unknown [10.57.76.30])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7D833F738;
        Mon, 17 Jul 2023 07:47:54 -0700 (PDT)
Message-ID: <4f89d7bf-2fe2-fa53-c7ca-e4f152ca0edf@arm.com>
Date:   Mon, 17 Jul 2023 15:47:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/4] mm: FLEXIBLE_THP for improved performance
To:     David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230714160407.4142030-1-ryan.roberts@arm.com>
 <20230714161733.4144503-3-ryan.roberts@arm.com>
 <CAOUHufacQ8Vx9WQ3BVjGGWKGhcRkL7u79UMX=O7oePDwZ0iNxw@mail.gmail.com>
 <82c934af-a777-3437-8d87-ff453ad94bfd@redhat.com>
 <2c4b2a41-1c98-0782-ac30-80e65bdb2b0c@arm.com>
 <2e7d5692-8ba7-1e56-a03f-449f1671b100@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2e7d5692-8ba7-1e56-a03f-449f1671b100@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 14:56, David Hildenbrand wrote:
> On 17.07.23 15:20, Ryan Roberts wrote:
>> On 17/07/2023 14:06, David Hildenbrand wrote:
>>> On 14.07.23 19:17, Yu Zhao wrote:
>>>> On Fri, Jul 14, 2023 at 10:17 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>
>>>>> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
>>>>> allocated in large folios of a determined order. All pages of the large
>>>>> folio are pte-mapped during the same page fault, significantly reducing
>>>>> the number of page faults. The number of per-page operations (e.g. ref
>>>>> counting, rmap management lru list management) are also significantly
>>>>> reduced since those ops now become per-folio.
>>>>>
>>>>> The new behaviour is hidden behind the new FLEXIBLE_THP Kconfig, which
>>>>> defaults to disabled for now; The long term aim is for this to defaut to
>>>>> enabled, but there are some risks around internal fragmentation that
>>>>> need to be better understood first.
>>>>>
>>>>> When enabled, the folio order is determined as such: For a vma, process
>>>>> or system that has explicitly disabled THP, we continue to allocate
>>>>> order-0. THP is most likely disabled to avoid any possible internal
>>>>> fragmentation so we honour that request.
>>>>>
>>>>> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
>>>>> that have not explicitly opted-in to use transparent hugepages (e.g.
>>>>> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
>>>>> arch_wants_pte_order() is limited by the new cmdline parameter,
>>>>> `flexthp_unhinted_max`. This allows for a performance boost without
>>>>> requiring any explicit opt-in from the workload while allowing the
>>>>> sysadmin to tune between performance and internal fragmentation.
>>>>>
>>>>> arch_wants_pte_order() can be overridden by the architecture if desired.
>>>>> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
>>>>> set of ptes map physically contigious, naturally aligned memory, so this
>>>>> mechanism allows the architecture to optimize as required.
>>>>>
>>>>> If the preferred order can't be used (e.g. because the folio would
>>>>> breach the bounds of the vma, or because ptes in the region are already
>>>>> mapped) then we fall back to a suitable lower order; first
>>>>> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>>>>>
>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>> ---
>>>>>    .../admin-guide/kernel-parameters.txt         |  10 +
>>>>>    mm/Kconfig                                    |  10 +
>>>>>    mm/memory.c                                   | 187 ++++++++++++++++--
>>>>>    3 files changed, 190 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>>>> b/Documentation/admin-guide/kernel-parameters.txt
>>>>> index a1457995fd41..405d624e2191 100644
>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>> @@ -1497,6 +1497,16 @@
>>>>>                           See Documentation/admin-guide/sysctl/net.rst for
>>>>>                           fb_tunnels_only_for_init_ns
>>>>>
>>>>> +       flexthp_unhinted_max=
>>>>> +                       [KNL] Requires CONFIG_FLEXIBLE_THP enabled. The
>>>>> maximum
>>>>> +                       folio size that will be allocated for an anonymous vma
>>>>> +                       that has neither explicitly opted in nor out of using
>>>>> +                       transparent hugepages. The size must be a
>>>>> power-of-2 in
>>>>> +                       the range [PAGE_SIZE, PMD_SIZE). A larger size
>>>>> improves
>>>>> +                       performance by reducing page faults, while a smaller
>>>>> +                       size reduces internal fragmentation. Default: max(64K,
>>>>> +                       PAGE_SIZE). Format: size[KMG].
>>>>> +
>>>>
>>>> Let's split this parameter into a separate patch.
>>>>
>>>
>>> Just a general comment after stumbling over patch #2, let's not start splitting
>>> patches into things that don't make any sense on their own; that just makes
>>> review a lot harder.
>>
>> ACK
>>
>>>
>>> For this case here, I'd suggest first adding the general infrastructure and then
>>> adding tunables we want to have on top.
>>
>> OK, so 1 patch for the main infrastructure, then a patch to disable for
>> MADV_NOHUGEPAGE and friends, then a further patch to set flexthp_unhinted_max
>> via a sysctl?
> 
> MADV_NOHUGEPAGE handling for me falls under the category "required for
> correctness to not break existing workloads" and has to be there initially.
> 
> Anything that is rather a performance tunable (e.g., a sysctl to optimize) can
> be added on top and discussed separately.>
> At least IMHO :)
> 
>>
>>>
>>> I agree that toggling that at runtime (for example via sysfs as raised by me
>>> previously) would be nicer.
>>
>> OK, I clearly misunderstood, I thought you were requesting a boot parameter.
> 
> Oh, sorry about that. I wanted to actually express
> "/sys/kernel/mm/transparent_hugepage/" sysctls where we can toggle that later at
> runtime as well.
> 
>> What's the ABI compat guarrantee for sysctls? I assumed that for a boot
>> parameter it would be easier to remove in future if we wanted, but for sysctl,
>> its there forever?
> 
> sysctl are hard/impossible to remove, yes. So we better make sure what we add
> has clear semantics.
> 
> If we ever want some real auto-tunable mode (and can actually implement it
> without harming performance; and I am skeptical), we might want to allow for
> setting such a parameter to "auto", for example.
> 
>>
>> Also, how do you feel about the naming and behavior of the parameter?
> 
> Very good question. "flexthp_unhinted_max" naming is a bit suboptimal.
> 
> For example, I'm not so sure if we should expose the feature to user space as
> "flexthp" at all. I think we should find a clearer feature name to begin with.
> 
> ... maybe we can initially get away with dropping that parameter and default to
> something reasonably small (i.e., 64k as you have above)?

That would certainly get my vote. But it was you who was arguing for a tunable
previously ;-). I propose we use the following as the "unhinted ceiling" for
now, then we can add a tunable if/when we find a use case that doesn't work
optimally with this value:

	static int flexthp_unhinted_max_order =
		ilog2(SZ_64K > PAGE_SIZE ? SZ_64K : PAGE_SIZE) - PAGE_SHIFT;

(Using PAGE_SIZE when its gt 64K to cover the ppc case that looks like it can
support 256K pages. Open coding the max because max() can't be used outside a
function).

> 
> /sys/kernel/mm/transparent_hugepage/enabled=never and simply not get any thp.

Yes, that should work with the patch as it is today.

> 

