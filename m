Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6C4793F1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241781AbjIFOlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjIFOlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:41:35 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DADE92;
        Wed,  6 Sep 2023 07:41:30 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1927D2BD;
        Wed,  6 Sep 2023 14:41:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1927D2BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1694011289; bh=P4XbTYrbyFVipsH3NpNDOMKLr6UvSvDqubSY9VraH4U=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=kwNQd2eoa27LZIjQJdoBdaB0Rt3iWhaGoCuDtNazb7YAvBTxl83nhhbDMLdbKYvAj
         NDRpmUuIGIth9nwSvE81/2U8KVhXilZQ/Dl3WGCDLiZVHa1A2YO8dEWM3n+CaCoDvt
         DKnMRzepW1wRQ1BZgO5nOVhsZ4le4pvIZiWbvTQe+HNYg1FmoV8bjjXCL3/Pm/Y2nx
         xxeghv7cxhG2fbfpnDCdpxfUIGn02nEz4tK2fToEIKKVT2GAx2E6/95st8PQIzQ6P9
         I1+aB4/C0xHMsqxupAG8jhVdPzQbrnJKcpFi1tN0QedKfSXIL9HIAQOk9XJKbXWBdc
         aLPSs8gvoOABg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] docs/mm: Physical Memory: add "Memory map" section
In-Reply-To: <20230906074210.3051751-1-rppt@kernel.org>
References: <20230906074210.3051751-1-rppt@kernel.org>
Date:   Wed, 06 Sep 2023 08:41:28 -0600
Message-ID: <87ledjgy93.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@kernel.org> writes:

> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Briefly describe memory map and add sub-sections for pages, folios and
> ptdescs.
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  Documentation/mm/physical_memory.rst | 338 ++++++++++++++++++++++++++-
>  1 file changed, 332 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
> index 531e73b003dd..e3318897bf57 100644
> --- a/Documentation/mm/physical_memory.rst
> +++ b/Documentation/mm/physical_memory.rst
> @@ -343,23 +343,349 @@ Zones
>  
>     This section is incomplete. Please list and describe the appropriate fields.
>  
> +.. _memmap:

Please, let's not clutter the docs with labels that are never used.  We
don't do that with code!

> +Memory map and memory descriptors
> +=================================
> +
> +Every physical page frame in the systam has an associated descriptor which
> +is used to keep track of its status. The collection of these descriptors is
> +called `memory map` and it is arranged in one or more arrays, depending on

*the* memory map

Also, why the `backtick quotes` ?  They don't have any particular
meaning to Sphinx here.

> +the selection of the memory model. Memory models are described in more
> +detail in Documentation/mm/memory-model.rst
> +
> +The basic memory descriptor is called :ref:`struct page <Pages>` and it is
> +essentially a union of several structures, each representing a page frame
> +metadata for a paricular usage.
> +
> +In many cases the entries in the memory map are not treated as `struct page`,
> +but rather as different types of descriptors such as :ref:`struct folio
> +<Folios>`, :ref:`struct ptdesc <ptdesc>` or `struct slab`.

I would hope that just saying "struct folio" would do the right thing;
did that not happen for you?

>  .. _pages:

I'd drop this label too

>  Pages
> -=====
> +-----
>  
> -.. admonition:: Stub
> +`struct page` tracks status of a single physical page frame. This structure

tracks *the* status

> +is a mixture of several types that represent metadata for different uses of
> +a page frame. To save memory these types partially overlap so the `struct
> +page` definition in ``include/linux/mm_types.h`` mixes scalar fields and
> +unions of structures.
>  
> -   This section is incomplete. Please list and describe the appropriate fields.
> +Common fields
> +~~~~~~~~~~~~~
> +
> +``flags``
> +  This field contains flags which describe the status of the page and
> +  additional information about the page, like, for instance, zone, section
> +  and node this page belongs to. Several flags determine how the page is
> +  used, sometimes in combination with ``page_type`` field. Other flags
> +  determine the state of the page, for instance if it is dirty or should be
> +  reclaimed, what LRU list this page is on and many others.
> +
> +  All flags are declared in ``include/linux/page-flags.h``. There are a
> +  number of macros defined for testing, clearing and setting the flags. Page
> +  flags should not be accessed directly, but only using these macros.

