Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0192A770D7C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjHEDPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjHEDPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:15:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC5410D2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691205285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cbOnpetRdksvYmHQrc1VnOUvWL6pFOiaAZEA/zz5j+M=;
        b=T70zeuibdO4ec1aKBTqg0d/JLC4VHLzCuVdJviPUVP7LXflrzod7RF7tCowW72+TR1Gm/6
        fkUtllspWQozxplPwAvD6r/MMaJ5+dGepfmATrYnrGiR19dvTIHE/kH0Ncs1Y20fpZhVLr
        crYjW4Sb2uQzfyC4DoKAjygzqIACDQE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-wzz4IEXSMFKvJ1ICHU4eLA-1; Fri, 04 Aug 2023 23:14:43 -0400
X-MC-Unique: wzz4IEXSMFKvJ1ICHU4eLA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76c888cc6cdso308983685a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 20:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691205283; x=1691810083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbOnpetRdksvYmHQrc1VnOUvWL6pFOiaAZEA/zz5j+M=;
        b=QGVyxQAuplaM5mZ3F8HXMZXZ8bMkIStzXqxzGBWXLNEQdsv/qFOhBpKRjdBgax2H/L
         lXVauXji93crCacAsuByinHpzxoVe8jLy9fuF+XLtogfFEbl6vfBRK/Qg88kA7zIf8O9
         wkCFVdxM6kaykXbwuWuu10dcGdluui45wjsGgsIz9ou5EBoryXzUl65iQqbzRPG3afWU
         J7SAcY9xMVnpPafnYbZlobh7way+8bVnzQejX6LTXmg1sqcPvYcXcCedM8hY7uEzNlsd
         4+WwpczQafK/9INRsgfjmCl+o/Ai/3ot2fkzOtKPFhjqvDwNRlf2xsRg0L+Fteiw8ZPo
         Jq4Q==
X-Gm-Message-State: AOJu0YwpNHS9dAQ/pbws7CczNpiD2y9GKKWv+5s9ac+IMiv1mOz4bWzU
        UvVwsjE76okZNTZjIc9IwP378tcBASKfj2+WmQfzFoJsRtKoWJt527FEV+1IcMjft93MOlJryYm
        6moupyfGG8o8jgcQk+F1fqRH7NUnE2TxOCy+uUwZ/
X-Received: by 2002:a05:622a:199f:b0:403:b869:9d37 with SMTP id u31-20020a05622a199f00b00403b8699d37mr4911919qtc.0.1691205283332;
        Fri, 04 Aug 2023 20:14:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9hCtZkKsNcH3RInYQsyPY9FuS0uXfJQ8KVHGGSVyrOAym5sd9HYXY78yRP/LQTvr/kqaCKw2GiWRDw7MDG+o=
X-Received: by 2002:a05:622a:199f:b0:403:b869:9d37 with SMTP id
 u31-20020a05622a199f00b00403b8699d37mr4911908qtc.0.1691205283091; Fri, 04 Aug
 2023 20:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230804084900.1135660-2-leobras@redhat.com> <20230804084900.1135660-6-leobras@redhat.com>
 <CAJF2gTTOT3_3K_cWNY9n_DgRoPhYEhBLno=bh57r9D--OavREQ@mail.gmail.com>
In-Reply-To: <CAJF2gTTOT3_3K_cWNY9n_DgRoPhYEhBLno=bh57r9D--OavREQ@mail.gmail.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Sat, 5 Aug 2023 00:14:31 -0300
Message-ID: <CAJ6HWG4gy7HV11-cdoB0VAP2z1Zw-zyJhNRpJ1eDMmrkvnob3w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/5] riscv/cmpxchg: Implement cmpxchg for variables
 of size 1 and 2
To:     Guo Ren <guoren@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guo Ren, thanks for the feedback!

