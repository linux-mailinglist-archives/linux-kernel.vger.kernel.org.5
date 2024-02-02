Return-Path: <linux-kernel+bounces-49661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CE4846DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4A91F2722A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747C27F7E6;
	Fri,  2 Feb 2024 10:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AWEoLNam"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CF77A70F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869011; cv=none; b=uayDhnGffXtPuLy7L8VI3MXRRknR/2Oe4TUUXmKfbeEihR9Nnn7f3OFi7dwsaG8i6JThdM98TZd5XDaXU1poprO8EKy9ovhFdeQIrtjYNl/fK9hsE3dDS4mNtPDdDkau++tTykTcIXsqsezlkv0LNCRJM6SC/s8NSeONglFuU1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869011; c=relaxed/simple;
	bh=ChqR4pwLOMRrvI2mwMAhvrmBk7bFBrYJU+84/NDgMjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PbIKz/YQ89jblR3bHCv1n9lIFLEIA9jEQ+N0hM/fzWUPE/nJQKwS47P7j6fE+cW++qaNlYq9oYTXQEAeGRYNw5Obs8tf/s9XEX2LAg4zlSCmU96FOLn6V/6tCbuBgs5VRmgUulkeyC+yoJSMGxjC0kg3kmPaQCO9SnSj5eMvayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AWEoLNam; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d780a392fdso16102625ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 02:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706869006; x=1707473806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZoPcgm2ExbWiklFnpgC7jG0zZ989QvpgVdI0GYP0N0=;
        b=AWEoLNamHVOEhjRQA4YUhhy0Lz+hUkM/DOfssa1dOzcVR2fjw9kX6J6+8U3C7IzLnT
         l0y01pcgR9eNIKvkdkMQNamoKRtFiPYDtvz06KinRc/lCHUs/tDIy6DkY6MaLdnTaOaw
         m7MfTFkOMfPsAJtViKfegOoFEWyCa8Hn8pHOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706869006; x=1707473806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZoPcgm2ExbWiklFnpgC7jG0zZ989QvpgVdI0GYP0N0=;
        b=nnRU5xU6OL+qB7oFton+WyodRkuwPEZ+9lJ3FkmaJOmh4Xr2XHdAqYZDS6OQmNTFr/
         AmyPDV1Qd+tIsm2sO7lj1hxEIyx2YaJc0GeS+36rNwGDWpQaTRYZqs1h5/v3b3uH04c8
         GttrV0Z1IJcLs1qvd6uZGZyH/31C3+X7j8sHqHeipN7liJwWGHLPQT1A2e5KFLUwic32
         YEbvCX2MUMxr1WG0ii3smWU9tWvQRpp71Qz9s9QG94XjF9z193sckc8z7/WkRLlQlNJX
         YOmdcfcfjI+M+pHziPOC4ZG6CXkjptjEuMtAQtwBkzZnuCV9tnuJ4TLyOez0WxNrZLjW
         esmg==
X-Gm-Message-State: AOJu0YxnD35nrb7rgDDz2Mv1qoqKBs43/lBpWcxYsr177/1ARaHdcjl6
	TCbbwjkbiOpErGxRieI7ZigyoFBseQa4D0/e/gG8wwYPRw+Dkn+/MnFD2jMIww==
X-Google-Smtp-Source: AGHT+IFZZqecz2ffApEaxT7TLPhrkOmpZ7zCVX8hS1RbsMmyYzML6u2pv85e0w91QeAZXTSJ34nwvA==
X-Received: by 2002:a17:903:11cc:b0:1d9:4c1c:1982 with SMTP id q12-20020a17090311cc00b001d94c1c1982mr5628058plh.50.1706869006293;
        Fri, 02 Feb 2024 02:16:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXOeMEwTCrwVTk9AQndfLYbmDNRylcw0o2ibKbDnMznrN7x11BigeKNplTpQlrOOpph7WEjjuxpE37XcuRQfl/0SHfol6HMQr+MqIRtGDONtHO6dAl1jMs/Tl6W9r24YET09T7hCL/DO0FDFGjcrC72rvm4mB/vmqOvh1vxDsJyuLRWvJWw3/w4z5rtvEuZRPkMbGoipZgtg8rcJ41sXsdo3angUjuj0G8ec7QYPFYuwWy+m68cyEe81OcaIe8sLbj/3O4jmRH3AzegBGuGr90yL+ibNtmBIeC/OVpGpHJm2gVK0NWlmoly6bhTYXr6L9BOCB0Kg0OH0RhAQsjB8f7xNDxL3As4UhLZ0YCWsC0g+VHBc9hDuym9JMTH9yaR/XOKFsvfd43CsTc7PwSMu3sdUPXjMz+pCj9jczZeX5BQcIdGiFX5YT8STUPN3jjkdQkl2FR2og8L8USVcSWVqrGvoZz86uYU6tZqLZFUyIvexgzNZUgHwgBhfGx3SWl2sTnvtJiFkQqwa+BsspRXuZQwFGIPxhj3qP6TvyotG6foKdxoC+FcQSYbhRLIL6CX/nulbU7pIr8Ch9Utkr2d3zpj+PXBtF8WdCCWg1Y=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ks14-20020a170903084e00b001d963d963aasm1247928plb.308.2024.02.02.02.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 02:16:42 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Fangrui Song <maskray@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Bill Wendling <morbo@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 4/6] ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL
