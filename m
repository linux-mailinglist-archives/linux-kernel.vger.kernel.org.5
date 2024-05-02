Return-Path: <linux-kernel+bounces-166807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9D78B9FCC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5944B223CA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EEA17107D;
	Thu,  2 May 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXJEhgiw"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FCB171074
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672229; cv=none; b=mzd+f/jnFJHdlJ2OT1P5iLqYB10duVodbeFdbEN2Vhkb8C7ddD5RYRMOOiBlGzE7T/5TPm4bAv6Dl/cMCsnAoFs94Bg/KXhIhehwrLDZH/Jylf1DmMLkoF+75wdhvQVfx9XZGa8VxoxxJm5S56ywgw9NcVs9GCHqviS8MsjfUps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672229; c=relaxed/simple;
	bh=+YG8bU5lpRebP0zKL7QeY6YwFGqmbmUhx1xqVfMM9QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zfcp9YAy3vPk6KZnofR2cxykiADD4y9YHWpUP61akO8kMn5CsNfnKQzATbJYug+IFXYIYbWTYQ/9qOTg8wGNQGbY/lbJ4YDzdM9TsdmEu+DIstW2/EXKcYSLjn0zwQiIhnfV90GPT2xmdRz0qfyeC8MQ81KoyeSiUji8PPKdy98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DXJEhgiw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ec76185c0fso17145ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 10:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714672228; x=1715277028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+YG8bU5lpRebP0zKL7QeY6YwFGqmbmUhx1xqVfMM9QA=;
        b=DXJEhgiwYwJf3U1CbCZ3XeA88ZbKHm/fHFLTHbPlZ53oGZqdISPasmjmDjV64VsjI4
         5DehUPyKaHzD6VRBReqXpucxaYf3j0Yblwiek+TB1G6uFrxVxDmrtL0RYFhadtagT/Ip
         jmNvFJmw336d55pa2xxwdEFoVXTCqJe8vovY2TgbF+JKg8MYMLmi1+4FKcsl/i9W0fxX
         io2ewcWpTm4WdPDa807lgQ893yFFsCEMVNIVJ3pzTx690AH1icFl6D450lyx9O6sRRHO
         dyAlztWQ343/HX/1KE2WxpBMnQ7H/cY5PtO2OuoQa9k+IEZ4vxseg/Da+MnxyNW1tP1Y
         /w2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714672228; x=1715277028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+YG8bU5lpRebP0zKL7QeY6YwFGqmbmUhx1xqVfMM9QA=;
        b=Zx8HztdpmVQ0t1akTEyO6jgX66U305MXHYTDbjvqNBcQeIQ9Q1ziOHqu9BheraoxSg
         mRpkdG9dfvhe8xBFjHwV1GVh5c1U8SwY5WLbNWbl8eLYOVlQBmkNl2qDhqJsp0/sGWq9
         a7jddGQO1JdUNbjNiv8aZu271ky0s4BXKUSSMNMufjHM0wKffdr7mwp0oXxyg9gfEMZA
         dyussl4ycXMFtyUs1U0a7uiE4D+fin4OLeADkkSPOogizYviAaUOL6F1Fglg3v9l+Krx
         pA2Dzjr1BrjphWTX+e/ZJeQqyUwCeWgviUMvczQfhzBA6ByC+H1yQqc/hU6Py+GmCpOQ
         M8Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXriq+0EjJ/0ITiav3zDZotCGOgrC02sHdsKccD492G8eiBYjf22VA//9k0vWbSThIT/sVCrCwckU1kQ4EZ03opSg5Igypk3Pj3MMKj
X-Gm-Message-State: AOJu0YzGMtwkmNSAc+ZOhzQyI4EfzKgk94PUI0vz0PsStnvHTz3sYlt0
	TDXU3S4m8GqFkMjO3zKV4mzlk2+5YBIWS1oSsyOei8QhENlf93dB648ATCzctmrk7vf2sd3GO32
	MjEslAKe3AGcVpqQrbNfZuE+09m2RxEWiwDUL
X-Google-Smtp-Source: AGHT+IHIHO4ZxblGoxzXV30a1efcpuRtS16EH+6J55Oor1UygSWON6PEJUUlMNkboiyBx5keJ/YZIzYFrU9aNLdwfO0=
X-Received: by 2002:a17:903:90c:b0:1eb:1663:c80b with SMTP id
 d9443c01a7336-1ece5b3cb55mr2560225ad.11.1714672227326; Thu, 02 May 2024
 10:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711674410.git.babu.moger@amd.com> <CALPaoCjZ3oLdKymJjASt0aqtd0GGOme7LavvYOtPYTb_rA-mYQ@mail.gmail.com>
 <b35dc4e9-7e8b-42ed-9a51-ae50d521cf4b@amd.com>
