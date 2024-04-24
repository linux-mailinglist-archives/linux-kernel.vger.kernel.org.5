Return-Path: <linux-kernel+bounces-157745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4EE8B1544
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27ADBB241CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A532715E20A;
	Wed, 24 Apr 2024 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mTTDZ7f/"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6887156F25
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994871; cv=none; b=qix7xlpoXji8Fwp1j9Lbg/XC9PRC9VmSk6zXXY15/ptWSi7EIBm2Sbbv7bFeybooMWw8F8FYZnq38c4Jiq9xPiQt730MVbatk9Rg0tcVS0ngPicCIaPRAr9j38kBFMGbFd7Qz4i2/Q3x2u7GbgdnveAjPIco0KCUpS8t4tz3I4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994871; c=relaxed/simple;
	bh=lWcazK2402lkD4Wrba9Q2qaF3Ixn3Ax0z7KNqGLKz60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJp/JtbL3xvwJbt/1qxlff4+LCqQXcvv4NSVY2SkWVFXWi9e8AwHXrzXgfB/tKFCwqEjvsMRl3ExE8hpnDefYhkshnsnWTUF/io0K3l42bDlR9c+M6KjrU6rja806MafaQhDkZrc1hDM+y0CM08GDNyQ/AiIwifxp69mnt7sd0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mTTDZ7f/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e4f341330fso3134935ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713994869; x=1714599669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+QuwAWtOf2xR22BKuasFxurK2ECAnfs8jdrPoithuU=;
        b=mTTDZ7f/wm4RRaPRIMRtYjTo3bhIX3VjlWqUnRCT+MvSNlYjkBBVWBYuoCA+IFYEwh
         FFpD+hqVtnmGp/Z/cq+5l/XCX/pZLO2pVpPzXF/Q4mH9Q8MqvvITH/C29GRKxugQSiTp
         x2hRVeb3KYfsvQthHZbQROlpYYMRYC3kxRVac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713994869; x=1714599669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+QuwAWtOf2xR22BKuasFxurK2ECAnfs8jdrPoithuU=;
        b=wH5juUok91U8tN+PVwpvrE0cY/b8Hhf1CN8cEKlMNSY+DwK+7aIVqN0Ic+QwAFvCV8
         F96XkXo7h1ybBa5G04tPTPbEECXp1IsrvrQUh7+7hYEoMzp5JsxGjsNEC/D4+TcGuJiw
         mQSdUrE3LQCg/odCf0xqKeAP0DGGMFhIC/Yse5diXgwvprflKlUu0zwm18GMz1vnjlq6
         FWm8W3ijvtT9tF/f48PQt0WiVTFZ6jNChozsRU32+jetFsxMff9Ga8/NJMdrt821A4Ry
         m7Mrz4VLBsp2gDtBq80LUU27MpfALY99TNi9UIo5kmfz/zWMIw0C6sqKngmYjVnFXCFj
         hagA==
X-Forwarded-Encrypted: i=1; AJvYcCU2awIt59UVTD0AXc4nCf0yfL/lK5JkTMaO/yBicIOn2NZxh5iiu5czr5TjQVts5UHepIr9pvFOydobXaX6kHtyXDMMVOqFfU3HJqXy
X-Gm-Message-State: AOJu0YxOn4AcpVyL39H2xHF7dk0FApHS1IGtk5nRboMvTK9oFA1XYH1e
	r6hZMmGq3Rahpnj/7Bv6bKS3VrVRPcaI5Zf1zOl9Sk6CmktbEGw8afk48X/QIg==
X-Google-Smtp-Source: AGHT+IHIXGHtzh8lHI9UAe8GBSXBeuQxS5IrYdgWRav1tlMqSSJ4dcU1FmJlbd5lVXFZJW2TuOd4FQ==
X-Received: by 2002:a17:902:cf0e:b0:1e7:b775:64bd with SMTP id i14-20020a170902cf0e00b001e7b77564bdmr4707051plg.53.1713994869316;
        Wed, 24 Apr 2024 14:41:09 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902a38500b001e2bfd40b86sm12604928pla.47.2024.04.24.14.41.05
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
	linux-hardening@vger.kernel.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	julien.voisin@dustri.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] mm/slab: Plumb kmem_buckets into __do_kmalloc_node()
