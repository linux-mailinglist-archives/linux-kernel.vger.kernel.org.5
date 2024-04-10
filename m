Return-Path: <linux-kernel+bounces-138694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 057C489F91D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2931F1C25CD6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AE815F402;
	Wed, 10 Apr 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="33iofNrw"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44815B568
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757588; cv=none; b=Qq4kxVi7ufck6uulYZRCFRi0F18euDTguIiaYiujoMLB1nRCGh949yZVs9WkKU+r8u9dDFLkBZPUMHCcEy3lmWY+ywfHDmMu0QpcV2B1ItqX+FUv/PVnthQo3OCAiu4kQNCBunHs7i5mR0UZCnNh8ls9JtyucKSo4QaP/ed+bHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757588; c=relaxed/simple;
	bh=6Uqwnw302suIzBJiIBQsZeD3y2gKWEdgNhICFPWo1MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXYTFb3D/3IuO4K/rwO7mQ1tQ0YPDlP9IG/1DQFMl3eoeOyYmk9aFJARafwMfWDtERTbF6LjYE3kayT0+TNzq7W7rICxDfoE0Ie3ZPeJtOLdr4Bmi951JFYpfZcbWwbFpedT6NoLrTHXDI26hrzeCpYvFSOkhm6CV+/iO6c31L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=33iofNrw; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-479e57ff63bso1757224137.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712757586; x=1713362386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5aa3hIWZtOiM9o7F/Dz6DxBBPY3BgmfWmAFxkVrBHd8=;
        b=33iofNrwnfNauxs8afLTgJHKp+9p4CPgdTobmG0+vYEc6KZmX6vufTcD0bPXCZjdox
         wXfy76V/viBwIUp7/KscRduZtTKbddgDkdfBjMR+u+DR+jmnHOdYY8wv0+i8TrofTZPg
         bYBjfuC4Emao2Q1oguAgL/tYrqse0VYyDntA4GbnLyZvoIHhiV/U2etAxX53MTcP0RAw
         hHI23PTSvu/DcUIK+KOrjgP3XOrNmaNO0Ri+djkKxpspJ4yyRbtA5ti+oMlTzNT8O2hW
         DO0VcYQpQUJ6JbgtemPCEAdyGV4A+9/RarTwbTGyNl0o8WAqaU7OwYPiO9b2fvXyGss+
         03eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757586; x=1713362386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aa3hIWZtOiM9o7F/Dz6DxBBPY3BgmfWmAFxkVrBHd8=;
        b=S1kIYVAfslNLXahhFengxykm8oBFCtzwkHejZzcw0lMNxkZsgfSPjBasuS6YskGaf5
         UKbi9CSQEZAOzWjjUo1IPghhdPINIPbhp1uY0B8L9yYSp96Oyp3jEmcJ89t0iO0L+Wrr
         IvX5mZvW2zNnNEFupINxn0jVSnWzsjxS1M6EoRvtrefllkr9OGf0OMLtIoE0cEok3950
         T7Qz60rBqnby2RGfCIWtkVvO0TcdayPY0Rbi3EY4kBmHkZfUfDCxaFfK8vkIlAKr0dhG
         zr6Tahdxebx0IYpwnsYT7oFK/vddswg8XULgIivSYVPHkmMNGam5PzPXk4XmY4f+SyY1
         kuRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlKWP9sCarvH7kmWTFkk3REMTgkY60f6jQ0lk/985/yuYtOvCrvnF93JlrXWrdBsEp+CtZwWZSVYkaZ2lwz+2DzuKmPywB4uunzTBk
X-Gm-Message-State: AOJu0YzWbbTi4iD/QhR6SOfMSuKp0Wj7sVbXLEmi7fxbpcf1krO1+KW5
	u/9SVUcP1R9PYkaDnRO3JYHPie/n2dMus1aTRSyFuzoQ00zJMh9UUt7P/g87hxxlFHbdumlZBT5
	t4ponic8BLugcRAW24VxvutvE/agSlUYs6cik
X-Google-Smtp-Source: AGHT+IEpsiKA9Ha0aSj78Js7MGsZu+xSPo2OOybBgeVcNcg20IWc+marqLN4JEtWyhh8Xzl0ENJq8kVbtbfz5TbqHoU=
X-Received: by 2002:a05:6102:1593:b0:47a:248b:6846 with SMTP id
 g19-20020a056102159300b0047a248b6846mr2424398vsv.16.1712757585948; Wed, 10
 Apr 2024 06:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408090205.3714934-1-elver@google.com> <20240410225648.7a815ba873c8d55c44385c24@kernel.org>
In-Reply-To: <20240410225648.7a815ba873c8d55c44385c24@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 10 Apr 2024 15:59:07 +0200
Message-ID: <CANpmjNNFcHp0n5J5XWMb=3cpa+FT5V1xeev5dFZCC7SknPBkOA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Add new_exec tracepoint
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 15:56, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Mon,  8 Apr 2024 11:01:54 +0200
> Marco Elver <elver@google.com> wrote:
>
> > Add "new_exec" tracepoint, which is run right after the point of no
> > return but before the current task assumes its new exec identity.
> >
> > Unlike the tracepoint "sched_process_exec", the "new_exec" tracepoint
> > runs before flushing the old exec, i.e. while the task still has the
> > original state (such as original MM), but when the new exec either
> > succeeds or crashes (but never returns to the original exec).
> >
> > Being able to trace this event can be helpful in a number of use cases:
> >
> >   * allowing tracing eBPF programs access to the original MM on exec,
> >     before current->mm is replaced;
> >   * counting exec in the original task (via perf event);
> >   * profiling flush time ("new_exec" to "sched_process_exec").
> >
> > Example of tracing output ("new_exec" and "sched_process_exec"):
>
> nit: "new_exec" name a bit stands out compared to other events, and hard to
> expect it comes before or after "sched_process_exec". Since "begin_new_exec"
> is internal implementation name, IMHO, it should not exposed to user.
> What do you think about calling this "sched_prepare_exec" ?

I like it, I'll rename it to sched_prepare_exec.

Thanks!

