Return-Path: <linux-kernel+bounces-120316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C78C88D59A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D85F1C2573B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C160F2D042;
	Wed, 27 Mar 2024 04:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ceoRPsJR"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEF42C6B6
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515066; cv=none; b=JEIUrz/VbfVhQiePiXKzoa0bPn7k1dAg27jUQbZMoBk3U0W/55/LPRFGb7ew+eRpxwAgADNkhOmwYKq0RL2coN55+oK6XiMuIqljYlLdBL2APE+HCTbvqtSh/TxW5M9ijP8Fl2Mam4yUSkfuouIJxUftL1dOqC3UR54/AK5hCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515066; c=relaxed/simple;
	bh=D/kvOoscoO9GAvES/r3sKJAilm9YD07kx5uQNIOnQFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvRROqVdim0BNAGA8LmqV8MlgzG+0SLRygNDEjS1t1zUxjAdZXacI/veU4vnP/aQrnF0ukNCYuddWyMZ5mqrPgj8NHeaQ1SFRumIpKGwdXccwtA8gWZYGF66kIzvgQJZ8n14wSvjA5JnnTLGct3igbSCz73jM9mljX77bcY9Zv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ceoRPsJR; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a5362ceb7bso1591058eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711515063; x=1712119863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DStjBcAn1SHrL/HpDMugRz0dC8r4hdt1hrlyujsEs2s=;
        b=ceoRPsJRxo9+qc2acSFLkXlaPq0aHu0TpsMyFUXrAst8Ila4TWwUAOz59yOedpyG4U
         +20etI4OOwpZbOXlp8yOXtW2pQoRe2Eb9/P/0DbuAkAm7eeWbJ8CMPOfhHgfuoAmkaR9
         MIILW1QN/PFdcrjsR6C1/vfM+Oj8UJXlC05WlseTV5EKudyD5A6zOUAh4nzvYyBD3XCe
         cOwmaqQUC0vI2+m3FSFUX0/nyacCIlDaVF15wNhx4ITpA0aNWOaTnmwtsoWLX6oDCI5t
         6GMGIIhKvzHXPzXqU7960N4m05YHLVMRrZHUoRw7SEH0/ix6YUfM145pNZvdm74hlXC0
         cOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515063; x=1712119863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DStjBcAn1SHrL/HpDMugRz0dC8r4hdt1hrlyujsEs2s=;
        b=GDHhhaS2UKZO5COGCMM+z5/h+mM/yKXtn7hMv+XbF4hk1H3MmM5VF67IDFHydsJTUx
         3lbfUziRAosgUAqz4uvWVJfOmlkYyTng01xwrQxngyE9BliNkqO+iIJyytvgZOHmKVEP
         CKZIIlYoP42Zqwq6XVwCRdW3dGGW8Go3o9vktxgFzG5IP8CGjBy0MamgLoe7TzTcY1H2
         wczenAAo7MawvYVAZSZghU6FQHuYPdCz31bZhO2uBl0QHsyYKLX52neKgH+BWkOTQ8h3
         50kHltHI7uqxxyKAFU7529rG1WJ8NHCVUBrS7R89ujM+/JnRNAACdenTMF2+oRONyt6p
         7Lvg==
X-Gm-Message-State: AOJu0YyKSmdsVktDBoSWuuJoB9Nk4Um4t/l+AZuaUu9MGjVb7aR7/6bd
	c9d0UrxsXBJkdTI4wbRq9dDcMf4UUe4O5F+0ju4ji1ohGNuZaGbJW0aEYu7J9hE=
X-Google-Smtp-Source: AGHT+IElUFan01DMTcKq7mpLuQEXv/M6ZjDhhp1pW7v7cPBwp502ELftTLKlJV+xiDuinHxlNWw0zA==
X-Received: by 2002:a05:6358:520d:b0:17f:1d34:6253 with SMTP id b13-20020a056358520d00b0017f1d346253mr268628rwa.15.1711515063614;
        Tue, 26 Mar 2024 21:51:03 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e31-20020a63501f000000b005e4666261besm8351500pgb.50.2024.03.26.21.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:51:02 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 13/13] riscv: mm: Always use an ASID to flush mm contexts
Date: Tue, 26 Mar 2024 21:49:54 -0700
Message-ID: <20240327045035.368512-14-samuel.holland@sifive.com>
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

Even if multiple ASIDs are not supported, using the single-ASID variant
of the sfence.vma instruction preserves TLB entries for global (kernel)
pages. So it is always more efficient to use the single-ASID code path.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v5)

Changes in v5:
 - Leave use_asid_allocator declared in asm/mmu_context.h

Changes in v4:
 - There is now only one copy of __flush_tlb_range()

Changes in v2:
 - Update both copies of __flush_tlb_range()

 arch/riscv/mm/tlbflush.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 35266dd9a9a2..44e7ed4e194f 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -109,8 +109,7 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
 
 static inline unsigned long get_mm_asid(struct mm_struct *mm)
 {
-	return static_branch_unlikely(&use_asid_allocator) ?
-			cntx2asid(atomic_long_read(&mm->context.id)) : FLUSH_TLB_NO_ASID;
+	return cntx2asid(atomic_long_read(&mm->context.id));
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
-- 
2.43.1


