Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272817F5454
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjKVXMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjKVXMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:12:14 -0500
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7614101
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:12:09 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700694727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uNmdlwYGwAMCb5jza2UGKjePd3PtCVqVMGoJzVDye+g=;
        b=EbjD+KjtUReYpy3VEP2zh1PWDPdocfuDXn//2UykrrShxpEvbz8Lt2fOjSTIqAaqQQSP7V
        CYH/tF+RfK9UBYjQWzumEnZ/lRQqdOcxNIy6bxBqR8zc55i8kVhf3qeEOvvYkfiviv7XtT
        J/+WXzYfqAyKcZ3HAi6QMawrfjd1sEU=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Feng Tang <feng.tang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm] slub, kasan: improve interaction of KASAN and slub_debug poisoning
Date:   Thu, 23 Nov 2023 00:12:02 +0100
Message-Id: <20231122231202.121277-1-andrey.konovalov@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

When both KASAN and slub_debug are enabled, when a free object is being
prepared in setup_object, slub_debug poisons the object data before KASAN
initializes its per-object metadata.

Right now, in setup_object, KASAN only initializes the alloc metadata,
which is always stored outside of the object. slub_debug is aware of
this and it skips poisoning and checking that memory area.

However, with the following patch in this series, KASAN also starts
initializing its free medata in setup_object. As this metadata might be
stored within the object, this initialization might overwrite the
slub_debug poisoning. This leads to slub_debug reports.

Thus, skip checking slub_debug poisoning of the object data area that
overlaps with the in-object KASAN free metadata.

Also make slub_debug poisoning of tail kmalloc redzones more precise when
KASAN is enabled: slub_debug can still poison and check the tail kmalloc
allocation area that comes after the KASAN free metadata.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Andrew, please put this patch right before "kasan: use stack_depot_put
for Generic mode".
---
 mm/slub.c | 41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 63d281dfacdb..782bd8a6bd34 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -870,20 +870,20 @@ static inline void set_orig_size(struct kmem_cache *s,
 				void *object, unsigned int orig_size)
 {
 	void *p = kasan_reset_tag(object);
+	unsigned int kasan_meta_size;
 
 	if (!slub_debug_orig_size(s))
 		return;
 
-#ifdef CONFIG_KASAN_GENERIC
 	/*
-	 * KASAN could save its free meta data in object's data area at
-	 * offset 0, if the size is larger than 'orig_size', it will
-	 * overlap the data redzone in [orig_size+1, object_size], and
-	 * the check should be skipped.
+	 * KASAN can save its free meta data inside of the object at offset 0.
+	 * If this meta data size is larger than 'orig_size', it will overlap
+	 * the data redzone in [orig_size+1, object_size]. Thus, we adjust
+	 * 'orig_size' to be as at least as big as KASAN's meta data.
 	 */
-	if (kasan_metadata_size(s, true) > orig_size)
-		orig_size = s->object_size;
-#endif
+	kasan_meta_size = kasan_metadata_size(s, true);
+	if (kasan_meta_size > orig_size)
+		orig_size = kasan_meta_size;
 
 	p += get_info_end(s);
 	p += sizeof(struct track) * 2;
@@ -1192,7 +1192,7 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 {
 	u8 *p = object;
 	u8 *endobject = object + s->object_size;
-	unsigned int orig_size;
+	unsigned int orig_size, kasan_meta_size;
 
 	if (s->flags & SLAB_RED_ZONE) {
 		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
@@ -1222,12 +1222,23 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 	}
 
 	if (s->flags & SLAB_POISON) {
-		if (val != SLUB_RED_ACTIVE && (s->flags & __OBJECT_POISON) &&
-			(!check_bytes_and_report(s, slab, p, "Poison", p,
-					POISON_FREE, s->object_size - 1) ||
-			 !check_bytes_and_report(s, slab, p, "End Poison",
-				p + s->object_size - 1, POISON_END, 1)))
-			return 0;
+		if (val != SLUB_RED_ACTIVE && (s->flags & __OBJECT_POISON)) {
+			/*
+			 * KASAN can save its free meta data inside of the
+			 * object at offset 0. Thus, skip checking the part of
+			 * the redzone that overlaps with the meta data.
+			 */
+			kasan_meta_size = kasan_metadata_size(s, true);
+			if (kasan_meta_size < s->object_size - 1 &&
+			    !check_bytes_and_report(s, slab, p, "Poison",
+					p + kasan_meta_size, POISON_FREE,
+					s->object_size - kasan_meta_size - 1))
+				return 0;
+			if (kasan_meta_size < s->object_size &&
+			    !check_bytes_and_report(s, slab, p, "End Poison",
+					p + s->object_size - 1, POISON_END, 1))
+				return 0;
+		}
 		/*
 		 * check_pad_bytes cleans up on its own.
 		 */
-- 
2.25.1