On Fri, Aug 4, 2023 at 2:45=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Fri, Aug 4, 2023 at 4:49=E2=80=AFAM Leonardo Bras <leobras@redhat.com>=
 wrote:
> >
> > cmpxchg for variables of size 1-byte and 2-bytes is not yet available f=
or
> > riscv, even though its present in other architectures such as arm64 and
> > x86. This could lead to not being able to implement some locking mechan=
isms
> > or requiring some rework to make it work properly.
> >
> > Implement 1-byte and 2-bytes cmpxchg in order to achieve parity with ot=
her
> > architectures.
> >
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >  arch/riscv/include/asm/cmpxchg.h | 35 ++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/=
cmpxchg.h
> > index 5a07646fae65..dfb433ac544f 100644
> > --- a/arch/riscv/include/asm/cmpxchg.h
> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > @@ -72,6 +72,36 @@
> >   * indicated by comparing RETURN with OLD.
> >   */
> >
> > +#define __arch_cmpxchg_mask(sc_sfx, prepend, append, r, p, o, n)      =
 \
> > +({                                                                    =
 \
> > +       /* Depends on 2-byte variables being 2-byte aligned */         =
 \
> > +       ulong __s =3D ((ulong)(p) & 0x3) * BITS_PER_BYTE;              =
   \
> > +       ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)=
   \
> > +                       << __s;                                        =
 \
> > +       ulong __newx =3D (ulong)(n) << __s;                            =
   \
> > +       ulong __oldx =3D (ulong)(o) << __s;                            =
   \
> > +       ulong __retx;                                                  =
 \
> > +       register unsigned int __rc;                                    =
 \
> > +                                                                      =
 \
> > +       __asm__ __volatile__ (                                         =
 \
> > +               prepend                                                =
 \
> > +               "0:     lr.w %0, %2\n"                                 =
 \
> > +               "       and  %0, %0, %z5\n"                            =
 \
> > +               "       bne  %0, %z3, 1f\n"                            =
 \

> bug:
> -               "       and  %0, %0, %z5\n"                             \
> -               "       bne  %0, %z3, 1f\n"                             \
> +               "       and  %1, %0, %z5\n"                             \
> +               "       bne  %1, %z3, 1f\n"                             \
> Your code breaks the %0.

What do you mean by breaks here?

In the end of this macro, I intended  to have __retx =3D (*p & __mask)
which means the value is clean to be rotated at the end of the macro
(no need to apply the mask again): r =3D __ret >> __s;

Also, I assumed we are supposed to return the same variable type
as the pointer, so this is valid:
u8 a, *b, c;
a =3D xchg(b, c);

Is this correct?

> > +               append                                                 =
 \
> > +               "1:\n"                                                 =
 \
> > +               : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(p))        =
     \
> > +               : "rJ" ((long)__oldx), "rJ" (__newx),                  =
 \
> > +                 "rJ" (__mask), "rJ" (~__mask)                        =
 \
> > +               : "memory");                                           =
 \
> > +                                                                      =
 \
> > +       r =3D (__typeof__(*(p)))(__retx >> __s);                       =
   \
> > +})
> > +
> >
> >  #define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, o, n=
)        \
> >  ({                                                                    =
 \
> > @@ -98,6 +128,11 @@
> >         __typeof__(*(ptr)) __ret;                                      =
 \
> >                                                                        =
 \
> >         switch (sizeof(*__ptr)) {                                      =
 \
> > +       case 1:                                                        =
 \
> > +       case 2:                                                        =
 \
> > +               __arch_cmpxchg_mask(sc_sfx, prepend, append,           =
 \
> > +                                       __ret, __ptr, __old, __new);   =
 \
> > +               break;                                                 =
 \
> >         case 4:                                                        =
 \
> >                 __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,     =
 \
> >                                 __ret, __ptr, (long), __old, __new);   =
 \
> > --
> > 2.41.0
> >
>
>
> --
> Best Regards
>  Guo Ren
>

