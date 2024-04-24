Return-Path: <linux-kernel+bounces-157312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC5D8B0FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26862B25995
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8184A1635AA;
	Wed, 24 Apr 2024 16:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezZeMQYb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDCF161902
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975951; cv=none; b=dQDHJ89p/JVf+734NlPZq8XUtSTnb7ZyA8i+mVYbV+ZizQHi9iQ9k1ivu8IAUMyOAXMRoIlr96UTANPPD/9j/MsrGfyBFTbFQc+QB+TnO/iFZ9ENmg68YxCJGx8C9sqzoUgd+6CPgL/I9rWjwro+OqKYtGMoSpd2muZllCxY0Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975951; c=relaxed/simple;
	bh=oI1b8kqDH/8miPXxoT7fdpUo4BcnLxtpPFTxdZ4YrOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u1X/KgnxeYnPnpGPb3V4fJZQq2EVPLTLVJqi57+CeTqvZwaCsFbs1njMrsVyYytY0WkxR5W/YqAgD+DRzl9xGOXg3pH8enV0iRaWrCCxFnOoAO477DQslgo32gP/LPD23I0atZt6Pd8u5R2pJHphcjxkMAfeYFoQvhcMI4R5ycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezZeMQYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239A4C113CD;
	Wed, 24 Apr 2024 16:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713975951;
	bh=oI1b8kqDH/8miPXxoT7fdpUo4BcnLxtpPFTxdZ4YrOM=;
	h=From:To:Cc:Subject:Date:From;
	b=ezZeMQYbPamei6p0XNikEjt50jhShYagX1GVtuubDlMFeYQwlB8zFqAEZa3qpJu3v
	 kjPQME8f5DLNfQ0uB7k57JVOFWz0e7F+LNdQzDxRawU0q3SDVIDaVQoesLp8tOYcxn
	 gqYFZd90JkltX0EcCEylSx5QI0vPTKplUKu6Se//BCR2maGmUswL18BeK3eqiozoku
	 GDgnJD0QkYgPhtVb0jTuMVXD9jO5CV3Z/xaZ5+7NtUJZZbpyhU484rjTXFwGiwzpD9
	 dolxUatwisI6b6aBcpq2MzPWBVoclg2q1vuRCcXt2ok4RDHun8h8arE2848sWFCyf+
	 B5+eF617qSxFw==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Pu Lehui <pulehui@huaweicloud.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] RISC-V: clarify what some RISCV_ISA* config options do
Date: Wed, 24 Apr 2024 17:25:21 +0100
Message-ID: <20240424-tabby-plural-5f1d9fe44f47@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5473; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=wk4E/pxggdkeSnKuNpxKb8WehqS3wGMKwrH1RMIGJ5A=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGmaRoVKV07vSDl9qMx0y/qCUsGlWffFpxcIPGBUmTI1t eOTzL5vHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhIWhEjw18vsd9HjqeUfNoi pPTEP3FBclv3K8H0xH3s894e/RhjtYThf5l9JLsdm/cb/dYuD3/DmRtlfT8lTr/K866fvfxA1vl +XgA=
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
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

Since this is a commit entirely about wording, I dropped both R-bs for
v2 as, while my intent hasn't changed, I've come up with a new set of
wordings.
v2 redoes some of the "detected by the kernel" wording to avoid stuff that
Drew pointed out was redundant & adds a wee bit more wording to the C
extension's stuff to be clear that it is a build time option.

CC: Samuel Holland <samuel.holland@sifive.com>
CC: Pu Lehui <pulehui@huaweicloud.com>
CC: Björn Töpel <bjorn@kernel.org>
CC: Andrew Jones <ajones@ventanamicro.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: linux-riscv@lists.infradead.org
CC: linux-kernel@vger.kernel.org
---
 arch/riscv/Kconfig | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6d64888134ba..8376595501ba 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -493,7 +493,8 @@ config RISCV_ISA_C
 	help
 	  Adds "C" to the ISA subsets that the toolchain is allowed to emit
 	  when building Linux, which results in compressed instructions in the
-	  Linux binary.
+	  Linux binary. This option produces a kernel that will not run on
+	  systems that do not support compressed instructions.
 
 	  If you don't know what to do here, say Y.
 
@@ -503,8 +504,8 @@ config RISCV_ISA_SVNAPOT
 	depends on RISCV_ALTERNATIVE
 	default y
 	help
-	  Allow kernel to detect the Svnapot ISA-extension dynamically at boot
-	  time and enable its usage.
+	  Add support for the Svnapot ISA-extension in the kernel when it
+	  is detected at boot.
 
 	  The Svnapot extension is used to mark contiguous PTEs as a range
 	  of contiguous virtual-to-physical translations for a naturally
@@ -522,9 +523,8 @@ config RISCV_ISA_SVPBMT
 	depends on RISCV_ALTERNATIVE
 	default y
 	help
-	   Adds support to dynamically detect the presence of the Svpbmt
-	   ISA-extension (Supervisor-mode: page-based memory types) and
-	   enable its usage.
+	   Add support for the Svpbmt ISA-extension (Supervisor-mode:
+	   page-based memory types) in the kernel when it is detected at boot.
 
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
-	  Say N here if you want to disable all vector related procedure
-	  in the kernel.
+	  Add support for the Vector extension when it is detected at boot.
+	  When this option is disabled, neither the kernel nor userspace may
+	  use vector procedures.
 
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
@@ -640,7 +641,7 @@ config RISCV_ISA_ZICBOZ
 	default y
 	help
 	   Enable the use of the Zicboz extension (cbo.zero instruction)
-	   when available.
+	   in the kernel when it is detected at boot.
 
 	   The Zicboz extension is used for faster zeroing of memory.
 
@@ -685,8 +686,9 @@ config FPU
 	bool "FPU support"
 	default y
 	help
-	  Say N here if you want to disable all floating-point related procedure
-	  in the kernel.
+	  Add support for floating point operations when an FPU is detected at
+	  boot. When this option is disabled, neither the kernel nor userspace
+	  may use the floating point unit.
 
 	  If you don't know what to do here, say Y.
 
-- 
2.43.0


