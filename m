Return-Path: <linux-kernel+bounces-134882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C53EA89B831
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01DC01C21ABB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D824522EEB;
	Mon,  8 Apr 2024 07:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pksJtR3i"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E41BC39
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560626; cv=none; b=ZUFjsxhrxWLRLhtfU0Yr9HBYoxjQJJcKZnAQQTBF+05shdo9TtdsxQSQr0+lL9dQWInSIJn0kKh0sL4KcJJK/7D01ZKKRj9Xr57CjheLCQhl/X84d3WvpG0Ln+syhsMfsNYZs81ilsJgJU12IYJ2KU7Q/kDTyVLHxwh5+JquE/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560626; c=relaxed/simple;
	bh=z6ttkFiobSvcs1HPoZJjd2N3G8sKym7Fnc8Lvj7iQLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INTBCrvkOHOLeObj9k9G8N33LexG/uuhiRU4L2cXTzrA1swlQ0jQtdhZ1HvhVgiekUHSJBG2G6rLmX/lX2xTWmWjBsy+TzGNLmIuOFDQEUlXfbtH0ihuazBXQphJZrpm7h5ZmUgk17xcSNfp8/6gxl5c+WVlUgIR5pN/3EtvTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pksJtR3i; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e6b22af648so3598155b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712560624; x=1713165424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z6ttkFiobSvcs1HPoZJjd2N3G8sKym7Fnc8Lvj7iQLI=;
        b=pksJtR3iAlf0MIVK0RIXXtrlln0bfiVcWKIb0K0W2Hv4Ug6ltE5ni7No/4EY5mPbh7
         QffVkAkfZ1W0AwBv2woieH6Q0sGQZofAL9Y4hPwhYCaaLtfoTE+xjcM9KRzmkCB3YHPw
         ruapYC7PHyOMUn9pvUQazelDX0jQaSOWFI/EYwoOVzSGsNRBsQoKv0chTya7kOwka9Vg
         2MG+XiXQxonQSlm259EmjtZZwxB4eTJFdhpj6BzmvlDvSyr5h/joRm7TBpn0hqf+ObyC
         TcR3YR9gzNjBj26NtXQENj4a4/UsNG73/LrLWnlJjZHXWaE0xv14B95UE6OAuUbhJFwN
         YRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712560624; x=1713165424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6ttkFiobSvcs1HPoZJjd2N3G8sKym7Fnc8Lvj7iQLI=;
        b=Hm0VJZr/QSgwUNTiWZYDX+sKCzZyoL/i3qvxUmi2dFTy5q4DK08Bq1oJTJ1vumo4A0
         ccncUOpN9HXl3Mdl6fb+cEeQY74TwecjUxkG5m3DRIYPE4wUXunFtowHtA4bQXdJe1pB
         4RM3eS/JgZ5LYwlQXLjvY87oCI1nOPUGeYgedbWOB8Lw0anT1NroT3asMHOyFXzOQ53c
         MQhrg2divFsl9WvSkxFR3KjqnLRPJSnGQsuurRTJHDD+JdBcXOpf1JLP5RpS1gIpDXmp
         qcf7I8LwWLUDCKTF72o4T9qGz16L/uyqXHVQ97GkXXPPYk2m3yAXlDFrc3CCzkfeNKqk
         olOg==
X-Forwarded-Encrypted: i=1; AJvYcCVJm+8JpHE9VdGvOK7QlM9s5ZclMZXElNY+kHPWCD/8z5W40Cyqaqo6KYgo5VyQS1Bpr40SSchtVaGpfNJuXrxA7AldJw7XoLwFwmJF
X-Gm-Message-State: AOJu0YzfvJ7TQuEUp/5aNAR6OwfYOcPx+ZUtrVD/KfuGfkwFSkm5Jz/h
	10Mw53xTL3umthiWoFGRndhsLLCflsndeCWlYMkcICm0TSorrb8I1QJM2Mog2Yrmcho230Nk+FV
	ZGT8WeFCjW0EeShMO11Kn2qqGS1hz+gqulIM7fw==
X-Google-Smtp-Source: AGHT+IHf7G0qH23Gi6+/sVvIKSWLs/MgFqI80unw0WgTCq5dgXhEazFn9bkfZ/UXlRbc4H24bkXtDtHfzjtAiihq8LA=
X-Received: by 2002:a17:902:c94d:b0:1dd:8ed0:59d0 with SMTP id
 i13-20020a170902c94d00b001dd8ed059d0mr10148621pla.17.1712560623953; Mon, 08
 Apr 2024 00:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403005930.1587032-1-qyousef@layalina.io> <CAKfTPtDB8D6bouxJN9q8gXqG+BQYcsrJYEodDWtOB2kQwPH53A@mail.gmail.com>
 <20240404220500.dmfl2krll37znbi5@airbuntu> <CAKfTPtDP7if0gozSrnj+E_hH5xR-vpGAM2TwN4qWXcg5BtrEtw@mail.gmail.com>
 <20240405171653.boxbylrdak5fopjv@airbuntu> <20240407122700.ns7gknqwqkpjjyd4@airbuntu>
In-Reply-To: <20240407122700.ns7gknqwqkpjjyd4@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 8 Apr 2024 09:16:52 +0200
Message-ID: <CAKfTPtBZao-Ry=sdAV=rtTwbxbEJmwb-_gNceSjV6u-6EXTY-w@mail.gmail.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting prio
To: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	John Stultz <jstultz@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Apr 2024 at 14:27, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 04/05/24 18:16, Qais Yousef wrote:
>
> > >
> > > All that to say that I think the weight is not applied on purpose.
> > > This might work for your particular case but there are more changes to
> > > be done if you want to apply prio inheritance between cfs tasks.
> > >
> > > As an example, what about the impact of cgroup on the actual weight
> > > and the inherited priority of a task ? If the owner and the waiter
> > > don't belong to the same cgroup their own prio is meaningless... task
> > > nice -20 in a group with a weight equal to nice 19 vs a task nice 19
> > > in a group with a weight equals to nice -20
> >
> > That is on my mind actually. But I thought it's a separate problem. That has to
> > do with how we calculate the effective priority of the pi_task. And probably
> > the sorting order to if we agree we need to revert the above. If that is done
>
> Thinking more about it the revert is not the right thing to do. We want fair
> tasks to stay ordered in FIFO for better fairness and avoid potential
> starvation issues. It's just the logic for searching the top_waiter need to be
> different. If the top_waiter is fair, then we need to traverse the tree to find
> the highest nice value. We probably can keep track of this while adding items
> to the tree to avoid the search.
>
> For cgroup; is it reasonable (loosely speaking) to keep track of pi_cfs_rq and
> detach_attach_task_cfs_rq() before the reweight? This seems the most
> straightforward solution and will contain the complexity to keeping track of
> cfs_rq. But it'll have similar issue to proxy execution where a task that
> doesn't belong to the cgroup will consume its share..

That's a good point, Would proxy execution be the simplest way to fix all this ?

>
> Can we treat the two as separate problems? Or you think any solution must
> address the two? Both must be fixed of course.
>
>
> Thanks!
>
> --
> Qais Yousef

