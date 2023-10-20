Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE68A7D066F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 04:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346858AbjJTC1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 22:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbjJTC1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 22:27:11 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BF01124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 19:27:07 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dx_+t45TFlLF8zAA--.33039S3;
        Fri, 20 Oct 2023 10:27:04 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxP9115TFl7r4rAA--.28791S2;
        Fri, 20 Oct 2023 10:27:01 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v3 0/8] Add objtool and orc support for LoongArch
Date:   Fri, 20 Oct 2023 10:26:53 +0800
Message-Id: <1697768821-22931-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8CxP9115TFl7r4rAA--.28791S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXrW5XrW8Cr1DKry7Gw47WrX_yoWruF1DpF
        9rurykGF4UWr93Awnrta4UurWDJan7Gr12g3W2qry8CFW2qr1DJrsakFyDZFyqqa1rJFy0
        qFn5Gw1aga1jyabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8uMKtUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version is based on the latest torvalds/linux.git (20231020)
which includes the commit 00c2ca84c680 ("LoongArch: Use SYM_CODE_*
to annotate exception handlers"), tested with the latest upstream
gcc and binutils (20231009).

v3:
  -- Use tab for indentation in special.h
  -- Replace BP/bp with FP/fp
  -- Modify jirl decoder to handle special case in hibernate_asm.o
  -- Remove the calling of bswap_if_needed() which always return false
  -- Remove OBJECT_FILES_NON_STANDARD_suspend_asm.o
  -- Remove check of assembler version in Makefile
  -- Remove UNWIND_HINT_EMPTY in kernel_entry
  -- Put unwind_init() after cpu_probe()
  -- Remove CONFIG_BPF_JIT_ALWAYS_ON in defconfig
  -- Rename title of patch #8 to "Add ORC stack unwinder support"
  -- Fix build error of scripts/sorttable.h reported by test robot
  -- Add exception_table[] to save exception handlers

Tiezhu Yang (8):
  objtool/LoongArch: Enable objtool to be built
  objtool/LoongArch: Implement instruction decoder
  objtool/x86: Separate arch-specific and generic parts
  objtool/LoongArch: Enable orc to be built
  objtool: Check local label about sibling call
  objtool: Check local label in add_dead_ends()
  objtool: Check local label in read_unwind_hints()
  LoongArch: Add ORC stack unwinder support

 arch/loongarch/Kconfig                             |   2 +
 arch/loongarch/Kconfig.debug                       |  11 +
 arch/loongarch/Makefile                            |  18 +
 arch/loongarch/include/asm/Kbuild                  |   1 +
 arch/loongarch/include/asm/bug.h                   |   1 +
 arch/loongarch/include/asm/exception.h             |   2 +
 arch/loongarch/include/asm/module.h                |   7 +
 arch/loongarch/include/asm/orc_header.h            |  19 +
 arch/loongarch/include/asm/orc_lookup.h            |  34 ++
 arch/loongarch/include/asm/orc_types.h             |  58 +++
 arch/loongarch/include/asm/stackframe.h            |   3 +
 arch/loongarch/include/asm/unwind.h                |  22 +-
 arch/loongarch/include/asm/unwind_hints.h          |  28 ++
 arch/loongarch/kernel/Makefile                     |   3 +
 arch/loongarch/kernel/entry.S                      |   5 +
 arch/loongarch/kernel/genex.S                      |   4 +
 arch/loongarch/kernel/module.c                     |  11 +-
 arch/loongarch/kernel/relocate_kernel.S            |   2 +
 arch/loongarch/kernel/setup.c                      |   2 +
 arch/loongarch/kernel/stacktrace.c                 |   1 +
 arch/loongarch/kernel/traps.c                      |  44 +-
 arch/loongarch/kernel/unwind_orc.c                 | 522 +++++++++++++++++++++
 arch/loongarch/kernel/vmlinux.lds.S                |   3 +
 arch/loongarch/lib/Makefile                        |   2 +
 arch/loongarch/mm/tlb.c                            |  27 +-
 arch/loongarch/mm/tlbex.S                          |   9 +
 arch/loongarch/vdso/Makefile                       |   1 +
 include/linux/compiler.h                           |   9 +
 scripts/Makefile                                   |   7 +-
 tools/arch/loongarch/include/asm/inst.h            | 161 +++++++
 tools/arch/loongarch/include/asm/orc_types.h       |  58 +++
 tools/include/linux/bitops.h                       |  11 +
 tools/objtool/Makefile                             |   4 +
 tools/objtool/arch/loongarch/Build                 |   3 +
 tools/objtool/arch/loongarch/decode.c              | 352 ++++++++++++++
 .../objtool/arch/loongarch/include/arch/cfi_regs.h |  22 +
 tools/objtool/arch/loongarch/include/arch/elf.h    |  30 ++
 .../objtool/arch/loongarch/include/arch/special.h  |  33 ++
 tools/objtool/arch/loongarch/orc.c                 | 171 +++++++
 tools/objtool/arch/loongarch/special.c             |  15 +
 tools/objtool/arch/x86/Build                       |   1 +
 tools/objtool/arch/x86/orc.c                       | 188 ++++++++
 tools/objtool/check.c                              | 118 +++--
 tools/objtool/include/objtool/orc.h                |  14 +
 tools/objtool/orc_dump.c                           |  69 +--
 tools/objtool/orc_gen.c                            | 113 +----
 46 files changed, 1964 insertions(+), 257 deletions(-)
 create mode 100644 arch/loongarch/include/asm/orc_header.h
 create mode 100644 arch/loongarch/include/asm/orc_lookup.h
 create mode 100644 arch/loongarch/include/asm/orc_types.h
 create mode 100644 arch/loongarch/include/asm/unwind_hints.h
 create mode 100644 arch/loongarch/kernel/unwind_orc.c
 create mode 100644 tools/arch/loongarch/include/asm/inst.h
 create mode 100644 tools/arch/loongarch/include/asm/orc_types.h
 create mode 100644 tools/objtool/arch/loongarch/Build
 create mode 100644 tools/objtool/arch/loongarch/decode.c
 create mode 100644 tools/objtool/arch/loongarch/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/loongarch/include/arch/elf.h
 create mode 100644 tools/objtool/arch/loongarch/include/arch/special.h
 create mode 100644 tools/objtool/arch/loongarch/orc.c
 create mode 100644 tools/objtool/arch/loongarch/special.c
 create mode 100644 tools/objtool/arch/x86/orc.c
 create mode 100644 tools/objtool/include/objtool/orc.h

-- 
2.1.0

