Return-Path: <linux-kernel+bounces-157992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BADB8B19E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC3F1C231A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01CE376F5;
	Thu, 25 Apr 2024 04:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="wtJ1cnIq"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069AC2BB01
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 04:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714019092; cv=none; b=dPWkV1UBrjdn19LOwb3pd3h5X+fJi/kspz5iyysDbfFuybcR9kH7FyrkipduEyxafhr9FbMzTp0el6F/pzALy8wphIbl14nSS6fzKDkwgvTiyO+avUmxvMsUyla5rjRXHlHj1mfGAt50vhJ8Jqh9zc9STzNpNoyaQjo6uogwyFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714019092; c=relaxed/simple;
	bh=vizLPpDz77XHtZLteOOI1a/fr6BKUXFJsNe42QhGao4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGCHo5mrv4FKbpJXsXQ97HmiU1vbmsbLCj6EZxpqOONrMeCXnJDsaA8uHMHms9ilmuUB9UN262AcqcwjUvvcEkafl9LFsKq1/5vEdTYT3Z1hEaGkLEDwZWa6fIMv2Qg4g3bxuUqxPT/fpZ+lUoUQDZ5fjvtUBNvzevWmYT2dgpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wtJ1cnIq; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso564033e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714019089; x=1714623889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IrvuwiS3D7ejDmTROQaAmlrQLvgYgyzhfvA7OnGDQQ=;
        b=wtJ1cnIqZcZ8WGxSMYDjNj8LyZciAEihxRh9DEHmyGnPncStbcRCicxPbFckXlPOlq
         OyrkbZiWl3+7G5uy9hYnL2m/9lXMoe8QyNTVSdZZz5GoQUOJiZH3SltF1T3mAPDwZXVD
         m7T0A0f1Kj1RGjXMzPTRF8/DBH0/r/dY3gTruv65ylO/lJW1kcisbmo3SRR5Cwf604pH
         87AyI9/dwsMG/3IY9McxaM8Xxwg/yGjnCxgnY65menyt7FwZ80stwzNiEsPcezH1DbVt
         dD9MfmXhZYG2mx5Ku3cDQwU/9P5/Wb/1fJKBBhj6yTwuuirePsrVMEYfPaNltvOGD+cY
         v0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714019089; x=1714623889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IrvuwiS3D7ejDmTROQaAmlrQLvgYgyzhfvA7OnGDQQ=;
        b=okMkaenH9gNF7FzdiFW6fcpHpAmKyieq1NhgD1qxFsz41AVfNRisJng8gZvH6OuZoj
         0f2VHy85ze7sKarnL8xuq2mPApeQsQ37a5E8dqleHrLtiq98HwhvOmXSthuxuZYN9vS/
         3pTICqppTZOvXh1kJ5/qjWUmfjDqDf4BqxDz4/7ek8VZ/OtJ4DJegDzsh+hSnBhZsECU
         2KFfQahsJLvF92jcYAh7zKjUhZexXXKgjp77x0yJroklK63nkBJ2iXRvQl0f0tt+tSWe
         W3uy6QPm+SNWDgztws+auTHWI80Z8nRfEUwUlWsrApk+rzkb6t+4Lw9I14xFfF3Nia8h
         0//Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbuKyosxa7SE0sr06QAvWTZNFd1Vfw5HuSmR6WOhbwzS4uDrchsCzs7TftIPfdWhxezMG5I2Ur/WhvwVGH0SLZ7oKuKORd48rHDc48
X-Gm-Message-State: AOJu0YyYN3ixvu4As3z4eRp6D94pO/O4iIvXsvkLL+6uIY92iX3nkJO7
	Cgs+foxMSQURKSLGaTG0gTy/M+l/V6AvMGCCBq/knweAjxHtlaTOLLBLLuget4z7SP6GBPDq00Z
	BcUrbvKHJ+LMvZpKDgE8IKqqjCAzskcfsqkX0
X-Google-Smtp-Source: AGHT+IEfUvui+52+qEcBDxTr1I+atQ6NoQjh90cU28I8b/8zvD7XHdTLRCq77QQHNVeBNssifFW7F7FKpHuLBaL/bns=
X-Received: by 2002:ac2:4841:0:b0:51a:cfca:ca3f with SMTP id
 1-20020ac24841000000b0051acfcaca3fmr2858795lfy.36.1714019088770; Wed, 24 Apr
 2024 21:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZiaX3H3YfrVh50cs@google.com> <d8f3497b-9f63-e30e-0c63-253908d40ac2@loongson.cn>
 <d980dd10-e4c4-4774-b107-77b320cec9f9@linux.intel.com> <b5e97aa1-7683-4eff-e1e3-58ac98a8d719@loongson.cn>
 <1ec7a21c-71d0-4f3e-9fa3-3de8ca0f7315@linux.intel.com> <5279eabc-ca46-ee1b-b80d-9a511ba90a36@loongson.cn>
 <CAL715WJK893gQd1m9CCAjz5OkxsRc5C4ZR7yJWJXbaGvCeZxQA@mail.gmail.com>
 <b3868bf5-4e16-3435-c807-f484821fccc6@loongson.cn> <CAL715W++maAt2Ujfvmu1pZKS4R5EmAPebTU_h9AB8aFbdLFrTQ@mail.gmail.com>
 <f843298c-db08-4fde-9887-13de18d960ac@linux.intel.com> <Zikeh2eGjwzDbytu@google.com>
 <7834a811-4764-42aa-8198-55c4556d947b@linux.intel.com>
