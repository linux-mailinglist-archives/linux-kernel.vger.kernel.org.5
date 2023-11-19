Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44667F0896
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjKSTtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjKSTtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:49:14 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19686198C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:51 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b6ce6fac81so2425834b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423330; x=1701028130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aDkLnQICnVgpq4/orPONBtwFkKKcmzZtjb3XACAs/tw=;
        b=RXAJrU5+u3NIqZYjCeSgFrmFpHZ/y80OxLUHyDQIEANThnEXlB8Gkpn81diIPTlg0+
         LNxnLDXmDvmkERe656iIzGP7k3hNqIhB6SSi/J9+OKY6c+KWH8oRWIzOBBMJO6wcwlGi
         DRcpDg4ti1nvZUwie9yI3HvBJjdwO6VAIZXFGdNan0Gvmhucnm83P8QjnnhNY+YoEcyM
         Lm9MWaXUevxHsmyQ2IFJUYneVbg48NBUWcJC7amwYWZ7FJPkan8bntgg3v56+ClzdKG0
         +zYvV0F+r2Ow54NGWaxxFozYP+FGEXgysJ6pe93gP/MKf64MMSRXmz+L5Vh/W3FpuXe/
         Fk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423330; x=1701028130;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDkLnQICnVgpq4/orPONBtwFkKKcmzZtjb3XACAs/tw=;
        b=Za39uM4eYlCQfBlWgYJXm5pe9euZPGAWvfjMgc/jRVMV+VX7+m2zGCb0YAQxsZOUmg
         s9EXHErISWWJrZ6fSK7D3RvSnK5pXVEMp5UoQ0ziF+GjMLWb0n9KhnXX73wrf4P89qCv
         zpQ/lJNch9zGDqRX7xtPwR4cXdFdb+alZ71APkYD6+8tStXiT1KDRzR6toUjWvUr4U1N
         +xh5f7KrkfAbV8e4GvbhJexiriJDwLRlxFABc83htJZ1P176sW6tRirkn5rWhVe7CiWP
         brQXhKfpgtCmQOUFe2wATPrX6eg/19ytwhJ9b5yNWwksaXxqUURn/SgIuXeCLz854PY9
         iBVA==
X-Gm-Message-State: AOJu0YxtSdU9Kc5gCbMaSsGWeFkMDgGriAUEhTUlb6OOKfhB8eqyMOej
        i6GdzL0P6gdRYQHSTTpmXd4=
X-Google-Smtp-Source: AGHT+IHnf4WdU+15DFAUt+1f+EUXMBC9sDjxOomJ4RYRSV1AA/+YKlySoWIJz9+C0DlwqbVhK6dXxQ==
X-Received: by 2002:a05:6808:1452:b0:3af:983a:8129 with SMTP id x18-20020a056808145200b003af983a8129mr7743023oiv.53.1700423330257;
        Sun, 19 Nov 2023 11:48:50 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:49 -0800 (PST)
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
Subject: [PATCH 15/24] mm/swap: avoid an duplicated swap cache lookup for SYNCHRONOUS_IO device
Date:   Mon, 20 Nov 2023 03:47:31 +0800
Message-ID: <20231119194740.94101-16-ryncsn@gmail.com>
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

When a xa_value is returned by the cache lookup, keep it to be used
later for workingset refault check instead of doing the looking up again
in swapin_no_readahead.

This does have a side effect of making swapoff also triggers workingset
check, but should be fine since swapoff does effect the workload in many
ways already.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index e057c79fb06f..51de2a0412df 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -872,7 +872,6 @@ static struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
 {
 	struct folio *folio;
 	struct page *page;
-	void *shadow = NULL;
 
 	page = alloc_pages_mpol(gfp_mask, 0, mpol, ilx, numa_node_id());
 	folio = (struct folio *)page;
@@ -888,10 +887,6 @@ static struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
 
 		mem_cgroup_swapin_uncharge_swap(entry);
 
-		shadow = get_shadow_from_swap_cache(entry);
-		if (shadow)
-			workingset_refault(folio, shadow);
-
 		folio_add_lru(folio);
 
 		/* To provide entry to swap_readpage() */
@@ -922,11 +917,12 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	enum swap_cache_result cache_result;
 	struct swap_info_struct *si;
 	struct mempolicy *mpol;
+	void *shadow = NULL;
 	struct folio *folio;
 	struct page *page;
 	pgoff_t ilx;
 
-	folio = swap_cache_get_folio(entry, vmf, NULL);
+	folio = swap_cache_get_folio(entry, vmf, &shadow);
 	if (folio) {
 		page = folio_file_page(folio, swp_offset(entry));
 		cache_result = SWAP_CACHE_HIT;
@@ -938,6 +934,8 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	if (swap_use_no_readahead(si, swp_offset(entry))) {
 		page = swapin_no_readahead(entry, gfp_mask, mpol, ilx, vmf->vma->vm_mm);
 		cache_result = SWAP_CACHE_BYPASS;
+		if (shadow)
+			workingset_refault(page_folio(page), shadow);
 	} else if (swap_use_vma_readahead(si)) {
 		page = swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf);
 		cache_result = SWAP_CACHE_MISS;
-- 
2.42.0

