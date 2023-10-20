Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21EB57D0AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376527AbjJTIwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376531AbjJTIvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:51:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0214FD45
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:51:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E40C433C9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697791904;
        bh=7wCZJNariC+ywRbblSwGuyBQzQuVdm9CW0r/K3XTqys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hneA6Aur47t7YtokfAlAY/QkhJrpM/u5OEIbMfHN5bFiybPQV3k2Ms8Mac617nE9t
         a3wiE2Gwce1RmUACuSSn3pAl9y0rOnauRjk6juKZmarxgCkb+Z3Oon58BQ2kKNjgmx
         I2iunQKGLOpZt4ZYICaYlqfQ+E8VDia2RHeC0hmHAprTWJnpWv9pIxqGVmelZ11caR
         2JPx/3nt6y7ozOQzMjPhiPjmiSnoMerQ/UDirWGNRBlM8JoR72e68bCSci18kR+Qh4
         V56C5DYhRtK3ujG/plS+t+vhnPYsUzPw5Yu9hDno7ubODZ0vWvbMjry9YkTxytrz5L
         y0bCz6d2cbsPw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9c3aec5f326so359630566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:51:44 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx/dBNmlyNB8mBMDETgYMpP+GcNcAha9qtG3unLNXTtrmsToUCZ
        dCVMHiMGmeVnPyqR29SAufXHd+axn6Q5zPiVPDo=
X-Google-Smtp-Source: AGHT+IGbd+qPL/UanMfgCbBiAOq6gRK2ufsPAqbB3ZzkZpT7echM7jAojr1gyWFsGKHe+GpLquXKDxN0EMUJKj7Z8ro=
X-Received: by 2002:a17:907:3da9:b0:9bd:a66a:a22 with SMTP id
 he41-20020a1709073da900b009bda66a0a22mr916731ejc.15.1697791903082; Fri, 20
 Oct 2023 01:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <1697768821-22931-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1697768821-22931-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 20 Oct 2023 16:51:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4wqO0=+EOhyH+t=0bpiX2DayddVArB=x_yzVvmX9OW1g@mail.gmail.com>
Message-ID: <CAAhV-H4wqO0=+EOhyH+t=0bpiX2DayddVArB=x_yzVvmX9OW1g@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Add objtool and orc support for LoongArch
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cross compiling on X86 for LoongArch fails:

  CALL    scripts/checksyscalls.sh
  DESCEND objtool
make[5]: *** No rule to make target
'/usr/lib/gcc/x86_64-redhat-linux/8/include/stdbool.h', needed by
'/home/chenhuacai/linux-official.git/tools/objtool/libsubcmd/exec-cmd.o'.
Stop.
make[4]: *** [Makefile:80:
/home/chenhuacai/linux-official.git/tools/objtool/libsubcmd/libsubcmd-in.o]
Error 2
make[3]: *** [Makefile:82:
/home/chenhuacai/linux-official.git/tools/objtool/libsubcmd/libsubcmd.a]
Error 2
make[2]: *** [Makefile:73: objtool] Error 2
make[1]: *** [/home/chenhuacai/linux-official.git/Makefile:1355:
tools/objtool] Error 2
make: *** [Makefile:234: __sub-make] Error 2

Huacai

