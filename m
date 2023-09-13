Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4211479F008
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjIMROz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIMROy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:14:54 -0400
Received: from out-212.mta0.migadu.com (out-212.mta0.migadu.com [91.218.175.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61F3A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:14:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694625288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Gc6HzykR+A0L83xKMiWxb5E3eMlheJobgexoepcnfG0=;
        b=ODwSiHcis3mdddO8WgNkr0OX4CFlXGCtxXFw1qh2OkYCRDvsJp2kKgsnNbJ8Ge1HWYw6Gg
        qFyB7nW3syZF3lt4fEZE89uDLMmQd0mlYzmeI+kPXZAt1II6Wy6iHHDK6XeYOtxVHOkOq+
        EPv9hZtm5/AmnbNkbRVPkdVPGebLbzw=
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
Subject: [PATCH v2 00/19] stackdepot: allow evicting stack traces
Date:   Wed, 13 Sep 2023 19:14:25 +0200
Message-Id: <cover.1694625260.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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
 lib/Kconfig                |  10 +-
 lib/stackdepot.c           | 410 ++++++++++++++++++++++++-------------
 mm/kasan/common.c          |   7 +-
 mm/kasan/generic.c         |   9 +-
 mm/kasan/kasan.h           |   2 +-
 mm/kasan/report_tags.c     |  27 +--
 mm/kasan/tags.c            |  24 ++-
 mm/kmsan/core.c            |   7 +-
 9 files changed, 356 insertions(+), 199 deletions(-)

-- 
2.25.1

