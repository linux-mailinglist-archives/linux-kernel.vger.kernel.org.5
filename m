Return-Path: <linux-kernel+bounces-150757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5478AA42B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E172822ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CDE194C71;
	Thu, 18 Apr 2024 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="nys+YJQS"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E594190663
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472742; cv=none; b=ltwSXEjgQTvwl14Gms6HnkPZYG4+RGjJvxubW+8Pfkt26FsQPyfY31pykDwexvbFI4fzAVcZ53tusqXOaneEVuS285X1tOWwUAGGQkzSIk6dMpr6IPuK08Qr5VEEJm3W4wgWzJNoPq9Ml6y40hzOaEJ1kUQXQBaaJJs6KG+qwQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472742; c=relaxed/simple;
	bh=EQjWnSkdAXaSrCFiO96RSYAuq6uV5rmr2APeMYWUk2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8gRbixw9JPHEXvEU/nWtPEliXR9PropdO/yF9c3gAXT65BoYKyYqfZrcgGVXOPDkjBsS7G+WJBwD5t9cmIiZn98dAmUNCTQ76nVw7AHJgFcDjGMGsmuEuuyB1i6ef6FFffIVr78xCsHfqdJ0Nml7PFZkhQUr9jbY7VJBOyJFwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nys+YJQS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a52582ecde4so122012866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713472739; x=1714077539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kB9PcMjE0hVVpql+JbzqFJwr2b8GY15J6ZW7aMEdH3Q=;
        b=nys+YJQSD+bVtq0Co48PcXIVYeRGNykKREGFF+/QL7SEkPdariZrDfXd8UjgV9BdM9
         55fBydZ6jx3w7G/PF8bIt8fNamPQhrryGrVEDJS6NWAw62Lwkn/5fSo1BBKJKk53QZh4
         BH7sWmiD8hoiapl75oSTrDtFyI5zIkHFbO9nAeIHbkAEUtRQHiHJQaEiwDcE5PO0byrF
         qRmkulUB0Wds/AIJm6zVHiKSna9HC+C+M8qk25X5RO7OBya28nTikrSc21gtRJEwWnKt
         R16rJxEnTMjw6iK1jPla0z2LbRo6cQuirj207jiLAxcdgfwHupq33ZCN7GXWEj2Gv3df
         K8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713472739; x=1714077539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kB9PcMjE0hVVpql+JbzqFJwr2b8GY15J6ZW7aMEdH3Q=;
        b=oDo1D0HhixhiTmgYVogBbHEbjL1DkgvWdMKUFnyGobvJaPCyV+rnVA9Vo3Fre9CW17
         fH3L6My+BP5xuJj3aS9j1dkq2wvhRudh8H8+WdrLoGpOFJU40LJnuzjs9Zog5AulI5bE
         ii//Ur1nxZiWNWPf65k1O3xfLVrwa43WqVjDIDvcUS1YXBgiqESPTsvIZPKzzcw03Ksd
         66er7em5HwE/qMQiVXPq5zo6p4ChDSR1GxT8nA0TY7CfXzBEwScxwpiBJ+8OzuI53q6h
         eyyMlK7lwLToNy1iekTHVh1X/pNof/kXVo2Jv3cdR4VIe1MsoL3fHBSf5MCrSc5WN7qS
         N0hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKsKoS7CGT7XLfcXGyf4pXB2LHe4JcgmZGqbdGgLkWd21YivUOLUbOU0b1JCEd+Uxn+g2RYAD1qywGQ0h319ZLszwu+PEjA7pdGXm3
X-Gm-Message-State: AOJu0Yw1WMrliFH2TaDPIramLuXXyYP9DkxKLIeTH61QyoMyPdpWqNhe
	04eDXnFhXd+kTwJs6Bfq1LQ+jddkdkSAQ8rnt8wsaSib5zxYgyjGl5ZnEZqZOxUnbf9Ny/v2iFF
	z8UpkFEAOk/467vs+wA6Mv/0q6CCDsSSGQC3g
