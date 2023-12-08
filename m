Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B117A809C41
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjLHGOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjLHGOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:14:10 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC5E171F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:14:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db548f8dae4so2294059276.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 22:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702016055; x=1702620855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MPyzSKrXH5Tqmu9fHEEk3D/5egUUX9zjhxgsMiAOvSY=;
        b=sx41H2WPZze9RWflhBXz/lSSAEC3LY0JnjR3LOlOzXrnPNvP8f6bQZVip5xKRq78kE
         jeyVo9r+Whn7Hz9qv0N/oel3byRyL53qMpC7gU+4o1KeK2CpB3Gq3Lo4VAQnqJvOnvrC
         KmlB3msz8cfcEqQWI7QXMuzZgt8OlwQLdhinMKYFshrAOrsYTEfdMK1F8yR3krsomZxx
         YXp21SOKcabj2Ogkkhg8IsF/fh95K92d3TNvuk8yQJA7B/B5ea+HVKUKy28hRVSLyHjD
         lynMy5FeiiLCkulYVtLNOi7E/70+EHF3uRcT5fRsjG6sCqa0TAFASwrJw3FaKzI+t+AN
         l2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702016055; x=1702620855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MPyzSKrXH5Tqmu9fHEEk3D/5egUUX9zjhxgsMiAOvSY=;
        b=ukKenaKztEtDF5WHhWHmc39/+O1jyqnNBpkBVUe2YpxXdHsJce8dr3P8Uyc0wN5QQY
         7gV63Tpx4QesTfyUsQTjuEamMLo1/5TFSSjHcIUAw/gpDqu045m7qqCxfGmMrqDp/v4F
         ZRu821kQ/XKLvMYROg0p08kcwwkFPx0xnGe8AkeSFtPndXicxm7u5uPJjKCloaVskAXt
         8u1DqgF4fBbG7QuAua41JVsVRFmF6B8c9zsIFifje1F0BiygHr7h+XnzXhAW2WL0pw6M
         SadihBO//PLtY2u32c+75MkEEEjlTv4HxoJfLjrlbXMs7fJQ5Fs2pkiELEC+wzkumeu4
         Tsxw==
X-Gm-Message-State: AOJu0YzeITMglcSsVzBvzrZpzPcVEsYmsudj0w0EXpB9YIi5YY0aEYPE
        hnWY4UV3k57OmCzTNfaR1h26HjyUv9M=
X-Google-Smtp-Source: AGHT+IGdRJ6oJBGbszEwYJdNZWMiTiNDeQOA8ujBPwzvHJj4q8s9r2Akp7Hq9nIVYDsXPZgw2A9/YR7iKD4=
X-Received: from yuzhao2.bld.corp.google.com ([100.64.188.49]) (user=yuzhao
 job=sendgmr) by 2002:a25:76d5:0:b0:da0:3da9:ce08 with SMTP id
 r204-20020a2576d5000000b00da03da9ce08mr52921ybc.10.1702016055395; Thu, 07 Dec
 2023 22:14:15 -0800 (PST)
Date:   Thu,  7 Dec 2023 23:14:05 -0700
In-Reply-To: <20231208061407.2125867-1-yuzhao@google.com>
Mime-Version: 1.0
References: <20231208061407.2125867-1-yuzhao@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208061407.2125867-2-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 2/4] mm/mglru: try to stop at high watermarks
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
        Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The initial MGLRU patchset didn't include the memcg LRU support, and
