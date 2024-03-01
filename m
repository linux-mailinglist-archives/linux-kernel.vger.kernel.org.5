Return-Path: <linux-kernel+bounces-88159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A02286DE01
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4560A281474
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1FB6A33C;
	Fri,  1 Mar 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="D88vBHfu"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23926A32B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709284637; cv=none; b=FVf3TPV75fNtktcWW3uKRXKEHBt+fkxI9XkZqqUEwL8GadUl7UPjGnA8RlMeKGkdh4vEEbXDZjLT8vH0lTI32WizyRVRQvIp793lDrtkbLBWpiKLBqGOfVNzyl2CyuWzSe+vFRVDlGV6J3mNYuhHxKmb7/mZptDgygsWhFYNiOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709284637; c=relaxed/simple;
	bh=fuD7xzNQmvbDUfKc84q5eANZ/OlUzjddCa7IPcGLM+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A7gdKBmoTEDstWPNNzb3/EbR/tCrqhA706RINdwmklR6mEw4WVlgb84xawihLjAGn0tUfM88UhR0uI5smxQAAoVozBPlrOKSVDYwtN8YT8iouVHlNYPdfhgVVEaEcc/59cY1l/veCv/aL3UOr+G90q9N8BgKhvs4gkqkR5tBCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=D88vBHfu; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412c3f4c6b9so5408265e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 01:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709284634; x=1709889434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=celeezlUFfnCgdabriQL+vY9x87nEUlib9jbsT9nzg0=;
        b=D88vBHfuqkU82KVn1HZ6QnjU7/+Qr0plRkucMAzTdrRDPeTHInZEZ4lou5fdl+6UVS
         PGGbFQx614obSDwJTuxuiYv2ejwBhLWyHgyidPHdj8Te+rcIqTSTFhyGEXCroa9x/e9u
         3VJrHcT/tegbFcjEGWZNRqBXp7mAXx0uYu1vqOxKv+aKmrx05TuLhfgK7aB+6gMVk/nV
         xqNh8AFZAP9SvSdBk8y3hQxvgP8RFGUYDSFUGhfDVqUeEHp8+XoGtDL9FeUyDFbl+4/5
         yl3yO0cq/zhQcscPNoWJfkZvURqsoOa22qPf/B1UrwQgHIH64H7vVtEucnL2SY9VgyCi
         N7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709284634; x=1709889434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=celeezlUFfnCgdabriQL+vY9x87nEUlib9jbsT9nzg0=;
        b=QrHQLe/jE/cS9jts/ANrVJlxPYNx1aUcP601HoBkw9H7yiYkyG3Y3UHG0UhScIUanU
         Rt3rlzQFya1+CreQKeqRf3A+yGyZMdnITMRiHEhXU6LX1hyD4HY8wTekMOpP/QelsrYF
         dgcA35UJAz964IxYxAyFm+6WNA2XwnNITUIroblzzTAk4HhoKx1HOfQs9FWsX5r6rEeg
         vdMxjzsh+NaQ9ZMiPt3LY6pK0K/3S9YdXY2ibDjb7q7v1e7Yhu8eLt1Szv6dmIYbo3az
         Yr1hoM8NFfzCQtJihMuoGT0xAy/qeOfx3HjmDUFbp8CoIYKfoTxtkJjS6f1QPkD1L/6I
         3DnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpFCbXno4xeXax518+uWSPsxdWFMgHrqJ1xCuSf0DHRC9ugTbb9Dnnu7UFDYyhd39Fq02XewHeaknY8h7Y07w4hfC82ca5odfSFLsW
X-Gm-Message-State: AOJu0Yy1R4xj0y/PSWTavc/Pt/K/Wgs5mREBkwFxiegZOOkkS0UNy8N4
	oD1Rj+d+nFf06fhTN8dApSGBB1HZHVTUE/TH61ZAh84+F/plbQK0hv7owIXNLaU=
X-Google-Smtp-Source: AGHT+IFB0pFFxU/+IPg3Lb+DpLxmFSKXoGv4IrPSAZpcxiUzICaAY8iLg+9vVvkiiGxUNIP5Ue4QKg==
X-Received: by 2002:a05:600c:3b26:b0:412:c810:fd18 with SMTP id m38-20020a05600c3b2600b00412c810fd18mr995837wms.18.1709284634158;
        Fri, 01 Mar 2024 01:17:14 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id l33-20020a05600c1d2100b00412ca88537dsm358022wms.0.2024.03.01.01.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:17:13 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 2/9] riscv: Safely remove huge_pte_offset() when manipulating NAPOT ptes
Date: Fri,  1 Mar 2024 10:14:48 +0100
Message-Id: <20240301091455.246686-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240301091455.246686-1-alexghiti@rivosinc.com>
References: <20240301091455.246686-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pte_t pointer is expected to point to the first entry of the NAPOT
mapping so no need to use huge_pte_offset(), similarly to what is done
in arm64.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/hugetlbpage.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 3d84fbc5c572..2477d20c1497 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -274,7 +274,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
 
 	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
-	ptep = huge_pte_offset(mm, addr, pte_num * pgsize);
 
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
@@ -319,10 +318,8 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	}
 
 	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
-	ptep = huge_pte_offset(mm, addr, pte_num * pgsize);
 
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
-
 	orig_pte = pte_wrprotect(orig_pte);
 
 	set_ptes(mm, addr, ptep, orig_pte, pte_num);
-- 
2.39.2


