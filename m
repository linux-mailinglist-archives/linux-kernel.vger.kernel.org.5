Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C8C7F5479
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344599AbjKVXZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344409AbjKVXZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:25:33 -0500
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B610D110
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:25:29 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700695528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h7yT/gNa8WVPOQ61JKqXqNgHJRrqgXjHTIF9eRajh2g=;
        b=O6Wa1Pq7Futp9HUKsVGvdg+Z5w+n3MO/N9v0rDnM9VMU80eqJlKtDs5MCdlB/RLuq3zB75
        DFQ+Bbi5//mR819xx4Wrz6FRF25hy8ONIL+PG+xyufurdr4QS6+jDEsypsEnexxM7IRVd+
        TH/mv9J3tjkNle2GRCxH+jXEE/7wAlg=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH 3/7] mm: shrinker: Add new stats for .to_text()
Date:   Wed, 22 Nov 2023 18:25:08 -0500
Message-ID: <20231122232515.177833-4-kent.overstreet@linux.dev>
In-Reply-To: <20231122232515.177833-1-kent.overstreet@linux.dev>
References: <20231122232515.177833-1-kent.overstreet@linux.dev>
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

Add a few new shrinker stats.

number of objects requested to free, number of objects freed:

Shrinkers won't necessarily free all objects requested for a variety of
reasons, but if the two counts are wildly different something is likely
amiss.

.scan_objects runtime:

If one shrinker is taking an excessive amount of time to free
objects that will block kswapd from running other shrinkers.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: linux-mm@kvack.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/shrinker.h |  5 +++++
 mm/shrinker.c            | 18 +++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
index 968c55474e78..497a7e8e348c 100644
--- a/include/linux/shrinker.h
+++ b/include/linux/shrinker.h
@@ -118,6 +118,11 @@ struct shrinker {
 #endif
 	/* objs pending delete, per node */
 	atomic_long_t *nr_deferred;
+
+	atomic_long_t objects_requested_to_free;
+	atomic_long_t objects_freed;
+	atomic_long_t last_freed;
+	atomic64_t ns_run;
 };
 #define DEFAULT_SEEKS 2 /* A good number if you don't know better. */
 
diff --git a/mm/shrinker.c b/mm/shrinker.c
index 4976dbac4c83..acfc3f92f552 100644
--- a/mm/shrinker.c
+++ b/mm/shrinker.c
@@ -430,13 +430,20 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	       total_scan >= freeable) {
 		unsigned long ret;
 		unsigned long nr_to_scan = min(batch_size, total_scan);
+		u64 start_time = ktime_get_ns();
+
+		atomic_long_add(nr_to_scan, &shrinker->objects_requested_to_free);
 
 		shrinkctl->nr_to_scan = nr_to_scan;
 		shrinkctl->nr_scanned = nr_to_scan;
 		ret = shrinker->scan_objects(shrinker, shrinkctl);
+
+		atomic64_add(ktime_get_ns() - start_time, &shrinker->ns_run);
 		if (ret == SHRINK_STOP)
 			break;
 		freed += ret;
+		atomic_long_add(ret, &shrinker->objects_freed);
+		atomic_long_set(&shrinker->last_freed, ret);
 
 		count_vm_events(SLABS_SCANNED, shrinkctl->nr_scanned);
 		total_scan -= shrinkctl->nr_scanned;
@@ -812,9 +819,18 @@ EXPORT_SYMBOL_GPL(shrinker_free);
 void shrinker_to_text(struct seq_buf *out, struct shrinker *shrinker)
 {
 	struct shrink_control sc = { .gfp_mask = GFP_KERNEL, };
+	unsigned long nr_freed = atomic_long_read(&shrinker->objects_freed);
 
 	seq_buf_puts(out, shrinker->name);
-	seq_buf_printf(out, " objects: %lu\n", shrinker->count_objects(shrinker, &sc));
+	seq_buf_putc(out, '\n');
+
+	seq_buf_printf(out, "objects:             %lu", shrinker->count_objects(shrinker, &sc));
+	seq_buf_printf(out, "requested to free:   %lu", atomic_long_read(&shrinker->objects_requested_to_free));
+	seq_buf_printf(out, "objects freed:       %lu", nr_freed);
+	seq_buf_printf(out, "last freed:          %lu", atomic_long_read(&shrinker->last_freed));
+	seq_buf_printf(out, "ns per object freed: %llu", nr_freed
+		       ? div64_ul(atomic64_read(&shrinker->ns_run), nr_freed)
+		       : 0);
 
 	if (shrinker->to_text) {
 		shrinker->to_text(out, shrinker);
-- 
2.42.0

