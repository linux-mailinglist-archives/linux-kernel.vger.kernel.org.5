Return-Path: <linux-kernel+bounces-130509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DC0897911
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6BE51C23460
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8843C155313;
	Wed,  3 Apr 2024 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Bf9yguDD"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AA01552F8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172920; cv=none; b=qHqBMpSnPoaYVyvcICdznTuE8V9FDkV2cEyfXC4ugBVGhQhDQcQyMDPTJp3WyQsx87cxA0uHtsnqCjRH7jtOdjSWTF9AoRBz5kMBZp48DKwDTu5zoKfaeNZQMgm1lzC20+N1e9jzQymjqOHuYKk055Jd2I1WgoreJbNFuZdMTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172920; c=relaxed/simple;
	bh=Wz+XAmCjUc8PDsaYphxSsci9OJCLtebQHEYs8FmStqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyZM3DoX23BzCPxe2pgWA0SE5djJaJxfl2TFrqr/dzp1t2EUozYFI/wpByTd1aBdQwi14Q8DQ2B5f2BmlCrNcede2Uq8xUCn/wBsiHadbhqBAU7SugjT92Qxpg2VoqMiimUhppJaitQmri2NT4efeQdrXlWRP/6jGPvl8KOhT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bf9yguDD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-413f8c8192eso21425e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712172917; x=1712777717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz+XAmCjUc8PDsaYphxSsci9OJCLtebQHEYs8FmStqA=;
        b=Bf9yguDDXSrI+aNRMNFLcLdKGpG2myuUFtGLECbxeLCXpHJvnMZi2S9citztBNOOFJ
         MDiaUinEQZZZv5uOtBB2gaOvgJ+XDcuk+B5Rq4s+BOlVVLMqvMDew8mKSpStNAjDwmiW
         8wQMX6od3iJZ8VXCmgARiA4BwHcRExdNhmke6dUjnnEiIqqlhuHgDVhxCqhFGLIa8ETH
         EnPwwUzr3TIl5o4MBU65qKD3zzHltVFw8PiEfmrHeQ2r0Zxqo8cgQuksooJNBIlmms5Q
         jojbsGkunr1ibtn1oVX/vKYg8d1zG/Hdxubz0LNB/y88nutoLoo+t8H/dSgzsMqaXhCv
         f5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712172917; x=1712777717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wz+XAmCjUc8PDsaYphxSsci9OJCLtebQHEYs8FmStqA=;
        b=ghVt0D8y9qBp24s0rhiWXokTyoVEf8zkfkXWsxd+TGCjzmjFdy9f0L0oxn4ipuJqK4
         slICXvKeMak4lbmccMbiJvRedW0LnqITIk3sgiWkJyJsk1fY63lrDT9yRof/7s4/buAg
         ot8g8UtbpIMuKHixWBA7cqlxxuibA0sByBAa2DXaU75gtQXhOSlSWu7B2FuZQ49dMXJb
         DFL9Wq1DG31NSDT1iAFieEwe9S5hKJwJLo+PTYYLVP03OcllSKn5tQEc0Gm5drFhZzDr
         6dYE9Gu3nyWI4ZXLasRoF0UvemlbYxdZvhP7M9ai/Y1bOThucbLFTD2iQuXP3a1lHLTA
         YwFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkrBcjeRXOYEpSOVv9QY0qqGH09xt9CEtcbcRwlIPAL1k5gcqaDWJcKGoqGmIoC4prFdzZ55oqQmmkBG9bNFL4hv2nXz2y+Z/NR5oB
X-Gm-Message-State: AOJu0Yw1xcougkcGrP3t0T1CJjnBQf4l3Tmyav39ZHClczi/HRz9yfNQ
	bjM1lYOQWNc9KfkMjhYXg71700tjokDiYd8HcQi/ksxUrbH0VRjCgkhD5NSgR9218WqsUvoy/T9
	gWxc9Z2u+lR82wTan99SiI5z9uXVUy5+eE7I=
X-Google-Smtp-Source: AGHT+IEzkSBTxCD4EO3RWvVhNTCuadU+0PmJnuJ2msK4apHkHqQwAY0UNc4MQ7EFCG3/6oJj5BZZcSRNAnuoqXIEKLg=
X-Received: by 2002:a05:600c:1d25:b0:416:1eba:175f with SMTP id
 l37-20020a05600c1d2500b004161eba175fmr299989wms.6.1712172917250; Wed, 03 Apr
 2024 12:35:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87sf02bgez.ffs@tglx> <87r0fmbe65.ffs@tglx> <CANDhNCoGRnXLYRzQWpy2ZzsuAXeraqT4R13tHXmiUtGzZRD3gA@mail.gmail.com>
 <87o7aqb6uw.ffs@tglx>
In-Reply-To: <87o7aqb6uw.ffs@tglx>
From: John Stultz <jstultz@google.com>
Date: Wed, 3 Apr 2024 12:35:04 -0700
Message-ID: <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Marco Elver <elver@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	kasan-dev@googlegroups.com, Edward Liaw <edliaw@google.com>, 
	Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 12:10=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Apr 03 2024 at 11:16, John Stultz wrote:
> > On Wed, Apr 3, 2024 at 9:32=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
de> wrote:
> > Thanks for this, Thomas!
> >
> > Just FYI: testing with 6.1, the test no longer hangs, but I don't see
> > the SKIP behavior. It just fails:
> > not ok 6 check signal distribution
> > # Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0
> >
> > I've not had time yet to dig into what's going on, but let me know if
> > you need any further details.
>
> That's weird. I ran it on my laptop with 6.1.y ...
>
> What kind of machine is that?

I was running it in a VM.

Interestingly with 64cpus it sometimes will do the skip behavior, but
with 4 cpus it seems to always fail.

thanks
-john

