Return-Path: <linux-kernel+bounces-151903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5760B8AB589
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3D02836A6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724EA13C9B1;
	Fri, 19 Apr 2024 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zIeHq+Th"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CAB13C3F2
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713554530; cv=none; b=aZE0DA9vJf2vWVPAFlV27ZAO/DD7jRck8ga6vpDjbIyRkixzIc81gqc0YOkAxaXq0Jzjw2yV6e1XYiXqZbu4itqXKp1lDRGRcUsgCzemLwWBVNpqscZw6n5xYa92JkKrSU0cpEAWR6JNOZqEQe2dd10JjW9mNLS8qZLBAwiNrKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713554530; c=relaxed/simple;
	bh=0Yf1np1EiQRR1H+HojMtCteZkzQwyIMTFpovj1tcuSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kun5Tl4SDTzcxYx0iyNJZOM/CR5O3k5D+ljlLbS7X/CdxnFJKYuvzQq7douQR8IN28KLxsO/x4GTDetvFi+VSppgkrIwhRnmg4Em07CaDh3XdE64sn3orcLiQ1qAcMtjmhi/S/vhUmnohvUUnU8VRLawq1/1cJeqkzK184rR4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zIeHq+Th; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a55602507a9so282038966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 12:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713554527; x=1714159327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cgxiaek1OC/UQSjtnluTE8oS+OxORZPByii8n2kRyX4=;
        b=zIeHq+Thn7YTr3RpZM3b+1yEJ5ovU/PQYkZPXZhio6P7bZctZbZiLGj24cRFIg5oFw
         kHsShSdrttqbvrsThk6/whQjz0PlCcUfi9PAf4QKVU5oX7NvZzjZaBMMDyrPYI9GHora
         hI3hMxb4Xu1V3yVOfG25Gh/oSvOu8DBaJD58mNQty4nZZrLQpNnEVabb3PHEhYmbTzGA
         lgOgUcUOb23NYEb7jAsI7wlpy/mr3hoJP9nOjpr1l7996mNf12bdNAiZCMNj5bHB4ACG
         eqCJxOZKZ8nwG30IxCBu7PLmFtG7SkTk/KB2EkG/EC5tdC+3LWFoAcNftt/ysDAJgcOt
         TXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713554527; x=1714159327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cgxiaek1OC/UQSjtnluTE8oS+OxORZPByii8n2kRyX4=;
        b=J2J+miFX4UAxw1xJDB2S0a/9Cjy/iqOmpa4+srY5mdTZ6ZSj7CT/TVCR1himqgTQC4
         j3UXSV2cf3g19BsGcCuBFEpqhOdTX0QZDycy8Od8Ay1U6/JKqtEaU/oA5zNdcpZDpz5h
         w9TS7+8wCI3L+CdMcEcOe2HwIVxUIobtcPXCwTDUk4QGZhhHT+6lCE3S2Kqlq+jg6jxc
         M+aYBwkJvb2K8OpGto28fjryEvJwAmtI86kTbl1YET4mSaG9sQV362OJPqDeiukSygPC
         gG8+xLpLcMoGb7FfL6bQJBW6BFO9c2Pcygx6kYv/8tnywJ0UmprLaF7fKW7fCIMr6q8r
         BmHg==
X-Forwarded-Encrypted: i=1; AJvYcCWfo4eQEAbcwF4kVtMlOV3TNODAtSKBxN/NppgErkVjLkVfMV4WmP3t4fk7g+jPt0902gp1CkzDooU7wVfJOL+WfkcNAKvWwW0KswsR
X-Gm-Message-State: AOJu0YxtYRimTUCX0BmltV6GIqg3PQWaep0JMk1i398QwRaMEoLV5HB6
	uawBT1Vbj1brlEl5LiqJ4xIuu+UQ3gayzOQd22o+PAfzk+NPSP2gWul6n9Gn55GAExA1CANSVXU
	VNGotShFWpCHR5BdL2DbbDstKXK4ZI86ZpSqX
X-Google-Smtp-Source: AGHT+IEBjBNkvxdmuTE9VnI6C88nKhqq8KjzGCHHIFj/6VLY3xCFjTvSpOxoFw/tjaW8RUkr6IZWX3lHaV1KlXwC0BQ=
X-Received: by 2002:a17:906:f255:b0:a52:2284:d97f with SMTP id
 gy21-20020a170906f25500b00a522284d97fmr2030488ejb.25.1713554526552; Fri, 19
 Apr 2024 12:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328989335.3930751.3091577850420501533.stgit@firesoul> <CAJD7tkZFnQK9CFofp5rxa7Mv9wYH2vWF=Bb28Dchupm8LRt7Aw@mail.gmail.com>
 <651a52ac-b545-4b25-b82f-ad3a2a57bf69@kernel.org> <lxzi557wfbrkrj6phdlub4nmtulzbegykbmroextadvssdyfhe@qarxog72lheh>
 <CAJD7tkYJZgWOeFuTMYNoyH=9+uX2qaRdwc4cNuFN9wdhneuHfA@mail.gmail.com>
 <6392f7e8-d14c-40f4-8a19-110dfffb9707@kernel.org> <gckdqiczjtyd5qdod6a7uyaxppbglg3fkgx2pideuscsyhdrmy@by6rlly6crmz>
