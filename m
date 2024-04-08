Return-Path: <linux-kernel+bounces-135889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F2589CCAF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91EE5B26849
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEDF14600C;
	Mon,  8 Apr 2024 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJQp+Gy+"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BBA1DDD6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605897; cv=none; b=oh5cJ8HndaOqiumJiCUX4i6gl7veGC1XwFSLm2wygR8beQWbgGeRatMTRq0ANzicZ9VRWNdu9J0iB1ay0Dk+sfaOXBl90NpHc8Z3dD9EsdKu7Yr+iH4BkLt1acN4WnANchY0rVONT7CuyTwA867jI94HTdltnuMRaefjxMvNAPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605897; c=relaxed/simple;
	bh=C/1GfbVoOcsdIxsKvHhVJgku1EJaAbD6ddXpXExhDos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2mDLZIYpCB4LlsRFQjWIZSFHgvxFc+1TF7fULCkVqfajyvS+Rdr+lVehwplABNNlZ6bxGPgE34R2f3KZbfyPns+zmza56omlhsXO1SDgrUFQ0NDGQRmU5scAo4sGJMeb11vBzA/DOjA7Fm8rjox6d3JM6kyribSjOTnQ/UvMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rJQp+Gy+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e5174ffc2so124a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712605894; x=1713210694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/1GfbVoOcsdIxsKvHhVJgku1EJaAbD6ddXpXExhDos=;
        b=rJQp+Gy+9mGhwSDMtLNYQj10bVwDlh7u74FMGVoz8OT2He4GO2deAk7x2VM7cHCyDu
         J/SHp625SJFIa+sz07e7eI5Uaeh8XupZJo1+Y31PDYxP0AU8Ei5/1rwSDah5L5dW1w6I
         Dtz54TfSx+5twMCR8MoG/7hyA3f5TLgITiKII2D84TkAT77+ZanRkRVB3Pp6YQwb/o9H
         mbuuCXS2QSlyTXS4XV3wO0Ozr/FJtdiBB6IAMKqo7dR1VCzwJ1PzvzF2Ot/MCIk7XVGb
         gvrLUW40d6Kr6wjUwY8Mh/CVQIJ/C7DxkaqEoOHDqJwd44cSarizoodX5oV8uBdxIFjF
         yJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712605894; x=1713210694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/1GfbVoOcsdIxsKvHhVJgku1EJaAbD6ddXpXExhDos=;
        b=U9KUfKO0OAFY2OTKIcwosOYu/gE/PrxlEx9t3VfMMg14AA7pGMNg+P/P+IoM0oOP9G
         RBSEQXhZis1l0VAWFQwYFqpJ7tqY01ggkbWuBSr4qkvTImlCUnDPIATGmw8rKeI0qhRu
         oR8994/2WL1KkcZGqNNGNTpgVHvPfpmr+GGTUoJ0nHOFXgV4yq7ZZ0uAohGiffyOl7Iq
         +b3H/SPwPneQJXxiQxoGNPHqATKBwOXTjHh42KemcZaYiwDmyGgzhoqd7EUWIByts/Rc
         yw9dfIjYdodqxjicMHnB3CprdEYHXBnmVwbb7hzjKxQdYrQCja5Ne+VlkJfr/LPvcY7Y
         o25Q==
X-Forwarded-Encrypted: i=1; AJvYcCVevwMWgoO4YadvNSl+eAzPNRsWp42g4bvmeRueZRx8XNOjLht5sjXQHS7s/oeCmhk/WjqTENWn0MG4EHuDek4NbcXzvw9hKiBuLV+c
X-Gm-Message-State: AOJu0Yz2/EeLO8MIyEiN8zO9ug5WfIix69JM626dnFbiM/NH3ShXmLex
	9vq8UrpTule4ZdefarH/LVbrtMdcxSV9Kim9CElkmttN2an4I7MrgdlkSWT7+A4DhLTy40CabPM
	yXdico4kI2vqVzZPz1AochSe8PQBmzEUYwgo=
