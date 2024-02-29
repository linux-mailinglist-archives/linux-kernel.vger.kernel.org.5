Return-Path: <linux-kernel+bounces-87676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4413886D7A6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FC228396E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83BD1428E5;
	Thu, 29 Feb 2024 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Y5PTzjo+"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BE0134419
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248939; cv=none; b=Wa1WgqfhA6Vaq9QTDppjnhXSjIqyYRrkCHMRyB3+xyDhraN/iVby9tnYupJ30ClTgQfPG2dYt2BtqKBu2kQoCV2fQos69o8g6yAF136fxeQZpWpBd5slq7u52b26LUHr3uZ6d4jhpFoUKIA+yQuzRrv6e61bWk+yn/LFcS6MB/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248939; c=relaxed/simple;
	bh=+FVwMSfaHr0vNyET+wjjwD1Kp9smtCmocHiX0IEwmbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJokqbcm9pH5w3H3hYJ2QUGY88hW5Mj7YM/A6EJqgDAUg7IOWtzrRfFM/HFZZtF8jOfLZCFjU7JIHE/LczCp3pLLArLEU27MB2KxXwLonHd+zpYvGhtMDbR50jJ/DXBhi8wAgSe8Yp0ef1+vsirCrzWrYr6VExI6vuDSEOW4QrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Y5PTzjo+; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e571666829so1039247b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709248937; x=1709853737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/3iO4NfkALka4Buc8Img0QDYdUTnf5/4SNG0fcN5rQ=;
        b=Y5PTzjo+xBUgRjntIDSAgAbd24KT29iEbqMGCCLRMTr35b1b3rLtcOwWzYC1SUMGMI
         X6vxlEWAr2F+jpllNu/1xe2pqgPqZQc3lYoTEGfTj/ocdYencX2QG9so2pRU3rXDGly8
         UJsBav/WBvbvCwFFUs+d/2J4TOT5MADKnsqkGN4XjmnmrDYmE1q8xxBJ360dAZsxXcLg
         D2HX4OmSFrfQthSrs7V6Hf4ChzrL75U2EuNPBX2lfoE8xKaagefK+YFeK+v+MLCSrOfq
         nXFDSnclrkt3oJ+YFhyA1wGvpwSjzDD9B+wQNpK/36sMScXN1C7leNHfz1dpUxzCIzJ5
         dKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248937; x=1709853737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/3iO4NfkALka4Buc8Img0QDYdUTnf5/4SNG0fcN5rQ=;
        b=beDnSaIJslE0SpK6II225n00JqQp3ChkrtBOCRPIRYNvV5uF3eFHCSdOp/QK9W8GA5
         xNyFDpHmmATMIMEZF0nIV+2lAAiqnnI3ckALXZXz9XMFwWG1Xa4txSZZbiaa2qEHLS9T
         zM/rem/a5t+ZqU58K8Pf2ryeseHAHB1+dF+b5nD4fLNJRyQ+z7Ia3II4YKRBgZe4VGeh
         3HdEJjkcwOteYxMNO7bstMYixoBhgtS/xhD+3aSlCfRx2Vhi6H3Z3pI0hvhH6nKJNtD9
         sZgvXl0BXZn3zQV4z1srig/RJ81p5BCBxS8/y+x2c48rENauIew7gBTBU6UoaSwGQRoI
         8RXQ==
X-Gm-Message-State: AOJu0Yz1RtM8T4iojcH541GjTslcQI2AJUM0VHQwAH8F+SsSJ/548Jjo
	bYTuqY+Z2bYoPg7/svz6ZmJWYYWfC5dHESz/0r2nmdRX9YU8a2NcHRIciy8NCgo=
X-Google-Smtp-Source: AGHT+IHEWuHXVZ/LoNCuQjq9ikFwqlpYM8ivEnjNJqMVh5lQ2hbDE0NnP51hssPDjMbEUOy86+sdSg==
X-Received: by 2002:a05:6a00:14cf:b0:6e5:a996:5201 with SMTP id w15-20020a056a0014cf00b006e5a9965201mr172471pfu.10.1709248937282;
        Thu, 29 Feb 2024 15:22:17 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e55aa75d6csm1779719pfo.122.2024.02.29.15.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:22:16 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 04/13] riscv: mm: Broadcast kernel TLB flushes only when needed
Date: Thu, 29 Feb 2024 15:21:45 -0800
Message-ID: <20240229232211.161961-5-samuel.holland@sifive.com>
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
index 0373661bd1c4..8cdb082f00ca 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -102,22 +102,15 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
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
@@ -131,8 +124,7 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
 		on_each_cpu_mask(cmask, __ipi_flush_tlb_range_asid, &ftd, 1);
 	}
 
-	if (cmask != cpu_online_mask)
-		put_cpu();
+	put_cpu();
 }
 
 static inline unsigned long get_mm_asid(struct mm_struct *mm)
-- 
2.43.1


