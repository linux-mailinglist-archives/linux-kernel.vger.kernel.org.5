Return-Path: <linux-kernel+bounces-144466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A918A46B5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7425E1C218DB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F6E18E01;
	Mon, 15 Apr 2024 02:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evKEoJ1G"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0341401F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146608; cv=none; b=Vvza9av6Pk42wx1jtEqbhECs0ImV663ntY6BUOTs62Z7p3qxM4nzeYzaLswMi1iKX7n/uaCEJwwwWtwexf+b1wja8ZPbWL6KQltmKWfZly6AxvyLcfPB4N13ygP6kOcZRVe/d7yM8NrXQizIRQFAgtom8mRYmChUjJWsPQT0Uus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146608; c=relaxed/simple;
	bh=fBFDZL9kz1r8fr1pqVMj87whn7xQxhhlhEAomRuHf58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQnjCEJpKVDgGi5HlLB7Vq7xxek8fTUPCs86kM+g5Jn2gk/esQDEG24qh/0rUiPjwWDTm7UpFrZDw8EtBJls+kxFlrflIEoGLRER/VrQdvhzg8q7i3EdA0trClXok6v1D0mWPkSLgRFrr/DavRsEe8OtEn3Ij4xb65C1tZVlZ/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evKEoJ1G; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e2c1650d8so2223552a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 19:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713146604; x=1713751404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1vXtyWT8fXGggKvExKnj2HZSfdeJ3yoesmgjWoiN9Y=;
        b=evKEoJ1GPpOiImWo+Q5cNsM9qUq/AtaQwpsY5FUbaieAG+Gl1EIA58royViGjmLWB/
         C4Nhjbc+rlj0hinVck3xsXOtt8k5NVBxOniqYU8/QzSARIzVzV5OQdpRDTF5vx4DX+yG
         K7nMjrOumHeOGXJMvaGM1lAb8LNjj7AV2rjVYkSsJ6T757IzlJNW0JVlUB1NsF3kmVdd
         w502xZaZfhejeKUIqIYn12AVHfobQ7ofEy8nZ4mR1QswyGtdHcHGgh3cCgqPBXWJMfOh
         CA3AhGKljv5QrhxqiOT7mkTIymlLfTyEvhRkEcDmmlZvY5+F2qHzhCm4R1jF6JKg7r5y
         +dvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713146604; x=1713751404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1vXtyWT8fXGggKvExKnj2HZSfdeJ3yoesmgjWoiN9Y=;
        b=jfBXIQRtapSASkyXSmr3YbwaA/0iOiJ/nD2moC3ry6p30LmoJhvPQZ8n1NJYSfEaWN
         8HdRlaJNDIZyZaedOc77GOLhUdpbbi0lxU6/W+1vjEV2bnkBElnpywyTrok0+KSjJqMR
         rqqKjIebBtqi+fos7Tc7C6vl0Q/4tPvTTABgKdxIBoIcmi8TRc7t/U9EBakdYVy1COHR
         02r/bwpYLTM5gGj82fBHtby54iOsLE18GNFnLdQSvu/T7K1bTwiQI3AX9MP01lYxGJp2
         DWt3YNYfZxXLfv9cDLOFvm2aHXDCQxatzZ0L51kkLvnlDQZFzX89CysXoXMlM62sK+/m
         bnow==
X-Gm-Message-State: AOJu0YxJZ+/iUHrkstzJ1efUtdD7mBTVasO5XRj/ghHgFi7+yDfu51my
	EVbOBsEBxORjnzGKqUs+lBP1a/ykxgtnrrFPqVjLxE1ENlMv5evq5bK8MFskIOVTLB5ZsgvoJKW
	fcjZMe9UjUMpVRLrCI5/uH+bOoas=
X-Google-Smtp-Source: AGHT+IEp20fAFSAGfwdzEgLx88JHUdcn0dllshXamkiTnZR2Xe1PO+8MZqKUMwwNTnnyfV/lFC9mdo1U7oH4PtcJpIg=
X-Received: by 2002:a50:9f2b:0:b0:56e:355d:2ece with SMTP id
 b40-20020a509f2b000000b0056e355d2ecemr5627069edf.30.1713146604197; Sun, 14
 Apr 2024 19:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313085817.48892-1-zegao@tencent.com> <65b1691d-8d90-4057-8ad0-da546a0ac8a1@linux.ibm.com>
In-Reply-To: <65b1691d-8d90-4057-8ad0-da546a0ac8a1@linux.ibm.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Mon, 15 Apr 2024 10:03:12 +0800
Message-ID: <CAD8CoPDxgL+dkUM_6oAGuAT-GQVdfrckJB2yOjufvbFE14hBxg@mail.gmail.com>
Subject: Re: [PATCH] sched: Improve rq selection for a blocked task when its
 affinity changes
To: 20240313085817.48892-1-zegao@tencent.com
Cc: linux-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>, 
	Ben Segall <bsegall@google.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 12:59=E2=80=AFAM Madadi Vineeth Reddy
