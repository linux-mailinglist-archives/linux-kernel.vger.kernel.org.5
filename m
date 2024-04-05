Return-Path: <linux-kernel+bounces-132972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD27899CB1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7A71C23199
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0658216C44C;
	Fri,  5 Apr 2024 12:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zBdEcRV5"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCBC16C69E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319320; cv=none; b=nBoBNrp4RNSSTUHaghc6GRGS8mPz5EcWrElHr2j7Yy2zVg5n0fDZ/p06Nm05hL4kvOBliZzphwGPLkK/TFBQt9FNTHpIEIm8+yqqDPgm1EAUic8oqlpxbVBUVjZEVZ6QrnJ28iFRzT+BYq57MsZaSxgOhLF/OSvtMoZZwwwHQlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319320; c=relaxed/simple;
	bh=Dwl47Xw/UaKT3Or1qk5X+ECM730kMnq85KKO8t7OEN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPxEWEXovQY1vs+k6JXNEA4hwKuJCyX/Ekb2a9W3bOv6B4t59dO2CKh3vFZtK6XakdnvoILzefljqvSRkzFtC2ukBfd28OqJPM5ctaS00lzGtX9eK2mvaP3l2mFzX1fKLyzHhtymZhJy2SL3md959h6Twid6oSops+N02J9sZ+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zBdEcRV5; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a4706cd005so262566a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 05:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712319318; x=1712924118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ih3PtW8gSBt1naF66h5cf3kKmHxMDYlZf9KoPVxVNgc=;
        b=zBdEcRV5djf8arAGQgRKUC+XBRepOhm36kdBbrUCx0TqcyMZEe/mOZyqdmH2UoBO5+
         D416aIrxzMKoZruvH23PH+/nzljFPZ8A2Mma0s3wj4eyJArQ8s9K3eGy6qTYoXdbsnt4
         4Sxq0pevQEQhjMrvKNRRVUDFjV6TaS60vaJW/VoVG5ea749C45EOoQlpixcuC2jrYG4f
         a1foZnbN1otnbe26uxntaZTpWCqpK59J8AkBzXGfJbrxgMqWTqoU5XwXF08b1M3VY0Ix
         H7cOcz6hxpnu7qqDSJUBEHd2ifCJOgrvAM6o6qYqt0U5CIblq6e2z4wPRxYxhnb8qLyH
         RECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712319318; x=1712924118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ih3PtW8gSBt1naF66h5cf3kKmHxMDYlZf9KoPVxVNgc=;
        b=OHLPneh9T2yhLiTj+1rhGHL8d2Bkp9EAHkFveUZjrnEkUe8sqK+Jz9N0CAPjjGiodD
         dKbCmox3NgZ4ZpjBjDCfRl0k5zWtv7Pf/Z5TynG05+Wwz94/tIyoAn6QGlCH+OTOIhDC
         P97/F82K3WahDK+Xrq3q3bHExVk82SfzQNvNH9Zkp6m5Yxa1Kn0nrpd6N4lODBmMbGJJ
         N2bRRnTxySR7vl8bxT3VTM4fjMFJdm1c9KpDXs60ZoeyHjia9qKEy9ZMfROghJsW154G
         wdEOoo6kMUjDlBTxi0iKMc73JeWSH7V7E9v6JkDru0GdDPnb0Fz/89jujYbkF5Wqk2Gs
         iytQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ4B+dYc6yb+SrWATtVWnBBD8UB6A1NGu5qjUWrrZI5OP3Uk+kyG1HQhYCTkp7ivQI0zCNfUvuiBJzcdqhr7fMOIy++ifEgqDGlM8s
X-Gm-Message-State: AOJu0YzuquzxzokbXx860Du9tvLAjKc4iUseTG86SI8Gp1By+feDxKDd
	SFOkColbXcwKtRacCRGJbOMat0WnEtD9+rD00ighbsLssQ2U5y5uQzVOcDU17qkUJSJDUFeQ7S4
	n/7ScMA0+ZQh6RBCd/LiSwYkcz3FHT31emt0MMg==
X-Google-Smtp-Source: AGHT+IENgJy5xyQDznS4zTZoB9QDIulnpRJ57o7nEvQjpdXH3GvQL4CfSmVufwybuIoLjG+bOCRUeTE/TDXcLAs3m64=
X-Received: by 2002:a17:90a:db84:b0:2a2:dc9e:a2cd with SMTP id
 h4-20020a17090adb8400b002a2dc9ea2cdmr1165813pjv.18.1712319317669; Fri, 05 Apr
 2024 05:15:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403005930.1587032-1-qyousef@layalina.io> <CAKfTPtDB8D6bouxJN9q8gXqG+BQYcsrJYEodDWtOB2kQwPH53A@mail.gmail.com>
 <20240404220500.dmfl2krll37znbi5@airbuntu>
