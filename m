Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15B07FD4DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjK2LFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjK2LFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:05:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9320295
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:05:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FACD2F4;
        Wed, 29 Nov 2023 03:06:22 -0800 (PST)
Received: from [10.57.70.211] (unknown [10.57.70.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA7AA3F5A1;
        Wed, 29 Nov 2023 03:05:31 -0800 (PST)
Message-ID: <0641d171-731c-4c12-83c2-8212c63ffade@arm.com>
Date:   Wed, 29 Nov 2023 11:05:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v7 03/10] mm: thp: Introduce per-size thp sysfs
 interface
Content-Language: en-GB
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20231122162950.3854897-1-ryan.roberts@arm.com>
 <20231122162950.3854897-4-ryan.roberts@arm.com>
 <1a738e0a-ac11-4cd3-be2f-6b6e7cb4980a@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <1a738e0a-ac11-4cd3-be2f-6b6e7cb4980a@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2023 03:42, John Hubbard wrote:
> On 11/22/23 08:29, Ryan Roberts wrote:
>> In preparation for adding support for anonymous small-sized THP,
>> introduce new sysfs structure that will be used to control the new
>> behaviours. A new directory is added under transparent_hugepage for each
>> supported THP size, and contains an `enabled` file, which can be set to
>> "global" (to inherrit the global setting), "always", "madvise" or
>> "never". For now, the kernel still only supports PMD-sized anonymous
>> THP, so only 1 directory is populated.
>>
>> The first half of the change converts transhuge_vma_suitable() and
>> hugepage_vma_check() so that they take a bitfield of orders for which
>> the user wants to determine support, and the functions filter out all
>> the orders that can't be supported, given the current sysfs
>> configuration and the VMA dimensions. If there is only 1 order set in
>> the input then the output can continue to be treated like a boolean;
>> this is the case for most call sites.
>>
>> The second half of the change implements the new sysfs interface. It has
>> been done so that each supported THP size has a `struct thpsize`, which
>> describes the relevant metadata and is itself a kobject. This is pretty
>> minimal for now, but should make it easy to add new per-thpsize files to
>> the interface if needed in future (e.g. per-size defrag). Rather than
>> keep the `enabled` state directly in the struct thpsize, I've elected to
>> directly encode it into huge_anon_orders_[always|madvise|global]
>> bitfields since this reduces the amount of work required in
>> transhuge_vma_suitable() which is called for every page fault.
>>
>> The remainder is copied from Documentation/admin-guide/mm/transhuge.rst,
>> as modified by this commit. See that file for further details.
>>
>> Transparent Hugepage Support for anonymous memory can be entirely
>> disabled (mostly for debugging purposes) or only enabled inside
>> MADV_HUGEPAGE regions (to avoid the risk of consuming more memory
>> resources) or enabled system wide. This can be achieved
>> per-supported-THP-size with one of::
>>
>>     echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>>     echo madvise >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>>     echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>>
>> where <size> is the hugepage size being addressed, the available sizes
>> for which vary by system. Alternatively it is possible to specify that
>> a given hugepage size will inherrit the global enabled setting::
>>
>>     echo global >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>>
>> The global (legacy) enabled setting can be set as follows::
>>
>>     echo always >/sys/kernel/mm/transparent_hugepage/enabled
>>     echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
>>     echo never >/sys/kernel/mm/transparent_hugepage/enabled
>>
>> By default, PMD-sized hugepages have enabled="global" and all other
>> hugepage sizes have enabled="never". If enabling multiple hugepage
>> sizes, the kernel will select the most appropriate enabled size for a
>> given allocation.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   Documentation/admin-guide/mm/transhuge.rst |  74 ++++--
>>   Documentation/filesystems/proc.rst         |   6 +-
>>   fs/proc/task_mmu.c                         |   3 +-
>>   include/linux/huge_mm.h                    | 100 +++++---
>>   mm/huge_memory.c                           | 263 +++++++++++++++++++--
>>   mm/khugepaged.c                            |  16 +-
>>   mm/memory.c                                |   6 +-
>>   mm/page_vma_mapped.c                       |   3 +-
>>   8 files changed, 387 insertions(+), 84 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst
>> b/Documentation/admin-guide/mm/transhuge.rst
>> index b0cc8243e093..52565e0bd074 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -45,10 +45,23 @@ components:
>>      the two is using hugepages just because of the fact the TLB miss is
>>      going to run faster.
>>
>> +As well as PMD-sized THP described above, it is also possible to
>> +configure the system to allocate "small-sized THP" to back anonymous
> 
> Here's one of the places to change to the new name, which lately is
> "multi-size THP", or mTHP or m_thp for short. (I've typed "multi-size"
> instead of "multi-sized", because the 'd' doesn't add significantly to
> the meaning, and if in doubt, shorter is better.

I was thinking of some light changes to the start of this paragraph, something like:

Modern kernels support "multi-size THP" (mTHP), which introduces the ability to
allocate memory in blocks that are bigger than a base page but smaller than
traditional PMD-size (as described above, in increments of a power-of-2 number
of pages. mTHP can back anonymous

> 
> 
>> +memory (for example 16K, 32K, 64K, etc). These THPs continue to be
>> +PTE-mapped, but in many cases can still provide similar benefits to
>> +those outlined above: Page faults are significantly reduced (by a
>> +factor of e.g. 4, 8, 16, etc), but latency spikes are much less
>> +prominent because the size of each page isn't as huge as the PMD-sized
>> +variant and there is less memory to clear in each page fault. Some
>> +architectures also employ TLB compression mechanisms to squeeze more
>> +entries in when a set of PTEs are virtually and physically contiguous
>> +and approporiately aligned. In this case, TLB misses will occur less
>> +often.
>> +
> 
> OK, all of the above still seems like it can remain the same.
> 
>>   THP can be enabled system wide or restricted to certain tasks or even
>>   memory ranges inside task's address space. Unless THP is completely
>>   disabled, there is ``khugepaged`` daemon that scans memory and
>> -collapses sequences of basic pages into huge pages.
>> +collapses sequences of basic pages into PMD-sized huge pages.
>>
>>   The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
>>   interface and using madvise(2) and prctl(2) system calls.
>> @@ -95,12 +108,29 @@ Global THP controls
>>   Transparent Hugepage Support for anonymous memory can be entirely disabled
>>   (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
>>   regions (to avoid the risk of consuming more memory resources) or enabled
>> -system wide. This can be achieved with one of::
>> +system wide. This can be achieved per-supported-THP-size with one of::
>> +
>> +    echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>> +    echo madvise >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>> +    echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>> +
>> +where <size> is the hugepage size being addressed, the available sizes
>> +for which vary by system. Alternatively it is possible to specify that
>> +a given hugepage size will inherrit the global enabled setting::
> 
> typo: inherrit

ACK, will fix

> 
>> +
>> +    echo global >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
>> +
>> +The global (legacy) enabled setting can be set as follows::
>>
>>       echo always >/sys/kernel/mm/transparent_hugepage/enabled
>>       echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
>>       echo never >/sys/kernel/mm/transparent_hugepage/enabled
>>
>> +By default, PMD-sized hugepages have enabled="global" and all other
>> +hugepage sizes have enabled="never". If enabling multiple hugepage
>> +sizes, the kernel will select the most appropriate enabled size for a
>> +given allocation.
>> +
> 
> This is slightly murky. I wonder if "inherited" is a little more directly
> informative than global; it certainly felt that way my first time running
> this and poking at it.
> 
> And a few trivial examples would be a nice touch.
> 
> And so overall with a few other minor tweaks, I'd suggest this:
> 
> ...
> where <size> is the hugepage size being addressed, the available sizes
> for which vary by system.
> 
> For example:
>     echo always >/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> 
> Alternatively it is possible to specify that a given hugepage size will inherit
> the top-level "enabled" value:
> 
>     echo inherited >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/enabled
> 
> For example:
>     echo inherited >/sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> 
> The top-level setting (for use with "inherited") can be by issuing one of the
> following commands::
> 
>     echo always >/sys/kernel/mm/transparent_hugepage/enabled
>     echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
>     echo never >/sys/kernel/mm/transparent_hugepage/enabled
> 
> By default, PMD-sized hugepages have enabled="inherited" and all other
> hugepage sizes have enabled="never".

That all sounds good; will update.

I wonder if "inherit" is even better than "inherited" though?


> 
> 
>>   It's also possible to limit defrag efforts in the VM to generate
>>   anonymous hugepages in case they're not immediately free to madvise
>>   regions or to never try to defrag memory and simply fallback to regular
>> @@ -146,25 +176,34 @@ madvise
>>   never
>>       should be self-explanatory.
>>
>> -By default kernel tries to use huge zero page on read page fault to
>> -anonymous mapping. It's possible to disable huge zero page by writing 0
>> -or enable it back by writing 1::
>> +By default kernel tries to use huge, PMD-mappable zero page on read
>> +page fault to anonymous mapping. It's possible to disable huge zero
>> +page by writing 0 or enable it back by writing 1::
>>
>>       echo 0 >/sys/kernel/mm/transparent_hugepage/use_zero_page
>>       echo 1 >/sys/kernel/mm/transparent_hugepage/use_zero_page
>>
>> -Some userspace (such as a test program, or an optimized memory allocation
>> -library) may want to know the size (in bytes) of a transparent hugepage::
>> +Some userspace (such as a test program, or an optimized memory
>> +allocation library) may want to know the size (in bytes) of a
>> +PMD-mappable transparent hugepage::
>>
>>       cat /sys/kernel/mm/transparent_hugepage/hpage_pmd_size
>>
>> -khugepaged will be automatically started when
>> -transparent_hugepage/enabled is set to "always" or "madvise, and it'll
>> -be automatically shutdown if it's set to "never".
>> +khugepaged will be automatically started when one or more hugepage
>> +sizes are enabled (either by directly setting "always" or "madvise",
>> +or by setting "global" while the global enabled is set to "always" or
>> +"madvise"), and it'll be automatically shutdown when the last hugepage
>> +size is disabled (either by directly setting "never", or by setting
>> +"global" while the global enabled is set to "never").
>>
>>   Khugepaged controls
>>   -------------------
>>
>> +.. note::
>> +   khugepaged currently only searches for opportunities to collapse to
>> +   PMD-sized THP and no attempt is made to collapse to small-sized
>> +   THP.
>> +

"small-sized THP" used here too; I propose to change it to "... collapse to
other THP sizes."

>>   khugepaged runs usually at low frequency so while one may not want to
>>   invoke defrag algorithms synchronously during the page faults, it
>>   should be worth invoking defrag at least in khugepaged. However it's
>> @@ -282,10 +321,11 @@ force
>>   Need of application restart
>>   ===========================
>>
>> -The transparent_hugepage/enabled values and tmpfs mount option only affect
>> -future behavior. So to make them effective you need to restart any
>> -application that could have been using hugepages. This also applies to the
>> -regions registered in khugepaged.
>> +The transparent_hugepage/enabled and
>> +transparent_hugepage/hugepages-<size>kB/enabled values and tmpfs mount
>> +option only affect future behavior. So to make them effective you need
>> +to restart any application that could have been using hugepages. This
>> +also applies to the regions registered in khugepaged.
>>
>>   Monitoring usage
>>   ================
>> @@ -308,6 +348,10 @@ frequently will incur overhead.
>>   There are a number of counters in ``/proc/vmstat`` that may be used to
>>   monitor how successfully the system is providing huge pages for use.
>>
>> +.. note::
>> +   Currently the below counters only record events relating to
>> +   PMD-sized THP. Events relating to small-sized THP are not included.
> 
> Here's another spot to rename to "multi-size THP".

I propose to change it to "Events relating to other THP sizes..."

I'm also going to move this note to just under the "Monitoring Usage" heading
since its current position doesn't make it clear that it includes
"AnonHugePages". I'll also make it clear in the text that mentions AnonHugePages
counter that it "only applies to traditional PMD-sized THP for historical
reasons" and that "AnonHugePages should have been called AnonHugePmdMapped" as
David suggested in the other thread.

> 
>> +
>>   thp_fault_alloc
>>       is incremented every time a huge page is successfully
>>       allocated to handle a page fault.
>> @@ -413,7 +457,7 @@ for huge pages.
>>   Optimizing the applications
>>   ===========================
>>
>> -To be guaranteed that the kernel will map a 2M page immediately in any
>> +To be guaranteed that the kernel will map a THP immediately in any
>>   memory region, the mmap region has to be hugepage naturally
>>   aligned. posix_memalign() can provide that guarantee.
>>
>> diff --git a/Documentation/filesystems/proc.rst
>> b/Documentation/filesystems/proc.rst
>> index 49ef12df631b..f8e8dd1fd148 100644
>> --- a/Documentation/filesystems/proc.rst
>> +++ b/Documentation/filesystems/proc.rst
>> @@ -528,9 +528,9 @@ replaced by copy-on-write) part of the underlying shmem
>> object out on swap.
>>   does not take into account swapped out page of underlying shmem objects.
>>   "Locked" indicates whether the mapping is locked in memory or not.
>>
>> -"THPeligible" indicates whether the mapping is eligible for allocating THP
>> -pages as well as the THP is PMD mappable or not - 1 if true, 0 otherwise.
>> -It just shows the current status.
>> +"THPeligible" indicates whether the mapping is eligible for allocating
>> +naturally aligned THP pages of any currently enabled size. 1 if true, 0
>> +otherwise. It just shows the current status.
> 
> "It just shows the current status"...as opposed to what? I'm missing an
> educational opportunity here--not sure what this means. :)

I have no idea either - it seems superfluous. But that sentence was there
already. I can remove it if you like?

> 
>>
>>   "VmFlags" field deserves a separate description. This member represents the
>>   kernel flags associated with the particular virtual memory area in two letter
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 51e0ec658457..2e25362ca9fa 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -865,7 +865,8 @@ static int show_smap(struct seq_file *m, void *v)
>>       __show_smap(m, &mss, false);
>>
>>       seq_printf(m, "THPeligible:    %8u\n",
>> -           hugepage_vma_check(vma, vma->vm_flags, true, false, true));
>> +           !!hugepage_vma_check(vma, vma->vm_flags, true, false, true,
>> +                    THP_ORDERS_ALL));
>>
>>       if (arch_pkeys_enabled())
>>           seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index fa0350b0812a..7d6f7d96b039 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -67,6 +67,21 @@ extern struct kobj_attribute shmem_enabled_attr;
>>   #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>>   #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>>
>> +/*
>> + * Mask of all large folio orders supported for anonymous THP.
>> + */
>> +#define THP_ORDERS_ALL_ANON    BIT(PMD_ORDER)
>> +
>> +/*
>> + * Mask of all large folio orders supported for file THP.
>> + */
>> +#define THP_ORDERS_ALL_FILE    (BIT(PMD_ORDER) | BIT(PUD_ORDER))
> 
> Is there something about file THP that implies PUD_ORDER? This
> deserves an explanatory comment, I think.

Sorry, I'm not really sure what you are asking? Today's kernel supports
PUD-mapping file-backed memory (mostly DAX I believe). I'm not sure what comment
you want me to add, other than "file-backed memory can support PUD-mapping", but
that's self-evident from the define, isn't it?

> 
>> +
>> +/*
>> + * Mask of all large folio orders supported for THP.
>> + */
>> +#define THP_ORDERS_ALL        (THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_FILE)
>> +
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>   #define HPAGE_PMD_SHIFT PMD_SHIFT
>>   #define HPAGE_PMD_SIZE    ((1UL) << HPAGE_PMD_SHIFT)
>> @@ -78,13 +93,18 @@ extern struct kobj_attribute shmem_enabled_attr;
>>
>>   extern unsigned long transparent_hugepage_flags;
>>
>> -#define hugepage_flags_enabled()                           \
>> -    (transparent_hugepage_flags &                       \
>> -     ((1<<TRANSPARENT_HUGEPAGE_FLAG) |               \
>> -      (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
>> -#define hugepage_flags_always()                \
>> -    (transparent_hugepage_flags &            \
>> -     (1<<TRANSPARENT_HUGEPAGE_FLAG))
> 
> Are macros actually required? If not, static inlines would be nicer.

I agree static inlines are nicer. Here I'm removing existing macros though, and
replacing with a function prototype (hugepage_flags_enabled()), which is
implemented in huge_memory.c; this avoids having to export a bunch of global
variables from that file if it were to be static inline.

> 
>> +bool hugepage_flags_enabled(void);
>> +
>> +static inline int first_order(unsigned long orders)
>> +{
>> +    return fls_long(orders) - 1;
>> +}
>> +
>> +static inline int next_order(unsigned long *orders, int prev)
>> +{
>> +    *orders &= ~BIT(prev);
>> +    return first_order(*orders);
>> +}
>>
>>   /*
>>    * Do the below checks:
>> @@ -97,23 +117,39 @@ extern unsigned long transparent_hugepage_flags;
>>    *   - For all vmas, check if the haddr is in an aligned HPAGE_PMD_SIZE
>>    *     area.
>>    */
>> -static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>> -        unsigned long addr)
>> -{
>> -    unsigned long haddr;
>> -
>> -    /* Don't have to check pgoff for anonymous vma */
>> -    if (!vma_is_anonymous(vma)) {
>> -        if (!IS_ALIGNED((vma->vm_start >> PAGE_SHIFT) - vma->vm_pgoff,
>> -                HPAGE_PMD_NR))
>> -            return false;
>> +static inline unsigned long transhuge_vma_suitable(struct vm_area_struct *vma,
>> +        unsigned long addr, unsigned long orders)
> 
> Changing this from a bool to a mask of orders is quite significant, and
> both the function name and the function-level comment documentation need
> to also be adjusted. Here, perhaps one of these names would work:
> 
>         transhuge_vma_suitable_orders()

This is my preference, but its getting a bit long. How about:

	thp_vma_suitable_orders()

I could then call the other one:

	thp_vma_allowable_orders()

So we have a clearly related pair?


>         transhuge_vma_orders()>
> 
>> +{
>> +    int order;
>> +
>> +    /*
>> +     * Iterate over orders, highest to lowest, removing orders that don't
>> +     * meet alignment requirements from the set. Exit loop at first order
>> +     * that meets requirements, since all lower orders must also meet
>> +     * requirements.
> 
> Should we add a little note here, to the effect of, "this is unilaterally
> taking over a certain amount of allocation-like policy, by deciding how
> to search for folios of a certain size"?
> 
> Or is this The Only Way To Do It, after all? I know we had some discussion
> about it, and intuitively it feels reasonable, but wanted to poke at it
> one last time anyway.

This function isn't trying to implement policy, its just filtering out orders
that don't fit and therefore definitely cannot be used. The result is a set of
orders the could be used and its the policy maker's job to decide which one.
Currently that policy is "biggest one that fits && does not overlap other
non-none ptes && folio successfully allocated". That's implemented in the next
patch and would potentially be swapped out in the future for something more
exotic/optimal.

So I don't think we need any extra comments here.


> 
>> +     */
>> +
>> +    order = first_order(orders);
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
>> +        }
>> +
>> +        order = next_order(&orders, order);
>>       }
>>
>> -    haddr = addr & HPAGE_PMD_MASK;
>> -
>> -    if (haddr < vma->vm_start || haddr + HPAGE_PMD_SIZE > vma->vm_end)
>> -        return false;
>> -    return true;
>> +    return orders;
>>   }
>>
>>   static inline bool file_thp_enabled(struct vm_area_struct *vma)
>> @@ -130,8 +166,9 @@ static inline bool file_thp_enabled(struct vm_area_struct
>> *vma)
>>              !inode_is_open_for_write(inode) && S_ISREG(inode->i_mode);
>>   }
>>
>> -bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
>> -            bool smaps, bool in_pf, bool enforce_sysfs);
>> +unsigned long hugepage_vma_check(struct vm_area_struct *vma,
>> +                 unsigned long vm_flags, bool smaps, bool in_pf,
>> +                 bool enforce_sysfs, unsigned long orders);
>>
>>   #define transparent_hugepage_use_zero_page()                \
>>       (transparent_hugepage_flags &                    \
>> @@ -267,17 +304,18 @@ static inline bool folio_test_pmd_mappable(struct folio
>> *folio)
>>       return false;
>>   }
>>
>> -static inline bool transhuge_vma_suitable(struct vm_area_struct *vma,
>> -        unsigned long addr)
>> +static inline unsigned long transhuge_vma_suitable(struct vm_area_struct *vma,
>> +        unsigned long addr, unsigned long orders)
>>   {
>> -    return false;
>> +    return 0;
>>   }
>>
>> -static inline bool hugepage_vma_check(struct vm_area_struct *vma,
>> -                      unsigned long vm_flags, bool smaps,
>> -                      bool in_pf, bool enforce_sysfs)
>> +static inline unsigned long hugepage_vma_check(struct vm_area_struct *vma,
>> +                    unsigned long vm_flags, bool smaps,
>> +                    bool in_pf, bool enforce_sysfs,
>> +                    unsigned long orders)
>>   {
>> -    return false;
>> +    return 0;
>>   }
>>
>>   static inline void folio_prep_large_rmappable(struct folio *folio) {}
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 6eb55f97a3d2..0b545d56420c 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -74,12 +74,60 @@ static unsigned long deferred_split_scan(struct shrinker
>> *shrink,
>>   static atomic_t huge_zero_refcount;
>>   struct page *huge_zero_page __read_mostly;
>>   unsigned long huge_zero_pfn __read_mostly = ~0UL;
>> +static unsigned long huge_anon_orders_always __read_mostly;
>> +static unsigned long huge_anon_orders_madvise __read_mostly;
>> +static unsigned long huge_anon_orders_global __read_mostly;
>>
>> -bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
>> -            bool smaps, bool in_pf, bool enforce_sysfs)
>> +#define hugepage_global_enabled()            \
>> +    (transparent_hugepage_flags &            \
>> +     ((1<<TRANSPARENT_HUGEPAGE_FLAG) |        \
>> +      (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG)))
>> +
>> +#define hugepage_global_always()            \
>> +    (transparent_hugepage_flags &            \
>> +     (1<<TRANSPARENT_HUGEPAGE_FLAG))
>> +
> 
> Here again, I'd like to request that we avoid macros, as I don't think
> they are strictly required.

Yeah I agree. I did them this way, because they already existed and I was just
moving them from the header to here. But I'll change to static inline.

> 
>> +bool hugepage_flags_enabled(void)
>>   {
>> +    /*
>> +     * We cover both the anon and the file-backed case here; we must return
>> +     * true if globally enabled, even when all anon sizes are set to never.
>> +     * So we don't need to look at huge_anon_orders_global.
>> +     */
>> +    return hugepage_global_enabled() ||
>> +           huge_anon_orders_always ||
>> +           huge_anon_orders_madvise;
>> +}
>> +
>> +/**
>> + * hugepage_vma_check - determine which hugepage orders can be applied to vma
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
>> +unsigned long hugepage_vma_check(struct vm_area_struct *vma,
>> +                 unsigned long vm_flags, bool smaps, bool in_pf,
>> +                 bool enforce_sysfs, unsigned long orders)
> 
> Here again, a bool return type has been changed to a bitfield. Let's
> also update the function name. Maybe one of these:
> 
>         hugepage_vma_orders()
>         hugepage_vma_allowable_orders()

thp_vma_allowable_orders()?


Thanks for the review!

> 
> ?
> 
> 
> thanks,

