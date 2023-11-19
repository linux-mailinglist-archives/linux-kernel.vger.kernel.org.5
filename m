Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D2F7F088F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjKSTsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjKSTsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:48:43 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80435D45
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:28 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6b2018a11efso3881298b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423308; x=1701028108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Iv3a0RkKO4tJSHfzH299Wh8nqjqW5sZox/cVI//TM8=;
        b=TfQ3+1EvjgS8cNADoaSCxk1RMNz27Q2YIcqO8OiMF+oW9o0ikJ4nXGGF17AzeDFaa6
         +rWmHBxTqxHuzPbIb1SfZtZUkixsBU9pPq1b59jlXNSlLaoKb9ISAZp/30pcLNazFK0h
         Mzo9AuYMrTf3wUQY1N7urp2LElyKDZfpORxu8Sa5TmHgaAexu3qwL8NjKu5wIcZ4jUvL
         TatZNoDWnmYQgjj5DvaKgj8pyELvBLE+3S8LnH+ekrOZ6b7Cgm52gSovQnFyZzuB2C2C
         Dt2o/aLSbXnT6Hzg9gsLIOGDnbCfQtoiOe5IOTIY6VP3SlpOeRwgXV03oqLctxfRmkbM
         zX4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423308; x=1701028108;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Iv3a0RkKO4tJSHfzH299Wh8nqjqW5sZox/cVI//TM8=;
        b=L0zmYDNp9ECwyGOlZsqUalZlHeFv/vjnAwAnza7DmLpXKGYBlphM4gfGujoie5/Tmk
         zWwQl988sdHCocDK1iGCXQetjnkEdocewxexKgek6ftduSVthZy7G5YhXVq8k/FbWPOi
         IbgOCMKNYpXxU7Wbn5oi5ocSmHuy1QHMoyjqeo/LBip/HHDLtDUhyD0FjFdKiu68Dq30
         j+9EUQa0vjFmyMBJwcTDE2QIZMK+ulzaNAHYLBtv8Ee0BrTPc0t64I11j8n2BW4ygtq5
         HUSu3BAcZ1R1cFPDzrHZQwgq5auoTlsrV+jtEsrj35RLhQ/fOmu+JFIoOETFPskxJ64F
         lbTg==
X-Gm-Message-State: AOJu0YzKjU+vKJ/uT5mvPnqbcEpxQy7zsjcJ+R1VqK7SKwqh34czLLlx
        7/o3qmrVKV39/Vi8YU0F/3U=
X-Google-Smtp-Source: AGHT+IHOC/pH4egukb5+EX3DwlCGnZ4HWVCMhNwTp5WbUoyceBak2FygNQZocPIPIHn77Rx48Jh+bw==
X-Received: by 2002:a05:6a20:3d84:b0:17b:426f:829 with SMTP id s4-20020a056a203d8400b0017b426f0829mr7488318pzi.37.1700423307883;
        Sun, 19 Nov 2023 11:48:27 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:27 -0800 (PST)
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
Subject: [PATCH 08/24] mm/swap: check readahead policy per entry
Date:   Mon, 20 Nov 2023 03:47:24 +0800
Message-ID: <20231119194740.94101-9-ryncsn@gmail.com>
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

Currently VMA readahead is globally disabled when any rotate disk is
used as swap backend. So multiple swap devices are enabled, if a slower
hard disk is set as a low priority fallback, and a high performance SSD
is used and high priority swap device, vma readahead is disabled globally.
The SSD swap device performance will drop by a lot.

Check readahead policy per entry to avoid such problem.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index ff6756f2e8e4..fb78f7f18ed7 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -321,9 +321,9 @@ static inline bool swap_use_no_readahead(struct swap_info_struct *si, swp_entry_
 	return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_count(entry) == 1;
 }
 
-static inline bool swap_use_vma_readahead(void)
+static inline bool swap_use_vma_readahead(struct swap_info_struct *si)
 {
-	return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotate_swap);
+	return data_race(si->flags & SWP_SOLIDSTATE) && READ_ONCE(enable_vma_readahead);
 }
 
 /*
@@ -341,7 +341,7 @@ struct folio *swap_cache_get_folio(swp_entry_t entry,
 
 	folio = filemap_get_folio(swap_address_space(entry), swp_offset(entry));
 	if (!IS_ERR(folio)) {
-		bool vma_ra = swap_use_vma_readahead();
+		bool vma_ra = swap_use_vma_readahead(swp_swap_info(entry));
 		bool readahead;
 
 		/*
@@ -920,16 +920,18 @@ static struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
 struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 			      struct vm_fault *vmf, bool *swapcached)
 {
+	struct swap_info_struct *si;
 	struct mempolicy *mpol;
 	struct page *page;
 	pgoff_t ilx;
 	bool cached;
 
+	si = swp_swap_info(entry);
 	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
-	if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
+	if (swap_use_no_readahead(si, entry)) {
 		page = swapin_no_readahead(entry, gfp_mask, mpol, ilx, vmf->vma->vm_mm);
 		cached = false;
-	} else if (swap_use_vma_readahead()) {
+	} else if (swap_use_vma_readahead(si)) {
 		page = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
 		cached = true;
 	} else {
-- 
2.42.0

