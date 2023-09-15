Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AD67A2227
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 17:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbjIOPR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 11:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbjIOPRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 11:17:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B07E50
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:17:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9301AC433CA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694791061;
        bh=Pn5wagKwIIkrewPEK5Nl2LLTjnSePpF+xfXYXJO0WYc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uBdTy9/j5LjtmTLykyB3tw4+mKLRonDty+LiVreZDSSlqCE/fKVatnS4Oc670mvOS
         w15oWMDFrsSc4Uy8GCpNNfvAbB5Oek/gn6M77SpAqmHVrYdn4hRDYwGDz9BN0TVQSc
         yv6CP60YZs9qPQGlZGlKYumL+DxEUvvw2I4vFr3+vLKEWw3eIttGD5PKBReaMgI20E
         Sdf2sv8HqVNDATm9QVKKdZ+CY1QzftP2IRNO+eNl0kVK5+6H01J5gorO72Ndp91nIF
         R0Olv/ms0ehD/QCkAoA2a527YZ8pw/BfQ+iqeQHpWqFYN2ZIiEx/KONsTXxNi/LjkB
         Nl32Z41HkwnjA==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-53087f0e18bso996785a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 08:17:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YzMoqJfhxnc8k2TGXptqDoFf5thsawET7n3HUa788/PMeH3Q30/
        Fx5M3vfiIBDibcO73oC5WxHq8yj1Z72rZbapAP8=
X-Google-Smtp-Source: AGHT+IHpOK75kILAwOKB+Q5UlF87xwn69ocBr6qslTeX6x1Qiydj6IjmSpCpQtP6mHvI+o8Z2EJhNyYzQdRfechbeVU=
X-Received: by 2002:a05:6402:344e:b0:526:d6d2:aeb5 with SMTP id
 l14-20020a056402344e00b00526d6d2aeb5mr1560565edc.9.1694791059969; Fri, 15 Sep
 2023 08:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <ZQC5jS/Kc/JiBEOa@p100> <CAAhV-H56oqmQhA1PKh3E6z0A04qfRPehQ8ATOiirAU2O+z=fgw@mail.gmail.com>
 <b1c729bf-86b9-8a1f-c6af-a69be2b4a44c@gmx.de> <CAAhV-H44mDiP2DWATVyvKq6n8qj=sLhjHxzMo_+_zyggoGR1pw@mail.gmail.com>
 <1160d063-8396-b126-15ca-a46807ec4258@gmx.de> <644b77db-7214-88c3-7ba6-9c805a134e63@roeck-us.net>
 <2bbc2df8-5fcf-b216-7aa0-192e27bac6e7@xen0n.name>
In-Reply-To: <2bbc2df8-5fcf-b216-7aa0-192e27bac6e7@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Fri, 15 Sep 2023 23:17:30 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6=dCsPeiYGTKO9AbqbndobDp6juTN9EhrKrqXDMjj9HA@mail.gmail.com>
Message-ID: <CAAhV-H6=dCsPeiYGTKO9AbqbndobDp6juTN9EhrKrqXDMjj9HA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix lockdep static memory detection
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Guenter Roeck <linux@roeck-us.net>, Helge Deller <deller@gmx.de>,
        loongarch@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
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

On Fri, Sep 15, 2023 at 10:19=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wr=
ote:
>
> Hi,
>
> On 9/15/23 22:07, Guenter Roeck wrote:
> > Hi Helge,
> >
> > On 9/15/23 03:10, Helge Deller wrote:
> >> On 9/15/23 11:23, Huacai Chen wrote:
> >>> On Fri, Sep 15, 2023 at 4:16=E2=80=AFPM Helge Deller <deller@gmx.de> =
wrote:
> >>>>
> >>>> On 9/15/23 05:22, Huacai Chen wrote:
> >>>>> Hi Helge,
> >>>>>
> >>>>> On Wed, Sep 13, 2023 at 3:18=E2=80=AFAM Helge Deller <deller@gmx.de=
> wrote:
> >>>>>>
> >>>>>> Since commit 0a6b58c5cd0d ("lockdep: fix static memory detection
> >>>>>> even
> >>>>>> more") the lockdep code uses is_kernel_core_data(),
> >>>>>> is_kernel_rodata()
> >>>>>> and init_section_contains() to verify if a lock is located inside =
a
> >>>>>> kernel static data section.
> >>>>>>
> >>>>>> This change triggers a failure on LoongArch, for which the
> >>>>>> vmlinux.lds.S
> >>>>>> script misses to put the locks (as part of in the .data.rel symbol=
s)
> >>>>>> into the Linux data section.
> >>>>>> This patch fixes the lockdep problem by moving *(.data.rel*) symbo=
ls
> >>>>>> into the kernel data section (from _sdata to _edata).
> >>>>>>
> >>>>>> Additionally, move other wrongly assigned symbols too:
> >>>>>> - altinstructions into the _initdata section,
> >>>>
> >>>>> I think altinstructions cannot  be put into _initdata because it wi=
ll
> >>>>> be used by modules.
> >>>>
> >>>> No.
> >>>> arch/loongarch/kernel/vmlinux.lds.S is used for the static parts of
> >>>> the kernel
> >>>> and altinstructions are replaced before modules are loaded.
> >>>> For altinstructions in modules the linker script
> >>>> scripts/module.lds.S is used.
> >>
> >>> OK, then what about .got/.plt? It seems arm64 also doesn't put them i=
n
> >>> the data section.
> >>
> >> arm64 seems to throw away all plt entries already at link time (and
> >> just keeps
> >> the got.plt in the read-only data section).
> >> It even checks at link time, that there are no plt entries in the
> >> binary:
> >>          ASSERT(SIZEOF(.plt) =3D=3D 0, "Unexpected run-time procedure
> >> linkages detected!")
> >>
> >> I don't know for loongarch, but if you need the plt entries for
> >> loongarch, it's
> >> safest & best to put them into the read-only data section too, which
> >> is what my patch does.
> >> Up to now, you have them completely outside of code & data sections.
> >>
> >> In the end you need to decide for your platform. My patch is a
> >> suggestion, which I think
> >> is correct (untested by me, but Guenter replied he tested it).
> >> But to fix the lockdep problem at minimum the move of the .data.rel
> >> section
> >> is needed.
> >>
> >
> > Just my $0.02 .. it might make sense to concentrate on the minimum to
> > get the immediate
> > problem fixed. Loongarch maintainers can then decide at their own pace
> > if they want
> > to apply any of the other changes you suggested. After all, unless I
> > am missing
> > something, those additional changes are not really needed in stable
> > releases.
>
> Sorry for coming late, but as reviewer of arch/loongarch, I'd agree with
> Guenter and Helge here: let's fix the immediate problem and investigate
> the rest later -- it's not like the problems are *definitely* orthogonal
> in this case, and at least *some* progress would be appreciated.
>
> I'll try to reproduce the problem and test the fix during the weekend,
> so hopefully Huacai can get the fix in before -rc2 or -rc3. Thanks for
> the attention and fix.
If all changes are OK, I have no objection to putting them in a single patc=
h.

Huacai

>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
>
