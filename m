Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034257E464B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 17:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjKGQls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 11:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjKGQlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 11:41:46 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB19293
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 08:41:44 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc385e90a9so40804415ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 08:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699375304; x=1699980104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJTyn/MQ0wtUc81GXLOJfql+NHWVQ1+0MlJSpHwULk4=;
        b=Al0UgESHAjmGoQuSRzl6EWPFDZ2RPipkuFr9fojWXouNlUmEXz5f9NbzKEiLBdIGnu
         xESK/7bvXKpFmXLiKG3rXBu9rmpaTDDgfrQNNSDwK1Ti46gIz01sF1KBhQ5B1pDRMFB9
         sanpqTVlvfjIzOMJ1sTAa43dDjWYrPKPWSa4CQijQNo4nkP99w8TzJmmvx8yc0oOQP/E
         buWWXbd4JnjmvXRrtUXQcJBG0KRlvw+q0wuVdx5JBOgM6F47U+8ErZH5bBeKi0fQV8rx
         82MWZ20Sp+8qVa1zDMr8LlAdgv2k3SjdRzKIPwP5dvEAhmxUJifNwGelhFu4sqSlTqCa
         wbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699375304; x=1699980104;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJTyn/MQ0wtUc81GXLOJfql+NHWVQ1+0MlJSpHwULk4=;
        b=s9v3iJX/hrQa5F26Cp4lQMArQ8G2ulTGZ2J7JVN6nJHww9XZc0+T6kHtZym5kBqDmP
         HCqI11/ZwyL304Oz00FxO18dK27MHz6VY6YEFYGX/F8uNuZ2t1T8S9e0sEpxzzuAMmDn
         irOF8Nn5blGOLimzL4wntA+XcR1+7Ooh+bYhlUFYzfqa/SmfFZT2n6ZruBpk2mG+MetW
         OuGUfNhlxMjyDhsfQR3j47EOTfGOAteRe6yVMkYyVyhLGiQ5NvGjbs2o8zLWqtxAp+7I
         uQerQxEqjGTiAcb65PxycVoQBK+y3JlPKOF8EY3JMqztI/KFySbfTuHAX4NvD/cBp5L9
         o78Q==
X-Gm-Message-State: AOJu0YzNcxyRWoA2B8cgioe+Zu15A9gqBCRQLJhRhvDQFNM2+cXhMD0A
        +6Iov4bXcAnPOArWk84Nci8zDbIBZQ4=
X-Google-Smtp-Source: AGHT+IEJ0YCArcLB1KynYznhKlnI6/Z0unmvbii+kF//7GFmP3XJWVOLkXnhDLafJNk+NiIe6Wzu7TnsHIk=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:10:38b1:2ca1:f401:605a])
 (user=avagin job=sendgmr) by 2002:a17:903:2609:b0:1b8:8c7:31e6 with SMTP id
 jd9-20020a170903260900b001b808c731e6mr605864plb.1.1699375304213; Tue, 07 Nov
 2023 08:41:44 -0800 (PST)
Date:   Tue,  7 Nov 2023 08:41:37 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107164139.576046-1-avagin@google.com>
Subject: [PATCH 1/2 v3] fs/proc/task_mmu: report SOFT_DIRTY bits through the
 PAGEMAP_SCAN ioctl
From:   Andrei Vagin <avagin@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
        "=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=" <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PAGEMAP_SCAN ioctl returns information regarding page table entries.
It is more efficient compared to reading pagemap files. CRIU can start
to utilize this ioctl, but it needs info about soft-dirty bits to track
memory changes.

We are aware of a new method for tracking memory changes implemented in
the PAGEMAP_SCAN ioctl. For CRIU, the primary advantage of this method
is its usability by unprivileged users. However, it is not feasible to
transparently replace the soft-dirty tracker with the new one. The main
problem here is userfault descriptors that have to be preserved between
pre-dump iterations.  It means criu continues supporting the soft-dirty
method to avoid breakage for current users. The new method will be
implemented as a separate feature.

Cc: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
v2: check the soft-dirty bit in pagemap_page_category
v3: update tools/include/uapi/linux/fs.h

 Documentation/admin-guide/mm/pagemap.rst |  1 +
 fs/proc/task_mmu.c                       | 17 ++++++++++++++++-
 include/uapi/linux/fs.h                  |  1 +
 tools/include/uapi/linux/fs.h            |  1 +
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin=
-guide/mm/pagemap.rst
index fe17cf210426..f5f065c67615 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -253,6 +253,7 @@ Following flags about pages are currently supported:
 - ``PAGE_IS_SWAPPED`` - Page is in swapped
 - ``PAGE_IS_PFNZERO`` - Page has zero PFN
 - ``PAGE_IS_HUGE`` - Page is THP or Hugetlb backed
+- ``PAGE_IS_SOFT_DIRTY`` - Page is soft-dirty
=20
 The ``struct pm_scan_arg`` is used as the argument of the IOCTL.
