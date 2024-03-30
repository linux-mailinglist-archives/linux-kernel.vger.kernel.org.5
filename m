Return-Path: <linux-kernel+bounces-125605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01DF89298A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 07:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52B081F2223E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 06:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83BA8C04;
	Sat, 30 Mar 2024 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl0RZ7So"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16017320B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 06:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711778764; cv=none; b=TukdR3O3WZ3AVZuF0Y3JLegdxCn1ueZ4MT/2G5nIg57ldtU0WEgkCpgtte4Hkau2JmNiVq8cYKTKQGO1vp8aihzClAYGCePm0hXkRLwbAkZVs0VF/OD60dxrHGGJ7LIpZNUVfRIeQm7sBK7SR5MnIjKQ6uB3meYgt9439H6x/7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711778764; c=relaxed/simple;
	bh=SWfX/RbvaJ6uB9jNBeoemQtYuqtBDiacIgkpF7oebdg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZaBtkN8gozh8m/xHg1KP5UDBzEI+ZFEAc2HBREWtVIGJPE8GN8uIEo3/Z+NxVFf9qbhmr8cKWm5q/a3dnw44RIJXSdYvqUNp3/AmtZVAWdFhWXdR4bDktleLsaYL2DYAzyDi565sYmg5lOZJzq66rXo0yphHepFYDdfoLE9iquc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl0RZ7So; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927EFC433C7;
	Sat, 30 Mar 2024 06:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711778763;
	bh=SWfX/RbvaJ6uB9jNBeoemQtYuqtBDiacIgkpF7oebdg=;
	h=From:To:Cc:Subject:Date:From;
	b=Bl0RZ7Sosh1AqQqFHnODsXMr1GJizm4FGuM7uPs1p8Fa5fnqnBj1HS/FYjggHTY0v
	 mkgs0XBQPOCxIeJwTKqbhZr0RXbrF3y3/Y+ArG0zJqAPH39OR5K+fQAtBXv/P0QK5m
	 1bf458+I38BgMn3k2KFjFAWk67Xz5LcjTiRCuTAttpA9QPH5Rp4TxRbfqtOIDSgJRw
	 /7p8dp5QCBfzgGLIj7d7gO/Xa7XwIleHfoEsj0D/+jVzgm3rR7ay6FgAuxyC/I6T3z
	 cLlf31wAe7KytixpaKh28EYi05O5vPUf64HDwMjZBaJyrpC0PaFDdr1y80YO5FsEJw
	 ZvtCjJLDdXkLw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/virt: use obj-y to descend into arch/x86/virt/
Date: Sat, 30 Mar 2024 15:05:54 +0900
Message-Id: <20240330060554.18524-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c33621b4c5ad ("x86/virt/tdx: Wire up basic SEAMCALL functions")
introduced a new instance of core-y instead of the standardized obj-y
syntax.

X86 Makefiles descend into subdirectories of arch/x86/virt inconsistently;
into arch/x86/virt/ via core-y defined in arch/x86/Makefile, but into
arch/x86/virt/svm/ via obj-y defined in arch/x86/Kbuild.

This is problematic when you build a single object in parallel because
multiple threads attempt to build the same file.

  $ make -j$(nproc) arch/x86/virt/vmx/tdx/seamcall.o
    [ snip ]
    AS      arch/x86/virt/vmx/tdx/seamcall.o
    AS      arch/x86/virt/vmx/tdx/seamcall.o
  fixdep: error opening file: arch/x86/virt/vmx/tdx/.seamcall.o.d: No such file or directory
  make[4]: *** [scripts/Makefile.build:362: arch/x86/virt/vmx/tdx/seamcall.o] Error 2

Use the obj-y syntax, as it works correctly.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/x86/Kbuild        | 2 +-
 arch/x86/Makefile      | 2 --
 arch/x86/virt/Makefile | 2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
index 6a1f36df6a18..cf0ad89f5639 100644
--- a/arch/x86/Kbuild
+++ b/arch/x86/Kbuild
@@ -28,7 +28,7 @@ obj-y += net/
 
 obj-$(CONFIG_KEXEC_FILE) += purgatory/
 
-obj-y += virt/svm/
+obj-y += virt/
 
 # for cleaning
 subdir- += boot tools
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 662d9d4033e6..5ab93fcdd691 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -251,8 +251,6 @@ archheaders:
 
 libs-y  += arch/x86/lib/
 
-core-y += arch/x86/virt/
-
 # drivers-y are linked after core-y
 drivers-$(CONFIG_MATH_EMULATION) += arch/x86/math-emu/
 drivers-$(CONFIG_PCI)            += arch/x86/pci/
diff --git a/arch/x86/virt/Makefile b/arch/x86/virt/Makefile
index 1e36502cd738..ea343fc392dc 100644
--- a/arch/x86/virt/Makefile
+++ b/arch/x86/virt/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y	+= vmx/
+obj-y	+= svm/ vmx/
-- 
2.40.1


