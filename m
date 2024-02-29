Return-Path: <linux-kernel+bounces-87679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8D886D7AA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10521C21595
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F170144043;
	Thu, 29 Feb 2024 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="k6LDVrnp"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7766B143720
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248943; cv=none; b=s5QBXL9PgzljNNAjLlL6RkCPmuniqwz/0Ze+tGqJ3rqy40wzB79A2lEeXOCpx9wxjMFXibUKC5cfS3A/VXtoI2dVjWepzlswSOKYiWzOiBEqCG7rPXrPh0jxdlpo289LJE6OEgxVZvOwICc6hGhb1bjh9KY/vZk8xAqU+mYR1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248943; c=relaxed/simple;
	bh=mxWZWiyysmkBFHfNnHhHfYVQO5Mh4OcNRTXlF0LxGbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2P+EoqVJrYGq6yDFbSNJNYUxnbRlXu/y9q6F5JPWuy/2j2AJFQ5IA5WuAd+5haam40ueXJ7HwR2cF6CsqKz1iv+O0NkS+4jOChaY5rVoCNlq5Mp8Xrd/z35ev4JtItJV40lwWpjX/d3h0vCUL7eGI5z4PcBpsjhLrcrbyHKMZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=k6LDVrnp; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e49812ba77so722927a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709248940; x=1709853740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jEC1X5CZdJa4ryFg9hWmhSsIovSPBi+ZbblNH/6mwk=;
        b=k6LDVrnpThZ8kscB1/zh8r7zr/HU+vP/rlweyGAIXTA+x6BUdHnjrbbqh3Fg0TRtbt
         4U0JGHQlI7Q1yv9VsJ/Xjn0KK4NIA3o3x6IXPLwhUf3mFyj5scNI3EmajkuGgWHX6xU8
         jy1XOcrTDFHK+Ma0fG+gNobfVutCHNMcaUyBTBJUpqzTBtrquZXZIzMeumznZZZurM6d
         ISK+cjUeFvHEgjCV6oISSwnznccB6ovGfNcMgVKPLdOTFwqvoMa1ql4PpfMxC+lixQiP
         VpVjYNfHcm+TuakQlNtv6n6che7Y1vjG9nkH7zrKrTxBn7PmjxbUPB8wF+pcXYoCHhIn
         q22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709248940; x=1709853740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jEC1X5CZdJa4ryFg9hWmhSsIovSPBi+ZbblNH/6mwk=;
        b=EPPtPxhAvBA+lTAFirFw+VIOFxwAS6BrFp3lzAWPItbTUCsjog07P6f7SQD60hctED
         1sV53uMTPy/PErDH9QJ3qQeOdJ4MpXNtQgCHDkRBZJkCwOLR74UAzsemh9OhA6L29WWr
         RsvdoIfDioMk1FJ9LVl6m4EyKyvKcWw6FrftQgeg0YXXvkGNc7h2d7hb/j4dV6w7xKzp
         EWD474IyJT2ocLq/uZkcm1jJ9IWwB7EjX7pDNIB+Fdh0yTTxDregPGckzzk6amf6iCyW
         oPE/CdmO48GsIFkFgPuwiCt59c7R1v+IyieFc+/Ohhy7vr/IZfWtoz5k4zqjgBr2ZvZA
         dLsQ==
X-Gm-Message-State: AOJu0YwEB6dY0OyVoGSVBDEoyq++Lpv8//lIdB/7dAPy9mKclg/QPQfL
	2ZX9pROTUBDJcckafLKTgNECVT6O+hxVj7IX627dPA5uj4AWDc3xti8RAdZUvDo=
X-Google-Smtp-Source: AGHT+IGX4/HV5W58fetZh8Yw57gYr75gd/4aFWyaezvIp/BsV5LakI2yn+mW+sbVnuOSeLnU1moubA==
X-Received: by 2002:a05:6870:ac22:b0:21e:dd7a:2d3e with SMTP id kw34-20020a056870ac2200b0021edd7a2d3emr4104469oab.22.1709248940592;
        Thu, 29 Feb 2024 15:22:20 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id c6-20020aa78806000000b006e55aa75d6csm1779719pfo.122.2024.02.29.15.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 15:22:20 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 07/13] riscv: Apply SiFive CIP-1200 workaround to single-ASID sfence.vma
