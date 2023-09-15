Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444C57A1D03
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjIOLBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjIOLA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:00:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EC62D42
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-cf4cb742715so2346580276.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 04:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694775612; x=1695380412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C4pEChVXRU6sm004Zu1IJnbwIsY1yXPwkOtMip47RAc=;
        b=caER2+GTwQV0Eb9KjW9LgnO5MO+4bH08gvZvDYLwhRzAj6vxyz9Kx4oIWpM2gnGD2r
         iv1hfpc35TbryyXHFB3fNa4MQ9qx/OVRnmd5ENOT+vwdBYQ173BABw0om86QdNTmPAcV
         WlPYBxZpLu/EJTw1MVq2Nj5buHDgztP2ChREUy1a6eoQQT48nPtCneIDyxYu3CEv3VnV
         GdG/BYmTZyu9toFczoU4gQUY2H7pyZNWjZa2/QeCLrhz/mqxd+hwaHhkvpCi0vZ5HkQB
         JgQ7s0FDXRt2U08+93YHyKMUOAQEa8dT04K2Z7mHKYrRa0YtjndYwTXJz5JcCYbiRA/f
         0asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694775612; x=1695380412;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4pEChVXRU6sm004Zu1IJnbwIsY1yXPwkOtMip47RAc=;
        b=Dyn1GEv0hgExyNCQ09Q/FVPdmdKPYPK+ekp2qkNwvUrFEoWHLbAHGjCkDzocJXfdGk
         kL7mtg7B2k0DCXx1RfqutMopCbmn3FLKnf+9fTfhg8zKAzJq/V4y/gwaDC5Hq7B0V/yU
         TtJtQ+QAFRs/NMrGM2rb/fzmG/rcl77FSk5ry3AvWmPaLhEp9chBdcBvtYGCUcFTQEuU
         0zOMjbLBbDdSOI1IX7pgyH62jZh7T7pa7xOfen3J0CgnHkejQQVaL/N4ceN8by1EEm3H
         rP8cdtGPtiaiSndqhLADmdBN3fhJv/NuXKYM46aw0fNuOXSIyLbb4brKDRAt0LN2csM0
         +kVA==
X-Gm-Message-State: AOJu0Yyn+UZZZBKJ0+iLAdb/5Nb+DyYlnVOHXYPg9BOtFG3ZHCnuoBA9
        eIiYpjHxVzRToAo8IRQ+/gUDuHNCNeuxoWnI4w==
X-Google-Smtp-Source: AGHT+IHt9z6QcITgpugvtEYL0lGwEogSA+C1s55ADVWGOnuIpG1JocMIlh+GBo6p7lHOr6nsErM2osN2OLhU91MuRQ==
X-Received: from mr-cloudtop2.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:2a6])
 (user=matteorizzo job=sendgmr) by 2002:a05:6902:118a:b0:d80:183c:92b9 with
 SMTP id m10-20020a056902118a00b00d80183c92b9mr29633ybu.4.1694775611854; Fri,
 15 Sep 2023 04:00:11 -0700 (PDT)
Date:   Fri, 15 Sep 2023 10:59:32 +0000
In-Reply-To: <20230915105933.495735-1-matteorizzo@google.com>
Mime-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915105933.495735-14-matteorizzo@google.com>
Subject: [RFC PATCH 13/14] mm/slub: sanity-check freepointers
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

Sanity-check that:
 - non-NULL freepointers point into the slab
 - freepointers look plausibly aligned

