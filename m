Return-Path: <linux-kernel+bounces-139741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84028A071A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3E02880F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 04:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2743E13C3CF;
	Thu, 11 Apr 2024 04:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLsh4J9j"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407613B5A6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712809558; cv=none; b=oE9uEi7+EhM9LV2kT1jFm5rJ1ZJVO8HTUVWjC+yNnG+5kHcL25EUhtqRFXOeGsxDcm0Nd4wlIVrIL1LAUV5zDC0OvInTfVBfiehmne4BfWX7aWOeRp57xqJw0IO+9hcBGEZObypd+/aAlyjmHvvXWteshJfkt0cIFKHfU4lLFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712809558; c=relaxed/simple;
	bh=oxi2OKerIF315VVFmuLaP5aAMnTF5031/V0XLDjL4Jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJzy0b9atnFG8Ao5lNzF42unD/hJahXdb/U2Ht/Xai0if1Efmzu6LsZS2I+/ZFHZ6/2ixp9PmFjEbDrLmBftfPuo3pVDC2b6ge10l0WYKH1H7N/0S55YTf2m9XNVT2ae0PUkhQXnnuEHiDYIXFE6w682pKl2E+QDNoVIoqPAkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QLsh4J9j; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so4180a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712809554; x=1713414354; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OGZwW/DBNGOl3pBzyEkO8hTiXua9xAobSAemhCAbtpY=;
        b=QLsh4J9j8arNtc/63AmRAx6OsEwP6dPrQ0q96UYTJgcqPUutgbPt0AzDHXCpnglqyj
         /BfWX9B7cFtZQejoaLFVAYf1GMKgYnsyoxXeoks6PpIjupZnSDkGHY7NcazC1qCA0Lj5
         34PCSvpptxRkm5Y2U8ZuizDpo45NnRO00V6EDHGWXTDyTJZh7IzF5OLsrjV4Hq2d6ECW
         aSLe09L/JsguzbVKM09jjW+DSGcnHc3ISzjBUYdkTwlmd7UWNmo33AK4w4qnsaZ9cejl
         kaVhDDyR9jABFvbIWqWRz/EY0usdFYyfWAPXW7MnDPXLnPwMRXEv8WVHHGrwx0xWMyVF
         zVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712809554; x=1713414354;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGZwW/DBNGOl3pBzyEkO8hTiXua9xAobSAemhCAbtpY=;
        b=wrae4S5p6eI1uJDyeVOdpJ4MvJuc38YLiGvVccCZ7kSACMTpd8wat27tZjyNLzVuB4
         9NGkg5M/OkrqGp0iDaPqdVm2PU3cNXkqbSGqBZFOE8z+DAAqg9ib1PyPpElLZZccHXmZ
         kN+4sZbn+hUgP3dS7NxU7keVrGcQLB2+ZruORD08hGO6+LMGUVlInMzLcnHkC1lSCArk
         Py2m2rnvgRiA2WMF6EwsVCQNSmxZKd69uJ3MHPJHGSRNJi5KIizqrjICL+0B4p3MvjbG
         FodCmgpFIOzmrTkMdqROrGRIRkEvNEQuVvqDjH07AjBhyp3juwWR9Xr12Iw6T7WR0hcS
         fltA==
X-Forwarded-Encrypted: i=1; AJvYcCVDQNW5JyQRB5+2rr4ODhcCXYC4Ezc6mIbywhjcJEOXq2FMwBefbDSRx0k47vtLoImisW/OQFV6aiGjqe4R1Z9kAnDkXTkUL+7MD3L6
X-Gm-Message-State: AOJu0Yzou7qEmHqHLC7+o/Y3DG8F7IbSwFgpJ6wPZLcihOlemylbCT5U
	hifVQSaHpnfj+VIZOIeGua3TORN/Obe+E8BiS02YyTDqX4/sMECqufpEWtCWU+0TOf0xfCI7cK2
	SPntXiFS+ss44J/TdtpzYqYZSIzrWAMh9VIaTfpIlI/P58oNH0QsQ
X-Google-Smtp-Source: AGHT+IH2hQls1m7UNdV48Wn6pAK77+Rp29OLM0+t45ZoUv+zF0JtdDYoLt8qtMv1IVmSoNmgkLxR4cJ70h/rwsUuMAM=
X-Received: by 2002:a05:6402:524d:b0:56e:6e04:4fb9 with SMTP id
 t13-20020a056402524d00b0056e6e044fb9mr80183edd.1.1712809554059; Wed, 10 Apr
 2024 21:25:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410102710.35911-1-naresh.kamboju@linaro.org> <20240410152307.GA25111@willie-the-truck>
In-Reply-To: <20240410152307.GA25111@willie-the-truck>
From: David Gow <davidgow@google.com>
Date: Thu, 11 Apr 2024 12:25:40 +0800
Message-ID: <CABVgOSmJX=scCGZ7FWafpKB8CdQD17Uh5MuTeoFx2BhGC0DMSw@mail.gmail.com>
Subject: Re: BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq next-20240410
To: Will Deacon <will@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, mic@digikod.net, keescook@chromium.org, 
	rmoar@google.com, lkft-triage@lists.linaro.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	longman@redhat.com, boqun.feng@gmail.com, anders.roxell@linaro.org, 
	dan.carpenter@linaro.org, arnd@arndb.de, linux@roeck-us.net, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000010f2280615ca8d9c"

