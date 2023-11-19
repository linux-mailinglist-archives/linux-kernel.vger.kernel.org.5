Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2FE7F0895
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjKSTtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjKSTtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:49:11 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CCD10F9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:47 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6c10f098a27so2928347b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423327; x=1701028127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VCznjXM2MgFt7+7dcBajlWUiOZC/KHYcLFwrnZNwV5s=;
        b=OL7qQYlbB8hZlxpYO7qV2qBGwlsMJgdoEyrmUmaQqxtNVB9rDAhwZdFWAhlve4OSi9
         /t7H1ppiyiZZMaIS8lSi8TZwTSJmtNfeFvwPwN4xtFw+Lb6Pw6MAP8VZGobsgNW2HqOe
         qXkiXd0BFvibp25yOSFpiVT46xVrwUvPv6Qpl5iVMOeQDhJ8khrvCnYI6DI5qWalOehl
         X8H/Ys4Dhip8B5X9NfpvXcw+v/NJXh5Nknrpxfhgrmqfen8w0TBjrbc9TKyOl2MqTNGF
         lIxALhuVLsXL0xlnv7wO+q0cXsd2Dh3xLmtCewkTyGRY5E8MFX2vpKanUPsJ7gTEWbIs
         UYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423327; x=1701028127;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCznjXM2MgFt7+7dcBajlWUiOZC/KHYcLFwrnZNwV5s=;
        b=sG3CPKfP3eyDZGu/L8xdIP8hq7wFPwZ2gmbT4pkStfDstUN3WuOdx0iS/65yz/P8v3
         TDJYLvrvFVD8Kjup1RMwVH+BN1UcacIsQeZFmZc59mvusQsSoa4dTGr4o2mTPohZYRD5
         FCFIxUCGghR0oDECMS2eldHmN6o71Jzv1kZB7yPRY1cmpjyY8gFgADakXLY/pl5g7/gB
         9Xjzg3RjCC+z1j74theCD1SNeF0VDGqqND44ft9QG02orMzrm7UpQAHJp4ozsX7/pjqS
         8wuFOcBd/2HVRNskt6N4DypObx7AfR00x5/AWkW9QMNY6ZcOAkuyh6kI1d4veQ3styRb
         cPGQ==
X-Gm-Message-State: AOJu0YxJ7CSMlf9tUryB+FhQrhJouHhghqsYE0DFRWfxAgeLa3gefD2q
        3nzG1eScsT6x5ymjL3SnZVw=
X-Google-Smtp-Source: AGHT+IGzuAUevQ1XHN3DEflD4nhrPqC3JAr2xo9JJHGah1/1WAAz1GSa8PG8e1ODtV8IMaqzQtkuzA==
X-Received: by 2002:a05:6a20:6a1a:b0:189:df1b:6616 with SMTP id p26-20020a056a206a1a00b00189df1b6616mr3107739pzk.15.1700423327040;
        Sun, 19 Nov 2023 11:48:47 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:46 -0800 (PST)
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
Subject: [PATCH 14/24] mm/swap: do shadow lookup as well when doing swap cache lookup
Date:   Mon, 20 Nov 2023 03:47:30 +0800
Message-ID: <20231119194740.94101-15-ryncsn@gmail.com>
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

Make swap_cache_get_folio capable of returning the shadow value when the
xarray contains a shadow instead of a valid folio. Just extend the
arguments to be used later.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/shmem.c      |  2 +-
 mm/swap.h       |  2 +-
 mm/swap_state.c | 11 +++++++----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 72239061c655..f9ce4067c742 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1875,7 +1875,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	}
 
 	/* Look it up and read it in.. */
-	folio = swap_cache_get_folio(swap, NULL);
+	folio = swap_cache_get_folio(swap, NULL, NULL);
 	if (!folio) {
 		/* Or update major stats only when swapin succeeds?? */
 		if (fault_type) {
diff --git a/mm/swap.h b/mm/swap.h
index e43e965f123f..da9deb5ba37d 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -47,7 +47,7 @@ void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
 				  unsigned long end);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
-				   struct vm_fault *vmf);
+				   struct vm_fault *vmf, void **shadowp);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
 		pgoff_t index);
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 3b5a34f47192..e057c79fb06f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -334,14 +334,17 @@ static inline bool swap_use_vma_readahead(struct swap_info_struct *si)
  *
  * Caller must lock the swap device or hold a reference to keep it valid.
  */
-struct folio *swap_cache_get_folio(swp_entry_t entry, struct vm_fault *vmf)
+struct folio *swap_cache_get_folio(swp_entry_t entry, struct vm_fault *vmf, void **shadowp)
 {
 	bool vma_ra, readahead;
 	struct folio *folio;
 
-	folio = filemap_get_folio(swap_address_space(entry), swp_offset(entry));
-	if (IS_ERR(folio))
+	folio = filemap_get_entry(swap_address_space(entry), swp_offset(entry));
+	if (xa_is_value(folio)) {
+		if (shadowp)
+			*shadowp = folio;
 		return NULL;
+	}
 
 	/*
 	 * At the moment, we don't support PG_readahead for anon THP
@@ -923,7 +926,7 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	struct page *page;
 	pgoff_t ilx;
 
-	folio = swap_cache_get_folio(entry, vmf);
+	folio = swap_cache_get_folio(entry, vmf, NULL);
 	if (folio) {
 		page = folio_file_page(folio, swp_offset(entry));
 		cache_result = SWAP_CACHE_HIT;
-- 
2.42.0

