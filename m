Return-Path: <linux-kernel+bounces-39286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FE383CE2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8161C22B99
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689A413A253;
	Thu, 25 Jan 2024 21:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WtXUXe9I"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B171386D1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216888; cv=none; b=U4+3dAb5eTN0nLQoIuVuPvjyMN9l3wNR2M874pWI4rxPioVJFNy68PB1Zd/v8U0PCqszMhCPvmQZGfxQTYv+GnN2Z9gTppdVZUg/sVNHw+PBVoC3+Mcis02xcNpC/QVz+dpIf7GYm//vyLs1iEUyHD0vlwZa2gmI8v1dLXVHN+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216888; c=relaxed/simple;
	bh=v7D10LC1IYJVMcVqIlggcbChtoNx6N0e6LH0lrQrDoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NfaIlveTYguieB4Jl7afKRkywR1ESlvjbgph+eZbwU6x3t0g3Z1GH68wX3/qZK3cE86QG95NzQpBIy2h7zT8J+lTvD3ObbUg86buItgq19AMXSh6IldV5ByPIPn78aR1gnCGbmw2ecepT1aBOOpa/7G5FLLq3Sl/oSQQh1j1cpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WtXUXe9I; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d76f1e3e85so35005ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706216886; x=1706821686; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mBrFTwcWP7F+cVqEkBO6PNCSb9j3A08bRDVn6WGCUsY=;
        b=WtXUXe9ItgDAIAsQC9krCWe3bC22foLg+kzmv7aBu9oaz82US939tDzL2k05f98vQf
         lZYeeMOaHvhWvrBTVteXgAxKCfGyNBNzhKM9bh0hUnLA8Yd2wdPoCromDqLnFy7EH+zn
         M7olbdyz3NqDt9wlDPR2XY/iSWQVKRYHTMWzwu6nHMvvzsjMrzX1ThcwP4/O1BQhAz2q
         f7qX1u6fHGSVaBHbkUIpxiyrXnhgMyrlS78HW4+ZLVlCaAA4XwRtfKURqa7t+qscc5dk
         TzwzOCiDwn1cwCxMWo/6rIrB1proGb0DOPliLLoqoDIahnTASx0YB1HfsfnaKvzqEdnh
         BaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706216886; x=1706821686;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBrFTwcWP7F+cVqEkBO6PNCSb9j3A08bRDVn6WGCUsY=;
        b=pPSFTEEuVu5cCNY5M4gboVu9PDEnS48RUhqddtz+newOFVvGdAffa8wpx5FizU2LB/
         q4INeeG8VB3HG6JGMP1yh+Lpz7n7WngyRjgns8VG3+GxfmVBSVblsXziqv6IeFrv5gCx
         SgS+su1x393WceCHG882RhrXNdk31SUIQ7E9MNfNF/dcO/58oN2j43RAIelXtFZMUTJO
         gfL3wNBE+Xpl9FNklFZcjHygRMVZLOot1rX+XFD56pKniL/bFIhkF1qQXKYsY/hZkbIK
         z6bNEuBHeBgKgNwIbj21l9wmSKDfh9IRBZsKPycfjxRJv8qJvWH18f0+Xg24gbt3XBvO
         EliQ==
X-Gm-Message-State: AOJu0Yz1gY4ijqa7Ej5QWfDsii2sQ/VyPd1XqlofwZG0AhLwm6q5oSFm
	zb5NBT4B3Ise1cGPp83Tg35zBu73tlyK5SMV+VF46o4PBv2FUEgJKfZ2RapRIksaJGltV268tKg
	Abg==
X-Google-Smtp-Source: AGHT+IFPq6TvT2sgEczYhtqRpNMOXMDVQXbU4zzwUKJL3XAs8tCZr6FX/UutBnKxPyxWQ4AdSTctrg==
X-Received: by 2002:a17:902:ea10:b0:1d7:692e:3c8b with SMTP id s16-20020a170902ea1000b001d7692e3c8bmr5253plg.13.1706216885611;
        Thu, 25 Jan 2024 13:08:05 -0800 (PST)
