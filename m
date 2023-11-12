Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B787E8E4A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 05:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjKLEWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 23:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjKLEWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 23:22:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232AB30D1;
        Sat, 11 Nov 2023 20:22:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF58C433AB;
        Sun, 12 Nov 2023 04:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699762926;
        bh=FJL4JNEf9Nr1DoflQgnKi0tfP9lyYuVjCmmad2iv8TA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FacYEZCQKy7zh6VsDp47yhkL+9he5Y+BzcuRtc1i6KHlTBkqaeroQJJDPLMRFLWD9
         QNhskha1onUHVMj2O/qk8mK8c0vJZhiTXumXWS0CGWZks5ZJFrR6dvkAIDGJkCeV/t
         6amg22+gEIHVdyPSQgk0L9lJZr+X87dXFazyXH2ThFIzgEMWpLCJskz/nC6CtTqsA+
         Z9NTC9QINWCby1hgnVCHVFMOnhZXaqZYk/4H/uttsH8za+SgromnkZZytr79DMdLq5
         z6fSwHr0XX/U0fb4cdcZFZDuYKieV7M2bNXh4VB6zTAsNqvA0mOlgafeRuwkTVq4La
         Yez2M8oVwyWiQ==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so5252690a12.0;
        Sat, 11 Nov 2023 20:22:06 -0800 (PST)
X-Gm-Message-State: AOJu0Yw1fRuDc9XcvafNK/1x/b/M4Fh4EyZo0KDm9eGurcS/rIWfQqv0
        VjXPKVOG7l2f08dG09H3CibhTWMVH9X87+xsUQs=
X-Google-Smtp-Source: AGHT+IGKtBb4zpepnAgJWTPQf4OFL8Yxg0IypTLD7L38xtqORdph/fQnU2/w9oi/MfemCZAy/+rZ76w/2ug+y+JaBNQ=
X-Received: by 2002:a05:6402:3d9:b0:53f:731a:e513 with SMTP id
 t25-20020a05640203d900b0053f731ae513mr2174574edw.25.1699762924720; Sat, 11
 Nov 2023 20:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20231108125843.3806765-1-arnd@kernel.org> <20231108125843.3806765-13-arnd@kernel.org>
In-Reply-To: <20231108125843.3806765-13-arnd@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 11 Nov 2023 23:21:53 -0500
X-Gmail-Original-Message-ID: <CAJF2gTSEziwKn+f6DfZXRuzW1SXaWraKL2HdXMRkEOGyuHq3MQ@mail.gmail.com>
Message-ID: <CAJF2gTSEziwKn+f6DfZXRuzW1SXaWraKL2HdXMRkEOGyuHq3MQ@mail.gmail.com>
Subject: Re: [PATCH 12/22] csky: fix arch_jump_label_transform_static override
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Geoff Levand <geoff@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Helge Deller <deller@gmx.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Timur Tabi <timur@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        David Woodhouse <dwmw2@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-trace-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-bcachefs@vger.kernel.org,
        linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 8:02=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The arch_jump_label_transform_static() function in csky was originally me=
ant to
> override the generic __weak function, but that got changed to an #ifndef =
check.
>
> This showed up as a missing-prototype warning:
> arch/csky/kernel/jump_label.c:43:6: error: no previous prototype for 'arc=
h_jump_label_transform_static' [-Werror=3Dmissing-prototypes]
>
> Change the method to use the new method of having a #define and a prototy=
pe
> for the global function.
>
> Fixes: 7e6b9db27de9 ("jump_label: make initial NOP patching the special c=
ase")
> Fixes: 4e8bb4ba5a55 ("csky: Add jump-label implementation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/include/asm/jump_label.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/csky/include/asm/jump_label.h b/arch/csky/include/asm/j=
ump_label.h
> index d488ba6084bc..98a3f4b168bd 100644
> --- a/arch/csky/include/asm/jump_label.h
> +++ b/arch/csky/include/asm/jump_label.h
> @@ -43,5 +43,10 @@ static __always_inline bool arch_static_branch_jump(st=
ruct static_key *key,
>         return true;
>  }
>
> +enum jump_label_type;
> +void arch_jump_label_transform_static(struct jump_entry *entry,
> +                                     enum jump_label_type type);
> +#define arch_jump_label_transform_static arch_jump_label_transform_stati=
c
> +
>  #endif  /* __ASSEMBLY__ */
>  #endif /* __ASM_CSKY_JUMP_LABEL_H */
> --
> 2.39.2
>
>
Thank you!
Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
