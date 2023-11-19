Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3603F7F08A0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjKSTuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjKSTt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:49:56 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8EE1FC3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:49:13 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7a6774da682so175596139f.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423352; x=1701028152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YaE/AcfmvaBX4nhUPBOl45o2uIqec3EidHpbbgh18/A=;
        b=GMgAGHAGjIC3Ddy0feaX8VCRlLMutjNTDBX5rAcWdVC/FdX7vDfmOhxlW98XyoqPxM
         Mgw8BRbJ+gnw6un1cyxgndjsRWrHGR22bFefYaRmUIIIZBKYCO5HkcUcZN/mS3xmH/u2
         TVHnUCPjFhKhfdy4CUfOhSTO7r0KOV7fAjbIbR/gkU+/OU2V1EGcCgnx+/MDwjL2azmD
         pqlxjlMOoIZnN9mcj9iOsXEWo21ezWM08nYbHt2iUnVCtJd5odLzC2wiRo27iyGVH2mc
         xH85SpjFZtJqOzFdAuMf1R0mDN7hE/LB0iYvnLWE1hZcwZ0pIRbp7G5/zGDuNCYrz/nr
         KJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423352; x=1701028152;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaE/AcfmvaBX4nhUPBOl45o2uIqec3EidHpbbgh18/A=;
        b=MkREllb1Kik/odG9IqVmVxUSa1FOjqfID1SnORrScy44i4Xek/3RiGwFfJS0akUj0L
         7bQ8cuPycHr3Dwva8vBLOSRJUftCuAsAiaBfPiN0nLWaavfpPauuPK0W/X+SRwIFFEYy
         4cna5UJ7UlqwRig2iKk9Z6JbAS5bTJhFkib7ww0TCFPdBzRIMHv4cuQ+orfJK9Vo/1F8
         TltlHM9RIt1+ff8yWX10E06CZny8nVnXL0NDHIBKVgiUqQXOTvJ+LbEUS3PGLRPsKemj
         YdNMXqCUnlqKOG9hUhRLSGUIsaYKWuY+wObJkWfpA2k+ejaRiMAEQgfr1vkcXElmRg3S
         T2Wg==
X-Gm-Message-State: AOJu0YzweVJ338LxHOPIjB0HxjksYt7n6B5jcp172vhrL42BaCNoHdIR
        nqIsX7XZpjV9Mz7gShRarPc=
X-Google-Smtp-Source: AGHT+IGe3yrZIEULCUKtOSeAd+ADt5bek5FOv3ZnPoX4w0FfFxyEh6EumJmpzCHvfJdKyxdaJe+uQA==
X-Received: by 2002:a05:6e02:2607:b0:35a:fae1:1358 with SMTP id by7-20020a056e02260700b0035afae11358mr5301806ilb.12.1700423352719;
        Sun, 19 Nov 2023 11:49:12 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.49.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:49:12 -0800 (PST)
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
Subject: [PATCH 22/24] swap: make swap_cluster_readahead static
Date:   Mon, 20 Nov 2023 03:47:38 +0800
Message-ID: <20231119194740.94101-23-ryncsn@gmail.com>
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

Now there is no caller outside the same file, make it static.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h       | 8 --------
 mm/swap_state.c | 4 ++--
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index 4402970547e7..795a25df87da 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -56,8 +56,6 @@ struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				     struct mempolicy *mpol, pgoff_t ilx,
 				     bool *new_page_allocated);
-struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
-				    struct mempolicy *mpol, pgoff_t ilx);
 struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
 			      struct vm_fault *vmf, enum swap_cache_result *result);
 struct page *swapin_page_non_fault(swp_entry_t entry, gfp_t gfp_mask,
@@ -93,12 +91,6 @@ static inline void show_swap_cache_info(void)
 {
 }
 
-static inline struct page *swap_cluster_readahead(swp_entry_t entry,
-			gfp_t gfp_mask, struct mempolicy *mpol, pgoff_t ilx)
-{
-	return NULL;
-}
-
 static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
 			struct vm_fault *vmf, enum swap_cache_result *result)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 0433a2586c6d..b377e55cb850 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -627,8 +627,8 @@ static unsigned long swapin_nr_pages(unsigned long offset)
  * are used for every page of the readahead: neighbouring pages on swap
  * are fairly likely to have been swapped out from the same node.
  */
-struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
-				    struct mempolicy *mpol, pgoff_t ilx)
+static struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
+					   struct mempolicy *mpol, pgoff_t ilx)
 {
 	struct page *page;
 	unsigned long entry_offset = swp_offset(entry);
-- 
2.42.0

