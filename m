Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E679B7F3B04
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjKVBIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjKVBIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:08:25 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C9C199
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:21 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b709048f32so5533362b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700615301; x=1701220101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvpOAl9p0Aiam4sGuchXKDW+3q/tf43lzqxId4c/moI=;
        b=FrLswurMHZq4M5NffbQkhqAXMCarQlZX+nqEuPodr1N58lvjRdBIrLp5f0NLvCp6xx
         IFs+P7iSw8zPRaRSwwWT/rB01WDRzMU9rbjMAA9N6X2yw2rrRYFnANHXz+a1YohZ5eQd
         2YYI3xWMVrAmEA5xWAy4Lv+aWvpssZhVxbi23NbRgpU05bnC4PNJdFHlGUXxaVoL7zIH
         Ve6TvQKvZHYpDGGSfQWFOvwvX9qFe/NNKRv1mamhsAT//kluZjFBiUjlyoxymtR3LLn1
         FGozJ3baqyN/Y4KLeN34HsPlyo/eYfJHZzOB2/4AHNrYwyOj2DRnoPK+KOy7HnKDYbYF
         kjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700615301; x=1701220101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvpOAl9p0Aiam4sGuchXKDW+3q/tf43lzqxId4c/moI=;
        b=c8pwhu+Q5IRq+wNxUhQw+MDPY+uV73/r+H3pbRzqAr4ivRWhyDGFXmdi9LsMvoaOZ7
         wEd1TT0odd0uDKzaH4CRGiEqquT6Jc84t3y+ySMkZxqeWmBoMj84U5scK2YP1WWFSPkX
         hn4+IDzzYqayLnNkh2l/GQwTPnfjuq+FlkLW+efIPe5b3RUBlHoAj/p6RQb8li6rbd/Z
         USzyXrOBZlmv6hAlz/tRiIYvVeve2s68w0hpux0lrrPKoBrqYYB3nhQGZGciDbPugjEe
         WfuhQguFGBJxWoVJgt0EOaydbpmCCKNju/EFJlXvd+2Ixh3u5ATMaHDzwvOd9mdnPT9g
         5l6w==
X-Gm-Message-State: AOJu0YxaSdqd2qrzm3kKMfwBBcPxG12nx870OR64T2HiFK1Zg7lSkDHQ
        V58FxJo5ng/puRUmFo5kZtVqTg==
X-Google-Smtp-Source: AGHT+IF9d9fQIS/asTDDunhMGjFlgWHJ5Uekq1PrtWCEzSD057jeC559ik7d8wrAC6IaVqDr4/Nfcw==
X-Received: by 2002:a05:6a00:3927:b0:6c6:aaa4:5d68 with SMTP id fh39-20020a056a00392700b006c6aaa45d68mr871292pfb.27.1700615301365;
        Tue, 21 Nov 2023 17:08:21 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bn5-20020a056a00324500b006be047268d5sm8713961pfb.174.2023.11.21.17.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 17:08:20 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 3/8] riscv: Avoid TLB flush loops when affected by SiFive CIP-1200
Date:   Tue, 21 Nov 2023 17:07:14 -0800
Message-ID: <20231122010815.3545294-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122010815.3545294-1-samuel.holland@sifive.com>
References: <20231122010815.3545294-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since implementations affected by SiFive errata CIP-1200 always use the
global variant of the sfence.vma instruction, they only need to execute
the instruction once. The range-based loop only hurts performance.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v3:
 - New patch for v3

 arch/riscv/errata/sifive/errata.c | 3 +++
 arch/riscv/include/asm/tlbflush.h | 2 ++
 arch/riscv/mm/tlbflush.c          | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
index 3d9a32d791f7..00e011d78866 100644
--- a/arch/riscv/errata/sifive/errata.c
+++ b/arch/riscv/errata/sifive/errata.c
@@ -42,6 +42,9 @@ static bool errata_cip_1200_check_func(unsigned long  arch_id, unsigned long imp
 		return false;
 	if ((impid & 0xffffff) > 0x200630 || impid == 0x1200626)
 		return false;
+
+	tlb_flush_all_threshold = 0;
+
 	return true;
 }
 
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index e529a643be17..3b393f765805 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -62,6 +62,8 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end);
 #endif
+
+extern unsigned long tlb_flush_all_threshold;
 #else /* CONFIG_MMU */
 #define local_flush_tlb_all()			do { } while (0)
 #endif /* CONFIG_MMU */
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 0feccb8932d2..27b3744b5673 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -11,7 +11,7 @@
  * Flush entire TLB if number of entries to be flushed is greater
  * than the threshold below.
  */
-static unsigned long tlb_flush_all_threshold __read_mostly = 64;
+unsigned long tlb_flush_all_threshold __read_mostly = 64;
 
 static void local_flush_tlb_range_threshold_asid(unsigned long start,
 						 unsigned long size,
-- 
2.42.0

