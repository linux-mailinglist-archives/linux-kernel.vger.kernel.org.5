Return-Path: <linux-kernel+bounces-136455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150DE89D433
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F61B1F246C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DFE7EEE1;
	Tue,  9 Apr 2024 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2Ghk5W2"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC847E777
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651218; cv=none; b=Fbw1OV2tfRpOnGCU3u5MRH3dtDYBSdobT9W1W+mCAgywEUILDqC4KWMMopCPoptBRLtBeu7qZEctEQDf9m9Fxcp84Y8ZJRTdQBvUQbim8vrVNmECC9TV/90PQq9eJW77yAmaE1rwkinr7/khV3w1BKVaA/1a5wdRoe0J4ecGPKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651218; c=relaxed/simple;
	bh=ZVVZQhufHZgVYRPoViiMgUgHDRKoZRsicNrqLop/teo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=grgF4NKNskq4tBgDzafFAvkdvchC4rifvJGjMu87DbGW406Xiei3R5xJBuDUPD0nvZtzdD/cmnhdTammLbkhTsUtHQ326cqu9QuCDhc/ODYAXd3DryHZ20mhbjXXhnt/aTEzSg9kTh3+oiln67Y6awhgpsQA4MoPWY+u2pjEX3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2Ghk5W2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ecfeefe94cso2614593b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712651216; x=1713256016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei1Crh3xKYkUssDLy2Y3ak8IjHOYPwPhmj2M8HC/g7Q=;
        b=J2Ghk5W2gCEB0aYkxGY2E322Cjo94GTTUh0IJMz9+MLDbJb7m40yi3aAdRdajuqDD/
         mrlcCOps9dNdzV4Qikq1ouFrVvsQUStKNWaCvuwWXkSnBUuJI7uS+xtmTrm7bi/hLv1E
         BshgUb90wMhKiML0Q3BZ63jdNZqFXMB+IsuFpZXP9ekabxWdGd9NLawnyQR0IX5sv8Ry
         eipjO12gFqXzOi+tCTABUKexhnpcnkaZdqYjIL4CBVXYIwT8yzgI76eNnT/QPDhYScND
         2JMXz4sUwgj8OIoz/51CZJBw3XYRTC8KLGn16cqFICuQzJ5kbZgOjV2HdDCHFC+47mAu
         Wgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712651216; x=1713256016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ei1Crh3xKYkUssDLy2Y3ak8IjHOYPwPhmj2M8HC/g7Q=;
        b=ksnQ8nm3eFyosLmWbeCx+ZNZgJm3MULNEEJHmx4icbRl65FQFzDaJ6tvSLo5oh6UyR
         tyNq1sz+4irgijBm5/LIZ0H3lO/rvmAi7G2W+6elfqtERjr40bhlpkbBz4xEcFE38UUf
         dAjE8GeDzUu87yCqUIR/baT4BMAQku/hNR9NFRtahVoqMohBBdyCG64nAkwguheoZwIY
         Y0i2Eh6PO4Y5wRKxkiOocoz0/Wct769N53gj3MmIwHu5lCti5ZCwu7NDJkxNcVba5umf
         3AHWeGkuN8GpcUAUfRvwV6CWWiGN0VcexJoa+5mUqDQXyjRMo6p3pHMpgOgiDaIM5ME1
         T3Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVk3GnYitxYAUnLZyiWEWUD1B3fRzbVnuLfEXWOSdGnrikN7Kyz5u13ScdHPyFhkmjVbtf2dbHXte3FbWHMKHDG7+5FYfQunuQhtkEu
X-Gm-Message-State: AOJu0YwTqQiv3pqvYonUUaVtTL2ucqlZOgP4MFWpL6SECrIjRdIQPoWo
	4Ma3gHRyWzLvrfzxrZxebiEio4MJRRRMQQEEnMAfQHpjhM+S5WNRs9SdR7m9GTM=
