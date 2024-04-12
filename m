Return-Path: <linux-kernel+bounces-143000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 096498A3311
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628FFB25B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AC4149011;
	Fri, 12 Apr 2024 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xv8SKoQu"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130671487F6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937716; cv=none; b=hjwYqLLTyLWg4qBWTNa1vbcUJMgWRwm7/GPoIZKGJDy2ovlYU/ZhSG0rm82ivi/SMcJLL5SJOIiOsL7HKJInD5ehHi8zZj+yvunoITotTVC0GiNsztIp20Ug63mPn8tgt8HTu8wyOCDV2DiYZzToXXiyVCGT17juuLNRAyQKRIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937716; c=relaxed/simple;
	bh=29mMxzABJNu2s6sXXHWuTqJmU9ZiVLQYln8kPDantDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Txli5SCUlZn7M8C9kdVB1Ns4h6kCrYC+ruc3rCW0yPcLuUZkZcXnYIXajwiGDhI0EBAQsAZ7MbFqK1PAOztpptczwoJBODhq9ObYHx/9fAkD1H9MLnihgIG0iz89T0xi/VAJvJqvz2oL0T+aBbInIF5OYfR3cymgg4YJJlvxOSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xv8SKoQu; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a6f2c7c1b8so775738a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 09:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712937714; x=1713542514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zE2NMeREY9M0RzVWCwQFXSSfNx2GjxIaqj3+nSSE88=;
        b=Xv8SKoQuY/mTjeQyYKDLH/lyGjpzQM1s2vyQFMUcc9Fgk7LIEVxFZmCc2GHJNro/1Y
         z3iwG2NxaEFVdgEZVwgphJTR+zPnu5F+kIdv87w4XZwpEDp/XPMWanc0d+yT2hFQxzGZ
         eXQmkVHJGvcIikUyLSfpnxewE1WXsuFf+ILmjaEM8iCtSFppU+ZD9Sx3zEtTk4RrKDdm
         Nq5FQp0Qk3sQ72qD6f6llk1A3Av2t1qht/PDS9W6FGiGdGdRTvgP8MazmUYeRSb05Nzr
         V7hNr3Th1junatKzNhdmg9bsdcL2i3gvWjfBE+UAb/P5+5Z3fiziiXwpJcbwVP7VgO5g
         UaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712937714; x=1713542514;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7zE2NMeREY9M0RzVWCwQFXSSfNx2GjxIaqj3+nSSE88=;
        b=LRMt8Dl7xOyuFlm4mrrBiqmkb8heVuDsktdbh6uMRLdq12EDpnNq9pqeqjhkJqCwAb
         GbEG3fqeEoMtdQUz5csnSZy9GL6PTJcM64db+372ko6z2wTc6guhGiqIRmx1Ljjyh13R
         l0l01XMmAWx5TzDBTZFOGwAsIBXE0qTGDAtZxVGfuv52psFGp0CHrEubnVp0ixacD4WF
         LpLQVjGE27BRfIguOOY2AXkjH/2DhK1DJnGb9KLtZ4p5E4Mb+MAb/1W/pfeFCzOFyHel
         mT91gPafZ2bb2uTvZQ91AZW4rAAztRawwcK6iy8WoGPiMPQGk6wscR3m2OOpmmbsEgr5
         TeyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhtnw5PQl9GM+AHPdIiMGlRPSlZfQZt5G4Kox8AYKf4kJuDkszWc8X3vYxKRvVFuzn/hXv8xxc36SDfxMmUhJv4BcipojU+D+eONM1
X-Gm-Message-State: AOJu0YwfKslQ9zWFM/3C28fOWdsvVvjxIfeHMqXXjkXZH/pAm2LXLAkB
	Y2Qguxot72WfyX5d6Qw+cmPPmFDaVQtEWMYJE7+eCinopSZ1He4Emv0woKfw/D7oEWH+ewLMaOe
	O9Q==
X-Google-Smtp-Source: AGHT+IFKD4Hv8wNoDvr4Y5aQffHL1eNGOeIZjolKkjhO23bzQ9t+IKJIElrdebVXil7KaicTN70CogUiCbU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:66cf:b0:2a5:227f:dd7c with SMTP id
 z15-20020a17090a66cf00b002a5227fdd7cmr8569pjl.1.1712937714332; Fri, 12 Apr
 2024 09:01:54 -0700 (PDT)