Signed-off-by: Jann Horn <jannh@google.com>
Co-developed-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
---
 lib/slub_kunit.c |  4 ++++
 mm/slab.h        |  8 +++++++
 mm/slub.c        | 57 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index d4a3730b08fa..acf8600bd1fd 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -45,6 +45,10 @@ static void test_clobber_zone(struct kunit *test)
 #ifndef CONFIG_KASAN
 static void test_next_pointer(struct kunit *test)
 {
+	if (IS_ENABLED(CONFIG_SLAB_VIRTUAL))
+		kunit_skip(test,
+			"incompatible with freepointer corruption detection in CONFIG_SLAB_VIRTUAL");
+
 	struct kmem_cache *s = test_kmem_cache_create("TestSlub_next_ptr_free",
 							64, SLAB_POISON);
 	u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
diff --git a/mm/slab.h b/mm/slab.h
index 460c802924bd..8d10a011bdf0 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -79,6 +79,14 @@ struct slab {
 
 	struct list_head flush_list_elem;
 
+	/*
+	 * Not in kmem_cache because it depends on whether the allocation is
+	 * normal order or fallback order.
+	 * an alternative might be to over-allocate virtual memory for
+	 * fallback-order pages.
+	 */
+	unsigned long align_mask;
+
 	/* Replaces the page lock */
 	spinlock_t slab_lock;
 
diff --git a/mm/slub.c b/mm/slub.c
index 0f7f5bf0b174..57474c8a6569 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -392,6 +392,44 @@ static inline freeptr_t freelist_ptr_encode(const struct kmem_cache *s,
 	return (freeptr_t){.v = encoded};
 }
 
+/*
+ * Does some validation of freelist pointers. Without SLAB_VIRTUAL this is
+ * currently a no-op.
+ */
+static inline bool freelist_pointer_corrupted(struct slab *slab, freeptr_t ptr,
+	void *decoded)
+{
+#ifdef CONFIG_SLAB_VIRTUAL
+	/*
+	 * If the freepointer decodes to 0, use 0 as the slab_base so that
+	 * the check below always passes (0 & slab->align_mask == 0).
+	 */
+	unsigned long slab_base = decoded ? (unsigned long)slab_to_virt(slab)
+		: 0;
+
+	/*
+	 * This verifies that the SLUB freepointer does not point outside the
+	 * slab. Since at that point we can basically do it for free, it also
+	 * checks that the pointer alignment looks vaguely sane.
+	 * However, we probably don't want the cost of a proper division here,
+	 * so instead we just do a cheap check whether the bottom bits that are
+	 * clear in the size are also clear in the pointer.
+	 * So for kmalloc-32, it does a perfect alignment check, but for
+	 * kmalloc-192, it just checks that the pointer is a multiple of 32.
+	 * This should probably be reconsidered - is this a good tradeoff, or
+	 * should that part be thrown out, or do we want a proper accurate
+	 * alignment check (and can we make it work with acceptable performance
+	 * cost compared to the security improvement - probably not)?
+	 */
+	return CHECK_DATA_CORRUPTION(
+		((unsigned long)decoded & slab->align_mask) != slab_base,
+		"bad freeptr (encoded %lx, ptr %p, base %lx, mask %lx",
+		ptr.v, decoded, slab_base, slab->align_mask);
+#else
+	return false;
+#endif
+}
+
 static inline void *freelist_ptr_decode(const struct kmem_cache *s,
 					freeptr_t ptr, unsigned long ptr_addr,
 					struct slab *slab)
@@ -403,6 +441,10 @@ static inline void *freelist_ptr_decode(const struct kmem_cache *s,
 #else
 	decoded = (void *)ptr.v;
 #endif
+
+	if (unlikely(freelist_pointer_corrupted(slab, ptr, decoded)))
+		return NULL;
+
 	return decoded;
 }
 
@@ -2122,6 +2164,21 @@ static struct slab *get_free_slab(struct kmem_cache *s,
 	if (slab == NULL)
 		return NULL;
 
+	/*
+	 * Bits that must be equal to start-of-slab address for all
+	 * objects inside the slab.
+	 * For compatibility with pointer tagging (like in HWASAN), this would
+	 * need to clear the pointer tag bits from the mask.
+	 */
+	slab->align_mask = ~((PAGE_SIZE << oo_order(oo)) - 1);
+
+	/*
+	 * Object alignment bits (must be zero, which is equal to the bits in
+	 * the start-of-slab address)
+	 */
+	if (s->red_left_pad == 0)
+		slab->align_mask |= (1 << (ffs(s->size) - 1)) - 1;
+
 	return slab;
 }
 
-- 
2.42.0.459.ge4e396fd5e-goog

