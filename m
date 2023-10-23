Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BAF7D3C47
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjJWQXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjJWQXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:23:05 -0400
Received: from out-205.mta0.migadu.com (out-205.mta0.migadu.com [91.218.175.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3946DE4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:23:00 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698078177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hE8/xihIXcLGI8uaU/L34q0MmNF0Ny3eNAOyLz5owLs=;
        b=en6BEB2NL2TkfIZ+o5d1ARfK4S/MJ2EVXaSRfOwcHIC+VIjAnj5g0Y6cuUN98kV9kwFDmT
        j7o0G98RL+sezKiMqYGkyZRIp0E/6tdKgsZRBac3ovUz5AAb1SmV8jOb1lrg5LGLAFU5an
        /uiVY0J+58ucGMH80sj+fzrZvHg1EoE=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v3 00/19] stackdepot: allow evicting stack traces
Date:   Mon, 23 Oct 2023 18:22:31 +0200
Message-Id: <cover.1698077459.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

1. Storing stack traces in fixed-frame-sized slots; the slot size is
   controlled via CONFIG_STACKDEPOT_MAX_FRAMES (vs precisely-sized
   slots in the current implementation);
2. Keeping available slots in a freelist (vs keeping an offset to the next
   free slot);
3. Using a read/write lock for synchronization (vs a lock-free approach
   combined with a spinlock).

This series also integrates the eviction functionality in the tag-based
KASAN modes.

Despite wasting some space on rounding up the size of each stack record,
with CONFIG_STACKDEPOT_MAX_FRAMES=32, the tag-based KASAN modes end up
consuming ~5% less memory in stack depot during boot (with the default
stack ring size of 32k entries). The reason for this is the eviction of
irrelevant stack traces from the stack depot, which frees up space for
other stack traces.

For other tools that heavily rely on the stack depot, like Generic KASAN
and KMSAN, this change leads to the stack depot capacity being reached
sooner than before. However, as these tools are mainly used in fuzzing
scenarios where the kernel is frequently rebooted, this outcome should
be acceptable.

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

Andrey Konovalov (19):
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

 include/linux/stackdepot.h |  59 ++++--
 lib/Kconfig                |  10 +
 lib/stackdepot.c           | 418 ++++++++++++++++++++++++-------------
 mm/kasan/common.c          |   7 +-
 mm/kasan/generic.c         |   9 +-
 mm/kasan/kasan.h           |   2 +-
 mm/kasan/report_tags.c     |  27 +--
 mm/kasan/tags.c            |  24 ++-
 mm/kmsan/core.c            |   7 +-
 9 files changed, 365 insertions(+), 198 deletions(-)

-- 
2.25.1

