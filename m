Return-Path: <linux-kernel+bounces-76583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FCC85F984
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9761D287724
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730BB1350C6;
	Thu, 22 Feb 2024 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hJO1/fTs"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E8133296
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608080; cv=none; b=CAKmvrsYbSjwGZzEO66hbykFSItMpdUZ22an8cZApwbitrqHP4o02woGYGxMocujWkW5yIsTVUHqcrJhFDEl1ibUTyVfTPROji+o2ocoqRRYDaWkctc3iz7nIypUDRP0GNM1fAzDQzxoDCioxDQUk3qBGBojS2Gb2uenSqPNImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608080; c=relaxed/simple;
	bh=XveA4E+yk5QXd3bzarqjGQAxhwM+egZQ/Cu6Twuiuhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bBdQnQ4Y7Dv0aLncD1S//tM+pfKQy98xpOz9TQQcF/g1ogVE59qelcU5lpsoCLc4I4DG4TmDAClr3STIvDfVeDyjjAI/ay0oi3qA855+zJhKUpj8vvpRtz/U3++PwuzpaW4+/CWP3fgpsMCp+ms7OegE7Z/GHzE8OLVDVxlgDlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hJO1/fTs; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <55ccc92a-79fa-42d2-97d8-b514cf00823b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708608075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVsrtEMZ6JawTvIkaCsFFiEwAJTnWgKN991X9xgEngg=;
	b=hJO1/fTsTrllgAUFzCkXgfJKJH/fwtbEPRAPPkxqxg//Y8+EpEFlU/x/wmG+jlWK0wDTN2
	JeIsZqLYUwObAa8kF7bvQWAwY7vDvkPxN92SY6mg0I1m38qGVtqAxblYdOkZSxExVjocK5
	unHQQUp3rKINTBrOnsacaY0GGFlh8cQ=
Date: Thu, 22 Feb 2024 21:20:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] slub: avoid scanning all partial slabs in get_slabinfo()
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>,
 Jianfeng Wang <jianfeng.w.wang@oracle.com>
Cc: cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
 akpm@linux-foundation.org, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240215211457.32172-1-jianfeng.w.wang@oracle.com>
 <6b58d81f-8e8f-3732-a5d4-40eece75013b@google.com>
 <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <fee76a21-fbc5-4ad8-b4bf-ba8a8e7cee8f@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/19 16:30, Vlastimil Babka wrote:
> On 2/18/24 20:25, David Rientjes wrote:
>> On Thu, 15 Feb 2024, Jianfeng Wang wrote:
>>
>>> When reading "/proc/slabinfo", the kernel needs to report the number of
>>> free objects for each kmem_cache. The current implementation relies on
>>> count_partial() that counts the number of free objects by scanning each
>>> kmem_cache_node's partial slab list and summing free objects from all
>>> partial slabs in the list. This process must hold per kmem_cache_node
>>> spinlock and disable IRQ. Consequently, it can block slab allocation
>>> requests on other CPU cores and cause timeouts for network devices etc.,
>>> if the partial slab list is long. In production, even NMI watchdog can
>>> be triggered because some slab caches have a long partial list: e.g.,
>>> for "buffer_head", the number of partial slabs was observed to be ~1M
>>> in one kmem_cache_node. This problem was also observed by several
>>> others [1-2] in the past.
>>>
>>> The fix is to maintain a counter of free objects for each kmem_cache.
>>> Then, in get_slabinfo(), use the counter rather than count_partial()
>>> when reporting the number of free objects for a slab cache. per-cpu
>>> counter is used to minimize atomic or lock operation.
>>>
>>> Benchmark: run hackbench on a dual-socket 72-CPU bare metal machine
>>> with 256 GB memory and Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.3 GHz.
>>> The command is "hackbench 18 thread 20000". Each group gets 10 runs.
>>>
>>
>> This seems particularly intrusive for the common path to optimize for 
>> reading of /proc/slabinfo, and that's shown in the benchmark result.
>>
>> Could you discuss the /proc/slabinfo usage model a bit?  It's not clear if 
>> this is being continuously read, or whether even a single read in 
>> isolation is problematic.
>>
>> That said, optimizing for reading /proc/slabinfo at the cost of runtime 
>> performance degradation doesn't sound like the right trade-off.
> 
> It should be possible to make this overhead smaller by restricting the
> counter only to partial list slabs, as [2] did. This would keep it out of
> the fast paths, where it's really not acceptable.
> Note [2] used atomic_long_t and the percpu counters used here should be
> lower overhead. So basically try to get the best of both attemps.

I just tried to implement this, the performance numbers are below:
(Run testing 5 times: perf bench sched messaging -g 5 -t -l 100000)

		slab-for-next	slab-pernode-counters
Total time:	7.495		7.5
		7.51		7.532
		7.54		7.514
		7.508		7.472
		7.42		7.527

The problem is that the counters include inuse objects of all slabs,
so can't distinguish how many free objects on the node partial list,
or how many free objects on the cpu partial lists.

But the current code will only iterate the slabs on node partial list,
so this implementation has inconsistency with the current behavior.

IMHO, we can't easily record inuse/free objects of only slabs on the
node partial list, since in __slab_free() we can't know the freed object
belong to slabs on cpu partial list or slabs on node partial list.

Anyway, I put the code below for discussion...

---
 mm/slub.c | 68 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 53 insertions(+), 15 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 20641ad82508..284b751b3b64 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -42,6 +42,7 @@
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 #include <linux/sort.h>
+#include <linux/percpu_counter.h>

 #include <linux/debugfs.h>
 #include <trace/events/kmem.h>
