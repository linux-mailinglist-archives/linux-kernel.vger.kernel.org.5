Return-Path: <linux-kernel+bounces-84488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BC186A757
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1558B218B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373B220328;
	Wed, 28 Feb 2024 03:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9QT+KEM"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACBD2030F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 03:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709092174; cv=none; b=Q88a2FYuI4zZrxSkaB0O9H61gZcnrXWtbqft0y4QMI422DqziojJN0W33Gg3ZhUE6kErBhBKuRITxlx9ADOIpn4k8uupvETVDGnJ8adQQjtUqhF4XwwD733diQnw0Zg+J9ei7x3t0nM1Ix/ah9risN1+o4j46L9jqwIMO7TsFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709092174; c=relaxed/simple;
	bh=GORHl7Se++zyxsZ5Y5aFQ7sI1NaaSGD3Zd3YJixbA4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z5mpI0rX0ZxieZ8Ba3uaJwJQL9wKm3vgT4RkSOINlR/XL0N8Zf6pto8k6p0fJmchT2eijRatluSlinwOF0kCSIr0pL2n6GM0f6b1FVUQlvNAjJf1Sp4RjJiKPfwJAyh4g+pEcR7f8B7NHdFnvBYoms0fGum9CJLMbPVcZDuM9qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9QT+KEM; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so3595873a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709092172; x=1709696972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQlUYyJ2eXhnbobYPXDOgBr3jKeBkHk1CGOLpbMiMT0=;
        b=V9QT+KEMMqs/ehp2oT5nph0XSk4wn3vUftvzoiKuZKGj8BFJxEhvraqwc3WkxjQ9qF
         8vmzZx6vE7J0ixn5DT4z/hHhZH5u5k43MBe8LtlXv4uPALi28vf9sdgPOr57qex1zPUO
         xud4cKgu7MfZjz7iORBMTxuhvwv4zgMHMPxMeyq0yug8WOACeboXcJfEV9WtkCsDoFk7
         0HKjDxHXmnKNLqB1XkTWep+1G5DlkzTrHqG+oM5ULkU/5InXUjLtCX2hZUd2Y4D39ipd
         SrtHsI9rZec8oxinApMvbFBjjjpniNxV60va9ybUVGd5zpVgXjva7HlKjxI48PVcamFT
         IdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709092172; x=1709696972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQlUYyJ2eXhnbobYPXDOgBr3jKeBkHk1CGOLpbMiMT0=;
        b=X+CzIB+WZ+oONDcpXRCyf6V+kuLx1zNLC5+l7NDLTCS4uT9OFQV7k8S5p6F3J9KErg
         pGKlrUSOjXxEFIZMqYbyh0PHlNzPBf7wYK6WZUKk9kCJeIii4ZTKozijX0IGZ5O5OlMu
         FgTzXrzcPR5DBGWt7Y/Xthj7VxxE8mgiUaHonjeaNAEej9tgI7EYa8WAYHrcAhrRHua4
         cqTpc0Dyz0dMr9ixXLijNgNllMEr0XSI00CsdUjCPIXpXjMzy4XfBVHIiOxJ/YTxOvBy
         UKxBmjpaaoS45yuCbw4G46UidPUPmslyI0GUXFdnLY+zCBZmtRYsjZcge8qSCj3eimKS
         hxWg==
X-Forwarded-Encrypted: i=1; AJvYcCUCRwQUP4XjSCEPtPtqcAMEdNdJWJyiqAhHbG9uraGOI2/pl1Ey0Igi0LcjIf+0APSjpEYkDgLFETb99fFZTdeyUcWpL7JW/noWc3Q3
X-Gm-Message-State: AOJu0YwO8Fzt784tMbtcJBILngjNP5rlvVQjPf7r15Nz6PFZU/jQ11nI
	SbWkihGyX27FpA0o4frdIuovBSUcBrElhNJJJLv/AlQoQEDIOQSB
