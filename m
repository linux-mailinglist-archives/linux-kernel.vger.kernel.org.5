Return-Path: <linux-kernel+bounces-92052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A6E871A43
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD76282E83
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC3B55C2C;
	Tue,  5 Mar 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c7s1eTp2"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2679548E6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633431; cv=none; b=t3mHRqkCbPp4ZzHfMj5e2keWbHaHGbXtbepMvPuH24b5Je6ekWW6sYJ7yPcRqpPMgFqoqPj8GvDHR1WzCq83iHKBt9ax/60waL+WN8QqLFtzUiZINL/72eLqsitAcgyPU8cW/Sfa4qGgfFDE2l7BnJ2VNh1HtfW71s6hT6BAJSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633431; c=relaxed/simple;
	bh=JqAs2ONNE7kMO16unP+0GI5vQbPsq9Mj6KA7f6Xw/go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FQ3uWASoT6BsqEBCu6mTBnI3GaRr2F0nGVyNGnvMG5277iZWi/Kueqh/aY9j7jrd+2B62n6eQhaujKEsUJHsg+eqrFuwzv8YFmAaG5Mz0TIiauDuggwzpHDfZlOZGO6krdU92LYj8EmLKBXpDOX6PbP4m9RqaM6mKHS7PtYyvTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c7s1eTp2; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dcb3e6ff3fso28228905ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 02:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709633429; x=1710238229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99J+yh1I+zD4qoBsjvOLBvxyDWRgmU0/2arb8UvstmI=;
        b=c7s1eTp2x2Pq2b9KQvTawnB3//dDRaQv74AoAQ0vFDZMj5jR6j9mTZSvTDYq8Rp2sv
         VcNa/zs5XOC0eWji8hCrNtjl+TiPm0tuokacJ5QssGeaDCO9TPwyeSAF/DzJI83YdF2B
         q+oYzDkdnlAHhfPKhnP9lBuczvlEVL2LeUEqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633429; x=1710238229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99J+yh1I+zD4qoBsjvOLBvxyDWRgmU0/2arb8UvstmI=;
        b=EKfPgNuh09IGPLb32oxAgF3+NYjjFrAbhx5K+HPVfGOCxbz7Bnmy294Dlh+dELoh9m
         uI1otR0QeVXQMFxsh4huKx4WfNtCr/z3kfBzWqBbmjnRsDqbwHGsn3l7nCwfiBJmveZR
         lat2KZyIRflX25vH/WMEjcx+0BBs+Li2XNjnWGJ28kD90sX2CKHnMFzHuDUV1j9yq0Qs
         Q4L72oMFiM7LQ4QVUjdtwPM7BRoJE6SgemjM0uu0aej9If2s5dQtZ8oRNk8CSlOMm9nV
         Lk0zRFO+yGtHd50SqbaPaCuOmzr+Q44IagxdYNeKG5wtsBXm5/zGXXprPYWBsWMDJRzP
         c5lg==
X-Forwarded-Encrypted: i=1; AJvYcCXr0emkwGqpQcmS+Q3V3iG2qDip23dpJZxYEWonkifcVqx43bW/3vI0A8lP3NegFa/dIxINYICtinLckNLn19E5YuYIWwYvFEiwXRWZ
X-Gm-Message-State: AOJu0YwysDecixirhbWdqABHUJL3zXm8OU8Ni9e1MjzwcYMicrnOXtC+
	9C2v4vLD8KX0Mh/kqq9oCaN3advwtAqEr5OxhNVh4l9tEmvoZvCTvD0v/ElFhw==