@@ -431,6 +432,7 @@ struct kmem_cache_node {
 	atomic_long_t total_objects;
 	struct list_head full;
 #endif
+	struct percpu_counter inuse_objects;
 };

 static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
@@ -1873,6 +1875,20 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 #endif
 #endif /* CONFIG_SLUB_DEBUG */

+static inline void add_inuse_objects(struct kmem_cache *s, int node, int objects)
+{
+	struct kmem_cache_node *n = get_node(s, node);
+
+	percpu_counter_add_local(&n->inuse_objects, objects);
+}
+
+static inline void sub_inuse_objects(struct kmem_cache *s, int node, int objects)
+{
+	struct kmem_cache_node *n = get_node(s, node);
+
+	percpu_counter_sub_local(&n->inuse_objects, objects);
+}
+
 static inline enum node_stat_item cache_vmstat_idx(struct kmem_cache *s)
 {
 	return (s->flags & SLAB_RECLAIM_ACCOUNT) ?
@@ -2526,6 +2542,8 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
 		add_full(s, n, slab);
 	}

+	add_inuse_objects(s, slab_nid(slab), 1);
+
 	return object;
 }

@@ -2563,6 +2581,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s,
 		add_partial(n, slab, DEACTIVATE_TO_HEAD);

 	inc_slabs_node(s, nid, slab->objects);
+	add_inuse_objects(s, nid, 1);
 	spin_unlock_irqrestore(&n->list_lock, flags);

 	return object;
@@ -2862,6 +2881,8 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 		new.freelist, new.counters,
 		"unfreezing slab"));

+	sub_inuse_objects(s, slab_nid(slab), free_delta);
+
 	/*
 	 * Stage three: Manipulate the slab list based on the updated state.
 	 */
@@ -3313,26 +3334,27 @@ __update_cpu_freelist_fast(struct kmem_cache *s,
 static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
 {
 	struct slab new;
-	unsigned long counters;
-	void *freelist;
+	struct slab old;

 	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));

 	do {
-		freelist = slab->freelist;
-		counters = slab->counters;
+		old.freelist = slab->freelist;
+		old.counters = slab->counters;

-		new.counters = counters;
+		new.counters = old.counters;

 		new.inuse = slab->objects;
-		new.frozen = freelist != NULL;
+		new.frozen = old.freelist != NULL;

 	} while (!__slab_update_freelist(s, slab,
-		freelist, counters,
+		old.freelist, old.counters,
 		NULL, new.counters,
 		"get_freelist"));

-	return freelist;
+	add_inuse_objects(s, slab_nid(slab), old.objects - old.inuse);
+
+	return old.freelist;
 }

 /*
@@ -3341,25 +3363,26 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
 static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
 {
 	struct slab new;
-	unsigned long counters;
-	void *freelist;
+	struct slab old;

 	do {
-		freelist = slab->freelist;
-		counters = slab->counters;
+		old.freelist = slab->freelist;
+		old.counters = slab->counters;

-		new.counters = counters;
+		new.counters = old.counters;
 		VM_BUG_ON(new.frozen);

 		new.inuse = slab->objects;
 		new.frozen = 1;

 	} while (!slab_update_freelist(s, slab,
-		freelist, counters,
+		old.freelist, old.counters,
 		NULL, new.counters,
 		"freeze_slab"));

-	return freelist;
+	add_inuse_objects(s, slab_nid(slab), old.objects - old.inuse);
+
+	return old.freelist;
 }

 /*
@@ -3567,6 +3590,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	slab->frozen = 1;

 	inc_slabs_node(s, slab_nid(slab), slab->objects);
+	add_inuse_objects(s, slab_nid(slab), slab->objects);

 	if (unlikely(!pfmemalloc_match(slab, gfpflags))) {
 		/*
@@ -4108,6 +4132,8 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,

 	stat(s, FREE_SLOWPATH);

+	sub_inuse_objects(s, slab_nid(slab), cnt);
+
 	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
 		free_to_partial_list(s, slab, head, tail, cnt, addr);
 		return;
@@ -4866,6 +4892,7 @@ static void early_kmem_cache_node_alloc(int node)
 	n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL, false);
 	slab->freelist = get_freepointer(kmem_cache_node, n);
 	slab->inuse = 1;
+	BUG_ON(percpu_counter_init(&n->inuse_objects, 1, GFP_KERNEL));
 	kmem_cache_node->node[node] = n;
 	init_kmem_cache_node(n);
 	inc_slabs_node(kmem_cache_node, node, slab->objects);
@@ -4884,6 +4911,7 @@ static void free_kmem_cache_nodes(struct kmem_cache *s)

 	for_each_kmem_cache_node(s, node, n) {
 		s->node[node] = NULL;
+		percpu_counter_destroy(&n->inuse_objects);
 		kmem_cache_free(kmem_cache_node, n);
 	}
 }
@@ -4916,6 +4944,11 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
 			return 0;
 		}

+		if (percpu_counter_init(&n->inuse_objects, 0, GFP_KERNEL)) {
+			free_kmem_cache_nodes(s);
+			return 0;
+		}
+
 		init_kmem_cache_node(n);
 		s->node[node] = n;
 	}
@@ -5541,6 +5574,11 @@ static int slab_mem_going_online_callback(void *arg)
 			ret = -ENOMEM;
 			goto out;
 		}
+		ret = percpu_counter_init(&n->inuse_objects, 0, GFP_KERNEL);
+		if (ret) {
+			kmem_cache_free(kmem_cache_node, n);
+			goto out;
+		}
 		init_kmem_cache_node(n);
 		s->node[nid] = n;
 	}
--
2.40.1

