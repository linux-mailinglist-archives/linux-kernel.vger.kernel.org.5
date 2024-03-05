Return-Path: <linux-kernel+bounces-92053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2176871A44
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9055282F0E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4A15676A;
	Tue,  5 Mar 2024 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T2v9Wzno"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58556548EB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633433; cv=none; b=a3DY5putNzpxALokEZn3ljogzcYhmmOGzkmj6zls+1Z2lloKKjJYdJ3CZY7SV/xqWRqAFZuLPU7k1Jzs7Zk5UN/MAj637/Ne6lAWYTV3pC/OqnySoURGUdfXVdDw+q5sDYTQNZIPccI9LETpbzw0GFKv6SeE9GQFT1tFBvB+o/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633433; c=relaxed/simple;
	bh=y3vf/uqNKTNnOBLgqwE3tYFT2Luy4iHXIHzaxbjeLuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=im+8owKQT4Uif/08XCglpROvFuX2DrcRiRamvyKTHLBsTKscJxjUnCR4fl/Hdt4nV2aMCp28MygEw+YjvxVKPiM/GH3eYu9t8HAZP9xJTdaA6OzTEjB2ObN2YPTppcegjUq7i9aUre9A0doHCPbJXxqqpvWJkqT0AEwMquJCCiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T2v9Wzno; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e63e9abf6aso286861b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709633430; x=1710238230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeUYrlEBxVnkyCc/znLfwIQ49KwaP7QNJJ/emVdVuls=;
        b=T2v9Wznov3Rjko+n4hZHVIXdf5g1oiKwCASjTXgI5KOSchhWyill9f5IUjDGxRzSES
         yEJaQKUmwDPxRp1Gi+t4H51myK2dZ2s/CEHnHOrvUf3BbKMgXb2wseL6eNmws7ZNHLlR
         YQJ9SxjGN2xqeDKXD23BLrNvq7zMMcWkgGSW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633430; x=1710238230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeUYrlEBxVnkyCc/znLfwIQ49KwaP7QNJJ/emVdVuls=;
        b=ZnVHJXePSsJakwpYkEfvsZKR1/4Hnh0MBB8Olc5eBRinV5lCRe8fg3cu0eRcRrOGJR
         7w59bZyVbGOUrh9akRCLJWKke5hJ14ZkzLLg/SVrKs1Bw8mgyg7PngFaGO40CgBumB/Z
         hskmfiES70SR5KywygLpVU0flCFD/sGpx0UvTdNKL4hCuecoBkMjmNnsIfAQ8FEjaXur
         LQcAk7ZsotR/AiwDXjxTxxBzAWuQhsL7keOsF3r6+fEToV4oaw8V29JnikvvTEsEegnz
         4yspQJUKeLyFj4/jX8Pl+4h2I6/OelUisHNtW6YXd0BKe0yCs3PbG7scaupXCDkar5xw
         p1LA==
X-Forwarded-Encrypted: i=1; AJvYcCWcMDWuyguqtHJ52RRkTYDAD3pwcAh/KNb1rYW8J+xhOYHwLWHJdDD+DmJVXyC3sX9SXWtJ6GK//L4nMHR4VCqU6EE/GNuflAzGblcL
X-Gm-Message-State: AOJu0YyP8IkZKQB0735TtyDl4ZJ+OCEmV6DmhhvOeo0Qxde+6PxASIOd
	lAtTS9U5qrEEGHEM5mDeDOE/BYQbw1nhpdDoMBHI1ZbzP/P5ZTrUrGy1Oe4pcw==
