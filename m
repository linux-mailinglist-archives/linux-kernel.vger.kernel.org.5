Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B54876D850
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjHBUBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjHBUBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:01:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122E81FFA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691006443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wY/Nfh45HwpbJdIjIFwouOX8OJ1MkJG+IEi4LOizmfM=;
        b=FEi9xhcytpbe/+WNuQNHYrp+Qr+FUY+r4qj6kN2jWQFRtuyvQz6n6o0BAmfo8zz17a4MuZ
        s+HCmNZgOVxhHbby+q1pjPp0R80bMPdbJLoHOY+pnpa5KT+fSX3i0yJcrAritHd7vp7gzM
        K+v1nsy1oi5XdAi+mh2QXujegVdUvZY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-RoTWklR3PYGona0x4ufrIQ-1; Wed, 02 Aug 2023 16:00:29 -0400
X-MC-Unique: RoTWklR3PYGona0x4ufrIQ-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40ea01f3e3bso2635881cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 13:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691006429; x=1691611229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wY/Nfh45HwpbJdIjIFwouOX8OJ1MkJG+IEi4LOizmfM=;
        b=Csb83lLJyyYZeNNBPQfTeYEOHc4+3eorwTuwsqL3WP77OFmvWqYhCcyGBu9QRpkfEs
         7lXYjMfRC/xQNAqhUmJLp+E+nPPR23NKfNsWnhgAAgXsrK6Mau53Yi21d6kakJzUn+It
         B9uc4y96EUdBhIHHQpcAwaI9MRFS9iCj3OgIW3YenYmErJs9dlkDYIUjU91ZMu/KsZZ3
         TKOJOapm6xlcvHH31p19xWKaN4NY7aol11l7drgFzonu/Aundtw2TyVdpEGbW8/0xFvm
         lY47QyXL5HFD0SP6tJqU78LGLWkbHD3shYkZCiY1C6DJvznzUoD7RKNEfN8kUqumIUfr
         meyw==
X-Gm-Message-State: ABy/qLbBMXanCP4fPYdvxdxqUINLUbhWegJoH1GzIivpFyTTyx6RufoY
        hsi9Js1KGlCGo3BUEFZ3I9msCvcadxle+8oNramoj9Jlw2hH+g8POIg1tIqAW249tWiT0yVl1hR
        9Lw3dd2PRfducd/LMs2+bHOvPjBqDvTBXocjOiDzc
X-Received: by 2002:a05:622a:20a:b0:403:adf1:8352 with SMTP id b10-20020a05622a020a00b00403adf18352mr21371248qtx.24.1691006429443;
        Wed, 02 Aug 2023 13:00:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFdfcAWRqOhKjznQcKVbW+9jHs24tBO1aGhDU5g/DP+NaQk30hEz3jDxdOD1iu1O5H+VWqQb1eav5bKL4dI4R0=
X-Received: by 2002:a05:622a:20a:b0:403:adf1:8352 with SMTP id
 b10-20020a05622a020a00b00403adf18352mr21371221qtx.24.1691006429150; Wed, 02
 Aug 2023 13:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230419062505.257231-1-leobras@redhat.com> <CAJ6HWG6nPdUQ_2_fSj6J7ZE7FB-T+VWT-kq9oW8BLTUtuQEWxA@mail.gmail.com>
 <CAJF2gTRZO2hogUbZvj0f41JJvmqLNz-MKTHJshgdhNMpp9Bc8w@mail.gmail.com>
In-Reply-To: <CAJF2gTRZO2hogUbZvj0f41JJvmqLNz-MKTHJshgdhNMpp9Bc8w@mail.gmail.com>
From:   Leonardo Bras Soares Passos <leobras@redhat.com>
Date:   Wed, 2 Aug 2023 17:00:18 -0300
Message-ID: <CAJ6HWG7kvWtZHTBMiFAQriUn84E8SYuGmtAGmW8YVwqUyoUYgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] riscv/atomic.h: Deduplicate arch_atomic.*
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
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

