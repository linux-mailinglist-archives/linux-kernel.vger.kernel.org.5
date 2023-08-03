Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83E976F0A0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbjHCR10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjHCR1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:27:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27943C3D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:27:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5844a99c268so13512377b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691083629; x=1691688429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=enNugCeOmhfazHyzEjQZvfU7Wp5uGQcTSmtYdGh09Fo=;
        b=zMcctUOh7tYayLvckt9uz/YiCskGpP+YntI3h+0uVE/02dHvg03tF8YSHbRMyNGfZB
         vRYvs+C9OZgyahs0ZA60vqFKBKDcsU68jI9QF2xZbnvK1zTGlMYfnt4cUcYYUYYQEZgm
         QcZToqsbu8sycVp7w2dB3p8Tho375Ac9GC/kb1P9fL5XmVLzXVE4tmVCtIfbtq++EekQ
         sXwQggrredRKZtR876ti7Xpr8W/4VwmfvILxh9XXU6UIOZhAVePq4SmwRGAaJR1zzKb1
         NYBjYG4UWWlZvCyBazMus+wGvZXN0rUGhkIT38Std3TmC/giO7p092GnBqUklLiC2uAW
         CiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691083629; x=1691688429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enNugCeOmhfazHyzEjQZvfU7Wp5uGQcTSmtYdGh09Fo=;
        b=NOVYs6xS5KqgzYvK/CFEf2Ykpfhrx17VF3ODcwvIxsDhbbOcA4RhdNNsMSLASHOv8t
         q8UTZ/GPSh0xI471yafJK5XYIMnl5CaUj2Hz97EJy0kPqPb4jo9Wleo6sFl9S44INUVi
         tECYEZZyrzkHnKX3TY73h7mGECrb0xcGgqbPHLA93Vm5fK3CyrAxDN0x3eEbTF46B/DA
         9VmuNr6WOW3yUEaR34lpzd/YDxgoYlCfBgJZWSt2kgEzpb+FO4LAwBUhoj0i3gEwPkSy
         Eu7FhuxO6KALcA0xzoxm1JhhxBe5sktFpNWwCjiG2PEM6RLOj3gpncUuFXuDqE0QUU+P
         7V9g==
X-Gm-Message-State: ABy/qLbk2EQMSILUyI9WM/MUf/ocR6X0nfGWBCPEN0srbB2p6XbihiXr
        +VK24SBGJlR1tUNLdwRaVpx1GNAp19E=
X-Google-Smtp-Source: APBJJlFs+p1+IFx0/LyJPwchu48cnzJ5YCTLzpQdjYobzqCAPy/6bN4ZVrBDwToPCue3BOGsJ6NlQ5kk+iE=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3dec:ef9e:7bf4:7a6])
 (user=surenb job=sendgmr) by 2002:a81:ac58:0:b0:579:e07c:2798 with SMTP id
 z24-20020a81ac58000000b00579e07c2798mr160834ywj.2.1691083629316; Thu, 03 Aug
 2023 10:27:09 -0700 (PDT)
Date:   Thu,  3 Aug 2023 10:26:51 -0700
In-Reply-To: <20230803172652.2849981-1-surenb@google.com>
Mime-Version: 1.0
References: <20230803172652.2849981-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803172652.2849981-7-surenb@google.com>
Subject: [PATCH v3 6/6] mm: move vma locking out of vma_prepare and dup_anon_vma
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_prepare() is currently the central place where vmas are being locked
before vma_complete() applies changes to them. While this is convenient,
it also obscures vma locking and makes it harder to follow the locking
rules. Move vma locking out of vma_prepare() and take vma locks
explicitly at the locations where vmas are being modified. Move vma
locking and replace it with an assertion inside dup_anon_vma() to further
clarify the locking pattern inside vma_merge().

Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Suggested-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 850a39dee075..ae28d6f94c34 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -476,16 +476,6 @@ static inline void init_vma_prep(struct vma_prepare *vp,
  */
 static inline void vma_prepare(struct vma_prepare *vp)
 {
-	vma_start_write(vp->vma);
-	if (vp->adj_next)
-		vma_start_write(vp->adj_next);
-	if (vp->insert)
-		vma_start_write(vp->insert);
-	if (vp->remove)
-		vma_start_write(vp->remove);
-	if (vp->remove2)
-		vma_start_write(vp->remove2);
-
 	if (vp->file) {
 		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
 
@@ -618,7 +608,7 @@ static inline int dup_anon_vma(struct vm_area_struct *dst,
 	 * anon pages imported.
 	 */
 	if (src->anon_vma && !dst->anon_vma) {
-		vma_start_write(dst);
+		vma_assert_write_locked(dst);
 		dst->anon_vma = src->anon_vma;
 		return anon_vma_clone(dst, src);
 	}
@@ -650,10 +640,12 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	bool remove_next = false;
 	struct vma_prepare vp;
 
+	vma_start_write(vma);
 	if (next && (vma != next) && (end == next->vm_end)) {
 		int ret;
 
 		remove_next = true;
+		vma_start_write(next);
 		ret = dup_anon_vma(vma, next);
 		if (ret)
 			return ret;
@@ -708,6 +700,8 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma_iter_prealloc(vmi))
 		return -ENOMEM;
 
+	vma_start_write(vma);
+
 	init_vma_prep(&vp, vma);
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, start, end, 0);
@@ -940,16 +934,21 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (!merge_prev && !merge_next)
 		return NULL; /* Not mergeable. */
 
+	if (prev)
+		vma_start_write(prev);
+
 	res = vma = prev;
 	remove = remove2 = adjust = NULL;
 
 	/* Can we merge both the predecessor and the successor? */
 	if (merge_prev && merge_next &&
 	    is_mergeable_anon_vma(prev->anon_vma, next->anon_vma, NULL)) {
+		vma_start_write(next);
 		remove = next;				/* case 1 */
 		vma_end = next->vm_end;
 		err = dup_anon_vma(prev, next);
 		if (curr) {				/* case 6 */
+			vma_start_write(curr);
 			remove = curr;
 			remove2 = next;
 			if (!next->anon_vma)
@@ -957,6 +956,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		}
 	} else if (merge_prev) {			/* case 2 */
 		if (curr) {
+			vma_start_write(curr);
 			err = dup_anon_vma(prev, curr);
 			if (end == curr->vm_end) {	/* case 7 */
 				remove = curr;
@@ -966,6 +966,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			}
 		}
 	} else { /* merge_next */
+		vma_start_write(next);
 		res = next;
 		if (prev && addr < prev->vm_end) {	/* case 4 */
 			vma_end = addr;
@@ -983,6 +984,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_pgoff = next->vm_pgoff - pglen;
 			if (curr) {			/* case 8 */
 				vma_pgoff = curr->vm_pgoff;
+				vma_start_write(curr);
 				remove = curr;
 				err = dup_anon_vma(next, curr);
 			}
@@ -2373,6 +2375,9 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
 
+	vma_start_write(vma);
+	vma_start_write(new);
+
 	init_vma_prep(&vp, vma);
 	vp.insert = new;
 	vma_prepare(&vp);
@@ -3078,6 +3083,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (vma_iter_prealloc(vmi))
 			goto unacct_fail;
 
+		vma_start_write(vma);
+
 		init_vma_prep(&vp, vma);
 		vma_prepare(&vp);
 		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
-- 
2.41.0.585.gd2178a4bd4-goog