<vineethr@linux.ibm.com> wrote:
>
> Hi Ze Gao,
>
> On 13/03/24 14:28, Ze Gao wrote:
> > We observered select_idle_sibling() is likely to return the *target* cp=
u
> > early which is likely to be the previous cpu this task is running on ev=
en
> > when it's actually not within the affinity list newly set, from where a=
fter
> > we can only rely on select_fallback_rq() to choose one for us at its wi=
ll
> > (the first valid mostly for now).
> >
> > However, the one chosen by select_fallback_rq() is highly likely not a
> > good enough candidate, sometimes it has to rely on load balancer to kic=
k
> > in to place itself to a better cpu, which adds one or more unnecessary
> > migrations in no doubt. For example, this is what I get when I move tas=
k
> > 3964 to cpu 23-24 where cpu 23 has a cpu bound work pinned already:
> >
> >         swapper       0 [013]   959.791829: sched:sched_migrate_task: c=
omm=3Dstress-ng-cpu pid=3D3964 prio=3D120 orig_cpu=3D13 dest_cpu=3D23
> > kworker/24:2-mm    1014 [024]   959.806148: sched:sched_migrate_task: c=
omm=3Dstress-ng-cpu pid=3D3964 prio=3D120 orig_cpu=3D23 dest_cpu=3D24
> >
>
> I am able to reproduce this scenario of having an extra migration through=
 load balance
> swapper       0 [031] 398764.057232: sched:sched_migrate_task: comm=3Dloo=
p pid=3D178687 prio=3D120 orig_cpu=3D31 dest_cpu=3D33
> ksoftirqd/0  13 [000] 398764.356138: sched:sched_migrate_task: comm=3Dloo=
p pid=3D178687 prio=3D120 orig_cpu=3D33 dest_cpu=3D34
>
> I wrote a simple c program that blocks for few seconds, meanwhile I tasks=
et it to CPUs 33,34 while I already have a
> busy task running on CPU 33.
>
> > The thing is we can actually do better if we do checks early and take m=
ore
> > advantages of the *target* in select_idle_sibling(). That is, we contin=
ue
> > the idle cpu selection if *target* fails the test of cpumask_test_cpu(
> > *target*, p->cpus_ptr). By doing so, we are likely to pick a good candi=
date,
> > especially when the newly allowed cpu set shares some cpu resources wit=
h
> > *target*.
> >
> > And with this change, we clearly see the improvement when I move task 3=
964
> > to cpu 25-26 where cpu 25 has a cpu bound work pinned already.
> >
> >         swapper       0 [027]  4249.204658: sched:sched_migrate_task: c=
omm=3Dstress-ng-cpu pid=3D3964 prio=3D120 orig_cpu=3D27 dest_cpu=3D26
>
> But after applying this patch, The extra migration is still happening as =
CPU 33 is still chosen by try_to_wake_up.
>
> On placing some perf probes and testing,
>     migration/57     304 [057] 12216.988491:       sched:sched_migrate_ta=
sk: comm=3Dloop pid=3D11172 prio=3D120 orig_cpu=3D57 dest_cpu=3D4
>          swapper       0 [004] 12226.989065: probe:select_idle_sibling_L1=
24: (c0000000001bafc0) i=3D-1 recent_used_cpu=3D-1 prev_aff=3D-1
>          swapper       0 [004] 12226.989071:       probe:select_fallback_=
rq: (c0000000001a2e38) cpu=3D4
>          swapper       0 [004] 12226.989074:       sched:sched_migrate_ta=
sk: comm=3Dloop pid=3D11172 prio=3D120 orig_cpu=3D4 dest_cpu=3D33
>          swapper       0 [000] 12227.007768:       sched:sched_migrate_ta=
sk: comm=3Dloop pid=3D11172 prio=3D120 orig_cpu=3D33 dest_cpu=3D34
>
> It is observed that, select_fallback_rq is still taken in this scenario a=
s default target is returned at the end of select_idle_sibling
> which was CPU 4.

My best guess is that you may have hit the code path for running tasks
(taskset happens right after the task is woken up). Should that happen,
the picking is done via:

        dest_cpu =3D cpumask_any_and_distribute(cpu_valid_mask, ctx->new_ma=
sk);

and it also makes sense that select_fallback_rq() returns 4 since that happ=
ens
before you change the affinities.

you may need to rule out this case first :)

Regards,
Ze

> In most of my testing, default target is returned at the end of the funct=
ion due to the initial checks. It's possible that there would
> be cases where we can get optimal CPU before we reach end of the select_i=
dle_sibling function but it would be interesting to know if the
> extra time spent in finding an optimal cpu have an impact instead of retu=
rning it earlier if in most of the times we are returning the
> default target at the end.
>
> Thanks and Regards
> Madadi Vineeth Reddy
>
> >
> > Note we do the same check for *prev* in select_idle_sibling() as well.
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
>

