Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA297F088B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjKSTsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKSTsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:48:20 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EDED5D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:15 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6ce2cf67be2so2082085a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423295; x=1701028095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xjzoOYVfaQZliXw2umUqNXWj2wEYGvE1fLa1+gbge5g=;
        b=IusQLIKDW1ybycdFgJM22Bx23qUm7uOyWwwZrWxeWOz54H0+166QH1cupFkrJ7z3qU
         PKVbvp8SDoKUR63g3SMFujLfAAB0PkeY7X/R0ugnhUve16dPomwhOgnL8eZjHl7nFOxo
         McGvs6UkJCeQ5zdZBZLBdIdu770XpqgpoqREtIcC77A/Q/A6an29HV7BEXk6J+/BLmTC
         VkH+s4IpSReoXwzBFlgK4wcThRzXOgmucaS/agfqEUVQxrvL29D8wJ7p4jiTRRy8ylNK
         7VeOoXaKKnQiT2xHZpcgSbwxJvE69Ena15wcbOkK6o6vmoIDXJYe9vL7hxcczurKFa1+
         yrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423295; x=1701028095;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjzoOYVfaQZliXw2umUqNXWj2wEYGvE1fLa1+gbge5g=;
        b=wJgwmfXTB+WolAYtw0dtjmnvzSbO+Ua/M2C6WUk7NtFGmUUl5pk8z/YlzSCi7hSk6F
         EVYYqOOPTkkMNtIQvQINE2uVEHLx7UQ9JImgD7oHs6ve5VOxJr0waqhcXRRJSfEWcHwe
         fx2KBq5Jl58cKsRz+dTaBlhIf7EhZ2x6RiCx7p+AAc5lf/huaCAnu1XkIZ2fCMhY4IKl
         0t52lkHTa5ZcQJJAdDe3qOgGu9QWGdC3QreuPxDJDOgpWUkDgGpBKRDTXpvI47CZIFPv
         rRO5KLjh5y3V6EynpcRVWLMM49RBh/mn7pcSYF7T1CWznuKBhIdOIY5Lu82eF83SikLZ
         5eww==
X-Gm-Message-State: AOJu0YyTrmwdZDSR+nShLug3Z+4TycM3VtBPe9nhXusLhw0MsEW7hXvm
        RdXm9Ft3YWdKh53ajIMRS3I=
X-Google-Smtp-Source: AGHT+IFQHR1l2ZzyKI4Xa9NdFiIiGKaudZGQta2YkNoMRhm/wHLbj2a5Jpev7P/tpTPzm9ZFNWym6A==
X-Received: by 2002:a05:6870:3b85:b0:1f9:36fe:fd0e with SMTP id gi5-20020a0568703b8500b001f936fefd0emr1616531oab.47.1700423294901;
        Sun, 19 Nov 2023 11:48:14 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:14 -0800 (PST)
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
Subject: [PATCH 04/24] mm/swap: avoid setting page lock bit and doing extra unlock check
Date:   Mon, 20 Nov 2023 03:47:20 +0800
Message-ID: <20231119194740.94101-5-ryncsn@gmail.com>
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

When swapping in a page, mem_cgroup_swapin_charge_folio is called for new
allocated folio, nothing else is referencing the folio so no need to set
the lock bit. This avoided doing unlock check on error path.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index ac4fa404eaa7..45dd8b7c195d 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -458,6 +458,8 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 						mpol, ilx, numa_node_id());
 		if (!folio)
                         goto fail_put_swap;
+		if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mask, entry))
+			goto fail_put_folio;
 
 		/*
 		 * Swap entry may have been freed since our caller observed it.
@@ -483,13 +485,9 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	/*
 	 * The swap entry is ours to swap in. Prepare the new page.
 	 */
-
 	__folio_set_locked(folio);
 	__folio_set_swapbacked(folio);
 
-	if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mask, entry))
-		goto fail_unlock;
-
 	/* May fail (-ENOMEM) if XArray node allocation failed. */
 	if (add_to_swap_cache(folio, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
 		goto fail_unlock;
@@ -510,6 +508,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 fail_unlock:
 	put_swap_folio(folio, entry);
 	folio_unlock(folio);
+fail_put_folio:
 	folio_put(folio);
 fail_put_swap:
 	put_swap_device(si);
@@ -873,16 +872,15 @@ struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
 				vma, vmf->address, false);
 	if (folio) {
-		__folio_set_locked(folio);
-		__folio_set_swapbacked(folio);
-
-		if (mem_cgroup_swapin_charge_folio(folio,
-					vma->vm_mm, GFP_KERNEL,
-					entry)) {
-			folio_unlock(folio);
+		if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
+						   GFP_KERNEL, entry)) {
 			folio_put(folio);
 			return NULL;
 		}
+
+		__folio_set_locked(folio);
+		__folio_set_swapbacked(folio);
+
 		mem_cgroup_swapin_uncharge_swap(entry);
 
 		shadow = get_shadow_from_swap_cache(entry);
-- 
2.42.0

