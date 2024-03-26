Return-Path: <linux-kernel+bounces-119743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2A188CCA0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25DA327DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF5D13CC62;
	Tue, 26 Mar 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfFZL5W9"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D8413CC44
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479863; cv=none; b=tZshbS+TxfQs3n4vYNwvi1oKZ6cBTLOZeIZ91KpzNpP/O/iuRdYq9oQrVqTzGm9vxV09r6m1eGoXdS/4QtNyypTqZCIeFRjFCQm+77nxsrnYOWZXuoxjRYsOWGzsGkF5+OCh+eR8nobdVW4rxofIuv3q/2tK/QvppSCMyoSYk44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479863; c=relaxed/simple;
	bh=tkhzRdtmDHxGPLSNGrCz95fBiO47MFeM9d6uWVZhm/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V549Xv4xPhjvMebThlmr9QSpIFGsFyTvm6g7Ao7xFncr+t7SMHDHr1ko+jNCcu3W3hTc+ptCp7u8oOkyOa4JUJTYPwYIr+7qGoL6WsYMwTge+dIkQR6cphJEmBL6+ROf4F0r805ZI5/YGlX/aEAGj14BbKTAUS7jsHEDUzbN3UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfFZL5W9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6b5432439so4576676b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711479861; x=1712084661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MPCeiBQ6Vuv/VMKCl+70rHoy18EK+MdrkqBGmpRbWL4=;
        b=LfFZL5W9iI8VA0D87qczM7mAbvunmMc6ltI0tk36kwnYX0S3s8Ei0gSxMxpXIN6c2j
         DnPWc3A5Z7amYnWfonyKeenwgwghOrCLLft8UcXDIwFJMhnNuCWttpk4Jyy9J4lTBIYq
         cthoTByMsCiXIoLMqfKs0Gbv7UfUjiSRDwRWiFTPxogvxs5uHKV4Iji3oIy2pRENLrdH
         8+iohbDEs8JUwc0DXFfxrk0pibpAgiEcsXf8Dr3eK6slwANvCW9O/k1tPv8Xl8OMG+lh
         VAPlr+316zCGHnx+07/aeiqRp7ruEZOlG23UBEYq3TuCJYOraGbaUREFFjiMSS1YluZF
         Wl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711479861; x=1712084661;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPCeiBQ6Vuv/VMKCl+70rHoy18EK+MdrkqBGmpRbWL4=;
        b=MrsJtFM7Rv2/txNxOZ6U5tKNpSE6VNjFmgCes52mLPwsmTzD1AMe7gONncVnRW54j5
         M1xcCYUCvRUIf6XApHhyK2UeMNjbVuNzkDzE7sClmFGmwpgVCk6chSxs+HLuDqgQvgPI
         QymkzleW2zZs3nJIivMTkbBttX8zgtC3hztOZ3r3bb1tB1gZL/iVqiRxLGA1AItXZtgG
         9SGTenLHkmBrSYkK+jUw7rvjBkTOZLYieJH2UpLwmClNt5L3SHR1yFM534oNPAP93bFi
         8vrUY2kAC/sJH17IS9/xHIYdjUZTi5bc2NewoWDdFsoB1aKYgB+GGA4RVtEeViSo69si
         qq8A==
X-Forwarded-Encrypted: i=1; AJvYcCWQr3wlk0lOuYhddkWSYh5RCxHyY/b3tOVObw09TyyPqvY7TxF34h6qZ1kWU64Mx2Xc3p36FAsaXbGXd+tX3/xsN34zUoyA8z1o+B8N
X-Gm-Message-State: AOJu0YwCDF4CwiS+9n//r0sUIzJN3f0KddIAEN8IFEm68cfUiB3CD7LA
	1DtJC3zUIqlGbmXG/i+0bOG19/QCXNzNUpDS/ugdyVLrsFA5Ak8Z
X-Google-Smtp-Source: AGHT+IEvuj2NywPp4edKIveEUgd69iy3TfxxMJh0u9KQ2EoAOriC83NY/O9bepwSOY7NB56Qt1OqEA==
X-Received: by 2002:a05:6a00:814:b0:6e6:830:cd13 with SMTP id m20-20020a056a00081400b006e60830cd13mr2478320pfk.23.1711479860988;
        Tue, 26 Mar 2024 12:04:20 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id j14-20020aa783ce000000b006ea790c2232sm6298350pfn.79.2024.03.26.12.04.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Mar 2024 12:04:20 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: "Huang, Ying" <ying.huang@intel.com>,
	Chris Li <chrisl@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Yu Zhao <yuzhao@google.com>,
	SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 01/10] mm/filemap: split filemap storing logic into a standalone helper
