Return-Path: <linux-kernel+bounces-99170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31461878467
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3FBA1F2110C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A831F4503F;
	Mon, 11 Mar 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="I3lQTwkg"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168851B599
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172869; cv=none; b=R5W4gOwGA2yzb1y7OoCHqszCgYEJw+D6Fn7DRsoNwaaQXeA6AzwADwvJXnGAZxFN6j9mLjGAviwCgnckWDBFjDJzCahHGbf6naRH+mMnpyfLOKBb3a3eVnAxP2Tex0OrlhFaqtn30It1CwYRRuHIefh2YUyWfQIelr2d5Ccph7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172869; c=relaxed/simple;
	bh=XNQK/9H9S/TRV1NaA5lRp99yrcK2KjfLQCczuJnqzks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2BYBK56qsC0q1DJb8uqHlWKKJ3x/mt/g4ujC2yXRb/YeZZapDdecJBKSbLGK8hvs29CD/m1MCno4A+JYdtELVb8Fe1D5OPAYBbTcoSNXINQQ5t4trvhIBGguvu5dVPbIWgFtUn5IPzflqrro4KcY3UeimmItiQ0I3KEh/dDSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=I3lQTwkg; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-690d103a16fso8331616d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710172867; x=1710777667; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1N7co8NWWbrgWO/PhCUEvz9SlxrSNp3j8wIFjBPjv4=;
        b=I3lQTwkgg3r+7fykGpEbuvampZ89nWaFoVpxl3TB282cE8mkcA6vkUEsCSpkOarspU
         wga5UdxEA9nq9+PZUHw3xLWZ0bdkjV/9XBni5uJ0YY52yF8uigMpXgMcEIaYs7XKX4GG
         lH2zfMLjwD0h/uxN86d4oIKzzRV+alIxl3sFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710172867; x=1710777667;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1N7co8NWWbrgWO/PhCUEvz9SlxrSNp3j8wIFjBPjv4=;
        b=ZV6xOQUkO0GLCXdPtEsvAzoPrTsySfklEwJP9I3AYA39yUxhcTBjrML2ZipYtqoZoo
         Nrci7ogJ24Ace2Hi2M988iw1Y5eydTvET8g+TKCAVzCcqnQFsY+sU07lmZY9VZTxF4go
         RCWjkrERQ9Rif6k511nqGOBvAp1wWaGS699OO9bRpRjTg/IA2dk9hd9nRfUbXUvmuZcj
         BY077lfXjXuRAQSk/k55ULZMzXohMCD8omxTxJ+MjPztKDTfx6sLR6bXdFAoPBovwS4D
         XJF9avAE+QMWnYgkQTVrRgTAqWAqeN4amQvhvtJyd5m1s4DHuaWevj8hqaxnwFksKcHY
         Si2g==
X-Gm-Message-State: AOJu0YyQZsdBn4GZvvrDStzHObaLibkgm5yJI+zEMM6OdMaoDOKxvBHU
	dte4wmNhayJNVznfAvNDyBJErqTqqaa0VWk0sBFlHRi02sYuG3HxsdjiNNSouwI=
X-Google-Smtp-Source: AGHT+IEedX26MR8qvP2/dUT7bPe3lDS7rpbDNaTSAZ7d+VClyScny+YtPHr9raeMpVjPgfxQIxx5PA==
X-Received: by 2002:a05:6214:17c7:b0:690:cf9c:f568 with SMTP id cu7-20020a05621417c700b00690cf9cf568mr3778333qvb.14.1710172866793;
        Mon, 11 Mar 2024 09:01:06 -0700 (PDT)
Received: from [10.5.0.2] ([91.196.69.182])
        by smtp.gmail.com with ESMTPSA id g12-20020a0cf84c000000b00690b8a0e537sm2728405qvo.21.2024.03.11.09.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 09:01:05 -0700 (PDT)
Message-ID: <4e66c40b-5ac9-4b39-b3f6-f963f90d2b33@joelfernandes.org>
Date: Mon, 11 Mar 2024 12:01:04 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 rcu/dev 2/2] rcu/tree: Add comments explaining
 now-offline-CPU QS reports
Content-Language: en-US
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
 urezki@gmail.com, neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
 rostedt@goodmis.org, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
References: <20240308224439.281349-1-joel@joelfernandes.org>
 <20240308224439.281349-2-joel@joelfernandes.org>
 <01b4d228-9416-43f8-a62e-124b92e8741a@paulmck-laptop>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <01b4d228-9416-43f8-a62e-124b92e8741a@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/10/2024 3:43 PM, Paul E. McKenney wrote:
