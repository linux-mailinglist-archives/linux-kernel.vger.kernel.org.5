Return-Path: <linux-kernel+bounces-141700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7AD8A221C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05991F23A95
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1200C47A76;
	Thu, 11 Apr 2024 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="OFX64rYP"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93A481D0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876947; cv=none; b=APuCBMoYPi45Sj5pHm/OhgaodJrqEs/ZECacbWeFHwxeQGDRFuyk2q+yov/Wrtap0h7G1wnIm4E+fJyaVJ5H2sPefci3CX+kYO1TIRz4j+xLsspvsgZJxFr5DeHPHCBX3gxYZzbzthzv58996a0fbMBoc7Jjt3MYuH/M603CqFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876947; c=relaxed/simple;
	bh=QWxPbywU79EbshCBlfa1l4nYQ1WLinyIfiyU/gvdwg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWcchSp3Jvc6vjGQ0ugppURsiL21lBeack8HD+KyXbIiMq7zvSkCB7n5JhwcOhQ6AXgMHbFIMhBKYehiWuNflqq4SeiTVCMPyCL37wWXW9trR7KyGSNyZlxNJziyFOqoA31h3AYajWe2TbJmkox2qivFqXSeUn4KU2w/WBkOSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFX64rYP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so2378a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712876944; x=1713481744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRt0Ft5K85BJFAwKY/YyFYZFShSHCAWggantBcv7H3Q=;
        b=OFX64rYPf0vwhnxPW/bkravmCuvhBR3+jaND6v6Qgzj8qj8QaLX07TILDCmK/F015h
         295Ipoa7N9o9RqdO1Qsmlpa+96yL43ALLt9qnSgltYRBI/fPdWAXnufqtvSkER4/atqX
         6+9E0lUwGsp7lyWdcZz8Vmu99eJFGb02gsYoUutF4u+9hzu9YGn+NtNVKjN07uYCopuX
         sakrkogzTh5NXBtpIBlxNBJsisRE0SlQs6s+xET8Y3z7ZmTE5jkPVKduhl/vciK60k39
         35gSsV7S4mmDKgDNBMauis58YhyBKZOXeYfGpRNvmzsrDJbL+QImSBrz1sHeNVZ4su+n
         ogyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712876944; x=1713481744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRt0Ft5K85BJFAwKY/YyFYZFShSHCAWggantBcv7H3Q=;
        b=AOB4eTb7VYIkT8E3q+VO4kwZHeswK2l6GbjuO8+NLhUkErzUHT7qJmXFkwHTQyFj6i
         t6rGQyq7aOsR9OJ/qfQ73Z/0upw2rVnRrG/da6zgC0P+FwH/x3vkdCxhM50PohGgnsuQ
         iwTYhc+1KVCt8njraNX5VK7qzGcX9ZawNOOf7hYuHGyU/Pm/kmRpy421tAp7BiyCMwFm
         RQ9YKxY7a6YL+kP5XZ8CttG+OxwtQJ/6iiZIYradtdEbdNm67ht8L8Ng/XWGGNXebfWs
         y/pwHr14M7uXk/eEzFu564YO9nOzK/VKfl4099oBL7z992bHMR2qsVa7cf+SN0HFO984
         vybg==
X-Forwarded-Encrypted: i=1; AJvYcCUc60aqFV1rkp9vYBk9UvK6RzdeZ/JtAUdk/k7YdPkJh8TMMUKJJRFJwdzrFDUipeusLI8QGNsw218BTSq7FKIiMrCTvKsbVvNQVn+z
X-Gm-Message-State: AOJu0Yzu3bbNjYvoK1rE4eFC2A7cBpJVhyKnsHR2dZYsdyAMRaOMuoQY
	fL6HKsXj13ZlztevPeMF2hggvTjvPfn+ZsDdPVVARepxyV02n54kKMWnaCxRbpVuoSHzyEsdO8d
	jt4gRfOmNzNvJzi0Ea0+l5YMxsPWwSHqVR+Kn
