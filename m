Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9947F089D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjKSTuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjKSTtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:49:49 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1671B1704
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:49:10 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6c115026985so3870434b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423349; x=1701028149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w2h0VsFq1SfFmbRfFbDLLmtclse5HYqoYk4CcDA6qDI=;
        b=kPVLQgwQevJOFiEY0KJ3SPO+qeDa6dHv8o5dvT8mV5RwVnvACWUcAZ09RNYS17O0uJ
         F5rUlZSZYZJSP3McplnFbayZBp3zJi4oniSKsO9H8xecRURD72zLnK9uzZs31NqN+FrE
         LF3atFZV3hgZHgdhmuSJ/RuCscN2YzlkQSPcYOHSmqnb3XOY4MxFL9qBy51K9+1mQPoZ
         ck8UYcQqX568dEFMmZBWVs8elpC8wi4GDirZVqtBxZVK4E8o5R2ZNdLTL325oViQy4W9
         F/gRx4taMjSmqYErjPpedjaO3X5zf6tTBo8pad0BnIk+u5a2JlxqT1YPZpkEs9kWg3oO
         DkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423349; x=1701028149;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2h0VsFq1SfFmbRfFbDLLmtclse5HYqoYk4CcDA6qDI=;
        b=A7tSNiJiiEpGtL4wf3bUp04p93syIY+rRQWQ85OXb2xmPneZKkyvnfHYM5FJDbkquE
         CI8nWL3aQUeKRJ0mFVlGEhFZmjh2w9tyeP4s9CouR1MbVbNKSGw/qL40EDAjTsRCZ5SM
         UmmsBrck9jpj8k4NwP9LjEnfpA7bhCjb52Ub40P+EGJVcksgPS5qnKzc2oXMmrwyeEc/
         OXZC/tQZ8TMXHJ9tf46ywF/bIrF9WdsdSE8QO5Ym0wJm7ik1FAn8t7m7KJsTjWRbTIqb
         z8nohzw1pKOkZO/Bgvz3Msl6mcL9elP6jIQtQ6i2dKhbrpv1aEXA5zSjnQUxhiMqaWLF
         lggg==
X-Gm-Message-State: AOJu0YwroDZ4VCarqa6mw9jY2e/KLe3DLC7JbleeCYdZueQkAEC3fOPZ
        aITERZ1MYRnVW15rOoI5zq0=
X-Google-Smtp-Source: AGHT+IH7Ef3T9tYhjLf81++NfU6x692Tm7IbNx4ET6n1TwJLp+72WBRurfMYbX3sMqxL34SXbWHpQw==
X-Received: by 2002:a05:6a00:1988:b0:6cb:a1fe:5217 with SMTP id d8-20020a056a00198800b006cba1fe5217mr787020pfl.16.1700423349552;
        Sun, 19 Nov 2023 11:49:09 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.49.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:49:08 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH 21/24] swap: make swapin_readahead result checking argument mandatory
Date:   Mon, 20 Nov 2023 03:47:37 +0800
Message-ID: <20231119194740.94101-22-ryncsn@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119194740.94101-1-ryncsn@gmail.com>
References: <20231119194740.94101-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

This is only one caller now in page fault path, make the result return
argument mandatory.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 6f39aa8394f1..0433a2586c6d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -913,7 +913,6 @@ static struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
 struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 			      struct vm_fault *vmf, enum swap_cache_result *result)
 {
-	enum swap_cache_result cache_result;
 	struct swap_info_struct *si;
 	struct mempolicy *mpol;
 	void *shadow = NULL;
@@ -928,29 +927,27 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 
 	folio = swap_cache_get_folio(entry, vmf, &shadow);
 	if (folio) {
+		*result = SWAP_CACHE_HIT;
 		page = folio_file_page(folio, swp_offset(entry));
-		cache_result = SWAP_CACHE_HIT;
 		goto done;
 	}
 
 	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
 	if (swap_use_no_readahead(si, swp_offset(entry))) {
+		*result = SWAP_CACHE_BYPASS;
 		page = swapin_no_readahead(entry, gfp_mask, mpol, ilx, vmf->vma->vm_mm);
-		cache_result = SWAP_CACHE_BYPASS;
 		if (shadow)
 			workingset_refault(page_folio(page), shadow);
-	} else if (swap_use_vma_readahead(si)) {
-		page = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
-		cache_result = SWAP_CACHE_MISS;
 	} else {
-		page = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
-		cache_result = SWAP_CACHE_MISS;
+		*result = SWAP_CACHE_MISS;
+		if (swap_use_vma_readahead(si))
+			page = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
+		else
+			page = swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
 	}
 	mpol_cond_put(mpol);
 done:
 	put_swap_device(si);
-	if (result)
-		*result = cache_result;
 
 	return page;
 }
-- 
2.42.0

