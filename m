Return-Path: <linux-kernel+bounces-111862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9818871D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676AD284D33
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0E55FBA5;
	Fri, 22 Mar 2024 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHdW/Rxm"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB4D5D909
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127801; cv=none; b=o3yInKjNzQa0Mf+eGSDrd9T5T/sS7BURrmegEDs3gMTzIeEkcjch0daS8/T74F7RA0gF5dLlAxY0jrsruOqswwx2RBJ26BNQXW31jd35P0hTVA4VwGGL3WW25tBGAZDnTu3PGGqykZZCUHsY8XAPKzQxGZvC5nkel5+UJyXgWE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127801; c=relaxed/simple;
	bh=2XgtdX5L83O8lONpj9+q9R68FKAPEzG1Evk2xJVlxNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LY5HSDDv3XJDYvSm3ekpw1JH6Y78lOjQDaqQmaccWA0jhNCk4VTvSKFDJTloYZ6bn8zZAIugMczEBe45dN9Tldfk1zv71xUlqDD6AwhmNVS3zHoz47gn0UdP75nyPNTPsqkj7N8ajwtE86SRTvvxZAe4q4JheVxvWKZGHjnTxWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SHdW/Rxm; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dddbe47ac1so22432735ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711127799; x=1711732599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XgtdX5L83O8lONpj9+q9R68FKAPEzG1Evk2xJVlxNQ=;
        b=SHdW/Rxm5925lwaw3dMiXq2MDAczpm7vBKy2/QhiWmEIHYz06oY5Q/+zNlvSpQgsNS
         lSm+VDZPyYmwdn+U3T0TsUG+BPGomZZADpAS60ZkYG8SvGCAvRXTExxFRF1oJUkQMjg+
         VgCFwU1O2kEsJqP0wzO6Sh56vugeSj0JpblhSV4EuE2vLotzn37byK7JXDIBqSFgKHYO
         ssVs0YyKvldH1DkbFRVfGCngEwHlTsazq5oNESt7vsnRSYWma5INxQnC9GAPcuuxCtaP
         qQGMcBT5qbiPq532DoAcexyiyiDhcTv3+tZzb1TBacNwXXmqDLUu+bY7YW6PwB9PWWz/
         xSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127799; x=1711732599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XgtdX5L83O8lONpj9+q9R68FKAPEzG1Evk2xJVlxNQ=;
        b=hfwINIAnp33CVzSPwkttqJErsZTjKLe+8RpMdgflbKp9XwWuDAhzmSjk5oOHAfrZAH
         xMbB//AvqEjN4R2dYh++IQSwoBJPDA5PZbXCR3EsuNKT0xXl+Dr21kzYNQ1dgVO+nerQ
         ILzCT/rA/6r0grHBT07FIahgqsERvOsOqvTWUSA3gZhuQpLyqjWNkklAoWejXAsCbnRf
         sjiT1TA6ynth0Gun9m1N7bzMgAHZC04z6kRLz5qBupwmNbrFR++OziK/N1+JW3TGPvsp
         F9UdX7L9ksFacrTQG+UYC+ua8h3AFNvANiNzbIpyUS8CoVYl/TYhDRnMkP45dNzjFyro
         kksg==
X-Forwarded-Encrypted: i=1; AJvYcCVx74voTZijUmEgEZHxacQUTKQDNIz9aKs8lZzYvl8Du0MgsbjcUVvpqNQ35t+qIXeFTAaSWTdHOMYmBwnwoIN/g5l1naI7sakfWI1S
X-Gm-Message-State: AOJu0Yw6Z183tNIsnIkaYv+ccV996tbGSJVUBXeEev4NM6jKAs+OH5zb
	gtiwMY0qgJNoruywaIU+t0ZHkBtOt3/u45nezmfL/ryTM51guZ3d2UMMbTR07pPkROtZRlhFemA
	qj/iUs4uC+bihwyW+IoXNK47xMWMDFfXmWk9x0Q==