Date: Wed, 24 Apr 2024 14:40:59 -0700
Message-Id: <20240424214104.3248214-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424213019.make.366-kees@kernel.org>
References: <20240424213019.make.366-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8366; i=keescook@chromium.org;
 h=from:subject; bh=lWcazK2402lkD4Wrba9Q2qaF3Ixn3Ax0z7KNqGLKz60=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKXxuXSr8rdPRSyF2wBgMoZZNHIsBtwsrinlKe
 bq327jZWyuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZil8bgAKCRCJcvTf3G3A
 JjhaD/9qXDqOgVCP5PmY3bLEzzzpXHAburpbBFoBFgjOtLRbbCVNi0RXeJRDstJhZjQ1pSFczdM
 QuP1rYez2GCqsbpwqP/39GLi2CfoHjGr8Fzd0SM0gFnyMvWKgCo57WdcbvolAyq7Yh/YNK77dPA
 egxi2E4zufNQMrJHa8yj1lRv2SXvUtiwwhqpEHyEijmiiK1Xh7Y6P9x5lMiG/5ncfmQqjm6fsN9
 GYRLjidguOaWEL37PqW6mA48nj9La6uF2qVApKk8allKd437NMwr6ChknmdQny65ggUP+tN2ARy
 45Nb/YgZURzOlMvply7vlgbJprBaIzmAI+A6k2EYsJRkdUYkcrI2Alv1eFiIrEUcpxgLbycSI/m
 pGM9FBfYJhF8yOpuwlD/XAifJ/BQ2P9ugQj+D0zBfi5iX8Mas3UB4nC4AXCmU6MbhN/U2e9Yw84
 Tqj35Urvfvfv8HCb5jf7dTQjZP+iu8iLVIJpHJKim2PUwciik3OQQDAskJrqN70pYdexnylVCF9
 85XdAQYytNgqDmDbKXoQUcksz8LtATIg0a1kmk26vJjGxtc/jNs5yvxJtsIqpxRpezTN8xvoqTA
 4GUn6gWe/LrYQFSgwpF4PVsgQ75hZzGbG4gf2uGo/lJ5YN9Sps2ciWQOM185FEQy/V3w3lg4n9m M6uPM7mb/9qJGVQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

To be able to choose which buckets to allocate from, make the buckets
available to the lower level kmalloc interfaces by adding them as the
first argument. Where the bucket is not available, pass NULL, which means
"use the default system kmalloc bucket set" (the prior existing behavior),
as implemented in kmalloc_slab().

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
Cc: linux-hardening@vger.kernel.org
---
 include/linux/slab.h | 16 ++++++++--------
 lib/fortify_kunit.c  |  2 +-
 mm/slab.h            |  6 ++++--
 mm/slab_common.c     |  4 ++--
 mm/slub.c            | 14 +++++++-------
 mm/util.c            |  2 +-
 6 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index c8164d5db420..07373b680894 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -569,8 +569,8 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
-							 __alloc_size(1);
+void *__kmalloc_node_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node)
+				__assume_kmalloc_alignment __alloc_size(2);
 #define __kmalloc_node(...)			alloc_hooks(__kmalloc_node_noprof(__VA_ARGS__))
 
 void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t flags,
@@ -679,7 +679,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node_noprof(size_t size, gf
 				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, node, size);
 	}
-	return __kmalloc_node_noprof(size, flags, node);
+	return __kmalloc_node_noprof(NULL, size, flags, node);
 }
 #define kmalloc_node(...)			alloc_hooks(kmalloc_node_noprof(__VA_ARGS__))
 
@@ -730,10 +730,10 @@ static inline __realloc_size(2, 3) void * __must_check krealloc_array_noprof(voi
  */
 #define kcalloc(n, size, flags)		kmalloc_array(n, size, (flags) | __GFP_ZERO)
 
-void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int node,
-				  unsigned long caller) __alloc_size(1);
+void *kmalloc_node_track_caller_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node,
+				       unsigned long caller) __alloc_size(2);
 #define kmalloc_node_track_caller(...)		\
-	alloc_hooks(kmalloc_node_track_caller_noprof(__VA_ARGS__, _RET_IP_))
+	alloc_hooks(kmalloc_node_track_caller_noprof(NULL, __VA_ARGS__, _RET_IP_))
 
 /*
  * kmalloc_track_caller is a special version of kmalloc that records the
@@ -746,7 +746,7 @@ void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags, int node,
 #define kmalloc_track_caller(...)		kmalloc_node_track_caller(__VA_ARGS__, NUMA_NO_NODE)
 
 #define kmalloc_track_caller_noprof(...)	\
-		kmalloc_node_track_caller_noprof(__VA_ARGS__, NUMA_NO_NODE, _RET_IP_)
+		kmalloc_node_track_caller_noprof(NULL, __VA_ARGS__, NUMA_NO_NODE, _RET_IP_)
 
 static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags,
 							  int node)
@@ -757,7 +757,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_
 		return NULL;
 	if (__builtin_constant_p(n) && __builtin_constant_p(size))
 		return kmalloc_node_noprof(bytes, flags, node);
-	return __kmalloc_node_noprof(bytes, flags, node);
+	return __kmalloc_node_noprof(NULL, bytes, flags, node);
 }
 #define kmalloc_array_node(...)			alloc_hooks(kmalloc_array_node_noprof(__VA_ARGS__))
 
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 493ec02dd5b3..ff059d88d455 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -220,7 +220,7 @@ static void alloc_size_##allocator##_dynamic_test(struct kunit *test)	\
 	checker(expected_size, __kmalloc(alloc_size, gfp),		\
 		kfree(p));						\
 	checker(expected_size,						\
-		__kmalloc_node(alloc_size, gfp, NUMA_NO_NODE),		\
+		__kmalloc_node(NULL, alloc_size, gfp, NUMA_NO_NODE),	\
 		kfree(p));						\
 									\
 	orig = kmalloc(alloc_size, gfp);				\
diff --git a/mm/slab.h b/mm/slab.h
index 5f8f47c5bee0..f459cd338852 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -403,16 +403,18 @@ static inline unsigned int size_index_elem(unsigned int bytes)
  * KMALLOC_MAX_CACHE_SIZE and the caller must check that.
  */
 static inline struct kmem_cache *