In-Reply-To: <b35dc4e9-7e8b-42ed-9a51-ae50d521cf4b@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 2 May 2024 10:50:15 -0700
Message-ID: <CALPaoChxYoJx8eR48EkSKf-hu2p2myQJLZEhj_Pq6O4R15-=5A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: babu.moger@amd.com
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com, 
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com, 
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com, 
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com, kai.huang@intel.com, 
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com, 
	pbonzini@redhat.com, sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com, 
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Babu,

On Thu, May 2, 2024 at 9:25=E2=80=AFAM Moger, Babu <babu.moger@amd.com> wro=
te:
> On 5/1/24 12:48, Peter Newman wrote:
> > The FS layer is informed by the arch layer (through rdt_resource
> > fields) how many assignable monitors are available and whether a
> > monitor is assigned to an entire group or a single event in a group.
> > Also, the FS layer can assume that monitors are indexed contiguously,
> > allowing it to host the data structures managing FS-level view of
> > monitor usage.
> >
> > I used the following resctrl_arch-interfaces to propagate assignments
> > to the implementation:
> >
> > void resctrl_arch_assign_monitor(struct rdt_domain *d, u32 mon_id, u32
> > closid, u32 rmid, int evtid);
>
> Sure. I can add these in next version.
>
> Few comments..
>
> AMD does not need closid for assignment. I assume ARM requires closid.

Correct, MPAM needs a CLOSID+RMID (PARTID+PMG) to identify a
monitoring group. The CLOSID parameter is ignored on x86.

>
> What is mon_id here?

On ABMC, the value is programmed into L3_QOS_ABMC_CFG.CtrID


>
> > void resctrl_arch_unassign_monitor(struct rdt_domain *d, u32 mon_id);
>
> We need rmid and evtid for unassign interface here.

From my reading of the ABMC specification, it does not look necessary
to program BwSrc or BwType when changing L3_QOS_ABMC_CFG.CtrEn to 0
for a particular CtrID. This interface only disables a counter, so it
should not need to know about how it was previously used when assign
is able to reassign, as assign will always reset the arch_mbm data.

I do not see any harm in the arch_mbm data being stale while the
counter is unassigned, because the data is not accessed when reading
the hardware counter fails. In general, resctrl_arch_rmid_read()
cannot return any information if the hardware counter is not readable
at the time it is called.

>
>
> >
> > I chose to allow reassigning an assigned monitor without calling
> > unassign first. This is important when monitors are unassigned and
> > assigned in a single write to mbm_assign_control, as it allows all
> > updates to be performed in a single round of parallel IPIs to the
> > domains.
>
> Yes. It is not required to call unassign before assign. Hardware(AMD)
> supports it.
>
> But, we only have 32 counters. We need to know which counter we are going
> to use for assignment. If all the counters already assigned, then we can'=
t
> figure out the counter id without calling unassigm first. Using the rando=
m
> counter will overwrite the already assigned counter.

I made the caller of resctrl_arch_assign_monitor() responsible for
selecting which monitor to assign. As long as the user orders the
unassign operations before the assign operations in a write to
mbm_assign_control, the FS code will be able to find an available
monitor ID.


> > I chose to make this a mount option to simplify the management of the
> > monitor tracking data structures. They are simply allocated at mount
> > time and deallocated and unmount.
>
> Initially I added it as an mount option.
> Based on our earlier discussion, we decided to use the assign feature by
> default if hardware supports it. Users don't have to worry about the deta=
ils.
> >
> > I called the option "mon_assign": The mount option parser calls
> > resctrl_arch_mon_assign_enable() to determine whether the
> > implementation supports assignment in some form. If it returns an
> > error, the mount fails. When successful, the assignable monitor count
> > is made non-zero in the appropriate rdt_resource, triggering the
> > behavior change in the FS layer.
> >
> > I'm still not sure if it's a good idea to enable monitor assignment by
> > default. This would be a major disruption in the MBM usage model
> > triggered by moving software between AMD CPU models. I thought the
>
> Why will it be a disruption? Why do you think mount option will solve the
> problem? As always, there will be option to go back to legacy mode. right=
?
>
> > safest option was to disallow creating more monitoring groups than
> > monitors unless the option is selected. Given that nobody else
>
> Current code allows to create more groups, but it will report "Monitor
> assignment failed" when it runs out of monitors.

Ok that should be fine then.

However, I don't think it's necessary to support dynamically changing
the usage model of monitoring groups without remounting. I believe it
makes it more difficult for the FS code to generically manage monitor
assignment.

-Peter