X-Google-Smtp-Source: AGHT+IFqjHRULQpfLuOIfWcrg86BprEdjHxZ7A04s1os533fRHV67h+yavqSGXCERg/CRb9UyIa8KQ==
X-Received: by 2002:a17:902:d4c1:b0:1d8:ab27:d76c with SMTP id o1-20020a170902d4c100b001d8ab27d76cmr1643127plg.51.1709633429324;
        Tue, 05 Mar 2024 02:10:29 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n15-20020a170903110f00b001dcc3a46a6bsm10081558plh.262.2024.03.05.02.10.27
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
Subject: [PATCH v2 3/9] util: Introduce __kvmalloc_node() that can take kmem_buckets argument
Date: Tue,  5 Mar 2024 02:10:19 -0800
Message-Id: <20240305101026.694758-3-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305100933.it.923-kees@kernel.org>
References: <20240305100933.it.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2996; i=keescook@chromium.org;
 h=from:subject; bh=JqAs2ONNE7kMO16unP+0GI5vQbPsq9Mj6KA7f6Xw/go=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5u+QU4fAZ6X0I2VVjtMMEATXAWJJ5dqn0j2T+
 P8LqusMSw+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZebvkAAKCRCJcvTf3G3A
 JmecD/92uSdARNPOF/Ig41R9iblLk9UxCbO1fB2HKnaa/w+yLHjuEWP2fptZr1u4cl7oBi+V+7e
 XCMsvWK4pkOYAP7NuRX8GU6AxmvUqlZpmQXa283pIL7cWbyoBryIVD0uVp7YjUDWMT3mZYo8kTI
 WOxJrg2BS22j8FjJ0SmfK28wsBeG/6y4f11iNleBFW5KpXlGaRw2NoFGPv/oYzmVJdpOvno7tv1
 SrJhdM++M5F4fg8dy8UZdPFSBIjoz4VC49dlXRzdsM9GoSdV+aakrKnzGaX8WPqr1QTfDcy5qEv
 RCskJbWRYLonWFp9KcpeVrWeXB43I5oPU6H/DHx0PGqLxhEKdHMseOCtWkAKNPVhtqOufAQLdct
 2XPAIyB+CIavIHRn8oZvNB8dhF46U1bKOM9jFISSARfnGEZp8WC4c4OStJpN9nCnwYHPz32sXy5
 IFPtLolXYwV9mqfABdpmFQb/QG6+XuvjFWZ+HpxdxuAD/41pG2HrHPS3XlG77pqtqM+/vtWm5LH
 hf8/tXhzxjo8B8vey28JSnydpkHd63SeElyfCf/JQ/Vbe5wzsRt/oHddPw1OThs95gN/vEjmHXH
 rP+vV3/i9F7vKu273jzC4MIKRmYWSs3/Lc000Nj3NCnpIp6uaAeGZFpJIzs1h/qLp3rQGBKT8yw TPX8rWd+pV6qhAA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Provide an API to perform kvmalloc-style allocations with a particular
set of buckets.

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
 include/linux/slab.h | 9 ++++++++-
 mm/util.c            | 9 +++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 1cc1a7637b56..f26ac9a6ef9f 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -723,7 +723,14 @@ static inline __alloc_size(1) void *kzalloc_node(size_t size, gfp_t flags, int n
 	return kmalloc_node(size, flags | __GFP_ZERO, node);
 }
 
-extern void *kvmalloc_node(size_t size, gfp_t flags, int node) __alloc_size(1);
+void * __alloc_size(2)
+__kvmalloc_node(kmem_buckets *b, size_t size, gfp_t flags, int node);
+
+static inline __alloc_size(1) void *kvmalloc_node(size_t size, gfp_t flags, int node)
+{
+	return __kvmalloc_node(NULL, size, flags, node);
+}
+
 static inline __alloc_size(1) void *kvmalloc(size_t size, gfp_t flags)
 {
 	return kvmalloc_node(size, flags, NUMA_NO_NODE);
diff --git a/mm/util.c b/mm/util.c
index 5a6a9802583b..02c895b87a28 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -577,8 +577,9 @@ unsigned long vm_mmap(struct file *file, unsigned long addr,
 EXPORT_SYMBOL(vm_mmap);
 
 /**
- * kvmalloc_node - attempt to allocate physically contiguous memory, but upon
+ * __kvmalloc_node - attempt to allocate physically contiguous memory, but upon
  * failure, fall back to non-contiguous (vmalloc) allocation.
+ * @b: which set of kmalloc buckets to allocate from.
  * @size: size of the request.
  * @flags: gfp mask for the allocation - must be compatible (superset) with GFP_KERNEL.
  * @node: numa node to allocate from
@@ -592,7 +593,7 @@ EXPORT_SYMBOL(vm_mmap);
  *
  * Return: pointer to the allocated memory of %NULL in case of failure
  */
-void *kvmalloc_node(size_t size, gfp_t flags, int node)
+void *__kvmalloc_node(kmem_buckets *b, size_t size, gfp_t flags, int node)
 {
 	gfp_t kmalloc_flags = flags;
 	void *ret;
@@ -614,7 +615,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 		kmalloc_flags &= ~__GFP_NOFAIL;
 	}
 
-	ret = kmalloc_node(size, kmalloc_flags, node);
+	ret = __kmalloc_node(b, size, kmalloc_flags, node);
 
 	/*
 	 * It doesn't really make sense to fallback to vmalloc for sub page
@@ -643,7 +644,7 @@ void *kvmalloc_node(size_t size, gfp_t flags, int node)
 			flags, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
 			node, __builtin_return_address(0));
 }
-EXPORT_SYMBOL(kvmalloc_node);
+EXPORT_SYMBOL(__kvmalloc_node);
 
 /**
  * kvfree() - Free memory.
-- 
2.34.1


