Return-Path: <linux-kernel+bounces-150295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC8B8A9CED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FBE1F214EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AE516C865;
	Thu, 18 Apr 2024 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOtcW97s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ECB16D314
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713450092; cv=none; b=ctTG/+cXSnav6G36+zxU5URmxMYYGetLX9rQEcL022wmZp8a1VIY4quKLwHYkcF+/1/Mo4dalT5Yr3xMmBRDWAMgKGV0kX6L/htyaA/z87xIW43JeT5eJAJFXxC6E4SZq4eyzzgQlw+7hHYXHtGa/h/wups1dj+obSNDNUR6NQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713450092; c=relaxed/simple;
	bh=aUM0Xf17pxFUy6Cr+9PH1jkH+tLH18RFiiZ8wiEHNyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BzdXIrkfM3wbP/mHoT44hB6H6+XdG95xQTRqFutseVgCVGw9Z0bC7yJbQps17V+64R1Lgh+M4Ev0tf3BG/t4xt747fAAopfHGhnXMbEBElZ6/Dzh7+suDeCoOwILzPXL/eRqfMOtx8r89ocXNbvMs3drBTAmX/7ixiIDhkE0LX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOtcW97s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF75C113CC;
	Thu, 18 Apr 2024 14:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713450092;
	bh=aUM0Xf17pxFUy6Cr+9PH1jkH+tLH18RFiiZ8wiEHNyg=;
	h=From:To:Cc:Subject:Date:From;
	b=OOtcW97s6gnerm+tffJItV7ew9zy1ZhSrvMo02RgX0ZKyCqH6YI5v/LvsHbYyrfBB
	 gHtxJJeMGexhCWow0EK+VYT+ar3LU591BkU1ndoautpWZxkuXlKYO6a6BUSZR8nLNY
	 POIswoimSwvsP6a5nlfoLxsakWhfbzrnOwBitY9ssyuNsPEuDltVnVxtvuI/hMq76N
	 vG/Uog8auWPLN8QpGxPIG7zFvcyW2UetfjQrfTYAWTtqll7jYLh/vxxM/BWCRXH8p3
	 zonPVmBcl85quvEQ/cXPfaZpLHhOE3Qz1qUPbCkp1E8hTUmM/IomwlLI8XYgv/u34w
	 RXKqNFZFD87wA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Pu Lehui <pulehui@huaweicloud.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] RISC-V: clarify what some RISCV_ISA* config options do
Date: Thu, 18 Apr 2024 15:21:01 +0100
Message-ID: <20240418-stable-railway-7cce07e1e440@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4357; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=mdQDYpXoXxz/xowCTUoQTmMv0Y172vMgP0KsAfRXkKE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmKOj7ijzraWDadNrNUnVy24Kh8zi7FjO0bDi6oktvrm 1VoIn+wo5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABN5rMrwP41vk132s/6tRlWP jm7l3xzx+OFFI/PLlVKaTpwHQ/jvHmNk+KKwUNf42umu6KN3PkjVHz4RkOm/J42Ro/B5Q/jHCXW XuQE=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

During some discussion on IRC yesterday and on Pu's bpf patch [1]
I noticed that these RISCV_ISA* Kconfig options are not really clear
about their implications. Many of these options have no impact on what
userspace is allowed to do, for example an application can use Zbb
regardless of whether or not the kernel does. Change the help text to
try and clarify whether or not an option affects just the kernel, or
also userspace. None of these options actually control whether or not an
extension is detected dynamically as that's done regardless of Kconfig
options, so drop any text that implies the option is required for
dynamic detection, rewording them as "do x when y is detected".

Link: https://lore.kernel.org/linux-riscv/20240328-ferocity-repose-c554f75a676c@spud/ [1]
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

Vector copy-paste-o fixed, correct spelling of optimisations kept.

CC: Samuel Holland <samuel.holland@sifive.com>
CC: Pu Lehui <pulehui@huaweicloud.com>
CC: Björn Töpel <bjorn@kernel.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 arch/riscv/Kconfig | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6d64888134ba..c3a7793b0a7c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -503,8 +503,8 @@ config RISCV_ISA_SVNAPOT
 	depends on RISCV_ALTERNATIVE
 	default y
 	help
-	  Allow kernel to detect the Svnapot ISA-extension dynamically at boot
-	  time and enable its usage.
+	  Add support for the Svnapot ISA-extension when it is detected by
+	  the kernel at boot.
 
 	  The Svnapot extension is used to mark contiguous PTEs as a range
 	  of contiguous virtual-to-physical translations for a naturally
@@ -522,9 +522,9 @@ config RISCV_ISA_SVPBMT
 	depends on RISCV_ALTERNATIVE
 	default y
 	help
-	   Adds support to dynamically detect the presence of the Svpbmt
-	   ISA-extension (Supervisor-mode: page-based memory types) and
-	   enable its usage.
+	   Add support for the Svpbmt ISA-extension (Supervisor-mode:
+	   page-based memory types) when it is detected by the kernel at
+	   boot.
 
 	   The memory type for a page contains a combination of attributes
 	   that indicate the cacheability, idempotency, and ordering
@@ -543,14 +543,15 @@ config TOOLCHAIN_HAS_V
 	depends on AS_HAS_OPTION_ARCH
 
 config RISCV_ISA_V
-	bool "VECTOR extension support"
+	bool "Vector extension support"
 	depends on TOOLCHAIN_HAS_V
 	depends on FPU
 	select DYNAMIC_SIGFRAME
 	default y
 	help
 	  Say N here if you want to disable all vector related procedure
-	  in the kernel.
+	  in the kernel. Without this option enabled, neither the kernel nor
+	  userspace may use vector.
 
 	  If you don't know what to do here, say Y.
 
@@ -608,8 +609,8 @@ config RISCV_ISA_ZBB
 	depends on RISCV_ALTERNATIVE
 	default y
 	help
-	   Adds support to dynamically detect the presence of the ZBB
-	   extension (basic bit manipulation) and enable its usage.
+	   Add support for enabling optimisations in the kernel when the
+	   Zbb extension is detected at boot.
 
 	   The Zbb extension provides instructions to accelerate a number
 	   of bit-specific operations (count bit population, sign extending,
@@ -625,9 +626,9 @@ config RISCV_ISA_ZICBOM
 	select RISCV_DMA_NONCOHERENT
 	select DMA_DIRECT_REMAP
 	help
-	   Adds support to dynamically detect the presence of the ZICBOM
-	   extension (Cache Block Management Operations) and enable its
-	   usage.
+	   Add support for the Zicbom extension (Cache Block Management
+	   Operations) and enable its use in the kernel when it is detected
+	   at boot.
 
 	   The Zicbom extension can be used to handle for example
 	   non-coherent DMA support on devices that need it.
@@ -686,7 +687,8 @@ config FPU
 	default y
 	help
 	  Say N here if you want to disable all floating-point related procedure
-	  in the kernel.
+	  in the kernel. Without this option enabled, neither the kernel nor
+	  userspace may use floating-point procedures.
 
 	  If you don't know what to do here, say Y.
 
-- 
2.43.0


