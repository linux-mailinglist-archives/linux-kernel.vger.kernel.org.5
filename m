Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B037F3B05
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbjKVBIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbjKVBIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:08:30 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0439D47
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:25 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ce2eaf7c2bso3883743a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700615305; x=1701220105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8uQuAx5HbeGrqX4Ip/qQY7nv6lrxw4qacCJFbpKbko=;
        b=nXz2QW8m13PAMP28eJBbdowxNhob8TF/eJCZS1R2xO0VquNmNSxQv5NPcDTr5i1TPy
         4WHRT7idnD58/grgstzYoKrqbP96c9gZWrvEgO7oxDYeAjSEo+MYOcxj9OFlvWXliAYm
         dIyH0yBKAEhngtl5MEGBTwWc1kbH2XtSs/59IlPV7AmfSU30NVkbkBtBNJ46wxCkuEo9
         UkYn54jCqiPkVeYiVv5jzLLjH8vi0CI/qnnr+Bs+f2nYdO4YlpbWc55TQ1+x47Ainhpm
         1RlqdtJyurK8DQsuO6t2ETeDGom3rSzlQPYYwIz4v5VU14Fn24eqAK1I+NTivu+BD8KR
         KsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700615305; x=1701220105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O8uQuAx5HbeGrqX4Ip/qQY7nv6lrxw4qacCJFbpKbko=;
        b=OXsADn7ndgpc6XsEQmTrduJTWYIEWV+H7fcwpf0EnoRsPQklrw0yZQxoBWwrHhjfb2
         84bI+AJt25mnJ/nBATcawlNLrPx629Q9AhyYiQcNrq3peM8yfXFiF8/eXCyC6+frbtJP
         XATYclOHhTOc3z3ISip5YrIaxU9U6vtSBXRD3egZ7xDT8dk1wJWxI0Dig61DELKHTZie
         epPzfUgSpMtkOmpAQCK6n4NoKr97HwsU+5XewPkSvJqO5vyczTeoMUk1puJKCjhe6ayP
         FqUnWvyis4uzWtiGRUjhsZvcg6yAm+xt/R6eH6eNTrRwhEcWyCj2b8bb3NAWN9yYYo5n
         YDvw==
X-Gm-Message-State: AOJu0YwpZLzFf8gfwyZE6WYuN/bqOEr+BjXy9DraowP5riyxRzYvtlII
        b0/FeKBFZ4qJ3Bh4iElrhZq2AQ==
X-Google-Smtp-Source: AGHT+IHzY35P/bmGNlxsboL33Yxa5yN9S+7CxJ9PS0wbWCSnN9yRamcO2jnn4/Cd8sidyrAKu3XrJw==
X-Received: by 2002:a05:6870:9b0c:b0:1f5:b5ca:435e with SMTP id hq12-20020a0568709b0c00b001f5b5ca435emr1104182oab.52.1700615304951;
        Tue, 21 Nov 2023 17:08:24 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id bn5-20020a056a00324500b006be047268d5sm8713961pfb.174.2023.11.21.17.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 17:08:24 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 6/8] riscv: mm: Make asid_bits a local variable
Date:   Tue, 21 Nov 2023 17:07:17 -0800
Message-ID: <20231122010815.3545294-7-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122010815.3545294-1-samuel.holland@sifive.com>
References: <20231122010815.3545294-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is only used inside asids_init().

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v1)

 arch/riscv/mm/context.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index b5170ac1b742..43a8bc2d5af4 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -20,7 +20,6 @@
 
 DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
 
-static unsigned long asid_bits;
 static unsigned long num_asids;
 
 static atomic_long_t current_version;
@@ -226,7 +225,7 @@ static inline void set_mm(struct mm_struct *prev,
 
 static int __init asids_init(void)
 {
-	unsigned long old;
+	unsigned long asid_bits, old;
 
 	/* Figure-out number of ASID bits in HW */
 	old = csr_read(CSR_SATP);
-- 
2.42.0

