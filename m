Return-Path: <linux-kernel+bounces-29382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFE0830D90
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AE41F260E8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E3924A11;
	Wed, 17 Jan 2024 19:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XamRXZ+E"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D430249FE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521535; cv=none; b=Y/olUOd5sCpFpGvsctc1ajNiXng8k0/XYokDF1zVPDtvrxyPEVx9lqmKqD+S9fGHHlf16zTslnBMoHD88LMvJ70M3sXzWSGI00Mbv1Jg41ftk4zCZyY0PSceQ7Ji42md/QRCfaEJvvlaLT+JVjd+lUm4LT89TzIEOgEOGHjBdfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521535; c=relaxed/simple;
	bh=D4IE53rJBci7nuFEPZUzedqALbFIgrADBxi29G2OhnQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=eBuA4ouvjhLkR7vP90nP9CtlPb68ZU4C0qja7jx5IEbzqwia5weIUCb1Lgsm4Ak56u/V2vsNQfNdZl+hrikVN20Kq1PeUmjYnmqjxTFeT5syPvW+9WuAj5YIk+mtURopP5gNI2u49vEsc33XLQPhVtsgYhDfQlUxJbGo4omt4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XamRXZ+E; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-337c25e503fso7431f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705521531; x=1706126331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OW4Pp+2efBAP38SHF6DygEiJ8WxYEhemir12iniNRbY=;
        b=XamRXZ+E8cqyo25IyON1+VNNUmMZJCt0xss77+ims9ohtn/LMFKh9sJr7aPGGWLjO9
         TNHMI+ucxbhmgeFQRTC/p7XrNX8hujndOzgrznLn5uS4tr+NxCzz0wz+V69x8aQRgMH2
         XoxxIkySIKBE+IyxpTuskC5llckSeqMmjF8G32f3/cEE+VOz4E2h9HZ+28aT8pUwCM1H
         Wu90dxcbWvUETLy5k2PDVKWCVk9+qzedj7DE50AVSVIqORGRDHx0uoFvdi/4mdRVL970
         nKhuL6J4SiZkRArOlcJnjMnVCyjh4XsuBPvmbTjUsZ6tyoDY/qjjOVABD5O4C0cq1R5+
         bhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521531; x=1706126331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OW4Pp+2efBAP38SHF6DygEiJ8WxYEhemir12iniNRbY=;
        b=GT4n7KsJXzoIETCcCLdiTPkXz3Si6ieOUiz2xDDDzGnGKBrTaVsk4KpYy7/Uhg9fym
         2J34oxO/1PNBT2trWn/BCtc6H0+oHR51+3hFYV6tcVPHcGMpYifSqaxa3MEF/8Lil26z
         Mrhawf4sS3xpqSk86QHWZsUiIoF0mxRDE6aViS3LguyFqJ0B1zBwUlKPRgGBhZ4s7DY7
         ChYn8reUc2b4aaKzYw2ol5Rs7s346o5Q2r6QwUdk9scAUS5Iq2wr2TfexoOgE2BN/IDK
         y9fxn5A+JyKCB8DjJLrZMfxyYOL4knr/yartNABLEEwT0+bgqhBXbr+NiT3sERpAozJO
         3MrA==
X-Gm-Message-State: AOJu0YzFLI6hZ77APFKNDxuAfFRTE2zM2PxvbU5zgDiWRkBIrT7/NcQ1
	tMfwRL0onsCdy4f/BF49oQk4gk9PW35O6RyUyUHFK2g0zPY=
X-Google-Smtp-Source: AGHT+IH+wmAPb2Zr2LBLfBchzsXw9gB43nlluCVXkANox4rQAmtTZpNwwjXk/z5t3IS4Fx7EKEyu2g==
X-Received: by 2002:a05:600c:30d4:b0:40e:52a6:f5af with SMTP id h20-20020a05600c30d400b0040e52a6f5afmr869311wmn.28.1705521531269;
        Wed, 17 Jan 2024 11:58:51 -0800 (PST)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0040e3bdff98asm27120885wmn.23.2024.01.17.11.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:58:50 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Qinglin Pan <panqinglin2020@iscas.ac.cn>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 1/2] riscv: Fix set_huge_pte_at() for NAPOT mapping
Date: Wed, 17 Jan 2024 20:57:40 +0100
Message-Id: <20240117195741.1926459-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240117195741.1926459-1-alexghiti@rivosinc.com>
References: <20240117195741.1926459-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As stated by the privileged specification, we must clear a NAPOT
mapping and emit a sfence.vma before setting a new translation.

Fixes: 82a1a1f3bfb6 ("riscv: mm: support Svnapot in hugetlb page")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/mm/hugetlbpage.c | 42 +++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index b52f0210481f..24c0179565d8 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -177,13 +177,36 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
+static void clear_flush(struct mm_struct *mm,
+			unsigned long addr,
+			pte_t *ptep,
+			unsigned long pgsize,
+			unsigned long ncontig)
+{
+	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
+	unsigned long i, saddr = addr;
+
+	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
+		ptep_get_and_clear(mm, addr, ptep);
+
+	flush_tlb_range(&vma, saddr, addr);
+}
+
+/*
+ * When dealing with NAPOT mappings, the privileged specification indicates that
+ * "if an update needs to be made, the OS generally should first mark all of the
+ * PTEs invalid, then issue SFENCE.VMA instruction(s) covering all 4 KiB regions
+ * within the range, [...] then update the PTE(s), as described in Section
+ * 4.2.1.". That's the equivalent of the Break-Before-Make approach used by
+ * arm64.
+ */
 void set_huge_pte_at(struct mm_struct *mm,
 		     unsigned long addr,
 		     pte_t *ptep,
 		     pte_t pte,
 		     unsigned long sz)
 {
-	unsigned long hugepage_shift;
+	unsigned long hugepage_shift, pgsize;
 	int i, pte_num;
 
 	if (sz >= PGDIR_SIZE)
@@ -198,7 +221,22 @@ void set_huge_pte_at(struct mm_struct *mm,
 		hugepage_shift = PAGE_SHIFT;
 
 	pte_num = sz >> hugepage_shift;
-	for (i = 0; i < pte_num; i++, ptep++, addr += (1 << hugepage_shift))
+	pgsize = 1 << hugepage_shift;
+
+	if (!pte_present(pte)) {
+		for (i = 0; i < pte_num; i++, ptep++, addr += pgsize)
+			set_ptes(mm, addr, ptep, pte, 1);
+		return;
+	}
+
+	if (!pte_napot(pte)) {
+		set_ptes(mm, addr, ptep, pte, 1);
+		return;
+	}
+
+	clear_flush(mm, addr, ptep, pgsize, pte_num);
+
+	for (i = 0; i < pte_num; i++, ptep++, addr += pgsize)
 		set_pte_at(mm, addr, ptep, pte);
 }
 
-- 
2.39.2


