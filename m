Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3451380270A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjLCTgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbjLCTg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:36:27 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31BD19BF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 11:33:42 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso2144098276.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 11:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632021; x=1702236821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRG7J1XhtxmqjKk8mPyX2ntR1/BM7lRJBdNSI5UPjng=;
        b=V0bB9EgE9geKKLnK8shvWe1KUQ78kOoFIJSqNIz2okIgocck0oiDan1ruNwgwzDzsw
         l+afX/Faw6bmf1iU5/bIqq/RSqkOjs5Hk6OjyUQFTgsuLXxLz/n9BwLssePi8Xyl+/zh
         WoAGrecvh1TT1RB2XanU9IVfi1Eb8ics7PrJccDN1DwQHbX26hFjjZKWSM2mx6fp2jDM
         M3uaeIWNt3kdL+YQq4eLdOiAgPC0axq8ysmte5hJ1HawT51swXF00MG+siItAsEuwvRm
         dZIl6CSLgzMU2L+Lsy/0LjotYBUEpHCmY7TkGws/+qwr8yLdQ7HSXuB6o5pi3SsybpKh
         4mVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632021; x=1702236821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cRG7J1XhtxmqjKk8mPyX2ntR1/BM7lRJBdNSI5UPjng=;
        b=l5EutowARjFSIHm3cNVwRGvwZ1SnpO1+W6Dxz4g7l46wVQQr2dUadI56iXcRb0nzHS
         ebOD2CJoWluQ5+D0c1z9F+OA78M6WU+KhOWW1nXzo+ebsA1nBQ2s1rcKjHgqxdoa7fYR
         H1ttQ2/U0m13RwEhqmtIubnXvBMZuvyisSlhZ96+0ONskK2ZMbaxrAsYZv3Sr0A635t8
         MiBE0ZFeWr4HNdyJYXLg5ii3HqOR2oosGnDwVoLRQVFw7RncJBjUo7weQCk6u8ZW1vEM
         pBtLiMe64IpzBRaIWZqemjVnPGydZR0mEG0BAb/4bba+9QhZJp/5uGOGV3peEwT2V3n9
         hp1Q==
X-Gm-Message-State: AOJu0YzzeSeRn5xLBd463U8nkeRZ0rHy/9/RJek5zMQuUI158CuJNEo9
        2LioiZLe0hh0aQ9RwTc+F9b0MLTHCCCw5Q==
X-Google-Smtp-Source: AGHT+IH/zAr/IRLH41uf8GyRu75RL5p41k4FNgdJhjBLXJc/pBGsG9eMP2VGrFV3emuPx11G2UwLSw==
X-Received: by 2002:a5b:bce:0:b0:db5:42eb:3efd with SMTP id c14-20020a5b0bce000000b00db542eb3efdmr2164135ybr.2.1701632020812;
        Sun, 03 Dec 2023 11:33:40 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id 132-20020a25028a000000b00d7497467d36sm1820247ybc.45.2023.12.03.11.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:39 -0800 (PST)
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
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 18/35] powerpc: use atomic find_bit() API where appropriate
Date:   Sun,  3 Dec 2023 11:32:50 -0800
Message-Id: <20231203193307.542794-17-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use find_and_{set,clear}_bit() where appropriate and simplify the logic.

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
2.40.1

