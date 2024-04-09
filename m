Return-Path: <linux-kernel+bounces-136458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF22589D437
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E251283D9A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBE080BEC;
	Tue,  9 Apr 2024 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq0NgBcp"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3B97F46A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651232; cv=none; b=q41fG2vl5eFDQzZV/hrIG4PxpwAJlSFpRXNHEuveXmnDjFHZvExFFNJUEG7blB2J75W5WqLF1iPgznt6TueP+BKxfor6YUS2x03lELOi9FLk3zbTngyDQTzgmdx2YpBNE5yVLPir5sJLGyug3E2wxSoymwSaMhk97QToOPzFt3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651232; c=relaxed/simple;
	bh=D+Ww0cHxH7lNQifArSTX5yyjcFVuKM5MIm3KMR2gH30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j/cPn+gwvAVtri9nix8HjO1Cu42sKb3N10vShz9tV8Tu5ArtTNZbBEbVOqnwiGUK7M4hCnIDk3ALxDANM9uOyyhZGKc5krW4phozvVPahen0dDo5tv6wVz07T/vxaKJ/GSPdT+iwL2D3YAzRPNUaALCPHV5Z75k6zlPU/hkDc0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uq0NgBcp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2a52c544077so1216802a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712651230; x=1713256030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZXg/AhadeS891XoBBBMkIgTpnMXwbdxyyz0Yc4z5x8=;
        b=Uq0NgBcpYXI3lH/FTTF0NJI/iuwRHrRENxNLK0nDkygKeYShFDRAmii5YqmrjDigom
         2AUhJTBei8SCUjxhtTgZElYaO2XrEDxKXFrG0JrQYp/41U6BYkd0BQBm1FN6VB5uBuil
         BCYwnensFDXNmPR39WF2PGkySE7H/GsoPpUTjj13fhEFLV0lbYUK6QE0XUQcODSm9RLI
         YUgzPrQMBxkwV849TSRqO/S8eqPsEpGFs81MlruSnntDyiJ4dti5b/+cbxDkINRPLymf
         8L9JOktRBANxoKdhwbZcI2L2fNmCA/FBLx1rE/1aR7NYPZNxXbatm0GruFZBg5bwnYoq
         IX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712651230; x=1713256030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ZXg/AhadeS891XoBBBMkIgTpnMXwbdxyyz0Yc4z5x8=;
        b=LvPpauAdyf1PbCOO1BTvNb+4n8XCBBWDpiaVkZXVVyR4HcseSHdPzPsMdWVOJeDE+F
         /dAV2hsdKZI9CGQZEqaeCMLwjSHQGtiP8wOgkgvJ5JIPthO/H21DsW6RPo1YnwbTqwqW
         Q2CfgcveNW8ivhIzrESmZytLiUrMBaaH2T7WjbvPlCynnKMbhgw9HhopiNqn5/CZrfht
         LQxAPB2N1J8HwU7IFry0GSmDmtVJM7zRw6/YtmMCTBdStasK52T5fy4ZaFm9Lu08ggjS
         TVfHiJ7ZrFHBhprNzVnVO54lGF65jf7N7Zej2NoXN0KL0q4faXXRxed4QAAW14L+btJg
         vFpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpxRWeuiBmx4a3PwyNplFWYbbu957q7v/wv7Btdrd7wubzTpEqv8Uap9jdlG5uIZH1+wTU55izUUM+kxNkmql0abnMWf0BvikIteag
X-Gm-Message-State: AOJu0YzYaZc7P9CtVJV3c4I5jRBcwETyXTfKI9PrihYNyGKimDMunEGf
	02TOP6UDHTJwkeVy9eO9zXXbLGr26YgbSzIk+GKf9TTdr7AJtbEL
X-Google-Smtp-Source: AGHT+IFg5AbIygO1G/4Sf/xhmF54Nd1zJbM7cGgBTgS8FOC9fn0UWuAxj2wjNfCbUfjBKgj68N+xMw==
X-Received: by 2002:a17:90b:3587:b0:2a4:e962:b62c with SMTP id mm7-20020a17090b358700b002a4e962b62cmr4228631pjb.49.1712651230311;
        Tue, 09 Apr 2024 01:27:10 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id r16-20020a632050000000b005f05c88c149sm7594238pgm.71.2024.04.09.01.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 01:27:09 -0700 (PDT)
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
Subject: [PATCH v2 3/5] mm: swap_pte_batch: add an output argument to reture if all swap entries are exclusive
Date: Tue,  9 Apr 2024 20:26:29 +1200
Message-Id: <20240409082631.187483-4-21cnbao@gmail.com>
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

From: Barry Song <v-songbaohua@oppo.com>

Add a boolean argument named any_shared. If any of the swap entries are
non-exclusive, set any_shared to true. The function do_swap_page() can
then utilize this information to determine whether the entire large
folio can be reused.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/internal.h | 9 ++++++++-
 mm/madvise.c  | 2 +-
 mm/memory.c   | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9d3250b4a08a..cae39c372bfc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -238,7 +238,8 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
  *
  * Return: the number of table entries in the batch.
  */
-static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
+static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte,
+				bool *any_shared)
 {
 	pte_t expected_pte = pte_next_swp_offset(pte);
 	const pte_t *end_ptep = start_ptep + max_nr;
@@ -248,12 +249,18 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 	VM_WARN_ON(!is_swap_pte(pte));
 	VM_WARN_ON(non_swap_entry(pte_to_swp_entry(pte)));
 
+	if (any_shared)
+		*any_shared |= !pte_swp_exclusive(pte);
+
 	while (ptep < end_ptep) {
 		pte = ptep_get(ptep);
 
 		if (!pte_same(pte, expected_pte))
 			break;
 
+		if (any_shared)
+			*any_shared |= !pte_swp_exclusive(pte);
+
 		expected_pte = pte_next_swp_offset(expected_pte);
 		ptep++;
 	}
diff --git a/mm/madvise.c b/mm/madvise.c
index f59169888b8e..d34ca6983227 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -671,7 +671,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 			entry = pte_to_swp_entry(ptent);
 			if (!non_swap_entry(entry)) {
 				max_nr = (end - addr) / PAGE_SIZE;
-				nr = swap_pte_batch(pte, max_nr, ptent);
+				nr = swap_pte_batch(pte, max_nr, ptent, NULL);
 				nr_swap -= nr;
 				free_swap_and_cache_nr(entry, nr);
 				clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
diff --git a/mm/memory.c b/mm/memory.c
index 2702d449880e..c4a52e8d740a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1638,7 +1638,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			folio_put(folio);
 		} else if (!non_swap_entry(entry)) {
 			max_nr = (end - addr) / PAGE_SIZE;
-			nr = swap_pte_batch(pte, max_nr, ptent);
+			nr = swap_pte_batch(pte, max_nr, ptent, NULL);
 			/* Genuine swap entries, hence a private anon pages */
 			if (!should_zap_cows(details))
 				continue;
-- 
2.34.1


