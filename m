Return-Path: <linux-kernel+bounces-48172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1885845839
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ADA01F23A8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6555CDE7;
	Thu,  1 Feb 2024 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgsernW5"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC91B5336A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791998; cv=none; b=a6T4exDnm7HwbocBUE/UKsaSfWABVobZQI52/ipzsVrFIEmJV+vOIBuUpRH2J/jikvojCH96thJ2lEoOjDYifJjbFbQFjyi+ZyrGZMjIymGsRrcD/wIcX9sin5Sknu6v0cA1AyxJAb+s5+epKZGde+BAFUTNc+MBx+ggAIHgM1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791998; c=relaxed/simple;
	bh=7PXAUnHUmoEF3UTxLOPfT0TJCC9/HwX2n79M8mfQ9Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RAhfwFdS1cSOsSWBWOHa9hH9MvfGeEI9wQBjWh9s7pQDscq5rDS4t1sg+WuEYN8ux+8pSg1gPgF1eOjphJZj4BvZYLw7pzY8bBIzcyKfX6/4G4XMU7FXivMsoHkqx38PlqEn32YPBfZSFOAH5jgKDiItlapKWcwwsTOfhR0Z9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgsernW5; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-363844ae819so3334235ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 04:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706791996; x=1707396796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+dIpEuHcsVA+p6HpZJFPK5u2p7oWDuiKjAseXCAiZTo=;
        b=SgsernW59t1ppqSoFFq1hQRjxtFsBWBplyJ0cd/gcqiqpn4VDYAV/iEAoZxJsldLuX
         YQGkYCFDU6FNnTM6jsSaKxTpjyAcF4J5z7opw/Sk+reTQy982TalAe7c2NCJc7LeFoz1
         skdZoAxT6xcxaRkFEAYbGmJh85JQ2O14kWXkcjRToGKuaaFavuJe3ZdYQlUYPs9bhV/T
         AWrvzApU5dKHK1bnPV8lNWpDpdS3Pdjeie4MHG2De7r6+bdB+A5MAsSowEkQM+opSUOD
         qWaMHA+P4cU3tY1SEpT89GsMQmp3gycQF487BvkOEZXpW79VQ4Tv3yG3hMMKV9GT+hZF
         Juug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706791996; x=1707396796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dIpEuHcsVA+p6HpZJFPK5u2p7oWDuiKjAseXCAiZTo=;
        b=QEHgQGZx1vYFFNsiv1bjN07lPsp0fx/sErNdtSilJrSdL+WyrnueTq1zXFTPHf3xDy
         9AZMUSALaAYFLSUJcotgmPSKssIkT49/zngbPMeMcsCP+n/DbZuXiA6kUOffFQZCLko7
         bt/e9Y9cRBOi6gwYtZWMP7bWBBJgooM5R610czp0z0ASJWvKy9iiIlB98kLeRslJn1Gh
         O2BMT2M1miMUqJjZYphyQ/oWqhYWEZJiCc/HN1Nk8FPQYSg2N0fj4SidGqYItjmhKe8i
         Z9cfeb5k4TnxdGZ8+qEQ8SPmmzgZhjGJlVVU2QErqnTGlu3FWRxtf2QDKAMJSBP+VyZf
         e3ow==
X-Gm-Message-State: AOJu0YystGCgjw3gVh51TroqlvU5c09O/LzwS4qQZsavnVL+tPih8z4z
	6U8aO4cQJrnlG6KqWg0zZmPmGA80fJ5ydMByzcXLxxsJPf2LJiq/
X-Google-Smtp-Source: AGHT+IG9rtFkIqzbFdbCc8UCLsLfITRXKzQzKEPG60fxsRW3huj2RDpqksiISbxY3tV787PqINAdnA==
X-Received: by 2002:a92:d44c:0:b0:363:7a04:548e with SMTP id r12-20020a92d44c000000b003637a04548emr4612091ilm.9.1706791995971;
        Thu, 01 Feb 2024 04:53:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUQmbzvwjjuar5/jjMYvrUfyQqXab4b3OcMUL5T6Ss1INNhxyM/EtSEtESt8NBceTbbqBw+exoQkoGSxIXlWYk9A6fm4vSBbVM4TGBGBYv1jEUsE2LIYM4raJEJQbIg91R+vXrspkuys7H+WdjiG5pCXXdycCqMtjyUGqg9OBJoQ2ZLPTAaXVlkVf60qmWPCqeN/0Z47xRoIJyNXO7MdPN5l35ojzS3wrt339yLwDcWBflMmKnZ5bWc/Y+lOPfbZs7chGjFduDN6/XTx01BxIg6o+bpGfBlXkYU9gNxb+k3a649thcqK5Vmvdw+BNkFqm8n
Received: from LancedeMBP.lan ([112.10.240.49])
        by smtp.gmail.com with ESMTPSA id k30-20020a63ba1e000000b005c661a432d7sm10863637pgf.75.2024.02.01.04.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 04:53:15 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: akpm@linux-foundation.org
Cc: mhocko@suse.com,
	zokeefe@google.com,
	david@redhat.com,
	songmuchun@bytedance.com,
	shy828301@gmail.com,
	peterx@redhat.com,
	minchan@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Lance Yang <ioworker0@gmail.com>
Subject: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
Date: Thu,  1 Feb 2024 20:52:26 +0800
Message-Id: <20240201125226.28372-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.33.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The collapsing behavior of khugepaged with pages
marked using MADV_FREE might cause confusion
among users.

For instance, allocate a 2MB chunk using mmap and
later release it by MADV_FREE. Khugepaged will not
collapse this chunk. From the user's perspective,
it treats lazyfree pages as pte_none. However,
for some pages marked as lazyfree with MADV_FREE,
khugepaged might collapse this chunk and copy
these pages to a new huge page. This inconsistency
in behavior could be confusing for users.

After a successful MADV_FREE operation, if there is
no subsequent write, the kernel can free the pages
at any time. Therefore, in my opinion, counting
lazyfree pages in max_pte_none seems reasonable.

Perhaps treating MADV_FREE like MADV_DONTNEED, not
copying lazyfree pages when khugepaged collapses
huge pages in the background better aligns with
user expectations.

Signed-off-by: Lance Yang <ioworker0@gmail.com>
---
 mm/khugepaged.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 2b219acb528e..6cbf46d42c6a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -777,6 +777,7 @@ static int __collapse_huge_page_copy(pte_t *pte,
 				     pmd_t orig_pmd,
 				     struct vm_area_struct *vma,
 				     unsigned long address,
+				     struct collapse_control *cc,
 				     spinlock_t *ptl,
 				     struct list_head *compound_pagelist)
 {
@@ -797,6 +798,13 @@ static int __collapse_huge_page_copy(pte_t *pte,
 			continue;
 		}
 		src_page = pte_page(pteval);
+
+		if (cc->is_khugepaged
+				&& !folio_test_swapbacked(page_folio(src_page))) {
+			clear_user_highpage(page, _address);
+			continue;
+		}
+
 		if (copy_mc_user_highpage(page, src_page, _address, vma) > 0) {
 			result = SCAN_COPY_MC;
 			break;
@@ -1205,7 +1213,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	anon_vma_unlock_write(vma->anon_vma);
 
 	result = __collapse_huge_page_copy(pte, hpage, pmd, _pmd,
-					   vma, address, pte_ptl,
+					   vma, address, cc, pte_ptl,
 					   &compound_pagelist);
 	pte_unmap(pte);
 	if (unlikely(result != SCAN_SUCCEED))
-- 
2.33.1


