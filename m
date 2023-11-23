Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D787F58BF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbjKWG6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjKWG6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:58:35 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB109D53
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:58:09 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6cbe716b511so212930b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700722689; x=1701327489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LItBiu3njgwOLf534DBFrKwLVF0r3rYUowPJh3TGf00=;
        b=UzGdsOSz9JSDfHRi5KKnT4dlZtIi2nhA7QGLNCAgBQOMZQKID2pPvTO29f/rPAFOXq
         EK7NkQN3aL+S8AtA/bpAD9ehTJAz+JwOGcsKBapLl81gCz/IpCOqVRS9Oi9JaJyUbHCP
         Sn127m6mYRPrTCbXtvIoFwqaHDm0aDV4f1SnTmtsOFYQmw2vC6Nfi/RX+BclfoyX3OB8
         mCAqes1YYDgFwLzs0v4U2UnvejN/E+9kNTdBa5sgFgdRUNsWGCFzS8rAYx6SfQs5rPcp
         6sv0RJu36k5rxfLIJaKG1ZfBbQIUBJkSxTrYnPUB9ty8+3/athaoDftvkM/9vUyzNl0+
         FGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700722689; x=1701327489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LItBiu3njgwOLf534DBFrKwLVF0r3rYUowPJh3TGf00=;
        b=PEnjSCEyovcy3U8z3dEC2i+m3prDBY1EWc+7aFk/FJzL/tjiSRCvGs2b5yE1Dj+CcC
         DjUuvECFMH3OefINqFpsh0h5SBOflxKW4VSqLfySUGAXk8b6EXG0x8sQOVefPYCQGcIk
         miJcghsgcX9R2ciwXYe8maXfnYi0yrKBeVhuQ/mDNlsVSNA+9csSv69cL6wjsj+WGnuR
         EnnjDr8zB4fNfEqWE7EmMu+JxrpFdDRapdt5D6sYhr5Tg/W3Da3dRd7F3QZTJNONFfJ+
         s8tknts+I0dueCLyZidFvm8uB/xbFdYLPntCLC2ffcIIz95H41aS0OGbTTL7dNqzOFRT
         4ckw==
X-Gm-Message-State: AOJu0Yy2qwwNEiLqj8R4jsXlv1Obf6cE2dFUJm8eKWTGUAR/6nR/FjDN
        c2n26LoZUXzU9z8jhg/atIjJgw==
X-Google-Smtp-Source: AGHT+IHDftjTLrWgyN3MNpT75XgaN32WdbFQKAWGC+MLKZT2N1z3VTeVkMs+OclMTvua0pcY3LDEGg==
X-Received: by 2002:a05:6a00:35cf:b0:6cb:8c70:4790 with SMTP id dc15-20020a056a0035cf00b006cb8c704790mr5824334pfb.1.1700722689341;
        Wed, 22 Nov 2023 22:58:09 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id w37-20020a634765000000b005bd2b3a03eesm615437pgk.6.2023.11.22.22.58.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Nov 2023 22:58:09 -0800 (PST)
From:   Xu Lu <luxu.kernel@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, ardb@kernel.org, anup@brainfault.org,
        atishp@atishpatra.org
Cc:     dengliang.1214@bytedance.com, xieyongji@bytedance.com,
        lihangjing@bytedance.com, songmuchun@bytedance.com,
        punit.agrawal@bytedance.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH V1 08/11] riscv: Apply Svnapot for base page mapping
Date:   Thu, 23 Nov 2023 14:57:05 +0800
Message-Id: <20231123065708.91345-9-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231123065708.91345-1-luxu.kernel@bytedance.com>
References: <20231123065708.91345-1-luxu.kernel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Svnapot extension on RISC-V is like contiguous PTE on ARM64. It
allows ptes of a naturally aligned power-of 2 (NAPOT) memory range be
encoded in the same format to save the TLB space.

This commit applies Svnapot for each base page's mapping. This commit is
the key to achieving larger base page's performance optimization.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 34 +++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 56366f07985d..803dc5fb6314 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -230,6 +230,16 @@ static __always_inline unsigned long __pte_napot(unsigned long pteval)
 	return pteval & _PAGE_NAPOT;
 }
 
+static __always_inline unsigned long __pte_mknapot(unsigned long pteval,
+		unsigned int order)
+{
+	int pos = order - 1 + _PAGE_PFN_SHIFT;
+	unsigned long napot_bit = BIT(pos);
+	unsigned long napot_mask = ~GENMASK(pos, _PAGE_PFN_SHIFT);
+
+	return (pteval & napot_mask) | napot_bit | _PAGE_NAPOT;
+}
+
 static inline pte_t __pte(unsigned long pteval)
 {
 	pte_t pte;
@@ -348,13 +358,11 @@ static inline unsigned long pte_napot(pte_t pte)
 	return __pte_napot(pte_val(pte));
 }
 
-static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
+static inline pte_t pte_mknapot(pte_t pte, unsigned int page_order)
 {
-	int pos = order - 1 + _PAGE_PFN_SHIFT;
-	unsigned long napot_bit = BIT(pos);
-	unsigned long napot_mask = ~GENMASK(pos, _PAGE_PFN_SHIFT);
+	unsigned int hw_page_order = page_order + (PAGE_SHIFT - HW_PAGE_SHIFT);
 
-	return __pte((pte_val(pte) & napot_mask) | napot_bit | _PAGE_NAPOT);
+	return __pte(__pte_mknapot(pte_val(pte), hw_page_order));
 }
 
 #else
@@ -366,6 +374,11 @@ static inline unsigned long pte_napot(pte_t pte)
 	return 0;
 }
 
+static inline pte_t pte_mknapot(pte_t pte, unsigned int page_order)
+{
+	return pte;
+}
+
 #endif /* CONFIG_RISCV_ISA_SVNAPOT */
 
 /* Yields the page frame number (PFN) of a page table entry */
@@ -585,6 +598,17 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
  */
 static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
+	unsigned long order;
+
+	/*
+	 * has_svnapot() always return false before riscv_isa is initialized.
+	 */
+	if (has_svnapot() && pte_present(pteval) && !pte_napot(pteval)) {
+		for_each_napot_order(order) {
+			if (napot_cont_shift(order) == PAGE_SHIFT)
+				pteval = pte_mknapot(pteval, order);
+		}
+	}
 	*ptep = pteval;
 }
 
-- 
2.20.1

