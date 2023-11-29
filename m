Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A44D7FD780
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjK2NHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbjK2NHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:07:02 -0500
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9051E10DD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:07:06 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxbOp3N2dlWqc9AA--.29642S3;
        Wed, 29 Nov 2023 21:07:03 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axzy91N2dlVtNPAA--.45987S2;
        Wed, 29 Nov 2023 21:07:01 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/8] Add objtool and orc support for LoongArch
Date:   Wed, 29 Nov 2023 21:06:53 +0800
Message-ID: <20231129130701.27744-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axzy91N2dlVtNPAA--.45987S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWw17Gr1UWw45ZFWrKFW5XFc_yoWrAry7pF
        ZrZrykGF4UWr93Aw1Dta4UurWDJan7Gr12g3Wavry8CFW2qr1DArsakFyDXFnFqa1rGFy0
        gF1rGw4aqa1jqabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
        1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
        67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This version is based on 6.7-rc3, tested with the latest upstream
gcc and binutils (20231127).

v5:
  -- Fix the partial backtrace about irq stack
  -- Check on_stack() again after get_stack_info()
  -- Silence the orc warning about handle_syscall
  -- Silence the objtool warnings if CONFIG_CPU_HAS_LBT=y
  -- Update the commit message about objdump and readelf info

Tiezhu Yang (8):
  objtool/LoongArch: Enable objtool to be built
  objtool/LoongArch: Implement instruction decoder
  objtool/x86: Separate arch-specific and generic parts
  objtool/LoongArch: Enable orc to be built
  objtool: Check local label about sibling call
  objtool: Check local label in add_dead_ends()
  objtool: Check local label in read_unwind_hints()
  LoongArch: Add ORC stack unwinder support

 arch/loongarch/Kconfig                        |   2 +
 arch/loongarch/Kconfig.debug                  |  11 +
 arch/loongarch/Makefile                       |  19 +
 arch/loongarch/include/asm/Kbuild             |   2 +
 arch/loongarch/include/asm/bug.h              |   1 +
 arch/loongarch/include/asm/exception.h        |   2 +
 arch/loongarch/include/asm/module.h           |   7 +
 arch/loongarch/include/asm/orc_header.h       |  18 +
 arch/loongarch/include/asm/orc_lookup.h       |  31 ++
 arch/loongarch/include/asm/orc_types.h        |  58 ++
 arch/loongarch/include/asm/stackframe.h       |   3 +
 arch/loongarch/include/asm/unwind.h           |  19 +-
 arch/loongarch/include/asm/unwind_hints.h     |  28 +
 arch/loongarch/kernel/Makefile                |   4 +
 arch/loongarch/kernel/entry.S                 |   6 +-
 arch/loongarch/kernel/fpu.S                   |   7 +
 arch/loongarch/kernel/genex.S                 |   6 +-
 arch/loongarch/kernel/lbt.S                   |   5 +
 arch/loongarch/kernel/module.c                |  22 +-
 arch/loongarch/kernel/relocate_kernel.S       |   2 +
 arch/loongarch/kernel/setup.c                 |   2 +
 arch/loongarch/kernel/stacktrace.c            |   1 +
 arch/loongarch/kernel/traps.c                 |  42 +-
 arch/loongarch/kernel/unwind_orc.c            | 516 ++++++++++++++++++
 arch/loongarch/kernel/vmlinux.lds.S           |   3 +
 arch/loongarch/kvm/switch.S                   |   7 +-
 arch/loongarch/lib/Makefile                   |   2 +
 arch/loongarch/mm/tlb.c                       |  27 +-
 arch/loongarch/mm/tlbex.S                     |   9 +
 arch/loongarch/vdso/Makefile                  |   1 +
 include/linux/compiler.h                      |   9 +
 scripts/Makefile                              |   7 +-
 tools/arch/loongarch/include/asm/inst.h       | 161 ++++++
 tools/arch/loongarch/include/asm/orc_types.h  |  58 ++
 tools/include/linux/bitops.h                  |  11 +
 tools/objtool/Makefile                        |   4 +
 tools/objtool/arch/loongarch/Build            |   3 +
 tools/objtool/arch/loongarch/decode.c         | 356 ++++++++++++
 .../arch/loongarch/include/arch/cfi_regs.h    |  22 +
 .../objtool/arch/loongarch/include/arch/elf.h |  30 +
 .../arch/loongarch/include/arch/special.h     |  33 ++
 tools/objtool/arch/loongarch/orc.c            | 171 ++++++
 tools/objtool/arch/loongarch/special.c        |  15 +
 tools/objtool/arch/x86/Build                  |   1 +
 tools/objtool/arch/x86/orc.c                  | 188 +++++++
 tools/objtool/check.c                         | 117 ++--
 tools/objtool/include/objtool/elf.h           |   1 +
 tools/objtool/include/objtool/orc.h           |  14 +
 tools/objtool/orc_dump.c                      |  69 +--
 tools/objtool/orc_gen.c                       | 113 +---
 50 files changed, 1983 insertions(+), 263 deletions(-)
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
2.42.0

