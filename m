Return-Path: <linux-kernel+bounces-127608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458BC894E56
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C321F22E0D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92C356B95;
	Tue,  2 Apr 2024 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2QX5B+0D"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D8F56754
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048871; cv=none; b=Nkicyl434zbqPlLEzXPyZ4X80Ei0oFd2Vakjx+eADiu4gBz9bzcp+tiMj7zsWzriJE15YW+m0FEdtM6t9lGB3AyDB2bBL9lcobBnYuEAuuv/lvZ2n5f+hg6rk3hVbG/c71yfOF3GK+LleAwJKXEOAOdJw8U1Hd5N2LkUqsoV4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048871; c=relaxed/simple;
	bh=BmiFl2dlvUSQbFQDIWYMV3yfnVRwHbjvGePU4GqEhN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcLWW290ksFZrR1stUW7QM+sj6w7rfnfiTP6aP9j36QZcF3LVZ3Q2qNZKCksdOvENZlFPGpxMmYgSFNME1cRQBHRmJVgUaosXKzgRZYlw+5djmWIH6wT/OZa7a7mKvAGBWISCbj9GkXWFJVGmbl2N1CBYoSaMUDGLldH0NFsxnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2QX5B+0D; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56c2cfdd728so43473a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712048868; x=1712653668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj2lIs7j0qMeOLAI9CgIcyOVJL5/QjEQamjTy+gS40c=;
        b=2QX5B+0DXiqwvck7Z+42zwaJpGf2S/dkfH9YaQC/K9cAKOiFssmHJLmlkl+5F/J5So
         1XFmATGk41aWRmthoO9NWyqxcV+fZ/CR8oNkHWt/N1/rcRcrQF4/QSwm9H4hbVZERs++
         Al5miBvPdIUBtoFuXc/h0JViqMAylpJi89knJVNWZOpZ2um6osfOH3HKBgwflhXH2oxL
         BlqTHhFSKzJy1weiirQ8XGHu8FkBonBjid4Bodx0R6GdXZDRROkKOSxEJRHMiZnSEmJB
         6O3yAC0ZQMnD8JCq39xiDrTYizilHKrGCdNLhc4s3dPP4b1bzcbh9kqmkpvoTupFIGMz
         xhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048868; x=1712653668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj2lIs7j0qMeOLAI9CgIcyOVJL5/QjEQamjTy+gS40c=;
        b=T4kpMzV16A0kjdz889j1cZtSEKrOSV9Bve0UwEKhsk/6RSs/iCh0eWLEQvijaHyynl
         gPg2Dgc2KzJ8VwW0ZHwD9NosRxQHQiAlOOo/r4y69Yi0qyGnoQbLe9tz3IdW934tnnv7
         4CRtvoiS/suB/irVklcY88YMlyMqv4RlNPMBaOYxe6Ln13o8HvHcQc2lu6U/dyEoZC8K
         u/mRWv8qsTJArDPWUAB4maxYPRGkxy6qlPNeCLQMItf1jAbc4VpjXqTRcW1FVqkHgddq
         YOyqxv8xJB9CNgFU/70rYhLkug5Vrf935/QXYlh84lcSptDLTzWyf+gNywJa2NjGEyko
         GVZA==
X-Forwarded-Encrypted: i=1; AJvYcCX7rrsuM7Da4rZJHqOo3BUfmuVhdrF8BhKd6q7NV0n9vFfPPiQiKtN7wTz4DUWrcwGOwLTicNoAGbZHKYpINInKpaF3vxwtjZbI8r+h
X-Gm-Message-State: AOJu0YyMnRKcKeDiS7ibO2JHwot+it0lasbSoBNi5nGEhtB/5iptR72E
	xBSSEtovP4yJ2/lZp/9MtMwYFxXdeOUNemS3bal6S0H/FWOPm7iu5/NsNkU+irYKkfHgEURL3fc
	MiCkKmA9py/PIzQDpgXC+Q+UK6ggYrxPC6Pwa
X-Google-Smtp-Source: AGHT+IHoV8vKV4c3GSfLunloGPf6EZQrAdvAMSsmbrytkJD9bd1jsE0BDkfwvXFHjbexFnUTzHovVRHCTH/mcV7A2qE=
X-Received: by 2002:a05:6402:5253:b0:56d:eeb0:c76e with SMTP id
 t19-20020a056402525300b0056deeb0c76emr60307edd.7.1712048868331; Tue, 02 Apr
 2024 02:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230316123028.2890338-1-elver@google.com> <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
In-Reply-To: <CANDhNCqBGnAr_MSBhQxWo+-8YnPPggxoVL32zVrDB+NcoKXVPQ@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 2 Apr 2024 11:07:32 +0200
Message-ID: <CACT4Y+a6E8wg3PZhG_AoZtZwozhqUC+LPgMV3G_gQZXkr1rGzw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] posix-timers: Prefer delivery of signals to the
 current thread
To: John Stultz <jstultz@google.com>
Cc: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, 
	Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Apr 2024 at 22:17, John Stultz <jstultz@google.com> wrote:
>
> On Thu, Mar 16, 2023 at 5:30=E2=80=AFAM Marco Elver <elver@google.com> wr=
ote:
> >
> > From: Dmitry Vyukov <dvyukov@google.com>
> >
> > POSIX timers using the CLOCK_PROCESS_CPUTIME_ID clock prefer the main
> > thread of a thread group for signal delivery.     However, this has a
> > significant downside: it requires waking up a potentially idle thread.
> >
> > Instead, prefer to deliver signals to the current thread (in the same
> > thread group) if SIGEV_THREAD_ID is not set by the user. This does not
> > change guaranteed semantics, since POSIX process CPU time timers have
> > never guaranteed that signal delivery is to a specific thread (without
> > SIGEV_THREAD_ID set).
> >
> > The effect is that we no longer wake up potentially idle threads, and
> > the kernel is no longer biased towards delivering the timer signal to
> > any particular thread (which better distributes the timer signals esp.
> > when multiple timers fire concurrently).
> >
> > Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> > Suggested-by: Oleg Nesterov <oleg@redhat.com>
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Apologies for drudging up this old thread.
>
> I wanted to ask if anyone had objections to including this in the -stable=
 trees?
>
> After this and the follow-on patch e797203fb3ba
> ("selftests/timers/posix_timers: Test delivery of signals across
> threads") landed, folks testing older kernels with the latest
> selftests started to see the new test checking for this behavior to
> stall.  Thomas did submit an adjustment to the test here to avoid the
> stall: https://lore.kernel.org/lkml/20230606142031.071059989@linutronix.d=
e/,
> but it didn't seem to land, however that would just result in the test
> failing instead of hanging.
>
> This change does seem to cherry-pick cleanly back to at least
> stable/linux-5.10.y cleanly, so it looks simple to pull this change
> back. But I wanted to make sure there wasn't anything subtle I was
> missing before sending patches.

I don't have objections per se. But I wonder how other tests deal with
such situations. It should happen for any test for new functionality.
Can we do the same other tests are doing?

