Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927DE7AEB92
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjIZLhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjIZLhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:37:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD34DE;
        Tue, 26 Sep 2023 04:37:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE27C433C8;
        Tue, 26 Sep 2023 11:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695728247;
        bh=O+RcTs6al0nb2ywW5JP9SXFLkrSXtK+6NJnpj8EIVPI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fJr31bDuAVzGw0DgCWU3iTzYDjFju5ygKLXeFx7Emkbp3HIY31hQRXhNzEKe9d0/e
         zjljv0oEpOH3Z0bgSHZpHwFcGwYkHphfYDL+rCy6YHjA62EPAeN75PainVoGTDeCx6
         bCuzMJO35T0ome16h4PaZDjA8Di7Pv7MVsMOo07/DqSeHXHWFfBYvU73xqeMNKuIr6
         ojDgSRFAXPCnXxQLg3EKqPDZclWISr6+7jCi+Cl2HL1UeIm/nCT6nLlCh4dtyIEr7Q
         ZRhHOjCCp34A5qJrYSXhVesESFM1L6muyuEIJ6d4+WWOT3eqFF2JJOolCo7BD089zn
         ylZCVrTB5ehtw==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so141416451fa.2;
        Tue, 26 Sep 2023 04:37:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YzXsx2SUecTr4QEGRgYfW/oHr/ukMhHF28JOBb1vns5VpPdmJ0p
        WbzP31bOU9kFbghiyGeldUBlyqRT42CYPDsmg8o=
X-Google-Smtp-Source: AGHT+IHFh6Q3ky5Gr0feeJ3Zj2d9YEYuNkYdUgpzVdgj/M2mi+hvARG8ElmoIEndOncNiWnwKYAlxHRqRsUxo6LlK0o=
X-Received: by 2002:a2e:9888:0:b0:2bd:1000:431d with SMTP id
 b8-20020a2e9888000000b002bd1000431dmr7936723ljj.10.1695728245423; Tue, 26 Sep
 2023 04:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230925110023.1796789-1-masahiroy@kernel.org>
In-Reply-To: <20230925110023.1796789-1-masahiroy@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 26 Sep 2023 11:37:14 +0000
X-Gmail-Original-Message-ID: <CAMj1kXHM_dRNVeMuwiPyniz4qUh8JT6mmX2R2VdhBMLCjFA8WQ@mail.gmail.com>
Message-ID: <CAMj1kXHM_dRNVeMuwiPyniz4qUh8JT6mmX2R2VdhBMLCjFA8WQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix get_user() broken with veneer
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masahiro,

Thanks for getting to the bottom of this.

The patch looks correct to me, but could we please drop this huge
commit log text? The AAPCS simply states that a BL instruction might
clobber IP, so any inline asm that contains a BL should have IP in its
clobber list. In our case, the use of PIC veneers is what might cause
this, so we should mention that as well. But your entire journey to
get to that conclusion is not something that deserves to be included
in the git commit log forever, imho.

So with the commit log trimmed:

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


Thanks,



