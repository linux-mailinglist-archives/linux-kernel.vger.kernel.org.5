Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADEC07F1B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjKTRrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjKTRrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:47:33 -0500
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [IPv6:2001:41d0:203:375::ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BAEF5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:47:28 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700502446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dirg16X8IjWPdQeQGOiKGtH7xHuc5gOowsqXecWSLlM=;
        b=LrmT6z7BevrEOVmLW0g9//fbwyY1UogPCDw8xj/Xlc92kuYfZXlzWvlU+nKASw0KSd7GY+
        kD5OERtPjKafidVOi7TNebi8D7eNrTExLNbbWD6Ila0/S8nb06sDJQX7+FJZVc9EmXLfNE
        KI7cobYyoicYG6JJ416fOHwwFvor0uw=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v4 00/22] stackdepot: allow evicting stack traces
Date:   Mon, 20 Nov 2023 18:46:58 +0100
Message-Id: <cover.1700502145.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Currently, the stack depot grows indefinitely until it reaches its
capacity. Once that happens, the stack depot stops saving new stack
traces.

This creates a problem for using the stack depot for in-field testing
and in production.

For such uses, an ideal stack trace storage should:

1. Allow saving fresh stack traces on systems with a large uptime while
   limiting the amount of memory used to store the traces;
2. Have a low performance impact.

Implementing #1 in the stack depot is impossible with the current
keep-forever approach. This series targets to address that. Issue #2 is
left to be addressed in a future series.

This series changes the stack depot implementation to allow evicting
unneeded stack traces from the stack depot. The users of the stack depot
can do that via new stack_depot_save_flags(STACK_DEPOT_FLAG_GET) and
stack_depot_put APIs.

Internal changes to the stack depot code include:

1. Storing stack traces in fixed-frame-sized slots (vs precisely-sized
   slots in the current implementation); the slot size is controlled via
   CONFIG_STACKDEPOT_MAX_FRAMES (default: 64 frames);
2. Keeping available slots in a freelist (vs keeping an offset to the next
   free slot);
3. Using a read/write lock for synchronization (vs a lock-free approach
   combined with a spinlock).

This series also integrates the eviction functionality into KASAN:
the tag-based modes evict stack traces when the corresponding entry
leaves the stack ring, and Generic KASAN evicts stack traces for objects
once those leave the quarantine.

With KASAN, despite wasting some space on rounding up the size of each
stack record, the total memory consumed by stack depot gets saturated due
to the eviction of irrelevant stack traces from the stack depot.

With the tag-based KASAN modes, the average total amount of memory used
for stack traces becomes ~0.5 MB (with the current default stack ring size
of 32k entries and the default CONFIG_STACKDEPOT_MAX_FRAMES of 64). With
Generic KASAN, the stack traces take up ~1 MB per 1 GB of RAM (as the
quarantine's size depends on the amount of RAM).

However, with KMSAN, the stack depot ends up using ~4x more memory per a
stack trace than before. Thus, for KMSAN, the stack depot capacity is
increased accordingly. KMSAN uses a lot of RAM for shadow memory anyway,
so the increased stack depot memory usage will not make a significant
difference.

Other users of the stack depot do not save stack traces as often as KASAN
and KMSAN. Thus, the increased memory usage is taken as an acceptable
trade-off. In the future, these other users can take advantage of the
eviction API to limit the memory waste.

There is no measurable boot time performance impact of these changes for
KASAN on x86-64. I haven't done any tests for arm64 modes (the stack
depot without performance optimizations is not suitable for intended use
of those anyway), but I expect a similar result. Obtaining and copying
stack trace frames when saving them into stack depot is what takes the
most time.

This series does not yet provide a way to configure the maximum size of
the stack depot externally (e.g. via a command-line parameter). This will
be added in a separate series, possibly together with the performance
improvement changes.

---

Changes v3->v4:
- Rebase onto 6.7-rc2.
- Fix lockdep annotation in depot_fetch_stack.
- New patch: "kasan: use stack_depot_put for Generic mode" (was sent for
  review separately but now merged into this series).
- New patch: "lib/stackdepot: print disabled message only if truly
  disabled" (was sent for review separately but now merged into this
  series).
- New patch: "lib/stackdepot: adjust DEPOT_POOLS_CAP for KMSAN".

Changes v2->v3:
- Fix null-ptr-deref by using the proper number of entries for
  initializing the stack table when alloc_large_system_hash()
  auto-calculates the number (see patch #12).
- Keep STACKDEPOT/STACKDEPOT_ALWAYS_INIT Kconfig options not configurable
  by users.
- Use lockdep_assert_held_read annotation in depot_fetch_stack.
- WARN_ON invalid flags in stack_depot_save_flags.
- Moved "../slab.h" include in mm/kasan/report_tags.c in the right patch.
- Various comment fixes.

Changes v1->v2:
- Rework API to stack_depot_save_flags(STACK_DEPOT_FLAG_GET) +
  stack_depot_put.
- Add CONFIG_STACKDEPOT_MAX_FRAMES Kconfig option.
- Switch stack depot to using list_head's.
- Assorted minor changes, see the commit message for each path.

Andrey Konovalov (22):
  lib/stackdepot: print disabled message only if truly disabled
  lib/stackdepot: check disabled flag when fetching
  lib/stackdepot: simplify __stack_depot_save
  lib/stackdepot: drop valid bit from handles
  lib/stackdepot: add depot_fetch_stack helper
  lib/stackdepot: use fixed-sized slots for stack records
  lib/stackdepot: fix and clean-up atomic annotations
  lib/stackdepot: rework helpers for depot_alloc_stack
  lib/stackdepot: rename next_pool_required to new_pool_required
  lib/stackdepot: store next pool pointer in new_pool
  lib/stackdepot: store free stack records in a freelist
  lib/stackdepot: use read/write lock
  lib/stackdepot: use list_head for stack record links
  kmsan: use stack_depot_save instead of __stack_depot_save
  lib/stackdepot, kasan: add flags to __stack_depot_save and rename
  lib/stackdepot: add refcount for records
  lib/stackdepot: allow users to evict stack traces
  kasan: remove atomic accesses to stack ring entries
  kasan: check object_size in kasan_complete_mode_report_info
  kasan: use stack_depot_put for tag-based modes
  kasan: use stack_depot_put for Generic mode
  lib/stackdepot: adjust DEPOT_POOLS_CAP for KMSAN

 include/linux/stackdepot.h |  59 ++++-
 lib/Kconfig                |  10 +
 lib/stackdepot.c           | 452 ++++++++++++++++++++++++-------------
 mm/kasan/common.c          |   8 +-
 mm/kasan/generic.c         |  27 ++-
 mm/kasan/kasan.h           |   2 +-
 mm/kasan/quarantine.c      |  26 ++-
 mm/kasan/report_tags.c     |  27 +--
 mm/kasan/tags.c            |  24 +-
 mm/kmsan/core.c            |   7 +-
 10 files changed, 427 insertions(+), 215 deletions(-)

-- 
2.25.1

