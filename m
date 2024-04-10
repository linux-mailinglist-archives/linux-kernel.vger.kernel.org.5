Return-Path: <linux-kernel+bounces-139091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B11289FE69
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F37528AC17
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEAF1802AC;
	Wed, 10 Apr 2024 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHsnJaP6"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1932717BB0A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769723; cv=none; b=DAYftBd6BST1MZlz81bxR8Ax+zTa1EIi5pliP6OQvbEGJcTV8d1viqeVeCJUUAYf2XiRIMsx9BK0ITNdtH4UrB/Rdo43XxZ1fbRsefJIoWmOwnabBSw6/mR/1R5aFC9mgEmqMqnWd1CboG9U4GXmCs9UC+BsZT+vASBYEqvMRYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769723; c=relaxed/simple;
	bh=BxNgph8RWHdE1mK1PBQYW6dYWfJbthYaWeMXsEnbzEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VeH8ekkXk5BE8lNN8jhTTTe2H7Dmzgen02CKAjvssZdkKtYYNAvRo8A2unsbAGc2LNVd8kVUfTBeE+SNcTSgGDsMViPdmEFEl9tUjRQIWi5DZQKWjLOuVbrvm7U329XX/XprgQ4whZZqK6cO22P31l/PhMHI+HkctFMyaJCfqYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SHsnJaP6; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-479c39b78dbso2829394137.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712769720; x=1713374520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hclFsSQIEHjUwmV99crg51mMPciXyr3SfzXCYeO/DPE=;
        b=SHsnJaP66lqS9JkizhTYtsu3S6Xy1lT8L3ecexFBN393TXkgwSV6z5fJTz1bV0O75w
         t2Oa8/jYNDmGZWhAbH3erjRtab/5dOM97iuMk8lWxtrcWh7Ab7GOg4Gkh3w6c60Sykvq
         e9aXegbOCwmQwfHw6LJOhkoXanYazwM7n+UGg1PK0bd7R2v0R2a7/0kAD4UOBx2lPfdZ
         8aLO9+EbJgZsljthZQtZ6sd787WQUtKJkLTtv+Wdchvksmr8B1DFYdVkVpzNiT/7e+Wm
         nqqHGVNfE+KtXQWpHx3MPr6zVvKIvkuadeZ4hMgzUkuGvAUYdoYcs0IlC/RgqkOtX2LG
         5l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712769720; x=1713374520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hclFsSQIEHjUwmV99crg51mMPciXyr3SfzXCYeO/DPE=;
        b=XeiY6Rrk5d/ydo3+fv1dFyDlloLR+9X9czDlKXTMO/yb7IOp7dgujGtZI2ULUgula0
         DdQOR/VURVKVkY4A1R8nrvQfU5rMsHrEGcL6ZHMmkaAMKlnVsLHCt/pw1DDr+1zpPt6T
         ClTAbqC5dd0O0gVpDEvygDTgqSoQEabvbk6vNstdU4deSzWB6ZEOr3Jg+W/X8yyGIe66
         4Udo6nIvdw5WqIIns9kbV3j68L2/Xg0K1lKQPkqLLhBuZ+nZ0qJ/NotVytlxgaDPIavS
         8IpY1Jgzz7M4LpmDd+BcvVHuOlk/blWuiHx8WRPfFp1+wuInRWuoue1/gEOOENIjebPq
         Q1jA==
X-Forwarded-Encrypted: i=1; AJvYcCWl/BaHKJVXr2+VFabbG7s73Ao7QnOrxI/2C41KTEbYzTRpxw1TtxLlMjN/4nqOvi/TeszbQV6VZc7+YeaMwO04Rd3VlnytX7LeBil5
X-Gm-Message-State: AOJu0YwPfLFTIGgEUKBM7bsZ0BQjJIq2e2eg80pb4RdR5Y/Kr9oqXCgD
	GHTCeK8iFuR5aDO/a7hRhymLwO9QhzCgBqAtyJt3KnEQD1J6LfoNLyTk+F5nBdfcwbzMkZRd3KT
	+/1oPLeKoJor7Uln6UccWF5vMwQ/66KCUGlIj1Q==
