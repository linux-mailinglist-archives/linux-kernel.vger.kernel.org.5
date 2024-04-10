Return-Path: <linux-kernel+bounces-138239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6415089EE97
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B95B24CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFC9155741;
	Wed, 10 Apr 2024 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iguVEViO"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B430155393
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740399; cv=none; b=e9bY5yQWJKexj3jocWDknMIXIR+fUTSp5RYF09N/5d2iNwUzGjrQMlnNw/EQwG1soMhL3VYsTsEq89WZ4VFfB7t73rptz9B5CB+hCVSrbvaGXYLP777RF7QHdYGrS8nymqLONe7vJ+t1deuFEl3mTKWLQwKnhueLbQ9GnU4DY4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740399; c=relaxed/simple;
	bh=747hwwI/9YEbtqGw/BZYY5aPIyGCxcAHjcyu86npB9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfvWy6hxq+foZvw1hv/NIVGzdcrsKv2h3VhkAE8eB30OYx8Sxd9Begn2xeCwLKGqf6NtWjOxV0YLKYznw+C55OkG//Fnee/HNanWy1XJgX+Mbg+D0giuEAl4x/JPcsRzU6h08+6uFZhFRFvFbpyhNFHm5IZcfj4cbHiq83Uur/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iguVEViO; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dca1efad59so4616856a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 02:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712740397; x=1713345197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=747hwwI/9YEbtqGw/BZYY5aPIyGCxcAHjcyu86npB9A=;
        b=iguVEViOMpo9tpWmLm72ISEvyDI+QJIMZw8Wl8E5zrheC0OeOUap1I3jfBQypo/6FD
         0+7JhFYw1pGwfP4q2VfU+na+NZ3s5/8OHEIaqYl2Yp+p0vi+Jf1OeuetFLBU/+4jbzSn
         nRMJvnrBiFcaAsL3eqjHU+QZYRGdjD9LAvrFUm5SMjLt5PX8jN1GVUp7oeEIcphL1KD4
         LwyJXFZ+Knr6gkP2YrcrfbY9PgtVWXFtGAlubqr6+/4uwm7pZFJoZvpJLAYp6bxcnKhC
         45dgMesaOso5jFINH714r3b1TH4WW+1wf0WLNJxrsdRpWqcXMWzOq9ua3EmJnh+08Ydf
         ln/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712740397; x=1713345197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=747hwwI/9YEbtqGw/BZYY5aPIyGCxcAHjcyu86npB9A=;
        b=rASchSxOsoKtTahjBt2p+CIIXbY0xWKHbCoDqhYKwqJTNRKr0cy1cR3r7IM3EDiiQo
         YzFhML+09OQW6DIeGE/Gmwju0dKtXCbf492P3s3RDt1cJvrF/zCCoREGDqPNGPr5I1W9
         J/lRKP6OFttjQyAumiU84v6Ycv5CQfMz7VRJ4lYk8Ezlg+neIwQqhKBJRHgklItHhIOz
         NOnVof9nKd1tZrUEQIHmD6DTYngP7yq+RvDOXSbE/whszwgJdT58T5iB57MNoIIE6CeB
         pU0VeVXvG0mcIFicWTgyPtnS8b/JRsUxOcwsn1LDWQgrWp+BzFyN7SO6VAdgXo8/udTp
         n93w==
X-Forwarded-Encrypted: i=1; AJvYcCUKpitamHA8qu9rW5zScWfMPr5mZ2pskHrmqkJ1z/m5qBNuB2ufRy64UXT5H4MTo40ZYKNW8P6NfRzCjbY54anhLAd7immNhtU0clNV
X-Gm-Message-State: AOJu0YwTCpamCHX+/BACnGOhKMRe8VzFa5w/hiNT42EYRVJOto/+6K7M
	nu3vI9hKz2UYYXJkHW184HynuV0hpN+9vMCiP3r2Hvy+C3562Gu+ua8rbMptQXpumUjJSo+41Rs
	P5ZEDWsO3cHvq5sNK2HIQ0FEEy2wlk7C8hOinlQ==
X-Google-Smtp-Source: AGHT+IFtiHhjryYsOV4095JXEzRNDfVTs/PKiPustZNKOQaI3lZeyTvS3gYiwpaUh0qrUoKzXy/ySr9mjAULOpoe53A=
X-Received: by 2002:a05:6a21:186:b0:1a9:500c:d3e1 with SMTP id
 le6-20020a056a21018600b001a9500cd3e1mr1857329pzb.50.1712740397608; Wed, 10
 Apr 2024 02:13:17 -0700 (PDT)
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
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 10 Apr 2024 11:13:06 +0200
Message-ID: <CAKfTPtD-J37Q1SL2HqZLvfNtW9LY34C-d-t6-0KU4DxkUmvHzQ@mail.gmail.com>
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

On Wed, 10 Apr 2024 at 08:59, Qais Yousef <qyousef@layalina.io> wrote:
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

And then how do you apply it on the hierarchy ?

>
> Does proxy execution fix this problem then? If we can't find the top wait=
er,

I haven't dug enough in the patchset. John ?

> I can't see how proxy execution would work here too. To my understanding =
it's
> more about how we apply inheritance (by donating execution context of the=
 top
> waiter) instead of manually applying inheritance like we're doing now.
>
> But the logic of finding the top waiter should remain the same, no?
>
> Need to extend my test case to cover this scenario.

