Return-Path: <linux-kernel+bounces-139101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B513389FE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6813B219B2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4926517BB21;
	Wed, 10 Apr 2024 17:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="dDwf9cgJ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CE817B513
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770272; cv=none; b=FyhBrIF58d9wJQTPKlvwJ/OHVtmKWzoYPwffneB0wJ69KLuuuCvDKNzIF3Wu3FiiluIUCs2nQvRdgfWuyfcke6MIZ2tTqzGJj6gQLkTV+O8dwGbl6ciz2u23Zy1FypS7GVI9qrZKH08k8KZrXaoTNJxUDduklUKECvubWjmBOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770272; c=relaxed/simple;
	bh=GyzVTM/nobFigo0gdaX0dkQ6qfqgd6/094uZmxhelDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTPq+tHWukfW9QwZRu1gX5MS+qmSX7uRhUXlOo8zP/cAGXNUR+0py2ZZs2sYo7/Jby60e1XgZiEmWpKwya2clBKqIfM6wJXyAvHANLJPItv0hvvkWqZAJUUJAvU/2Yd5VxR3zGL3/hd5r2EXqLQp3uPZq8O1afJf4SnWxDmb9y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dDwf9cgJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41699bbfb91so8595e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712770269; x=1713375069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Y9T4PDG3LECg285TrAcpIeJGNVoCKlbsl4TE7eGWPE=;
        b=dDwf9cgJWk+fbxlDkW7c/zEcUou+816A/fB9rMTNKi8vXXT8ogSS7QnhqxhahKCyoG
         zGYG05Cn89JDLaiCXgBH17eJwV7Dm3rGgzVjZkgGgxIVWJCX7RteAqaE1wOfkF2o83EZ
         XVOgKzbi8C/W7GBtjdo+riKxCXAIOQMvVyQypxJtmTsJFPv60bcez6ogHcJvnxBv+239
         ICveLho6fcCYgYjfYcv3tNcZprzA5V03e9R8DBF+k9Q1AeoMKQjLYbtqXILrf77Tggp9
         whUvVheuwqT4VDoMFXd4FBpAIPcFI+gk3Ld/cNaLZwJZW2kOM5gEUw29FKTB0vVIleHM
         6xCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712770269; x=1713375069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Y9T4PDG3LECg285TrAcpIeJGNVoCKlbsl4TE7eGWPE=;
        b=oK5uQVZYhBmhuzX/6Mpf+C41WH7L9Q5ENypLsEDA1JAbtGUflTQFncnsBorIzDE9tG
         4ORM8/+2YieSfmtOJRAl+01OAqyNSN2jQ+zNQCayAi5gpkaqCoUw5PJLGMVjU0gFeV+o
         vqH9b2kPXC1GzJu2gNiaofoI/XygDrNR3yQN9ef4/WAlgY1LgC/fBCq77spWjBw1/Xor
         +F1nOg5LsETlO16+cuKNhRMyU6eBGnid6TbDgTeDXrwJGI2zW/evuK1mPyb3I77e/kIE
         9IXl6K82SvgXUwGglccTyna0cbFceFyTuKnuLEOuWDwmpHli0u9Ts4UdycPYdjxW7Hoo
         ezJg==
X-Forwarded-Encrypted: i=1; AJvYcCXvBTO8cbawvp6cmSalZwtLcxIzcEsi1txkWMAR9iA/hBVQamFQvoueamdE2OW/vH5jDXU3fOmMZNEmMMZpNXWk6V7nuo3nRIZgT5r9
X-Gm-Message-State: AOJu0YwRmSvCPHPgmetC8r0JudWJTERuiY+l1cHAUuHwRqlRCzRWraic
	cxpoXDpl75gs/gk/BdDjeGO/y2sFgeFgV+6VlgkVTXRoq6RS/DVxRgESOzqH6pqEUK7CcT6o2V0
	VDmzAoiCc1lwVotVoz7eJk807h8KnrThO6Tc=
X-Google-Smtp-Source: AGHT+IE5mNwdNBGpjBaaxKLYIuy8/+75QJpRIt9RsC51c2J9o+zPlCbk4wHhreCctsN59lrCdxxlqxVeQxseri5fULc=
X-Received: by 2002:a05:600c:1c01:b0:416:7385:b675 with SMTP id
 j1-20020a05600c1c0100b004167385b675mr212414wms.7.1712770268815; Wed, 10 Apr
 2024 10:31:08 -0700 (PDT)
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
 <CANDhNCq5HZvecSe9_9f7j5koY2VNdyjM_b3csL6=U1A_8J2ksw@mail.gmail.com>
 <20240409061909.tb3vxc27h2eawiwg@airbuntu> <CAKfTPtC4hdbBhn+-hkK9i4vkjO5fBGfsxjESkBrvyOwN6oHCdA@mail.gmail.com>
 <20240410065901.ruzhjsmtmpsnl4qe@airbuntu>