X-Google-Smtp-Source: AGHT+IEA1CSyGq/q0upjn8FhCc79X1Sz1fnRam7a7llwA6f0dlAvS0keaevB9x35pohBL6JFKtxYYg==
X-Received: by 2002:a05:6a20:244c:b0:1a1:4cbe:bf74 with SMTP id t12-20020a056a20244c00b001a14cbebf74mr1486585pzc.15.1709633429921;
        Tue, 05 Mar 2024 02:10:29 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b001dc78455383sm10146541plg.223.2024.03.05.02.10.27
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
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 4/9] slab: Introduce kmem_buckets_create()
Date: Tue,  5 Mar 2024 02:10:20 -0800
Message-Id: <20240305101026.694758-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305100933.it.923-kees@kernel.org>
References: <20240305100933.it.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5125; i=keescook@chromium.org; h=from:subject; bh=y3vf/uqNKTNnOBLgqwE3tYFT2Luy4iHXIHzaxbjeLuY=; b=owEBbAKT/ZANAwAKAYly9N/cbcAmAcsmYgBl5u+QPWE1fKjC5eCeZH4vakqfDEWTI/IohhLqT GoUV/5ej76JAjIEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZebvkAAKCRCJcvTf3G3A Jm/UD/jfSpO31HjXWApCYeolkFhb19QZEq8SrIOIqsqGoGZVAU3k6RWg8yQniQMy3yngBQfa2Ww h/QK0A6lEPzXyLI42kPBmua1RHFrT+Vqe3/1WofvSSsTESICw9TsnzitVinrUOM0nQo51nWISXI rTAc2Dqc1+eteEhuO2mBf61hDJZKYlE3dAE5Oy4yiPLQFOXU363T3VyPS1+jHmjCX9a7U/Fwp1L RE0Jo+IrwYWkV7JCru2Lf9QUOZcLZe1kaDT1S8KGCLBUj0qGfSQ0+6oYCVle7ZtWnAgM69VdfEM u0aSFr9DMPQLnL8DW+S2i4Y7E5d0OaG/m+vACFCAyEOjbMvqBotLX2oVqDLe3wNMWZN/GBxUDdu 9D/jUe03FvtktaMo2UTni3Qsx3d0boMxXGArJ5wo+vyGDDDBs8hxF/3ZhnEd58EUf4/WPWb7Hax 2EybOpRinpRqyal2KGNFPDIBOG4YgGqWYgGXRb3pw4pH6eFdr/PLQhggawSo/Wg96qL8WHZRvZ8 Ndwaph2SCDS3DM+r5nhF8mm7Tw5P9exoRn+a0tJNyv0i8CcN7W2IbJjkG9d/LV/uokfH1SLJWNJ VY+Op6bioLEyekWFsA4tTJyWA5wDB2UiYy2llni7suxYh5HYAzl4ULcPr/X6iHSyvXfscabaGjQ iPexMVWCtLcF/
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Dedicated caches are available For fixed size allocations via
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
defense for dynamically sized allocations.

In order to isolate user-controllable sized allocations from system
allocations, introduce kmem_buckets_create(), which behaves like
kmem_cache_create(). (The next patch will introduce kmem_buckets_alloc(),
which behaves like kmem_cache_alloc().)

Allows for confining allocations to a dedicated set of sized caches
(which have the same layout as the kmalloc caches).

This can also be used in the future once codetag allocation annotations
exist to implement per-caller allocation cache isolation[1] even for
dynamic allocations.

Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [1]
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
 include/linux/slab.h |  5 +++
 mm/slab_common.c     | 72 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index f26ac9a6ef9f..058d0e3cd181 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -493,6 +493,11 @@ void *kmem_cache_alloc_lru(struct kmem_cache *s, struct list_lru *lru,
 			   gfp_t gfpflags) __assume_slab_alignment __malloc;
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
+kmem_buckets *kmem_buckets_create(const char *name, unsigned int align,
+				  slab_flags_t flags,
+				  unsigned int useroffset, unsigned int usersize,
+				  void (*ctor)(void *));
+
 /*
  * Bulk allocation and freeing operations. These are accelerated in an
  * allocator specific way to avoid taking locks repeatedly or building
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1d0f25b6ae91..03ba9aac96b6 100644
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
@@ -933,6 +1001,10 @@ void __init create_kmalloc_caches(slab_flags_t flags)
 
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


