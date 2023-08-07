Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D6E771ECF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjHGKvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjHGKvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9724BE76;
        Mon,  7 Aug 2023 03:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 341CB61783;
        Mon,  7 Aug 2023 10:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A77C433C7;
        Mon,  7 Aug 2023 10:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691405463;
        bh=DoqAUIdFfxDtVwWf/5SjDf8cZxhWlmX9gpkT5wfCSkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dlh8DsplC4Z8hYqkPtH9ov+kL/kd4AdHaDHEnwfKtPZqK9d0jko6CdLpScqtIP6/w
         dDpBJFuPlVqoU4BfnxucbDY1jB4cCLijqUB2m0cK/BFuznNaVUx9Jl1UWxg5rOb7uE
         gk94LXZemBWijXMILsW6adCHlNRt934fzt7pcgaoAM74Ss7ElpP62vAyTO9hEJqSOg
         IA4AQ4OTHmjbrTX4/fuK623f/BJCZWYSWKuuzeOaX0LCnWOMNH7Asc3HQDlxvRYVo+
         wZu+H1+ZjNoux5LE1lIk+HcuxpIX9CLJ/5aXA1R8cW2t1lglEVAfq948o6amGanRRp
         SLNs9QAg71cbQ==
Date:   Mon, 7 Aug 2023 13:50:10 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation/page_tables: Add info about MMU/TLB and
 Page Faults
Message-ID: <20230807105010.GK2607694@kernel.org>
References: <20230728120054.12306-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728120054.12306-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Fri, Jul 28, 2023 at 01:53:01PM +0200, Fabio M. De Francesco wrote:
> Extend page_tables.rst by adding a section about the role of MMU and TLB
> in translating between virtual addresses and physical page frames.
> Furthermore explain the concept behind Page Faults and how the Linux
> kernel handles TLB misses. Finally briefly explain how and why to disable
> the page faults handler.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> This has been an RFC PATCH in its 2nd version for a week or so. I received
> comments and suggestions on it from Jonathan Cameron (thanks!), and so it has
> now been modified to a real patch. I hope that other people want to add their
> comments on this document in order to further improve and extend it.
> 
> The link to the thread with the RFC PATCH v2 and the messages between Jonathan
> and me start at https://lore.kernel.org/all/20230723120721.7139-1-fmdefrancesco@gmail.com/#r
> 
>  Documentation/mm/page_tables.rst | 105 +++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/Documentation/mm/page_tables.rst b/Documentation/mm/page_tables.rst
> index 7840c1891751..6ecfd6d2f1f3 100644
> --- a/Documentation/mm/page_tables.rst
> +++ b/Documentation/mm/page_tables.rst
> @@ -152,3 +152,108 @@ Page table handling code that wishes to be architecture-neutral, such as the
>  virtual memory manager, will need to be written so that it traverses all of the
>  currently five levels. This style should also be preferred for
>  architecture-specific code, so as to be robust to future changes.
> +
> +
> +MMU, TLB, and Page Faults
> +=========================
> +
> +The `Memory Management Unit (MMU)` is a hardware component that handles virtual
> +to physical address translations. It may use relatively small caches in hardware
> +called `Translation Lookaside Buffers (TLBs)` and `Page Walk Caches` to speed up
> +these translations.
> +
> +When a process wants to access a memory location, the CPU provides a virtual
> +address to the MMU, which then uses the MMU to check access permissions and
> +dirty bits, and if possible it resolves the physical address and consents the
> +requested type of access to the corresponding physical address.

Essentially any access to a memory location involves the translation from
virtual to physical, not only when processes access memory.
I'd write this and the next paragraph as:

When CPU accesses a memory location, it  provides a virtual address to the
MMU, which checks if there is existing translation in TLB or in the Page
Walk Caches on architectures that support them. If no translation is found,
MMU uses the page tables to determine the physical address.

During the translation process, be it a cached translation or page table
walk, MMU checks the permissions and verifies that access is allowed.
If architecture supports accessed and dirty bits in the page tables, these
bits are updated in the page tables.

> +If the TLBs have not yet any recorded translations, the MMU may use the Page
> +Walk Caches and complete or restart the page tables walks until a physical
> +address can finally be resolved. Permissions and dirty bits are checked.
> +
> +In the context of a virtual memory system, like the one used by the Linux
> +kernel, each page of memory has associated permission and dirty bits.

The permissions and dirty (and accessed) bits should be introduced before
we mention them, or we can just presume that the reader knows what they are
or will check it elsewhere :)

> +The dirty bit for a page is set (i.e., turned on) when the page is written
> +to. This indicates that the page has been modified since it was loaded into
> +memory. It probably needs to be written on disk or other cores may need to
> +be informed about previous changes before allowing further operations.

I don't think there are architectures that require synchronization on dirty
bits.

