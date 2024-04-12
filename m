Return-Path: <linux-kernel+bounces-142608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 881CD8A2DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E471F23C9B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A9154FB1;
	Fri, 12 Apr 2024 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWDWZRAW"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCE654FBE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712922559; cv=none; b=khRy1WfFWoo9zJy/syQToFDGt1NJr2tyyiE5yY7yhHzlcIeGtVtYUM/1Kinba61gYEdwPB6xwXBNnfuvKAaP+q21bjNwKRTP9VLRY19SDMblUTEMf5/uds0JNXQOMNr4/8zA8ZIA846L9kH4PkXWnOgz8V8cVbgVzNtePE4QpXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712922559; c=relaxed/simple;
	bh=/NCU8L1nyBke5rCK/5TqCMZiK2pSQoaU6KW5LiSJJ8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IX5nBfewmGQ43cuMc13WdWaTAbUzDq1e76xyncdb8ZvmOw9Y7Gugi06bTnb+bNH7Y5MbjGtZQKMu6+TnUf5KL5MKeIVHGKdY/hFX9QrtcVOoF0XUlcrZeSQtoHjz8wDqi6GYRWD/uJkgRowQRPFsyNYMTsfCfn+4l9XliiVfQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWDWZRAW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ecf8ebff50so567684b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712922558; x=1713527358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBqcW3yGOLnf8fCkLXd+q0+NdDQ6JnFQ/vzKSqccdZY=;
        b=ZWDWZRAWuC8vPzK65YDH7lrK0I4uudtfAYXgOfXVW5VbLHmnROIM8vcNoj3fU6wtDr
         u7chhslYFJDjpG+tsqTt062s82WlLvgFDH8iWn6ZoSIBdNbDa////v4hfPPCI8V67Kvd
         e9DqDw9MGR8f43rd3okH4tefQClbjmhHi4DzJAKwODndH6nngquLXLuDVQmOjR/TuiCn
         +5qjuqQuymhaQtSiuZz+rQO2T70qldF6fhEgw88GGiDAbxWa1yO2QlxAVpe13NjRwJl5
         rLDgV4/KYPXpL6FrWc8l5Rg1xUnGlnSnYJHB6KMTw6LI77IAoiiXVwmle4fyKYfhTE8M
         VGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712922558; x=1713527358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBqcW3yGOLnf8fCkLXd+q0+NdDQ6JnFQ/vzKSqccdZY=;
        b=fuvrOI3FUs4Qr5iwdUqfR0FomfziSvaPFZYb/9yExgiFVBWmUxsnnhz+TIOtUHWZDx
         X/W2lljd0lFDeigFBLF1UYecCznOswnBq2eI+bW0quc23MzXU+HxLXz3rwCnRKAYC45o
         zxTiDhLjmmG9E1mYQxfY3ER/BkBWdXAUXR8zx31gMPaI2kUu31L6rroluu3ZQP9+awte
         ukjnVhXAJ6tnHV79EGFdA7dlLiquIQ5+I81ezlznFjpkYhXM2gK3yhWsJ6Urk/qTg04A
         ILrQtSdjPl57VT4i50SCnZURTOLZMmIcwG/fmMaHUtmQczSlci3PYhl5lQ+x5ugDujA9
         Grlg==
X-Forwarded-Encrypted: i=1; AJvYcCXIcio6leFQ72ZYg9C3EjM1e9w65z/PSMnAeMiTAUWLCgwLYJHhcqtGHnr7qzfE4/STiy65nCCKhSEj44y8whfAW9ZI7wTFXqr2vb6w
X-Gm-Message-State: AOJu0Yx59o+JVuoR4JgjjRfQj74lkYxm4WtcKZ88XJ2GEa+Exa+HPLUK
	Ecw9cSeAku7u0IeWyEvwlkecVqstQFghD2mZhZETJN0i8RmIvCGQOT54GO8d
X-Google-Smtp-Source: AGHT+IGaTHWz4rwtGHc+sgkHopCT3nCaKwwOngZTn+zC3VlvQfYHhe+0iaWXVFi2u44WZCge+8Zqcg==
X-Received: by 2002:a05:6a21:3406:b0:1a8:58a2:ea41 with SMTP id yn6-20020a056a21340600b001a858a2ea41mr3325699pzb.9.1712922557669;
        Fri, 12 Apr 2024 04:49:17 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id q1-20020a634301000000b005e43cce33f8sm2541048pga.88.2024.04.12.04.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 04:49:17 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: cerasuolodomenico@gmail.com,
	chrisl@kernel.org,
	david@redhat.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	peterx@redhat.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	yosryahmed@google.com,
	yuzhao@google.com,
	corbet@lwn.net
Subject: [PATCH v6 1/4] mm: add per-order mTHP anon_fault_alloc and anon_fault_fallback counters
Date: Fri, 12 Apr 2024 23:48:55 +1200
Message-Id: <20240412114858.407208-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412114858.407208-1-21cnbao@gmail.com>
References: <20240412114858.407208-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Profiling a system blindly with mTHP has become challenging due to the
lack of visibility into its operations.  Presenting the success rate of
mTHP allocations appears to be pressing need.

Recently, I've been experiencing significant difficulty debugging
performance improvements and regressions without these figures.  It's
crucial for us to understand the true effectiveness of mTHP in real-world
scenarios, especially in systems with fragmented memory.