It would sure be nice if we had documentation for what all the flags
mean :)

> +  The layout of the ``flags`` field depends on the kernel configuration. It
> +  is affeted by selection of the memory model, section size for SPARSEMEM

affected

> +  without VMEMMAP, number of zone types, maximal number of nodes and other
> +  build time parameters, such as ``CONFIG_NUMA_BALANCING``,
> +  ``CONFIG_KASAN_SW_TAGS`` and ``CONFIG_LRU_GEN``.
> +
> +  For example, a kernel configured for 64-bit system with
> +  SPARSEMEM_VMEMMAP, four zone types and maximum of 64 nodes and other
> +  relevant options disabled layout of ``flags`` will be::
> +
> +    63   58 57  56 55                  23 22                      0
> +    +------+------+----------------------+------------------------+
> +    | node | zone |         ...          |         flags          |
> +    +------+------+----------------------+------------------------+
> +
> +  And for the same configuration with enabled ``CONFIG_LRU_GEN`` and
> +  ``CONFIG_NUMA_BALANCING`` it will be::
> +
> +    63   58 57  56 55    42 41     39 38      37 36  23 22        0
> +    +------+------+--------+---------+----------+------+----------+
> +    | node | zone | cpupid | lru_gen | lru_refs | ...  |  flags   |
> +    +------+------+--------+---------+----------+------+----------+
> +
> +  For the exact details refer to ``include/linux/page-flags-layout.h`` and
> +  ``include/linux/mmzone.h``.
> +
> +  Although in the above examples the page flags layout includes 23 flags,
> +  their number may vary with different kernel configurations.
> +
> +``_refcount``
> +  Usage count of the `struct page`. Should not be used directly. Use
> +  accessors defined in ``include/linux/page_ref.h``.
> +
> +``memcg_data``
> +  An opaque object used by memory cgroups. Defined only when
> +  ``CONFIG_MEMCG`` is enabled.
> +
> +``virtual``
> +  Virtual address in the kernel direct map. Will be ``NULL`` for highmem
> +  pages. Only defined for some architectures.

I'd say virtual is absent more often than present anymore, right?
Perhaps it's worth being more explicit about that.  And maybe say to use
page_address() rather than accessing it directly?

> +``kmsan_shadow``
> +  KMSAN shadow page: every bit indicates whether the corresponding bit of
> +  the original page is initialized (0) or not (1). Defined only when
> +  ``CONFIG_KMSAN`` is enabled.
> +
> +``kmsan_origin``
> +  KMSAN origin page: every 4 bytes contain an id of the stack trace where
> +  the uninitialized value was created. Defined only when ``CONFIG_KMSAN``
> +  is enabled.
> +
> +``_last_cpupid``
> +  IDs of last CPU and last process that accessed the page. Only enabled if
> +  there are not enough bits in the ``flags`` field.
> +  Do not use directly, use accessors defined in ``include/linux/mm.h``
> +
> +Fields shared between multiple types
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +``_mapcount``
> +  If the page can be mapped to userspace, encodes the number of times this
> +  page is referenced by a page table.
> +  Do not use directly, call page_mapcount().

Have we figured out what mapcount really means yet? :)

> +``page_type``
> +  If the page is neither ``PageSlab`` nor mappable to userspace, the value
> +  stored here may help determine what this page is used for. See
> +  ``include/linux/page-flags.h`` for a list of page types which are
> +  currently stored here.
> +
> +``rcu_head``
> +  You can use this to free a page by RCU. Available for page table pages
> +  and for page cache and anonymous pages not linked to any of the LRU
> +  lists.
> +
> +Page cache and anonymous pages
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The following fields are used to link `struct page` to a linked list and
> +they overlap with each other:
> +
> +``lru``
> +  Linked list pointers for pages on LRU lists, for example active_list
> +  protected by ``lruvec->lru_lock``. Sometimes used as a generic list by
> +  the page owner.
> +
> +For pages on unevictable "LRU list" ``lru`` is overlayed with an anonymous
> +struct containing two fields:
> +
> +``__filler``
> +  A dummy field that must be always even to avoid conflict with compound
> +  page encoding.

