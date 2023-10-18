Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624877CD952
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjJRKeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRKeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:34:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE69BA;
        Wed, 18 Oct 2023 03:34:19 -0700 (PDT)
Date:   Wed, 18 Oct 2023 10:34:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697625257;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zAT0k8uV4B1VaziPHHllpGl9vbj2hwXI5RmgJXRf8gY=;
        b=tyme8N1wKOL3zq4Q8j7udJYUK26F4YyEcD5tnwTPqVGIMG/gvj2OhTN66uDEVU67kCXGeE
        7lD63wp2IZmNJpHmwPfe1ZxFy90Pa89MyRNzj+VaQX8zir01KCjYd53tedvzZhr3mxUmk9
        zUhvTlMs12vfk4GRtI6Z225JE8ew8lWjyRCP0lHhCi7V8U+rLlUGxtSzVQ5We/ZBhi7g8q
        4r5cvlR6Dv/RHGWmNNLfuarvRPxvY8qUuRgEV8OIfaQB5wrInu7ZCDeiLp9uuYdI6s3pEh
        H8PgLfsQJYjnG1ioUCYKcucZ8A1NV5tHTjGqyzSQ52Kv/FGO/tZkdF59b551pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697625257;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zAT0k8uV4B1VaziPHHllpGl9vbj2hwXI5RmgJXRf8gY=;
        b=98KCdelaADEX8bKHz5g+ChhpEdc4r/X7v+YEEgFlRQdRRKFc4BMN1cTAMHG5O/oqPjn8fz
        1E8/i4BbcRxerTBQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: efistub: Assign global boot_params variable
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <169762525684.3135.6443175198415541833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     50dcc2e0d62e3c4a54f39673c4dc3dcde7c74d52
Gitweb:        https://git.kernel.org/tip/50dcc2e0d62e3c4a54f39673c4dc3dcde7c74d52
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 17 Oct 2023 15:25:13 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 18 Oct 2023 12:03:04 +02:00

x86/boot: efistub: Assign global boot_params variable

Now that the x86 EFI stub calls into some APIs exposed by the
decompressor (e.g., kaslr_get_random_long()), it is necessary to ensure
that the global boot_params variable is set correctly before doing so.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 drivers/firmware/efi/libstub/x86-stub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 3bfc596..76cc0d0 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -818,6 +818,8 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	unsigned long kernel_entry;
 	efi_status_t status;
 
+	boot_params_ptr = boot_params;
+
 	efi_system_table = sys_table_arg;
 	/* Check if we were booted by the EFI firmware */
 	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
