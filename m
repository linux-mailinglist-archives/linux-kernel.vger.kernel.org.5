Return-Path: <linux-kernel+bounces-78394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605D28612E4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922D21C215F1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088B2823CC;
	Fri, 23 Feb 2024 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnagCjM0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F6823AE;
	Fri, 23 Feb 2024 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695525; cv=none; b=pTPsrx8VIZaSJ6AN9tjcp1IMu/4aTbA8iiNmxM11zBaEqfInDMgItrZdqHIzivmC90uwt2m9VspZRF+vT308pb92S2q0SOKSJIDyhZv9Mi/54Vh8wCGW/xMNHBpVnusBPifrLu6s3qCbHkV4DwYjj6E0VairnTCkBtw4bkAR7b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695525; c=relaxed/simple;
	bh=n7EJGb6r/9uWhXBTxysKjx17Y2iaQNTqlPUbVd030hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxERmYSxqCzqbm5LOvrItHeLk1lMJRWMeL7z+m6e0VGNECKG9urm4i+GtostmpWZ/0Me4sOku11MwW/oRowz2DUAGtGDzNdqm7Bpy6+mX3C297Eo7eXx9XIvjZfFogTVRwPF4Et6LpKBdLNu871aFJ6/leM250Acds/saPY7ITw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnagCjM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0BAC43399;
	Fri, 23 Feb 2024 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708695525;
	bh=n7EJGb6r/9uWhXBTxysKjx17Y2iaQNTqlPUbVd030hI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YnagCjM0KBRU4knIa5ukmyCLbIBQ79mVq8ZFaUsG4bPoq3W2BaAfbzZvmZXqEfMtQ
	 YYmdDI6hwLjWm88p8iugiOesjBI7iZxep5trLFczsqllK4hpZ/qXJGzNeDR4h2fg+J
	 XfR4Xs48Ge1PZ8kmw6IVM1ETX8+ykApcfKU7+kbEl0YfhUTmIh/6bCoD6J+79yZO55
	 2jPbKdE3fhQQWwIKWFQ8ZJSH78wyHoY0ZMjuiBRZb+ZZ9dEoc78qmnj6RZKr3Vlpot
	 L6eYVy1EjkbMwlLCm3iCTXf2YQDgGfCqRjRbPBj0PCbYI0ErS8EEwSqwMYIiQ5hXi8
	 6QYi5pY8GEQnA==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	rust-for-linux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 3/3] RISC-V: enable building 64-bit kernels with rust support
Date: Fri, 23 Feb 2024 13:38:05 +0000
Message-ID: <20240223-palatable-quintuple-ed221a517407@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240223-leverage-walmart-5424542cd8bd@spud>
References: <20240223-leverage-walmart-5424542cd8bd@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2571; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=dXiTCnXsPq6szb52W4FfTLrkIWRphwTLGk/WpEPIpxA=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKk35u+R+n7i+OwT39IUWaQPMGd9WVleuj/N9dhv5lkZX 950bXrd0VHKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJeL1nZNg/wWKXZM7OpDYn 8zeiOy94+N68+CslNMT1aGxkUqdO6GWGP1wisa+2BoUt0/q+ds2FPTL/DtavLuPzr4z/Oe/D15q /ZWwA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Miguel Ojeda <ojeda@kernel.org>

The rust modules work on 64-bit RISC-V, with no twiddling required.
Select HAVE_RUST and provide the required flags to kbuild so that the
modules can be used. The Makefile and Kconfig changes are lifted from
work done by Miguel in the Rust-for-Linux tree, hence his authorship.
Following the rabbit hole, the Makefile changes originated in a script,
created based on config files originally added by Gary, hence his
co-authorship.

32-bit is broken in core rust code, so support is limited to 64-bit:
ld.lld: error: undefined symbol: __udivdi3

As 64-bit RISC-V is now supported, add it to the arch support table,
taking the opportunity to sort the table in alphabetical order.

Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/rust/arch-support.rst | 1 +
 arch/riscv/Kconfig                  | 1 +
 arch/riscv/Makefile                 | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/Documentation/rust/arch-support.rst b/Documentation/rust/arch-support.rst
index 73203ba1e901..9e18a81fc2ef 100644
--- a/Documentation/rust/arch-support.rst
+++ b/Documentation/rust/arch-support.rst
@@ -16,6 +16,7 @@ support corresponds to ``S`` values in the ``MAINTAINERS`` file.
 Architecture   Level of support  Constraints
 =============  ================  ==============================================
 ``loongarch``  Maintained        -
+``riscv``      Maintained        ``riscv64`` only.
 ``um``         Maintained        ``x86_64`` only.
 ``x86``        Maintained        ``x86_64`` only.
 =============  ================  ==============================================
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5c59e00405e3..3eaae08e1d5c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -142,6 +142,7 @@ config RISCV
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RETHOOK if !XIP_KERNEL
 	select HAVE_RSEQ
+	select HAVE_RUST if 64BIT
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index ebbe02628a27..22fdb1e83744 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -34,6 +34,8 @@ ifeq ($(CONFIG_ARCH_RV64I),y)
 	KBUILD_AFLAGS += -mabi=lp64
 
 	KBUILD_LDFLAGS += -melf64lriscv
+
+	KBUILD_RUSTFLAGS += -Ctarget-cpu=generic-rv64
 else
 	BITS := 32
 	UTS_MACHINE := riscv32
-- 
2.43.0


