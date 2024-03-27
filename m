Return-Path: <linux-kernel+bounces-120315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DEF88D599
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368112C24C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542162C6AD;
	Wed, 27 Mar 2024 04:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jM+qYYj5"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636B2C1A8
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515063; cv=none; b=Bomg9+YJaYzuSD0fZ/ac0G5KgFTUYhq80DmzlIH2Ak7R8caXjcgJ/YxYKS/YHlEJ5H0XSne5H4A6ZOHtdNbtgz68ZKs3OCRiAd9eKv/yw7td7VcremJhdstJeD3+fd33/cKnRgmk7DaI7JKFBl4X6wys6O7XhhfsdSCDFjHGPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515063; c=relaxed/simple;
	bh=MRE4XT0P9lLUUCp1Ujsa6SQk4prpBDb9nMVRKvQ6tEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rn0iBRL0HDdmal9SYwn+n9cUgtwUGY4DJngnmlICmK1ICS0l2utNXHUIhJhmY7kOWIxXmBxM4O2YE79ChRFCo2AlVUFT9FT5UXUQziPW/ZKpRegmoCJxrRzxycFy76oKdw8qDX9m92p6hiHLl/2zgbHtpY3rV/QpSkqhwG/5nxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jM+qYYj5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ea9a605ca7so381507b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711515061; x=1712119861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwpkv2OuO7YHUplKH98oFVfOa+CFbclxXNu0ysmduyU=;
        b=jM+qYYj5QTJ+dGUdyDeBKHcRLJZk81elChhqV+twofbmJhbnMwqqn/XqUpoaRJTDoL
         mXcSyDUZ9e+L9AY0zJK+HiOqTQjrPZelmz1av7t6yvXS/3Yzud7PKBhTBzzxSdBr8nlH
         jqyFQXPYbPqycIGgCyv/qolFRyfsUbOq2iJFs/t96dT2uHoMBNEF1840ayYmGL8EWTQR
         PuCevHEZLgb1FjLdDFwfqVGk/o4NrwOlIY56z/018WgVWuQss3+CKVWLNBP9fvCu9n7G
         bmOX3usTWNd3PqbM/JC3ACpqbetuooUGhAupq8LIAiQTBS2Cho7monHkEoD/nvohZFoV
         mWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515061; x=1712119861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwpkv2OuO7YHUplKH98oFVfOa+CFbclxXNu0ysmduyU=;
        b=Iobp5+X6iEofl1BR0kqhhWoE3bifSGoPN1cdQ2IGvoSRCTKn2n2YF+xx7mW/Yzbf6Q
         SX+2gYt5y/z07gzrrlm3YK113GI8BX5IP2q+BNczgTV/TuL1huEcaUAKNubbFLYxpeSE
         VTc1LNEhuncKLH2pfAaEkZFWw994Jk9bi5LbBg3zym6gP/S+sTjCoieOmKGOweOZKsXi
         fbPHUXFNAIo/Cxh9uLr/wGxvxm8+bGlMdd23vfzfwuUXBm8ozhAnOEq2LU0j+a1wqvp2
         O/8mYLWSYhbGxyjswrmZIVRMR27c/CBMeQ5ZC+rnhhxJnUYm2jH6BtFE0tszQ0LsumzO
         e4pA==
X-Gm-Message-State: AOJu0Ywsz1lmO+5mpcORnKNFGG6h96VBas+ymVOxEAgEpTGGXsczyZdm
	elT5d3lBesWUgNbiHnxtDf+4aQH1fwWA9YnZzK+/TwsqwGU0g1Ov9hj8hKljcoI=
X-Google-Smtp-Source: AGHT+IFIatp35KNpgDUDmJycAxTP3nvYaAVXQURqJcQtx3/AD7qiy3AeB8dChiHf0CcNcubYBhb1CQ==
X-Received: by 2002:a05:6a20:7345:b0:1a1:67c0:c751 with SMTP id v5-20020a056a20734500b001a167c0c751mr5157753pzc.17.1711515061281;
        Tue, 26 Mar 2024 21:51:01 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e31-20020a63501f000000b005e4666261besm8351500pgb.50.2024.03.26.21.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:51:00 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 12/13] riscv: mm: Preserve global TLB entries when switching contexts
Date: Tue, 26 Mar 2024 21:49:53 -0700
Message-ID: <20240327045035.368512-13-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327045035.368512-1-samuel.holland@sifive.com>
References: <20240327045035.368512-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the CPU does not support multiple ASIDs, all MM contexts use ASID 0.
In this case, it is still beneficial to flush the TLB by ASID, as the
single-ASID variant of the sfence.vma instruction preserves TLB entries
for global (kernel) pages.

This optimization is recommended by the RISC-V privileged specification:

  If the implementation does not provide ASIDs, or software chooses
  to always use ASID 0, then after every satp write, software should
  execute SFENCE.VMA with rs1=x0. In the common case that no global
  translations have been modified, rs2 should be set to a register
  other than x0 but which contains the value zero, so that global
  translations are not flushed.

It is not possible to apply this optimization when using the ASID
allocator, because that code must flush the TLB for all ASIDs at once
when incrementing the version number.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/mm/context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 0bf6d0070a14..60cb0b82240e 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -200,7 +200,7 @@ static void set_mm_noasid(struct mm_struct *mm)
 {
 	/* Switch the page table and blindly nuke entire local TLB */
 	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) | satp_mode);
-	local_flush_tlb_all();
+	local_flush_tlb_all_asid(0);
 }
 
 static inline void set_mm(struct mm_struct *prev,
-- 
2.43.1


