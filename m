Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB158031EE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjLDL5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjLDL5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:57:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D29194
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B03C433CA;
        Mon,  4 Dec 2023 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701691039;
        bh=q9RFRmQz//PfuZnmNFqtqm4IBejSJpfxv/MO9WQSm6g=;
        h=From:To:Cc:Subject:Date:From;
        b=otFmRzW1jBZI0ynTl9GruW+vDoZYr9DfIOVxxXZTzV7ocbkPeeo2AR9iIizr6yomB
         gBEK2bIqKaJ3pQIW+CdlfKUUQHxyS7Ioq+Lpdf+v00FOvP7YQA1+QZ0+OjRTxl9LIg
         aTJqnmCsfAN9XncqnH3VXyXxzDk/Svi7xxFa6mVrScrYl6zXMmZ1VnRiZ4dAWWE9lZ
         6bxEu3F4qUx5/wuX0IsjLW3tRviuujMLEATEmCllddvZU96iybTU73CbayMP07gJBn
         0yrS3gEg2c5U6yxNUk+txhHtGKaQ3iac6LSEGX2L/PXyFfmkHkafyVIyhWmW3CXCD0
         Lz8li42kCefpA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Stephen Rothwell" <sfr@rothwell.id.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH 00/20] mips: address -Wmissing-prototypes warnings
Date:   Mon,  4 Dec 2023 12:56:50 +0100
Message-Id: <20231204115710.2247097-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

As promised, I've now addressed the -Wmissing-prototypes warnings that
showed up in mips as the last major architecture after my patch to
enable the option everywhere.

This should result in a clean build for the defconfig and allmodconfig
builds, but the older platforms that are not yet converted to
CONFFIG_MIPS_GENERIC_KERNEL tend to still have some remaining warnings
in platform specific code that someone needs to address.

The patches could either go through Thomas's mips tree, or
alternatively through linux-mm along with the hexagon patches
that Andrew has already merged.

      Arnd

Link: https://lore.kernel.org/lkml/ebb5b1a2-ed27-4a77-b62b-1d3f19bddd85@app.fastmail.com/
Cc: "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Stephen Rothwell" <sfr@rothwell.id.au>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
Cc: "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
Cc: linux-mips@vger.kernel.org

Arnd Bergmann (20):
  mips: decompress: fix add missing prototypes
  mips: add asm/syscalls.h header
  mips: add missing declarations for trap handlers
  mips: rs870e: stop exporting local functions
  mips: signal: move sigcontext declarations to header
  mips: mark local function static if possible
  mips: move build_tlb_refill_handler() prototype
  mips: move jump_label_apply_nops() declaration to header
  mips: unhide uasm_in_compat_space_p() declaration
  mips: fix setup_zero_pages() prototype
  mips: fix tlb_init() prototype
  mips: move cache declarations into header
  mips: add missing declarations
  mips: spram: fix missing prototype warning for spram_config
  mips: mt: include asm/mips_mt.h
  mips: remove extraneous asm-generic/iomap.h include
  mips: suspend: include linux/suspend.h as needed
  mips: hide conditionally unused functions
  mips: smp: fix setup_profiling_timer() prototype
  mips: kexec: include linux/reboot.h

 arch/mips/boot/compressed/dbg.c               |  2 ++
 arch/mips/boot/compressed/decompress.c        | 16 ++-------
 arch/mips/boot/compressed/decompress.h        | 24 ++++++++++++++
 arch/mips/boot/compressed/string.c            |  1 +
 arch/mips/include/asm/cache.h                 |  6 ++++
 arch/mips/include/asm/io.h                    |  2 --
 arch/mips/include/asm/jump_label.h            |  3 ++
 .../mips/include/asm/mach-loongson64/mmzone.h |  1 -
 arch/mips/include/asm/mmzone.h                |  2 ++
 arch/mips/include/asm/processor.h             |  2 ++
 arch/mips/include/asm/r4kcache.h              |  4 +++
 arch/mips/include/asm/setup.h                 |  1 +
 arch/mips/include/asm/signal.h                |  1 +
 arch/mips/include/asm/smp.h                   |  2 ++
 arch/mips/include/asm/spram.h                 |  2 +-
 arch/mips/include/asm/syscalls.h              | 33 +++++++++++++++++++
 arch/mips/include/asm/tlbex.h                 |  1 +
 arch/mips/include/asm/traps.h                 | 23 +++++++++++++
 arch/mips/include/asm/uasm.h                  |  2 --
 arch/mips/kernel/cpu-probe.c                  |  1 -
 arch/mips/kernel/cpu-r3k-probe.c              |  1 -
 arch/mips/kernel/linux32.c                    |  1 +
 arch/mips/kernel/machine_kexec.c              |  1 +
 arch/mips/kernel/mips-cm.c                    |  2 +-
 arch/mips/kernel/mips-mt-fpaff.c              |  1 +
 arch/mips/kernel/mips-mt.c                    |  1 +
 arch/mips/kernel/module.c                     |  3 +-
 arch/mips/kernel/r4k-bugs64.c                 |  1 +
 arch/mips/kernel/signal-common.h              |  3 ++
 arch/mips/kernel/signal.c                     |  1 +
 arch/mips/kernel/signal32.c                   |  1 +
 arch/mips/kernel/signal_n32.c                 |  4 +--
 arch/mips/kernel/signal_o32.c                 |  1 +
 arch/mips/kernel/smp.c                        |  3 ++
 arch/mips/kernel/spram.c                      |  1 +
 arch/mips/kernel/syscall.c                    |  1 +
 arch/mips/kernel/traps.c                      |  2 --
 arch/mips/kernel/unaligned.c                  |  1 +
 arch/mips/mm/c-r4k.c                          |  6 +---
 arch/mips/mm/cache.c                          |  6 ----
 arch/mips/mm/fault.c                          |  1 +
 arch/mips/mm/init.c                           |  1 +
 arch/mips/mm/pgtable-64.c                     |  2 ++
 arch/mips/mm/tlb-r3k.c                        |  4 +--
 arch/mips/mm/tlb-r4k.c                        |  6 ++--
 arch/mips/power/cpu.c                         |  1 +
 arch/mips/power/hibernate.c                   |  1 +
 drivers/platform/mips/rs780e-acpi.c           | 12 +++----
 48 files changed, 145 insertions(+), 53 deletions(-)
 create mode 100644 arch/mips/boot/compressed/decompress.h
 create mode 100644 arch/mips/include/asm/syscalls.h

-- 
2.39.2