X-Google-Smtp-Source: AGHT+IEJ1SOCIROJkQzXUCPeA3+faaETnrkIoj1FbgfCG46pfPyaXma2HjP2rAB57BbM+97Tj9WenfblhfTBxgG4fF0=
X-Received: by 2002:aa7:de18:0:b0:56e:2ba2:c32b with SMTP id
 h24-20020aa7de18000000b0056e2ba2c32bmr29945edv.6.1712605893966; Mon, 08 Apr
 2024 12:51:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403005930.1587032-1-qyousef@layalina.io> <CAKfTPtDB8D6bouxJN9q8gXqG+BQYcsrJYEodDWtOB2kQwPH53A@mail.gmail.com>
 <20240404220500.dmfl2krll37znbi5@airbuntu> <CAKfTPtDP7if0gozSrnj+E_hH5xR-vpGAM2TwN4qWXcg5BtrEtw@mail.gmail.com>
 <20240405171653.boxbylrdak5fopjv@airbuntu> <20240407122700.ns7gknqwqkpjjyd4@airbuntu>
 <CAKfTPtBZao-Ry=sdAV=rtTwbxbEJmwb-_gNceSjV6u-6EXTY-w@mail.gmail.com>
In-Reply-To: <CAKfTPtBZao-Ry=sdAV=rtTwbxbEJmwb-_gNceSjV6u-6EXTY-w@mail.gmail.com>
From: John Stultz <jstultz@google.com>
Date: Mon, 8 Apr 2024 12:51:22 -0700
Message-ID: <CANDhNCq5HZvecSe9_9f7j5koY2VNdyjM_b3csL6=U1A_8J2ksw@mail.gmail.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting prio
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 12:17=E2=80=AFAM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Sun, 7 Apr 2024 at 14:27, Qais Yousef <qyousef@layalina.io> wrote:
> >
> > On 04/05/24 18:16, Qais Yousef wrote:
> >
> > > >
> > > > All that to say that I think the weight is not applied on purpose.
> > > > This might work for your particular case but there are more changes=
 to
> > > > be done if you want to apply prio inheritance between cfs tasks.
> > > >
> > > > As an example, what about the impact of cgroup on the actual weight
> > > > and the inherited priority of a task ? If the owner and the waiter
> > > > don't belong to the same cgroup their own prio is meaningless... ta=
sk
> > > > nice -20 in a group with a weight equal to nice 19 vs a task nice 1=
9
> > > > in a group with a weight equals to nice -20
> > >
> > > That is on my mind actually. But I thought it's a separate problem. T=
hat has to
> > > do with how we calculate the effective priority of the pi_task. And p=
robably
> > > the sorting order to if we agree we need to revert the above. If that=
 is done
> >
> > Thinking more about it the revert is not the right thing to do. We want=
 fair
> > tasks to stay ordered in FIFO for better fairness and avoid potential
> > starvation issues. It's just the logic for searching the top_waiter nee=
d to be
> > different. If the top_waiter is fair, then we need to traverse the tree=
 to find
> > the highest nice value. We probably can keep track of this while adding=
 items
> > to the tree to avoid the search.
> >
> > For cgroup; is it reasonable (loosely speaking) to keep track of pi_cfs=
_rq and
> > detach_attach_task_cfs_rq() before the reweight? This seems the most
> > straightforward solution and will contain the complexity to keeping tra=
ck of
> > cfs_rq. But it'll have similar issue to proxy execution where a task th=
at
> > doesn't belong to the cgroup will consume its share..
>
> That's a good point, Would proxy execution be the simplest way to fix all=
 this ?

So, at the moment, in part. It ought to resolve the issue for
in-kernel mutexes (blocked tasks stay on rq, if blocked tasks are
selected to run we will instead run the runnable lock owner - thus it
works across scheduling classes), but it isn't tied into userland
futexes the way rt_mutexes are at this point.

Review and feedback on the series would be greatly appreciated!
(Nudge! Nudge! :)
-john

