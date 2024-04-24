Return-Path: <linux-kernel+bounces-157743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6028B1541
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62EC41C21D09
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086C2157474;
	Wed, 24 Apr 2024 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lH4S4A4H"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FFC156F51
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994870; cv=none; b=I9z66tKdF89zpbdORafCMRuObpcvx0b70GycZv8MxtZmRQCppr6wMuU7uaDayKIS2fUDf4IjZrB8lxvYXi8KsAvpo1r9LWcsEbkz+2UXfI6v5DFBv80qSPscbE7FxOsK0+7o2cY9aX2ljpkzN1qZSO4YwpCFQ2oq3IwyoQauxsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994870; c=relaxed/simple;
	bh=n44EIwrVbtUC/HODjVXTzsGeRWoVsJemo0On/8Qrf5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kxPRFy82rZB0Nr8No/A19Ja/lDponauR0idGaIadQy4/PObsi83bAFIOZ/c7HTUwn/r3irbfh0UX3ZIGhRyI+1mJeSCfB9DBcicjuT+H8X4yUpH54dpcQFu+rrMfskQfN7/rSM1XbRm/sdkbs9ciiT6XxvcujZzdbPCzX01H04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lH4S4A4H; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso394218b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713994868; x=1714599668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avaWrT0khuREU5h1MMjzzZvo4YgUdeePn0h1OukYT6Y=;
        b=lH4S4A4HoHvypMCVNU8xzV+BPI1sDaHdPxc8DNbsiIoudb1JJWznStnkN9ssUXg1uQ
         gP8cydF7V/JPkUT1iAwXVek6pvu0JtsVOClA67HI3VN38tOUcxh4mZ7LvT802cIkI/8A
         gC9f/QnBH7KPuz0dw8kgtD1WEYCi/tWek2dK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713994868; x=1714599668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avaWrT0khuREU5h1MMjzzZvo4YgUdeePn0h1OukYT6Y=;
        b=MRJojRRzxhI5W4zxDYncMnhTJYzmRqVD5DXIgvfY67y2zyN/4qj25ByjExf11ofP26
         RjdvCXQucML2/skkmu1V9/9ycDjcpVE7XYxmDPfVODRRczKabjfg7nF8rxMX7Fu8LEc0
         JxPgsz/AJfzO9bkH+ZmeZxZFn1/xpJYdQN71I3gqkQD8ALmMm48R5Nmdk59EYWX1FAJD
         x2ouvb0dX2Bn3/mOJFEveKfnUDe0fnOCfYhytz/bZ2ZjdASv+8+ell0K6292ApkiQXXg
         2FZCFu8lnDwGa6JNhSyfti8BwAf3f8zWDbbKpw4UKL1ZlPZpdMLrZrFbq5K8G/1VXp9N
         NJnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNGNQG02Oc7ZIGYDv5jJLaXLe2xlaqR089DnKg9qQQg6ZJ2IuWnqsNQp4z8/D8utszcMOt5tNrQAmfU5OlmoXRMeeBtbAKu3QAoGdP
X-Gm-Message-State: AOJu0YxORDONNhiLMGNDk2XXF9xikR2I1q4/D+GajAJebFHLufd8SE8Q
	137lG4MKTc5D9tndI1AWFBqXTjAt24kTugVktZIS6iBOuonpZRep2hvGdNByfA==
X-Google-Smtp-Source: AGHT+IHXJzscAQxkhpdn10b8o9bm2jTf9Syzbn/UYNQIO/7g7UQSGqLaU9uDrKL3kC60AEISiyGgRQ==
X-Received: by 2002:a05:6a20:5616:b0:1a7:a353:939e with SMTP id ir22-20020a056a20561600b001a7a353939emr3679161pzc.56.1713994868043;
        Wed, 24 Apr 2024 14:41:08 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x1-20020a63b201000000b005e838b99c96sm11611467pge.80.2024.04.24.14.41.05
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
Subject: [PATCH v3 3/6] mm/slab: Introduce __kvmalloc_node() that can take kmem_buckets argument
Date: Wed, 24 Apr 2024 14:41:00 -0700
Message-Id: <20240424214104.3248214-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424213019.make.366-kees@kernel.org>
References: <20240424213019.make.366-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4187; i=keescook@chromium.org;
 h=from:subject; bh=n44EIwrVbtUC/HODjVXTzsGeRWoVsJemo0On/8Qrf5o=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKXxuIQwklSExmXc87p72DCfh76AnwjYnK9Py8
 7Fv1B+pgpeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZil8bgAKCRCJcvTf3G3A
 JupMD/0VCva4CsvxyFhP/1VkRIHNT9neF+T4OIPegvk9amzhCJfRNJLUcIqZXAK9xEgkjQfbh2D
 vH/7wvvpfhoK+5xeXHZOkczwMl8+V2SiJieg5YMyTQs9ngeiUc00hjMfo/xIUlrurpZtf2QksCA
 Z5jRwHG/EgB7hCDS3nYtURFBj/AXsQTcrLiVJx+SqAmUIZ5yIDa/CocjagCWKN5gwxWe3CEpp56
 PqhbCSxFQc5T/e5xN2S15FaupnNJX9s6PXe2Nx8Q/QUSQXDdwL/XvWV8F6kdM/xCOfYhMu0lrxj
 Wi29HbzMDnNAhqYpc8Ia7vtAX8v6zRiVS0S5i6HRIiRWHJnkNCwXLR92/Gsr/Ta8rt3yVjgjwC6
 WY0VfE2J4xY9wz3TgKXuEYNzOqkTyCXyMGGUZe21ghzrocTHqP/8jxO5T7WvFt4PoBBEAcZ5fxO
 SXGz+iIscVt3qMrVkMfbkgVlY1xaLCz2N4du08JCuwtL9+vntjBOMH4YH9rTxx8D3MRkShjZ0y0
 dBVtSr8odvEdUwdHX4H7FbvCEUJ5aIr3hfLxW9PKBb1H7sv3zw0jMEVpbxezXhcbUxqoiodcJDg
 YlL/45F9uG1CLOOK3MZLM1s1rOOVst3540xcKfxutWb2HIAhckktrVwaCmRKz8NAfuZVOEOIp8a wbiLrOqzM2i8B/g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Plumb kmem_buckets arguments through kvmalloc_node_noprof() so it is
