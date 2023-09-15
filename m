Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D9B7A1ACD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjIOJik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjIOJi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:38:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893081FFE;
        Fri, 15 Sep 2023 02:38:09 -0700 (PDT)
Date:   Fri, 15 Sep 2023 09:37:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694770670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gqu6Nk4eu/qbxmuvCEJNwbWI36cRFH74ZZtWhng7yLM=;
        b=g3GmNPs5p7zwUln2W5QWbSkyPKcO7j/JKkACe/V8gO9oNYNalq8hSw4dV/uTRM+7gF7P1O
        PgRhtgmDJO7WEU/Y3aDeacRWqzp8+wRpeJKhFHOujUbyQNDrZlvx6oZH3hMMKlCjZG+tYG
        KZei0AkRG9PjK+dGVFwKlq+MApnilDRtz7gQqDNxAHh3PNjmAlp2i8luJw9LwYdnAqlxi2
        mGf+1lHDGSOIZe6XlrryCR6lFUmc6T9TIMuZipWmWhU0uUIERgr6H1Lcn+k35zvOv9v0Z7
        MhhjEv9ZJAK/z7xyBF/3Y760F1k8NSdZKdvJWR0pMVDjDqhIOFmKdgU1GegN3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694770670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gqu6Nk4eu/qbxmuvCEJNwbWI36cRFH74ZZtWhng7yLM=;
        b=+neiJaCHJdlJEp5bVOAKtIjTb5xvZy38WYeuLaA5YDLnntU1DKlKVU/yCOXFJbE3iVYApg
        O9jy76pxdalKtYDg==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/efi: Disregard setup header of loaded image
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230912090051.4014114-19-ardb@google.com>
References: <20230912090051.4014114-19-ardb@google.com>
MIME-Version: 1.0
Message-ID: <169477066941.27769.15794634265281433984.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     7e50262229faad0c7b8c54477cd1c883f31cc4a7
Gitweb:        https://git.kernel.org/tip/7e50262229faad0c7b8c54477cd1c883f31cc4a7
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 12 Sep 2023 09:00:53 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 11:18:40 +02:00

x86/efi: Disregard setup header of loaded image

The native EFI entrypoint does not take a struct boot_params from the
loader, but instead, it constructs one from scratch, using the setup
header data placed at the start of the image.

This setup header is placed in a way that permits legacy loaders to
manipulate the contents (i.e., to pass the kernel command line or the
address and size of an initial ramdisk), but EFI boot does not use it in
that way - it only copies the contents that were placed there at build
time, but EFI loaders will not (and should not) manipulate the setup
header to configure the boot. (Commit 63bf28ceb3ebbe76 "efi: x86: Wipe
setup_data on pure EFI boot" deals with some of the fallout of using
setup_data in a way that breaks EFI boot.)

Given that none of the non-zero values that are copied from the setup
header into the EFI stub's struct boot_params are relevant to the boot
now that the EFI stub no longer enters via the legacy decompressor, the
copy can be omitted altogether.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230912090051.4014114-19-ardb@google.com
---
 drivers/firmware/efi/libstub/x86-stub.c | 46 +++---------------------
 1 file changed, 6 insertions(+), 40 deletions(-)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 2fee52e..3bfc596 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -449,9 +449,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 				   efi_system_table_t *sys_table_arg)
 {
-	struct boot_params *boot_params;
-	struct setup_header *hdr;
-	void *image_base;
+	static struct boot_params boot_params __page_aligned_bss;
+	struct setup_header *hdr = &boot_params.hdr;
 	efi_guid_t proto = LOADED_IMAGE_PROTOCOL_GUID;
 	int options_size = 0;
 	efi_status_t status;
@@ -469,30 +468,9 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 		efi_exit(handle, status);
 	}
 
-	image_base = efi_table_attr(image, image_base);
-
-	status = efi_allocate_pages(sizeof(struct boot_params),
-				    (unsigned long *)&boot_params, ULONG_MAX);
-	if (status != EFI_SUCCESS) {
-		efi_err("Failed to allocate lowmem for boot params\n");
-		efi_exit(handle, status);
-	}
-
-	memset(boot_params, 0x0, sizeof(struct boot_params));
-
-	hdr = &boot_params->hdr;
-
-	/* Copy the setup header from the second sector to boot_params */
-	memcpy(&hdr->jump, image_base + 512,
-	       sizeof(struct setup_header) - offsetof(struct setup_header, jump));
-
-	/*
-	 * Fill out some of the header fields ourselves because the
-	 * EFI firmware loader doesn't load the first sector.
-	 */
+	/* Assign the setup_header fields that the kernel actually cares about */
 	hdr->root_flags	= 1;
 	hdr->vid_mode	= 0xffff;
-	hdr->boot_flag	= 0xAA55;
 
 	hdr->type_of_loader = 0x21;
 
@@ -501,25 +479,13 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 	if (!cmdline_ptr)
 		goto fail;
 
-	efi_set_u64_split((unsigned long)cmdline_ptr,
-			  &hdr->cmd_line_ptr, &boot_params->ext_cmd_line_ptr);
-
-	hdr->ramdisk_image = 0;
-	hdr->ramdisk_size = 0;
-
-	/*
-	 * Disregard any setup data that was provided by the bootloader:
-	 * setup_data could be pointing anywhere, and we have no way of
-	 * authenticating or validating the payload.
-	 */
-	hdr->setup_data = 0;
+	efi_set_u64_split((unsigned long)cmdline_ptr, &hdr->cmd_line_ptr,
+			  &boot_params.ext_cmd_line_ptr);
 
-	efi_stub_entry(handle, sys_table_arg, boot_params);
+	efi_stub_entry(handle, sys_table_arg, &boot_params);
 	/* not reached */
 
 fail:
-	efi_free(sizeof(struct boot_params), (unsigned long)boot_params);
-
 	efi_exit(handle, status);
 }
 