X-Google-Smtp-Source: AGHT+IHZGO/8Oq5G4AI8d7uAa0Xfd/UfJnN/mN1F1Zgkmt5jIyqoC0gKP++Z8vrGbui309CoYrBrbQ==
X-Received: by 2002:a05:6a20:430c:b0:1a7:5413:1e6d with SMTP id h12-20020a056a20430c00b001a754131e6dmr3319733pzk.4.1712651216427;
        Tue, 09 Apr 2024 01:26:56 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id r16-20020a632050000000b005f05c88c149sm7594238pgm.71.2024.04.09.01.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:26:56 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kasong@tencent.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] mm: swap: introduce swap_free_nr() for batched swap_free()
Date: Tue,  9 Apr 2024 20:26:27 +1200
Message-Id: <20240409082631.187483-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409082631.187483-1-21cnbao@gmail.com>
References: <20240409082631.187483-1-21cnbao@gmail.com>
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
 include/linux/swap.h |  5 +++++
 mm/swapfile.c        | 51 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 11c53692f65f..b7a107e983b8 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -483,6 +483,7 @@ extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t);
 extern void swap_free(swp_entry_t);
+extern void swap_free_nr(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
 extern void free_swap_and_cache_nr(swp_entry_t entry, int nr);
 int swap_type_of(dev_t device, sector_t offset);
@@ -564,6 +565,10 @@ static inline void swap_free(swp_entry_t swp)
 {
 }
 
+void swap_free_nr(swp_entry_t entry, int nr_pages)
+{
+}
+
 static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
 {
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 28642c188c93..f4c65aeb088d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1356,6 +1356,57 @@ void swap_free(swp_entry_t entry)
 		__swap_entry_free(p, entry);
 }
 
+/*
+ * Free up the maximum number of swap entries at once to limit the
+ * maximum kernel stack usage.
+ */
+#define SWAP_BATCH_NR (SWAPFILE_CLUSTER > 512 ? 512 : SWAPFILE_CLUSTER)
+
+/*
+ * Called after swapping in a large folio, batched free swap entries
+ * for this large folio, entry should be for the first subpage and
+ * its offset is aligned with nr_pages
+ */
+void swap_free_nr(swp_entry_t entry, int nr_pages)
+{
+	int i, j;
+	struct swap_cluster_info *ci;
+	struct swap_info_struct *p;
+	unsigned int type = swp_type(entry);
+	unsigned long offset = swp_offset(entry);
+	int batch_nr, remain_nr;
+	DECLARE_BITMAP(usage, SWAP_BATCH_NR) = { 0 };
+
+	/* all swap entries are within a cluster for mTHP */
+	VM_BUG_ON(offset % SWAPFILE_CLUSTER + nr_pages > SWAPFILE_CLUSTER);
+
+	if (nr_pages == 1) {
+		swap_free(entry);
+		return;
+	}
+
+	remain_nr = nr_pages;
+	p = _swap_info_get(entry);
+	if (p) {
+		for (i = 0; i < nr_pages; i += batch_nr) {
+			batch_nr = min_t(int, SWAP_BATCH_NR, remain_nr);
+
+			ci = lock_cluster_or_swap_info(p, offset);
+			for (j = 0; j < batch_nr; j++) {
+				if (__swap_entry_free_locked(p, offset + i * SWAP_BATCH_NR + j, 1))
+					__bitmap_set(usage, j, 1);
+			}
+			unlock_cluster_or_swap_info(p, ci);
+
+			for_each_clear_bit(j, usage, batch_nr)
+				free_swap_slot(swp_entry(type, offset + i * SWAP_BATCH_NR + j));
+
+			bitmap_clear(usage, 0, SWAP_BATCH_NR);
+			remain_nr -= batch_nr;
+		}
+	}
+}
+
 /*
  * Called after dropping swapcache to decrease refcnt to swap entries.
  */
-- 
2.34.1


