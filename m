Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6367F0890
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjKSTs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjKSTsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:48:46 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BEBD4F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:31 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2840780a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423311; x=1701028111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7ikH9nPhVAiKzaSXcyZub9ryWf7e3smOr0BN4n2CRJU=;
        b=Qs3l1A/9czxQrrdc1WwtlfYX4eberyGOUowS2hKfGCiHaDX6SpF+9XAVYMsAvTs/eU
         Pd3l5wy9As8VQTpSIPuZdkKWG9+yqXZTpceiKeVQ9sjh55U5v3rN2Tbra7DdMreB/qTR
         IiwAa9BgqJxCNY181WuTdRe/kguYEsgBO/x8rorQ2z/mPQxQPqn4eAn2sELpMyhZaZ6k
         kdR+9ZPCcnsDL0gGRCxcTQ6s0EKe/+KZwqhqPaIK3fRzphTCTBpV5yRtqNsIbToe5/C9
         KBT+IyMs7LZBA+KyWtMXLMwj/pWltTgRzM+cOP4mmVmPuCOkFB95skafO/E+GPoZ2Q1v
         IH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423311; x=1701028111;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ikH9nPhVAiKzaSXcyZub9ryWf7e3smOr0BN4n2CRJU=;
        b=IyhZVIjjmFIGJk+0rKEOo4vSwX5WxhwYS7TNtiIavRfNkAg585rcVl77FN6/Bc2VHt
         JaTe7LXM6QtA1flosLnMBd6OuYEp8U/ZJnfPEGQB3ZTslKz2ngX/iotB/dZfEXLGz8EU
         71/wfpH187IHm3fVcO2cF/G/fVBGHnm6EHOZ8IWeoVUuUfVBeQ7LfZAo8kqJac2nDE+g
         8PzVJ3uHTrRHhbmyyJmsouuwMUthJULYGHOoUA2C0zGNm0yi3YMyaQ40cxC3xOI/kran
         i8UBxjnatQPWJv6/izHSh0l8lVpY50AsB5282NSEyNUnsq0yUYFX9iO15IxKGJatVaA2
         D8Ng==
X-Gm-Message-State: AOJu0YwAdpKS9Lpn1DLn7ROlCJt4vQNnMG34rc5MSMGULL6kpQ9wQC8T
        bDsT+wMx37yLHcfZrrYGZm8=
X-Google-Smtp-Source: AGHT+IH1zxFvtExW3yVn2ffiwyDes1ojQa3pxYWmcyzSBulOiTzqABkc4AI7t2dHHB2qRMn2sfkZdw==
X-Received: by 2002:a05:6a20:552a:b0:188:1125:88bd with SMTP id ko42-20020a056a20552a00b00188112588bdmr6787703pzb.43.1700423311039;
        Sun, 19 Nov 2023 11:48:31 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:30 -0800 (PST)
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
Subject: [PATCH 09/24] mm/swap: inline __swap_count
Date:   Mon, 20 Nov 2023 03:47:25 +0800
Message-ID: <20231119194740.94101-10-ryncsn@gmail.com>
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

There is only one caller in swap subsystem now, where it can be inline
smoothly, avoid the memory access and function call overheads.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h | 6 ------
 mm/swap_state.c      | 6 +++---
 mm/swapfile.c        | 8 --------
 3 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2401990d954d..64a37819a9b3 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -485,7 +485,6 @@ int swap_type_of(dev_t device, sector_t offset);
 int find_first_swap(dev_t *device);
 extern unsigned int count_swap_pages(int, int);
 extern sector_t swapdev_block(int, pgoff_t);
-extern int __swap_count(swp_entry_t entry);
 extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry);
 extern int swp_swapcount(swp_entry_t entry);
 extern struct swap_info_struct *page_swap_info(struct page *);
@@ -559,11 +558,6 @@ static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
 {
 }
 
-static inline int __swap_count(swp_entry_t entry)
-{
-	return 0;
-}
-
 static inline int swap_swapcount(struct swap_info_struct *si, swp_entry_t entry)
 {
 	return 0;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index fb78f7f18ed7..d87c20f9f7ec 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -316,9 +316,9 @@ void free_pages_and_swap_cache(struct encoded_page **pages, int nr)
 	release_pages(pages, nr);
 }
 
-static inline bool swap_use_no_readahead(struct swap_info_struct *si, swp_entry_t entry)
+static inline bool swap_use_no_readahead(struct swap_info_struct *si, pgoff_t offset)
 {
-	return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_count(entry) == 1;
+	return data_race(si->flags & SWP_SYNCHRONOUS_IO) && swap_count(si->swap_map[offset]) == 1;
 }
 
 static inline bool swap_use_vma_readahead(struct swap_info_struct *si)
@@ -928,7 +928,7 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 
 	si = swp_swap_info(entry);
 	mpol = get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
-	if (swap_use_no_readahead(si, entry)) {
+	if (swap_use_no_readahead(si, swp_offset(entry))) {
 		page = swapin_no_readahead(entry, gfp_mask, mpol, ilx, vmf->vma->vm_mm);
 		cached = false;
 	} else if (swap_use_vma_readahead(si)) {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a8ae472ed2b6..e15a6c464a38 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1431,14 +1431,6 @@ void swapcache_free_entries(swp_entry_t *entries, int n)
 		spin_unlock(&p->lock);
 }
 
-int __swap_count(swp_entry_t entry)
-{
-	struct swap_info_struct *si = swp_swap_info(entry);
-	pgoff_t offset = swp_offset(entry);
-
-	return swap_count(si->swap_map[offset]);
-}
-
 /*
  * How many references to @entry are currently swapped out?
  * This does not give an exact answer when swap count is continued,
-- 
2.42.0