Date: Wed, 27 Mar 2024 02:50:23 +0800
Message-ID: <20240326185032.72159-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326185032.72159-1-ryncsn@gmail.com>
References: <20240326185032.72159-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Swapcache can reuse this part for multi index support, no change of
performance from page cache side except noise:

Test in 8G memory cgroup and 16G brd ramdisk.

  echo 3 > /proc/sys/vm/drop_caches

  fio -name=cached --numjobs=16 --filename=/mnt/test.img \
    --buffered=1 --ioengine=mmap --rw=randread --time_based \
    --ramp_time=30s --runtime=5m --group_reporting

Before:
bw (  MiB/s): min=  493, max= 3947, per=100.00%, avg=2625.56, stdev=25.74, samples=8651
iops        : min=126454, max=1010681, avg=672142.61, stdev=6590.48, samples=8651

After:
bw (  MiB/s): min=  298, max= 3840, per=100.00%, avg=2614.34, stdev=23.77, samples=8689
iops        : min=76464, max=983045, avg=669270.35, stdev=6084.31, samples=8689

Test result with THP (do a THP randread then switch to 4K page in hope it
issues a lot of splitting):

  echo 3 > /proc/sys/vm/drop_caches

  fio -name=cached --numjobs=16 --filename=/mnt/test.img \
      --buffered=1 --ioengine=mmap -thp=1 --readonly \
      --rw=randread --time_based --ramp_time=30s --runtime=10m \
      --group_reporting

  fio -name=cached --numjobs=16 --filename=/mnt/test.img \
      --buffered=1 --ioengine=mmap \
      --rw=randread --time_based --runtime=5s --group_reporting

Before:
bw (  KiB/s): min= 4611, max=15370, per=100.00%, avg=8928.74, stdev=105.17, samples=19146
iops        : min= 1151, max= 3842, avg=2231.27, stdev=26.29, samples=19146

READ: bw=4635B/s (4635B/s), 4635B/s-4635B/s (4635B/s-4635B/s), io=64.0KiB (65.5kB), run=14137-14137msec

After:
bw (  KiB/s): min= 4691, max=15666, per=100.00%, avg=8890.30, stdev=104.53, samples=19056
iops        : min= 1167, max= 3913, avg=2218.68, stdev=26.15, samples=19056

READ: bw=4590B/s (4590B/s), 4590B/s-4590B/s (4590B/s-4590B/s), io=64.0KiB (65.5kB), run=14275-14275msec

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/filemap.c | 124 +++++++++++++++++++++++++++------------------------
 1 file changed, 65 insertions(+), 59 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 90b86f22a9df..0ccdc9e92764 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -848,38 +848,23 @@ void replace_page_cache_folio(struct folio *old, struct folio *new)
 }
 EXPORT_SYMBOL_GPL(replace_page_cache_folio);
 