possible to provide an API to perform kvmalloc-style allocations with
a particular set of buckets. Introduce __kvmalloc_node() that takes a
kmem_buckets argument.

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
 include/linux/slab.h | 10 ++++++----
 lib/rhashtable.c     |  2 +-
 mm/util.c            |  5 +++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 07373b680894..23b13be0ac95 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -781,11 +781,13 @@ static inline __alloc_size(1) void *kzalloc_noprof(size_t size, gfp_t flags)
 #define kzalloc(...)				alloc_hooks(kzalloc_noprof(__VA_ARGS__))
 #define kzalloc_node(_size, _flags, _node)	kmalloc_node(_size, (_flags)|__GFP_ZERO, _node)
 
-extern void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node) __alloc_size(1);
-#define kvmalloc_node(...)			alloc_hooks(kvmalloc_node_noprof(__VA_ARGS__))
+extern void *kvmalloc_node_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node)
+					__alloc_size(2);
+#define __kvmalloc_node(...)			alloc_hooks(kvmalloc_node_noprof(__VA_ARGS__))
+#define kvmalloc_node(...)			__kvmalloc_node(NULL, __VA_ARGS__)
 
 #define kvmalloc(_size, _flags)			kvmalloc_node(_size, _flags, NUMA_NO_NODE)
-#define kvmalloc_noprof(_size, _flags)		kvmalloc_node_noprof(_size, _flags, NUMA_NO_NODE)
+#define kvmalloc_noprof(_size, _flags)		kvmalloc_node_noprof(NULL, _size, _flags, NUMA_NO_NODE)
 #define kvzalloc(_size, _flags)			kvmalloc(_size, _flags|__GFP_ZERO)
 
 #define kvzalloc_node(_size, _flags, _node)	kvmalloc_node(_size, _flags|__GFP_ZERO, _node)
@@ -797,7 +799,7 @@ static inline __alloc_size(1, 2) void *kvmalloc_array_noprof(size_t n, size_t si
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
 		return NULL;
 
-	return kvmalloc_node_noprof(bytes, flags, NUMA_NO_NODE);
+	return kvmalloc_node_noprof(NULL, bytes, flags, NUMA_NO_NODE);
 }
 
 #define kvmalloc_array(...)			alloc_hooks(kvmalloc_array_noprof(__VA_ARGS__))
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index dbbed19f8fff..ef0f496e4aed 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -184,7 +184,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	static struct lock_class_key __key;
 
 	tbl = alloc_hooks_tag(ht->alloc_tag,
-			kvmalloc_node_noprof(struct_size(tbl, buckets, nbuckets),
+			kvmalloc_node_noprof(NULL, struct_size(tbl, buckets, nbuckets),
 					     gfp|__GFP_ZERO, NUMA_NO_NODE));
 
 	size = nbuckets;
diff --git a/mm/util.c b/mm/util.c
index 80430e5ba981..bdec4954680a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -596,6 +596,7 @@ EXPORT_SYMBOL(vm_mmap);
 /**
  * kvmalloc_node - attempt to allocate physically contiguous memory, but upon
  * failure, fall back to non-contiguous (vmalloc) allocation.
+ * @b: which set of kmalloc buckets to allocate from.
  * @size: size of the request.
  * @flags: gfp mask for the allocation - must be compatible (superset) with GFP_KERNEL.
  * @node: numa node to allocate from
@@ -609,7 +610,7 @@ EXPORT_SYMBOL(vm_mmap);
  *
  * Return: pointer to the allocated memory of %NULL in case of failure
  */
-void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
+void *kvmalloc_node_noprof(kmem_buckets *b, size_t size, gfp_t flags, int node)
 {
 	gfp_t kmalloc_flags = flags;
 	void *ret;
@@ -631,7 +632,7 @@ void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
 		kmalloc_flags &= ~__GFP_NOFAIL;
 	}
 
-	ret = kmalloc_node_noprof(size, kmalloc_flags, node);
+	ret = __kmalloc_node_noprof(b, size, kmalloc_flags, node);
 
 	/*
 	 * It doesn't really make sense to fallback to vmalloc for sub page
-- 
2.34.1


