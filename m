Return-Path: <linux-kernel+bounces-112314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CC088783D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 12:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A542826E4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB2E171BA;
	Sat, 23 Mar 2024 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLIkyaAV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20C013FEA
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711193714; cv=none; b=EzEU8G1AFh8XStDys7zHB4pDeuWaao6ucHMjnoLyj83add8FqZ/ddJcqQt3Neg/9HeCIjaWuaCfF+WYCgvrBuiQokqBRS7xCH9wO8/QhH/c6a5eyeCb5SWuf2cOdBZu2OUJLi5JTzdAMXNAbFWFoG8vgCS1aMHO2qckpcVhsoXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711193714; c=relaxed/simple;
	bh=s3Msyc9z8t/gpktSf5g/K9aT1iYIR1/xxL+MBJH1F94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fVGAHY5neG0n0IvduWHc368Yq14wjic8HLj95TuPX12OnuKsV0ewptyL/aJNJPAkz+9SolRnFgJhMuF1KKl+94c/kLULhLn2ICEDasBTBtyc1mBGfBL7W7GOIL8k7NQdhHQW7NjibSKYb4L2dH6+TKoZW83DtwFHiZhpwai4OGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLIkyaAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2199C433C7;
	Sat, 23 Mar 2024 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711193713;
	bh=s3Msyc9z8t/gpktSf5g/K9aT1iYIR1/xxL+MBJH1F94=;
	h=From:To:Cc:Subject:Date:From;
	b=HLIkyaAVFf3l3DbhPZk9xviQiFV/PGYTECEs1BTZqZnoenoLlJYx1xvTka2Xflj4s
	 K1kxHD1db8ZLETyX1l9dUaYRgOQyqT53YjWx08x6nEtjpj4z45UYo+7Nb+KgelULNi
	 7QeXf8ZtKyST67cH3XrYNk+F4uf0AxxF6fJSC/zVhbvexyyO5IQ939J6JP8I4VJe7v
	 jLV3DY+mPInjpatl7g5TE3wqNDFCSRV2jW71xeMx0MkyCA9i8TE4Dvwt7jOvJKIeKx
	 1J1fGPX4n4ButwoQSsqJrJVfUZzbUGsNcfM4/B8Z0lIm4bB0Xpjk3m8GLFTBuFT7h3
	 IhsT5FtpJ+WUw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] riscv: merge two if-blocks for KBUILD_IMAGE
Date: Sat, 23 Mar 2024 20:35:00 +0900
Message-Id: <20240323113500.1249272-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In arch/riscv/Makefile, KBUILD_IMAGE is assigned in two separate
if-blocks.

When CONFIG_XIP_KERNEL is disabled, the decision made by the first
if-block is overwritten by the second one, which is redundant and
unreadable.

Merge the two if-blocks.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/riscv/Makefile | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 252d63942f34..a74e70405d3f 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -133,7 +133,15 @@ boot		:= arch/riscv/boot
 ifeq ($(CONFIG_XIP_KERNEL),y)
 KBUILD_IMAGE := $(boot)/xipImage
 else
+ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
+KBUILD_IMAGE := $(boot)/loader.bin
+else
+ifeq ($(CONFIG_EFI_ZBOOT),)
 KBUILD_IMAGE	:= $(boot)/Image.gz
+else
+KBUILD_IMAGE := $(boot)/vmlinuz.efi
+endif
+endif
 endif
 
 libs-y += arch/riscv/lib/
@@ -153,17 +161,6 @@ endif
 vdso-install-y			+= arch/riscv/kernel/vdso/vdso.so.dbg
 vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg:../compat_vdso/compat_vdso.so
 
-ifneq ($(CONFIG_XIP_KERNEL),y)
-ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
-KBUILD_IMAGE := $(boot)/loader.bin
-else
-ifeq ($(CONFIG_EFI_ZBOOT),)
-KBUILD_IMAGE := $(boot)/Image.gz
-else
-KBUILD_IMAGE := $(boot)/vmlinuz.efi
-endif
-endif
-endif
 BOOT_TARGETS := Image Image.gz loader loader.bin xipImage vmlinuz.efi
 
 all:	$(notdir $(KBUILD_IMAGE))
-- 
2.40.1


