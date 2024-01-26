Return-Path: <linux-kernel+bounces-40098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E58383DA46
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD82F1F27A25
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E79119452;
	Fri, 26 Jan 2024 12:43:32 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4E18040
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273012; cv=none; b=D6TGTB7j7KcvtTBaVa6vLdq6YYaYgISg1MfTNdu18UW4icCnQNtNruZcyJD45s7NK3vswwfg3wrCVZKnuguy5/wJkD5+Yya0sJeDcD6To2gwIA1trXlIrVwsMSX6GD0rom4jBQy72oA9iX7OkissUb0WaxRsucQfP3oDSyDmW30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273012; c=relaxed/simple;
	bh=YEvuQE0egY0EGa0GmaZ/uR8m+fkDJrKEvI3b3UJKoy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EVAFjTvTjaP4k7597kXRFqiXa1FiKl2x4Ivx1APgNxtWe7CRg0Rpof4djgL4dsjVKyVktRt46E6JzWs7xYLwgTgyDnVVLOoD2yf0BCezU5gk0kesJRdYzLC8G64W1JrH9VMpj9004jRDhcmaUA7kNKwXGkm95W7sjvM9Bu7ANlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.210])
	by sina.com (172.16.235.25) with ESMTP
	id 65B3A40E0000063A; Fri, 26 Jan 2024 20:22:40 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 84450634210253
X-SMAIL-UIID: 117540BEF18F4E7CAE5F98929E674A80-20240126-202240-1
From: Hillf Danton <hdanton@sina.com>
To: Benjamin Segall <bsegall@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: do not do lock handoff in percpu_up_write
Date: Fri, 26 Jan 2024 20:22:30 +0800
Message-Id: <20240126122230.838-1-hdanton@sina.com>
In-Reply-To: <xm267cjxf7f1.fsf@bsegall-linux.svl.corp.google.com>
References: <xm26zfwx7z5p.fsf@google.com> <20240123150541.1508-1-hdanton@sina.com> <20240125110456.783-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Jan 2024 13:08:02 -0800 Benjamin Segall <bsegall@google.com>
> Hillf Danton <hdanton@sina.com> writes:
> > On Wed, 24 Jan 2024 14:10:43 -0800 Benjamin Segall <bsegall@google.com>
> >> Hillf Danton <hdanton@sina.com> writes:
> >> > On Mon, 22 Jan 2024 14:59:14 -0800 Benjamin Segall <bsegall@google.com>
> >> >> So the actual problem we saw was that one job had severe slowdowns
> >> >> during startup with certain other jobs on the machine, and the slowdowns
> >> >> turned out to be some cgroup moves it did during startup. The antagonist
> >> >> jobs were spawning huge numbers of threads and some other internal bugs
> >> >> were exacerbating their contention. The lock handoff meant that a batch
> >> >> of antagonist threads would receive the read lock of
> >> >> cgroup_threadgroup_rwsem and at least some of those threads would take a
> >> >> long time to be scheduled.
> >> >
> >> > If you want to avoid starved lock waiter, take a look at RWSEM_FLAG_HANDOFF
> >> > in rwsem_down_read_slowpath().
> >> 
> >> rwsem's HANDOFF flag is the exact opposite of what this patch is doing.
> >
> > You and I are not on the same page.
> >
> >> Percpu-rwsem's current code has perfect handoff for read->write, and a very
> >> short window for write->read (or write->write) to be beaten by a new writer.
> >
> > Given no chance left for spin on owner who is legal to take a ten-minute nap,
> > the right thing known to do on behalf of starved waiters is to add the HANDOFF
> > mechanism without any heuristic like you proposed for instance, in order to
> > force lock acquirers to go the slow path.
> >
> > Only for thoughts.
> 
> This is not the type of slowdown that is the problem my patch is trying
> to address. (And due to the way percpu-rwsem works sem->ww is nearly
> entirely redundant with sem->block - the first waiting writer is instead
> waiting on rcuwait and holds sem->block while doing so)
> 
> The problem that my patch addresses is:
> 
> Writer is done: percpu_up_write
>   atomic_set_release(&sem->block, 0);  // #1
>   wake a batch of readers:
>     percpu_rwsem_wake_function -> __percpu_rwsem_trylock(reader) // #2
>   wake a single writer
>     percpu_rwsem_wake_function -> __percpu_rwsem_trylock(writer) // #3
> new writer wakes up (holding sem->block from #3)
>   sees the readers holding the lock from #2, now sleeps on rcuwait
> time passes // #4
> readers finally get to run, run quickly and release the lock
> now the writer gets to run
> 
> Currently the only source of unfairness/optimistic locking is the window
> between #1 and #2, which occur in quick succession, on the same thread,
> and with no SPIN_ON_OWNER to make this window more likely than it
> otherwise would be.

The sem->ww introduced closes the window between #1 and #2 by define
as it is derived from rwsem's HANDOFF.
> 
> My patch makes the entire #4 available to writers (or new readers), so
> that the woken writer will instead get to run immediately. This is

Victims rise in case the woken readers at #2 have been waiting more
than a minute while the woken writer less than 20ms.

> obviously much less fair, but provides much better throughput (ideally
> it might have some sort of delay, so that in more normal circumstances
> readers don't have to win the wakeup race by luck and being woken
> slightly sooner, but I don't have that).
> 
> This is also only useful because of the assumption that readers will
> almost always not actually block (among other required assumptions) - if

Like heuristic, any assumption makes the locking game more complex than
thought without real win.

> they regularly sleep while holding the lock, then saving writers from
> that first wakeup latency of readers isn't particularly helpful anymore,
> because they'll still be delayed by the other wakeup latencies.

