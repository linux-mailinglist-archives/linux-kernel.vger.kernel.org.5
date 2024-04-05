Return-Path: <linux-kernel+bounces-132827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D46A899ACC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608D21C218A1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D959716ABC9;
	Fri,  5 Apr 2024 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWWkZXSp"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B81649B3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312858; cv=none; b=V6uMkkZJUODO4nce5H8H67HFjukFLZolndBqfBFSCu5DLVZZlGOBpBjPrKNLkpDSxeVTpDm8Y2VaL2//R4gY5rYZn52D9mMox8bh6JSZKPwhV7uCBZWaLCEysX4OoELhS/GAZJGxBN5OfJMHDwV1kOIDB7ZsGE9VOH+1xzSVHAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312858; c=relaxed/simple;
	bh=xU+87YeJV2oMg/LrboKIyNFcwar7pMcfTUa1FZYXXlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ulJtbZIBmTFsZ0aZK5nPP95v3VKa7p4eGusX6zmhNrmunxxj3KJftV72w7aMvnF/j5bfequLwAyxqMU4hE6Ithy3N0ezWMxDYBMukX5D0nB3TBzVdPdHwTiUI+Iz9fjwICqJaJLHTEh0qCKYNv6s5Swy1MoZUUHG5GrrgBl2ZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWWkZXSp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ecfeefe94cso358194b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 03:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712312856; x=1712917656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykuY6i2Fu38nsDbXE/VtCFZLlgGKZpXgb6cmPoEsG8o=;
        b=RWWkZXSpcytbPO9+InhPbUk3jdAz92PM6gSi2zMSMPCTq+BRU22KwbARcklHoReVE/
         Lde/g9CuqItTs1XobhAGmczeGhf7Z6hPpuser4qfCJPyU57ySb2iapDfGDqHfdKsuRNw
         jro36eiQ6VpHbnjZGAfj3MdG0NNlADdk6UOErNfy3eeSUdR/H0qMiGzhkn7N+hVF96D9
         D71JFmxAsAq1uQRLfwkNTPRva8auH/MfCsDvFR76WWQ2fBsNWhXTWbxu6WKrmT6BsQXj
         4KThhbnwvH7Qp1cgorfICzRbv9JjUIDF9PDyb4DDD0qQMiexaPHMMahrC3W4+LDc1owJ
         2ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712312856; x=1712917656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykuY6i2Fu38nsDbXE/VtCFZLlgGKZpXgb6cmPoEsG8o=;
        b=orGtLcfZcR4Ct8lCQgROeiLyO9+zeI+LD4WP0kUiwHAbuox4cByTqcKZjGL7Nod93d
         8cQcYHeWu7umHx9GGWHxxlSKeFCGH2r0t3RKqmQ4sjTjlalLKHgc3bDFE1yiAoMi66vG
         Odkj7GM5lODiPgYUmMq8TzAO8dt+oBEoWNghCNuLTIfKXtwDDNiYj+5xCoWf0tpUhSgx
         PbNIPN32lSC4efgIbaB0F7YkDWa8ReZbroXX7cxp0PtuHtbmkBn4eanWNclJIlQBGj2F
         QKjqxcjCki0vj1Z55mHkNWC5ZJ4ZKZLmiThG8zXrp1xeDnmgUX4cx4iFSDlkvd/6LIrz
         9VyA==
X-Forwarded-Encrypted: i=1; AJvYcCXoxPGuLwk5hs9qa/yvLQyq32T2x2/HekGC+4BS/AViuP3jLh375/NVyutQB/eIKzqUaIxdoeA12WnAYEhesAqmfD81ubyQGfTC8sPb
X-Gm-Message-State: AOJu0YwaD7yVSqTi+hpQvFemQhheN68OlnXZjAwuf2efGUSx3hwjsjAA
	AxIU5m5ClCGJal+dbbsyznhsEO/grrC/MctqpZE13kLGqB26N9yZ
