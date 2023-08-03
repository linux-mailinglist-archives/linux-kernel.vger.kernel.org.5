Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2BA76E014
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjHCGPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjHCGOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9B92733
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 23:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691043246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=imCcolcrV1yQpuA2JqwtaHcIuT99VRjz+byMTD6j/Xo=;
        b=RDvhwoGrGjNVt/KeiVDgKvhhBvk8Q5HUYjoSVtGCh/zpvg+4LqQ9+lTn6TUJc+vEJoL64Q
        gz+37l296b7hF8yNi0G8t9G2c0AQfcBfsQfQuE23e5gd4VJcEMUB6k+QbHTyVWH2Xr+8AD
        7JQ7Ys+Uy3f7v32Q1GB+vQVPejFUUnk=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-x_iH2e3jPnWjAOM3ZtKDJg-1; Thu, 03 Aug 2023 02:14:05 -0400
X-MC-Unique: x_iH2e3jPnWjAOM3ZtKDJg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1b0812d43a0so837844fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 23:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691043243; x=1691648043;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=imCcolcrV1yQpuA2JqwtaHcIuT99VRjz+byMTD6j/Xo=;
        b=W/NgFRnfzO++FnxuVRR+L04c5/6aCWN7/RRjWdKYOCp/P/4caZuPIVpgy6uzE5tvWF
         SZqBBE3mjeOpEws2sOVye2bbyBpz8f6SD5wCI3xa9ojDp12t+7BMHhG6xchbZaD1seXC
         OGR2Sd1vwKZQzT+45tbTh1Hsqok2TrGgeCF3U9qgtzA3P74AF1IxeMqg3Rlc4CNhdYoA
         1ncTTPFHSHpibxAYLFqOKCY+bqfnVMwsM8+JIidxH+c9YG/q1NOd8EtO6BIFKwCM/fN0
         cThDPY4YZA8Jln+qoH/vcBUc/AoA6D7gyT2IyTz9uMt+K7WK+qgSYaAyH7nxBGkBahF/
         AFEA==
X-Gm-Message-State: ABy/qLYtlWZ48bBF1dobgpvj3ccxlYt/odFJ6kJwuycn7TyOcQjqnZNO
        jkKAZVg0NfXab095se5OkQftyjQaUmpWnPm/R8TBUQ7TJcEZezuHZmcHUJydaPxmaG4uGI69kX4
        f8lRn3QKrxc7i158BzqgKKu29
X-Received: by 2002:a05:6871:612:b0:1bb:6c17:271e with SMTP id w18-20020a056871061200b001bb6c17271emr13477527oan.8.1691043243528;
        Wed, 02 Aug 2023 23:14:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGUj32PVtAgKWHA4EzUkjs9Ww4YE8fPpSBqJDaqqabo1/sVgSrHXftfReloE0xDA7AZOOjTrg==
X-Received: by 2002:a05:6871:612:b0:1bb:6c17:271e with SMTP id w18-20020a056871061200b001bb6c17271emr13477519oan.8.1691043243229;
        Wed, 02 Aug 2023 23:14:03 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a801:d380:694f:4f52:764c:4b7f? ([2804:1b3:a801:d380:694f:4f52:764c:4b7f])
        by smtp.gmail.com with ESMTPSA id dx26-20020a056870769a00b0019e6b96f909sm7243197oab.22.2023.08.02.23.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 23:14:02 -0700 (PDT)
Message-ID: <8e0623921f52113735d32f184f26e888e4e4e463.camel@redhat.com>
Subject: Re: [RFC PATCH 1/1] riscv/atomic.h: Deduplicate arch_atomic.*
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Thu, 03 Aug 2023 03:13:58 -0300
In-Reply-To: <CAJ6HWG7kvWtZHTBMiFAQriUn84E8SYuGmtAGmW8YVwqUyoUYgQ@mail.gmail.com>
References: <20230419062505.257231-1-leobras@redhat.com>
         <CAJ6HWG6nPdUQ_2_fSj6J7ZE7FB-T+VWT-kq9oW8BLTUtuQEWxA@mail.gmail.com>
         <CAJF2gTRZO2hogUbZvj0f41JJvmqLNz-MKTHJshgdhNMpp9Bc8w@mail.gmail.com>
         <CAJ6HWG7kvWtZHTBMiFAQriUn84E8SYuGmtAGmW8YVwqUyoUYgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-08-02 at 17:00 -0300, Leonardo Bras Soares Passos wrote:
> On Thu, May 25, 2023 at 7:07=E2=80=AFAM Guo Ren <guoren@kernel.org> wrote=
:
> >=20
> > On Thu, May 25, 2023 at 5:31=E2=80=AFPM Leonardo Bras Soares Passos
> > <leobras@redhat.com> wrote:
> > >=20
> > > Friendly ping?
> > >=20
> > > On Wed, Apr 19, 2023 at 3:25=E2=80=AFAM Leonardo Bras <leobras@redhat=
.com> wrote:
> > > >=20
> > > > Some functions use mostly the same asm for 32-bit and 64-bit versio=
ns.
> > > >=20
> > > > Make a macro that is generic enough and avoid code duplication.
> > > >=20
> > > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > > ---
> > > >  arch/riscv/include/asm/atomic.h | 164 +++++++++++++++-------------=
----
> > > >  1 file changed, 76 insertions(+), 88 deletions(-)
> > > >=20
> > > > diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/a=
sm/atomic.h
> > > > index 0dfe9d857a762..85eb2edbc8219 100644
> > > > --- a/arch/riscv/include/asm/atomic.h
> > > > +++ b/arch/riscv/include/asm/atomic.h
> > > > @@ -196,22 +196,28 @@ ATOMIC_OPS(xor, xor, i)
> > > >  #undef ATOMIC_FETCH_OP
> > > >  #undef ATOMIC_OP_RETURN
> > > >=20
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
> > > >=20
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
> > > >=20
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
> > > >=20
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
> > > >=20
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
> > > >=20
> > > >  #define arch_atomic_inc_unless_negative arch_atomic_inc_unless_neg=
ative
> > > >=20
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
> > > >=20
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
> > > >=20
> > > >  #define arch_atomic_dec_unless_positive arch_atomic_dec_unless_pos=
itive
> > > >=20
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
> > > >=20
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
> > > >=20
> > > > @@ -376,17 +391,8 @@ static __always_inline bool arch_atomic64_inc_=
unless_negative(atomic64_t *v)
> > > >         s64 prev;
> > > >         long rc;
> > > >=20
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
> > > >=20
> > > > @@ -397,17 +403,8 @@ static __always_inline bool arch_atomic64_dec_=
unless_positive(atomic64_t *v)
> > > >         s64 prev;
> > > >         long rc;
> > > >=20
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
> > > >=20
> > > > @@ -418,17 +415,8 @@ static __always_inline s64 arch_atomic64_dec_i=
f_positive(atomic64_t *v)
> > > >         s64 prev;
> > > >         long rc;
> > > >=20
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
> > > >=20
> > > > --
> > > > 2.40.0
> > > >=20
> > >=20
> > A safe cleanup, no problem found.
> >=20
> > Reviewed-by: Guo Ren <guoren@kernel.org>
> >=20
> >=20
>=20
> Hello Palmer,
>=20
> Any improvements you suggest for this patch?
>=20
> Best regards,
> Leonardo Bras

Superseded by v2:
https://patchwork.kernel.org/project/linux-riscv/list/?series=3D772422&stat=
e=3D%2A&archive=3Dboth

Leo

