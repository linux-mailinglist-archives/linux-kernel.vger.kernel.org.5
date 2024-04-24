Return-Path: <linux-kernel+bounces-157718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0218B1505
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB101C2361D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6946156980;
	Wed, 24 Apr 2024 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LpkcbgLl"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4020156679
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992791; cv=none; b=uUcqtOODe00k3rBIzJ7fiMWx2PUVHm9aWniGv56PnxIRgE35XeH958Nq8X4R1+cqV9UhRVEZhr0LcbZvZ25xLKvY6I9kWP31iQKcngOEmB3369cYlxFyhQZTHF3TMkbwJcaGiNHN0d1QchSgTfVyY+AoYLCDrZ6ZViL2mdTC2nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992791; c=relaxed/simple;
	bh=7L27pbDyJlNBFN5utq97RsmvJQir9xLX7N/dZ3st4HE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4ZZPMsWDZtWVRBCRdagMFYl+4XRt+o/bSj+VLSo6emGmXKP7JUtBRrYmZcvDFLNvp5YSPmeByS9PsWbrc41jnWqNmbGPdl3NDkoVCMOx6a2dZL8PWl42X/FKOi5l00UwiDfa/xofLaoFnpzzcrJiX9yjgZnguRp/VA0ll7jp74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LpkcbgLl; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51acb95b892so295386e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713992787; x=1714597587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7L27pbDyJlNBFN5utq97RsmvJQir9xLX7N/dZ3st4HE=;
        b=LpkcbgLlwBVk3bWw/y8jR7KmkskgG+cElTEzQYNWtzzBrmsl13c8wPzloo3UGDuOVf
         VivwefyTXPzPlByR+vRGei1WpHY36he5jWmSJXeYCjnR9K485ZVN8llwvl+hO4nh0A/T
         pZsO2BJL4jdw6qsIpY8eZ8GqMmSfLBvC94bb8Rmbp5Yi0DJ3F47ZcfHW/zSELDciCkjD
         EU6Y3v0ka/ka/sX4tc9LykorihO9nSM3WX9yGlcJaflhQh3VwC0MMLCIJNSNADm5z8tM
         HCatAcIyFH8VOC0NScRPf3wwBFBjveU1TNtFTmZWH3V2TXlub2r6XzDwCgroXltjsIBk
         d4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713992787; x=1714597587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7L27pbDyJlNBFN5utq97RsmvJQir9xLX7N/dZ3st4HE=;
        b=SoeV1i3mMnhyouTyTYEiWi6wWwWKXQMc22hfT4jPtDmw98xtZlf6dwjAUY7Y7cSM43
         w+XYvBp4fkuBO1sSmUpCrX7HRZbNdfcQCdwOL+78OAtOUZRLqEp0Qo/CjINv0Sua6HLu
         l8kUpRS5RQLmE/OcClFq/6pocD/NVVheisEBx0t+dYagYFC9sDtVAUJ0WA8YKrlaUyWA
         Jt1vDK1VlpSLqqIamdbuM5PEwG+qIybV77wqX9h+qLOOZScORCMeErmj7WQ+R8/Fzk4V
         OKxFUIUdUq80x8siIV03/jeRu+bKxp2Gfnm4raeVffj6oURZfKD4/9BUhPs/hBMdrAIY
         EU0g==
X-Forwarded-Encrypted: i=1; AJvYcCVzW/1a86juwh3yAVh7ZSMJu02taBN8TFpklTgPGDHOBJd2/Oh13IXnTrR9HiZtw7s98CyelGbb+LERqBkT7uZ3/dt7GFcuZ3Xt16b6
X-Gm-Message-State: AOJu0Yw/LV92N4GcmajEa9RB2XZENeBb70B5zwObYGfbuuoiirezxXMw
	oAuun/PCMIt/8KFFi2OmNG0S6pxmH9qDd8Xn+2cE1crLPRgxzfAWVseWSwW1QNSkM80zzSfWQJA
	QUKzVk4rd9543lluMlve5i1Nu5UG0zlNg637H0g==
