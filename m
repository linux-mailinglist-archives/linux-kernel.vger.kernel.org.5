Return-Path: <linux-kernel+bounces-162699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663B68B5F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AAF1C20FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428A186244;
	Mon, 29 Apr 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvaB+GUP"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC3B85643;
	Mon, 29 Apr 2024 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408747; cv=none; b=XNNKzQrICafHqpZ2Nl7LrzJL6v0LZVWTjYC+izgllaMqfoWCjiNzB207KvZZmH5WifCFcWug47HSpWAFzaniEqtDnYI8T0jcMu+kihiyx/c2A8L1xI8Fzt8c8v1gRIeqfML0L+1WSx9J+tNJbBk/48qVcDv59GELHZdChV+scMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408747; c=relaxed/simple;
	bh=zJC2jHdtvNuoh/7+wUOUQfN1zCwoKCDjYiEpvNDhnkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebFims5TvqHPOR/ZYlSsTTvaq1q8PSxJ5c8ekY1dXUaO3VY7NAOKFjhqGgeYitnnr9dL+Fsq/CT6bGjcrqWf2Pnc256d7ZOf1EZFMck4Aftt9EnNJIBtBqioirP/jaFz0FQM4Ufy8kHHIxmE8+Comde1SWGf//Yy7kHUipzrsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvaB+GUP; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5709cb80b03so4755722a12.2;
        Mon, 29 Apr 2024 09:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714408744; x=1715013544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8ZupKM3UqZOUqxG1rrXLoiAhRVggO/mf0Y0hq1+ePE=;
        b=mvaB+GUP7LTLkjmadIhkg4NwG/5fD6+NgXB/o6iN2YKpPT0NBU1Q6PQ6eZ238pfSLq
         Kzkz69KW0S3qLX2rlI8LM+q7oApeK6wJ88XV9BTRwTfvPW3hCy/8kl2FQiUfw78uPd4+
         +6PXMXKqE2E+imTCEfuC+d1PzLyPRjpP8DODpjUYABslZJspAGcGfl3qPoa36mVjzA4j
         jYjkoe6We6Be7sr7ai2WxFYzD2dEcN8nmYtGzRaMDhlUz6iSnTrToPL+fUEyPFATW2gP
         kArmqBPlpXr7xDCA29JZu4pPda5H/wSzeLiL9ITmfBYQ+v0n5hiZ7NOW1V3FtBjk4qo/
         rOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714408744; x=1715013544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8ZupKM3UqZOUqxG1rrXLoiAhRVggO/mf0Y0hq1+ePE=;
        b=OKCDoylh4uEw5uYc4ibuFvNMDoApq5foFDCRZPjE4HCiW5Q3Z4Jia50TVzHp+ACeeb
         OoPbidNT015qllN5zXDKgvU7aQw0d0rr8RqNFXzhPUnol2ySP5gUeJbuznxHPxKk2VSd
         vIhFUb/zIiv+gJAC5PcFU7SFml96RzLbuE0Gmsv56+AsBzMAJbk2a44npoMI5pzJt/7j
         WSATy39GVqmg6QlcLBAHgYcNMtsEhYKV+K5kmNlYUpa1DGWWP8S5ETBu/S+qMpD0sxfY
         OMncduy74ReEP0XEVtw2bJW41aVkYNIvWDnZX/uvWDyzYasSEbapiyHgN9L6PWGm86t5
         jbPw==
X-Forwarded-Encrypted: i=1; AJvYcCWm03LVTVVUHOlBs7L2egoECpapSIHI9eicpZYqHFuAU7LGGssx/talP15xqIEbeb60bMnYQO4C77Lln+M50ZCk+Y4tkAtF5AKgoRnoqYCE3SrmNIiuXTytvjNwTTTqh91ZASGHG+32SSUORn5Trw==
X-Gm-Message-State: AOJu0Yzn8+zDU0lUIHmfS4X/0fKhU86fZZM2kPOxOkb6uBDAb2i/9o4l
	WcioSZPA7ubRNTb8gVF0Fbv/0tTpcYLEGKribCr9BK5h/JrozNk0y07E7sxfO0wSuwpADGqWn4O
	C9DtYDATGsiJbbAez1HgcHP44snQ=
