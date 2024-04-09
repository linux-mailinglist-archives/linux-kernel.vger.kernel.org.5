Return-Path: <linux-kernel+bounces-136872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE1489D944
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C8C2843E2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5EE81ABA;
	Tue,  9 Apr 2024 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zd10V4HK"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D00384
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666141; cv=none; b=N/EHAyZiH6J3cqBVJmhjkfiQ+/WgRBiGydnlcYn4D4gOh5pZf1cCX/r+DNPUFraIl/gkW2XRh6j1jcbTjpcF5nT8cDt6Sr/fcp64tWaq675ko2ep4cLFykyNUHri5yQmZbQQCFvEaSYz0E4KZI/9rfD4v/w3Yd3kVWLD+yFCozM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666141; c=relaxed/simple;
	bh=I2EVUCJF1pyEMVBSw1bVJ3VObStzh2EcfTUZb6HxvLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuZqcd2Fw1g45I2FFgxRsaHZXyuzVyfUz6WgAvKSOIU7UkswLr68intTjW1duzsX2D7y4BtEGrAI3q9BL8I7Ta4RXGvkl2fQ1yFEk4Sk2Oh4hOCe5QBTXa7nT/JiHavBu7Mh/c/vHTzLSITswRZxddOQWxvVb51uNxup4xs1+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zd10V4HK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso4002285a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 05:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712666139; x=1713270939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2EVUCJF1pyEMVBSw1bVJ3VObStzh2EcfTUZb6HxvLI=;
        b=zd10V4HKU4aAxGz7wJ/3EQbUCJfC+XMOdAYqRbPnWYHjiDCmfeFnXE3WJRG4DmIGkQ
         nZuQNyj/H8JyX9Bb5XDnfiDGbANCyUpx+kcRWl4N8CyYVa8D2k08A/9sEtvZ9BunOABx
         c/9q3MFC3LjSalUP2Kb3Ss+eXQdepKwyQoQgIwpG0Fl6SPAEh4kOPdm7ov+y/bRJizY0
         7kqIA96pdqs1gCJH4yB1xsACPfpo5r1/K+fStJLULU1OJLHZcujVbHX/N2h9rR5wech4
         I6p8/Y/oDtZsvjrYciHx7A/RsrC7KQL56BmjamvMUQj6yAcKsPgTYlg1V1x/e1jtsAOB
         xzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712666139; x=1713270939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2EVUCJF1pyEMVBSw1bVJ3VObStzh2EcfTUZb6HxvLI=;
        b=afvLQuCWm+xmTn2UQdc2JCqBMM+VP6ahc1xdk8iiyBqz4eHbizafYs9Dt/2wRYzofn
         LS8ZmQjS/PLMT/n+MZlMhuN4DXh/xvZyFiKN+Ft88xGzBhymNR6+JU1JpWkgOu+roJX2
         s8O1e0kAyBV9lDqAA9WrG59NKjrGwoNnvuqhzPQHltYOhJiMQM/d0NXWfrEBoQqNwesj
         x9G8RudgGyc3PRbAAbrAjjoapEwwJ0N5P/B21BPoxSND8vDZrxmDgqNkfVdZZ/KFd7Af
         G5I3R0IeEvkw3oqXhbAuV7iCHkuMrnhTaVh3gHRvw05/K4Te0ZJej45C//avW7J5M6+G
         OYcA==
X-Forwarded-Encrypted: i=1; AJvYcCWzkLFSbFwSJnWEHr3rS7dgwblnRW+ZCoqWq93EKikW8S7gwkfh/7DlqfUSxQeZCSDNBlacbDrB16WnXJqXMHc6p9rl6lrl0rrxWmfe
X-Gm-Message-State: AOJu0YwclUw3qy9TU7Fi5zWLHA//cuRal/wDDpwuHF/9e5Cy/wntt0iR
	ZKd1MDmH+AfuA4IS5xylPIFopH51k7HDcDnPU/dojv4Mh+2pUdkxk3O3FW4OJmQcirSRAN6Wtvk
	rtFnkNv9oax34zJ+jatsKW5Tbfb4ah/o6AKh3qQ==
X-Google-Smtp-Source: AGHT+IHkI3jjlZCeDLfmTGC4C2E7Io7iXBK3pYmiYq/MlGobLrRzvtUBVY5a0Lhsec11T5/CunZsTuumnpzGg2w/j18=
X-Received: by 2002:a17:90a:ab97:b0:2a5:3637:1968 with SMTP id
 n23-20020a17090aab9700b002a536371968mr4649251pjq.9.1712666139328; Tue, 09 Apr
 2024 05:35:39 -0700 (PDT)
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
 <CANDhNCq5HZvecSe9_9f7j5koY2VNdyjM_b3csL6=U1A_8J2ksw@mail.gmail.com> <20240409061909.tb3vxc27h2eawiwg@airbuntu>
