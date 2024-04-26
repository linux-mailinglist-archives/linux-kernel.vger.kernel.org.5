Return-Path: <linux-kernel+bounces-159506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2028B2F86
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46646B226CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E2F13A24A;
	Fri, 26 Apr 2024 04:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="aYbejN4G"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4FD81207
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 04:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714106848; cv=none; b=rUkB9yJD6zN875hjgpZ9Cr4xkAQ5w81tzTAUL3SZcTGTW2/Wc7Gb+Uwp+nyNGAvpljfGx1F4ME2ZuUR7vXo1KNEFoEICQChEdfpb1ELOVSPMGenVimUe6DKedWVqa8FrPG/E44S09H98xBX3V6jv/Mwi2rS7uMb6rg/TMUXauAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714106848; c=relaxed/simple;
	bh=qFZS8Xx/TeXHzdjwyYI3GI/SHkQZTua5k7xNUURsfIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAnKYEHnw82/+pN0xEzI6vE4RtR/E/of0h/JwbYki9JfCkvFZdgfizgAVHHXzhO9PlfLr1+z8whf4lHKrgPi0edjJ6EslGCdPJ9swjxpLFZ90x4istR4JMcBgvXnfrLaiAaU30pxB+V5jr4UcdLF7oLM/TbJ0azp+qXirQ81H/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aYbejN4G; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51acb95b892so2147368e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714106845; x=1714711645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xNG5kAKIWrMQdy9hX6H8VEwA1kEtA0fkEb+j2LDJiI=;
        b=aYbejN4GSimBgOGSCDV3tXlil7RneVumwSceogVecCaXklAN0L+dp4JXHkJAQkSB2W
         JJNEviE2wWw9doh9Y0GYNL1yubEM+fD1VwCkMn1huMqYaevQrThGjqc+6ExnCxDQw/pK
         WZ0JR8jC1HdSITH2Q/Wm54DMCF6Te1/51YVXV/hYv2UhXL/AQT60JL/t8ihomxGI4is+
         wg+EspKtKWBENBTBnql+UWKkkXHBjFjJfNDGahosuoI+hEK63pwJ6EVj/HwvYsqyeD9C
         A5gjcDHXzSJg4WZbjJHJ7tqUjLY9EzkmvgfFik78dXlxWmNZJ3Wf0X4t1vm5ooXbjkuE
         vyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714106845; x=1714711645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xNG5kAKIWrMQdy9hX6H8VEwA1kEtA0fkEb+j2LDJiI=;
        b=J+ZIrRa8r7WpRM1ML4ExrGP5Qv/CSZ9cCHQ2aYm4VqSt8m11T4w8VQsBUimDVLHnDz
         5eWC/2Bbnc0VRcTFxw+dKLLrxG5TPlYqC+UHpfHMLu9IDpVx1KRMAocXkZEdv6vSc0Me
         34QwCbXUXW5VrBJlv/JWXSf1ddsAsxUJsepVUz6dQd8PkkACV9uE7ql45TOKlrDIFS5N
         qVcUHlM8DOM6L+JathB4qIjOFIPIPFUX/gVYyxOjqVinCjXvWWtKP+QDKLC/aClLCQOH
         L4llwUqB4ucYPHwz/6fPU932Fo31EQQGGSHnD86O4QztyJ0gkGS0q4OHduPTwAsg/N/k
         UcTA==
X-Forwarded-Encrypted: i=1; AJvYcCUzMXlqC/8yLqBW5Ki8cZ+5DbximZgJe1dKaUUehdxy+mJHDUOVJR2QzhIpmtwHyyvarkISM/s0F85SGW1vFN8dyZbmyMRqEmItc72T
X-Gm-Message-State: AOJu0Yy+AutF7I/rj9g9rOR1mqxwKed9jH03ygHknuLbuBEJ6uWqpbNu
	D+FpC1opJ/es1sgvvVLQo5Q3rkj/zDlik2ETmKh7BWpmNxVcZ7uf2eJHpuXDHUOuuj4HzGZq+fI
	v/EAJvQ+NkrZRLV3L0UjynD4XcA8GdsUaGRfs
