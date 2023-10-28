Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5337DAA24
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 01:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjJ1XOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 19:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjJ1XON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 19:14:13 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915571B1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc1ee2d8dfso17082325ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 16:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698534837; x=1699139637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYq2JBnvfDkZMtFq+gFMcak9lyRAM53Oqx2LdQZI3vI=;
        b=gEZkrP2YiX4vVYOeeXB7ZtljVqPEl/maZqiQL1ssgjFayGJpuXCPYIAqziTMfgAUzS
         3cBkzMHmea475AZSzmKa6imwcEd0EpMd+O/H0NS1DK2PP+WUYaIAfXDO1QHrBgtw6prn
         VxCIrw4o0+plAADTIUEwUv1J9UMKleFWxAhdm/S7tewX0RZSQ5PLZktGAhA1LSHuOyrN
         spKthjTJp1fwm/tZWO27TKIsK50Ffw4mjsyav8Q6AvPwxQY2OROMsfYXl3oaCQ+yrK/H
         6BG3AJropXRvA3ApD5tgRK8sin7gfPYSm3RCZgQ4V5ZV+IB102mTSXGruKeaAt4ZCeuT
         i/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698534837; x=1699139637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYq2JBnvfDkZMtFq+gFMcak9lyRAM53Oqx2LdQZI3vI=;
        b=jc3zzIS8B6/Yfyz7EihbRFYMlkBk0Uzk1toh8OWUyWbGU7iX9/u4KH7dFtOnJozK/4
         bMGT1c3t7P6oBur2rexjpJAcJF8OaRVq99InDDOMRZzpO6Qn45IyiIxhz/krgOdNm80a
         1PHShUxjbfGDmajtUCueV+d6PrYNBhsaDfT5Yy0UhU0W8RCJJVUrWpTSoyNAYT/50l6X
         fZl8OjriNSkvvHwpQNs/Au7ubchraRVDLFllKJFyBQDIO84YOuzL27CdeyQY//rJwf/D
         QojQBIwXsPq7mbmw70bTJxShB22iGGBlEX+mPJByaMzm2is6cQf1pilQ8wo6PNjUlI7E
         5K6Q==
X-Gm-Message-State: AOJu0Ywyio2vQL7ib9tlTaRBZ3m/IRRxFGFXtnPRlne8/gma1TSUC75A
        FsvUTu8tLnzIhjPA1JE7Q44A2g==
X-Google-Smtp-Source: AGHT+IHR5gJkl+2hmALdgeC6Mspb2OIhkdCFo9rAzDT7R89li8y2sxi8zbkov4fwyI0EL6o8dg+K/w==
X-Received: by 2002:a17:902:f542:b0:1c5:a7b7:291c with SMTP id h2-20020a170902f54200b001c5a7b7291cmr8203243plf.12.1698534836728;
        Sat, 28 Oct 2023 16:13:56 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001b8622c1ad2sm3679345ple.130.2023.10.28.16.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 16:13:56 -0700 (PDT)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v2 11/11] riscv: mm: Always use ASID to flush MM contexts
Date:   Sat, 28 Oct 2023 16:12:09 -0700
Message-ID: <20231028231339.3116618-12-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231028231339.3116618-1-samuel.holland@sifive.com>
References: <20231028231339.3116618-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if multiple ASIDs are not supported, using the single-ASID variant
of the sfence.vma instruction preserves TLB entries for global (kernel)
pages. So it is always most efficient to use the single-ASID code path.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Update both copies of __flush_tlb_range()

 arch/riscv/include/asm/mmu_context.h | 2 --
 arch/riscv/mm/context.c              | 3 +--
 arch/riscv/mm/tlbflush.c             | 5 ++---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 7030837adc1a..b0659413a080 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -33,8 +33,6 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
-DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
-
 #include <asm-generic/mmu_context.h>
 
 #endif /* _ASM_RISCV_MMU_CONTEXT_H */
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 3ca9b653df7d..20057085ab8a 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -18,8 +18,7 @@
 
 #ifdef CONFIG_MMU
 
-DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
-
+static DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
 static unsigned long num_asids;
 
 static atomic_long_t current_version;
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 1cfac683bda4..9d06a3e9d330 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -90,8 +90,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 		/* check if the tlbflush needs to be sent to other CPUs */
 		broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
 
-		if (static_branch_unlikely(&use_asid_allocator))
-			asid = cntx2asid(atomic_long_read(&mm->context.id));
+		asid = cntx2asid(atomic_long_read(&mm->context.id));
 	} else {
 		cmask = cpu_online_mask;
 		broadcast = true;
@@ -122,7 +121,7 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
 {
 	unsigned long asid = FLUSH_TLB_NO_ASID;
 
-	if (mm && static_branch_unlikely(&use_asid_allocator))
+	if (mm)
 		asid = cntx2asid(atomic_long_read(&mm->context.id));
 
 	local_flush_tlb_range_asid(start, size, stride, asid);
-- 
2.42.0

