Return-Path: <linux-kernel+bounces-43977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B92841BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04A7D1C2314B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC2738394;
	Tue, 30 Jan 2024 06:17:39 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F230381D4
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706595458; cv=none; b=GE1LIo1bFPD/vY4d2Wx19wPWBDWIHiukuHEXMtvJiwoQmb7gNm6pG0ItOCI9YjOyoLdzYALabHGkiwJ2N6etzTKiWP89mxYiK8KFjBglorP45vxOhFw2sXRtKLystHjuFkjRfhQNF7Ffty4wWaMaIt/tkQMnihYRN31SSzyySvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706595458; c=relaxed/simple;
	bh=1kOWIzmsJoporGw30Qoft6ml2gLj2mn7G2dsJGbt3Cc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mdk9KfkPnKvxSaLq4mxuAMVo8SMAc0TvHkw5nyCvlPt+cc3ksrwt/ISCaXMBlV7VcYxchCqveZVapbecnLgs7+3XnayBn1j16z9vbJU4cHwS+TtTTqnhXtqg4mC3ea2VaFNW9WJX+DrPpMOnGXjmT3JCO+lOnxR4LhLYAyKloSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Bxnut9lLhl+jUIAA--.25090S3;
	Tue, 30 Jan 2024 14:17:33 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxnhN7lLhlYXQnAA--.34034S2;
	Tue, 30 Jan 2024 14:17:31 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/8] Add objtool, orc and livepatching support for LoongArch
Date: Tue, 30 Jan 2024 14:17:22 +0800
Message-ID: <20240130061730.21118-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxnhN7lLhlYXQnAA--.34034S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr45JF45KFyUury7XFWDtrc_yoWruF1rpF
	9rZrykGF4UWr93Aw1Dta4UurWDJan7Gr12g3Wavry8CFW2qr1DArsakryDZF9Fqa1rGFy0
	qF1rGw4aqa1jqabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=

This version is based on 6.8-rc2, tested with the latest upstream
gcc and binutils (20240129).

v6:
  -- Add "-mno-relax" option
  -- Remove "-fno-optimize-sibling-calls" option
  -- Remove "-falign-functions=4 -falign-labels=4" options
  -- Remove "#ifdef CONFIG_CPU_HAS_LBT" in lbt.S
  -- Remove patch "objtool: Check local label about sibling call"
  -- Silence the objtool warnings under CONFIG_FUNCTION_TRACER
  -- Add livepatching support and fix the problems when testing

Tiezhu Yang (8):
  objtool/LoongArch: Enable objtool to be built
  objtool/LoongArch: Implement instruction decoder
  objtool/x86: Separate arch-specific and generic parts
  objtool/LoongArch: Enable orc to be built
  objtool: Check local label in add_dead_ends()
  objtool: Check local label in read_unwind_hints()
  LoongArch: Add ORC stack unwinder support
  LoongArch: Add kernel livepatching support

 arch/loongarch/Kconfig                        |   6 +
 arch/loongarch/Kconfig.debug                  |  11 +
 arch/loongarch/Makefile                       |  23 +-
 arch/loongarch/include/asm/Kbuild             |   2 +
 arch/loongarch/include/asm/bug.h              |   1 +
 arch/loongarch/include/asm/exception.h        |   2 +
 arch/loongarch/include/asm/module.h           |   7 +
 arch/loongarch/include/asm/orc_header.h       |  18 +
 arch/loongarch/include/asm/orc_lookup.h       |  31 ++
 arch/loongarch/include/asm/orc_types.h        |  58 ++
 arch/loongarch/include/asm/stackframe.h       |   3 +
 arch/loongarch/include/asm/thread_info.h      |   2 +
 arch/loongarch/include/asm/unwind.h           |  20 +-
 arch/loongarch/include/asm/unwind_hints.h     |  28 +
 arch/loongarch/kernel/Makefile                |   4 +
 arch/loongarch/kernel/entry.S                 |   5 +
 arch/loongarch/kernel/fpu.S                   |   7 +
 arch/loongarch/kernel/genex.S                 |   6 +
 arch/loongarch/kernel/lbt.S                   |   2 +
 arch/loongarch/kernel/mcount_dyn.S            |   6 +
 arch/loongarch/kernel/module.c                |  22 +-
 arch/loongarch/kernel/relocate_kernel.S       |   8 +-
 arch/loongarch/kernel/rethook_trampoline.S    |   1 +
 arch/loongarch/kernel/setup.c                 |   2 +
 arch/loongarch/kernel/stacktrace.c            |  42 ++
 arch/loongarch/kernel/traps.c                 |  42 +-
 arch/loongarch/kernel/unwind_orc.c            | 516 ++++++++++++++++++
 arch/loongarch/kernel/vmlinux.lds.S           |   3 +
 arch/loongarch/kvm/switch.S                   |   9 +-
 arch/loongarch/lib/clear_user.S               |   2 +
 arch/loongarch/lib/copy_user.S                |   2 +
 arch/loongarch/lib/memcpy.S                   |   2 +
 arch/loongarch/lib/memset.S                   |   2 +
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
 tools/objtool/check.c                         |  52 +-
 tools/objtool/include/objtool/elf.h           |   1 +
 tools/objtool/include/objtool/orc.h           |  14 +
 tools/objtool/orc_dump.c                      |  69 +--
 tools/objtool/orc_gen.c                       | 113 +---
 56 files changed, 2011 insertions(+), 239 deletions(-)
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


