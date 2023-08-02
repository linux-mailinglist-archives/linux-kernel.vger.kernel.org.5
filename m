Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B187376D885
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjHBUUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHBUUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4669B10C7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691007564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dBFeHRoTmh4urlfIyx1gmbxIUEWXgvqCq/rZeKcvfo=;
        b=NXbaPtkkgh3SD8eT1aCPhVrzhJaIxb2HJ3i9tQ/IDhy4GUh2GlqHb1NUb1O7b3GY0n5O9z
        V8MX+KR1jTrtlmvI22hXS8AvIxJUMR3ldKSvCiVKd5Cw2sgJospIW34NtXvNE4W4prs01/
        za74VBZdIJ+YqZwaRm3Y3kRxMjiOHFc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-Hr3ETF-tNhGZU75oKywDPQ-1; Wed, 02 Aug 2023 16:19:21 -0400
X-MC-Unique: Hr3ETF-tNhGZU75oKywDPQ-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-40fc220d343so4873841cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 13:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691007561; x=1691612361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dBFeHRoTmh4urlfIyx1gmbxIUEWXgvqCq/rZeKcvfo=;
        b=IuTK/czhsAGsQPjmeKy0x7do0AC/MHEuYCnyqs2MaGJB5NuQb9VilhjUlvTV1f1Hfs
         V5l6v2uAnk/05FkfLw/jMGcLaOBOC0nKL6OQ4/k7jX0RExNon/oyUdxFS1g/FLur3qpW
         WHugZcTZBzt8/ymzQGo6KXKn/DU9Rfg4mcIs4AqrhD5UTr560Ul7RBmhappjnrJNbfRf
         sfcIDJMI8z0J4OAWuFda89CM9yaFKMjkSoopjekI77RsugkQaAE9DEB1Z4JXOKnurOFj
         P8y6pg3D9ZDfM5gltZTpL1EMMPmafsNvIeHod/Z0yYWllFqQjsg1TPcLspu6FrSJRsHO
         qMfg==
X-Gm-Message-State: ABy/qLbszd1x49VWaeiZU3PXyqLp+rF0Gu/Jyt81YW4Z/G/3buTr0M2s
        C8/wGYtiRDdj9pOKw9ejwaqErZBHF/0a8AU0WR6miktRQBmk75+5F6oAKUqgevgo2ZcRe1I35wT
        /k1GyiyRJ31RdksK5hJ2jG0aLo9qCNdzJ8Jw0E9JT
X-Received: by 2002:ac8:7f4f:0:b0:403:e853:17c3 with SMTP id g15-20020ac87f4f000000b00403e85317c3mr22771922qtk.38.1691007560699;
        Wed, 02 Aug 2023 13:19:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEy8sMN6nYiiQmEwjb7z+zZkbTmstgQ2upD6g75EF7rNyuGGM77tiUKSgdkfiVPFd0L7K9xi54iwTzcYPzNd6o=
X-Received: by 2002:ac8:7f4f:0:b0:403:e853:17c3 with SMTP id
 g15-20020ac87f4f000000b00403e85317c3mr22771908qtk.38.1691007560400; Wed, 02
 Aug 2023 13:19:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230419062505.257231-1-leobras@redhat.com> <CAJ6HWG6nPdUQ_2_fSj6J7ZE7FB-T+VWT-kq9oW8BLTUtuQEWxA@mail.gmail.com>
 <CAJF2gTRZO2hogUbZvj0f41JJvmqLNz-MKTHJshgdhNMpp9Bc8w@mail.gmail.com> <CAJ6HWG7kvWtZHTBMiFAQriUn84E8SYuGmtAGmW8YVwqUyoUYgQ@mail.gmail.com>
