Return-Path: <linux-kernel+bounces-167120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05F38BA4B5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 02:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446D71F2504C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262B4E57E;
	Fri,  3 May 2024 00:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtCsYF+k"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C675BE58
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714697467; cv=none; b=ZD9osuseL6dxbUQWDStGeaBvdTxsWr0b1wUB6zfl/HTneBTU9F5jNAXkUT1xbslUwu/1m2UnXYuMLyoo7gNRWemj6rz6MFi6W3jHlJBQ8e4zIE9c2Xr2CYxAhaLGuZE9GMs/9fFw7+A+hGj3yG4W/nSJBjWWcSvav3A6goFNaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714697467; c=relaxed/simple;
	bh=UvcQuwNEhAycNFg7PwGBytTqZKIoZm9LHS0WW5GsLno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AjBVU6kxWcEpLbOLxWxE6FupsZnMu28XVyflO+vD+K8UdeKPy5kFk9lYwNJVTbm85avFjnmm2wncQav5WkTj4BkWeG0dRD5bQWdFuxDFfet3vAZ0av6a0fDbzBHqVE545FxI+lBFMtUGkwJHdHKFu2nhgH/MjuBCXYtdpffHVG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtCsYF+k; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso14875445ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 17:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714697465; x=1715302265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8/xoQXqz11CQNwI09Ird7+bH6VcV03qRwDFMsnqJvs=;
        b=PtCsYF+kfqsh0WA1F+WMj9uRX2OUC87d31j8gU4VmKIJE40+ZoAhHX3NDaKn0WaWC6
         DODmW6rRlxNG/oIfNB+cWPCbTXDLA91wksIWA98JbbJGdKsYyi2Qpw1LK/CZei0pxL4d
         aHN2otiyBaFyyZvqd5zNwn/l/Q666BB2dOqG9l1IlsstcoFTshG+AXm4SnSxRnLddWqe
         MXDFWo1+nVxTQH4cAvePAIFObE7jbfb/ifErhz2oDvFqFsatrWTtMccWwuDuTiZUvAZ2
         a/iYjl9Q67bgdFMNL07kOVim/pCEvdBROXzhcQnwBVabgZJVlGULb5149Y+OdoFtshrb
         qz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714697465; x=1715302265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8/xoQXqz11CQNwI09Ird7+bH6VcV03qRwDFMsnqJvs=;
        b=LlUxmAlV1yIflLgyo421/5I4SyS+hQscqlhB7wiSd2xOv8kj5BzJA/TGJBXxF2InFB
         vBsaF5GxcWPXQ8cDRxLjk1AiVrxmRCcq638KoO8OXHRe2aysRHi7RwxGcdWyuRZLUBhg
         ehz/OqSG36kTg1mdrpnr7GIhmkaZWXJ37I5VmvC/eqBOGRlVrVu+AyWDhgLDo9Ene69t
         /ky2UgUuFJWIpLIE3+i/tNeExoUJuARFIido5I96U8DNtx+5cUjWpD7oAYLkaxZaNoyi
         bKrZYOw69zAcm3UzMaITOlOVZ27RSX5RfFjjgUhqNi4+UOtd6xZNgLU1+XE19VFwZxHA
         BYeg==
X-Forwarded-Encrypted: i=1; AJvYcCVdOCxF3/nskE0pCNRXk2N9ZCDR2jTsPKWIGY4fS5qa6snjvDda1EYuwYLV2pXm1fWqrgUT93cm7XxHYOa7iTOwBLywANX6c9qmc+zh
X-Gm-Message-State: AOJu0YyydHeevTCQzXEtjqZpy2xMvyxUKDtsOQQqnzRKwCJcPs2MsK2M
	GlBNa5BOSLOoHZqhuJM9rmw6AogJxxDDPYFUnvgX7oZ/uVruiqln
X-Google-Smtp-Source: AGHT+IGFQTJEucm2ac55Okxx+HqgTWR7zEJF87WiBhCpMaLEsrJyrBBOIayzx6pibugr3l3cuGjLhA==
X-Received: by 2002:a17:903:2384:b0:1ed:36dc:a570 with SMTP id v4-20020a170903238400b001ed36dca570mr620343plh.49.1714697465334;
        Thu, 02 May 2024 17:51:05 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001ec48e41d2esm1969175plh.212.2024.05.02.17.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 17:51:04 -0700 (PDT)
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
Subject: [PATCH v3 3/6] mm: introduce pte_move_swp_offset() helper which can move offset bidirectionally
Date: Fri,  3 May 2024 12:50:20 +1200
Message-Id: <20240503005023.174597-4-21cnbao@gmail.com>
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

From: Barry Song <v-songbaohua@oppo.com>

There could arise a necessity to obtain the first pte_t from a swap
pte_t located in the middle. For instance, this may occur within the
context of do_swap_page(), where a page fault can potentially occur in
any PTE of a large folio. To address this, the following patch introduces
pte_move_swp_offset(), a function capable of bidirectional movement by
a specified delta argument. Consequently, pte_increment_swp_offset()
will directly invoke it with delta = 1.

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/internal.h | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index c5552d35d995..cfe4aed66a5c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -211,18 +211,21 @@ static inline int folio_pte_batch(struct folio *folio, unsigned long addr,
 }
 
 /**
- * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
+ * pte_move_swp_offset - Move the swap entry offset field of a swap pte
+ *	 forward or backward by delta
  * @pte: The initial pte state; is_swap_pte(pte) must be true and
  *	 non_swap_entry() must be false.
+ * @delta: The direction and the offset we are moving; forward if delta
+ *	 is positive; backward if delta is negative
  *
- * Increments the swap offset, while maintaining all other fields, including
+ * Moves the swap offset, while maintaining all other fields, including
  * swap type, and any swp pte bits. The resulting pte is returned.
  */
-static inline pte_t pte_next_swp_offset(pte_t pte)
+static inline pte_t pte_move_swp_offset(pte_t pte, long delta)
 {
 	swp_entry_t entry = pte_to_swp_entry(pte);
 	pte_t new = __swp_entry_to_pte(__swp_entry(swp_type(entry),
-						   (swp_offset(entry) + 1)));
+						   (swp_offset(entry) + delta)));
 
 	if (pte_swp_soft_dirty(pte))
 		new = pte_swp_mksoft_dirty(new);
@@ -234,6 +237,20 @@ static inline pte_t pte_next_swp_offset(pte_t pte)
 	return new;
 }
 
+
+/**
+ * pte_next_swp_offset - Increment the swap entry offset field of a swap pte.
+ * @pte: The initial pte state; is_swap_pte(pte) must be true and
+ *	 non_swap_entry() must be false.
+ *
+ * Increments the swap offset, while maintaining all other fields, including
+ * swap type, and any swp pte bits. The resulting pte is returned.
+ */
+static inline pte_t pte_next_swp_offset(pte_t pte)
+{
+	return pte_move_swp_offset(pte, 1);
+}
+
 /**
  * swap_pte_batch - detect a PTE batch for a set of contiguous swap entries
  * @start_ptep: Page table pointer for the first entry.
-- 
2.34.1


