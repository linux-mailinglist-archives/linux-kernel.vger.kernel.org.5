Return-Path: <linux-kernel+bounces-113403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB6E88840C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D7C286616
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D1B1A50DC;
	Sun, 24 Mar 2024 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr8Y5vwJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D4F1A50C1;
	Sun, 24 Mar 2024 22:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320205; cv=none; b=sdEryrdmyCROcf2dwKcJtFQUqBpr9t81o9i/pBhz5J5sbtF1i1Oi/7PgtS8Birdsb3b6jmY58VrCvjsxYvyL+LVD69lIPESAxoRybXfb5xzjWwOCrPf6ACplxOJ+796W/ywz1Nen+G3jybjF9vL4MHe5t/Y5aTCbafKpAfrd6z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320205; c=relaxed/simple;
	bh=mHAtQPbhY3AG6xn7A3FOh2mgrLWtyzGdrZ6xKI5s4u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I089cELpEjwHy1hbYJ9xfjGC7+BGNnOsWxwSzYfAYZJIKfhvZkyHNGunekDMU2TL0BzDUKUQ0F3R/oU2m3SkwIs5HKWIP18QCtvTDUhTPijLkuLGTEv+ky7kYr67cXM4bXijtYwIb0LGF2WLESuJ+PnzXsQny2pYgOV2Awhuevo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lr8Y5vwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005A7C43394;
	Sun, 24 Mar 2024 22:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320205;
	bh=mHAtQPbhY3AG6xn7A3FOh2mgrLWtyzGdrZ6xKI5s4u4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lr8Y5vwJFr5FK6XVSihc4k3E7srXdFOsa8WUIVvHQk/Udd9QhZldjyUQsPYFd2cup
	 KinFUmdVtIyJwRk+qfKe/hJx1TrJxXJ1G+r8O5vS++sQ/pwlFb5Hp73A5RUVACw1Zy
	 /d0WtHwtIZGLZlsL+G7oxUAsEreRIDvow+0p/Pmf32MGn6F6mDEyQ3rdiRmJMEgM77
	 0VsHrUw0Svq385fUlERT3AWZQ6IiacEljU3MajcrlVF/RuXctdx3R968B/q73sEs8q
	 KT079ev1NSHf9abcA9U03xlK8tlSCYMEmltcDqqhXg1Y80CPeM7pfUMZbAQsANBrmV
	 Qa5TSFCNztXnQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oscar Salvador <osalvador@suse.de>,
	Marco Elver <elver@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 512/715] lib/stackdepot: fix first entry having a 0-handle
Date: Sun, 24 Mar 2024 18:31:31 -0400
Message-ID: <20240324223455.1342824-513-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Oscar Salvador <osalvador@suse.de>

[ Upstream commit 3ee34eabac2abb6b1b6fcdebffe18870719ad000 ]

Patch series "page_owner: print stacks and their outstanding allocations",
v10.

page_owner is a great debug functionality tool that lets us know about all
pages that have been allocated/freed and their specific stacktrace.  This
comes very handy when debugging memory leaks, since with some scripting we
can see the outstanding allocations, which might point to a memory leak.

In my experience, that is one of the most useful cases, but it can get
really tedious to screen through all pages and try to reconstruct the
stack <-> allocated/freed relationship, becoming most of the time a
daunting and slow process when we have tons of allocation/free operations.

This patchset aims to ease that by adding a new functionality into
page_owner.  This functionality creates a new directory called
'page_owner_stacks' under 'sys/kernel//debug' with a read-only file called
'show_stacks', which prints out all the stacks followed by their
outstanding number of allocations (being that the times the stacktrace has
allocated but not freed yet).  This gives us a clear and a quick overview
of stacks <-> allocated/free.

We take advantage of the new refcount_f field that stack_record struct
gained, and increment/decrement the stack refcount on every
__set_page_owner() (alloc operation) and __reset_page_owner (free
operation) call.

Unfortunately, we cannot use the new stackdepot api STACK_DEPOT_FLAG_GET
because it does not fulfill page_owner needs, meaning we would have to
special case things, at which point makes more sense for page_owner to do
its own {dec,inc}rementing of the stacks.  E.g: Using
STACK_DEPOT_FLAG_PUT, once the refcount reaches 0, such stack gets
evicted, so page_owner would lose information.

This patchset also creates a new file called 'set_threshold' within
'page_owner_stacks' directory, and by writing a value to it, the stacks
which refcount is below such value will be filtered out.

A PoC can be found below:

 # cat /sys/kernel/debug/page_owner_stacks/show_stacks > page_owner_full_stacks.txt
 # head -40 page_owner_full_stacks.txt
  prep_new_page+0xa9/0x120
  get_page_from_freelist+0x801/0x2210
  __alloc_pages+0x18b/0x350
  alloc_pages_mpol+0x91/0x1f0
  folio_alloc+0x14/0x50
  filemap_alloc_folio+0xb2/0x100
  page_cache_ra_unbounded+0x96/0x180
  filemap_get_pages+0xfd/0x590
  filemap_read+0xcc/0x330
  blkdev_read_iter+0xb8/0x150
  vfs_read+0x285/0x320
  ksys_read+0xa5/0xe0
  do_syscall_64+0x80/0x160
  entry_SYSCALL_64_after_hwframe+0x6e/0x76
 stack_count: 521

  prep_new_page+0xa9/0x120
  get_page_from_freelist+0x801/0x2210
  __alloc_pages+0x18b/0x350
  alloc_pages_mpol+0x91/0x1f0
  folio_alloc+0x14/0x50
  filemap_alloc_folio+0xb2/0x100
  __filemap_get_folio+0x14a/0x490
  ext4_write_begin+0xbd/0x4b0 [ext4]
  generic_perform_write+0xc1/0x1e0
  ext4_buffered_write_iter+0x68/0xe0 [ext4]
  ext4_file_write_iter+0x70/0x740 [ext4]
  vfs_write+0x33d/0x420
  ksys_write+0xa5/0xe0
  do_syscall_64+0x80/0x160
  entry_SYSCALL_64_after_hwframe+0x6e/0x76
 stack_count: 4609