X-Google-Smtp-Source: AGHT+IHYLcM0oC3rvLhAw7AimABtScQQcJz6qsvPoydJB6AXdW25Yrj/AhfnCgHMDKCFE5Uns7HbM1d7zzklSQS1Fbw=
X-Received: by 2002:a05:6512:ac1:b0:51c:cc1b:a8f6 with SMTP id
 n1-20020a0565120ac100b0051ccc1ba8f6mr118103lfu.20.1714106844513; Thu, 25 Apr
 2024 21:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL715WJK893gQd1m9CCAjz5OkxsRc5C4ZR7yJWJXbaGvCeZxQA@mail.gmail.com>
 <b3868bf5-4e16-3435-c807-f484821fccc6@loongson.cn> <CAL715W++maAt2Ujfvmu1pZKS4R5EmAPebTU_h9AB8aFbdLFrTQ@mail.gmail.com>
 <f843298c-db08-4fde-9887-13de18d960ac@linux.intel.com> <Zikeh2eGjwzDbytu@google.com>
 <7834a811-4764-42aa-8198-55c4556d947b@linux.intel.com> <CAL715WKh8VBJ-O50oqSnCqKPQo4Bor_aMnRZeS_TzJP3ja8-YQ@mail.gmail.com>
 <6af2da05-cb47-46f7-b129-08463bc9469b@linux.intel.com> <CAL715W+zeqKenPLP2Fm9u_BkGRKAk-mncsOxrg=EKs74qK5f1Q@mail.gmail.com>
 <42acf1fc-1603-4ac5-8a09-edae2d85963d@linux.intel.com> <ZirPGnSDUzD-iWwc@google.com>
 <77913327-2115-42b5-850a-04ef0581faa7@linux.intel.com> <CAL715WJCHJD_wcJ+r4TyWfvmk9uNT_kPy7Pt=CHkB-Sf0D4Rqw@mail.gmail.com>
 <c96330d1-9750-4b65-8465-1b6f46bc11ba@linux.intel.com>
In-Reply-To: <c96330d1-9750-4b65-8465-1b6f46bc11ba@linux.intel.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Thu, 25 Apr 2024 21:46:47 -0700
Message-ID: <CAL715WKOPBG+G-hTDNw7S12uRMOP=3JgcYcys2xbKWrQVrXyDQ@mail.gmail.com>
Subject: Re: [RFC PATCH 23/41] KVM: x86/pmu: Implement the save/restore of PMU
 state for Intel CPU
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	maobibo <maobibo@loongson.cn>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, 
	peterz@infradead.org, kan.liang@intel.com, zhenyuw@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 9:03=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 4/26/2024 11:12 AM, Mingwei Zhang wrote:
> > On Thu, Apr 25, 2024 at 6:46=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.in=
tel.com> wrote:
> >>
> >> On 4/26/2024 5:46 AM, Sean Christopherson wrote:
> >>> On Thu, Apr 25, 2024, Kan Liang wrote:
> >>>> On 2024-04-25 4:16 p.m., Mingwei Zhang wrote:
> >>>>> On Thu, Apr 25, 2024 at 9:13=E2=80=AFAM Liang, Kan <kan.liang@linux=
intel.com> wrote:
> >>>>>> It should not happen. For the current implementation, perf rejects=
 all
> >>>>>> the !exclude_guest system-wide event creation if a guest with the =
vPMU
> >>>>>> is running.
> >>>>>> However, it's possible to create an exclude_guest system-wide even=
t at
> >>>>>> any time. KVM cannot use the information from the VM-entry to deci=
de if
> >>>>>> there will be active perf events in the VM-exit.
> >>>>> Hmm, why not? If there is any exclude_guest system-wide event,
> >>>>> perf_guest_enter() can return something to tell KVM "hey, some acti=
ve
> >>>>> host events are swapped out. they are originally in counter #2 and
> >>>>> #3". If so, at the time when perf_guest_enter() returns, KVM will a=
ck
> >>>>> that and keep it in its pmu data structure.
> >>>> I think it's possible that someone creates !exclude_guest event afte=
r
> >>> I assume you mean an exclude_guest=3D1 event?  Because perf should be=
 in a state
