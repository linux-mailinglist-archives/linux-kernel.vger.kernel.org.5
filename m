Return-Path: <linux-kernel+bounces-121935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D382C88EFAC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8DB1C2D79B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B6C1534E7;
	Wed, 27 Mar 2024 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZWOH2hwn"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494901E52C
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569723; cv=none; b=fI00wbrBmyAPdBQeygej3eLIR4TIkx4swrOYCMN8Id2EOmrfuKTmAIh40u4gS+Y9mF5NRg+T+TRiSBkzTBZjLz6nJk5x8urPiiKB6Hsqn25MtHTXaxxaMa2Ej3C2ISPDl/gKMlzERIa95tqlCsum9Z6NdxnesKwPPQKhN8DDkBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569723; c=relaxed/simple;
	bh=i2lJ+jD1bLDg/bvc+g8utHsarI18UNXJm0eesaXfmls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HClZwuzJHvm8wqgUuM5le0HmaU+MlpGvarRrGMw2tQJFERRF7l/DMD4ZUcjzaPbvXP63O7kbWwdEFJ/FaCre+Fr0Er9i27x7+0al/iKe45tui3FhxKqs+WV5At387lsjBAlltmp6IyvqRkwLNK2tjSMlKFzzELMOYMBq7x4/fE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=ZWOH2hwn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e0d82d441bso2009615ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569721; x=1712174521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=im7zmQeDt7pZodE0p+VySjAa7DBv0KaW+gKoLu+LS/g=;
        b=ZWOH2hwnFGcioI7v46sWq88vqrfCybD+vdZmF5/CqBOu0YNbPAZAMyfhcUHMbpHdp7
         TP4HtYYft3srYXixuihqErvsU2nR536e4E549NfIZc4AOgMF9PSvn5eOoXVsSzQwq+8s
         bV4W3b3mxer1kgfPw/7EtR3tUhxq9Sly7JWJNnPrGLXg5YEJ3IyIY6VPiqra8v+3AMOg
         SLFt/B9j98UTYHJ0in4Kocp1IAdcxlyWEHflqyzgU+LZ9/IO03vzUVWlxHHsIIm7WSKw
         fsqJO9HYBdWTm9KEJj2LE4j+1To7tDy0J0Nw+iaVjzpO2rwZ5XEmX/XRvtk3jW6Bnf34
         84NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569721; x=1712174521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=im7zmQeDt7pZodE0p+VySjAa7DBv0KaW+gKoLu+LS/g=;
        b=MUUWZ++jRrfkTmQEjZHlswjJnIA2qQQnak9V7aAhlmFesqj+7PGi5seM0uSM9tmfrv
         YwA/R/VNNhHJcmbEkQLcJJEbDf+nnomvBzn6KGadCv5OAZhYvjtQFd/hCWFxNEsgi0DW
         vXZg/Zj6htFKYqm34+Atz+7+EHlrfm0j4fbjc+xzrkuuxboJBTu9pPi/nVS3eV33aelB
         j6YVaD5zmnJtT8uTaVY/Bom+qtXNESnvq764Zq1ukqge04orhKCNRZ6YN4EVXdsKO0VJ
         m0itCk5TQjkS/IjDCxWXEtdhwhDv471WfiTeI5tp0+o6q8+pwzitat9ODJkK5O4qS176
         oL7g==
X-Gm-Message-State: AOJu0YzGurvfHPFFMo1TtAu+ZIlNmm0oRifJ++ur30oDPaLGU1X+pspJ
	NXKXVbGTZxnSjRQSVPERbNAFb2tj3H2+jyT2e5UMiWJuIlYVDx4iTKl0us8kzePpQnoU0Jigv8v
	e
X-Google-Smtp-Source: AGHT+IF+ykWlXq/2p9fLdxe5qiT+fQJVLXU8yD1cTqgZWIiJ9yzpflW/8jhLl1LVX7Yz7XdGYJsgng==
X-Received: by 2002:a17:903:28e:b0:1e0:d6ce:7e16 with SMTP id j14-20020a170903028e00b001e0d6ce7e16mr805365plr.15.1711569721663;
        Wed, 27 Mar 2024 13:02:01 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:01 -0700 (PDT)
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
Subject: [PATCH v3 02/14] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Date: Wed, 27 Mar 2024 13:00:33 -0700
Message-ID: <20240327200157.1097089-3-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327200157.1097089-1-samuel.holland@sifive.com>
References: <20240327200157.1097089-1-samuel.holland@sifive.com>
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
2.43.1


