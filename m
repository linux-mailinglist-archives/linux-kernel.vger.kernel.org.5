Return-Path: <linux-kernel+bounces-108693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C89E8880E93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C171F23244
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB673BB36;
	Wed, 20 Mar 2024 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7/ZfMUK"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7583B1AB
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 09:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926986; cv=none; b=AQk6hBwYy8MwjoxheFUdhomDkgEJW8A/ofjOfTQEApaDLXclkyTj70NrPRjcRQqY5Z/WMJdftp85SgoCz1k8iWaJqG7Hq10R4OcTYPFyNGEsttTCpOjjYhtN5SikigLfUxcrpocvcNWBED1m1YD4eklrFcY2d9rQih0/1eqA4SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926986; c=relaxed/simple;
	bh=JV5AsD2lAi9wBqVvLQn7AIdqYz+TReKn30XElI8tZow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hoc+d0adLBdQ1Bo8K9kHhEWQEDJ1idO8uTKsUFA+Pin3cx1JDAhf+IufgLFqsdp1dxcqHH/ggfpi0Yp54oGf7TDXzT5AO1lHEVoiAZwPHakwmQCTd2zjQxr8Y1FlG5huxNrXptPGuzNqUd6NAtZ1IAKx0rVKqVPmGojHIkbKIu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A7/ZfMUK; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78822e21a9dso280794185a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710926984; x=1711531784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLyoCiqbHiSdNZKr0m0tptqhq/5sVBW4PAT9ynMrYdw=;
        b=A7/ZfMUKLntQ9difjhbvO1NHec+sm7YD9l7muAzf8n9gfUG5vMDaQgC61un+D5zwlt
         3oAdKxNoj6urNxI5hjKwaIIj4FoobXKCcJiWNsymhKIkjxDjuBO5ltE6vCuGjNTleu2K
         Bbzj4zX0dWV1snFGsKbUh7LEpVQPWfXJNxsdRqAlDtAlK6xG0aA9TQuXzjpmkZ8tDO28
         yGbM4qxqTW3Lmmxr/YR0ut08L4I7juxh9PWjHVCnpVwP6SxCie1todM/2zafw6csDYV2
         PxpyfvknIX+DgAW4wIdYJ5tkIE+5qB5iz66Zb0TkKW4O78pgWdgrdaf0CMULfTTl07F2
         nW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710926984; x=1711531784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLyoCiqbHiSdNZKr0m0tptqhq/5sVBW4PAT9ynMrYdw=;
        b=KKwyWyGPnjYrtt6L3/SQryTcPtIy/ugxg+q0M4qGNnjmgJ3VZ/ZcqxBJLdBLuCEn+o
         Tf6dz9DtnqUl+XYRdlbJAGW7j/R16y5B0gmI2yDLOccbKQoIj69XnROgrJjA9nwFxp4p
         nw2cwcY5x3tDOcfwu75EOWv+nhR6fwof3HYQuYriJPl5BRlTRhenrVxBGdhUHlJayuM2
         729Dp4CqGhVbejVmFpm4XwheXx56VEzJjpuLdBosV9RgR3AHHr7ShO9MbzLjN/QTrHY5
         rtxszIkADWv25jevmfHttjoeHLzwXjVtyNoMIHWp6Lrb+P5uj4VSzuEwPLMY8NVZnbPX
         8cJw==
X-Forwarded-Encrypted: i=1; AJvYcCXDZgRwqWTShdGMczws4VUQdvB8Nh965cq6rRqZJpzty3AyGC5PhghTrFtC6/upi6kKTetIze/y8hPDHkFgIovU+bQPXS/7GXCWR2ch
X-Gm-Message-State: AOJu0YzTSkqn9ZtiBMxhbK385dB00YUc1nufFuRD36kzGGuATSNqQtlA
	WzQJicLIJeuEANlbbqnHYwczEabsP8fFOlkDBCtHk/ldtTYF/x3mnLYC5p9KbEKUDfTw6zI4+PT
	+EZ5CzyZCMy/G2QOdzwI4jRMs/lWTim0ZGnkZ
X-Google-Smtp-Source: AGHT+IEWCL5NACsTa3NVpSQB5eIX0UlfZkWAmrIj1tIqtW/2Ztw3IFXs62zk0mbaPLCfBgv7avANKn3cXU8SDwZl3/Q=
X-Received: by 2002:ad4:5bef:0:b0:691:641a:7bbb with SMTP id
 k15-20020ad45bef000000b00691641a7bbbmr22395757qvc.28.1710926984060; Wed, 20
 Mar 2024 02:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319163656.2100766-1-glider@google.com> <20240319163656.2100766-3-glider@google.com>
 <f9a8a442-0ff2-4da9-af4d-3d0e2805c4a7@I-love.SAKURA.ne.jp>
In-Reply-To: <f9a8a442-0ff2-4da9-af4d-3d0e2805c4a7@I-love.SAKURA.ne.jp>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 20 Mar 2024 10:29:03 +0100
Message-ID: <CAG_fn=UAsTnuZb+p17X+_LN+wY7Anh3OzjHxMEw9Z-A=sJV0UQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] x86: call instrumentation hooks from copy_mc.c
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kasan-dev@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 4:54=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/03/20 1:36, Alexander Potapenko wrote:
> > @@ -61,10 +62,20 @@ unsigned long copy_mc_enhanced_fast_string(void *ds=
t, const void *src, unsigned
> >   */
> >  unsigned long __must_check copy_mc_to_kernel(void *dst, const void *sr=
c, unsigned len)
> >  {
> > -     if (copy_mc_fragile_enabled)
> > -             return copy_mc_fragile(dst, src, len);
> > -     if (static_cpu_has(X86_FEATURE_ERMS))
> > -             return copy_mc_enhanced_fast_string(dst, src, len);
> > +     unsigned long ret;
> > +
> > +     if (copy_mc_fragile_enabled) {
> > +             instrument_memcpy_before(dst, src, len);
>
> I feel that instrument_memcpy_before() needs to be called *after*
> copy_mc_fragile() etc. , for we can't predict how many bytes will
> copy_mc_fragile() etc. actually copy.

That's why we have both _before() and _after(). We can discuss what
checks need to be done before and after the memcpy call, but calling
instrument_memcpy_before() after copy_mc_fragile() is
counterintuitive.

For KMSAN it is indeed important to only handle `len-ret` bytes that
were actually copied. We want the instrumentation to update the
metadata without triggering an immediate error report, so the update
better be consistent with what the kernel actually did with the
memory.

But for KASAN/KCSAN we can afford more aggressive checks.
First, if we postpone them after the actual memory accesses happen,
the kernel may panic on the invalid access without a decent error
report.
Second, even if in a particular case only `len-ret` bytes were copied,
the caller probably expected both `src` and `dst` to have `len`
addressable bytes.
Checking for the whole length in this case is more likely to detect a
real error than produce a false positive.