it relied on should_abort_scan(), added by commit f76c83378851 ("mm:
multi-gen LRU: optimize multiple memcgs"), to "backoff to avoid
overshooting their aggregate reclaim target by too much".

Later on when the memcg LRU was added, should_abort_scan() was deemed
unnecessary, and the test results [1] showed no side effects after it
was removed by commit a579086c99ed ("mm: multi-gen LRU: remove
eviction fairness safeguard").

However, that test used memory.reclaim, which sets nr_to_reclaim to
SWAP_CLUSTER_MAX. So it can overshoot only by SWAP_CLUSTER_MAX-1
pages, i.e., from nr_reclaimed=nr_to_reclaim-1 to
nr_reclaimed=nr_to_reclaim+SWAP_CLUSTER_MAX-1. Compared with the batch
size kswapd sets to nr_to_reclaim, SWAP_CLUSTER_MAX is tiny. Therefore
that test isn't able to reproduce the worst case scenario, i.e.,
kswapd overshooting GBs on large systems and "consuming 100% CPU" (see
the Closes tag).

Bring back a simplified version of should_abort_scan() on top of the
memcg LRU, so that kswapd stops when all eligible zones are above
their respective high watermarks plus a small delta to lower the
chance of KSWAPD_HIGH_WMARK_HIT_QUICKLY. Note that this only applies
to order-0 reclaim, meaning compaction-induced reclaim can still run
wild (which is a different problem).

On Android, launching 55 apps sequentially:
           Before     After      Change
  pgpgin   838377172  802955040  -4%
  pgpgout  38037080   34336300   -10%

[1] https://lore.kernel.org/20221222041905.2431096-1-yuzhao@google.com/

Fixes: a579086c99ed ("mm: multi-gen LRU: remove eviction fairness safeguard")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Closes: https://lore.kernel.org/CAK8fFZ4DY+GtBA40Pm7Nn5xCHy+51w3sfxPqkqpqakSXYyX+Wg@mail.gmail.com/
Tested-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Tested-by: Kalesh Singh <kaleshsingh@google.com>
Cc: stable@vger.kernel.org
---
 mm/vmscan.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e67631c60ac0..10e964cd0efe 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4676,20 +4676,41 @@ static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, bool
 	return try_to_inc_max_seq(lruvec, max_seq, sc, can_swap, false) ? -1 : 0;
 }
 
-static unsigned long get_nr_to_reclaim(struct scan_control *sc)
+static bool should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
 {
+	int i;
+	enum zone_watermarks mark;
+
 	/* don't abort memcg reclaim to ensure fairness */
 	if (!root_reclaim(sc))
-		return -1;
+		return false;
 
-	return max(sc->nr_to_reclaim, compact_gap(sc->order));
+	if (sc->nr_reclaimed >= max(sc->nr_to_reclaim, compact_gap(sc->order)))
+		return true;
+
+	/* check the order to exclude compaction-induced reclaim */
+	if (!current_is_kswapd() || sc->order)
+		return false;
+
+	mark = sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING ?
+	       WMARK_PROMO : WMARK_HIGH;
+
+	for (i = 0; i <= sc->reclaim_idx; i++) {
+		struct zone *zone = lruvec_pgdat(lruvec)->node_zones + i;
+		unsigned long size = wmark_pages(zone, mark) + MIN_LRU_BATCH;
+
+		if (managed_zone(zone) && !zone_watermark_ok(zone, 0, size, sc->reclaim_idx, 0))
+			return false;
+	}
+
+	/* kswapd should abort if all eligible zones are safe */
+	return true;
 }
 
 static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	long nr_to_scan;
 	unsigned long scanned = 0;
-	unsigned long nr_to_reclaim = get_nr_to_reclaim(sc);
 	int swappiness = get_swappiness(lruvec, sc);
 
 	/* clean file folios are more likely to exist */
@@ -4711,7 +4732,7 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 		if (scanned >= nr_to_scan)
 			break;
 
-		if (sc->nr_reclaimed >= nr_to_reclaim)
+		if (should_abort_scan(lruvec, sc))
 			break;
 
 		cond_resched();
@@ -4772,7 +4793,6 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 	struct lru_gen_folio *lrugen;
 	struct mem_cgroup *memcg;
 	const struct hlist_nulls_node *pos;
-	unsigned long nr_to_reclaim = get_nr_to_reclaim(sc);
 
 	bin = first_bin = get_random_u32_below(MEMCG_NR_BINS);
 restart:
@@ -4805,7 +4825,7 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 
 		rcu_read_lock();
 
-		if (sc->nr_reclaimed >= nr_to_reclaim)
+		if (should_abort_scan(lruvec, sc))
 			break;
 	}
 
@@ -4816,7 +4836,7 @@ static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 
 	mem_cgroup_put(memcg);
 
-	if (sc->nr_reclaimed >= nr_to_reclaim)
+	if (!is_a_nulls(pos))
 		return;
 
 	/* restart if raced with lru_gen_rotate_memcg() */
-- 
2.43.0.472.g3155946c3a-goog