In-Reply-To: <20240404220500.dmfl2krll37znbi5@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 5 Apr 2024 14:15:06 +0200
Message-ID: <CAKfTPtDP7if0gozSrnj+E_hH5xR-vpGAM2TwN4qWXcg5BtrEtw@mail.gmail.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting prio
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	John Stultz <jstultz@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Apr 2024 at 00:05, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 04/03/24 15:11, Vincent Guittot wrote:
> > On Wed, 3 Apr 2024 at 02:59, Qais Yousef <qyousef@layalina.io> wrote:
> > >
> > > For fair tasks inheriting the priority (nice) without reweighting is
> > > a NOP as the task's share won't change.
> >
> > AFAICT, there is no nice priority inheritance with rt_mutex; All nice
>
> Hmm from what I see there is
>
> > tasks are sorted with the same "default prio" in the rb waiter tree.
> > This means that the rt top waiter is not the cfs with highest prio but
> > the 1st cfs waiting for the mutex.
>
> This is about the order on which tasks contending for the lock more than the
> effective priority the task holding the lock should run at though, no?

No, they are ordered by priority in the rb tree so you can get the
priority of the top waiter and apply it to the owner of the lock

>
> >
> > >
> > > This is visible when running with PTHREAD_PRIO_INHERIT where fair tasks
> > > with low priority values are susceptible to starvation leading to PI
> > > like impact on lock contention.
> > >
> > > The logic in rt_mutex will reset these low priority fair tasks into nice
> > > 0, but without the additional reweight operation to actually update the
> > > weights, it doesn't have the desired impact of boosting them to allow
> > > them to run sooner/longer to release the lock.
> > >
> > > Apply the reweight for fair_policy() tasks to achieve the desired boost
> > > for those low nice values tasks. Note that boost here means resetting
> > > their nice to 0; as this is what the current logic does for fair tasks.
> >
> > But you can at the opposite decrease the cfs prio of a task
> > and even worse with the comment :
> > /* XXX used to be waiter->prio, not waiter->task->prio */
> >
> > we use the prio of the top cfs waiter (ie the one waiting for the
> > lock) not the default 0 so it can be anything in the range [-20:19]
> >
> > Then, a task with low prio (i.e. nice > 0) can get a prio boost even
> > if this task and the waiter are low priority tasks
>
> I don't see this effect. The only change I am doing here
> is that when we set the prio that we are supposed to be inheriting, instead of
> simply changing prio, I also ensure we reweight so that we run at the inherited
> nice value. I am not changing how the waiter logic works.

But if you look more deeply in the code, you will see that all cfs are
sorted with the same default prio so cfs tasks are not sorted and are
considered to be the same.

All that to say that I think the weight is not applied on purpose.
This might work for your particular case but there are more changes to
be done if you want to apply prio inheritance between cfs tasks.

As an example, what about the impact of cgroup on the actual weight
and the inherited priority of a task ? If the owner and the waiter
don't belong to the same cgroup their own prio is meaningless... task
nice -20 in a group with a weight equal to nice 19 vs a task nice 19
in a group with a weight equals to nice -20


>
> Here's my test app FWIW
>
>         https://github.com/qais-yousef/pi_test
>
> When I run
>
>         pi_test --lp-nice 0 --lp-nice 10
>
> the lp thread runs at 0 still
>
> If I do
>
>         pi_test --lp-nice 10 --lp-nice 5
>
> low priority thread runs at 5
>
> What combination are you worried about? I can give it a try. I use
> sched-analyzer-pp [1] to see the division of runnable/running or you can
> monitor them on top
>
>         #!/bin/bash
>         set -eux
>
>         sudo sched-analyzer &
>
>         ./pi_test --lp-nice ${1:-10} --hp-nice ${2:-0} --affine-cpu ${3:-0} &
>
>         sleep 10
>
>         pkill -SIGKILL pi_test
>
>         sudo pkill -SIGINT sched-analyzer
>
>         sched-analyzer-pp --sched-states pi_test sched-analyzer.perfetto-trace
>
> Picutres of output is attached for before and after
>
>         pi_test --lp-nice 10 --hp-nice 0
>
> [1] https://github.com/qais-yousef/sched-analyzer

