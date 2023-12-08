Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7140809C08
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573233AbjLHFzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:55:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjLHFzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:55:03 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E82171D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:55:08 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d0bcc0c313so12829145ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 21:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702014908; x=1702619708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y10I6kBvaoBdzCYCMFFIBpivZ4OdHpoiZkoWcSRPSMo=;
        b=LsZ+1abePke2lWjvnjGEMnRKRFedjn2235vw5scbYl+tO/bO6ZKjEikpE/NVfV2rQN
         wKhxHdX8X9kN7Tg5UjdnKKJotveENdlKlUExf8lqiyTUsdV/Th2SLK9K2mhQVqOkjh3+
         AVkIKXkrYFUUH1L7JT9ttyLOOFllpdEdAJZxKuwW4mWvq+OkT/vG+a0LpifJGKbhmMpA
         ktpJwCfL+mWYRX0+a0Mj6pMhEcU/yE6vEO1IrQnlBEnG/UMQCr8KFlO56qA5mXKGnK+U
         l1G1dzqzIRN2hV20Fro2IZLdtgtq9crtLriu8h3Fa4Xqlfl45rhJPr8sRyXrkV+A+X97
         BZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014908; x=1702619708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y10I6kBvaoBdzCYCMFFIBpivZ4OdHpoiZkoWcSRPSMo=;
        b=k4Fahvrr8ZfwCcE+7792eeD7Dd00h29Go4TJv94NDYKlWy6GXdfw0IIafnkAvbwK6A
         Zen/HqvJo222q89muB3OHw3TJ3EWrPBKoCjCSjw+hXbmlZqzXjKyuYsKRddGaw0lxPBT
         MI2QCcKQ2m4OkDMhJvZBddcrM4ZTqhH2l1Xy2tCOAgmmlakm4bsOVDZuO+qshGWTPYZB
         TB9BLawlnUpnaPnzCNyJr/9yHacu9KPl62LGi7GPdcXYkhRfGbS3mL18mWUAcXmpT6DI
         +HbpWtg5/waOj8TpwVoEpM+QsdC7kufiRZWy1lz5MgNbh6Fs78dMOITYDt0HNIU6RciO
         Pbww==
X-Gm-Message-State: AOJu0Yzwpmh8JOM1bZ1UOmYaM+W9PZSELYyy8YoY6JUWobDwMu7maXpM
        r49+zrWIrlwysyI8WSt6TNTkIQ+iT9qff+H/488=
X-Google-Smtp-Source: AGHT+IEV61WWeWMu7V3217Zpahk/hLH31IwX3YH3+NDaZQD5K6JU/sf2eERQjPEIU9FeQqZ//wlz9w==
X-Received: by 2002:a17:903:983:b0:1d0:bba1:57c1 with SMTP id mb3-20020a170903098300b001d0bba157c1mr3658032plb.78.1702014907827;
        Thu, 07 Dec 2023 21:55:07 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:55:07 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arch@vger.kernel.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [RFC PATCH 04/12] arm64: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date:   Thu,  7 Dec 2023 21:54:34 -0800
Message-ID: <20231208055501.2916202-5-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208055501.2916202-1-samuel.holland@sifive.com>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
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

arm64 provides an equivalent to the common kernel-mode FPU API, but in a
different header and using different function names. Add a wrapper
header, and export CFLAGS adjustments as found in lib/raid6/Makefile.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/arm64/Kconfig           |  1 +
 arch/arm64/Makefile          |  9 ++++++++-
 arch/arm64/include/asm/fpu.h | 17 +++++++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/fpu.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..485ac389ac11 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -30,6 +30,7 @@ config ARM64
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if KERNEL_MODE_NEON
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 9a2d3723cd0f..4a65f24c7998 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -36,7 +36,14 @@ ifeq ($(CONFIG_BROKEN_GAS_INST),y)
 $(warning Detected assembler with broken .inst; disassembly will be unreliable)
 endif
 
-KBUILD_CFLAGS	+= -mgeneral-regs-only	\
+# The GCC option -ffreestanding is required in order to compile code containing
+# ARM/NEON intrinsics in a non C99-compliant environment (such as the kernel)
+CC_FLAGS_FPU	:= -ffreestanding
+# Enable <arm_neon.h>
+CC_FLAGS_FPU	+= -isystem $(shell $(CC) -print-file-name=include)
+CC_FLAGS_NO_FPU	:= -mgeneral-regs-only
+
+KBUILD_CFLAGS	+= $(CC_FLAGS_NO_FPU) \
 		   $(compat_vdso) $(cc_has_k_constraint)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, psabi)
 KBUILD_AFLAGS	+= $(compat_vdso)
diff --git a/arch/arm64/include/asm/fpu.h b/arch/arm64/include/asm/fpu.h
new file mode 100644
index 000000000000..664c0a192ab1
--- /dev/null
+++ b/arch/arm64/include/asm/fpu.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * linux/arch/arm64/include/asm/fpu.h
+ *
+ * Copyright (C) 2023 SiFive
+ */
+
+#ifndef __ASM_FPU_H
+#define __ASM_FPU_H
+
+#include <asm/neon.h>
+
+#define kernel_fpu_available()	cpu_has_neon()
+#define kernel_fpu_begin()	kernel_neon_begin()
+#define kernel_fpu_end()	kernel_neon_end()
+
+#endif /* ! __ASM_FPU_H */
-- 
2.42.0

