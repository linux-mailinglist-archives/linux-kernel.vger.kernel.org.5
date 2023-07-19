Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5138759773
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjGSNzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGSNzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:55:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3D5C19A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 06:55:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95FFC2F4;
        Wed, 19 Jul 2023 06:55:47 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9A253F6C4;
        Wed, 19 Jul 2023 06:55:02 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 0/3] Optimize large folio interaction with deferred split
Date:   Wed, 19 Jul 2023 14:54:47 +0100
Message-Id: <20230719135450.545227-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is v2 of a small series in support of my work to enable the use of large
folios for anonymous memory (known as "FLEXIBLE_THP" or "LARGE_ANON_FOLIO") [1].
It first makes it possible to add large, non-pmd-mappable folios to the deferred
split queue. Then it modifies zap_pte_range() to batch-remove spans of
physically contiguous pages from the rmap, which means that in the common case,
we elide the need to ever put the folio on the deferred split queue, thus
reducing lock contention and improving performance.

This becomes more visible once we have lots of large anonymous folios in the
system, and Huang Ying has suggested solving this needs to be a prerequisit for
merging the main FLEXIBLE_THP/LARGE_ANON_FOLIO work.

The series applies on top of v6.5-rc2 and a branch is available at [2].

I don't have a full test run with the latest versions of all the patches on top
of the latest baseline, so not posting results formally. I can get these if
people feel they are neccessary though. But anecdotally, for the kernel
compilation workload, this series reduces kernel time by ~4% and reduces
real-time by ~0.4%, compared with [1].

Changes since v1 [3]
--------------------

- patch 2: Modified doc comment for folio_remove_rmap_range()
- patch 2: Hoisted _nr_pages_mapped manipulation out of page loop so its now
  modified once per folio_remove_rmap_range() call.
- patch 2: Added check that page range is fully contained by folio in
  folio_remove_rmap_range()
- patch 2: Fixed some nits raised by Huang, Ying for folio_remove_rmap_range()
- patch 3: Support batch-zap of all anon pages, not just those in anon vmas
- patch 3: Renamed various functions to make their use clear
- patch 3: Various minor refactoring/cleanups
- Added Reviewed-By tags - thanks!

[1] https://lore.kernel.org/linux-mm/20230714160407.4142030-1-ryan.roberts@arm.com/
[2] https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/granule_perf/deferredsplit-lkml_v2
[3] https://lore.kernel.org/linux-mm/20230717143110.260162-1-ryan.roberts@arm.com/

Thanks,
Ryan


Ryan Roberts (3):
  mm: Allow deferred splitting of arbitrary large anon folios
  mm: Implement folio_remove_rmap_range()
  mm: Batch-zap large anonymous folio PTE mappings

 include/linux/rmap.h |   2 +
 mm/memory.c          | 120 +++++++++++++++++++++++++++++++++++++++++++
 mm/rmap.c            |  76 ++++++++++++++++++++++++++-
 3 files changed, 196 insertions(+), 2 deletions(-)

--
2.25.1

