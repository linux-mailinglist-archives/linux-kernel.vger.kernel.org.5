Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 708367EC895
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjKOQai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKOQag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:30:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F2A3A6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:30:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67F18DA7;
        Wed, 15 Nov 2023 08:31:18 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABB813F641;
        Wed, 15 Nov 2023 08:30:29 -0800 (PST)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
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
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/14] Transparent Contiguous PTEs for User Mappings
Date:   Wed, 15 Nov 2023 16:30:04 +0000
Message-Id: <20231115163018.1303287-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is v2 of a series to opportunistically and transparently use contpte
mappings (set the contiguous bit in ptes) for user memory when those mappings
meet the requirements. It is part of a wider effort to improve performance by
allocating and mapping variable-sized blocks of memory (folios). One aim is for
the 4K kernel to approach the performance of the 16K kernel, but without
breaking compatibility and without the associated increase in memory. Another
aim is to benefit the 16K and 64K kernels by enabling 2M THP, since this is the
contpte size for those kernels. We have good performance data that demonstrates
both aims are being met (see below).

Of course this is only one half of the change. We require the mapped physical
memory to be the correct size and alignment for this to actually be useful (i.e.
64K for 4K pages, or 2M for 16K/64K pages). Fortunately folios are solving this
problem for us. Filesystems that support it (XFS, AFS, EROFS, tmpfs, ...) will
allocate large folios up to the PMD size today, and more filesystems are coming.
And the other half of my work, to enable "small-sized THP" (large folios) for
anonymous memory, makes contpte sized folios prevalent for anonymous memory too
[2].

Optimistically, I would really like to get this series merged for v6.8; there is
a chance that the small-sized THP series will also get merged for that version.
But even if it doesn't, this series still benefits file-backed memory from the
file systems that support large folios so shouldn't be held up for it.
Additionally I've got data that shows this series adds no regression when the
system has no appropriate large folios.

All dependecies listed against v1 are now resolved; This series applies cleanly
against v6.7-rc1.

Note that the first patch is for core-mm and provides the refactoring to make a
crucial optimization possible - which is then implemented in patch 13. The
remaining patches are arm64-specific.

Testing
=======

I've tested this series together with small-sized THP [2] on both Ampere Altra
(bare metal) and Apple M2 (VM):
  - mm selftests (inc new tests written for small-sized THP); no regressions
  - Speedometer Java script benchmark in Chromium web browser; no issues
  - Kernel compilation; no issues
  - Various tests under high memory pressure with swap enabled; no issues


Performance
===========

John Hubbard at Nvidia has indicated dramatic 10x performance improvements for
some workloads at [3], when using 64K base page kernel.

You can also see the original performance results I posted against v1 [1] which
are still valid.

I've additionally run the kernel compilation and speedometer benchmarks on a
system with small-sized THP disabled and large folio support for file-backed
memory intentionally disabled; I see no change in performance in this case (i.e.
no regression when this change is "present but not useful").


Changes since v1
================

  - Export contpte_* symbols so that modules can continue to call inline
    functions (e.g. ptep_get) which may now call the contpte_* functions (thanks
    to JohnH)
  - Use pte_valid() instead of pte_present() where sensible (thanks to Catalin)
  - Factor out (pte_valid() && pte_cont()) into new pte_valid_cont() helper
    (thanks to Catalin)
  - Fixed bug in contpte_ptep_set_access_flags() where TLBIs were missed (thanks
    to Catalin)
  - Added ARM64_CONTPTE expert Kconfig (enabled by default) (thanks to Anshuman)
  - Simplified contpte_ptep_get_and_clear_full()
  - Improved various code comments


[1] https://lore.kernel.org/linux-arm-kernel/20230622144210.2623299-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-arm-kernel/20231115132734.931023-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/linux-mm/c507308d-bdd4-5f9e-d4ff-e96e4520be85@nvidia.com/


Thanks,
Ryan


Ryan Roberts (14):
  mm: Batch-copy PTE ranges during fork()
  arm64/mm: set_pte(): New layer to manage contig bit
  arm64/mm: set_ptes()/set_pte_at(): New layer to manage contig bit
  arm64/mm: pte_clear(): New layer to manage contig bit
  arm64/mm: ptep_get_and_clear(): New layer to manage contig bit
  arm64/mm: ptep_test_and_clear_young(): New layer to manage contig bit
  arm64/mm: ptep_clear_flush_young(): New layer to manage contig bit
  arm64/mm: ptep_set_wrprotect(): New layer to manage contig bit
  arm64/mm: ptep_set_access_flags(): New layer to manage contig bit
  arm64/mm: ptep_get(): New layer to manage contig bit
  arm64/mm: Split __flush_tlb_range() to elide trailing DSB
  arm64/mm: Wire up PTE_CONT for user mappings
  arm64/mm: Implement ptep_set_wrprotects() to optimize fork()
  arm64/mm: Add ptep_get_and_clear_full() to optimize process teardown

 arch/arm64/Kconfig                |  10 +-
 arch/arm64/include/asm/pgtable.h  | 325 +++++++++++++++++++---
 arch/arm64/include/asm/tlbflush.h |  13 +-
 arch/arm64/kernel/efi.c           |   4 +-
 arch/arm64/kernel/mte.c           |   2 +-
 arch/arm64/kvm/guest.c            |   2 +-
 arch/arm64/mm/Makefile            |   1 +
 arch/arm64/mm/contpte.c           | 447 ++++++++++++++++++++++++++++++
 arch/arm64/mm/fault.c             |  12 +-
 arch/arm64/mm/fixmap.c            |   4 +-
 arch/arm64/mm/hugetlbpage.c       |  40 +--
 arch/arm64/mm/kasan_init.c        |   6 +-
 arch/arm64/mm/mmu.c               |  16 +-
 arch/arm64/mm/pageattr.c          |   6 +-
 arch/arm64/mm/trans_pgd.c         |   6 +-
 include/linux/pgtable.h           |  13 +
 mm/memory.c                       | 175 +++++++++---
 17 files changed, 956 insertions(+), 126 deletions(-)
 create mode 100644 arch/arm64/mm/contpte.c

--
2.25.1

