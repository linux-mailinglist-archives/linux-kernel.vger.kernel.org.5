Return-Path: <linux-kernel+bounces-40635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F3383E374
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49251C23358
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD86241F4;
	Fri, 26 Jan 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bO6mjgAD"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB2122630
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706301649; cv=none; b=rG7KHiVhE5Eyul0eVfjeDonZkNzDtJKSb4IOwmOd3X9ukogi8ECNUq3tf5B21WRCgvtJcawxxA5iFeNkA0OrjzFEd4NocEJoRvw7e1yTKJtX4BDFS7NQMhOmoRzPT5npvXfXJw6aKl8vckyo5Fdp6l4m+0zj3B0SQgjcXJi2pw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706301649; c=relaxed/simple;
	bh=6OXb8yisA+wOMTyjl6MEUJlWvpsc7TPctZSOTFP70u4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TvlZ9ppMeLV2QIYOQA7wd1T8S42BsfePq6vqYutBYBnCkrXjnz7eA/rTzMTPeGzdrGUbTsL+kXD9cmoxe4+BOQznTuebV4RGjn7OzysjRbWMp6vJveGGD0PxOlsYutj0KMjQvuOBMSaz/SHJZZgablRu9xXpF1sRnjVCJwO1BIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bO6mjgAD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d76f1e3e85so27925ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 12:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706301647; x=1706906447; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H6OTEPwP1MRtepPp6KWjNIn59HVlFqvRSia0WO706Bo=;
        b=bO6mjgADMAH4BNKD29Ion9jDYJiOSfG5Q6mgMs6J9iES/fGB+UT6rTE8XwcEUH+i9F
         Mg6GVXVYlOlGI3ZZxO+X5jChGhZCktZcrtT/V39Zjt2CV28wrAUBef54O8fn/aZNkhWN
         XkYdg1qqLWo7vRgZpRlRJftmkhhVMlwPcpu5IFUKiXuvlUianHq4q/vBcWuxY6TUrvDI
         lJAenC9BimUdY6Y2riLnE5HpdGw7VYQ+SsDB/UCHY7SmC9NXeegm/gLifAP4KybUAyJt
         2W90ez2A9WqdD2JHDqEDsZ4u66fliPO+I1yC1ssHZ5DGZuDSOGV21Yl9/dZVnT3/tuZe
         MAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706301647; x=1706906447;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6OTEPwP1MRtepPp6KWjNIn59HVlFqvRSia0WO706Bo=;
        b=d9/8f95FFFHaYvD09bDfBUHaw7hXsY0+YOYH7psVfWwLladNqeylAeApOFkFt/Th9I
         uU7Iq6rhENAS/v1hZJKEJRgVxpH9RWi+fnU7ujw9meqicqo56HCTLteStOs5lW6zMTZn
         tVdGY/m2TR5kVPXTIF197RWXhwZsfuhGxkDpaNyt++RWIvkxgkB4euag2u66MPeKhUEw
         kUvduUyMXgJJHZnU8FV9tyqx+I4+AHnmy7qsEnKeVnH3lhDarVV0wVOIomnS9g6IRpug
         Q73MorzG1opda2XqmheheAWlDR8XJ2yADm93ZmYGdn9jJvLigFoh1QVFXQ+OSd72EO6O
         5C0Q==
X-Gm-Message-State: AOJu0Yz617MQNwJ/C3Ss909/CX7PqCzwf4Nrkc6Hu/w7nL/AqmYhjr7J
	mSVknDA5j8sx3p1HjwA4Ol9g5E0PvgflwHwN0bmbtamh4kyWJOGo3LrBQnRv0qg/Cjo2HmXj9C+
	8aQ==
X-Google-Smtp-Source: AGHT+IFS/S63C5F55yuuzBV3E/UsVCD1WdQTTaGa1I8BNB5qUUMQTHp6p2ZyCqDBmKt+Tnn/Ht/vog==
X-Received: by 2002:a17:903:1ca:b0:1d5:a08c:46a2 with SMTP id e10-20020a17090301ca00b001d5a08c46a2mr298319plh.2.1706301647182;
        Fri, 26 Jan 2024 12:40:47 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7854c000000b006ddcf5d5b0bsm1508884pfn.153.2024.01.26.12.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 12:40:46 -0800 (PST)
From: Benjamin Segall <bsegall@google.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,
  Will Deacon <will@kernel.org>,  Waiman Long <longman@redhat.com>,  Boqun
 Feng <boqun.feng@gmail.com>,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: do not do lock handoff in
 percpu_up_write