This patch establishes the framework for per-order mTHP
counters. It begins by introducing the anon_fault_alloc and
anon_fault_fallback counters. Additionally, to maintain consistency
with thp_fault_fallback_charge in /proc/vmstat, this patch also tracks
anon_fault_fallback_charge when mem_cgroup_charge fails for mTHP.
Incorporating additional counters should now be straightforward as well.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Yu Zhao <yuzhao@google.com>
---
 include/linux/huge_mm.h | 21 +++++++++++++++++
 mm/huge_memory.c        | 52 +++++++++++++++++++++++++++++++++++++++++
 mm/memory.c             |  5 ++++
 3 files changed, 78 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e896ca4760f6..d4fdb2641070 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -264,6 +264,27 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 					  enforce_sysfs, orders);
 }
 
+enum mthp_stat_item {
+	MTHP_STAT_ANON_FAULT_ALLOC,
+	MTHP_STAT_ANON_FAULT_FALLBACK,
+	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
+	__MTHP_STAT_COUNT
+};
+
+struct mthp_stat {
+	unsigned long stats[ilog2(MAX_PTRS_PER_PTE) + 1][__MTHP_STAT_COUNT];
+};
+
+DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
+
+static inline void count_mthp_stat(int order, enum mthp_stat_item item)
+{
+	if (order <= 0 || order > PMD_ORDER)
+		return;
+
+	this_cpu_inc(mthp_stats.stats[order][item]);
+}
+
 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
 	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index dc30139590e6..dfc38cc83a04 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -526,6 +526,48 @@ static const struct kobj_type thpsize_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
+DEFINE_PER_CPU(struct mthp_stat, mthp_stats) = {{{0}}};
+
+static unsigned long sum_mthp_stat(int order, enum mthp_stat_item item)
+{
+	unsigned long sum = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct mthp_stat *this = &per_cpu(mthp_stats, cpu);
+
+		sum += this->stats[order][item];
+	}
+
+	return sum;
+}
+
+#define DEFINE_MTHP_STAT_ATTR(_name, _index)				\
+static ssize_t _name##_show(struct kobject *kobj,			\
+			struct kobj_attribute *attr, char *buf)		\
+{									\
+	int order = to_thpsize(kobj)->order;				\
+									\
+	return sysfs_emit(buf, "%lu\n", sum_mthp_stat(order, _index));	\
+}									\
+static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
+
+DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
+DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
+DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
+
+static struct attribute *stats_attrs[] = {
+	&anon_fault_alloc_attr.attr,
+	&anon_fault_fallback_attr.attr,
+	&anon_fault_fallback_charge_attr.attr,
+	NULL,
+};
+
+static struct attribute_group stats_attr_group = {
+	.name = "stats",
+	.attrs = stats_attrs,
+};
+
 static struct thpsize *thpsize_create(int order, struct kobject *parent)
 {
 	unsigned long size = (PAGE_SIZE << order) / SZ_1K;
@@ -549,6 +591,12 @@ static struct thpsize *thpsize_create(int order, struct kobject *parent)
 		return ERR_PTR(ret);
 	}
 
+	ret = sysfs_create_group(&thpsize->kobj, &stats_attr_group);
+	if (ret) {
+		kobject_put(&thpsize->kobj);
+		return ERR_PTR(ret);
+	}
+
 	thpsize->order = order;
 	return thpsize;
 }
@@ -880,6 +928,8 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		folio_put(folio);
 		count_vm_event(THP_FAULT_FALLBACK);
 		count_vm_event(THP_FAULT_FALLBACK_CHARGE);
+		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
+		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
 		return VM_FAULT_FALLBACK;
 	}
 	folio_throttle_swaprate(folio, gfp);
@@ -929,6 +979,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		mm_inc_nr_ptes(vma->vm_mm);
 		spin_unlock(vmf->ptl);
 		count_vm_event(THP_FAULT_ALLOC);
+		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_ALLOC);
 		count_memcg_event_mm(vma->vm_mm, THP_FAULT_ALLOC);
 	}
 
@@ -1050,6 +1101,7 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	folio = vma_alloc_folio(gfp, HPAGE_PMD_ORDER, vma, haddr, true);
 	if (unlikely(!folio)) {
 		count_vm_event(THP_FAULT_FALLBACK);
+		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
 		return VM_FAULT_FALLBACK;
 	}
 	return __do_huge_pmd_anonymous_page(vmf, &folio->page, gfp);
diff --git a/mm/memory.c b/mm/memory.c
index 649a547fe8e3..f31da2de19c6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4368,6 +4368,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 		folio = vma_alloc_folio(gfp, order, vma, addr, true);
 		if (folio) {
 			if (mem_cgroup_charge(folio, vma->vm_mm, gfp)) {
+				count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
 				folio_put(folio);
 				goto next;
 			}
@@ -4376,6 +4377,7 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 			return folio;
 		}
 next:
+		count_mthp_stat(order, MTHP_STAT_ANON_FAULT_FALLBACK);
 		order = next_order(&orders, order);
 	}
 
@@ -4485,6 +4487,9 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	folio_ref_add(folio, nr_pages - 1);
 	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_FAULT_ALLOC);
+#endif
 	folio_add_new_anon_rmap(folio, vma, addr);
 	folio_add_lru_vma(folio, vma);
 setpte:
-- 
2.34.1


