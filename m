Return-Path: <linux-kernel+bounces-92054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C32C871A46
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305021C21291
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C08E5788F;
	Tue,  5 Mar 2024 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DzqiGsMv"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F77548EE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633434; cv=none; b=lsyaTPSL0yV53SzXKgl6L0Ojy7MvNuP2g//QTv/0hjJdEvzNIFM4XMetI/9ZonunxSSPNuzDRjEfbJDdmA04mzwAfI7oYLbQ///BLmBNuWO8rVxCctDHdLZbCYdXppPtGLSsVUk2sJvDGm9eDb0Nvy5394M/3YKRQrW+5XLqe+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633434; c=relaxed/simple;
	bh=dsYwePKLsCLMzShH9MEQL3PgSxerM2N+02XNBrgQB3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+NV6xvj78AaevbCgRKZTMQeTFb7crZWb2ryEQK5a+4FmeP48qrJK4C4Qqi+GOv9VuiCwcfjEXLJc07ES0TLVvZWb0PvFt2GojJDojeKYVpHZK6Uz2PW83kXrg7XJP1vKpipxjrBwE+E+xd93k8d2O8rNX/zvtqqhxPnA4Wvoa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DzqiGsMv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dca3951ad9so52543305ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709633431; x=1710238231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCac96MRWhgh1/2EEmwcpolePHb0x1wbAjOzVa8BY+0=;
        b=DzqiGsMvnyuPX9FYpscrIGebjxFCgVqN8A4eMd5SDSMtEnT7/iK1cl5+LkAeASNtCH
         vq1PFFDl3DXQo6QPaxBMVlxhJ/NOusiSP/iXdVA2gnLBaxqMzUH+yut0IWq+rcNABnzQ
         59x8w3H71un7a8F7JQRBvIZ45eZp+iuHOnu7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633431; x=1710238231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCac96MRWhgh1/2EEmwcpolePHb0x1wbAjOzVa8BY+0=;
        b=WryAcyHsIJWh1FXFjw174j5W29mUh4vG7VDk1cY1303tiSVu/2CoKPXarMz7gujrdc
         LMQxz+m+H308yRSa5RiYu/16+Pf5JiQwDZxPrxDlK4CwE/vYbbLY+eY4VQ+o1F5/k9RW
         WTnHhNrI58tfKbwUf1Ne4hpAJug5CfwamrbeDR1+vy8iw8RXLozkqtBosugWI7cTciej
         Xiwq3omvSFZ0jUJkaTjl0TOL36Bzk0yGr3h+frMI/XwCVN+rv5Zr8CD3GGxiQ4XwlTfv
         oVBmBcrkhETtn0BfLND09DF50XV29sfTLfULg+W7I0ulGqVA4dk6Fr03exKbXEUMrfgy
         3eHg==
X-Forwarded-Encrypted: i=1; AJvYcCWGYE031X1Dmi/eoWKbxdS5wrixdIXQc3RQn3w77J0hfB5uO9T/6CeGdieP1HrfVc9RrcNw7YTJXfx7a1U0Rmfi5IjnpZGswmzAcc/r
X-Gm-Message-State: AOJu0Yy2zDtK0As4AhYRtqOe4SB9fdBwp0YEhmfL3yNzq42mBNOqsXkc
	6rQWkfkUvODzYx/ccYwvFbWIdnvHOXKVqowBhCmGWEANXMSGbS2ueyLDsCh5hw==
X-Google-Smtp-Source: AGHT+IGQD7egJY3N2jy+qTOLk98RlzGpfSgXtQ8qNR83/EYIZpLvDqeKxbLyOSOxTxFrRo9HzKuI6Q==
X-Received: by 2002:a17:903:230a:b0:1dc:fb9d:402d with SMTP id d10-20020a170903230a00b001dcfb9d402dmr1584663plh.58.1709633430745;
        Tue, 05 Mar 2024 02:10:30 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n7-20020a170903110700b001dc9893b03bsm10063682plh.272.2024.03.05.02.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:10:27 -0800 (PST)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] slub: Plumb kmem_buckets into __do_kmalloc_node()
Date: Tue,  5 Mar 2024 02:10:18 -0800
Message-Id: <20240305101026.694758-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305100933.it.923-kees@kernel.org>
References: <20240305100933.it.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5763; i=keescook@chromium.org;
 h=from:subject; bh=dsYwePKLsCLMzShH9MEQL3PgSxerM2N+02XNBrgQB3U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5u+Qh5OvUkS2WLPejBFffVYr3X7AdnuJ+g+ss
 wawW9pNc9iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZebvkAAKCRCJcvTf3G3A
 Jpz5D/90L2rsJJvl6+P+wDTk00KFpS0yvEOEnTFGCVFHdm1gLjjRgBEZOCCPWclrHgGTkc8hBia
 nOccJ3xAylGH42H9q91nYChjlw/IZUry4o+uK9hKbxXcdC57QMGm38XenTvoOd4Eeqry07ryFmS
 Vtt0qurq/+5ki/6NecKkeipCrrNoA5RCxIDY0d95UiJV9EO4VZiWoeJ6j+YW6sCHuYqojJUmth8
 nASULi9PDpCRxUlhbDJGHsgd7vhSSVKhr+iAVeILIgKu0ABrT+JLWABfwImg0azZt5Ls1q6akOw
 gnS+llQjZPPJ3vLk3Yqy3vdLff1gpUvad4G0TTJ69rOlneNSxmYTtrZZcxO/7jqHYl3Y3+pZWcI
 Ag/9AGf2AlCALy0WdUlBXXNfJE4lwywJnBfsr7GkeTtnd8JhTwB2w92l+xuHv5JUmzB5cSk6EOK
 dLaYXgNTlKnMTIq8eiOLrYhtEZGOpGgC15pVSSGiUBGviTyv+Rdi59+L+NVkvcHyG9z+2qVDc9/
 Lvm8+g1VDnXM8KSNOfUFbX48M+wlbPFG1fhjcwxttYIsH2AqUtWu8K48KlXf5ugIsLGlhRQmjEX
 8bFw/IhfXee/9Bt9phiU1TThOqIbodEUWlAb14Y/A/0YMUIOJbkeUWTR5mjkPZDaIFUh0MEGkE/ lg0QYFHUdAVLRJg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

