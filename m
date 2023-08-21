Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE7978367A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjHUXsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjHUXsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:48:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885C6E4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:48:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58cf42a3313so53422927b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692661730; x=1693266530;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YCOyIsFUlLjTnVIlQjRMIQSr9BmEp4/1j6SRmVYuUQQ=;
        b=1vRA8NFDehhZixvfUqi0M0SQpQ2MFDSs44seZB949NKKzBZzpVSxGDWwO/LNrXjrHy
         Ada9q6DbnJx8rN+sOeayQJ4TFmInwlfhnYp0unQOmBy2T+vbbSdOyVnplEv2mJvZ+Dff
         SWMYWuIB0eBOo1HwE8yLGk6cfIC2ia61Kt6fyO4lPPzrlwqb072OXA+mpUn3Wz61zk70
         yvfG0y1E/5HgQJxDdxwmvUU40pkNMUL4jVvCsxGbvVM+JZAZ6YkxUZ7RnqYUA7xg5wq+
         Pn/vFjpRIqpYBlKiPfoBO6l4+ZHwhY2Abs59vVQqDFyNamEoftAu3ozdwKw/sjtLR59T
         lppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692661730; x=1693266530;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCOyIsFUlLjTnVIlQjRMIQSr9BmEp4/1j6SRmVYuUQQ=;
        b=MJn980HTsxiUix7GA5b52fnRXhkXvIbd4nbXEjoUv593LdZ5tgwXuEf+oMKUB+TiuQ
         TndaQtY2rzNl9rodm03aAeSMo3Fa18xtSsMVN+yGrS2SrwWUA1YthqTyRPinYca5ZItB
         /LJnaTqigCqdJtju70xGoPNvQs6ndFRL4ZepXD6Gzg2cJZp4cXFFEA1bvhHZK+o1MqW6
         UFpFhs+6f67eD+y5mYK6H+WSqzd8Ox41R2mVAzBuoDjGD9FA4IJ28pOcTuspjLWhix+w
         OszRyYgaH98OZ5jL7n49HfDu1O633EVldMZplVusma5pPw0u9JjkWUSfOgL19ElyMPtK
         KExQ==
X-Gm-Message-State: AOJu0Yxoi8lO7oS2JAT9Pg5/T+MJ6ggRB02bAOAbsRTNwtxkhOZzH5GW
        kjrEmCdOgiBNtXO2iBcqid51WQVT+2t1
X-Google-Smtp-Source: AGHT+IF/HIypG9hKuqBUy9shzQU2f2lrrmetedwPUcFRd7NrkxJpYSdhCJsQY85/dvUbv4G15qj30HF917UZ
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a81:4304:0:b0:577:619e:d3c9 with SMTP id
 q4-20020a814304000000b00577619ed3c9mr79027ywa.10.1692661729731; Mon, 21 Aug
 2023 16:48:49 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:48:44 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230821234844.699818-1-zokeefe@google.com>
Subject: [PATCH v3] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
From:   "Zach O'Keefe" <zokeefe@google.com>
To:     linux-mm@kvack.org, Yang Shi <shy828301@gmail.com>
Cc:     linux-kernel@vger.kernel.org, "Zach O'Keefe" <zokeefe@google.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
Changed from v2[1]:
	- Fixed false negative in smaps check when !dax && ->huge_fault
Changed from v1[2]:
	- [Saurabhi] Allow ->huge_fault handler to handle fault, if it exists

There are some logical holes in smaps' THPeligible checks here, but those
are best dealt with in follow-up patches.  For now, just make sure the
fault path is dealt with.

[1] https://lore.kernel.org/linux-mm/20230818211533.2523697-1-zokeefe@google.com/
[2] https://lore.kernel.org/linux-mm/CAAa6QmQw+F=o6htOn=6ADD6mwvMO=Ow_67f3ifBv3GpXx9Xg_g@mail.gmail.com/

---
 mm/huge_memory.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index eb3678360b97..901dcf8db8d2 100644
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
@@ -128,12 +128,18 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 					   !hugepage_flags_always())))
 		return false;
 
-	/* Only regular file is valid */
-	if (!in_pf && file_thp_enabled(vma))
-		return true;
-
-	if (!vma_is_anonymous(vma))
+	if (!vma_is_anonymous(vma)) {
+		/*
+		 * Trust that ->huge_fault() handlers know what they are doing
+		 * in fault path.
+		 */
+		if (((in_pf || smaps)) && vma->vm_ops->huge_fault)
+			return true;
+		/* Only regular file is valid in collapse path */
+		if (((!in_pf || smaps)) && file_thp_enabled(vma))
+			return true;
 		return false;
+	}
 
 	if (vma_is_temporary_stack(vma))
 		return false;
-- 
2.42.0.rc1.204.g551eb34607-goog

