Return-Path: <linux-kernel+bounces-90480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA8E86FFD0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620131F240E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BB03A1A3;
	Mon,  4 Mar 2024 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cio8SLAN"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF9739FE8
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550504; cv=none; b=VNchG/b8MkXaCzVOqId3qSERxwtdfVJa88Zm2Rjt9y1rqRe+ERtxdQkjqPoiDOkpth4KPLPjn7BGJ7p0Rsal6Opf2QQOU/0oSQVfzK7ouSJm7oPXDXjEEBnLuZ4dKViQSRUb9jm+MZ5Awi40TxOE+mPhD8GZV496ajTyFN56TAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550504; c=relaxed/simple;
	bh=FQ6sLDKliZQxGaM/0fZ2Dlbeq3FZV7uzrQlqY13q4kU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WcroKHtBwc0w4NUhz76DJqeYigjAzqHbGMdWObAQbUQXqwfdPTfhe0MZSgPIWrLFviW/yzqSEombSa5kx/yDpQv58ay5Vv0FVQOpErHjJ5hXAG6E28LcDnW6V2cQ8+OxqlZIVaVi7KU2FE6rox1RvEI7mSLS5+qKrhdtjU9edWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cio8SLAN; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cfb8126375so673492a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 03:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709550502; x=1710155302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RLTgvH0qYoneoQ+N+6ayDYFDcXGD4luCEt+X8Py56w=;
        b=cio8SLANw7fertsc3r5ZmCdJ7hbRoaDpL1ZZveIYND2iSSCG0H3jQIvFnkg8NU4TrL
         0jXiQF6nBkxU2381b8Szo8g8bZ2bHaiCYSXd0CrckzzeTdCC2+gxT+v1qEjlOzkP3mVV
         A+wdUOQT5UOx9rKNR+91muojmOi8zvj8aZ1zwLIhj80gHxqLE0F2pi3BhGT/UFyjO0Ch
         UYa8Bgj9W4YoQqshqox11kqr/yROvPVyk3JsylBheyYrJxy87YIUR5vV9bHfuPVU80GU
         pqmgvV14SD1/V7+nZVi578SwX33t1ItZZmC7KDWAPKMFRh5RNj6m9yaphnZiCeFxxLxY
         xbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709550502; x=1710155302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RLTgvH0qYoneoQ+N+6ayDYFDcXGD4luCEt+X8Py56w=;
        b=XMWUikQqY9YwSVSg42XsuYmCt13ArZJ5yNhK59gGVU2p9m6+lM3zIGYQamsivi0Bms
         YuHwLQZ9G/7GFBfpOG30GK/V7AvkfxxNCDWWMYvCLWoybA0SdOj86+CgiJPVRnyLVz4Q
         jmeTCV1iCQe/gQxso10C3fxAv7JmOUHi+OVd0qNWUhAUb/nxBv7YeKPH+kVl8D3ZXDqL
         O5+Y1VODMtvk+gJLDlDpsdQ1IFARqcfg2GkoXy9pb51JRdAQ08AbNm3aeZ6JqqKroRUO
         zsBY547RwKslzNpPyMAULHHZlmiWEATVdM2mfXnM9pSXUfcf04Z1sxvQ8/HEh0+fcru/
         QKXw==
X-Forwarded-Encrypted: i=1; AJvYcCXgH0SzBJSI931Kloqj0cHvebiATKKS9AWnGNrhAuDs086K4XLYOpFk6ytMxjDUe+K+a5iB1DiOgd6EIcJquIvigaw/0fPFgN+GscY9
X-Gm-Message-State: AOJu0YwvfpsCjRJRLp7ejd/gEI5+noNwPVNK5eDjrYJABgZNvrnvFmzt
	TWUicyiT6th4k5Qm/keWK9YuVkCAIfdcqB5b/IS0rJdokI8dWwSODg4jvB/fzJk=