X-Google-Smtp-Source: AGHT+IFutqemErmK6ODXh6FUWRCGYBPCk1mNrXK+yjEdyK8mnXK+phIySKy9xjTvq8PMb7B1wAhD65ZJhyDztQrc2pw=
X-Received: by 2002:a50:d602:0:b0:570:5b3d:91f with SMTP id
 x2-20020a50d602000000b005705b3d091fmr140668edi.23.1714408744009; Mon, 29 Apr
 2024 09:39:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jw=5vKSE8ibuim0uFKQq=sA3sWULqM5auqKNJCq0=kqGg@mail.gmail.com>
 <20240424094305.GT40213@noisy.programming.kicks-ass.net>
In-Reply-To: <20240424094305.GT40213@noisy.programming.kicks-ass.net>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Mon, 29 Apr 2024 09:38:52 -0700
Message-ID: <CAJg=8jxS+omJP-HeBUNEgh-avEGQuCisPcX2knRiucppQTNAdw@mail.gmail.com>
Subject: Re: possible deadlock in __perf_event_task_sched_in
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

Thanks for taking the time to explain this issue!

Wishing you a nice day!

Best,
Marius

On Wed, 24 Apr 2024 at 02:43, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Apr 22, 2024 at 11:44:27AM -0700, Marius Fleischer wrote:
> > Hi,
> >
> > We would like to report the following bug which has been found by our
> > modified version of syzkaller.
> >
> > We found this report (https://lkml.org/lkml/2021/9/12/333) that seems
> > to have a similar but different stack trace. We are unable to tell,
> > though, whether it is the same cause. We=E2=80=99d be grateful for your
> > advice.
>
> This is just the printk thing sucks again. Some WARN/printk got tripped
> in a non-suitable context.
>
>
> >  _printk+0xba/0xed kernel/printk/printk.c:2299
> >  ex_handler_msr.cold+0xb7/0x147 arch/x86/mm/extable.c:90
> >  fixup_exception+0x973/0xbb0 arch/x86/mm/extable.c:187
> >  __exc_general_protection arch/x86/kernel/traps.c:601 [inline]
> >  exc_general_protection+0xed/0x2f0 arch/x86/kernel/traps.c:562
> >  asm_exc_general_protection+0x22/0x30 arch/x86/include/asm/idtentry.h:5=
62
> > RIP: 0010:__wrmsr arch/x86/include/asm/msr.h:103 [inline]
> > RIP: 0010:native_write_msr arch/x86/include/asm/msr.h:154 [inline]
> > RIP: 0010:wrmsrl arch/x86/include/asm/msr.h:271 [inline]
> > RIP: 0010:__x86_pmu_enable_event
> > arch/x86/events/intel/../perf_event.h:1120 [inline]
> > RIP: 0010:intel_pmu_enable_event+0x2d9/0xff0 arch/x86/events/intel/core=
c:2694
> > Code: ea 03 49 81 cc 00 00 40 00 4d 21 f4 80 3c 02 00 0f 85 5b 0c 00
> > 00 44 8b ab 70 01 00 00 4c 89 e2 44 89 e0 48 c1 ea 20 44 89 e9 <0f> 30
> > 0f 1f 44 00 00 e8 1b 32 75 00 48 83 c4 20 5b 5d 41 5c 41 5d
> > RSP: 0018:ffffc900115af348 EFLAGS: 00010002
> > RAX: 0000000000530000 RBX: ffff888019dd6a50 RCX: 0000000000000188
> > RDX: 0000000000000002 RSI: ffffffff81029464 RDI: ffff888019dd6bc0
> > RBP: 0000000000000000 R08: 0000000000000001 R09: ffff888063e22ab7
> > R10: 0000000000000000 R11: 0000000000000001 R12: 0000000200530000
> > R13: 0000000000000188 R14: ffffffffffffffff R15: ffff888019dd6bb0
> >  x86_pmu_start+0x1cc/0x270 arch/x86/events/core.c:1520
> >  x86_pmu_enable+0x481/0xdf0 arch/x86/events/core.c:1337
> >  perf_pmu_enable kernel/events/core.c:1243 [inline]
> >  perf_pmu_enable kernel/events/core.c:1239 [inline]
>
> Most likely your VM is wonky and perf tries to poke an MSR that either
> doesn't exist or isn't emulated properly, who knows.