Do we care about the constraints on this field's contents?  Presumably
that is taken care of somewhere and nobody should mess with it?

> +``mlock_count``
> +  Number of times the page has been pinned by mlock().
> +
> +Pages on free lists used by the page allocator are linked to the relevant
> +list with eithter of the two below fields:

Spellcheckers are your friend :)

> +``buddy_list``
> +  Links the page to one of the free lists in the buddy allocator. Overlaps
> +  with ``lru``.
> +
> +``pcp_list``
> +  Links the page to a per-cpu free list. Overlaps with ``lru``.
> +
> +``mapping``
> +  The file this page belongs to. Can be pagecache or swapcahe. For
> +  anonymous memory refers to the `struct anon_vma`.
> +  See also ``include/linux/page-flags.h`` for ``PAGE_MAPPING_FLAGS``

It seems like putting in the types for fields like this would be useful;
readers of the HTML docs can then follow the links and see what is
actually pointed to.

> +``index``
> +  Page offset within mapping. Overlaps with ``share``.
> +
> +``share``
> +  Share count for fsdax. Overlaps with ``index``.
> +
> +``private``
> +  Mapping-private opaque data. Usually used for buffer_heads if
> +  PagePrivate. Used for swp_entry_t if PageSwapCache. Indicates order in
> +  the buddy system if PageBuddy.
> +
> +Page pool
> +~~~~~~~~~
> +
> +The following fields are used by
> +`page_pool <Documentation/networking/page_pool.rst>`
> +allocator used by the networking stack.
> +
> +``pp_magic``
> +  Magic value to avoid recycling non page_pool allocated pages.
> +
> +``pp``
> +  `struct page_pool` holding the page.
> +
> +``_pp_mapping_pad``
> +  A padding to avoid collision of page_pool data with ``mapping``.
> +
> +``dma_addr``
> +  DMAable address of the page.
> +
> +``dma_addr_upper``
> +  Upper part of DMA address on 32-bit architectures that use 64-bit DMA
> +  addressing. Overlaps with ``pp_frag_count``.
> +
> +``pp_frag_count``
> +  Used by sub-page allocations in ``page_pool``. Not supported on 32-bit
> +  architectures with 64-bit DMA addresses. Overlaps with ``dma_addr_upper``.
> +
> +Tail pages of compound page
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +``compound_head``
> +  Pointer to the head page of compound page. Bit zero is always set for
> +  tail pages and cleared for head pages.
> +
> +ZONE_DEVICE pages
> +~~~~~~~~~~~~~~~~~
> +
> +``pgmap``
> +  Points to the hosting device page map.
> +
> +``zone_device_data``
> +  Private data used by the owning device.
>  
>  .. _folios:
>  
>  Folios
> -======
> +------

As Willy said, linking to the existing docs might be better here.

