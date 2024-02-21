Return-Path: <linux-kernel+bounces-75685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A36E185ED63
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C1C1F24152
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D3312E1E0;
	Wed, 21 Feb 2024 23:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4Oi6Tit"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B5A12D77F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559404; cv=none; b=fOyCndru5THQ6V/HCxWOPXCr00UrwcW4a7WFjXG7WX8CF6BD5GhT/+fqr+7ayLtoncm6eAuH/RrOdntx5knMW5iJJBCIDgtZaLf1DPGWAF28Ab8C7ozy/o8dtrNXVLBoYsIULptzCwSTPx+SaHpDJWGBm2gUXjRubUH1n7HsW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559404; c=relaxed/simple;
	bh=9I24s70ML12HR7yAYgWnA/yzcgx2UmcSmZ6qGRMVJj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbUFWcm3QDZLnzEz4pOMRdiYdHzr8rlGpvvRhTKZRubVJQrzrPqrKk9QTtQoeD0W3+xnUXLcHrnasSJRrLrPUdInDENl/jq34OEO7Ki1EGCPPWEg4SJ+Ndlz3CD/GTLEDbzWVrg5it4daqJncnAz6ZtqBYEeIL4mF4lNBychGBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4Oi6Tit; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so33956435ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708559402; x=1709164202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pW0shPvwYrN8ODFgTcl6EvNguHwyyx6gBjAHCZnk7do=;
        b=b4Oi6Tite/aRDjIPYFJ4cAgqcToTWM1kmI1GjMsqSEM4aMhZ5iZbfvdl+vKazlWy1i
         ZQ5VV08gg+AOQitiwHEeI0kJlJw21Bjn1H1ylyna9TkhoFS4bGWkBN9Xf8RqLzrrEmz3
         kkOj7iCBDV1j0FaH37XUj3DdZq5oWYf7GTx/YfDXEHY/6LfIo/ZX4KFDFCsdoTCjjGsf
         d+rZikWdsTXMRhHr59rrgnNaIlDpoQ4qmhxWHD9dXJfH78vmEiWf2PJcKRzOQ8lU/Mb9
         rKGXuY1zdDTe2YPtBmQKfHxVTAHBFddinXxnz1Ohd8AUOn3XryQKJ9I6G/sJka4kFYvj
         5k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559402; x=1709164202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pW0shPvwYrN8ODFgTcl6EvNguHwyyx6gBjAHCZnk7do=;
        b=QgBPSvmUqsh5T+6wM6mMVnvO9pJHdqVE4wpPA0pixGbbMXL8OHTrPzaDtayIkWFouI
         KBfqLlZMdr0/t3/SkJtzhtdZa4xbhGSVvOSnOQA9juwiCC/sULslAUM+/HS2eytlR2X4
         mS6UVbXk0p+t3sw3u8koxyYgEdG+Rerr9GaKSHYDyfM231eaIyWFr3aO3xfQq180BZlZ
         NnaQ/JYi1kpUej2FwZPAQTEHR5Iuu/FzUrdsc58SFge0eEGSqitPXi2Rc4c/tFfl5v9t
         G1sxY90yBpHiHl5TKHd0MYZTiNo/60533VkQyIQHY7j1f6BxXJJBkB9L7mvGS3WUFHJ+
         BQIQ==
X-Gm-Message-State: AOJu0YwN5pcjMckcl56LaIwBsFhKpwcUsTnB1Yn7ka+kCP2sOSrQq6VT
	j8y3ssDPFcqsYObkjNHNh0V0xNQGXgyIC47nXy3K+OQmzuyl38pV
X-Google-Smtp-Source: AGHT+IEkWuA9z9zlwpJbc1Kta19kKpN2tZu6Hibqp8iAOwkmOQwVY84bMgMA2AlZNl8oNprNMtwCsw==
X-Received: by 2002:a17:902:ce85:b0:1db:d120:5cda with SMTP id f5-20020a170902ce8500b001dbd1205cdamr14482066plg.11.1708559402026;
        Wed, 21 Feb 2024 15:50:02 -0800 (PST)
