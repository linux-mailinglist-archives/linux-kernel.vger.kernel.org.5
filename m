Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0295C7B8040
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242544AbjJDNKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242548AbjJDNKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:10:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A70C4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:10:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-406553f6976so4704285e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696425028; x=1697029828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z15iGiezxYK5XcqIfgGulDEdBAkSg8R0+TumWNSNnqo=;
        b=vbnPtDiZGixJZvl6ozqL0YnBLNX8OsQURI+FOhAuZzPJwKKhNyl+i2uTV8+l4O54fI
         8S4U0aCdt0+B8JHCLjprcIvbmTFysRtcaRTuyJcgCqlsgGgJsFxyX4WIbTIeAqWAg1Bp
         W2+PsRmwHwyKNdAVOg93y7qoOfpjebbDAzDxxRCsipYPxnYb0HwMtyO/6SKMdr8JnAR9
         Q5xQ3JUy3jOvG3TbpsRuOTfO2n+ntMT8uYDWpW0sFMc96tsX+3F9XTM2nqOs3CGdkGZ9
         MtrS2b5XLLO9QRoiJdtWK8f50JdWzCdnysXajbvRtxVHRFX4zylWeN75eqmOEkAZ85Kd
         Bq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425028; x=1697029828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z15iGiezxYK5XcqIfgGulDEdBAkSg8R0+TumWNSNnqo=;
        b=gCuBjdtqZNhK0K01BqT+60ltDoKdquezhn/g+CqKle/ZruAqbusxOSBNMGktEKnSwA
         VwXsVCyodK5VsIed/Byswg61nv5of9fqFEbEr+4SaN5tc0zPYEDnxKkjrSnbnNghGjAO
         RP1WfvmXnYMniZHhwiewULCOhDoEIpptXu9y01vcWvL7zDWpOhqbHuY429M+4pSmr5TU
         MOKAx//mYSVzvaZim4WBlHccmnhMmIRYtPdF65Ticdt0QJLL0cbBsCo4liCUc0xJz8sn
         VUP2xkxdEB9VFs2mJBbXBRUAozqMiESeu+CE3akUV+YwHCC2iMFO4UfModaga+s5xav0
         2z3w==
X-Gm-Message-State: AOJu0Yz/DBBRmE+BoKUBN97N3VAQFo+QL++si9tM1Fl4uzp6yfSPTKVC
        0TRQ8FtBLpJPDWPBInd1JCRWRg==
X-Google-Smtp-Source: AGHT+IFnbZnW549ZWt1PzlFvEq2ZFwMTlc5GL20gDuzsNXnx6EeJFuLFcPl6tcuFSBDuZ7Gy71wyWw==
X-Received: by 2002:a7b:ca59:0:b0:3fe:d637:7b25 with SMTP id m25-20020a7bca59000000b003fed6377b25mr2345430wml.0.1696425027197;
        Wed, 04 Oct 2023 06:10:27 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:9474:8d75:5115:42cb])
        by smtp.gmail.com with ESMTPSA id m10-20020a7bce0a000000b00405953973c3sm1497074wmc.6.2023.10.04.06.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 06:10:26 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: blacklist assembly symbols for kprobe
Date:   Wed,  4 Oct 2023 15:10:09 +0200
Message-ID: <20231004131009.409193-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.42.0
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

Adding kprobes on some assembly functions (mainly exception handling)
will result in crashes (either recursive trap or panic). To avoid such
errors, add ASM_NOKPROBE() macro which allow adding specific symbols
into the __kprobe_blacklist section and use to blacklist the following
symbols that showed to be problematic:
- handle_exception()
- ret_from_exception()
- handle_kernel_stack_overflow()

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/include/asm/asm.h | 10 ++++++++++
 arch/riscv/kernel/entry.S    |  3 +++
 2 files changed, 13 insertions(+)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 114bbadaef41..9194e334de15 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -142,6 +142,16 @@
 	REG_L x31, PT_T6(sp)
 	.endm
 
+/* Annotate a function as being unsuitable for kprobes. */
+#ifdef CONFIG_KPROBES
+#define ASM_NOKPROBE(name)				\
+	.pushsection "_kprobe_blacklist", "aw";		\
+	RISCV_PTR name;					\
+	.popsection
+#else
+#define ASM_NOKPROBE(name)
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_ASM_H */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 143a2bb3e697..f24bc4eeedde 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -101,6 +101,7 @@ _save_context:
 1:
 	tail do_trap_unknown
 SYM_CODE_END(handle_exception)
+ASM_NOKPROBE(handle_exception)
 
 /*
  * The ret_from_exception must be called with interrupt disabled. Here is the
@@ -167,6 +168,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	sret
 #endif
 SYM_CODE_END(ret_from_exception)
+ASM_NOKPROBE(ret_from_exception)
 
 #ifdef CONFIG_VMAP_STACK
 SYM_CODE_START_LOCAL(handle_kernel_stack_overflow)
@@ -254,6 +256,7 @@ restore_caller_reg:
 	move a0, sp
 	tail handle_bad_stack
 SYM_CODE_END(handle_kernel_stack_overflow)
+ASM_NOKPROBE(handle_kernel_stack_overflow)
 #endif
 
 SYM_CODE_START(ret_from_fork)
-- 
2.42.0

