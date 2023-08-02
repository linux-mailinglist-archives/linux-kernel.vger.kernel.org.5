Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6087576C171
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 02:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjHBAUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 20:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbjHBAUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 20:20:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC922710
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 17:20:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d326cb4c97fso2589861276.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 17:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690935604; x=1691540404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sQqMGlFvgvQ3yvXEv1c3TG8Zu+eyY93FF0SWidKY8Dg=;
        b=sjS9Sd/96ChnfQYaR1cO5sk2N9oknVX/qJB2yXG052CqPpTjyq29z2og4PvyAUfuFb
         BbtTttNXygAAyEGj4VDc+gc5Tv/jJm9VVufAhbVnxD9d2fZv9SEDE3pJ6CmBfTmsJ7/M
         30pcgTpZEa5b5WZTWX8yFJI4winvc57m0RSu8uswlhLrD88MgHDJlMnwkJUHOUbaDiEX
         XFB8o/mR1Hsb5CgE+Zf1jutf81sOk0xLQ2PlXcTmJRipNCPc6eQScIC9DvSTQlXma76v
         y6rPEG/+3EoY9yWeyWMpqj6nc4br7aYthBDJY27Nv4jLmE5k9Zm7VQi5fBGYNijEtZwE
         qVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690935604; x=1691540404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sQqMGlFvgvQ3yvXEv1c3TG8Zu+eyY93FF0SWidKY8Dg=;
        b=iyVvg4Dx+cspydffc7xhXdqD/MOkOorrVazUZ27irMG8OAKqmkFx67qU5Bknd95GEg
         ms56ZeT+8venJrlhcH9moa6TjWCS25+M7hmlpdsGDEtfVio0Zw4EL10VAZ0HD3rASpIH
         X2Pl8WGMywqGQkyRkEz1cFcxaOPziT3vaoQLMpvZ7h+vq4Xnwy1Y1IHSiB5ygedgNStu
         6HqT+rk2o+D0KyRHNpAlpjTgwIegGwtPbkJBZPbaPZKGjRcCG0o3pLEIE776ElBnzgB5
         5NSlpiA9K0cUh6z2NCK7MsOTMtXv9n14ntTG5g4Jlowudg+q+7weHHREoHLNR6nRi8tE
         MnFA==
X-Gm-Message-State: ABy/qLYP/56jXEP5vlICzwrQZI8kWtca3jXm0OtOlMmgzhbfsbhU/mWp
        G5INhQy4HfYqOCawPvDPqGyRVcLefd6SAsKvOg==
X-Google-Smtp-Source: APBJJlEf7/u2/Z616hvXFPIg4IjabnaZmfD7pavvMQxNa0+Yi7QX2OhFnd4BlpzLjlUWlOxu9nZ4P/MXGt70cu1ftA==
X-Received: from kalesh.mtv.corp.google.com ([2620:15c:211:201:aa5f:ff75:318:255])
 (user=kaleshsingh job=sendgmr) by 2002:a25:48a:0:b0:d37:353:b7eb with SMTP id
 132-20020a25048a000000b00d370353b7ebmr33827ybe.11.1690935603866; Tue, 01 Aug
 2023 17:20:03 -0700 (PDT)
Date:   Tue,  1 Aug 2023 17:19:37 -0700
In-Reply-To: <20230802001938.3913174-1-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20230802001938.3913174-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230802001938.3913174-3-kaleshsingh@google.com>
Subject: [PATCH 3/3] mm-unstable: Multi-gen LRU: Fix can_swap in lru_gen_look_around()
From:   Kalesh Singh <kaleshsingh@google.com>
To:     yuzhao@google.com, akpm@linux-foundation.org
Cc:     surenb@google.com, android-mm@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
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

walk->can_swap might be invalid since it's not guaranteed to be
initialized for the particular lruvec. Instead deduce it from the folio
type (anon/file).

Cc: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 mm/vmscan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6eecd291756c..b4329f93a682 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4656,6 +4656,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	pte_t *pte = pvmw->pte;
 	unsigned long addr = pvmw->address;
 	struct folio *folio = pfn_folio(pvmw->pfn);
+	bool can_swap = !folio_is_file_lru(folio);
 	struct mem_cgroup *memcg = folio_memcg(folio);
 	struct pglist_data *pgdat = folio_pgdat(folio);
 	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
@@ -4704,7 +4705,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		if (!pte_young(ptent))
 			continue;
 
-		folio = get_pfn_folio(pfn, memcg, pgdat, !walk || walk->can_swap);
+		folio = get_pfn_folio(pfn, memcg, pgdat, can_swap);
 		if (!folio)
 			continue;
 
-- 
2.41.0.255.g8b1d071c50-goog

