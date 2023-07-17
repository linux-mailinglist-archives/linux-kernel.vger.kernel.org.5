Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1BF75665D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjGQObZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjGQObX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:31:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E4A4C0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:31:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B82DAC15;
        Mon, 17 Jul 2023 07:32:04 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6EF53F738;
        Mon, 17 Jul 2023 07:31:19 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 0/3] Optimize large folio interaction with deferred split
Date:   Mon, 17 Jul 2023 15:31:07 +0100
Message-Id: <20230717143110.260162-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is a small series in support of my work to enable the use of large folios
for anonymous memory (currently called "FLEXIBLE_THP") [1]. It first makes it
possible to add large, non-pmd-mappable folios to the deferred split queue. Then
it modifies zap_pte_range() to batch-remove spans of physically contiguous pages
from the rmap, which means that in the common case, we elide the need to ever
put the folio on the deferred split queue, thus reducing lock contention and
improving performance.

This becomes more visible once we have lots of large anonymous folios in the
system, and Huang Ying has suggested solving this needs to be a prerequisit for
merging the main FLEXIBLE_THP work.

The series applies on top of v6.5-rc2 and a branch is available at [2].

I don't have a full test run with the latest versions of all the patches on top
of the latest baseline, so not posting results formally. I can get these if
people feel they are neccessary though. But anecdotally, for the kernel
compilation workload, this series reduces kernel time by ~4% and reduces
real-time by ~0.4%, compared with [1].

[1] https://lore.kernel.org/linux-mm/20230714160407.4142030-1-ryan.roberts@arm.com/
[2] https://gitlab.arm.com/linux-arm/linux-rr/-/tree/features/granule_perf/deferredsplit-lkml_v1

Thanks,
Ryan


Ryan Roberts (3):
  mm: Allow deferred splitting of arbitrary large anon folios
  mm: Implement folio_remove_rmap_range()
  mm: Batch-zap large anonymous folio PTE mappings

 include/linux/rmap.h |   2 +
 mm/memory.c          | 119 +++++++++++++++++++++++++++++++++++++++++++
 mm/rmap.c            |  67 +++++++++++++++++++++++-
 3 files changed, 187 insertions(+), 1 deletion(-)

--
2.25.1

