Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0472576C331
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjHBC4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjHBC4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:56:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33762D4E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:56:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583da2ac09fso74295847b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 19:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690944984; x=1691549784;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hIR85jBvXabpNDlh2e7xtBRwmCRiojtCshBAYjOX1Y=;
        b=NaC24ZANDfp+9XAVYJ2zthvJ8rUBTQ6l5oOsseG6mfA3cvF+arl71fQG1qHAhLbqJ9
         9qeh16JOmABIOlkWmOSbROyLEpFlmq9EQUA6/uFoeGgx/95B08yoDHueOaoh/i5155mY
         XVuhu3IiHZBf1PozmtFvavLXWlrDny3HMWCrGbcbi3wm/Avg9RqMK4JG4u4VTr67QtHd
         KbHI/PNLuqrNbAwO5JvECyVMzM5KsSmQk2W4uE2b/bpTqBDpICou5hRnR2Ky2iDO0WiX
         xNEzbL/OrqT3RifP1ne+1qALr+MKSfhXAnsSEvF0phJYNv0q7iAwZlhSP5UEXbHyOUib
         Cf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690944984; x=1691549784;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hIR85jBvXabpNDlh2e7xtBRwmCRiojtCshBAYjOX1Y=;
        b=ffnY0EsPEmpLsVG7scB3dQrAUSSIwXn13W9yTLZ/6IDfvk/6hIdOp+0igsGi25qNpb
         jjzGTCGPi715uKPJwE7jXTp7N8oRsRV7klzi5ulgDyMg6uu2qnAwr8wfmkjEW9E1Kbao
         3SROfqmmtFLEVYtl5xzHKNvJ5t5JkVC6wrY9vKGrmCXXcH9fXEU9EoxY1gxl64LgmTXN
         7MHJUHj6tQNRKeX1v7lxXQ4k4iC5qD/PScRLtet57tQevqkw8YTz4Afy08OeGLTpgdi1
         7Y7WYfVMNvikLlSsH8PIiBQI+2RzX90yLmxzdp2P9YgN3FI5GBuV5PFnUd0SHJI+qwY4
         qUzg==
X-Gm-Message-State: ABy/qLYpWPUq5VF0hsewKhXx8myqU38IDUA2iAWcX8v61auFYR6VwxfO
        nbw35PW0iBhy9X9LYwI8by420pWoimbPXU/0OA==
X-Google-Smtp-Source: APBJJlHj0tBKgoeUZ7ci0leYLXMuHGiQZrYMbH4Cl/uWTIvoLc5trBzIvMofv2F1eZ7phbcd71NDee6Wx5e539GPkA==
X-Received: from kalesh.mtv.corp.google.com ([2620:15c:211:201:aa5f:ff75:318:255])
 (user=kaleshsingh job=sendgmr) by 2002:a81:a706:0:b0:583:4f82:b9d9 with SMTP
 id e6-20020a81a706000000b005834f82b9d9mr120587ywh.5.1690944984182; Tue, 01
 Aug 2023 19:56:24 -0700 (PDT)
Date:   Tue,  1 Aug 2023 19:56:04 -0700
In-Reply-To: <20230802025606.346758-1-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20230802025606.346758-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230802025606.346758-3-kaleshsingh@google.com>
Subject: [PATCH v2 3/3] mm-unstable: Multi-gen LRU: Fix can_swap in lru_gen_look_around()
From:   Kalesh Singh <kaleshsingh@google.com>
To:     yuzhao@google.com, akpm@linux-foundation.org
Cc:     surenb@google.com, android-mm@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Suleiman Souhlal <suleiman@google.com>,
        Steven Barrett <steven@liquorix.net>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
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

walk->can_swap might be invalid since it's not guaranteed to be
initialized for the particular lruvec. Instead deduce it from the folio
type (anon/file).

Fixes: 018ee47f1489 ("mm: multi-gen LRU: exploit locality in rmap")
Cc: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - Add Fixes tag

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

