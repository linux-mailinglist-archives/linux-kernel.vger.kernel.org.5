Return-Path: <linux-kernel+bounces-131835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 972D7898C53
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86071C2083E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42B11311B1;
	Thu,  4 Apr 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOLd7dXM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671D3130E25
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248656; cv=none; b=MxFbqfBnEkVsPzfCuFwkxauFYhqgGw4WJ5nXKS7d/lYFRlzHGMYIYcDxyVhqPVpDsjmgyPhVUyzBFXasddgnzf8DQtaI80mH7KLb2xdX5l4v3Q1z8qUS8x8HCcTzMwokPr9GHYpZmLmJZYYhp9cEVM7DmZpGwSovMyGNDoG+zsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248656; c=relaxed/simple;
	bh=MRKvUOhgbx1JCPqRkZYfqZCtresFIov/9ISiCIQgDR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrsPUev0b5vBHuscjtfy/RXMbS5VHO+IjWN0IfI04onTWiRK5wfAPdotUFjQL9jzL74qFj6rUr0uTRHwyvIplilQ89rAJbYSm+n5z3FRM4O3akdyqPHYbzmpmSHI2IWhFUWyXrJs1krlqXOfJC7lkdlHf2hPdIPa78IvZl1KVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOLd7dXM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712248654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3q+pZ5P34ghakudMZLyDnJaIa/cVUQD0kuqVhWGHj8=;
	b=hOLd7dXMAJrsahgszPN4y+MZdG3OJiuTEYEfv0dy5vijSCZkTdkS2Ech7sTmuBp62tLOte
	xwCUGKVbiXjEhlRDph9VDaEaH5Ic3BdPyknjQXUrVPbyqPdrrqa/u8wobC9BL2p0JuIdpU
	GtJaT7Faly/Q1JY8n0FImaHndWkfJeM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-iKIcEnTlP7OdF8dgEB13LQ-1; Thu, 04 Apr 2024 12:37:30 -0400
X-MC-Unique: iKIcEnTlP7OdF8dgEB13LQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AC5E88D016;
	Thu,  4 Apr 2024 16:37:29 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0804E3C24;
	Thu,  4 Apr 2024 16:37:25 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v1 5/5] s390/hugetlb: convert PG_arch_1 code to work on folio->flags
Date: Thu,  4 Apr 2024 18:36:42 +0200
Message-ID: <20240404163642.1125529-6-david@redhat.com>
In-Reply-To: <20240404163642.1125529-1-david@redhat.com>
References: <20240404163642.1125529-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Let's make it clearer that we are always working on folio flags and
never page flags of tail pages.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/gmap.c        | 4 ++--
 arch/s390/mm/hugetlbpage.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 9233b0acac89..ca31f2143bc0 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2731,7 +2731,7 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
 {
 	pmd_t *pmd = (pmd_t *)pte;
 	unsigned long start, end;
-	struct page *page = pmd_page(*pmd);
+	struct folio *folio = pmd_folio(*pmd);
 
 	/*
 	 * The write check makes sure we do not set a key on shared
@@ -2746,7 +2746,7 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
 	start = pmd_val(*pmd) & HPAGE_MASK;
 	end = start + HPAGE_SIZE - 1;
 	__storage_key_init_range(start, end);
-	set_bit(PG_arch_1, &page->flags);
+	set_bit(PG_arch_1, &folio->flags);
 	cond_resched();
 	return 0;
 }
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index e1e63dc1b23d..21ed6ac5f1c5 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -121,7 +121,7 @@ static inline pte_t __rste_to_pte(unsigned long rste)
 
 static void clear_huge_pte_skeys(struct mm_struct *mm, unsigned long rste)
 {
-	struct page *page;
+	struct folio *folio;
 	unsigned long size, paddr;
 
 	if (!mm_uses_skeys(mm) ||
@@ -129,16 +129,16 @@ static void clear_huge_pte_skeys(struct mm_struct *mm, unsigned long rste)
 		return;
 
 	if ((rste & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R3) {
-		page = pud_page(__pud(rste));
+		folio = page_folio(pud_page(__pud(rste)));
 		size = PUD_SIZE;
 		paddr = rste & PUD_MASK;
 	} else {
-		page = pmd_page(__pmd(rste));
+		folio = pmd_folio(__pmd(rste));
 		size = PMD_SIZE;
 		paddr = rste & PMD_MASK;
 	}
 
-	if (!test_and_set_bit(PG_arch_1, &page->flags))
+	if (!test_and_set_bit(PG_arch_1, &folio->flags))
 		__storage_key_init_range(paddr, paddr + size - 1);
 }
 
-- 
2.44.0


