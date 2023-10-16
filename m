Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9BB7C9DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjJPDXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPDXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:23:10 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC27E6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:08 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fb85afef4so3086318b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697426588; x=1698031388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXZWHgZHrQ6fRhi1dWH8Hwu+H4KBhNEo2ODkb4cUdHA=;
        b=i7jsGdw0ITgbB+sXok0kbvMVrmxqxWdLOsPKKGXRS7ZV+Ib32o4zDlQNIYOlzoCgF1
         yE2Ajf9i0s+IDxGRVfs4J/vlG95B3IvV0ZCBvsUOIGdG+YKLo3SVkcMrESaxUZE/FbeT
         4T8s04fybllvgRqqMnojQbfs/gEM0PY6ku0LwMpCrMXt2StGilC1J+qJxapzyt5/99kl
         EVmVLty5j4Bz/BH8HIwj60ApI0i6bJrsIy2ysfh7mOgMO7Lb1HmbBjcn+PyrYhTfoo+d
         DG/8RbemO3WNH+ectz5QHapeEy8QplLnpv331f0XaHl7CvQvAbgBsOoJwiabiFdNwA7q
         A0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697426588; x=1698031388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XXZWHgZHrQ6fRhi1dWH8Hwu+H4KBhNEo2ODkb4cUdHA=;
        b=VqTmEW8s4YEq8B21R240oNeIxcTKoDqNONVCpnu9BF2Iv82+NGUX2MtSbUXbWdxunD
         z3ZtcqxDghBX9Uwk+hP6DX9+FCBjK91kZSo1/i9yjWtQ+EpebW7UH20OVzYS8nzKvTpa
         eFeQ+uilDsubID70PciJyNyfGYTBSX5sWC2Oh/N3Uw1DbvADT2gPH1vb40RmnEZuzIWa
         gAHGZbwF28Nj8w927tscSOA+wgUnNnkS/YuGH5VA2LF39x5deJGYbSzoaVIZekUm1UD+
         2Uk/iNqvc8KxVH+PXFsvTYlCHwjUQ2/17ELtb9RhZ7ZZ7JFF34HtQSIzdkigMTpySyIE
         ZUUg==
X-Gm-Message-State: AOJu0YwBA5dVGNvcAsb+71B0PBqZKLCTXL4JTtqIx/i3kFEwn6w4RgpM
        d8lIkbmNS60kmLppSkfkwffwww==
X-Google-Smtp-Source: AGHT+IHJ/d4Imcp6odYT1h7aWQHUYbM1ac42oVm99u/t154/4XdiI3P2y5GHneaRUB847sqBMYQ7vA==
X-Received: by 2002:a05:6a21:7784:b0:173:318:b1ec with SMTP id bd4-20020a056a21778400b001730318b1ecmr12877225pzc.35.1697426588170;
        Sun, 15 Oct 2023 20:23:08 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090ae28800b0027758c7f585sm3452770pjz.52.2023.10.15.20.23.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Oct 2023 20:23:08 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 04/10] radix tree test suite: Align kmem_cache_alloc_bulk() with kernel behavior.
Date:   Mon, 16 Oct 2023 11:22:20 +0800
Message-Id: <20231016032226.59199-5-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
References: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kmem_cache_alloc_bulk() fails to allocate, leave the freed pointers
in the array. This enables a more accurate simulation of the kernel's
behavior and allows for testing potential double-free scenarios.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 tools/testing/radix-tree/linux.c | 45 +++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
index 61fe2601cb3a..4eb442206d01 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -93,13 +93,9 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru,
 	return p;
 }
 
-void kmem_cache_free_locked(struct kmem_cache *cachep, void *objp)
+void __kmem_cache_free_locked(struct kmem_cache *cachep, void *objp)
 {
 	assert(objp);
-	uatomic_dec(&nr_allocated);
-	uatomic_dec(&cachep->nr_allocated);
-	if (kmalloc_verbose)
-		printf("Freeing %p to slab\n", objp);
 	if (cachep->nr_objs > 10 || cachep->align) {
 		memset(objp, POISON_FREE, cachep->size);
 		free(objp);
@@ -111,6 +107,15 @@ void kmem_cache_free_locked(struct kmem_cache *cachep, void *objp)
 	}
 }
 
+void kmem_cache_free_locked(struct kmem_cache *cachep, void *objp)
+{
+	uatomic_dec(&nr_allocated);
+	uatomic_dec(&cachep->nr_allocated);
+	if (kmalloc_verbose)
+		printf("Freeing %p to slab\n", objp);
+	__kmem_cache_free_locked(cachep, objp);
+}
+
 void kmem_cache_free(struct kmem_cache *cachep, void *objp)
 {
 	pthread_mutex_lock(&cachep->lock);
@@ -141,18 +146,17 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 	if (kmalloc_verbose)
 		pr_debug("Bulk alloc %lu\n", size);
 
-	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
-		if (cachep->non_kernel < size)
-			return 0;
-
-		cachep->non_kernel -= size;
-	}
-
 	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs >= size) {
 		struct radix_tree_node *node;
 
 		for (i = 0; i < size; i++) {
+			if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+				if (!cachep->non_kernel)
+					break;
+				cachep->non_kernel--;
+			}
+
 			node = cachep->objs;
 			cachep->nr_objs--;
 			cachep->objs = node->parent;
@@ -163,11 +167,19 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 	} else {
 		pthread_mutex_unlock(&cachep->lock);
 		for (i = 0; i < size; i++) {
+			if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+				if (!cachep->non_kernel)
+					break;
+				cachep->non_kernel--;
+			}
+
 			if (cachep->align) {
 				posix_memalign(&p[i], cachep->align,
 					       cachep->size);
 			} else {
 				p[i] = malloc(cachep->size);
+				if (!p[i])
+					break;
 			}
 			if (cachep->ctor)
 				cachep->ctor(p[i]);
@@ -176,6 +188,15 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 		}
 	}
 
+	if (i < size) {
+		size = i;
+		pthread_mutex_lock(&cachep->lock);
+		for (i = 0; i < size; i++)
+			__kmem_cache_free_locked(cachep, p[i]);
+		pthread_mutex_unlock(&cachep->lock);
+		return 0;
+	}
+
 	for (i = 0; i < size; i++) {
 		uatomic_inc(&nr_allocated);
 		uatomic_inc(&cachep->nr_allocated);
-- 
2.20.1