--00000000000010f2280615ca8d9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Apr 2024 at 23:23, Will Deacon <will@kernel.org> wrote:
>
> On Wed, Apr 10, 2024 at 03:57:10PM +0530, Naresh Kamboju wrote:
> > Following kernel crash noticed on Linux next-20240410 tag while running
> > kunit testing on qemu-arm64 and qemu-x86_64.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Crash log on qemu-arm64:
> > ----------------
> > <3>[ 30.465716] BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq (inclu=
de/linux/instrumented.h:96 include/linux/atomic/atomic-instrumented.h:1301 =
include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/li=
nux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170)
> > <3>[   30.467097] Write of size 4 at addr 0000000000000008 by task swap=
per/0/1
> > <3>[   30.468059]
> > <3>[   30.468393] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B        =
    N 6.9.0-rc3-next-20240410 #1
> > <3>[   30.469209] Hardware name: linux,dummy-virt (DT)
> > <3>[   30.469645] Call trace:
> > <3>[ 30.469919] dump_backtrace (arch/arm64/kernel/stacktrace.c:319)
> > <3>[ 30.471622] show_stack (arch/arm64/kernel/stacktrace.c:326)
> > <3>[ 30.472124] dump_stack_lvl (lib/dump_stack.c:117)
> > <3>[ 30.472947] print_report (mm/kasan/report.c:493)
> > <3>[ 30.473755] kasan_report (mm/kasan/report.c:603)
> > <3>[ 30.474524] kasan_check_range (mm/kasan/generic.c:175 mm/kasan/gene=
ric.c:189)
> > <3>[ 30.475094] __kasan_check_write (mm/kasan/shadow.c:38)
> > <3>[ 30.475683] _raw_spin_lock_irq (include/linux/instrumented.h:96 inc=
lude/linux/atomic/atomic-instrumented.h:1301 include/asm-generic/qspinlock.=
h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 ker=
nel/locking/spinlock.c:170)
> > <3>[ 30.476257] wait_for_completion_timeout (kernel/sched/completion.c:=
84 kernel/sched/completion.c:116 kernel/sched/completion.c:127 kernel/sched=
/completion.c:167)
> > <3>[ 30.476909] kunit_try_catch_run (lib/kunit/try-catch.c:86)
> > <3>[ 30.477628] kunit_run_case_catch_errors (lib/kunit/test.c:544)
> > <3>[ 30.478311] kunit_run_tests (lib/kunit/test.c:635)
> > <3>[ 30.478865] __kunit_test_suites_init (lib/kunit/test.c:729 (discrim=
inator 1))
> > <3>[ 30.479482] kunit_run_all_tests (lib/kunit/executor.c:276 lib/kunit=
/executor.c:392)
> > <3>[ 30.480079] kernel_init_freeable (init/main.c:1578)
> > <3>[ 30.480747] kernel_init (init/main.c:1465)
> > <3>[ 30.481474] ret_from_fork (arch/arm64/kernel/entry.S:861)
> > <3>[   30.482080] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > <1>[   30.484503] Unable to handle kernel NULL pointer dereference at v=
irtual address 0000000000000008
> > <1>[   30.485369] Mem abort info:
> > <1>[   30.485923]   ESR =3D 0x000000009600006b
> > <1>[   30.486943]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > <1>[   30.487540]   SET =3D 0, FnV =3D 0
> > <1>[   30.488007]   EA =3D 0, S1PTW =3D 0
> > <1>[   30.488509]   FSC =3D 0x2b: level -1 translation fault
> > <1>[   30.489150] Data abort info:
> > <1>[   30.489610]   ISV =3D 0, ISS =3D 0x0000006b, ISS2 =3D 0x00000000
> > <1>[   30.490360]   CM =3D 0, WnR =3D 1, TnD =3D 0, TagAccess =3D 0
> > <1>[   30.491057]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > <1>[   30.491822] [0000000000000008] user address but active_mm is swap=
per
> > <0>[   30.493008] Internal error: Oops: 000000009600006b [#1] PREEMPT S=
MP
> > <4>[   30.494105] Modules linked in:
> > <4>[   30.496244] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B        =
    N 6.9.0-rc3-next-20240410 #1
> > <4>[   30.497171] Hardware name: linux,dummy-virt (DT)
> > <4>[   30.497905] pstate: 224000c9 (nzCv daIF +PAN -UAO +TCO -DIT -SSBS=
 BTYPE=3D--)
> > <4>[ 30.498895] pc : _raw_spin_lock_irq (arch/arm64/include/asm/atomic_=
lse.h:271 arch/arm64/include/asm/cmpxchg.h:120 arch/arm64/include/asm/cmpxc=
hg.h:169 include/linux/atomic/atomic-arch-fallback.h:2055 include/linux/ato=
mic/atomic-arch-fallback.h:2173 include/linux/atomic/atomic-instrumented.h:=
1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 inclu=
de/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170)
> > <4>[ 30.499542] lr : _raw_spin_lock_irq (include/linux/atomic/atomic-ar=
ch-fallback.h:2172 (discriminator 1) include/linux/atomic/atomic-instrument=
ed.h:1302 (discriminator 1) include/asm-generic/qspinlock.h:111 (discrimina=
tor 1) include/linux/spinlock.h:187 (discriminator 1) include/linux/spinloc=
k_api_smp.h:120 (discriminator 1) kernel/locking/spinlock.c:170 (discrimina=
tor 1))
> >
> > <trim>
>
> It's a shame that you have trimmed the register dump here.
>
> > <4>[   30.511022] Call trace:
> > <4>[ 30.511437] _raw_spin_lock_irq (arch/arm64/include/asm/atomic_lse.h=
:271 arch/arm64/include/asm/cmpxchg.h:120 arch/arm64/include/asm/cmpxchg.h:=
169 include/linux/atomic/atomic-arch-fallback.h:2055 include/linux/atomic/a=
tomic-arch-fallback.h:2173 include/linux/atomic/atomic-instrumented.h:1302 =
include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/li=
nux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170)
> > <4>[ 30.512013] wait_for_completion_timeout (kernel/sched/completion.c:=
84 kernel/sched/completion.c:116 kernel/sched/completion.c:127 kernel/sched=
/completion.c:167)
> > <4>[ 30.512627] kunit_try_catch_run (lib/kunit/try-catch.c:86)
> > <4>[ 30.513188] kunit_run_case_catch_errors (lib/kunit/test.c:544)
> > <4>[ 30.513801] kunit_run_tests (lib/kunit/test.c:635)
>
> Ok, so 'task_struct->vfork_done' is NULL. Looks like this code was added
> recently, so adding Micka=C3=ABl to cc.
>

Thanks. This looks like a race condition where the KUnit test kthread
can terminate before we wait on it.

Micka=C3=ABl, does this seem like a correct fix to you?
---
From: David Gow <davidgow@google.com>
Date: Thu, 11 Apr 2024 12:07:47 +0800
Subject: [PATCH] kunit: Fix race condition in try-catch completion

KUnit's try-catch infrastructure now uses vfork_done, which is always
set to a valid completion when a kthread is crated, but which is set to
NULL once the thread terminates. This creates a race condition, where
the kthread exits before we can wait on it.

Keep a copy of vfork_done, which is taken before we wake_up_process()
and so valid, and wait on that instead.

Fixes: 4de2a8e4cca4 ("kunit: Handle test faults")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: David Gow <davidgow@google.com>
---
lib/kunit/try-catch.c | 4 +++-
1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index fa687278ccc9..fc6cd4d7e80f 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -63,6 +63,7 @@ void kunit_try_catch_run(struct kunit_try_catch
*try_catch, void *context)
{
       struct kunit *test =3D try_catch->test;
       struct task_struct *task_struct;
+       struct completion *task_done;
       int exit_code, time_remaining;

       try_catch->context =3D context;
@@ -75,13 +76,14 @@ void kunit_try_catch_run(struct kunit_try_catch
*try_catch, void *context)
               return;
       }
       get_task_struct(task_struct);
+       task_done =3D task_struct->vfork_done;
       wake_up_process(task_struct);
       /*
        * As for a vfork(2), task_struct->vfork_done (pointing to the
        * underlying kthread->exited) can be used to wait for the end of a
        * kernel thread.
        */
-       time_remaining =3D wait_for_completion_timeout(task_struct->vfork_d=
one,
+       time_remaining =3D wait_for_completion_timeout(task_done,
                                                    kunit_test_timeout());
       if (time_remaining =3D=3D 0) {
               try_catch->try_result =3D -ETIMEDOUT;
--

--00000000000010f2280615ca8d9c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIN8PS4dKaOuaS3VM5rix2bV7phcQ8kOHYa2kfF2foVNdMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQxMTA0MjU1NFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB1RcOA
iSVkdf8tg+FO09GClCZbc8D0xguHKRyR+V8SWFhqGd/MEdHC7G9NaFBNefikkk9fAMr8YEwsGZIX
rCCs3qoxupfha3GNhAHMQ85LYx6A01XHFFtQ4dax1dA4VBk7q6I1TidkSz0rBsPsGpl6/zKD6k5D
6inEk4qHouUufmpkWSd98BxzZxDjizW6NPx2KW9qrvd+kETy38SbUJ9PmJaUXTDSyuSEY4CiAT0z
4yb5BMbaYMugDhbTCMza/MqfkALY41F95W5Uj3VqGH9ZA8ip3tYYrfv3aFTo/wAAWEInukjGl66O
nZnzvgABA9lvtVu2qtbuF5ZkBwwKtT1E
--00000000000010f2280615ca8d9c--

