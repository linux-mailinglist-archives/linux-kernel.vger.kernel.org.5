Return-Path: <linux-kernel+bounces-130170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ECF8974DF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C688284FD6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91F114D459;
	Wed,  3 Apr 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9brMdbB"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B0714D285;
	Wed,  3 Apr 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160500; cv=none; b=LJ63jxwd6v7b91oK5e2beD6hPnhpkY5tkQu46GclVuukL0epkiIFmKvTylzCxdbdcwuCly3LAXR8DVY5RAbaFrIS4kU/NeMHO8DlnBwFAJed4A2vrNhMDMn0SpygDkkZUZPMl26JPnKEGszXFvN/Id13bPgTwyj3v+UQgbK23z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160500; c=relaxed/simple;
	bh=IqjH8ZsjjXcHWdkBguAM3YqmROLjZcQ6NsU/4jQD6gI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UO7imUCjOZlmWg96t14mzS+4VduDLWLA4YRS5EVmhSrkdcLiPW1Sh1ZaWBvZVdaCIE7mWXkF2LkzoMHDiwhP7vrQaeeBkUJR0qqoOGUYgSMpWSwsotMSRq3p3G8RdE+a46X9VG9n1XOdrS+hSOhFVxklVOR6gw7+lmUwKDVuGmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9brMdbB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e0878b76f3so9670575ad.0;
        Wed, 03 Apr 2024 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712160498; x=1712765298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTovBIMigzMxozJjoOLniaoDgNINuOLPvVuUktpfkdo=;
        b=U9brMdbBtIpFXuAaUAzc+xfDhWzerujWt1V6vRfsReSSk1ANA98VfSShwTOVft7ecw
         ghC2B7pvRnBGwaBra4zHDiu5LI3SOExtHvrZGAF9ZQmflcX/J2YJ8PgYfI4vTP6C/O4O
         f/fYnHQqcHh22VUoFcLPHDkavJE5BOAJ5el37NbvXeSJb16GWnp1s+XdwObb+hcR0Qo5
         3s+gosQSM9Ey33hY+0qoo/X5osJRU3SqLBlRTV/Uj2Z/rNQPxf7tVkL3Lc5nzH1k1E+a
         0zApEGli8c/MpjFn9IMTxAYqtJbQMs1JjGw9Dnqle1eh1j03OTaHFX/jefMxOJtSrPIB
         NI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712160498; x=1712765298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTovBIMigzMxozJjoOLniaoDgNINuOLPvVuUktpfkdo=;
        b=ovAUfql9dmP95LyTTOI3Ghd+/RfhisAtKsw6irWO4wts7Etyra4bIl+9flwd18m1XH
         kFDW2GGkwBjJ0ctWfLZvotfm9h4vJQsZivDd4hEwrTQEEAQ2ZwQE0Zi25V+5WRyqXy48
         P9gQ3TfCQgppS3cNkMdKmqxxyXMYzzFxzvQLdpOFG8/XvB3Nzt5iTyDTMcCafM3eKH+C
         OYH57cfggzqNttKhbuasUw2Vrusil2e5/IyP02QyeZ0pzGVF3cq0GSUYGfpwOdgGaJKn
         a56x/KSX8UK7gEd1dcZDygXx/+j7LDM1N74/2D5coACsNqpPjlqJUBDV0PkEAVCHgmSJ
         jmUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj98e6jIW8VjsTT8yZXz0mha2KK7ejkqq6s6KyvNf4QDI6ykdeiwBIo28NaSA2Pg/QjonI6QFwRDFhLRCVbBoUh4zlaxksHXFPxb5DNHj3TpNKOWmrgwg34Nc1CDHS3y46
X-Gm-Message-State: AOJu0YwapkgQ9yx2qIcpFYxoxX5Gc2tplHzLnel839eiseMDQJpV91oc
	/Ur2ICrbgRc/ioxoGjCs9QnwHMrHLordqS4QpE4PuV8EQKGdF6ByBwzlAICrpRpvDvnfYg9UYdl
	gVtYa7gOFHmP8MqE/z4gkgejLnifFVTDp