In-Reply-To: <gckdqiczjtyd5qdod6a7uyaxppbglg3fkgx2pideuscsyhdrmy@by6rlly6crmz>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Apr 2024 12:21:30 -0700
Message-ID: <CAJD7tkbCzx1S9d0oK-wR7AY3O3ToBrEwKTaYTykE1WwczcYLBg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] cgroup/rstat: convert cgroup_rstat_lock back to mutex
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, hannes@cmpxchg.org, 
	lizefan.x@bytedance.com, cgroups@vger.kernel.org, longman@redhat.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> > > Perhaps we could experiment with always dropping the lock at CPU
> > > boundaries instead?
> > >
> >
> > I don't think this will be enough (always dropping the lock at CPU
> > boundaries).  My measured "lock-hold" times that is blocking IRQ (and
> > softirq) for too long.  When looking at prod with my new cgroup
> > tracepoint script[2]. When contention occurs, I see many Yields
> > happening and with same magnitude as Contended. But still see events
> > with long "lock-hold" times, even-though yields are high.
> >
> >  [2] https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_tracepoint.bt
> >
> > Example output:
> >
> >  12:46:56 High Lock-contention: wait: 739 usec (0 ms) on CPU:56 comm:kswapd7
> >  12:46:56 Long lock-hold time: 6381 usec (6 ms) on CPU:27 comm:kswapd3
> >  12:46:56 Long lock-hold time: 18905 usec (18 ms) on CPU:100
> > comm:kworker/u261:12
> >
> >  12:46:56  time elapsed: 36 sec (interval = 1 sec)
> >   Flushes(2051) 15/interval (avg 56/sec)
> >   Locks(44464) 1340/interval (avg 1235/sec)
> >   Yields(42413) 1325/interval (avg 1178/sec)
> >   Contended(42112) 1322/interval (avg 1169/sec)
> >
> > There is reported 15 flushes/sec, but locks are yielded quickly.
> >
> > More problematically (for softirq latency) we see a Long lock-hold time
> > reaching 18 ms.  For network RX softirq I need lower than 0.5ms latency,
> > to avoid RX-ring HW queue overflows.

Here we are measuring yields against contention, but the main problem
here is IRQ serving latency, which doesn't have to correlate with
contention, right?

Perhaps contention is causing us to yield the lock every nth cpu
boundary, but apparently this is not enough for IRQ serving latency.
Dropping the lock on each boundary should improve IRQ serving latency,
regardless of the presence of contention.

Let's focus on one problem at a time ;)

> >
> >
> > --Jesper
> > p.s. I'm seeing a pattern with kswapdN contending on this lock.
> >
> > @stack[697, kswapd3]:
> >         __cgroup_rstat_lock+107
> >         __cgroup_rstat_lock+107
> >         cgroup_rstat_flush_locked+851
> >         cgroup_rstat_flush+35
> >         shrink_node+226
> >         balance_pgdat+807
> >         kswapd+521
> >         kthread+228
> >         ret_from_fork+48
> >         ret_from_fork_asm+27
> >
> > @stack[698, kswapd4]:
> >         __cgroup_rstat_lock+107
> >         __cgroup_rstat_lock+107
> >         cgroup_rstat_flush_locked+851
> >         cgroup_rstat_flush+35
> >         shrink_node+226
> >         balance_pgdat+807
> >         kswapd+521
> >         kthread+228
> >         ret_from_fork+48
> >         ret_from_fork_asm+27
> >
> > @stack[699, kswapd5]:
> >         __cgroup_rstat_lock+107
> >         __cgroup_rstat_lock+107
> >         cgroup_rstat_flush_locked+851
> >         cgroup_rstat_flush+35
> >         shrink_node+226
> >         balance_pgdat+807
> >         kswapd+521
> >         kthread+228
> >         ret_from_fork+48
> >         ret_from_fork_asm+27
> >
>
> Can you simply replace mem_cgroup_flush_stats() in
> prepare_scan_control() with the ratelimited version and see if the issue
> still persists for your production traffic?

With thresholding, the fact that we reach cgroup_rstat_flush() means
that there is a high magnitude of pending updates. I think Jesper
mentioned 128 CPUs before, that means 128 * 64 (MEMCG_CHARGE_BATCH)
page-sized updates. That could be over 33 MBs with 4K page size.

I am not sure if it's fine to ignore such updates in shrink_node(),
especially that it is called in a loop sometimes so I imagine we may
want to see what changed after the last iteration.

>
> Also were you able to get which specific stats are getting the most
> updates?

This, on the other hand, would be very interesting. I think it is very
possible that we don't actually have 33 MBs of updates, but rather we
keep adding and subtracting from the same stat until we reach the
threshold. This could especially be true for hot stats like slab
allocations.

