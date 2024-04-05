Return-Path: <linux-kernel+bounces-132826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81C9899ACA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA531C214EE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DE31649D7;
	Fri,  5 Apr 2024 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cmmk86d3"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30991649B3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712312852; cv=none; b=PTmp1MYBaNgriqHblHtFgORS6TP7bPokg0MKFRvvIGdcMnoNk3kAR2e9iur8ZVDm3k4WVSZU6IvU31me7FJXfrUodHNluqz+PanFmDWJa88ZdRzQUGvC/F+jky28Dq7WLC7Ml2yybPdSuI0tUXXnxh/yKhx5DNntG4er94IqIjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712312852; c=relaxed/simple;
	bh=WURzhiHUsRPfCjHdtBvME0gbF+PimGo+jHoV15Bt+so=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTwRDEawWXJwRwRoEqhD/NnYs4IbM9ZumVgmYQAtjswd4v2pgpj3nVPcq4Q4bdAUZmEUVnkxjZiTkE/sC6k7j0JbbQa3gWHXz7qWA+LJXAfUsNt9t4Ch+501PCGkZvtWo9tsOqKlz1JpQxl4Cgkx+fzVnJotRN0E/41LdDIbT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cmmk86d3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ecf8ebff50so834220b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 03:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712312850; x=1712917650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZWljBCC9KrF5CNn3q7EM6c1BT8pMAntpGQOmXRtUQU=;
        b=Cmmk86d3bGG04uqXzVrGIV6IjcEO/RaK0rU5k1HJEDcV8b0noog4g53wnKHJ09Ll5J
         Ac/mSLmRfMd9UpevprcY5tqfizMMqzsyakXPxHo7ITzTpuZjaZIVp5an8cfI0alnFwlY
         L1FiuHKMND9vLGgIJQAp6/lOdpAcJ4hikdBspKTxe/JFKwtJJMpTpBX8vpPkdEOpfcPf
         6uoqELwnmFhfP0o8xb27wufU2UbCKOtHPJupQo7lW3nrqrWrEPAgQldhSLE74sQqCS7H
         uEM7hY4gjltPcrmeGhesgt5T0gnUMDdxUnPn7saqGrl6OdHuvCKAUXbd2jEM0b1g6+be
         LmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712312850; x=1712917650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZWljBCC9KrF5CNn3q7EM6c1BT8pMAntpGQOmXRtUQU=;
        b=ecoHuJRgfHYIs4iEfNkoHDcC8c8KuuKFtgzlel1Yv3Z0EFjQ7wQQ7VbJIqBT8iN63O
         Eh5glg10Rc5LXxQqv8WCZhq/EdNTwP43JLz6vNKlfoR1T2XCBCPAs7yq5SQUFRcSfgdj
         oe2z5OM0VpmZt6UzqPs6RTR4Xim9T5ikM7cJPhknvCfmP58tTO8YKR0rvhLCBdKJP6qW
         MxHEmZpvkpqWAbpo1Q1fpesZiYAG0EFywq1TcZxa8xIDo5PQtu55zRbz/1nFpWTeGycl
         ilrLSRE6YjQE5EFkngrZ5rMWWFHFu6FVW8Wf8+VsjkGjNsY0uQliFpIQnNUm4KnIp0Fc
         rA2g==
X-Forwarded-Encrypted: i=1; AJvYcCVBY4iwn4qLR56wMTzioJC3TzyVoiDbNL1JeY50PimA/OEw5utcQy9mxmqpilSl3FPBtwIhtVz5rl5DvFCZYKimnwRKIVDm6Ld96rF5
X-Gm-Message-State: AOJu0YwMUZsAR9UBGAiifwAd2Frci6RJm12DPvhznRTIWFlYn2P/MpA+
	8epj2r5eXphdTnfB+p//c1XFlCA4R/r9Jc0HOlmejV3d1HRGHvN8
X-Google-Smtp-Source: AGHT+IGtMKiEbIdv0FWwPdoZQEr/By0dCwSDG7UHQlGksBrCqvl3FEssVeROn/+hGtNQ6NcBdk65wA==
X-Received: by 2002:a05:6a21:a5a9:b0:1a7:2451:aeac with SMTP id gd41-20020a056a21a5a900b001a72451aeacmr1784226pzc.16.1712312850194;
        Fri, 05 Apr 2024 03:27:30 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id f20-20020a056a00229400b006ed06aa3604sm113334pfe.82.2024.04.05.03.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 03:27:29 -0700 (PDT)
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
Subject: [PATCH v4 1/2] mm: add per-order mTHP anon_alloc and anon_alloc_fallback counters
Date: Fri,  5 Apr 2024 23:27:03 +1300
Message-Id: <20240405102704.77559-2-21cnbao@gmail.com>
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