X-Google-Smtp-Source: AGHT+IH2ovdfmOEB0kenFNmxB+vsJc1NZieoLUEirvPHxb6Ulkwew52K4sk/AQbARhlHsmpGqy/r2YpIVSwLiVlU+GA=
X-Received: by 2002:ac2:47e6:0:b0:51a:d08d:bab4 with SMTP id
 b6-20020ac247e6000000b0051ad08dbab4mr2906232lfp.55.1713992786911; Wed, 24 Apr
 2024 14:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103165438.633054-1-samuel.holland@sifive.com>
 <CAOnJCUJ4rC+Rrs6GV4t+=NWA=LtTZix5Nk1VzgP9CK-3+5-jAg@mail.gmail.com>
 <06e71142-e113-40ac-b2c2-b20893aa714f@sifive.com> <a4c4c9f2-9fe1-4c22-a99c-1667481ddd6b@rivosinc.com>
 <CAAhSdy1yoCMtR52X7tS6dB2x_ysgA8K4hSSXH044bbq2uFY7jQ@mail.gmail.com>
 <CAP-5=fX5JRYxZ26buLujSVP7roQTaWofqdiX1y1rAKQ70Yu+QQ@mail.gmail.com>
 <CAHBxVyGuxQLTnBUiK2w=9atqNXs0sWC9KcWjssgzhNnbp_Z-mg@mail.gmail.com>
 <20240424-7b4434122a8c1cf1c1173403@orel> <CAP-5=fVts9oyi8AYmWnLvASZu_2AjcMeHX3UVLGiECX6yi3Pew@mail.gmail.com>
In-Reply-To: <CAP-5=fVts9oyi8AYmWnLvASZu_2AjcMeHX3UVLGiECX6yi3Pew@mail.gmail.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Wed, 24 Apr 2024 14:06:15 -0700
Message-ID: <CAHBxVyFqd_4BWYmoxFkPWkJTzXKPqYD4UdPzdyGTQj+E-qBrjQ@mail.gmail.com>
Subject: Re: [PATCH] perf: RISC-V: Check standard event availability
To: Ian Rogers <irogers@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Atish Patra <atishp@atishpatra.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 11:27=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, Apr 24, 2024 at 6:31=E2=80=AFAM Andrew Jones <ajones@ventanamicro=
com> wrote:
> >
> > On Tue, Apr 23, 2024 at 05:36:43PM -0700, Atish Kumar Patra wrote:
> > > On Mon, Apr 22, 2024 at 8:44=E2=80=AFPM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > On Mon, Apr 15, 2024 at 9:07=E2=80=AFPM Anup Patel <anup@brainfault=
org> wrote:
> > > > >
> > > > > On Tue, Apr 16, 2024 at 5:31=E2=80=AFAM Atish Patra <atishp@rivos=
inc.com> wrote:
> > > > > >
> > > > > > On 4/10/24 18:40, Samuel Holland wrote:
> > > > > > > Hi Atish,
> > > > > > >
> > > > > > > On 2024-03-18 2:44 PM, Atish Patra wrote:
> > > > > > >> On Wed, Jan 3, 2024 at 8:54=E2=80=AFAM Samuel Holland <samue=
l.holland@sifive.com> wrote:
> > > > > > >>>
> > > > > > >>> The RISC-V SBI PMU specification defines several standard h=
ardware and
> > > > > > >>> cache events. Currently, all of these events appear in the =
`perf list`
> > > > > > >>> output, even if they are not actually implemented. Add logi=
c to check
> > > > > > >>> which events are supported by the hardware (i.e. can be map=
ped to some
> > > > > > >>> counter), so only usable events are reported to userspace.
> > > > > > >>>
> > > > > > >>
> > > > > > >> Thanks for the patch.
> > > > > > >> This adds tons of SBI calls at every boot for a use case whi=
ch is at
> > > > > > >> best confusing for a subset of users who actually wants to r=
un perf.
> > > > > > >
> > > > > > > I should have been clearer in the patch description. This is =
not just a cosmetic
> > > > > > > change; because perf sees these as valid events, it tries to =
use them in
> > > > > > > commands like `perf stat`. When the error from SBI_EXT_PMU_CO=
UNTER_CFG_MATCH
> > > > > > > causes the ->add() callback to fail, this prevents any other =
events from being
> > > > > > > scheduled on that same CPU (search can_add_hw in kernel/event=
s/core.c). That is
> > > > > > > why the dTLB/iTLB miss counts are missing in the "before" exa=
mple below.
> > > > > > >
> > > > > >
> > > > > > Thanks for explaining the problem. I can reproduce it in qemu a=
s well if
> > > > > > enough number of invalid events given on the command line and t=
he
> > > > > > workload is short enough.
> > > > > >
> > > > > > >> This probing can be done at runtime by invoking the
> > > > > > >> pmu_sbi_check_event from pmu_sbi_event_map.
> > > > > > >> We can update the event map after that so that it doesn't ne=
ed to
> > > > > > >> invoke pmu_sbi_check_event next time.
> > > > > > >
> > > > > > > I tried to implement this suggestion, but it did not work. Th=
e SBI interface
> > > > > > > does not distinguish between "none of the counters can monito=
r the specified
> > > > > > > event [because the event is unsupported]" and "none of the co=
unters can monitor
> > > > > > > the specified event [because the counters are busy]". It is n=
ot sufficient for
> > > > > > > the kernel to verify that at least one counter is available b=
efore performing
> > > > > > > the check, because certain events may only be usable on a sub=
set of counters
> > > > > > > (per riscv,event-to-mhpmcounters), and the kernel does not kn=
ow that mapping.
> > > > > > >
> > > > > >
> > > > > > Yeah. My suggestion was to fix the perf list issue which is dif=
ferent
> > > > > > than the issue reported now.
> > > > > >
> > > > > > > As a result, checking for event support is only reliable when=
 none of the
