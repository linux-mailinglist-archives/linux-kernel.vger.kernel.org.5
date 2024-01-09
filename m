Return-Path: <linux-kernel+bounces-21460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33065828F76
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D598928801C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173AB3DBA7;
	Tue,  9 Jan 2024 22:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FeUfEWH8"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44563C6A4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704838361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+MEfEwS7YBgABTVs4pBpb90gb7WYrZTDLj1svt0+kOQ=;
	b=FeUfEWH8NQXFDwxIrMCopRuDErF2CX8T2lyAKILhtxo9p7YHypWHSErr2cSpZ7NUXuCRj4
	T99H0foXMcRpFqGJbZ1VYyl9mF0EBh3+tvcP+Jqmi7D0ItBLHKMSuoNecWKmCENC7avZ/F
	xwbCI/whlohiv7GmWiheHgh8pnDt628=
From: andrey.konovalov@linux.dev
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH mm] kasan: avoid resetting aux_lock
Date: Tue,  9 Jan 2024 23:12:34 +0100
Message-Id: <20240109221234.90929-1-andrey.konovalov@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@gmail.com>

With commit 63b85ac56a64 ("kasan: stop leaking stack trace handles"),
KASAN zeroes out alloc meta when an object is freed. The zeroed out data
purposefully includes alloc and auxiliary stack traces but also
accidentally includes aux_lock.

As aux_lock is only initialized for each object slot during slab
creation, when the freed slot is reallocated, saving auxiliary stack
traces for the new object leads to lockdep reports when taking the
zeroed out aux_lock.

Arguably, we could reinitialize aux_lock when the object is reallocated,
but a simpler solution is to avoid zeroing out aux_lock when an object
gets freed.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Closes: https://lore.kernel.org/linux-next/5cc0f83c-e1d6-45c5-be89-9b86746fe731@paulmck-laptop/
Fixes: 63b85ac56a64 ("kasan: stop leaking stack trace handles")
Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
---
 mm/kasan/generic.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 24c13dfb1e94..df6627f62402 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -487,6 +487,7 @@ void kasan_init_object_meta(struct kmem_cache *cache, const void *object)
 		__memset(alloc_meta, 0, sizeof(*alloc_meta));
 
 		/*
+		 * Prepare the lock for saving auxiliary stack traces.
 		 * Temporarily disable KASAN bug reporting to allow instrumented
 		 * raw_spin_lock_init to access aux_lock, which resides inside
 		 * of a redzone.
@@ -510,8 +511,13 @@ static void release_alloc_meta(struct kasan_alloc_meta *meta)
 	stack_depot_put(meta->aux_stack[0]);
 	stack_depot_put(meta->aux_stack[1]);
 
-	/* Zero out alloc meta to mark it as invalid. */
-	__memset(meta, 0, sizeof(*meta));
+	/*
+	 * Zero out alloc meta to mark it as invalid but keep aux_lock
+	 * initialized to avoid having to reinitialize it when another object
+	 * is allocated in the same slot.
+	 */
+	__memset(&meta->alloc_track, 0, sizeof(meta->alloc_track));
+	__memset(meta->aux_stack, 0, sizeof(meta->aux_stack));
 }
 
 static void release_free_meta(const void *object, struct kasan_free_meta *meta)
-- 
2.25.1


