Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE44C790CB1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243822AbjICPNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243295AbjICPNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:13:43 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A9111A
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 08:13:39 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79289fefdbeso37418139f.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 08:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693754018; x=1694358818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oa7N2sPH/lilO/UwWqLMR+jDCHXNj+j722SD4+8DAS8=;
        b=p3ecb/r3Oez3FeX0zxpD3f9Ziln558UEzDLpuqh8HNXSknzOxmT4SPodW6rM8VjH8D
         Azrhc/vJThEJlKmycWClmEDvDZx4Giojf1un9nRL8S2WIhPxg8+KOoamMha3GHXFz0Wo
         +qIziE2JNDpIejHJ5haC6paenH8shfjHOMx2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693754018; x=1694358818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oa7N2sPH/lilO/UwWqLMR+jDCHXNj+j722SD4+8DAS8=;
        b=WnXIpZooua9EJKsQxXMnpt6Z5tSrrFOvUQPXNoR1jbCMl7E4FFrH513TtrLye6Uxwm
         KNrsxoaaA0Xt2uIKbAF6dAPxxtxWGDZCEFfU/Tenl+5fbIpNrHTkUf3uz+s5gkm7HCGz
         6b333p4W0QH0NiP1ITK7FXlaXwbyfP8DP9pYTncRBGTwank0sMkM20ieGnaRTDfebHhf
         KYBIsotUXjjhg1XA70yJYP2QQZrZMZ7TZ46ZjcFkK2UJ7kv5OyQYPH+SzOnlQW4rC53M
         zdZkMSEYUk5b7fNthSmKvd1ES9ypr3PFcjAlKufSrPF0rjWthfp5Nhg+6Mqgj6NqsePK
         7Qsg==
X-Gm-Message-State: AOJu0YzuU9JJKNGnbB4t/kE1UhtecE6Bkmzmo14TsL+CCiHHM9rS8JQq
        yhCFO2hpE4h/2Crgsb3xJeBKIABUv8S8HWdqAs0=
X-Google-Smtp-Source: AGHT+IGTBN7+8BUOuxu3HzD4jDZmr/y5lg4NupMcQKdCe0g07b+paLWsn6FtLb2h4fhMmD0ruozikg==
X-Received: by 2002:a05:6602:210b:b0:787:169a:927 with SMTP id x11-20020a056602210b00b00787169a0927mr8408605iox.20.1693754018437;
        Sun, 03 Sep 2023 08:13:38 -0700 (PDT)
Received: from joelboxx5.corp.google.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id f5-20020a6b5105000000b007835a305f61sm2605897iob.36.2023.09.03.08.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:13:37 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: [PATCH v6 2/7] mm/mremap: Allow moves within the same VMA for stack moves
Date:   Sun,  3 Sep 2023 15:13:23 +0000
Message-ID: <20230903151328.2981432-3-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230903151328.2981432-1-joel@joelfernandes.org>
References: <20230903151328.2981432-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the stack move happening in shift_arg_pages(), the move is happening
within the same VMA which spans the old and new ranges.

In case the aligned address happens to fall within that VMA, allow such
moves and don't abort the mremap alignment optimization.

In the regular non-stack mremap case, we cannot allow any such moves as
will end up destroying some part of the mapping (either the source of
the move, or part of the existing mapping). So just avoid it for stack
moves.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/exec.c          |  2 +-
 include/linux/mm.h |  2 +-
 mm/mremap.c        | 33 +++++++++++++++++++--------------
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 1a827d55ba94..244925307958 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -712,7 +712,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
 	 * process cleanup to remove whatever mess we made.
 	 */
 	if (length != move_page_tables(vma, old_start,
-				       vma, new_start, length, false))
+				       vma, new_start, length, false, true))
 		return -ENOMEM;
 
 	lru_add_drain();
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 406ab9ea818f..e635d1fc73b6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2458,7 +2458,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 extern unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks);
+		bool need_rmap_locks, bool for_stack);
 
 /*
  * Flags used by change_protection().  For now we make it a bitmap so
diff --git a/mm/mremap.c b/mm/mremap.c
index 1011326b7b80..2b51f8b7cad8 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -490,12 +490,13 @@ static bool move_pgt_entry(enum pgt_entry entry, struct vm_area_struct *vma,
 }
 
 /*
- * A helper to check if a previous mapping exists. Required for
- * move_page_tables() and realign_addr() to determine if a previous mapping
- * exists before we can do realignment optimizations.
+ * A helper to check if aligning down is OK. The aligned address should fall
+ * on *no mapping*. For the stack moving down, that's a special move within
+ * the VMA that is created to span the source and destination of the move,
+ * so we make an exception for it.
  */
 static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_align,
