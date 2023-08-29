Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4E478CA67
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbjH2RMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbjH2RLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:11:42 -0400
X-Greylist: delayed 140373 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Aug 2023 10:11:37 PDT
Received: from out-251.mta1.migadu.com (out-251.mta1.migadu.com [95.215.58.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03912113
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:11:36 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693329095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4p8eo+KqdaDj4APbJngGg5i5hNM+Az1Zd3d9hROUHxc=;
        b=dnT146MfGXO/FX/5OU0nnhGox5bH9Q9iL3wR8QzreWKi8HM6ftxenQbNh0giCupLWbBvZ3
        yrtJFrQqJMbwnzOPm1V30EMbaXRjHIUhQydgFATDwvyKhMPATQoGC3i906ED2ejiv5kKAp
        3LsU6hfXBzBqwgYR0HkngXLEuukvWWo=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 00/15] stackdepot: allow evicting stack traces
Date:   Tue, 29 Aug 2023 19:11:10 +0200
Message-Id: <cover.1693328501.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
can do that via a new stack_depot_evict API.

Internal changes to the stack depot code include:

1. Storing stack traces in 32-frame-sized slots (vs precisely-sized slots
   in the current implementation);
2. Keeping available slots in a freelist (vs keeping an offset to the next
   free slot);
3. Using a read/write lock for synchronization (vs a lock-free approach
   combined with a spinlock).

This series also integrates the eviction functionality in the tag-based
KASAN modes. (I will investigate integrating it into the Generic mode as
well in the following iterations of this series.)

Despite wasting some space on rounding up the size of each stack record
to 32 frames, with this change, the tag-based KASAN modes end up
consuming ~5% less memory in stack depot during boot (with the default
stack ring size of 32k entries). The reason for this is the eviction of
irrelevant stack traces from the stack depot, which frees up space for
other stack traces.

For other tools that heavily rely on the stack depot, like Generic KASAN
and KMSAN, this change leads to the stack depot capacity being reached
sooner than before. However, as these tools are mainly used in fuzzing
scenarios where the kernel is frequently rebooted, this outcome should
be acceptable.

There is no measurable boot time performace impact of these changes for
KASAN on x86-64. I haven't done any tests for arm64 modes (the stack
depot without performance optimizations is not suitable for intended use
of those anyway), but I expect a similar result. Obtaining and copying
stack trace frames when saving them into stack depot is what takes the
most time.

This series does not yet provide a way to configure the maximum size of
the stack depot externally (e.g. via a command-line parameter). This will
either be added in the following iterations of this series (if the used
approach gets approval) or will be added together with the performance
improvement changes.

Andrey Konovalov (15):
  stackdepot: check disabled flag when fetching
  stackdepot: simplify __stack_depot_save
  stackdepot: drop valid bit from handles
  stackdepot: add depot_fetch_stack helper
  stackdepot: use fixed-sized slots for stack records
  stackdepot: fix and clean-up atomic annotations
  stackdepot: rework helpers for depot_alloc_stack
  stackdepot: rename next_pool_required to new_pool_required
  stackdepot: store next pool pointer in new_pool
  stackdepot: store free stack records in a freelist
  stackdepot: use read/write lock
  stackdepot: add refcount for records
  stackdepot: add backwards links to hash table buckets
  stackdepot: allow users to evict stack traces
  kasan: use stack_depot_evict for tag-based modes

 include/linux/stackdepot.h |  11 ++
 lib/stackdepot.c           | 361 ++++++++++++++++++++++++-------------
 mm/kasan/tags.c            |   7 +-
 3 files changed, 249 insertions(+), 130 deletions(-)

-- 
2.25.1

