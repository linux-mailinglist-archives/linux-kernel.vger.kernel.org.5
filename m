Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A297C770DB9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 06:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjHEEYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 00:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjHEEYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 00:24:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B064B4683
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 21:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09A12602E0
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 04:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACEDC433C9
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 04:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691209473;
        bh=ewtEDcg34QoYbGgN5Vr123G5dU4FHcWD9MrlE/jZp5w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PeEN7uSMlA5XhVAHthnzVZtzO0e0Rg9wt6WEm86JL2MwUrlAhOzZOj3nezx3nsVXp
         +2Bizf66P21zt+dZUYeo4TLwxOVWVix9HXtPHNC1sK6amjAmpORxEhP/j5+DHf7ozk
         l8D/Y0z7KcdqNuSPDVcM2MRR/B+QQo9VlsiUkzpDju87dlJiX9yqfY5rskMNrPN5hM
         p0+77nUnnhSJ7a81qxkuCroSrIUPzdzTRsbr34hnfhe3jndG1AO2P1QrtbiPS/fg+Y
         sGlJ7XcljdyR8J5F9wCoiPKXB3MuHLoeo1wPJIx+es0jgRnHzrL/+jJRZlfb28hTut
         Chgg0RlBnrk3Q==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-52256241c66so5836868a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 21:24:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YxSfvEROeVQNNcFnqKLuHoZ8WTMU9fxsw8C2SKTe3jCqo8kVEer
        lBdJxV9Muhmt+Y3f5z9CXuG9GpL3NJHFX+HritE=
X-Google-Smtp-Source: AGHT+IHM3/0cnah9HbCYv1j+tlNf6izw+zb33C1aQ3wTKFaLvihKs2cBxKaqkSshwhEJOfXCGvMY9LtuPZRfl26gSUc=
X-Received: by 2002:a05:6402:2747:b0:51e:2c4b:6f1e with SMTP id
 z7-20020a056402274700b0051e2c4b6f1emr1841498edd.14.1691209471650; Fri, 04 Aug
 2023 21:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230804084900.1135660-2-leobras@redhat.com> <20230804084900.1135660-6-leobras@redhat.com>
 <CAJF2gTTOT3_3K_cWNY9n_DgRoPhYEhBLno=bh57r9D--OavREQ@mail.gmail.com> <CAJ6HWG4gy7HV11-cdoB0VAP2z1Zw-zyJhNRpJ1eDMmrkvnob3w@mail.gmail.com>
In-Reply-To: <CAJ6HWG4gy7HV11-cdoB0VAP2z1Zw-zyJhNRpJ1eDMmrkvnob3w@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 5 Aug 2023 12:24:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQY5RX87Zo8HcM1Og-Oc6vd5Vyj97KL-o6UcqMaT4oxng@mail.gmail.com>
Message-ID: <CAJF2gTQY5RX87Zo8HcM1Og-Oc6vd5Vyj97KL-o6UcqMaT4oxng@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/5] riscv/cmpxchg: Implement cmpxchg for variables
 of size 1 and 2
To:     Leonardo Bras Soares Passos <leobras@redhat.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 5, 2023 at 11:14=E2=80=AFAM Leonardo Bras Soares Passos
<leobras@redhat.com> wrote:
>
> Hello Guo Ren, thanks for the feedback!
>
> On Fri, Aug 4, 2023 at 2:45=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Fri, Aug 4, 2023 at 4:49=E2=80=AFAM Leonardo Bras <leobras@redhat.co=
m> wrote:
> > >
> > > cmpxchg for variables of size 1-byte and 2-bytes is not yet available=
 for
> > > riscv, even though its present in other architectures such as arm64 a=
nd
> > > x86. This could lead to not being able to implement some locking mech=
anisms
> > > or requiring some rework to make it work properly.
> > >
> > > Implement 1-byte and 2-bytes cmpxchg in order to achieve parity with =
other
> > > architectures.
> > >
> > > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > > ---
> > >  arch/riscv/include/asm/cmpxchg.h | 35 ++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 35 insertions(+)
> > >
> > > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/as=
m/cmpxchg.h
> > > index 5a07646fae65..dfb433ac544f 100644
> > > --- a/arch/riscv/include/asm/cmpxchg.h
> > > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > @@ -72,6 +72,36 @@
> > >   * indicated by comparing RETURN with OLD.
> > >   */
> > >
> > > +#define __arch_cmpxchg_mask(sc_sfx, prepend, append, r, p, o, n)    =
   \
