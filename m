Return-Path: <linux-kernel+bounces-74688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE4B85D7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0D8EB22B07
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AFC4F61C;
	Wed, 21 Feb 2024 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CpeiNZrZ"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486C64D13B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517595; cv=none; b=Ex30YzcKIVTXE485KnV8QtDoaK+Ez75ic0Oi9o9ZX32fvS33FvB6jB4R0Ig7StRMMFCnYIPZuWsMD9eh31W5MAov/HMS6QatZBRp2ZBd0CYzwfn9FAHJjAUmxbr6JZU+qRixYFys2R2SGomsDi+USGZwx+9V4b58wgzz9QEnxgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517595; c=relaxed/simple;
	bh=nk9RpluGr0tF6v2tluYj3gtiA6vjGhoHRasqnmMVpqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ib+ieLw0FqYVaelIZf5VQTh846mQwKoCI7ag9nEcsQdzlUcyFiUtjozjpMBRqym+SuxFC0dxR/xCCqcy/Ij+6qlYgUQZXmI9D/EINnrcG/jYUj6ji2wbofs3oxzNxP8KrGbH4UasKAZTAWSwXjbaO57wSkKLkCno+joBYPUx3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CpeiNZrZ; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708517591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bz0cGVE6WLA7e0c4EkbAqLj7Vrv2Vyq9GZ8uOCbwj1A=;
	b=CpeiNZrZjiLtxn4Z3YUU5MaXkCDTRZld89DR18NlWJCzgwcmoiU5JeeHp9r8ObETMn3otk
	eTpYeU1WSTuDozM9Idjqi+S6QnWvwPCXGrumeo8uKgQ0IugTfladj4nkro5cnq7Q/xO9x7
	UMTqigC7MoVqBL7Auc87Oul3z9zJuxI=
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Wed, 21 Feb 2024 12:12:53 +0000
Subject: [PATCH 1/2] mm, slab: remove unused object_size parameter in
 kmem_cache_flags()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240221-slab-cleanup-v1-1-63382f41d699@linux.dev>
References: <20240221-slab-cleanup-v1-0-63382f41d699@linux.dev>
In-Reply-To: <20240221-slab-cleanup-v1-0-63382f41d699@linux.dev>
To: Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <roman.gushchin@linux.dev>
Cc: Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708517585; l=2862;
 i=chengming.zhou@linux.dev; s=20240220; h=from:subject:message-id;
 bh=nk9RpluGr0tF6v2tluYj3gtiA6vjGhoHRasqnmMVpqo=;
 b=Vxbg1J2RwEx3Y/a5Ivg5HMPbt0xZi3xKziMxqbb5re7o+KxAFmvs+ke8YVeB6B6zuUoMssnAF
 D4gzuY3tfmrA8fYBTtMNySrGukRjESuSPIx1SroYlU+GZ9XiSc7H28A
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=5+68Wfci+T30FoQos5RH+hfToF6SlC+S9LMPSPBFWuw=
X-Migadu-Flow: FLOW_OUT

We don't need the object_size parameter in kmem_cache_flags(), so
just remove it.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/slab.h        | 3 +--
 mm/slab_common.c | 2 +-
 mm/slub.c        | 9 +++------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 54deeb0428c6..161a3fe5d573 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -435,8 +435,7 @@ struct kmem_cache *
 __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
 		   slab_flags_t flags, void (*ctor)(void *));
 
-slab_flags_t kmem_cache_flags(unsigned int object_size,
-	slab_flags_t flags, const char *name);
+slab_flags_t kmem_cache_flags(slab_flags_t flags, const char *name);
 
 static inline bool is_kmalloc_cache(struct kmem_cache *s)
 {
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 238293b1dbe1..e86557397a61 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -172,7 +172,7 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
 	size = ALIGN(size, sizeof(void *));
 	align = calculate_alignment(flags, align, size);
 	size = ALIGN(size, align);
-	flags = kmem_cache_flags(size, flags, name);
+	flags = kmem_cache_flags(flags, name);
 
 	if (flags & SLAB_NEVER_MERGE)
 		return NULL;
diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..95700f2b17ae 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1764,7 +1764,6 @@ __setup("slub_debug", setup_slub_debug);
 
 /*
  * kmem_cache_flags - apply debugging options to the cache
- * @object_size:	the size of an object without meta data
  * @flags:		flags to set
  * @name:		name of the cache
  *
@@ -1773,8 +1772,7 @@ __setup("slub_debug", setup_slub_debug);
  * slub_debug=<Debug-Options>,<slab name1>,<slab name2> ...
  * then only the select slabs will receive the debug option(s).
  */
-slab_flags_t kmem_cache_flags(unsigned int object_size,
-	slab_flags_t flags, const char *name)
+slab_flags_t kmem_cache_flags(slab_flags_t flags, const char *name)
 {
 	char *iter;
 	size_t len;
@@ -1850,8 +1848,7 @@ static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,
 					struct slab *slab) {}
 static inline void remove_full(struct kmem_cache *s, struct kmem_cache_node *n,
 					struct slab *slab) {}
-slab_flags_t kmem_cache_flags(unsigned int object_size,
-	slab_flags_t flags, const char *name)
+slab_flags_t kmem_cache_flags(slab_flags_t flags, const char *name)
 {
 	return flags;
 }
@@ -5104,7 +5101,7 @@ static int calculate_sizes(struct kmem_cache *s)
 
 static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 {
-	s->flags = kmem_cache_flags(s->size, flags, s->name);
+	s->flags = kmem_cache_flags(flags, s->name);
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	s->random = get_random_long();
 #endif

-- 
b4 0.10.1

