Return-Path: <linux-kernel+bounces-86368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632F286C480
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867F11C20DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B22957318;
	Thu, 29 Feb 2024 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pgm6ujn4"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B743057303
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197694; cv=none; b=FSq0otzydIIpqV03XnshPHunkW3vHYRB0syISr6XLiQmqCLdM3614tx1mDDrEfI+QHoLg++s7PXlBvrPkHGJyvNQFv54Xl30cz5xfEN363+PlTN3gCQ1rg3CTHjdpMisw0goVd74vbt6F2llurLrkUir0XOe4RN7GIP+jS147bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197694; c=relaxed/simple;
	bh=l46nLxdSX68XgH8CZU5Rl2axE2hrdul4SJ2CI/R14vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1UD17jpin4bLR4Y7eXScwkzGH9X8eiRXmRz2ULPHm6943eWuHKbfQCenCrdeRQGea5NguYnwLI3vftmHAkaCPbw8slASfRTeSGxrbwqDBCC0EB3CTYhkmvQDJDkPKHpfyFOopgYySj+kWVP1LaGDI4Pjm3b3zHeKBXDDX1keyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pgm6ujn4; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-428405a0205so233831cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 01:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709197692; x=1709802492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/bglfg8iaZ/rtcaw/aGcp7YxohzYTHpnKNEq43joN8=;
        b=pgm6ujn4ETswDqt+7XSjqpBgxNu0OYqvXXJaDv543M9NAi9TeSIK5Z+E7aooZByXBA
         kWhZkk/Gqb4wDwhWGNRqa/BuL/fzsQGA5tADdiNCyIhsI5yLHBmxgVnaqFwZ2o70TAok
         VXz2Oz4AB8U4wwEPXsgO0YMwAXCarQC/liUJMWXASV+O/WtzPZTcM/VVARE0XbAOrEFv
         H+U9EVfU3bcRZrw9+ZjHNLXUOgBmf7ZKnD53eUOERIwhnBWn3nxwhcmDBShcqsKP1zMr
         0SFZZVlLSctezljcKldMyMr8Tb7YsYUK9epiY7wwVVSSjSJ3N3UqjxjdZutdG8EESrIq
         ShUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709197692; x=1709802492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/bglfg8iaZ/rtcaw/aGcp7YxohzYTHpnKNEq43joN8=;
        b=tss4FctE1EinKiKN+92DxBltA2eKqFyCCyuZXeQpefnoiPEw4xVIV6nwSnYjkWsDl0
         hxaE6g10WxGI/9UPgwXRwPU8zntAS/tmhaAn5jBDo0jBBpAkNhUiOlzL/GiolNHpmIgG
         pxhvwblriYoYIqxfiUn29yMgmzV0IvHFSHya3lEBh5h5evFU+s1LetxmKuqWRULE14Li
         xETfUsIh8s1B35JWLpSwG2DLWVrxnppZAjJpwuOWeZ0LWR8SRDgT75xOo1yxHyx9583T
         i5ApUA6w8LN3qaaxI8sfQDZgAmETf+M28zVsmCVTsXkdveisTAio31cPaYUZj92PSTbC
         Wx5A==
X-Forwarded-Encrypted: i=1; AJvYcCWR8tdz4+O2iWyCUjRCGiu3uLyYu6DMoqA16oanHFNI5iNvfOCpFSaFH/crUVNfhlvxc2eb00b+YGc3wuBlfEiw7CVlmpBkBPfzc+Y4
X-Gm-Message-State: AOJu0Yyi0rI7HARWp1lhmnMWtygZbkgpeXN2wq16y1NtuuUw0Nz7FTkZ
	pkWAHi90uScdKyY5COJ5ukY0lsJ8oJ+19Hgx715oRCTSt4lLmhDYqCzW3+0+RcBKvV6P1QNfE54
	Taew416YAWRmi9Cv8VzyPmc/MO53lJES/iqaF
X-Google-Smtp-Source: AGHT+IEWAaS+o9scYAENznVavc+PcUbOTVQl9bOg949Fz0km2uV3Q+uIr4IOPmFLnlCxM9Z0t2tEDPhGwIkar5J/3bM=
X-Received: by 2002:ac8:5fc4:0:b0:42e:b6c3:3e71 with SMTP id
 k4-20020ac85fc4000000b0042eb6c33e71mr179293qta.28.1709197691505; Thu, 29 Feb
 2024 01:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223143833.1509961-1-guanyulin@google.com>
 <a299118d-eeec-40b4-9a3d-48dc40f34e12@gmail.com> <CAOuDEK3wP6zhEwgUn5zSedtwTYVFaJeBfeXkSg897EhpGP9=ig@mail.gmail.com>
 <3208c5b9-5286-48d1-81ab-cc3b2bc4303e@gmail.com> <CAOuDEK39Bdru5wAbxW-g2c=POgRxZwdQzPO5uNXP96AfSyA6pw@mail.gmail.com>
 <7292dc5c-dff0-45f0-99b1-f1687451b23f@gmail.com>
In-Reply-To: <7292dc5c-dff0-45f0-99b1-f1687451b23f@gmail.com>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Thu, 29 Feb 2024 17:08:00 +0800
Message-ID: <CAOuDEK2OtAO7GqPzWkdC=SARkuHYGzqW4iPdFfMx8dyw4Cy+Lg@mail.gmail.com>
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	rdunlap@infradead.org, james@equiv.tech, broonie@kernel.org, 
	james.clark@arm.com, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 1:57=E2=80=AFAM Florian Fainelli <f.fainelli@gmail.=