X-Google-Smtp-Source: AGHT+IHahCFe/opQQPfDyrdTRR3sFC4LRbnDLPlzwCjh2uwdYsu1msEEmkEhYYZ/2UmyYbPBWfTH5v2FccDGXe9wjZw=
X-Received: by 2002:a05:6102:950:b0:47a:3008:b210 with SMTP id
 a16-20020a056102095000b0047a3008b210mr965275vsi.22.1712769718743; Wed, 10 Apr
 2024 10:21:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410102710.35911-1-naresh.kamboju@linaro.org>
 <20240410152307.GA25111@willie-the-truck> <CA+G9fYv2szPTjixaM-QT_cfZWwGSx1Huk2pUtUWP-A9PTMTLOQ@mail.gmail.com>
In-Reply-To: <CA+G9fYv2szPTjixaM-QT_cfZWwGSx1Huk2pUtUWP-A9PTMTLOQ@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 10 Apr 2024 22:51:46 +0530
Message-ID: <CA+G9fYuNW82jZWyqhWSym8aaZrdyJr8CNuWPaupeb-enjF9zHg@mail.gmail.com>
Subject: Re: BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq next-20240410
To: Will Deacon <will@kernel.org>
Cc: mic@digikod.net, keescook@chromium.org, davidgow@google.com, 
	rmoar@google.com, lkft-triage@lists.linaro.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	longman@redhat.com, boqun.feng@gmail.com, anders.roxell@linaro.org, 
	dan.carpenter@linaro.org, arnd@arndb.de, linux@roeck-us.net, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: multipart/mixed; boundary="000000000000ab37d10615c146c9"

--000000000000ab37d10615c146c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Apr 2024 at 22:44, Naresh Kamboju <naresh.kamboju@linaro.org> wr=
ote:
>
> On Wed, 10 Apr 2024 at 20:53, Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, Apr 10, 2024 at 03:57:10PM +0530, Naresh Kamboju wrote:
> > > Following kernel crash noticed on Linux next-20240410 tag while runni=
ng
> > > kunit testing on qemu-arm64 and qemu-x86_64.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > Crash log on qemu-arm64:
> > > ----------------
> > > <3>[ 30.465716] BUG: KASAN: null-ptr-deref in _raw_spin_lock_irq (inc=
lude/linux/instrumented.h:96 include/linux/atomic/atomic-instrumented.h:130=
1 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/=
linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170)
>
> > It's a shame that you have trimmed the register dump here.
>
> My apologies for that, the detailed crash log is attached and
> the links provided in the tail of this email.
>
> >
> > > <4>[   30.511022] Call trace:
> > > <4>[ 30.511437] _raw_spin_lock_irq (arch/arm64/include/asm/atomic_lse=
h:271 arch/arm64/include/asm/cmpxchg.h:120 arch/arm64/include/asm/cmpxchg.=
h:169 include/linux/atomic/atomic-arch-fallback.h:2055 include/linux/atomic=
/atomic-arch-fallback.h:2173 include/linux/atomic/atomic-instrumented.h:130=
2 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/=
linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170)
> > > <4>[ 30.512013] wait_for_completion_timeout (kernel/sched/completion.=
c:84 kernel/sched/completion.c:116 kernel/sched/completion.c:127 kernel/sch=
ed/completion.c:167)
> > > <4>[ 30.512627] kunit_try_catch_run (lib/kunit/try-catch.c:86)
> > > <4>[ 30.513188] kunit_run_case_catch_errors (lib/kunit/test.c:544)
> > > <4>[ 30.513801] kunit_run_tests (lib/kunit/test.c:635)
> >
> > Ok, so 'task_struct->vfork_done' is NULL. Looks like this code was adde=
d
> > recently, so adding Micka=C3=ABl to cc.
> >
> > Will

The decode stack trace dump file for arm64 has been attached.

 - Naresh

--000000000000ab37d10615c146c9
Content-Type: text/plain; charset="US-ASCII"; name="output-kasan-kunit-kernel-crash.txt"
Content-Disposition: attachment; 
	filename="output-kasan-kunit-kernel-crash.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_luu2srol0>
X-Attachment-Id: f_luu2srol0

