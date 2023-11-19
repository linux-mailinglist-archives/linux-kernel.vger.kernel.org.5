Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA827F0893
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjKSTtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjKSTtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:49:01 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D16D6E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:41 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6c4cf0aea06so3616039b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423320; x=1701028120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ppA1yq5tSXPW7Cplga4R0sTrIzgEEoc6Te1dihtlR90=;
        b=WSg1wBRpJmuTftOP9HXoBZo5KW4YFAwao7tV1HOTnZUWYybr4Vw5Vtm8iGjBbLHDt2
         rUKfm49N5LoVnKrQIy5c0pHG3t6wT0gAj7cuP6A6ADVwvDxGXFrj31z5JFGjVIg5U5yo
         lB6veVIkWScSgwLVHu02G+rK23A3ex5VL95WJ/x9lhj0CJPwp5p6/R6bmTNYvAPsdOki
         lMK/ho/QlpYtFnndd6ATcsy2Ex/Hprfx77X9Y0zbWKFrWYKJKkSsElGJdJq+yfn+47zO
         TmGadhtt3i17FSs4vnDZilPH4Dc8nQkdCGU/sJZt3ukcEcnC7rkUckv/PQpbFYYhVcxz
         OTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423320; x=1701028120;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ppA1yq5tSXPW7Cplga4R0sTrIzgEEoc6Te1dihtlR90=;
        b=USGLHsPSwhnMNI+myGSlSaTSIYB6Vr2iYkUfedA0UciFpWaoX8AbbbDLeyuuVlu6rp
         lmdRy6NfKpmDsZHGMc70MBb+UEJLmzRnS+iOjBkGQQavmnY9BxXPON06YC8Q7fdOx037
         N2ltz6APhtLpqBk9O8tdEFxjui08584qbIY5RoJY6EmVA7zY0T2OGBa9dBO7wT1G1G6c
         W2B/s1w35CTERmUhdEEqpq5WqNVv4svI6MtedxzSSglXbM5Nz/UJU+9leOBlFc0PFhaC
         0GHGIKDQ6++RhAYMBvU58v+T8bvmAibgixhJu8Mx9v51hy7DQM6Zfoa9ADoqNVyNl1dk
         gfQw==
X-Gm-Message-State: AOJu0Yzj+pwdJRlgqOTS36CH6eTqT4UilA050mB6wrb2aAaXciXwXCDZ
        uijzgzsFF1dVn1kZcJ8XQQ0=
X-Google-Smtp-Source: AGHT+IEBKHSE8kWnJJK8rM1dJTQqf5O5zE26MX7FuQ337U8kKzHMmekWO97Hh8Tc9mKAekA3sDGJiw==
X-Received: by 2002:a05:6a00:1ca9:b0:6cb:a434:b58f with SMTP id y41-20020a056a001ca900b006cba434b58fmr619405pfw.33.1700423320649;
        Sun, 19 Nov 2023 11:48:40 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:40 -0800 (PST)
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
Subject: [PATCH 12/24] mm/swap: simplify arguments for swap_cache_get_folio
Date:   Mon, 20 Nov 2023 03:47:28 +0800
Message-ID: <20231119194740.94101-13-ryncsn@gmail.com>
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

There are only two caller now, simplify the arguments.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c      |  2 +-
 mm/swap.h       |  2 +-
 mm/swap_state.c | 15 +++++++--------
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0d1ce70bce38..72239061c655 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1875,7 +1875,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	}
 
 	/* Look it up and read it in.. */
-	folio = swap_cache_get_folio(swap, NULL, 0);
+	folio = swap_cache_get_folio(swap, NULL);
 	if (!folio) {
 		/* Or update major stats only when swapin succeeds?? */
 		if (fault_type) {
diff --git a/mm/swap.h b/mm/swap.h
index ac9136eee690..e43e965f123f 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -47,7 +47,7 @@ void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
-		struct vm_area_struct *vma, unsigned long addr);
+				   struct vm_fault *vmf);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
 		pgoff_t index);
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index e96d63bf8a22..91461e26a8cc 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -334,8 +334,7 @@ static inline bool swap_use_vma_readahead(struct swap_info_struct *si)
  *
  * Caller must lock the swap device or hold a reference to keep it valid.
  */
-struct folio *swap_cache_get_folio(swp_entry_t entry,
-		struct vm_area_struct *vma, unsigned long addr)
+struct folio *swap_cache_get_folio(swp_entry_t entry, struct vm_fault *vmf)
 {
 	struct folio *folio;
 
@@ -352,22 +351,22 @@ struct folio *swap_cache_get_folio(swp_entry_t entry,
 			return folio;
 
 		readahead = folio_test_clear_readahead(folio);
-		if (vma && vma_ra) {
+		if (vmf && vma_ra) {
 			unsigned long ra_val;
 			int win, hits;
 
-			ra_val = GET_SWAP_RA_VAL(vma);
+			ra_val = GET_SWAP_RA_VAL(vmf->vma);
 			win = SWAP_RA_WIN(ra_val);
 			hits = SWAP_RA_HITS(ra_val);
 			if (readahead)
 				hits = min_t(int, hits + 1, SWAP_RA_HITS_MAX);
-			atomic_long_set(&vma->swap_readahead_info,
-					SWAP_RA_VAL(addr, win, hits));
+			atomic_long_set(&vmf->vma->swap_readahead_info,
+					SWAP_RA_VAL(vmf->address, win, hits));
 		}
 
 		if (readahead) {
 			count_vm_event(SWAP_RA_HIT);
-			if (!vma || !vma_ra)
+			if (!vmf || !vma_ra)
 				atomic_inc(&swapin_readahead_hits);
 		}
 	} else {
@@ -926,7 +925,7 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	struct page *page;
 	pgoff_t ilx;
 
-	folio = swap_cache_get_folio(entry, vmf->vma, vmf->address);
+	folio = swap_cache_get_folio(entry, vmf);
 	if (folio) {
 		page = folio_file_page(folio, swp_offset(entry));
 		cache_result = SWAP_CACHE_HIT;
-- 
2.42.0

