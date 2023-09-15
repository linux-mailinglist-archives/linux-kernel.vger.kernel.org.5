Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335657A1CF6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjIOLAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbjIOLAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:00:09 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68C310FA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:59:54 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-9a647551b7dso316247266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775593; x=1695380393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/q3ouMwQ7IDAIohC0sCavv+JpOlHz5JpjrFwf8Yaow=;
        b=kf7ywg1cK7qdtNseJfNJII+vGPd7GqIfWF5yIxge0QWHLNSZcmfhkFdLuP1xmndcc7
         nSBFVW6bbXgqYdZF44TryJrX6lIXD0llXx/q4W7/HIK/KZL9UHx9DRlyvIlyYDw4ikIO
         9J86p55d8HaGcnaJT81C9lcK4VDFZoSc9Y0DKt1vNPhkgeABErHaTpvAmsOy54Qs6P3v
         TXIZFA7nvgHo6K/GkBdhDBToPm/1JwRQB8rbxbt7C/wuYEYeDJ7WAEJYXuhuTMnr1Irw
         cN37ZbwXueaajQEwjv3mx5ecKdvPGuUxp7fRsw6UgXKUQKlzyp5JhwbOB3tozbjRyo+N
         Du3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775593; x=1695380393;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/q3ouMwQ7IDAIohC0sCavv+JpOlHz5JpjrFwf8Yaow=;
        b=BGCYePHkIP7ULxTUXW04oTnqBXs/HaPG9nIjA/AqhP5osCOprySro+fNu0asAVJFCE
         n3SHCrrPG/fuFZQG/TrUW11CCjDWlfPytWhR2WjXO4SIlmYdRhL3E7F9fPtsxKDm14fg
         eLHyJ3QtRseBFDuZN0S8yXTvjYp/Frvwr69yhZP4UJ9sS4Iwm2xBeseCYtkebtoVPpdD
         dvscyP6pCelcJxxbGxWEwO6hARXPcW3Q4fggslu/zocBSUppiPrZABprv+de/kjWxMKx
         7C6Gc6j/trEe+mCFqnCYkm/jB+wYDB4Uj9wWWZAeaApCS8AorUIadqmr8qoYiPrktMWU
         zpfg==
X-Gm-Message-State: AOJu0YxBTfmFHg1s+0LCf3yr1scz+TzLIfH6RcyDbNJWFzNTVwUYc9CQ
        eQ7tFkzHcZ2G6m4djCMOUTu7Rnb/RHHluClUaA==
X-Google-Smtp-Source: AGHT+IGzGcqa6kGNtl+Zbc2lxfKKH+MRmw22LvMY2Bcl+linrh96N5epPcLI/8cSAKDbzrfQBk304rpFFgdGLDJl5w==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a17:907:c9aa:b0:9ad:c79d:2a20 with
 SMTP id uj42-20020a170907c9aa00b009adc79d2a20mr11116ejc.1.1694775593399; Fri,
 15 Sep 2023 03:59:53 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:25 +0000
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
Mime-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-7-matteorizzo@google.com>
Subject: [RFC PATCH 06/14] mm/slub: pass additional args to alloc_slab_page
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

This is refactoring in preparation for SLAB_VIRTUAL.

The implementation of SLAB_VIRTUAL needs access to struct kmem_cache in
alloc_slab_page in order to take unused slabs from the slab freelist,
which is per-cache.

In addition to that it passes two different sets of GFP flags.
meta_gfp_flags is used for the memory backing the metadata region and
page tables, and gfp_flags for the data memory.

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 mm/slub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 9b87afade125..eaa1256aff89 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1869,7 +1869,8 @@ static void folio_clear_slab(struct folio *folio, struct slab *slab)
 	__folio_clear_slab(folio);
 }
 
-static inline struct slab *alloc_slab_page(gfp_t flags, int node,
+static inline struct slab *alloc_slab_page(struct kmem_cache *s,
+		gfp_t meta_flags, gfp_t flags, int node,
 		struct kmem_cache_order_objects oo)
 {
 	struct folio *folio;
@@ -2020,7 +2021,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if ((alloc_gfp & __GFP_DIRECT_RECLAIM) && oo_order(oo) > oo_order(s->min))
 		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
 
-	slab = alloc_slab_page(alloc_gfp, node, oo);
+	slab = alloc_slab_page(s, flags, alloc_gfp, node, oo);
 	if (unlikely(!slab)) {
 		oo = s->min;
 		alloc_gfp = flags;
@@ -2028,7 +2029,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		 * Allocation may have failed due to fragmentation.
 		 * Try a lower order alloc if possible
 		 */
-		slab = alloc_slab_page(alloc_gfp, node, oo);
+		slab = alloc_slab_page(s, flags, alloc_gfp, node, oo);
 		if (unlikely(!slab))
 			return NULL;
 		stat(s, ORDER_FALLBACK);
-- 
2.42.0.459.ge4e396fd5e-goog

