Return-Path: <linux-kernel+bounces-14913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B72982246E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291B91F23801
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FD118E23;
	Tue,  2 Jan 2024 22:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AGqNsbmM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B04C18C13
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28c7c9b19f1so2514434a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 14:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1704232900; x=1704837700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA8TOHyyeKTc95PFXJRpYatfRR5oPHMuobG+iziT3HE=;
        b=AGqNsbmMnp9vjyebsFChQjy7nWz6SWLDLP0QAiuNu27kO49irRUptsDDwu9E5V9Ket
         xvodU/gGJFv9vP5cV6Q8RA8C4/ZF7/VZCDCtJQBuiyuuiJ4ia418Kc4zam429n8/ofuS
         Uo4UFXB4eRCJsditxh58ECPJ53zpK0LjtIA1qftThpO0uq2LhqaLAgJjWjzzkUlH9NmS
         3hbJTa8CZsVqH4yce8yvbbnq0iYoVoCBRNG3qqBh9fSl22ovicWKevmCdZu8bx5sSLCU
         OmkkQy20Jb0DsOTi5CKI0zsCgdq/J983tSNp8xKiwyEAaignZWNbTGCJ2zZ1fv9T5cu3
         jclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704232900; x=1704837700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA8TOHyyeKTc95PFXJRpYatfRR5oPHMuobG+iziT3HE=;
        b=V4td4ENHyyYtcM+wxiSEEbRhkVd9kzd4wISlCEKoeyA8vlg5iLFOFrreiGA8lLZ2LE
         3O4S/e+3Em/tuoUbqJ5SHZKPIk7iOeV55uiRa0zwdoD6TbSl2xNY5MBf/Ny4tjDHJ/43
         qpAiTu5mdeL89kXl556Zg38xKoTVpQWOa7E7kX6YkCvC6yezt2zvubyeSbuEQfkn7wA6
         udWT1JyiiF63FG99pVHwz4tfAdm828O3c7JV7QXgG/sxvFj6J6GHFxx6CCXbJTsYshFq
         jy5G75HSowy9vKM+omj61B0LtBoOuWOBMSwhJO7jfb7WAMxtWXxWFVRZXEf8rmsHDVH0
         8N2A==
X-Gm-Message-State: AOJu0YyDVgS/6Foj946cMGA17geeGxh7FA1lraLhsxHPWaPJukZcZ0JT
	b78N1xOwbYvLuELqWHf99NR/48hHHDkNRQ==
X-Google-Smtp-Source: AGHT+IGXoPWHR5PafwwvCfsK03qnPYeIgtaQPhGwO0vZvHcHemW0jssRCcGF3figFCmbRtQxmnrgGQ==
X-Received: by 2002:a17:90a:974c:b0:28c:accc:b1db with SMTP id i12-20020a17090a974c00b0028cacccb1dbmr2272863pjw.44.1704232900428;
        Tue, 02 Jan 2024 14:01:40 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id r59-20020a17090a43c100b0028ce507cd7dsm101724pjg.55.2024.01.02.14.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:01:40 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 03/12] riscv: mm: Broadcast kernel TLB flushes only when needed
Date: Tue,  2 Jan 2024 14:00:40 -0800
Message-ID: <20240102220134.3229156-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240102220134.3229156-1-samuel.holland@sifive.com>
References: <20240102220134.3229156-1-samuel.holland@sifive.com>
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

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - New patch for v4

 arch/riscv/mm/tlbflush.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 09b03bf71e6a..2f18fe6fc4f3 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -98,27 +98,23 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 {
 	const struct cpumask *cmask;
 	unsigned long asid = FLUSH_TLB_NO_ASID;
-	bool broadcast;
+	unsigned int cpu;
 
 	if (mm) {
-		unsigned int cpuid;
-
 		cmask = mm_cpumask(mm);
 		if (cpumask_empty(cmask))
 			return;
 
-		cpuid = get_cpu();
-		/* check if the tlbflush needs to be sent to other CPUs */
-		broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
-
 		if (static_branch_unlikely(&use_asid_allocator))
 			asid = atomic_long_read(&mm->context.id) & asid_mask;
 	} else {
 		cmask = cpu_online_mask;
-		broadcast = true;
 	}
 
-	if (!broadcast) {
+	cpu = get_cpu();
+
+	/* Check if the TLB flush needs to be sent to other CPUs. */
+	if (cpumask_any_but(cmask, cpu) >= nr_cpu_ids) {
 		local_flush_tlb_range_asid(start, size, stride, asid);
 	} else if (riscv_use_sbi_for_rfence()) {
 		sbi_remote_sfence_vma_asid(cmask, start, size, asid);
@@ -132,8 +128,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 		on_each_cpu_mask(cmask, __ipi_flush_tlb_range_asid, &ftd, 1);
 	}
 
-	if (mm)
-		put_cpu();
+	put_cpu();
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
-- 
2.42.0


