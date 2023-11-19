Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3165E7F089A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjKSTty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjKSTt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:49:28 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8600D19A2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:57 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c115026985so3870297b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700423337; x=1701028137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FCPW0dI33gWre1bmPp4wG3A/kpp2Dtpn+fZQd/yP8/o=;
        b=kb+kvJTuqgPIZdsg4KJJjy4Vh03F0rOOeZzSaU+peAxitPCQ0MWo9ABfEVs7rZwyfS
         z31d/fxAwEsdIqbjZigitUmP9kWKcjX+K7kvGXrk+fb5YgU8iRigF+GxYXaKWB9SfiOQ
         o1TE0qSQmYaTMuuPz62JyWBVG5Lt7KoaU0BiaG0w3fXdqFmbMohiTWl3FQD7v91bOdev
         F3ujCKuGqWI5jqzdWoXJY6fHyQJlfyOqEP4nTHU21LO6fAwJZxQuzqMnsXdpd3HNCroY
         W7dC4sMoYYvi+BDePxgluzFC8G5PJ8JxxGPsDNhg14Snar4a8rukXcTwGxz9wwFLh9aM
         USlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700423337; x=1701028137;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FCPW0dI33gWre1bmPp4wG3A/kpp2Dtpn+fZQd/yP8/o=;
        b=ghxlr0cmFUU6IM9BG3A5q1d1ZbEsQ8uQuAWia1HdXcXoZc5CO4csurkVoQc0KuMNJV
         +I7ok0PGWjwDJCxQilEj2atfxeOrowANrzkvGS7rEnkcfKOnA8aN4zDTcdlB4kG3xTlj
         o1Qd44hoRUtsnjwAIDxnecYTAWTt8+fYajUXG7u48TM/LOEs7QvghKwPD4JF0f4yBt/L
         VS4V5hvvkZWBsj0S/6lw0szRhnqJZBDtds5paY2CcJDyA5TL5p26NMq6Bb7AO6zxnXEG
         oE2UBF0MfSyTtiHK4K+4MhGE4sX1/m2wfEVyjU2EUOnk7Oz1QdHeLYxYBX1gAYWDORLN
         SPbg==
X-Gm-Message-State: AOJu0YyCwTVLjsMQOax9N3n0KiqcN4EagWRPhLyxNv+I3WTA4bWHK8Pf
        SL76K+Zj9t6UHxzVfsO9T7s=
X-Google-Smtp-Source: AGHT+IF9QoAWouGwWEXuyCQ9NU0AgZDxQWALIyGpxr9BM9RgNBGPUMqyqjGgp7YBTc1CUFiZCcylkA==
X-Received: by 2002:a05:6a20:244e:b0:187:f23d:f9f2 with SMTP id t14-20020a056a20244e00b00187f23df9f2mr6715469pzc.58.1700423336700;
        Sun, 19 Nov 2023 11:48:56 -0800 (PST)
Received: from KASONG-MB2.tencent.com ([115.171.40.79])
        by smtp.gmail.com with ESMTPSA id a6-20020aa78646000000b006cb7feae74fsm1237140pfo.164.2023.11.19.11.48.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 11:48:56 -0800 (PST)
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
Subject: [PATCH 17/24] mm/swap: fix false error when swapoff race with swapin
Date:   Mon, 20 Nov 2023 03:47:33 +0800
Message-ID: <20231119194740.94101-18-ryncsn@gmail.com>
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

When swapoff race with swapin, get_swap_device may fail and cause
swapin_readahead to return -EBUSY. In such case check if the page is
already swapped in by swapoff path.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index e399b37ef395..620fa87557fd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3846,9 +3846,21 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 	page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
 				vmf, &cache_result);
-	if (PTR_ERR(page) == -EBUSY) {
-		goto out;
-	} else if (page) {
+	if (IS_ERR_OR_NULL(page)) {
+		/*
+		 * Back out if somebody else faulted in this pte
+		 * while we released the pte lock.
+		 */
+		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
+				vmf->address, &vmf->ptl);
+		if (likely(vmf->pte && pte_same(ptep_get(vmf->pte), vmf->orig_pte))) {
+			if (!page)
+				ret = VM_FAULT_OOM;
+			else
+				ret = VM_FAULT_RETRY;
+		}
+		goto unlock;
+	} else {
 		folio = page_folio(page);
 		if (cache_result != SWAP_CACHE_HIT) {
 			/* Had to read the page from swap area: Major fault */
@@ -3866,17 +3878,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			ret = VM_FAULT_HWPOISON;
 			goto out_release;
 		}
-	} else {
-		/*
-		 * Back out if somebody else faulted in this pte
-		 * while we released the pte lock.
-		 */
-		vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
-				vmf->address, &vmf->ptl);
-		if (likely(vmf->pte &&
-			   pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
-			ret = VM_FAULT_OOM;
-		goto unlock;
 	}
 
 	ret |= folio_lock_or_retry(folio, vmf);
-- 
2.42.0

