Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0784D7F00AD
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjKRPxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjKRPwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:52:40 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8269119B4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:35 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-dafe04717baso2735378276.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322694; x=1700927494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sgPttQUTNTuJ1Gv7B+hCylz5123eQWSPdiwCHEz6H8=;
        b=PoNIotFYnRO1vakd/M6VycSkD3A4sX/1tLnMXtRJOaid3l8nMRfWklAhxIiJcPKWWR
         +/VSe19s7rJwBZ7K8p04nY28F1C3gs2X6WtZxvKnFg5+eBNFe9oB/9L2ramKlhqDK9JS
         Caxb/ExO62CG+9lULE455pTIgthCmBJ8Pa/BzsVG3p2Y7irAjFjTO379nGv+zARdCM2q
         AtsvsaP7b/FbxTOfE3slsJ3yH11bI0qKWOreP8NP/RmgNCXUROVZLMbhrE889LLqmMJf
         LeAijksAPm6a5qJ3UT87Hzyi6xIlEez5TuMBG+wJMevNlpWHyHjRxS3xW1l10kNzKPyy
         kc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322694; x=1700927494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sgPttQUTNTuJ1Gv7B+hCylz5123eQWSPdiwCHEz6H8=;
        b=eJxp+j/f2xSes4ranWypt0XOVJam0eYhTiHDUQIPNXLzva7/3XtqPbSakKpxQvFINg
         jpuzlMvmC3yP7A+uMNqlAoZfhBP5PiwamYM35Nl4yeJ1JrnDe64KdCoMVrEjaFp3CJN8
         hCh+acpINwVxy9e/ASVanpdacvNYqhjzLa3Tla0KFYSHL7sjwpSY5ix5vVH7+9xon1h5
         PIEPj5cWWV9fM5rnPqBSXtXWPMJLPC2vW4LuKQD3xzHHrDfv1Gmo05/NE73xS9Z0ZpJI
         0f1acIkLK57qEDMMI4yA9d508EQWEcAO79VMrdd4K8oZZ33BYotuygsYp/IodBTBTc/T
         SCtQ==
X-Gm-Message-State: AOJu0Ywv3KI2X5X/k2yYtd1RqZ6mSStc7n4pRYCFC/NBKGx43jdXDitY
        Q4STSBT77ONNjw05xFVZ9y+Y3B7BcKxLjH3A
X-Google-Smtp-Source: AGHT+IH3c8eQ4c+uzbxwI+kH3hUCZgJt3MgED5/a9/Dtof5xSXMrcPkxFIL9d3IXLZ+C5ahKbRF/xw==
X-Received: by 2002:a25:6d44:0:b0:da0:9735:b012 with SMTP id i65-20020a256d44000000b00da09735b012mr2056422ybc.11.1700322693911;
        Sat, 18 Nov 2023 07:51:33 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id u14-20020a05690201ce00b00d7b8a1074d4sm967654ybh.57.2023.11.18.07.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:33 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Yury Norov <yury.norov@gmail.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 16/34] powerpc: use atomic find_bit() API where appropriate
Date:   Sat, 18 Nov 2023 07:50:47 -0800
Message-Id: <20231118155105.25678-17-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix opencoded find_and_{set,clear}_bit() by using dedicated functions.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/powerpc/mm/book3s32/mmu_context.c     | 10 ++---
 arch/powerpc/platforms/pasemi/dma_lib.c    | 45 +++++-----------------
 arch/powerpc/platforms/powernv/pci-sriov.c | 12 ++----
 3 files changed, 17 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/mmu_context.c b/arch/powerpc/mm/book3s32/mmu_context.c
index 1922f9a6b058..7db19f173c2e 100644
--- a/arch/powerpc/mm/book3s32/mmu_context.c
+++ b/arch/powerpc/mm/book3s32/mmu_context.c
@@ -50,13 +50,11 @@ static unsigned long context_map[LAST_CONTEXT / BITS_PER_LONG + 1];
 
 unsigned long __init_new_context(void)
 {
-	unsigned long ctx = next_mmu_context;
+	unsigned long ctx;
 
-	while (test_and_set_bit(ctx, context_map)) {
-		ctx = find_next_zero_bit(context_map, LAST_CONTEXT+1, ctx);
-		if (ctx > LAST_CONTEXT)
-			ctx = 0;
-	}
+	ctx = find_and_set_next_bit(context_map, LAST_CONTEXT + 1, next_mmu_context);
+	if (ctx > LAST_CONTEXT)
+		ctx = 0;
 	next_mmu_context = (ctx + 1) & LAST_CONTEXT;
 
 	return ctx;
diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
index 1be1f18f6f09..906dabee0132 100644
--- a/arch/powerpc/platforms/pasemi/dma_lib.c
+++ b/arch/powerpc/platforms/pasemi/dma_lib.c
@@ -118,14 +118,9 @@ static int pasemi_alloc_tx_chan(enum pasemi_dmachan_type type)
 		limit = MAX_TXCH;
 		break;
 	}