X-Google-Smtp-Source: AGHT+IFBOOIUNI94cOhOoYb8AwpERd5isoTBK9odWtV+MEuzyzhHwVrtYw8sFJceXMlJR9tIyeo1cQ==
X-Received: by 2002:a05:6a20:1b30:b0:1a1:480e:7711 with SMTP id ch48-20020a056a201b3000b001a1480e7711mr5045368pzb.0.1709550501853;
        Mon, 04 Mar 2024 03:08:21 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.154])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090aca8500b0029b59bf77b4sm587410pjt.42.2024.03.04.03.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:08:21 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: akpm@linux-foundation.org,
	vishal.moola@gmail.com,
	hughd@google.com,
	david@redhat.com,
	rppt@kernel.org,
	willy@infradead.org,
	muchun.song@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH 3/3] s390: supplement for ptdesc conversion
Date: Mon,  4 Mar 2024 19:07:20 +0800
Message-Id: <04beaf3255056ffe131a5ea595736066c1e84756.1709541697.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1709541697.git.zhengqi.arch@bytedance.com>
References: <cover.1709541697.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 6326c26c1514 ("s390: convert various pgalloc functions to use
ptdescs"), there are still some positions that use page->{lru, index}
instead of ptdesc->{pt_list, pt_index}. In order to make the use of
ptdesc->{pt_list, pt_index} clearer, it would be better to convert them
as well.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/pgalloc.h |  4 ++--
 arch/s390/mm/gmap.c             | 38 +++++++++++++++++----------------
 arch/s390/mm/pgalloc.c          |  8 +++----
 3 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index 502d655fe6ae..7b84ef6dc4b6 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -23,9 +23,9 @@ unsigned long *crst_table_alloc(struct mm_struct *);
 void crst_table_free(struct mm_struct *, unsigned long *);
 
 unsigned long *page_table_alloc(struct mm_struct *);
-struct page *page_table_alloc_pgste(struct mm_struct *mm);
+struct ptdesc *page_table_alloc_pgste(struct mm_struct *mm);
 void page_table_free(struct mm_struct *, unsigned long *);
-void page_table_free_pgste(struct page *page);
+void page_table_free_pgste(struct ptdesc *ptdesc);
 extern int page_table_allocate_pgste;
 
 static inline void crst_table_init(unsigned long *crst, unsigned long entry)
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 8da39deb56ca..4d2674f89322 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -206,9 +206,11 @@ static void gmap_free(struct gmap *gmap)
 
 	/* Free additional data for a shadow gmap */
 	if (gmap_is_shadow(gmap)) {
+		struct ptdesc *ptdesc;
+
 		/* Free all page tables. */
-		list_for_each_entry_safe(page, next, &gmap->pt_list, lru)
-			page_table_free_pgste(page);
+		list_for_each_entry_safe(ptdesc, next, &gmap->pt_list, pt_list)
+			page_table_free_pgste(ptdesc);
 		gmap_rmap_radix_tree_free(&gmap->host_to_rmap);
 		/* Release reference to the parent */
 		gmap_put(gmap->parent);
@@ -1348,7 +1350,7 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
 {
 	unsigned long *ste;
 	phys_addr_t sto, pgt;
-	struct page *page;
+	struct ptdesc *ptdesc;
 
 	BUG_ON(!gmap_is_shadow(sg));
 	ste = gmap_table_walk(sg, raddr, 1); /* get segment pointer */
@@ -1361,9 +1363,9 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
 	*ste = _SEGMENT_ENTRY_EMPTY;
 	__gmap_unshadow_pgt(sg, raddr, __va(pgt));
 	/* Free page table */
-	page = phys_to_page(pgt);
-	list_del(&page->lru);
-	page_table_free_pgste(page);
+	ptdesc = page_ptdesc(phys_to_page(pgt));
+	list_del(&ptdesc->pt_list);
+	page_table_free_pgste(ptdesc);
 }
 
 /**
@@ -1377,7 +1379,7 @@ static void gmap_unshadow_pgt(struct gmap *sg, unsigned long raddr)
 static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
 				unsigned long *sgt)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 	phys_addr_t pgt;
 	int i;
 
@@ -1389,9 +1391,9 @@ static void __gmap_unshadow_sgt(struct gmap *sg, unsigned long raddr,
 		sgt[i] = _SEGMENT_ENTRY_EMPTY;
 		__gmap_unshadow_pgt(sg, raddr, __va(pgt));
 		/* Free page table */
-		page = phys_to_page(pgt);
-		list_del(&page->lru);
-		page_table_free_pgste(page);
+		ptdesc = page_ptdesc(phys_to_page(pgt));
+		list_del(&ptdesc->pt_list);
+		page_table_free_pgste(ptdesc);
 	}
 }
 
