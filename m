Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9960A7979BF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243183AbjIGRUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243192AbjIGRUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:20:11 -0400
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98DE2111
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:19:42 -0700 (PDT)
Received: by mail-lj1-x24a.google.com with SMTP id 38308e7fff4ca-2bceb2b3024so13428871fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 10:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694107098; x=1694711898; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pguS5nzVV0mhBjB/CrXM2tdNaYwlS7Rq+h24iaGnEBI=;
        b=X4O3JEBwi2cYJSDeEWaEh4q5DR0cglGJlr0MlH/3vaXQUY5J+jQoPd8arNTOotE7Ca
         tclzfCN8K/Q5a0/V0gbze30Xxj0PuLYTouhrDak+0N8BSb3aEX0XLil4zZlTZF5jfLhP
         c3u7ASYGkND4mq+fPR/z6O267nwuHZ2s0Z3wFYN13cP9JtZDCy9/KhmCo/9oFd4rsFSW
         EvjYDrMywXII4J4TZHUdcMBKmok2s8huvNq8UsyyKO9azycXe+Mj8h6E756xBmRMpWgs
         bG+cMp51S1bBfLEOa2bwZ0fj5EOpTaSm7F4VHXNEMSGCTpUiWdl4puYMpTAFi45tJ3G7
         NRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694107098; x=1694711898;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pguS5nzVV0mhBjB/CrXM2tdNaYwlS7Rq+h24iaGnEBI=;
        b=g0e3r77NHfdqYGkIjpK01qNdoAK3mctCuMq4i1LncctxOJ5mJYnIOvrQlZIuhl4Sr+
         r7AHJnBW8LMfz12ardW8hzJB00/xlsb0+1Z+uLDgOVQesDGxDWFz7DzGqRNd/26rTb9W
         lG72wiazN6lgx6onLNcYymBTwXTYWEUat8Gh9b5q+FfajCgqqNIuVOCxmA0498jJ99Ev
         b4In3EghDhsnTjKGQPiQaQHmbJnG0zqAsm6D/50TbY0b8ufWN9ElJLUYAzkL8ZB6iX9u
         laJCDloY3n5++CcyKh8jnF8RdiaYd7xuD3IDoI2/5t6I8795DX+Y+ATQCzuVfyb/cB+5
         KZmA==
X-Gm-Message-State: AOJu0YzAxBTSwhqKwCK/m+XfptlGHTBBMdB1JIwOhzkgRDQL/+xYylsz
        bAwxF+Q8ebedkVlWUU1AWW+ya3f83Iw=
X-Google-Smtp-Source: AGHT+IGBqXTREGTdC9uanYMcN82i8XIFX52t7L2XmvkIcAbdZnLizPEjhlk0WM1DzQMASN5p1z0+EuxsWCw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:33dd:e36e:b6dc:1a69])
 (user=glider job=sendgmr) by 2002:a05:600c:2d84:b0:402:eacb:a797 with SMTP id
 i4-20020a05600c2d8400b00402eacba797mr47988wmg.4.1694092006816; Thu, 07 Sep
 2023 06:06:46 -0700 (PDT)
Date:   Thu,  7 Sep 2023 15:06:41 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230907130642.245222-1-glider@google.com>
Subject: [PATCH 1/2] kmsan: simplify kmsan_internal_memmove_metadata()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, dvyukov@google.com, elver@google.com,
        akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmsan_internal_memmove_metadata() is the function that implements
copying metadata every time memcpy()/memmove() is called.
Because shadow memory stores 1 byte per each byte of kernel memory,
copying the shadow is trivial and can be done by a single memmove()
call.
Origins, on the other hand, are stored as 4-byte values corresponding
to every aligned 4 bytes of kernel memory. Therefore, if either the
source or the destination of kmsan_internal_memmove_metadata() is
unaligned, the number of origin slots corresponding to the source or
destination may differ:

  1) memcpy(0xffff888080a00000, 0xffff888080900000, 4)
     copies 1 origin slot into 1 origin slot:

     src (0xffff888080900000): xxxx
     src origins:              o111
     dst (0xffff888080a00000): xxxx
     dst origins:              o111

  2) memcpy(0xffff888080a00001, 0xffff888080900000, 4)
     copies 1 origin slot into 2 origin slots:

     src (0xffff888080900000): xxxx
     src origins:              o111
     dst (0xffff888080a00000): .xxx x...
     dst origins:              o111 o111

  3) memcpy(0xffff888080a00000, 0xffff888080900001, 4)
     copies 2 origin slots into 1 origin slot:

     src (0xffff888080900000): .xxx x...
     src origins:              o111 o222
     dst (0xffff888080a00000): xxxx
     dst origins:              o111
                           (or o222)

