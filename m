Return-Path: <linux-kernel+bounces-114004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CC48887E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1538D28EF08
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2034A225200;
	Sun, 24 Mar 2024 23:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvgX/3Mj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D91F4184;
	Sun, 24 Mar 2024 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321151; cv=none; b=TqRztMULUmgCSsMVq97r0NfT1iKD7ntugHbk43+mUK3nWi67QeNc9iM248SuMlbXVYVD4VGEb0yBQ0m78QRCvLA0gy0u5ifeNfbwYfjDSL2uwNXcjE2+kcFj3O2xNQ8hbwAk+o+6PryRGjITC2sau8sosaA4nHbihnYOrsw4NKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321151; c=relaxed/simple;
	bh=zYRJyHjGPDedyr/ShRm7a7j5upuj+Z24YOyQgC2F6oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNvFqu/QAu/h4kfYQgohwmSYYgBI/xzA811itXL3q5bR2icLbUyn6dkXROMlkevNCihd9jCUnNm4u5XdlJPu1LdooVslhVwQwO2EgGgrhP390VE5LmOgKa8p+eYUZnGfuFmKHFGe7r3ch4jY7o0IQsf++8dm6SjR7idDWpPRodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvgX/3Mj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C49C433B1;
	Sun, 24 Mar 2024 22:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321149;
	bh=zYRJyHjGPDedyr/ShRm7a7j5upuj+Z24YOyQgC2F6oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kvgX/3MjnAKfr6FVTvpSVadlg3dHqHHDG9nkz4s/1KS88ERmJ4ANRSXIKdSTFMUXT
	 6o7Hd0/WJghXyTv/X81sYK0TNwJesQ4zjOEG+lIKIUhV5QLXJ4RvM4kFlkntUbP9Hc
	 vj/5oo16LWBD2cdzAgHxoLTdqe2HrXnizuKeOakHcbEXIoioL2+oTPmfwaosE9AYjC
	 1o1y7Akxo5F+CnTc/lxS1eSCqNpnZ+xJDouyNUtz3WZX9Rn/3GVnoGYD4/fIuG6PEb
	 vB9iXr+U2GfYKTt9Hm+0VATohSDQGdD9nUgAQ5h5G2OSa/Rnf7m9fO1o8JxrAWbsLX
	 Wgv9lL79duSHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	stable@kernel.org,
	Radek Podgorny <radek@podgorny.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 711/713] x86/efistub: Clear decompressor BSS in native EFI entrypoint
Date: Sun, 24 Mar 2024 18:47:17 -0400
Message-ID: <20240324224720.1345309-712-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ard Biesheuvel <ardb@kernel.org>

[ Upstream commit b3810c5a2cc4a6665f7a65bed5393c75ce3f3aa2 ]

The EFI stub on x86 no longer invokes the decompressor as a subsequent
boot stage, but calls into the decompression code directly while running
in the context of the EFI boot services.

This means that when using the native EFI entrypoint (as opposed to the
EFI handover protocol, which clears BSS explicitly), the firmware PE
image loader is being relied upon to ensure that BSS is zeroed before
the EFI stub is entered from the firmware.

As Radek's report proves, this is a bad idea. Not all loaders do this
correctly, which means some global variables that should be statically
initialized to 0x0 may have junk in them.

So clear BSS explicitly when entering via efi_pe_entry(). Note that
zeroing BSS from C code is not generally safe, but in this case, the
following assignment and dereference of a global pointer variable
ensures that the memset() cannot be deferred or reordered.

Cc: <stable@kernel.org> # v6.1+
Reported-by: Radek Podgorny <radek@podgorny.cz>
Closes: https://lore.kernel.org/all/a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/efi/libstub/x86-stub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 99429bc4b0c7e..681f576ec02a0 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -21,6 +21,8 @@
 #include "efistub.h"
 #include "x86-stub.h"
 
+extern char _bss[], _ebss[];
+
 const efi_system_table_t *efi_system_table;
 const efi_dxe_services_table_t *efi_dxe_table;
 static efi_loaded_image_t *image = NULL;
@@ -465,6 +467,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_status_t status;
 	char *cmdline_ptr;
 
+	memset(_bss, 0, _ebss - _bss);
+
 	efi_system_table = sys_table_arg;
 
 	/* Check if we were booted by the EFI firmware */
@@ -958,8 +962,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 void efi_handover_entry(efi_handle_t handle, efi_system_table_t *sys_table_arg,
 			struct boot_params *boot_params)
 {
-	extern char _bss[], _ebss[];
-
 	memset(_bss, 0, _ebss - _bss);
 	efi_stub_entry(handle, sys_table_arg, boot_params);
 }
-- 
2.43.0


