Return-Path: <linux-kernel+bounces-82619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C12C5868754
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2AD11C2957B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1924E168C6;
	Tue, 27 Feb 2024 02:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHvch6Ac"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC55C125D5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001666; cv=none; b=FoPIOGpUc3Q0O4qmPKo++79kcpYrThP6wb0vHJrPamQh8fbuMKx9OA3nszMKsi5xsmUotBWK4kFqeS20Q8WHBkjaGpJQcWBCEzdqSg3aFf0xtI/XZ+RBjKldRdJcwX0VXD8UzcsohSNhCj6t8N87YLl7GkvHi3n6hHU8G0+bVZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001666; c=relaxed/simple;
	bh=GdjVbuKlyr67H96AYnoupjDwfylD1+PwoQv5H1kB2HI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CGRCz2gGw0NmtB33rfZAdJpkai7bdiFHvWvvZxAZNdp/q2C9pZxNGGqcXgAHp8BtDIF6rBajDj1J0R14GOIQ12pVT8lOJADs/tKiAcIrIhwBCKfYDVhhPmBslOLLMwNaFsbzACR2ltEKFNGB1yLNsWpmlIlplQUcOwp8Yw28Va0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHvch6Ac; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e53f76898fso609987b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709001664; x=1709606464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9kPnEQQtmu12UoNhoLVM4of9Nt6V7crsGL0uVHcTJA=;
        b=FHvch6AcijXBrDSMxajB8xxJUdZDpEtEDPt3krGMz05wZYeKdCHvpCbqWSGSDXsOVD
         gSiTzQnW5YoXdx4JWvJ9w/EvTQsLGj1BRTKo4STQJxPN3lYdQrYxAryRd/UrFiIRXgBe
         Q2OESHGtzeh3f08YHjE8rd2ySA+iUcX0useMFj+xNZIHOzcbh0Hqe0cBRPCCxe76OBYt
         +S/u9DWIEEeFC0yfiogB2fU/+rIDUZnYewQCklebfdjmW/uMAC0bjH2AyMOeVDVDOaib
         FlQrytUzOIYzYY5kwhy9l3MlIkJJPVPXAQZ9ZNVD1+e3GAZYU0q4X791kStwqbr4B8a7
         mmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709001664; x=1709606464;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9kPnEQQtmu12UoNhoLVM4of9Nt6V7crsGL0uVHcTJA=;
        b=tYcH8LeiZtFLfo1ssx58HwYpjiDHHuiZz7BZp8mFfUKYp18Z+kTOoMPUyLwl3BWgyz
         6u83kYBNa+bkBztzHaIXBhPv7XQsa6B5lPZBQN3ANuPmOTjZwPq+f6Qc5IcXM6KvGdPG
         iu1s5o7pDvhDs1ioPALYpWaWf0OScUrNYJAIc+EnSmlkm25N8iivWsGj9WlVfUxkkCpm
         vKXjktZU49BmhrumP9GwvraS/fSY5TiAofZNm5OuuxS9nmALjYMVXNLykrMKIAV8b3+X
         6WUcvNu2TkvMr1DPJ/HkdIrRQY0F9qsFiPFomuVnvlOS2EDC3SLyylCdEDaPFuiWHtWM
         5BRQ==
X-Gm-Message-State: AOJu0Yy6w5k4fyYn7i8SczQDjvAQUB69vlzm0S84E77mec+YlqJHx355
	DaHKqhdHRecK2li5ZHZkitx/g+anfe+yPzIa333MBO4wOXfntPif
X-Google-Smtp-Source: AGHT+IGiB0yNLS+947SzPqW5TZ7PC1hIalQTf7qMGyIVa2Qhsl/G3WdYUU1A+6vXBy5lSjliOsUZ7w==
X-Received: by 2002:a17:902:6847:b0:1dc:a834:5e1c with SMTP id f7-20020a170902684700b001dca8345e1cmr3256626pln.11.1709001663911;
        Mon, 26 Feb 2024 18:41:03 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:fae4:3bff:fecb:410])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b001d706e373a9sm358616pla.292.2024.02.26.18.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 18:41:03 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Yin Fengwei <fengwei.yin@intel.com>
Subject: [PATCH] mm: export folio_pte_batch as a couple of modules might need it
Date: Tue, 27 Feb 2024 15:40:50 +1300
Message-Id: <20240227024050.244567-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

madvise and some others might need folio_pte_batch to check if a range
of PTEs are completely mapped to a large folio with contiguous physcial
addresses. Let's export it for others to use.

Cc: Lance Yang <ioworker0@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 -v1:
 at least two jobs madv_free and madv_pageout depend on it. To avoid
 conflicts and dependencies, after discussing with Lance, we prefer
 this one can land earlier.

 mm/internal.h | 13 +++++++++++++
 mm/memory.c   | 11 +----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 13b59d384845..8e2bc304f671 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -83,6 +83,19 @@ static inline void *folio_raw_mapping(struct folio *folio)
 	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
 }
 
+/* Flags for folio_pte_batch(). */
+typedef int __bitwise fpb_t;
+
+/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
+#define FPB_IGNORE_DIRTY		((__force fpb_t)BIT(0))
+
+/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
+#define FPB_IGNORE_SOFT_DIRTY		((__force fpb_t)BIT(1))
+
+extern int folio_pte_batch(struct folio *folio, unsigned long addr,
+		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
+		bool *any_writable);
+
 void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
 						int nr_throttled);
 static inline void acct_reclaim_writeback(struct folio *folio)
diff --git a/mm/memory.c b/mm/memory.c
index 1c45b6a42a1b..319b3be05e75 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -953,15 +953,6 @@ static __always_inline void __copy_present_ptes(struct vm_area_struct *dst_vma,
 	set_ptes(dst_vma->vm_mm, addr, dst_pte, pte, nr);
 }
 
-/* Flags for folio_pte_batch(). */
-typedef int __bitwise fpb_t;
-
-/* Compare PTEs after pte_mkclean(), ignoring the dirty bit. */
-#define FPB_IGNORE_DIRTY		((__force fpb_t)BIT(0))
-
-/* Compare PTEs after pte_clear_soft_dirty(), ignoring the soft-dirty bit. */
-#define FPB_IGNORE_SOFT_DIRTY		((__force fpb_t)BIT(1))
-
 static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
 {
 	if (flags & FPB_IGNORE_DIRTY)
@@ -982,7 +973,7 @@ static inline pte_t __pte_batch_clear_ignored(pte_t pte, fpb_t flags)
  * If "any_writable" is set, it will indicate if any other PTE besides the
  * first (given) PTE is writable.
  */
-static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
+int folio_pte_batch(struct folio *folio, unsigned long addr,
 		pte_t *start_ptep, pte_t pte, int max_nr, fpb_t flags,
 		bool *any_writable)
 {
-- 
2.34.1