Date: Fri, 12 Apr 2024 09:01:52 -0700
In-Reply-To: <CALMp9eR6-7va0XUbEYFNVtGdEzmWbAr9pXhLgSL=f9dJyAso7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <20240126085444.324918-19-xiong.y.zhang@linux.intel.com> <ZhhUyk2uAXqG7GEd@google.com>
 <CALMp9eR6-7va0XUbEYFNVtGdEzmWbAr9pXhLgSL=f9dJyAso7Q@mail.gmail.com>
Message-ID: <Zhla8NGvQgzhkclx@google.com>
Subject: Re: [RFC PATCH 18/41] KVM: x86/pmu: Intercept full-width GP counter
 MSRs by checking with perf capabilities
From: Sean Christopherson <seanjc@google.com>
To: Jim Mattson <jmattson@google.com>
Cc: Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, 
	peterz@infradead.org, mizhang@google.com, kan.liang@intel.com, 
	zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhiyuan.lv@intel.com, eranian@google.com, irogers@google.com, 
	samantha.alt@intel.com, like.xu.linux@gmail.com, chao.gao@intel.com, 
	Xiong Zhang <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024, Jim Mattson wrote:
> On Thu, Apr 11, 2024 at 2:23=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Fri, Jan 26, 2024, Xiong Zhang wrote:
> > > From: Mingwei Zhang <mizhang@google.com>
> > >
> > > Intercept full-width GP counter MSRs in passthrough PMU if guest does=
 not
> > > have the capability to write in full-width. In addition, opportunisti=
cally
> > > add a warning if non-full-width counter MSRs are also intercepted, in=
 which
> > > case it is a clear mistake.
> > >
> > > Co-developed-by: Xiong Zhang <xiong.y.zhang@intel.com>
> > > Signed-off-by: Xiong Zhang <xiong.y.zhang@intel.com>
> > > Signed-off-by: Mingwei Zhang <mizhang@google.com>
> > > ---
> > >  arch/x86/kvm/vmx/pmu_intel.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_inte=
l.c
> > > index 7f6cabb2c378..49df154fbb5b 100644
> > > --- a/arch/x86/kvm/vmx/pmu_intel.c
> > > +++ b/arch/x86/kvm/vmx/pmu_intel.c
> > > @@ -429,6 +429,13 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vc=
pu, struct msr_data *msr_info)
> > >       default:
> > >               if ((pmc =3D get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) |=
|
> > >                   (pmc =3D get_gp_pmc(pmu, msr, MSR_IA32_PMC0))) {
> > > +                     if (is_passthrough_pmu_enabled(vcpu) &&
> > > +                         !(msr & MSR_PMC_FULL_WIDTH_BIT) &&
> > > +                         !msr_info->host_initiated) {
> > > +                             pr_warn_once("passthrough PMU never int=
ercepts non-full-width PMU counters\n");
> > > +                             return 1;
> >
> > This is broken, KVM must be prepared to handle WRMSR (and RDMSR and RDP=
MC) that
> > come in through the emulator.
>=20
> Don't tell me that we are still supporting CPUs that don't have
> "unrestricted guest"! Sigh.

Heh, KVM still supports CPUs without VMX virtual NMIs :-)

Practically speaking, if we want to eliminate things like emulated WRMSR/RD=
MSR,
a Kconfig to build a reduced emulator would be the way to go.  But while a =
reduced
emulator would be nice for host security, I don't think it would buy us muc=
h from
a code perspective, since KVM still needs to handle host userspace MSR acce=
sses.

E.g. KVM could have conditional sanity checks for MSRs that are supposed to=
 be
passed through, but unless a reduced emulator is a hard requirement for pas=
sthrough
PMUs, we'd still need the code to handle the emulated accesses.  And even i=
f a
reduced emulator were a hard requirement, I'd still push for a WARN-and-con=
tinue
approach, not a "inject a bogus #GP because KVM screwed up" approach.

