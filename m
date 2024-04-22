Return-Path: <linux-kernel+bounces-153826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B48AD3D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F4F1C20DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6376315445B;
	Mon, 22 Apr 2024 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="prDlvP0j"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274A8154440
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713810244; cv=none; b=gLfjsAWlCtXrKFA7E1xVZ129oCFsRUtLennfuy8KUTPNsV5oYSBY7LYQuUeAP5n6u0tBZYiEewe5lRfOxdikYyOFwMmq4TvbSg965wAV+4JE+lfKGKUwFJxhc92+13aksycfRnSu4QJmZo5AYm1zY93PSY+f8GF97si4OpqX8A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713810244; c=relaxed/simple;
	bh=OjtrXMo+MlZ+3lOmnQX8rKQ9mp5Ecgys0pfUSNpHerk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTIlOlNKYlmC+G709UIn5NV/A1vO60X6EmnvY4LHEYFW1kCPTMc8ihkiPBph5J9LuP03ygg/sCr15mJzN6MZxeEH/z7FSXj2S2FNPTJEkIRUHytmI4JpDMwa4BbqcdsFfReQNsie18X1lTTpZMv3qRCe6G2tvMvpNQVZKsiWafM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=prDlvP0j; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-436ed871225so46121cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713810241; x=1714415041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7UkO2xTenVr9mJYoz7W4myFtpUDe3OaDoN0PKm5L+4=;
        b=prDlvP0jvHzAiBjLGgOOqda0FPbuaVWF6zNDJtk6j4VVR1iobWk9j8Cxr3AUEnQ18H
         /5RyP6dN9SOE+rztd/WsKUVmUox6U41UDgu7koCZDoIrUbOTjcJ1v223F4Qkt7BgBl/v
         novaYw+6uDSYWpUbUm5PKwOg1dOS7u6/j/ro1n9b8jYXfJ2KK7TL+YZI8vMiGWqob5T2
         kjNEyubJo5Dxb/azNdpxWHLMqf+TDbKyNk2vapNqo8ZZZXKAY/nf5hOevhDv1zqIkExn
         z+6bUr4WmDGd801me0vF1S4dpYZP1U3K6Nr4ew/0LZc4/Ekfjh/s2R33iTCLMRiZCcYr
         DUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713810241; x=1714415041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7UkO2xTenVr9mJYoz7W4myFtpUDe3OaDoN0PKm5L+4=;
        b=D5QyLTChh4gXlp41cu5H2nhg7QCwUEZ7kI/ZelLHaQUw7ORnW7Rh61kMurE41P9LY1
         LKc+Ywu7p5kefiGYxzgNrsDBAzAJjoQgSx8c3DE+Xapfmbcg7HzakhMEfmtjwxkFdSmq
         MtKXlFiW5BX+XCfAZGIueyfyMWyqZxcEkOCLccSq1qZf3OhufMiDti0LaBXR/UEyHJtj
         8VgQw+/38Um5JviaEAWAM3MQ0dCm29aYMVXqJNJ0EJRglmsoCg8yDkOR56eVZUnG4vZt
         Tkz3f62ERHfYgkt1lMcHprdOgeJVPuoAOjcqPKO3eSewKUm/Ya3P17YjSj3ub7URlXkD
         WWIA==
X-Forwarded-Encrypted: i=1; AJvYcCV7OMdXtKJOZdVJ4YfKZzNTlnq4LKBTvBFhLE56j/Nf24PqDqKLC3710XEPpzNdpKK+Gu4J01ED99KwATsAsy7oVJiuPybCSepia09l
X-Gm-Message-State: AOJu0YzwfCP5yOt+NdgrdtanhJ8wfLfGJp/OxYvaatZ7kG8cLX5MZd9t
	XOgaCBQzZhgEia/rqJOacUUZIuwjiPI7ruPyY8XcI0P0Urr00RRsyWPL8rf0jQuD6/hXyDhh0Kr
	RvbEev+UweEluDXSA+6R6SjH8NzUFZgJiwPIj
X-Google-Smtp-Source: AGHT+IGpXESi8Pgm9due9O6vOTOmJm+HZXrg8fill1bQi+2mIk1Fjf/XXUb3ASMGhrQD1eJ9QdfpQ4uh52hkBOjsXPw=
X-Received: by 2002:ac8:4299:0:b0:437:c52f:cd6a with SMTP id
 o25-20020ac84299000000b00437c52fcd6amr25098qtl.8.1713810241132; Mon, 22 Apr
 2024 11:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711674410.git.babu.moger@amd.com> <ZiaRXrmDDjc194JI@e133380.arm.com>
