Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007538070BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378474AbjLFNSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378416AbjLFNS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:18:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72ACB9C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:18:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D3F01474;
        Wed,  6 Dec 2023 05:19:20 -0800 (PST)
Received: from [10.57.73.130] (unknown [10.57.73.130])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04A693F5A1;
        Wed,  6 Dec 2023 05:18:30 -0800 (PST)
Message-ID: <ca3a2b97-f08e-452a-91dc-1a53dece0aa6@arm.com>
Date:   Wed, 6 Dec 2023 13:18:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/10] mm: thp: Introduce multi-size THP sysfs
 interface
Content-Language: en-GB
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Barry Song <21cnbao@gmail.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231204102027.57185-1-ryan.roberts@arm.com>
 <20231204102027.57185-4-ryan.roberts@arm.com>
 <004ed23d-5571-4474-b7fe-7bc08817c165@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <004ed23d-5571-4474-b7fe-7bc08817c165@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 16:57, David Hildenbrand wrote:
> On 04.12.23 11:20, Ryan Roberts wrote:
>> In preparation for adding support for anonymous multi-size THP,
>> introduce new sysfs structure that will be used to control the new
>> behaviours. A new directory is added under transparent_hugepage for each
>> supported THP size, and contains an `enabled` file, which can be set to
>> "inherit" (to inherit the global setting), "always", "madvise" or
>> "never". For now, the kernel still only supports PMD-sized anonymous
>> THP, so only 1 directory is populated.
>>
>> The first half of the change converts transhuge_vma_suitable() and
>> hugepage_vma_check() so that they take a bitfield of orders for which
>> the user wants to determine support, and the functions filter out all
>> the orders that can't be supported, given the current sysfs
>> configuration and the VMA dimensions. If there is only 1 order set in
>> the input then the output can continue to be treated like a boolean;
>> this is the case for most call sites. The resulting functions are
>> renamed to thp_vma_suitable_orders() and thp_vma_allowable_orders()
>> respectively.
>>
>> The second half of the change implements the new sysfs interface. It has
>> been done so that each supported THP size has a `struct thpsize`, which
>> describes the relevant metadata and is itself a kobject. This is pretty
>> minimal for now, but should make it easy to add new per-thpsize files to
>> the interface if needed in future (e.g. per-size defrag). Rather than
>> keep the `enabled` state directly in the struct thpsize, I've elected to
>> directly encode it into huge_anon_orders_[always|madvise|inherit]
>> bitfields since this reduces the amount of work required in
>> thp_vma_allowable_orders() which is called for every page fault.
>>
>> See Documentation/admin-guide/mm/transhuge.rst, as modified by this
>> commit, for details of how the new sysfs interface works.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
> 
> Some comments mostly regarding thp_vma_allowable_orders and friends. In general,
> LGTM. I'll have to go over the order logic once again, I got a bit lost once we
> started mixing anon and file orders.
> 
> [...]
> 
> Doc updates all looked good to me, skimming over them.
> 
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index fa0350b0812a..bd0eadd3befb 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
> 
> [...]
> 
>> +static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
>> +        unsigned long addr, unsigned long orders)
>> +{
>> +    int order;
>> +
>> +    /*
>> +     * Iterate over orders, highest to lowest, removing orders that don't
>> +     * meet alignment requirements from the set. Exit loop at first order
>> +     * that meets requirements, since all lower orders must also meet
>> +     * requirements.
>> +     */
>> +
>> +    order = first_order(orders);
> 
> nit: "highest_order" or "largest_order" would be more expressive regarding the
> actual semantics.

Yep, will call it "highest_order".

> 
>> +
>> +    while (orders) {
>> +        unsigned long hpage_size = PAGE_SIZE << order;
>> +        unsigned long haddr = ALIGN_DOWN(addr, hpage_size);
>> +
>> +        if (haddr >= vma->vm_start &&
>> +            haddr + hpage_size <= vma->vm_end) {
>> +            if (!vma_is_anonymous(vma)) {
>> +                if (IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) -
>> +                        vma->vm_pgoff,
>> +                        hpage_size >> PAGE_SHIFT))
>> +                    break;
>> +            } else
>> +                break;
> 
> Comment: Codying style wants you to use if () {} else {}
> 
> But I'd recommend for the conditions:
> 
> if (haddr < vma->vm_start ||
>     haddr + hpage_size > vma->vm_end)
>     continue;
> /* Don't have to check pgoff for anonymous vma */
> if (!vma_is_anonymous(vma))
>     break;
> if (IS_ALIGNED((...
>     break;

OK I'll take this structure.

> 
> [...]
> 
> 
>> +/**
>> + * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
>> + * @vma:  the vm area to check
>> + * @vm_flags: use these vm_flags instead of vma->vm_flags
>> + * @smaps: whether answer will be used for smaps file
>> + * @in_pf: whether answer will be used by page fault handler
>> + * @enforce_sysfs: whether sysfs config should be taken into account
>> + * @orders: bitfield of all orders to consider
>> + *
>> + * Calculates the intersection of the requested hugepage orders and the allowed
>> + * hugepage orders for the provided vma. Permitted orders are encoded as a set
>> + * bit at the corresponding bit position (bit-2 corresponds to order-2, bit-3
>> + * corresponds to order-3, etc). Order-0 is never considered a hugepage order.
>> + *
>> + * Return: bitfield of orders allowed for hugepage in the vma. 0 if no hugepage
>> + * orders are allowed.
>> + */
>> +unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>> +                       unsigned long vm_flags, bool smaps,
>> +                       bool in_pf, bool enforce_sysfs,
>> +                       unsigned long orders)
>> +{
>> +    /* Check the intersection of requested and supported orders. */
>> +    orders &= vma_is_anonymous(vma) ?
>> +            THP_ORDERS_ALL_ANON : THP_ORDERS_ALL_FILE;
>> +    if (!orders)
>> +        return 0;
> 
> Comment: if this is called from some hot path, we might want to move as much as
> possible into a header, so we can avoid this function call here when e.g., THP
> are completely disabled etc.

If THP is completely disabled (compiled out) then thp_vma_allowable_orders() is
defined as a header inline that returns 0. I'm not sure there are any paths in
practice which are likely to ask for a set of orders which are never supported
(i.e. where this specific check would return 0). And the "are they run time
enabled" check is further down and fairly involved, so not sure that's ideal for
an inline.

I haven't changed the pattern from how it was previously, so I don't think it
should be any more expensive. Which parts exactly do you want to move to a header?


> 
>> +
>>       if (!vma->vm_mm)        /* vdso */
>> -        return false;
>> +        return 0;
>>         /*
>>        * Explicitly disabled through madvise or prctl, or some
>> @@ -88,16 +141,16 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>> unsigned long vm_flags,
>>        * */
>>       if ((vm_flags & VM_NOHUGEPAGE) ||
>>           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>> -        return false;
>> +        return 0;
>>       /*
>>        * If the hardware/firmware marked hugepage support disabled.
>>        */
>>       if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED))
>> -        return false;
>> +        return 0;
>>         /* khugepaged doesn't collapse DAX vma, but page fault is fine. */
>>       if (vma_is_dax(vma))
>> -        return in_pf;
>> +        return in_pf ? orders : 0;
>>         /*
>>        * khugepaged special VMA and hugetlb VMA.
>> @@ -105,17 +158,29 @@ bool hugepage_vma_check(struct vm_area_struct *vma,
>> unsigned long vm_flags,
>>        * VM_MIXEDMAP set.
>>        */
>>       if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
>> -        return false;
>> +        return 0;
>>         /*
>> -     * Check alignment for file vma and size for both file and anon vma.
>> +     * Check alignment for file vma and size for both file and anon vma by
>> +     * filtering out the unsuitable orders.
>>        *
>>        * Skip the check for page fault. Huge fault does the check in fault
>> -     * handlers. And this check is not suitable for huge PUD fault.
>> +     * handlers.
>>        */
>> -    if (!in_pf &&
>> -        !transhuge_vma_suitable(vma, (vma->vm_end - HPAGE_PMD_SIZE)))
>> -        return false;
>> +    if (!in_pf) {
>> +        int order = first_order(orders);
>> +        unsigned long addr;
>> +
>> +        while (orders) {
>> +            addr = vma->vm_end - (PAGE_SIZE << order);
>> +            if (thp_vma_suitable_orders(vma, addr, BIT(order)))
>> +                break;
> 
> Comment: you'd want a "thp_vma_suitable_order" helper here. But maybe the
> compiler is smart enough to optimize the loop and everyything else out.

I'm happy to refactor so that thp_vma_suitable_order() is the basic primitive,
then make thp_vma_suitable_orders() a loop that calls thp_vma_suitable_order()
(that's basically how it is laid out already, just all in one function). Is that
what you are requesting?

> 
> [...]
> 
>> +
>> +static ssize_t thpsize_enabled_store(struct kobject *kobj,
>> +                     struct kobj_attribute *attr,
>> +                     const char *buf, size_t count)
>> +{
>> +    int order = to_thpsize(kobj)->order;
>> +    ssize_t ret = count;
>> +
>> +    if (sysfs_streq(buf, "always")) {
>> +        set_bit(order, &huge_anon_orders_always);
>> +        clear_bit(order, &huge_anon_orders_inherit);
>> +        clear_bit(order, &huge_anon_orders_madvise);
>> +    } else if (sysfs_streq(buf, "inherit")) {
>> +        set_bit(order, &huge_anon_orders_inherit);
>> +        clear_bit(order, &huge_anon_orders_always);
>> +        clear_bit(order, &huge_anon_orders_madvise);
>> +    } else if (sysfs_streq(buf, "madvise")) {
>> +        set_bit(order, &huge_anon_orders_madvise);
>> +        clear_bit(order, &huge_anon_orders_always);
>> +        clear_bit(order, &huge_anon_orders_inherit);
>> +    } else if (sysfs_streq(buf, "never")) {
>> +        clear_bit(order, &huge_anon_orders_always);
>> +        clear_bit(order, &huge_anon_orders_inherit);
>> +        clear_bit(order, &huge_anon_orders_madvise);
> 
> Note: I was wondering for a second if some concurrent cames could lead to an
> inconsistent state. I think in the worst case we'll simply end up with "never"
> on races.

You mean if different threads try to write different values to this file
concurrently? Or if there is a concurrent fault that tries to read the flags
while they are being modified?

I thought about this for a long time too and wasn't sure what was best. The
existing global enabled store impl clears the bits first then sets the bit. With
this approach you can end up with multiple bits set if there is a race to set
diffierent values, and you can end up with a faulting thread seeing never if it
reads the bits after they have been cleared but before setting them.

I decided to set the new bit before clearing the old bits, which is different; A
racing fault will never see "never" but as you say, a race to set the file could
result in "never" being set.

On reflection, it's probably best to set the bit *last* like the global control
does?


> 
> [...]
> 
>>   static int __init hugepage_init_sysfs(struct kobject **hugepage_kobj)
>>   {
>>       int err;
>> +    struct thpsize *thpsize;
>> +    unsigned long orders;
>> +    int order;
>> +
>> +    /*
>> +     * Default to setting PMD-sized THP to inherit the global setting and
>> +     * disable all other sizes. powerpc's PMD_ORDER isn't a compile-time
>> +     * constant so we have to do this here.
>> +     */
>> +    huge_anon_orders_inherit = BIT(PMD_ORDER);
>>         *hugepage_kobj = kobject_create_and_add("transparent_hugepage", mm_kobj);
>>       if (unlikely(!*hugepage_kobj)) {
>> @@ -434,8 +631,24 @@ static int __init hugepage_init_sysfs(struct kobject
>> **hugepage_kobj)
>>           goto remove_hp_group;
>>       }
>>   +    orders = THP_ORDERS_ALL_ANON;
>> +    order = first_order(orders);
>> +    while (orders) {
>> +        thpsize = thpsize_create(order, *hugepage_kobj);
>> +        if (IS_ERR(thpsize)) {
>> +            pr_err("failed to create thpsize for order %d\n", order);
>> +            err = PTR_ERR(thpsize);
>> +            goto remove_all;
>> +        }
>> +        list_add(&thpsize->node, &thpsize_list);
>> +        order = next_order(&orders, order);
>> +    }
>> +
>>       return 0;
>>   
> 
> [...]
> 
>>       page = compound_head(page);
>> @@ -5116,7 +5116,8 @@ static vm_fault_t __handle_mm_fault(struct
>> vm_area_struct *vma,
>>           return VM_FAULT_OOM;
>>   retry_pud:
>>       if (pud_none(*vmf.pud) &&
>> -        hugepage_vma_check(vma, vm_flags, false, true, true)) {
>> +        thp_vma_allowable_orders(vma, vm_flags, false, true, true,
>> +                     BIT(PUD_ORDER))) {
>>           ret = create_huge_pud(&vmf);
>>           if (!(ret & VM_FAULT_FALLBACK))
>>               return ret;
>> @@ -5150,7 +5151,8 @@ static vm_fault_t __handle_mm_fault(struct
>> vm_area_struct *vma,
>>           goto retry_pud;
>>         if (pmd_none(*vmf.pmd) &&
>> -        hugepage_vma_check(vma, vm_flags, false, true, true)) {
>> +        thp_vma_allowable_orders(vma, vm_flags, false, true, true,
>> +                     BIT(PMD_ORDER))) {
> 
> Comment: A helper like "thp_vma_allowable_order(vma, PMD_ORDER)" might make this
> easier to read -- and the implemenmtation will be faster.

I'm happy to do this and use it to improve readability:

#define thp_vma_allowable_order(..., order) \
	thp_vma_allowable_orders(..., BIT(order))

This wouldn't make the implementation any faster though; Are you suggesting a
completely separate impl? Even then, I don't think there is much scope to make
it faster for the case where there is only 1 order in the bitfield.

> 
>>           ret = create_huge_pmd(&vmf);
>>           if (!(ret & VM_FAULT_FALLBACK))
>>               return ret;
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index e0b368e545ed..64da127cc267 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
>> @@ -268,7 +268,8 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>                * cleared *pmd but not decremented compound_mapcount().
>>                */
>>               if ((pvmw->flags & PVMW_SYNC) &&
>> -                transhuge_vma_suitable(vma, pvmw->address) &&
>> +                thp_vma_suitable_orders(vma, pvmw->address,
>> +                            BIT(PMD_ORDER)) &&
> 
> Comment: Similarly, a helper like "thp_vma_suitable_order(vma, PMD_ORDER)" might
> make this easier to read.

Yep, will do this.

> 
>>                   (pvmw->nr_pages >= HPAGE_PMD_NR)) {
>>                   spinlock_t *ptl = pmd_lock(mm, pvmw->pmd);
>>   
> 

