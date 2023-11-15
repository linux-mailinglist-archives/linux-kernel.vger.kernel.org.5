Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EF67E9260
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjKLTvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjKLTvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:51:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4378136
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:51:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A7CC433C8;
        Sun, 12 Nov 2023 19:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699818676;
        bh=f/4S7FI52mCchbVDxW+qnUwpaqkZ5LrMF0Zm8xHVglI=;
        h=From:To:Cc:Subject:Date:From;
        b=FI+o3K77vKwtr3eh6pr0PyVPPrjyTpDOfLpDbq6ZhUYdryxWqa/p0o1syGJeY0yq0
         em27v4lVFETJkl0ldFpQWRph01DARqCkM2qzyA50GnfJspW92r4qilsZgi1vOGyeop
         nXjyBGQWZfR+jTIg8/5Y9rm9BWSevr3i9SQAWJxfR8BkkEoxc2k7rSc6VGHLjroknX
         EBaBgZtNZqAmngbMlgLEa3dqlc0I15YSh+72QrMcvQMUzJCA5UM09Oi36Uxu3I33Fz
         Hw0j67xjV419CPZh00xutDfoScwiwsirMlTIJctiQQMKn4X69H2omhUdFZuLVl131G
         LiKSPyhJAKpmw==
From:   SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC IDEA] ACMA: Access/Contiguity-aware Memory Auto-scaling
Date:   Sun, 12 Nov 2023 19:51:14 +0000
Message-Id: <20231112195114.61474-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I'd like to share an idea for making systems automatically scale up/down memory
in an access/contiguity-awared way.  It is designed for memory efficiency of
free pages reporting-like collaboration based memory oversubscribed virtual
machine systems, but it might also be potentially useful for memory/power
efficiency and memory contiguity of general systems.  There is no
implementation at the moment, but I'd like to hear any comments or concerns
about the idea first if anyone has.  I will also share this in the upcoming
kernel summit DAMON talk[1]'s future plans part.

Background
==========

On memory oversubscribed virtual machine systems, free pages reporting could be
used as a core of the collaborative memory management.  That is, the kernel of
guests report free pages to the host, and the host utilizes the reported pages
for other guests.  When the guest accesses the reported guest-physical page
again, the host knows that via the page fault mechanism, allocates a
host-physical page, and provide it to the guest.

Requirements
------------

For maximizing the memory efficiency of such systems, below properties are
required to guest machines.

1. Being memory frugal.  The guest should use memory only as really needed.
Otherwise, only insufficient amounts of memory are freed and reported to the
host while the guest is wasting the host-physical pages to accommodate not
really needed data.  As a result, the host level memory efficiency is degraded.

2. Report-time contiguity of free pages.  To reduce the overhead of the free
pages reporting, the feature usually works for not every single page but for
contiguous free pages of user-specifiable granularity (e.g., 2 MiB).  Hence,
even if there are many free pages in a guest, if the free pages are not
report-granularity-contiguous, those cannot be reported to the host.

3. Post-report contiguity of free pages.  In some cases, the host's page size
could be different from (usually larger than) that of the guest.  For example,
the host can manage the memory with 2 MiB-sized pages while the guest is using
4 KiB-sized pages.  In this case, the host-guest page mapping works in the
host-side page size.  Hence, even if only one page among a reported contiguous
free pages are allocated again and accessed, the whole reported contiguous
chunk should be returned to the guest.  This kind of ping pong itself could
also consume some resources.

4. Minimizing the metadata for reported pages.  Even though the guests report
free pages, the metadata for the pages (e.g., 'struct page') still exist and
consume memory.  Ideally, guests should have only metadata for really needed
pages.

Possible Approach and Limitations
---------------------------------

There are kernel features that could be used from the guests' user space for
the requirements.  DAMON-based proactive reclamation[2] could be turned on for
being memory frugal with only minimum performance impact.  Proactive compaction
can periodically run for the report-time contiguity of free pages.  Memory
hot-unplugging can be used for freeing the metadata of free pages[3].  The
guest would need to hot-plug the memory blocks again depending on memory
demands.  This may require some changes in the kernel for user-space driven
hot-[un]plugging of memory, and reporting hot-unplugged memory to the host.

