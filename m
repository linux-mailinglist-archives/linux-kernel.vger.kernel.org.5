Return-Path: <linux-kernel+bounces-97436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E208876A71
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F09B1F215D3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE06140861;
	Fri,  8 Mar 2024 18:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9YowF0l"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D048CFC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709921122; cv=none; b=I+1E7Wv2VeDsbBhhh1wq3Wyg0anaGvMqGNY5fmpY5+bkVkhzkp1DaOe+jreffOeDPjtCYDGx7mFWAjvb8SCQz0AZheNI8Ln6hvrFDR0gmB50BlWVMibv2PjMDl1qgDuk/u3wS3T7AfX9Ggx0D4f1x4DN/aqlsAXN8NGtS+b91Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709921122; c=relaxed/simple;
	bh=k4qoNEgTAI/NBFOIEmoqhhmmaXxIBENDE2kiy+x+1J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1iRIipfKRcqGzb7hecMrDVfTNULCxK4jpOgoK62XEDL6fisAZdyLRj3xcOGaDNxQXoP+M5OvRTGsdfzGcKrOgv4L7vttANb7+FRgyamHaLfp8o/QY7qWmCRERFhJlBdD81MMbWRleZ2nX78DHEGXkUAwCPuytG7JL7EI/Hb5H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9YowF0l; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so287a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 10:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709921119; x=1710525919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+erbz9PPCR1ZEYV82oV8Vbs5yNtZyW1/t5a2qxXOXM=;
        b=K9YowF0lhwms9+2vwe2OYR1Sh3DP/5QSN50Q89eDfBzMDW38fwh0yD8VvKS2ISWjqA
         VQNE9d8wgJireGAALVpadhzleHYwchqXk27LVS3QoLerj/WPbyqPr8XjPkJLe7+Ugul9
         Ra2nFMiU9dvsrwySqnU8e+V4bnJd6Yofr+MaspH58uKHmiy1HwF/pzVr3uVrUXoGHvH0
         Nxzk2+JnXHZ4zm944WhxhxFmbIGRyYt+JshlzLNo4/euHxH8PxQbd9y7YM9ydoqVp8eF
         h0HDc3SS1jXXeBU6H0tF2twCLC23eXnCF8u/1eyGFHtBpOIIFo663OUvm9nSYd/5WYwu
         KR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709921119; x=1710525919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+erbz9PPCR1ZEYV82oV8Vbs5yNtZyW1/t5a2qxXOXM=;
        b=AEAFYqxCMbNhVQ50xC87xyVm6I6/7Og8T5e8IkVdvXBuQ9fnBv6p3bscYP1aNz9zMd
         DuyWuvGmbjoCp0UPR1YKAkz36JuRf9Cp+QPcMuvEF0v2goIJt8VrmMp3MkYmKRZGFCI/
         elpRnBwHQ1vSjr6BsIFp2q3d8ew5gBZ1MNFv10SubgFJI2nImXitPHrhdiEYhNpDdsuV
         YaSrWrkoH7IEhNeKozj1qhnZVNXxxmJDP1sXv07T2Q1CkAwwdGsKnFuTavxgHjm2P7GS
         EkBahbJ6Jrgdby249Oiw5TzdbF+M/G8Tkbx89p4HK2qb+VDHMgZ876v87dnqN+YWeV2V
         8NUA==
X-Forwarded-Encrypted: i=1; AJvYcCVmtnoBAECBttbvQAylj33YjFFNG9axz1CCHXC3ZBMIKdHaHafEQfNjqD4NYhjz4l1j+8M4bdeuJ4FkEazj1JuTDskQNRy6j/V5CEz/
X-Gm-Message-State: AOJu0YzieZFhR3qGylHzRY/S/a3YlRWM85I3/QVCPCM68vI2K3QOy5D0
	0bZKRjfZVTRbq28wS7JltYzCLnKC+/KFC9y503RFZffEK+LgdRwNyTLJCAQDA4fm5+ePa9SbGDZ
	r1q9OX/Hj/yYSMLS8E4I+tMfJpEI+spoKQN9F
