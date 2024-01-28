Return-Path: <linux-kernel+bounces-41608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AE683F551
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A8D1C20EFD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55431208D5;
	Sun, 28 Jan 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vPPifL+Z"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928F1200DB
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706443452; cv=none; b=DaggzDMNkLT0AraG3+T9sZjXhfKwxoRHuZ8A4kufENLecfSPWoxg8sGjXJBhn5dgS2AxTb+y9NOZc6L+0jDn5H/c1EVcwl4qBLVjU5eLke7enh39fT410Q1cgMhqnyAamgcZLPoO4mdNVCjMeMP/zuoSEJXifpz7XO5vB4NPQOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706443452; c=relaxed/simple;
	bh=VzbpvU0e9JzomL+t0EfKfndh1+wTmCO5Ucl/AxnJG3c=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=s9u9RQGg/ZDo9GjYvVkSO3symqBPWDWcSC1qbTueAi9aQMmLuHg0OrcVn4vHXISOjKkDO16oIvyOqv+f7HSuD1nqOshtdKOd5lfg/vXrlSzw+lDRFNW1DzeDH/68tKLtcTZVW5KIwHpGOzcPsUjQzufbK05sjdD8paLCwLvvMh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vPPifL+Z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e7065b7bdso31119995e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 04:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706443448; x=1707048248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HxcAjPK0N066N6P8kFzyYPkzX8zdfJo2IeOhtls9JxI=;
        b=vPPifL+ZE0VnjQmk0/32mFDkxFYKVKSSsiwVCkjTYKnHq1HKo7SZ5DrjSy2/4GAJmA
         z/vxC0TPfNyadqZlpWQCgbtO8UZzK1n4FJ5KGlKHOFLoj4OyuEULt614HiX880SlejW7
         mwP7gjQMesUhvMio0uovydAFOBv1U2/EAs5MEnKV/9yTVokBiApC36VrzIxNjB2T4VZE
         BhKBIJOVDdewpljAYXef9buWAffFPcO5XxndYon3+iFSsxboImOLNkRlcR6kWzaXD2iY
         YmMxwm2ZjAuhltu8YmVSmgwT+Sw1ijVrugZUCtJhOEu9XuBka+mLwrVsQcGr1W1zfPRC
         aQcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706443448; x=1707048248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HxcAjPK0N066N6P8kFzyYPkzX8zdfJo2IeOhtls9JxI=;
        b=ZIZsodKs80i5ayrFbE1Eq6v1bI6iLHOz8hUiJw+iZ4S5eZLBuH7BWcywJGpj9iPnfM
         RCC8ay5OMKIxVUEuiqCe7XfMRSDXzprx+pHPn69wUQKoKP477IVcG9gRV74JQgSwhr1V
         izCRY2FrFu9bA1EaJLv7e4cFgc30m5Yf1GOS3BNttHb44vNTXnBwx2unfk8DbHmLSPvu
         TlM7C9IJZPTeQV1SDc3077a7NHfF7vHcBTbG2xMqYPAweHQuil8m6Ao4xHGkTV7Y+Kv/
         XhqsOypFJgO6IqDfMxcPCjeyCMD6i8Y5zaF5cStgIDjt5dCcz3fhnAH2c8AdLPf+IuY4
         7naw==
X-Gm-Message-State: AOJu0YwS2yzMlM+NXE+2DT9Ddo0UycJYqhOv70B6NPATuaaqEmtL8vfg
	lbT+kIYDUo8J8dd0DRZlHkbWUf5RqVrAokaiQMNiF1QW6phK7AGN2Q3j9l3248k=
X-Google-Smtp-Source: AGHT+IGp9QOplulvd/Y9t4bqyDTHP2SEbLG4SLRuZKPDPzRKkEqnxw5vDg9O8Y6f+J4FCQikbsMYxA==
X-Received: by 2002:a05:600c:34c4:b0:40e:ee82:18 with SMTP id d4-20020a05600c34c400b0040eee820018mr1937031wmq.14.1706443447739;
        Sun, 28 Jan 2024 04:04:07 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c4f5000b0040eee561e4dsm3859911wmq.41.2024.01.28.04.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 04:04:07 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH -fixes] riscv: Flush the tlb when a page directory is freed
Date: Sun, 28 Jan 2024 13:04:05 +0100
Message-Id: <20240128120405.25876-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The riscv privileged specification mandates to flush the TLB whenever a
page directory is modified, so add that to tlb_flush().

Fixes: c5e9b2c2ae82 ("riscv: Improve tlb_flush()")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/tlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
index 1eb5682b2af6..50b63b5c15bd 100644
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -16,7 +16,7 @@ static void tlb_flush(struct mmu_gather *tlb);
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 #ifdef CONFIG_MMU
-	if (tlb->fullmm || tlb->need_flush_all)
+	if (tlb->fullmm || tlb->need_flush_all || tlb->freed_tables)
 		flush_tlb_mm(tlb->mm);
 	else
 		flush_tlb_mm_range(tlb->mm, tlb->start, tlb->end,
-- 
2.39.2


