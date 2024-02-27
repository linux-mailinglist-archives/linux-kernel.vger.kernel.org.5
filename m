Return-Path: <linux-kernel+bounces-83995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3034C86A12C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54BAB1C248F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CAC14EFDA;
	Tue, 27 Feb 2024 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wymAGB67"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E36156985
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067085; cv=none; b=oOUdZb6GNZQ+0cZRv7Mx1XkPfiJyfLhW6ZixCT3ZHkd0xGLeZbObvE5AaCuKFO4aqzKtZLzh29anBHZ6MjQtUZMwhW/1ghcRMArXeE29G8PbDgJRlfTASwQMa7uqcOdkGKJwqcUiEZmguMlVIOQxhu15JBt/kUuixr8646fjqaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067085; c=relaxed/simple;
	bh=YfetGUHw90TINhyDyoOkqomfVnThTiY+r2jyOXe193w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z8KClKa5mYVIDOcylMj/U5GnMVfsHXT3HHDeAYaKLuDOwnKIbz9CeybZNQZwhMA33L0Am1iqgB7c349z+fwea7+tUfJMK5vgmCN9ZwUG2scwZhR0JVaWn6xoe7Oz+gXZjHm/3b0xFUGAb0DUe4T8iMYFgZonyHazDNeTZ0zsq3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wymAGB67; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3392b045e0aso3870845f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709067080; x=1709671880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS3Fbtccf2xLgZAcGdUt297LbB3kw/tfByr2NgsnNkM=;
        b=wymAGB67y2g14ZjVuSLbpsCPR3IiRxkjYIIop/swNmry9Cdle69shGKDDPYM4YrT0d
         cNT6vNiS+P+QR+ewVNcBAKFPCwAhaAOYok46pR8UOMBAaofD7zMW7YGsKrgXJhJsvCbT
         eiK74EpqG2TROivwhpcZMr7tvkKXiJYThwX8w4Tep5Dwa/X8BG1e86RiwAhn3VN6x+hP
         4Ko/l9bdDqSdTYwA1kb2cXCDg60LyodN62UEGQE1yrJw4k+Hlddeyc4hwLclJxad8Sbf
         rHj5vbhA99lkhAAFq60FlH5z+TwLEtZtHZLrkAkf4w0rtQ+qyVotYaSWRXuNrTtj8AVf
         1VtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709067080; x=1709671880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wS3Fbtccf2xLgZAcGdUt297LbB3kw/tfByr2NgsnNkM=;
        b=n/2Xzyb9/nrtTOs0zHonTXqfv0sumFtu5407awct+cVPTucGEERS+MsoubibYzmmS+
         RAymXAfzFu4O5mZiHK9qVVMdfeF5WIt26Dt9BxHoIf/wmYVQO7oVPBEoxjI4wir8IsPr
         Rxx6JI6YPW7N0gj3Kn53BVtLLgzUb1xyvqSVT6XqMH+LsQ0NJgXT1l7uXJcpuNmeEnJ6
         UTCqPE9KeWXKERcwlrErnMbQUogDicVdQojvp1XXqYS7wAqa1Pgk3UaBHx1l70bWyYhL
         KcGwraiPo0lpr/EF2nAb9OABfk2VqNdO1EzfzJzKP+IbHxFJ8nFW8+N1FMgZKjCHADkJ
         J1SA==
X-Forwarded-Encrypted: i=1; AJvYcCWHGfdip845Vuk1S4n/lo1MKFpPDxamKsvYQYNjvRb+daJGpGcE5it62WYRMIU8HaxjFclNm8WglP5Mve5xF61wRQLZBRpXsPCjO5vM
X-Gm-Message-State: AOJu0YwKdd7VHIGJeuSU1jJnT5klSJhV84nTTHgZkUTsISW7K/hs2CJS
	yBCbgX6Ah+vhxj0aedFmcOC1ij1ob5extkB6CYjSEwBQp4NG2GQ6h+T8g8DWUEw=