Date: Thu, 29 Feb 2024 15:21:48 -0800
Message-ID: <20240229232211.161961-8-samuel.holland@sifive.com>
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

commit 3f1e782998cd ("riscv: add ASID-based tlbflushing methods") added
calls to the sfence.vma instruction with rs2 != x0. These single-ASID
instruction variants are also affected by SiFive errata CIP-1200.

Until now, the errata workaround was not needed for the single-ASID
sfence.vma variants, because they were only used when the ASID allocator
was enabled, and the affected SiFive platforms do not support multiple
ASIDs. However, we are going to start using those sfence.vma variants
regardless of ASID support, so now we need alternatives covering them.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - Rebase on Alexandre's "riscv: tlb flush improvements" series v5

 arch/riscv/include/asm/errata_list.h | 12 +++++++++++-
 arch/riscv/include/asm/tlbflush.h    | 19 ++++++++++++++++++-
 arch/riscv/mm/tlbflush.c             | 23 -----------------------
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index ea33288f8a25..6e2762101968 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -43,11 +43,21 @@ ALTERNATIVE(__stringify(RISCV_PTR do_page_fault),			\
 	    CONFIG_ERRATA_SIFIVE_CIP_453)
 #else /* !__ASSEMBLY__ */
 
-#define ALT_FLUSH_TLB_PAGE(x)						\
+#define ALT_SFENCE_VMA_ASID(asid)					\
+asm(ALTERNATIVE("sfence.vma x0, %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
+		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
+		: : "r" (asid) : "memory")
+
+#define ALT_SFENCE_VMA_ADDR(addr)					\
 asm(ALTERNATIVE("sfence.vma %0", "sfence.vma", SIFIVE_VENDOR_ID,	\
 		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
 		: : "r" (addr) : "memory")
 
+#define ALT_SFENCE_VMA_ADDR_ASID(addr, asid)				\
+asm(ALTERNATIVE("sfence.vma %0, %1", "sfence.vma", SIFIVE_VENDOR_ID,	\
+		ERRATA_SIFIVE_CIP_1200, CONFIG_ERRATA_SIFIVE_CIP_1200)	\
+		: : "r" (addr), "r" (asid) : "memory")
+
 /*
  * _val is marked as "will be overwritten", so need to set it to 0
  * in the default case.
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 4f86424b1ba5..463b615d7728 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -22,10 +22,27 @@ static inline void local_flush_tlb_all(void)
 	__asm__ __volatile__ ("sfence.vma" : : : "memory");
 }
 
+static inline void local_flush_tlb_all_asid(unsigned long asid)
+{
+	if (asid != FLUSH_TLB_NO_ASID)
+		ALT_SFENCE_VMA_ASID(asid);
+	else
+		local_flush_tlb_all();
+}
+
 /* Flush one page from local TLB */
 static inline void local_flush_tlb_page(unsigned long addr)
 {
-	ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
+	ALT_SFENCE_VMA_ADDR(addr);
+}
+
+static inline void local_flush_tlb_page_asid(unsigned long addr,
+					     unsigned long asid)
+{
+	if (asid != FLUSH_TLB_NO_ASID)
+		ALT_SFENCE_VMA_ADDR_ASID(addr, asid);
+	else
+		local_flush_tlb_page(addr);
 }
 
 void flush_tlb_all(void);
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 69402c260a89..365e0a0e4725 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -7,29 +7,6 @@
 #include <asm/sbi.h>
 #include <asm/mmu_context.h>
 
-static inline void local_flush_tlb_all_asid(unsigned long asid)
-{
-	if (asid != FLUSH_TLB_NO_ASID)
-		__asm__ __volatile__ ("sfence.vma x0, %0"
-				:
-				: "r" (asid)
-				: "memory");
-	else
-		local_flush_tlb_all();
-}
-
-static inline void local_flush_tlb_page_asid(unsigned long addr,
-		unsigned long asid)
-{
-	if (asid != FLUSH_TLB_NO_ASID)
-		__asm__ __volatile__ ("sfence.vma %0, %1"
-				:
-				: "r" (addr), "r" (asid)
-				: "memory");
-	else
-		local_flush_tlb_page(addr);
-}
-
 /*
  * Flush entire TLB if number of entries to be flushed is greater
  * than the threshold below.
-- 
2.43.1