> > > +({                                                                  =
   \
> > > +       /* Depends on 2-byte variables being 2-byte aligned */       =
   \
> > > +       ulong __s =3D ((ulong)(p) & 0x3) * BITS_PER_BYTE;            =
     \
> > > +       ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, =
0)   \
> > > +                       << __s;                                      =
   \
> > > +       ulong __newx =3D (ulong)(n) << __s;                          =
     \
> > > +       ulong __oldx =3D (ulong)(o) << __s;                          =
     \
> > > +       ulong __retx;                                                =
   \
> > > +       register unsigned int __rc;                                  =
   \
> > > +                                                                    =
   \
> > > +       __asm__ __volatile__ (                                       =
   \
> > > +               prepend                                              =
   \
> > > +               "0:     lr.w %0, %2\n"                               =
   \
> > > +               "       and  %0, %0, %z5\n"                          =
   \
> > > +               "       bne  %0, %z3, 1f\n"                          =
   \
>
> > bug:
> > -               "       and  %0, %0, %z5\n"                            =
 \
> > -               "       bne  %0, %z3, 1f\n"                            =
 \
> > +               "       and  %1, %0, %z5\n"                            =
 \
> > +               "       bne  %1, %z3, 1f\n"                            =
 \
> > Your code breaks the %0.
>
> What do you mean by breaks here?
>
> In the end of this macro, I intended  to have __retx =3D (*p & __mask)
> which means the value is clean to be rotated at the end of the macro
> (no need to apply the mask again): r =3D __ret >> __s;
>
> Also, I assumed we are supposed to return the same variable type
> as the pointer, so this is valid:
> u8 a, *b, c;
> a =3D xchg(b, c);
>
> Is this correct?
I missed your removing "__ret & mask" at the end. So this may not the probl=
em.

Your patch can't boot. After chewing your code for several hours, I
found a problem:
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpx=
chg.h
index 943f094375c7..67bcce63b267 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -14,6 +14,7 @@
 #define __arch_xchg_mask(prepend, append, r, p, n)                     \
 ({                                                                     \
        /* Depends on 2-byte variables being 2-byte aligned */          \
+       volatile ulong *__p =3D (ulong *)((ulong)(p) & ~0x3);             \
        ulong __s =3D ((ulong)(p) & 0x3) * BITS_PER_BYTE;                 \
        ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)   \
                        << __s;                                         \
@@ -29,7 +30,7 @@
               "        sc.w %1, %1, %2\n"                              \
               "        bnez %1, 0b\n"                                  \
               append                                                   \
-              : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(p))             =
 \
+              : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(__p))           =
 \
               : "rJ" (__newx), "rJ" (~__mask)                          \
               : "memory");                                             \
                                                                        \
@@ -106,6 +107,7 @@
 #define __arch_cmpxchg_mask(sc_sfx, prepend, append, r, p, o, n)       \
 ({                                                                     \
        /* Depends on 2-byte variables being 2-byte aligned */          \
+       volatile ulong *__p =3D (ulong *)((ulong)(p) & ~0x3);             \
        ulong __s =3D ((ulong)(p) & 0x3) * BITS_PER_BYTE;                 \
        ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)   \
                        << __s;                                         \
@@ -125,7 +127,7 @@
                "       bnez %1, 0b\n"                                  \
                append                                                  \
                "1:\n"                                                  \
-               : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(p))            =
 \
+               : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(__p))          =
 \
                : "rJ" ((long)__oldx), "rJ" (__newx),                   \
                  "rJ" (__mask), "rJ" (~__mask)                         \
                : "memory");                                            \

But the lkvm-static still can't boot with paravirt_spinlock .... Are
there any atomic tests in the Linux?

I found you use some "register int variables". Would it cause the problem?

You can reference this file, and it has passed the lock torture test:
https://github.com/guoren83/linux/blob/sg2042-master-qspinlock-64ilp32_v4/a=
rch/riscv/include/asm/cmpxchg.h

I also merged your patches with the qspinlock series: (Use the above
cmpxchg.h the lkvm would run normally.)
https://github.com/guoren83/linux/tree/qspinlock_v11



>
> > > +               append                                               =
   \
> > > +               "1:\n"                                               =
   \
> > > +               : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(p))      =
       \
> > > +               : "rJ" ((long)__oldx), "rJ" (__newx),                =
   \
> > > +                 "rJ" (__mask), "rJ" (~__mask)                      =
   \
> > > +               : "memory");                                         =
   \
> > > +                                                                    =
   \
> > > +       r =3D (__typeof__(*(p)))(__retx >> __s);                     =
     \
> > > +})
> > > +
> > >
> > >  #define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, o,=
 n)        \
> > >  ({                                                                  =
   \
> > > @@ -98,6 +128,11 @@
> > >         __typeof__(*(ptr)) __ret;                                    =
   \
> > >                                                                      =
   \
> > >         switch (sizeof(*__ptr)) {                                    =
   \
> > > +       case 1:                                                      =
   \
> > > +       case 2:                                                      =
   \
> > > +               __arch_cmpxchg_mask(sc_sfx, prepend, append,         =
   \
> > > +                                       __ret, __ptr, __old, __new); =
   \
> > > +               break;                                               =
   \
> > >         case 4:                                                      =
   \
> > >                 __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,   =
   \
> > >                                 __ret, __ptr, (long), __old, __new); =
   \
> > > --
> > > 2.41.0
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
>


--
Best Regards
 Guo Ren
