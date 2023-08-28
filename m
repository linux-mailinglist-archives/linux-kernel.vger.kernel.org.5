Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1725178B012
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjH1M0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjH1MZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:25:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B793C123
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:25:38 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A13BF1EC00D9;
        Mon, 28 Aug 2023 14:25:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1693225536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=u039bQisaevab5OcXO8iHcE5EypFcCNlyJCatMkBM6w=;
        b=ViTdcJDz62F6Cd559ad2Bj2I4zVJ3kC8HOzyWjN25qaVra0z+8VB7KUBULEVCti4FBdM/D
        Ds08foCmAOxTUGpbIF+SUHoOZm9aEk0CUdXcrnaIZaFqCdqoZryiAlYsPZxP9ZzXPjeuUL
        DbICqXieQF9k2aDwoWAZLjbMaVsbStQ=
Date:   Mon, 28 Aug 2023 14:25:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode for v6.6-rc1
Message-ID: <20230828122533.GBZOySPQIjw25NiUqI@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the first part of Thomas' microcode loader work, for 6.6.
The other part wasn't fully ready in time so it will follow on later.

Thx.

---

The following changes since commit 6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.6_rc1

for you to fetch changes up to 4d2b748305e96fb76202a0d1072a285b1500bff3:

  x86/microcode: Remove remaining references to CONFIG_MICROCODE_AMD (2023-08-26 13:37:55 +0200)

----------------------------------------------------------------
- The first, cleanup part of the microcode loader reorg tglx has been
  working on. This part makes the loader core code as it is practically
  enabled on pretty much every baremetal machine so there's no need to
  have the Kconfig items. In addition, there are cleanups which prepare
  for future feature enablement.

----------------------------------------------------------------
Ashok Raj (2):
      x86/microcode: Include vendor headers into microcode.h
      x86/microcode/intel: Rename get_datasize() since its used externally

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Rip out static buffers

Lukas Bulwahn (1):
      x86/microcode: Remove remaining references to CONFIG_MICROCODE_AMD

Sebastian Andrzej Siewior (1):
      x86/microcode: Remove microcode_mutex

Thomas Gleixner (7):
      x86/mm: Remove unused microcode.h include
      x86/microcode: Hide the config knob
      x86/microcode/intel: Move microcode functions out of cpu/intel.c
      x86/microcode: Make reload_early_microcode() static
      x86/microcode: Move core specific defines to local header
      x86/microcode/intel: Remove debug code
      x86/microcode/intel: Remove pointless mutex

 arch/x86/Kconfig                         |  38 +---
 arch/x86/configs/i386_defconfig          |   1 -
 arch/x86/configs/x86_64_defconfig        |   1 -
 arch/x86/include/asm/microcode.h         | 154 +++++-----------
 arch/x86/include/asm/microcode_amd.h     |  58 ------
 arch/x86/include/asm/microcode_intel.h   |  88 ---------
 arch/x86/kernel/cpu/common.c             |   4 +-
 arch/x86/kernel/cpu/intel.c              | 176 +-----------------
 arch/x86/kernel/cpu/microcode/Makefile   |   4 +-
 arch/x86/kernel/cpu/microcode/amd.c      | 133 +++++++-------
 arch/x86/kernel/cpu/microcode/core.c     |  17 +-
 arch/x86/kernel/cpu/microcode/intel.c    | 304 +++++++++++++++++++++----------
 arch/x86/kernel/cpu/microcode/internal.h | 131 +++++++++++++
 arch/x86/mm/init.c                       |   1 -
 drivers/platform/x86/intel/ifs/load.c    |   7 +-
 15 files changed, 466 insertions(+), 651 deletions(-)
 delete mode 100644 arch/x86/include/asm/microcode_amd.h
 delete mode 100644 arch/x86/include/asm/microcode_intel.h
 create mode 100644 arch/x86/kernel/cpu/microcode/internal.h


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