X-Google-Smtp-Source: AGHT+IE5WBFPkQE1UYAhvIFf0d5mnAUdlsEGWrhC2zVPDjA0RfuTTaSKcmUw73ewun1AK1uASHQuPihQ9bZCIaT/BJw=
X-Received: by 2002:a17:906:a24c:b0:a55:59e6:13f5 with SMTP id
 bi12-20020a170906a24c00b00a5559e613f5mr170031ejb.26.1713472738744; Thu, 18
 Apr 2024 13:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328989335.3930751.3091577850420501533.stgit@firesoul> <CAJD7tkZFnQK9CFofp5rxa7Mv9wYH2vWF=Bb28Dchupm8LRt7Aw@mail.gmail.com>
 <651a52ac-b545-4b25-b82f-ad3a2a57bf69@kernel.org>
In-Reply-To: <651a52ac-b545-4b25-b82f-ad3a2a57bf69@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 18 Apr 2024 13:38:20 -0700
Message-ID: <CAJD7tkbU1PB6ocRUVM0mw_q-c6kq1r9WsgkZwe1ppNkZG8KdQA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] cgroup/rstat: convert cgroup_rstat_lock back to mutex
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	cgroups@vger.kernel.org, longman@redhat.com, netdev@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org, Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 2:02=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
org> wrote:
>
>
>
> On 18/04/2024 04.19, Yosry Ahmed wrote:
> > On Tue, Apr 16, 2024 at 10:51=E2=80=AFAM Jesper Dangaard Brouer <hawk@k=
ernel.org> wrote:
> >>
> >> Since kernel v4.18, cgroup_rstat_lock has been an IRQ-disabling spinlo=
ck,
> >> as introduced by commit 0fa294fb1985 ("cgroup: Replace cgroup_rstat_mu=
tex
> >> with a spinlock").
> >>
> >> Despite efforts in cgroup_rstat_flush_locked() to yield the lock when
> >> necessary during the collection of per-CPU stats, this approach has le=
d
> >> to several scaling issues observed in production environments. Holding
> >> this IRQ lock has caused starvation of other critical kernel functions=
,
> >> such as softirq (e.g., timers and netstack). Although kernel v6.8
> >> introduced optimizations in this area, we continue to observe instance=
s
> >> where the spin_lock is held for 64-128 ms in production.
> >>
> >> This patch converts cgroup_rstat_lock back to being a mutex lock. This
> >> change is made possible thanks to the significant effort by Yosry Ahme=
d
> >> to eliminate all atomic context use-cases through multiple commits,
> >> ending in 0a2dc6ac3329 ("cgroup: removecgroup_rstat_flush_atomic()"),
> >> included in kernel v6.5.
> >>
> >> After this patch lock contention will be less obvious, as converting t=
his
> >> to a mutex avoids multiple CPUs spinning while waiting for the lock, b=
ut
> >> it doesn't remove the lock contention. It is recommended to use the
> >> tracepoints to diagnose this.
> >
> > I will keep the high-level conversation about using the mutex here in
> > the cover letter thread, but I am wondering why we are keeping the
> > lock dropping logic here with the mutex?
> >
>
> I agree that yielding the mutex in the loop makes less sense.
> Especially since the raw_spin_unlock_irqrestore(cpu_lock, flags) call
> will be a preemption point for my softirq.   But I kept it because, we
> are running a CONFIG_PREEMPT_VOLUNTARY kernel, so I still worried that
> there was no sched point for other userspace processes while holding the
> mutex, but I don't fully know the sched implication when holding a mutex.

I guess dropping the lock before rescheduling could be more preferable
in this case since we do not need to keep holding the lock for
correctness.

>
> > If this is to reduce lock contention, why does it depend on
> > need_resched()? spin_needbreak() is a good indicator for lock
> > contention, but need_resched() isn't, right?
> >
>
> As I said, I'm unsure of the semantics of holding a mutex.
>
>
> > Also, how was this tested?
> >
>
> I tested this in a testlab, prior to posting upstream, with parallel
> reader of the stat files.

I believe high concurrency is a key point here. CC'ing Wei who
reported regressions on previous attempts of mine before to address
the lock contention from userspace.

> As I said in other mail, I plan to experiment
> with these patches(2+3) in production, as micro-benchmarking will not
> reveal the corner cases we care about.

Right, but micro-benchmarking should give us a signal about
regressions. It was very useful for me when working with this code
before to use synthetic benchmarks with high concurrency of userspace
reads and/or kernel flushers.

