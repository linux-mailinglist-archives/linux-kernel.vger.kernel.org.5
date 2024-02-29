Return-Path: <linux-kernel+bounces-87684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DAC86D7AF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DB81C218C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E9914A4F3;
	Thu, 29 Feb 2024 23:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XSvn8kij"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94168145668
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248948; cv=none; b=GpIUqyhwn9sJmdsEICsn57css4NLH71GWWKZ3+7Uns4HDkDzvCNRrwY+uJcDOrwyH4frePlmaZpyEXRoIkwTNEjkdW8ltOmUJWqaJve3Pu63XuGSUqse2ZvBRqAvRN6TrLl5HMDDBZL1A1p2UXo+izpaWW5WUvzwkzvD9QnvYok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248948; c=relaxed/simple;
	bh=MRE4XT0P9lLUUCp1Ujsa6SQk4prpBDb9nMVRKvQ6tEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4GAX3Xv+UI+98BgTuHZlqCVwwEnsm2gYONN4Xv2SfQbR+SejtyfS/lsvxpcBK9uJMORDX3H7Gm0NgIQXrL8ebwxxSa7AyLVn9ZDBS3nhroaLkcaYaTzApXJWD3/SDW6yYq2VcVBlklXI4xstQAWmtd7V2QvI45QRu/c8CFDTBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XSvn8kij; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3bb9b28acb4so1094686b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709248946; x=1709853746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwpkv2OuO7YHUplKH98oFVfOa+CFbclxXNu0ysmduyU=;
        b=XSvn8kijH43lMHYjQhBT0h1zp2LObu8ygYFKiDSr3mS/HXqIzckAiAmvpc+COu0a2e
         3jOeUVSnSk+Onb1pHstwBjfqUS5KGf8RXtO6tAtJm6eaCHkXou/JQiWDojnRBlolaYHM
         kBUDXsvMVoJVYzEmE1oL5rZfj/ljFQ26OMJ1meUy3YBJ8i3hlPYk/OSLOkUHA5KGTZrU
         jbxkqEEbCl5g12LXsmxXoSIRe3rVDZFQSFjX0o0s0dTO28YG2KbXa7laBLDx5j4GGwn9
         lK4IDJko3KLj3es+Gy7PODJy5cb4nvbV9LZxJ5ACeZHpQCJ4Y1SwtE00qMWrJT4JaNoG
         LPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248946; x=1709853746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwpkv2OuO7YHUplKH98oFVfOa+CFbclxXNu0ysmduyU=;
        b=DRvGW7+TLapQHMFqVqMOK1dSanEk6P6tYCcCvhqciRup2ORjyzFt/inCea4qikuUOX
         Rey35XDu1R5AsX152gsfy+P4lzW9bIAcWdbPnDrwzenKqQrl4zzHfEAmOiex8DSHVkCt
         YWVxa130ohLvXktkz0oy2uLlPQBel5WebQxkQKlwAlerAV7opgjFbidGZVH6beG8M1U+
         4slINWcQScDEGlfBhfjOJivfDaNHfEXkT7LKE56feHiCoiNVwg3HvPDGstlMX3oykRbD
         XmZGSSIFT014P7r0nnsk429vS23OSuFgyOHH2m1SNQ9YM7j3xkTGxu0voYl0Ha080pjK
         tUVQ==
X-Gm-Message-State: AOJu0YyPLL4gG6leb9aGuFLI4a76KCLB3ZvrLpUanB0cPLhOB2Ecssx+
	C4tOi1U9Oty7EbrjYNZEudr5KI21ZTtRIdV7H0drvTpYqKtrWCApNp1qRW9yBNk=
X-Google-Smtp-Source: AGHT+IHmmt9lzZLUCIFAbm5GqyPJaePE9QFXJ4x/3NAo+fPZmowQvwtei5P759brqGkqtPXCOnb8SQ==
X-Received: by 2002:a05:6808:17a7:b0:3c1:af49:222b with SMTP id bg39-20020a05680817a700b003c1af49222bmr47209oib.37.1709248945851;
        Thu, 29 Feb 2024 15:22:25 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e55aa75d6csm1779719pfo.122.2024.02.29.15.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:22:25 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 12/13] riscv: mm: Preserve global TLB entries when switching contexts
Date: Thu, 29 Feb 2024 15:21:53 -0800
Message-ID: <20240229232211.161961-13-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240229232211.161961-1-samuel.holland@sifive.com>
References: <20240229232211.161961-1-samuel.holland@sifive.com>
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


