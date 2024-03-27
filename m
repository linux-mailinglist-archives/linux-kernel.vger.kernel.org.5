Return-Path: <linux-kernel+bounces-120307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4488988D58F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 564A3B2307A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5886C175AA;
	Wed, 27 Mar 2024 04:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ivDqwdIa"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193DD1172C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 04:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711515048; cv=none; b=KctcYKumxOnH+084tZ1DneRkJ258XFsnWeqmC94kHJMBtKoDahgk9xdbYgNU9nN7DNp/kZiMxqVK5bPkT4+1XzTWqPwBnb8n4dsOaMzR0aJk9SeSEYy1PKkU1EN0CZF8/SdUxrkBH5DIegadf6gMNK+4AjKE9jrIXodaDlBx0PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711515048; c=relaxed/simple;
	bh=R5LG+o542v8AgH1AF2U8/WvJmQDWsmGeEqymqdAXiWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egTOt/aKAoRKlrbK9wrIXMBppY+J1cKNHZvsDLmGL11t8Ar8RWyKdWv1anPk1NeZsd92p/jgoe6YR6CXkIi5mm0pkB93fYL2IwzU8Hj1X4vGe/yE7XcbRwvmmHOt/aJP+CXK9kJ6L8GS701DzpJBypG3sN+BGYW4UFzBQQySfkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ivDqwdIa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ea9a605ca7so381411b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711515046; x=1712119846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fwmOl0CxtBfQxlaR9NQyd7IGBnsfsK+MLDyKM1aSvU=;
        b=ivDqwdIaeIS4u4I3npdDBQdffMhJJQeh20WWT6pm0Q4PdS9Cs0oJ48UhUZlmj7Rd3P
         fKN8HAdCH7xJAl7EqUivq5maekwcBzMV1CRmt0h9/A2i694iV6m6i59gotVv+LZQerJ+
         8fGlwFvAm0JuGVnzxRsF57Bunob2b5RhdAdQyvyat2qcU1pfgsc6tFdMaYkp5Tg7JyiC
         6QFK+X+qzhSF+8KQa998g8UCBymSwfGaDUw3zK2kVJQHsmE3nc9yeY5EAfeVhGPIFV/6
         pjxqFhY4fCy1HOd5HBduDHIbFGROdvqKjb6dt4YN5KxgBbLv9Yz3qTsKM2HdmOGvdeV3
         h9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711515046; x=1712119846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fwmOl0CxtBfQxlaR9NQyd7IGBnsfsK+MLDyKM1aSvU=;
        b=HnBirnpU2Xf2gTZC6udruUNWc36K2zI3M646JOIYn82hF0oVLPECJDQrBX56/+Xyfb
         ZK07Ck9qfAkRZI9llM42jdnE+/s6L7YQBPLWf0R3ktRyajqRXfAjX5Tu1DXdDxhtXY4s
         zE0s4JYIkTId3Uhq/pK5G3jzzy+AsFlu1mYCS3laCeYu3j9jfjLI1n+IMNTrttvTisUF
         B+V648mebULeznRKw9iKXea8NYt6GbazCZ3CWTgOLaITVQ/aVrCxlvPTstoSzOe3FV1S
         oPz3dEjF1IpQlDPEQl9tgB1sDSKivPw+4z/MKYHQ3WEWCdocn5MAUxOFVXjaVax+S20a
         Dhqw==
X-Gm-Message-State: AOJu0Yzd2Tej93u/CjKWksCgy5neNBh6FE8eS3m3DJ61vx/4QwpeohZA
	gb1R9NU5f+TEV49N8Y/OmwL8HDQ24OYMigQqUJ89/sxZQ0+HIEk48lc70nnMhTA=
X-Google-Smtp-Source: AGHT+IGHAmpkwghveoQCxqBYVJp1RVR15SSZ2ypXvD8LXUp94lm0FkTd5l29fFm2kWdFZwCld1auyw==
X-Received: by 2002:a05:6a20:3d11:b0:1a3:6a11:4898 with SMTP id y17-20020a056a203d1100b001a36a114898mr4924839pzi.3.1711515046438;
        Tue, 26 Mar 2024 21:50:46 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id e31-20020a63501f000000b005e4666261besm8351500pgb.50.2024.03.26.21.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 21:50:45 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v6 04/13] riscv: mm: Broadcast kernel TLB flushes only when needed
Date: Tue, 26 Mar 2024 21:49:45 -0700
Message-ID: <20240327045035.368512-5-samuel.holland@sifive.com>
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

__flush_tlb_range() avoids broadcasting TLB flushes when an mm context
is only active on the local CPU. Apply this same optimization to TLB
flushes of kernel memory when only one CPU is online. This check can be
constant-folded when SMP is disabled.

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v4)

Changes in v4:
 - New patch for v4

 arch/riscv/mm/tlbflush.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 0435605b07d0..da821315d43e 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -103,22 +103,15 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
 			      unsigned long start, unsigned long size,
 			      unsigned long stride)
 {
-	bool broadcast;
+	unsigned int cpu;
 
 	if (cpumask_empty(cmask))
 		return;
 
-	if (cmask != cpu_online_mask) {
-		unsigned int cpuid;
+	cpu = get_cpu();
 
-		cpuid = get_cpu();
-		/* check if the tlbflush needs to be sent to other CPUs */
-		broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
-	} else {
-		broadcast = true;
-	}
-
-	if (!broadcast) {
+	/* Check if the TLB flush needs to be sent to other CPUs. */
+	if (cpumask_any_but(cmask, cpu) >= nr_cpu_ids) {
 		local_flush_tlb_range_asid(start, size, stride, asid);
 	} else if (riscv_use_sbi_for_rfence()) {
 		sbi_remote_sfence_vma_asid(cmask, start, size, asid);
@@ -132,8 +125,7 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
 		on_each_cpu_mask(cmask, __ipi_flush_tlb_range_asid, &ftd, 1);
 	}
 
-	if (cmask != cpu_online_mask)
-		put_cpu();
+	put_cpu();
 }
 
 static inline unsigned long get_mm_asid(struct mm_struct *mm)
-- 
2.43.1