Received: from fedora.. (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.googlemail.com with ESMTPSA id jx3-20020a170903138300b001d752c4f36asm8657794plb.78.2024.02.21.15.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 15:50:01 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	muchun.song@linux.dev,
	willy@infradead.org,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 3/5] hugetlb: Pass struct vm_fault through to hugetlb_handle_userfault()
Date: Wed, 21 Feb 2024 15:47:30 -0800
Message-ID: <20240221234732.187629-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221234732.187629-1-vishal.moola@gmail.com>
References: <20240221234732.187629-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that hugetlb_fault() has a struct vm_fault, have
hugetlb_handle_userfault() use it instead of creating one of its own.

This lets us reduce the number of arguments passed to
hugetlb_handle_userfault() from 7 to 3, cleaning up the code and stack.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/hugetlb.c | 38 +++++++++-----------------------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d792d60ea16c..70c5870e859e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6060,39 +6060,21 @@ int hugetlb_add_to_page_cache(struct folio *folio, struct address_space *mapping
 	return 0;
 }
 
-static inline vm_fault_t hugetlb_handle_userfault(struct vm_area_struct *vma,
+static inline vm_fault_t hugetlb_handle_userfault(struct vm_fault *vmf,
 						  struct address_space *mapping,
-						  pgoff_t idx,
-						  unsigned int flags,
-						  unsigned long haddr,
-						  unsigned long addr,
 						  unsigned long reason)
 {
 	u32 hash;
-	struct vm_fault vmf = {
-		.vma = vma,
-		.address = haddr,
-		.real_address = addr,
-		.flags = flags,
-
-		/*
-		 * Hard to debug if it ends up being
-		 * used by a callee that assumes
-		 * something about the other
-		 * uninitialized fields... same as in
-		 * memory.c
-		 */
-	};
 
 	/*
 	 * vma_lock and hugetlb_fault_mutex must be dropped before handling
 	 * userfault. Also mmap_lock could be dropped due to handling
 	 * userfault, any vma operation should be careful from here.
 	 */
-	hugetlb_vma_unlock_read(vma);
-	hash = hugetlb_fault_mutex_hash(mapping, idx);
+	hugetlb_vma_unlock_read(vmf->vma);
+	hash = hugetlb_fault_mutex_hash(mapping, vmf->pgoff);
 	mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-	return handle_userfault(&vmf, reason);
+	return handle_userfault(vmf, reason);
 }
 
 /*
@@ -6116,7 +6098,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			struct address_space *mapping, pgoff_t idx,
 			unsigned long address, pte_t *ptep,
-			pte_t old_pte, unsigned int flags)
+			pte_t old_pte, unsigned int flags,
+			struct vm_fault *vmf)
 {
 	struct hstate *h = hstate_vma(vma);
 	vm_fault_t ret = VM_FAULT_SIGBUS;
@@ -6175,8 +6158,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				goto out;
 			}
 
-			return hugetlb_handle_userfault(vma, mapping, idx, flags,
-							haddr, address,
+			return hugetlb_handle_userfault(vmf, mapping,
 							VM_UFFD_MISSING);
 		}
 
@@ -6248,8 +6230,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				ret = 0;
 				goto out;
 			}
-			return hugetlb_handle_userfault(vma, mapping, idx, flags,
-							haddr, address,
+			return hugetlb_handle_userfault(vmf, mapping,
 							VM_UFFD_MINOR);
 		}
 	}
@@ -6419,9 +6400,8 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		 * hugetlb_no_page will drop vma lock and hugetlb fault
 		 * mutex internally, which make us return immediately.
 		 */
-
 		return hugetlb_no_page(mm, vma, mapping, vmf.pgoff, address,
-					ptep, entry, flags);
+					ptep, entry, flags, &vmf);
 	}
 
 	ret = 0;
-- 
2.43.0