X-Google-Smtp-Source: AGHT+IGoIy/IYyU7iK+6jx6icrcL1Xju4L2aS5adnRoP6nwCZZ2+bufJ5/ik0q2FYBugSBkkQJcDHxrbeyySCNYr/lQ=
X-Received: by 2002:a17:903:32ca:b0:1e0:93b1:3a31 with SMTP id
 i10-20020a17090332ca00b001e093b13a31mr3001188plr.18.1711127798785; Fri, 22
 Mar 2024 10:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
 <20220825122726.20819-2-vincent.guittot@linaro.org> <CABk29NsQf_xStzWg8bB_hpNpPC_LduMs-M058LjdhnDG16wN_A@mail.gmail.com>
 <CAKfTPtDSC25N8TvszDAjseqdLdGy4qiDnwobNThkt8piSL_5Pw@mail.gmail.com> <CABk29NuU30DHproFY-i3_baEhXxofCyLQx-Z5LV74y8_6m7uGA@mail.gmail.com>
In-Reply-To: <CABk29NuU30DHproFY-i3_baEhXxofCyLQx-Z5LV74y8_6m7uGA@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 22 Mar 2024 18:16:27 +0100
Message-ID: <CAKfTPtCf3US76sLObK=iRNtid2hL8s-6Denha71F6W4J0MyAoA@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/fair: make sure to try to detach at least one
 movable task
To: Josh Don <joshdon@google.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Mar 2024 at 21:25, Josh Don <joshdon@google.com> wrote:
>
> On Wed, Mar 20, 2024 at 9:58=E2=80=AFAM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > Hi Josh,
> >
> > Sorry for the late reply.
>
> No worries, responses to your comments inline below.
>
> > > We had a user recently trigger a hard lockup which we believe is due
> > > to this patch. The user in question had O(10k) threads affinitized to
> > > a cpu; seems like the process had an out of control thread spawning
> > > issue, and was in the middle of getting killed. However, that was
> > > being slowed down due to the fact that load balance was iterating all
> >
> > Does it mean that it was progressing but not as fast as you would like
>
> It was a hard lockup, so it's more than just "not fast enough".
> Indeed it was progressing, but not at a rate sufficient to avoid
> lockup.
>
> > > these threads and bouncing the rq lock (and making no progress due to
> > > ALL_PINNED). Before this patch, load balance would quit after hitting
> > > loop_max.
> > >
> > > Even ignoring that specific instance, it seems pretty easy for this
> > > patch to cause a softlockup due to a buggy or malicious process.
> >
> > The fact that the rq is released regularly should prevent a
> > softlockup.
>
> That doesn't prevent a softlockup; kernel is stuck looping over a long
> list of tasks for too long, regardless of whether it is releasing and
> re-acquiring the rq locks.
>
> Note also that load balance can come from softirq in a context where
> we have IRQ disabled, which can lead to hard lockup as well.

fair enough

>
> > And we could even fasten can_migrate() which does a lot of
> > useless stuff for task affined to 1 cpu.
>
> That seems like a useful optimization, but not really relevant? It
> doesn't matter how small we make the constant factor, we still have an
> O(n) operation in kernel mode here.
>
> > > For the tradeoff you were trying to make in this patch (spend more
> > > time searching in the hopes that there's something migratable further
> > > in the list), perhaps it would be better to adjust
> > > sysctl.sched_nr_migrate instead of baking this into the kernel?
> >
> > That could be a solution but this increases the iterations for all
> > cases including those which are more time consuming to sort out and
> > the number of tasks that you will migrate in one lb. The latter is the
> > one which consumes time
>
> Is is really that bad? loop_max will be unchanged for most cases since
> it gets min'd with nr_running anyway. And, even if loop_max ends up
> larger in some other instances, we still terminate the iteration after
> fixing up env->imbalance (granted, we'll migrate more tasks to achieve
> a better balance with a larger loop_max, which I think is your point).

Yes, my point is that load of a task can be quite small, especially
with cgroups, so we can end up detaching/attaching a very large number
of tasks which is far more time consuming that checking if we can
migrate it or not
>
>
> Another idea then: what about separating the number of tasks we can
> move from the number of tasks we can search? You effectively want to
> keep the number of tasks that can be migrated small (nr_migrate), but
> be able to search deeper in the list for things to pull (a larger
> search_depth).

That could be a solution indeed

>
> - Josh