> +If nothing prevents it, eventually the physical memory can be accessed and
> +the requested operation on the physical frame is performed.
> +
> +There are several reasons why the MMU can't find certain translations. It
> +could happen because the process is trying to access a range of memory that is

here as well, it's not necessarily a process.

> +not allowed to, or because the data is not present into RAM.
> +
> +When these conditions happen, the MMU triggers page faults, which are types
> +of exceptions that signal the CPU to pause the current process and run a special

                                        maybe current execution ^ 

> +function to handle the mentioned page faults.
> +
> +One cause of page faults is due to bugs (or maliciously crafted addresses) and
> +happens when a process tries to access a range of memory that it doesn't have
> +permission to. This could be because the memory is reserved for the kernel or
> +for another process, or because the process is trying to write to a read-only
> +section of memory. When this happens, the kernel sends a Segmentation Fault
> +(SIGSEGV) signal to the process, which usually causes the process to terminate.
> +
> +An expected and more common cause of page faults is an optimization called "lazy
> +allocation". This is a technique used by the Kernel to improve memory efficiency

                                              ^ no need in capital K

> +and reduce footprint. Instead of allocating physical memory to a process as soon
> +as it's requested, the Kernel waits until the process actually tries to use the
> +memory. This can save a significant amount of memory in cases where a process
> +requests a large block but only uses a small portion of it.
> +
> +A related technique is called "Copy-on-Write" (CoW), where the Kernel allows
> +multiple processes to share the same physical memory as long as they're only
> +reading from it. If a process tries to write to the shared memory, the kernel
> +triggers a page fault and allocates a separate copy of the memory for the
> +process. This allows the Kernel to save memory and avoid unnecessary data
> +copying and, by doing so, it reduces latency and space occupation.

I believe both lazy allocation and CoW descriptions better fit into Process
Addresses.

> +
> +Now, let's see how the Linux kernel handles these page faults:
> +
> +1. For most architectures, `do_page_fault()` is the primary interrupt handler
> +   for page faults. It delegates the actual handling of the page fault to
> +   `handle_mm_fault()`. This function checks the cause of the page fault and
> +   takes the appropriate action, such as loading the required page into
> +   memory, granting the process the necessary permissions, or sending a
> +   SIGSEGV signal to the process.
> +
> +2. In the specific case of the x86 architecture, the interrupt handler is
> +   defined by the `DEFINE_IDTENTRY_RAW_ERRORCODE()` macro, which calls
> +   `handle_page_fault()`. This function then calls either
> +   `do_user_addr_fault()` or `do_kern_addr_fault()`, depending on whether
> +   the fault occurred in user space or kernel space. Both of these functions
> +   eventually lead to `handle_mm_fault()`, similar to the workflow in other
> +   architectures.

I don't think it's important how the arch-specific page fault handlers are
defined. The important bits are that there is an architecture specific
exception handler that does initial processing of the page fault and calls
handle_mm_fault() which takes care of the generic page processing.

> +`handle_mm_fault()` (likely) ends up calling `__handle_mm_fault()` to carry

The unlikely bit actually generates SIGSEGV, so it would be nice to
describe that.

> +out the actual work of allocation of the page tables. It works by using
> +several functions to find the entry's offsets of the 4 - 5 layers of tables

Better to use 'upper' instead of '4-5'. __handle_mm_fault() never gets to
pte offset.

> +and allocate the tables it needs to. The functions that look for the offset
> +have names like `*_offset()`, where the "*" is for pgd, p4d, pud, pmd, pte;
> +instead the functions to allocate the corresponding tables, layer by layer,
> +are named `*_alloc`, with the above mentioned convention to name them after
> +the corresponding types of tables in the hierarchy.

It's worth mentioning that page table walk may end at one of the upper
layers if the memory is to be mapped with PMD or PUD.

> +At the very end of the walk with allocations, if it didn't return errors,
> +`__handle_mm_fault()` finally calls `handle_pte_fault()`, which via
> +`do_fault()` performs one of `do_read_fault()`, `do_cow_fault()`,
> +`do_shared_fault()`. "read", "cow", "shared" give hints about the reasons
> +and the kind of fault it's handling.
> +
> +The actual implementation of the workflow is very complex. Its design allows
> +Linux to handle page faults in a way that is tailored to the specific
> +characteristics of each architecture, while still sharing a common overall
> +structure.
> +
> +To conclude this brief overview from very high altitude of how Linux handles
> +page faults, let's add that page faults handler can be disabled and enabled
> +respectively with `pagefault_disable()` and `pagefault_enable()`.
> +
> +Several code path make use of the latter two functions because they need to
> +disable traps into the page faults handler, mostly to prevent deadlocks.[1]

I don't think this reference is needed here

> +
> +[1] mm/userfaultfd: Replace kmap/kmap_atomic() with kmap_local_page()
> +https://lore.kernel.org/all/20221025220136.2366143-1-ira.weiny@intel.com/
> -- 
> 2.41.0
> 

-- 
Sincerely yours,
Mike.