This approach could work, but has some limitations.  Firstly, memory
hot-[un]plugging needs isolation/migration of the whole pages in the target
block.  This takes time, and could fail for any page isolation/migration
failures.    Periodic compaction could also partially fail due to page
isolation/migration failures.  It could also waste resources for compacting too
much memory, while required contiguity is only report-granularity.  There is no
way to avoid the compacted regions being defragmented again.  We were unable to
find a good existing solution for the post-report contiguity.  Finally,
efficiently controlling these multiple different kernel features from user
space is complex and challenging.

ACMA: Access/Contiguity-aware Memory Auto-scaling
=================================================

We therefore propose a new kernel feature for the requirements, namely
Access/Contiguity-aware Memory Auto-scaling (ACMA).

Definitions
-----------

ACMA defines a metric called DAMON-detected working set.  This is a set of
memory regions that DAMON has detected access to those regions within a
user-specifiable time interval, say, one minute.

ACMA also defines a new operation called stealing.  It receives a contiguous
memory region as its input, and allocates the pages of the region.  If some
pages in the region are not free, migrate those out.  Hence it could be thought
of a variant, or a wrapper of memory offlining or alloc_contig_range().  If the
allocation is successful, it further reports the region as safe to use to the
host.  ACMA manages the stealing status of each memory block.  If the entire
page of a memory block is stolen, it further hot-unplug the block.

It further defines a new operation called stolen pages returning.  The action
receives an amount of memory size as input.  If there are not-yet-hot-unplugged
stolen pages of the size, it frees the page.  If there are no such stolen pages
but a hot-unplugged stolen memory block, it hot-plugs the block again, closer
to the not-hot-unplugged blocks first.  Then the guest users can allocate pages
of returned ones and access it.  When they access it, the host will notify that
via page fault and assign/map a host-physical page for that.

Workflow
--------

With these definitions, ACMA behaves based on system status as follows.

Phase 0. It periodically monitors the DAMON-based working set size and free
memory size of the system.

Phase 1. If the free memory to the working set size ratio is more than a
threshold (high), say, 2:1 (200%), ACMA steals report-granularity contiguous
non-working set pages in the last not-yet-hot-unplugged memory block, colder
pages first.  The ratio will decrease.

Phase 2. If the free memory to the working set size ratio becomes less than a
threshold (normal), say, 1:1 (100%), ACMA stops stealing and start reclaiming
non-workingset pages, colder pages first.  The ratio will increase.  The
reclamation is continued until the ratio becomes higher than the normal
threshold.

Phase 3. If the non-workingset reclamation is not increasing the ratio and it
becomes less than yet another threshold (low), say, 1:2 (50%), ACMA starts
returning stolen pages until the free memory to the working set ratio becomes
higher than the low threshold.

Expectations
------------

Since ACMA does stealing in phase 1, which does a sort of compaction on its
own, in free pages report-granularity, it does compaction only as much as
really required.  Because the stealing targets colder pages first, it will only
rarely conflict with users of the pages.  Hence less isolation/migration
failures, which results in more stealing success is expected.

Since ACMA-stolen pages are allocated to ACMA, which is in kernel space, no
other in-guest components can use it before ACMA returns those.  Hence,
after-report contiguity is kept, unless working set size, which represents real
memory demand, grows enough to make ACMA work in the phase 3.

Since ACMA does proactive non-workingset cold-pages first reclamation in
phase 2, the guest becomes memory frugal with minimum performance degradation.

Because the phase changes based on free memory to working set size ratio, the
guest system is guaranteed to have only the working set plus normal-high
(100%-200% in this example) working set size proportional free memory.  This
wouldn't be true if the working set size is more than 50% of all available
guest-physical memory of the guest.  In this case, if memory demands continues
increasing, any system has no way but OOM.  The host might be able to detect
this and add more guest-physical memory so that ACMA can hot-plug those
automatically, though.  Because stealing does hot-unplugging of the memory,
'struct page' for only really needed pages are used.

Hence, ACMA provides monitored access pattern based contiguity-aware real
memory demands based memory scaling without unnecessary metadata.

Implementation
--------------

