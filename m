Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249417D4C89
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbjJXJem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbjJXJeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:34:08 -0400
X-Greylist: delayed 25900 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Oct 2023 02:33:57 PDT
Received: from out-200.mta0.migadu.com (out-200.mta0.migadu.com [91.218.175.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDA22693
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:33:56 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698140035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qf2lNfc5Fcm5jSP4SS61S986dXbxp18qbu8hfCRqjgg=;
        b=ulgukAe+ntV+q6q46KjRxzvDgqkp/9R4BbSpIIEAf4gLSyNYSnyQqPIsvBKrebExQuG61T
        UrvYVBWUMeScMaS04qEYF5Hc2HpYIrOL2XC7J9bBBDVj0T/sOlX4ece9qubM4KO4PlOnx5
        LtM6csrrf2qX5xiqNvQ04cnpUBX8jgo=
From:   chengming.zhou@linux.dev
To:     cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH v3 0/7] slub: Delay freezing of CPU partial slabs
Date:   Tue, 24 Oct 2023 09:33:38 +0000
Message-Id: <20231024093345.3676493-1-chengming.zhou@linux.dev>
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

From: Chengming Zhou <zhouchengming@bytedance.com>

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

3. Testing
==========
We just did some simple testing on a server with 128 CPUs (2 nodes) to
compare performance for now.

 - perf bench sched messaging -g 5 -t -l 100000
   baseline	RFC
   7.042s	6.966s
   7.022s	7.045s
   7.054s	6.985s

 - stress-ng --rawpkt 128 --rawpkt-ops 100000000
   baseline	RFC
   2.42s	2.15s
   2.45s	2.16s
   2.44s	2.17s

It shows above there is about 10% improvement on stress-ng rawpkt
testcase, although no much improvement on perf sched bench testcase.

Thanks for any comment and code review!

Chengming Zhou (7):
  slub: Keep track of whether slub is on the per-node partial list
  slub: Prepare __slab_free() for unfrozen partial slab out of node
    partial list
  slub: Reflow ___slab_alloc()
  slub: Change get_partial() interfaces to return slab
  slub: Introduce freeze_slab()
  slub: Delay freezing of partial slabs
  slub: Optimize deactivate_slab()

 mm/slab.h |  19 ++++
 mm/slub.c | 306 +++++++++++++++++++++++-------------------------------
 2 files changed, 149 insertions(+), 176 deletions(-)

-- 
2.40.1