-			       unsigned long mask)
+			    unsigned long mask, bool for_stack)
 {
 	unsigned long addr_masked = addr_to_align & mask;
 
@@ -504,9 +505,13 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
 	 * of the corresponding VMA, we can't align down or we will destroy part
 	 * of the current mapping.
 	 */
-	if (vma->vm_start != addr_to_align)
+	if (!for_stack && vma->vm_start != addr_to_align)
 		return false;
 
+	/* In the stack case we explicitly permit in-VMA alignment. */
+	if (for_stack && addr_masked >= vma->vm_start)
+		return true;
+
 	/*
 	 * Make sure the realignment doesn't cause the address to fall on an
 	 * existing mapping.
@@ -517,7 +522,7 @@ static bool can_align_down(struct vm_area_struct *vma, unsigned long addr_to_ali
 /* Opportunistically realign to specified boundary for faster copy. */
 static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old_vma,
 			     unsigned long *new_addr, struct vm_area_struct *new_vma,
-			     unsigned long mask)
+			     unsigned long mask, bool for_stack)
 {
 	/* Skip if the addresses are already aligned. */
 	if ((*old_addr & ~mask) == 0)
@@ -528,8 +533,8 @@ static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old
 		return;
 
 	/* Ensure realignment doesn't cause overlap with existing mappings. */
-	if (!can_align_down(old_vma, *old_addr, mask) ||
-	    !can_align_down(new_vma, *new_addr, mask))
+	if (!can_align_down(old_vma, *old_addr, mask, for_stack) ||
+	    !can_align_down(new_vma, *new_addr, mask, for_stack))
 		return;
 
 	*old_addr = *old_addr & mask;
@@ -539,7 +544,7 @@ static void try_realign_addr(unsigned long *old_addr, struct vm_area_struct *old
 unsigned long move_page_tables(struct vm_area_struct *vma,
 		unsigned long old_addr, struct vm_area_struct *new_vma,
 		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks)
+		bool need_rmap_locks, bool for_stack)
 {
 	unsigned long extent, old_end;
 	struct mmu_notifier_range range;
@@ -559,9 +564,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 	 * If possible, realign addresses to PMD boundary for faster copy.
 	 * Only realign if the mremap copying hits a PMD boundary.
 	 */
-	if ((vma != new_vma)
-		&& (len >= PMD_SIZE - (old_addr & ~PMD_MASK)))
-		try_realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK);
+	if (len >= PMD_SIZE - (old_addr & ~PMD_MASK))
+		try_realign_addr(&old_addr, vma, &new_addr, new_vma, PMD_MASK,
+				 for_stack);
 
 	flush_cache_range(vma, old_addr, old_end);
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma->vm_mm,
@@ -708,7 +713,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	}
 
 	moved_len = move_page_tables(vma, old_addr, new_vma, new_addr, old_len,
-				     need_rmap_locks);
+				     need_rmap_locks, false);
 	if (moved_len < old_len) {
 		err = -ENOMEM;
 	} else if (vma->vm_ops && vma->vm_ops->mremap) {
@@ -722,7 +727,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		 * and then proceed to unmap new area instead of old.
 		 */
 		move_page_tables(new_vma, new_addr, vma, old_addr, moved_len,
-				 true);
+				 true, false);
 		vma = new_vma;
 		old_len = new_len;
 		old_addr = new_addr;
-- 
2.42.0.283.g2d96d420d3-goog

