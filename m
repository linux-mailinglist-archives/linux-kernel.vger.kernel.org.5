Return-Path: <linux-kernel+bounces-167118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F058BA4B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE486B212C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF2CC13D;
	Fri,  3 May 2024 00:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eu0rJlFw"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB6BBA53
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714697453; cv=none; b=JzAx7bxdK/veDNMdBY3B2bP6u32EIFBweqXuSNyzlx2Q4iD2LmVlTgBamfzf7zW7eL3WeQVoypwgqTg3ndgziSN1VnHp88IUQBCsciY89WW0XVkX/McFk4k2Dl2S/sVV1XK3GhbrRxV1JXrjSxWWoA7rk6t4qB8eYN6Kf0IWdKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714697453; c=relaxed/simple;
	bh=Rwkln1NM+NdA1PcVGtpQVbTXcTpZ9hnMHyu91T/s6t0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MQ4efcyFVrqzbPbsNH7zEnKQ9aqDfEPTXl/dFd36ayLWQjTgF4nk9MZVV92QkORHj9GfxVLmkUyv5KFWCz0RkDpjPKLiDgc3DS8HQ2nfAdn3e1GKrQUkaAmDGT0wQNo3UiJAqFg3849dM4MpkMb6PjkGjaCmltYoO2ZEPGyC4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eu0rJlFw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3f17c6491so72045125ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 17:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714697451; x=1715302251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZtaFVcTSDB4ul8nNoaO/PcEtn9Rrjc3ITa59z6anjw=;
        b=eu0rJlFwphXNCNrUoxktH69Vn3+GsdN/ISlSxQDvPLA0uFKa34U9ePJSDiyQjmb6z4
         Gf+5jzMx/fx/Hd+NeXDpnV1LMSLYFj6L8hLzgSyk6APxK8cSOEViZcs7gv4vQ7Q0QklO
         R2wsPnoEF3OBvJD6w7MZsY93bxNEoPMVMIUa95M/nIE45ETD/8B6/RmVX4NW3psJbkBO
         eS1MSamuSB1NDNfAY+VH4+BxzQaLT8o6Xe2e330RaAoH9e1zGrvUl6jJ3HMleon7qtl4
         p2jeEyx3geSTv0CA6MQEzLwx420eXkHl4PwpWtREcmSV+g80FtbXLgCYnKCnOK9uuNXo
         3iUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714697451; x=1715302251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZtaFVcTSDB4ul8nNoaO/PcEtn9Rrjc3ITa59z6anjw=;
        b=Pb7irlH0131/SZBv5lljNAS8IZeOieAdS3ySOSft6d1V9t94hw9WFUYdhyRL76GicY
         hV8jHNQnj5qUmX+mB9bfPbOiaP4VUtw2XfdOnIdof0DWSx4LhH05Mn2HZ9W3GQa0p+qn
         wMfTvotfVtbCarelS2qVRgzdtRFfVQl9Nu/NmExQhYsqw6ljatWHXiR+cn4Yiz5fuY+o
         21+skUI2dbkJ381LVHno8cfoPWWLVtGtEvgh9fvy7RDqjeq16FyA5ilLC7LDFhdF6b1x
         nDy2oyqo5VzQ2nGOrZ8cHB1oBLtaC7ZK26J5Xa0EIdVHGy98CCailSu43RCvZ52bNU6I
         B2jA==
X-Forwarded-Encrypted: i=1; AJvYcCU6qCd5NqNW8r7FhwxqX4nY/ey5ybIPWylvN/oBRXRDXSyxvugmHUymltHMIz8LcP8Yckc8wSt2kFjeORtABEfEBF+L71zVT397mmXy
X-Gm-Message-State: AOJu0YxpArfGbQW4FGpkiYlwBA51DWEHM6eWuGw7tzMY9bsJVBfwh8oB
	hKpIfFOc9i+eEXU5tOD9y3OZR2oq538Gn54BvYdXuxBgs/1oecpE
X-Google-Smtp-Source: AGHT+IEefQkadUJjt20GqF9jK1qsxgF1ScWbbqdgQAWnvfCb3u+RiScs5Eeaq3V8oWvBSMJbyG0VfA==
X-Received: by 2002:a17:902:bb8b:b0:1e8:b768:2c25 with SMTP id m11-20020a170902bb8b00b001e8b7682c25mr1211101pls.15.1714697450969;
        Thu, 02 May 2024 17:50:50 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001ec48e41d2esm1969175plh.212.2024.05.02.17.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 17:50:50 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yosryahmed@google.com,
	yuzhao@google.com,
	ziy@nvidia.com
Subject: [PATCH v3 1/6] mm: swap: introduce swap_free_nr() for batched swap_free()
Date: Fri,  3 May 2024 12:50:18 +1200
Message-Id: <20240503005023.174597-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240503005023.174597-1-21cnbao@gmail.com>
References: <20240503005023.174597-1-21cnbao@gmail.com>
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
Furthermore, this new function, swap_free_nr(), is designed to efficiently
handle various scenarios for releasing a specified number, nr, of swap
entries.

Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
Co-developed-by: Barry Song <v-songbaohua@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/swap.h |  5 +++++
 mm/swapfile.c        | 47 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 11c53692f65f..d1d35e92d7e9 100644
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
 
+static inline void swap_free_nr(swp_entry_t entry, int nr_pages)
+{
+}
+
 static inline void put_swap_folio(struct folio *folio, swp_entry_t swp)
 {
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f6ca215fb92f..ec12f2b9d229 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1356,6 +1356,53 @@ void swap_free(swp_entry_t entry)
 		__swap_entry_free(p, entry);
 }
 
+static void cluster_swap_free_nr(struct swap_info_struct *sis,
+		unsigned long offset, int nr_pages)
+{
+	struct swap_cluster_info *ci;
+	DECLARE_BITMAP(to_free, BITS_PER_LONG) = { 0 };
+	int i, nr;
+
+	ci = lock_cluster_or_swap_info(sis, offset);
+	while (nr_pages) {
+		nr = min(BITS_PER_LONG, nr_pages);
+		for (i = 0; i < nr; i++) {
+			if (!__swap_entry_free_locked(sis, offset + i, 1))
+				bitmap_set(to_free, i, 1);
+		}
+		if (!bitmap_empty(to_free, BITS_PER_LONG)) {
+			unlock_cluster_or_swap_info(sis, ci);
+			for_each_set_bit(i, to_free, BITS_PER_LONG)
+				free_swap_slot(swp_entry(sis->type, offset + i));
+			if (nr == nr_pages)
+				return;
+			bitmap_clear(to_free, 0, BITS_PER_LONG);
+			ci = lock_cluster_or_swap_info(sis, offset);
+		}
+		offset += nr;
+		nr_pages -= nr;
+	}
+	unlock_cluster_or_swap_info(sis, ci);
+}
+
+void swap_free_nr(swp_entry_t entry, int nr_pages)
+{
+	int nr;
+	struct swap_info_struct *sis;
+	unsigned long offset = swp_offset(entry);
+
+	sis = _swap_info_get(entry);
+	if (!sis)
+		return;
+
+	while (nr_pages) {
+		nr = min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
+		cluster_swap_free_nr(sis, offset, nr);
+		offset += nr;
+		nr_pages -= nr;
+	}
+}
+
 /*
  * Called after dropping swapcache to decrease refcnt to swap entries.
  */
-- 
2.34.1


