Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AD176575A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbjG0PV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbjG0PVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:21:52 -0400
Received: from out-96.mta0.migadu.com (out-96.mta0.migadu.com [91.218.175.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A0B1FCF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:21:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690471303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MHEGgdVdHj4vY18bdOXyRtJoqYQZlvIgYxDQJPuL59w=;
        b=Vv/FGX69XOHCDVN28FE8R9XfgBkvYOjRJ9IrvFT4uw+lvzw0cVFHnWmhOhZGe5DGQq4Vm6
        xenzswl7kJ31dEbx9wuTzt3TmK2vDnonf0xi2V8MGao8+9SF3mSueeizHrtPzSG04Vm5+Z
        hNGBLEjRgjptwa72wdpo33hUSoujnnA=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, krisman@suse.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH v2 3/3] sbitmap: drop wrap logic in __sbitmap_get_word()
Date:   Thu, 27 Jul 2023 23:20:20 +0800
Message-ID: <20230727152020.3633009-3-chengming.zhou@linux.dev>
In-Reply-To: <20230727152020.3633009-1-chengming.zhou@linux.dev>
References: <20230727152020.3633009-1-chengming.zhou@linux.dev>
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

From: Chengming Zhou <zhouchengming@bytedance.com>

The complex wrap logic in __sbitmap_get_word() seems unnecessary:

1. Strict round-robin mode: wrap == false
   1.1 hint == 0: we search sb->map_nr words, won't wrap
   1.2 hint > 0: we search (sb->map_nr + 1) words, won't wrap

2. Non round-robin mode: wrap == true
   2.1 hint == 0: we search sb->map_nr words, don't need wrap
   2.2 hint > 0: we search sb->map_nr words, need wrap

So 2.2 is the only reason we need wrap logic in __sbitmap_get_word(),
the only user like 2.2 is __sbitmap_get_shallow().

__sbitmap_get_shallow() always set wrap == true no matter the sbitmap
is round-robin or not, seems that it doesn't want strict round-robin
tag in this limited case.

We can remove 2.2 case by setting hint == 0 in __sbitmap_get_shallow(),
since there is no point in looping twice in find_next_zero_bit() if we
don't want strict round-robin tag for this case.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 lib/sbitmap.c | 47 +++++++++++++----------------------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 6e098a46be26..d042dc5d53c3 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -134,41 +134,21 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 EXPORT_SYMBOL_GPL(sbitmap_resize);
 
 static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
-			      unsigned int hint, bool wrap)
+			      unsigned int hint)
 {
 	int nr;
 
-	/* don't wrap if starting from 0 */
-	wrap = wrap && hint;
-
 	while (1) {
 		nr = find_next_zero_bit(word, depth, hint);
-		if (unlikely(nr >= depth)) {
-			/*
-			 * We started with an offset, and we didn't reset the
-			 * offset to 0 in a failure case, so start from 0 to
-			 * exhaust the map.
-			 */
-			if (wrap) {
-				wrap = false;
-				hint = 0;
-				continue;
-			}
+		if (unlikely(nr >= depth))
 			return -1;
-		}
 
 		if (!test_and_set_bit_lock(nr, word))
 			break;
 
 		hint = nr + 1;
-		if (unlikely(hint >= depth)) {
-			if (wrap) {
-				wrap = false;
-				hint = 0;
-				continue;
-			}
+		if (unlikely(hint >= depth))
 			return -1;
-		}
 	}
 
 	return nr;
@@ -176,14 +156,13 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 
 static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 				    unsigned int depth,
-				    unsigned int alloc_hint,
-				    bool wrap)
+				    unsigned int alloc_hint)
 {
 	int nr;
 
 	do {
 		nr = __sbitmap_get_word(&map->word, depth,
-					alloc_hint, wrap);
+					alloc_hint);
 		if (nr != -1)
 			break;
 		if (!sbitmap_deferred_clear(map))
@@ -196,8 +175,7 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 static int sbitmap_find_bit(struct sbitmap *sb,
 			    unsigned int depth,
 			    unsigned int index,
-			    unsigned int alloc_hint,
-			    bool wrap)
+			    unsigned int alloc_hint)
 {
 	unsigned int map_nr = sb->map_nr;
 	unsigned int i;
@@ -207,7 +185,7 @@ static int sbitmap_find_bit(struct sbitmap *sb,
 	 * If we have alloc_hint > 0 and don't wrap, we need to
 	 * recheck sb->map[index] with hint == 0 to exhaust the map.
 	 */
-	if (alloc_hint && !wrap)
+	if (alloc_hint)
 		map_nr += 1;
 
 	for (i = 0; i < map_nr; i++) {
@@ -215,7 +193,7 @@ static int sbitmap_find_bit(struct sbitmap *sb,
 					      min_t(unsigned int,
 						    __map_depth(sb, index),
 						    depth),
-					      alloc_hint, wrap);
+					      alloc_hint);
 
 		if (nr != -1) {
 			nr += index << sb->shift;
@@ -247,8 +225,7 @@ static int __sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint)
 	else
 		alloc_hint = 0;
 
-	return sbitmap_find_bit(sb, UINT_MAX, index, alloc_hint,
-				!sb->round_robin);
+	return sbitmap_find_bit(sb, UINT_MAX, index, alloc_hint);
 }
 
 int sbitmap_get(struct sbitmap *sb)
@@ -275,9 +252,11 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 	unsigned int index;
 
 	index = SB_NR_TO_INDEX(sb, alloc_hint);
-	alloc_hint = SB_NR_TO_BIT(sb, alloc_hint);
 
-	return sbitmap_find_bit(sb, shallow_depth, index, alloc_hint, true);
+	/* No point in looping twice in find_next_zero_bit() for this case. */
+	alloc_hint = 0;
+
+	return sbitmap_find_bit(sb, shallow_depth, index, alloc_hint);
 }
 
 int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth)
-- 
2.41.0

