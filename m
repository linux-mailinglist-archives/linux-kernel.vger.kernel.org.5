Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A977A1A81
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjIOJ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbjIOJ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:26:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F9A4237
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:23:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803E7C433CD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694769810;
        bh=LWjbHHD1AKzOXNTWg1RLXHiP86HEf3dv2TI9RydxFBM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j6vKH5sEITz8dU/Xz6I4urspsE8PFEvVLHpF3344usS+0ulGoIwkeYGIzKC1E/Lhy
         C7+F/lbrGxs+OeCYM6AVd3kyhOBRfwQhmifbMOE8wBy/sOm6vat88QTxd6LBHmeK9X
         q7bhFVKmD6yvlQWTuXGMlI3gy/9flRFo9XK4WYFRlRW5ls5M/a1LTVHzuN+OkbiE87
         5o4SdCb3qrUVPtDDQzVaezzTyZvVZ6Pfd16zvUxokqGhkGqFsBmkGwzVvZAcBbaEVX
         i8RQBeDwa9xkX9NylLYzpbVLZcRAUMZZtZFJpkix2CyWSlDhmJyWEVDc3k2RVyT0G1
         sxF1UFr5nUK+g==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2bfb0a2682fso31477421fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:23:30 -0700 (PDT)
X-Gm-Message-State: AOJu0YwmfAYeiUcZZ4AeVPjQ1ZRXfoty7DeSKDit6E2O+wq4kYeGpv+X
        2sbIJkrLrSShaT5iPbRF8Xek9SUqEtFBZ70ayxE=
X-Google-Smtp-Source: AGHT+IH3XG6mXlyJ/to9M/kFOv4K0YybmiN0nSgX2SmurjB1i5HaZAFfOqbg8TxLHmLLTrFj0zrEvqnxXcuJWgtj2gI=
X-Received: by 2002:a2e:7e12:0:b0:2bc:d6d8:8ab5 with SMTP id
 z18-20020a2e7e12000000b002bcd6d88ab5mr984500ljc.24.1694769808663; Fri, 15 Sep
 2023 02:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <ZQC5jS/Kc/JiBEOa@p100> <CAAhV-H56oqmQhA1PKh3E6z0A04qfRPehQ8ATOiirAU2O+z=fgw@mail.gmail.com>
 <b1c729bf-86b9-8a1f-c6af-a69be2b4a44c@gmx.de>
