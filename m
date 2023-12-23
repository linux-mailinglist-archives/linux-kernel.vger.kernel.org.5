Return-Path: <linux-kernel+bounces-10484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5AE81D4EF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 17:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1816283E14
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 16:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F77125A9;
	Sat, 23 Dec 2023 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTsd1xdh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371510979
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 16:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BAA3C433C8;
	Sat, 23 Dec 2023 16:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703347510;
	bh=9PwrcihFF5i7bY070ZxIROnCJMVZyvc9x7nf1yDV/Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTsd1xdhj0LqRZ2MgmYoGjWEEqLJbmKVgowayVJ83RFEE38PjtAEf+44jZP8EzkQG
	 Jjb9v+dvlONiF5uYgot39N5ERitQlH/cXWEdABAPR2sz8pudoLyzuxJtoOm6HnIPQk
	 a5W7QqkC+8oX/fjaJESoJeEHnv9X6osE2Mu9gIDMjFw7GUX0q9xVaqkuabOgH+Vd8z
	 lx1DXV3tTIDLOLBi7/jVN1TyRhOLgO6AOqBPqbJZgiXn6FIkKVAn7DnsgfsD4vwEOa
	 j0U/SW8P9Vuy+EvLOfUnfFFN0+6sOVyRBbStdXZc9Vffw7cdbbJln8FEd6vPeJE76b
	 OqctVbxiijVKA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Qingfang DENG <dqfext@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v3 1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
Date: Sat, 23 Dec 2023 23:52:25 +0800
Message-Id: <20231223155226.4050-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231223155226.4050-1-jszhang@kernel.org>
References: <20231223155226.4050-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some riscv implementations such as T-HEAD's C906, C908, C910 and C920
support efficient unaligned access, for performance reason we want
to enable HAVE_EFFICIENT_UNALIGNED_ACCESS on these platforms. To
avoid performance regressions on other non efficient unaligned access
platforms, HAVE_EFFICIENT_UNALIGNED_ACCESS can't be globally selected.

To solve this problem, runtime code patching based on the detected
speed is a good solution. But that's not easy, it involves lots of
work to modify vairous subsystems such as net, mm, lib and so on.
This can be done step by step.

So let's take an easier solution: add support to efficient unaligned
access and hide the support under NONPORTABLE.

Now let's introduce RISCV_EFFICIENT_UNALIGNED_ACCESS which depends on
NONPORTABLE, if users know during config time that the kernel will be
only run on those efficient unaligned access hw platforms, they can
enable it. Obviously, generic unified kernel Image shouldn't enable it.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig  | 12 ++++++++++++
 arch/riscv/Makefile |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 24c1799e2ec4..b91094ea53b7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -651,6 +651,18 @@ config RISCV_MISALIGNED
 	  load/store for both kernel and userspace. When disable, misaligned
 	  accesses will generate SIGBUS in userspace and panic in kernel.
 
+config RISCV_EFFICIENT_UNALIGNED_ACCESS
+	bool "Use unaligned access for some functions"
+	depends on NONPORTABLE
+	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	default n
+	help
+	  Say Y here if you want the kernel only run on hardware platforms which
+	  support efficient unaligned access, then unaligned access will be used
+	  in some functions for optimized performance.
+
+	  If unsure what to do here, say N.
+
 endmenu # "Platform type"
 
 menu "Kernel features"
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index a74be78678eb..ebbe02628a27 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -108,7 +108,9 @@ KBUILD_AFLAGS_MODULE += $(call as-option,-Wa$(comma)-mno-relax)
 # unaligned accesses.  While unaligned accesses are explicitly allowed in the
 # RISC-V ISA, they're emulated by machine mode traps on all extant
 # architectures.  It's faster to have GCC emit only aligned accesses.
+ifneq ($(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS),y)
 KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
+endif
 
 ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
 prepare: stack_protector_prepare
-- 
2.40.0