X-Google-Smtp-Source: AGHT+IFie6kWXAuIKFD19BDQmEVuYkXyygSoVtc7g5k6fJ83evlUpB/kUdYyYkH1hFW80mrYrAAbpNBPLDkRavi0P4E=
X-Received: by 2002:a05:6402:2917:b0:56f:ce8d:8f9 with SMTP id
 ee23-20020a056402291700b0056fce8d08f9mr24010edb.3.1712876943905; Thu, 11 Apr
 2024 16:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126085444.324918-1-xiong.y.zhang@linux.intel.com>
 <20240126085444.324918-29-xiong.y.zhang@linux.intel.com> <ZhhcAT7XiLHK3ZNQ@google.com>
 <CALMp9eTQr8ndf48uHHDem2ZkycdhAuVqz18+V1reEEfv0sx8qg@mail.gmail.com> <ZhhqL2HKmcW9DAIY@google.com>
In-Reply-To: <ZhhqL2HKmcW9DAIY@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 11 Apr 2024 16:08:48 -0700
Message-ID: <CALMp9eQ+-wcj8QMmFR07zvxFF22-bWwQgV-PZvD04ruQ=0NBBA@mail.gmail.com>
Subject: Re: [RFC PATCH 28/41] KVM: x86/pmu: Switch IA32_PERF_GLOBAL_CTRL at
 VM boundary
To: Sean Christopherson <seanjc@google.com>
Cc: Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, 
	peterz@infradead.org, mizhang@google.com, kan.liang@intel.com, 
	zhenyuw@linux.intel.com, dapeng1.mi@linux.intel.com, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhiyuan.lv@intel.com, eranian@google.com, irogers@google.com, 
	samantha.alt@intel.com, like.xu.linux@gmail.com, chao.gao@intel.com, 
	Xiong Zhang <xiong.y.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 3:54=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Apr 11, 2024, Jim Mattson wrote:
> > On Thu, Apr 11, 2024 at 2:54=E2=80=AFPM Sean Christopherson <seanjc@goo=
gle.com> wrote:
> > >
> > > On Fri, Jan 26, 2024, Xiong Zhang wrote:
> > > > +static void save_perf_global_ctrl_in_passthrough_pmu(struct vcpu_v=
mx *vmx)
> > > > +{
> > > > +     struct kvm_pmu *pmu =3D vcpu_to_pmu(&vmx->vcpu);
> > > > +     int i;
> > > > +
> > > > +     if (vm_exit_controls_get(vmx) & VM_EXIT_SAVE_IA32_PERF_GLOBAL=
_CTRL) {
> > > > +             pmu->global_ctrl =3D vmcs_read64(GUEST_IA32_PERF_GLOB=
AL_CTRL);
> > > > +     } else {
> > > > +             i =3D vmx_find_loadstore_msr_slot(&vmx->msr_autostore=
guest,
> > > > +                                             MSR_CORE_PERF_GLOBAL_=
CTRL);
> > > > +             if (i < 0)
> > > > +                     return;
> > > > +             pmu->global_ctrl =3D vmx->msr_autostore.guest.val[i].=
value;
> > >
> > > As before, NAK to using the MSR load/store lists unless there's a *re=
ally* good
> > > reason I'm missing.
> >
> > The VM-exit control, "save IA32_PERF_GLOBAL_CTL," first appears in
> > Sapphire Rapids. I think that's a compelling reason.
>
> Well that's annoying.  When was PMU v4 introduced?  E.g. if it came in IC=
X, I'd
> be sorely tempted to make VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL a hard requi=
rement.

Broadwell was v3. Skylake was v4.

> And has someone confirmed that the CPU saves into the MSR store list befo=
re
> processing VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL?

It's at the top of chapter 28 in volume 3 of the SDM.  MSRs may be
saved in the VM-exit MSR-store area before processor state is loaded
based in part on the host-state area and some VM-exit controls.
Anything else would be stupid. (Yes, I know that this is CPU design
we're talking about!)

