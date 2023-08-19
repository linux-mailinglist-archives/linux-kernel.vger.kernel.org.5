Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42676781925
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjHSKzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjHSKzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:55:53 -0400
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC6D3516A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 03:52:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vq56BWP_1692442360;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vq56BWP_1692442360)
          by smtp.aliyun-inc.com;
          Sat, 19 Aug 2023 18:52:41 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, shy828301@gmail.com, david@redhat.com,
        ying.huang@intel.com, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Extend migrate_misplaced_page() to support batch migration
Date:   Sat, 19 Aug 2023 18:52:33 +0800
Message-Id: <cover.1692440586.git.baolin.wang@linux.alibaba.com>
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

[1] https://lore.kernel.org/lkml/cover.1639306956.git.baolin.wang@linux.alibaba.com/t/#mc45929849b5d0e29b5fdd9d50425f8e95b8f2563
[2] https://lore.kernel.org/all/20230213123444.155149-1-ying.huang@intel.com/T/#u

Baolin Wang (4):
  mm: migrate: move migration validation into numa_migrate_prep()
  mm: migrate: move the numamigrate_isolate_page() into do_numa_page()
  mm: migrate: change migrate_misplaced_page() to support multiple pages
    migration
  mm: migrate: change to return the number of pages migrated
    successfully

 include/linux/migrate.h | 15 ++++++++---
 mm/huge_memory.c        | 19 +++++++++++---
 mm/memory.c             | 34 +++++++++++++++++++++++-
 mm/migrate.c            | 58 ++++++++---------------------------------
 4 files changed, 71 insertions(+), 55 deletions(-)

-- 
2.39.3

