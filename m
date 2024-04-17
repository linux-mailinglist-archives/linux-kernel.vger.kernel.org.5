Return-Path: <linux-kernel+bounces-149083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018718A8B9F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6291F22703
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3651CAAC;
	Wed, 17 Apr 2024 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8s6c60V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13434BE55
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713379945; cv=none; b=fL0IKUcjraDcw5b0BCJl3sOyQ7zLPFYXUUKlIySWVrtrVzB0QfAbJwHK0MLD8eyDIRXWxQ5a9tI8z2LSq9b3C1MxHOG3R9mJ5PauQFwY7OFzKctWndpM0wL0Eg+SPkDM9mBpPE9hl5Q1WCrU8JTkwngZfSjRzf6+3H8cSMYrFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713379945; c=relaxed/simple;
	bh=74jMQuzSh36qJ8FYaLBTkvL3mGU+qxFSRe5NGvyNMV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QXZveys23E901GwBNpT/pJT+4FxcRwgFiTI0GxCtHJYi+/p/QPt3a6CUq0/7KmxEfC/ru5tLJnZT2guDEdJdi44kLRu4ZqNuqqVNh035HW/9MTpq0v2UqYCc5RWqHaIRy/aeSzMkJWFqP/0DA9SkoerFajx1vAnMQH/wNZbq/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e8s6c60V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713379942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Tew7DnBHXv/dAADkrspYwkAgLRodYl6fxKKd2qlbBpE=;
	b=e8s6c60VIux6GnAOEpLuwm/eX4V9ugBCI/jOpR3SpuFYRGoXJxJjT71VKySVwcyF2Tt339
	uObv/S+JNVR4SPRO0m5TWskKhpWDgONcBH+D7yZ2+XoPv0L7vRwqMIWJ0Y5FqJ4+IB+sF1
	EtIMmcvZVIOoWqwtVfAW009NTTVUYqE=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-L80dOE5aP-aW2kelaO0ugQ-1; Wed, 17 Apr 2024 14:52:21 -0400
X-MC-Unique: L80dOE5aP-aW2kelaO0ugQ-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-47ba363a879so6213137.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:52:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713379941; x=1713984741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tew7DnBHXv/dAADkrspYwkAgLRodYl6fxKKd2qlbBpE=;
        b=SfiBUG+TFClgy+6zRRGd+L5T70Tc4jN0Nc0hTKxTVnKt7Zw0IKP2j31sONxlpBqabq
         speBSkhIuZkkyKj/qLoQVYHlVsyA6ZueBg+XNiWVChOH+LDH7ulCLk0aN9f9bgcFLpkM
         dzqsIL2X9GlMtZR8gewzRrGH4Tpm2cbLv86pCM+5k0wMIQFbG89OFL4J2NgpFE1NQkUs
         NZtSXEuU4n7W9d+MrL1BuzuU7FnpR2NdHfGmDWc8t6Isy8cyBjI0eh5Od9ulSvV0F/CT
         TON7ziy9JtdHaNvuDXU5BQEngI7kuabVHnqLVR/nOMLCzz5euB+P6T96Gww7DL37RSkl
         RTVQ==
X-Gm-Message-State: AOJu0YzqHYJIlfABZ3c2AwM8Bnaj3nkukrAhOVfU7hoIYZkRAkxdj4ha
	mnN/eGv+d8haq5eLM4J/bFub/3fb6GvVFu+BxML51A8NaIH7vVSq+YF771x44jth74TU85LmvRM
	JHFwOyRd99tnw8I+U28thc1sJeUgXCWv6jFuKBd39+0J6Umgu+N0EQWD90duhvVmQ5ETVDxkG5d
	6vQwUPFzsDSv/l4mDs/rebPfvt8HzHD8NgIdmBYCgKi98=
X-Received: by 2002:a1f:f449:0:b0:4d4:eb8:bf1f with SMTP id s70-20020a1ff449000000b004d40eb8bf1fmr616732vkh.0.1713379940566;
        Wed, 17 Apr 2024 11:52:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmvQhcK7g/g6HfsIin2L5g7CUCALj6zs9ezToh7Mi8fEGATINcPL4QIMIzANzqRCW/PtUe6A==
X-Received: by 2002:a1f:f449:0:b0:4d4:eb8:bf1f with SMTP id s70-20020a1ff449000000b004d40eb8bf1fmr616688vkh.0.1713379939338;
        Wed, 17 Apr 2024 11:52:19 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id ne22-20020a056214425600b006a04769b5a7sm738831qvb.110.2024.04.17.11.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 11:52:19 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] mm/page_table_check: Support userfault wr-protect entries
Date: Wed, 17 Apr 2024 14:52:17 -0400
Message-ID: <20240417185217.2667853-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow page_table_check hooks to check over userfaultfd wr-protect criteria
upon pgtable updates.  The rule is no co-existance allowed for any writable
flag against userfault wr-protect flag.

This should be better than c2da319c2e, where we used to only sanitize such
issues during a pgtable walk, but when hitting such issue we don't have a
good chance to know where does that writable bit came from [1], so that
even the pgtable walk exposes a kernel bug (which is still helpful on
triaging) but not easy to track and debug.

Now we switch to track the source.  It's much easier too with the recent
introduction of page table check.

