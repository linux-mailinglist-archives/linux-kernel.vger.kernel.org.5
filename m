Return-Path: <linux-kernel+bounces-157746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CA08B1545
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4101A286982
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9E6160862;
	Wed, 24 Apr 2024 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H8zCYV0M"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C0156F53
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994872; cv=none; b=cFdLQk80YmmAqJ5XBln+KcjaREsOzPUgaMACI11QlqTWf6byLpqG8hnDTBpTzrsEZ4Qsz91oxRySsGt8NaCeYsWRTa/bEYbuWjGLsv3rDM1l2ptQZBurb6NIzmEALO8YnKpNrG3LiBkNNhsuThFf/ZnrNIvTcX7rNGf+WQJyI3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994872; c=relaxed/simple;
	bh=C0Prx/nK0APcgMVkHJYdvYJapdDY3C5e64QBsP8kI7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZD142uwDQFCfZevyQjRAo7kkRpswa3vmstAFnzRLASjDGopWRtxYxaknpxpa4+CZHzTuDlX9mGX79iR2lVQXUsVzv7G2mJWq5o/BmhmHN/n1HE6vG09PrcLN0b4oFRDtStbpG+WJ/0e15FlUCgW2h3BseElf0BW7XZInLRuvak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H8zCYV0M; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so3038115ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713994870; x=1714599670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgSg7tRErA3GTFqfC6/09RNvabn2ysccNK/8UlB0lqg=;
        b=H8zCYV0Maxf2Z+1r5TWBePYVr5R6C/5OMRQFn3atp8YIyTgaAlheMeuRkVdK6mXa7a
         xZ7wP9+h/Nv3dPccL8xFSOGiLxqoz2Bug2lj5RTssjDwhQ6a0PK/kxhSxR8gIeUX0Kdp
         g4iFVVheA0PGgmGnEuFD4PpRiqYhjrwfQHAp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713994870; x=1714599670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgSg7tRErA3GTFqfC6/09RNvabn2ysccNK/8UlB0lqg=;
        b=VBghti4pbWKzrUItOIKA5ETb+x3PL/sj+tEuq1Kh7akNA7Dzku2FOM1TiYfNSdx4f+
         CBw51TKrfsiHl3y2YkXwg7Iw0SCSnDbisjypAVdFO4y2kHlFXuuYzs9gpFvAqUCq6Zu3
         TWxf9ExD/UZPSWlUwa7FIYbT0yzJjvN1OKuXOTyEj6CgLE4CdymK7aFNaw7XnGpSP3Qn
         lOz8JFFpPRhkQj6ZDDrjz+o5FIPiU8d+dg2aD/VjdePOl3nNJ6+4i4i+CL49EMGljwY9
         9/XYAk08g7jCvtrPjueN80keq3DybwM2l3KL44/qljcVYyCWPCelo+69uFzv2GHjTQNh
         T1mw==
X-Forwarded-Encrypted: i=1; AJvYcCURvTzlG5tHnfI6snMS4OGwA72y8GnG9BaSdOe5pIBWOmzgnq/5LIw2fAcrquQFuWqDjnl0PPPJASXe22EheM5e+hJEpC8Yjp/686aS
X-Gm-Message-State: AOJu0YzAb1Wzj1vVByRaaQXUEmpfinW8EoJ95+STfhvODrQuFmJLGbe8
	qyT3QOtJkEV7OEwZDkL8KW5GShcG6l847Pic+Y/ZJf7ceEw7Go+ZP5Y5Bsp2bg==
X-Google-Smtp-Source: AGHT+IHb55e4QA/5/nvYk8hjmJDauEXroyLEAzvYHGIUTin2g6qZf3SjNVhCZtuDOfjBzSSBH/ffBQ==
X-Received: by 2002:a17:903:32c5:b0:1e3:e1ff:2e79 with SMTP id i5-20020a17090332c500b001e3e1ff2e79mr4664344plr.45.1713994869664;
        Wed, 24 Apr 2024 14:41:09 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902ecc800b001e944fc9248sm8170647plh.194.2024.04.24.14.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 14:41:05 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	julien.voisin@dustri.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 4/6] mm/slab: Introduce kmem_buckets_create() and family
