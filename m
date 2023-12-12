Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DFD80E04A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345457AbjLLAbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjLLAbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:31:44 -0500
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E850B8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:31:50 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-35d6644c1f2so12876905ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702341109; x=1702945909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iCJbgeC+22r1aKipX6bocvG2HYxcQLc/B81JrVBznno=;
        b=cz6Kboyk5AsAWMGfKkaFfv7mqGsQEhdS2YhTetcR9vbHBsSvIiJA1+4kRiQnkGZeB7
         qSfC3ezqew8gXCa7+rTfoYk7jfqfIZS/FNOoM0g7uNiDjCSMFx3/7xd1NFws93yh9Iv4
         mpqbirAK4ZtZ4nFdHvpvGasLu0Zx7a9/SMLVMHFiIkOi5VmTHW5qZllx2grAjhodWMmd
         NJ7IW66f8gb0hwV/+UeKce3TBv4LLAggpg0tMk9XpN1M2GninSLiHBMAFpVDmX4lpsSB
         OmopQDr+l1PBKU720tx6PHrfQBxmsOcrWWh4Lsyf78U8z+vn+SMU75xxWH3ysOJKHABU
         fwXA==
X-Gm-Message-State: AOJu0Yx06j6SjFIepPg/0LUcbGdjM57LaqycqPUBR0Jte0fbJ6eDwJF8
        bd0VsRdnnG7/y1z1b3u3dVMfPwzMzy2aaAJh
X-Google-Smtp-Source: AGHT+IFNYsxF04xo7hJgz8N7oloefHHtMlql+oCrL55YTYMB9F2b60VbR4JsUZ5cWLAz2TTNxhXeeA==
X-Received: by 2002:a05:6e02:1d8e:b0:35a:e348:ab4d with SMTP id h14-20020a056e021d8e00b0035ae348ab4dmr4392756ila.6.1702341109271;
        Mon, 11 Dec 2023 16:31:49 -0800 (PST)