In-Reply-To: <20240409061909.tb3vxc27h2eawiwg@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 9 Apr 2024 14:35:27 +0200
Message-ID: <CAKfTPtC4hdbBhn+-hkK9i4vkjO5fBGfsxjESkBrvyOwN6oHCdA@mail.gmail.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting prio
To: Qais Yousef <qyousef@layalina.io>
Cc: John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Apr 2024 at 08:19, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 04/08/24 12:51, John Stultz wrote:
> > On Mon, Apr 8, 2024 at 12:17=E2=80=AFAM Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Sun, 7 Apr 2024 at 14:27, Qais Yousef <qyousef@layalina.io> wrote:
> > > >
> > > > On 04/05/24 18:16, Qais Yousef wrote:
> > > >
> > > > > >
> > > > > > All that to say that I think the weight is not applied on purpo=
se.
> > > > > > This might work for your particular case but there are more cha=
nges to
> > > > > > be done if you want to apply prio inheritance between cfs tasks=
.
> > > > > >
> > > > > > As an example, what about the impact of cgroup on the actual we=
ight
> > > > > > and the inherited priority of a task ? If the owner and the wai=
ter
> > > > > > don't belong to the same cgroup their own prio is meaningless..=
 task
> > > > > > nice -20 in a group with a weight equal to nice 19 vs a task ni=
ce 19
> > > > > > in a group with a weight equals to nice -20
> > > > >
> > > > > That is on my mind actually. But I thought it's a separate proble=
m. That has to
> > > > > do with how we calculate the effective priority of the pi_task. A=
nd probably
> > > > > the sorting order to if we agree we need to revert the above. If =
that is done
> > > >
> > > > Thinking more about it the revert is not the right thing to do. We =
want fair
> > > > tasks to stay ordered in FIFO for better fairness and avoid potenti=
al
> > > > starvation issues. It's just the logic for searching the top_waiter=
 need to be
> > > > different. If the top_waiter is fair, then we need to traverse the =
tree to find
> > > > the highest nice value. We probably can keep track of this while ad=
ding items
> > > > to the tree to avoid the search.
> > > >
> > > > For cgroup; is it reasonable (loosely speaking) to keep track of pi=
_cfs_rq and
> > > > detach_attach_task_cfs_rq() before the reweight? This seems the mos=
t
> > > > straightforward solution and will contain the complexity to keeping=
 track of
> > > > cfs_rq. But it'll have similar issue to proxy execution where a tas=
k that
> > > > doesn't belong to the cgroup will consume its share..
> > >
> > > That's a good point, Would proxy execution be the simplest way to fix=
 all this ?
>
> Is it? Over 4.5 years ago Unity reported to me about performance inversio=
n
> problem and that's when proxy execution work was revived as simplest way =
to fix
> all of this. But still no end in sight from what I see. I was and still t=
hink
> an interim solution in rt_mutex could help a lot of use cases already wit=
hout
> being too complex. Not as elegant and comprehensive like proxy execution,=
 but
> given the impact on both userspace and out of tree kernel hacks are growi=
ng
> waiting for this to be ready, the cost of waiting is high IMHO.
>
> FWIW, I already heard several feedbacks that PTHREAD_PRIO_INHERIT does no=
thing.
> I think this reweight issue is more serious problem and likely why I hear=
d this
> feedback. I could be underestimating the complexity of the fix though. So=
 I'll

Without cgroup, the solution could be straightforward but android uses
extensively cgroup AFAICT and update_cfs_group() makes impossible to
track the top cfs waiter and its "prio"

> trust your judgement and ditch further effort if you think it's more effo=
rt
> than helping proxy execution patchset - for the list at least. I'm likely=
 still
> to pursue something out of tree to get into as many android LTS kernels. =
And
> will be happy to share this work if there's desire to try to pick somethi=
ng up
> for mainline to make the problem less severe at least.
>
> Note that binder has already performance, latency (out of tree) and prior=
ity
> inheritance and without those performance is impacted in many corner case=
s and
> considered indispensable part.
>
> >
> > So, at the moment, in part. It ought to resolve the issue for
> > in-kernel mutexes (blocked tasks stay on rq, if blocked tasks are
> > selected to run we will instead run the runnable lock owner - thus it
> > works across scheduling classes), but it isn't tied into userland
> > futexes the way rt_mutexes are at this point.
> >
> > Review and feedback on the series would be greatly appreciated!
> > (Nudge! Nudge! :)
>
> I am guilty of this, sorry.

me too