To be able to choose which buckets to allocate from, make the buckets
available to the lower level kmalloc interfaces.

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
 include/linux/slab.h |  8 ++++----
 lib/fortify_kunit.c  |  2 +-
 mm/slab.h            |  6 ++++--
 mm/slab_common.c     |  2 +-
 mm/slub.c            | 12 ++++++------
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 55059faf166c..1cc1a7637b56 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -508,8 +508,8 @@ static __always_inline void kfree_bulk(size_t size, void **p)
 	kmem_cache_free_bulk(NULL, size, p);
 }
 
-void *__kmalloc_node(size_t size, gfp_t flags, int node) __assume_kmalloc_alignment
-							 __alloc_size(1);
+void *__kmalloc_node(kmem_buckets *b, size_t size, gfp_t flags, int node)
+		     __assume_kmalloc_alignment __alloc_size(2);
 void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t flags, int node) __assume_slab_alignment
 									 __malloc;
 
@@ -608,7 +608,7 @@ static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t fla
 				kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 				flags, node, size);
 	}
-	return __kmalloc_node(size, flags, node);
+	return __kmalloc_node(NULL, size, flags, node);
 }
 
 /**
@@ -686,7 +686,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_node(size_t n, size_t size,
 		return NULL;
 	if (__builtin_constant_p(n) && __builtin_constant_p(size))
 		return kmalloc_node(bytes, flags, node);
-	return __kmalloc_node(bytes, flags, node);
+	return __kmalloc_node(NULL, bytes, flags, node);
 }
 
 static inline __alloc_size(1, 2) void *kcalloc_node(size_t n, size_t size, gfp_t flags, int node)
diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index 2e4fedc81621..c44400b577f3 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -182,7 +182,7 @@ static void alloc_size_##allocator##_dynamic_test(struct kunit *test)	\
 	checker(expected_size, __kmalloc(alloc_size, gfp),		\
 		kfree(p));						\
 	checker(expected_size,						\
-		__kmalloc_node(alloc_size, gfp, NUMA_NO_NODE),		\
+		__kmalloc_node(NULL, alloc_size, gfp, NUMA_NO_NODE),	\
 		kfree(p));						\
 									\
 	orig = kmalloc(alloc_size, gfp);				\
diff --git a/mm/slab.h b/mm/slab.h
index 54deeb0428c6..931f261bde48 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -404,16 +404,18 @@ static inline unsigned int size_index_elem(unsigned int bytes)
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
index 8787cf17d6e4..1d0f25b6ae91 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -698,7 +698,7 @@ size_t kmalloc_size_roundup(size_t size)
 		 * The flags don't matter since size_index is common to all.
 		 * Neither does the caller for just getting ->object_size.
 		 */
-		return kmalloc_slab(size, GFP_KERNEL, 0)->object_size;
+		return kmalloc_slab(NULL, size, GFP_KERNEL, 0)->object_size;
 	}
 
 	/* Above the smaller buckets, size is a multiple of page size. */
diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..71220b4b1f79 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3959,7 +3959,7 @@ void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 EXPORT_SYMBOL(kmalloc_large_node);
 
 static __always_inline
-void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
+void *__do_kmalloc_node(kmem_buckets *b, size_t size, gfp_t flags, int node,
 			unsigned long caller)
 {
 	struct kmem_cache *s;
@@ -3975,7 +3975,7 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
 	if (unlikely(!size))
 		return ZERO_SIZE_PTR;
 
-	s = kmalloc_slab(size, flags, caller);
+	s = kmalloc_slab(b, size, flags, caller);
 
 	ret = slab_alloc_node(s, NULL, flags, node, caller, size);
 	ret = kasan_kmalloc(s, ret, size, flags);
@@ -3983,22 +3983,22 @@ void *__do_kmalloc_node(size_t size, gfp_t flags, int node,
 	return ret;
 }
 
-void *__kmalloc_node(size_t size, gfp_t flags, int node)
+void *__kmalloc_node(kmem_buckets *b, size_t size, gfp_t flags, int node)
 {
-	return __do_kmalloc_node(size, flags, node, _RET_IP_);
+	return __do_kmalloc_node(b, size, flags, node, _RET_IP_);
 }
 EXPORT_SYMBOL(__kmalloc_node);
 
 void *__kmalloc(size_t size, gfp_t flags)
 {
-	return __do_kmalloc_node(size, flags, NUMA_NO_NODE, _RET_IP_);
+	return __do_kmalloc_node(NULL, size, flags, NUMA_NO_NODE, _RET_IP_);
 }
 EXPORT_SYMBOL(__kmalloc);
 
 void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
 				  int node, unsigned long caller)
 {
-	return __do_kmalloc_node(size, flags, node, caller);
+	return __do_kmalloc_node(NULL, size, flags, node, caller);
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
 
-- 
2.34.1