com> wrote:
>
> On 2/27/24 00:56, Guan-Yu Lin wrote:
> > On Tue, Feb 27, 2024 at 2:40=E2=80=AFAM Florian Fainelli <f.fainelli@gm=
ail.com> wrote:
> >>
> >> On 2/26/24 02:28, Guan-Yu Lin wrote:
> >>> On Sat, Feb 24, 2024 at 2:20=E2=80=AFAM Florian Fainelli <f.fainelli@=
gmail.com> wrote:
> >>>>
> >>>> On 2/23/24 06:38, Guan-Yu Lin wrote:
> >>>>> In systems with a main processor and a co-processor, asynchronous
> >>>>> controller management can lead to conflicts.  One example is the ma=
in
> >>>>> processor attempting to suspend a device while the co-processor is
> >>>>> actively using it. To address this, we introduce a new sysfs entry
> >>>>> called "conditional_skip". This entry allows the system to selectiv=
ely
> >>>>> skip certain device power management state transitions. To use this
> >>>>> feature, set the value in "conditional_skip" to indicate the type o=
f
> >>>>> state transition you want to avoid.  Please review /Documentation/A=
BI/
> >>>>> testing/sysfs-devices-power for more detailed information.
> >>>>
> >>>> This looks like a poor way of dealing with a lack of adequate resour=
ce
> >>>> tracking from Linux on behalf of the co-processor(s) and I really do=
 not
> >>>> understand how someone is supposed to use that in a way that works.
> >>>>
> >>>> Cannot you use a HW maintained spinlock between your host processor =
and
> >>>> the co-processor such that they can each claim exclusive access to t=
he
> >>>> hardware and you can busy-wait until one or the other is done using =
the
> >>>> device? How is your partitioning between host processor owned blocks=
 and
> >>>> co-processor(s) owned blocks? Is it static or is it dynamic?
> >>>> --
> >>>> Florian
> >>>>
> >>>
> >>> This patch enables devices to selectively participate in system power
> >>> transitions. This is crucial when multiple processors, managed by
> >>> different operating system kernels, share the same controller. One
> >>> processor shouldn't enforce the same power transition procedures on
> >>> the controller =E2=80=93 another processor might be using it at that =
moment.
> >>> While a spinlock is necessary for synchronizing controller access, we
> >>> still need to add the flexibility to dynamically customize power
> >>> transition behavior for each device. And that's what this patch is
> >>> trying to do.
> >>> In our use case, the host processor and co-processor are managed by
> >>> separate operating system kernels. This arrangement is static.
> >>
> >> OK, so now the question is whether the peripheral is entirely visible =
to
> >> Linux, or is it entirely owned by the co-processor, or is there a
> >> combination of both and the usage of the said device driver is dynamic
> >> between Linux and your co-processor?
> >>
> >> A sysfs entry does not seem like the appropriate way to described whic=
h
> >> states need to be skipped and which ones can remain under control of
> >> Linux, you would have to use your firmware's description for that (ACP=
I,
> >> Device Tree, etc.) such that you have a more comprehensive solution th=
at
> >> can span a bigger scope.
> >> --
> >> Florian
> >>
> >
> > We anticipate that control of the peripheral (e.g., controller) will
> > be shared between operating system kernels. Each kernel will need its
> > own driver for peripheral communication. To accommodate different
> > tasks, the operating system managing the peripheral can change
> > dynamically at runtime.
>
> OK, that seems like this ought to be resolved at various layer other
> than just user-space, starting possibly with an
> overarching/reconciliation layer between the various operating systems?
>

We achieve cooperation between operating system kernels by assigning
interrupts to corresponding kernels, and only one kernel could write
commands to the peripheral.

> >
> > We dynamically select the operating system kernel controlling the
> > target peripheral based on the task at hand, which looks more like a
> > software behavior rather than hardware behavior to me. I agree that we
> > might need a firmware description for "whether another operating
> > system exists for this peripheral", but we also need to store the
> > information about "whether another operating system is actively using
> > this peripheral". To me, the latter one looks more like a sysfs entry
> > rather than a firmware description as it's not determined statically.
>
> I can understand why moving this sort of decisions to user-space might
> sound appealing, but it also seems like if the peripheral is going to be
> "stolen" away from Linux, then maybe Linux should not be managing it at
> all, e.g.: unbind the device from its driver, and then rebind it when
> Linux needs to use it. You would have to write your drivers such that
> they can skip the peripheral's initialization if you need to preserve
> state from the previous agent after an ownership change for instance?
>
> I do not think you are painting a full picture of your use case,
> hopefully not intentionally but at first glance it sounds like you need
> a combination of kernel-level changes to your drivers, and possibly more.
>
> Seems like more details need to be provided about the overall intended
> use cases such that people can guide you with a fuller picture of the
> use cases.
> --
> Florian
>

Let me introduce the scenario of our real-world use case. The
peripheral (controller) can issue multiple interrupts, which are
handled respectively by two operating system kernels (Linux and a
non-Linux). In addition, only one kernel can issue commands to the
peripheral. Although we have successfully distributed control of this
peripheral between the kernels, Linux's system power management still
applies power transition rules to the entire peripheral without
awareness of the other kernel's activity. In other words, the Linux
kernel has partial responsibility for the peripheral's functionality,
but its power management decisions affect the entire peripheral. This
can potentially interfere with the non-Linux kernel's operations.

We want to introduce a mechanism that allows the Linux kernel to make
power transitions for the peripheral based on whether the other
operating system kernel is actively using it. To achieve this, we
propose this patch that adds a sysfs attribute, providing the Linux
kernel with the necessary information.