Date: Fri,  2 Feb 2024 02:16:37 -0800
Message-Id: <20240202101642.156588-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202101311.it.893-kees@kernel.org>
References: <20240202101311.it.893-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7713; i=keescook@chromium.org;
 h=from:subject; bh=ChqR4pwLOMRrvI2mwMAhvrmBk7bFBrYJU+84/NDgMjc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlvMEHFqznRoc47f8x3QBqsx9X6BtCiDiZKmRIR
 0EaK8ZbstmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZbzBBwAKCRCJcvTf3G3A
 JongD/4vXj5YeywVHimPvNTkjtoy7sRY1cQ7zCQ+0Hictm2B0DGz5Xk+fYxqkuRfc151mQ9m4RW
 hP/Nu0vNsr27XyXjaTp9nQ6ahzuF10bljtgK2IkLDZcNMmOIIyYoeEiQP77LDx8eSdT8g4BAsMh
 RWVq9uL+azlAB7GshQN1aC48YvnG3+ilmBoUryzPZq44ElHQ3imdRFx0QIB9uvCOHalfj0OEFzm
 LFFkPuCcG03ZQliO3kdl1J1rKlnJ2NScx4Rv6golBOfRozWCYjp1R5BTLDAotn+wLbFOshsHTir
 VSRCVP+LlRDHI0x7gdG8KFNrj8lcD4TLoTjz7pAlDq1AYVyQ1d2Nrob2lnKfNA8uzLgs8SoP8yo
 YkCJj1Gt9TvyIZZKqnqd6JgPANTPlc/uyAdyafJYYew8mAa2ts04DSpqWxna1uiTLUj3PCd8u5k
 RO2KY6Z2qcIsyanyIH3xHV5ivXuf1VL6vd2O568ewYuMOrPgrY0dGATL9aKYAHsVDlr0Y1iWh60
 WzYRH7kF4CJmKRh3Jmz19lehP4zo61sK83NIUBMxauh91KIEpurKTn9z8sRc82twKvcKOPv2IRD
 DMVj718hh+eiK507UGiwiIBqJY8/lm3ljxl+5UzgkmZhmTAPeq4I1i056gYcFjcE4J5ij4SVemG geww1McF0NisgJA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

For simplicity in splitting out UBSan options into separate rules,
remove CONFIG_UBSAN_SANITIZE_ALL, effectively defaulting to "y", which
is how it is generally used anyway. (There are no ":= y" cases beyond
where a specific file is enabled when a top-level ":= n" is in effect.)

Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Marco Elver <elver@google.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/dev-tools/ubsan.rst | 28 ++++++++--------------------
 arch/arm/Kconfig                  |  2 +-
 arch/arm64/Kconfig                |  2 +-
 arch/mips/Kconfig                 |  2 +-
 arch/parisc/Kconfig               |  2 +-
 arch/powerpc/Kconfig              |  2 +-
 arch/riscv/Kconfig                |  2 +-
 arch/s390/Kconfig                 |  2 +-
 arch/x86/Kconfig                  |  2 +-
 lib/Kconfig.ubsan                 | 13 +------------
 scripts/Makefile.lib              |  2 +-
 11 files changed, 18 insertions(+), 41 deletions(-)

