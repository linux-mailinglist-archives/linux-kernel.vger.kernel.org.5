Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48B87D6FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbjJYOqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjJYOp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:45:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 881CADC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:45:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7C432F4;
        Wed, 25 Oct 2023 07:46:37 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 896F53F64C;
        Wed, 25 Oct 2023 07:45:54 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3 0/4] Swap-out small-sized THP without splitting
Date:   Wed, 25 Oct 2023 15:45:42 +0100
Message-Id: <20231025144546.577640-1-ryan.roberts@arm.com>
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

This is v3 of a series to add support for swapping out small-sized THP without
needing to first split the large folio via __split_huge_page(). It closely
follows the approach already used by PMD-sized THP.

"Small-sized THP" is an upcoming feature that enables performance improvements
by allocating large folios for anonymous memory, where the large folio size is
smaller than the traditional PMD-size. See [3].

In some circumstances I've observed a performance regression (see patch 2 for
details), and this series is an attempt to fix the regression in advance of
merging small-sized THP support.

I've done what I thought was the smallest change possible, and as a result, this
approach is only employed when the swap is backed by a non-rotating block device
(just as PMD-sized THP is supported today). Discussion against the RFC concluded
that this is probably sufficient.

The series applies against mm-unstable (1a3c85fa684a)


Changes since v2 [2]
====================

 - Reuse scan_swap_map_try_ssd_cluster() between order-0 and order > 0
   allocation. This required some refactoring to make everything work nicely
   (new patches 2 and 3).
 - Fix bug where nr_swap_pages would say there are pages available but the
   scanner would not be able to allocate them because they were reserved for the
   per-cpu allocator. We now allow stealing of order-0 entries from the high
   order per-cpu clusters (in addition to exisiting stealing from order-0
   per-cpu clusters).

Thanks to Huang, Ying for the review feedback and suggestions!


Changes since v1 [1]
====================

 - patch 1:
    - Use cluster_set_count() instead of cluster_set_count_flag() in
      swap_alloc_cluster() since we no longer have any flag to set. I was unable
      to kill cluster_set_count_flag() as proposed against v1 as other call
      sites depend explicitly setting flags to 0.
 - patch 2:
    - Moved large_next[] array into percpu_cluster to make it per-cpu
      (recommended by Huang, Ying).
    - large_next[] array is dynamically allocated because PMD_ORDER is not
      compile-time constant for powerpc (fixes build error).


Thanks,
Ryan

P.S. I know we agreed this is not a prerequisite for merging small-sized THP,
but given Huang Ying had provided some review feedback, I wanted to progress it.
All the actual prerequisites are either complete or being worked on by others.


[1] https://lore.kernel.org/linux-mm/20231010142111.3997780-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/20231017161302.2518826-1-ryan.roberts@arm.com/
[3] https://lore.kernel.org/linux-mm/15a52c3d-9584-449b-8228-1335e0753b04@arm.com/


Ryan Roberts (4):
  mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
  mm: swap: Remove struct percpu_cluster
  mm: swap: Simplify ssd behavior when scanner steals entry
  mm: swap: Swap-out small-sized THP without splitting

 include/linux/swap.h |  31 +++---
 mm/huge_memory.c     |   3 -
 mm/swapfile.c        | 232 ++++++++++++++++++++++++-------------------
 mm/vmscan.c          |  10 +-
 4 files changed, 149 insertions(+), 127 deletions(-)

--
2.25.1