In-Reply-To: <7834a811-4764-42aa-8198-55c4556d947b@linux.intel.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Wed, 24 Apr 2024 21:24:12 -0700
Message-ID: <CAL715WKh8VBJ-O50oqSnCqKPQo4Bor_aMnRZeS_TzJP3ja8-YQ@mail.gmail.com>
Subject: Re: [RFC PATCH 23/41] KVM: x86/pmu: Implement the save/restore of PMU
 state for Intel CPU
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, maobibo <maobibo@loongson.cn>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, peterz@infradead.org, 
	kan.liang@intel.com, zhenyuw@linux.intel.com, jmattson@google.com, 
	kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:56=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 4/24/2024 11:00 PM, Sean Christopherson wrote:
> > On Wed, Apr 24, 2024, Dapeng Mi wrote:
> >> On 4/24/2024 1:02 AM, Mingwei Zhang wrote:
> >>>>> Maybe, (just maybe), it is possible to do PMU context switch at vcp=
u
> >>>>> boundary normally, but doing it at VM Enter/Exit boundary when host=
 is
> >>>>> profiling KVM kernel module. So, dynamically adjusting PMU context
> >>>>> switch location could be an option.
> >>>> If there are two VMs with pmu enabled both, however host PMU is not
> >>>> enabled. PMU context switch should be done in vcpu thread sched-out =
path.
> >>>>
> >>>> If host pmu is used also, we can choose whether PMU switch should be
> >>>> done in vm exit path or vcpu thread sched-out path.
> >>>>
> >>> host PMU is always enabled, ie., Linux currently does not support KVM
> >>> PMU running standalone. I guess what you mean is there are no active
> >>> perf_events on the host side. Allowing a PMU context switch drifting
> >>> from vm-enter/exit boundary to vcpu loop boundary by checking host
> >>> side events might be a good option. We can keep the discussion, but I
> >>> won't propose that in v2.
> >> I suspect if it's really doable to do this deferring. This still makes=
 host
> >> lose the most of capability to profile KVM. Per my understanding, most=
 of
> >> KVM overhead happens in the vcpu loop, exactly speaking in VM-exit han=
dling.
> >> We have no idea when host want to create perf event to profile KVM, it=
 could
> >> be at any time.
> > No, the idea is that KVM will load host PMU state asap, but only when h=
ost PMU
> > state actually needs to be loaded, i.e. only when there are relevant ho=
st events.
> >
> > If there are no host perf events, KVM keeps guest PMU state loaded for =
the entire
> > KVM_RUN loop, i.e. provides optimal behavior for the guest.  But if a h=
ost perf
> > events exists (or comes along), the KVM context switches PMU at VM-Ente=
r/VM-Exit,
> > i.e. lets the host profile almost all of KVM, at the cost of a degraded=
 experience
> > for the guest while host perf events are active.
>
> I see. So KVM needs to provide a callback which needs to be called in
> the IPI handler. The KVM callback needs to be called to switch PMU state
> before perf really enabling host event and touching PMU MSRs. And only
> the perf event with exclude_guest attribute is allowed to create on
> host. Thanks.

Do we really need a KVM callback? I think that is one option.

Immediately after VMEXIT, KVM will check whether there are "host perf
events". If so, do the PMU context switch immediately. Otherwise, keep
deferring the context switch to the end of vPMU loop.

Detecting if there are "host perf events" would be interesting. The
"host perf events" refer to the perf_events on the host that are
active and assigned with HW counters and that are saved when context
switching to the guest PMU. I think getting those events could be done
by fetching the bitmaps in cpuc. I have to look into the details. But
at the time of VMEXIT, kvm should already have that information, so it
can immediately decide whether to do the PMU context switch or not.

oh, but when the control is executing within the run loop, a
host-level profiling starts, say 'perf record -a ...', it will
generate an IPI to all CPUs. Maybe that's when we need a callback so
the KVM guest PMU context gets preempted for the host-level profiling.
Gah..

hmm, not a fan of that. That means the host can poke the guest PMU
context at any time and cause higher overhead. But I admit it is much
better than the current approach.

The only thing is that: any command like 'perf record/stat -a' shot in
dark corners of the host can preempt guest PMUs of _all_ running VMs.
So, to alleviate that, maybe a module parameter that disables this
"preemption" is possible? This should fit scenarios where we don't
want guest PMU to be preempted outside of the vCPU loop?

Thanks. Regards
-Mingwei

-Mingwei

>
>
> >
> > My original sketch: https://lore.kernel.org/all/ZR3eNtP5IVAHeFNC@google=
com

