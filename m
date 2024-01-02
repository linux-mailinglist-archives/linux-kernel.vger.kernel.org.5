Return-Path: <linux-kernel+bounces-14094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9708217CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 306B7B2170B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424D3D507;
	Tue,  2 Jan 2024 06:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxdSmTFr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2B6D298;
	Tue,  2 Jan 2024 06:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBB7C433CC;
	Tue,  2 Jan 2024 06:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704178226;
	bh=4LDaa8miGX63GOCzm8SPiKzDeUQSHDxUGMUaV7Nkuco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxdSmTFrm9Xl4hfb9Rj5yaTAeLll/pSJ03NiplnrB6f8quiDI98TGCrSWBaEKH7/E
	 XoxAmn0Z/FOYZyPEAZXeDBYr3StoGhzK8qSEoRVQoVs7oOj+X9FKXrDBCtVEbEWyAg
	 x5HI6wm9ql+D/bO9MLHah+9ytmSkChINqoR6uuGRGAyKDljE8ERj6XG+EstHHc4m+0
	 786bVMAbSHJADyW+UB8KaJh2OybdAy63u/L1hNmMiffoE2taGlXZfPE9VyhsXt0nce
	 lRZzTY/bR6S6Y1OLG2RW0Ttyklhm7DaSn0OIp4G/MVL0Hqo1eJTbBXpa6pxzEe1ejO
	 uAYqOfkLEtksQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jerry Shih <jerry.shih@sifive.com>
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Phoebe Chen <phoebe.chen@sifive.com>,
	hongrong.hsu@sifive.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [RFC PATCH 05/13] RISC-V: hook new crypto subdir into build-system
Date: Tue,  2 Jan 2024 00:47:31 -0600
Message-ID: <20240102064743.220490-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102064743.220490-1-ebiggers@kernel.org>
References: <20240102064743.220490-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@vrull.eu>

Create a crypto subdirectory for added accelerated cryptography routines
and hook it into the riscv Kbuild and the main crypto Kconfig.

Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/riscv/Kbuild          | 1 +
 arch/riscv/crypto/Kconfig  | 5 +++++
 arch/riscv/crypto/Makefile | 4 ++++
 crypto/Kconfig             | 3 +++
 4 files changed, 13 insertions(+)
 create mode 100644 arch/riscv/crypto/Kconfig
 create mode 100644 arch/riscv/crypto/Makefile

diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
index d25ad1c19f881..2c585f7a0b6ef 100644
--- a/arch/riscv/Kbuild
+++ b/arch/riscv/Kbuild
@@ -1,11 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-y += kernel/ mm/ net/
 obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
+obj-$(CONFIG_CRYPTO) += crypto/
 obj-y += errata/
 obj-$(CONFIG_KVM) += kvm/
 
 obj-$(CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY) += purgatory/
 
 # for cleaning
 subdir- += boot
diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
new file mode 100644
index 0000000000000..10d60edc0110a
--- /dev/null
+++ b/arch/riscv/crypto/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
+
+endmenu
diff --git a/arch/riscv/crypto/Makefile b/arch/riscv/crypto/Makefile
new file mode 100644
index 0000000000000..b3b6332c9f6d0
--- /dev/null
+++ b/arch/riscv/crypto/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# linux/arch/riscv/crypto/Makefile
+#
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 70661f58ee41c..c8fd2b83e589b 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1512,20 +1512,23 @@ source "arch/arm64/crypto/Kconfig"
 endif
 if LOONGARCH
 source "arch/loongarch/crypto/Kconfig"
 endif
 if MIPS
 source "arch/mips/crypto/Kconfig"
 endif
 if PPC
 source "arch/powerpc/crypto/Kconfig"
 endif
+if RISCV
+source "arch/riscv/crypto/Kconfig"
+endif
 if S390
 source "arch/s390/crypto/Kconfig"
 endif
 if SPARC
 source "arch/sparc/crypto/Kconfig"
 endif
 if X86
 source "arch/x86/crypto/Kconfig"
 endif
 endif
-- 
2.43.0


