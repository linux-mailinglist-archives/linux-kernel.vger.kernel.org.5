Return-Path: <linux-kernel+bounces-87685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6204686D7B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E9AEB22648
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DF614BD51;
	Thu, 29 Feb 2024 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="e+Pa+A3E"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C86145679
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248948; cv=none; b=Ux4QAhlHH5KYasppMubXsEr/CSnwVUOH7Is/ROQwm8ocKfFVKsSK5iedN1EOw7qvEITTeS2Lhefx9cfPTkf5Ub8nVyaumVOudax+dMgK8uDfRuDupatIkqwBxZyAyCZlc+OzmVKNw+Xeddsxa1sy8pqLR9gRurh0APNz2mWgBwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248948; c=relaxed/simple;
	bh=iR1wf5c+BMYzI7Dk7MIElBjHFZAAvj9ByRRGMTXW5IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhXNJqvUQtp5NTnVOX4R5APkVJb/zANiHAVK5NSu3RGD0JNXT5yZ7WEcWDiNqDBOrUTG5rL7k/Vl04/oKdkfrDVIdhrFIQiF0zm/A1zRPuXsVrttmYA317KeoHgQ+3GpTyyQTqx5UgYuntEq+MybzqqdApucU2xWFt9mkZToqAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=e+Pa+A3E; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e5a232fe80so701516b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709248947; x=1709853747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJvv9umwOkXOwc0iOvLk+NQYD7Mm5kACvwQaK1YGZP0=;
        b=e+Pa+A3EB/w6kupfp9BgaUqZShW6EPMpsncIOTv/l1dVOxtBqjGKlDsQBm7MtnR1JN
         4SnYfrzns3hITSjfawED+HzdC3tP9fKxIm5ZueckFyxVNHvZRjZOJMakDv7iJfyG3qZ3
         Qh9q5QeXaJYeWlqTI+yVedi05TUrmreisshxgKOtl1CQ7fJTZu3o88tEunmZDptSRhrX
         +E4LgwjC0O7SBMY5bEf+4imc8HWHDz9HUx1jiD9IIQxxHixE0rmHa5tGHAxVBHdKwPun
         1ndp8tpgfVlzt4dRo+6bprH5MRxPu5n6GCbiL71RqlY8+GSGc+y/9BTIm0+hG06Cf0Zo
         xnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248947; x=1709853747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJvv9umwOkXOwc0iOvLk+NQYD7Mm5kACvwQaK1YGZP0=;
        b=pFmcP/27HCLSFFPYW8C405ju4v+p4GkhfFlh0+i+hXrqtsiKcgpno4gu6GfGtHbJik
         ehEJRzbM4PLKt7FFzSgfK8OvrlejNU+24KGTKseEZnzBQxbSyXbTaAJKvp3y4SrqFqCZ
         nr3j4pfSm7NkdikHM9HjJ/Af4AIhNDbMGLmNdqhjeKtbygmMl96FRbRrswgIoTyPNM74
         zyE+j+mKCVwuDBJjjF9VgV5jog0K7ouegYdcBR+OUSazihlT9/IRddtsQoJ1M1WfuQ9V
         omT/PUSqxSWZJh2Rv3L613yxwDz9Av3FzL+URfKH74fDHI6vZTwxPg+cLdYEG1MYlWQb
         Iz1w==
X-Gm-Message-State: AOJu0YwEvz5XD8MHpgwF7NE6PHrGj2IKXANt4L0g8NaqL/IAAmXFyMzJ
	D4rSFuQpXUSbUYHvMUnZIQDC8sJSMML+98nnWQCfa4bNM1m8Zf8jl+VY3dXTh4M=
X-Google-Smtp-Source: AGHT+IG000bMn11OdL3LH1zGovTy9Qg+UUgYE8CMrW4h6bNv2nzitQBp1dzsEHx4shrcmNE8zaAVpw==
X-Received: by 2002:a05:6a00:27a3:b0:6e5:3dea:bf51 with SMTP id bd35-20020a056a0027a300b006e53deabf51mr562992pfb.7.1709248946831;
        Thu, 29 Feb 2024 15:22:26 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e55aa75d6csm1779719pfo.122.2024.02.29.15.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:22:26 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 13/13] riscv: mm: Always use an ASID to flush mm contexts
Date: Thu, 29 Feb 2024 15:21:54 -0800
Message-ID: <20240229232211.161961-14-samuel.holland@sifive.com>
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

Even if multiple ASIDs are not supported, using the single-ASID variant
of the sfence.vma instruction preserves TLB entries for global (kernel)
pages. So it is always more efficient to use the single-ASID code path.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v5:
 - Leave use_asid_allocator declared in asm/mmu_context.h

Changes in v4:
 - There is now only one copy of __flush_tlb_range()

Changes in v2:
 - Update both copies of __flush_tlb_range()

 arch/riscv/mm/tlbflush.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index e194e14e5b2b..5b473588a985 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -108,8 +108,7 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
 
 static inline unsigned long get_mm_asid(struct mm_struct *mm)
 {
-	return static_branch_unlikely(&use_asid_allocator) ?
-			cntx2asid(atomic_long_read(&mm->context.id)) : FLUSH_TLB_NO_ASID;
+	return cntx2asid(atomic_long_read(&mm->context.id));
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
-- 
2.43.1


