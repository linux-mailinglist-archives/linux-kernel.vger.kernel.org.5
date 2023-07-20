Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D19575B198
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjGTOuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjGTOuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:50:02 -0400
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4277CE60
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689864598;
        bh=Qcz15XReY65YdihFG7Jmx5oPpTHAUuD8Yllv8YH9M0o=;
        h=From:To:Cc:Subject:Date;
        b=IirFhtFdl9BNwuH0OPcCLSw+yozZo2YvicxzWqWW8sTU527DJB2LSwFZDJ0psxaGb
         zEPucDoTdvsXxIAeUGqLhxTxtOlstE8wt++rNIErEbBGD3Xxzsj8lBTUaNol9LRTsb
         sTNnauoFYXBJDO9zS51bSlv2mFhI9zFWZStKgOpk=
Received: from linkpc.nju.edu.cn ([58.213.8.104])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id C771E6C3; Thu, 20 Jul 2023 22:49:55 +0800
X-QQ-mid: xmsmtpt1689864595t13z8h5u9
Message-ID: <tencent_C2D6865561F23A8141BB145149ACC682B408@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjSUXlQpXDAbkBcZjcNvgtboI9mD4CSVX2bJs8NHANQ2x1u1ELe7
         WK13yV3eDNEGCOyR8j4mAsv9yzxVXJckkYuIPJ08gaDljfv6hWZiKCqPWDDqvatuKB923+558zAW
         ebp2b5JUpQsOcbruVi9yPywy+RbH6kbZQX+Z3Xta8hfSCl0C3vd1Xsz+DJIVulP2UlHZ8QbCeITy
         e/1JQoE7KwRIZngya5mTfliq8Lha98Yokh22td0b4fVt9Sivf6z3xfxCQbutmPAJ+KiXimLkgQxz
         R5huVexGTmCKz4kSIs1L5cuOxiYfJlpalwaw8dyL7kpfkMG5SgUXdTKec69dEwXG39TJyhsPtzjf
         co4X2hocYHOm7/Wyls27VgiWWp78e/lVIoccb12Q9+xR/PkhwaqXc0G6N06Cs28eNmIJmwTLtXhG
         +d5usc+fisGdhWnu/c0lcIRolkrzVYMAJCZN6RDrXnxpPlqRw7hyfNt2ftWSY3S/K1Yn1sAUyZV0
         r2P33px2RvOpEmoX3PZOd61W/AxFHNUk046MtIBt+1VwxrcnyFJhJ4FXWCY4+4eoC0dv1snN+ZCc
         g5XQB21HXxGaSCnAifYrMjDyY0sKzci/v0qZRgOGRFhbciI7T4KT+cufSysDg4gnLe49M3ybeN2v
         3LCvYmgjCDarE1mNDl4+kh3QPYfrVGJxi5xn2fYfe4CSaHOQg2y8W40t4mTVD+Qae9FC25gYysyQ
         FUfw2xnIHpdrHqjdjbfEAfnY0M38tHiU1LJ/HSsqDOT0W5dHAoevnbqUDqkCN/gIp3T94ckZ87wc
         whDh2UQM9hUmHNViQUtqMrej+SXeUqOAnidi8kYkX8lJNgxRl1q4UgckBo/wUEkxgoU173THyEa6
         dCY/CjCVB0l72tXVQhEhxGNfJHwwRwo3SRR1vKjEn38tloekLkxKflBhfjymJEZA82KyB8qDbVyb
         5Styfq46VPidF5EUBC8WJh14BmtZlx+HUHB6DGdRVY90HUnEjnhv6KIM+W9js3rj0HyIKQBKs=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From:   Linke Li <lilinke99@foxmail.com>
To:     linux-mm@kvack.org
Cc:     mike.kravetz@oracle.com, muchun.song@linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        dan.carpenter@linaro.org, Linke Li <lilinke99@gmail.com>
Subject: [PATCH v3] hugetlbfs: Fix integer overflow check in hugetlbfs_file_mmap()
Date:   Thu, 20 Jul 2023 22:49:52 +0800
X-OQ-MSGID: <20230720144952.127328-1-lilinke99@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linke Li <lilinke99@gmail.com>

```
	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
	/* check for overflow */
	if (len < vma_len)
		return -EINVAL;
```

There is a signed integer overflow in the code, which is undefined
behavior according to the C stacnard. Although this works, it's
still a bit ugly and static checkers will complain.

Using macro "check_add_overflow" to do the overflow check can
effectively detect integer overflow and avoid any undefined behavior.

Signed-off-by: Linke Li <lilinke99@gmail.com>
---
v3: fix checkpatch warning and better description.
 fs/hugetlbfs/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7b17ccfa039d..326a8c0af5f6 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -154,10 +154,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
 		return -EINVAL;
 
-	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
-	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-	/* check for overflow */
-	if (len < vma_len)
+	if (check_add_overflow(vma_len, (loff_t)vma->vm_pgoff << PAGE_SHIFT, &len))
 		return -EINVAL;
 
 	inode_lock(inode);
-- 
2.25.1

