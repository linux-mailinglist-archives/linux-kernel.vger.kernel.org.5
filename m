Return-Path: <linux-kernel+bounces-77335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4CE8603F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB851C2546B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFADA73F10;
	Thu, 22 Feb 2024 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RdNXGbOm"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EDE71755
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708634875; cv=none; b=ZKpVzL81NkPQTwtaqE2uf0q2zPjgF5HzRrozccbl7gkTDt0FOihoIbjrtP7d//fBwEfpYlz1kjOO7kpMJRFFvKzkMTUXch+ikVK63XngEGXZouGHK9COg7F+MAm8glDm8vlpap13BUblhH63+2YlQr6GBiCAnCZlXsRwIkYD5dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708634875; c=relaxed/simple;
	bh=QNoU6odUcLZ2SUGTbNvPVg8J+8QIs4NPY5wilaDCdEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SnK73FUenP+aKnLk7+AidO5x3tFeccMAMrOULfIYJbCcVv6gyIpjLKXstpPpdvxyYbg1hSk1chLYYhXq66fvREn+buRvYU+jze8n6e3gYq9FqYbCoXoODzOM/BVULMmbf15ycjkmXSPGKRHxzlMQCA6VUEer0fGutOw/lhWJvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RdNXGbOm; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so3303a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708634871; x=1709239671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSOJ7f8rYN1lEBD1fhEZ7+hLU6/OKYxXzZesaTmUBqQ=;
        b=RdNXGbOm33xTxjbJmwRBZPvNTlP1lUxXXksQ+9AeMW78WCXZrUIgd/MxgSdWwAESpk
         u+gif+kq0uid03R+1T09sju3bDnkbZcfJtSpoHerxVpsIDkJupAZ6r+3vBjEJ0rBVXlk
         4n/6jOA7rQ07kN6tlrSQqEiJs7Krg/5FGHxZrSa8dQY3gZBAk2tbMndict3iBr7dXfPx
         1bBqihDdj6fQ50ZtatPIb/Ius95MNp9cDhwJVZR2AwOM8HeAUtNR+CzNozVlXqSMsRFB
         eWEAPby4ec/upD8W7IXsKIcyIwKPqsncWWmRiCUs9Uf6YVi/JQ32j/aYtcMm/86ARlq+
         q4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708634871; x=1709239671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSOJ7f8rYN1lEBD1fhEZ7+hLU6/OKYxXzZesaTmUBqQ=;
        b=TsjvS0FLg38Wzu41DMfZiLYs+PRCRwXlKThBPGONS2Uv53MNShcbxEpEPytSIIQQDi
         +udh85AXjQ3P41LRiJfAvt7wRHvH60HO3YI+NjP3RiX/8MdrPGxPyqtyIWeWzVI3DAqz
         tYSAdtKUhveZpjW1FIFG06mJXuV4Wg/bcB/XuKJXE2x4NiJ1py3vSxOIwArnibC3IAX+
         YAiVgtxN0qcV9nOTiYIv7STdZvaVaU3XOb64/LwfN4NTcDXhRJg+pAZx9tYJuX1OuUx0
         lJTZGjwhWai0y+RjJHd4LNkQQE8yzPd+3jJNl0Dc8lGEWgq0kumhzAXJ33rkvZq3PupX
         QfoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVStv1727KyV3JWP6VxCoUsjnAboO7YMVRYsRlh1EIjq50ynTC8KNRRhGGRdmYgsjc5rymP1h/wWiMb7NPVqI6XbtVgTWUVgzEU5rKC
X-Gm-Message-State: AOJu0YwLaZiWvdLJheYchwu76uHO9h8rE+a+R4gTF1Z2bN8/eAJDMHeT
	XwPjAtXbqOfCosQIOybm3gVF+JlK8WxQKomi+yJ/9UIag8iDOIza9yz8YtXevmiWlCb1WQbxdFy
	5YRaWGmd8CdbguScidx91JwJYGGA0MsTqKKg=
X-Google-Smtp-Source: AGHT+IGO+7NsjTptMN3hqf7B6LQhfC/7VyjDY6ByXIkJOa7NfTEn4QqWupcwV56XCgJEf6Eeb4U9SjsuHYzoAuHshf0=
X-Received: by 2002:a50:bac2:0:b0:563:f48a:aa03 with SMTP id
 x60-20020a50bac2000000b00563f48aaa03mr521773ede.2.1708634871424; Thu, 22 Feb
 2024 12:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222051253.1361002-1-jstultz@google.com> <8734tkfrzz.ffs@tglx>
 <CANDhNCoHqX9fo5e=K7_74YSmV8-T2tE-Obu+phhqy+n2bqc4QQ@mail.gmail.com> <87wmqwz1bz.fsf@jogness.linutronix.de>
In-Reply-To: <87wmqwz1bz.fsf@jogness.linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Thu, 22 Feb 2024 12:47:38 -0800
Message-ID: <CANDhNCrWjPL4zW4=uRcFJNFZX6zxC9_GM0uQcNJ=WC9Q6ZS-ag@mail.gmail.com>
Subject: Re: [RFC][PATCH] hrtimer: Use printk_deferred_once for
 hrtimer_interrupt message
To: John Ogness <jogness@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:33=E2=80=AFPM John Ogness <jogness@linutronix.de=
> wrote:
> On 2024-02-22, John Stultz <jstultz@google.com> wrote:
> > On Thu, Feb 22, 2024 at 7:17=E2=80=AFAM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> >> On Wed, Feb 21 2024 at 21:12, John Stultz wrote:
> >> > With qemu, I constantly see lockdep warnings after the
> >> > hrimter_interrupt message is printed:
> >> >
> >> > [   43.434557] hrtimer: interrupt took 6517564 ns
> >> > [   43.435000]
> >> > [   43.435000] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > [   43.435000] [ BUG: Invalid wait context ]
> >>
> >> Do you have PROVE_RAW_LOCK_NESTING enabled?
> >
> > Yes, I do. Let me know if there's anything else you'd like me to try.
>
> This option is to "ensure that the lock nesting rules for PREEMPT_RT
> enabled kernels are not violated."
>
> Since you are not running a PREEMPT_RT enabled kernel, these warnings
> are irrelevant for _your_ kernel.

Ah, mostly I've been running with all the lockdep options as part of
my development of proxy-exec series, as I want to avoid accidentally
introducing any new problems with my work.

> >> > I thought the new printk work was going to resolve this, but
> >> > apparently not
>
> Yes, it will, but it is not all mainline yet. The full printk rework is
> only available as part of the PREEMPT_RT patch series [0]. With that

Ah, my apologies! I know the printk changes are *very* eagerly
awaited, but I haven't been following it closely, and at plumbers I
had the mistaken sense that the key parts had been queued to be merged
in 6.8.

> If you really want to test lock nesting for PREEMPT_RT, I recommend
> applying the PREEMPT_RT series and keeping PROVE_RAW_LOCK_NESTING
> enabled. Otherwise, if you do not want to apply the PREEMPT_RT series, I
> recommend disabling PROVE_RAW_LOCK_NESTING.
>

Ok, will do.  Though would it make sense to hide
PROVE_RAW_LOCK_NESTING under BROKEN or something upstream in the
meantime?

Thanks so much for the response and your efforts on the printk improvements=
!
-john

