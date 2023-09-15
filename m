Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3426B7A1CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjIOK7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233910AbjIOK7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:59:51 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F4C193
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:59:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5925fb6087bso25063237b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775583; x=1695380383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZucAKzByYrFaSau/ORvEIe6Pa38oq3gYlqLtnctNAqY=;
        b=0UUipZjE05nfLxs//N+5K5UD1LOg8zvkCIA/PPAeacB3UA7ZgNPiM9SlycPer+gLF6
         BVy9xvJYA7dkKfNTjNj3cw9Eaw0qi2E4DgJr/hnzdNf5+t9Ls6xgwqREMZBwKqe22HpY
         j5CL2LouU3WbUF4RCC226OpcwNNd+ELOMxYkpaj3+WIgX8QsFyztklW/ZsJVn0V/dXmI
         k0QnktpwyQRYNLgnZ7rqtRY82q8CH/jlzfkde0KOmW0NZUTkusQmZsKSS/pH9RdFBUK6
         UHcp56PWP8oOuIbj/2X0zj7lbrzm1aYWQ/HMSNoovmjrkCzoIWbv8HDQq9at2315+BBv
         Ne/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775583; x=1695380383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZucAKzByYrFaSau/ORvEIe6Pa38oq3gYlqLtnctNAqY=;
        b=hPq0AHz8bTTqzgIMyncIwI/tOPe+IH1tIAq2OthT9z//lkNWFvq29Q6fdQ+tNHmH/Y
         qUHPiuDmtT62B7EqrOLAxyecmQDu7/t8RvHWws3VIQXd0WCaf9DnA8o63ePtBBqrU8jt
         xHRl70f2IjO1u5S9aq9lWPZ4Q/pZfjmdDgO3aM0pCRxcbyvFqS6sAnIOmCQ8f/lX4dE/
         CXJqucJz+p31+UlQK/Rp6NTQwJIa+iDHUnVwL+9ydbHLxgGXw0lMgh2Tg41VPunzxgfl
         wRiciS8RRvyTZ/+fmpxgBDteY+M5xZ79CT9s8lQgYWuGAXRVxJzi0y56Vxao79J4dGy/
         M7yQ==
X-Gm-Message-State: AOJu0YzM2fCiHJYyldjdccTVyGj2eAhi5t8wRDwXwGOU9icrEjZlTgOT
        oJAiKXsHh3+rh8ItpocDFbcrqCJZIdAIgX86Hw==
X-Google-Smtp-Source: AGHT+IEAnaaQu/BWsVFGNIRiv6lcplWzZAAkMq3yz1aqKWinKyMc9fRYJHvcl3uXxi5mNmOlrck3nzUMRNpgDaT5wA==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a81:b612:0:b0:565:9bee:22e0 with SMTP
 id u18-20020a81b612000000b005659bee22e0mr34824ywh.0.1694775582994; Fri, 15
 Sep 2023 03:59:42 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:21 +0000
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
Mime-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-3-matteorizzo@google.com>
Subject: [RFC PATCH 02/14] mm/slub: add is_slab_addr/is_slab_page helpers
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

This is refactoring in preparation for adding two different
implementations (for SLAB_VIRTUAL enabled and disabled).

virt_to_folio(x) expands to _compound_head(virt_to_page(x)) and
virt_to_head_page(x) also expands to _compound_head(virt_to_page(x))

so PageSlab(virt_to_head_page(res)) should be equivalent to
is_slab_addr(res).

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 include/linux/slab.h | 1 +
 kernel/resource.c    | 2 +-
 mm/slab.h            | 9 +++++++++
 mm/slab_common.c     | 5 ++---
 mm/slub.c            | 6 +++---
 5 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 8228d1276a2f..a2d82010d269 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -793,4 +793,5 @@ int slab_dead_cpu(unsigned int cpu);
 #define slab_dead_cpu		NULL
 #endif
 
+#define is_slab_addr(addr) folio_test_slab(virt_to_folio(addr))
 #endif	/* _LINUX_SLAB_H */
diff --git a/kernel/resource.c b/kernel/resource.c
index b1763b2fd7ef..c829e5f97292 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -158,7 +158,7 @@ static void free_resource(struct resource *res)
 	 * buddy and trying to be smart and reusing them eventually in
 	 * alloc_resource() overcomplicates resource handling.
 	 */
-	if (res && PageSlab(virt_to_head_page(res)))
+	if (res && is_slab_addr(res))
 		kfree(res);
 }
 
diff --git a/mm/slab.h b/mm/slab.h
index 799a315695c6..25e41dd6087e 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -169,6 +169,15 @@ static_assert(IS_ALIGNED(offsetof(struct slab, freelist), sizeof(freelist_aba_t)
  */
 #define slab_page(s) folio_page(slab_folio(s), 0)
 
+/**
+ * is_slab_page - Checks if a page is really a slab page
+ * @s: The slab
+ *
+ * Checks if s points to a slab page.
+ *
+ * Return: true if s points to a slab and false otherwise.
+ */
+#define is_slab_page(s) folio_test_slab(slab_folio(s))
 /*
  * If network-based swap is enabled, sl*b must keep track of whether pages
  * were allocated from pfmemalloc reserves.
diff --git a/mm/slab_common.c b/mm/slab_common.c
index e99e821065c3..79102d24f099 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1063,7 +1063,7 @@ void kfree(const void *object)
 		return;
 
 	folio = virt_to_folio(object);
-	if (unlikely(!folio_test_slab(folio))) {
+	if (unlikely(!is_slab_addr(object))) {
 		free_large_kmalloc(folio, (void *)object);
 		return;
 	}
@@ -1094,8 +1094,7 @@ size_t __ksize(const void *object)
 		return 0;
 
 	folio = virt_to_folio(object);
-
-	if (unlikely(!folio_test_slab(folio))) {
+	if (unlikely(!is_slab_addr(object))) {
 		if (WARN_ON(folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE))
 			return 0;
 		if (WARN_ON(object != folio_address(folio)))
diff --git a/mm/slub.c b/mm/slub.c
index a7dae207c2d2..b69916ab7aa8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1259,7 +1259,7 @@ static int check_slab(struct kmem_cache *s, struct slab *slab)
 {
 	int maxobj;
 
-	if (!folio_test_slab(slab_folio(slab))) {
+	if (!is_slab_page(slab)) {
 		slab_err(s, slab, "Not a valid slab page");
 		return 0;
 	}
@@ -1454,7 +1454,7 @@ static noinline bool alloc_debug_processing(struct kmem_cache *s,
 	return true;
 
 bad:
-	if (folio_test_slab(slab_folio(slab))) {
+	if (is_slab_page(slab)) {
 		/*
 		 * If this is a slab page then lets do the best we can
 		 * to avoid issues in the future. Marking all objects
@@ -1484,7 +1484,7 @@ static inline int free_consistency_checks(struct kmem_cache *s,
 		return 0;
 
 	if (unlikely(s != slab->slab_cache)) {
-		if (!folio_test_slab(slab_folio(slab))) {
+		if (!is_slab_page(slab)) {
 			slab_err(s, slab, "Attempt to free object(0x%p) outside of slab",
 				 object);
 		} else if (!slab->slab_cache) {
-- 
2.42.0.459.ge4e396fd5e-goog