In-Reply-To: <b1c729bf-86b9-8a1f-c6af-a69be2b4a44c@gmx.de>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 15 Sep 2023 17:23:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H44mDiP2DWATVyvKq6n8qj=sLhjHxzMo_+_zyggoGR1pw@mail.gmail.com>
Message-ID: <CAAhV-H44mDiP2DWATVyvKq6n8qj=sLhjHxzMo_+_zyggoGR1pw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix lockdep static memory detection
To:     Helge Deller <deller@gmx.de>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 4:16=E2=80=AFPM Helge Deller <deller@gmx.de> wrote:
>
> On 9/15/23 05:22, Huacai Chen wrote:
> > Hi Helge,
> >
> > On Wed, Sep 13, 2023 at 3:18=E2=80=AFAM Helge Deller <deller@gmx.de> wr=
ote:
> >>
> >> Since commit 0a6b58c5cd0d ("lockdep: fix static memory detection even
> >> more") the lockdep code uses is_kernel_core_data(), is_kernel_rodata()
> >> and init_section_contains() to verify if a lock is located inside a
> >> kernel static data section.
> >>
> >> This change triggers a failure on LoongArch, for which the vmlinux.lds=
.S
> >> script misses to put the locks (as part of in the .data.rel symbols)
> >> into the Linux data section.
> >> This patch fixes the lockdep problem by moving *(.data.rel*) symbols
> >> into the kernel data section (from _sdata to _edata).
> >>
> >> Additionally, move other wrongly assigned symbols too:
> >> - altinstructions into the _initdata section,
>
> > I think altinstructions cannot  be put into _initdata because it will
> > be used by modules.
>
> No.
> arch/loongarch/kernel/vmlinux.lds.S is used for the static parts of the k=
ernel
> and altinstructions are replaced before modules are loaded.
> For altinstructions in modules the linker script scripts/module.lds.S is =
used.
OK, then what about .got/.plt? It seems arm64 also doesn't put them in
the data section.

Huacai

>
> Helge
>
>
> >> - PLT symbols behind the read-only section, and
> >> - *(.la_abs) into the data section.
> >>
> >> Signed-off-by: Helge Deller <deller@gmx.de>
> >> Reported-by: Guenter Roeck <linux@roeck-us.net>
> >> Fixes: 0a6b58c5cd0d ("lockdep: fix static memory detection even more")
> >> Cc: stable <stable@kernel.org> # v6.4+
> >>
> >> diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kern=
el/vmlinux.lds.S
> >> index b1686afcf876..bb2ec86f37a8 100644
> >> --- a/arch/loongarch/kernel/vmlinux.lds.S
> >> +++ b/arch/loongarch/kernel/vmlinux.lds.S
> >> @@ -53,33 +53,6 @@ SECTIONS
> >>          . =3D ALIGN(PECOFF_SEGMENT_ALIGN);
> >>          _etext =3D .;
> >>
> >> -       /*
> >> -        * struct alt_inst entries. From the header (alternative.h):
> >> -        * "Alternative instructions for different CPU types or capabi=
lities"
> >> -        * Think locking instructions on spinlocks.
> >> -        */
> >> -       . =3D ALIGN(4);
> >> -       .altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
> >> -               __alt_instructions =3D .;
> >> -               *(.altinstructions)
> >> -               __alt_instructions_end =3D .;
> >> -       }
> >> -
> >> -#ifdef CONFIG_RELOCATABLE
> >> -       . =3D ALIGN(8);
> >> -       .la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
> >> -               __la_abs_begin =3D .;
> >> -               *(.la_abs)
> >> -               __la_abs_end =3D .;
> >> -       }
> >> -#endif
> >> -
> >> -       .got : ALIGN(16) { *(.got) }
> >> -       .plt : ALIGN(16) { *(.plt) }
> >> -       .got.plt : ALIGN(16) { *(.got.plt) }
> >> -
> >> -       .data.rel : { *(.data.rel*) }
> >> -
> >>          . =3D ALIGN(PECOFF_SEGMENT_ALIGN);
> >>          __init_begin =3D .;
> >>          __inittext_begin =3D .;
> >> @@ -94,6 +67,18 @@ SECTIONS
> >>
> >>          __initdata_begin =3D .;
> >>
> >> +       /*
> >> +        * struct alt_inst entries. From the header (alternative.h):
> >> +        * "Alternative instructions for different CPU types or capabi=
lities"
> >> +        * Think locking instructions on spinlocks.
> >> +        */
> >> +       . =3D ALIGN(4);
> >> +       .altinstructions : AT(ADDR(.altinstructions) - LOAD_OFFSET) {
> >> +               __alt_instructions =3D .;
> >> +               *(.altinstructions)
> >> +               __alt_instructions_end =3D .;
> >> +       }
> >> +
> >>          INIT_DATA_SECTION(16)
> >>          .exit.data : {
> >>                  EXIT_DATA
> >> @@ -113,6 +98,11 @@ SECTIONS
> >>
> >>          _sdata =3D .;
> >>          RO_DATA(4096)
> >> +
> >> +       .got : ALIGN(16) { *(.got) }
> >> +       .plt : ALIGN(16) { *(.plt) }
> >> +       .got.plt : ALIGN(16) { *(.got.plt) }
> >> +
> >>          RW_DATA(1 << CONFIG_L1_CACHE_SHIFT, PAGE_SIZE, THREAD_SIZE)
> >>
> >>          .rela.dyn : ALIGN(8) {
> >> @@ -121,6 +111,17 @@ SECTIONS
> >>                  __rela_dyn_end =3D .;
> >>          }
> >>
> >> +       .data.rel : { *(.data.rel*) }
> >> +
> >> +#ifdef CONFIG_RELOCATABLE
> >> +       . =3D ALIGN(8);
> >> +       .la_abs : AT(ADDR(.la_abs) - LOAD_OFFSET) {
> >> +               __la_abs_begin =3D .;
> >> +               *(.la_abs)
> >> +               __la_abs_end =3D .;
> >> +       }
> >> +#endif
> >> +
> >>          .sdata : {
> >>                  *(.sdata)
> >>          }
>