> > > > > > > counters are in use. So the check can be asynchronous/deferre=
d to later in the
> > > > > > > boot process, but I believe it still needs to be performed fo=
r all events before
> > > > > > > userspace starts using the counters.
> > > > > > >
> > > > > >
> > > > > > We should defer it a work queue for sure. We can also look at i=
mproving
> > > > > > SBI PMU extension to support bulk matching behavior as well.
> > > > > >
> > > > > > However, I think a better solution would be to just rely on the=
 json
> > > > > > file mappings instead of making SBI calls. We are going to have=
 the
> > > > > > event encoding and mappings in the json in the future.
> > > > >
> > > > > The problem with JSON based event encoding is how to deal in-case
> > > > > we are running inside Guest/VM because Host could be anything.
> > > > >
> > > > > IMO, the JSON based approach is not suitable for SBI PMU. For now=
,
> > > > > we either defer the work using the work queue or keep the approac=
h
> > > > > of this patch as-is.
> > > > >
> > > > > The good part about SBI PMU extension is that we do have a standa=
rd
> > > > > set of events and we only need a way to discover supported standa=
rd
> > > > > events with a minimum number of SBI calls. It is better to add a =
new
> > > > > SBI PMU call to assist supported event discovery which will also
> > > > > help us virtualize it.
> > > > >
> > > > > Regards,
> > > > > Anup
> > > >
> > > > +Ian Rogers
> > > >
> > > > `perf list` will already filter some events depending on whether th=
e
> > > > PMU supports them, for example, legacy cache events. I think we can
> > > > extend this to json events.
> > > >
> > >
> > > Yes. That's what I was thinking as well. However, that may be a
> > > problem in virtualization
> > > as Anup pointed out.
> > >
> > > As per my understanding, cloud providers provide json files for VMs
> > > based on the host
> > > architecture and allow migration only between hosts with the same
> > > family of cpu. In RISC-V, the mapfile.csv works based on 3 registers
> > > indicating marchid, mimpid, and mvendorid. Thus, the json file has to
> > > be tied with the host machine it is going to be run.
> >
> > This is also my understanding. That is, that cloud instances typically
> > dedicate CPUs to VMs and don't try to present CPU models to VMs which
> > don't exactly match the host's CPUs. The remaining concern would be if
> > the hypervisor doesn't emulate/passthrough everything the json describe=
s
> > for the host CPU type.
>

