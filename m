Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9B980F748
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377315AbjLLTyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjLLTyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:54:04 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06E8A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:54:09 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40c2308faedso62660065e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702410848; x=1703015648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JvZSnb3frgLpz0T6ZYUyMh/rwMmfERMcSWI4MbVdOSg=;
        b=p//1Jm1aiKjuy56MVZ68YNmdwJRP31bLSUjEsqLMVgRlfb7av6pjVy2u7Vk4kQ/LFi
         9qr5jfisGQSZA63Pl41EqL0kR46jYFTkmHaO2HuVHtPFYT9tJGp159e6jFqp+9wcseCl
         DTWxCk4FniYgyf7QXxk78U2ttbYUZG+rMhgrtsZCoHsCNcpwXsSSbEUM2M5XZkqneDMa
         Ih+fSMqlVNXDH622RbYO5bOEuKTC10i1rGVawgY2422T3gfzxpj15XMTeMHHqc3IZbqJ
         6IxS3zLLk7xHi0JqKztT6BOF5veaDQi4YzZ06FqygV1b9OXJBqCaZAqAZTQLigF0HkEi
         CFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702410848; x=1703015648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvZSnb3frgLpz0T6ZYUyMh/rwMmfERMcSWI4MbVdOSg=;
        b=W5okq8+wOa+H/QNPxxsJOC/a6YWqL76iXXWi30BOyAy6+p/zAwxY+gK5m6JFs7LdNQ
         uYilYXS6gcvuC02x/EPKLcvQFLh2N3sBBxnX/AU18qd2W7+GlR5ktcI9iclF9xP/ZhUM
         Bje/sN0zDVz0TFAg+gbrltkrRXaN51TCGqZxPfRrwHezuXJcs/oVsa4owGFln1IPcWu0
         eqNykeYy9PiOm/+wOdj6tgzt4YNoUzgErm8lJlRk97qtNyrzTGhF/lEP4JqqbiWbJXHS
         A6z/3Xd9UO/ong6/QKrpGPhX5uFFy+Tbgpqy0D8Q0rv3faL1lktuLNeIxEH+bc0CsQSu
         qdWQ==
X-Gm-Message-State: AOJu0YxTvZq4sB/NfCLq+z3Sh9EQfZrEOisZIMTYeuI+k3Y7O2AxY+Kr
        WBKSXz8Xm9lATZBs8s43IztxbA==
X-Google-Smtp-Source: AGHT+IFX8nhEI0rbRpXhN/yjpVG2jYdKFpfLKOx+8sbynBMkPhmvV7Er0fQU4K1nNgFwq+Xh7r9xLQ==
X-Received: by 2002:a05:600c:2a41:b0:40c:32f1:816b with SMTP id x1-20020a05600c2a4100b0040c32f1816bmr3121626wme.162.1702410848328;
        Tue, 12 Dec 2023 11:54:08 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id e12-20020a05600c4e4c00b0040b398f0585sm17973419wmq.9.2023.12.12.11.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 11:54:07 -0800 (PST)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     syzbot+afb726d49f84c8d95ee1@syzkaller.appspotmail.com
Subject: [PATCH -fixes v2] riscv: Fix wrong usage of lm_alias() when splitting a huge linear mapping
Date:   Tue, 12 Dec 2023 20:54:00 +0100
Message-Id: <20231212195400.128457-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lm_alias() can only be used on kernel mappings since it explicitly uses
__pa_symbol(), so simply fix this by checking where the address belongs
to before.

Fixes: 311cd2f6e253 ("riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge linear mappings")
Reported-by: syzbot+afb726d49f84c8d95ee1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-riscv/000000000000620dd0060c02c5e1@google.com/
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

Changes in v2:
- Fix llvm warning about unitialized return value

 arch/riscv/mm/pageattr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index fc5fc4f785c4..96cbda683936 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -305,8 +305,13 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 				goto unlock;
 		}
 	} else if (is_kernel_mapping(start) || is_linear_mapping(start)) {
-		lm_start = (unsigned long)lm_alias(start);
-		lm_end = (unsigned long)lm_alias(end);
+		if (is_kernel_mapping(start)) {
+			lm_start = (unsigned long)lm_alias(start);
+			lm_end = (unsigned long)lm_alias(end);
+		} else {
+			lm_start = start;
+			lm_end = end;
+		}
 
 		ret = split_linear_mapping(lm_start, lm_end);
 		if (ret)
-- 
2.39.2

