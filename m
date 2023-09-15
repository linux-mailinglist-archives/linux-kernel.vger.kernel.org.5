Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7252F7A1ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjIOJim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjIOJia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:38:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06562113;
        Fri, 15 Sep 2023 02:38:10 -0700 (PDT)
Date:   Fri, 15 Sep 2023 09:37:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694770670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TVOhxRZeJJtvQIAxY2YKH1Zs/anzgkDL1NSdGh/qvWw=;
        b=Godk32NyepHPXcAD9n2qmbqfKXotH+mygtg5cErkmhEjvwus3JRbqQGBJLtex6WQRph/Eb
        93pEu+OQNZgV3M3Syr/6XY77GZtlgi50HarUwOwnmjEDMsBhUj0kzQ9vptQLLA2uVZK4YZ
        myS6wlwGZCKIzKkG4Y/5S3IZcmCE62smFKP0ogQi+9hmZ9tzaUHf42T/BSYlVn34RRrwgA
        vEA/vAbYIQRgoj9L1ayvRkJdM9fHu/PEhKxGQUqZdPJcMSv+NKm36CnO9jXrZj8Xj3LF2v
        KqCF1DKzxKeDD3O/4A5bNmhGHXmIsq3thMTKVeafIWz1q5zg+5Lx4pxvJgY6GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694770670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TVOhxRZeJJtvQIAxY2YKH1Zs/anzgkDL1NSdGh/qvWw=;
        b=JS25vSeFslcgTvbiqCmmvXuF9JgbC6kwLEiXu73y3CLZh/+n/nRQ2hT7AsxVxN0HVerDr+
        DEf180n+YIjLl6Dw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/efi: Drop EFI stub .bss from .data section
Cc:     Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230912090051.4014114-18-ardb@google.com>
References: <20230912090051.4014114-18-ardb@google.com>
MIME-Version: 1.0
Message-ID: <169477066995.27769.17984655854633044024.tip-bot2@tip-bot2>
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

Commit-ID:     5f51c5d0e905608ba7be126737f7c84a793ae1aa
Gitweb:        https://git.kernel.org/tip/5f51c5d0e905608ba7be126737f7c84a793ae1aa
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 12 Sep 2023 09:00:52 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 15 Sep 2023 11:18:40 +02:00

x86/efi: Drop EFI stub .bss from .data section

Now that the EFI stub always zero inits its BSS section upon entry,
there is no longer a need to place the BSS symbols carried by the stub
into the .data section.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230912090051.4014114-18-ardb@google.com
---
 arch/x86/boot/compressed/vmlinux.lds.S | 1 -
 drivers/firmware/efi/libstub/Makefile  | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index b22f34b..4ff6ab1 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -47,7 +47,6 @@ SECTIONS
 		_data = . ;
 		*(.data)
 		*(.data.*)
-		*(.bss.efistub)
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index a1157c2..ef4c12f 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -108,13 +108,6 @@ lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
 # https://bugs.llvm.org/show_bug.cgi?id=46480
 STUBCOPY_FLAGS-y		+= --remove-section=.note.gnu.property
 
-#
-# For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
-# .bss section, so the .bss section of the EFI stub needs to be included in the
-# .data section of the compressed kernel to ensure initialization. Rename the
-# .bss section here so it's easy to pick out in the linker script.
-#
-STUBCOPY_FLAGS-$(CONFIG_X86)	+= --rename-section .bss=.bss.efistub,load,alloc
 STUBCOPY_RELOC-$(CONFIG_X86_32)	:= R_386_32
 STUBCOPY_RELOC-$(CONFIG_X86_64)	:= R_X86_64_64
 
