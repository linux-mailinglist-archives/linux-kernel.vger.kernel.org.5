Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2CE7E747D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjKIWox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjKIWow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:44:52 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0549D420B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 14:44:50 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so19069a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 14:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699569888; x=1700174688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CTImi/DWpk790BqCHaZldzZROtwsywGX0FWTzFj2L8=;
        b=DfsMaDiaBQdQdc+4znHc+Tz/pusvTvZZYfUQuEFkDTTeFpX37GcXYBrTiz814eDbtp
         QjjoO//BmRE4BoeHf5YX+x2r6P5EtUEIn6y+7i4OyFpa7zV87yu2vjnm5lu6raC8xw3b
         Fii1QvnW52Xdst4ehMEPWa5lzVMkFRudSJVQ5jW/u1JXdOsX6M0yTvRV2I6kQQO0Tj5B
         i6gWTiDWJitYtRmJ8EzBiREjYQovCTeJB8YXtxrvug6u2ob9aLJbJL9ac621YuzhYtIY
         dVv8lKpgDOCLHsgWfqjzMG0tCEC86o4KH8TdtFqTp1lLzu6tBGyk9jZlITT08u5tL9zl
         RlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699569888; x=1700174688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CTImi/DWpk790BqCHaZldzZROtwsywGX0FWTzFj2L8=;
        b=Zpc8mCudyZ+ofXTdAZc1WwAhOcQ/YTGeAvmtucqeR9FecDmG47fgEyWvWgnTxZnSRN
         dpFpbme3/OEfakqzwYjoxq8sji3aM8GorSUg3iJ4mbrT7Ri6Zu+jM16LKDqnLjuw+KGS
         yGvJDdZgYgQ/738dQB+1iGUOnVUvNlcdxYIt76gf+3MH9H4XKyW9Lh1MQ9xnf0qFM3rB
         tVBo75LCIQbI5BhDfXc+wbjsSdT7nJGA9SC0IhzP29DM52VUtrguN5SNyFSfT6R7R/d3
         /YSw63LFf5vZ0buJ32z7vKPw1Hp147AjFFSs18gqZfQArDkBl0RV9mO1ccfhmGLTYRrx
         Kc4Q==
X-Gm-Message-State: AOJu0YzFS29NKRH7g6ILE+WlMKDYvqPho+dv2x0bzDc5S8HomKOyALso
        db4fLPbX+NevKWkFZg9Cv/qgMNCvMbMkCBJT2VjfYA==
X-Google-Smtp-Source: AGHT+IFJ0INqBt3RGn7B0ZT9oN7N4h53CmGunDKkG9d6IuaZT+muFJvXuaz+S/Q3w6QBHbMpDHaozjtvfXVtprZSsbw=
X-Received: by 2002:a05:6402:5410:b0:545:2e6:cf63 with SMTP id
 ev16-20020a056402541000b0054502e6cf63mr295994edb.6.1699569888247; Thu, 09 Nov
 2023 14:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20231109180646.2963718-1-khorenko@virtuozzo.com>