In-Reply-To: <CAJ6HWG7kvWtZHTBMiFAQriUn84E8SYuGmtAGmW8YVwqUyoUYgQ@mail.gmail.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 2 Aug 2023 17:19:09 -0300
Message-ID: <CAJ6HWG6fookkruQ1Rcx4t87q6RhqXWPUcPJPJw=ub-G83rVpMA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] riscv/atomic.h: Deduplicate arch_atomic.*
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 5:00=E2=80=AFPM Leonardo Bras Soares Passos
<leobras@redhat.com> wrote:
>
> On Thu, May 25, 2023 at 7:07=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote=
:
> >
> > On Thu, May 25, 2023 at 5:31=E2=80=AFPM Leonardo Bras Soares Passos
> > <leobras@redhat.com> wrote:
> > >
> > > Friendly ping?
> > >
> > > On Wed, Apr 19, 2023 at 3:25=E2=80=AFAM Leonardo Bras <leobras@redhat=
.com> wrote:
> > > >
> > > > Some functions use mostly the same asm for 32-bit and 64-bit versio=
ns.
> > > >
> > > > Make a macro that is generic enough and avoid code duplication.
> > > >
> > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > ---
> > > >  arch/riscv/include/asm/atomic.h | 164 +++++++++++++++-------------=
----
> > > >  1 file changed, 76 insertions(+), 88 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/a=
sm/atomic.h
> > > > index 0dfe9d857a762..85eb2edbc8219 100644
> > > > --- a/arch/riscv/include/asm/atomic.h
> > > > +++ b/arch/riscv/include/asm/atomic.h
> > > > @@ -196,22 +196,28 @@ ATOMIC_OPS(xor, xor, i)
> > > >  #undef ATOMIC_FETCH_OP
> > > >  #undef ATOMIC_OP_RETURN
> > > >
> > > > +#define _arch_atomic_fetch_add_unless(_prev, _rc, counter, _a, _u,=
 sfx)        \
> > > > +({                                                                =
     \
> > > > +       __asm__ __volatile__ (                                     =
     \
> > > > +               "0:     lr." sfx "     %[p],  %[c]\n"              =
     \
> > > > +               "       beq            %[p],  %[u], 1f\n"          =
     \
> > > > +               "       add            %[rc], %[p], %[a]\n"        =
     \
> > > > +               "       sc." sfx ".rl  %[rc], %[rc], %[c]\n"       =
     \
> > > > +               "       bnez           %[rc], 0b\n"                =
     \
> > > > +               "       fence          rw, rw\n"                   =
     \
> > > > +               "1:\n"                                             =
     \
> > > > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (c=
ounter)  \
> > > > +               : [a]"r" (_a), [u]"r" (_u)                         =
     \
> > > > +               : "memory");                                       =
     \
> > > > +})
> > > > +
> > > >  /* This is required to provide a full barrier on success. */
> > > >  static __always_inline int arch_atomic_fetch_add_unless(atomic_t *=
v, int a, int u)
> > > >  {
> > > >         int prev, rc;
> > > >
> > > > -       __asm__ __volatile__ (
> > > > -               "0:     lr.w     %[p],  %[c]\n"
> > > > -               "       beq      %[p],  %[u], 1f\n"
> > > > -               "       add      %[rc], %[p], %[a]\n"
> > > > -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > > > -               "       bnez     %[rc], 0b\n"
> > > > -               "       fence    rw, rw\n"
> > > > -               "1:\n"
> > > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->=
counter)
> > > > -               : [a]"r" (a), [u]"r" (u)
> > > > -               : "memory");
> > > > +       _arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "=
w");
> > > > +
> > > >         return prev;
> > > >  }
> > > >  #define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
> > > > @@ -222,17 +228,8 @@ static __always_inline s64 arch_atomic64_fetch=
_add_unless(atomic64_t *v, s64 a,
> > > >         s64 prev;
> > > >         long rc;
> > > >
> > > > -       __asm__ __volatile__ (
> > > > -               "0:     lr.d     %[p],  %[c]\n"
> > > > -               "       beq      %[p],  %[u], 1f\n"
> > > > -               "       add      %[rc], %[p], %[a]\n"
> > > > -               "       sc.d.rl  %[rc], %[rc], %[c]\n"
> > > > -               "       bnez     %[rc], 0b\n"
> > > > -               "       fence    rw, rw\n"
> > > > -               "1:\n"
> > > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->=
counter)
> > > > -               : [a]"r" (a), [u]"r" (u)
> > > > -               : "memory");
> > > > +       _arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "=
d");
> > > > +
> > > >         return prev;
> > > >  }
> > > >  #define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unl=
ess
> > > > @@ -310,61 +307,79 @@ ATOMIC_OPS()
> > > >  #undef ATOMIC_OPS
> > > >  #undef ATOMIC_OP
> > > >
> > > > +#define _arch_atomic_inc_unless_negative(_prev, _rc, counter, sfx)=
     \
