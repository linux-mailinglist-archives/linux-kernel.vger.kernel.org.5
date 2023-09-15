Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86077A1CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjIOLAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbjIOLAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:00:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EC61BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59bdb9fe821so26710147b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775601; x=1695380401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rgcw5kSlwTUZsnv8liQ/ZCTx1m6umum1AvnN+yk4ci0=;
        b=YNj4ReoeIxRcOkpVq1wXRHDJ4kBOiomlcsoOyIJsPeKpmSe6sUS5axgSozT2cUiDNF
         UqI+EpaBrjvu03Qa7dvD7SvLO6kwCl712RRDvHxermpsNFzBOfEx0m2UTPF3z4jl/yLX
         jAzEnQWYLo1Gr8mGDGsrEewV5ZCk+Qp1X4OdwvOo2McV2JMSEODYU6cn8qcsuVFHSs9D
         pe7+CgbeAs/3c5IuHTQe+Yisg3r0qXFFz2uPZuY9j0Zk/bEVTlEwga3EDXK+r/YFMjye
         M2PHAbgQnmBkUROVb6AQ29yPfOW61rTSNVZXaPYhPAELyisAzA3LWZgqHhCCRktRPcAY
         HeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775601; x=1695380401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rgcw5kSlwTUZsnv8liQ/ZCTx1m6umum1AvnN+yk4ci0=;
        b=tGgXusZqk5IQ8QBTh8B6jr8PVEE6dXbjeOrTfMzYfFGyNcqoSt8UaSZudU6kR1f44P
         TlA8kU30/uBvam2zfv2V8XHd1f/f64a1V1YnroFGqKvvFoUWUZEHLKs8B6MWoIprLkrm
         vx1TcapFqolhY1+cV+ctXunlqep9kN828dDYSSH4jLH/HqdVzs7ArlEJpeWgGHolojPV
         29JdN9xSjC8V99H3SxW3Q0uhLu+snTApEwdW34qEDkJcedb/27+frUrih3RfjxgJOJAV
         Y1kN5FP7i4Gt0Vu5PyJ1xUmP8qPTJ9I1dVVfYvnPjlN9PtZYfiMrsFh2XL0OhTYDciMI
         K6Hg==
X-Gm-Message-State: AOJu0YzMt8OhCKL557OFF5gaTTnddrJBFCXJnhy3TY7GzNIjiDqVO/J+
        H6xr1Mk+VyDDZoXQRKdibKgnCwgyeRvcRD5v6A==
X-Google-Smtp-Source: AGHT+IEcouH8JvuJElm8N08gEPWOgDsvJMW1WGDf8e1nxWq0e0tWAe1u3fFjyWd///wS5TI4Lwp37X8nvTPZK0q/lg==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a81:ae43:0:b0:59b:f493:813d with SMTP
 id g3-20020a81ae43000000b0059bf493813dmr28901ywk.1.1694775601139; Fri, 15 Sep
 2023 04:00:01 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:28 +0000
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
Mime-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-10-matteorizzo@google.com>
Subject: [RFC PATCH 09/14] mm/slub: add the slab freelists to kmem_cache
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

With SLAB_VIRTUAL enabled, unused slabs which still have virtual memory
allocated to them but no physical memory are kept in a per-cache list so
that they can be reused later if the cache needs to grow again.

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 include/linux/slub_def.h | 16 ++++++++++++++++
 mm/slub.c                | 23 +++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 0adf5ba8241b..693e9bb34edc 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -86,6 +86,20 @@ struct kmem_cache_cpu {
 /*
  * Slab cache management.
  */
+struct kmem_cache_virtual {
+#ifdef CONFIG_SLAB_VIRTUAL
+	/* Protects freed_slabs and freed_slabs_min */
+	spinlock_t freed_slabs_lock;
+	/*
+	 * Slabs on this list have virtual memory of size oo allocated to them
+	 * but no physical memory
+	 */
+	struct list_head freed_slabs;
+	/* Same as freed_slabs but with memory of size min */
+	struct list_head freed_slabs_min;
+#endif
+};
+
 struct kmem_cache {
 #ifndef CONFIG_SLUB_TINY
 	struct kmem_cache_cpu __percpu *cpu_slab;
@@ -107,6 +121,8 @@ struct kmem_cache {
 
 	/* Allocation and freeing of slabs */
 	struct kmem_cache_order_objects min;
+	struct kmem_cache_virtual virtual;
+
 	gfp_t allocflags;	/* gfp flags to use on each alloc */
 	int refcount;		/* Refcount for slab cache destroy */
 	void (*ctor)(void *);
diff --git a/mm/slub.c b/mm/slub.c
index 42e7cc0b4452..4f77e5d4fe6c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4510,8 +4510,20 @@ static int calculate_sizes(struct kmem_cache *s)
 	return !!oo_objects(s->oo);
 }
 
+static inline void slab_virtual_open(struct kmem_cache *s)
+{
+#ifdef CONFIG_SLAB_VIRTUAL
+	/* WARNING: this stuff will be relocated in bootstrap()! */
+	spin_lock_init(&s->virtual.freed_slabs_lock);
+	INIT_LIST_HEAD(&s->virtual.freed_slabs);
+	INIT_LIST_HEAD(&s->virtual.freed_slabs_min);
+#endif
+}
+
 static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 {
+	slab_virtual_open(s);
+
 	s->flags = kmem_cache_flags(s->size, flags, s->name);
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	s->random = get_random_long();
@@ -4994,6 +5006,16 @@ static int slab_memory_callback(struct notifier_block *self,
  * that may be pointing to the wrong kmem_cache structure.
  */
 
+static inline void slab_virtual_bootstrap(struct kmem_cache *s, struct kmem_cache *static_cache)
+{
+	slab_virtual_open(s);
+
+#ifdef CONFIG_SLAB_VIRTUAL
+	list_splice(&static_cache->virtual.freed_slabs, &s->virtual.freed_slabs);
+	list_splice(&static_cache->virtual.freed_slabs_min, &s->virtual.freed_slabs_min);
+#endif
+}
+
 static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
 {
 	int node;
@@ -5001,6 +5023,7 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
 	struct kmem_cache_node *n;
 
 	memcpy(s, static_cache, kmem_cache->object_size);
+	slab_virtual_bootstrap(s, static_cache);
 
 	/*
 	 * This runs very early, and only the boot processor is supposed to be
-- 
2.42.0.459.ge4e396fd5e-goog

