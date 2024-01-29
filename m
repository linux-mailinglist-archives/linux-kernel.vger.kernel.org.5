Return-Path: <linux-kernel+bounces-42195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0164183FDCE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA1C1F2208F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7F444C76;
	Mon, 29 Jan 2024 05:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSfuqKYk"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56583C46B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706507177; cv=none; b=KgzAT5VSxCiFORf8IkPAnvclarrliRPjZX+qikGB21XiOq5sq7Rqv4i2eQ8Ioo6drKweO1JOZ98HG3+3tcoTIDylZv2RcmGaoZqljCeO0GL729Mxhe0u9pWvRBGPgVbeRFWTLIIYbfaSamSHXhoDWPGegh+YmEp96IeVfCzcbLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706507177; c=relaxed/simple;
	bh=ZGnozxwzqrhoRvxoomJ3VxjzGQOXMMPHvabiuXazBSk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G02OhmNCSiDw3bl9qhc2mHCCrAq2oko2Q1Uk2AnJSl7M/NedccMbRYFbvZrdSdDjab73ORphVSnGO/lC/HoYOKQuyOHQRtweJ1FZn+MmC74sN+AoSv3YBAlKe/Jczr9mQFnuY/ttARQsDp1K/kIzuXo62Sgv1m7LvxptFXAgx30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSfuqKYk; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d8d747a3bcso3726715ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 21:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706507175; x=1707111975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IHuIHgsq0pkJV9MVOB176xiitDstTf9e4RykLNwMz7o=;
        b=nSfuqKYkZM1/WkTuCAhpW90Yz8zasgr4amwbnloUUcc/QYWjuoDLWua1vkBDJ88Zon
         idFRqgK7LP+cOZLgw3cv2DhGvdlHk+0munkt3IpNPnqrIhhsXIwApF6mNRvm5piI8Sx6
         CZqD4xTHUskynM2cBCXdHsoADWNmtTOasPoyqRrKvINXNfq8C5qvLYMaQXtXKsLr9N65
         A1S8VAJPr4StuRfzQhaOH80TyYQQgDiMVK6vUdmDdlYaKU/Ix8qyE4s/Wd3CrtKqlawF
         8d8bADVF76liwo6ns/ONTSlC/k+moG6EqrDAIV9OG9nfNtrXvlLAST7m9LgzqGBZfbvc
         yfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706507175; x=1707111975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHuIHgsq0pkJV9MVOB176xiitDstTf9e4RykLNwMz7o=;
        b=YCkPqxGmRr8QORcM2suXO8VM5MfOYTbFWehUPTaQXpUyfkepmwR9TW40bJGZKjNjA+
         Lr1H6B18KPo4fkCGgCarqaNqChSG/6CUleZudL7FAWT/JMH6pfN+f/EBB9qqkR7+hUU5
         EdvNrxqrZYClXRqjSgTMVK5Qza38k0GX0b3osTdvx8Em0CFZFrPS0Nyig+tceOvcvD1l
         qnskSZxCW1Xv855GKf4NQTbUc00SqtRbGl/hazVdxAakxCobxW4M8QU0WRjmdvEMzRbi
         7s+8oCYsH4jO5Ofi0Tma42WN8vnsg712FWKvyc2+o6K9AKABS/BvNfU+6WUFbJ/Ej7Kq
         Y99g==
X-Gm-Message-State: AOJu0YxEibnW7ZiPv4Gj+KTOqoopJC+Lv6cL8vU3PKJgldQgb2pmwiQx
	J9oXRGQh6yMcHn9opYVrWHgFP1VP6BdNWbOJeYV7c3oskW/A02pB
X-Google-Smtp-Source: AGHT+IEOZOP87PczPRaEtLnjXj7L60nqKEcW0EEF0dmvYeE8VsnLp8N+eQ3vn5EbGO/n6iJ6WNs+WQ==
X-Received: by 2002:a17:902:ec06:b0:1d8:f3c7:fb99 with SMTP id l6-20020a170902ec0600b001d8f3c7fb99mr102478pld.28.1706507174938;
        Sun, 28 Jan 2024 21:46:14 -0800 (PST)
