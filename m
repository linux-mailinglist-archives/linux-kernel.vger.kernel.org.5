Return-Path: <linux-kernel+bounces-125220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A51A892268
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169931F26FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5382A1327E8;
	Fri, 29 Mar 2024 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUQ+br9k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF51369A4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711731979; cv=none; b=apY417ga1aMgrITnwIQJtAXcQmjRs9kWDOUW1K/e1vwFSDxa+om0Zr01qiewCuf5cgRioOhG+KocnTyehH04k6RP4SDDba4Yfa0WpVCkha0ENQ2QnNsbFYj8X4hkHJzTtNYTMfT/LDBnHHVpVmrO7TuhJ5NXF2SvYrScvFIuyIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711731979; c=relaxed/simple;
	bh=WrfdUwCGcCYmGv6LOayRQdPXFmIfN6EGbLG6mYqqvPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4/tquR0hE3URcZAgSE56MPfU2vVpJe6dVkE/8aOMYdV1N9H5vod6O2fydsBfsS7dzyl4jlcUdV6R8K/S1U2TzAY+AWil3mmD/J3nbM59aNVA7kLvMXybFpjkHDhW0BVzBLsWebDAZNKVVfpxHQLZ7je9R5dNtz08HnA+mkHirQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NUQ+br9k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711731976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PM00yeqiUULLz/D8q0agS9td+y/ss+xjeDqHl52jqqE=;
	b=NUQ+br9ksthFzvsXa3h5ZgliQZO6db0PsZAKB5wfGrwdOJPIPgf8eViVRv+TKDcRVo2h+h
	3UZ6FULAGtJrOQytnNQqX7lk0dkvMRQDvlAf6rYn1AdR9zX1P/FCVx1vSUWQ7QCmIU8QzJ
	5H/h6+6s+fuBP5wsxfsvwSWtaW/Yt5I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-RL7gkeLMPiqdUnPIiE8gqQ-1; Fri,
 29 Mar 2024 13:06:13 -0400
X-MC-Unique: RL7gkeLMPiqdUnPIiE8gqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 343813C28646;
	Fri, 29 Mar 2024 17:06:13 +0000 (UTC)
Received: from [10.22.17.128] (unknown [10.22.17.128])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5E35C3C20;
	Fri, 29 Mar 2024 17:06:12 +0000 (UTC)
Message-ID: <64f4db2e-0a7f-4de2-aa5a-25f32cefa746@redhat.com>
Date: Fri, 29 Mar 2024 13:06:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: for_each_domain()/sched_domain_span() has offline CPUs (was Re:
 [PATCH 2/2] timers: Fix removed self-IPI on global timer's enqueue in
 nohz_full)
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Valentin Schneider <vschneid@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Alex Shi <alexs@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Barry Song <song.bao.hua@hisilicon.com>
References: <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
 <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
 <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
 <Zf1sSv/6mQHJuJ8G@lothringen> <Zf2GDjekyemQKn7I@lothringen>
 <xhsmhwmppaqls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <87cyrfe7a3.ffs@tglx>
 <xhsmhle62ay5f.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <ZgYikMb5kZ7rxPp6@slm.duckdns.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZgYikMb5kZ7rxPp6@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 3/28/24 22:08, Tejun Heo wrote:
