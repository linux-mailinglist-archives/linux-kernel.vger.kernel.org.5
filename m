Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F77D79367C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjIFHm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjIFHm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:42:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3BFCC;
        Wed,  6 Sep 2023 00:42:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED41C433C8;
        Wed,  6 Sep 2023 07:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693986143;
        bh=NhKp71pBQ3K1MW2iDG6Uwy5Q0EJj7yAguOPdhP7Ds6E=;
        h=From:To:Cc:Subject:Date:From;
        b=QTXNpu0Ppe7vjC2wivikeqrWziXA3sRhA9aF/MN3DvnyOGoZH+td1Odg9Q3Jzsk5v
         1qxoEn7rK3/0kyCwxs5zEOjLGmtMg2KApOiyGFwhNTztWPMIH0vkOZHqjoUGAQlcAT
         TLQLj51dxsNGwG4SAi7RlY1lWpzps/wL5TTycZMvPM6bPm1t9ncxTLT3D92i2PDXrz
         Vwr7s6YtcBWqy48BRGn3qCiDfSaUITswYiTc4PDfXbzY5KR77Wm0keoq70zz9v4qR8
         USMzG5dmODcw9QqB2hYQdYidUs2GsrhT13RDTAWhtmT4/Ip2c2DkLVGRNFRsQEW4sn
         VrAsqMKfsIVag==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] docs/mm: Physical Memory: add "Memory map" section
Date:   Wed,  6 Sep 2023 10:42:10 +0300
Message-Id: <20230906074210.3051751-1-rppt@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Briefly describe memory map and add sub-sections for pages, folios and
ptdescs.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 Documentation/mm/physical_memory.rst | 338 ++++++++++++++++++++++++++-
 1 file changed, 332 insertions(+), 6 deletions(-)

diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
index 531e73b003dd..e3318897bf57 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -343,23 +343,349 @@ Zones
 
    This section is incomplete. Please list and describe the appropriate fields.
 
+.. _memmap:
+
+Memory map and memory descriptors
+=================================
+
+Every physical page frame in the systam has an associated descriptor which
+is used to keep track of its status. The collection of these descriptors is
+called `memory map` and it is arranged in one or more arrays, depending on
+the selection of the memory model. Memory models are described in more
+detail in Documentation/mm/memory-model.rst
+
+The basic memory descriptor is called :ref:`struct page <Pages>` and it is
+essentially a union of several structures, each representing a page frame
+metadata for a paricular usage.
+
+In many cases the entries in the memory map are not treated as `struct page`,
+but rather as different types of descriptors such as :ref:`struct folio
+<Folios>`, :ref:`struct ptdesc <ptdesc>` or `struct slab`.
+
 .. _pages:
 
 Pages
-=====
+-----
 
-.. admonition:: Stub
+`struct page` tracks status of a single physical page frame. This structure
+is a mixture of several types that represent metadata for different uses of
+a page frame. To save memory these types partially overlap so the `struct
+page` definition in ``include/linux/mm_types.h`` mixes scalar fields and
+unions of structures.
 
