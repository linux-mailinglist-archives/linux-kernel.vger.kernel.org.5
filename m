Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3198026F9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbjLCTfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjLCTed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:34:33 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B91D10D0
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 11:34:08 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5cfc3a48ab2so39492967b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 11:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632047; x=1702236847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEAW6nGOpgim0ACBxEZBy/BOAQq7BVlPEZ5Wnk5EbpM=;
        b=XRC8nmw4aWS21qdL/HpPYHRLloSUN6FVCe40JgWmo0j/cG8RyRTVuZCSGllmeCRFEE
         czLitV/XKrw8nagMe36/wTlO0vpJIWEcNakT3uQBrQpQZPJB2P8I4ywRKStWM2WLSzhH
         CJUBIU9mFE8u8Hi+eRykCJb71qqMQ3iCkNCZWbp0VTCrR45mSSP2WVEKQo6Q9LnhK3hy
         /rPKActhfQeQxGYfXqgmp/5Re6hkt5H34R0BCRgbaUgLpxEfDiMiTN9LKOJ2ekzkR3q4
         pZyzmBScJTzuBzaEL9SZkNSZ70l2UIMbOXXRBBy2s8L5Eyj9jc10WH6Xl06yypaVmK7L
         oo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632047; x=1702236847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEAW6nGOpgim0ACBxEZBy/BOAQq7BVlPEZ5Wnk5EbpM=;
        b=UH9rcOj9+PMigV/uPE/vrLOT5fQJkf9FugsvkI+UYxNlBQbzu1YYfpq7FzPY1ikyU4
         x6ccFT4I3Mr0u9EBzBLIcGEPunKvc3S/7xNnEbi90ZAXHRlZ/y4l5L1ihCksQpFQGbdd
         DpiRSh9K+cpF+TFOsvmJUw1w4nwOxJxnEXCNrqFMRYfHhRjVBqH+i3Qe3N3lme3fQAYW
         wjWCcqJAQT/JJ4rH2LqMIWtyLOqZMAULaqFgjvcYRMTJDJYo3hEkKp7JoCs8jXs0lqW7
         0orHfMK3ChxoQd3p8Bl2qDJxWQ2ZfaItSst+lvrGFIuO0pg44Zuu3L885+PaiQse3L9+
         ya2Q==
X-Gm-Message-State: AOJu0YzJ3UWy6uHaPC+caML39p0X8W1xR4WobPTmXmkWRhnfOOe3lNCV
        HT8TSX9q0LFYwHvgO4UKpCFtiDzltN2Zpw==
X-Google-Smtp-Source: AGHT+IHufbVLLqLGwm6nH7ckWvYr9uGUqV0U2BDaMdlKYlwniqIdKwaazuL68uDooDDXCfZAK6cVoA==
X-Received: by 2002:a81:af62:0:b0:5d3:507f:98da with SMTP id x34-20020a81af62000000b005d3507f98damr2016941ywj.11.1701632046878;
        Sun, 03 Dec 2023 11:34:06 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id q188-20020a8199c5000000b00583f8f41cb8sm2732232ywg.63.2023.12.03.11.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:34:06 -0800 (PST)
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
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH v2 33/35] m68k: rework get_mmu_context()
Date:   Sun,  3 Dec 2023 11:33:05 -0800
Message-Id: <20231203193307.542794-32-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
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

get_mmu_context() opencodes atomic find_and_set_bit_wrap(). Switch
it to dedicated function.

CC: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Acked-by: Greg Ungerer <gerg@linux-m68k.org>
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
2.40.1