Received: from bsegall-linux.svl.corp.google.com.localhost ([2620:15c:2a3:200:1ebe:31e4:1b4a:7f02])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090276c200b001d5d736d1b2sm12315858plt.261.2024.01.25.13.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 13:08:05 -0800 (PST)
From: Benjamin Segall <bsegall@google.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,
  Will Deacon <will@kernel.org>,  Waiman Long <longman@redhat.com>,  Boqun
 Feng <boqun.feng@gmail.com>,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: do not do lock handoff in
 percpu_up_write
In-Reply-To: <20240125110456.783-1-hdanton@sina.com> (Hillf Danton's message
	of "Thu, 25 Jan 2024 19:04:56 +0800")
References: <xm26zfwx7z5p.fsf@google.com>
	<20240123150541.1508-1-hdanton@sina.com>
	<20240125110456.783-1-hdanton@sina.com>
Date: Thu, 25 Jan 2024 13:08:02 -0800
Message-ID: <xm267cjxf7f1.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hillf Danton <hdanton@sina.com> writes:

> On Wed, 24 Jan 2024 14:10:43 -0800 Benjamin Segall <bsegall@google.com>
>> Hillf Danton <hdanton@sina.com> writes:
>> > On Mon, 22 Jan 2024 14:59:14 -0800 Benjamin Segall <bsegall@google.com>
>> >> So the actual problem we saw was that one job had severe slowdowns
>> >> during startup with certain other jobs on the machine, and the slowdowns
>> >> turned out to be some cgroup moves it did during startup. The antagonist
>> >> jobs were spawning huge numbers of threads and some other internal bugs
>> >> were exacerbating their contention. The lock handoff meant that a batch
>> >> of antagonist threads would receive the read lock of
>> >> cgroup_threadgroup_rwsem and at least some of those threads would take a
>> >> long time to be scheduled.
>> >
>> > If you want to avoid starved lock waiter, take a look at RWSEM_FLAG_HANDOFF
>> > in rwsem_down_read_slowpath().
>> 
>> rwsem's HANDOFF flag is the exact opposite of what this patch is doing.
>
> You and I are not on the same page.
>
>> Percpu-rwsem's current code has perfect handoff for read->write, and a very
>> short window for write->read (or write->write) to be beaten by a new writer.
>
> Given no chance left for spin on owner who is legal to take a ten-minute nap,
> the right thing known to do on behalf of starved waiters is to add the HANDOFF
> mechanism without any heuristic like you proposed for instance, in order to
> force lock acquirers to go the slow path.
>
> Only for thoughts.

This is not the type of slowdown that is the problem my patch is trying
to address. (And due to the way percpu-rwsem works sem->ww is nearly
entirely redundant with sem->block - the first waiting writer is instead
waiting on rcuwait and holds sem->block while doing so)

The problem that my patch addresses is:

Writer is done: percpu_up_write
  atomic_set_release(&sem->block, 0);  // #1
  wake a batch of readers:
    percpu_rwsem_wake_function -> __percpu_rwsem_trylock(reader) // #2
  wake a single writer
    percpu_rwsem_wake_function -> __percpu_rwsem_trylock(writer) // #3
new writer wakes up (holding sem->block from #3)
  sees the readers holding the lock from #2, now sleeps on rcuwait
time passes // #4
readers finally get to run, run quickly and release the lock
now the writer gets to run

Currently the only source of unfairness/optimistic locking is the window
between #1 and #2, which occur in quick succession, on the same thread,
and with no SPIN_ON_OWNER to make this window more likely than it
otherwise would be.

My patch makes the entire #4 available to writers (or new readers), so
that the woken writer will instead get to run immediately. This is
obviously much less fair, but provides much better throughput (ideally
it might have some sort of delay, so that in more normal circumstances
readers don't have to win the wakeup race by luck and being woken
slightly sooner, but I don't have that).

This is also only useful because of the assumption that readers will
almost always not actually block (among other required assumptions) - if
they regularly sleep while holding the lock, then saving writers from
that first wakeup latency of readers isn't particularly helpful anymore,
because they'll still be delayed by the other wakeup latencies.

