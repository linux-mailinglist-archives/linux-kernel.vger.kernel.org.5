Return-Path: <linux-kernel+bounces-75684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BA885ED62
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20267282E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E22512DD98;
	Wed, 21 Feb 2024 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q046JbFT"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2F612C809
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559402; cv=none; b=YlULQX/J4eRyr24qUvYGmWffUZh9EPfOXQLdb+Va4SoDXmPfs8h2V3SLFXKcBQfwY0E63e0XygDbSoq9PXAQRVyleuuWWKi0tvNH1uP+Jy7DZjGbJOQkvRw3EP1C5FCUjSXgCXLLhWojSx+ugsRnJuO/xofn0R/xV90iVWQ2p0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559402; c=relaxed/simple;
	bh=FAgtlGGDMtr8yiPvIUkNg2PdKKRtVVWsau7z48QcBII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjYfQi3ji/oRMFB0etA+JazCxO3CNTVCcgcfjOOh2BBei1vuSGm3bvxa2iuEyauAjzPVkgFQaqjgyDla9VzwlR916EMnKpkSCmQdNc0zhZOxUW6zywiNS9DIFgHhVHbrhFObjYNo9orwCJQhXkp1qG9zQid5PBNUB258qwbuQic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q046JbFT; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dbb47852cdso11308895ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708559400; x=1709164200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yscKp0AJANlReZg8MRza2RJbrRIz7yBwKbuUCOLUH8=;
        b=Q046JbFTfKXqy1RWrIT6BrlaXF7ajxXLrWGRYAJRvUWtZDSFChQiPygmTwukgug9qu
         VfMfo4xvk8g4FdERXQ7b227uhLQH7sw8VPSo13lQ/IsM6aSTI4BHgTNNfvuyt+7J15ML
         KuPJRTQElmSrb2tzMIVCNpopGwH9MYs0XMbbJdDwG63H8SHsx/IHlRnWw2hC4sdEsPay
         5Qi9Bh9Jb5MPlRs2ZdvuCKwfakElnP/hfbezZL6FIl5zmw19gnLZRVxVeNoNmM1xj3nr
         Y4+6SvX7/JcyTAUCc5CozDQ5JZUrAFrhIfUKQu2OHn8Ckrf5byqtDoVMZznfzStyGWd2
         JQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559400; x=1709164200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yscKp0AJANlReZg8MRza2RJbrRIz7yBwKbuUCOLUH8=;
        b=YsZViXcMZcoq8oyH3SmnPVKWqeGEBoLUYUhgT5Rdug13xSTQEG1andczj1X+sV79M4
         EXr9h1Hd/u68+Ja+pmZjd+0TDhvlnrFcleXzBzQicryJryJCtcAWXcSaAE0IDUKn55ks
         g2HjVNoG83HYXImo1kGbvGuwmxL9fyEyiFmKNnuaWmUZkepbt1/YRv2ga30ZtE8D8uKT
         iXBmPAyNdiad/0gEJ3CY9w9tfRseBvNaACmqLv1w7NQSmKIWa2ZbHZJMYQXtW36MU+4Q
         EIZFT+gU2bvT6ecwakH4vvYvsHybUsbiCtdVNrMK//m2rMnKv/PX6RTCMHEP/KXPH9Ym
         DyRw==
X-Gm-Message-State: AOJu0YxXtjht9bi5Djjd0NfHbqz9TIdXWzXKR5a1V8RwIvS2lZkmelZq
	43Z8HppgSYHcnrnX7zrWwjlndWOIgOaerQSVgI2z+2NzIqdnzVhd
X-Google-Smtp-Source: AGHT+IFZIf1O6PqXeRikv0kae6U3RFR5jVDKRbX/kRqX+aBw6Rf505v5O+I9/n7itMhFi0AnJq7rXQ==
X-Received: by 2002:a17:902:db09:b0:1dc:139:8488 with SMTP id m9-20020a170902db0900b001dc01398488mr10763038plx.5.1708559400552;
        Wed, 21 Feb 2024 15:50:00 -0800 (PST)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id jx3-20020a170903138300b001d752c4f36asm8657794plb.78.2024.02.21.15.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 15:49:59 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	willy@infradead.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 2/5] hugetlb: Move vm_struct declaration to the top of hugetlb_fault()
Date: Wed, 21 Feb 2024 15:47:29 -0800
Message-ID: <20240221234732.187629-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221234732.187629-1-vishal.moola@gmail.com>
References: <20240221234732.187629-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hugetlb_fault() currently defines a vm_struct to pass to the generic
handle_userfault() function. We can move this definition to the top of
hugetlb_fault() so that it can be used throughout the rest of the
hugetlb fault path.

This will help cleanup a number of excess variables and function
arguments throughout the stack. Also, since vm_fault already has space
to store the page offset, use that instead and get rid of idx.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/hugetlb.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ed1581b670d4..d792d60ea16c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6353,13 +6353,25 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	spinlock_t *ptl;
 	vm_fault_t ret;
 	u32 hash;
-	pgoff_t idx;
 	struct folio *folio = NULL;
 	struct folio *pagecache_folio = NULL;
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping;
 	int need_wait_lock = 0;
 	unsigned long haddr = address & huge_page_mask(h);
+	struct vm_fault vmf = {
+		.vma = vma,
+		.address = haddr,
+		.real_address = address,
+		.flags = flags,
+		.pgoff = vma_hugecache_offset(h, vma, haddr),
+		/* TODO: Track hugetlb faults using vm_fault */
+
+		/*
+		 * Some fields may not be initialized, be careful as it may
+		 * be hard to debug if called functions make assumptions
+		 */
+	};
 
 	/* TODO: Handle faults under the VMA lock */
 	if (flags & FAULT_FLAG_VMA_LOCK) {
@@ -6373,8 +6385,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	 * the same page in the page cache.
 	 */
 	mapping = vma->vm_file->f_mapping;
-	idx = vma_hugecache_offset(h, vma, haddr);
-	hash = hugetlb_fault_mutex_hash(mapping, idx);
+	hash = hugetlb_fault_mutex_hash(mapping, vmf.pgoff);
 	mutex_lock(&hugetlb_fault_mutex_table[hash]);
 
 	/*
@@ -6408,8 +6419,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * hugetlb_no_page will drop vma lock and hugetlb fault
 		 * mutex internally, which make us return immediately.
 		 */
-		return hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
-				      entry, flags);
+
+		return hugetlb_no_page(mm, vma, mapping, vmf.pgoff, address,
+					ptep, entry, flags);
 	}
 
 	ret = 0;
@@ -6455,7 +6467,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		/* Just decrements count, does not deallocate */
 		vma_end_reservation(h, vma, haddr);
 
-		pagecache_folio = filemap_lock_hugetlb_folio(h, mapping, idx);
+		pagecache_folio = filemap_lock_hugetlb_folio(h, mapping,
+							     vmf.pgoff);
 		if (IS_ERR(pagecache_folio))
 			pagecache_folio = NULL;
 	}
@@ -6470,13 +6483,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
 	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
 		if (!userfaultfd_wp_async(vma)) {
-			struct vm_fault vmf = {
-				.vma = vma,
-				.address = haddr,
-				.real_address = address,
-				.flags = flags,
-			};
-
 			spin_unlock(ptl);
 			if (pagecache_folio) {
 				folio_unlock(pagecache_folio);
-- 
2.43.0