Received: from localhost (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id b89-20020a0295e2000000b0041e328a2084sm2116062jai.79.2023.12.11.16.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 16:31:48 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, youssefesmat@google.com, joelaf@google.com,
        roman.gushchin@linux.dev, yu.c.chen@intel.com,
        kprateek.nayak@amd.com, gautham.shenoy@amd.com,
        aboorvad@linux.vnet.ibm.com, wuyun.abel@bytedance.com,
        tj@kernel.org, kernel-team@meta.com
Subject: [PATCH v4 0/8] sched: Implement shared runqueue in fair.c
Date:   Mon, 11 Dec 2023 18:31:33 -0600
Message-ID: <20231212003141.216236-1-void@manifault.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v4 of the shared runqueue patchset. This patch set is based off
of commit 418146e39891 ("freezer,sched: Clean saved_state when restoring
it during thaw") on the sched/core branch of tip.git.

In prior versions of this patch set, I was observing consistent and
statistically significant wins for several benchmarks when this feature
was enabled, such as kernel compile and hackbench. After rebasing onto
the latest sched/core on tip.git, I'm no longer observing these wins,
and in fact observe some performance loss with SHARED_RUNQ on hackbench.
I ended up bisecting this to when EEVDF was merged.

As I mentioned in [0], our plan for now is to take a step back and
re-evaluate how we want to proceed with this patch set. That said, I did
want to send this out in the interim in case it could be of interest to
anyone else who would like to continue to experiment with it.

[0]: https://lore.kernel.org/all/20231204193001.GA53255@maniforge/

v1 (RFC): https://lore.kernel.org/lkml/20230613052004.2836135-1-void@manifault.com/
v2: https://lore.kernel.org/lkml/20230710200342.358255-1-void@manifault.com/
v3: https://lore.kernel.org/all/20230809221218.163894-1-void@manifault.com/

v3 -> v4 changes:
- Ensure list is fully drained when toggling feature on and off (noticed
  offline by Chris Mason, and independently by Aboorva Devarajan)

- Also check !is_migration_disabled() in shared_runq_pick_next_task() if
  we find a task in the shard, as is_cpu_allowed() doesn't check for
  migration. Also do another check for is_cpu_allowed() after
  re-acquiring the task rq lock in case state has changed

- Statically initialize the shared_runq_node list node in the init task.

- Only try to pull a task from the shared_runq if the rq's root domain has
  the overload bit set (K Prateek Nayak)

- Check this_rq->ttwu_pending after trying to pull a task from a shared
  runqueue shard before going forward to load_balance() (K Prateek Nayak)

- Fix where we would try to skip over the lowest-level sched domain --
  do the check in load_balance() instead of before, as for_each_domain()
  iterates over all domains starting from the beginning (K Prateek Nayak)

- Add a selftest testcase which toggles the SHARED_RUNQ feature on and
  off in a loop

Worth noting is that there have been a number of suggestions for
improving this feature that were not included in this v4, such as:

- [1], where Chen Yu <yu.c.chen@intel.com> suggested not putting certain
  tasks on a shared_runq if e.g. p->avg_runtime <= sysctl_migration_cost.
  I elected to not include this, as it's a heuristic that could
  incorrectly prevent work conservation, which is the primary goal of
  the feature.

- [2], where K Prateek Nayak <kprateek.nayak@amd.com> suggested adding a
  per-shard "overload" flag that can be set to avoid contending on the
  shard lock. This should be covered by checking the root domain
  overload flag.

- [3], where K Prateek Nayak <kprateek.nayak@amd.com> suggested also
  checking rq->avg_idle < sd->max_newidle_lb_cost. This is a similar
  suggestion to Chen Yu's above, and I elected to leave it out here for
  the same reason: that we want to encourage work conservation.

- [4], where Gautham Shenoy <gautham.shenoy@amd.com> suggests iterating
  over all tasks in a shard until one is found that can be pulled,
  rather than bailing out after failing to migrate the HEAD task.

None of these ideas are unreasonable, and may be worth applying if it
improves the feature for more general cases following further testing. I
left the patch set as is simply to keep the feature "consistent" in
encouraging work conservation, but that decision can be revisited.

[1]: https://lore.kernel.org/all/ZO7e5YaS71cXVxQN@chenyu5-mobl2/
[2]: https://lore.kernel.org/all/20230831104508.7619-4-kprateek.nayak@amd.com/
[3]: https://lore.kernel.org/all/20230831104508.7619-3-kprateek.nayak@amd.com/
[4]: https://lore.kernel.org/lkml/ZJkqeXkPJMTl49GB@BLR-5CG11610CF.amd.com/

v2 -> v3 changes:
- Don't leave stale tasks in the lists when the SHARED_RUNQ feature is
  disabled (Abel Wu)

- Use raw spin lock instead of spinlock_t (Peter)

- Fix return value from shared_runq_pick_next_task() to match the
  semantics expected by newidle_balance() (Gautham, Abel)

- Fold patch __enqueue_entity() / __dequeue_entity() into previous patch
  (Peter)

- Skip <= LLC domains in newidle_balance() if SHARED_RUNQ is enabled
  (Peter)

- Properly support hotplug and recreating sched domains (Peter)

- Avoid unnecessary task_rq_unlock() + raw_spin_rq_lock() when src_rq ==
  target_rq in shared_runq_pick_next_task() (Abel)

- Only issue list_del_init() in shared_runq_dequeue_task() if the task
  is still in the list after acquiring the lock (Aaron Lu)

- Slightly change shared_runq_shard_idx() to make it more likely to keep
  SMT siblings on the same bucket (Peter)

v1 -> v2 changes:
- Change name from swqueue to shared_runq (Peter)

- Shard per-LLC shared runqueues to avoid contention on scheduler-heavy
  workloads (Peter)

- Pull tasks from the shared_runq in newidle_balance() rather than in
  pick_next_task_fair() (Peter and Vincent)

- Rename a few functions to reflect their actual purpose. For example,
  shared_runq_dequeue_task() instead of swqueue_remove_task() (Peter)

- Expose move_queued_task() from core.c rather than migrate_task_to()
  (Peter)

- Properly check is_cpu_allowed() when pulling a task from a shared_runq
  to ensure it can actually be migrated (Peter and Gautham)

- Dropped RFC tag


David Vernet (8):
  sched: Expose move_queued_task() from core.c
  sched: Move is_cpu_allowed() into sched.h
  sched: Tighten unpinned rq lock window in newidle_balance()
  sched: Check cpu_active() earlier in newidle_balance()
  sched: Enable sched_feat callbacks on enable/disable
  sched: Implement shared runqueue in CFS
  sched: Shard per-LLC shared runqueues
  sched: Add selftest for SHARED_RUNQ

 include/linux/sched.h                     |   2 +
 init/init_task.c                          |   1 +
 kernel/sched/core.c                       |  52 +--
 kernel/sched/debug.c                      |  18 +-
 kernel/sched/fair.c                       | 413 +++++++++++++++++++++-
 kernel/sched/features.h                   |   2 +
 kernel/sched/sched.h                      |  60 +++-
 kernel/sched/topology.c                   |   4 +-
 tools/testing/selftests/sched/Makefile    |   7 +-
 tools/testing/selftests/sched/config      |   2 +
 tools/testing/selftests/sched/test-swq.sh |  23 ++
 11 files changed, 521 insertions(+), 63 deletions(-)
 create mode 100755 tools/testing/selftests/sched/test-swq.sh

-- 
2.42.1

