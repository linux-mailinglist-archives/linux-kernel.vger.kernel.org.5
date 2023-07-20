Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C82375AB68
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjGTJte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjGTJs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:48:28 -0400
Received: from out-18.mta0.migadu.com (out-18.mta0.migadu.com [IPv6:2001:41d0:1004:224b::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678DB26A5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:47:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689846450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CHTcss6l/Dml/Uch+o0A/n+25yQoOIqj7dE4TlbyHH4=;
        b=Ai++OZMUjHmw2983yCNBjVkPFxFeR1arX5zXXbaGjA90hfi5mvTPK+xbJURrXi/u+0CWWN
        RkZhb6KGm+bKwEOt2ud4UlHdP4VWFqqslwKhjxgk4nP6y8kd6taike6pQ5cLKPz4EMMIpE
        7N58wZ4pmp7tHfkumvcPMa3P5e/aYD4=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, osandov@fb.com, ming.lei@redhat.com,
        kbusch@kernel.org, krisman@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 4/6] sbitmap: remove offset wrap logic when finding bit in word
Date:   Thu, 20 Jul 2023 17:45:53 +0800
Message-ID: <20230720094555.1397621-5-chengming.zhou@linux.dev>
In-Reply-To: <20230720094555.1397621-1-chengming.zhou@linux.dev>
References: <20230720094555.1397621-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

We actually don't need the offset hint wrap logic in word:

1. Strict round-robin mode: just search from that offset hint,
   we will recheck that word at last if offset hint > 0.

2. No round-robin mode: we use offset hint == 0, so don't need
   to wrap offset hint too.

We remove offset wrap logic and simplify the code.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 lib/sbitmap.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 0f3943bd3940..50bdf3a31947 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -134,34 +134,21 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
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
-			if (wrap) {
-				hint = 0;
-				continue;
-			}
+		if (unlikely(nr >= depth))
 			return -1;
-		}
 
 		if (!test_and_set_bit_lock(nr, word))
 			break;
 
 		hint = nr + 1;
-		if (hint >= depth) {
-			if (wrap) {
-				hint = 0;
-				continue;
-			}
+		if (hint >= depth)
 			return -1;
-		}
 	}
 
 	return nr;
@@ -169,14 +156,13 @@ static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 
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
@@ -189,8 +175,7 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 static int sbitmap_find_bit(struct sbitmap *sb,
 			    unsigned int depth,
 			    unsigned int index,
-			    unsigned int alloc_hint,
-			    bool wrap)
+			    unsigned int alloc_hint)
 {
 	unsigned int map_nr = sb->map_nr;
 	unsigned int i;
@@ -200,7 +185,7 @@ static int sbitmap_find_bit(struct sbitmap *sb,
 	 * If we have alloc_hint > 0 and don't wrap, we need to
 	 * recheck sb->map[index] with hint == 0 to exhaust the map.
 	 */
-	if (alloc_hint && !wrap)
+	if (alloc_hint)
 		map_nr += 1;
 
 	for (i = 0; i < map_nr; i++) {
@@ -208,7 +193,7 @@ static int sbitmap_find_bit(struct sbitmap *sb,
 					      min_t(unsigned int,
 						    __map_depth(sb, index),
 						    depth),
-					      alloc_hint, wrap);
+					      alloc_hint);
 
 		if (nr != -1) {
 			nr += index << sb->shift;
@@ -240,8 +225,7 @@ static int __sbitmap_get(struct sbitmap *sb, unsigned int alloc_hint)
 	else
 		alloc_hint = 0;
 
-	return sbitmap_find_bit(sb, UINT_MAX, index, alloc_hint,
-				!sb->round_robin);
+	return sbitmap_find_bit(sb, UINT_MAX, index, alloc_hint);
 }
 
 int sbitmap_get(struct sbitmap *sb)
@@ -272,7 +256,7 @@ static int __sbitmap_get_shallow(struct sbitmap *sb,
 	/* No point in looping twice in find_next_zero_bit() for this case. */
 	alloc_hint = 0;
 
-	return sbitmap_find_bit(sb, shallow_depth, index, alloc_hint, true);
+	return sbitmap_find_bit(sb, shallow_depth, index, alloc_hint);
 }
 
 int sbitmap_get_shallow(struct sbitmap *sb, unsigned long shallow_depth)
-- 
2.41.0

