Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97F5764153
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 23:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGZVmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 17:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjGZVml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:42:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39712703
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:42:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so29435e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690407753; x=1691012553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fA0Me8OSweYBjKfTeTvzrSFKTXO3COLTBAEvIA2gZco=;
        b=OYnxtY0lQuP4YPlQRqAUmtP3RMc8pfaHk2NfnpSIoIDi3PjLr3leyZSzd22GI5ecos
         mJGI5GscwkBgXyl1qaCtnGOD6nGS8VhZlwTm7slBxueZ7gebzjedpmw5tqTiTsjehOoH
         Ul10KCReJXIFOQDkUF3nK9lHTP73ydkyGa3oczkh6hHDJUJUFTW4NtSwqL755G+L7ogJ
         0pHiJN+lx1hAwE6Afno47y5K6cX6udQIoua2oBuZwj0UtPD3gpCL3pIbuK7iEwOFnQfB
         xbzmbJ8VbPBQzMiYyZgC2E82sr+gqgGMe4e6lRAyf5cWPva1AHCgsQtO+mkAwhHyaF/r
         o2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690407753; x=1691012553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fA0Me8OSweYBjKfTeTvzrSFKTXO3COLTBAEvIA2gZco=;
        b=l98w/rcfVn7u5wJcsCJG0wVJ6OEmm5H/poM2AELD3CFPDR0N7Opxg7tiPbPBqypp/I
         Ax+iEOCFMEIpkTgT34I0X8ETHR2PmefBnwOJBJ7OOfS1/ysWNvb2uf9Vl/IGLK6kJ5hN
         VpTgbDnCdPJI5ptWYXsveakBYHNZgjQnbVT88Pvptm//6xsvP2tmjm4PAvacm9lMH2cK
         PlqcL3XSToW2A/Hp2uH9gDyc2vJiHXdiPPJh7LmOz7I4129IkxqaiTpEmWmr3i0F1DhI
         ZtHql/23IQmDpASF4+LUe7Eeo6NeAVHsSbxV0G338XOoT84fSgyfnvL7TIZ4D/aOmG0R
         uKKg==
X-Gm-Message-State: ABy/qLZNN7Vk7LXr/pcIOuDfSA1sVsMjpeCCWkaUJUHhQbEoAJypMBIs
        XsYiG3WAW01xKppaGEAZ1Br4rw==
X-Google-Smtp-Source: APBJJlF6Dq7xoEActnF1/g/rKskCj63rlqpHc/U+0oCDlz+EnM06XrCK1OzzM/6uuxJknTayVYMmaA==
X-Received: by 2002:a05:600c:829:b0:3f1:6fe9:4a95 with SMTP id k41-20020a05600c082900b003f16fe94a95mr23971wmp.4.1690407753151;
        Wed, 26 Jul 2023 14:42:33 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:e8c:2042:5dec:b586])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe884000000b003144b95e1ecsm33480wrm.93.2023.07.26.14.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 14:42:32 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 1/2] mm: lock_vma_under_rcu() must check vma->anon_vma under vma lock
Date:   Wed, 26 Jul 2023 23:41:03 +0200
Message-ID: <20230726214103.3261108-3-jannh@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230726214103.3261108-1-jannh@google.com>
References: <20230726214103.3261108-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lock_vma_under_rcu() tries to guarantee that __anon_vma_prepare() can't
be called in the VMA-locked page fault path by ensuring that
vma->anon_vma is set.
However, this check happens before the VMA is locked, which means a
concurrent move_vma() can concurrently call unlink_anon_vmas(), which
disassociates the VMA's anon_vma.

This means we can get UAF in the following scenario:

  THREAD 1                   THREAD 2
  ========                   ========
  <page fault>
    lock_vma_under_rcu()
      rcu_read_lock()
      mas_walk()
      check vma->anon_vma

                             mremap() syscall
                               move_vma()
                                vma_start_write()
                                 unlink_anon_vmas()
                             <syscall end>

    handle_mm_fault()
      __handle_mm_fault()
        handle_pte_fault()
          do_pte_missing()
            do_anonymous_page()
              anon_vma_prepare()
                __anon_vma_prepare()
                  find_mergeable_anon_vma()
                    mas_walk() [looks up VMA X]

                             munmap() syscall (deletes VMA X)

                    reusable_anon_vma() [called on freed VMA X]

This is a security bug if you can hit it, although an attacker would
have to win two races at once where the first race window is only a
few instructions wide.

This patch is based on some previous discussion with Linus Torvalds on
the security list.

Cc: stable@vger.kernel.org
Fixes: 5e31275cc997 ("mm: add per-VMA lock and helper functions to control it")
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/memory.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 01f39e8144ef..603b2f419948 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5393,27 +5393,28 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	if (!vma_is_anonymous(vma) && !vma_is_tcp(vma))
 		goto inval;
 
-	/* find_mergeable_anon_vma uses adjacent vmas which are not locked */
-	if (!vma->anon_vma && !vma_is_tcp(vma))
-		goto inval;
-
 	if (!vma_start_read(vma))
 		goto inval;
 
+	/*
+	 * find_mergeable_anon_vma uses adjacent vmas which are not locked.
+	 * This check must happen after vma_start_read(); otherwise, a
+	 * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
+	 * from its anon_vma.
+	 */
+	if (unlikely(!vma->anon_vma && !vma_is_tcp(vma)))
+		goto inval_end_read;
+
 	/*
 	 * Due to the possibility of userfault handler dropping mmap_lock, avoid
 	 * it for now and fall back to page fault handling under mmap_lock.
 	 */
-	if (userfaultfd_armed(vma)) {
-		vma_end_read(vma);
-		goto inval;
-	}
+	if (userfaultfd_armed(vma))
+		goto inval_end_read;
 
 	/* Check since vm_start/vm_end might change before we lock the VMA */
-	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
-		vma_end_read(vma);
-		goto inval;
-	}
+	if (unlikely(address < vma->vm_start || address >= vma->vm_end))
+		goto inval_end_read;
 
 	/* Check if the VMA got isolated after we found it */
 	if (vma->detached) {
@@ -5425,6 +5426,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 
 	rcu_read_unlock();
 	return vma;
+
+inval_end_read:
+	vma_end_read(vma);
 inval:
 	rcu_read_unlock();
 	count_vm_vma_lock_event(VMA_LOCK_ABORT);
-- 
2.41.0.487.g6d72f3e995-goog