X-Google-Smtp-Source: AGHT+IH7lyqbZgiy6gFtYdrA72hCZMiuUcdajSkaC+qbDc4j+Oz8Sw3oeAQrQ+KFY+9839aPVaFHvA==
X-Received: by 2002:a05:6a00:2341:b0:6ea:9b37:c288 with SMTP id j1-20020a056a00234100b006ea9b37c288mr1454381pfj.15.1712312855698;
        Fri, 05 Apr 2024 03:27:35 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id f20-20020a056a00229400b006ed06aa3604sm113334pfe.82.2024.04.05.03.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:27:35 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: david@redhat.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com
Cc: cerasuolodomenico@gmail.com,
	chrisl@kernel.org,
	kasong@tencent.com,
	peterx@redhat.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	yosryahmed@google.com,
	yuzhao@google.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] mm: add per-order mTHP anon_swpout and anon_swpout_fallback counters
Date: Fri,  5 Apr 2024 23:27:04 +1300
Message-Id: <20240405102704.77559-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102704.77559-1-21cnbao@gmail.com>
References: <20240405102704.77559-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This helps to display the fragmentation situation of the swapfile,
knowing the proportion of how much we haven't split large folios.
So far, we only support non-split swapout for anon memory, with
the possibility of expanding to shmem in the future.  So, we add
the "anon" prefix to the counter names.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/huge_mm.h | 2 ++
 mm/huge_memory.c        | 4 ++++
 mm/page_io.c            | 6 +++++-
 mm/vmscan.c             | 3 +++
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c5d33017a4dd..1d893a358df6 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -267,6 +267,8 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 enum mthp_stat_item {
 	MTHP_STAT_ANON_ALLOC,
 	MTHP_STAT_ANON_ALLOC_FALLBACK,
+	MTHP_STAT_ANON_SWPOUT,
+	MTHP_STAT_ANON_SWPOUT_FALLBACK,
 	__MTHP_STAT_COUNT
 };
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5b875f0fc923..28113f8fdf18 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -554,10 +554,14 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
 
 DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_ANON_ALLOC);
 DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLBACK);
+DEFINE_MTHP_STAT_ATTR(anon_swpout, MTHP_STAT_ANON_SWPOUT);
+DEFINE_MTHP_STAT_ATTR(anon_swpout_fallback, MTHP_STAT_ANON_SWPOUT_FALLBACK);
 
 static struct attribute *stats_attrs[] = {
 	&anon_alloc_attr.attr,
 	&anon_alloc_fallback_attr.attr,
+	&anon_swpout_attr.attr,
+	&anon_swpout_fallback_attr.attr,
 	NULL,
 };
 
diff --git a/mm/page_io.c b/mm/page_io.c
index a9a7c236aecc..7669452e8b4d 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -212,13 +212,17 @@ int swap_writepage(struct page *page, struct writeback_control *wbc)
 
 static inline void count_swpout_vm_event(struct folio *folio)
 {
+	long nr_pages = folio_nr_pages(folio);
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (unlikely(folio_test_pmd_mappable(folio))) {
 		count_memcg_folio_events(folio, THP_SWPOUT, 1);
 		count_vm_event(THP_SWPOUT);
 	}
+	if (nr_pages > 0)
+		count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_SWPOUT);
 #endif
-	count_vm_events(PSWPOUT, folio_nr_pages(folio));
+	count_vm_events(PSWPOUT, nr_pages);
 }
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ffc4553c8615..b30e6294f82a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1247,6 +1247,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 						count_vm_event(
 							THP_SWPOUT_FALLBACK);
 					}
+					if (nr_pages > 0)
+						count_mthp_stat(get_order(nr_pages * PAGE_SIZE),
+							MTHP_STAT_ANON_SWPOUT_FALLBACK);
 #endif
 					if (!add_to_swap(folio))
 						goto activate_locked_split;
-- 
2.34.1


