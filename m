Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7863478E1AA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242986AbjH3VyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241910AbjH3VyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100A7122
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693432279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RwMhUi78iLzb6B1R9ibtn+RGWIWRZszqqgWbG3yfVHk=;
        b=DgULl2RfWJoGuXrCeHhXl4Q5K394fkzv4i/ST5dJGT+f9dOrvJCsE50SpVr0mj4Y46bw4S
        0vVUVMo0eWddhB5XTg9PmobjuTbSWBjNb05HGatXaZqPv+RIPrt6PYd4rVFpIAlJBPLepN
        EdWGasgT12nGrq0N0T9Q12Gq3vxj+mU=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672--TvlTMWJNcmWuR2sgbdxnw-1; Wed, 30 Aug 2023 17:51:17 -0400
X-MC-Unique: -TvlTMWJNcmWuR2sgbdxnw-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1c8cea801f3so91160fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693432277; x=1694037077;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RwMhUi78iLzb6B1R9ibtn+RGWIWRZszqqgWbG3yfVHk=;
        b=OgmR9USB/S1WvXdis7yLfuKlgT+MiIDyjKEvayKi/GF1vKS63fM7hUhLZRMV24Mud5
         8AV35MdEExl4Dx0yU4ITub2MkWZ5gEYtsrZNnW0V5L4Ub+k+Ca4vNejy1EE52oJkh/me
         P1KMCZRVBkZA/tr4jf7bsjtfjUfZkljweSF1zRBPtaR5AyqvSj+gu+s3nbDY5JEjX714
         +wGyFVhYhsrWCndux43EjePQYGrPWLok//nzHg8GDt6zucwlOLPAUqc4Gw+h1frWj1GO
         qG1AsVEGCRx11gJJH8m0rZOV+YtL6gofPgEvcwKGyxooghczAZZIt7Az2Y2aM4f5ymIe
         njZQ==
X-Gm-Message-State: AOJu0YxSmmL2848o6gkVG3Vrm61woe8PR1anMQ/u7PiqHUF1/IusMRBM
        g/3id1HRyp7D5p8vX0GcMvxA3muKJZxfJk5/ah1fmMf2knCwmTPL52E7CN+pMUCQYmDZN2jjPBw
        ac/j38DXzXLat9dC3RCTGSRwv
X-Received: by 2002:a05:6870:e0d1:b0:1bb:8333:ab8a with SMTP id a17-20020a056870e0d100b001bb8333ab8amr3808590oab.4.1693432277191;
        Wed, 30 Aug 2023 14:51:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgdZeTeMyfZtVyVZ1rWxcIBrlvGqZ9lkoWD3afW5AgFYCI31UE9+SCPweJgSIsgfspg3PhOw==
X-Received: by 2002:a05:6870:e0d1:b0:1bb:8333:ab8a with SMTP id a17-20020a056870e0d100b001bb8333ab8amr3808574oab.4.1693432276908;
        Wed, 30 Aug 2023 14:51:16 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a802:98e3:3c98:3d83:9703:4411? ([2804:1b3:a802:98e3:3c98:3d83:9703:4411])
        by smtp.gmail.com with ESMTPSA id r21-20020a9d7515000000b006b884bbb4f3sm96544otk.26.2023.08.30.14.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:51:16 -0700 (PDT)
Message-ID: <aa881f41ca432b76f1cb50abb6903dfdf33b8c35.camel@redhat.com>
Subject: Re: [RFC PATCH v5 5/5] riscv/cmpxchg: Implement xchg for variables
 of size 1 and 2
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To:     Guo Ren <guoren@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Date:   Wed, 30 Aug 2023 18:51:12 -0300
In-Reply-To: <CAJF2gTTg9MMj0TXJmQsWKsnoGKD_F84HKC5D9LFEy_5uERpRCw@mail.gmail.com>
References: <mhng-92f37526-d36c-48c0-8fbd-7676df1b6086@palmer-ri-x1c9>
         <ad9b8e41-5897-4ad6-8113-2812301c0c93@app.fastmail.com>
         <CAJF2gTTg9MMj0TXJmQsWKsnoGKD_F84HKC5D9LFEy_5uERpRCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Sorry for the delay, I was out of office for a while.

