Return-Path: <linux-kernel+bounces-31622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7177C833154
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E973284B08
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9458ABF;
	Fri, 19 Jan 2024 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1HSI3xgy"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8875138E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705705777; cv=none; b=dMAsioTv7MgJp0tcHfg8x4XBi+kJ9oCjyjDW52FFCUzJUkkmr1QcGyApSRrYVAbmsxglK801XzX56gfeaMpIfYYv4IvDz3U0TPVgn1sdvFRdDGaZ/8iHLQlMkcJus6scc+euPfV0urqOCvT13x38cURjLCNaXctfb1R8Zh5CW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705705777; c=relaxed/simple;
	bh=F8dckIwZyijHfQTYznmnx0TKzYnWRTbezWzuYQEA1tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EawMoz1ftQ08XGk3oD7H638+j+LhYiVMvB7/H6V08u2FLSohAbulSLf6pjJ0gjx8MSvoUvtkauTHC4IpdvkubFBZ1xkEQOFg6XE3kpAGtzLhUU6pYLj7Txfqb855hsUU18vFt35rDxwP4JCKQ0k3QfBdCvhgu4ssIub6GLVhCh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1HSI3xgy; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a27733ae1dfso124356566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705705774; x=1706310574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GDVdXd1TBpHX2j7H0xPhMwXFKbgX32ui9QuTscsOz8=;
        b=1HSI3xgyaKkTNF1p4ztrXpr0yNZ1YMv7xaE2ir0Pkaa+os4PtPwa5m8HkbhCEl5t5h
         AErPmUztSTruGynddzpZu6r3LQvYQGl/WHaFzJCsypXSki6T4AsO4TMjfnCi+EN8b8zn
         Otqm2E0hzEjkCK1L2js3JIyvGbWITT+bybClGfCefeCViAZPM4PETqZjdS2tvC0HYbpS
         WPf8NkZvBpP3JHaT3RUsM4/5ijGE3fu5TRgvpU5cqTTYozUuEUXfH7A4vwoINUH71T5O
         FOeI3Cge6rvP4vZ8BNdpHBP9xBVZkTODs9DJgNijB9/7u7zhtbZYcRUEUPNkB/KbWpVw
         LDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705705774; x=1706310574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GDVdXd1TBpHX2j7H0xPhMwXFKbgX32ui9QuTscsOz8=;
        b=DFTYjtiRvpNCyXgUx3t8uH+WEn8EGvfoJg5kPpaZS55hJhpKrWjF1eWxJv46Up5F05
         0LEAoqA3/VDniQcwp4X0yorzFA//t/JeDuSzoor5kdFZx750NWj68ZX1HgzgpZ1XDWpK
         Df/vyW1bJLs0JlbviPMHPfJ2dUQfJbDHLKDn0KT4xf1C3jtbZNs6jVKlnNFPKO5OGwr9
         LSqQVC0wwUnB+H9KFAx5Qyrt3GcmA0FptVWt7yFuTY0YEEFfvvsCzxD8BScxs0bBOWV4
         1ac4h74YX0rG0g/RYvLCSArmxxUpmcDC2rsmcO6B8l2lvS3zj60boxyJUZzKAosVVvDp
         XDrg==
X-Gm-Message-State: AOJu0Yzf0Kt8lrosFZXrGSP2DSvofGrSeNbLPAAxI3e5s7fmMEyir3E7
	Ua6fhiiN7Edq+58k7bXs0SW2VAZ58AzbwuIXY7E1U+Zydx5478/x6lh5NuGOXrC+GqI0cMcno5H
	1F4eiwtLp3rce5KTdQzexgjpJyUe/oOYgGi1cq4BQUn1RufcgTliQ6Jw=
X-Google-Smtp-Source: AGHT+IG5kFYzk5BhWVbqGNrV3b6ymK+J1uwhd/il1MqA+wARoys+EzM4lGgVcseLNIDMe392mrgE+JaZYZFs6n5os/Q=
X-Received: by 2002:a17:907:c086:b0:a2f:bb33:915f with SMTP id
 st6-20020a170907c08600b00a2fbb33915fmr89840ejc.261.1705705773643; Fri, 19 Jan
 2024 15:09:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118181459.1663313-1-pranavpp@google.com> <CANDhNCqyugdsais9bzaL8RxTxyBgme4W2ZdfayaS8HbqBHJraw@mail.gmail.com>
 <87y1cldsgq.ffs@tglx>
In-Reply-To: <87y1cldsgq.ffs@tglx>
From: Pranav Prasad <pranavpp@google.com>
Date: Fri, 19 Jan 2024 15:09:22 -0800
Message-ID: <CACkwYU2psvrCKNKQBRngYtj3xRgnBo0wa1L644tq2nP+8tb-5w@mail.gmail.com>
Subject: Re: [PATCH] alarmtimer: Expose information about next alarm to
 userspace via sysfs
To: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>, sboyd@kernel.org, linux-kernel@vger.kernel.org, 
	Kelly Rossmoyer <krossmo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 11:38=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Thu, Jan 18 2024 at 14:11, John Stultz wrote:
> >   I'm always a bit cautious when exposing stuff to userland,
> > particularly if it's potentially racy as you mentioned in your
> > description. One thought I had was might adding a similar check
> > earlier in the suspend path on the kernel side provide similar benefit
> > (without requiring userland changes)?
> >
> > Basically, if I understand the problem:
> > echo mem > /sys/power/state
> > <kernel goes through suspending everything>
> > alarmtimer_suspend()
> >   if (next_alarm < TWO_SECONDS)
> >       return -EBUSY;
> > <kernel has to resume everything, and all that time was wasted>
> >
> > So if instead we did:
> > echo mem > /sys/power/state
> > enter_state()
> >    if (alarmtimer_immenent())
> >       retrun -EBUSY
> >
> > So the kernel would come back much faster if the suspend was going to a=
bort.
> >
> > I suspect you all have considered this already but wanted to
> > understand what issues that approach has.
>
> It has the same race issues as the user space readout has as far as I
> understand and it's much simpler.
>
> Thanks,
>
>         tglx

Thanks John and Thomas for the suggestions!

The reason I did not go ahead with this approach previously was that I
wanted to contain the changes to the alarmtimer subsystem. I see the
benefit in eliminating the dependency on userspace reading from sysfs,
hence I shall work on v2 for this patch with an alternate solution
where I expose a function from alarmtimer to be used by the suspend
prepare flow in kernel/power.

Regards,
Pranav

