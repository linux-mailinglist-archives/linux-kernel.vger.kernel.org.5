Return-Path: <linux-kernel+bounces-140697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842D28A17D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1BF41F255E6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52590DF43;
	Thu, 11 Apr 2024 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WJu12uy+"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD5ED529
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712847070; cv=none; b=MuMdhWRJj/LFjypywXhIAG5aFSiKN4aV085SZH1t51MnUQYwaNKSsW+0RvNyAdDj1hHXJOQqFWwpCGcU2AgVZa5YC5KVBBmWvPxOAkMWGX+BpLyk5y7Z0ScraTmKmcWbWXIHECpSptw0bGqrlkfJI1CA1IMG4mWO797kX7h89Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712847070; c=relaxed/simple;
	bh=XvvMgS8KM9bD8EXAWpvpyGCBQp7ouztblDsNIm8RM90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Co2Mw1XO4Wml91scE/b4ZvMuKnTQ0cHXppWkntZeTyFPy6gkmOagEwCX89poSBwmI6OuL98Q6307l2uF4Gntz9y+j4wRPRuaQjv9EcPjSJiZocdA5jeV7vQ8U2+mbWI3DHyR9gmpiA2LL7iqNOU1F/Ts0VHWTePLZ7Rc6SyM4cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WJu12uy+; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4dad331b828so1589600e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712847067; x=1713451867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgqT1CKpIWq/SKAnPsoPdkIFm1Z2kKufmdCFfw5sjuI=;
        b=WJu12uy+q2ub9CxvXtISjK09xcZ5UyoxPNy5wQHQIiEp5/sr2SY0STuFLu4oCl1J+a
         A/mLoaHCBaTuksjbf9qgETL19D+vlxg1yFDWH0Ub/HC8oIqTOIJX4dABDCwIA2cj/zS+
         KnIiNjTuigmH3ZPkXMx9KFfZUaOBzPYdMykqIXYdsLkyZb9qDvWmoZmfVdVy7+vpf9K1
         tMNWqNEGrHPs/V9Bc/T1AkhdgesSMZC4WVNismmQ5OCrudr4PTTfrikOdUHdYjnmdGRR
         99uDCQ6pasTsmkjEvluQk6HGArwDJxtTWZlLFLXETSqPZUXhtVeIRGX9w0qpf8eIHiWT
         zBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712847067; x=1713451867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgqT1CKpIWq/SKAnPsoPdkIFm1Z2kKufmdCFfw5sjuI=;
        b=cLSO4vzjylbxn76s5kNcOceZKpS9o6vuv+tjBrCNQ0TmRhSMDcnLn0dfhFYOS4Z7yg
         e9uQek0sbyTYRYr5L8bPbeHBFr9pLrLLkgTds3clqVHbUPADN4pvLFoihWz6+0PLKFjx
         l08Rd1NNPQlLzFwFkZXvbar9WMN4K0QYR5laC+O8bIUo4P0YbBCJQaIyARPaZhACV73J
         8oBQGxZ9Y2A9tm0i5g3baMo1B+CyDCDgxRza2RvIKtCReWvRI5vL1uq61lKYVsa1iwJa
         S9E5x4pi6mbnTEeCmTAyZWu5WvtYfZsb4QscQcMPzZVfec8r5Iapznfrf5Kax52Q+KZl
         szwA==
X-Forwarded-Encrypted: i=1; AJvYcCXuJXzztoL1ZXByChubI2eFfeGrX04hjXnH9in5AwtJJG7TxwmvCfMCb+6ZOk9VmGSVgO3DOb6M200X2tYwMroxKTegu6PQW6fiN6Ad
X-Gm-Message-State: AOJu0YxpxUnCXUgdwRPJlf2KemEfEo8RQJJe31sOrIoWJtg2M7j17sg0
	chCvo8SW1EUt141t1Rq14fz+2/iZVw+1uNkGHNfCHYJOro4/1mM4bSvR8E4BeTh9YnvBTkBjfHA
	DpGZHOp54yBRYzKXctaT3S1cg+TRX8UV0ZkPweA==
