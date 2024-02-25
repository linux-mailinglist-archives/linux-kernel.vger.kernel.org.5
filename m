Return-Path: <linux-kernel+bounces-80062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F159862A53
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC3FFB20FC9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63095E560;
	Sun, 25 Feb 2024 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ViP9soqL"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350A1524C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 12:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708864364; cv=none; b=RTjpRdk5ZkLO/hzBCkDdiNcuPc23pOg3YWdlLB0xuBd3lRJT8M9TAcv8pHO9i7nstJ/lYhaP4lKF8ypHsUxzBZ19vjd1NfM2AvufP+pzV4Hg5evQS1MNjUh9BwfI9GCZm0zBP8PBT3fIzx/KbktqaRYK4ejVTb7UYEAM+BAIZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708864364; c=relaxed/simple;
	bh=HECrdga/cgyBD5jdIPl2pPx2JjCQTPsLUZcjVnYQogk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rTBtDK7Hum513XMOBQDKG2W+IUEECB4Q+haItVOE40FckeagGZtT16Y7D13WzaiYQCUbJ9EgbuWbCl7OXg3D6tKnDb4B20v8oWC8Xo8FXJ7wPSX9aY5RY61lBD2+x5qFPP3pbvvD/6Uf6eJwK6arnugyGdy7PswMmP04IAJbe/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ViP9soqL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc90e8a83dso4211175ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 04:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708864362; x=1709469162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NkrOn60bYXii+776z5Blla5PvhzOI0ScvyS7QmR81bk=;
        b=ViP9soqLsxVTlGpyzhAGSEt/r9JR7/kIHI4anCDFMZj49vi4vmE0L2TCN0nTwJ0VVf
         S6YoLPIj21v6VJddrAS7wqdHjrad9bLzCVj7kC67xn4j1SUMLbDyLVYHy0ciccsCD8hg
         pd5OkyXfPRI5e92xuIwE3QuZYMBY4kOqR2QCUy9hN+LRClgHWNSCJR21WNTtAwcGjtmm
         kKzfnqGlNo1lw9C9KrzsmfCa3m5Bj/5peazklgIHAjY80wlcR3DhWR3lHfYzmRletLl5
         kQKcuHv4Ge+hMjrocduSRE7wH0njpQ4dcOZtSQyinh+h+oJ3jjnWbE5Q6r1HJgV6SK67
         AZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708864362; x=1709469162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkrOn60bYXii+776z5Blla5PvhzOI0ScvyS7QmR81bk=;
        b=TgmhG2uZ/ETgZf4u7jLgtz6CgZ+qSXYwDMjfbWXeXaP4gkQQzOH4SOnwxZvFDyie4i
         ROrUICR4YGlDAx9IeXBj+9azyayDaoOn4KqVqGtImEa6bBaFqvjAQlcEorGmRBbKaLNN
         qgkyjFtvbu2xaOPINeFxWz4SSVtdg0EXcXIxpqn56wFCnviwxXjn+N3s7rha16JW0CoP
         HWEiIdp+HxmwQEoGg+K3vIR+l5Je1Nm8PQQ43MrwU7RH+z+qJzNfSxAonv+PEOtMaoZD
         Ezh+P34fqDGSZreNqd8DtJaRbXeWf+uWUP+6YdzelrCWXXEPMfg08gmvgpCqvOR0m7ik
         7FvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp9OxrMfpKrs1GmcRd2r8VAxes3Gc2zl4lUrrTloaRTkkdyME/5LfRYPat5wSASRssnyk6FHyY+Ovif9M3AiJRAQyzt6acsq1KI15+
X-Gm-Message-State: AOJu0YxHJNYcYBxu6uX0Fnen8R0/FKUjZJPSte1kHfKoqvewb3dgqaeo
	UprnjeU+gnF8A/h2QASLpOl+fFUYack2b7eNk26U5tzPUojLfcpa
X-Google-Smtp-Source: AGHT+IGEp+WZndCmlzDJnWpIFgzUaQLyX3PK3uV53ziSi6AW12U3MkcG3ndSagzAEYAVoAc/sqIeRQ==
X-Received: by 2002:a17:903:1c5:b0:1dc:8798:7436 with SMTP id e5-20020a17090301c500b001dc87987436mr4023890plh.1.1708864362444;
        Sun, 25 Feb 2024 04:32:42 -0800 (PST)
Received: from LancedeMBP.lan ([112.10.225.117])
        by smtp.gmail.com with ESMTPSA id lc7-20020a170902fa8700b001db9d2c1874sm2192069plb.29.2024.02.25.04.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 04:32:42 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: zokeefe@google.com,
	shy828301@gmail.com,
	david@redhat.com,
	mhocko@suse.com,
	ryan.roberts@arm.com,
	wangkefeng.wang@huawei.com,
	songmuchun@bytedance.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