X-Google-Smtp-Source: AGHT+IHuSUMdO6pjLJbvSTmow/ClVgPEQqkEXbtL28DUnlywZ0RXRnPF2GaO1+aK8oJNbPCtgglv5tnLFgZeYisBReM=
X-Received: by 2002:a17:903:32c8:b0:1e0:b628:a752 with SMTP id
 i8-20020a17090332c800b001e0b628a752mr4121467plr.7.1712160497829; Wed, 03 Apr
 2024 09:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240331041830.2806741-1-andrii@kernel.org> <Zgp+lYLOZU3OkO7w@gmail.com>
 <CAEf4BzZEuDRt=dLN79uJ0EwQcxuxCp8LZx1ayNBsw82BytPTqg@mail.gmail.com> <Zg0N87sfBdB5Cydk@gmail.com>
In-Reply-To: <Zg0N87sfBdB5Cydk@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Apr 2024 09:08:05 -0700
Message-ID: <CAEf4BzbGvhjwGCxQUt7fHrxdJbk00K6GnE_AjBEffDAak=7BaA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] perf/x86/amd: add LBR capture support outside of
 hardware events
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@linutronix.de, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, song@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 1:06=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrote=
:
>
>
> * Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Mon, Apr 1, 2024 at 2:30=E2=80=AFAM Ingo Molnar <mingo@kernel.org> w=
rote:
> > >
> > >
> > > * Andrii Nakryiko <andrii@kernel.org> wrote:
> > >
> > > > Add AMD-specific implementation of perf_snapshot_branch_stack stati=
c call that
> > > > allows LBR capture from arbitrary points in the kernel. This is uti=
lized by
> > > > BPF programs. See patch #3 for all the details.
> > > >
> > > > Patches #1 and #2 are preparatory steps to ensure LBR freezing is c=
ompletely
> > > > inlined and have no branches, to minimize LBR snapshot contaminatio=
n.
> > > >
> > > > Patch #4 removes an artificial restriction on perf events with LBR =
enabled.
> > > >
> > > > Andrii Nakryiko (4):
> > > >   perf/x86/amd: ensure amd_pmu_core_disable_all() is always inlined
> > > >   perf/x86/amd: avoid taking branches before disabling LBR
> > > >   perf/x86/amd: support capturing LBR from software events
> > > >   perf/x86/amd: don't reject non-sampling events with configured LB=
R
> > > >
> > > >  arch/x86/events/amd/core.c   | 37 ++++++++++++++++++++++++++++++++=
+++-
> > > >  arch/x86/events/amd/lbr.c    | 11 +----------
> > > >  arch/x86/events/perf_event.h | 11 +++++++++++
> > > >  3 files changed, 48 insertions(+), 11 deletions(-)
> > >
> > > So there's a new conflict with patch #2, probably due to interaction
> > > with this recent fix that is now upstream:
> > >
> > >    598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability"=
)
> > >
> > > I don't think it should change the logic of the snapshot feature
> > > materially, X86_FEATURE_AMD_LBR_PMC_FREEZE should be orthogonal to it=
,
> > > as the LBR snapshot isn't taken from a PMI.
> > >
> >
> > Yep, seems like there was a parallel change to related code in
> > perf/urgent branch. And yes, you are right that it's orthogonal and
> > doesn't regress anything as far as branching and whatnot (just
> > retested everything on real hardware). So I've rebased my patches on
> > top of perf/urgent, will send v5 momentarily.
>
> Thank you - it's now all in tip:perf/core and lined up for v6.10.

Great, thank you!

>
> > Sorry for an extra round on this.
>
> Not your doing really - just crossing patches.
>
> Thanks,
>
>         Ingo

