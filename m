Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE8378149E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 23:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbjHRVPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 17:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240768AbjHRVPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:15:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491D24216
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:15:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583c49018c6so18294697b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692393337; x=1692998137;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sGETMcHxX4ObOscRub16vn6iyArRP5Rx2JOMy3tD22A=;
        b=vSbdup0x7pGjyjrNke14G4in3KiGeWdp4C7AlnPlh/Lg7LYay3noXqdk/7Gcojvnt2
         L0vkg2689+eOisj9cKCuTIq+KWznoxDM5VVTukZmH0UMuIlHVqVaQqlzZm3qqllE5YDp
         35IB3uNTL0gtKhwkbXm5z91LkXftDfMleqWBl0LNlWUXbWMFBdk2wyBRu6NL28gssioI
         HR292kurg9MD0vMGhusRI0jKaChKQiWBvE2lJSPVk8qSc9woxhc1j+AawmuwX4RjDtyi
         0qY4PSqSJhHL+JqSpyoIRqVNMtHahxAiI4GvGa3cODRQkVSocnC+0/CDUaNTF6+W1Fv/
         OXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692393337; x=1692998137;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sGETMcHxX4ObOscRub16vn6iyArRP5Rx2JOMy3tD22A=;
        b=GZ+f8DjiZMZUmsFolSfW/xHTkHW6dxxjjiBM58/dQ7aNbis930ObvQIuGKzSXcNZpP
         pgQJ+oByeADAzah7jvYiKnjCg/ojQn4d/Ko9ZC2UpvRG4Zlta88cTX0zXJnK0xWXJcG7
         5BVjL/sHXkPhPUrwMtUF42stIHDGthYvRLsYkTXgJMqj3ke+xHVlcn5TFnCnmV03WrDL
         BhctfRA8f+bLznPCRN0p8vOEGEi5/5UoZSAXB/M2ADu4lfX0O9zFnR5QDbDG3DXqol0J
         doxd1cJ+4UJxSL4zrPWJ1bqIoD1bOjOqcl6jcBOloNB4SdjA69mdUJztHneCQPPm/ZcY
         sItQ==
X-Gm-Message-State: AOJu0YwKmmmf8BYRor54QI0491/1mPUsgD2O1B3JiVuarjAGcTQdYSPK
        52da77YE8E2Zzg4f3N9W4gD/tABlzu0u
X-Google-Smtp-Source: AGHT+IGHFmw+z6ECEaVn7NDn8YhvRcI3CTcWzU7lbkAR2EO4ibelUVluW979zggJYCVEk4uuoqNHxpwkE5el
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a81:ad0f:0:b0:58c:8c9f:c05a with SMTP id
 l15-20020a81ad0f000000b0058c8c9fc05amr3143ywh.9.1692393337591; Fri, 18 Aug
 2023 14:15:37 -0700 (PDT)
Date:   Fri, 18 Aug 2023 14:15:32 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818211533.2523697-1-zokeefe@google.com>
Subject: [PATCH v2 1/2] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
From:   "Zach O'Keefe" <zokeefe@google.com>
To:     linux-mm@kvack.org, Yang Shi <shy828301@gmail.com>
Cc:     linux-kernel@vger.kernel.org, "Zach O'Keefe" <zokeefe@google.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
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

The 6.0 commits:

commit 9fec51689ff6 ("mm: thp: kill transparent_hugepage_active()")
commit 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")

merged "can we have THPs in this VMA?" logic that was previously done
separately by fault-path, khugepaged, and smaps "THPeligible" checks.

During the process, the semantics of the fault path check changed in two
ways:

1) A VM_NO_KHUGEPAGED check was introduced (also added to smaps path).
2) We no longer checked if non-anonymous memory had a vm_ops->huge_fault
   handler that could satisfy the fault.  Previously, this check had been
   done in create_huge_pud() and create_huge_pmd() routines, but after
   the changes, we never reach those routines.

During the review of the above commits, it was determined that in-tree
users weren't affected by the change; most notably, since the only relevant
user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which is
explicitly approved early in approval logic.  However, there is at least
one occurrence where an out-of-tree driver that used
VM_HUGEPAGE|VM_MIXEDMAP with a vm_ops->huge_fault handler, was broken.

Remove the VM_NO_KHUGEPAGED check when not in collapse path and give
any ->huge_fault handler a chance to handle the fault.  Note that we
don't validate the file mode or mapping alignment, which is consistent
with the behavior before the aforementioned commits.

Fixes: 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
Reported-by: Saurabh Singh Sengar <ssengar@microsoft.com>
Signed-off-by: Zach O'Keefe <zokeefe@google.com>
Cc: Yang Shi <shy828301@gmail.com>
---
Changed from v1[1]:
	- [Saurabhi] Allow ->huge_fault handler to handle fault, if it exists

[1] https://lore.kernel.org/linux-mm/CAAa6QmQw+F=o6htOn=6ADD6mwvMO=Ow_67f3ifBv3GpXx9Xg_g@mail.gmail.com/

---
 mm/huge_memory.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index eb3678360b97..cd379b2c077b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -96,11 +96,11 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 		return in_pf;
 
 	/*
-	 * Special VMA and hugetlb VMA.
+	 * khugepaged special VMA and hugetlb VMA.
 	 * Must be checked after dax since some dax mappings may have
 	 * VM_MIXEDMAP set.
 	 */
-	if (vm_flags & VM_NO_KHUGEPAGED)
+	if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
 		return false;
 
 	/*
@@ -128,12 +128,15 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 					   !hugepage_flags_always())))
 		return false;
 
-	/* Only regular file is valid */
-	if (!in_pf && file_thp_enabled(vma))
-		return true;
-
 	if (!vma_is_anonymous(vma))
-		return false;
+		return in_pf ?
+			/*
+			 * Trust that ->huge_fault() handlers know
+			 * what they are doing in fault path.
+			 */
+			!!vma->vm_ops->huge_fault :
+			/* Only regular file is valid in collapse path */
+			file_thp_enabled(vma);
 
 	if (vma_is_temporary_stack(vma))
 		return false;
-- 
2.42.0.rc1.204.g551eb34607-goog

