Return-Path: <linux-kernel+bounces-90177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A81A86FB6C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEDAB1F22B5B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDD617566;
	Mon,  4 Mar 2024 08:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9d3OlLT"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2F3171CE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709540077; cv=none; b=si3+7K3dRAbji60nU4EdEwJc1VWV/+OAioNAzJdKFZxFG0PwX2+Go9nvC554r6+oI5pd72MuBo6NlJi28f4tHpUJ4mKGS5fKcAURlkMDerDzMYX5Ca1x7MsBctty0GCeN+0DtaRnYr8o5VopX6evHOhXsPV/X+B+RkQd7ibhCoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709540077; c=relaxed/simple;
	bh=PHC2OmMBrBHeHzSR537jJ2GXTFYmQehyNnf3GsevdDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uiq+5tt6PyohlMdXWPMgWyuiAzPmBi6NcqCFFsTteKsul4CMYN2csm0ChxzV88mj1GcVwAj3+jf5xmW0EpdM1X5cUxjI/YdQ3zODdK6K39v9f9upZ5t0BSVGUshnKhk+xfYQLzrEKeqlBdoFCMbeRzjMwTFxcvhpzKPhu145LJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9d3OlLT; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6da202aa138so3020867b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 00:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709540076; x=1710144876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AOQhq+D2hctSN3bqux7faSvf1ZbbOD2cN4aBjG+5ulk=;
        b=D9d3OlLTK1TC2jOvPi5Z2pb9hrOzomJa8LOHJ1pOnCCRV2Ed7pJBudmN3kYk5vvRnE
         UuknfVLeyC1D8M51y3+1rjX94ysmP/g4lOij6qgYb5otD3QEds50EzaMhJ5Z1IyvW2Nr
         9rwEN1/Cu+weVpibnDuqd+eqEnutI5estrPx3cKCp9gV5/ffJbHn8LPC+6RF6ql7NlOu
         gWrB4a2kqE7ArAd3k9fxSi+JzEgGoYkash5/7B6id8M8y51awA7bvNfqxxXBbX8qv/Sx
         TC2NhrQhDy0yqEEQercxGTUEb3ch6BnDW66eopNBRGx1CA/V+pqI6Mi55WoeSoxG8BYm
         Kw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709540076; x=1710144876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOQhq+D2hctSN3bqux7faSvf1ZbbOD2cN4aBjG+5ulk=;
        b=h1Qpv1clVrcb2SNTYbiXr/hji/WvqIqEQaVOz/PdDkB4nNbWgto0FYESn/l5MSluh/
         b5eNKKbx08CW/q+XN/5YJKnTi+vN3N9Ev9GUGBnV+SsoAOX0nOX0MBe9XGcH580eGLYO
         tTTrPQnmOEN8tYAfgwZD1mlSHi9QboK4YXctbpWA+T71fHPLB7Uwyg8XH9pcA8HNb6ZA
         9KnCjjqreVjn7EU8JZvGIqPHlSCHntrt848CHk3+33VyKsboLPD//7CZhcCb2lcBSNnu
         LdUzPSenKK2ncg1Oln5avATKaHxMkidW4aoy7h0CHnglcuc8/1/tBnKT628+agM/hkbW
         M0XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYgyxOVjpNM1daiSzF0X31qvOHd5I8TqoYSPXOSCHEyfwI4j6tC3kU0la/mDspKqiBJqQqw8cRWtP9L5u8+EXYPrTPpXmaDHHO+moc
X-Gm-Message-State: AOJu0YwPtiFb5GUtuDKfBMlEfI6++ZopdsRdc0vF+QKwMmENQRCE00R5
	umi+fwlIMK8D4sxkwZzVA+Na9n6F+IYQ5gSTW96yzl+D1nDoF0I9
X-Google-Smtp-Source: AGHT+IGEsGkarNyt9Jp8whgPA0poRrIOWMKKVHKbcHA3ADNFk6EzEEaBlL35RANkuwLw0QLGLyniCQ==
X-Received: by 2002:a05:6a20:979b:b0:1a1:3000:ab67 with SMTP id hx27-20020a056a20979b00b001a13000ab67mr9356185pzc.46.1709540075740;
        Mon, 04 Mar 2024 00:14:35 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id ka42-20020a056a0093aa00b006e558a67374sm6686387pfb.0.2024.03.04.00.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 00:14:35 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com
Cc: chengming.zhou@linux.dev,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	kasong@tencent.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	nphamcs@gmail.com,
	shy828301@gmail.com,
	steven.price@arm.com,
	surenb@google.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	Chuanhua Han <hanchuanhua@oppo.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: [RFC PATCH v3 2/5] mm: swap: introduce swap_nr_free() for batched swap_free()
Date: Mon,  4 Mar 2024 21:13:45 +1300
Message-Id: <20240304081348.197341-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304081348.197341-1-21cnbao@gmail.com>
References: <20240304081348.197341-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuanhua Han <hanchuanhua@oppo.com>

While swapping in a large folio, we need to free swaps related to the whole
folio. To avoid frequently acquiring and releasing swap locks, it is better
to introduce an API for batched free.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/swap.h |  6 ++++++
 mm/swapfile.c        | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 2955f7a78d8d..d6ab27929458 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -481,6 +481,7 @@ extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t);
 extern void swap_free(swp_entry_t);
+extern void swap_nr_free(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
 extern int free_swap_and_cache(swp_entry_t);
 int swap_type_of(dev_t device, sector_t offset);
@@ -561,6 +562,11 @@ static inline void swap_free(swp_entry_t swp)
 {
 }
 
+void swap_nr_free(swp_entry_t entry, int nr_pages)
+{
+
+}
+
 static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
 {
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 3f594be83b58..244106998a69 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1341,6 +1341,41 @@ void swap_free(swp_entry_t entry)
 		__swap_entry_free(p, entry);
 }
 
+/*
+ * Called after swapping in a large folio, batched free swap entries
+ * for this large folio, entry should be for the first subpage and
+ * its offset is aligned with nr_pages
+ */
+void swap_nr_free(swp_entry_t entry, int nr_pages)
+{
+	int i;
+	struct swap_cluster_info *ci;
+	struct swap_info_struct *p;
+	unsigned type = swp_type(entry);
+	unsigned long offset = swp_offset(entry);
+	DECLARE_BITMAP(usage, SWAPFILE_CLUSTER) = { 0 };
+
+	/* all swap entries are within a cluster for mTHP */
+	VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUSTER);
+
+	if (nr_pages == 1) {
+		swap_free(entry);
+		return;
+	}
+
+	p = _swap_info_get(entry);
+
+	ci = lock_cluster(p, offset);
+	for (i = 0; i < nr_pages; i++) {
+		if (__swap_entry_free_locked(p, offset + i, 1))
+			__bitmap_set(usage, i, 1);
+	}
+	unlock_cluster(ci);
+
+	for_each_clear_bit(i, usage, nr_pages)
+		free_swap_slot(swp_entry(type, offset + i));
+}
+
 /*
  * Called after dropping swapcache to decrease refcnt to swap entries.
  */
-- 
2.34.1