Profiling a system blindly with mTHP has become challenging due to the
lack of visibility into its operations. Presenting the success rate of
mTHP allocations appears to be pressing need.

Recently, I've been experiencing significant difficulty debugging
performance improvements and regressions without these figures.
It's crucial for us to understand the true effectiveness of mTHP in
real-world scenarios, especially in systems with fragmented memory.

This patch sets up the framework for per-order mTHP counters, starting
with the introduction of anon_alloc and anon_alloc_fallback counters.
Incorporating additional counters should now be straightforward as well.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/huge_mm.h | 19 ++++++++++++++++
 mm/huge_memory.c        | 48 +++++++++++++++++++++++++++++++++++++++++
 mm/memory.c             |  2 ++
 3 files changed, 69 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e896ca4760f6..c5d33017a4dd 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -264,6 +264,25 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 					  enforce_sysfs, orders);
 }
 
+enum mthp_stat_item {
+	MTHP_STAT_ANON_ALLOC,
+	MTHP_STAT_ANON_ALLOC_FALLBACK,
+	__MTHP_STAT_COUNT
+};
+
+struct mthp_stat {
+	unsigned long stats[PMD_ORDER + 1][__MTHP_STAT_COUNT];
+};
+
+DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
+
+static inline void count_mthp_stat(int order, enum mthp_stat_item item)
+{
+	if (unlikely(order > PMD_ORDER))
+		return;
+	this_cpu_inc(mthp_stats.stats[order][item]);
+}
+
 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
 	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 9d4b2fbf6872..5b875f0fc923 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -526,6 +526,46 @@ static const struct kobj_type thpsize_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops,
 };
 
+DEFINE_PER_CPU(struct mthp_stat, mthp_stats) = {{{0}}};
+
+static unsigned long sum_mthp_stat(int order, enum mthp_stat_item item)
+{
+	unsigned long sum = 0;
+	int cpu;
+
+	for_each_online_cpu(cpu) {
+		struct mthp_stat *this = &per_cpu(mthp_stats, cpu);
+
+		sum += this->stats[order][item];
+	}
+
+	return sum;
+}
+
+#define DEFINE_MTHP_STAT_ATTR(_name, _index)					\
+static ssize_t _name##_show(struct kobject *kobj,			\
+			struct kobj_attribute *attr, char *buf)		\
+{									\
+	int order = to_thpsize(kobj)->order;				\
+									\
+	return sysfs_emit(buf, "%lu\n", sum_mthp_stat(order, _index));	\
+}									\
+static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
+
+DEFINE_MTHP_STAT_ATTR(anon_alloc, MTHP_STAT_ANON_ALLOC);
+DEFINE_MTHP_STAT_ATTR(anon_alloc_fallback, MTHP_STAT_ANON_ALLOC_FALLBACK);
+
+static struct attribute *stats_attrs[] = {
+	&anon_alloc_attr.attr,
+	&anon_alloc_fallback_attr.attr,
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
@@ -549,6 +589,12 @@ static struct thpsize *thpsize_create(int order, struct kobject *parent)
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
@@ -1050,8 +1096,10 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
 	folio = vma_alloc_folio(gfp, HPAGE_PMD_ORDER, vma, haddr, true);
 	if (unlikely(!folio)) {
 		count_vm_event(THP_FAULT_FALLBACK);
+		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_ALLOC_FALLBACK);
 		return VM_FAULT_FALLBACK;
 	}
+	count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_ALLOC);
 	return __do_huge_pmd_anonymous_page(vmf, &folio->page, gfp);
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index 649e3ed94487..1723c8ddf9cb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4374,8 +4374,10 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
 			}
 			folio_throttle_swaprate(folio, gfp);
 			clear_huge_page(&folio->page, vmf->address, 1 << order);
+			count_mthp_stat(order, MTHP_STAT_ANON_ALLOC);
 			return folio;
 		}
+		count_mthp_stat(order, MTHP_STAT_ANON_ALLOC_FALLBACK);
 next:
 		order = next_order(&orders, order);
 	}
-- 
2.34.1


