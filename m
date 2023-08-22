Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B25278371D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 02:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjHVAyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 20:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjHVAyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 20:54:13 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3691183
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 17:54:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VqK0DOL_1692665646;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VqK0DOL_1692665646)
          by smtp.aliyun-inc.com;
          Tue, 22 Aug 2023 08:54:07 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, shy828301@gmail.com, david@redhat.com,
        ying.huang@intel.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Extend migrate_misplaced_page() to support batch migration
Date:   Tue, 22 Aug 2023 08:53:48 +0800
Message-Id: <cover.1692665449.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently, on our ARM servers with NUMA enabled, we found the cross-die latency
is a little larger that will significantly impact the workload's performance.
So on ARM servers we will rely on the NUMA balancing to avoid the cross-die
accessing. And I posted a patchset[1] to support speculative numa fault to
improve the NUMA balancing's performance according to the principle of data
locality. Moreover, thanks to Huang Ying's patchset[2], which introduced batch
migration as a way to reduce the cost of TLB flush, and it will also benefit
the migration of multiple pages all at once during NUMA balancing.

So we plan to continue to support batch migration in do_numa_page() to improve
the NUMA balancing's performance, but before adding complicated batch migration
algorithm for NUMA balancing, some cleanup and preparation work need to do firstly,
which are done in this patch set. In short, this patchset extends the
migrate_misplaced_page() interface to support batch migration, and no functional
changes intended.

In addition, these cleanup can also benefit the compound page's NUMA balancing,
which was discussed in previous thread[3]. IIUC, for the compound page's NUMA
balancing, it is possible that partial pages were successfully migrated, so it is
necessary to return the number of pages that were successfully migrated from
migrate_misplaced_page().

This series is based on the latest mm-unstable(d226b59b30cc).

[1] https://lore.kernel.org/lkml/cover.1639306956.git.baolin.wang@linux.alibaba.com/t/#mc45929849b5d0e29b5fdd9d50425f8e95b8f2563
[2] https://lore.kernel.org/all/20230213123444.155149-1-ying.huang@intel.com/T/#u
[3] https://lore.kernel.org/all/f8d47176-03a8-99bf-a813-b5942830fd73@arm.com/

Changes from v1:
 - Move page validation into a new function suggested by Huang Ying.
 - Change numamigrate_isolate_page() to boolean type.
 - Update some commit message.

Baolin Wang (4):
  mm: migrate: factor out migration validation into
    numa_page_can_migrate()
  mm: migrate: move the numamigrate_isolate_page() into do_numa_page()
  mm: migrate: change migrate_misplaced_page() to support multiple pages
    migration
  mm: migrate: change to return the number of pages migrated
    successfully

 include/linux/migrate.h | 15 +++++++---
 mm/huge_memory.c        | 23 +++++++++++++--
 mm/internal.h           |  1 +
 mm/memory.c             | 43 ++++++++++++++++++++++++++-
 mm/migrate.c            | 64 +++++++++--------------------------------
 5 files changed, 88 insertions(+), 58 deletions(-)

-- 
2.39.3

