Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3680E1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345976AbjLLC3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345816AbjLLC2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:48 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD458EE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:28:43 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5d3758fdd2eso50362517b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348122; x=1702952922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDadoh3sC9nujQVrBPos5E8fmvZsF3sQWC418uY4Cbs=;
        b=dxdYWiQLlx6CnU5kD0QxPoqDd7uG5ayj5M9sjT1If/KWFku9+Pp/Xb4neP7pFZIy9e
         QHE8OovC+4K/D2pTyeKES56IdDB7r1HN+9c5PsZ5hsr1xrZ+5S44ev33Tp6/UILyrtgr
         zUTf3GHBtt6eA4PdTsrgs35ies93gFMr/NNHBQAj878cdAzwBUO2X/Z9F24yIaMK5pHg
         NoZlwIwmilOyRTiFfjY9jlhA+O19D7tLg59bcqzGfwCCeEtAcljr0MJOZXD58SczdXzL
         eGEv/+SK3DCk/3Q95YOeijOUrmFgzfnGKcLigVf2u7PSHrh72JJUWzotlSlTbGi52GEn
         Mmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348122; x=1702952922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDadoh3sC9nujQVrBPos5E8fmvZsF3sQWC418uY4Cbs=;
        b=WjPwH6iPTu/RCFf+nKwGFidWUWjLSL8NQbB0iovCnBuJ2ZGJOB4LWNlqys/iBnWMnG
         qod5+g1b2pxdFC0+vcXq1THbSfINfP/Ih6FzNWgzhdr/P+Gr9Tak1og44uFVOaOXqk9n
         gznrPNaamA5SCgPgiTJpM6ZK6TLG028lxPUGZTbFNLxIGSA0FPLwZgnvRJnQ7/rJH8Us
         iG3Dyr0AzAnvMyqwr9PROpIiAH2kst0iGhLzPg4N19La09g5Azd6dIJclK2dwBw5pjPs
         2Ck0QXrGf5HgZ17LZltvW5LOKnKX81msP1Bhm7TmOyHH38007Ym+CUtkGcRH3+cZm001
         Tc3g==
X-Gm-Message-State: AOJu0YzRPIQyVMsprLvNc8F8n3azrQdYzKWB0SXxHc+GK2GhgNJk7xRm
        /Uu+SP04ZPb8D+vBcu33j2FQs8wqCBQ3Xg==
X-Google-Smtp-Source: AGHT+IF4MiRLJg7zkL3OhNWCGnMtb0r24vkH27sZ9pFz/LYJwRM799+vxQS1413dV8ucCQ5S38CQjQ==
X-Received: by 2002:a0d:cb83:0:b0:5ca:71fe:4dbc with SMTP id n125-20020a0dcb83000000b005ca71fe4dbcmr3774094ywd.49.1702348122349;
        Mon, 11 Dec 2023 18:28:42 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id s7-20020a815e07000000b005b34d8b33ffsm3432482ywb.119.2023.12.11.18.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:41 -0800 (PST)
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
Subject: [PATCH v3 33/35] m68k: optimize get_mmu_context()
Date:   Mon, 11 Dec 2023 18:27:47 -0800
Message-Id: <20231212022749.625238-34-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_mmu_context() opencodes atomic find_and_set_bit_wrap(). Simplify
it by using find_and_set_bit_wrap().

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

