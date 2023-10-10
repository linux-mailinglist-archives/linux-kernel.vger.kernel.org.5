Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497FB7BFF0A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjJJOV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjJJOV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:21:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE3FBF5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:21:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F08071FB;
        Tue, 10 Oct 2023 07:22:03 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE8D43F762;
        Tue, 10 Oct 2023 07:21:21 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH v1 0/2] Swap-out small-sized THP without splitting
Date:   Tue, 10 Oct 2023 15:21:09 +0100
Message-Id: <20231010142111.3997780-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is an RFC for a small series to add support for swapping out small-sized
THP without needing to first split the large folio via __split_huge_page(). It
closely follows the approach already used by PMD-sized THP.

"Small-sized THP" is an upcoming feature that enables performance improvements
by allocating large folios for anonymous memory, where the large folio size is
smaller than the traditional PMD-size. See [1].

In some circumstances I've observed a performance regression (see patch 2 for
details), and this series is an attempt to fix the regression in advance of
merging small-sized THP support.

I've done what I thought was the smallest change possible, and as a result, this
approach is only employed when the swap is backed by a non-rotating block device
(just as PMD-sized THP is supported today). However, I have a few questions on
whether we should consider relaxing those requirements in certain circumstances:


1) block-backed vs file-backed
==============================

The code only attempts to allocate a contiguous set of entries if swap is backed
by a block device (i.e. not file-backed). The original commit, f0eea189e8e9
("mm, THP, swap: don't allocate huge cluster for file backed swap device"),
stated "It's hard to write a whole transparent huge page (THP) to a file backed
swap device". But didn't state why. Does this imply there is a size limit at
which it becomes hard? And does that therefore imply that for "small enough"
sizes we should now allow use with file-back swap?

This original commit was subsequently fixed with commit 41663430588c ("mm, THP,
swap: fix allocating cluster for swapfile by mistake"), which said the original
commit was using the wrong flag to determine if it was a block device and
therefore in some cases was actually doing large allocations for a file-backed
swap device, and this was causing file-system corruption. But that implies some
sort of correctness issue to me, rather than the performance issue I inferred
from the original commit.

If anyone can offer an explanation, that would be helpful in determining if we
should allow some large sizes for file-backed swap.


2) rotating vs non-rotating
===========================

I notice that the clustered approach is only used for non-rotating swap. That
implies that for rotating media, we will always fail a large allocation, and
fall back to splitting THPs to single pages. Which implies that the regression
I'm fixing here may still be present on rotating media? Or perhaps rotating disk
is so slow that the cost of writing the data out dominates the cost of
splitting?

I considered that potentially the free swap entry search algorithm that is used
in this case could be modified to look for (small) contiguous runs of entries;
Up to ~16 pages (order-4) could be done by doing 2x 64bit reads from map instead
of single byte.

I haven't looked into this idea in detail, but wonder if anybody thinks it is
worth the effort? Or perhaps it would end up causing bad fragmentation.


Finally on testing, I've run the mm selftests and see no regressions, but I
don't think there is anything in there specifically aimed towards swap? Are
there any functional or performance tests that I should run? It would certainly
be good to confirm I haven't regressed PMD-size THP swap performance.

Thanks,
Ryan

[1] https://lore.kernel.org/linux-mm/15a52c3d-9584-449b-8228-1335e0753b04@arm.com/

Ryan Roberts (2):
  mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
  mm: swap: Swap-out small-sized THP without splitting

 include/linux/swap.h |  17 +++----
 mm/huge_memory.c     |   3 --
 mm/swapfile.c        | 105 ++++++++++++++++++++++---------------------
 mm/vmscan.c          |  10 +++--
 4 files changed, 66 insertions(+), 69 deletions(-)

--
2.25.1

