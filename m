Return-Path: <linux-kernel+bounces-136280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A31C89D22F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CF4283528
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A563B7F478;
	Tue,  9 Apr 2024 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="hzJ2U9k1"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353C07EEF4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643141; cv=none; b=sjKNFtiOcV1u0vFYH+yKBCZo/4GiEtM3M/+vhaz7lfPNGDJw++mNP/XVNxFrZzlIiXus1OOhl2gyINqs4qlU5Wng8ktOxWAFhWjOpHkX/vHnt47Q7vslNF+XmE8+0EFG8Ga7/n1SON6Ylm8zErtTUg4KgNwm+u0OR0Dp07py/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643141; c=relaxed/simple;
	bh=dTY/GwwtQQn+cv6gzN7QoMkNpekzSb9lOmQZaapsMdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j9qOCVJqWtxaWMbZlBtGzRkNi5Ob3Isezpyc9qSrb7IKdwfHSj2VKLwxz8SRz7n91Ddu2Sk5hAcfcd474Ly/RzMWVbFqmQg4fvGEu4R8xy4ZdymAVcMOCTqXMNjFAXl6s094FIMIvi6fzBrIc7yHyBOljm/ieCwPprU4F0PXYok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=hzJ2U9k1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so1318107b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712643139; x=1713247939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uNeXG8cnKNkHDs5z+HyiJ2ZiLa62BNigh2TpBUq9FE=;
        b=hzJ2U9k1zlqr7ns8JT4wdvxDe8wzZKQUR8z3C01UqZpH4lYAwDlJ5cEN0Vkn7/EcQ5
         cTo4+2s4KyLHBeugWq9NnkvEpU31J7b4nUfa5jpGOv6L2r6djmGFkTsVtDzMjV7NUV86
         V8Wn/FUfj8fW/afij0mndxGQD39Ym8nysg1RJ3HnURG2xldrnAp4OrNnQPTyBS5lJjYH
         SI8ILWh7zTawqQdF0OFNZ0YrSrcP2uj4FjQEWLAVB8UkVS5OlIktVthy42uuHUjSRgze
         f4jUZOPKrhsM2SIDROhE/jzXeNUtCaV56mFIxQVAe056OYics8pouGyaWU6kwJ5zMw7k
         3g3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643139; x=1713247939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uNeXG8cnKNkHDs5z+HyiJ2ZiLa62BNigh2TpBUq9FE=;
        b=gJrzAlzR/hiE/Ca8RD98yvHJAKa6bjg5XqGKJy4rHEM2oHpyghU9qadKG0e7Ce1Uoo
         +PeMDpeg2GKApEnDlWUwBfAgwnKQjQcuykzn2eIDPvZPrFkvgwVRTE8mQbBd/uZrZMRl
         4YYn/OPBHH73fP4/u3/PKP3sNtels1nX18Xzm6B0IFdLgnJps9ieT6Dyd/WIffw/HCyI
         w3xXRoumdeLgOrkMltWLJH28f2TEsv8pZfDFu4vUmWABPyaMKMes9SuW/5GdtJV2n4t4
         zqIbpwAPzv3zv3jk/kYEmSMO/PDIcZm0Dqovab3nshz5vSF4nhIUIMnSU5o8ixIk1sHv
         YNnw==
X-Forwarded-Encrypted: i=1; AJvYcCVZIclP/qzz+G58WbIzK+SP0QL86WiJDRAc+qDLdbpCPCJLobzKPhntI7u5+QtPn12Mv22+gVDK2IQFfgwvIZ2a+1w19jgh/sGUqXyn
X-Gm-Message-State: AOJu0YyvhXCgchMwNq3WAPwAoqinMkM7vCZ+BQNT7RqibXr+vOftdWqo
	7ODDi2NCYCjt0yYTfPFiUwPNdzeAOtIQU4PHYfOGtaLjKfsMtP0orXHGeL8ZVSE=
X-Google-Smtp-Source: AGHT+IGfw5gGVpfgehYAjws0Ix22Cm1DN/qW9eRm+J9+S7AHD87B900xvYwa0hBVxmABGwIoWI7SCg==
X-Received: by 2002:a05:6a20:2d28:b0:1a3:57b4:ed1c with SMTP id g40-20020a056a202d2800b001a357b4ed1cmr12934235pzl.25.1712643139603;
        Mon, 08 Apr 2024 23:12:19 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001e3dd5972ccsm5775564plf.185.2024.04.08.23.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:12:19 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	andy.chiu@sifive.com,
	debug@rivosinc.com,
	hankuan.chen@sifive.com,
	guoren@kernel.org,
	greentime.hu@sifive.com,
	samitolvanen@google.com,
	cleger@rivosinc.com,
	apatel@ventanamicro.com,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	waylingii@gmail.com,
	sameo@rivosinc.com,
	alexghiti@rivosinc.com,
	akpm@linux-foundation.org,
	shikemeng@huaweicloud.com,
	rppt@kernel.org,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	willy@infradead.org,
	jszhang@kernel.org,
	leobras@redhat.com,
	songshuaishuai@tinylab.org,
	haxel@fzi.de,
	samuel.holland@sifive.com,
	namcaov@gmail.com,
	bjorn@rivosinc.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	falcon@tinylab.org,
	viro@zeniv.linux.org.uk,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	hca@linux.ibm.com,
	arnd@arndb.de,
	kent.overstreet@linux.dev,
	boqun.feng@gmail.com,
	oleg@redhat.com,
	paulmck@kernel.org,
	broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: [RFC PATCH 11/12] riscv: Kconfig & Makefile for riscv kernel control flow integrity