In-Reply-To: <20231109180646.2963718-1-khorenko@virtuozzo.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 9 Nov 2023 14:44:32 -0800
Message-ID: <CALMp9eQGqqo66fQGwFJMc3y+9XdUrL7ageE8kvoAOV6NJGfJpw@mail.gmail.com>
Subject: Re: [PATCH 0/1] KVM: x86/vPMU: Speed up vmexit for AMD Zen 4 CPUs
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Denis V. Lunev" <den@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 10:24=E2=80=AFAM Konstantin Khorenko
<khorenko@virtuozzo.com> wrote:
>
> We have detected significant performance drop of our atomic test which
> checks the rate of CPUID instructions rate inside an L1 VM on an AMD
> node.
>
> Investigation led to 2 mainstream patches which have introduced extra
> events accounting:
>
>    018d70ffcfec ("KVM: x86: Update vPMCs when retiring branch instruction=
s")
>    9cd803d496e7 ("KVM: x86: Update vPMCs when retiring instructions")
>
> And on an AMD Zen 3 CPU that resulted in immediate 43% drop in the CPUID
> rate.
>
> Checking latest mainsteam kernel the performance difference is much less
> but still quite noticeable: 13.4% and shows up on AMD CPUs only.
>
> Looks like iteration over all PMCs in kvm_pmu_trigger_event() is cheap
> on Intel and expensive on AMD CPUs.
>
> So the idea behind this patch is to skip iterations over PMCs at all in
> case PMU is disabled for a VM completely or PMU is enabled for a VM, but
> there are no active PMCs at all.

A better solution may be to maintain two bitmaps of general purpose
counters that need to be incremented, one for instructions retired and
one for branch instructions retired. Set or clear these bits whenever
the PerfEvtSelN MSRs are written. I think I would keep the PGC bits
separate, on those microarchitectures that support PGC. Then,
kvm_pmu_trigger_event() need only consult the appropriate bitmap (or
the logical and of that bitmap with PGC). In most cases, the value
will be zero, and the function can simply return.

This would work even for AMD microarchitectures that don't support PGC.

> Unfortunately
>  * current kernel code does not differentiate if PMU is globally enabled
>    for a VM or not (pmu->version is always 1)
>  * AMD CPUs older than Zen 4 do not support PMU v2 and thus efficient
>    check for enabled PMCs is not possible
>
> =3D> the patch speeds up vmexit for AMD Zen 4 CPUs only, this is sad.
>    but the patch does not hurt other CPUs - and this is fortunate!
>
> i have no access to a node with AMD Zen 4 CPU, so i had to test on
> AMD Zen 3 CPU and i hope my expectations are right for AMD Zen 4.
>
> i would appreciate if anyone perform the test of a real AMD Zen 4 node.
>
> AMD performance results:
> CPU: AMD Zen 3 (three!): AMD EPYC 7443P 24-Core Processor
>
>  * The test binary is run inside an AlmaLinux 9 VM with their stock kerne=
l
>    5.14.0-284.11.1.el9_2.x86_64.
>  * Test binary checks the CPUID instractions rate (instructions per sec).
>  * Default VM config (PMU is off, pmu->version is reported as 1).
>  * The Host runs the kernel under test.
>
>  # for i in 1 2 3 4 5 ; do ./at_cpu_cpuid.pub ; done | \
>    awk -e '{print $4;}' | \
>    cut -f1 --delimiter=3D'.' | \
>    ./avg.sh
>
> Measurements:
> 1. Host runs stock latest mainstream kernel commit 305230142ae0.
> 2. Host runs same mainstream kernel + current patch.
> 3. Host runs same mainstream kernel + current patch + force
>    guest_pmu_is_enabled() to always return "false" using following change=
:
>
>    -       if (pmu->version >=3D 2 && !(pmu->global_ctrl & ~pmu->global_c=
trl_mask))
>    +       if (pmu->version =3D=3D 1 && !(pmu->global_ctrl & ~pmu->global=
_ctrl_mask))
>
>    -----------------------------------------
>    | Kernels       | CPUID rate            |
>    -----------------------------------------
>    | 1.            | 1360250               |
>    | 2.            | 1365536 (+ 0.4%)      |
>    | 3.            | 1541850 (+13.4%)      |
>    -----------------------------------------
>
> Measurement (2) gives some fluctuation, the performance is not increased
> because the test was done on a Zen 3 CPU, so we are unable to use fast
> check for active PMCs.
> Measurement (3) shows expected performance boost on a Zen 4 CPU under
> the same test.
>
> The test used:
> # cat at_cpu_cpuid.pub.cpp
> /*
>  * The test executes CPUID instruction in a loop and reports the calls ra=
te.
>  */
>
> #include <stdio.h>
> #include <time.h>
>
> /* #define CPUID_EAX            0x80000002 */
> #define CPUID_EAX               0x29a
> #define CPUID_ECX               0
>
> #define TEST_EXEC_SECS          30      // in seconds
> #define LOOPS_APPROX_RATE       1000000
>
> static inline void cpuid(unsigned int _eax, unsigned int _ecx)
> {
>         unsigned int regs[4] =3D {_eax, 0, _ecx, 0};
>
>         asm __volatile__(
>                 "cpuid"
>                 : "=3Da" (regs[0]), "=3Db" (regs[1]), "=3Dc" (regs[2]), "=
=3Dd" (regs[3])
>                 :  "0" (regs[0]),  "1" (regs[1]),  "2" (regs[2]),  "3" (r=
egs[3])
>                 : "memory");
> }
>
> double cpuid_rate_loops(int loops_num)
> {
>         int i;
>         clock_t start_time, end_time;
>         double spent_time, rate;
>
>         start_time =3D clock();
>
>         for (i =3D 0; i < loops_num; i++)
>                 cpuid((unsigned int)CPUID_EAX, (unsigned int)CPUID_ECX);
>
>         end_time =3D clock();
>         spent_time =3D (double)(end_time - start_time) / CLOCKS_PER_SEC;
>
>         rate =3D (double)loops_num / spent_time;
>
>         return rate;
> }
>
> int main(int argc, char* argv[])
> {
>         double approx_rate, rate;
>         int loops;
>
>         /* First we detect approximate CPUIDs rate. */
>         approx_rate =3D cpuid_rate_loops(LOOPS_APPROX_RATE);
>
>         /*
>          * How many loops there should be in order to run the test for
>          * TEST_EXEC_SECS seconds?
>          */
>         loops =3D (int)(approx_rate * TEST_EXEC_SECS);
>
>         /* Get the precise instructions rate. */
>         rate =3D cpuid_rate_loops(loops);
>
>         printf( "CPUID instructions rate: %f instructions/second\n", rate=
);
>
>         return 0;
> }
>
> Konstantin Khorenko (1):
>   KVM: x86/vPMU: Check PMU is enabled for vCPU before searching for PMC
>
>  arch/x86/kvm/pmu.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> --
> 2.39.3
>
>