X-Google-Smtp-Source: AGHT+IGmkrwNAWPQ65TNLci3z2Qo5DY/oK3TNmr5uwh7kn4VJhIp0suR062ltivW/oexJghPveJmlU3qllXt7eV0lVc=
X-Received: by 2002:a05:6402:2022:b0:568:271a:8c0f with SMTP id
 ay2-20020a056402202200b00568271a8c0fmr267936edb.7.1709921118696; Fri, 08 Mar
 2024 10:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223143833.1509961-1-guanyulin@google.com>
 <a299118d-eeec-40b4-9a3d-48dc40f34e12@gmail.com> <CAOuDEK3wP6zhEwgUn5zSedtwTYVFaJeBfeXkSg897EhpGP9=ig@mail.gmail.com>
 <3208c5b9-5286-48d1-81ab-cc3b2bc4303e@gmail.com> <CAOuDEK39Bdru5wAbxW-g2c=POgRxZwdQzPO5uNXP96AfSyA6pw@mail.gmail.com>
 <7292dc5c-dff0-45f0-99b1-f1687451b23f@gmail.com> <CAOuDEK2OtAO7GqPzWkdC=SARkuHYGzqW4iPdFfMx8dyw4Cy+Lg@mail.gmail.com>
 <2024022901-getaway-bacon-b805@gregkh>
In-Reply-To: <2024022901-getaway-bacon-b805@gregkh>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Sat, 9 Mar 2024 02:04:00 +0800
Message-ID: <CAOuDEK31NFNErYcGr-h0KA7=RkXQ2d5nV3wT6q6LqdGCY4tcxw@mail.gmail.com>
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, rafael@kernel.org, pavel@ucw.cz, 
	len.brown@intel.com, andriy.shevchenko@linux.intel.com, rdunlap@infradead.org, 
	james@equiv.tech, broonie@kernel.org, james.clark@arm.com, 
	masahiroy@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 4:34=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Feb 29, 2024 at 05:08:00PM +0800, Guan-Yu Lin wrote:
> > We want to introduce a mechanism that allows the Linux kernel to make
> > power transitions for the peripheral based on whether the other
> > operating system kernel is actively using it. To achieve this, we
> > propose this patch that adds a sysfs attribute, providing the Linux
> > kernel with the necessary information.
>
> Don't create random user/kernel apis in sysfs for no good reason just
> because it is "easy" :(
>

We initially considered using sysfs because it could provide a
universal interface regardless of which operating system kernel shares
the device with the Linux kernel. This would allow users to modify the
feature through simple sysfs interactions. However, the current method
of using information in sysfs doesn't seem to integrate well with the
existing system power management framework. Could we refine how sysfs
is used in system power management to enable cross-kernel
communication? Alternatively, should we avoid exposing the information
of whether a device is used by multiple operating systems to user
space?

> If the "other operating system is actively using it" isn't able to be
> detected by Linux, then Linux shouldn't be able to change the PM state,
> so this sounds like you need to fix your Linux driver to properly know
> this information, just like any other device type (think about a sound
> device that needs to know if it is being used or not, nothing different
> here.)
>

I think the variable `usage_count` in struct `dev_pm_info` records
whether the device is being used. Could we leverage this information
in the design? We could modify the device tree to record which devices
are shared across operating system kernels. Then, we could
conditionally skip system power management steps for those devices if
they're actively in use. We'll need to carefully consider potential
corner cases and assess any impact on runtime power management. If
this proposal seems worthwhile, I can prepare a more detailed v4 for
discussion.

> So please post your Linux driver and we can see what needs to be done
> there to get this to work properly, odds are you are just missing
> something.  Have a pointer to the code anywhere?
>
> Also, as you know, we can NOT add interfaces to the kernel without any
> real user, so without a driver for your hardware, none of this is able
> to go anywhere at all, sorry.
>

The Linux device driver we're using here is the upstream xhci driver.
We configure only partial interrupts for the controller in the device
tree. This prevents the Linux kernel from accessing other interrupts
handled by another operating system kernel. Consequently, the
controller can function normally even with two operating system
kernels accessing it, as long as we completely disable system power
management functionality.

> thanks,
>
> greg k-h

