Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AF17CC879
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234544AbjJQQNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjJQQNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:13:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F265E95
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 09:13:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D6AF2F4;
        Tue, 17 Oct 2023 09:13:55 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0463C3F762;
        Tue, 17 Oct 2023 09:13:12 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Swap-out small-sized THP without splitting
Date:   Tue, 17 Oct 2023 17:13:00 +0100
Message-Id: <20231017161302.2518826-1-ryan.roberts@arm.com>
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

This is v2 of a series to add support for swapping out small-sized THP without
needing to first split the large folio via __split_huge_page(). It closely
follows the approach already used by PMD-sized THP.

"Small-sized THP" is an upcoming feature that enables performance improvements
by allocating large folios for anonymous memory, where the large folio size is
smaller than the traditional PMD-size. See [2].

In some circumstances I've observed a performance regression (see patch 2 for
details), and this series is an attempt to fix the regression in advance of
merging small-sized THP support.

I've done what I thought was the smallest change possible, and as a result, this
approach is only employed when the swap is backed by a non-rotating block device
(just as PMD-sized THP is supported today). Discussion against the RFC concluded
that this is probably sufficient.

The series applies against mm-unstable (3fb06e6d0a6f)


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


[1] https://lore.kernel.org/linux-mm/20231010142111.3997780-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/linux-mm/15a52c3d-9584-449b-8228-1335e0753b04@arm.com/


Ryan Roberts (2):
  mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
  mm: swap: Swap-out small-sized THP without splitting

 include/linux/swap.h |  16 +++---
 mm/huge_memory.c     |   3 --
 mm/swapfile.c        | 119 ++++++++++++++++++++++++-------------------
 mm/vmscan.c          |  10 ++--
 4 files changed, 78 insertions(+), 70 deletions(-)

--
2.25.1

