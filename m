Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBCE7DEB4A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348340AbjKBDYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348268AbjKBDYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:24:46 -0400
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [IPv6:2001:41d0:203:375::bd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07FE9F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 20:24:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698895477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=44Ofo08nnlVGC1+D0ik4N2mhA+VghDHvF1jQ7/BBmJM=;
        b=hDZi+BTfnatfirUvnC7qCE1cD7sxRD9ekvwfTs2FxozQdKO3S6K8R5hv5aVRh1LgWJlh5c
        IBHDJ5naZiteqnk/UJphOvy/Q1P8V7W6R9urRvc5GuxWcLv5v9qERwjEgUNT2lVB+G25u7
        /3vLyJzzp6meRSQUw8dGOqX9r97j2GM=
From:   chengming.zhou@linux.dev
To:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v5 0/9] slub: Delay freezing of CPU partial slabs
Date:   Thu,  2 Nov 2023 03:23:21 +0000
Message-Id: <20231102032330.1036151-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Changes in v5:
 - Drop "RFC".
 - Retest to update performance numbers (little difference with RFC v1).
 - Add Reviewed-by and Tested-by tags. Many thanks!
 - Change to better function name: __put_partials().
 - Some minor improvements of comments and changelog.
 - RFC v4: https://lore.kernel.org/all/20231031140741.79387-1-chengming.zhou@linux.dev/

Changes in RFC v4:
 - Reorder patches to put the two cleanup patches to the front.
 - Move slab_node_partial flag functions to mm/slub.c.
 - Fix freeze_slab() by using slab_update_freelist().
 - Fix build error when !CONFIG_SLUB_CPU_PARTIAL.
 - Add a patch to rename all *unfreeze_partials* functions.
 - Add a patch to update inconsistent documentations in the source.
 - Some comments and changelog improvements.
 - Add Reviewed-by and Suggested-by tags. Many thanks!
 - RFC v3: https://lore.kernel.org/all/20231024093345.3676493-1-chengming.zhou@linux.dev/

Changes in RFC v3:
 - Directly use __set_bit() and __clear_bit() for the slab_node_partial
   flag operations to avoid exporting non-atomic "workingset" interfaces.
 - Change get_partial() related functions to return a slab instead of
   returning the freelist or single object.
 - Don't freeze any slab under the node list_lock to further reduce
   list_lock holding times, as suggested by Vlastimil Babka.
 - Introduce freeze_slab() to do the delay freezing and return freelist.
 - Reorder patches.
 - RFC v2: https://lore.kernel.org/all/20231021144317.3400916-1-chengming.zhou@linux.dev/

Changes in RFC v2:
 - Reuse PG_workingset bit to keep track of whether slub is on the
   per-node partial list, as suggested by Matthew Wilcox.
 - Fix OOM problem on kernel without CONFIG_SLUB_CPU_PARTIAL, which
   is caused by leak of partial slabs when get_partial_node().
 - Add a patch to simplify acquire_slab().
 - Reorder patches a little.
 - RFC v1: https://lore.kernel.org/all/20231017154439.3036608-1-chengming.zhou@linux.dev/

1. Problem
==========
Now we have to freeze the slab when get from the node partial list, and
unfreeze the slab when put to the node partial list. Because we need to
rely on the node list_lock to synchronize the "frozen" bit changes.

This implementation has some drawbacks:

 - Alloc path: twice cmpxchg_double.
   It has to get some partial slabs from node when the allocator has used
   up the CPU partial slabs. So it freeze the slab (one cmpxchg_double)
   with node list_lock held, put those frozen slabs on its CPU partial
   list. Later ___slab_alloc() will cmpxchg_double try-loop again if that
   slab is picked to use.

 - Alloc path: amplified contention on node list_lock.
   Since we have to synchronize the "frozen" bit changes under the node
   list_lock, the contention of slab (struct page) can be transferred
   to the node list_lock. On machine with many CPUs in one node, the
   contention of list_lock will be amplified by all CPUs' alloc path.

   The current code has to workaround this problem by avoiding using
   cmpxchg_double try-loop, which will just break and return when
   contention of page encountered and the first cmpxchg_double failed.
   But this workaround has its own problem. For more context, see
   9b1ea29bc0d7 ("Revert "mm, slub: consider rest of partial list if
   acquire_slab() fails"").

 - Free path: redundant unfreeze.
   __slab_free() will freeze and cache some slabs on its partial list,
   and flush them to the node partial list when exceed, which has to
   unfreeze those slabs again under the node list_lock. Actually we
   don't need to freeze slab on CPU partial list, in which case we
   can save the unfreeze cmpxchg_double operations in flush path.

2. Solution
===========
We solve these problems by leaving slabs unfrozen when moving out of
the node partial list and on CPU partial list, so "frozen" bit is 0.

These partial slabs won't be manipulate concurrently by alloc path,
the only racer is free path, which may manipulate its list when !inuse.
So we need to introduce another synchronization way to avoid it, we
reuse PG_workingset to keep track of whether the slab is on node partial
list or not, only in that case we can manipulate the slab list.

The slab will be delay frozen when it's picked to actively use by the
CPU, it becomes full at the same time, in which case we still need to
rely on "frozen" bit to avoid manipulating its list. So the slab will
be frozen only when activate use and be unfrozen only when deactivate.

The current updated scheme (which this series implemented) is:
 - node partial slabs: PG_Workingset && !frozen
 - cpu partial slabs: !PG_Workingset && !frozen
 - cpu slabs: !PG_Workingset && frozen
 - full slabs: !PG_Workingset && !frozen

The most important change is that "frozen" bit is not set for the cpu
partial slabs anymore, __slab_free() will grab node list_lock then
check by !PG_Workingset that it's not on a node partial list.

And the "frozen" bit is still kept for the cpu slabs for performance,
since we don't need to grab node list_lock to check whether PG_Workingset
is set or not if the "frozen" bit is set in the __slab_free().

3. Testing
==========
We did some simple testing on a server with 128 CPUs (2 nodes) to compare
performance.

 - perf bench sched messaging -g 5 -t -l 100000
   baseline	v5
   7.042s	6.934s
   7.022s	6.865s
   7.054s	7.009s

 - stress-ng --rawpkt 128 --rawpkt-ops 100000000
   baseline	v5
   2.42s	2.18s
   2.45s	2.16s
   2.44s	2.17s

It shows above there is about 10% improvement on stress-ng rawpkt
testcase, although no much improvement on perf sched bench testcase.

Thanks for any comment and code review!

Chengming Zhou (9):
  slub: Reflow ___slab_alloc()
  slub: Change get_partial() interfaces to return slab
  slub: Keep track of whether slub is on the per-node partial list
  slub: Prepare __slab_free() for unfrozen partial slab out of node
    partial list
  slub: Introduce freeze_slab()
  slub: Delay freezing of partial slabs
  slub: Optimize deactivate_slab()
  slub: Rename all *unfreeze_partials* functions to *put_partials*
  slub: Update frozen slabs documentations in the source

 mm/slub.c | 384 +++++++++++++++++++++++++-----------------------------
 1 file changed, 180 insertions(+), 204 deletions(-)

-- 
2.20.1