-kmalloc_slab(size_t size, gfp_t flags, unsigned long caller)
+kmalloc_slab(kmem_buckets *b, size_t size, gfp_t flags, unsigned long caller)
 {
 	unsigned int index;
 
+	if (!b)
+		b = &kmalloc_caches[kmalloc_type(flags, caller)];
 	if (size <= 192)
 		index = kmalloc_size_index[size_index_elem(size)];
 	else
 		index = fls(size - 1);
 
-	return kmalloc_caches[kmalloc_type(flags, caller)][index];
+	return (*b)[index];
 }
 
 gfp_t kmalloc_fix_flags(gfp_t flags);
diff --git a/mm/slab_common.c b/mm/slab_common.c
index db9e1b15efd5..7cb4e8fd1275 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -702,7 +702,7 @@ size_t kmalloc_size_roundup(size_t size)
 		 * The flags don't matter since size_index is common to all.
 		 * Neither does the caller for just getting ->object_size.
 		 */
-		return kmalloc_slab(size, GFP_KERNEL, 0)->object_size;
+		return kmalloc_slab(NULL, size, GFP_KERNEL, 0)->object_size;
 	}
 
 	/* Above the smaller buckets, size is a multiple of page size. */
@@ -1186,7 +1186,7 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 		return (void *)p;
 	}
 
-	ret = kmalloc_node_track_caller_noprof(new_size, flags, NUMA_NO_NODE, _RET_IP_);
+	ret = kmalloc_node_track_caller_noprof(NULL, new_size, flags, NUMA_NO_NODE, _RET_IP_);
 	if (ret && p) {
 		/* Disable KASAN checks as the object's redzone is accessed. */
 		kasan_disable_current();
diff --git a/mm/slub.c b/mm/slub.c
index 23bc0d236c26..a94a0507e19c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4093,7 +4093,7 @@ void *kmalloc_large_node_noprof(size_t size, gfp_t flags, int node)
 EXPORT_SYMBOL(kmalloc_large_node_noprof);
 
 static __always_inline
-void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
+void *__do_kmalloc_node(kmem_buckets *b, size_t size, gfp_t flags, int node,
 			unsigned long caller)
 {
 	struct kmem_cache *s;
@@ -4109,7 +4109,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
 	if (unlikely(!size))
 		return ZERO_SIZE_PTR;
 
-	s = kmalloc_slab(size, flags, caller);
+	s = kmalloc_slab(b, size, flags, caller);
 
 	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
 	ret = kasan_kmalloc(s, ret, size, flags);
@@ -4117,22 +4117,22 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
 	return ret;
 }
 
-void *__kmalloc_node_noprof(size_t size, gfp_t flags, int node)
+void *__kmalloc_node_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node)
 {
-	return __do_kmalloc_node(size, flags, node, _RET_IP_);
+	return __do_kmalloc_node(b, size, flags, node, _RET_IP_);
 }
 EXPORT_SYMBOL(__kmalloc_node_noprof);
 
 void *__kmalloc_noprof(size_t size, gfp_t flags)
 {
-	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
+	return __do_kmalloc_node(NULL, size, flags, NUMA_NO_NODE, _RET_IP_);
 }
 EXPORT_SYMBOL(__kmalloc_noprof);
 
-void *kmalloc_node_track_caller_noprof(size_t size, gfp_t flags,
+void *kmalloc_node_track_caller_noprof(kmem_buckets *b, size_t size, gfp_t flags,
 				       int node, unsigned long caller)
 {
-	return __do_kmalloc_node(size, flags, node, caller);
+	return __do_kmalloc_node(b, size, flags, node, caller);
 }
 EXPORT_SYMBOL(kmalloc_node_track_caller_noprof);
 
diff --git a/mm/util.c b/mm/util.c
index c9e519e6811f..80430e5ba981 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -128,7 +128,7 @@ void *kmemdup_noprof(const void *src, size_t len, gfp_t gfp)
 {
 	void *p;
 
-	p = kmalloc_node_track_caller_noprof(len, gfp, NUMA_NO_NODE, _RET_IP_);
+	p = kmalloc_node_track_caller_noprof(NULL, len, gfp, NUMA_NO_NODE, _RET_IP_);
 	if (p)
 		memcpy(p, src, len);
 	return p;
-- 
2.34.1


