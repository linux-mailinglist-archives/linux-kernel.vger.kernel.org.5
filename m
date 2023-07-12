Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8506675118D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjGLT5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGLT45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:56:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB011FE4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:56:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57a43b50c2fso59035667b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689191815; x=1691783815;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2BtXsjfKyBZZ4hGpVoJMLLIXywElgntexK2sVj3vQno=;
        b=sK8Qv7jgQFBakMmJ76L4YwA9bGaXfKDlEpXmENSJ0IEZGo2dC+BmgF3N3EInITTrUE
         Iok6sB9ubdOYOq2TAsfOVa+3Hm6cFze9Abo4hMHfjKfXNl+9NS//kwmXOV6tj0cUv3sh
         05ZYyZhcZjT7LR3qUxIbJhO0D6YaxWxoxPeWpsGphNLAtWPqT2ymZHXgK9TwZSuqBHLt
         +9/Gpa/LwODCRC4pANti+N5Y/1o6wU10fIlBnKMX7BH0d9X5MDtsY4C8ps+6/GwK+OJy
         MS1a/JxHHWixAuD8GqIwTg2wq5sPthIN4NFiZtinDB/kc9ouymP0mFWHsTtrvrc3+HLf
         B1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689191815; x=1691783815;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2BtXsjfKyBZZ4hGpVoJMLLIXywElgntexK2sVj3vQno=;
        b=PcPyMODmbrMGN66MN7VefDG40SfGWmifHfH874BHI1NDAWrDgCeu0Ytk5getCtlTfK
         LwCOUEge0slFP/h43MUPs0LBJ/QNMm4zwhNLCwrw4eEr+BbCNcFQcHvpMvIcdUGKioRa
         Zm8KDQ3wt6/gKthwYWT686W+JJsOHAFgI9FwGe4MoRsXzFxXuPnxeGSbo/RzAo3xYAFS
         73kuvj+7oAEyALDBeVdpnMhPgLZq7O+ZkJHpgky6pIffLJyhmLljyOUWH3BdmCBqT7mc
         biGkG2S93rKwk4HXNblX9DflrbOPWdidBhPRmcVvRLBvm5Wr/FIxZS1xir1ngqP6leIR
         ACUQ==
X-Gm-Message-State: ABy/qLYtVAzObYSxmfHI9AsqKX32oOyxyGS+1Kxu3acpRo6+tjpSsC5k
        EmPpDW1NBSl7Mvp4jvVRigWPETPhQaI=
X-Google-Smtp-Source: APBJJlF9Q/vZpfBREpRg5ypLsgVDhpX4u3umnCxJNyVvelWjyn/NUiGUk739RK0xqeWTgDRuQ+qE9rOKyNk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:cf1c:cfa6:8f82:4b58])
 (user=surenb job=sendgmr) by 2002:a81:b603:0:b0:56c:e0c5:de88 with SMTP id
 u3-20020a81b603000000b0056ce0c5de88mr160708ywh.1.1689191815286; Wed, 12 Jul
 2023 12:56:55 -0700 (PDT)
Date:   Wed, 12 Jul 2023 12:56:52 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.455.g037347b96a-goog
Message-ID: <20230712195652.969194-1-surenb@google.com>
Subject: [PATCH 1/1] mm: fix a lockdep issue in vma_assert_write_locked
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     Liam.Howlett@oracle.com, linux-mm@kvack.org, willy@infradead.org,
        ldufour@linux.ibm.com, michel@lespinasse.org, jglisse@google.com,
        vbabka@suse.cz, paulmck@kernel.org, brauner@kernel.org,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <liam.howlett@oracle.com>,
        syzbot+339b02f826caafd5f7a8@syzkaller.appspotmail.com
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

__is_vma_write_locked() can be used only when mmap_lock is write-locked
to guarantee vm_lock_seq and mm_lock_seq stability during the check.
Therefore it asserts this condition before further checks. Because of
that it can't be used unless the user expects the mmap_lock to be
write-locked. vma_assert_locked() can't assume this before ensuring
that VMA is not read-locked.
Change the order of the checks in vma_assert_locked() to check if the
VMA is read-locked first and only then assert if it's not write-locked.

Fixes: 50b88b63e3e4 ("mm: handle userfaults under VMA lock")
Reported-by: Liam R. Howlett <liam.howlett@oracle.com>
Closes: https://lore.kernel.org/all/20230712022620.3yytbdh24b7i4zrn@revolver/
Reported-by: syzbot+339b02f826caafd5f7a8@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000002db68f05ffb791bc@google.com/
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/mm.h | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9687b48dfb1b..e3b022a66343 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -668,6 +668,7 @@ static inline void vma_end_read(struct vm_area_struct *vma)
 	rcu_read_unlock();
 }
 
+/* WARNING! Can only be used if mmap_lock is expected to be write-locked */
 static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
 {
 	mmap_assert_write_locked(vma->vm_mm);
@@ -707,22 +708,17 @@ static inline bool vma_try_start_write(struct vm_area_struct *vma)
 	return true;
 }
 
-static inline void vma_assert_locked(struct vm_area_struct *vma)
+static inline void vma_assert_write_locked(struct vm_area_struct *vma)
 {
 	int mm_lock_seq;
 
-	if (__is_vma_write_locked(vma, &mm_lock_seq))
-		return;
-
-	lockdep_assert_held(&vma->vm_lock->lock);
-	VM_BUG_ON_VMA(!rwsem_is_locked(&vma->vm_lock->lock), vma);
+	VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
 }
 
-static inline void vma_assert_write_locked(struct vm_area_struct *vma)
+static inline void vma_assert_locked(struct vm_area_struct *vma)
 {
-	int mm_lock_seq;
-
-	VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
+	if (!rwsem_is_locked(&vma->vm_lock->lock))
+		vma_assert_write_locked(vma);
 }
 
 static inline void vma_mark_detached(struct vm_area_struct *vma, bool detached)
-- 
2.41.0.455.g037347b96a-goog