Date: Wed, 24 Apr 2024 14:41:01 -0700
Message-Id: <20240424214104.3248214-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424213019.make.366-kees@kernel.org>
References: <20240424213019.make.366-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7010; i=keescook@chromium.org;
 h=from:subject; bh=C0Prx/nK0APcgMVkHJYdvYJapdDY3C5e64QBsP8kI7M=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKXxuY6dgso5CobllhqEMKf+YP1OAj0tPWmvHV
 V/Awo4RmLeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZil8bgAKCRCJcvTf3G3A
 Jqa7D/4xKQ5cm8fo1KortUawuJbdD58RkZxTRydP+JlQbVi/tshUUQFxdEjS36UO7Ine1xNL6eL
 VQkwIqn4v+jkXbAlyXJynBw6USOvJPLMvkjKyTbnF+xRbqnLcZwtbnDDAXWmCSDAAYQng+WwgxG
 8lJQJftOJBVtOIeQmjDgzC2L8KX0WFPKVnlWuV7fSsdyPvqloa2Q1JNk2bdHwFCEv35X8aQSnt/
 4fO8eHYzhOInTIe5set0qN1Ho70Dkalud5cv/0BJTeECVfsmvozJ2hlq//jhZNHnurhzGNt4w7A
 GH4n4wynqIdieggoJBLVJ6ErY4SIvop/3G3BXB++Q9XgHMtnM+XfYb1cYXZuIQWTJKmLjX5Iwk0
 XsCGCXyWWj9ciiwT67Adl/cOnovL6SNORwRVR+MIr/UR5BZTveOWwQEEyXKZewp9ucq0Euvm+PP
 no6zUeieXsC/WHnGd/ODPO0A3PD0d87TLhjz7B2P1IiwNEmcNrRYp03SIy3LlWBcjkEEBTLRzmH
 S1Mb+AyR8PLvQS4Sb29XYgL9l9e7oOLmdJjD9rMP4M1xRFcnb7Ki+Q2RO8CmI21fyf6pFNusf9a
 LdyNNrHcTf3EEJi+USDAgOp/hHIK2VXgig5x64lTso76okPx8USqNBnY8uET6RSCjriSCYhYFM6 0zaJmVbJuJfE0cQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Dedicated caches are available for fixed size allocations via
kmem_cache_alloc(), but for dynamically sized allocations there is only
the global kmalloc API's set of buckets available. This means it isn't
possible to separate specific sets of dynamically sized allocations into
a separate collection of caches.

This leads to a use-after-free exploitation weakness in the Linux
kernel since many heap memory spraying/grooming attacks depend on using
userspace-controllable dynamically sized allocations to collide with
fixed size allocations that end up in same cache.

While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
against these kinds of "type confusion" attacks, including for fixed
same-size heap objects, we can create a complementary deterministic
defense for dynamically sized allocations that are directly user
controlled. Addressing these cases is limited in scope, so isolation these
kinds of interfaces will not become an unbounded game of whack-a-mole. For
example, pass through memdup_user(), making isolation there very
effective.

In order to isolate user-controllable sized allocations from system
allocations, introduce kmem_buckets_create(), which behaves like
kmem_cache_create(). Introduce kmem_buckets_alloc(), which behaves like
kmem_cache_alloc(). Introduce kmem_buckets_alloc_track_caller() for
where caller tracking is needed. Introduce kmem_buckets_valloc() for
cases where vmalloc callback is needed.

Allows for confining allocations to a dedicated set of sized caches
(which have the same layout as the kmalloc caches).

This can also be used in the future to extend codetag allocation
annotations to implement per-caller allocation cache isolation[1] even
for dynamic allocations.

Memory allocation pinning[2] is still needed to plug the Use-After-Free
cross-allocator weakness, but that is an existing and separate issue
which is complementary to this improvement. Development continues for
that feature via the SLAB_VIRTUAL[3] series (which could also provide
guard pages -- another complementary improvement).

Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
Link: https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html [2]
Link: https://lore.kernel.org/lkml/20230915105933.495735-1-matteorizzo@google.com/ [3]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
---
 include/linux/slab.h | 13 ++++++++
 mm/slab_common.c     | 72 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 23b13be0ac95..1f14a65741a6 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -552,6 +552,11 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