Implementation detail is to-be-discussed, but we could implement ACMA using
DAMOS.  That is, the stealing and stolen pages return operation could be
implemented as a new DAMOS action.  The working set size monitoring can be
natively done with DAMON.  The three phases can each be implemented as a DAMOS
scheme.  The free memory to the working set size ratio based activation and
deactivation of the schemes can be done using the aim-oriented auto-tuning of
DAMOS[4].  We could add PSI goals to the schemes, too.

For example, below DAMOS schemes in the DAMO json input format could be
imagined.  Note that this is not what is currently supported.

    [
        {
            "action": "acma_steal",
            "access_pattern": {
                "sz_bytes": { "min": "2 MB", "max": "max" },
                "nr_accesses": { "max": "0 %" },
                "age": { "min": "1 minute" }
            },
            "auto_tuning_aims": [
                {
                    "metric": "workingset_to_free_mem_ratio",
                    "workingset_min_age": "1 minute", "target": 1.0
                },
                { "metric": "psi_mem_ratio", "target": 0.001, },
            ],
        },
        {
            "action": "pageout",
            "access_pattern": {
                "nr_accesses": { "max": "0 %" },
                "age": { "min": "1 minute" }
            },
            "auto_tuning_aims": [
                {
                    "metric": "free_mem_to_workingset_ratio",
                    "workingset_min_age": "1 minute", "target": 1.0
                },
                { "metric": "psi_mem_ratio", "target": 0.001, },
            ],
        },
        {
            "action": "acma_return",
            "auto_tuning_aims": [
                {
                    "metric": "free_mem_to_workingset_ratio",
                    "workingset_min_age": "1 minute", "target": 0.5
                },
            ],
        }
    ]

Potential Benefits for General Usage
====================================

ACMA is basically designed for memory overcommitted virtual machine systems, as
described above.  However, it could be useful for general systems that memory
can be physically hot-[un]pluggable.  It could help improve memory efficiency
of physical clusters, and save power for unused DRAM or memory devices.

We could also think about extending ACMA to provide a contiguous memory
allocation interface.  Since stolen pages are report-granularity or memory
block-granularity contiguous and isolated from the system's other components,
ACMA could allocate contiguous memory from the stolen memory, without high
latency.  If the report granularity and required contiguous memory allocation
size is same (e.g., 2 MiB default free pages reporting granularity and 2 MiB
hugepages), it would be especially efficient.  In this case, ACMA may stand for
Access-aware Contiguous Memory Allocator.

Request For Comments
====================

This is in very early stage.  No enough survey of related works is done, and no
implementation is made at all.  That said, I hope to share what I'm gonna do,
and get any comment if possible, not to only success, but rather to learn from
you and develop it together, or even fail fast.

Example ACMA Operation Scenario
===============================

Let’s assume a guest using 2MiB size pages.  Each memory block has 9 pages, and
also 1 page for metadata of the 9 pages.  The system has 10 memory blocks, so
200 MiB memory in total.

Let’s represent the state of each page as below.

U: stolen-and-unplugged page
M: metadata of the pages in the page block
S: stolen-but-not-yet-unplugged page
F: Free page
C: Non-free (assigned) cold (non-workingset) page
H: Non-free (assigned) hot (workingset) page

And the proposed system is configured like above implementation example.  To
summarize it again,

* Steal 2MiB-contiguous cold memory in last plugged memory block, when
  free memory to working set rate > 100%
* Reclaim cold pages if free memory to working set rate <= 100%
* Return stolen memory if free memory to working set rate < 50%

The initial state could look like below.

    MFFFFFFFFF MFFFFFFFFF
    MFFFFFFFFF MFFFFFFFFF
    MFFFFFFFFF MFFFFFFFFF
    MFFFFFFFFF MCCCCCCCCC
    MCCCCCCCCC MHHHHHHHHH

    Free mem to working set rate: 63 pages / 9 pages = 700 %

Stealing memory (down-scaling)
------------------------------

Since free memory to workingset ratio is larger than 100%, cold pages stealing
works.  Stolen pages are reported to the host.  As more pages are stolen, the
free memory to workingset ratio decreases.  For example, if hot/cold pages are
stable and four free pages are stolen, the status looks like below.  Note that
ACMA can steal allocated-cold pages, too.

    MFSFSFSSFF MFFFFFFFFF
    MFFFFFFFFF MFFFFFFFFF
    MFFFFFFFFF MFFFFFFFFF
    MFFFFFFFFF MCCCCCCCCC
    MCCCCCCCCC MHHHHHHHHH

    Free mem to working set rate: 59 pages / 9 pages = 655 %

