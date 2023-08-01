Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952DB76C01F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjHAWIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjHAWIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:08:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098F1268F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 15:07:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57320c10635so71725447b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 15:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690927671; x=1691532471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FgBjF0ZO5ynPdNrndPmrtDmv0LneRZKTmqqgx6E5wg8=;
        b=D1O6U13IyQtW6sRKIgsBESsntgiHZD2NBKEqY9x4VzN/LKKhnlNfxDelhOtdMckxRn
         FHM+qzWy+1vIGVvjuSnC3HOPacbJwiF+FU/44s3FUSl9rg9/MlksilEUDdYILducKN5m
         QBspm1K1gtu0F9WcdyEIrEuwnPMiQ8okMkqevL/Euzqha1FW9VFmXK9Kd09SaJL8SIMi
         4XcGgId5NKrdkKLAeWoz/iYiTpXzRmouek8VJ8B5ZERcnA/Lkgi6E3b5jwXkBi9h6gTm
         7wI1MoX2O3/0bFhkSpJ1WB6U2kt7rsAJK91S/XGtkVxCLlTHZukUWI5CAAc5iREvhiOQ
         j9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690927671; x=1691532471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FgBjF0ZO5ynPdNrndPmrtDmv0LneRZKTmqqgx6E5wg8=;
        b=cArRiACyB0A3L0L1ol/Btjapdf4CDB3q3hT7vH7U8IEwosQuxFvVil1r989yRcZFey
         H+gw6MDe9AGqynrRtXxivkA5AOqSTouYOHSM8i8yzrujkIItjRfAAoaGM55kRS0YeIFa
         ybKVLRfaYDhrQOr6Il7ACAfkwLn79ipVrslMFqOL4hETzx1v6AGUiwVJvJ1c1VTgbv0R
         hRHrYely1e57d5aSFwWKsqayL0Weldc35+4KGtBaLlOPdVK3ck6n/vSg7o/lCXNwmyU2
         2bkdsyf1wAzrsxxquKjPHuj5FF1KPkAlEK+uZA2WQ12LjFghfoDc28fH5Q726jK1NqRa
         M9eQ==
X-Gm-Message-State: ABy/qLYXhTz+ydCVMzcJyZWqLFw/A1XyCs1uyt0P7quWzmZ8pOsLGyQP
        Ux69pAur2+31HNEeoysz0Oli1btywdA=
X-Google-Smtp-Source: APBJJlHKCcBKjQ9mL8CtWFWy75AVvvzqEFOjz4RA/pg75yQkmZcpThORh+6C2/yUUDZy/D/HgF30pmifT2Y=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:211c:a2ff:f17b:c5e9])
 (user=surenb job=sendgmr) by 2002:a81:ae13:0:b0:583:a866:3450 with SMTP id
 m19-20020a81ae13000000b00583a8663450mr126859ywh.7.1690927671038; Tue, 01 Aug
 2023 15:07:51 -0700 (PDT)
Date:   Tue,  1 Aug 2023 15:07:32 -0700
In-Reply-To: <20230801220733.1987762-1-surenb@google.com>
Mime-Version: 1.0
References: <20230801220733.1987762-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801220733.1987762-7-surenb@google.com>
Subject: [PATCH v2 6/6] mm: move vma locking out of vma_prepare
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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
2.41.0.585.gd2178a4bd4-goog