-   This section is incomplete. Please list and describe the appropriate fields.
+Common fields
+~~~~~~~~~~~~~
+
+``flags``
+  This field contains flags which describe the status of the page and
+  additional information about the page, like, for instance, zone, section
+  and node this page belongs to. Several flags determine how the page is
+  used, sometimes in combination with ``page_type`` field. Other flags
+  determine the state of the page, for instance if it is dirty or should be
+  reclaimed, what LRU list this page is on and many others.
+
+  All flags are declared in ``include/linux/page-flags.h``. There are a
+  number of macros defined for testing, clearing and setting the flags. Page
+  flags should not be accessed directly, but only using these macros.
+
+  The layout of the ``flags`` field depends on the kernel configuration. It
+  is affeted by selection of the memory model, section size for SPARSEMEM
+  without VMEMMAP, number of zone types, maximal number of nodes and other
+  build time parameters, such as ``CONFIG_NUMA_BALANCING``,
+  ``CONFIG_KASAN_SW_TAGS`` and ``CONFIG_LRU_GEN``.
+
+  For example, a kernel configured for 64-bit system with
+  SPARSEMEM_VMEMMAP, four zone types and maximum of 64 nodes and other
+  relevant options disabled layout of ``flags`` will be::
+
+    63   58 57  56 55                  23 22                      0
+    +------+------+----------------------+------------------------+
+    | node | zone |         ...          |         flags          |
+    +------+------+----------------------+------------------------+
+
+  And for the same configuration with enabled ``CONFIG_LRU_GEN`` and
+  ``CONFIG_NUMA_BALANCING`` it will be::
+
+    63   58 57  56 55    42 41     39 38      37 36  23 22        0
+    +------+------+--------+---------+----------+------+----------+
+    | node | zone | cpupid | lru_gen | lru_refs | ...  |  flags   |
+    +------+------+--------+---------+----------+------+----------+
+
+  For the exact details refer to ``include/linux/page-flags-layout.h`` and
+  ``include/linux/mmzone.h``.
+
+  Although in the above examples the page flags layout includes 23 flags,
+  their number may vary with different kernel configurations.
+
+``_refcount``
+  Usage count of the `struct page`. Should not be used directly. Use
+  accessors defined in ``include/linux/page_ref.h``.
+
+``memcg_data``
+  An opaque object used by memory cgroups. Defined only when
+  ``CONFIG_MEMCG`` is enabled.
+
+``virtual``
+  Virtual address in the kernel direct map. Will be ``NULL`` for highmem
+  pages. Only defined for some architectures.
+
+``kmsan_shadow``
+  KMSAN shadow page: every bit indicates whether the corresponding bit of
+  the original page is initialized (0) or not (1). Defined only when
+  ``CONFIG_KMSAN`` is enabled.
+
+``kmsan_origin``
+  KMSAN origin page: every 4 bytes contain an id of the stack trace where
+  the uninitialized value was created. Defined only when ``CONFIG_KMSAN``
+  is enabled.
+
+``_last_cpupid``
+  IDs of last CPU and last process that accessed the page. Only enabled if
+  there are not enough bits in the ``flags`` field.
+  Do not use directly, use accessors defined in ``include/linux/mm.h``
+
+Fields shared between multiple types
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+``_mapcount``
+  If the page can be mapped to userspace, encodes the number of times this
+  page is referenced by a page table.
+  Do not use directly, call page_mapcount().
+
+``page_type``
+  If the page is neither ``PageSlab`` nor mappable to userspace, the value
+  stored here may help determine what this page is used for. See
+  ``include/linux/page-flags.h`` for a list of page types which are
+  currently stored here.
+
+``rcu_head``
+  You can use this to free a page by RCU. Available for page table pages
+  and for page cache and anonymous pages not linked to any of the LRU
+  lists.
+
+Page cache and anonymous pages
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The following fields are used to link `struct page` to a linked list and
+they overlap with each other:
+
+``lru``
+  Linked list pointers for pages on LRU lists, for example active_list
+  protected by ``lruvec->lru_lock``. Sometimes used as a generic list by
+  the page owner.
+
+For pages on unevictable "LRU list" ``lru`` is overlayed with an anonymous
+struct containing two fields:
+
+``__filler``
+  A dummy field that must be always even to avoid conflict with compound
+  page encoding.
+
+``mlock_count``
+  Number of times the page has been pinned by mlock().
+
+Pages on free lists used by the page allocator are linked to the relevant
+list with eithter of the two below fields:
+
+``buddy_list``
+  Links the page to one of the free lists in the buddy allocator. Overlaps
+  with ``lru``.
+
+``pcp_list``
+  Links the page to a per-cpu free list. Overlaps with ``lru``.
+
+``mapping``
+  The file this page belongs to. Can be pagecache or swapcahe. For
+  anonymous memory refers to the `struct anon_vma`.
+  See also ``include/linux/page-flags.h`` for ``PAGE_MAPPING_FLAGS``
+
+``index``
+  Page offset within mapping. Overlaps with ``share``.
+
+``share``
+  Share count for fsdax. Overlaps with ``index``.
+
+``private``
+  Mapping-private opaque data. Usually used for buffer_heads if
+  PagePrivate. Used for swp_entry_t if PageSwapCache. Indicates order in
+  the buddy system if PageBuddy.
+
+Page pool
+~~~~~~~~~
+
+The following fields are used by
+`page_pool <Documentation/networking/page_pool.rst>`
+allocator used by the networking stack.
+
+``pp_magic``
+  Magic value to avoid recycling non page_pool allocated pages.
+
+``pp``
+  `struct page_pool` holding the page.
+
+``_pp_mapping_pad``
+  A padding to avoid collision of page_pool data with ``mapping``.
+
+``dma_addr``
+  DMAable address of the page.
+
+``dma_addr_upper``
+  Upper part of DMA address on 32-bit architectures that use 64-bit DMA
+  addressing. Overlaps with ``pp_frag_count``.
+
+``pp_frag_count``
+  Used by sub-page allocations in ``page_pool``. Not supported on 32-bit
+  architectures with 64-bit DMA addresses. Overlaps with ``dma_addr_upper``.
+
+Tail pages of compound page
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+``compound_head``
+  Pointer to the head page of compound page. Bit zero is always set for
+  tail pages and cleared for head pages.
+
+ZONE_DEVICE pages
+~~~~~~~~~~~~~~~~~
+
+``pgmap``
+  Points to the hosting device page map.
+
+``zone_device_data``
+  Private data used by the owning device.
 
 .. _folios:
 
 Folios
