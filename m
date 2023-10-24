Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B327D5B70
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344178AbjJXT1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343612AbjJXT1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:27:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BEE10C3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:26:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73354C433C7;
        Tue, 24 Oct 2023 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698175617;
        bh=+anck+iVi4/9AxBaPBVSONihMc3/xRqjTE3i12vRea4=;
        h=From:To:Cc:Subject:Date:From;
        b=pu5np2xifqVw00cZ9Z6nwP8ziNGZoZtGj7PA+aR0d4yzvZy/BMB0PUuBb632APfEa
         1ZDWDFJBamzVFMHuii8b0pviocPYN4pumq8L7lE1N3btV7b4N5vQs+v0gZYW7rWUNI
         0DNFbZput21S/Ccoh+53Z5hatA9Xp5zw+ORQRPUve9tdxmQXUvycyAkkgGU1IP9QcW
         91/e5KgIkF8hDog4o8/Zw/FtyugJzHGQqMFQImtfF8frOLiHo0i3jNUbrfrJaL/DDS
         UfUtgR1vmE9jypMyNpN77f1zO7GT6nVKK/ziBA+69Lpb/n3kpzlTjJQd3+5wLIa1+A
         lZgiUIuyaqyQA==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: CONFIG_EFI should not depend on CONFIG_RISCV_ISA_C
Date:   Tue, 24 Oct 2023 21:26:48 +0200
Message-Id: <20231024192648.25527-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

UEFI/PE mandates that the kernel Image starts with "MZ" ASCII
(0x5A4D). Convenient enough, "MZ" is a valid compressed RISC-V
instruction. This means that a non-UEFI loader can simply jump to
"code0" in the Image header [1] and start executing.

The Image specification [1] says the following about "code0":
  |   This header is also reused to support EFI stub for RISC-V. EFI
  |   specification needs PE/COFF image header in the beginning of the
  |   kernel image in order to load it as an EFI application. In order
  |   to support EFI stub, code0 is replaced with "MZ" magic string
  |   and res3(at offset 0x3c) points to the rest of the PE/COFF
  |   header.

"MZ" is not a valid instruction for implementations without the C
extension.

A non-UEFI loader, loading a non-C UEFI image have the following
options:
  1. Trap and emulate "code0"
  2. Avoid "code0" if it is "MZ", and have the kernel entry at
     "code1".

Replace the compressed instruction with a hex code variant, that works
for CONFIG_RISCV_ISA_C=n builds. Further, this change also make sure
that the "code0" instruction is 32b aligned.

[1] Documentation/riscv/boot-image-header.rst

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig       | 1 -
 arch/riscv/kernel/head.S | 8 ++++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..9c5bbbc93951 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -799,7 +799,6 @@ config EFI
 	select EFI_RUNTIME_WRAPPERS
 	select EFI_STUB
 	select LIBFDT
-	select RISCV_ISA_C
 	select UCS2_STRING
 	help
 	  This option provides support for runtime services provided
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 3710ea5d160f..33d69b569843 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -27,9 +27,13 @@ ENTRY(_start)
 	 */
 #ifdef CONFIG_EFI
 	/*
-	 * This instruction decodes to "MZ" ASCII required by UEFI.
+	 * The compressed (C extension) "c.li s4,-13" instruction
+	 * decodes to 0x5a4d/"MZ" (ASCII), which is required by UEFI.
+	 *
+	 * In order to support non-compressed EFI kernels, the
+	 * instruction is written in hex.
 	 */
-	c.li s4,-13
+	.word 0x5a4d5a4d
 	j _start_kernel
 #else
 	/* jump to start kernel */

base-commit: d88520ad73b79e71e3ddf08de335b8520ae41c5c
-- 
2.40.1

