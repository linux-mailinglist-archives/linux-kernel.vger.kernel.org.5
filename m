Return-Path: <linux-kernel+bounces-116000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2554088991F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F6D2A1803
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C08839C1F9;
	Mon, 25 Mar 2024 03:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbR/x1kK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D95015FD1A;
	Sun, 24 Mar 2024 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322367; cv=none; b=sMi21V34REgSf9z3KguQvgYHOYPGM5ndRFHPKQpzsOE0gZlNKxMPinf33cfoiZUTgm6lQWqg6wbZBQ/FJnTNNkHIcJYhpFBBrjcMVmj0nevFVjmsoriIYc1fXyVggEGOXLzegxvD7Q/ZHdVExNHm5wYRRtgTfn/4RPbb2SlEyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322367; c=relaxed/simple;
	bh=R27CTNliboiG9ez/iXBakzPHknya3eT60HpHVzU5DHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmITuE/kxP9pCN4eBJ5/sT7ooDTlNd5OH+V8heqjuO6Tlkja9+mawMxopB70bzhdCpa323ZUWl0KbdyVlzLvUt3p9ktPjdSn4wSwUKRh48+EMDe2HNlmk5AgmQbqRiZQ1zuJqTblNz52B9tiFLOvUXDNG+Mm9sJfTS31py76yvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbR/x1kK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D08C43394;
	Sun, 24 Mar 2024 23:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322367;
	bh=R27CTNliboiG9ez/iXBakzPHknya3eT60HpHVzU5DHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbR/x1kKOHAEgW057aN9Jxyqj/1UEPV9DGUDCreVqr+eAhJmyinrx36fr8JLF+07H
	 aZPfIW3xbl3xjVVB7KsSGjI8d0NqZan8zTf9rXBYk+sHAvCgR/Ze4S7WkDMCCpjuGd
	 y2yhPMSZq/qojzeEXDcOgJhKmp+WASMabPeTBMxMCs5VC65pBB0Gl7mtahPpol2wbu
	 3Bsbst4qBUKdEFot+LRjafIA63PnxvSo2JSDJjviIAC3H3+LFGTZhGAE6Rk/GrilVr
	 vLgrRXXEcyyJ+kP7cOcUPcqqiBVJmhjmjJRHWVQPV1h33D49i5KH5OjTqwXKqcd+Eg
	 WimPs74JhI5tg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	stable@kernel.org,
	Radek Podgorny <radek@podgorny.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 449/451] x86/efistub: Clear decompressor BSS in native EFI entrypoint
Date: Sun, 24 Mar 2024 19:12:05 -0400
Message-ID: <20240324231207.1351418-450-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 784e1b2ae5ccd..aa07051459f52 100644
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
@@ -432,6 +434,8 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	efi_status_t status;
 	char *cmdline_ptr;
 
+	memset(_bss, 0, _ebss - _bss);
+
 	efi_system_table = sys_table_arg;
 
 	/* Check if we were booted by the EFI firmware */
@@ -950,8 +954,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
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