On Fri, 2023-08-11 at 09:24 +0800, Guo Ren wrote:
> On Fri, Aug 11, 2023 at 3:13=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wro=
te:
> >=20
> > On Thu, Aug 10, 2023, at 18:23, Palmer Dabbelt wrote:
> > > On Thu, 10 Aug 2023 09:04:04 PDT (-0700), leobras@redhat.com wrote:
> > > > On Thu, 2023-08-10 at 08:51 +0200, Arnd Bergmann wrote:
> > > > > On Thu, Aug 10, 2023, at 06:03, Leonardo Bras wrote:
> > > > > > xchg for variables of size 1-byte and 2-bytes is not yet availa=
ble for
> > > > > > riscv, even though its present in other architectures such as a=
rm64 and
> > > > > > x86. This could lead to not being able to implement some lockin=
g mechanisms
> > > > > > or requiring some rework to make it work properly.
> > > > > >=20
> > > > > > Implement 1-byte and 2-bytes xchg in order to achieve parity wi=
th other
> > > > > > architectures.
> > > >=20
> > > > > Parity with other architectures by itself is not a reason to do t=
his,
> > > > > in particular the other architectures you listed have the instruc=
tions
> > > > > in hardware while riscv does not.
> > > >=20
> > > > Sure, I understand RISC-V don't have native support for xchg on var=
iables of
> > > > size < 4B. My argument is that it's nice to have even an emulated v=
ersion for
> > > > this in case any future mechanism wants to use it.
> > > >=20
> > > > Not having it may mean we won't be able to enable given mechanism i=
n RISC-V.
> > >=20
> > > IIUC the ask is to have a user within the kernel for these functions.
> > > That's the general thing to do, and last time this came up there was =
no
> > > in-kernel use of it -- the qspinlock stuff would, but we haven't enab=
led
> > > it yet because we're worried about the performance/fairness stuff tha=
t
> > > other ports have seen and nobody's got concrete benchmarks yet (thoug=
h
> > > there's another patch set out that I haven't had time to look through=
,
> > > so that may have changed).
> >=20
> > Right. In particular the qspinlock is a good example for something
> > where having the emulated 16-bit xchg() may end up less efficient
> > than a natively supported instruction.
> The xchg() efficiency depends on micro-architecture. and the number of
> instructions is not the key, even one instruction would be separated
> into several micro-ops. I thought the Power guys won't agree with this
> view :)
>=20
> >=20
> > The xchg() here is a performance optimization for CPUs that can
> > do this without touching the other half of the 32-bit word.
> It's useless on a non-SMT system because all operations are cacheline
> based. (Ps: Because xchg() has a load semantic, CHI's "Dirty Partial"
> & "Clean Empty" can't help anymore.)
>=20
> >=20
> > > >=20
> > > > Didn't get this part:
> > > > By "emulating small xchg() through cmpxchg()", did you mean like em=
ulating an
> > > > xchg (usually 1 instruction) with lr & sc (same used in cmpxchg) ?
> > > >=20
> > > > If so, yeah, it's a fair point: in some extreme case we could have =
multiple
> > > > threads accessing given cacheline and have sc always failing. On th=
e other hand,
> > > > there are 2 arguments on that:
> > > >=20
> > > > 1 - Other architectures, (such as powerpc, arm and arm64 without LS=
E atomics)
> > > > also seem to rely in this mechanism for every xchg size. Another ar=
chs like csky
> > > > and loongarch use asm that look like mine to handle size < 4B xchg.
> >=20
> > I think you misread the arm64 code, which should use native instruction=
s
> > for all sizes, in both the armv8.0 and LSE atomics.

By native I understand you mean swp instead of ll/sc, right?

Well, that's right only if the kernel is compiled with LSE, and the ll/sc o=
ption
for is available for other arm64 that don't.=C2=A0

Also, according to Kconfig, it seems to have been introduced in ARMv8.1, me=
aning
arm64 for (at least some) ARMv8.0 use ll/sc, and this is why xchg with the =
ll/sc
code is available for 1, 2, 4 and 8 bytes in arch/arm64/include/asm/cmpxchg=
.h:

#define __XCHG_CASE(w, sfx, name, sz, mb, nop_lse, acq, acq_lse, rel,
cl)	\static inline u##sz __xchg_case_##name##sz(u##sz x, volatile void *ptr=
)		\{										\	u##szret;								\	unsignedlongtmp;							\										\
\	asm
volatile(ARM64_LSE_ATOMIC_INSN(					\	/* LL/SC */								\	"	prfm	pstl1strm=
, %2\n"					\	"1:	ld"#acq"xr"#sfx"\t%"#w"0,%2\n"				\	"	st"#rel"xr"#sfx"\t%=
w1,%"#w"3,%2\n"			\	"	cbnz	%w1,1b\n"						\	"	"#mb,								\	/*LSEatomics*/=
							\	"	swp"#acq_lse#rel#sfx"\t%"#w"3,%"#w"0,%2\n"		\[...]

__XCHG_CASE(w, b,     ,  8,        ,    ,  ,  ,  ,         )
__XCHG_CASE(w, h,     , 16,        ,    ,  ,  ,  ,         )
__XCHG_CASE(w,  ,     , 32,        ,    ,  ,  ,  ,         )

> >=20
> > PowerPC does use the masking for xchg, but I suspect there are no
> > actual users, at least it actually has its own qspinlock implementation
> > that avoids xchg().
> PowerPC still needs similar things, see publish_tail_cpu(), and more
> complex cmpxchg semantics.
>=20
> Paravrit qspinlock and CNA qspinlock still need more:
>  - xchg8 (RCsc)
>  - cmpxchg8/16_relaxed
>  - cmpxchg8/16_release (Rcpc)
>  - cmpxchg8_acquire (RCpc)
>  - cmpxchg8 (RCsc)
>=20
> >=20
> > > > >  This is also something that almost no architecture
> > > > > specific code relies on (generic qspinlock being a notable except=
ion).
> > > > >=20
> > > >=20
> > > > 2 - As you mentioned, there should be very little code that will ac=
tually make
> > > > use of xchg for vars < 4B, so it should be safe to assume its fine =
to not
> > > > guarantee forward progress for those rare usages (like some of abov=
e mentioned
> > > > archs).
> >=20
> > I don't this this is a safe assumption, we've had endless discussions
> > about using qspinlock on architectures without a native xchg(), which
> > needs either hardware guarantees or special countermeasures in xchg() i=
tself
> > to avoid this.

That seems a nice discussion, do you have a link for this?

By what I could see, Guo Ren is doing a great work on proving that using
qspinlock (with smaller xchg) performs better on RISC-V.=20

> >=20
> > What I'd actually like to do here is to remove the special 8-bit and
> > 16-bit cases from the xchg() and cmpxchg() interfaces at all, leaving
> It needs to modify qspinlock, paravirt_qspinlock, and CNA_qspinlock
> code to prevent using 8-bit/16-bit xchg/cmpxchg, and cleanup all
> architectures' cmpxchg.h. What you do is just get them out of the
> common atomic.h, but architectures still need to solve them and
> connect to the qspinlock series.
>=20
> > only fixed 32-bit and native wordsize (either 32 or 64) as the option,
> > while dealing with the others the same way we treat the fixed
> > 64-bit cases that hardcode the 64-bit argument types and are only
> > usable on architectures that provide them.
> >=20
> >     Arnd
>=20
>=20
>=20

IIUC, xchg for size 1 & 2 can still be useful if having the lock variable b=
igger
causes the target struct to use more than a cacheline. This could reduce ca=
che
usage and avoid some cacheline misses.=20

Even though in some arches those 'non-native' xchg can take longer, it can =
be
perceived as a valid tradeoff for some scenarios.

Thanks,
Leo

