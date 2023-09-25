Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A877C7AE02D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjIYUB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYUBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:01:25 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B573110C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 13:01:18 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c2ca3bcf9so134649387b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 13:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695672078; x=1696276878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zmn8UWXrJoykttF2WL0ItLwCoiyMGCPwIkseCGByc8Y=;
        b=qQHVJZOeERvwGglS6nJtg3QgMycP+eC9XYQXnqFKA+1TjQBXsNvepv8NEB70lpglXe
         FyMriTsIOp7ul47hpTVdhcvNto8A7K78vLXlYx2wFoZPs7W8OeM+qURNgMhqMKX2jGTt
         +X/Iat2n3k/XyqqBH5EZRn45fuK7nkhgkbdYzABloB6qzcoBzvIWgk2TFbR7uDi6URXz
         er5bK8AaNf3IOZWc9tPEYmQnPGWCyEhqdiHVkDC9Z22qkli962KPYXwo7j04r1acDoGM
         oI3hN8/n1RHwbs7e6ADJ2J1ryuABxNjVHuJHi5l/SAHuGREHS1MbDMNx4LcchEopmp2U
         gU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695672078; x=1696276878;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zmn8UWXrJoykttF2WL0ItLwCoiyMGCPwIkseCGByc8Y=;
        b=ghqrVFknaQ6af7oPFDJZw39Sjb5dicjhxMN00c0oY3F/0vzUivSBl0Smxzlc/OdCrX
         wVm+/UcAxu6vl4TE1ZJtAW+tJTX8ML2JKrd/gLGVfAuHBjk2c9Kzd8P5dcFeXZFxKBLR
         R5PojUedh+R9ES7wWyRBrgcWJ4qB+28DQO2NqZO++E9TG4+3LU1dmcQ0RfDUevCCyANN
         EgMC5x8FjXmuEMiJbaP5NKa9xdHghZ8gkV6aIIhfnEPyTD6SlgL0cmwH+iixq3ABSKWs
         jL38Riut7Ej9lEl7wc0n4GmSaXGOpQ7hJFZCCrbVPMBUa8u/sRjaiFZxtVTlvwF25mzb
         Cv3Q==
X-Gm-Message-State: AOJu0YxOVrIgQfcg2uNf4GGgk2NT41rJmMgmSwrgbjDiRFYICrL9lo4W
        v/sM1z2AZmLmxZuJwxuJqo9lTht0Gf6G
X-Google-Smtp-Source: AGHT+IHynGz8uTuhPCcteQ9fRpzZKQn4SfmpahOj3xEXuSYuZ5PekHFLjW28hJJbizPAzZP6dnw3loQr/g5+
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2971])
 (user=zokeefe job=sendgmr) by 2002:a81:e503:0:b0:59b:e81f:62ab with SMTP id
 s3-20020a81e503000000b0059be81f62abmr92301ywl.7.1695672077978; Mon, 25 Sep
 2023 13:01:17 -0700 (PDT)
Date:   Mon, 25 Sep 2023 13:01:10 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230925200110.1979606-1-zokeefe@google.com>
Subject: [PATCH v4] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
From:   "Zach O'Keefe" <zokeefe@google.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, "Zach O'Keefe" <zokeefe@google.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
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
explicitly approved early in approval logic. However, this was a bad
assumption to make as it assumes the only reason to support ->huge_fault
was for DAX (which is not true in general).

Remove the VM_NO_KHUGEPAGED check when not in collapse path and give
any ->huge_fault handler a chance to handle the fault.  Note that we
don't validate the file mode or mapping alignment, which is consistent
with the behavior before the aforementioned commits.

Fixes: 7da4e2cb8b1f ("mm: thp: kill __transhuge_page_enabled()")
Reported-by: Saurabh Singh Sengar <ssengar@microsoft.com>
Signed-off-by: Zach O'Keefe <zokeefe@google.com>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
---
I've updated the changelog to reflect discussions in [1] -- leaving
ack to David / Matthew on whether to take the patch.

Changed from v3[1]:
	- [akpm / David H. / M. Wilcox] Updated log to capture email discussion
Changed from v2[2]:
	- Fixed false negative in smaps check when !dax && ->huge_fault
Changed from v1[3]:
	- [Saurabhi] Allow ->huge_fault handler to handle fault, if it exists

[1] https://lore.kernel.org/linux-mm/20230821234844.699818-1-zokeefe@google.com/
[2] https://lore.kernel.org/linux-mm/20230818211533.2523697-1-zokeefe@google.com/
[3] https://lore.kernel.org/linux-mm/CAAa6QmQw+F=o6htOn=6ADD6mwvMO=Ow_67f3ifBv3GpXx9Xg_g@mail.gmail.com/

---
 mm/huge_memory.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0f93a73115f73..797fe617e51ab 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -100,11 +100,11 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
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
@@ -132,12 +132,18 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
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
2.42.0.515.g380fc7ccd1-goog

