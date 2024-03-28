Return-Path: <linux-kernel+bounces-123601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4177890B99
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AF9298B93
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A997013B2B9;
	Thu, 28 Mar 2024 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1lRnD1T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEC313A3E4
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658404; cv=none; b=XFrsmuUfdIvZO2w90HTxs8+FVZUEJ7SJlRiIVX6Ri8L5rmF7me/ZRnaQvNgeLMeiHteVvL9qYbpmCbGC56oas+jyqmjRpk4QcscI800bQud5QDOn9849fU7to92rgwoeKByleMyuaT7V1z4WMi/Og5ld9baRcE1PooHhPTXJfsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658404; c=relaxed/simple;
	bh=JtoDLKPhVjReSgPmgvFPdymak+1I9+8VDqBX0AZiGVk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G9XCrvehrpLXKw0DAm2Os6KGZ5Fyk/7n6ncbvLOHMqskWnIRyr7BRCZChEK5X9E0DSejkLw2SLPpgNnjaPRFMSNQo2sEWNKOuv3ULVh5DCOWN88B1gkY6A2f/A9Gu1hmdMZv391p0jf57ozBN/Upso2JjSYBy5JDajJA1r0uu1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V1lRnD1T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711658402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1EkVi7s/8MlhEYExXdilpNvNL4sr92wH/0BIT7iNhyg=;
	b=V1lRnD1TaM4k9hoY9RwGERzQz68va74Z1ikyPyhReohIMLQSrk6eJJopi3kp3lVzOo1Z4j
	iNI10T/aOFYkBQJyu8x5nHQrgaXW2wyF1Bm5zyKqpBMcMGzvKtkOiJ5RxrKYboH6ktnqlK
	FLXzDGWSQeEf09UGzZh7PzeQ+E0KsJ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-6mYjidUJOpC64qE5UykkdQ-1; Thu, 28 Mar 2024 16:39:59 -0400
X-MC-Unique: 6mYjidUJOpC64qE5UykkdQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3418f237c0bso715003f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658399; x=1712263199;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EkVi7s/8MlhEYExXdilpNvNL4sr92wH/0BIT7iNhyg=;
        b=ZSLHJtIDOdgIXP5vUa0ZhPIRvX7XBidDPb4lBQqL+m+tlx7DejD+zC+8rmrviUocRF
         5XfipcNMKZUUtIdJsiF7+xHewsVqFiaMFPXPYPJwc4m59znekkfgcn2ixpZRkj30AFqi
         tapiNNsH4WuDyKzyBozqHTVARqAgcrAONIKi+BFXJFvAf6jVfV3D4ZG4dQq1npiWVfJN
         6YvvfgLhuGu8spQKKRp2KooUyhWemGQslg+4yjgY/F0fPCzix4lp63RMt79EN1QPyVCV
         2EiT9e/dFF3eLGqwE+U0PDhqxFcDkuLv3MNLAipLT1lM+Dl2rgz00hNS5ZRABmiUwTKy
         0dQQ==
X-Gm-Message-State: AOJu0YzfiOna07a/18VqszlsYJtxDwP+Qqsssyva9VgDDWsxOBi4eI1V
	8CMYZs/hKr7n0nJNPMSpFDQNbFTbyu+5AV0zjbBvb3gejJp8sA2vH11Sm5BkhWvHSxtgVJf+lTx
	Sf3Ph9CU3d4ZVnJca/Kjn+oBZCtGWdxYA1bXNPI6vhDdXBBO7OmfSAPZ8JsbcEA==
X-Received: by 2002:a05:6000:1ac7:b0:341:cf94:3fce with SMTP id i7-20020a0560001ac700b00341cf943fcemr122837wry.10.1711658398904;
        Thu, 28 Mar 2024 13:39:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlFuuGI/hmfixQO2obOOMtY2DfcdI5KoL5LgJmY6xG4aKatLKCbxQyKtFErCZiOGgQKLVWsw==
X-Received: by 2002:a05:6000:1ac7:b0:341:cf94:3fce with SMTP id i7-20020a0560001ac700b00341cf943fcemr122818wry.10.1711658398464;
        Thu, 28 Mar 2024 13:39:58 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id by7-20020a056000098700b0033ec94c6277sm2580126wrb.115.2024.03.28.13.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:39:58 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Alex Shi
 <alexs@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Barry Song <song.bao.hua@hisilicon.com>,
 Tejun Heo <tj@kernel.org>
Subject: Re: for_each_domain()/sched_domain_span() has offline CPUs (was Re:
 [PATCH 2/2] timers: Fix removed self-IPI on global timer's enqueue in
 nohz_full)
In-Reply-To: <87cyrfe7a3.ffs@tglx>
References: <20240318230729.15497-1-frederic@kernel.org>
 <20240318230729.15497-3-frederic@kernel.org>
 <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
 <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
 <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
 <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
 <Zf1sSv/6mQHJuJ8G@lothringen> <Zf2GDjekyemQKn7I@lothringen>
 <xhsmhwmppaqls.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <87cyrfe7a3.ffs@tglx>