..
..

 # echo 5000 > /sys/kernel/debug/page_owner_stacks/set_threshold
 # cat /sys/kernel/debug/page_owner_stacks/show_stacks > page_owner_full_stacks_5000.txt
 # head -40 page_owner_full_stacks_5000.txt
  prep_new_page+0xa9/0x120
  get_page_from_freelist+0x801/0x2210
  __alloc_pages+0x18b/0x350
  alloc_pages_mpol+0x91/0x1f0
  folio_alloc+0x14/0x50
  filemap_alloc_folio+0xb2/0x100
  __filemap_get_folio+0x14a/0x490
  ext4_write_begin+0xbd/0x4b0 [ext4]
  generic_perform_write+0xc1/0x1e0
  ext4_buffered_write_iter+0x68/0xe0 [ext4]
  ext4_file_write_iter+0x70/0x740 [ext4]
  vfs_write+0x33d/0x420
  ksys_pwrite64+0x75/0x90
  do_syscall_64+0x80/0x160
  entry_SYSCALL_64_after_hwframe+0x6e/0x76
 stack_count: 6781

  prep_new_page+0xa9/0x120
  get_page_from_freelist+0x801/0x2210
  __alloc_pages+0x18b/0x350
  pcpu_populate_chunk+0xec/0x350
  pcpu_balance_workfn+0x2d1/0x4a0
  process_scheduled_works+0x84/0x380
  worker_thread+0x12a/0x2a0
  kthread+0xe3/0x110
  ret_from_fork+0x30/0x50
  ret_from_fork_asm+0x1b/0x30
 stack_count: 8641

This patch (of 7):

The very first entry of stack_record gets a handle of 0, but this is wrong
because stackdepot treats a 0-handle as a non-valid one.  E.g: See the
check in stack_depot_fetch()

Fix this by adding and offset of 1.

This bug has been lurking since the very beginning of stackdepot, but no
one really cared as it seems.  Because of that I am not adding a Fixes
tag.

Link: https://lkml.kernel.org/r/20240215215907.20121-1-osalvador@suse.de
Link: https://lkml.kernel.org/r/20240215215907.20121-2-osalvador@suse.de
Co-developed-by: Marco Elver <elver@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: dc24559472a6 ("lib/stackdepot: off by one in depot_fetch_stack()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/stackdepot.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 4a7055a63d9f8..c043a4186bc59 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -45,15 +45,16 @@
 #define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
 			       STACK_DEPOT_EXTRA_BITS)
 #define DEPOT_POOLS_CAP 8192
+/* The pool_index is offset by 1 so the first record does not have a 0 handle. */
 #define DEPOT_MAX_POOLS \
-	(((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
-	 (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
+	(((1LL << (DEPOT_POOL_INDEX_BITS)) - 1 < DEPOT_POOLS_CAP) ? \
+	 (1LL << (DEPOT_POOL_INDEX_BITS)) - 1 : DEPOT_POOLS_CAP)
 
 /* Compact structure that stores a reference to a stack. */
 union handle_parts {
 	depot_stack_handle_t handle;
 	struct {
-		u32 pool_index	: DEPOT_POOL_INDEX_BITS;
+		u32 pool_index	: DEPOT_POOL_INDEX_BITS; /* pool_index is offset by 1 */
 		u32 offset	: DEPOT_OFFSET_BITS;
 		u32 extra	: STACK_DEPOT_EXTRA_BITS;
 	};
@@ -372,7 +373,7 @@ static struct stack_record *depot_pop_free_pool(void **prealloc, size_t size)
 	stack = current_pool + pool_offset;
 
 	/* Pre-initialize handle once. */
-	stack->handle.pool_index = pool_index;
+	stack->handle.pool_index = pool_index + 1;
 	stack->handle.offset = pool_offset >> DEPOT_STACK_ALIGN;
 	stack->handle.extra = 0;
 	INIT_LIST_HEAD(&stack->hash_list);
@@ -483,18 +484,19 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 	const int pools_num_cached = READ_ONCE(pools_num);
 	union handle_parts parts = { .handle = handle };
 	void *pool;
+	u32 pool_index = parts.pool_index - 1;
 	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
 	struct stack_record *stack;
 
 	lockdep_assert_not_held(&pool_lock);
 
-	if (parts.pool_index > pools_num_cached) {
+	if (pool_index > pools_num_cached) {
 		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
-		     parts.pool_index, pools_num_cached, handle);
+		     pool_index, pools_num_cached, handle);
 		return NULL;
 	}
 
-	pool = stack_pools[parts.pool_index];
+	pool = stack_pools[pool_index];
 	if (WARN_ON(!pool))
 		return NULL;
 
-- 
2.43.0