On Thu, May 25, 2023 at 7:07=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, May 25, 2023 at 5:31=E2=80=AFPM Leonardo Bras Soares Passos
> <leobras@redhat.com> wrote:
> >
> > Friendly ping?
> >
> > On Wed, Apr 19, 2023 at 3:25=E2=80=AFAM Leonardo Bras <leobras@redhat.c=
om> wrote:
> > >
> > > Some functions use mostly the same asm for 32-bit and 64-bit versions=
.
> > >
> > > Make a macro that is generic enough and avoid code duplication.
> > >
> > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > ---
> > >  arch/riscv/include/asm/atomic.h | 164 +++++++++++++++---------------=
--
> > >  1 file changed, 76 insertions(+), 88 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm=
/atomic.h
> > > index 0dfe9d857a762..85eb2edbc8219 100644
> > > --- a/arch/riscv/include/asm/atomic.h
> > > +++ b/arch/riscv/include/asm/atomic.h
> > > @@ -196,22 +196,28 @@ ATOMIC_OPS(xor, xor, i)
> > >  #undef ATOMIC_FETCH_OP
> > >  #undef ATOMIC_OP_RETURN
> > >
> > > +#define _arch_atomic_fetch_add_unless(_prev, _rc, counter, _a, _u, s=
fx)        \
> > > +({                                                                  =
   \
> > > +       __asm__ __volatile__ (                                       =
   \
> > > +               "0:     lr." sfx "     %[p],  %[c]\n"                =
   \
> > > +               "       beq            %[p],  %[u], 1f\n"            =
   \
> > > +               "       add            %[rc], %[p], %[a]\n"          =
   \
> > > +               "       sc." sfx ".rl  %[rc], %[rc], %[c]\n"         =
   \
> > > +               "       bnez           %[rc], 0b\n"                  =
   \
> > > +               "       fence          rw, rw\n"                     =
   \
> > > +               "1:\n"                                               =
   \
> > > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (cou=
nter)  \
> > > +               : [a]"r" (_a), [u]"r" (_u)                           =
   \
> > > +               : "memory");                                         =
   \
> > > +})
> > > +
> > >  /* This is required to provide a full barrier on success. */
> > >  static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v,=
 int a, int u)
> > >  {
> > >         int prev, rc;
> > >
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.w     %[p],  %[c]\n"
> > > -               "       beq      %[p],  %[u], 1f\n"
> > > -               "       add      %[rc], %[p], %[a]\n"
> > > -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > > -               "       bnez     %[rc], 0b\n"
> > > -               "       fence    rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               : [a]"r" (a), [u]"r" (u)
> > > -               : "memory");
> > > +       _arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "w"=
);
> > > +
> > >         return prev;
> > >  }
> > >  #define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
> > > @@ -222,17 +228,8 @@ static __always_inline s64 arch_atomic64_fetch_a=
dd_unless(atomic64_t *v, s64 a,
> > >         s64 prev;
> > >         long rc;
> > >
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.d     %[p],  %[c]\n"
> > > -               "       beq      %[p],  %[u], 1f\n"
> > > -               "       add      %[rc], %[p], %[a]\n"
> > > -               "       sc.d.rl  %[rc], %[rc], %[c]\n"
> > > -               "       bnez     %[rc], 0b\n"
> > > -               "       fence    rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               : [a]"r" (a), [u]"r" (u)
> > > -               : "memory");
> > > +       _arch_atomic_fetch_add_unless(prev, rc, v->counter, a, u, "d"=
);
> > > +
> > >         return prev;
> > >  }
> > >  #define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unles=
s
> > > @@ -310,61 +307,79 @@ ATOMIC_OPS()
> > >  #undef ATOMIC_OPS
> > >  #undef ATOMIC_OP
> > >
> > > +#define _arch_atomic_inc_unless_negative(_prev, _rc, counter, sfx)  =
   \
> > > +({                                                                  =
   \
> > > +       __asm__ __volatile__ (                                       =
   \
> > > +               "0:     lr." sfx "      %[p],  %[c]\n"               =
   \
> > > +               "       bltz            %[p],  1f\n"                 =
   \
> > > +               "       addi            %[rc], %[p], 1\n"            =
   \
> > > +               "       sc." sfx ".rl   %[rc], %[rc], %[c]\n"        =
   \
> > > +               "       bnez            %[rc], 0b\n"                 =
   \
> > > +               "       fence           rw, rw\n"                    =
   \
> > > +               "1:\n"                                               =
   \
> > > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (cou=
nter)  \
> > > +               :                                                    =
   \
> > > +               : "memory");                                         =
   \
> > > +})
> > > +
> > >  static __always_inline bool arch_atomic_inc_unless_negative(atomic_t=
 *v)
> > >  {
> > >         int prev, rc;
> > >
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.w      %[p],  %[c]\n"
> > > -               "       bltz      %[p],  1f\n"
> > > -               "       addi      %[rc], %[p], 1\n"
> > > -               "       sc.w.rl   %[rc], %[rc], %[c]\n"
> > > -               "       bnez      %[rc], 0b\n"
> > > -               "       fence     rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               :
> > > -               : "memory");
> > > +       _arch_atomic_inc_unless_negative(prev, rc, v->counter, "w");
> > > +
> > >         return !(prev < 0);
> > >  }
> > >
> > >  #define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negat=
ive
> > >
> > > +#define _arch_atomic_dec_unless_positive(_prev, _rc, counter, sfx)  =
   \
> > > +({                                                                  =
   \
> > > +       __asm__ __volatile__ (                                       =
   \
> > > +               "0:     lr." sfx "      %[p],  %[c]\n"               =
   \
> > > +               "       bgtz            %[p],  1f\n"                 =
   \
> > > +               "       addi            %[rc], %[p], -1\n"           =
   \
> > > +               "       sc." sfx ".rl   %[rc], %[rc], %[c]\n"        =
   \
> > > +               "       bnez            %[rc], 0b\n"                 =
   \
> > > +               "       fence           rw, rw\n"                    =
   \
> > > +               "1:\n"                                               =
   \
> > > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (cou=
nter)  \
> > > +               :                                                    =
   \
> > > +               : "memory");                                         =
   \
> > > +})
> > > +
> > >  static __always_inline bool arch_atomic_dec_unless_positive(atomic_t=
 *v)
