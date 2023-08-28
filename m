Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A0E78A54A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 07:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjH1FgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 01:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjH1FgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 01:36:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F2FDE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 22:35:59 -0700 (PDT)
Received: from nazgul.tnic (dynamic-046-114-154-102.46.114.pool.telefonica.de [46.114.154.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 590861EC00F4;
        Mon, 28 Aug 2023 07:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1693200952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=n3muETB9kQ9v2gMm10xe/CMarCqmpVu9kcQDhfVRD6k=;
        b=e9NURplLsrZ02Bi3bYYHZOtmYOGvslEUGAkP5nPlpABjUs9dnLQd+0O9Ek6rMv+1BAWoO5
        cL9ziFgnVEp0st/kbJUfDh08biH6t/dg5mYKag5O7m39C2fedrUQb4tAaEDxdH3dhY2evc
        RLHcHREaOu/HLGjIbNc8wUnbrhzeIrQ=
Date:   Mon, 28 Aug 2023 07:35:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/boot for v6.6-rc1
Message-ID: <20230828053543.GAZOwyL40QMun5zKU5@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the set of x86/boot changes for 6.6.

Thx.

---

The following changes since commit bee6cf1a80b54548a039e224c651bb15b644a480:

  x86/sev: Do not try to parse for the CC blob on non-AMD hardware (2023-08-07 18:05:13 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_boot_for_v6.6_rc1

for you to fetch changes up to a1b87d54f4e45ff5e0d081fb1d9db3bf1a8fb39a:

  x86/efistub: Avoid legacy decompressor when doing EFI boot (2023-08-07 21:07:43 +0200)

----------------------------------------------------------------
- Avoid the baremetal decompressor code when booting on an EFI machine.
  This is mandated by the current tightening of EFI executables
  requirements when used in a secure boot scenario. More specifically,
  an EFI executable cannot have a single section with RWX permissions,
  which conflicts with the in-place kernel decompression that is done
  today. Instead, the things required by the booting kernel image are
  done in the EFI stub now. Work by Ard Biesheuvel.

----------------------------------------------------------------
Ard Biesheuvel (23):
      x86/decompressor: Don't rely on upper 32 bits of GPRs being preserved
      x86/head_64: Store boot_params pointer in callee save register
      x86/efistub: Branch straight to kernel entry point from C code
      x86/efistub: Simplify and clean up handover entry code
      x86/decompressor: Avoid magic offsets for EFI handover entrypoint
      x86/efistub: Clear BSS in EFI handover protocol entrypoint
      x86/decompressor: Store boot_params pointer in callee save register
      x86/decompressor: Assign paging related global variables earlier
      x86/decompressor: Call trampoline as a normal function
      x86/decompressor: Use standard calling convention for trampoline
      x86/decompressor: Avoid the need for a stack in the 32-bit trampoline
      x86/decompressor: Call trampoline directly from C code
      x86/decompressor: Only call the trampoline when changing paging levels
      x86/decompressor: Pass pgtable address to trampoline directly
      x86/decompressor: Merge trampoline cleanup with switching code
      x86/efistub: Perform 4/5 level paging switch from the stub
      x86/efistub: Prefer EFI memory attributes protocol over DXE services
      decompress: Use 8 byte alignment
      x86/decompressor: Move global symbol references to C code
      x86/decompressor: Factor out kernel decompression and relocation
      efi/libstub: Add limit argument to efi_random_alloc()
      x86/efistub: Perform SNP feature test while running in the firmware
      x86/efistub: Avoid legacy decompressor when doing EFI boot

 Documentation/arch/x86/boot.rst                |   2 +-
 arch/x86/boot/compressed/Makefile              |   5 +
 arch/x86/boot/compressed/efi_mixed.S           | 107 ++++------
 arch/x86/boot/compressed/head_32.S             |  32 ---
 arch/x86/boot/compressed/head_64.S             | 280 ++++++++----------------
 arch/x86/boot/compressed/misc.c                |  44 ++--
 arch/x86/boot/compressed/misc.h                |   2 -
 arch/x86/boot/compressed/pgtable.h             |  10 +-
 arch/x86/boot/compressed/pgtable_64.c          |  87 ++++----
 arch/x86/boot/compressed/sev.c                 | 112 ++++++----
 arch/x86/include/asm/boot.h                    |   8 +
 arch/x86/include/asm/efi.h                     |   7 +-
 arch/x86/include/asm/sev.h                     |   6 +
 arch/x86/kernel/head_64.S                      |  32 ++-
 drivers/firmware/efi/libstub/Makefile          |   1 +
 drivers/firmware/efi/libstub/arm64-stub.c      |   2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c |   2 +
 drivers/firmware/efi/libstub/efistub.h         |   3 +-
 drivers/firmware/efi/libstub/randomalloc.c     |  10 +-
 drivers/firmware/efi/libstub/x86-5lvl.c        |  95 +++++++++
 drivers/firmware/efi/libstub/x86-stub.c        | 281 ++++++++++++++-----------
 drivers/firmware/efi/libstub/x86-stub.h        |  17 ++
 drivers/firmware/efi/libstub/zboot.c           |   2 +-
 include/linux/decompress/mm.h                  |   2 +-
 24 files changed, 587 insertions(+), 562 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/x86-5lvl.c
 create mode 100644 drivers/firmware/efi/libstub/x86-stub.h

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
