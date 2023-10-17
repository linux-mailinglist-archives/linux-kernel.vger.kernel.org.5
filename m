Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C597CC7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344104AbjJQPpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjJQPpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:45:19 -0400
Received: from out-204.mta1.migadu.com (out-204.mta1.migadu.com [IPv6:2001:41d0:203:375::cc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9FCB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:45:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697557515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lemsX7vhxu4js2CfwxN22PvTUw6JIiATv2g1JPaIjFU=;
        b=uN24GXJpRZk/OgGh+X3H2+ZPV7U57tOlzJa1pdg68vEeMyCb3k8Ltg6+sL101i6+UFMXqg
        aoSLXJCYUTZfTf2dxI3zFkONVwF8pLQnfJ5YHvafFO47JLqmfqQofBpF1M8VXOKggln2va
        gsZV2NI5jM9645zCQ1OD47R4nZ6pKOk=
From:   chengming.zhou@linux.dev
To:     cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH 0/5] slub: Delay freezing of CPU partial slabs
Date:   Tue, 17 Oct 2023 15:44:34 +0000
Message-Id: <20231017154439.3036608-1-chengming.zhou@linux.dev>
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
   But this workaround has its own problem.

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
use a bit in slab->flags to indicate whether the slab is on node partial
list or not, only in that case we can manipulate the slab list.

The slab will be delay frozen when it's picked to actively use by the
CPU, it becomes full at the same time, in which case we still need to
rely on "frozen" bit to avoid manipulating its list. So the slab will
be frozen only when activate use and be unfrozen only when deactivate.

3. Patches
==========
Patch-1 introduce the new slab->flags to indicate whether the slab is
on node partial list, which is protected by node list_lock.

Patch-2 change the free path to check if slab is on node partial list,
only in which case we can manipulate its list. Then we can keep unfrozen
partial slabs out of node partial list, since the free path won't
concurrently manipulate with it.

Patch-3 optimize the deactivate path, we can directly unfreeze the slab,
(since node list_lock is not needed to synchronize "frozen" bit anymore)
then grab node list_lock if it's needed to put on the node partial list.

Patch-4 change to don't freeze slab when moving out from node partial
list or put on the CPU partial list, and don't need to unfreeze these
slabs when put back to node partial list from CPU partial list.

Patch-5 change the alloc path to freeze the CPU partial slab when picked
to use.

4. Testing
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

Chengming Zhou (5):
  slub: Introduce on_partial()
  slub: Don't manipulate slab list when used by cpu
  slub: Optimize deactivate_slab()
  slub: Don't freeze slabs for cpu partial
  slub: Introduce get_cpu_partial()

 mm/slab.h |   2 +-
 mm/slub.c | 257 +++++++++++++++++++++++++++++++-----------------------
 2 files changed, 150 insertions(+), 109 deletions(-)

-- 
2.40.1