In-Reply-To: <ZiaRXrmDDjc194JI@e133380.arm.com>
From: Peter Newman <peternewman@google.com>
Date: Mon, 22 Apr 2024 11:23:50 -0700
Message-ID: <CALPaoCh5DDmojnkUZPnACkq_ugwKnqCnwLHj2sV69TSTzpAL9g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Dave Martin <Dave.Martin@arm.com>
Cc: Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com, 
	reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
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

Hi Dave,

On Mon, Apr 22, 2024 at 9:33=E2=80=AFAM Dave Martin <Dave.Martin@arm.com> w=
rote:
>
> Hi Babu,
>
> On Thu, Mar 28, 2024 at 08:06:33PM -0500, Babu Moger wrote:
> >        Assignment flags can be one of the following:
> >
> >         t  MBM total event is assigned
>
> With my MPAM hat on this looks a bit weird, although I suppose it
> follows on from the way "mbm_total_bytes" and "mbm_local_bytes" are
> already exposed in resctrlfs.
>
> From an abstract point of view, "total" and "local" are just event
> selection criteria, additional to those in mbm_cfg_mask.  The different
> way they are treated in the hardware feels like an x86 implementation
> detail.
>
> For MPAM we don't currently distinguish local from non-local traffic, so
> I guess this just reduces to a simple on-off (i.e., "t" or nothing),
> which I guess is tolerable.
>
> This might want more thought if there is an expectation that more
> categories will be added here, though (?)

There should be a path forward whenever we start supporting
user-configured counter classes. I assume the letters a-z will be
enough to cover all the counter classes which could be used at once.

>
> >         l  MBM local event is assigned
> >         tl Both total and local MBM events are assigned
> >         _  None of the MBM events are assigned
>
> This use of '_' seems unusual.  Can we not just have the empty string
> for "nothing assigned"?
>
> Since every assignment is terminated by ';' or end-of-line, I don't
> think that there would be any parsing ambiguity (?)
>
> >
> >       Examples:
> >
> >       # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> >       non_defult_group//0=3Dtl;1=3Dtl;2=3Dtl;3=3Dtl;4=3Dtl;5=3Dtl;6=3Dt=
l;7=3Dtl;
> >       non_defult_group/non_default_mon1/0=3Dtl;1=3Dtl;2=3Dtl;3=3Dtl;4=
=3Dtl;5=3Dtl;6=3Dtl;7=3Dtl;
> >       //0=3Dtl;1=3Dtl;2=3Dtl;3=3Dtl;4=3Dtl;5=3Dtl;6=3Dtl;7=3Dtl;
> >       /default_mon1/0=3Dtl;1=3Dtl;2=3Dtl;3=3Dtl;4=3Dtl;5=3Dtl;6=3Dtl;7=
=3Dtl;
> >
> >       There are four groups and all the groups have local and total eve=
nt assigned.
> >
> >       "//" - This is a default CONTROL MON group
> >
> >       "non_defult_group//" - This is non default CONTROL MON group
> >
> >       "/default_mon1/"  - This is Child MON group of the defult group
> >
> >       "non_defult_group/non_default_mon1/" - This is child MON group of=
 the non default group
> >
> >       =3Dtl means both total and local events are assigned.
> >
> > e. Update the group assignment states using the interface file /sys/fs/=
resctrl/info/L3_MON/mbm_assign_control.
> >
> >       The write format is similar to the above list format with additio=
n of
> >       op-code for the assignment operation.
>
> With by resctrl newbie hat on:
>
> It feels a bit complex (for the kernel) to have userspace needing to
> write a script into a magic file that we need to parse, specifying
> updates to a bunch of controls already visible as objects in resctrlfs
> in their own right.
>
> What's the expected use case here?

I went over the use case of iterating a small number of monitors over
a much larger number of monitoring groups here:

https://lore.kernel.org/lkml/CALPaoCi=3DPCWr6U5zYtFPmyaFHU_iqZtZL-LaHC2mYxb=
ETXk3ig@mail.gmail.com/

>
> If userspace really does need to switch lots of events simultaneously
> then I guess the overhead of enumerating and poking lots of individual
> files might be unacceptable though, and we would still need some global
> interfaces for operations such as "unassign everything"...

My main goal is for the number of parallel IPI batches to all the
domains (or write syscalls) to be O(num_rmids / num_monitors) rather
than O(num_rmids * num_monitors) as I need to know how frequently we
can afford to sample the current memory bandwidth of the maximum
number of monitoring groups supported.

Thanks!
-Peter