> >>> where it rejects exclude_guest=3D0 events.
> >> Suppose should be exclude_guest=3D1 event, the perf event without
> >> exclude_guest attribute would be blocked to create in the v2 patches
> >> which we are working on.
> >>
> >>
> >>>> the perf_guest_enter(). The stale information is saved in the KVM. P=
erf
> >>>> will schedule the event in the next perf_guest_exit(). KVM will not =
know it.
> >>> Ya, the creation of an event on a CPU that currently has guest PMU st=
ate loaded
> >>> is what I had in mind when I suggested a callback in my sketch:
> >>>
> >>>    :  D. Add a perf callback that is invoked from IRQ context when pe=
rf wants to
> >>>    :     configure a new PMU-based events, *before* actually programm=
ing the MSRs,
> >>>    :     and have KVM's callback put the guest PMU state
> >>
> >> when host creates a perf event with exclude_guest attribute which is
> >> used to profile KVM/VMM user space, the vCPU process could work at thr=
ee
> >> places.
> >>
> >> 1. in guest state (non-root mode)
> >>
> >> 2. inside vcpu-loop
> >>
> >> 3. outside vcpu-loop
> >>
> >> Since the PMU state has already been switched to host state, we don't
> >> need to consider the case 3 and only care about cases 1 and 2.
> >>
> >> when host creates a perf event with exclude_guest attribute to profile
> >> KVM/VMM user space,  an IPI is triggered to enable the perf event
> >> eventually like the following code shows.
> >>
> >> event_function_call(event, __perf_event_enable, NULL);
> >>
> >> For case 1,  a vm-exit is triggered and KVM starts to process the
> >> vm-exit and then run IPI irq handler, exactly speaking
> >> __perf_event_enable() to enable the perf event.
> >>
> >> For case 2, the IPI irq handler would preempt the vcpu-loop and call
> >> __perf_event_enable() to enable the perf event.
> >>
> >> So IMO KVM just needs to provide a callback to switch guest/host PMU
> >> state, and __perf_event_enable() calls this callback before really
> >> touching PMU MSRs.
> > ok, in this case, do we still need KVM to query perf if there are
> > active exclude_guest events? yes? Because there is an ordering issue.
> > The above suggests that the host-level perf profiling comes when a VM
> > is already running, there is an IPI that can invoke the callback and
> > trigger preemption. In this case, KVM should switch the context from
> > guest to host. What if it is the other way around, ie., host-level
> > profiling runs first and then VM runs?
> >
> > In this case, just before entering the vcpu loop, kvm should check
> > whether there is an active host event and save that into a pmu data
> > structure. If none, do the context switch early (so that KVM saves a
> > huge amount of unnecessary PMU context switches in the future).
> > Otherwise, keep the host PMU context until vm-enter. At the time of
> > vm-exit, do the check again using the data stored in pmu structure. If
> > there is an active event do the context switch to the host PMU,
> > otherwise defer that until exiting the vcpu loop. Of course, in the
> > meantime, if there is any perf profiling started causing the IPI, the
> > irq handler calls the callback, preempting the guest PMU context. If
> > that happens, at the time of exiting the vcpu boundary, PMU context
> > switch is skipped since it is already done. Of course, note that the
> > irq could come at any time, so the PMU context switch in all 4
> > locations need to check the state flag (and skip the context switch if
> > needed).
> >
> > So this requires vcpu->pmu has two pieces of state information: 1) the
> > flag similar to TIF_NEED_FPU_LOAD; 2) host perf context info (phase #1
> > just a boolean; phase #2, bitmap of occupied counters).
>
> I still had no chance to look at the details about vFPU implementation,
> currently I have no idea what we need exactly on vPMU side, a flag or a
> callback. Anyway, that's just implementation details, we can look at it
> when starting to implement it.

I think both. The flag helps to decide whether the context switch has
already been done. The callback will always trigger the context
switch, but the context switch code should always check if the switch
has already been done.

FPU context switch is similar but slightly different. That is done at
the host-level context switch boundary and even crossing that boundary
as long as the next process/thread is not using FPU and/or not going
back to userspace. I don't think we want to defer it that far.
Instead, the PMU context switch should still happen within the range
of KVM.

>
> >
> > This is a non-trivial optimization on the PMU context switch. I am
> > thinking about splitting them into the following phases:
> >
> > 1) lazy PMU context switch, i.e., wait until the guest touches PMU MSR
> > for the 1st time.
> > 2) fast PMU context switch on KVM side, i.e., KVM checking event
> > selector value (enable/disable) and selectively switch PMU state
> > (reducing rd/wr msrs)
> > 3) dynamic PMU context boundary, ie., KVM can dynamically choose PMU
> > context switch boundary depending on existing active host-level
> > events.
> > 3.1) more accurate dynamic PMU context switch, ie., KVM checking
> > host-level counter position and further reduces the number of msr
> > accesses.
> > 4) guest PMU context preemption, i.e., any new host-level perf
> > profiling can immediately preempt the guest PMU in the vcpu loop
> > (instead of waiting for the next PMU context switch in KVM).
>
> Great! we have a whole clear picture about the optimization right now.
> BTW, the optimization 1 and 2 are already on our original to-do list. We
> plan to do it after RFC v2 is ready.
>

I am going to summarize that into a design doc. It has been 50 emails
in this thread. I am sure no one has the patience to read our garbage
unless they are involved at the very beginning :)

Any of the implementations are very welcome. 1) and 2) are low hanging
fruit and we can finish that quickly after v2. 3-4 is error prone and
needs further discussions so let's not rush for that.

On the other hand, how do we test this is the question we need to think abo=
ut.

Thanks.
-Mingwei

