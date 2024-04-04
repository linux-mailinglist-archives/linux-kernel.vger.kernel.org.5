Return-Path: <linux-kernel+bounces-132012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7A6898EAA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808E41C21EB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C89E13341E;
	Thu,  4 Apr 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZdo5tf2"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1D51332BA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257736; cv=none; b=gdUOWsdE4fGq4MF33CD3Ax+MevYACUL1IqCsETphvdhn7oCd/qBS94ZWnfrfeebecbYDdVLLEzcClGmJsYYqqtjdXInI+ZNYP0gVEO2chofEO71E5j2mSwaJ/QkmNb4vLnX0LdhSYR2GyZF8pckGqAiAEAJDPC7I6yaJzyKiAFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257736; c=relaxed/simple;
	bh=WxeAqvvN/v7ktneYk9JoOYaf4wH/gjJj72H4zKdF+ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KWNlEk5c7VeL8T3t2pLNjehcECC2+/YwcCjcJTTrLc8jD1zH7BYf9GlfP5za5ybu9HQOdIMlVl2vJ160IhcRDsZT4MYZoL3gff9YtAhcKJELgjeUJ75eK0pV98nXAcyQowGWV5A5aiZWgkoO1tcm/0SxDGzINyia84iMkh/z4Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZdo5tf2; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-431347c6c99so58561cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 12:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712257734; x=1712862534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2FS3zsbt8L4jeaVkTvzqGihSw/YCQu8ub3DPuvSaF0=;
        b=uZdo5tf2PBHHmoUmpJYi/ZNTG+TcIConAiXCqPIOzIWxY1KUS1/Wq+LsVpFt/RChqZ
         AjUG3doKkyIN/bEz1rNe0wY+LcqMo1GCJNc7y0Ga8HRHHXa0KzVusB4YpeX1pSwM5vNc
         Dux85gt4wWQjGuPW1EQUz+Q5JGX+PfylOdZy5nEBscoMRvb7T9y5ZD/PDz5hmr4oP3la
         ZGe7aaV8slzvtzDu1sWDEqHAqnf3pXP+yXZFrYMG09JoVQCVVnH2wHrceDaunlXc2x4Y
         Wnu2GJDq8oCC9WpN9b90vO3L1Ce7PfsqtnOY3g0+YJm4ek/L1Q0/s//jI5LK0zbtYbxg
         eNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712257734; x=1712862534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2FS3zsbt8L4jeaVkTvzqGihSw/YCQu8ub3DPuvSaF0=;
        b=fT7mAopPWrfl4mI35nkg4zi4YuoDXBIqhijjLfQMC7H4/tTp+oGAz0Npein2694yRv
         +W+pHbdlwH9EXFHVVl1U6cGcRHksZ2mA7aSJDjqOFvc2Zk/Hygff2eyNEOaau8w818xK
         0HvJztGspfWPSWhN/YcJFmLcrRYrHVM2tUW2BwhYAUI7XpACdag8xp6L4l80stnnJCiU
         h9qGXSvMjU7K5VjEp4R+hAUXkbOhir5hNGtXGQdHapFOEpnIGCqkYC/Fz3UZEVKoCHmO
         IPYJfNBC8waKY0BGsEDcZzcFfNOWT59qBBgflAGVDcxG8zMetCve1mIaylhSrAFIaDjV
         VuPg==
X-Forwarded-Encrypted: i=1; AJvYcCUkdjMCAYvGUZ4EAGPWw0GR+mwFXwhOWY40/27CGte2dTmu9iSF/+DM6k0zMgGipPLRc+QLLEz5qd03PqfoPObHVFBzy0w4OfiTnDg7
X-Gm-Message-State: AOJu0YxYJT6nf3QnIvpJP3sjqyZQFh8Y/TuTBUzVXXP/daWk3vOPWE8c
	4sExbCM+pp263Td5R0zip48m1teCE5gJjf9ysntaEuG4guLAqma5+lTeVioJRuXgszTGA2XZmHG
	FDa9UOp5ZJD8vq5uuL3vsyHpNClFYtinJALLA