X-Google-Smtp-Source: AGHT+IEYnjtPMTFGSmzBVj4ZO+mgjjVSiqDfVfH2pkgfdUKnn+eMx9+1/LplUayFdXwH/afBi9LnrPBmnZPKX6nByHE=
X-Received: by 2002:a05:6122:2519:b0:4c8:8d45:5325 with SMTP id
 cl25-20020a056122251900b004c88d455325mr31366vkb.7.1712847067207; Thu, 11 Apr
 2024 07:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410102710.35911-1-naresh.kamboju@linaro.org>
 <20240410152307.GA25111@willie-the-truck> <CABVgOSmJX=scCGZ7FWafpKB8CdQD17Uh5MuTeoFx2BhGC0DMSw@mail.gmail.com>
 <CA+G9fYuuLXnVuc2fqy_-EY3QBiUxroU9uw74vZ2i08qW=-q1tQ@mail.gmail.com>
In-Reply-To: <CA+G9fYuuLXnVuc2fqy_-EY3QBiUxroU9uw74vZ2i08qW=-q1tQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 11 Apr 2024 20:20:55 +0530
Message-ID: <CA+G9fYt6U4YzYGvYWxDVvUVKNc0pgVYiGafZ5_OSEf=5r1=YYA@mail.gmail.com>
Subject: Re: BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq next-20240410
To: David Gow <davidgow@google.com>
Cc: Will Deacon <will@kernel.org>, mic@digikod.net, keescook@chromium.org, 
	rmoar@google.com, lkft-triage@lists.linaro.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	longman@redhat.com, boqun.feng@gmail.com, anders.roxell@linaro.org, 
	dan.carpenter@linaro.org, arnd@arndb.de, linux@roeck-us.net, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Apr 2024 at 20:12, Naresh Kamboju <naresh.kamboju@linaro.org> wr=
ote:
>
> On Thu, 11 Apr 2024 at 09:55, David Gow <davidgow@google.com> wrote:
> >
> > On Wed, 10 Apr 2024 at 23:23, Will Deacon <will@kernel.org> wrote:
> > >
> > > On Wed, Apr 10, 2024 at 03:57:10PM +0530, Naresh Kamboju wrote:
> > > > Following kernel crash noticed on Linux next-20240410 tag while run=
ning
> > > > kunit testing on qemu-arm64 and qemu-x86_64.
> > > >
> > > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > > >
>
> <trim>
>
> > >
> > > Ok, so 'task_struct->vfork_done' is NULL. Looks like this code was ad=
ded
> > > recently, so adding Micka=C3=ABl to cc.
> > >
> >
> > Thanks. This looks like a race condition where the KUnit test kthread
> > can terminate before we wait on it.
> >
> > Micka=C3=ABl, does this seem like a correct fix to you?
> > ---
> > From: David Gow <davidgow@google.com>
> > Date: Thu, 11 Apr 2024 12:07:47 +0800
> > Subject: [PATCH] kunit: Fix race condition in try-catch completion
> >
> > KUnit's try-catch infrastructure now uses vfork_done, which is always
> > set to a valid completion when a kthread is crated, but which is set to
> > NULL once the thread terminates. This creates a race condition, where
> > the kthread exits before we can wait on it.
> >
> > Keep a copy of vfork_done, which is taken before we wake_up_process()
> > and so valid, and wait on that instead.
> >
> > Fixes: 4de2a8e4cca4 ("kunit: Handle test faults")
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Signed-off-by: David Gow <davidgow@google.com>
>
> This patch tested on top of Linux next and reported issues fixed.
>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>



