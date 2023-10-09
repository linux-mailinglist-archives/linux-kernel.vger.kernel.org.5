Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014767BDD08
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376633AbjJINDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376629AbjJINDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:03:18 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9992799
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 06:03:14 -0700 (PDT)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bx5fAR+iNlGE4wAA--.27781S3;
        Mon, 09 Oct 2023 21:03:13 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxzt4P+iNlksscAA--.62948S2;
        Mon, 09 Oct 2023 21:03:11 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: [PATCH v2 0/8] Add objtool and orc support for LoongArch
Date:   Mon,  9 Oct 2023 21:03:02 +0800
Message-Id: <1696856590-30298-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8Cxzt4P+iNlksscAA--.62948S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw15JFy5WF17tFyfGry8Zwc_yoWrurWUpF
        9rArykGF4UWr93Aw1kta4UurWDJan7Gr12g3W3Xry8AFW2qr1DArsakryDXF9Fqa1rGFy0
        qF1fWw1Yga1jvabCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9Yb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
        AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
        XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
        AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
        6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
        CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
        0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
        AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
        Ja73UjIFyTuYvjxU2MKZDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version is based on 6.6-rc5, tested with the latest upstream
gcc and binutils (20231009), all of the objtool warnings have been
silenced.

The patches #5, #6 and #7 are based on the following objdump info:
the latest upstream gas of LoongArch replaces a pair of ADD32/64
and SUB32/64 with 32/64_PCREL, and the option -mrelax is used by
default, there are local labels for the branch and jump operation,
the reloc symbol is label + offset instead of section + offset.

The binutils should contain the following two commits:
(1) Use 32/64_PCREL to replace a pair of ADD32/64 and SUB32/64
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=ecb802d02eeb
(2) as: add option for generate R_LARCH_32/64_PCREL
https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=816029e06768

Tiezhu Yang (8):
  objtool/LoongArch: Enable objtool to be built
  objtool/LoongArch: Implement instruction decoder
  objtool/x86: Separate arch-specific and generic parts
  objtool/LoongArch: Enable orc to be built
  objtool: Check local label about sibling call
  objtool: Check local label in add_dead_ends()
  objtool: Check local label in read_unwind_hints()
  LoongArch: Add ORC unwinder support

 arch/loongarch/Kconfig                             |   2 +
 arch/loongarch/Kconfig.debug                       |  11 +
 arch/loongarch/Makefile                            |  23 +
 arch/loongarch/configs/loongson3_defconfig         |   1 +
 arch/loongarch/include/asm/Kbuild                  |   1 +
 arch/loongarch/include/asm/bug.h                   |   1 +
 arch/loongarch/include/asm/linkage.h               |   2 +
 arch/loongarch/include/asm/module.h                |   7 +
 arch/loongarch/include/asm/orc_header.h            |  19 +
 arch/loongarch/include/asm/orc_lookup.h            |  34 ++
 arch/loongarch/include/asm/orc_types.h             |  58 +++
 arch/loongarch/include/asm/stackframe.h            |   3 +
 arch/loongarch/include/asm/unwind.h                |  22 +-
 arch/loongarch/include/asm/unwind_hints.h          |  28 +
 arch/loongarch/kernel/Makefile                     |   3 +
 arch/loongarch/kernel/entry.S                      |   9 +-
 arch/loongarch/kernel/genex.S                      |  20 +-
 arch/loongarch/kernel/head.S                       |   1 +
 arch/loongarch/kernel/module.c                     |  11 +-
 arch/loongarch/kernel/relocate_kernel.S            |   2 +
 arch/loongarch/kernel/setup.c                      |   2 +
 arch/loongarch/kernel/stacktrace.c                 |   1 +
 arch/loongarch/kernel/unwind_orc.c                 | 571 +++++++++++++++++++++
 arch/loongarch/kernel/vmlinux.lds.S                |   3 +
 arch/loongarch/lib/Makefile                        |   2 +
 arch/loongarch/mm/tlbex.S                          |  45 +-
 arch/loongarch/power/Makefile                      |   2 +
 arch/loongarch/vdso/Makefile                       |   1 +
 include/linux/compiler.h                           |   9 +
 scripts/Makefile                                   |   5 +-
 tools/arch/loongarch/include/asm/inst.h            | 161 ++++++
 tools/arch/loongarch/include/asm/orc_types.h       |  58 +++
 tools/include/linux/bitops.h                       |  11 +
 tools/objtool/Makefile                             |   4 +
 tools/objtool/arch/loongarch/Build                 |   3 +
 tools/objtool/arch/loongarch/decode.c              | 334 ++++++++++++
 .../objtool/arch/loongarch/include/arch/cfi_regs.h |  21 +
 tools/objtool/arch/loongarch/include/arch/elf.h    |  30 ++
 .../objtool/arch/loongarch/include/arch/special.h  |  33 ++
 tools/objtool/arch/loongarch/orc.c                 | 155 ++++++
 tools/objtool/arch/loongarch/special.c             |  15 +
 tools/objtool/arch/x86/Build                       |   1 +
 tools/objtool/arch/x86/orc.c                       | 169 ++++++
 tools/objtool/check.c                              | 118 +++--
 tools/objtool/include/objtool/orc.h                |  10 +
 tools/objtool/orc_dump.c                           |  69 +--
 tools/objtool/orc_gen.c                            |  92 +---
 47 files changed, 1949 insertions(+), 234 deletions(-)
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