X-Google-Smtp-Source: AGHT+IFRY4QGSGiwJ3A8YX2yjQXNwm/FJuEvmJf5VoD79vrLqSU2/o1QqH8DeNhZ00svTvH3AICvuXJRA+LVIptBTb8=
X-Received: by 2002:a05:622a:1a82:b0:434:5c3f:6d55 with SMTP id
 s2-20020a05622a1a8200b004345c3f6d55mr7835qtc.1.1712257734134; Thu, 04 Apr
 2024 12:08:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711674410.git.babu.moger@amd.com>
In-Reply-To: <cover.1711674410.git.babu.moger@amd.com>
From: Peter Newman <peternewman@google.com>
Date: Thu, 4 Apr 2024 12:08:43 -0700
Message-ID: <CALPaoCheW=Jz2R3gMKcgwQe6ONDrRqu3tUxeg=A3USg6BC8buA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Babu Moger <babu.moger@amd.com>
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

On Thu, Mar 28, 2024 at 6:07=E2=80=AFPM Babu Moger <babu.moger@amd.com> wro=
te:
>    The list follows the following format:
>
>        * Default CTRL_MON group:
>                "//<domain_id>=3D<assignment_flags>"
>
>        * Non-default CTRL_MON group:
>                "<CTRL_MON group>//<domain_id>=3D<assignment_flags>"
>
>        * Child MON group of default CTRL_MON group:
>                "/<MON group>/<domain_id>=3D<assignment_flags>"
>
>        * Child MON group of non-default CTRL_MON group:
>                "<CTRL_MON group>/<MON group>/<domain_id>=3D<assignment_fl=
ags>"
>
>        Assignment flags can be one of the following:
>
>         t  MBM total event is assigned
>         l  MBM local event is assigned
>         tl Both total and local MBM events are assigned
>         _  None of the MBM events are assigned
>
>         Examples:
>
>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>         non_defult_group//0=3Dtl;1=3Dtl;2=3Dtl;3=3Dtl;4=3Dtl;5=3Dtl;6=3Dt=
l;7=3Dtl;
>         non_defult_group/non_default_mon1/0=3Dtl;1=3Dtl;2=3Dtl;3=3Dtl;4=
=3Dtl;5=3Dtl;6=3Dtl;7=3Dtl;
>         //0=3Dtl;1=3Dtl;2=3Dtl;3=3Dtl;4=3Dtl;5=3Dtl;6=3Dtl;7=3Dtl;
>         /default_mon1/0=3Dtl;1=3Dtl;2=3Dtl;3=3Dtl;4=3Dtl;5=3Dtl;6=3Dtl;7=
=3Dtl;
>
>         There are four groups and all the groups have local and total eve=
nt assigned.
>
>         "//" - This is a default CONTROL MON group
>
>         "non_defult_group//" - This is non default CONTROL MON group
>
>         "/default_mon1/"  - This is Child MON group of the defult group
>
>         "non_defult_group/non_default_mon1/" - This is child MON group of=
 the non default group
>
>         =3Dtl means both total and local events are assigned.

I recall there was supposed to be a way to perform the same update on
all domains together so that it isn't tedious to not do per-domain
customizations. (And also to avoid serializing programming all the
domains the same way.)


>
>  .../admin-guide/kernel-parameters.txt         |   2 +-
>  Documentation/arch/x86/resctrl.rst            | 144 ++++
>  arch/x86/include/asm/cpufeatures.h            |   1 +
>  arch/x86/include/asm/msr-index.h              |   2 +
>  arch/x86/kernel/cpu/cpuid-deps.c              |   3 +
>  arch/x86/kernel/cpu/resctrl/core.c            |  25 +-
>  arch/x86/kernel/cpu/resctrl/internal.h        |  56 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c         |  24 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 714 +++++++++++++++++-
>  arch/x86/kernel/cpu/scattered.c               |   1 +
>  include/linux/resctrl.h                       |  12 +
>  11 files changed, 964 insertions(+), 20 deletions(-)
>
> --
> 2.34.1
>

This should be fine for me to get started with. I'll see if I can work
backwards from the patches adding the parsing code to see how I'll
work the software implementation in.

Thanks!
-Peter

