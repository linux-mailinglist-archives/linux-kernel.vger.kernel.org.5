Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CBC7F00C4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjKRPzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjKRPxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:53:40 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD2010E5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:57 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-da0cfcb9f40so2988934276.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322716; x=1700927516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNt2pqVZ1WV5AdCyxo2zcjd8VNJuqW2Azbsupr/AuxU=;
        b=NGUiw/mL7WRPzT2RlK9PbyCZveUqmgM81hOy+rsUTY5fSOyrgceZh6KAyPQzty08Er
         GAAyE0otRecqL5W6PFgzjLVh3yne9zHw6kI2SH8c7iWoHgJMYjMEbS+595kxbLBm8qf2
         qQERnVQax891G0oWLCpQSHURuboOkuyMPhmkvxoHKNqten4zo5ap/qzmonSf5EAJSo4z
         mDtWXXE2X35cf75WmH66B9QVWAfS2XEcrFdFNpMX/+GTN7kPhOXo1+dHUg/QsP9/hwJw
         wO3z9qKaKklY2xI5N5fhygTooZsfTXlDHcv8N5z/VF8EnuPvSdW/cMsUf+VEYBVP1U19
         0FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322716; x=1700927516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNt2pqVZ1WV5AdCyxo2zcjd8VNJuqW2Azbsupr/AuxU=;
        b=B6dxk603r1jGG8Pcg7ZdcDnBun7MaeN54X75oO6iBeTWopBAMV0ac7N8XkwEddJdyY
         HEAv9SbPkjsxPmyTfXs/4K2BfwwegAhcTwpjIptS0kWNgm6iZ2r2w/aO4E4boP/f0VOx
         MB4hwR3EncXb8NSmjg1PrOfY+hpkKKSNNUUY5voZsuV/5oImPrr72CTR2uqYiMoUJflh
         tDcGgSbnltxOZcsJIH1AVbdVVdzx4ItVW3jrg6oRsqU9+x9cuVQFnK1xLk6xHPfBtwvN
         AxZ2CprCmZhf68BRQLwWi1mJ1zbX7YDeeZDVc0kE0/q5H3kFsdMEz8F6ULhgpxAbehqA
         7+Hg==
X-Gm-Message-State: AOJu0YzYd1C2qNspPB+bM1ZaayHlo5uTOqjH72kUUKRFih4MqRHL4qEA
        t/4SfbySe6RMomO1DFjAr7isdtkCkM0s7/+g
X-Google-Smtp-Source: AGHT+IEf1SMn4kx/hj71N88M3PWh0tAr7wvGpwiR33ZDpQe2i0m4dnQ8GWNqn8AtrUGo6m7vBDMcZQ==
X-Received: by 2002:a25:ca44:0:b0:da0:54f7:69bd with SMTP id a65-20020a25ca44000000b00da054f769bdmr2497887ybg.22.1700322715920;
        Sat, 18 Nov 2023 07:51:55 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id y36-20020a25ad24000000b00d9a577d8434sm998467ybi.53.2023.11.18.07.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:55 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <yury.norov@gmail.com>,
        linux-m68k@lists.linux-m68k.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 32/34] m68k: rework get_mmu_context()
Date:   Sat, 18 Nov 2023 07:51:03 -0800
Message-Id: <20231118155105.25678-33-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALSA code opencodes atomic find_and_set_bit_wrap(). Switch it to
dedicated function.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/m68k/include/asm/mmu_context.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/include/asm/mmu_context.h b/arch/m68k/include/asm/mmu_context.h
index 141bbdfad960..0419ad87a1c1 100644
--- a/arch/m68k/include/asm/mmu_context.h
+++ b/arch/m68k/include/asm/mmu_context.h
@@ -35,12 +35,11 @@ static inline void get_mmu_context(struct mm_struct *mm)
 		atomic_inc(&nr_free_contexts);
 		steal_context();
 	}
-	ctx = next_mmu_context;
-	while (test_and_set_bit(ctx, context_map)) {
-		ctx = find_next_zero_bit(context_map, LAST_CONTEXT+1, ctx);
-		if (ctx > LAST_CONTEXT)
-			ctx = 0;
-	}
+
+	do {
+		ctx = find_and_set_bit_wrap(context_map, LAST_CONTEXT + 1, next_mmu_context);
+	} while (ctx > LAST_CONTEXT);
+
 	next_mmu_context = (ctx + 1) & LAST_CONTEXT;
 	mm->context = ctx;
 	context_mm[ctx] = mm;
-- 
2.39.2

