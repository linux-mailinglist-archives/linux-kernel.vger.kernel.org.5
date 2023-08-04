Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CE27704A0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjHDP2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHDP2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:28:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D921A49E5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:27:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d05883d850fso2183674276.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691162862; x=1691767662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=okHSXq0SYkri7E0to28JFQj9dGiLp+hbVT5qT1e9xdU=;
        b=Ze27H+8OOQhF7Oj+2ZOk+cY5b5gFDys4DfQgVT60v89OD7qi5UeZ/cauYLk5j1Z+GU
         XzmqYz49Fo48ZGd45wNkV/OWAGwTfMj8sHgA+WLxLRz9FINm38B5BG9wrka8I8py53e4
         JxZXr7fPwYEz6xiF3SpxqoYBrBtxE6j/MgIItpyaYxeW+m/Vd5hX9SE2Cml3lUFOZW6r
         WM0e0CYffNX/JyZR7vi5OUlMXdaHPpAW0Kgep2I5V112BkSAgUR3PqlHz5NH22t6usrn
         YTi2zd8kbs4j6hx+FeLjGtgIsVutMy1LiPSegd4snkm0AH19LFF/qxuEmA9dhEOGf0FI
         5fXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162862; x=1691767662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okHSXq0SYkri7E0to28JFQj9dGiLp+hbVT5qT1e9xdU=;
        b=i8s+hGS59c9rGrIzJ7iAtfI6ruftLTSzaSz2lZy6rPiZULutLj0qsLnpg8cwAAsZr7
         JBuOqDIFPcJyFJTcf5w5B2nbJ26EvVsXkNtfwEy1hQE+zp+TksvrAFMK8oV/fHVMZ3+/
         A7vjCvBc6KluSk8wihoww7hGLMt3OtbQS/rDm4UAFY1PbrH/0ZKtJFJEla0WyHwvR/eQ
         Gj0iaojWBNYRdt4gV6h0SmffmM5zDCWmbD0KEMSF5MsMI5d0dsII1+fzRlw7saeTI6Dk
         +fFtz6ygq5Y3WdjDOeNFvKLtX5dfA45ZViW82XeGPEN89t1/zPiDkyIULsi1TaC73JAM
         sPVg==
X-Gm-Message-State: AOJu0YzS12RwtXsrsH5VljVXvGH5I/R2dV3+FtPJjIK+AVDc2WiXfMCm
        vytyH001kSxnH6qBBW/JehTZg/FlybU=
X-Google-Smtp-Source: AGHT+IGWFF8LV12V45AQ8PHaqPReOn9OGTO6qHNI1IHy9jYdCHxrz4hNZdLqwTqM3hhHqBDlThuUA+9rLzA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:43a7:a50f:b0fd:a068])
 (user=surenb job=sendgmr) by 2002:a05:6902:1614:b0:d0d:c74a:a6c0 with SMTP id
 bw20-20020a056902161400b00d0dc74aa6c0mr10193ybb.2.1691162861553; Fri, 04 Aug
 2023 08:27:41 -0700 (PDT)
Date:   Fri,  4 Aug 2023 08:27:24 -0700
In-Reply-To: <20230804152724.3090321-1-surenb@google.com>
Mime-Version: 1.0
References: <20230804152724.3090321-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230804152724.3090321-7-surenb@google.com>
Subject: [PATCH v4 6/6] mm: move vma locking out of vma_prepare and dup_anon_vma
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
 mm/mmap.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 850a39dee075..16661427d3e8 100644
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
 
+	if (merge_prev)
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
@@ -966,8 +966,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			}
 		}
 	} else { /* merge_next */
+		vma_start_write(next);
 		res = next;
 		if (prev && addr < prev->vm_end) {	/* case 4 */
+			vma_start_write(prev);
 			vma_end = addr;
 			adjust = next;
 			adj_start = -(prev->vm_end - addr);
@@ -983,6 +985,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
 			vma_pgoff = next->vm_pgoff - pglen;
 			if (curr) {			/* case 8 */
 				vma_pgoff = curr->vm_pgoff;
+				vma_start_write(curr);
 				remove = curr;
 				err = dup_anon_vma(next, curr);
 			}
@@ -2373,6 +2376,9 @@ int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
 
+	vma_start_write(vma);
+	vma_start_write(new);
+
 	init_vma_prep(&vp, vma);
 	vp.insert = new;
 	vma_prepare(&vp);
@@ -3078,6 +3084,8 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		if (vma_iter_prealloc(vmi))
 			goto unacct_fail;
 
+		vma_start_write(vma);
+
 		init_vma_prep(&vp, vma);
 		vma_prepare(&vp);
 		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
-- 
2.41.0.585.gd2178a4bd4-goog

