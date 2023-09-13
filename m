Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B650279EB20
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241171AbjIMOa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241070AbjIMOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:30:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D6E91
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:30:49 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c39f2b4f5aso28429335ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1694615449; x=1695220249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgJ7ho64PWmdEQGindJ/iYi2WUEGv6uVRhh7Nn8vnYw=;
        b=V9/8wT6kdogY/I94SxwJ1pIDWHOJIr9AVcNbfjv9c9P5MOxAHW8iq2mEUPaSgp72Yq
         1/eyLvdB8nBDJIBVuQXWQJ41J5Q15crw9U7RjN15h1UH3UHO54rO+nDicw6NAjcEVhlF
         k7Xthp6xpGujTMWaGu24l/K+DrPrCq6suywnt3Ep3HVoSZcjXo9fTOXHriATyoHrLuL6
         jFeMBcGu1rcXs3Olhnw9b1mtKZNlEbdVfgKRwju5yUPPHWFSTMjSBlxy/a3ILEkMLERF
         o979l3I61+4WmtskzFbWsABFDyxUFG86V5v1Whoredt87pU4bOO+epuM+zbNCliuMNzE
         mLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694615449; x=1695220249;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgJ7ho64PWmdEQGindJ/iYi2WUEGv6uVRhh7Nn8vnYw=;
        b=je7O90lVM1ZSsMm/BRkaulIOaba8aO7i1KyLaFe71PU4WeIM1gwIzoav+8IHumpvlS
         4x4XH9M1ub+7XT5Sa+jPBFIf3+1mJyeHUqkXtfiJ01QZb5/tW8KHxUnhcu4hcD2CV1BC
         f0yh3DmWL9wygN8a1kCbV4cqzVKpddWO4oZ4aZ4Nqe64NV0Ws/K22Px/jc6moVFdkJW3
         2BFr+2NTET6Wo+kYaMVIBihPdGMxL8nhPDDUTAe3zz6KfvjhJ2UI3WJN6Vo6g7iLfWZN
         EZolgH6LtkyJXUtFz/IeWzoU9RSnTYQxeZX/HL/qjjOLeYhz1BBxorSvkZ9V2Da4soTx
         ydjQ==
X-Gm-Message-State: AOJu0YxEot4Pei5YK/5wldTZQfo4KdroFD6Pg5iCetWqcJNiDmtLNdt+
        LnjN+lUchI5WcD3VkvCuLPz4Yg==
X-Google-Smtp-Source: AGHT+IFciMNiqnHPYKPekiNiuVG7fgj773Kwcez4AWuo7gjkj8DCSJSLDiz4+6TJK6xgnOVclPuY/g==
X-Received: by 2002:a17:902:e84a:b0:1b5:64a4:bea0 with SMTP id t10-20020a170902e84a00b001b564a4bea0mr3495622plg.10.1694615449079;
        Wed, 13 Sep 2023 07:30:49 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b001bb1f0605b2sm10543211plg.214.2023.09.13.07.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 07:30:48 -0700 (PDT)
