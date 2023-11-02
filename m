Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105337DF8C9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbjKBReH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjKBReE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:34:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8947E19D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:34:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7c97d5d5aso17334167b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698946439; x=1699551239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t9YpU4ldQQXi82QJZDUwjxQ3rP5Gle0TPFZjnEHYbWE=;
        b=iAO77EFAgcWddLYuZKXE9qepfSt6IFGJwn6Vit91jtNgivH798craudB87DgqA4NI0
         yF9laVx2Io+TwAd4gr1Zc85YHGhaVxfUYaHtigsJX8huOk0ZOwUaK0mBAob9/GdF191B
         l2UqC1RYW2QGmNrgrGBeoBKM+bjRVc7b3HuTWPKu22YUHjGefkAKeuoTYZvSOKLNc8GL
         z7W0GwINg+hLMrPitsGGY9hvcx3Yc66SWKOChppm+P1w0Zqsx0W/K1CVb32RjYm7vHUp
         Wc+VmsLV+pvB6DNz7ciZ2pMs/bxVBfYyLtez6UPSytbozioAJsSVb5ZBCbcEqTwWZ1mB
         QIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698946439; x=1699551239;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9YpU4ldQQXi82QJZDUwjxQ3rP5Gle0TPFZjnEHYbWE=;
        b=dxvM97UemH4scW7O4g2pYSuMmO14QlhDy+UBmMZ9jD2RQVyf1rp3kSbPhGjqCDRhG1
         bi9egbf9DYdQi314aLHQOWlX8N2wij1t2Y+6iC/zj++lYLWlplSbdeWVf38u/ukEvqKi
         9iFbgchiKemWe+7o5Kbf2Pr62ps393GEbRymfYyeEstF4fUFTO89iWGhGHAxqyblxA9w
         U6vRUe9SmmjzPMmsSfzGnV7jZzuGLEfttlWPGuXec5IProQ1wVgten4quYNcQJz7ZHFP
         pJqnhL6Fra1zJBlrjgvgrtITzHvcThCx9aPUgKN40ANiJS9igZ20YHY3xknoJvRKuxOa
         ILAg==
X-Gm-Message-State: AOJu0Yyv4oliYf97tG6pPO1oXDHsZCrdOgtAfMbKIEF0Jrrjr/ycdWfg
        3FRTQ8oIO72MMTkDT2ZVjwQ5L70twl4=
X-Google-Smtp-Source: AGHT+IEtlX9obG8wcyu0re0ETqrSDPLviN5zJozM80QKS5E7coB4Dqsk+Dz7Vr71IisMGcVmSjm3FV1Iv5k=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:10:a803:d728:acb2:4622])
 (user=avagin job=sendgmr) by 2002:a0d:ea41:0:b0:5a7:aa51:c08e with SMTP id
 t62-20020a0dea41000000b005a7aa51c08emr7033ywe.1.1698946439720; Thu, 02 Nov
 2023 10:33:59 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:33:57 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102173357.446157-1-avagin@google.com>
Subject: [PATCH] fs/proc/task_mmu: report SOFT_DIRTY bits through the
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
 fs/proc/task_mmu.c      | 13 ++++++++++++-
 include/uapi/linux/fs.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ef2eb12906da..cefa676bd33b 100644
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
@@ -1853,12 +1853,16 @@ static unsigned long pagemap_thp_category(struct pa=
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
@@ -1905,10 +1909,14 @@ static unsigned long pagemap_hugetlb_category(pte_t=
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
@@ -1991,6 +1999,9 @@ static int pagemap_scan_test_walk(unsigned long start=
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

