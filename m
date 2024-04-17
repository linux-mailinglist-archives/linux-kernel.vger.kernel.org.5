Return-Path: <linux-kernel+bounces-149256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B483F8A8DDE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 421EE1F21AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 21:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ED980C14;
	Wed, 17 Apr 2024 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/HLh8UM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDFA657B6
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713389157; cv=none; b=ARYG4vlLpwxHielZ1sKR9cQw3AsY0J/KNdrg4zQQCZtJ19K1PFHkHxXSo5excB8ulOrX2WNzOwayUIJyvwsY/j9FyjGTkTFrHlJZ1C91hw9bdS+hSSdZvJzuQCgXryCs0QsuTL5R83OJGT1VCIl9iO5YRkQ+QSeHbgiILsKvu7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713389157; c=relaxed/simple;
	bh=MBpGy9Ue64Hb6UYghGr8bplLJSA6IgQyGkdfMqFOpHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fkN+D79MQ+4jX5hRYF3Nspx8guhfhgulu30ryPNyXzTNMeNfIHghuCy9WCauUc+81Y8rBeU6uGfDxGa0pEGB0HKsaRg+E1fdTRbGIOl31+cZPZsR8tki6vWKH+LWnr5bJKLEmdXoOgnZhgtnqtUnbcdmjrF43PYUueo2OZAF9EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/HLh8UM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713389154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ahj2taeFOxrKqKUGuyCB3eGq6ZHz9BjeESNc79q5P5w=;
	b=Z/HLh8UMS+lsf5reQ5r/bokDNEB1fDReFPoQqRAvNJTdjiuj00I9PFcu94w1bN5TPeUkc2
	uEW+7CO4JZl5J0aRt/mjci9TMzqx4IuoYiCoVhBG9V4Ir1TwpKCfTCBNrmBCfvkcIl2wYd
	xJi2U8O2Leb7hKlTNsYzaNQvDeNOzTw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-b30-lUQbMimzVWR1ZpqF0A-1; Wed, 17 Apr 2024 17:25:53 -0400
X-MC-Unique: b30-lUQbMimzVWR1ZpqF0A-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5acdbfb49daso62493eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713389152; x=1713993952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahj2taeFOxrKqKUGuyCB3eGq6ZHz9BjeESNc79q5P5w=;
        b=PmRofXKbuhrULPLu4qmk1nDLs9TxmbxRt2N/f9wtwX/jwYE3UHUhuWgPMCxghYPkw0
         620XxHUtJo2qnsU/j8Rb2o44HjWwOAvtXTF3o1rGx9UC4xub4empzUDJAel8PB0rcbSH
         e0Pq2Hkv+34nvTdlp6/ki8qYojiyOINTBj7vB2GhSGLt83kV7/WCYqaSVuOA/GOKwL1j
         PwcGkCezwn4jFPAYUYwQZhB6Ec+cOPDoAVscl/+fddoB/K0ptwZUvXIZYKJtwOtquxSD
         zUICGQXEaDibkH7uVchd4cV5EFFBaA3/Z9AQnCEEeFdvaXHHkVMHkrdNIiV6FTZBf/G3
         zs+g==
X-Forwarded-Encrypted: i=1; AJvYcCUYcsCMteEf4fKJHn9WE/N8uWGPHfddZAThxzR4UxBejckQBmYv7BPTil126ezQWaW+dk/WGmQnAAHZAcQAzjQd3G4dYBGhefWjsbAO
X-Gm-Message-State: AOJu0Yx18W+ddKy12LNt3wbjbHU8mLWH6v4jKgyGcPF6CbRHFtt1Msmn
	UlWbpcU+700UgWjyG/9x4aP2KMO5RP5u00OVHHc/ngRs58OTC5mIv0YknNHb7l8bmyAFcNItlZK
	akjzwD4sv6yLcnn7KAjm3Vt3AIsuWIFSbFDL7HNRnWIA2maifNLdYWponrlYdUg==
X-Received: by 2002:a05:6358:88e:b0:186:43ee:8d32 with SMTP id m14-20020a056358088e00b0018643ee8d32mr699688rwj.3.1713389152177;
        Wed, 17 Apr 2024 14:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtDZFWDX2pFLDDeWFFYKjqvQrUADLN/TxQZFeEHDALfL/PjWEmHUVYEoXcLY7cj8DYh1dCFQ==
X-Received: by 2002:a05:6358:88e:b0:186:43ee:8d32 with SMTP id m14-20020a056358088e00b0018643ee8d32mr699661rwj.3.1713389151515;
        Wed, 17 Apr 2024 14:25:51 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id p10-20020a0c8c8a000000b0069942a53f46sm30653qvb.53.2024.04.17.14.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 14:25:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	peterx@redhat.com,
	Nadav Amit <nadav.amit@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH v4] mm/page_table_check: Support userfault wr-protect entries
Date: Wed, 17 Apr 2024 17:25:49 -0400
Message-ID: <20240417212549.2766883-1-peterx@redhat.com>
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
v3:
- Add missing doc update [Pasha]
v4:
- Fix wordings in doc, use more elegant swap helpers [Pasha]
---
 Documentation/mm/page_table_check.rst |  9 +++++++-
 arch/x86/include/asm/pgtable.h        | 18 +---------------
 mm/page_table_check.c                 | 30 +++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/Documentation/mm/page_table_check.rst b/Documentation/mm/page_table_check.rst
index c12838ce6b8d..c59f22eb6a0f 100644
--- a/Documentation/mm/page_table_check.rst
+++ b/Documentation/mm/page_table_check.rst
@@ -14,7 +14,7 @@ Page table check performs extra verifications at the time when new pages become
 accessible from the userspace by getting their page table entries (PTEs PMDs
 etc.) added into the table.
 
-In case of detected corruption, the kernel is crashed. There is a small
+In case of most detected corruption, the kernel is crashed. There is a small
 performance and memory overhead associated with the page table check. Therefore,
 it is disabled by default, but can be optionally enabled on systems where the
 extra hardening outweighs the performance costs. Also, because page table check
@@ -22,6 +22,13 @@ is synchronous, it can help with debugging double map memory corruption issues,
 by crashing kernel at the time wrong mapping occurs instead of later which is
 often the case with memory corruptions bugs.
 
+It can also be used to do page table entry checks over various flags, dump
+warnings when illegal combinations of entry flags are detected.  Currently,
+userfaultfd is the only user of such to sanity check wr-protect bit against
+any writable flags.  Illegal flag combinations will not directly cause data
+corruption in this case immediately, but that will cause read-only data to
+be writable, leading to corrupt when the page content is later modified.
+
 Double mapping detection logic
 ==============================
 
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
index af69c3c8f7c2..4169576bed72 100644
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
@@ -182,6 +184,22 @@ void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
 }
 EXPORT_SYMBOL(__page_table_check_pud_clear);
 
+/* Whether the swap entry cached writable information */
+static inline bool swap_cached_writable(swp_entry_t entry)
+{
+	return is_writable_device_exclusive_entry(entry) ||
+	    is_writable_device_private_entry(entry) ||
+	    is_writable_migration_entry(entry);
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
@@ -190,6 +208,8 @@ void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
 	if (&init_mm == mm)
 		return;
 
+	page_table_check_pte_flags(pte);
+
 	for (i = 0; i < nr; i++)
 		__page_table_check_pte_clear(mm, ptep_get(ptep + i));
 	if (pte_user_accessible_page(pte))
@@ -197,11 +217,21 @@ void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
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