Date: Mon,  8 Apr 2024 23:10:42 -0700
Message-Id: <20240409061043.3269676-12-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409061043.3269676-1-debug@rivosinc.com>
References: <20240409061043.3269676-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Defines `CONFIG_RISCV_KERNEL_CFI` and selects SHADOW_CALL_STACK
and DYNAMIC_SCS both so that zicfiss can be wired up.

Makefile checks if CONFIG_RISCV_KERNEL_CFI is enabled, then light
up zicfiss and zicfilp compiler flags.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig  | 36 +++++++++++++++++++++++++++++++++++-
 arch/riscv/Makefile |  6 ++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56..5276598bb773 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -193,7 +193,7 @@ config GCC_SUPPORTS_DYNAMIC_FTRACE
 	depends on $(cc-option,-fpatchable-function-entry=8)
 
 config HAVE_SHADOW_CALL_STACK
-	def_bool $(cc-option,-fsanitize=shadow-call-stack)
+	def_bool $(cc-option,-fsanitize=shadow-call-stack) || $(cc-option,-mabi=lp64 -march=rv64ima_zicfilp_zicfiss)
 	# https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a484e843e6eeb51f0cb7b8819e50da6d2444d769
 	depends on $(ld-option,--no-relax-gp)
 
@@ -211,6 +211,30 @@ config ARCH_HAS_BROKEN_DWARF5
 	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
 	depends on LD_IS_LLD && LLD_VERSION < 180000
 
+config RISCV_KERNEL_CFI
+	def_bool n
+	bool "hw assisted riscv kernel control flow integrity (kcfi)"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfilp_zicfiss)
+	select ARCH_SUPPORTS_SHADOW_CALL_STACK
+	select SHADOW_CALL_STACK
+	select DYNAMIC_SCS
+	help
+	  Provides CPU assisted control flow integrity to for riscv kernel.
+	  Control flow integrity is provided by implementing shadow stack for
+	  backward edge and indirect branch tracking for forward edge. Shadow
+	  stack protection is a hardware feature that detects function return
+	  address corruption. This helps mitigate ROP attacks. RISCV_KERNEL_CFI
+	  selects CONFIG_SHADOW_CALL_STACK which uses software based shadow
+	  stack but is unprotected against stray writes. Selecting RISCV_KERNEL_CFI
+	  will select CONFIG_DYNAMIC_SCS and will enable hardware assisted shadow
+	  stack protection against stray writes.
+	  Indirect branch tracking enforces that all indirect branches must land
+	  on a landing pad instruction else CPU will fault. This enables forward
+	  control flow (call/jmp) protection in kernel and restricts all indirect
+	  call or jump in kernel to a landing pad instruction which mostly likely
+	  will be start of the function.
+	  default n
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
 	default 8
@@ -639,6 +663,16 @@ config RISCV_ISA_ZICBOZ
 
 	   If you don't know what to do here, say Y.
 
+config TOOLCHAIN_HAS_ZICFILP
+	bool
+	default y
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfilp)
+
+config TOOLCHAIN_HAS_ZICFISS
+	bool
+	default y
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+
 config TOOLCHAIN_HAS_ZIHINTPAUSE
 	bool
 	default y
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 5b3115a19852..ae156e37e886 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -58,8 +58,10 @@ else ifeq ($(CONFIG_LTO_CLANG),y)
 endif
 
 ifeq ($(CONFIG_SHADOW_CALL_STACK),y)
+ifndef CONFIG_DYNAMIC_SCS
 	KBUILD_LDFLAGS += --no-relax-gp
 endif
+endif
 
 # ISA string setting
 riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
@@ -78,6 +80,10 @@ endif
 # Check if the toolchain supports Zihintpause extension
 riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) := $(riscv-march-y)_zihintpause
 
+ifeq ($(CONFIG_RISCV_KERNEL_CFI),y)
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZICFILP) := $(riscv-march-y)_zicfilp
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZICFISS) := $(riscv-march-y)_zicfiss
+endif
 # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
 # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
 KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
-- 
2.43.2


