Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D037B834A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243112AbjJDPOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjJDPO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:14:29 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C82ABF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:14:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4064e3c7c07so3944325e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696432464; x=1697037264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7cbbMj+E5ZBlob6bJSyN7OfL5gwM5MZRfPIQhkQ9FM=;
        b=XtVYV0xPiweJ42RdqZW5z23CDvkwCSO1o5sL7FQxS9vwUzsCc+B19wYL/40j3qYfwT
         LJaiNknfeNFOYgpO2/D3nfaC7u3+mpBnTcmUVNYYOvzMnUO4qqSDnAB5XUkpXLxhS7US
         xoxQeKvqVkFCS0k/lcWO1yxFvAUe7YXm42CXokxPZEicb2nqZKchRnNBVlM5rdgjz8F0
         NtQ5X1nuYruN2QtmqdGfJQfM0KtYZQzOdfj/U4WU6rVLoEP2p/2iWH9hUZgfAhOaBqXU
         0IbsX2f+UxIPZ/FcKr9+qPF3dDV9pHP3I52OUZhjRNcnm1I2tTI4WuyEUyAoVJZHrhhh
         ti1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696432464; x=1697037264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7cbbMj+E5ZBlob6bJSyN7OfL5gwM5MZRfPIQhkQ9FM=;
        b=r43ciMF4Dar/kwoR/CZsHNul9c3sUTlkz3j8MlR18cKvi4mEkS5Lge5calmKpu+t/U
         bCEHVxXJHmq5iXhN4ziAOtaTvsuqS8kmG+HVeq87A1OZQAF+/voXkjOOkTkIfsW8aKCG
         wjkAPlAwzxZnwBUGDAd/P6jbM7GpK4ssvRVvJmTNLZQ5ttPrdJlmlexd/kO5QvuD68Xs
         rcmue2gp0a/PxeOArhz8Jefnm5bQXCjnWnT3LKDTq1ggmBKAPmxWSkNKLzP7gkUPnyRV
         xIfhHRAy15oo1SLIvNu83gtZrmGA7MsGGwjBZ7auRvtE0caevytmxTmxr5uQCTH6grtS
         7NcQ==
X-Gm-Message-State: AOJu0YzCYOkLbB9uTZ8QQMf4vymZ1FnccbhZXnD7FAaegZ0xzQPDZZmI
        ZL4pQ6fkuIKEe8SOhBQC9kCndA==
X-Google-Smtp-Source: AGHT+IFUYTV7FQFGtTHrMfR1VYTiBZo398LRCCrHvZm7ekynuy7D8ReYeOuSobKwivtHrDzV0o76mg==
X-Received: by 2002:a05:600c:510b:b0:404:75cc:62e6 with SMTP id o11-20020a05600c510b00b0040475cc62e6mr2495282wms.3.1696432464039;
        Wed, 04 Oct 2023 08:14:24 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9474:8d75:5115:42cb])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b00402f7b50517sm1768764wmd.40.2023.10.04.08.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:14:23 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>,
        Conor Dooley <conor@kernel.org>
Subject: [PATCH v2 1/8] riscv: remove unused functions in traps_misaligned.c
Date:   Wed,  4 Oct 2023 17:13:58 +0200
Message-ID: <20231004151405.521596-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004151405.521596-1-cleger@rivosinc.com>
References: <20231004151405.521596-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace macros by the only two function calls that are done from this
file, store_u8() and load_u8().

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 46 +++++-----------------------
 1 file changed, 7 insertions(+), 39 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 378f5b151443..e7bfb33089c1 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -151,51 +151,19 @@
 #define PRECISION_S 0
 #define PRECISION_D 1
 
-#define DECLARE_UNPRIVILEGED_LOAD_FUNCTION(type, insn)			\
-static inline type load_##type(const type *addr)			\
-{									\
-	type val;							\
-	asm (#insn " %0, %1"						\
-	: "=&r" (val) : "m" (*addr));					\
-	return val;							\
-}
+static inline u8 load_u8(const u8 *addr)
+{
+	u8 val;
 
-#define DECLARE_UNPRIVILEGED_STORE_FUNCTION(type, insn)			\
-static inline void store_##type(type *addr, type val)			\
-{									\
-	asm volatile (#insn " %0, %1\n"					\
-	: : "r" (val), "m" (*addr));					\
-}
+	asm volatile("lbu %0, %1" : "=&r" (val) : "m" (*addr));
 
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(u8, lbu)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(u16, lhu)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(s8, lb)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(s16, lh)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(s32, lw)
-DECLARE_UNPRIVILEGED_STORE_FUNCTION(u8, sb)
-DECLARE_UNPRIVILEGED_STORE_FUNCTION(u16, sh)
-DECLARE_UNPRIVILEGED_STORE_FUNCTION(u32, sw)
-#if defined(CONFIG_64BIT)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(u32, lwu)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(u64, ld)
-DECLARE_UNPRIVILEGED_STORE_FUNCTION(u64, sd)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(ulong, ld)
-#else
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(u32, lw)
-DECLARE_UNPRIVILEGED_LOAD_FUNCTION(ulong, lw)
-
-static inline u64 load_u64(const u64 *addr)
-{
-	return load_u32((u32 *)addr)
-		+ ((u64)load_u32((u32 *)addr + 1) << 32);
+	return val;
 }
 
-static inline void store_u64(u64 *addr, u64 val)
+static inline void store_u8(u8 *addr, u8 val)
 {
-	store_u32((u32 *)addr, val);
-	store_u32((u32 *)addr + 1, val >> 32);
+	asm volatile ("sb %0, %1\n" : : "r" (val), "m" (*addr));
 }
-#endif
 
 static inline ulong get_insn(ulong mepc)
 {
-- 
2.42.0