Previously, kmsan_internal_memmove_metadata() tried to solve this
problem by copying min(src_slots, dst_slots) as is and cloning the
missing slot on one of the ends, if needed.
This was error-prone even in the simple cases where 4 bytes were copied,
and did not account for situations where the total number of nonzero
origin slots could have increased by more than one after copying:

  memcpy(0xffff888080a00000, 0xffff888080900002, 8)

  src (0xffff888080900002): ..xx .... xx..
  src origins:              o111 0000 o222
  dst (0xffff888080a00000): xx.. ..xx
                            o111 0000
                        (or 0000 o222)

The new implementation simply copies the shadow byte by byte, and
updates the corresponding origin slot, if the shadow byte is nonzero.
This approach can handle complex cases with mixed initialized and
uninitialized bytes. Similarly to KMSAN inline instrumentation, latter
writes to bytes sharing the same origin slots take precedence.

Signed-off-by: Alexander Potapenko <glider@google.com>
---
 mm/kmsan/core.c | 127 ++++++++++++------------------------------------
 1 file changed, 31 insertions(+), 96 deletions(-)

diff --git a/mm/kmsan/core.c b/mm/kmsan/core.c
index 3adb4c1d3b193..c19f47af04241 100644
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -83,131 +83,66 @@ depot_stack_handle_t kmsan_save_stack_with_flags(gfp_t flags,
 /* Copy the metadata following the memmove() behavior. */
 void kmsan_internal_memmove_metadata(void *dst, void *src, size_t n)
 {
+	depot_stack_handle_t prev_old_origin = 0, prev_new_origin = 0;
+	int i, iter, step, src_off, dst_off, oiter_src, oiter_dst;
 	depot_stack_handle_t old_origin = 0, new_origin = 0;
-	int src_slots, dst_slots, i, iter, step, skip_bits;
 	depot_stack_handle_t *origin_src, *origin_dst;
-	void *shadow_src, *shadow_dst;
-	u32 *align_shadow_src, shadow;
+	u8 *shadow_src, *shadow_dst;
+	u32 *align_shadow_dst;
 	bool backwards;
 
 	shadow_dst = kmsan_get_metadata(dst, KMSAN_META_SHADOW);
 	if (!shadow_dst)
 		return;
 	KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(dst, n));
+	align_shadow_dst =
+		(u32 *)ALIGN_DOWN((u64)shadow_dst, KMSAN_ORIGIN_SIZE);
 
 	shadow_src = kmsan_get_metadata(src, KMSAN_META_SHADOW);
 	if (!shadow_src) {
-		/*
-		 * @src is untracked: zero out destination shadow, ignore the
-		 * origins, we're done.
-		 */
-		__memset(shadow_dst, 0, n);
+		/* @src is untracked: mark @dst as initialized. */
+		kmsan_internal_unpoison_memory(dst, n, /*checked*/ false);
 		return;
 	}
 	KMSAN_WARN_ON(!kmsan_metadata_is_contiguous(src, n));
 
-	__memmove(shadow_dst, shadow_src, n);
-
 	origin_dst = kmsan_get_metadata(dst, KMSAN_META_ORIGIN);
 	origin_src = kmsan_get_metadata(src, KMSAN_META_ORIGIN);
 	KMSAN_WARN_ON(!origin_dst || !origin_src);
-	src_slots = (ALIGN((u64)src + n, KMSAN_ORIGIN_SIZE) -
-		     ALIGN_DOWN((u64)src, KMSAN_ORIGIN_SIZE)) /
-		    KMSAN_ORIGIN_SIZE;
-	dst_slots = (ALIGN((u64)dst + n, KMSAN_ORIGIN_SIZE) -
-		     ALIGN_DOWN((u64)dst, KMSAN_ORIGIN_SIZE)) /
-		    KMSAN_ORIGIN_SIZE;
-	KMSAN_WARN_ON((src_slots < 1) || (dst_slots < 1));
-	KMSAN_WARN_ON((src_slots - dst_slots > 1) ||
-		      (dst_slots - src_slots < -1));
 
 	backwards = dst > src;
-	i = backwards ? min(src_slots, dst_slots) - 1 : 0;
-	iter = backwards ? -1 : 1;
-
-	align_shadow_src =
-		(u32 *)ALIGN_DOWN((u64)shadow_src, KMSAN_ORIGIN_SIZE);
-	for (step = 0; step < min(src_slots, dst_slots); step++, i += iter) {
-		KMSAN_WARN_ON(i < 0);
-		shadow = align_shadow_src[i];
-		if (i == 0) {
-			/*
-			 * If @src isn't aligned on KMSAN_ORIGIN_SIZE, don't
-			 * look at the first @src % KMSAN_ORIGIN_SIZE bytes
-			 * of the first shadow slot.
-			 */
-			skip_bits = ((u64)src % KMSAN_ORIGIN_SIZE) * 8;
-			shadow = (shadow >> skip_bits) << skip_bits;
+	step = backwards ? -1 : 1;
+	iter = backwards ? n - 1 : 0;
+	src_off = (u64)src % KMSAN_ORIGIN_SIZE;
+	dst_off = (u64)dst % KMSAN_ORIGIN_SIZE;
+
+	/* Copy shadow bytes one by one, updating the origins if necessary. */
+	for (i = 0; i < n; i++, iter += step) {
+		oiter_src = (iter + src_off) / KMSAN_ORIGIN_SIZE;
+		oiter_dst = (iter + dst_off) / KMSAN_ORIGIN_SIZE;
+		if (!shadow_src[iter]) {
+			shadow_dst[iter] = 0;
+			if (!align_shadow_dst[oiter_dst])
+				origin_dst[oiter_dst] = 0;
+			continue;
 		}
-		if (i == src_slots - 1) {
-			/*
-			 * If @src + n isn't aligned on
-			 * KMSAN_ORIGIN_SIZE, don't look at the last
-			 * (@src + n) % KMSAN_ORIGIN_SIZE bytes of the
-			 * last shadow slot.
-			 */
-			skip_bits = (((u64)src + n) % KMSAN_ORIGIN_SIZE) * 8;
-			shadow = (shadow << skip_bits) >> skip_bits;
-		}
-		/*
-		 * Overwrite the origin only if the corresponding
-		 * shadow is nonempty.
-		 */
-		if (origin_src[i] && (origin_src[i] != old_origin) && shadow) {
-			old_origin = origin_src[i];
-			new_origin = kmsan_internal_chain_origin(old_origin);
+		shadow_dst[iter] = shadow_src[iter];
+		old_origin = origin_src[oiter_src];
+		if (old_origin == prev_old_origin)
+			new_origin = prev_new_origin;
+		else {
 			/*
 			 * kmsan_internal_chain_origin() may return
 			 * NULL, but we don't want to lose the previous
 			 * origin value.
 			 */
+			new_origin = kmsan_internal_chain_origin(old_origin);
 			if (!new_origin)
 				new_origin = old_origin;
 		}
-		if (shadow)
-			origin_dst[i] = new_origin;
-		else
-			origin_dst[i] = 0;
-	}
-	/*
-	 * If dst_slots is greater than src_slots (i.e.
-	 * dst_slots == src_slots + 1), there is an extra origin slot at the
-	 * beginning or end of the destination buffer, for which we take the
-	 * origin from the previous slot.
-	 * This is only done if the part of the source shadow corresponding to
-	 * slot is non-zero.
-	 *
-	 * E.g. if we copy 8 aligned bytes that are marked as uninitialized
-	 * and have origins o111 and o222, to an unaligned buffer with offset 1,
-	 * these two origins are copied to three origin slots, so one of then
-	 * needs to be duplicated, depending on the copy direction (@backwards)
-	 *
-	 *   src shadow: |uuuu|uuuu|....|
-	 *   src origin: |o111|o222|....|
-	 *
-	 * backwards = 0:
-	 *   dst shadow: |.uuu|uuuu|u...|
-	 *   dst origin: |....|o111|o222| - fill the empty slot with o111
-	 * backwards = 1:
-	 *   dst shadow: |.uuu|uuuu|u...|
-	 *   dst origin: |o111|o222|....| - fill the empty slot with o222
-	 */
-	if (src_slots < dst_slots) {
-		if (backwards) {
-			shadow = align_shadow_src[src_slots - 1];
-			skip_bits = (((u64)dst + n) % KMSAN_ORIGIN_SIZE) * 8;
-			shadow = (shadow << skip_bits) >> skip_bits;
-			if (shadow)
-				/* src_slots > 0, therefore dst_slots is at least 2 */
-				origin_dst[dst_slots - 1] =
-					origin_dst[dst_slots - 2];
-		} else {
-			shadow = align_shadow_src[0];
-			skip_bits = ((u64)dst % KMSAN_ORIGIN_SIZE) * 8;
-			shadow = (shadow >> skip_bits) << skip_bits;
-			if (shadow)
-				origin_dst[0] = origin_dst[1];
-		}
+		origin_dst[oiter_dst] = new_origin;
+		prev_new_origin = new_origin;
+		prev_old_origin = old_origin;
 	}
 }
 
-- 
2.42.0.283.g2d96d420d3-goog

