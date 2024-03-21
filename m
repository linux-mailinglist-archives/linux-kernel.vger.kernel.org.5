Return-Path: <linux-kernel+bounces-110374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B79885E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AD511F26B93
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5843913A242;
	Thu, 21 Mar 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6b48qlK"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746B01386D8
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039075; cv=none; b=iHBUZ+mNsHmIhgRnUYqJkDriKsBUeIYIO+TQl1DrBhLc7YivRV8NsX8ztzRwTr9GzcM/7MslXn26YD2S1nCqDezRIa4Xst2v3dGPdpkgzre/gW8Bd7EA/CXvr8e+9h4f4w/OpJc1BGsyRpy6ELIRdETJEvXiXAEmH2aO1/NDkUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039075; c=relaxed/simple;
	bh=MmVdvfO5LC6xlnfdEs4QpWcPQgkIPaDigwpfUrWBnqk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F1ddaN/MSHbPc09SWkTIU9gnumkRDeRqQkzUhuRTl7E3ciUgsYJYekfl6tFXVE+seti6h0aiRsMBjWkz0hvnFJ0pRhMR3MYwgnhYx3KZsikubDDHSOUWmoSG0W48JpqzGkiTqbyU1nh0aNI32HP20PZ0cpXoO2lTL14xsrSYsoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6b48qlK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dccc49ef73eso1589429276.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711039071; x=1711643871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VNGm+8y6Ss+mlVcFwBeCqCAgvw3+NOVbq/tJOyMa3ww=;
        b=k6b48qlKuYTyAtbrBSpBlbp9s4TuD29XNg2PUvWUK/sO++SLka2xRgi+Ews85668nc
         u/Wqetwc9mqGwhuPKi+niDHoUszTie9YjirlNfRqm+qdlFv2Ns4As5L8g6LSKBXhO+Er
         Zm8DEFU79fnkhGFWUzg60aS9BRHGgRNjA5M5JvrSecFl0KwkaP/MKfTfj0mri8I0n0Yz
         PT3kVB+jfUV215S+5UoSWnDzB5dp01pgqnHus8iyuS8xMj4z8cC2OTB4c6o6G2W4Wm0i
         DWdg/phufirn/+v3cdRasGJBYSbVve7VsWA4wnO9lZrHDQBzhWEuW9KhilDyAokyZd7l
         e/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711039071; x=1711643871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNGm+8y6Ss+mlVcFwBeCqCAgvw3+NOVbq/tJOyMa3ww=;
        b=mahuxNLxfgY2Vgmpy/cIcN4dwxKZnenDnEOciy4SrH9nswwry87p9MILqrLd5DFvuK
         u4UJg4HWspko6UJflY6d3EdWredr6UTb1HN+yZR/yl3Dwv1l5ahB5tUoW7V2OKlFb+46
         3FsJ8qrl7ambN4tLqZ1cHji7d1s2eMWCfmVW6lB4Gu6DjcNF2yAhq+roEnW4OWEwzb90
         pcikH5b86iOE2MdC23lXLfHDGS3zHUjZoT3ctvvQhUF8WaSh/f1hk6c80wDA7ZBZkjLw
         0+zqVt/9IpOTcDcxnJgQcvmnEkihZZLt/yiAp5cmRioOL9rId+j23Y6AbBpnEnZeToMQ
         2c8g==
X-Forwarded-Encrypted: i=1; AJvYcCXnZmlu6SsyaaLT87B+pAie8cRO4vh5+Unwtw3oyJ3k4YSLpk/aRxcsVso1VmqvvYufjsXI7ouFDblvjGgqDnoUINz9Ueb75alsIuMU
X-Gm-Message-State: AOJu0Yz38M3tP2I+B2Zh6TLEnZBApd59X44IZy2d+4eimKWpOEpIPd+O
	w61i7l+/Bv7gmojRhr/wRWGZCglmQPPW7nO0mKNZ2ZnW3gP6BKolbVTFlShx0dG+D3MU2LfyW4y
	UeQ==
X-Google-Smtp-Source: AGHT+IFHuXgNI5SVUJASc8Fg628bHOvpHsCOaQtXol/znxQ1foKXK9QPyvtw6ludSGd9C7o69Hlt2+8i3RA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:a489:6433:be5d:e639])
 (user=surenb job=sendgmr) by 2002:a05:6902:1004:b0:dc6:44d4:bee0 with SMTP id
 w4-20020a056902100400b00dc644d4bee0mr1149298ybt.7.1711039071427; Thu, 21 Mar
 2024 09:37:51 -0700 (PDT)