Received: from LancedeMBP.lan ([112.10.240.49])
        by smtp.gmail.com with ESMTPSA id n18-20020a170902d2d200b001d6eed31a1bsm4453110plc.245.2024.01.28.21.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 21:46:14 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: mhocko@suse.com,
	zokeefe@google.com,
	david@redhat.com,
	songmuchun@bytedance.com,
	shy828301@gmail.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH 1/1] mm/khugepaged: bypassing unnecessary scans with MMF_DISABLE_THP check
Date: Mon, 29 Jan 2024 13:45:51 +0800
Message-Id: <20240129054551.57728-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

khugepaged scans the entire address space in the
background for each given mm, looking for
opportunities to merge sequences of basic pages
into huge pages. However, when an mm is inserted
to the mm_slots list, and the MMF_DISABLE_THP flag
is set later, this scanning process becomes
unnecessary for that mm and can be skipped to avoid
redundant operations, especially in scenarios with
a large address space.

This commit introduces a check before each scanning
process to test the MMF_DISABLE_THP flag for the
given mm; if the flag is set, the scanning process
is bypassed, thereby improving the efficiency of
khugepaged.

Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/khugepaged.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2b219acb528e..d6a700834edc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -410,6 +410,12 @@ static inline int hpage_collapse_test_exit(struct mm_struct *mm)
 	return atomic_read(&mm->mm_users) == 0;
 }
 
+static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
+{
+	return hpage_collapse_test_exit(mm) ||
+	       test_bit(MMF_DISABLE_THP, &mm->flags);
+}
+
 void __khugepaged_enter(struct mm_struct *mm)
 {
 	struct khugepaged_mm_slot *mm_slot;
@@ -1422,7 +1428,7 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
 
 	lockdep_assert_held(&khugepaged_mm_lock);
 
-	if (hpage_collapse_test_exit(mm)) {
+	if (hpage_collapse_test_exit_or_disable(mm)) {
 		/* free mm_slot */
 		hash_del(&slot->hash);
 		list_del(&slot->mm_node);
@@ -2360,7 +2366,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 		goto breakouterloop_mmap_lock;
 
 	progress++;
-	if (unlikely(hpage_collapse_test_exit(mm)))
+	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
 		goto breakouterloop;
 
 	vma_iter_init(&vmi, mm, khugepaged_scan.address);
@@ -2368,7 +2374,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 		unsigned long hstart, hend;
 
 		cond_resched();
-		if (unlikely(hpage_collapse_test_exit(mm))) {
+		if (unlikely(hpage_collapse_test_exit_or_disable(mm))) {
 			progress++;
 			break;
 		}
@@ -2390,7 +2396,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 			bool mmap_locked = true;
 
 			cond_resched();
-			if (unlikely(hpage_collapse_test_exit(mm)))
+			if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
 				goto breakouterloop;
 
 			VM_BUG_ON(khugepaged_scan.address < hstart ||
@@ -2408,7 +2414,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 				fput(file);
 				if (*result == SCAN_PTE_MAPPED_HUGEPAGE) {
 					mmap_read_lock(mm);
-					if (hpage_collapse_test_exit(mm))
+					if (hpage_collapse_test_exit_or_disable(mm))
 						goto breakouterloop;
 					*result = collapse_pte_mapped_thp(mm,
 						khugepaged_scan.address, false);
@@ -2450,7 +2456,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 	 * Release the current mm_slot if this mm is about to die, or
 	 * if we scanned all vmas of this mm.
 	 */
-	if (hpage_collapse_test_exit(mm) || !vma) {
+	if (hpage_collapse_test_exit_or_disable(mm) || !vma) {
 		/*
 		 * Make sure that if mm_users is reaching zero while
 		 * khugepaged runs here, khugepaged_exit will find
-- 
2.33.1