Date: Thu, 28 Mar 2024 21:39:56 +0100
Message-ID: <xhsmhle62ay5f.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 27/03/24 21:42, Thomas Gleixner wrote:
> On Tue, Mar 26 2024 at 17:46, Valentin Schneider wrote:
>> On 22/03/24 14:22, Frederic Weisbecker wrote:
>>> On Fri, Mar 22, 2024 at 12:32:26PM +0100, Frederic Weisbecker wrote:
>> Now, on top of the above, there's one more thing worth noting:
>>   cpu_up_down_serialize_trainwrecks()
>>
>> This just flushes the cpuset work, so after that the sched_domain topology
>> should be sane. However I see it's invoked at the tail end of _cpu_down(),
>> IOW /after/ takedown_cpu() has run, which sounds too late. The comments
>> around this vs. lock ordering aren't very reassuring however, so I need to
>> look into this more.
>
> commit b22afcdf04c96ca58327784e280e10288cfd3303 has more information in
> the change log.
>
> TLDR: The problem is that cpusets have the lock order cpuset_mutex ->
> cpu_hotplug_lock in the hotplug path for whatever silly reason. So
> trying to flush the work from within the cpu hotplug lock write held
> region is guaranteed to dead lock.
>
> That's why all of this got deferred to a work queue. The flush at the
> end of the hotplug code after dropping the hotplug lock is there to
> prevent that user space sees the CPU hotplug uevent before the work is
> done. But of course between bringing the CPU offline and the flush the
> kernel internal state is inconsistent.
>

Thanks for the summary!

> There was an attempt to make the CPU hotplug path synchronous in commit
> a49e4629b5ed ("cpuset: Make cpuset hotplug synchronous") which got
> reverted with commit 2b729fe7f3 for the very wrong reason:
>
> https://lore.kernel.org/all/F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw/T/#u
>
>  (cpu_hotplug_lock){++++}-{0:0}:
>   lock_acquire+0xe4/0x25c
>   cpus_read_lock+0x50/0x154
>   static_key_slow_inc+0x18/0x30
>   mem_cgroup_css_alloc+0x824/0x8b0
>   cgroup_apply_control_enable+0x1d8/0x56c
>   cgroup_apply_control+0x40/0x344
>   cgroup_subtree_control_write+0x664/0x69c
>   cgroup_file_write+0x130/0x2e8
>   kernfs_fop_write+0x228/0x32c
>   __vfs_write+0x84/0x1d8
>   vfs_write+0x13c/0x1b4
>   ksys_write+0xb0/0x120
>
> Instead of the revert this should have been fixed by doing:
>
> +  cpus_read_lock();
>    mutex_lock();
>    mem_cgroup_css_alloc();
> -  static_key_slow_inc();
> +  static_key_slow_inc_cpuslocked();
>

So looking at the state of things now, writing to the
cgroup.subtree_control file looks like: 

  cgroup_file_write()
  `\
    cgroup_subtree_control_write()
    `\
      cgroup_kn_lock_live()
      `\
      | cgroup_lock()
      | `\
      |   mutex_lock(&cgroup_mutex);
      |
      cgroup_apply_control()
      `\
        cgroup_apply_control_enable()
        `\
          css_create()
          `\
            ss->css_alloc() [mem_cgroup_css_alloc()]
            `\
              static_branch_inc()        

and same with cgroup_mkdir(). So if we want to fix the ordering that caused
the revert, we'd probably want to go for:

  static inline void cgroup_lock(void)
  {
+       cpus_read_lock();
	mutex_lock(&cgroup_mutex);
  }

  static inline void cgroup_unlock(void)
  {
	mutex_unlock(&cgroup_mutex);
-       cpus_read_unlock();        
  }

+ a handful of +_cpuslocked() changes.

As for cpuset, it looks like it's following this lock order:

	cpus_read_lock();
	mutex_lock(&cpuset_mutex);

Which AFAICT is what we want.

> Sorry that I did not notice this back then because I was too focussed on
> fixing that uevent nonsense in a halfways sane way.
>
> After that revert cpuset locking became completely insane.
>
> cpuset_hotplug_cpus_read_trylock() is the most recent but also the most
> advanced part of that insanity. Seriously this commit is just tasteless
> and disgusting demonstration of how to paper over a problem which is not
> fully understood.
>
> After staring at it some more (including the history which led up to
> these insanities) I really think that the CPU hotplug path can be made
> truly synchronous and the memory hotplug path should just get the lock
> ordering correct.
>
> Can we please fix this for real and get all of this insanity out of the
> way

Yes please!

> including the nonsensical comments in the cpuset code:
>
>  * Call with cpuset_mutex held.  Takes cpus_read_lock().
>
>  ...
>
>        lockdep_assert_cpus_held();
>        lockdep_assert_held(&cpuset_mutex);
>
> Oh well...
>
> Thanks,
>
>         tglx


