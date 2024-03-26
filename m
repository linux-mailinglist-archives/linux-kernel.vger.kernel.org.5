Return-Path: <linux-kernel+bounces-119745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F60788CCA2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9077C1C63569
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F6A13CC50;
	Tue, 26 Mar 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOEY81nE"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4813CF8E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479872; cv=none; b=eE8zrlCklnCkzOLcbn/6wvZv9k+gT94MA2WcTnWP0gV/kiEQI0QWNevXSVHxADNyEgE9oRa+BNrzgcgTacZ2+75kMGs+I8AMeEGxLIxvpKal+Ys4VB+EfBWQOsddXK8MBsjmxDKH4edubJLgjDDB/98T52TJAuwX84f3W5bMywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479872; c=relaxed/simple;
	bh=gqfTmePSIYhjIm5j4qfpQ0dAqx5g46WOKwctYRNdYOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwzQpoW+AHnZlLHR8AbRfqDEpiCYuNBNx9zwlnKbPAmNT7Q9H07E4gDmVNnQHMVmWR6W3PuXQyT8Tp83jlW/O3VOSZApUXXPaOzbxors1ub0Fqo3ymX4/ZU/uE0b5khXx+h0PEsDq2U1AtqxBtTISBc6eo7ND7/Ptyyilwi5qi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOEY81nE; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso3366929a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711479870; x=1712084670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TEv2cY48RN4zMeEfANN3o0TZbotXcFB0DQsGIzjU7dM=;
        b=HOEY81nEpvbkfMQhF3Apfd0MSf8NZFUbDlZfU/f8S2PvoyAhGCc7xVg/NjSaL1NjN/
         NwySQ9uP090toDp6fgXJRcdDor7fNmU8g0IiRFsoL/Zk+vCP4bTj5n6mSnOuwUcUwaJg
         cI6211yfko0lphlNFVJJk3yHKIZlabq8xSWsDAsgdasVt1aUF+ItsEqFpG4DA+S009bV
         4y6A7qwkyl+gmWzHjVFyzTCT5DI86DuTkI/xhN1a8nrYzgEROFxoVh/VuO8wi6GnYtK7
         pmWlQTElMGKngwmnHJo9tTuvUqv1cGdyTIPW3g6e1ZJT4/VYJO9kNFurCi0VcrEofeu4
         cvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479870; x=1712084670;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TEv2cY48RN4zMeEfANN3o0TZbotXcFB0DQsGIzjU7dM=;
        b=dyPTlScG3ubp/L3NtpNUXAiuzhjk806NyZ6tPJAxsPOJ7g+oYya7SjyElcU0Iv2tRP
         Hdp+/b6RYCseXPaTtmLKcYDLT0hUZFIKxTXODqLl3cQydpsrSDV551qRoIwqD9t5TsA9
         L0EbYJhhaZG53GhHQEDluOL/8dzkQ5cz+bA/OVUnTwBn874a2FesmQNlyrJdKnPjRHOd
         10l9QWvTJrzgO+YkPfcg/T9NTokND9AGdn4yfKBOEpHLmGs5pa6G5Q/sQraHPbRsKXo2
         TMFdx2Ecb5ub6LIw1nCUDgZkOzRkCOi2C14Hqn0ltMQPGuB0tfRBpWmkkGPV3G0QLnev
         8GfA==
X-Forwarded-Encrypted: i=1; AJvYcCU0C7zbzCFmLNEerfllpsach9Bg3tB121pJnSGokaYbv6YoWNYgDKMtMAxgsJFHGwVGrBrA4/OmF573GgnRwFP0qpZ76mjd5G7+qbvE
X-Gm-Message-State: AOJu0Yxpyhnr8FgwSdDTk3rI4Evj6oNrU8hwYzmaNPnaXCQRRL6dCRpB
	uYeg5SNWimyceSQ6uuOWGMLYwQmLXfaESxg4i/6Ail3hPetC56QE
X-Google-Smtp-Source: AGHT+IEzVu/grUxN8VT3A2w/EHOVk9Am7cvRif7ZTTWBWxDgt7/3PIqhlTfiumnGRYgPCPyofkcdEA==
X-Received: by 2002:a05:6a21:398c:b0:1a3:dcdf:13cf with SMTP id ad12-20020a056a21398c00b001a3dcdf13cfmr2102446pzc.56.1711479869865;
        Tue, 26 Mar 2024 12:04:29 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id j14-20020aa783ce000000b006ea790c2232sm6298350pfn.79.2024.03.26.12.04.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Mar 2024 12:04:29 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: "Huang, Ying" <ying.huang@intel.com>,
	Chris Li <chrisl@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yu Zhao <yuzhao@google.com>,
	SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 03/10] mm/swap: convert swapin_readahead to return a folio
Date: Wed, 27 Mar 2024 02:50:25 +0800
Message-ID: <20240326185032.72159-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326185032.72159-1-ryncsn@gmail.com>
References: <20240326185032.72159-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Simplify the caller code logic.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     | 8 +++-----
 mm/swap.h       | 4 ++--
 mm/swap_state.c | 6 ++----
 mm/swapfile.c   | 5 +----
 4 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index e42fadc25268..dfdb620a9123 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4005,12 +4005,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			if (PTR_ERR(folio) == -EBUSY)
 				goto out;
 			need_clear_cache = true;
-			page = &folio->page;
 		} else {
-			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
-						vmf);
-			if (page)
-				folio = page_folio(page);
+			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, vmf);
 			swapcache = folio;
 		}
 
@@ -4027,6 +4023,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			goto unlock;
 		}
 
+		page = folio_file_page(folio, swp_offset(entry));
+
 		/* Had to read the page from swap area: Major fault */
 		ret = VM_FAULT_MAJOR;
 		count_vm_event(PGMAJFAULT);
diff --git a/mm/swap.h b/mm/swap.h
index 40e902812cc5..aee134907a70 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -57,7 +57,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
 struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
 			    struct vm_fault *vmf);
-struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
+struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
 			      struct vm_fault *vmf);
 
 static inline unsigned int folio_swap_flags(struct folio *folio)
@@ -95,7 +95,7 @@ static inline struct folio *swapin_direct(swp_entry_t entry, gfp_t flag,
 	return NULL;
 }
 
-static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
+static inline struct folio *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
 			struct vm_fault *vmf)
 {
 	return NULL;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 0a3fa48b3893..2a9c6bdff5ea 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -951,7 +951,7 @@ struct folio *swapin_direct(swp_entry_t entry, gfp_t gfp_mask,
  * it will read ahead blocks by cluster-based(ie, physical disk based)
  * or vma-based(ie, virtual address based on faulty address) readahead.
  */
-struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
+struct folio *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 				struct vm_fault *vmf)
 {
 	struct mempolicy *mpol;
@@ -964,9 +964,7 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
 	mpol_cond_put(mpol);
 
-	if (!folio)
-		return NULL;
-	return folio_file_page(folio, swp_offset(entry));
+	return folio;
 }
 
 #ifdef CONFIG_SYSFS
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4919423cce76..4dd894395a0f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1883,7 +1883,6 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 		folio = swap_cache_get_folio(entry, vma, addr);
 		if (!folio) {
-			struct page *page;
 			struct vm_fault vmf = {
 				.vma = vma,
 				.address = addr,
@@ -1891,10 +1890,8 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 				.pmd = pmd,
 			};
 
-			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
+			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
 						&vmf);
-			if (page)
-				folio = page_folio(page);
 		}
 		if (!folio) {
 			swp_count = READ_ONCE(si->swap_map[offset]);
-- 
2.43.0


