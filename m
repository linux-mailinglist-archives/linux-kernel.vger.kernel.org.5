Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FAD7CB3B5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjJPUIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjJPUII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:08:08 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0578D83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:08:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so8615850a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697486884; x=1698091684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3//5wXEK6wkrq5JXyoehSNgqGXcQbC5VyDpkqHpeQLs=;
        b=O2MZwPvfMJ+NKUX+knSxLhGnaHJAg36Q7r42AnzBIEfBiLp6THJtG4RDDM4NwTJjvq
         z+ieQm5MjHnySv6YBsmZtEJB9IZYxJuDy5IQMhQZtXKeXC2jLWhMxi086yKAAkxtBBhV
         XXnBXnAvqrKdporJmxpxxwHJs1X0f7jkh/rbCG7INpj8bZmYDUlNO8wqDSPuQeShxQZ6
         Eb8ELlun6pSzMB8lLWORmg5uxOfcoZ5Rq8Y+myd3JSoOsy/7XrLCQHe1NZUWl6yDW8BW
         oKanAy9Ue3fLB+fCndzszNM67ByWqtcCvGrV8r32zqHku0gQjE3Roc8OUOz0haE+q+b/
         mNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697486884; x=1698091684;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3//5wXEK6wkrq5JXyoehSNgqGXcQbC5VyDpkqHpeQLs=;
        b=FIC72tYXASOMfzq90d/8NZ0g82+pY6mzqD2ztrLcOIwVVKv8N1+LeLv98rRS2H7noQ
         B7p5bMaFlQFeTWWyfKGRNv6JkwXV4Wu2dJE4Ta29xfCI2myY/5SQ2x5nrnmjKuGgL4d3
         D67hWAGLiTjiOfW1Vn/bKJR05s2DSwNnC685zUTZ03WSIeipP81QKU3cQpH56pOm3kjL
         BNJ7LBusDM5pFdgcHSpXOCZMLdx4FxWWWKak76ajuooi94YqonRO82veSjePUXMFuLr8
         t3Tfhp82FbaKoaFf/rV3M+iNtzHDa/7CDjtB4SUOIyRV1t5rkH8ilCHQ1Ld/CdbLPXVW
         0SoQ==
X-Gm-Message-State: AOJu0YyJXVcqriYvdYXZ1e/F1DSWXetlDE4O7EcMTNb6T5aon55NIeWR
        gMUNPTzWabGAqJHbMwjlL9s=
X-Google-Smtp-Source: AGHT+IE8K34aCkvuZc2wZVBO1jlEOeeJlH1dL2AAL+gpO2L4ndUet/4bry1ybEZvebM9xXEUPSe9wQ==
X-Received: by 2002:a17:907:31cd:b0:9ae:6ad0:f6db with SMTP id xf13-20020a17090731cd00b009ae6ad0f6dbmr69308ejb.71.1697486884051;
        Mon, 16 Oct 2023 13:08:04 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a13-20020a170906368d00b0099cf9bf4c98sm4571040ejc.8.2023.10.16.13.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:08:03 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/percpu: Use correct asm operand modifier in percpu_stable_op
Date:   Mon, 16 Oct 2023 22:07:30 +0200
Message-ID: <20231016200755.287403-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"P" asm operand modifier is a x86 target-specific modifier. When used
for a constant, it drops all syntax-specific prefixes and issues the
bare constant. This modifier is not correct for address handling,
in this case a generic "a" operand modifier should be used.

"a" asm operand modifier substitutes a nemory reference, with the
actual operand treated as address.  For x86_64, when a symbol is
provided, the "a" modifier emits "sym(%rip)" instead of "sym",
enabling shorter %rip-relative addressing.

Clang allows only "i" and "r" opreand constraints with "a" modifier,
so the patch normalizes the modifier/constraint pair to "a"/"i"
which is consistent between both compilers.

The patch reduces code size of a test build for 4072 bytes:

25519196        4388300  808452 30715948        1d4b02c vmlinux-new.o
25523268        4388300  808452 30720020        1d4c014 vmlinux-old.o

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/percpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 54746903b8c3..ac3220aeb779 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -194,9 +194,9 @@ do {									\
 #define percpu_stable_op(size, op, _var)				\
 ({									\
 	__pcpu_type_##size pfo_val__;					\
-	asm(__pcpu_op2_##size(op, __force_percpu_arg(P[var]), "%[val]")	\
+	asm(__pcpu_op2_##size(op, __force_percpu_arg(a[var]), "%[val]")	\
 	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
-	    : [var] "p" (&(_var)));					\
+	    : [var] "i" (&(_var)));					\
 	(typeof(_var))(unsigned long) pfo_val__;			\
 })
 
-- 
2.41.0