=20
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ef2eb12906da..51e0ec658457 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1761,7 +1761,7 @@ static int pagemap_release(struct inode *inode, struc=
t file *file)
 #define PM_SCAN_CATEGORIES	(PAGE_IS_WPALLOWED | PAGE_IS_WRITTEN |	\
 				 PAGE_IS_FILE |	PAGE_IS_PRESENT |	\
 				 PAGE_IS_SWAPPED | PAGE_IS_PFNZERO |	\
-				 PAGE_IS_HUGE)
+				 PAGE_IS_HUGE | PAGE_IS_SOFT_DIRTY)
 #define PM_SCAN_FLAGS		(PM_SCAN_WP_MATCHING | PM_SCAN_CHECK_WPASYNC)
=20
 struct pagemap_scan_private {
@@ -1793,6 +1793,8 @@ static unsigned long pagemap_page_category(struct pag=
emap_scan_private *p,
=20
 		if (is_zero_pfn(pte_pfn(pte)))
 			categories |=3D PAGE_IS_PFNZERO;
+		if (pte_soft_dirty(pte))
+			categories |=3D PAGE_IS_SOFT_DIRTY;
 	} else if (is_swap_pte(pte)) {
 		swp_entry_t swp;
=20
@@ -1806,6 +1808,8 @@ static unsigned long pagemap_page_category(struct pag=
emap_scan_private *p,
 			    !PageAnon(pfn_swap_entry_to_page(swp)))
 				categories |=3D PAGE_IS_FILE;
 		}
+		if (pte_swp_soft_dirty(pte))
+			categories |=3D PAGE_IS_SOFT_DIRTY;
 	}
=20
 	return categories;
@@ -1853,12 +1857,16 @@ static unsigned long pagemap_thp_category(struct pa=
gemap_scan_private *p,
=20
 		if (is_zero_pfn(pmd_pfn(pmd)))
 			categories |=3D PAGE_IS_PFNZERO;
+		if (pmd_soft_dirty(pmd))
+			categories |=3D PAGE_IS_SOFT_DIRTY;
 	} else if (is_swap_pmd(pmd)) {
 		swp_entry_t swp;
=20
 		categories |=3D PAGE_IS_SWAPPED;
 		if (!pmd_swp_uffd_wp(pmd))
 			categories |=3D PAGE_IS_WRITTEN;
+		if (pmd_swp_soft_dirty(pmd))
+			categories |=3D PAGE_IS_SOFT_DIRTY;
=20
 		if (p->masks_of_interest & PAGE_IS_FILE) {
 			swp =3D pmd_to_swp_entry(pmd);
@@ -1905,10 +1913,14 @@ static unsigned long pagemap_hugetlb_category(pte_t=
 pte)
 			categories |=3D PAGE_IS_FILE;
 		if (is_zero_pfn(pte_pfn(pte)))
 			categories |=3D PAGE_IS_PFNZERO;
+		if (pte_soft_dirty(pte))
+			categories |=3D PAGE_IS_SOFT_DIRTY;
 	} else if (is_swap_pte(pte)) {
 		categories |=3D PAGE_IS_SWAPPED;
 		if (!pte_swp_uffd_wp_any(pte))
 			categories |=3D PAGE_IS_WRITTEN;
+		if (pte_swp_soft_dirty(pte))
+			categories |=3D PAGE_IS_SOFT_DIRTY;
 	}
=20
 	return categories;
@@ -1991,6 +2003,9 @@ static int pagemap_scan_test_walk(unsigned long start=
, unsigned long end,
 	if (vma->vm_flags & VM_PFNMAP)
 		return 1;
=20
+	if (vma->vm_flags & VM_SOFTDIRTY)
+		vma_category |=3D PAGE_IS_SOFT_DIRTY;
+
 	if (!pagemap_scan_is_interesting_vma(vma_category, p))
 		return 1;
=20
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index da43810b7485..48ad69f7722e 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -316,6 +316,7 @@ typedef int __bitwise __kernel_rwf_t;
 #define PAGE_IS_SWAPPED		(1 << 4)
 #define PAGE_IS_PFNZERO		(1 << 5)
 #define PAGE_IS_HUGE		(1 << 6)
+#define PAGE_IS_SOFT_DIRTY	(1 << 7)
=20
 /*
  * struct page_region - Page region with flags
diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index da43810b7485..48ad69f7722e 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -316,6 +316,7 @@ typedef int __bitwise __kernel_rwf_t;
 #define PAGE_IS_SWAPPED		(1 << 4)
 #define PAGE_IS_PFNZERO		(1 << 5)
 #define PAGE_IS_HUGE		(1 << 6)
+#define PAGE_IS_SOFT_DIRTY	(1 << 7)
=20
 /*
  * struct page_region - Page region with flags
--=20
2.42.0.869.gea05f2083d-goog