In-Reply-To: <20240126122230.838-1-hdanton@sina.com> (Hillf Danton's message
	of "Fri, 26 Jan 2024 20:22:30 +0800")
References: <xm26zfwx7z5p.fsf@google.com>
	<20240123150541.1508-1-hdanton@sina.com>
	<20240125110456.783-1-hdanton@sina.com>
	<20240126122230.838-1-hdanton@sina.com>
Date: Fri, 26 Jan 2024 12:40:43 -0800
Message-ID: <xm26sf2j3k1g.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hillf Danton <hdanton@sina.com> writes:

> On Thu, 25 Jan 2024 13:08:02 -0800 Benjamin Segall <bsegall@google.com>
>> Hillf Danton <hdanton@sina.com> writes:
>> > On Wed, 24 Jan 2024 14:10:43 -0800 Benjamin Segall <bsegall@google.com>
>> >> Hillf Danton <hdanton@sina.com> writes:
>> >> > On Mon, 22 Jan 2024 14:59:14 -0800 Benjamin Segall <bsegall@google.com>
>> >> >> So the actual problem we saw was that one job had severe slowdowns
>> >> >> during startup with certain other jobs on the machine, and the slowdowns
>> >> >> turned out to be some cgroup moves it did during startup. The antagonist
>> >> >> jobs were spawning huge numbers of threads and some other internal bugs
>> >> >> were exacerbating their contention. The lock handoff meant that a batch
>> >> >> of antagonist threads would receive the read lock of
>> >> >> cgroup_threadgroup_rwsem and at least some of those threads would take a
>> >> >> long time to be scheduled.
>> >> >
>> >> > If you want to avoid starved lock waiter, take a look at RWSEM_FLAG_HANDOFF
>> >> > in rwsem_down_read_slowpath().
>> >> 
>> >> rwsem's HANDOFF flag is the exact opposite of what this patch is doing.
>> >
>> > You and I are not on the same page.
>> >
>> >> Percpu-rwsem's current code has perfect handoff for read->write, and a very
>> >> short window for write->read (or write->write) to be beaten by a new writer.
>> >
>> > Given no chance left for spin on owner who is legal to take a ten-minute nap,
>> > the right thing known to do on behalf of starved waiters is to add the HANDOFF
>> > mechanism without any heuristic like you proposed for instance, in order to
>> > force lock acquirers to go the slow path.
>> >
>> > Only for thoughts.
>> 
>> This is not the type of slowdown that is the problem my patch is trying
>> to address. (And due to the way percpu-rwsem works sem->ww is nearly
>> entirely redundant with sem->block - the first waiting writer is instead
>> waiting on rcuwait and holds sem->block while doing so)
>> 
>> The problem that my patch addresses is:
>> 
>> Writer is done: percpu_up_write
>>   atomic_set_release(&sem->block, 0);  // #1
>>   wake a batch of readers:
>>     percpu_rwsem_wake_function -> __percpu_rwsem_trylock(reader) // #2
>>   wake a single writer
>>     percpu_rwsem_wake_function -> __percpu_rwsem_trylock(writer) // #3
>> new writer wakes up (holding sem->block from #3)
>>   sees the readers holding the lock from #2, now sleeps on rcuwait
>> time passes // #4
>> readers finally get to run, run quickly and release the lock
>> now the writer gets to run
>> 
>> Currently the only source of unfairness/optimistic locking is the window
>> between #1 and #2, which occur in quick succession, on the same thread,
>> and with no SPIN_ON_OWNER to make this window more likely than it
>> otherwise would be.
>
> The sem->ww introduced closes the window between #1 and #2 by define
> as it is derived from rwsem's HANDOFF.

Yes.

>> 
>> My patch makes the entire #4 available to writers (or new readers), so
>> that the woken writer will instead get to run immediately. This is
>
> Victims rise in case the woken readers at #2 have been waiting more
> than a minute while the woken writer less than 20ms.
>
>> obviously much less fair, but provides much better throughput (ideally
>> it might have some sort of delay, so that in more normal circumstances
>> readers don't have to win the wakeup race by luck and being woken
>> slightly sooner, but I don't have that).
>> 
>> This is also only useful because of the assumption that readers will
>> almost always not actually block (among other required assumptions) - if
>
> Like heuristic, any assumption makes the locking game more complex than
> thought without real win.
>

I'm fine with "no, fairness is more important than these performance
numbers or mitigating already-sorta-broken situations", but it's not
clear to me you've even understood the patch, because you keep only
talking about completely different forms of starvation, and suggesting
changes that would if anything make the situation worse.

