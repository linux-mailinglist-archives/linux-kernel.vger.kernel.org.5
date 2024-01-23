Return-Path: <linux-kernel+bounces-35003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9698B838A67
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2D21C23F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C27A5BAF8;
	Tue, 23 Jan 2024 09:33:57 +0000 (UTC)
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3624A5A0EA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002436; cv=none; b=NTnBxZNjJeDZVHUvQDgFmpChY8gxDZbWLJ0aMz0YAdTHly+caH00nrOgpf7gfVbE6XqiSVqHW0VEQkuXZPAXAhi/wFCgc8edexsctWFwjlY/n20e/ktX2qP97FB7gcndLhEsQvm7f3mvXDPTUtQs8W6X25FHapPh0WE42DFF+w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002436; c=relaxed/simple;
	bh=RxryMU48iVU4pnALkZXNrPy7bZDqLdaz2AEx4p3Ji5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=INOmBbQUA8jqguzGAUJtfx8joJcoWd1/ogekWUedhgr0oGQ/K4ZnpmAPm3+/57cvh7YmFEL+rUlUVsIQK1MfohSEKIXQf6J+b02idxNRmVvpr5MHev86HG8XtRHNyPOLroBjazmP4R1p59JCN0rVS5SXtg8lC87soviN9CjnBnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 23 Jan 2024 09:33:29 +0000
Subject: [PATCH v2 1/3] mm/slub: directly load freelist from cpu partial slab in the
 likely case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240117-slab-misc-v2-1-81766907896e@bytedance.com>
References: <20240117-slab-misc-v2-0-81766907896e@bytedance.com>
In-Reply-To: <20240117-slab-misc-v2-0-81766907896e@bytedance.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Pekka Enberg <penberg@kernel.org>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
 linux-mm@kvack.org, "Christoph Lameter (Ampere)" <cl@linux.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706002427; l=2205;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=RxryMU48iVU4pnALkZXNrPy7bZDqLdaz2AEx4p3Ji5Q=;
 b=378yGXlTZX4OD1uYzqIEJLiYJiKugeTycFRTFrJPpwzMaIF7wNnhWL/62RFkkKgtmJbEawLdi
 XuPcUkfqgQcAYhCGSKbsn/raWfAV9nLnWfdn7JURg7bvvxzMP/mmbwK
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

The likely case is that we get a usable slab from the cpu partial list,
we can directly load freelist from it and return back, instead of going
the other way that need more work, like reenable interrupt and recheck.

But we need to remove the "VM_BUG_ON(!new.frozen)" in get_freelist()
for reusing it, since cpu partial slab is not frozen. It seems
acceptable since it's only for debug purpose.

And get_freelist() also assumes it can return NULL if the freelist is
empty, which is not possible for the cpu partial slab case, so we
add "VM_BUG_ON(!freelist)" after get_freelist() to make it explicit.

There is some small performance improvement too, which shows by:
perf bench sched messaging -g 5 -t -l 100000

            mm-stable   slub-optimize
Total time      7.473    7.209

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..fda402b2d649 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3326,7 +3326,6 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
 		counters = slab->counters;
 
 		new.counters = counters;
-		VM_BUG_ON(!new.frozen);
 
 		new.inuse = slab->objects;
 		new.frozen = freelist != NULL;
@@ -3498,18 +3497,20 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 		slab = slub_percpu_partial(c);
 		slub_set_percpu_partial(c, slab);
-		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
-		stat(s, CPU_PARTIAL_ALLOC);
 
-		if (unlikely(!node_match(slab, node) ||
-			     !pfmemalloc_match(slab, gfpflags))) {
-			slab->next = NULL;
-			__put_partials(s, slab);
-			continue;
+		if (likely(node_match(slab, node) &&
+			   pfmemalloc_match(slab, gfpflags))) {
+			c->slab = slab;
+			freelist = get_freelist(s, slab);
+			VM_BUG_ON(!freelist);
+			stat(s, CPU_PARTIAL_ALLOC);
+			goto load_freelist;
 		}
 
-		freelist = freeze_slab(s, slab);
-		goto retry_load_slab;
+		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+
+		slab->next = NULL;
+		__put_partials(s, slab);
 	}
 #endif
 

-- 
b4 0.10.1