@@ -2058,19 +2060,19 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 {
 	unsigned long raddr, origin;
 	unsigned long *table;
-	struct page *page;
+	struct ptdesc *ptdesc;
 	phys_addr_t s_pgt;
 	int rc;
 
 	BUG_ON(!gmap_is_shadow(sg) || (pgt & _SEGMENT_ENTRY_LARGE));
 	/* Allocate a shadow page table */
-	page = page_table_alloc_pgste(sg->mm);
-	if (!page)
+	ptdesc = page_table_alloc_pgste(sg->mm);
+	if (!ptdesc)
 		return -ENOMEM;
-	page->index = pgt & _SEGMENT_ENTRY_ORIGIN;
+	ptdesc->pt_index = pgt & _SEGMENT_ENTRY_ORIGIN;
 	if (fake)
-		page->index |= GMAP_SHADOW_FAKE_TABLE;
-	s_pgt = page_to_phys(page);
+		ptdesc->pt_index |= GMAP_SHADOW_FAKE_TABLE;
+	s_pgt = page_to_phys(ptdesc_page(ptdesc));
 	/* Install shadow page table */
 	spin_lock(&sg->guest_table_lock);
 	table = gmap_table_walk(sg, saddr, 1); /* get segment pointer */
@@ -2088,7 +2090,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	/* mark as invalid as long as the parent table is not protected */
 	*table = (unsigned long) s_pgt | _SEGMENT_ENTRY |
 		 (pgt & _SEGMENT_ENTRY_PROTECT) | _SEGMENT_ENTRY_INVALID;
-	list_add(&page->lru, &sg->pt_list);
+	list_add(&ptdesc->pt_list, &sg->pt_list);
 	if (fake) {
 		/* nothing to protect for fake tables */
 		*table &= ~_SEGMENT_ENTRY_INVALID;
@@ -2114,7 +2116,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned long saddr, unsigned long pgt,
 	return rc;
 out_free:
 	spin_unlock(&sg->guest_table_lock);
-	page_table_free_pgste(page);
+	page_table_free_pgste(ptdesc);
 	return rc;
 
 }
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 008e487c94a6..abb629d7e131 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -135,7 +135,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 
 #ifdef CONFIG_PGSTE
 
-struct page *page_table_alloc_pgste(struct mm_struct *mm)
+struct ptdesc *page_table_alloc_pgste(struct mm_struct *mm)
 {
 	struct ptdesc *ptdesc;
 	u64 *table;
@@ -147,12 +147,12 @@ struct page *page_table_alloc_pgste(struct mm_struct *mm)
 		memset64(table, _PAGE_INVALID, PTRS_PER_PTE);
 		memset64(table + PTRS_PER_PTE, 0, PTRS_PER_PTE);
 	}
-	return ptdesc_page(ptdesc);
+	return ptdesc;
 }
 
-void page_table_free_pgste(struct page *page)
+void page_table_free_pgste(struct ptdesc *ptdesc)
 {
-	pagetable_free(page_ptdesc(page));
+	pagetable_free(ptdesc);
 }
 
 #endif /* CONFIG_PGSTE */
-- 
2.30.2