There are some limitations with using the page table check here for
userfaultfd wr-protect purpose:

  - It is only enabled with explicit enablement of page table check configs
  and/or boot parameters, but should be good enough to track at least
  syzbot issues, as syzbot should enable PAGE_TABLE_CHECK[_ENFORCED] for
  x86 [1].  We used to have DEBUG_VM but it's now off for most distros,
  while distros also normally not enable PAGE_TABLE_CHECK[_ENFORCED], which
  is similar.

  - It conditionally works with the ptep_modify_prot API.  It will be
  bypassed when e.g. XEN PV is enabled, however still work for most of the
  rest scenarios, which should be the common cases so should be good
  enough.

  - Hugetlb check is a bit hairy, as the page table check cannot identify
  hugetlb pte or normal pte via trapping at set_pte_at(), because of the
  current design where hugetlb maps every layers to pte_t... For example,
  the default set_huge_pte_at() can invoke set_pte_at() directly and lose
  the hugetlb context, treating it the same as a normal pte_t. So far it's
  fine because we have huge_pte_uffd_wp() always equals to pte_uffd_wp() as
  long as supported (x86 only).  It'll be a bigger problem when we'll
  define _PAGE_UFFD_WP differently at various pgtable levels, because then
  one huge_pte_uffd_wp() per-arch will stop making sense first.. as of now
  we can leave this for later too.

This patch also removes commit c2da319c2e altogether, as we have something
better now.

[1] https://lore.kernel.org/all/000000000000dce0530615c89210@google.com/

Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- Rename __page_table_check_pxx() to page_table_check_pxx_flags(),
  meanwhile move the pte check out of the loop [Pasha]
- Fix build issues reported from the bot, also added SWP_DEVICE_WRITE which
  was overlooked before
---
 arch/x86/include/asm/pgtable.h | 18 +---------------
 mm/page_table_check.c          | 39 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 273f7557218c..65b8e5bb902c 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -388,23 +388,7 @@ static inline pte_t pte_wrprotect(pte_t pte)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static inline int pte_uffd_wp(pte_t pte)
 {
-	bool wp = pte_flags(pte) & _PAGE_UFFD_WP;
-
-#ifdef CONFIG_DEBUG_VM
-	/*
-	 * Having write bit for wr-protect-marked present ptes is fatal,
-	 * because it means the uffd-wp bit will be ignored and write will
-	 * just go through.
-	 *
-	 * Use any chance of pgtable walking to verify this (e.g., when
-	 * page swapped out or being migrated for all purposes). It means
-	 * something is already wrong.  Tell the admin even before the
-	 * process crashes. We also nail it with wrong pgtable setup.
-	 */
-	WARN_ON_ONCE(wp && pte_write(pte));
-#endif
-
-	return wp;
+	return pte_flags(pte) & _PAGE_UFFD_WP;
 }
 
 static inline pte_t pte_mkuffd_wp(pte_t pte)
diff --git a/mm/page_table_check.c b/mm/page_table_check.c
index af69c3c8f7c2..388bcf60d8b5 100644
--- a/mm/page_table_check.c
+++ b/mm/page_table_check.c
@@ -7,6 +7,8 @@
 #include <linux/kstrtox.h>
 #include <linux/mm.h>
 #include <linux/page_table_check.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"page_table_check: " fmt
@@ -182,6 +184,31 @@ void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
 }
 EXPORT_SYMBOL(__page_table_check_pud_clear);
 
+/* Whether the swap entry cached writable information */
+static inline bool swap_cached_writable(swp_entry_t entry)
+{
+	unsigned type = swp_type(entry);
+
+#ifdef CONFIG_DEVICE_PRIVATE
+	if (type == SWP_DEVICE_EXCLUSIVE_WRITE || type == SWP_DEVICE_WRITE)
+		return true;
+#endif
+#ifdef CONFIG_MIGRATION
+	if (type == SWP_MIGRATION_WRITE)
+		return true;
+#endif
+
+	return false;
+}
+
+static inline void page_table_check_pte_flags(pte_t pte)
+{
+	if (pte_present(pte) && pte_uffd_wp(pte))
+		WARN_ON_ONCE(pte_write(pte));
+	else if (is_swap_pte(pte) && pte_swp_uffd_wp(pte))
+		WARN_ON_ONCE(swap_cached_writable(pte_to_swp_entry(pte)));
+}
+
 void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
 		unsigned int nr)
 {
@@ -190,6 +217,8 @@ void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
 	if (&init_mm == mm)
 		return;
 
+	page_table_check_pte_flags(pte);
+
 	for (i = 0; i < nr; i++)
 		__page_table_check_pte_clear(mm, ptep_get(ptep + i));
 	if (pte_user_accessible_page(pte))
@@ -197,11 +226,21 @@ void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
 }
 EXPORT_SYMBOL(__page_table_check_ptes_set);
 
+static inline void page_table_check_pmd_flags(pmd_t pmd)
+{
+	if (pmd_present(pmd) && pmd_uffd_wp(pmd))
+		WARN_ON_ONCE(pmd_write(pmd));
+	else if (is_swap_pmd(pmd) && pmd_swp_uffd_wp(pmd))
+		WARN_ON_ONCE(swap_cached_writable(pmd_to_swp_entry(pmd)));
+}
+
 void __page_table_check_pmd_set(struct mm_struct *mm, pmd_t *pmdp, pmd_t pmd)
 {
 	if (&init_mm == mm)
 		return;
 
+	page_table_check_pmd_flags(pmd);
+
 	__page_table_check_pmd_clear(mm, *pmdp);
 	if (pmd_user_accessible_page(pmd)) {
 		page_table_check_set(pmd_pfn(pmd), PMD_SIZE >> PAGE_SHIFT,
-- 
2.44.0