On Fri, Oct 20, 2023 at 10:27=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.c=
n> wrote:
>
> This version is based on the latest torvalds/linux.git (20231020)
> which includes the commit 00c2ca84c680 ("LoongArch: Use SYM_CODE_*
> to annotate exception handlers"), tested with the latest upstream
> gcc and binutils (20231009).
>
> v3:
>   -- Use tab for indentation in special.h
>   -- Replace BP/bp with FP/fp
>   -- Modify jirl decoder to handle special case in hibernate_asm.o
>   -- Remove the calling of bswap_if_needed() which always return false
>   -- Remove OBJECT_FILES_NON_STANDARD_suspend_asm.o
>   -- Remove check of assembler version in Makefile
>   -- Remove UNWIND_HINT_EMPTY in kernel_entry
>   -- Put unwind_init() after cpu_probe()
>   -- Remove CONFIG_BPF_JIT_ALWAYS_ON in defconfig
>   -- Rename title of patch #8 to "Add ORC stack unwinder support"
>   -- Fix build error of scripts/sorttable.h reported by test robot
>   -- Add exception_table[] to save exception handlers
>
> Tiezhu Yang (8):
>   objtool/LoongArch: Enable objtool to be built
>   objtool/LoongArch: Implement instruction decoder
>   objtool/x86: Separate arch-specific and generic parts
>   objtool/LoongArch: Enable orc to be built
>   objtool: Check local label about sibling call
>   objtool: Check local label in add_dead_ends()
>   objtool: Check local label in read_unwind_hints()
>   LoongArch: Add ORC stack unwinder support
>
>  arch/loongarch/Kconfig                             |   2 +
>  arch/loongarch/Kconfig.debug                       |  11 +
>  arch/loongarch/Makefile                            |  18 +
>  arch/loongarch/include/asm/Kbuild                  |   1 +
>  arch/loongarch/include/asm/bug.h                   |   1 +
>  arch/loongarch/include/asm/exception.h             |   2 +
>  arch/loongarch/include/asm/module.h                |   7 +
>  arch/loongarch/include/asm/orc_header.h            |  19 +
>  arch/loongarch/include/asm/orc_lookup.h            |  34 ++
>  arch/loongarch/include/asm/orc_types.h             |  58 +++
>  arch/loongarch/include/asm/stackframe.h            |   3 +
>  arch/loongarch/include/asm/unwind.h                |  22 +-
>  arch/loongarch/include/asm/unwind_hints.h          |  28 ++
>  arch/loongarch/kernel/Makefile                     |   3 +
>  arch/loongarch/kernel/entry.S                      |   5 +
>  arch/loongarch/kernel/genex.S                      |   4 +
>  arch/loongarch/kernel/module.c                     |  11 +-
>  arch/loongarch/kernel/relocate_kernel.S            |   2 +
>  arch/loongarch/kernel/setup.c                      |   2 +
>  arch/loongarch/kernel/stacktrace.c                 |   1 +
>  arch/loongarch/kernel/traps.c                      |  44 +-
>  arch/loongarch/kernel/unwind_orc.c                 | 522 +++++++++++++++=
++++++
>  arch/loongarch/kernel/vmlinux.lds.S                |   3 +
>  arch/loongarch/lib/Makefile                        |   2 +
>  arch/loongarch/mm/tlb.c                            |  27 +-
>  arch/loongarch/mm/tlbex.S                          |   9 +
>  arch/loongarch/vdso/Makefile                       |   1 +
>  include/linux/compiler.h                           |   9 +
>  scripts/Makefile                                   |   7 +-
>  tools/arch/loongarch/include/asm/inst.h            | 161 +++++++
>  tools/arch/loongarch/include/asm/orc_types.h       |  58 +++
>  tools/include/linux/bitops.h                       |  11 +
>  tools/objtool/Makefile                             |   4 +
>  tools/objtool/arch/loongarch/Build                 |   3 +
>  tools/objtool/arch/loongarch/decode.c              | 352 ++++++++++++++
>  .../objtool/arch/loongarch/include/arch/cfi_regs.h |  22 +
>  tools/objtool/arch/loongarch/include/arch/elf.h    |  30 ++
>  .../objtool/arch/loongarch/include/arch/special.h  |  33 ++
>  tools/objtool/arch/loongarch/orc.c                 | 171 +++++++
>  tools/objtool/arch/loongarch/special.c             |  15 +
>  tools/objtool/arch/x86/Build                       |   1 +
>  tools/objtool/arch/x86/orc.c                       | 188 ++++++++
>  tools/objtool/check.c                              | 118 +++--
>  tools/objtool/include/objtool/orc.h                |  14 +
>  tools/objtool/orc_dump.c                           |  69 +--
>  tools/objtool/orc_gen.c                            | 113 +----
>  46 files changed, 1964 insertions(+), 257 deletions(-)
>  create mode 100644 arch/loongarch/include/asm/orc_header.h
>  create mode 100644 arch/loongarch/include/asm/orc_lookup.h
>  create mode 100644 arch/loongarch/include/asm/orc_types.h
>  create mode 100644 arch/loongarch/include/asm/unwind_hints.h
>  create mode 100644 arch/loongarch/kernel/unwind_orc.c
>  create mode 100644 tools/arch/loongarch/include/asm/inst.h
>  create mode 100644 tools/arch/loongarch/include/asm/orc_types.h
>  create mode 100644 tools/objtool/arch/loongarch/Build
>  create mode 100644 tools/objtool/arch/loongarch/decode.c
>  create mode 100644 tools/objtool/arch/loongarch/include/arch/cfi_regs.h
>  create mode 100644 tools/objtool/arch/loongarch/include/arch/elf.h
>  create mode 100644 tools/objtool/arch/loongarch/include/arch/special.h
>  create mode 100644 tools/objtool/arch/loongarch/orc.c
>  create mode 100644 tools/objtool/arch/loongarch/special.c
>  create mode 100644 tools/objtool/arch/x86/orc.c
>  create mode 100644 tools/objtool/include/objtool/orc.h
>
> --
> 2.1.0
>
