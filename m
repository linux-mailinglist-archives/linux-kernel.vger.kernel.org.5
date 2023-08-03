Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CB276E8A3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbjHCMnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjHCMni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:43:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 62B44359A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:43:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E38C113E;
        Thu,  3 Aug 2023 05:44:18 -0700 (PDT)
Received: from [10.1.35.53] (C02Z41KALVDN.cambridge.arm.com [10.1.35.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D22893F6C4;
        Thu,  3 Aug 2023 05:43:32 -0700 (PDT)
Message-ID: <c02a95e9-b728-ad64-6942-f23dbd66af0c@arm.com>
Date:   Thu, 3 Aug 2023 13:43:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230726095146.2826796-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Kirill

On 26/07/2023 10:51, Ryan Roberts wrote:
> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
> allocated in large folios of a determined order. All pages of the large
> folio are pte-mapped during the same page fault, significantly reducing
> the number of page faults. The number of per-page operations (e.g. ref
> counting, rmap management lru list management) are also significantly
> reduced since those ops now become per-folio.
> 
> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
> which defaults to disabled for now; The long term aim is for this to
> defaut to enabled, but there are some risks around internal
> fragmentation that need to be better understood first.
> 
> When enabled, the folio order is determined as such: For a vma, process
> or system that has explicitly disabled THP, we continue to allocate
> order-0. THP is most likely disabled to avoid any possible internal
> fragmentation so we honour that request.
> 
> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
> that have not explicitly opted-in to use transparent hugepages (e.g.
> where thp=madvise and the vma does not have MADV_HUGEPAGE), then
> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
> bigger). This allows for a performance boost without requiring any
> explicit opt-in from the workload while limitting internal
> fragmentation.
> 
> If the preferred order can't be used (e.g. because the folio would
> breach the bounds of the vma, or because ptes in the region are already
> mapped) then we fall back to a suitable lower order; first
> PAGE_ALLOC_COSTLY_ORDER, then order-0.
> 

...

> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
> +		(ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SHIFT)
> +
> +static int anon_folio_order(struct vm_area_struct *vma)
> +{
> +	int order;
> +
> +	/*
> +	 * If THP is explicitly disabled for either the vma, the process or the
> +	 * system, then this is very likely intended to limit internal
> +	 * fragmentation; in this case, don't attempt to allocate a large
> +	 * anonymous folio.
> +	 *
> +	 * Else, if the vma is eligible for thp, allocate a large folio of the
> +	 * size preferred by the arch. Or if the arch requested a very small
> +	 * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER,
> +	 * which still meets the arch's requirements but means we still take
> +	 * advantage of SW optimizations (e.g. fewer page faults).
> +	 *
> +	 * Finally if thp is enabled but the vma isn't eligible, take the
> +	 * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHINTED.
> +	 * This ensures workloads that have not explicitly opted-in take benefit
> +	 * while capping the potential for internal fragmentation.
> +	 */
> +
> +	if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> +	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
> +	    !hugepage_flags_enabled())
> +		order = 0;
> +	else {
> +		order = max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
> +
> +		if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
> +			order = min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
> +	}
> +
> +	return order;
> +}


Hi All,

I'm writing up the conclusions that we arrived at during discussion in the THP
meeting yesterday, regarding linkage with exiting THP ABIs. It would be great if
I can get explicit "agree" or disagree + rationale from at least David, Yu and
Kirill.

In summary; I think we are converging on the approach that is already coded, but
I'd like confirmation.



The THP situation today
-----------------------

 - At system level: THP can be set to "never", "madvise" or "always"
 - At process level: THP can be "never" or "defer to system setting"
 - At VMA level: no-hint, MADV_HUGEPAGE, MADV_NOHUGEPAGE

That gives us this table to describe how a page fault is handled, according to
process state (columns) and vma flags (rows):

                | never     | madvise   | always
----------------|-----------|-----------|-----------
no hint         | S         | S         | THP>S
MADV_HUGEPAGE   | S         | THP>S     | THP>S
MADV_NOHUGEPAGE | S         | S         | S

Legend:
S	allocate single page (PTE-mapped)
LAF	allocate lage anon folio (PTE-mapped)
THP	allocate THP-sized folio (PMD-mapped)
>	fallback (usually because vma size/alignment insufficient for folio)



Principles for Large Anon Folios (LAF)
--------------------------------------

David tells us there are use cases today (e.g. qemu live migration) which use
MADV_NOHUGEPAGE to mean "don't fill any PTEs that are not explicitly faulted"
and these use cases will break (i.e. functionally incorrect) if this request is
not honoured.

So LAF must at least honour MADV_NOHUGEPAGE to prevent breaking existing use
cases. And once we do this, then I think the least confusing thing is for it to
also honor the "never" system/process state; so if either the system, process or
vma has explicitly opted-out of THP, then LAF should also be bypassed.

Similarly, any case that would previously cause the allocation of PMD-sized THP
must continue to be honoured, else we risk performance regression.

That leaves the "madvise/no-hint" case, and all THP fallback paths due to the
VMA not being correctly aligned or sized to hold a PMD-sized mapping. In these
cases, we will attempt to use LAF first, and fallback to single page if the vma
size/alignment doesn't permit it.

                | never     | madvise   | always
----------------|-----------|-----------|-----------
no hint         | S         | LAF>S     | THP>LAF>S
MADV_HUGEPAGE   | S         | THP>LAF>S | THP>LAF>S
MADV_NOHUGEPAGE | S         | S         | S

I think this (perhaps conservative) approach will be the least surprising to
users. And is the policy that is already implemented in this patch.



Downsides of this policy
------------------------

As Yu and Yin have pointed out, there are some workloads which do not perform
well with THP, due to large fault latency or memory wastage, etc. But which
_may_ still benefit from LAF. By taking the conservative approach, we exclude
these workloads from benefiting automatically.

But given they have explicitly opted out of THP, it doesn't seem unreasonable
that those workloads should be explicitly modified to opt-in to LAF. The
question is what should a control for this look like? And do we need to
implement the control for an MVP implementation of LAF? For the latter question,
I would suggest this can come later - its a tool to further optimize, but its
absence does not regress today's performance.

What should a control look like?

One suggestion was to expose a "maximum order" tunable, which would limit the
size of THP that could be allocated. setting it to 1M would cause traditional
THP to be bypassed (assuming for now PMD-sized THP is 2M) but would permit LAF.
But Kirill suggested that this type of control might turn out to be restrictive
in the long run.

Another suggestion was to provide a more abstracted hint to the kernel, which
the kernel could then derive a policy from, and that policy would be easier to
change over time.



Large Anon Folio Size
---------------------

Once we have decided to use LAF (vs THP vs S), we need to decide how big the
folio should be. If/when we get a control as described above, that will
obviously place an upper bound on the size. HW may also have a preferred size
due to tricks it can do in the TLB (arch_wants_pte_order() in this patch) but
you may still want to allocate a bigger folio than the HW wants (since bigger
folios will reduce page faults) or you may want to allocate a smaller folio than
the HW wants (due to concerns about latency or memory wastage).

I've had a stab at addressing this in the patch too, using the same decision as
for THP (ignoring the vma size/alignment requirement) to decide if we use the HW
preferred order or if we cap it (currently set at 64K).

Thoughts, comments?

Thanks,
Ryan





