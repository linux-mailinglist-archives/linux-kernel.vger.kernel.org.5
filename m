Return-Path: <linux-kernel+bounces-115747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0160889769
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2CB1C30A04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF2116D9C2;
	Mon, 25 Mar 2024 02:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDU2SSI6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F18156F41;
	Sun, 24 Mar 2024 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321907; cv=none; b=BicSaRhT8h0j0ta9dXTLJ5kdqqTkRuVFqT8Ef/ff8XDZwCzd6cVcyMkrcWrXGOWL3Dfh+yiPmEl0d2a7XomiOkoFyD+52OAoxf828h5Eb9BlokOGWACYSUzosXodY+haZxuTXlOyBq3OMlUNj7p98LAAL6AKD6xIkYDd7cQ6e9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321907; c=relaxed/simple;
	bh=mzQypdRQqwHtug1bhUTv6rpPGwe7Il+eUxhskgq8Mck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRuGqhtmxNPyEBiF9eegHHocvVes5xGBGCkLdzwHsuSiyoZsm4bguk6NqFHXz84v8F8ypCVrrV3zDVGwioIfspyXTRD/PzH+6fwFI98dETaaSMvDBOi1akvLpSLbBNzM3Szc5oH/nBj/fHEgFHEerpYCd/YIv21bTNA7q48Jtjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDU2SSI6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EA2C433B1;
	Sun, 24 Mar 2024 23:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321907;
	bh=mzQypdRQqwHtug1bhUTv6rpPGwe7Il+eUxhskgq8Mck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rDU2SSI6scyh2+kyt7pFVfkj53A/XYFoTRvDQsEMEsduWyf5nEzXvvwBmwdTG3hVy
	 btZ2tblo+OiEHgnSQuhg2IgSIO3vH1e1SAglH1AmVXIeIEFLBfBZvMHEr+juYN61mL
	 M/p/JiN1sTVXH05AmeDIy62vjElvQq2KNETVdNOaJwil4up3p4z3WjPi9tOS21pAzY
	 Mift+hAwGsIi81tUHJHXaqqcNw7Xa41f0FVoh0sxLmkECaSP2nFnMmGJ4hnYMpDM2h
	 U+g2XteiHo2t8OrYzojpaQHfiVcFzbTJAe7oZImImqEN5mcxSF5jqDCREYGqcqGVJo
	 UTsMwuJ8zfhHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	stable@kernel.org,
	Radek Podgorny <radek@podgorny.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 636/638] x86/efistub: Clear decompressor BSS in native EFI entrypoint
Date: Sun, 24 Mar 2024 19:01:13 -0400
Message-ID: <20240324230116.1348576-637-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 7bcc5170043fc..90f18315e0247 100644
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
@@ -956,8 +960,6 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
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


