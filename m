Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE7B7F0894
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjKSTt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjKSTtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:49:09 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B842CD49
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:44 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b2ec5ee2e4so2610802b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423324; x=1701028124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5hBTip8l+rVWgXZvgeAFfyX4NMH7GqXDBsHUYVWi3uA=;
        b=UtyXFX0e8/Ek/UERAhjAlWMzQLzTdg1YsOffvyqWYEG5x7xqYEA9coS/BQHM1Cx7ZG
         tI/6PmGbi7sUpz5Tq/0QuBh3z0CILn4eD0vrPpcNx2tgfkp1qPipIaWVSPUzQThbLdwN
         jlhbGQlKII2fg4nKvDsIkcqqfXIOQhJJFHgqSqIaJYIMQVNe6xzCdwWD79+/3KnFxkIN
         TcDMpUvQHTpDKP4f4GyW630CuWVXw9BO1jMVQajqB0yb+YsXe7WCcRiA0qK1de1MJyg+
         jkyaB/0+PCZ0ulxvictw8dWMjgSQP2EgMZVMsJwgvOz/9nsdzaal7u+BNGcF6iepH6LW
         GH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423324; x=1701028124;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hBTip8l+rVWgXZvgeAFfyX4NMH7GqXDBsHUYVWi3uA=;
        b=IocGKSInJPDQxeJAX74SOzPcR/aQYuKSLAwpo10JZhbIWYBsws+Ga83ReVt0EGQtiu
         +LMju/kXgzw0xd/EVtP+/ExMt5HugZddezpE1JCTS4W5HbGjDC53m+Zna75FrUBhCM3+
         Z7mBJU203kScmNGpY8x2ZDEQKiK/LN8Z+0TS6oAmmhNrRN/Ld96yCXEoPQmfC8hcxCuT
         5b4C2bguz/LRuWkYXSUoU+RQZbPKTtiqHUCy38qWGjpvT25FSdot6GMZpSjeLzXYAmz2
         q2KE9Q/iZZED7lspvd3TFSwdZR6tdD0fSxPNT2ITQcAmUVSk0/ryCF3mS2JXoJXULVcY
         JbDA==
X-Gm-Message-State: AOJu0Yzm8pgyUo1gRv9vKc/yrbniJtnpP7BTnHktKfsqhIY4c2ZhVQeE
        bTU+SJidFmF4h7wdXQui5aw=
X-Google-Smtp-Source: AGHT+IEailrfhPaQZQEKYeEqmxWit7bC+nmAWDqCtHjGUNXtOgvTTA/qDqxaYEq3DlyE+hI13556Tg==
X-Received: by 2002:a05:6808:3a10:b0:3ae:bae2:fa76 with SMTP id gr16-20020a0568083a1000b003aebae2fa76mr10473632oib.36.1700423323924;
        Sun, 19 Nov 2023 11:48:43 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:43 -0800 (PST)
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
Subject: [PATCH 13/24] swap: simplify swap_cache_get_folio
Date:   Mon, 20 Nov 2023 03:47:29 +0800
Message-ID: <20231119194740.94101-14-ryncsn@gmail.com>
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

Rearrange the if statement, reduce the code indent, no feature change.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 58 ++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 91461e26a8cc..3b5a34f47192 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -336,41 +336,39 @@ static inline bool swap_use_vma_readahead(struct swap_info_struct *si)
  */
 struct folio *swap_cache_get_folio(swp_entry_t entry, struct vm_fault *vmf)
 {
+	bool vma_ra, readahead;
 	struct folio *folio;
 
 	folio = filemap_get_folio(swap_address_space(entry), swp_offset(entry));
-	if (!IS_ERR(folio)) {
-		bool vma_ra = swap_use_vma_readahead(swp_swap_info(entry));
-		bool readahead;
+	if (IS_ERR(folio))
+		return NULL;
 
-		/*
-		 * At the moment, we don't support PG_readahead for anon THP
-		 * so let's bail out rather than confusing the readahead stat.
-		 */
-		if (unlikely(folio_test_large(folio)))
-			return folio;
-
-		readahead = folio_test_clear_readahead(folio);
-		if (vmf && vma_ra) {
-			unsigned long ra_val;
-			int win, hits;
-
-			ra_val = GET_SWAP_RA_VAL(vmf->vma);
-			win = SWAP_RA_WIN(ra_val);
-			hits = SWAP_RA_HITS(ra_val);
-			if (readahead)
-				hits = min_t(int, hits + 1, SWAP_RA_HITS_MAX);
-			atomic_long_set(&vmf->vma->swap_readahead_info,
-					SWAP_RA_VAL(vmf->address, win, hits));
-		}
+	/*
+	 * At the moment, we don't support PG_readahead for anon THP
+	 * so let's bail out rather than confusing the readahead stat.
+	 */
+	if (unlikely(folio_test_large(folio)))
+		return folio;
 
-		if (readahead) {
-			count_vm_event(SWAP_RA_HIT);
-			if (!vmf || !vma_ra)
-				atomic_inc(&swapin_readahead_hits);
-		}
-	} else {
-		folio = NULL;
+	vma_ra = swap_use_vma_readahead(swp_swap_info(entry));
+	readahead = folio_test_clear_readahead(folio);
+	if (vmf && vma_ra) {
+		unsigned long ra_val;
+		int win, hits;
+
+		ra_val = GET_SWAP_RA_VAL(vmf->vma);
+		win = SWAP_RA_WIN(ra_val);
+		hits = SWAP_RA_HITS(ra_val);
+		if (readahead)
+			hits = min_t(int, hits + 1, SWAP_RA_HITS_MAX);
+		atomic_long_set(&vmf->vma->swap_readahead_info,
+				SWAP_RA_VAL(vmf->address, win, hits));
+	}
+
+	if (readahead) {
+		count_vm_event(SWAP_RA_HIT);
+		if (!vmf || !vma_ra)
+			atomic_inc(&swapin_readahead_hits);
 	}
 
 	return folio;
-- 
2.42.0