> -.. admonition:: Stub
> +`struct folio` represents a physically, virtually and logically contiguous
> +set of bytes. It is a power-of-two in size, and it is aligned to that same
> +power-of-two. It is at least as large as ``PAGE_SIZE``. If it is in the
> +page cache, it is at a file offset which is a multiple of that
> +power-of-two. It may be mapped into userspace at an address which is at an
> +arbitrary page offset, but its kernel virtual address is aligned to its
> +size.
>  
> -   This section is incomplete. Please list and describe the appropriate fields.
> +`struct folio` occupies several consecutive entries in the memory map and
> +has the following fields:
> +
> +``flags``
> +  Identical to the page flags.
> +
> +``lru``
> +  Least Recently Used list; tracks how recently this folio was used.
> +
> +``mlock_count``
> +  Number of times this folio has been pinned by mlock().
> +
> +``mapping``
> +  The file this page belongs to. Can be pagecache or swapcahe. For
> +  anonymous memory refers to the `struct anon_vma`.
> +
> +``index``
> +  Offset within the file, in units of pages. For anonymous memory, this is
> +  the index from the beginning of the mmap.
> +
> +``private``
> +  Filesystem per-folio data (see folio_attach_private()). Used for
> +  ``swp_entry_t`` if folio is in the swap cache
> +  (i.e. folio_test_swapcache() is true)
> +
> +``_mapcount``
> +  Do not access this member directly. Use folio_mapcount() to find out how
> +  many times this folio is mapped by userspace.
> +
> +``_refcount``
> +  Do not access this member directly. Use folio_ref_count() to find how
> +  many references there are to this folio.
> +
> +``memcg_data``
> +  Memory Control Group data.
> +
> +``_folio_dtor``
> +  Which destructor to use for this folio.
> +
> +``_folio_order``
> +  The allocation order of a folio. Do not use directly, call folio_order().
> +
> +``_entire_mapcount``
> +  How many times the entire folio is mapped as a single unit (for example
> +  by a PMD or PUD entry). Does not include PTE-mapped subpages. This might
> +  be useful for debugging, but to find out how many times the folio is
> +  mapped look at folio_mapcount() or page_mapcount() or total_mapcount()
> +  instead.
> +  Do not use directly, call folio_entire_mapcount().
> +
> +``_nr_pages_mapped``
> +  The total number of times the folio is mapped.
> +  Do not use directly, call folio_mapcount().
> +
> +``_pincount``
> +  Used to track pinning of the folio for DMA.
> +  Do not use directly, call folio_maybe_dma_pinned().
> +
> +``_folio_nr_pages``
> +  The number of pages in the folio.
> +  Do not use directly, call folio_nr_pages().
> +
> +``_hugetlb_subpool``
> +  HugeTLB subpool the folio beongs to.
> +  Do not use directly, use accessor in ``include/linux/hugetlb.h``.
> +
> +``_hugetlb_cgroup``
> +  Memory Control Group data for a HugeTLB folio.
> +  Do not use directly, use accessor in ``include/linux/hugetlb_cgroup.h``.
> +
> +``_hugetlb_cgroup_rsvd``
> +  Memory Control Group data for a HugeTLB folio.
> +  Do not use directly, use accessor in ``include/linux/hugetlb_cgroup.h``.
> +
> +``_hugetlb_hwpoison``
> +  List of failed (hwpoisoned) pages for a HugeTLB folio.
> +  Do not use directly, call raw_hwp_list_head().
> +
> +``_deferred_list``
> +  Folios to be split under memory pressure.
> +
> +.. _ptdesc:
> +
> +Page table descriptors
> +----------------------
> +
> +`struct ptdesc` describes the pages used by page tables. It has the
> +following fields:
> +
> +``_page_flags``
> +  Same as page flags. Unused for page tables.
> +
> +``pt_rcu_head``
> +  For freeing page table pages using RCU.
> +
> +``pt_list``
> +  List of used page tables. Used for s390 and x86.
> +
> +``pmd_huge_pte``
> +  Used by THP to track page tables that map huge pages. Protected by
> +  ``ptdesc->ptl`` or ``mm->page_table_lock``, depending on values of
> +  ``CONFIG_NR_CPUS`` and ``CONFIG_SPLIT_PTLOCK_CPUS`` configuration
> +  options.
> +
> +``pt_mm``
> +  Pointer to mm_struct owning the page table. Only used for PGDs on x86.
> +
> +``pt_frag_refcount``
> +  For fragmented page table tracking. Used on Powerpc and s390 only.
> +
> +``ptl``
> +  Page table lock. If the size of `spinlock_t` object is small enough the
> +  lock is embedded in `struct ptdesc`, otherwise this field points to a
> +  lock allocated for each page table page.
> +
> +``_refcount``
> +  Same as page refcount. Used for s390 page tables.
> +
> +``pt_memcg_data``
> +  Memcg data. Tracked for page tables here.

It's good to see this documentation being filled in!

An overall concern that comes to mind is that you're documenting
something that is very much a moving target.  It's already a bit of an
awkward fit with the page types that have been split out into their own
structures, and will become more so as that work proceeds.  The document
seems likely to go out of date quickly.

I wonder if it might be better to structure it as if the splitting of
struct page were already complete, with a section for each page
descriptor type, even the ones that don't exist as separate entities
yet?  Maybe that would make it easier for people to keep it current as
they hack pieces out of struct page?

Just a thought.

Thanks,

jon
