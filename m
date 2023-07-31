Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83995769F28
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjGaRQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjGaRPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:15:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4872718
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:12:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d13e11bb9ecso5255515276.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690823571; x=1691428371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nlUlu5Mhd5cq+/dnIWytp1wDOwye9pYqWME5wT1VG2E=;
        b=sHGO4YkHIV7FKB9rSFdsUdceu+sd5n7SB4rQ2unW3pD+BVqkwNJbz+SITG2pysaMgl
         gKtSzBeA+OBMePojGafJ+11doCnzqSxZKPCriFEkRtJWp27lsz7elqgKl6T8eOE/f8yK
         w7zw6fW868PqBeRY5qLJOdGEIjLR+7606TSSgtlwLhhrV02LXp2unR5jYo2ZCHxqOD6/
         aTLQZWV2NWG8NNR6Zbwdm5er8wOMF1YxeMP3rfPV2nuC2GAZIApB/MNhrk0KohkTdxbo
         aZdUz3A18SoWVWors7K7+klRf0vOn2JYaGIHOGPalUyPxopNDj0TFe/WRuIA3D+NB8/C
         cl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823571; x=1691428371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nlUlu5Mhd5cq+/dnIWytp1wDOwye9pYqWME5wT1VG2E=;
        b=iLVH+/LhDPQ0f5JccoHOfenVggYZrkN3yyqrLyWIuxts5/9gGC2Qvs9/t6WZl3d4SC
         pbjzPXu6lxOiLJ20wdT5+1ZidMqbO/KidUvVjEy5e2mugrjPJ1wMZLQv3UeVFIELKWZ/
         WwJQ8dpBvGB8umiPm7GcvYrFqPEJSTtS3/drytRUuA35XgJZN+aNa9YYLM7azVeZHIsa
         5xmP8FvNi5eOCt36oFgX3pFoCc3LiSjR7PHg973QTtWtbBZ+4evALD5C6M1RQhaF5QNM
         p+vREv85bs8OSPUyVefsr/5Iir28x8re6+2iMJTMGR8nwIdK7LWYCRHYzvGCxB4vbP5T
         dW6A==
X-Gm-Message-State: ABy/qLZvNcvUzz+ciJ7LQlW8gOqYJm4AdbU79Gnn7qr4hTtqBVKQ3iG9
        po/xfit89tRew7ESPF1GpgyacywMZkg=
X-Google-Smtp-Source: APBJJlE2nxuBMZTc6tsHHVP/zDZfM1zO/qPtnEy+bfYdI+vtC/H0IUdghcKWYcF/n32JcSPB9GeJlvFqcvY=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:d4d3:7e41:cb80:21ea])
 (user=surenb job=sendgmr) by 2002:a05:6902:1616:b0:d12:d6e4:a08e with SMTP id
 bw22-20020a056902161600b00d12d6e4a08emr70507ybb.5.1690823571188; Mon, 31 Jul
 2023 10:12:51 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:12:32 -0700
In-Reply-To: <20230731171233.1098105-1-surenb@google.com>
Mime-Version: 1.0
References: <20230731171233.1098105-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230731171233.1098105-7-surenb@google.com>
Subject: [PATCH 6/6] mm: move vma locking out of vma_prepare
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
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
it also obscures vma locking and makes it hard to follow the locking rules.
Move vma locking out of vma_prepare() and take vma locks explicitly at the
locations where vmas are being modified.

Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/mmap.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 850a39dee075..e59d83cb1d7a 100644
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
 
@@ -650,6 +640,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	bool remove_next = false;
 	struct vma_prepare vp;
 
+	vma_start_write(vma);
 	if (next && (vma != next) && (end == next->vm_end)) {
 		int ret;
 
@@ -657,6 +648,7 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		ret = dup_anon_vma(vma, next);
 		if (ret)
 			return ret;
+		vma_start_write(next);
 	}
 
 	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
@@ -708,6 +700,8 @@ int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (vma_iter_prealloc(vmi))
 		return -ENOMEM;
 
+	vma_start_write(vma);
+
 	init_vma_prep(&vp, vma);
 	vma_prepare(&vp);
 	vma_adjust_trans_huge(vma, start, end, 0);
@@ -946,10 +940,12 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
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
@@ -958,6 +954,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	} else if (merge_prev) {			/* case 2 */
 		if (curr) {
 			err = dup_anon_vma(prev, curr);
+			vma_start_write(curr);
 			if (end == curr->vm_end) {	/* case 7 */
 				remove = curr;
 			} else {			/* case 5 */
@@ -969,6 +966,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 		res = next;
 		if (prev && addr < prev->vm_end) {	/* case 4 */
 			vma_end = addr;
+			vma_start_write(next);
 			adjust = next;
 			adj_start = -(prev->vm_end - addr);
 			err = dup_anon_vma(next, prev);
@@ -983,6 +981,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_pgoff = next->vm_pgoff - pglen;
 			if (curr) {			/* case 8 */
 				vma_pgoff = curr->vm_pgoff;
+				vma_start_write(curr);
 				remove = curr;
 				err = dup_anon_vma(next, curr);
 			}
@@ -996,6 +995,8 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 	if (vma_iter_prealloc(vmi))
 		return NULL;
 
+	vma_start_write(vma);
+
 	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
 	VM_WARN_ON(vp.anon_vma && adjust && adjust->anon_vma &&
 		   vp.anon_vma != adjust->anon_vma);
@@ -2373,6 +2374,9 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
 
+	vma_start_write(vma);
+	vma_start_write(new);
+
 	init_vma_prep(&vp, vma);
 	vp.insert = new;
 	vma_prepare(&vp);
@@ -3078,6 +3082,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (vma_iter_prealloc(vmi))
 			goto unacct_fail;
 
+		vma_start_write(vma);
+
 		init_vma_prep(&vp, vma);
 		vma_prepare(&vp);
 		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
-- 
2.41.0.487.g6d72f3e995-goog

