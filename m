Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96FC78DD0C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242953AbjH3Sre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbjH3Jub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:50:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5EFE1B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:50:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C95182F4;
        Wed, 30 Aug 2023 02:51:07 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C852A3F64C;
        Wed, 30 Aug 2023 02:50:25 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Will Deacon <will@kernel.org>,
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
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Optimize mmap_exit for large folios
Date:   Wed, 30 Aug 2023 10:50:06 +0100
Message-Id: <20230830095011.1228673-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is v2 of a series to improve performance of process teardown,
taking advantage of the fact that large folios are increasingly
regularly pte-mapped in user space; supporting filesystems already use
large folios for pagecache memory, and large folios for anonymous memory
are (hopefully) on the horizon.

See last patch for performance numbers, including measurements that show
this approach doesn't regress (and actually improves a little bit) when
all folios are small.

The basic approach is to accumulate contiguous ranges of pages in the
mmu_gather structure (instead of storing each individual page pointer),
then take advantage of this internal format to efficiently batch rmap
removal, swapcache removal and page release - see the commit messages
for more details.

This series replaces the previous approach I took at [2], which was much
smaller in scope, only attempting to batch rmap removal for anon pages.
Feedback was that I should do something more general that would also
batch-remove pagecache pages from the rmap. But while designing that, I
found it was also possible to improve swapcache removal and page
release. Hopefully I haven't gone too far the other way now! Note that
patch 1 is unchanged from that originl series.

Note that this series will conflict with Matthew's series at [3]. I
figure we both race to mm-unstable and the loser has to do the conflict
resolution?

This series is based on mm-unstable (b93868dbf9bc).


Changes since v1 [1]
--------------------

- Now using pfns for start and end of page ranges within a folio.
  `struct page`s may not be contiguous on some setups so using pointers
  breaks these systems. (Thanks to Zi Yan).
- Fixed zone_device folio reference putting. (Thanks to Matthew and
  David).
- Refactored release_pages() and folios_put_refs() so that they now
  share a common implementation.


[1] https://lore.kernel.org/linux-mm/20230810103332.3062143-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20230727141837.3386072-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/linux-mm/20230825135918.4164671-1-willy@infradead.org/


Thanks,
Ryan

Ryan Roberts (5):
  mm: Implement folio_remove_rmap_range()
  mm/mmu_gather: generalize mmu_gather rmap removal mechanism
  mm/mmu_gather: Remove encoded_page infrastructure
  mm: Refector release_pages()
  mm/mmu_gather: Store and process pages in contig ranges

 arch/s390/include/asm/tlb.h |   9 +-
 include/asm-generic/tlb.h   |  49 ++++-----
 include/linux/mm.h          |  11 +-
 include/linux/mm_types.h    |  34 +-----
 include/linux/rmap.h        |   2 +
 include/linux/swap.h        |   6 +-
 mm/memory.c                 |  24 +++--
 mm/mmu_gather.c             | 114 ++++++++++++++------
 mm/rmap.c                   | 125 ++++++++++++++++------
 mm/swap.c                   | 201 ++++++++++++++++++++++--------------
 mm/swap_state.c             |  11 +-
 11 files changed, 367 insertions(+), 219 deletions(-)

--
2.25.1

