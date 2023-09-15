Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E937A1CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234192AbjIOLAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjIOK7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:59:55 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD9418D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:59:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bdae1ef38so44827907b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775588; x=1695380388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xbAGox+1BQp1J2SCvFRdM4+gVemYBYzERzmxGZTZFIk=;
        b=S9XslvuI5gBbHvYu8f7Ky91OO+Y1hZncxlL21uUgx5MO/6rdEDpG76N2oSViFvwES8
         pfJbPgJgmsNYUMj+iKxbvzeqx29PMB1MVrDAmj6Tgtz2NgLTjhhO1PtVSIPHwqz3meOm
         QBRMSCuftb9Jei3z8+MmglO2IAPtTm1gdJEyp2c8FRobWY8VwYMQc9IbKSLvNzxFzKFk
         R0WJByLuE59mANduQXQA7w4DguI7zC2ac+6ZZ7xmgMkeAFlABS2LXCaseJC9jU38vZ3H
         8fI/jfB0pgdQaVGTdAveXUqn2MZ9Zqj/Gqh9pvIHrh0Exc8SVaRwFXT6zMTVtIAFK/c3
         /QIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775588; x=1695380388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbAGox+1BQp1J2SCvFRdM4+gVemYBYzERzmxGZTZFIk=;
        b=j5rDuq5QDhY5F76Owwyh8aLIEk34NEmulmxS+N8ILJridEEGEaHnXadSF+fDbDfwjI
         mASSK7G066Q/8NThkrnx8SSoVIqM9SQMrv5Jv1WjfB91ihBk+Nz57OdXFaRKz4sMVIU+
         4v5de/PagnjB7lhRl3UBWXQ7dQHRx3R8jWzpoFcN8kd8CXL5AzfC87T0ff4QWHruiFfx
         EMqRY8tDvC7E51bkb/iuIEzGKQBF86um4SP7cIxBmxNQ/Ym2ViwIgQcRqrTA9tHFkD2T
         77qd+2QZ+oDz8ejVBdE16I5y5zAa7FRzCmGXQb1i8PGvJyLHuNz89Zyt+p7biEYbrvbN
         tdNQ==
X-Gm-Message-State: AOJu0Yw8JlBChpdcH/Hs9HEyXMcIMejeF4hLjYgumUENi+RRTL2X8RY4
        5LsGMMJXQ6P7dNi3ErlftzgIYk6Mz1yA2yyGFA==
X-Google-Smtp-Source: AGHT+IFkQIG3OgVqqlEN6/c9lGi9RDx6q7XJsfPR2EVN/OdFKbEkhspIMm/2iOfMAd3xJyQxw6Wg1f3WaLFs8ikxSg==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a05:6902:11cd:b0:d81:5c03:df99 with
 SMTP id n13-20020a05690211cd00b00d815c03df99mr40387ybu.3.1694775588301; Fri,
 15 Sep 2023 03:59:48 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:23 +0000
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
Mime-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-5-matteorizzo@google.com>
Subject: [RFC PATCH 04/14] mm: use virt_to_slab instead of folio_slab
From:   Matteo Rizzo <matteorizzo@google.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org
Cc:     jannh@google.com, matteorizzo@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

This is refactoring in preparation for the introduction of SLAB_VIRTUAL
which does not implement folio_slab.

With SLAB_VIRTUAL there is no longer a 1:1 correspondence between slabs
and pages of physical memory used by the slab allocator. There is no way
to look up the slab which corresponds to a specific page of physical
memory without iterating over all slabs or over the page tables. Instead
of doing that, we can look up the slab starting from its virtual address
which can still be performed cheaply with both SLAB_VIRTUAL enabled and
disabled.

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 mm/memcontrol.c  |  2 +-
 mm/slab_common.c | 12 +++++++-----
 mm/slub.c        | 14 ++++++--------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e8ca4bdcb03c..0ab9f5323db7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2936,7 +2936,7 @@ struct mem_cgroup *mem_cgroup_from_obj_folio(struct folio *folio, void *p)
 		struct slab *slab;
 		unsigned int off;
 
-		slab = folio_slab(folio);
+		slab = virt_to_slab(p);
 		objcgs = slab_objcgs(slab);
 		if (!objcgs)
 			return NULL;
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 79102d24f099..42ceaf7e9f47 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1062,13 +1062,13 @@ void kfree(const void *object)
 	if (unlikely(ZERO_OR_NULL_PTR(object)))
 		return;
 
-	folio = virt_to_folio(object);
 	if (unlikely(!is_slab_addr(object))) {
+		folio = virt_to_folio(object);
 		free_large_kmalloc(folio, (void *)object);
 		return;
 	}
 
-	slab = folio_slab(folio);
+	slab = virt_to_slab(object);
 	s = slab->slab_cache;
 	__kmem_cache_free(s, (void *)object, _RET_IP_);
 }
@@ -1089,12 +1089,13 @@ EXPORT_SYMBOL(kfree);
 size_t __ksize(const void *object)
 {
 	struct folio *folio;
+	struct kmem_cache *s;
 
 	if (unlikely(object == ZERO_SIZE_PTR))
 		return 0;
 
-	folio = virt_to_folio(object);
 	if (unlikely(!is_slab_addr(object))) {
+		folio = virt_to_folio(object);
 		if (WARN_ON(folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE))
 			return 0;
 		if (WARN_ON(object != folio_address(folio)))
@@ -1102,11 +1103,12 @@ size_t __ksize(const void *object)
 		return folio_size(folio);
 	}
 
+	s = virt_to_slab(object)->slab_cache;
 #ifdef CONFIG_SLUB_DEBUG
-	skip_orig_size_check(folio_slab(folio)->slab_cache, object);
+	skip_orig_size_check(s, object);
 #endif
 
-	return slab_ksize(folio_slab(folio)->slab_cache);
+	return slab_ksize(s);
 }
 
 void *kmalloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
diff --git a/mm/slub.c b/mm/slub.c
index df2529c03bd3..ad33d9e1601d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3848,25 +3848,23 @@ int build_detached_freelist(struct kmem_cache *s, size_t size,
 {
 	int lookahead = 3;
 	void *object;
-	struct folio *folio;
+	struct slab *slab;
 	size_t same;
 
 	object = p[--size];
-	folio = virt_to_folio(object);
+	slab = virt_to_slab(object);
 	if (!s) {
 		/* Handle kalloc'ed objects */
-		if (unlikely(!folio_test_slab(folio))) {
-			free_large_kmalloc(folio, object);
+		if (unlikely(slab == NULL)) {
+			free_large_kmalloc(virt_to_folio(object), object);
 			df->slab = NULL;
 			return size;
 		}
-		/* Derive kmem_cache from object */
-		df->slab = folio_slab(folio);
-		df->s = df->slab->slab_cache;
+		df->s = slab->slab_cache;
 	} else {
-		df->slab = folio_slab(folio);
 		df->s = cache_from_obj(s, object); /* Support for memcg */
 	}
+	df->slab = slab;
 
 	/* Start new detached freelist */
 	df->tail = object;
-- 
2.42.0.459.ge4e396fd5e-goog

