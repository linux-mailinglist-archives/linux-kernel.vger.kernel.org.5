Return-Path: <linux-kernel+bounces-89072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A553986EA32
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44F41B25B6B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DB53C470;
	Fri,  1 Mar 2024 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PeJnQ3S0"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606503C464
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324321; cv=none; b=QR2jfiTWLPI55W5uMYUGKXJgr46Mhw857jr84St2l5Nr2+aKGtxmdECHblWXfQdSFfIT1Zg/jZNkTRg3B3ay+87/K+ejuzo4IToa+1dkiBrmawgjpofwlO2eudJ9f4G0zfjlttKAIiM45bmG4ki0OTcI9UWVKqCwUWb+nxNyJu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324321; c=relaxed/simple;
	bh=k8PnfdLlrbJCNs/j0R+9nMvSzfWV60dq0lhAeS4WAR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cu9WEC+WUCxF+ztffRvd+DX3qEwNd1VcJEGSqbUIkM3HR8d1q53oX8cwxxYm8QVhzdq/0FA+5wrnTE7gul8qg8uyHo4PILggTJo92QQwD/a6Ge8RvLGqjPnRVuDmzOBhglzicet/8QTq2C5bjNShuuoNH/Zm6RF7RE2P/1VZmlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PeJnQ3S0; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e55731af5cso2094463b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 12:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709324318; x=1709929118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LB21/Ow/29CKfiD0k0+EGFc0FZT6nL4Wg3LThQF2Bvw=;
        b=PeJnQ3S0o6RiGQL2xjKg4U90kpuGk+8+VJ6wzwg2FyH0e3sgN37MPcyHlh0hNaBMhq
         lO/U3rHJ1+QxwYpp9Nykh8oKldkt2TWBSQjH4FUuhrhVz6J/RTOAwy+5HaDahQHqd7aP
         9xs4lzZsfknAIOwRu4eQVAI3GXf1KZFtcgD+cdfJso2z3ZVjCL0T5+DWNWd5lCxxO6O2
         fbVYG9TmBBQDE2+xV0mvUaEP4Apw9/YRv8jwqKnYj86tz8maIRPJfhTVFpY0Pg9RnUg3
         MaYCsAeq0n9fLldxxyTuNeJd66IGkPKy/NU3dw21dUQCgjQhWE+1lxX3mVLAy4bDWqly
         RCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709324318; x=1709929118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LB21/Ow/29CKfiD0k0+EGFc0FZT6nL4Wg3LThQF2Bvw=;
        b=IZBGTfcujdvhsrWN4H45R+JKmGpvwcfxfNE4SYd/jaYhuAo+6taWIfBptozK9AW3uI
         qC0Jt9n9Q7gMx3uPzz++91dYUXMFVzXtmwI05J0Nx2w3H/5l7jOSaBTspUjteU7v96eq
         ufW3O1TWltNolSXK94bc8XjsghgDNTAaIfeBrqeBLhyeLcnM1Efupb+5gbrUOxatWjci
         3JhA1tNWV1H/65pwQpBcVr7vIYHKMoIa3hvvwDjnADKwlRNH1HrGke9QT8W2UjrEQlBL
         20YJ0ulo94c+TUN5HsbdMuSQyKWfb2fUFh2/J1MMrOYXhO8t+uYtDFnat5ZMGRoCAsjN
         pIYg==
X-Forwarded-Encrypted: i=1; AJvYcCUbE7cf6/gqZ+bEH7TTGavVvoaHfARJBUQ7kLYzGsEkTAMpN0puLICnGOyroqqpQWLhEBqtmsIBY8bxW1Siy2x44cCnJI41JZ2XZZp0
X-Gm-Message-State: AOJu0YyMi0P0HFn/jmh6c7PMR5D5/4vPaA4Odur2rzPtciIany/QLJp+
	xR6Tm9Nv4RNBSklHipHy/JOqjOBLby598Xq1CH9bPb/eAYYZQmJp2JHAaABll1g=
X-Google-Smtp-Source: AGHT+IExvcW1+DuFlfwWmifCp/Y/jBPrieVmeDTXpbxoxgyVqpNwW9a77bIovFcPZGGfBE38pSzCvQ==
X-Received: by 2002:a05:6a00:27a0:b0:6e4:f49f:bc9 with SMTP id bd32-20020a056a0027a000b006e4f49f0bc9mr3133223pfb.20.1709324318705;
        Fri, 01 Mar 2024 12:18:38 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id p26-20020aa79e9a000000b006e59688b828sm3364071pfq.19.2024.03.01.12.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:18:38 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-riscv@lists.infradead.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Dylan Jhong <dylan@andestech.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sergey Matyukevich <sergey.matyukevich@syntacore.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: mm: Fix prototype to avoid discarding const
Date: Fri,  1 Mar 2024 12:18:32 -0800
Message-ID: <20240301201837.2826172-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__flush_tlb_range() does not modify the provided cpumask, so its cmask
parameter can be pointer-to-const. This avoids the unsafe cast of
cpu_online_mask.

Fixes: 54d7431af73e ("riscv: Add support for BATCHED_UNMAP_TLB_FLUSH")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/riscv/mm/tlbflush.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 893566e004b7..07d743f87b3f 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -99,7 +99,7 @@ static void __ipi_flush_tlb_range_asid(void *info)
 	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
 }
 
-static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
+static void __flush_tlb_range(const struct cpumask *cmask, unsigned long asid,
 			      unsigned long start, unsigned long size,
 			      unsigned long stride)
 {
@@ -200,7 +200,7 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	__flush_tlb_range((struct cpumask *)cpu_online_mask, FLUSH_TLB_NO_ASID,
+	__flush_tlb_range(cpu_online_mask, FLUSH_TLB_NO_ASID,
 			  start, end - start, PAGE_SIZE);
 }
 
-- 
2.43.1