> > > > +({                                                                =
     \
> > > > +       __asm__ __volatile__ (                                     =
     \
> > > > +               "0:     lr." sfx "      %[p],  %[c]\n"             =
     \
> > > > +               "       bltz            %[p],  1f\n"               =
     \
> > > > +               "       addi            %[rc], %[p], 1\n"          =
     \
> > > > +               "       sc." sfx ".rl   %[rc], %[rc], %[c]\n"      =
     \
> > > > +               "       bnez            %[rc], 0b\n"               =
     \
> > > > +               "       fence           rw, rw\n"                  =
     \
> > > > +               "1:\n"                                             =
     \
> > > > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (c=
ounter)  \
> > > > +               :                                                  =
     \
> > > > +               : "memory");                                       =
     \
> > > > +})
> > > > +
> > > >  static __always_inline bool arch_atomic_inc_unless_negative(atomic=
_t *v)
> > > >  {
> > > >         int prev, rc;
> > > >
> > > > -       __asm__ __volatile__ (
> > > > -               "0:     lr.w      %[p],  %[c]\n"
> > > > -               "       bltz      %[p],  1f\n"
> > > > -               "       addi      %[rc], %[p], 1\n"
> > > > -               "       sc.w.rl   %[rc], %[rc], %[c]\n"
> > > > -               "       bnez      %[rc], 0b\n"
> > > > -               "       fence     rw, rw\n"
> > > > -               "1:\n"
> > > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->=
counter)
> > > > -               :
> > > > -               : "memory");
> > > > +       _arch_atomic_inc_unless_negative(prev, rc, v->counter, "w")=
;
> > > > +
> > > >         return !(prev < 0);
> > > >  }
> > > >
> > > >  #define arch_atomic_inc_unless_negative arch_atomic_inc_unless_neg=
ative
> > > >
> > > > +#define _arch_atomic_dec_unless_positive(_prev, _rc, counter, sfx)=
     \
> > > > +({                                                                =
     \
> > > > +       __asm__ __volatile__ (                                     =
     \
> > > > +               "0:     lr." sfx "      %[p],  %[c]\n"             =
     \
> > > > +               "       bgtz            %[p],  1f\n"               =
     \
> > > > +               "       addi            %[rc], %[p], -1\n"         =
     \
> > > > +               "       sc." sfx ".rl   %[rc], %[rc], %[c]\n"      =
     \
> > > > +               "       bnez            %[rc], 0b\n"               =
     \
> > > > +               "       fence           rw, rw\n"                  =
     \
> > > > +               "1:\n"                                             =
     \
> > > > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (c=
ounter)  \
> > > > +               :                                                  =
     \
> > > > +               : "memory");                                       =
     \
> > > > +})
> > > > +
> > > >  static __always_inline bool arch_atomic_dec_unless_positive(atomic=
_t *v)
> > > >  {
> > > >         int prev, rc;
> > > >
> > > > -       __asm__ __volatile__ (
> > > > -               "0:     lr.w      %[p],  %[c]\n"
> > > > -               "       bgtz      %[p],  1f\n"
> > > > -               "       addi      %[rc], %[p], -1\n"
> > > > -               "       sc.w.rl   %[rc], %[rc], %[c]\n"
> > > > -               "       bnez      %[rc], 0b\n"
> > > > -               "       fence     rw, rw\n"
> > > > -               "1:\n"
> > > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->=
counter)
> > > > -               :
> > > > -               : "memory");
> > > > +       _arch_atomic_dec_unless_positive(prev, rc, v->counter, "w")=
;
> > > > +
> > > >         return !(prev > 0);
> > > >  }
> > > >
> > > >  #define arch_atomic_dec_unless_positive arch_atomic_dec_unless_pos=
itive
> > > >
> > > > +#define _arch_atomic_dec_if_positive(_prev, _rc, counter, sfx)    =
     \