X-Google-Smtp-Source: AGHT+IHzShpzx0Q/2mn+wkknfDNqSJfPuVlQTcePThpcQE0N9o+mPidgxMz5BYc0SI6qcOtmJFBdmQ==
X-Received: by 2002:adf:e582:0:b0:33d:f3c9:a526 with SMTP id l2-20020adfe582000000b0033df3c9a526mr1830243wrm.67.1709067080216;
        Tue, 27 Feb 2024 12:51:20 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id v26-20020adfa1da000000b0033dfd3a8cd3sm35135wrv.30.2024.02.27.12.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:51:19 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Qinglin Pan <panqinglin2020@iscas.ac.cn>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes 1/2] Revert "riscv: mm: support Svnapot in huge vmap"
Date: Tue, 27 Feb 2024 21:50:15 +0100
Message-Id: <20240227205016.121901-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227205016.121901-1-alexghiti@rivosinc.com>
References: <20240227205016.121901-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit ce173474cf19fe7fbe8f0fc74e3c81ec9c3d9807.

We cannot correctly deal with NAPOT mappings in vmalloc/vmap because if
some part of a NAPOT mapping is unmapped, the remaining mapping is not
updated accordingly. For example:

ptr = vmalloc_huge(64 * 1024, GFP_KERNEL);
vunmap_range((unsigned long)(ptr + PAGE_SIZE),
	     (unsigned long)(ptr + 64 * 1024));

leads to the following kernel page table dump:

0xffff8f8000ef0000-0xffff8f8000ef1000    0x00000001033c0000         4K PTE N   ..     ..   D A G . . W R V

Meaning the first entry which was not unmapped still has the N bit set,
which, if accessed first and cached in the TLB, could allow access to the
unmapped range.

That's because the logic to break the NAPOT mapping does not exist and
likely won't. Indeed, to break a NAPOT mapping, we first have to clear
the whole mapping, flush the TLB and then set the new mapping ("break-
before-make" equivalent). That works fine in userspace since we can handle
any pagefault occurring on the remaining mapping but we can't handle a kernel
pagefault on such mapping.

So fix this by reverting the commit that introduced the vmap/vmalloc
support.

Fixes: ce173474cf19 ("riscv: mm: support Svnapot in huge vmap")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/vmalloc.h | 61 +-------------------------------
 1 file changed, 1 insertion(+), 60 deletions(-)

diff --git a/arch/riscv/include/asm/vmalloc.h b/arch/riscv/include/asm/vmalloc.h
index 924d01b56c9a..51f6dfe19745 100644
--- a/arch/riscv/include/asm/vmalloc.h
+++ b/arch/riscv/include/asm/vmalloc.h
@@ -19,65 +19,6 @@ static inline bool arch_vmap_pmd_supported(pgprot_t prot)
 	return true;
 }
 
-#ifdef CONFIG_RISCV_ISA_SVNAPOT
-#include <linux/pgtable.h>
+#endif
 
-#define arch_vmap_pte_range_map_size arch_vmap_pte_range_map_size
-static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr, unsigned long end,
-							 u64 pfn, unsigned int max_page_shift)
-{
-	unsigned long map_size = PAGE_SIZE;
-	unsigned long size, order;
-
-	if (!has_svnapot())
-		return map_size;
-
-	for_each_napot_order_rev(order) {
-		if (napot_cont_shift(order) > max_page_shift)
-			continue;
-
-		size = napot_cont_size(order);
-		if (end - addr < size)
-			continue;
-
-		if (!IS_ALIGNED(addr, size))
-			continue;
-
-		if (!IS_ALIGNED(PFN_PHYS(pfn), size))
-			continue;
-
-		map_size = size;
-		break;
-	}
-
-	return map_size;
-}
-
-#define arch_vmap_pte_supported_shift arch_vmap_pte_supported_shift
-static inline int arch_vmap_pte_supported_shift(unsigned long size)
-{
-	int shift = PAGE_SHIFT;
-	unsigned long order;
-
-	if (!has_svnapot())
-		return shift;
-
-	WARN_ON_ONCE(size >= PMD_SIZE);
-
-	for_each_napot_order_rev(order) {
-		if (napot_cont_size(order) > size)
-			continue;
-
-		if (!IS_ALIGNED(size, napot_cont_size(order)))
-			continue;
-
-		shift = napot_cont_shift(order);
-		break;
-	}
-
-	return shift;
-}
-
-#endif /* CONFIG_RISCV_ISA_SVNAPOT */
-#endif /* CONFIG_HAVE_ARCH_HUGE_VMAP */
 #endif /* _ASM_RISCV_VMALLOC_H */
-- 
2.39.2