Date: Thu, 21 Mar 2024 09:36:41 -0700
In-Reply-To: <20240321163705.3067592-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240321163705.3067592-1-surenb@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240321163705.3067592-20-surenb@google.com>
Subject: [PATCH v6 19/37] mm: create new codetag references during page splitting
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, mgorman@suse.de, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	penguin-kernel@i-love.sakura.ne.jp, corbet@lwn.net, void@manifault.com, 
	peterz@infradead.org, juri.lelli@redhat.com, catalin.marinas@arm.com, 
	will@kernel.org, arnd@arndb.de, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, peterx@redhat.com, 
	david@redhat.com, axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, dennis@kernel.org, jhubbard@nvidia.com, tj@kernel.org, 
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org, 
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com, 
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com, 
	keescook@chromium.org, ndesaulniers@google.com, vvvvvv@google.com, 
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, bristot@redhat.com, vschneid@redhat.com, cl@linux.com, 
	penberg@kernel.org, iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, 
	glider@google.com, elver@google.com, dvyukov@google.com, 
	songmuchun@bytedance.com, jbaron@akamai.com, aliceryhl@google.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	surenb@google.com, kernel-team@android.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a high-order page is split into smaller ones, each newly split
page should get its codetag. After the split each split page will be
referencing the original codetag. The codetag's "bytes" counter
remains the same because the amount of allocated memory has not
changed, however the "calls" counter gets increased to keep the
counter correct when these individual pages get freed.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/alloc_tag.h   |  9 +++++++++
 include/linux/pgalloc_tag.h | 30 ++++++++++++++++++++++++++++++
 mm/huge_memory.c            |  2 ++
 mm/page_alloc.c             |  2 ++
 4 files changed, 43 insertions(+)

diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
index 28c0005edae1..bc9b1b99a55b 100644
--- a/include/linux/alloc_tag.h
+++ b/include/linux/alloc_tag.h
@@ -106,6 +106,15 @@ static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag
 	this_cpu_inc(tag->counters->calls);
 }
 
+static inline void alloc_tag_ref_set(union codetag_ref *ref, struct alloc_tag *tag)
+{
+	alloc_tag_add_check(ref, tag);
+	if (!ref || !tag)
+		return;
+
+	__alloc_tag_ref_set(ref, tag);
+}
+
 static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_tag *tag, size_t bytes)
 {
 	alloc_tag_add_check(ref, tag);
diff --git a/include/linux/pgalloc_tag.h b/include/linux/pgalloc_tag.h
index 66bd021eb46e..093edf98c3d7 100644
--- a/include/linux/pgalloc_tag.h
+++ b/include/linux/pgalloc_tag.h
@@ -67,11 +67,41 @@ static inline void pgalloc_tag_sub(struct page *page, unsigned int nr)
 	}
 }
 
+static inline void pgalloc_tag_split(struct page *page, unsigned int nr)
+{
+	int i;
+	struct page_ext *page_ext;
+	union codetag_ref *ref;
+	struct alloc_tag *tag;
+
+	if (!mem_alloc_profiling_enabled())
+		return;
+
+	page_ext = page_ext_get(page);
+	if (unlikely(!page_ext))
+		return;
+
+	ref = codetag_ref_from_page_ext(page_ext);
+	if (!ref->ct)
+		goto out;
+
+	tag = ct_to_alloc_tag(ref->ct);
+	page_ext = page_ext_next(page_ext);
+	for (i = 1; i < nr; i++) {
+		/* Set new reference to point to the original tag */
+		alloc_tag_ref_set(codetag_ref_from_page_ext(page_ext), tag);
+		page_ext = page_ext_next(page_ext);
+	}
+out:
+	page_ext_put(page_ext);
+}
+
 #else /* CONFIG_MEM_ALLOC_PROFILING */
 
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
 				   unsigned int nr) {}
 static inline void pgalloc_tag_sub(struct page *page, unsigned int nr) {}
+static inline void pgalloc_tag_split(struct page *page, unsigned int nr) {}
 
 #endif /* CONFIG_MEM_ALLOC_PROFILING */
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c77cedf45f3a..b29f9ef0fcb2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -38,6 +38,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/memory-tiers.h>
 #include <linux/compat.h>
+#include <linux/pgalloc_tag.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
@@ -2924,6 +2925,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	/* Caller disabled irqs, so they are still disabled here */
 
 	split_page_owner(head, order, new_order);
+	pgalloc_tag_split(head, 1 << order);
 
 	/* See comment in __split_huge_page_tail() */
 	if (folio_test_anon(folio)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9c86ef2a0296..fd1cc5b80a56 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2666,6 +2666,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i = 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, order, 0);
+	pgalloc_tag_split(page, 1 << order);
 	split_page_memcg(page, order, 0);
 }
 EXPORT_SYMBOL_GPL(split_page);
@@ -4863,6 +4864,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
 		struct page *last = page + nr;
 
 		split_page_owner(page, order, 0);
+		pgalloc_tag_split(page, 1 << order);
 		split_page_memcg(page, order, 0);
 		while (page < --last)
 			set_page_refcounted(last);
-- 
2.44.0.291.gc1ea87d7ee-goog