Stealing works for only the last not-yet-unplugged block.  Once all pages of
the block are stolen, the entire block is unplugged.  The metadata for the
block also becomes available to the host.  Stealing continues to the next
block.

    UUUUUUUUUU MFSFFFFFFF
    MFFFFFFFFF MFFFFFFFFF
    MFFFFFFFFF MFFFFFFFFF
    MFFFFFFFFF MCCCCCCCCC
    MCCCCCCCCC MHHHHHHHHH

    Free mem to working set rate: 52 pages / 9 pages = 577 %

Reclamation helps stealing
--------------------------

And the stealing continues... Until free memory to working set rate reaches
100%.

    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    MFFFFFFFFF MCCCCCCCCC
    MCCCCCCCCC MHHHHHHHHH

    Free mem to working set rate: 9 pages / 9 pages = 100 %

Now stealing stops, and proactive reclamation starts.  It reclaims cold pages,
making those free pages.

    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    MFFFFFFFFF MCFCCCCCCC
    MCCCCCCCCC MHHHHHHHHH

    Free mem to working set rate: 10 pages / 9 pages = 111 %

Now reclamation is deactivated, and stealing be activated.

    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    MFFSFFFFFF MCFCCCCCCC
    MCCCCCCCCC MHHHHHHHHH

    Free mem to working set rate: 9 pages / 9 pages = 100 %

Ping pong of reclamation-stealing continues.  Reclaim,

    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    MFFSFFFFFF MCFCFCCCCC
    MCCCCCCCCC MHHHHHHHHH

    Free mem to working set rate: 10 pages / 9 pages = 111 %

and then Steal.

    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    MFFSSFFFFF MCFCFCCCCC
    MCCCCCCCCC MHHHHHHHHH

    Free mem to working set rate: 9 pages / 9 pages = 100 %

Eventually, converges to system having only workingset and
workingset-sufficient amount (workingset size) of free memory.

    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    MFFFFFFFFF MHHHHHHHHH

    Free mem to working set rate: 9 pages / 9 pages = 100 %

In this state, proactive reclaim is still active, but do nothing since no
allocated cold pages exist.

Stollen pages returning
-----------------------

User could start allocating more pages and accessing those frequently (make
hot).  In other words, working set could increase.  Then free memory to
workingset size ratio decreases.

    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    MFFFFFFHFF MHHHHHHHHH

    Free mem to working set rate: 8 pages / 10 pages = 80 %

Proactive reclaim is still active, but doesn’t increase the free memory, since
no allocated and cold page exists.  This situation continues until stolen pages
returning threshold is met (free memory to working set 50%).

    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    MFFHFHFHFF MHHHHHHHHH

    Free mem to working set rate: 6 pages / 12 pages = 50 %

If the user stops increasing the working set, this could be a stabilized state.

If the user adds one more hot page, the state becomes like below.

    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    MFFHFHHHFF MHHHHHHHHH

    Free mem to working set rate: 5 pages / 13 pages = 38 %

Now stolen pages returning is activated.  Since there is no
stolen-but-plugged page, it plugs the last unplugged memory block.

    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU MFFFFFFFFF
    MFFHFHHHFF MHHHHHHHHH

    Free mem to working set rate: 14 pages / 13 pages = 107 %

It increased the free memory to working set ratio to a high level, so returning
and proactive reclamation stops.  Stealing is again activated, decreasing the
free memory to working set ratio.

    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU UUUUUUUUUU
    UUUUUUUUUU MFFFSFFFFF
    MFFHFHHHFF MHHHHHHHHH

    Free mem to working set rate: 13 pages / 13 pages = 100 %

In this way, the system will always have a real working set (hot pages) plus
50-100% of the working set size free memory, and let the host uses the
remaining guest-physical memory.

[1] https://lpc.events/event/17/contributions/1624/
[2] https://docs.kernel.org/admin-guide/mm/damon/reclaim.html
[3] https://docs.kernel.org/admin-guide/mm/memory-hotplug.html#phases-of-memory-hotunplug
[4] https://lore.kernel.org/damon/20231112194607.61399-1-sj@kernel.org/
