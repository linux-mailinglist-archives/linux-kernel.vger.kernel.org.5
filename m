Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE8A76C16F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjHBAUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjHBAT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:19:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6EA2113
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 17:19:48 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57320c10635so72638517b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 17:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690935587; x=1691540387;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DXVsJSb9QIFOr/Cp0N+IT34pRw+slorysgAR9VBW/lM=;
        b=jrl7Ys0xOyJWUU+1bY9AvYsLoVedsg9Qt+P5GRVgnRL82QJNvITpopMf6Y35+KiR6+
         njcjAClUQ4TRB4Ew4iQEZOUMRde47mcLG3VaP/NoWN+aNNuff7bpgIyFSuKJqyCl/VaQ
         FNDSWcd3QRSOAYr30HQrFCbKb0BQVGZ020abfKKxfvpx7WxvVX/Cij4OvDiA073uU/1R
         4MuJofEOPoOQ1o65LYZcA42/Azb4YnHyrF+DH4DjXL9KbQfuDKMm497mezw1N8ynoBCD
         EpKwsodi8TP5ivvB24NM8bKJWXIIaTAiPXyXwURLSlqVmPA4hdUzH630ElxNEypBuYbx
         EDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690935587; x=1691540387;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXVsJSb9QIFOr/Cp0N+IT34pRw+slorysgAR9VBW/lM=;
        b=G3vUU2IPtX6gXV+2AVgSN+M3l94zUupHClIg/wBFyEExyR8r5HuuAS48IPmxDCMsLt
         s7HoWp5yd2+WvvlT+1efxTMyaEjeeF4+yxflhjso/E5fbKvfKKIZsUC3cSXtFTg73cIH
         9lnB7g6MMcnaL03Z0ZpjWYTrvKHMbyOCMcZTVdDDDJhrfRKCZBt5QlowSYs+RsOZpi/3
         G0ovyc9obljlV4NPMqIFsud9C4MEFeNeih5kvRQ9FLL9xwVyr+iKkLSisSVTdoGYXg7Y
         s3rH50Yo0RZn46TC8x5KH7VvxC+U4GUJyow2S1d4TXeeNe43/7C3rft1bRzUx+7HCnA7
         d02g==
X-Gm-Message-State: ABy/qLZ71GOtbcco6DdziI4L6cDI04kAqSOeuBkdM2wmu/or0JsNN1Ye
        b7GZTfqFrdp/JSn0LznU83AY5DTqALypCk9bfA==
X-Google-Smtp-Source: APBJJlFOYOnPjUqct44iRohOnc0mUP9ReqoYJeBrA5AVDrjW9wn0H6QdpajsQPU0LLHzoebktFORyvnYqlxBKUc5/Q==
X-Received: from kalesh.mtv.corp.google.com ([2620:15c:211:201:aa5f:ff75:318:255])
 (user=kaleshsingh job=sendgmr) by 2002:a25:ab86:0:b0:d0d:a7bc:4040 with SMTP
 id v6-20020a25ab86000000b00d0da7bc4040mr103482ybi.0.1690935587776; Tue, 01
 Aug 2023 17:19:47 -0700 (PDT)
Date:   Tue,  1 Aug 2023 17:19:35 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230802001938.3913174-1-kaleshsingh@google.com>
Subject: [PATCH 1/3] mm-unstable: Multi-gen LRU: Fix per-zone reclaim
From:   Kalesh Singh <kaleshsingh@google.com>
To:     yuzhao@google.com, akpm@linux-foundation.org
Cc:     surenb@google.com, android-mm@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

MGLRU has a LRU list for each zone for each type (anon/file) in each
generation:

	long nr_pages[MAX_NR_GENS][ANON_AND_FILE][MAX_NR_ZONES];

The min_seq (oldest generation) can progress independently for each
type but the max_seq (youngest generation) is shared for both anon and
file. This is to maintain a common frame of reference.

