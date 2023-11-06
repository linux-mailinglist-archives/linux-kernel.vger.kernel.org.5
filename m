Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F05A7E2F98
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjKFWKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjKFWKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:10:08 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8DFD47
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:10:04 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ce4e0e2bdso2870386276.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 14:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699308603; x=1699913403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ndxuLkPMKyChC51AXz0puMMS4+/C4wl7scpf4W3agH4=;
        b=Jtq2pPwva/fCp5CQxd3z1o/8kv1Ct0fONL9f1YDDuruSBqudt25s3yGJFSTrPnPup5
         zTCQSKa1cemDRfykU5nmYPFnGuRWV4iaDfM/oPf7wnBqPHjvo4/ZseQkPhUPFBeR0rC4
         WOdY7vjGDWFlu5B1SafaEevz175jTLKUJlUHyKahKxymK3A+lmh/SYjTSkhdrITTp6WS
         /N+kh4HSwws1Mf5secjkk5uR2880jbXou5XO5Hpg/Z9zSKtClr8xXNF20D6DKVOTvJHE
         wq/MLqG3LprcS81QlAGv+IQY8R14BuW5K+VJXN4E5VZjgELuIf2eb1radHhd83FL2K9O
         TD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308603; x=1699913403;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndxuLkPMKyChC51AXz0puMMS4+/C4wl7scpf4W3agH4=;
        b=SGyOsBMCtIkrzeC0xoI7TryezAw95Hoe/wt2kNQYw+xIiMRhUXCWBeL8/p1U/bFGRL
         JU1ON1pvMaZ68X9Wim10EpfBTr3wZ6NuyOX7Sg5M1PNz4QA8TVAGuxT6YoouoEmeecWq
         WbhnVbK5ZF+kCLyYNpt2BcDvT14GylNqcuKXnGXvoXG/MIEKr3IJfSGNL/RgfTIBn7F5
         kFGl/WzArp8VIxn0dWlZGJxeXw5Phq2u3Wlf0OMSVWWv0xc1qSMxpklGI9YECbhvlntd
         7VchXj0q52AS4ty+TX4H2FPosc2j1QFN8CMeE0PX4VE/oixBfsnZd7wdci1aF38BiewK
         aoEg==
X-Gm-Message-State: AOJu0Yx0Ft0X9JZ9pKIYwpN/n/Gl2rsnXGtvGoSGeSIOqwePoK89NU2D
        kfBPifStP8lJKq7KkwEhGQFcPDO7ybo=
X-Google-Smtp-Source: AGHT+IE1pB2FoWw+i0OF0BYXCw1D3qfFl5FaeAgXOoMMwsSqKELbiaufpdh916KNcWKh3d1/AAVQhirR4uE=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:10:b187:459d:af36:db4c])
 (user=avagin job=sendgmr) by 2002:a25:ce94:0:b0:da0:3bea:cdc7 with SMTP id
 x142-20020a25ce94000000b00da03beacdc7mr546295ybe.2.1699308603190; Mon, 06 Nov
 2023 14:10:03 -0800 (PST)
Date:   Mon,  6 Nov 2023 14:09:58 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231106220959.296568-1-avagin@google.com>
Subject: [PATCH 1/2 v2] fs/proc/task_mmu: report SOFT_DIRTY bits through the
 PAGEMAP_SCAN ioctl
From:   Andrei Vagin <avagin@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@google.com>,
        "=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=" <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
v2: check the soft-dirty bit in pagemap_page_category

 Documentation/admin-guide/mm/pagemap.rst |  1 +
 fs/proc/task_mmu.c                       | 17 ++++++++++++++++-
 include/uapi/linux/fs.h                  |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

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
--=20
2.42.0.869.gea05f2083d-goog