Date:   Wed, 13 Sep 2023 07:30:48 -0700 (PDT)
X-Google-Original-Date: Wed, 13 Sep 2023 07:30:45 PDT (-0700)
Subject:     Re: BUG Report: Some issues about vmlinux with emit-relocs 
In-Reply-To: <20230808085438.3445957-1-suagrfillet@gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        suagrfillet@gmail.com, anup@brainfault.org, alex@ghiti.fr,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     suagrfillet@gmail.com
Message-ID: <mhng-0208249f-0619-4be7-bbc7-e1c0ee6e3c8c@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Aug 2023 01:54:38 PDT (-0700), suagrfillet@gmail.com wrote:
> Hi, everyone:
>
> I encountered some issues when testing CONFIG_RELOCATABLE.
>
> The story starts with the issue "the empty relocations in .rela.dyn"
> mentioned in patch 1 of "Introduce 64b relocatable kernel" thread [1].
> And it had been circumvented by ld `--emit-relocs` option in patch 6.
>
> With the `emit-relocs` option enabled, the vmlinux would grow bigger,
> so vmlinux.relocs was created as a backup to generate the Image file
> and vmlinux objcopyed itself to check/strip all .rela* sections.
>
> Not sure there is a solution to fix the "empty relocaions" issue
> and get rid of the `emit-relocs` option.
> Until that, there are some other issues with vmlinux's `emit-relocs` option:
>
> 1. result of `remove-section` varies with different version GNU-objcopy
>
> - the sections of vmlinux with objcopy 2.31.1
>
> riscv64-linux-gnu-readelf -SW 00_rv_test/vmlinux |grep rel
>   [10] .rela.dyn         RELA            ffffffff80c26138 913138 2186a0 18   A  9   0  8
>   [15] .rela__ksymtab    RELA            0000000000000000 11529760 052dd0 18   I 49  14  8
>   [17] .rela__ksymtab_gpl RELA            0000000000000000 1157c530 05eba8 18   I 49  16  8
>   [20] .rela__param      RELA            0000000000000000 115db0d8 005400 18   I 49  19  8
>   [22] .rela__modver     RELA            0000000000000000 115e04d8 000300 18   I 49  21  8
>   [24] .rela__ex_table   RELA            0000000000000000 115e07d8 00cde0 18   I 49  23  8
>   [29] .rela__bug_table  RELA            0000000000000000 115ed5b8 0bd1e0 18   I 49  28  8
>   [32] .data.rel         PROGBITS        ffffffff816a5940 e21940 0d0df0 00  WA  0   0 64
>
> - the sections of vmlinux with objcopy 2.38
>
> riscv64-linux-gnu-readelf -SW 00_rv_newtool/vmlinux | grep rel
>
>
>   [25] .data.rel         PROGBITS        ffffffff816a6340 f77340 0d0cb0 00  WA  0   0 64
>
> The difference comes from binutils's commit c12d9fa2afe ("Support
> objcopy --remove-section=.relaFOO").
> The option `--remove-setions='.rela__'` wasn't supported before
> binutils/objcopy 2.32, so all of '.rela__' RELA sections were kept.
> And '.rela.dyn' section was kept due to the mismatch between the
> stripped 'dyn' section_pattern and the actual '.dynamic' section name.
>
> Should we kill the '.rela.dyn' section from the vmlinux ?
> IMO, some senses (like, kexec/kdump) will load/run vmlinux directly that
> needs this allocatable section.
> And from my kexec/kdump test with vmlinux, the 2nd kernel could start
> with '.rela.dyn' but failed if no '.rela.dyn'.
>
> How about keeping '.rela.dyn' section in vmlinux and
> making `remove-section` consistent with different version GNU-objcopy ?
>
>
> 2. the stripped vmlinux has huge symtab
>
> I found a similar issue[2] about the huge symtab of kernel modules.
>
> The aggressive link-time relaxations of RISC-V need sufficient
> relocation info and local symbols to rewrite the code at link time.
> That would result in a lot of extra symbols and relocations.
>
> Kernel modules are compiled `-mno-relax`. But the toolchain still needed
> to improve to emit fewer things under `-mno-relax`. Util that, stripping
> ko with `--discard-all` or `--discard-locals` would be an option to
> reduce the symtab size. (the Ubuntu fixing patch [3])
>
> While vmlinux now uses `emit-relocs` option that would aggravate the
> symtab size.
> (It would take a long long time to start when using the current vmlinux
> as the Crash's namelist. Crash is busy in symtab_init() function.)
>
> So how about objcopying vmlinux with `--discard-locals` option to
> reduce the symtab size ?
>
> (And how about adopting the Ubuntu patch into riscv kernel tree? )
>
>
> 3. suspicious relocations in vmlinux
>
> The vmlinux has some suspicious R_RISCV_NONE/R_RISCV_64 relocations
> emitted with the `emit-relocs` option, that would be detected by
> `tools/reloc_check.sh` and flush the console when making vmlinux.
>
> riscv64-linux-gnu-objdump -R ./00_rv_newtool/vmlinux | grep -E '\<R_' | awk '{print $2}' | sort | uniq -c
>       6 R_RISCV_64
>   20201 R_RISCV_NONE

Having R_RISCV_NONE in any binary is a bug, it's not a real relocation 
just an internal binutils thing.  There's another bug on sourceware 
about it, we're not quite sure what the right answer is yet:

https://sourceware.org/bugzilla/show_bug.cgi?id=30844

>   71307 R_RISCV_RELATIVE
>
> Is there a way/tool to get rid of these relocations from vmlinux,
> or temporarily silence the echo of those bad relocations?
>
>
> [1]: https://lore.kernel.org/all/20230329045329.64565-1-alexghiti@rivosinc.com/
> [2]: https://github.com/riscv-collab/riscv-gnu-toolchain/issues/1036
> [3]: https://patchwork.ozlabs.org/project/ubuntu-kernel/patch/20220309161622.124754-1-dimitri.ledkov@canonical.com/#2855027
>
> Finally, you can try this temporary git-diff for issue1 and issue2:
>
> diff --git a/arch/riscv/Makefile.postlink b/arch/riscv/Makefile.postlink
> index a46fc578b30b..3324c3ede9c6 100644
> --- a/arch/riscv/Makefile.postlink
> +++ b/arch/riscv/Makefile.postlink
> @@ -20,10 +20,10 @@ quiet_cmd_cp_vmlinux_relocs = CPREL   vmlinux.relocs
>  cmd_cp_vmlinux_relocs = cp vmlinux vmlinux.relocs
>
>  quiet_cmd_relocs_strip = STRIPREL $@
> -cmd_relocs_strip = $(OBJCOPY)   --remove-section='.rel.*'       \
> -                                --remove-section='.rel__*'      \
> -                                --remove-section='.rela.*'      \
> -                                --remove-section='.rela__*' $@
> +cmd_relocs_strip = 							\
> +	$(CONFIG_SHELL) $(srctree)/arch/riscv/tools/relocs_strip.sh	\
> +				  "$(OBJCOPY)" "$(CONFIG_LD_VERSION)" "$@"
> +
>  endif
>
>  # `@true` prevents complaint when there is nothing to be done
> diff --git a/arch/riscv/tools/relocs_strip.sh b/arch/riscv/tools/relocs_strip.sh
> new file mode 100755
> index 000000000000..20cb69cf041b
> --- /dev/null
> +++ b/arch/riscv/tools/relocs_strip.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +# This script strips and the relocations and the
> +# compiler-generated local symbols of a vmlinux.
> +
> +if [ $# -lt 3 ]; then
> +        echo "$0 [path to objcopy] [version of GNU objcopy] [path to vmlinux]" 1>&2
> +        exit 1
> +fi
> +
> +objcopy="$1"
> +objcopy_version="$2"
> +vmlinux="$3"
> +
> +# binutils/objcopy didn't support '--remove-setions='.rela__'' option util 2.32,
> +# use `--remove-relocations` to remove those RELA sections.
> +
> +if [ 0 -lt $objcopy_version -a 23200 -gt $objcopy_version ]; then
> +
> +	$objcopy --remove-section='.rel.*'	\
> +		 --remove-section='.rela.*'	\
> +		 --remove-relocations='__*' $vmlinux
> +else
> +	$objcopy --keep-section='.rela.dyn'	\
> +		 --remove-section='.rel.*'	\
> +		 --remove-section='.rel__*'	\
> +		 --remove-section='.rela.*'	\
> +		 --remove-section='.rela__*' $vmlinux
> +fi
> +
> +# discard the compiler-generated local symbols of vmlinux
> +
> +$objcopy --discard-locals $vmlinux