> On Fri, Mar 08, 2024 at 05:44:38PM -0500, Joel Fernandes (Google) wrote:
>> This a confusing piece of code (rightfully so as the issue it deals with
>> is complex). Recent discussions brought up a question -- what prevents the
>> rcu_implicit_dyntick_qs() from warning about QS reports for offline
>> CPUs.
>>
>> QS reporting for now-offline CPUs should only happen from:
>> - gp_init()
>> - rcutree_cpu_report_dead()
>>
>> Add some comments to this code explaining how QS reporting is not
>> missed when these functions are concurrently running.
>>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Thank you for putting this together!
> 
> A couple of questions below.
> 
> 							Thanx, Paul
> 
>> ---
>>  kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index bd29fe3c76bf..f3582f843a05 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -1917,7 +1917,22 @@ static noinline_for_stack bool rcu_gp_init(void)
> 
> Would it make sense to tag the earlier arch_spin_lock(&rcu_state.ofl_lock)
> as preventing grace period from starting concurrently with
> rcutree_report_cpu_dead()?

Yes, that makes sense.

> 
>>  		trace_rcu_grace_period_init(rcu_state.name, rnp->gp_seq,
>>  					    rnp->level, rnp->grplo,
>>  					    rnp->grphi, rnp->qsmask);
>> -		/* Quiescent states for tasks on any now-offline CPUs. */
>> +		/*
>> +		 * === Quiescent states for tasks on any now-offline CPUs. ===
>> +		 *
>> +		 * QS reporting for now-offline CPUs should only be performed from
>> +		 * either here, i.e., gp_init() or from rcutree_report_cpu_dead().
>> +		 *
>> +		 * Note that, when reporting quiescent states for now-offline CPUs,
>> +		 * the sequence of code doing those reports while also accessing
>> +		 * ->qsmask and ->qsmaskinitnext, has to be an atomic sequence so
>> +		 * that QS reporting is not missed! Otherwise it possible that
>> +		 * rcu_implicit_dyntick_qs() screams. This is ensured by keeping
>> +		 * the rnp->lock acquired throughout these QS-reporting
>> +		 * sequences, which is also acquired in
>> +		 * rcutree_report_cpu_dead(), so, acquiring ofl_lock is not
>> +		 * necessary here to synchronize with that function.
>> +		 */
> 
> Would it be better to put the long-form description in the "Hotplug
> CPU" section of Documentation/RCU/Design/Requirements/Requirements.rst?

Yes, totally. In fact I see the following already in Requirements.rst Hotplug
section:

During the checking/modification of RCU's hotplug bookkeeping, the
corresponding CPU's leaf node lock is held. This avoids race conditions
between RCU's hotplug notifier hooks, the grace period initialization
code, and the FQS loop, all of which refer to or modify this bookkeeping.
--

So I/we could just expand it there and refer to the .rst from the code.

> I will be the first to admit that this section is not as detailed as it
> needs to be.  This section is already referenced by the block comment
> preceding the WARN_ON_ONCE() in rcu_implicit_dyntick_qs(), which is
> where people will look first if any of this gets messed up.

Yes great point, and it is referenced in rcu_gp_init() as well.
> 
> Then these other places can refer to that comment or to that section of
> Requirements.rst, allowing them to focus on the corresponding piece of
> the puzzle.

Makes sense.

>>  		mask = rnp->qsmask & ~rnp->qsmaskinitnext;
>>  		rnp->rcu_gp_init_mask = mask;
>>  		if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp))
>> @@ -5116,6 +5131,25 @@ void rcutree_report_cpu_dead(void)
>>  	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
>>  	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
>>  	rdp->rcu_ofl_gp_state = READ_ONCE(rcu_state.gp_state);
>> +
>> +	/*
>> +	 * === Quiescent state reporting for now-offline CPUs ===
>> +	 *
>> +	 * QS reporting for now-offline CPUs should only be performed from
>> +	 * either here, i.e. rcutree_report_cpu_dead(), or gp_init().
>> +	 *
>> +	 * Note that, when reporting quiescent states for now-offline CPUs,
>> +	 * the sequence of code doing those reports while also accessing
>> +	 * ->qsmask and ->qsmaskinitnext, has to be an atomic sequence so
>> +	 * that QS reporting is not missed! Otherwise it possible that
>> +	 * rcu_implicit_dyntick_qs() screams. This is ensured by keeping
>> +	 * the rnp->lock acquired throughout these QS-reporting sequences, which
>> +	 * is also acquired in gp_init().
>> +	 * One slight change to this rule is below, where we release and
>> +	 * reacquire the lock after a QS report, but before we clear the
>> +	 * ->qsmaskinitnext bit. That is OK to do, because gp_init() report a
>> +	 * QS again, if it acquired the rnp->lock before we reacquired below.
>> +	 */
> 
> And then this need only say what is happening right here, but possibly
> moved to within the following "if" statement, at which point we know that
> we are in a grace period that cannot end until we report the quiescent
> state (which releases the rcu_node structure's ->lock) and a new grace
> period cannot look at this rcu_node structure's ->qsmaskinitnext until
> we release rcu_state.ofl_lock.

Yes, it makes sense and we should mention the ofl_lock as well as you note.

I have an trip starting in 2 weeks that goes on for 3 weeks shortly so I'm
scrambling a bit for time, and may get to this only after. If Neeraj is
interested in documenting this, he is more than welcome, especially since he
also understands this code very well ;-).

(See what I did there with the 'also' ? :P)

thanks,

 - Joel




