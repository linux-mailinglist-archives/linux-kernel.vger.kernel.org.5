Return-Path: <linux-kernel+bounces-124229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A48E8891428
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82401C2223B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76623FE27;
	Fri, 29 Mar 2024 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PvSiljmA"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A57A3FE2B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 07:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697088; cv=none; b=eC2zahFIw+LWlZWmBWw2d4AzudWpHbDtnyARLVRbBKm3zjgH6Wfx0KdhdoLgBZsStofQvYjLJVjzSGVP++Li6GVSdLDDNungsyMEi4YCww2eqeoRHyIAWo3P79klvv+yBBVTBtitp2eMzp9kEC7aIIyTwlCQpmxGCL3NaufZhh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697088; c=relaxed/simple;
	bh=WqXru62SFMywMewjfUP4xNPknFPzvsORsGQu0rgWXTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHlqAvZx4s/o2c/5XHuR5voHD+MWV/KsxUuhVI2fRjtmGqQm/rvz7q0hBqZfxsuftR15wgPUvQPPh3CZS5daIB+jJ3HSZtQY0aMOjq9uLQ2OQ8jWMyH9BKQFhRTtu9pD0CCO153xbIuKXEuyZT0KhGS3BUYUMstfz1BQ8HwkQJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PvSiljmA; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso1188496a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711697086; x=1712301886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfeToGq8Q96lZ3sXR0xrZDFoq0gdI38cqcIbuzYANg0=;
        b=PvSiljmANw4+nGm9IvYAIZcZ46UJHnthLIfXP9EX5Ct/9uIA9d88iU1P7AS6apSyao
         7FoApyKM7G6UbytCCWnHokwlAOuHnqBqcr5JyWqsyyAWiSDRmRCzqs6xl/nGi9tyPp7q
         GRlhyuNNcnO88hXWBWcui1oOklibnXfTbc9PXlPT+bwmg5tjaYCSCtupsH5Bprn1qcYc
         fzE1yoYZLcdkJsxvounQhAFb2mB9G4QqMzXn5BtkYXVX8kwi/dcHZ8M9crUY9K6hJ5M9
         kM7UXrzH7yJuqIV26Pqsb4MtmNtBGo3IJGp1IUZ8jJpZFxP7t+AVQ/1nseFI1SoFbotZ
         X1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697086; x=1712301886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RfeToGq8Q96lZ3sXR0xrZDFoq0gdI38cqcIbuzYANg0=;
        b=r6VuxiA1LZPlAYbaoZ0d4RhgmMffiLVQcbNxPCM1mVxXkgN/sITDm+qXlIWfg3XzBQ
         MS//r8uWGDakBqOWJ3nKB5WB+PX4cp/Z3cB0PyQjdUF5pscB1RSgWXWBxqXhIg1s61A2
         D/F+jLj5FMDY8onLVid5Xag/M+CmCj52TCRLFiyeXTBx1uzVzGE1UXnd7ROoBfPwThiq
         vqLXm1y0TwSMr0Pup6twiNrnamtGpIF/qqQfFZwbQYgnfyC/f2EQ/udWuUMb+XaEgXpE
         YMMrJqXafjcp7YbUn9UhOkrrvATqhIdBAI/fiXIOCq+NkGUPnWZqIDqEIYrJIgPbHYzi
         g6UQ==
X-Gm-Message-State: AOJu0YyXw/SmCzEFkKZnGeo9DFy5Sfd1Se9Nti41uqfJCuwGa6fLd82v
	yZgntaFHmoISWq2+AgQE3rXSFwVjhZnOZpPtD5ZRGcc7FY8tSP/bH14JIdzK2+s=
X-Google-Smtp-Source: AGHT+IGQfC9gwOMWVs1GDk/ouQ8mrl3lJb1JowaZL6ev/gV/g9creRjfkW6AQIWqS7U8Lf5+l0COxw==
X-Received: by 2002:a17:90a:4594:b0:2a2:88d:cdcb with SMTP id v20-20020a17090a459400b002a2088dcdcbmr1743529pjg.26.1711697086007;
        Fri, 29 Mar 2024 00:24:46 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:24:45 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 02/15] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Fri, 29 Mar 2024 00:18:17 -0700
Message-ID: <20240329072441.591471-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329072441.591471-1-samuel.holland@sifive.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARM provides an equivalent to the common kernel-mode FPU API, but in a
different header and using different function names. Add a wrapper
header, and export CFLAGS adjustments as found in lib/raid6/Makefile.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - Remove file name from header comment

 arch/arm/Kconfig           |  1 +
 arch/arm/Makefile          |  7 +++++++
 arch/arm/include/asm/fpu.h | 15 +++++++++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 arch/arm/include/asm/fpu.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b14aed3a17ab..b1751c2cab87 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -15,6 +15,7 @@ config ARM
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_KEEPINITRD
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_KERNEL_FPU_SUPPORT if KERNEL_MODE_NEON
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index d82908b1b1bb..71afdd98ddf2 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -130,6 +130,13 @@ endif
 # Accept old syntax despite ".syntax unified"
 AFLAGS_NOWARN	:=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
 
+# The GCC option -ffreestanding is required in order to compile code containing
+# ARM/NEON intrinsics in a non C99-compliant environment (such as the kernel)
+CC_FLAGS_FPU	:= -ffreestanding
+# Enable <arm_neon.h>
+CC_FLAGS_FPU	+= -isystem $(shell $(CC) -print-file-name=include)
+CC_FLAGS_FPU	+= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
+
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
 CFLAGS_ISA	:=-Wa,-mimplicit-it=always $(AFLAGS_NOWARN)
 AFLAGS_ISA	:=$(CFLAGS_ISA) -Wa$(comma)-mthumb
diff --git a/arch/arm/include/asm/fpu.h b/arch/arm/include/asm/fpu.h
new file mode 100644
index 000000000000..2ae50bdce59b
--- /dev/null
+++ b/arch/arm/include/asm/fpu.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
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
2.44.0


