Return-Path: <linux-kernel+bounces-85927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 563CB86BCE2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93121F24E49
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05FF34545;
	Thu, 29 Feb 2024 00:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWgyZS1i"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9410D2E851
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167123; cv=none; b=gq4dRpy3FLMuGVaznj/+p7TCOm4+/aODM8hq5/IrAcLXYqWCAz13L2GIf+a5zEscQn8hmh2JwedsRzpp84KQhlJ6Fg1TzOzVuleG701gRrkuXzomi8scfPJ5SJk04O0l86AxjoRffMPjckefP+iBzLGlmmXrCosLrv/nSMFJhJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167123; c=relaxed/simple;
	bh=cIgsX/okUpGvURqUeaQmBadiRRitG9Nc7gxU81tM22Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9JwG4wMFH5ait/nHg+IAueScmZ9jAqjVHpQGMG6XZ9sWmi904BXdPZJetSr3SVT9gMJOm4IGY8ZSCFpaZ04el1zA0hOdS/rx/IWAh22N1VBy+GZHqU5ykzCDoX4lq1uLE7ZMueZzmOV/HlAThpFiTz5AXUBQc5ewWDE5SdQQu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWgyZS1i; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dba177c596so2667325ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709167121; x=1709771921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMJ7yXDIGraWBc5cHOK7WDJvzj0gdP9hzucxgbPAd4E=;
        b=LWgyZS1isSKVdBaUD8XhjE88vnz0GCSMqspSVS+9jJ6pfNLsu77wa0mqZmuifbUxBa
         ge4Cvj50JJvd0kLuOc1n1VOXsIM/uJ6ibqIIaCx4ZG5TeTb575T1OJ7pr+Npe3kO9KTg
         F45cNv2F9vX7zEbnxF0dF63B6Q2ritqm9eCHRXaBY3AfeCEUKOF+SAdYbbldjZ+0/P9+
         uqQa9X8Rf0EynB9q1UaMvl2Z+na3FyByZii/VIhLsy1Q7cpDRvCuGb9kDeuFLlCY+kIG
         P6Xk5QjJmihgIRiaLhQIaL9swTiGqqZu2CD3nWf1neeWglW5s/EQy4TBbcIVSzHzt2i9
         hFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709167121; x=1709771921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMJ7yXDIGraWBc5cHOK7WDJvzj0gdP9hzucxgbPAd4E=;
        b=dSrKzmqVv/C1IFMzMHGQErRSPwXJL97W5bCKYbGuFKx4j5GjEBdfNrYE2kQjz+r/1k
         Tulku8/l/iH2R18w6UiHQ1wzDh5Kn9mYkJcYq0yyUypT89ASrq8HlhSaKxdKzm+jdSeQ
         fui98vkvH6KQDDjicW7IaWPxVS88RrGJzPDs+GgU7JkxyZgTosfY705GKl2dXcJnLd0T
         12SqruECZ/a5UJ8TSZdSgs7O+36rOT4a7CBbHRRxz4McY2uAFOfL17FaC9YkWekxIKX5
         imOjs6s5LwjY2Qr74d87Lz8DDKVM+6QC5y9RuTeIjHgUyO52tu7ybEsqoQUJvO0cHT2E
         ZqDw==
X-Forwarded-Encrypted: i=1; AJvYcCUTAj32IFv90+xWkY44TFX9KqOwYgh3n2VszqzXCKA3GeyEgMxNHituVi3hQk7AeuSyBeXdNWbkSAbL8lNNTu1NWO8k15vpEptz6EVp
X-Gm-Message-State: AOJu0YyRvkkIxYdpUcQc+4qUfRNLQuBtTgl9dYdyXQMHAabuC662uIXy
	niZY7e/++5QWTMSUXiucg1C2obz8m63msjs8d/axp3xMe33dXp/V
X-Google-Smtp-Source: AGHT+IHcSLxazfOE73baRJGF/GDzC2Ut3tKmCraQkgILYtM8ozQfrAGo7OOUSaQPjCdA4QL0Tm1Qmw==
X-Received: by 2002:a17:902:e5c2:b0:1d9:adc9:2962 with SMTP id u2-20020a170902e5c200b001d9adc92962mr530369plf.20.1709167120889;
        Wed, 28 Feb 2024 16:38:40 -0800 (PST)
Received: from localhost.localdomain ([2407:7000:8942:5500:5158:ed66:78b3:7fda])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902780300b001d9641003cfsm62647pll.142.2024.02.28.16.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 16:38:40 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	linux-mm@kvack.org,
	ryan.roberts@arm.com,
	chrisl@kernel.org
Cc: 21cnbao@gmail.com,
	linux-kernel@vger.kernel.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	steven.price@arm.com,
	surenb@google.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	kasong@tencent.com,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	hannes@cmpxchg.org,
	linux-arm-kernel@lists.infradead.org,
	Chuanhua Han <hanchuanhua@oppo.com>,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC v2 2/5] mm: swap: introduce swap_nr_free() for batched swap_free()
Date: Thu, 29 Feb 2024 13:37:50 +1300
Message-Id: <20240229003753.134193-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229003753.134193-1-21cnbao@gmail.com>
References: <20240229003753.134193-1-21cnbao@gmail.com>
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
index 25f6368be078..b3581c976e5f 100644
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
index 2b3a2d85e350..c0c058ee7b69 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1340,6 +1340,41 @@ void swap_free(swp_entry_t entry)
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