> > >  {
> > >         int prev, rc;
> > >
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.w      %[p],  %[c]\n"
> > > -               "       bgtz      %[p],  1f\n"
> > > -               "       addi      %[rc], %[p], -1\n"
> > > -               "       sc.w.rl   %[rc], %[rc], %[c]\n"
> > > -               "       bnez      %[rc], 0b\n"
> > > -               "       fence     rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               :
> > > -               : "memory");
> > > +       _arch_atomic_dec_unless_positive(prev, rc, v->counter, "w");
> > > +
> > >         return !(prev > 0);
> > >  }
> > >
> > >  #define arch_atomic_dec_unless_positive arch_atomic_dec_unless_posit=
ive
> > >
> > > +#define _arch_atomic_dec_if_positive(_prev, _rc, counter, sfx)      =
   \
> > > +({                                                                  =
   \
> > > +       __asm__ __volatile__ (                                       =
   \
> > > +               "0:     lr." sfx "     %[p],  %[c]\n"                =
   \
> > > +               "       addi           %[rc], %[p], -1\n"            =
   \
> > > +               "       bltz           %[rc], 1f\n"                  =
   \
> > > +               "       sc." sfx ".rl  %[rc], %[rc], %[c]\n"         =
   \
> > > +               "       bnez           %[rc], 0b\n"                  =
   \
> > > +               "       fence          rw, rw\n"                     =
   \
> > > +               "1:\n"                                               =
   \
> > > +               : [p]"=3D&r" (_prev), [rc]"=3D&r" (_rc), [c]"+A" (cou=
nter)  \
> > > +               :                                                    =
   \
> > > +               : "memory");                                         =
   \
> > > +})
> > > +
> > >  static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
> > >  {
> > >         int prev, rc;
> > >
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.w     %[p],  %[c]\n"
> > > -               "       addi     %[rc], %[p], -1\n"
> > > -               "       bltz     %[rc], 1f\n"
> > > -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > > -               "       bnez     %[rc], 0b\n"
> > > -               "       fence    rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               :
> > > -               : "memory");
> > > +       _arch_atomic_dec_if_positive(prev, rc, v->counter, "w");
> > > +
> > >         return prev - 1;
> > >  }
> > >
> > > @@ -376,17 +391,8 @@ static __always_inline bool arch_atomic64_inc_un=
less_negative(atomic64_t *v)
> > >         s64 prev;
> > >         long rc;
> > >
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.d      %[p],  %[c]\n"
> > > -               "       bltz      %[p],  1f\n"
> > > -               "       addi      %[rc], %[p], 1\n"
> > > -               "       sc.d.rl   %[rc], %[rc], %[c]\n"
> > > -               "       bnez      %[rc], 0b\n"
> > > -               "       fence     rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               :
> > > -               : "memory");
> > > +       _arch_atomic_inc_unless_negative(prev, rc, v->counter, "d");
> > > +
> > >         return !(prev < 0);
> > >  }
> > >
> > > @@ -397,17 +403,8 @@ static __always_inline bool arch_atomic64_dec_un=
less_positive(atomic64_t *v)
> > >         s64 prev;
> > >         long rc;
> > >
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.d      %[p],  %[c]\n"
> > > -               "       bgtz      %[p],  1f\n"
> > > -               "       addi      %[rc], %[p], -1\n"
> > > -               "       sc.d.rl   %[rc], %[rc], %[c]\n"
> > > -               "       bnez      %[rc], 0b\n"
> > > -               "       fence     rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               :
> > > -               : "memory");
> > > +       _arch_atomic_dec_unless_positive(prev, rc, v->counter, "d");
> > > +
> > >         return !(prev > 0);
> > >  }
> > >
> > > @@ -418,17 +415,8 @@ static __always_inline s64 arch_atomic64_dec_if_=
positive(atomic64_t *v)
> > >         s64 prev;
> > >         long rc;
> > >
> > > -       __asm__ __volatile__ (
> > > -               "0:     lr.d     %[p],  %[c]\n"
> > > -               "       addi      %[rc], %[p], -1\n"
> > > -               "       bltz     %[rc], 1f\n"
> > > -               "       sc.d.rl  %[rc], %[rc], %[c]\n"
> > > -               "       bnez     %[rc], 0b\n"
> > > -               "       fence    rw, rw\n"
> > > -               "1:\n"
> > > -               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->co=
unter)
> > > -               :
> > > -               : "memory");
> > > +       _arch_atomic_dec_if_positive(prev, rc, v->counter, "d");
> > > +
> > >         return prev - 1;
> > >  }
> > >
> > > --
> > > 2.40.0
> > >
> >
> A safe cleanup, no problem found.
>
> Reviewed-by: Guo Ren <guoren@kernel.org>
>
>

Hello Palmer,

Any improvements you suggest for this patch?

Best regards,
Leonardo Bras