>
> > ---
> > lib/kunit/try-catch.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> > index fa687278ccc9..fc6cd4d7e80f 100644
> > --- a/lib/kunit/try-catch.c
> > +++ b/lib/kunit/try-catch.c
> > @@ -63,6 +63,7 @@ void kunit_try_catch_run(struct kunit_try_catch
> > *try_catch, void *context)
> > {
> >        struct kunit *test =3D try_catch->test;
> >        struct task_struct *task_struct;
> > +       struct completion *task_done;
> >        int exit_code, time_remaining;
> >
> >        try_catch->context =3D context;
> > @@ -75,13 +76,14 @@ void kunit_try_catch_run(struct kunit_try_catch
> > *try_catch, void *context)
> >                return;
> >        }
> >        get_task_struct(task_struct);
> > +       task_done =3D task_struct->vfork_done;
> >        wake_up_process(task_struct);
> >        /*
> >         * As for a vfork(2), task_struct->vfork_done (pointing to the
> >         * underlying kthread->exited) can be used to wait for the end o=
f a
> >         * kernel thread.
> >         */
> > -       time_remaining =3D wait_for_completion_timeout(task_struct->vfo=
rk_done,
> > +       time_remaining =3D wait_for_completion_timeout(task_done,
> >                                                     kunit_test_timeout(=
));
> >        if (time_remaining =3D=3D 0) {
> >                try_catch->try_result =3D -ETIMEDOUT;
> > --

I use to notice kernel panic while running kunit tests
now I have noticed this

Unable to handle kernel paging request at virtual address
KASAN: null-ptr-deref in range
pc : kunit_test_null_dereference (lib/kunit/kunit-test.c:119)
lr : kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:31)

The kunit tests run to completion and the system is stable.
Kernel did not panic.

kunit test log:
------
<6>[   76.784878]     # Subtest: kunit_fault
<6>[   76.785527]     # module: kunit_test
<6>[   76.785785]     1..1
<1>[   76.794318] Unable to handle kernel paging request at virtual
address dfff800000000000
<1>[   76.796137] KASAN: null-ptr-deref in range
[0x0000000000000000-0x0000000000000007]
<1>[   76.796970] Mem abort info:
<1>[   76.797685]   ESR =3D 0x0000000096000005
<1>[   76.798868]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
<1>[   76.800355]   SET =3D 0, FnV =3D 0
<1>[   76.800893]   EA =3D 0, S1PTW =3D 0
<1>[   76.801715]   FSC =3D 0x05: level 1 translation fault
<1>[   76.802654] Data abort info:
<1>[   76.803713]   ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
<1>[   76.804362]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
<1>[   76.805278]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
<1>[   76.806302] [dfff800000000000] address between user and kernel
address ranges
<0>[   76.808597] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
<4>[   76.809876] Modules linked in:
<4>[   76.812055] CPU: 1 PID: 567 Comm: kunit_try_catch Tainted: G
B            N 6.9.0-rc3-next-20240410 #1
<4>[   76.812987] Hardware name: linux,dummy-virt (DT)
<4>[   76.814123] pstate: 12400009 (nzcV daif +PAN -UAO +TCO -DIT
-SSBS BTYPE=3D--)
<4>[ 76.814947] pc : kunit_test_null_dereference (lib/kunit/kunit-test.c:11=
9)
<4>[ 76.815862] lr : kunit_generic_run_threadfn_adapter
(lib/kunit/try-catch.c:31)
<4>[   76.816765] sp : ffff800083137dc0
<4>[   76.817473] x29: ffff800083137e20 x28: 0000000000000000 x27:
0000000000000000
<4>[   76.818684] x26: 0000000000000000 x25: 0000000000000000 x24:
fff00000c1b30c00
<4>[   76.819798] x23: ffffa76fb372e348 x22: ffffa76fb3736550 x21:
fff00000c1b30c08
<4>[   76.820900] x20: 1ffff00010626fb8 x19: ffff8000800879f0 x18:
0000000000000068
<4>[   76.822008] x17: 0000000000000000 x16: fff00000da132180 x15:
ffffa76fb36f3b04
<4>[   76.823125] x14: ffffa76fb2e3cc28 x13: 1ffe0000181547e4 x12:
fffd80001832511a
<4>[   76.824229] x11: 1ffe000018325119 x10: fffd800018325119 x9 :
ffffa76fb372e3d0
<4>[   76.825409] x8 : ffff800083137cb8 x7 : 0000000000000000 x6 :
0000000041b58ab3
<4>[   76.826532] x5 : ffff700010626fb8 x4 : 00000000f1f1f1f1 x3 :
0000000000000003
<4>[   76.827653] x2 : dfff800000000000 x1 : fff00000c1928000 x0 :
ffff8000800879f0
<4>[   76.828829] Call trace:
<4>[ 76.829410] kunit_test_null_dereference (lib/kunit/kunit-test.c:119)
<4>[ 76.830294] kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:3=
1)
<4>[ 76.831168] kthread (kernel/kthread.c:389)
<4>[ 76.831870] ret_from_fork (arch/arm64/kernel/entry.S:861)
<0>[ 76.833252] Code: b90004a3 d5384101 52800063 aa0003f3 (39c00042)
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0: b90004a3 str w3, [x5, #4]
   4: d5384101 mrs x1, sp_el0
   8: 52800063 mov w3, #0x3                    // #3
   c: aa0003f3 mov x19, x0
  10:* 39c00042 ldrsb w2, [x2] <-- trapping instruction

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
   0: 39c00042 ldrsb w2, [x2]
<4>[   76.834489] ---[ end trace 0000000000000000 ]---

Links:
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2exQ84O=
HGOdSUQMBfFMxJoo8tAo
--
Linaro LKFT
https://lkft.linaro.org