-======
+------
 
-.. admonition:: Stub
+`struct folio` represents a physically, virtually and logically contiguous
+set of bytes. It is a power-of-two in size, and it is aligned to that same
+power-of-two. It is at least as large as ``PAGE_SIZE``. If it is in the
+page cache, it is at a file offset which is a multiple of that
+power-of-two. It may be mapped into userspace at an address which is at an
+arbitrary page offset, but its kernel virtual address is aligned to its
+size.
 
-   This section is incomplete. Please list and describe the appropriate fields.
+`struct folio` occupies several consecutive entries in the memory map and
+has the following fields:
+
+``flags``
+  Identical to the page flags.
+
+``lru``
+  Least Recently Used list; tracks how recently this folio was used.
+
+``mlock_count``
+  Number of times this folio has been pinned by mlock().
+
+``mapping``
+  The file this page belongs to. Can be pagecache or swapcahe. For
+  anonymous memory refers to the `struct anon_vma`.
+
+``index``
+  Offset within the file, in units of pages. For anonymous memory, this is
+  the index from the beginning of the mmap.
+
+``private``
+  Filesystem per-folio data (see folio_attach_private()). Used for
+  ``swp_entry_t`` if folio is in the swap cache
+  (i.e. folio_test_swapcache() is true)
+
+``_mapcount``
+  Do not access this member directly. Use folio_mapcount() to find out how
+  many times this folio is mapped by userspace.
+
+``_refcount``
+  Do not access this member directly. Use folio_ref_count() to find how
+  many references there are to this folio.
+
+``memcg_data``
+  Memory Control Group data.
+
+``_folio_dtor``
+  Which destructor to use for this folio.
+
+``_folio_order``
+  The allocation order of a folio. Do not use directly, call folio_order().
+
+``_entire_mapcount``
+  How many times the entire folio is mapped as a single unit (for example
+  by a PMD or PUD entry). Does not include PTE-mapped subpages. This might
+  be useful for debugging, but to find out how many times the folio is
+  mapped look at folio_mapcount() or page_mapcount() or total_mapcount()
+  instead.
+  Do not use directly, call folio_entire_mapcount().
+
+``_nr_pages_mapped``
+  The total number of times the folio is mapped.
+  Do not use directly, call folio_mapcount().
+
+``_pincount``
+  Used to track pinning of the folio for DMA.
+  Do not use directly, call folio_maybe_dma_pinned().
+
+``_folio_nr_pages``
+  The number of pages in the folio.
+  Do not use directly, call folio_nr_pages().
+
+``_hugetlb_subpool``
+  HugeTLB subpool the folio beongs to.
+  Do not use directly, use accessor in ``include/linux/hugetlb.h``.
+
+``_hugetlb_cgroup``
+  Memory Control Group data for a HugeTLB folio.
+  Do not use directly, use accessor in ``include/linux/hugetlb_cgroup.h``.
+
+``_hugetlb_cgroup_rsvd``
+  Memory Control Group data for a HugeTLB folio.
+  Do not use directly, use accessor in ``include/linux/hugetlb_cgroup.h``.
+
+``_hugetlb_hwpoison``
+  List of failed (hwpoisoned) pages for a HugeTLB folio.
+  Do not use directly, call raw_hwp_list_head().
+
+``_deferred_list``
+  Folios to be split under memory pressure.
+
+.. _ptdesc:
+
+Page table descriptors
+----------------------
+
+`struct ptdesc` describes the pages used by page tables. It has the
+following fields:
+
+``_page_flags``
+  Same as page flags. Unused for page tables.
+
+``pt_rcu_head``
+  For freeing page table pages using RCU.
+
+``pt_list``
+  List of used page tables. Used for s390 and x86.
+
+``pmd_huge_pte``
+  Used by THP to track page tables that map huge pages. Protected by
+  ``ptdesc->ptl`` or ``mm->page_table_lock``, depending on values of
+  ``CONFIG_NR_CPUS`` and ``CONFIG_SPLIT_PTLOCK_CPUS`` configuration
+  options.
+
+``pt_mm``
+  Pointer to mm_struct owning the page table. Only used for PGDs on x86.
+
+``pt_frag_refcount``
+  For fragmented page table tracking. Used on Powerpc and s390 only.
+
+``ptl``
+  Page table lock. If the size of `spinlock_t` object is small enough the
+  lock is embedded in `struct ptdesc`, otherwise this field points to a
+  lock allocated for each page table page.
+
+``_refcount``
+  Same as page refcount. Used for s390 page tables.
+
+``pt_memcg_data``
+  Memcg data. Tracked for page tables here.
 
 .. _initialization:
 
-- 
2.39.2