> > > > +({                                                                =
     \
> > > > +       __asm__ __volatile__ (                                     =
     \
> > > > +               "0:     lr." sfx "     %[p],  %[c]\n"              =
     \
> > > > +               "       addi           %[rc], %[p], -1\n"          =
     \
> > > > +               "       bltz           %[rc], 1f\n"                =
     \
> > > > +               "       sc." sfx ".rl  %[rc], %[rc], %[c]\n"       =
     \
> > > > +               "       bnez           %[rc], 0b\n"                =
     \
> > > > +               "       fence          rw, rw\n"                   =
     \
> > > > +               "1:\n"                                             =
     \
> > > > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (c=
ounter)  \
> > > > +               :                                                  =
     \
> > > > +               : "memory");                                       =
     \
> > > > +})
> > > > +
> > > >  static __always_inline int arch_atomic_dec_if_positive(atomic_t *v=
)
> > > >  {
> > > >         int prev, rc;
> > > >
> > > > -       __asm__ __volatile__ (
> > > > -               "0:     lr.w     %[p],  %[c]\n"
> > > > -               "       addi     %[rc], %[p], -1\n"
> > > > -               "       bltz     %[rc], 1f\n"
> > > > -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > > > -               "       bnez     %[rc], 0b\n"
> > > > -               "       fence    rw, rw\n"
> > > > -               "1:\n"
> > > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->=
counter)
> > > > -               :
> > > > -               : "memory");
> > > > +       _arch_atomic_dec_if_positive(prev, rc, v->counter, "w");
> > > > +
> > > >         return prev - 1;
> > > >  }
> > > >
> > > > @@ -376,17 +391,8 @@ static __always_inline bool arch_atomic64_inc_=
unless_negative(atomic64_t *v)
> > > >         s64 prev;
> > > >         long rc;
> > > >
> > > > -       __asm__ __volatile__ (
> > > > -               "0:     lr.d      %[p],  %[c]\n"
> > > > -               "       bltz      %[p],  1f\n"
> > > > -               "       addi      %[rc], %[p], 1\n"
> > > > -               "       sc.d.rl   %[rc], %[rc], %[c]\n"
> > > > -               "       bnez      %[rc], 0b\n"
> > > > -               "       fence     rw, rw\n"
> > > > -               "1:\n"
> > > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->=
counter)
> > > > -               :
> > > > -               : "memory");
> > > > +       _arch_atomic_inc_unless_negative(prev, rc, v->counter, "d")=
;
> > > > +
> > > >         return !(prev < 0);
> > > >  }
> > > >
> > > > @@ -397,17 +403,8 @@ static __always_inline bool arch_atomic64_dec_=
unless_positive(atomic64_t *v)
> > > >         s64 prev;
> > > >         long rc;
> > > >
> > > > -       __asm__ __volatile__ (
> > > > -               "0:     lr.d      %[p],  %[c]\n"
> > > > -               "       bgtz      %[p],  1f\n"
> > > > -               "       addi      %[rc], %[p], -1\n"
> > > > -               "       sc.d.rl   %[rc], %[rc], %[c]\n"
> > > > -               "       bnez      %[rc], 0b\n"
> > > > -               "       fence     rw, rw\n"
> > > > -               "1:\n"
> > > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->=
counter)
> > > > -               :
> > > > -               : "memory");
> > > > +       _arch_atomic_dec_unless_positive(prev, rc, v->counter, "d")=
;
> > > > +
> > > >         return !(prev > 0);
> > > >  }
> > > >
> > > > @@ -418,17 +415,8 @@ static __always_inline s64 arch_atomic64_dec_i=
f_positive(atomic64_t *v)
> > > >         s64 prev;
> > > >         long rc;
> > > >
> > > > -       __asm__ __volatile__ (
> > > > -               "0:     lr.d     %[p],  %[c]\n"
> > > > -               "       addi      %[rc], %[p], -1\n"
> > > > -               "       bltz     %[rc], 1f\n"
> > > > -               "       sc.d.rl  %[rc], %[rc], %[c]\n"
> > > > -               "       bnez     %[rc], 0b\n"
> > > > -               "       fence    rw, rw\n"
> > > > -               "1:\n"
> > > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->=
counter)
> > > > -               :
> > > > -               : "memory");
> > > > +       _arch_atomic_dec_if_positive(prev, rc, v->counter, "d");
> > > > +
> > > >         return prev - 1;
> > > >  }
> > > >
> > > > --
> > > > 2.40.0
> > > >
> > >
> > A safe cleanup, no problem found.
> >
> > Reviewed-by: Guo Ren <guoren@kernel.org>
> >
> >
>
> Hello Palmer,
>
> Any improvements you suggest for this patch?
>
> Best regards,
> Leonardo Bras

CC: Palmer Dabbelt <palmer@rivosinc.com>

