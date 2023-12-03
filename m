Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8549B8026FB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjLCTfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbjLCTeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:34:36 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B99610FC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 11:34:10 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-db5e5647c24so1621144276.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 11:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632049; x=1702236849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ONlIH00MiYhYGoBsEhokNEtUTm7vUieJjeG6NEodPg=;
        b=JAuSRV8UL64Bcgb9S2QAMIyfAeGsChnDH0aLot298hiqZoSfpkmaWEXvXal2oZ7qu3
         sacUuNDiCdvj55/6RC18Br6ndwKMaHXQ7mcLG1a9exqt/soHyX+qtjLruDPG0EXAMJnz
         t+369EpIfq2JcG0pkz5HrW3N86Tc+tJjtvLUnjc7Mm+zFdgB92eoYwT7v7Tq/r3849nn
         I3GlFnakdFHM2IYtVVIGwDszRDmUje8vZ9UBhRcu8smUeZcDtj+9a20crgmZmXhjoZxA
         vJudBiGK1xUCo0FzIEA0C/UCWvw5CuciKIZ4QS4sYR4tEy1ZTjp2O6ZnuGhnPlhV1im1
         xcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632049; x=1702236849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ONlIH00MiYhYGoBsEhokNEtUTm7vUieJjeG6NEodPg=;
        b=QP+uBFOB3dwNOC3b4uZJAF4nwy51ugjt5RIXwsXapFAtByjXKwJ3cM3BFeC9IwtJGR
         VSSuRE0lMoHzTLhQyO00Dsfw183lpIiwdX+RpD1CoH+enhDXz/YRn06oZYLy0jRWxMce
         mwkmHWsuluEeIk8mbLxMmA+TX36FRbRVV6aHmLtWM/EctdM3YxV3bP9w1SSwnp4PrC52
         2fbEP+NZS4lqzJisLzI9EZZ4bVH6a3PU5CpHIiWc0qTiRVV739jXmtmIZ5ro5aDMCYQP
         93Wr2i9SRzlDkk+aEf8XeSSG2JWF+yymSSpfZJ+fQTzm/asexBS+MjiLMT5/8Mvt9N4+
         PH0A==
X-Gm-Message-State: AOJu0YzgQ6CM+dlcVsmDdetVyPgVxA1QmboKOTqy9AbyFmQX68VdseCF
        UDwmeFvvkkeZG9V0Wip2f7L1oJXM3ipaIQ==
X-Google-Smtp-Source: AGHT+IEeQNQARFKivngZ+xviJgmHrgXIJudfHB7IzRNwcvEB1vDTBAVhqrCwpLPl3d4ajkjgRk1Meg==
X-Received: by 2002:a81:a1c7:0:b0:5d7:1940:3efd with SMTP id y190-20020a81a1c7000000b005d719403efdmr1651357ywg.46.1701632048410;
        Sun, 03 Dec 2023 11:34:08 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id a85-20020a0dd858000000b005ce039bf1ecsm2099376ywe.7.2023.12.03.11.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:34:08 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 34/35] microblaze: rework get_mmu_context()
Date:   Sun,  3 Dec 2023 11:33:06 -0800
Message-Id: <20231203193307.542794-33-yury.norov@gmail.com>
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

Fix opencoded find_and_set_bit_wrap(), which also suppresses potential
KCSAN warning.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/microblaze/include/asm/mmu_context_mm.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/microblaze/include/asm/mmu_context_mm.h b/arch/microblaze/include/asm/mmu_context_mm.h
index c2c77f708455..209c3a62353a 100644
--- a/arch/microblaze/include/asm/mmu_context_mm.h
+++ b/arch/microblaze/include/asm/mmu_context_mm.h
@@ -82,12 +82,11 @@ static inline void get_mmu_context(struct mm_struct *mm)
 		return;
 	while (atomic_dec_if_positive(&nr_free_contexts) < 0)
 		steal_context();
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

