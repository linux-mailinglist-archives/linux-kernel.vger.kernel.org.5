Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AE87F00C5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjKRPzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjKRPxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:53:41 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E867B2107
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:58 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5b383b4184fso33543527b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 07:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322717; x=1700927517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JD5ffTGpk93tg8AkoESy4I0f3LaG6FeAVUaBjQtKP0=;
        b=X7pc2AVj+gHCUODSfMJQ1CCULuF++OsKUTMOHebHVYuvR+MvRn6nhotkGpU/kxXh/2
         aZJ3Xya7gtFHfEbh4wBKK0E/UATRnEdwk80UWlQdUgJazARP+qCKUetQ5aLNkNquEdcU
         0+XCzfzH74i9o5L9kDnBssrtP3Z3QSykWlwJv0oi9MEexSkaGku06cELfiogK2kISFeB
         DuU23LUY58LkVlgdEc4+13umvrYG9zK7eaxlAvKs39+PjzuGM0qRPU5HZ7r14rXMnNac
         jZx9whY3yYAx9Ru1flPMZll5kbS4rTK5kiGUHblS+MtLtbMveV4r67k+cMg8tSvbGln7
         Yz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322717; x=1700927517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JD5ffTGpk93tg8AkoESy4I0f3LaG6FeAVUaBjQtKP0=;
        b=WST0Rg6KKynh3QjteS6LJaCH11OKgfkcb125CGWp061Y4E2TV+j6oB79BVeX3Ddhe/
         x+1uiKYQ2cRnCV5tmoELwONiJIU2WANGAMS4xkIghywK50SiwB4bS1gITbwtj3m1a439
         yccK5hAcnpfiuwmGdi4G/MqWIiLNTobxGMS3fOdchG2tHLG1I4CV7pwAaXJd4kbhbb48
         HQNUYPsJHFX0V4lmps1hEvxKX/mRFMZhzgU0W6yrq55jIWdWNZ5Fahy7TUg8kgCl59co
         MKNOo7q8an0yMA6Z51Dn7asgJpkfF2VJKz6I+WFT0pEv+6Ijhe8b84azH8xQJfCCzum5
         1SQg==
X-Gm-Message-State: AOJu0YwvB03sE9aRrwBoasc808s53Yf/KPxM0quuxhEdVP4LIfARlAxW
        JC0u/SJ+2zerM/83M2RxaT206N4UTO6an+TO
X-Google-Smtp-Source: AGHT+IG7wPFpUNycKY+N0nEw19mU/BEjuia4iH+Rsm+r8LMcRL1GjjYZzQ/va5FVyE428m6U7tDiNQ==
X-Received: by 2002:a81:4f13:0:b0:5a5:65e:b847 with SMTP id d19-20020a814f13000000b005a5065eb847mr2911182ywb.34.1700322717124;
        Sat, 18 Nov 2023 07:51:57 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id w184-20020a0dd4c1000000b0059f650f46b2sm1172057ywd.7.2023.11.18.07.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:56 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 33/34] microblaze: rework get_mmu_context()
Date:   Sat, 18 Nov 2023 07:51:04 -0800
Message-Id: <20231118155105.25678-34-yury.norov@gmail.com>
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
2.39.2