On Mon, 25 Sept 2023 at 11:00, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The 32-bit ARM kernel stops working when it exceeds a certain size
> threshold.
>
> This problem can occur, for instance, when enabling certain debug CONFIG
> options or when linking numerous drivers as builtins, but reproducing
> it primarily depends on the kernel size. To demonstrate this, I wrote a
> debug Makefile code.
>
> The following debug code generates and links drivers/dummy-*.S. The
> NR_DUMMY_FILES variable specifies the number of dummy-*.S files to link.
> The added code should be harmless except growing the kernel, as it
> introduces unused symbols, dummy_0, dummy_1, and so on, each of which
> occupies 64K code.
>
> [Applying debug Makefile code]
>
> Run the following code.
>
> $ cat <<'EOF' >> drivers/Makefile
>
> dummy-sources := $(shell i=0; while [ "$$i" -lt "$(NR_DUMMY_FILES)" ]; do echo dummy-$$i.S; i=$$(( i + 1 )); done)
> targets += $(dummy-sources)
> obj-y += $(patsubst %.S,%.o,$(dummy-sources))
>
> quiet_cmd_gen_dummy = GEN   $@
>       cmd_gen_dummy = { \
>           echo '\#include <linux/linkage.h>'; \
>           echo '.section ".text","ax"'; \
>           echo "ENTRY(dummy_$*)"; \
>           echo ".fill 65536, 1, 0"; \
>           echo "ENDPROC(dummy_$*)"; \
>       } > $@
>
> $(obj)/dummy-%.S: FORCE; $(call if_changed,gen_dummy)
> EOF
>
> [Build result]
>
> You can easily increase the .text section by giving NR_DUMMY_FILES from
> the build command.
>
>  [1] ARM defconfig + NR_DUMMY_FILES=250
>
>   This inserts (64K * 250) dummy code on top of defconfig.
>   The kernel boots.
>
>   $ make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- NR_DUMMY_FILES=250 defconfig all
>   $ arm-linux-gnueabihf-size vmlinux
>   text      data     bss     dec       hex      filename
>   33361996  9278130  427088  43067214  291274e  vmlinux
>   $ arm-linux-gnueabihf-nm vmlinux | grep ' [tT] ' | grep __get_user_4
>   c20e5dbc T __get_user_4
>
>  [2] ARM defconfig + NR_DUMMY_FILES=350
>
>   This inserts (64K * 350) dummy code on top of defconfig.
>   The kernel does not boot any more.
>
>   $ make -j$(nproc) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- NR_DUMMY_FILES=350 defconfig all
>   $ arm-linux-gnueabihf-size vmlinux
>   text      data     bss     dec       hex      filename
>   39946652  9282226  427088  49655966  2f5b09e  vmlinux
>   $ arm-linux-gnueabihf-nm vmlinux | grep ' [tT] ' | grep __get_user_4
>   c272931c T __get_user_4
>   c06f6b10 t ____get_user_4_veneer
>   c0aef930 t ____get_user_4_veneer
>
> I noticed ____get_user_4_veneer was causing the issue.
>
> After commit 02e541db0540 ("ARM: 8323/1: force linker to use PIC veneers"),
> veneers use the ip (= r12) register.
>
> The disassembly of the veneer looks as follows:
>
>   c06f6b10 <____get_user_4_veneer>:
>   c06f6b10:       e59fc000        ldr     ip, [pc]        @ c06f6b18 <____get_user_4_veneer+0x8>
>   c06f6b14:       e08ff00c        add     pc, pc, ip
>   c06f6b18:       02032800        .word   0x02032800
>
> When a routine is called via a veneer, the ip register is destroyed.
>
> It is absolutely fine.
>
> AAPCS32 [1] says:
>
>  "Register r12 (IP) may be used by a linker as a scratch register between
>   a routine and any subroutine it calls. It can also be used within a
>   routine to hold intermediate values between subroutine calls."
>
> Of course, the compiler knows it, but the problem here is, the compiler
> cannot notice the 'bl' instruction inside the inline asm.
>
> In __get_user_check(), uaccess_save_and_enable() and uaccess_restore()
> functions read and restore the value of the DACR register. There is no
> obvious function call between them because __get_user_x() is a macro.
> However, there is a branch to __get_user_4 buried within inline asm,
> which the compiler is not aware of. Because only "lr" and "cc" are
> listed in the clobber, the compiler considers it safe to use the ip
> register to hold __ua_flags.
>
> The disassembly of do_undefinstr() looks as follows:
>
>   c030b2bc <do_undefinstr>:
>     [snip]
>   c030b3d8:       e1a01006        mov     r1, r6
>   c030b3dc:       e306077c        movw    r0, #26492        @ 0x677c
>   c030b3e0:       e34c02c5        movt    r0, #49861        @ 0xc2c5
>   c030b3e4:       e3a02000        mov     r2, #0
>   c030b3e8:       e8bd41f0        pop     {r4, r5, r6, r7, r8, lr}
>   c030b3ec:       eafffe2e        b       c030acac <die>
>   c030b3f0:       ee13cf10        mrc     15, 0, ip, cr3, cr0, {0}          <== DACR is loaded to ip
>   c030b3f4:       e3cc300c        bic     r3, ip, #12
>   c030b3f8:       e1a00007        mov     r0, r7
>   c030b3fc:       e3833004        orr     r3, r3, #4
>   c030b400:       e3e01441        mvn     r1, #1090519040        @ 0x41000000
>   c030b404:       ee033f10        mcr     15, 0, r3, cr3, cr0, {0}
>   c030b408:       f57ff06f        isb     sy
>   c030b40c:       eb0fadbf        bl      c06f6b10 <____get_user_4_veneer>  <== ip is destroyed here
>   c030b410:       ee03cf10        mcr     15, 0, ip, cr3, cr0, {0}          <== ip is written back to DACR
>   c030b414:       f57ff06f        isb     sy
>   c030b418:       e3500000        cmp     r0, #0
>
> Add "ip" to the clobber list to inform the compiler that it may be
> destroyed if we end up with a veneer.
>
> [1]: https://github.com/ARM-software/abi-aa/blob/2023Q1/aapcs32/aapcs32.rst
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> I did not check the entire ARM code to seek for a similar pattern,
> but I confirmed  __put_user_check() had "ip" "lr" "cc" in the clobber
> list.
>
> Perhaps, another way is to list out all registers not guaranteed
> in the spec.
>
> AAPCS32 says, "A subroutine must preserve the contents of the registers
> r4-r8, r10, r11 and SP".
>
> The others might be clobbered. Of course, clobbered registers are
> predicable as we write the subroutines in assembly code (only ip is
> conditionally clobbered if veneers are generated), but it will be
> safe in case we change the assembly code.
>
>
>  arch/arm/include/asm/uaccess.h | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index bb5c81823117..c28f5ec21e41 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -109,16 +109,6 @@ extern int __get_user_64t_1(void *);
>  extern int __get_user_64t_2(void *);
>  extern int __get_user_64t_4(void *);
>
> -#define __GUP_CLOBBER_1        "lr", "cc"
> -#ifdef CONFIG_CPU_USE_DOMAINS
> -#define __GUP_CLOBBER_2        "ip", "lr", "cc"
> -#else
> -#define __GUP_CLOBBER_2 "lr", "cc"
> -#endif
> -#define __GUP_CLOBBER_4        "lr", "cc"
> -#define __GUP_CLOBBER_32t_8 "lr", "cc"
> -#define __GUP_CLOBBER_8        "lr", "cc"
> -
>  #define __get_user_x(__r2, __p, __e, __l, __s)                         \
>            __asm__ __volatile__ (                                       \
>                 __asmeq("%0", "r0") __asmeq("%1", "r2")                 \
> @@ -126,7 +116,7 @@ extern int __get_user_64t_4(void *);
>                 "bl     __get_user_" #__s                               \
>                 : "=&r" (__e), "=r" (__r2)                              \
>                 : "0" (__p), "r" (__l)                                  \
> -               : __GUP_CLOBBER_##__s)
> +               : "ip", "lr", "cc")
>
>  /* narrowing a double-word get into a single 32bit word register: */
>  #ifdef __ARMEB__
> @@ -148,7 +138,7 @@ extern int __get_user_64t_4(void *);
>                 "bl     __get_user_64t_" #__s                           \
>                 : "=&r" (__e), "=r" (__r2)                              \
>                 : "0" (__p), "r" (__l)                                  \
> -               : __GUP_CLOBBER_##__s)
> +               : "ip", "lr", "cc")
>  #else
>  #define __get_user_x_64t __get_user_x
>  #endif
> --
> 2.39.2
>