x86/ARM64 kvm also can filter any event for the guest they want.

> So this isn't accurate. For x86 perf uses the CPUID instruction. A
> host operating system can change the CPUID for a guest, say pretending
> a newer CPU model is actually an older one. This can be done when
> migrating VMs as having the CPUID change dynamically in a guest would
> be a problem. VM migration like this can have issues and it is fair to
> say that it is avoided.
>

I was specifically asking if the json file is updated for a guest when migr=
ated
if the events supported on the destination host are different than the
source host ?

Or The VM migration across different CPUIDs (e.g different family of CPUs)
are avoided completely. It seems the latter from your statement ?


> Fwiw, a particular problem we have with x86 guests is the host hiding
> CPUID leaves that describe things like the frequency of the CPU. It is
> difficult to compute metrics in units of time when you don't know what
> frequency cycles relates to.
>
> > However, this is just "typical" clouds. All bets are off for general
> > virtualization, as Anup points out.
> >
> > >
> > > We will end up doing the same if we only rely on the json file to
> > > filter events in the future. Please let me know if the assumption is
> > > incorrect.
> > >
> > > If we allow a SBI call route to discover which events are supported,
> > > the guest can always support legacy events on any host even though it
> > > doesn't have a json file.
> >
> > Yes, I think we need a solution which works even without a json file,
> > since a VM may use a special mvendorid,marchid,mimpid triplet to
> > describe a more generic CPU type. Unless we also create json files
> > for these VCPUs, or provide other event discovery mechanisms, then
> > the VMs will not have anything.
>

We have to create a json file for VMs anyways for raw events. Having
the discovery through
SBI call allows minimum guarantee for the perf legacy events.

> I think a set of generic events is a good thing, then the PMU driver
> can map perf's legacy events to the generic events in a clean way. I'm
> not sure what the issue is with RISC-V guest operating systems. To

The pertinent question here is how does the guest know the list of
supported generic or perf legacy
events as RISC-V doesn't have any standard event format/encoding
support. There are two approaches

1. Define a new SBI interface which allows the host to let the guest
know which events are supported at one shot.
The perf legacy events mappings are updated at guest boot time via
this interface. Currently, this patch achieves this
by iterating through all the possible legacy events and making an SBI
call one at a time during the boot.

2. Rely on the json file present (if) in the guest. In this case, all
the supported perf legacy events must be present in
the json. In absence of that, the driver assumes it is not supported.


> lower overhead on x86 pass-through PMUs are being explored, that is
> the guest operating system directly programming the CPU's performance
> counters to avoid hypervisor traps. For this to work the triplet
> mvendorid,marchid,mimpid should match that of the host.
>

Yes. I am tracking the pass through series for vPMU in x86.
RISC-V also doesn't have pass through support and implements counter
virtualization similar
to other architectures as well but we have less number of traps
because of the bulk access features.

> The perf tool supports the notion of a standard set of legacy events
> like instructions, cycles and certain cache events. More recently
> we've moved to prefer sysfs and json events over these, primarily
> because the Apple M1 ARM based Macs nobody was establishing the
> mapping from legacy to an actual event. Users were complaining that
> 'cycles' via a sysfs event worked, but when ARM was made like Intel
> and prioritized legacy first, we broke it. Now we prioritize sysfs and
> json way for all architectures and hopefully everyone is happy. The
> last clean up for this is in:
> https://lore.kernel.org/lkml/20240416061533.921723-1-irogers@google.com/
>
> Thanks,
> Ian
>
> > Thanks,
> > drew