PDM+WyAzMC40NjU3MTZdIEJVRzogS0FTQU46IG51bGwtcHRyLWRlcmVmIGluIF9yYXdfc3Bpbl9s
b2NrX2lycSAoaW5jbHVkZS9saW51eC9pbnN0cnVtZW50ZWQuaDo5NiBpbmNsdWRlL2xpbnV4L2F0
b21pYy9hdG9taWMtaW5zdHJ1bWVudGVkLmg6MTMwMSBpbmNsdWRlL2FzbS1nZW5lcmljL3FzcGlu
bG9jay5oOjExMSBpbmNsdWRlL2xpbnV4L3NwaW5sb2NrLmg6MTg3IGluY2x1ZGUvbGludXgvc3Bp
bmxvY2tfYXBpX3NtcC5oOjEyMCBrZXJuZWwvbG9ja2luZy9zcGlubG9jay5jOjE3MCkgCjwzPlsg
ICAzMC40NjcwOTddIFdyaXRlIG9mIHNpemUgNCBhdCBhZGRyIDAwMDAwMDAwMDAwMDAwMDggYnkg
dGFzayBzd2FwcGVyLzAvMQo8Mz5bICAgMzAuNDY4MDU5XQo8Mz5bICAgMzAuNDY4MzkzXSBDUFU6
IDAgUElEOiAxIENvbW06IHN3YXBwZXIvMCBUYWludGVkOiBHICAgIEIgICAgICAgICAgICBOIDYu
OS4wLXJjMy1uZXh0LTIwMjQwNDEwICMxCjwzPlsgICAzMC40NjkyMDldIEhhcmR3YXJlIG5hbWU6
IGxpbnV4LGR1bW15LXZpcnQgKERUKQo8Mz5bICAgMzAuNDY5NjQ1XSBDYWxsIHRyYWNlOgo8Mz5b
IDMwLjQ2OTkxOV0gZHVtcF9iYWNrdHJhY2UgKGFyY2gvYXJtNjQva2VybmVsL3N0YWNrdHJhY2Uu
YzozMTkpIAo8Mz5bIDMwLjQ3MTYyMl0gc2hvd19zdGFjayAoYXJjaC9hcm02NC9rZXJuZWwvc3Rh
Y2t0cmFjZS5jOjMyNikgCjwzPlsgMzAuNDcyMTI0XSBkdW1wX3N0YWNrX2x2bCAobGliL2R1bXBf
c3RhY2suYzoxMTcpIAo8Mz5bIDMwLjQ3Mjk0N10gcHJpbnRfcmVwb3J0IChtbS9rYXNhbi9yZXBv
cnQuYzo0OTMpIAo8Mz5bIDMwLjQ3Mzc1NV0ga2FzYW5fcmVwb3J0IChtbS9rYXNhbi9yZXBvcnQu
Yzo2MDMpIAo8Mz5bIDMwLjQ3NDUyNF0ga2FzYW5fY2hlY2tfcmFuZ2UgKG1tL2thc2FuL2dlbmVy
aWMuYzoxNzUgbW0va2FzYW4vZ2VuZXJpYy5jOjE4OSkgCjwzPlsgMzAuNDc1MDk0XSBfX2thc2Fu
X2NoZWNrX3dyaXRlIChtbS9rYXNhbi9zaGFkb3cuYzozOCkgCjwzPlsgMzAuNDc1NjgzXSBfcmF3
X3NwaW5fbG9ja19pcnEgKGluY2x1ZGUvbGludXgvaW5zdHJ1bWVudGVkLmg6OTYgaW5jbHVkZS9s
aW51eC9hdG9taWMvYXRvbWljLWluc3RydW1lbnRlZC5oOjEzMDEgaW5jbHVkZS9hc20tZ2VuZXJp
Yy9xc3BpbmxvY2suaDoxMTEgaW5jbHVkZS9saW51eC9zcGlubG9jay5oOjE4NyBpbmNsdWRlL2xp
bnV4L3NwaW5sb2NrX2FwaV9zbXAuaDoxMjAga2VybmVsL2xvY2tpbmcvc3BpbmxvY2suYzoxNzAp
IAo8Mz5bIDMwLjQ3NjI1N10gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0IChrZXJuZWwvc2No
ZWQvY29tcGxldGlvbi5jOjg0IGtlcm5lbC9zY2hlZC9jb21wbGV0aW9uLmM6MTE2IGtlcm5lbC9z
Y2hlZC9jb21wbGV0aW9uLmM6MTI3IGtlcm5lbC9zY2hlZC9jb21wbGV0aW9uLmM6MTY3KSAKPDM+
WyAzMC40NzY5MDldIGt1bml0X3RyeV9jYXRjaF9ydW4gKGxpYi9rdW5pdC90cnktY2F0Y2guYzo4
NikgCjwzPlsgMzAuNDc3NjI4XSBrdW5pdF9ydW5fY2FzZV9jYXRjaF9lcnJvcnMgKGxpYi9rdW5p
dC90ZXN0LmM6NTQ0KSAKPDM+WyAzMC40NzgzMTFdIGt1bml0X3J1bl90ZXN0cyAobGliL2t1bml0
L3Rlc3QuYzo2MzUpIAo8Mz5bIDMwLjQ3ODg2NV0gX19rdW5pdF90ZXN0X3N1aXRlc19pbml0IChs
aWIva3VuaXQvdGVzdC5jOjcyOSAoZGlzY3JpbWluYXRvciAxKSkgCjwzPlsgMzAuNDc5NDgyXSBr
dW5pdF9ydW5fYWxsX3Rlc3RzIChsaWIva3VuaXQvZXhlY3V0b3IuYzoyNzYgbGliL2t1bml0L2V4
ZWN1dG9yLmM6MzkyKSAKPDM+WyAzMC40ODAwNzldIGtlcm5lbF9pbml0X2ZyZWVhYmxlIChpbml0
L21haW4uYzoxNTc4KSAKPDM+WyAzMC40ODA3NDddIGtlcm5lbF9pbml0IChpbml0L21haW4uYzox
NDY1KSAKPDM+WyAzMC40ODE0NzRdIHJldF9mcm9tX2ZvcmsgKGFyY2gvYXJtNjQva2VybmVsL2Vu
dHJ5LlM6ODYxKSAKPDM+WyAgIDMwLjQ4MjA4MF0gPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CjwxPlsgICAzMC40ODQ1MDNd
IFVuYWJsZSB0byBoYW5kbGUga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0
dWFsIGFkZHJlc3MgMDAwMDAwMDAwMDAwMDAwOAo8MT5bICAgMzAuNDg1MzY5XSBNZW0gYWJvcnQg
aW5mbzoKPDE+WyAgIDMwLjQ4NTkyM10gICBFU1IgPSAweDAwMDAwMDAwOTYwMDAwNmIKPDE+WyAg
IDMwLjQ4Njk0M10gICBFQyA9IDB4MjU6IERBQlQgKGN1cnJlbnQgRUwpLCBJTCA9IDMyIGJpdHMK
PDE+WyAgIDMwLjQ4NzU0MF0gICBTRVQgPSAwLCBGblYgPSAwCjwxPlsgICAzMC40ODgwMDddICAg
RUEgPSAwLCBTMVBUVyA9IDAKPDE+WyAgIDMwLjQ4ODUwOV0gICBGU0MgPSAweDJiOiBsZXZlbCAt
MSB0cmFuc2xhdGlvbiBmYXVsdAo8MT5bICAgMzAuNDg5MTUwXSBEYXRhIGFib3J0IGluZm86Cjwx
PlsgICAzMC40ODk2MTBdICAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDA2YiwgSVNTMiA9IDB4MDAw
MDAwMDAKPDE+WyAgIDMwLjQ5MDM2MF0gICBDTSA9IDAsIFduUiA9IDEsIFRuRCA9IDAsIFRhZ0Fj
Y2VzcyA9IDAKPDE+WyAgIDMwLjQ5MTA1N10gICBHQ1MgPSAwLCBPdmVybGF5ID0gMCwgRGlydHlC
aXQgPSAwLCBYcyA9IDAKPDE+WyAgIDMwLjQ5MTgyMl0gWzAwMDAwMDAwMDAwMDAwMDhdIHVzZXIg
YWRkcmVzcyBidXQgYWN0aXZlX21tIGlzIHN3YXBwZXIKPDA+WyAgIDMwLjQ5MzAwOF0gSW50ZXJu
YWwgZXJyb3I6IE9vcHM6IDAwMDAwMDAwOTYwMDAwNmIgWyMxXSBQUkVFTVBUIFNNUAo8ND5bICAg
MzAuNDk0MTA1XSBNb2R1bGVzIGxpbmtlZCBpbjoKPDQ+WyAgIDMwLjQ5NjI0NF0gQ1BVOiAwIFBJ
RDogMSBDb21tOiBzd2FwcGVyLzAgVGFpbnRlZDogRyAgICBCICAgICAgICAgICAgTiA2LjkuMC1y
YzMtbmV4dC0yMDI0MDQxMCAjMQo8ND5bICAgMzAuNDk3MTcxXSBIYXJkd2FyZSBuYW1lOiBsaW51
eCxkdW1teS12aXJ0IChEVCkKPDQ+WyAgIDMwLjQ5NzkwNV0gcHN0YXRlOiAyMjQwMDBjOSAobnpD
diBkYUlGICtQQU4gLVVBTyArVENPIC1ESVQgLVNTQlMgQlRZUEU9LS0pCjw0PlsgMzAuNDk4ODk1
XSBwYyA6IF9yYXdfc3Bpbl9sb2NrX2lycSAoYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9hdG9taWNf
bHNlLmg6MjcxIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vY21weGNoZy5oOjEyMCBhcmNoL2FybTY0
L2luY2x1ZGUvYXNtL2NtcHhjaGcuaDoxNjkgaW5jbHVkZS9saW51eC9hdG9taWMvYXRvbWljLWFy
Y2gtZmFsbGJhY2suaDoyMDU1IGluY2x1ZGUvbGludXgvYXRvbWljL2F0b21pYy1hcmNoLWZhbGxi
YWNrLmg6MjE3MyBpbmNsdWRlL2xpbnV4L2F0b21pYy9hdG9taWMtaW5zdHJ1bWVudGVkLmg6MTMw
MiBpbmNsdWRlL2FzbS1nZW5lcmljL3FzcGlubG9jay5oOjExMSBpbmNsdWRlL2xpbnV4L3NwaW5s
b2NrLmg6MTg3IGluY2x1ZGUvbGludXgvc3BpbmxvY2tfYXBpX3NtcC5oOjEyMCBrZXJuZWwvbG9j
a2luZy9zcGlubG9jay5jOjE3MCkgCjw0PlsgMzAuNDk5NTQyXSBsciA6IF9yYXdfc3Bpbl9sb2Nr
X2lycSAoaW5jbHVkZS9saW51eC9hdG9taWMvYXRvbWljLWFyY2gtZmFsbGJhY2suaDoyMTcyIChk
aXNjcmltaW5hdG9yIDEpIGluY2x1ZGUvbGludXgvYXRvbWljL2F0b21pYy1pbnN0cnVtZW50ZWQu
aDoxMzAyIChkaXNjcmltaW5hdG9yIDEpIGluY2x1ZGUvYXNtLWdlbmVyaWMvcXNwaW5sb2NrLmg6
MTExIChkaXNjcmltaW5hdG9yIDEpIGluY2x1ZGUvbGludXgvc3BpbmxvY2suaDoxODcgKGRpc2Ny
aW1pbmF0b3IgMSkgaW5jbHVkZS9saW51eC9zcGlubG9ja19hcGlfc21wLmg6MTIwIChkaXNjcmlt
aW5hdG9yIDEpIGtlcm5lbC9sb2NraW5nL3NwaW5sb2NrLmM6MTcwIChkaXNjcmltaW5hdG9yIDEp
KSAKPDQ+WyAgIDMwLjUwMDE2Ml0gc3AgOiBmZmZmODAwMDgwMDg3NjEwCjw0PlsgICAzMC41MDA2
ODNdIHgyOTogZmZmZjgwMDA4MDA4NzY3MCB4Mjg6IDFmZmZmMDAwMTAwMTBmNDMgeDI3OiBmZmZm
ODAwMDgwMDg3YTEwCjw0PlsgICAzMC41MDE5MTVdIHgyNjogMWZmZmYwMDAxMDAxMGY0NSB4MjU6
IGZmZjAwMDAwYzYzYjE0NjggeDI0OiAxZmZmZjAwMDEwMDEwZjQyCjw0PlsgICAzMC41MDM1ODJd
IHgyMzogMDAwMDAwMDAwMDAwMDAwMCB4MjI6IGRmZmY4MDAwMDAwMDAwMDAgeDIxOiBmZmZmODAw
MDgwMDg3NjMwCjw0PlsgICAzMC41MDQ1MDFdIHgyMDogMWZmZmYwMDAxMDAxMGVjMiB4MTk6IDAw
MDAwMDAwMDAwMDAwMDggeDE4OiAwMDAwMDAwMDVhMjY4YzNiCjw0PlsgICAzMC41MDU0MjBdIHgx
NzogM2QzZDNkM2QzZDNkM2QzZCB4MTY6IDNkM2QzZDNkM2QzZDNkM2QgeDE1OiAzZDNkM2QzZDNk
M2QzZDNkCjw0PlsgICAzMC41MDY0NTVdIHgxNDogM2QzZDNkM2QzZDNkM2QzZCB4MTM6IDIwNWQz
MDM4MzAzMjM4MzQgeDEyOiBmZmZmNzAwMDEwMDEwZWM3Cjw0PlsgICAzMC41MDcyMjddIHgxMTog
MWZmZmYwMDAxMDAxMGVjNiB4MTA6IGZmZmY3MDAwMTAwMTBlYzYgeDkgOiBkZmZmODAwMDAwMDAw
MDAwCjw0PlsgICAzMC41MDgyNTBdIHg4IDogMDAwMDAwMDAwMDAwMDAwMyB4NyA6IDAwMDAwMDAw
MDAwMDAwMDEgeDYgOiBmZmZmNzAwMDEwMDEwZWM2Cjw0PlsgICAzMC41MDkxNTRdIHg1IDogZmZm
ZjgwMDA4MDA4NzYzMCB4NCA6IGZmZmY3MDAwMTAwMTBlYzYgeDMgOiBmZmZmYTUxNTEwYjA1MmI4
Cjw0PlsgICAzMC41MTAyMDRdIHgyIDogMDAwMDAwMDAwMDAwMDAwMSB4MSA6IDAwMDAwMDAwMDAw
MDAwMDAgeDAgOiAwMDAwMDAwMDAwMDAwMDAwCjw0PlsgICAzMC41MTEwMjJdIENhbGwgdHJhY2U6
Cjw0PlsgMzAuNTExNDM3XSBfcmF3X3NwaW5fbG9ja19pcnEgKGFyY2gvYXJtNjQvaW5jbHVkZS9h
c20vYXRvbWljX2xzZS5oOjI3MSBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL2NtcHhjaGcuaDoxMjAg
YXJjaC9hcm02NC9pbmNsdWRlL2FzbS9jbXB4Y2hnLmg6MTY5IGluY2x1ZGUvbGludXgvYXRvbWlj
L2F0b21pYy1hcmNoLWZhbGxiYWNrLmg6MjA1NSBpbmNsdWRlL2xpbnV4L2F0b21pYy9hdG9taWMt
YXJjaC1mYWxsYmFjay5oOjIxNzMgaW5jbHVkZS9saW51eC9hdG9taWMvYXRvbWljLWluc3RydW1l
bnRlZC5oOjEzMDIgaW5jbHVkZS9hc20tZ2VuZXJpYy9xc3BpbmxvY2suaDoxMTEgaW5jbHVkZS9s
aW51eC9zcGlubG9jay5oOjE4NyBpbmNsdWRlL2xpbnV4L3NwaW5sb2NrX2FwaV9zbXAuaDoxMjAg
a2VybmVsL2xvY2tpbmcvc3BpbmxvY2suYzoxNzApIAo8ND5bIDMwLjUxMjAxM10gd2FpdF9mb3Jf
Y29tcGxldGlvbl90aW1lb3V0IChrZXJuZWwvc2NoZWQvY29tcGxldGlvbi5jOjg0IGtlcm5lbC9z
Y2hlZC9jb21wbGV0aW9uLmM6MTE2IGtlcm5lbC9zY2hlZC9jb21wbGV0aW9uLmM6MTI3IGtlcm5l
bC9zY2hlZC9jb21wbGV0aW9uLmM6MTY3KSAKPDQ+WyAzMC41MTI2MjddIGt1bml0X3RyeV9jYXRj
aF9ydW4gKGxpYi9rdW5pdC90cnktY2F0Y2guYzo4NikgCjw0PlsgMzAuNTEzMTg4XSBrdW5pdF9y
dW5fY2FzZV9jYXRjaF9lcnJvcnMgKGxpYi9rdW5pdC90ZXN0LmM6NTQ0KSAKPDQ+WyAzMC41MTM4
MDFdIGt1bml0X3J1bl90ZXN0cyAobGliL2t1bml0L3Rlc3QuYzo2MzUpIAo8ND5bIDMwLjUxNDY3
NF0gX19rdW5pdF90ZXN0X3N1aXRlc19pbml0IChsaWIva3VuaXQvdGVzdC5jOjcyOSAoZGlzY3Jp
bWluYXRvciAxKSkgCjw0PlsgMzAuNTE1MjU5XSBrdW5pdF9ydW5fYWxsX3Rlc3RzIChsaWIva3Vu
aXQvZXhlY3V0b3IuYzoyNzYgbGliL2t1bml0L2V4ZWN1dG9yLmM6MzkyKSAKPDQ+WyAzMC41MTU4
MzFdIGtlcm5lbF9pbml0X2ZyZWVhYmxlIChpbml0L21haW4uYzoxNTc4KSAKPDQ+WyAzMC41MTYz
ODRdIGtlcm5lbF9pbml0IChpbml0L21haW4uYzoxNDY1KSAKPDQ+WyAzMC41MTY5MDBdIHJldF9m
cm9tX2ZvcmsgKGFyY2gvYXJtNjQva2VybmVsL2VudHJ5LlM6ODYxKSAKPDA+WyAzMC41MTgxNTFd
IENvZGU6IDkzNDA3YzAyIGQ1MDMyMDFmIDJhMDAwM2UxIDUyODAwMDIyICg4OGUxN2U2MikKQWxs
IGNvZGUKPT09PT09PT0KICAgMDoJOTM0MDdjMDIgCXN4dHcJeDIsIHcwCiAgIDQ6CWQ1MDMyMDFm
IAlub3AKICAgODoJMmEwMDAzZTEgCW1vdgl3MSwgdzAKICAgYzoJNTI4MDAwMjIgCW1vdgl3Miwg
IzB4MSAgICAgICAgICAgICAgICAgICAJLy8gIzEKICAxMDoqCTg4ZTE3ZTYyIAljYXNhCXcxLCB3
MiwgW3gxOV0JCTwtLSB0cmFwcGluZyBpbnN0cnVjdGlvbgoKQ29kZSBzdGFydGluZyB3aXRoIHRo
ZSBmYXVsdGluZyBpbnN0cnVjdGlvbgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09CiAgIDA6CTg4ZTE3ZTYyIAljYXNhCXcxLCB3MiwgW3gxOV0KPDQ+WyAgIDMwLjUx
OTUwMV0gLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tCjw2PlsgICAzMC41MjAz
MTddIG5vdGU6IHN3YXBwZXIvMFsxXSBleGl0ZWQgd2l0aCBpcnFzIGRpc2FibGVkCjw2PlsgICAz
MC41MjEzNTVdIG5vdGU6IHN3YXBwZXIvMFsxXSBleGl0ZWQgd2l0aCBwcmVlbXB0X2NvdW50IDEK
PDA+WyAgIDMwLjUyMzEyOV0gS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IEF0dGVtcHRlZCB0
byBraWxsIGluaXQhIGV4aXRjb2RlPTB4MDAwMDAwMGIKPDI+WyAgIDMwLjUyNDM5N10gU01QOiBz
dG9wcGluZyBzZWNvbmRhcnkgQ1BVcwo8MD5bICAgMzAuNTI1NTUzXSBLZXJuZWwgT2Zmc2V0OiAw
eDI1MTQ4ZDQwMDAwMCBmcm9tIDB4ZmZmZjgwMDA4MDAwMDAwMAo8MD5bICAgMzAuNTI4MzQxXSBQ
SFlTX09GRlNFVDogMHg0MDAwMDAwMAo8MD5bICAgMzAuNTI5MDAzXSBDUFUgZmVhdHVyZXM6IDB4
MCwwMDAwMDAwNiw4ZjE3YmQ3Yyw2NzY2NzczZgo8MD5bICAgMzAuNTMwMzEzXSBNZW1vcnkgTGlt
aXQ6IG5vbmUKPDA+WyAgIDMwLjUzMTMxOV0gLS0tWyBlbmQgS2VybmVsIHBhbmljIC0gbm90IHN5
bmNpbmc6IEF0dGVtcHRlZCB0byBraWxsIGluaXQhIGV4aXRjb2RlPTB4MDAwMDAwMGIgXS0tLQo=
--000000000000ab37d10615c146c9--