In order for eviction to advance the min_seq of a type, all the per-zone
lists in the oldest generation of that type must be empty.

The eviction logic only considers pages from eligible zones for
eviction or promotion.

    scan_folios() {
	...
	for (zone = sc->reclaim_idx; zone >= 0; zone--)  {
	    ...
	    sort_folio(); 	// Promote
	    ...
	    isolate_folio(); 	// Evict
	}
	...
    }

Consider the system has the movable zone configured and default 4
generations. The current state of the system is as shown below
(only illustrating one type for simplicity):

Type: ANON

	Zone    DMA32     Normal    Movable    Device

	Gen 0       0          0        4GB         0

	Gen 1       0        1GB        1MB         0

	Gen 2     1MB        4GB        1MB         0

	Gen 3     1MB        1MB        1MB         0

Now consider there is a GFP_KERNEL allocation request (eligible zone
index <= Normal), evict_folios() will return without doing any work
since there are no pages to scan in the eligible zones of the oldest
generation. Reclaim won't make progress until triggered from a ZONE_MOVABLE
allocation request; which may not happen soon if there is a lot of free
memory in the movable zone. This can lead to OOM kills, although there
is 1GB pages in the Normal zone of Gen 1 that we have not yet tried to
reclaim.

This issue is not seen in the conventional active/inactive LRU since
there are no per-zone lists.

If there are no (not enough) folios to scan in the eligible zones, move
folios from ineligible zone (zone_index > reclaim_index) to the next
generation. This allows for the progression of min_seq and reclaiming
from the next generation (Gen 1).

Qualcomm, Mediatek and raspberrypi [1] discovered this issue independently.

[1] https://github.com/raspberrypi/linux/issues/5395

Cc: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
Reported-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/vmscan.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4039620d30fe..489a4fc7d9b1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4889,7 +4889,8 @@ static int lru_gen_memcg_seg(struct lruvec *lruvec)
  *                          the eviction
  ******************************************************************************/
 
-static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
+static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_control *sc,
+		       int tier_idx)
 {
 	bool success;
 	int gen = folio_lru_gen(folio);
@@ -4939,6 +4940,13 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, int tier_idx)
 		return true;
 	}
 
+	/* ineligible */
+	if (zone > sc->reclaim_idx) {
+		gen = folio_inc_gen(lruvec, folio, false);
+		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
+		return true;
+	}
+
 	/* waiting for writeback */
 	if (folio_test_locked(folio) || folio_test_writeback(folio) ||
 	    (type == LRU_GEN_FILE && folio_test_dirty(folio))) {
@@ -4987,7 +4995,8 @@ static bool isolate_folio(struct lruvec *lruvec, struct folio *folio, struct sca
 static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 		       int type, int tier, struct list_head *list)
 {
-	int gen, zone;
+	int i;
+	int gen;
 	enum vm_event_item item;
 	int sorted = 0;
 	int scanned = 0;
@@ -5003,9 +5012,10 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 
 	gen = lru_gen_from_seq(lrugen->min_seq[type]);
 
-	for (zone = sc->reclaim_idx; zone >= 0; zone--) {
+	for (i = MAX_NR_ZONES; i > 0; i--) {
 		LIST_HEAD(moved);
 		int skipped = 0;
+		int zone = (sc->reclaim_idx + i) % MAX_NR_ZONES;
 		struct list_head *head = &lrugen->folios[gen][type][zone];
 
 		while (!list_empty(head)) {
@@ -5019,7 +5029,7 @@ static int scan_folios(struct lruvec *lruvec, struct scan_control *sc,
 
 			scanned += delta;
 
-			if (sort_folio(lruvec, folio, tier))
+			if (sort_folio(lruvec, folio, sc, tier))
 				sorted += delta;
 			else if (isolate_folio(lruvec, folio, sc)) {
 				list_add(&folio->lru, list);
-- 
2.41.0.255.g8b1d071c50-goog

