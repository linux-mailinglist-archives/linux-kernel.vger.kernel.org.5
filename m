Return-Path: <linux-kernel+bounces-145894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A448A5C79
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF27B283639
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FA215696F;
	Mon, 15 Apr 2024 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqVHZS9u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F213156236
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 20:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713214388; cv=none; b=fMXr/oTfpa+Wg3bFRqJSXDTx/Oshh1LgomalHcfrlaEcADwiqAne6xsjdbuCY9kq0j8r2MXkoEdv1QcmPCVKWBb/pwxD0le+m18uZX1t9j4PYVsCilO1KQQoO9WNjE4F/0pOnEtKZNzJWzyhTldySw/QJBNeV49PC8pkQP/MK+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713214388; c=relaxed/simple;
	bh=92Ym7ybb9ZS1fQVgjvIEz1bEFs/AzuS6ODUJBRnWjEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MXwClFtM0lAUfVX8tmR4DWckwjZLq/ZFE64cdzlJZKXWji6HZhhJOvUjkXAljMEE6AWvvqJrD1+jg4zuezEUD6In5u1zb5Wy+rMbO0pXnrjgnZq56+LbIhCt08WoOo4XZcKGuNgnkZFSo8eNM4qBo3D8rp/PYmDjaQFuTAuSVoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqVHZS9u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713214385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7++5H78YlgDsEMmQcYVCUBmYO6bg5gOwdVwvkU8dfpY=;
	b=VqVHZS9uwROXhCvVsj2gl7UqXx/kdumzi2fi+JjAZY/2BY6CJjVr1mc9npFs98gl9mgL3/
	+g8T7Jgku7EQO1rG6QlAmoVo4Ip1nSEshap0fCxptKqKv9quNiz96MnUAYxIvO24v5WQlw
	Ld0LoAoo49Doit8qEUT1OFgFQQoEDqQ=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-F4FsCKQdMayzui847dJn2A-1; Mon, 15 Apr 2024 16:53:03 -0400
X-MC-Unique: F4FsCKQdMayzui847dJn2A-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7e822c441d5so370484241.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713214383; x=1713819183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7++5H78YlgDsEMmQcYVCUBmYO6bg5gOwdVwvkU8dfpY=;
        b=KpuwNd3+z/gFQvXgJ4hd7Xjs7vy/M3IJJzeKchTYc/cYdJK5srZuDmy9+AuSlGfisz
         L8fbcM1n54VEjStTxZDPQwPY9//sCwCjSNM7SoCq3Jbe5wvH45qjeyMpWZcaEHQpMLc3
         X4/IMluzUbs7Z4+eSmTRUxVWSq9ojlktMV45nIAi/nfWJgdbRl/4o7DiZVfLTW3/tlnj
         chVn1H0lOICbjv+wSRP7C0F21Q1c63/EkSTozPF6LiilgRZ3URtm7QZ8RkZvhrTNm0LN
         BY91uAHJnQic1jgb5Sit3PmELMX0iYlRgifXq0ZSGSk7JfsSQbIXCprdnw1t7Y8zvhqQ
         de2A==
X-Gm-Message-State: AOJu0YyLWp5570yjXXJLSNYjXWrLONe/xYtVyXBGikl4bkAKTsgC96np
	w8a2bUVGX6MN5HUOaia0Bp6P4w5RXm2RSM1Ml5TjRgeWHe0VctkBlD4elu+JSfOo2ka1uQSZbEo
	0tTNuEfQQs6BNz0utaOsBXQlUVHrIxF5TKSy09C3RDxDnLL1pVQFVhf1SZnl6yYkfxydjXk/c7n
	AtJQO8KKfADZ9KAsxeIavwZfhdRe4o0hm/s2pVzpGBRWA=
X-Received: by 2002:a05:6102:5493:b0:47a:145d:ff71 with SMTP id bk19-20020a056102549300b0047a145dff71mr8677885vsb.3.1713214381989;
        Mon, 15 Apr 2024 13:53:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyPe5nOGtZ1+eez23xTwwWwXmpPWZh75RjHcvLbAwZQLmYYWzn5kF0KOJY8fVpQefCJixTdQ==
X-Received: by 2002:a05:6102:5493:b0:47a:145d:ff71 with SMTP id bk19-20020a056102549300b0047a145dff71mr8677863vsb.3.1713214381409;
        Mon, 15 Apr 2024 13:53:01 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id u18-20020ae9c012000000b0078eeea25dd6sm1000911qkk.116.2024.04.15.13.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 13:53:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	peterx@redhat.com,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: [PATCH] mm/page_table_check: Support userfault wr-protect entries
Date: Mon, 15 Apr 2024 16:52:59 -0400
Message-ID: <20240415205259.2535077-1-peterx@redhat.com>
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
 arch/x86/include/asm/pgtable.h | 18 +-----------------
 mm/page_table_check.c          | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 18 deletions(-)

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
index af69c3c8f7c2..d4eb1212f0f5 100644
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
@@ -182,6 +184,23 @@ void __page_table_check_pud_clear(struct mm_struct *mm, pud_t pud)
 }
 EXPORT_SYMBOL(__page_table_check_pud_clear);
 
+/* Whether the swap entry cached writable information */
+static inline bool swap_cached_writable(swp_entry_t entry)
+{
+	unsigned type = swp_type(entry);
+
+	return type == SWP_DEVICE_EXCLUSIVE_WRITE ||
+	    type == SWP_MIGRATION_WRITE;
+}
+
+static inline void __page_table_check_pte(pte_t pte)
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
@@ -190,18 +209,29 @@ void __page_table_check_ptes_set(struct mm_struct *mm, pte_t *ptep, pte_t pte,
 	if (&init_mm == mm)
 		return;
 
-	for (i = 0; i < nr; i++)
+	for (i = 0; i < nr; i++) {
+		__page_table_check_pte(pte);
 		__page_table_check_pte_clear(mm, ptep_get(ptep + i));
+	}
 	if (pte_user_accessible_page(pte))
 		page_table_check_set(pte_pfn(pte), nr, pte_write(pte));
 }
 EXPORT_SYMBOL(__page_table_check_ptes_set);
 
+static inline void __page_table_check_pmd(pmd_t pmd)
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
 
+	__page_table_check_pmd(pmd);
 	__page_table_check_pmd_clear(mm, *pmdp);
 	if (pmd_user_accessible_page(pmd)) {
 		page_table_check_set(pmd_pfn(pmd), PMD_SIZE >> PAGE_SHIFT,
-- 
2.44.0