-noinline int __filemap_add_folio(struct address_space *mapping,
-		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
+static int __filemap_lock_store(struct xa_state *xas, struct folio *folio,
+				  pgoff_t index, gfp_t gfp, void **shadowp)
 {
-	XA_STATE(xas, &mapping->i_pages, index);
-	void *alloced_shadow = NULL;
-	int alloced_order = 0;
-	bool huge;
-	long nr;
-
-	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
-	mapping_set_update(&xas, mapping);
-
-	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
-	xas_set_order(&xas, index, folio_order(folio));
-	huge = folio_test_hugetlb(folio);
-	nr = folio_nr_pages(folio);
-
+	void *entry, *old, *alloced_shadow = NULL;
+	int order, split_order, alloced_order = 0;
 	gfp &= GFP_RECLAIM_MASK;
-	folio_ref_add(folio, nr);
-	folio->mapping = mapping;
-	folio->index = xas.xa_index;
 
 	for (;;) {
-		int order = -1, split_order = 0;
-		void *entry, *old = NULL;
+		order = -1;
+		split_order = 0;
+		old = NULL;
 
-		xas_lock_irq(&xas);
-		xas_for_each_conflict(&xas, entry) {
+		xas_lock_irq(xas);
+		xas_for_each_conflict(xas, entry) {
 			old = entry;
 			if (!xa_is_value(entry)) {
-				xas_set_err(&xas, -EEXIST);
+				xas_set_err(xas, -EEXIST);
 				goto unlock;
 			}
 			/*
@@ -887,72 +872,93 @@ noinline int __filemap_add_folio(struct address_space *mapping,
 			 * it will be the first and only entry iterated.
 			 */
 			if (order == -1)
-				order = xas_get_order(&xas);
+				order = xas_get_order(xas);
 		}
 
 		/* entry may have changed before we re-acquire the lock */
 		if (alloced_order && (old != alloced_shadow || order != alloced_order)) {
-			xas_destroy(&xas);
+			xas_destroy(xas);
 			alloced_order = 0;
 		}
 
 		if (old) {
 			if (order > 0 && order > folio_order(folio)) {
-				/* How to handle large swap entries? */
-				BUG_ON(shmem_mapping(mapping));
 				if (!alloced_order) {
 					split_order = order;
 					goto unlock;
 				}
-				xas_split(&xas, old, order);
-				xas_reset(&xas);
+				xas_split(xas, old, order);
+				xas_reset(xas);
 			}
 			if (shadowp)
 				*shadowp = old;
 		}
 
-		xas_store(&xas, folio);
-		if (xas_error(&xas))
-			goto unlock;
-
-		mapping->nrpages += nr;
-
-		/* hugetlb pages do not participate in page cache accounting */
-		if (!huge) {
-			__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
-			if (folio_test_pmd_mappable(folio))
-				__lruvec_stat_mod_folio(folio,
-						NR_FILE_THPS, nr);
-		}
-
+		xas_store(xas, folio);
+		if (!xas_error(xas))
+			return 0;
 unlock:
-		xas_unlock_irq(&xas);
+		xas_unlock_irq(xas);
 
 		/* split needed, alloc here and retry. */
 		if (split_order) {
-			xas_split_alloc(&xas, old, split_order, gfp);
-			if (xas_error(&xas))
+			xas_split_alloc(xas, old, split_order, gfp);
+			if (xas_error(xas))
 				goto error;
 			alloced_shadow = old;
 			alloced_order = split_order;
-			xas_reset(&xas);
+			xas_reset(xas);
 			continue;
 		}
 
-		if (!xas_nomem(&xas, gfp))
+		if (!xas_nomem(xas, gfp))
 			break;
 	}
 
-	if (xas_error(&xas))
-		goto error;
-
-	trace_mm_filemap_add_to_page_cache(folio);
-	return 0;
 error:
-	folio->mapping = NULL;
-	/* Leave page->index set: truncation relies upon it */
-	folio_put_refs(folio, nr);
-	return xas_error(&xas);
+	return xas_error(xas);
+}
+
+noinline int __filemap_add_folio(struct address_space *mapping,
+		struct folio *folio, pgoff_t index, gfp_t gfp, void **shadowp)
+{
+	XA_STATE(xas, &mapping->i_pages, index);
+	bool huge;
+	long nr;
+	int ret;
+
+	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	VM_BUG_ON_FOLIO(folio_test_swapbacked(folio), folio);
+	mapping_set_update(&xas, mapping);
+
+	VM_BUG_ON_FOLIO(index & (folio_nr_pages(folio) - 1), folio);
+	xas_set_order(&xas, index, folio_order(folio));
+	huge = folio_test_hugetlb(folio);
+	nr = folio_nr_pages(folio);
+
+	folio_ref_add(folio, nr);
+	folio->mapping = mapping;
+	folio->index = xas.xa_index;
+
+	ret = __filemap_lock_store(&xas, folio, index, gfp, shadowp);
+	if (!ret) {
+		mapping->nrpages += nr;
+		/* hugetlb pages do not participate in page cache accounting */
+		if (!huge) {
+			__lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
+			if (folio_test_pmd_mappable(folio))
+				__lruvec_stat_mod_folio(folio,
+						NR_FILE_THPS, nr);
+		}
+		xas_unlock_irq(&xas);
+		trace_mm_filemap_add_to_page_cache(folio);
+	} else {
+		folio->mapping = NULL;
+		/* Leave page->index set: truncation relies upon it */
+		folio_put_refs(folio, nr);
+	}
+
+	return ret;
 }
 ALLOW_ERROR_INJECTION(__filemap_add_folio, ERRNO);
 
-- 
2.43.0