+kmem_buckets *kmem_buckets_create(const char *name, unsigned int align,
+				  slab_flags_t flags,
+				  unsigned int useroffset, unsigned int usersize,
+				  void (*ctor)(void *));
+
 /*
  * Bulk allocation and freeing operations. These are accelerated in an
  * allocator specific way to avoid taking locks repeatedly or building
@@ -666,6 +671,12 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 }
 #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
 
+#define kmem_buckets_alloc(_b, _size, _flags)	\
+	alloc_hooks(__kmalloc_node_noprof(_b, _size, _flags, NUMA_NO_NODE))
+
+#define kmem_buckets_alloc_track_caller(_b, _size, _flags)	\
+	alloc_hooks(kmalloc_node_track_caller_noprof(_b, _size, _flags, NUMA_NO_NODE, _RET_IP_))
+
 static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gfp_t flags, int node)
 {
 	if (__builtin_constant_p(size) && size) {
@@ -792,6 +803,8 @@ extern void *kvmalloc_node_noprof(kmem_buckets *b, size_t size, gfp_t flags, int
 
 #define kvzalloc_node(_size, _flags, _node)	kvmalloc_node(_size, _flags|__GFP_ZERO, _node)
 
+#define kmem_buckets_valloc(_b, _size, _flags)	__kvmalloc_node(_b, _size, _flags, NUMA_NO_NODE)
+
 static inline __alloc_size(1, 2) void *kvmalloc_array_noprof(size_t n, size_t size, gfp_t flags)
 {
 	size_t bytes;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 7cb4e8fd1275..e36360e63ebd 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -392,6 +392,74 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 }
 EXPORT_SYMBOL(kmem_cache_create);
 
+static struct kmem_cache *kmem_buckets_cache __ro_after_init;
+
+kmem_buckets *kmem_buckets_create(const char *name, unsigned int align,
+				  slab_flags_t flags,
+				  unsigned int useroffset,
+				  unsigned int usersize,
+				  void (*ctor)(void *))
+{
+	kmem_buckets *b;
+	int idx;
+
+	if (WARN_ON(!kmem_buckets_cache))
+		return NULL;
+
+	b = kmem_cache_alloc(kmem_buckets_cache, GFP_KERNEL|__GFP_ZERO);
+	if (WARN_ON(!b))
+		return NULL;
+
+	flags |= SLAB_NO_MERGE;
+
+	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
+		char *short_size, *cache_name;
+		unsigned int cache_useroffset, cache_usersize;
+		unsigned int size;
+
+		if (!kmalloc_caches[KMALLOC_NORMAL][idx])
+			continue;
+
+		size = kmalloc_caches[KMALLOC_NORMAL][idx]->object_size;
+		if (!size)
+			continue;
+
+		short_size = strchr(kmalloc_caches[KMALLOC_NORMAL][idx]->name, '-');
+		if (WARN_ON(!short_size))
+			goto fail;
+
+		cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
+		if (WARN_ON(!cache_name))
+			goto fail;
+
+		if (useroffset >= size) {
+			cache_useroffset = 0;
+			cache_usersize = 0;
+		} else {
+			cache_useroffset = useroffset;
+			cache_usersize = min(size - cache_useroffset, usersize);
+		}
+		(*b)[idx] = kmem_cache_create_usercopy(cache_name, size,
+					align, flags, cache_useroffset,
+					cache_usersize, ctor);
+		kfree(cache_name);
+		if (WARN_ON(!(*b)[idx]))
+			goto fail;
+	}
+
+	return b;
+
+fail:
+	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
+		if ((*b)[idx])
+			kmem_cache_destroy((*b)[idx]);
+	}
+	kfree(b);
+
+	return NULL;
+}
+EXPORT_SYMBOL(kmem_buckets_create);
+
 #ifdef SLAB_SUPPORTS_SYSFS
 /*
  * For a given kmem_cache, kmem_cache_destroy() should only be called
@@ -938,6 +1006,10 @@ void __init create_kmalloc_caches(void)
 
 	/* Kmalloc array is now usable */
 	slab_state = UP;
+
+	kmem_buckets_cache = kmem_cache_create("kmalloc_buckets",
+					       sizeof(kmem_buckets),
+					       0, 0, NULL);
 }
 
 /**
-- 
2.34.1