Date: Sun, 25 Feb 2024 20:32:15 +0800
Message-Id: <20240225123215.86503-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch improves madvise_free_pte_range() to correctly
handle large folio that is smaller than PMD-size
(for example, 16KiB to 1024KiB[1]). It’s probably part of
the preparation to support anonymous multi-size THP.

Additionally, when the consecutive PTEs are mapped to
consecutive pages of the same large folio (mTHP), if the
folio is locked before madvise(MADV_FREE) or cannot be
split, then all subsequent PTEs within the same PMD will
be skipped. However, they should have been MADV_FREEed.

Moreover, this patch also optimizes lazyfreeing with
PTE-mapped mTHP (Inspired by David Hildenbrand[2]). We
aim to avoid unnecessary folio splitting if the large
folio is entirely within the given range.

On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by
PTE-mapped folios of the same size results in the following
runtimes for madvise(MADV_FREE) in seconds (shorter is better):

Folio Size  |    Old     |    New     |  Change
----------------------------------------------
      4KiB  |  0.590251  |  0.590264  |     0%
     16KiB  |  2.990447  |  0.182167  |   -94%
     32KiB  |  2.547831  |  0.101622  |   -96%
     64KiB  |  2.457796  |  0.049726  |   -98%
    128KiB  |  2.281034  |  0.030109  |   -99%
    256KiB  |  2.230387  |  0.015838  |   -99%
    512KiB  |  2.189106  |  0.009149  |   -99%
   1024KiB  |  2.183949  |  0.006620  |   -99%
   2048KiB  |  0.002799  |  0.002795  |     0%

[1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm.com
[2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redhat.com/

Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/madvise.c | 69 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 11 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index cfa5e7288261..bcbf56595a2e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -676,11 +676,43 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		 */
 		if (folio_test_large(folio)) {
 			int err;
+			unsigned long next_addr, align;
 
-			if (folio_estimated_sharers(folio) != 1)
-				break;
-			if (!folio_trylock(folio))
-				break;
+			if (folio_estimated_sharers(folio) != 1 ||
+			    !folio_trylock(folio))
+				goto skip_large_folio;
+
+			align = folio_nr_pages(folio) * PAGE_SIZE;
+			next_addr = ALIGN_DOWN(addr + align, align);
+
+			/*
+			 * If we mark only the subpages as lazyfree,
+			 * split the large folio.
+			 */
+			if (next_addr > end || next_addr - addr != align)
+				goto split_large_folio;
+
+			/*
+			 * Avoid unnecessary folio splitting if the large
+			 * folio is entirely within the given range.
+			 */
+			folio_test_clear_dirty(folio);
+			folio_unlock(folio);
+			for (; addr != next_addr; pte++, addr += PAGE_SIZE) {
+				ptent = ptep_get(pte);
+				if (pte_young(ptent) || pte_dirty(ptent)) {
+					ptent = ptep_get_and_clear_full(
+						mm, addr, pte, tlb->fullmm);
+					ptent = pte_mkold(ptent);
+					ptent = pte_mkclean(ptent);
+					set_pte_at(mm, addr, pte, ptent);
+					tlb_remove_tlb_entry(tlb, pte, addr);
+				}
+			}
+			folio_mark_lazyfree(folio);
+			goto next_folio;
+
+split_large_folio:
 			folio_get(folio);
 			arch_leave_lazy_mmu_mode();
 			pte_unmap_unlock(start_pte, ptl);
@@ -688,13 +720,28 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			err = split_folio(folio);
 			folio_unlock(folio);
 			folio_put(folio);
-			if (err)
-				break;
-			start_pte = pte =
-				pte_offset_map_lock(mm, pmd, addr, &ptl);
-			if (!start_pte)
-				break;
-			arch_enter_lazy_mmu_mode();
+
+			/*
+			 * If the large folio is locked before madvise(MADV_FREE)
+			 * or cannot be split, we just skip it.
+			 */
+			if (err) {
+skip_large_folio:
+				if (next_addr >= end)
+					break;
+				pte += (next_addr - addr) / PAGE_SIZE;
+				addr = next_addr;
+			}
+
+			if (!start_pte) {
+				start_pte = pte = pte_offset_map_lock(
+					mm, pmd, addr, &ptl);
+				if (!start_pte)
+					break;
+				arch_enter_lazy_mmu_mode();
+			}
+
+next_folio:
 			pte--;
 			addr -= PAGE_SIZE;
 			continue;
-- 
2.33.1