> (cc'ing Waiman and quoting whole body)
>
> Hello,
>
> On Thu, Mar 28, 2024 at 09:39:56PM +0100, Valentin Schneider wrote:
>> On 27/03/24 21:42, Thomas Gleixner wrote:
>>> On Tue, Mar 26 2024 at 17:46, Valentin Schneider wrote:
>>>> On 22/03/24 14:22, Frederic Weisbecker wrote:
>>>>> On Fri, Mar 22, 2024 at 12:32:26PM +0100, Frederic Weisbecker wrote:
>>>> Now, on top of the above, there's one more thing worth noting:
>>>>    cpu_up_down_serialize_trainwrecks()
>>>>
>>>> This just flushes the cpuset work, so after that the sched_domain topology
>>>> should be sane. However I see it's invoked at the tail end of _cpu_down(),
>>>> IOW /after/ takedown_cpu() has run, which sounds too late. The comments
>>>> around this vs. lock ordering aren't very reassuring however, so I need to
>>>> look into this more.
>>> commit b22afcdf04c96ca58327784e280e10288cfd3303 has more information in
>>> the change log.
>>>
>>> TLDR: The problem is that cpusets have the lock order cpuset_mutex ->
>>> cpu_hotplug_lock in the hotplug path for whatever silly reason. So
>>> trying to flush the work from within the cpu hotplug lock write held
>>> region is guaranteed to dead lock.
>>>
>>> That's why all of this got deferred to a work queue. The flush at the
>>> end of the hotplug code after dropping the hotplug lock is there to
>>> prevent that user space sees the CPU hotplug uevent before the work is
>>> done. But of course between bringing the CPU offline and the flush the
>>> kernel internal state is inconsistent.
>>>
>> Thanks for the summary!
>>
>>> There was an attempt to make the CPU hotplug path synchronous in commit
>>> a49e4629b5ed ("cpuset: Make cpuset hotplug synchronous") which got
>>> reverted with commit 2b729fe7f3 for the very wrong reason:
>>>
>>> https://lore.kernel.org/all/F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw/T/#u
>>>
>>>   (cpu_hotplug_lock){++++}-{0:0}:
>>>    lock_acquire+0xe4/0x25c
>>>    cpus_read_lock+0x50/0x154
>>>    static_key_slow_inc+0x18/0x30
>>>    mem_cgroup_css_alloc+0x824/0x8b0
>>>    cgroup_apply_control_enable+0x1d8/0x56c
>>>    cgroup_apply_control+0x40/0x344
>>>    cgroup_subtree_control_write+0x664/0x69c
>>>    cgroup_file_write+0x130/0x2e8
>>>    kernfs_fop_write+0x228/0x32c
>>>    __vfs_write+0x84/0x1d8
>>>    vfs_write+0x13c/0x1b4
>>>    ksys_write+0xb0/0x120
>>>
>>> Instead of the revert this should have been fixed by doing:
>>>
>>> +  cpus_read_lock();
>>>     mutex_lock();
>>>     mem_cgroup_css_alloc();
>>> -  static_key_slow_inc();
>>> +  static_key_slow_inc_cpuslocked();
>>>
>> So looking at the state of things now, writing to the
>> cgroup.subtree_control file looks like:
>>
>>    cgroup_file_write()
>>    `\
>>      cgroup_subtree_control_write()
>>      `\
>>        cgroup_kn_lock_live()
>>        `\
>>        | cgroup_lock()
>>        | `\
>>        |   mutex_lock(&cgroup_mutex);
>>        |
>>        cgroup_apply_control()
>>        `\
>>          cgroup_apply_control_enable()
>>          `\
>>            css_create()
>>            `\
>>              ss->css_alloc() [mem_cgroup_css_alloc()]
>>              `\
>>                static_branch_inc()
>>
>> and same with cgroup_mkdir(). So if we want to fix the ordering that caused
>> the revert, we'd probably want to go for:
>>
>>    static inline void cgroup_lock(void)
>>    {
>> +       cpus_read_lock();
>> 	mutex_lock(&cgroup_mutex);
>>    }
>>
>>    static inline void cgroup_unlock(void)
>>    {
>> 	mutex_unlock(&cgroup_mutex);
>> -       cpus_read_unlock();
>>    }
>>
>> + a handful of +_cpuslocked() changes.
>>
>> As for cpuset, it looks like it's following this lock order:
>>
>> 	cpus_read_lock();
>> 	mutex_lock(&cpuset_mutex);
>>
>> Which AFAICT is what we want.
>>
>>> Sorry that I did not notice this back then because I was too focussed on
>>> fixing that uevent nonsense in a halfways sane way.
>>>
>>> After that revert cpuset locking became completely insane.
>>>
>>> cpuset_hotplug_cpus_read_trylock() is the most recent but also the most
>>> advanced part of that insanity. Seriously this commit is just tasteless
>>> and disgusting demonstration of how to paper over a problem which is not
>>> fully understood.
>>>
>>> After staring at it some more (including the history which led up to
>>> these insanities) I really think that the CPU hotplug path can be made
>>> truly synchronous and the memory hotplug path should just get the lock
>>> ordering correct.
>>>
>>> Can we please fix this for real and get all of this insanity out of the
>>> way
>> Yes please!
> Yeah, making that operation synchronous would be nice. Waiman, you're a lot
> more familiar with this part than I am. Can you please take a look and see
> whether we can turn the sched domain updates synchronous?

Sure. I will take a look on how to make cpu hotplug sched domain update 
synchronous.

Cheers,
Longman