X-Google-Smtp-Source: AGHT+IFZf3UkJGMFdoMTVJXNs+EvRyKPGXTGgjO3Givm+ElB2niZvrZWAVSLHnfq28gpw6myICQ0Yw==
X-Received: by 2002:a05:6a20:e605:b0:1a1:e83:8eb4 with SMTP id my5-20020a056a20e60500b001a10e838eb4mr3472377pzb.9.1709092172179;
        Tue, 27 Feb 2024 19:49:32 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:e4ad:9b94:2418:969e])
        by smtp.gmail.com with ESMTPSA id p16-20020a17090b011000b00299e946b9cdsm374033pjz.20.2024.02.27.19.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 19:49:31 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: 21cnbao@gmail.com,
	ryan.roberts@arm.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	hanchuanhua@oppo.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	shy828301@gmail.com,
	steven.price@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com,
	yuzhao@google.com,
	Chris Li <chrisl@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	SeongJae Park <sj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RFC 6/6] mm: madvise: don't split mTHP for MADV_PAGEOUT
Date: Wed, 28 Feb 2024 16:49:06 +1300
Message-Id: <20240228034906.83872-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAGsJ_4xFgcf8+ZqKUqQ3gQt63JXtn-VifAk5mTA6dopYvNqGqA@mail.gmail.com>
References: <CAGsJ_4xFgcf8+ZqKUqQ3gQt63JXtn-VifAk5mTA6dopYvNqGqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> I'm going to rework this patch and integrate it into my series if that's ok with
>> you?
> 
> This is perfect. Please integrate it into your swap-out series which is the
> perfect place for this MADV_PAGEOUT.

BTW, Ryan, while you integrate this into your swap-put series, can you also
add the below one which is addressing one comment of Chris,

From: Barry Song <v-songbaohua@oppo.com>
Date: Tue, 27 Feb 2024 22:03:59 +1300
Subject: [PATCH] mm: madvise: extract common function
 folio_deactivate_or_add_to_reclaim_list

For madvise_cold_or_pageout_pte_range, both pmd-mapped and pte-mapped
normal folios are duplicating the same code right now, and we might
have more such as pte-mapped large folios to use it. It is better
to extract a common function.

Cc: Chris Li <chrisl@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/madvise.c | 52 ++++++++++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 44a498c94158..1812457144ea 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -321,6 +321,24 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
+static inline void folio_deactivate_or_add_to_reclaim_list(struct folio *folio, bool pageout,
+				struct list_head *folio_list)
+{
+	folio_clear_referenced(folio);
+	folio_test_clear_young(folio);
+
+	if (folio_test_active(folio))
+		folio_set_workingset(folio);
+	if (!pageout)
+		return folio_deactivate(folio);
+	if (folio_isolate_lru(folio)) {
+		if (folio_test_unevictable(folio))
+			folio_putback_lru(folio);
+		else
+			list_add(&folio->lru, folio_list);
+	}
+}
+
 static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 				unsigned long addr, unsigned long end,
 				struct mm_walk *walk)
@@ -394,19 +412,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 		}
 
-		folio_clear_referenced(folio);
-		folio_test_clear_young(folio);
-		if (folio_test_active(folio))
-			folio_set_workingset(folio);
-		if (pageout) {
-			if (folio_isolate_lru(folio)) {
-				if (folio_test_unevictable(folio))
-					folio_putback_lru(folio);
-				else
-					list_add(&folio->lru, &folio_list);
-			}
-		} else
-			folio_deactivate(folio);
+		folio_deactivate_or_add_to_reclaim_list(folio, pageout, &folio_list);
 huge_unlock:
 		spin_unlock(ptl);
 		if (pageout)
@@ -498,25 +504,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			tlb_remove_tlb_entry(tlb, pte, addr);
 		}
 
-		/*
-		 * We are deactivating a folio for accelerating reclaiming.
-		 * VM couldn't reclaim the folio unless we clear PG_young.
-		 * As a side effect, it makes confuse idle-page tracking
-		 * because they will miss recent referenced history.
-		 */
-		folio_clear_referenced(folio);
-		folio_test_clear_young(folio);
-		if (folio_test_active(folio))
-			folio_set_workingset(folio);
-		if (pageout) {
-			if (folio_isolate_lru(folio)) {
-				if (folio_test_unevictable(folio))
-					folio_putback_lru(folio);
-				else
-					list_add(&folio->lru, &folio_list);
-			}
-		} else
-			folio_deactivate(folio);
+		folio_deactivate_or_add_to_reclaim_list(folio, pageout, &folio_list);
 	}
 
 	if (start_pte) {
-- 
2.34.1

Thanks
Barry

