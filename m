Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C9F76C058
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbjHAWWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjHAWW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:22:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF54626A4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 15:22:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bdcade7fbso802717666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 15:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690928541; x=1691533341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIdAXVeCX023CXL0dIkcMbpnpUwf/1Zbz+CDE0MYpdA=;
        b=zGUTQBqADKJI0542k8Xf15503QgzkM457a2OErcRTosiK6bvEFow9m7Sr7TZudLD+d
         nX3StfOcbjXKfqr3JqP6eyP7r/oOTpgmw9B1ggw+P0bEq2fu9am+TKJ3p8YvKtzZQe1c
         5Xw4CeLJHZyiGvmmWk4G8q6WFAfulgLVE6BA2vVpuKeQJK0QUmixCaaW2xm1zBQ6wTOD
         xInmIcL6Us5aCyV+376xag9hDt9UtAkfmXnz+5wMln63QsLlgWx+6lZu2n/WJptfD0n5
         H98bAM3uLuPmn0HftnR3bUIedI0IO5Wq+PS17LMMuCVD0I/IzEB/psoG+ja5ImRAhV5P
         BV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690928541; x=1691533341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIdAXVeCX023CXL0dIkcMbpnpUwf/1Zbz+CDE0MYpdA=;
        b=X5PzKzyyG1iBEn3RfwYS8xRHS1lnzzYDZZlEmQM0maMMU446m5axZh1DcDW4g9wFGR
         xx23DPYhV1aYzkuZbTbu3io4rVtY/klVILPzfWn7uGwoAp1Btp/rYz07H5yPIW2b70Ir
         2yyzVW0bqLLVdzONqYpEaXTZMBt2D0vVRHGH0OI2hXhEdgEiXg06FwhADkiyh2Vi4Syh
         zY5JbKUDrym+LLqu6C3F2HZSolgobkdjI4hY/4TNxKEJ+xcWlyDwPGeRiEzJGYp/+gnS
         uwQAc2svqSEoh++I/JbUiVxnoNWoHg/uzelSphJ1OuaSFr66MlMeVjzSQaM6Of9uACfH
         tw7Q==
X-Gm-Message-State: ABy/qLY8PagTZDvt1r3XsGG8m+BFv3X9Mjt13sW5nP9sCxj0ycFYSQIX
        m6bnsbFyM39Y+GgR+mzwTTYnIk3593yOlxshlIf/fQ==
X-Google-Smtp-Source: APBJJlG198u3S8vlo+W7HOZPH8S9UFWg5AyX+Zc1gJMMdC04QfJg+j+PVN5g40HMzK3BY1igKJGAvns6JeFwNkx9f58=
X-Received: by 2002:aa7:d748:0:b0:518:6a99:cac3 with SMTP id
 a8-20020aa7d748000000b005186a99cac3mr3830626eds.31.1690928540799; Tue, 01 Aug
 2023 15:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-arch-riscv-kernel-v1-1-2b3f2dc0bc61@google.com> <20230801-tinsel-parcel-aa034d07aeb6@spud>
In-Reply-To: <20230801-tinsel-parcel-aa034d07aeb6@spud>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 1 Aug 2023 15:22:07 -0700
Message-ID: <CAFhGd8pCf5Ose-AVH2k-3fP=7AkHsX5eDsd82Z0F5qEdUFT0qQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: cpu: refactor deprecated strncpy
To:     Conor Dooley <conor@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 2:26=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> Hey Justin,
>
> On Tue, Aug 01, 2023 at 09:14:56PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings [=
1].
> >
> > A suitable replacement is `strscpy` [2] due to the fact that it
> > guarantees NUL-termination on its destination buffer argument which is
> > _not_ the case for `strncpy`!
> >
> > The `sv_type` buffer is declared with a size of 16 which is then
> > followed by some `strncpy` calls to populate the buffer with one of:
> > "sv32", "sv57", "sv48", "sv39" or "none". Hard-coding the max length as=
 5 is
> > error-prone and involves counting the number of characters (and
> > hopefully not forgetting to count the NUL-byte) in the raw string.
>
> What is error prone about it when there are only 4 characters possible?

To clarify, I don't believe there is a bug in the current
implementation. However, what I believe to be
error prone is that simply miscounting the length of the raw string
would result in a buffer overread.

See here: https://godbolt.org/z/5reW7a1sz

>
> > Using a pre-determined max length in combination with `strscpy` provide=
s
> > a cleaner, less error-prone as well as a less ambiguous implementation.
> > `strscpy` guarantees that it's destination buffer is NUL-terminated eve=
n
> > if it's source argument exceeds the max length as defined by the third
>
> Wrong its ;)

Oops, English is hard ;(

>
> > argument.
> >
> > To be clear, there is no bug (i think?) in the current implementation
> > but the current hard-coded values in combination with using a deprecate=
d
> > interface make this a worthwhile change, IMO.
> >
> > [1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-=
nul-terminated-strings
> > [2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
>
> This link is broken, it should be
> https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

Noted, will fix in future patches.

>
> Also, in the future, please use the form
>
> Link: <url> [ref]
>
> so
>
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [1]
>
> and so on.
Got it. Thanks!

>
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >  arch/riscv/kernel/cpu.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> > index a2fc952318e9..1c576e4ec171 100644
> > --- a/arch/riscv/kernel/cpu.c
> > +++ b/arch/riscv/kernel/cpu.c
> > @@ -17,6 +17,8 @@
> >  #include <asm/smp.h>
> >  #include <asm/pgtable.h>
> >
> > +#define SV_TYPE_MAX_LENGTH 16
> > +
> >  /*
> >   * Returns the hart ID of the given device tree node, or -ENODEV if th=
e node
> >   * isn't an enabled and valid RISC-V hart node.
> > @@ -271,21 +273,21 @@ static void print_isa(struct seq_file *f, const c=
har *isa)
> >
> >  static void print_mmu(struct seq_file *f)
> >  {
> > -     char sv_type[16];
> > +     char sv_type[SV_TYPE_MAX_LENGTH];
> >
> >  #ifdef CONFIG_MMU
> >  #if defined(CONFIG_32BIT)
> > -     strncpy(sv_type, "sv32", 5);
> > +     strscpy(sv_type, "sv32", SV_TYPE_MAX_LENGTH);
> >  #elif defined(CONFIG_64BIT)
> >       if (pgtable_l5_enabled)
> > -             strncpy(sv_type, "sv57", 5);
> > +             strscpy(sv_type, "sv57", SV_TYPE_MAX_LENGTH);
> >       else if (pgtable_l4_enabled)
> > -             strncpy(sv_type, "sv48", 5);
> > +             strscpy(sv_type, "sv48", SV_TYPE_MAX_LENGTH);
> >       else
> > -             strncpy(sv_type, "sv39", 5);
> > +             strscpy(sv_type, "sv39", SV_TYPE_MAX_LENGTH);
> >  #endif
> >  #else
> > -     strncpy(sv_type, "none", 5);
> > +     strscpy(sv_type, "none", SV_TYPE_MAX_LENGTH);
> >  #endif /* CONFIG_MMU */
> >       seq_printf(f, "mmu\t\t: %s\n", sv_type);
> >  }
>
> This all seems rather horrible, we should probably clean it up, but that
> is nothing to do with your patch. To be clear, I am also not requesting a
> resubmission for the commit message nitpickery.
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks,
> Conor.

--
Justin
