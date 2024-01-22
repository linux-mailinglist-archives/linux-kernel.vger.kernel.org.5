Return-Path: <linux-kernel+bounces-32235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 825098358F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D7E1F227C8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 00:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782DF1C27;
	Mon, 22 Jan 2024 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXmmw0pF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA75A2A;
	Mon, 22 Jan 2024 00:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705882979; cv=none; b=XhSvMvvLrC8Jd4LNc+DErlN5/X3yYeGUja2Qx5IHiDTIuWV0H7lmSUewZ1gn+b85NzaGlB4DyWSf5hyjGJleUPDtY/3nfnc6IB6TOqko0YwUj75sj5taJc07BpQEYpwxMbZ6VyU6+E76bEKUQ82rIW0hRNhgnMaqiH6va/pLC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705882979; c=relaxed/simple;
	bh=TfofIEIKQZPK62dMUzgvPsR4BgvnYH75rA2YkgLkUvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jQKbO4LRaW7p06NSPmtPek+0Ku6ChON1v2Qoz4pyPJrZhN5K6qfoyj39BQfkzqFVLaJVZ2QXOSs8Rn5d3gCahMjMw6udTWDpJWUcNmknUDxlkq4/AJZm5SDXS/4CdPzlEQTqiGrHuFTk1nNlZNILhkU2j8bEh9ZQhlIy9b7eD/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXmmw0pF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B7AC43330;
	Mon, 22 Jan 2024 00:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705882979;
	bh=TfofIEIKQZPK62dMUzgvPsR4BgvnYH75rA2YkgLkUvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXmmw0pFKie1iTNEGrk1apBcAwNl0xXWYevupFo5OY/FbDJ0gEe1eAwyHLzA7rYHQ
	 VakSJ8WYLUyqbNKoG43mlsAbgUEmIi+4L7MOfvsXzbw+goo9lUw9srnKTF3WWZxAcx
	 5Kyk99bwbmRl0u1P9xi/Ckm6NM+xWGQ9wtW1LiUTcljq2RWn1wE0siEwMuLGMSZ+AB
	 uo/A4Mrgrlw8bHIKJEHwlxCGbeCTMJGN+crODJ/aydsCP2MQ3zIsOOLdjwJwr3iXG/
	 pf01EyzlGraH+P21AEXDaXGIhX99/gvlUl76GOOYaFAnYzf2O/awfYJ/4utJVT9X4Q
	 K/yt9e5HaL7hA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andy Chiu <andy.chiu@sifive.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	=?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
	Heiko Stuebner <heiko@sntech.de>,
	Jerry Shih <jerry.shih@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Phoebe Chen <phoebe.chen@sifive.com>,
	hongrong.hsu@sifive.com,
	Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v3 03/10] RISC-V: hook new crypto subdir into build-system
Date: Sun, 21 Jan 2024 16:19:14 -0800
Message-ID: <20240122002024.27477-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122002024.27477-1-ebiggers@kernel.org>
References: <20240122002024.27477-1-ebiggers@kernel.org>
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
 arch/riscv/crypto/Makefile | 1 +
 crypto/Kconfig             | 3 +++
 4 files changed, 10 insertions(+)
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
index 0000000000000..a4e40e534e6a8
--- /dev/null
+++ b/arch/riscv/crypto/Makefile
@@ -0,0 +1 @@
+# SPDX-License-Identifier: GPL-2.0-only
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 7d156c75f15f2..00e4aa16bf2bf 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1489,20 +1489,23 @@ source "arch/arm64/crypto/Kconfig"
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


