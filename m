Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F0880E1C4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345958AbjLLC3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345818AbjLLC2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:48 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C425186
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:28:45 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-db5e5647c24so5250866276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348124; x=1702952924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DMiRTxcwheUb+ZoNiPcJzLnCeEFZ24O/DBbvQYnX0M=;
        b=l23L7lV4hh5lDkKy8WpQFYTkMrVEnXHT/E2pRwalsa8qbdIEvEVMsGaLXjFt7SKj6F
         MIckE0oRdoU28fWjsRIX58BJ77jDx9wwLvmo9KI1x1XI1ej1BxQfczXzlEwfW0gWd0df
         3Mcnqthhv4LOk4HgS1On0PlFnc40JY6Rj6JnLgzkdOWSiLQscS/VBiC+ulZa5hrR6nRI
         /1X9UnZDkmJc3eALd2QGnvD6WMCDr+HiaS4jRMVt/oiHk+Bunw3yz7VylvdFmMYccYsc
         ts7EDvMEXXinINQeNKo/paSVpSvxjIHzEB+YDAn+gCIlEmEzMOrCTqeTz0QtxbOUZm7r
         lIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348124; x=1702952924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DMiRTxcwheUb+ZoNiPcJzLnCeEFZ24O/DBbvQYnX0M=;
        b=gOWs6WXK5GnAitVJPyIQ3CATxyec/J2LJLatPP2K9HwPSlLJ1gylBaTi58uMJZn6Ga
         NAJWiD5cItJqUpLIZVYx9SLPzRB+ekIXvQfKtKHGm57XT5EsigNhZdGWsju+Giq3HPl1
         u9dF7yCXouTBM2JgxngcQtcA1G2aUQylI2EHw7nJp7AQNTb4yGl5xu/KMP+aRte+l+c2
         z/PMAXq9JZuEREOr/i00N53UItaU9uJ7WeMh5rMl4M2/pSPME0kGUw3atJRAiQoXfnGU
         aiROJ7jZEOJrfGgRliF1soaOuNObcCP0DHJmlEL8iSNjImvx+XSDn5wyIKa18Mlbui4M
         KcsQ==
X-Gm-Message-State: AOJu0YzPWbOlba0Swv7CgaLswSA/Iv2c8EZC1TQrcJovGT+SRLpEhM97
        8BWfubKXrYRVWGMEiFmk6vznU1gv0BzsuA==
X-Google-Smtp-Source: AGHT+IHCV3Pji6ko5rivDIHNkl5UacOOsEXrF599CG+SaY2q7FT8FxzO49D81kiTmkq1YFWQ3dLWaQ==
X-Received: by 2002:a25:cc82:0:b0:dbc:b4dc:a8c9 with SMTP id l124-20020a25cc82000000b00dbcb4dca8c9mr687040ybf.15.1702348123771;
        Mon, 11 Dec 2023 18:28:43 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id x9-20020a25a009000000b00d9a36ded1besm2959103ybh.6.2023.12.11.18.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:43 -0800 (PST)
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
Subject: [PATCH v3 34/35] microblaze: optimize get_mmu_context()
Date:   Mon, 11 Dec 2023 18:27:48 -0800
Message-Id: <20231212022749.625238-35-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
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

Simplify get_mmu_context() by using find_and_set_bit_wrap().

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

