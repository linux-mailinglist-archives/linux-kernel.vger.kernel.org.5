Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2025E76C32E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjHBC4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjHBC4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:56:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142E0273A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:56:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-585f254c41aso48678347b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 19:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690944975; x=1691549775;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aqehfJB+hF+Fne+AdGJurbsZIYsQCeOte57mRi2GAJw=;
        b=33TVVDzXg6eBl7/Vpt8F6zz+Hj/NOmdXdllc0HT3+fXbEBhkPYtEkaq37eNBBfQ//f
         huzyAhMvUorpNH56dDYRwA06JZVdYTEAbzfGjbqw3gBWiic0SbSYYIRLI7+dUO6KJeP/
         QbLSh8xuVcrhWjh4oWX9BfGiIQ2WhcFjEVln6zdtkNbTrb8Vr/FaB0bbjGe719xWxqpC
         hL3EQTp/eSWIIOfcyzhoc5/BO66sBZZeI+o1Tma4ICZmtHB5eUiGscJSklwG5yeK8aOP
         pOTWKEoNcoXV0uOzF2WA7ODrKPaZuVgMaXvYUoulWRPVnXT17L+Vmq1QR0HZFgWxuJek
         tQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690944975; x=1691549775;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqehfJB+hF+Fne+AdGJurbsZIYsQCeOte57mRi2GAJw=;
        b=ktUV9uNKEiJ4ZHirx5O0bbupTW3jow9+YcABcY/90FMTlkgKZY9VI/jMHyRmMwVQhx
         JBzI/JNlllloiyD3XoQqi9FIqv7d8NI8FDa+YPI3HXUQr8Z+lvByw9y1And3f9Sf9MFW
         PmfL/SpkJUZCB9ap+gjcJZ97w9SxqfWst7L+v5GHysQNda5SsayLKkgfjhCoJtI98g0Q
         CC5MHwe7YequIvkoUYlbz+rfA5+fV8GjGoyPZUibS1NXbxnrIAb0pXzJiEzivoE+wVDO
         ehz/U9ph4FvqWkhSrQCdliYWdkJ+eswL1bDCic3vxV9eDuSrEx6HD1vrFj3lObELUnNC
         KW4Q==
X-Gm-Message-State: ABy/qLYm2oDy6nUaHT84s9umZVV0aG7X4rzIfoJRpccm6yDKRDK01y15
        V9tm/nl8qbFF6zrfXKeCC6y7uEvQzEkJnIgK8A==
X-Google-Smtp-Source: APBJJlGu4CGYprEhx9EAJQV2bkMTULOViWk9fNZltzmcAuDxS7zR2BS8SgTh3oU+2KBCXMRrlqL63XtCKu/qeEPcYg==
X-Received: from kalesh.mtv.corp.google.com ([2620:15c:211:201:aa5f:ff75:318:255])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:100f:b0:cf9:3564:33cc with
 SMTP id w15-20020a056902100f00b00cf9356433ccmr116986ybt.13.1690944975112;
 Tue, 01 Aug 2023 19:56:15 -0700 (PDT)
Date:   Tue,  1 Aug 2023 19:56:02 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230802025606.346758-1-kaleshsingh@google.com>
Subject: [PATCH v2 1/3] mm-unstable: Multi-gen LRU: Fix per-zone reclaim
From:   Kalesh Singh <kaleshsingh@google.com>
To:     yuzhao@google.com, akpm@linux-foundation.org
Cc:     surenb@google.com, android-mm@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org,
        Charan Teja Kalla <quic_charante@quicinc.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        Barry Song <baohua@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

Fixes: ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
Cc: stable@vger.kernel.org
Cc: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Charan Teja Kalla <quic_charante@quicinc.com>
Reported-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - Add Fixes tag and cc stable

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