In-Reply-To: <20240410065901.ruzhjsmtmpsnl4qe@airbuntu>
From: John Stultz <jstultz@google.com>
Date: Wed, 10 Apr 2024 10:30:56 -0700
Message-ID: <CANDhNCr=S8b5MyDa9xp9D08FcsG6VGrHQjkj5CW3iFzuFO-4Xg@mail.gmail.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting prio
To: Qais Yousef <qyousef@layalina.io>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 11:59=E2=80=AFPM Qais Yousef <qyousef@layalina.io> w=
rote:
>
> On 04/09/24 14:35, Vincent Guittot wrote:
> > On Tue, 9 Apr 2024 at 08:19, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > On 04/08/24 12:51, John Stultz wrote:
> > > > On Mon, Apr 8, 2024 at 12:17=E2=80=AFAM Vincent Guittot
> > > > <vincent.guittot@linaro.org> wrote:
> > > > >
> > > > > On Sun, 7 Apr 2024 at 14:27, Qais Yousef <qyousef@layalina.io> wr=
ote:
> > > > > >
> > > > > > On 04/05/24 18:16, Qais Yousef wrote:
> > > > > >
> > > > > > > >
> > > > > > > > All that to say that I think the weight is not applied on p=
urpose.
> > > > > > > > This might work for your particular case but there are more=
 changes to
> > > > > > > > be done if you want to apply prio inheritance between cfs t=
asks.
> > > > > > > >
> > > > > > > > As an example, what about the impact of cgroup on the actua=
l weight
> > > > > > > > and the inherited priority of a task ? If the owner and the=
 waiter
> > > > > > > > don't belong to the same cgroup their own prio is meaningle=
ss... task
> > > > > > > > nice -20 in a group with a weight equal to nice 19 vs a tas=
k nice 19
> > > > > > > > in a group with a weight equals to nice -20
> > > > > > >
> > > > > > > That is on my mind actually. But I thought it's a separate pr=
oblem. That has to
> > > > > > > do with how we calculate the effective priority of the pi_tas=
k. And probably
> > > > > > > the sorting order to if we agree we need to revert the above.=
 If that is done
> > > > > >
> > > > > > Thinking more about it the revert is not the right thing to do.=
 We want fair
> > > > > > tasks to stay ordered in FIFO for better fairness and avoid pot=
ential
> > > > > > starvation issues. It's just the logic for searching the top_wa=
iter need to be
> > > > > > different. If the top_waiter is fair, then we need to traverse =
the tree to find
> > > > > > the highest nice value. We probably can keep track of this whil=
e adding items
> > > > > > to the tree to avoid the search.
> > > > > >
> > > > > > For cgroup; is it reasonable (loosely speaking) to keep track o=
f pi_cfs_rq and
> > > > > > detach_attach_task_cfs_rq() before the reweight? This seems the=
 most
> > > > > > straightforward solution and will contain the complexity to kee=
ping track of
> > > > > > cfs_rq. But it'll have similar issue to proxy execution where a=
 task that
> > > > > > doesn't belong to the cgroup will consume its share..
> > > > >
> > > > > That's a good point, Would proxy execution be the simplest way to=
 fix all this ?
> > >
> > > Is it? Over 4.5 years ago Unity reported to me about performance inve=
rsion
> > > problem and that's when proxy execution work was revived as simplest =
way to fix
> > > all of this. But still no end in sight from what I see. I was and sti=
ll think
> > > an interim solution in rt_mutex could help a lot of use cases already=
 without
> > > being too complex. Not as elegant and comprehensive like proxy execut=
ion, but
> > > given the impact on both userspace and out of tree kernel hacks are g=
rowing
> > > waiting for this to be ready, the cost of waiting is high IMHO.
> > >
> > > FWIW, I already heard several feedbacks that PTHREAD_PRIO_INHERIT doe=
s nothing.
> > > I think this reweight issue is more serious problem and likely why I =
heard this
> > > feedback. I could be underestimating the complexity of the fix though=
 So I'll
> >
> > Without cgroup, the solution could be straightforward but android uses
> > extensively cgroup AFAICT and update_cfs_group() makes impossible to
> > track the top cfs waiter and its "prio"
>
> :(
>
> IIUC the issue is that we can't easily come up with a single number of
> 'effective prio' for N level hierarchy and compare it with another M leve=
l
> hierarchy..
>
> Does proxy execution fix this problem then? If we can't find the top wait=
er,
> I can't see how proxy execution would work here too. To my understanding =
it's
> more about how we apply inheritance (by donating execution context of the=
 top
> waiter) instead of manually applying inheritance like we're doing now.

So, while proxy provides a sort of generalized inheritance, it isn't
deep enough in the class scheduler logic to need to really think about
priority/cgroups.

It just looks at what gets selected to run. That's the most important
task at that moment. It doesn't really need to care about how/why,
that's left to pick_next_task().

Since it leaves mutex blocked tasks on the RQ, it allows the class
scheduler logic to pick the most important task (mutex-blocked or not)
to run. Then if a mutex-blocked task gets selected, we will then find
the mutex owner and run it instead so it can release the lock.  When
locks are released, if the owner has a "donor" task, the lock is
handed off to the donor.  So, this basically uses the
pick_next_task()'s evaluation of what it wanted to run to effectively
provide the "top waiter".

thanks
-john