diff --git a/Documentation/dev-tools/ubsan.rst b/Documentation/dev-tools/ubsan.rst
index 2de7c63415da..e3591f8e9d5b 100644
--- a/Documentation/dev-tools/ubsan.rst
+++ b/Documentation/dev-tools/ubsan.rst
@@ -49,34 +49,22 @@ Report example
 Usage
 -----
 
-To enable UBSAN configure kernel with::
+To enable UBSAN, configure the kernel with::
 
-	CONFIG_UBSAN=y
+  CONFIG_UBSAN=y
 
-and to check the entire kernel::
-
-        CONFIG_UBSAN_SANITIZE_ALL=y
-
-To enable instrumentation for specific files or directories, add a line
-similar to the following to the respective kernel Makefile:
-
-- For a single file (e.g. main.o)::
-
-    UBSAN_SANITIZE_main.o := y
-
-- For all files in one directory::
-
-    UBSAN_SANITIZE := y
-
-To exclude files from being instrumented even if
-``CONFIG_UBSAN_SANITIZE_ALL=y``, use::
+To exclude files from being instrumented use::
 
   UBSAN_SANITIZE_main.o := n
 
-and::
+and to exclude all targets in one directory use::
 
   UBSAN_SANITIZE := n
 
+When disabled for all targets, specific files can be enabled using::
+
+  UBSAN_SANITIZE_main.o := y
+
 Detection of unaligned accesses controlled through the separate option -
 CONFIG_UBSAN_ALIGNMENT. It's off by default on architectures that support
 unaligned accesses (CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y). One could
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0af6709570d1..287e62522064 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -29,7 +29,7 @@ config ARM
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if CPU_V7 || CPU_V7M || CPU_V6K
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_KEEP_MEMBLOCK
-	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_UBSAN
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index aa7c1d435139..78533d1b7f35 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -107,7 +107,7 @@ config ARM64
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
-	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_UBSAN
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
 	select ARM_GIC
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 797ae590ebdb..9750ce3e40d5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -14,7 +14,7 @@ config MIPS
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_UBSAN
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_USE_BUILTIN_BSWAP
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index d14ccc948a29..dbc9027ea2f4 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -12,7 +12,7 @@ config PARISC
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
-	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_UBSAN
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_NO_SG_CHAIN
 	select ARCH_SUPPORTS_HUGETLBFS if PA20
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b9fc064d38d2..2065973e09d2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -154,7 +154,7 @@ config PPC
 	select ARCH_HAS_SYSCALL_WRAPPER		if !SPU_BASE && !COMPAT
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
-	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_UBSAN
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if PPC_RADIX_MMU
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bffbd869a068..d824d113a02d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -37,7 +37,7 @@ config RISCV
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_DATA
 	select ARCH_KEEP_MEMBLOCK if ACPI
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index fe565f3a3a91..97dd25521617 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -82,7 +82,7 @@ config S390
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYSCALL_WRAPPER
-	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_DATA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5edec175b9bf..1c4c326a3640 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -100,7 +100,7 @@ config X86
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
-	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_UBSAN
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 04222a6d7fd9..0611120036eb 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config ARCH_HAS_UBSAN_SANITIZE_ALL
+config ARCH_HAS_UBSAN
 	bool
 
 menuconfig UBSAN
@@ -169,17 +169,6 @@ config UBSAN_ALIGNMENT
 	  Enabling this option on architectures that support unaligned
 	  accesses may produce a lot of false positives.
 
-config UBSAN_SANITIZE_ALL
-	bool "Enable instrumentation for the entire kernel"
-	depends on ARCH_HAS_UBSAN_SANITIZE_ALL
-	default y
-	help
-	  This option activates instrumentation for the entire kernel.
-	  If you don't enable this option, you have to explicitly specify
-	  UBSAN_SANITIZE := y for the files/directories you want to check for UB.
-	  Enabling this option will get kernel image size increased
-	  significantly.
-
 config TEST_UBSAN
 	tristate "Module for testing for undefined behavior detection"
 	depends on m
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index cd5b181060f1..52efc520ae4f 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -175,7 +175,7 @@ endif
 
 ifeq ($(CONFIG_UBSAN),y)
 _c_flags += $(if $(patsubst n%,, \
-		$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_SANITIZE)$(CONFIG_UBSAN_SANITIZE_ALL)), \
+		$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_SANITIZE)y), \
 		$(CFLAGS_UBSAN))
 endif
 
-- 
2.34.1


