Return-Path: <linux-kernel+bounces-47750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F989845254
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18442896B6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95D2159577;
	Thu,  1 Feb 2024 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FIdgrMal"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A3158D84
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706774766; cv=none; b=JZs8x+J6fiTfhilbV+NUYMHS0BU6uAgPEzmmMfgBpIuJpirCRm6Jj2lJy8zwHrbvh/SXPuyBp4ebvMyoguEvyDG8wwR6fA81zwfhgaPTf+V2a1xEm82sm8A6QNAHyK/h75vXkT5J5/Uu7BeC3swk5mCADu6C7LkqT+k2x+ebaVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706774766; c=relaxed/simple;
	bh=fX+LasV85//JB3JqayRg2DaHh21Pzpe/TlzJPEh9Cz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ic2QN5Z9bKj1/NLfMynF05B05E+XD4qqlgbCPWnvqaggpVfov2a7L5f9ej2ESqL1g2LG7uozxGPJdi6okyCai5bjD4H/4SW02sM7vr1uq5EUUUl4dMdMDCmfOynMWkNEQdhMFGBeQ4MwCbw4Nr3OoEIlnueDoHkr5uiuKjp/UU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FIdgrMal; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cfb8126375so135678a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1706774761; x=1707379561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTPGAhJtcf1MyPZRa7AekzLPzVB6P7R8lGN8K5e/uaY=;
        b=FIdgrMalvruH1KXdta8buHKdfstw3XrRDaIWMiR1eZUjXomHIOUpqmWxPkzjTSU2P9
         KnenHxF6FFkk5ynjYWdnd+eS0wAv/hzM2k6owZhljiaeySltzkyHY+ZcB4Mfe6hqBOWT
         MVC1bNuCdQyG8ONUGuX21dtPiojidgfWBlCsgP1ImqDTxvVGIw/HRX+Jx00dvEXn6k8s
         3L/4iXvYREEK6S/tC2YZB0FaEvlsOAP/2O7f48o1r6erGClLz8qSPzcH7XLXPQnP2onn
         h/QKW4Mwa7JRy+b9DXAdrt5aMwIWvvo7XwVlRoS8Hg9UcsvnpdfGEqxhbngXJGQ7qq+u
         6LSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706774761; x=1707379561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTPGAhJtcf1MyPZRa7AekzLPzVB6P7R8lGN8K5e/uaY=;
        b=HFzvO6Fti+f9nmLBgZOh+5+iU7QLHhGA/Iqi2yHOfUDlJDLHJeZPEO6YckpzyjMcaJ
         Uc74eAJt0hbdgBWdsUIM133LWuc37zGVHaSEdcfyM3KIVr9kcANhTru6aZYHP9xhjVF5
         2j15BFD8oJjENSGVaHtKrplbxDldlPRHOAjhmn9NVcywwQ4IyuHTHf1HWaTMo+fdsIvc
         t7q7jNEHwGErfF+Bnl0NftqKUwPTLrxQ+TbTzYUU2tSvOd5x69Ex9bwTZDKpqChoaKpR
         jaTH4x1VfI64Q+jkCuG/HB2ptU8FxY0NFbgbpzgWDgqRiM3H9SqmZwMWeMfE9rSDCLy9
         sWBw==
X-Forwarded-Encrypted: i=0; AJvYcCUEGZgZB7I217a9jU030vkImKaoPZKIickrSaQQUEWrmntib5DieoRYOiUQ3F0ZEnDcgyDVlraHofaQSBuS92oeghmBdQHHco1FkYHq
X-Gm-Message-State: AOJu0YxF92O7y//nwbfPDo2koUThTrowVCnZ8C3Jqj2KAo0yCLkIoAE7
	2NNUK8i1KK0dMqsm0xpjTpDVBayyApxJJtVoc8QFQwJWVOS9Uia3eeSqClUBHn8=
X-Google-Smtp-Source: AGHT+IEUnUoM51cECvFG4aDXlm1WeTlTFMHPR0fA3iZmMtXBOgbtIn54HRGZi2CYU2BKNTL6psaVlg==
X-Received: by 2002:a62:cf02:0:b0:6dd:c870:2f7c with SMTP id b2-20020a62cf02000000b006ddc8702f7cmr4177620pfg.2.1706774761225;
        Thu, 01 Feb 2024 00:06:01 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.153])
        by smtp.gmail.com with ESMTPSA id d14-20020a056a00198e00b006de1da4ca81sm8389738pfl.55.2024.02.01.00.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:06:00 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: akpm@linux-foundation.org,
	arnd@arndb.de
Cc: muchun.song@linux.dev,
	david@redhat.com,
	willy@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 2/2] mm: pgtable: remove unnecessary split ptlock for kernel PMD page
Date: Thu,  1 Feb 2024 16:05:41 +0800
Message-Id: <63f0b3d2f9124ae5076963fb5505bd36daba0393.1706774109.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
References: <f023a6687b9f2109401e7522b727aa4708dc05f1.1706774109.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For kernel PMD entry, we use init_mm.page_table_lock to protect it, so
there is no need to allocate and initialize the split ptlock for kernel
PMD page.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/asm-generic/pgalloc.h | 10 ++++++++--
 include/linux/mm.h            | 21 ++++++++++++++++-----
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 908bd9140ac2..57bd41adf760 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -139,7 +139,10 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 	ptdesc = pagetable_alloc(gfp, 0);
 	if (!ptdesc)
 		return NULL;
-	if (!pagetable_pmd_ctor(ptdesc)) {
+
+	if (mm == &init_mm) {
+		__pagetable_pmd_ctor(ptdesc);
+	} else if (!pagetable_pmd_ctor(ptdesc)) {
 		pagetable_free(ptdesc);
 		return NULL;
 	}
@@ -153,7 +156,10 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
 
 	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
-	pagetable_pmd_dtor(ptdesc);
+	if (mm == &init_mm)
+		__pagetable_pmd_dtor(ptdesc);
+	else
+		pagetable_pmd_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 #endif
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e37db032764e..68ca71407177 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3048,26 +3048,37 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 	return ptl;
 }
 
-static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
+static inline void __pagetable_pmd_ctor(struct ptdesc *ptdesc)
 {
 	struct folio *folio = ptdesc_folio(ptdesc);
 
-	if (!pmd_ptlock_init(ptdesc))
-		return false;
 	__folio_set_pgtable(folio);
 	lruvec_stat_add_folio(folio, NR_PAGETABLE);
+}
+
+static inline bool pagetable_pmd_ctor(struct ptdesc *ptdesc)
+{
+	if (!pmd_ptlock_init(ptdesc))
+		return false;
+
+	__pagetable_pmd_ctor(ptdesc);
 	return true;
 }
 
-static inline void pagetable_pmd_dtor(struct ptdesc *ptdesc)
+static inline void __pagetable_pmd_dtor(struct ptdesc *ptdesc)
 {
 	struct folio *folio = ptdesc_folio(ptdesc);
 
-	pmd_ptlock_free(ptdesc);
 	__folio_clear_pgtable(folio);
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
+static inline void pagetable_pmd_dtor(struct ptdesc *ptdesc)
+{
+	pmd_ptlock_free(ptdesc);
+	__pagetable_pmd_dtor(ptdesc);
+}
+
 /*
  * No scalability reason to split PUD locks yet, but follow the same pattern
  * as the PMD locks to make it easier if we decide to.  The VM should not be
-- 
2.30.2