-retry:
-	bit = find_next_bit(txch_free, MAX_TXCH, start);
-	if (bit >= limit)
-		return -ENOSPC;
-	if (!test_and_clear_bit(bit, txch_free))
-		goto retry;
-
-	return bit;
+
+	bit = find_and_clear_next_bit(txch_free, MAX_TXCH, start);
+	return bit < limit ? bit : -ENOSPC;
 }
 
 static void pasemi_free_tx_chan(int chan)
@@ -136,15 +131,9 @@ static void pasemi_free_tx_chan(int chan)
 
 static int pasemi_alloc_rx_chan(void)
 {
-	int bit;
-retry:
-	bit = find_first_bit(rxch_free, MAX_RXCH);
-	if (bit >= MAX_TXCH)
-		return -ENOSPC;
-	if (!test_and_clear_bit(bit, rxch_free))
-		goto retry;
-
-	return bit;
+	int bit = find_and_clear_bit(rxch_free, MAX_RXCH);
+
+	return bit < MAX_TXCH ? bit : -ENOSPC;
 }
 
 static void pasemi_free_rx_chan(int chan)
@@ -374,16 +363,9 @@ EXPORT_SYMBOL(pasemi_dma_free_buf);
  */
 int pasemi_dma_alloc_flag(void)
 {
-	int bit;
+	int bit = find_and_clear_bit(flags_free, MAX_FLAGS);
 
-retry:
-	bit = find_first_bit(flags_free, MAX_FLAGS);
-	if (bit >= MAX_FLAGS)
-		return -ENOSPC;
-	if (!test_and_clear_bit(bit, flags_free))
-		goto retry;
-
-	return bit;
+	return bit < MAX_FLAGS ? bit : -ENOSPC;
 }
 EXPORT_SYMBOL(pasemi_dma_alloc_flag);
 
@@ -439,16 +421,9 @@ EXPORT_SYMBOL(pasemi_dma_clear_flag);
  */
 int pasemi_dma_alloc_fun(void)
 {
-	int bit;
-
-retry:
-	bit = find_first_bit(fun_free, MAX_FLAGS);
-	if (bit >= MAX_FLAGS)
-		return -ENOSPC;
-	if (!test_and_clear_bit(bit, fun_free))
-		goto retry;
+	int bit = find_and_clear_bit(fun_free, MAX_FLAGS);
 
-	return bit;
+	return bit < MAX_FLAGS ? bit : -ENOSPC;
 }
 EXPORT_SYMBOL(pasemi_dma_alloc_fun);
 
diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index 59882da3e742..640e387e6d83 100644
--- a/arch/powerpc/platforms/powernv/pci-sriov.c
+++ b/arch/powerpc/platforms/powernv/pci-sriov.c
@@ -397,18 +397,12 @@ static int64_t pnv_ioda_map_m64_single(struct pnv_phb *phb,
 
 static int pnv_pci_alloc_m64_bar(struct pnv_phb *phb, struct pnv_iov_data *iov)
 {
-	int win;
+	int win = find_and_set_bit(&phb->ioda.m64_bar_alloc, phb->ioda.m64_bar_idx + 1);
 
-	do {
-		win = find_next_zero_bit(&phb->ioda.m64_bar_alloc,
-				phb->ioda.m64_bar_idx + 1, 0);
-
-		if (win >= phb->ioda.m64_bar_idx + 1)
-			return -1;
-	} while (test_and_set_bit(win, &phb->ioda.m64_bar_alloc));
+	if (win >= phb->ioda.m64_bar_idx + 1)
+		return -1;
 
 	set_bit(win, iov->used_m64_bar_mask);
-
 	return win;
 }
 
-- 
2.39.2

