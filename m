Return-Path: <linux-kernel+bounces-103819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C64E87C4F0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173231C215F4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399C1768F3;
	Thu, 14 Mar 2024 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ukgABkwc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+ICCrXr3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D5768E5;
	Thu, 14 Mar 2024 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710453533; cv=none; b=VM4dBjRs0u93/Z1/K9qOv1P3OVQTZl5TPtyyNYIThQjainNLD9QnMsu3NjARkef3ODNXjLmOUXbBYDGU8ek296aekn4N/KT4DNZg1q8uEgpj/mqDwmr+imYIBB0FRpyDV6QD3eSd/zgimibrkh/LvLRevqj84k2XyIRH+Dx3mgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710453533; c=relaxed/simple;
	bh=/LiMqQj6Zh6GRzKDPJYYTBTObTTpqnKmWdqCvF34vKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JZuZ0aN8F5Pn7/d9NCAXRHRSHT9vFEi2IX9IaKYVVKq/sVqOZPSzhVbTtG06UqN+u53p5TWA12o+eHpip8Notb6U7+wwelt1tNG9kWkrJFmL+PnjPrlmIygWJt7AAG0qbWOZJ+W++RKbIYievLClojgGjQ0LLz3YZW0CPv0K/YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ukgABkwc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+ICCrXr3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710453529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAw3UnXOoaozEMCHtkHUVhe4NF/Llc4/omxDgXYSyJg=;
	b=ukgABkwcP1Hh41KOQ30VvjLADYhty8ArZH3ufQJypa8a6QuwxX8CeDAf1iX5b2nLBt44ym
	c1peEM0m3KX1bqRR0mW53rkYg0qIfqHybmuP86HFScTiGc0rtcwEnp+deeg5gdOi32f/rF
	A6DS6H3E3v97psxsuWDoQZohK0icw2mjp+iBxq/g3UXUy4gujnOQ/WGbGEKe0MZENdh7y/
	IVk7zK65d+va0/pnRu2vVRz4yPFy81Qm2PgTx4+tUosY9kCCmN3990vPuyqSwjIyxqUZmN
	E0xKP32tdxKGq9Rcz8L0S4DGd59rkXd5JH2ri2miLSaf0F6mDam92ntkYHXVaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710453529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAw3UnXOoaozEMCHtkHUVhe4NF/Llc4/omxDgXYSyJg=;
	b=+ICCrXr3eS6MlECMRJQF7Fishb6GYM0fbHXKYfl+RUEcv6BSuHFbp8um1o0FcXoQW1Rjhx
	heW56wEY3xGR+eCw==
To: Florian Fainelli <f.fainelli@gmail.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Joel Fernandes <joel@joelfernandes.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, paulmck@kernel.org, mingo@kernel.org,
 rcu@vger.kernel.org, neeraj.upadhyay@amd.com, urezki@gmail.com,
 qiang.zhang1211@gmail.com, bigeasy@linutronix.de, chenzhongjin@huawei.com,
 yangjihong1@huawei.com, rostedt@goodmis.org, Justin Chen
 <justin.chen@broadcom.com>
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes
 for v6.9]
In-Reply-To: <87sf0sldbi.ffs@tglx>
References: <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux>
 <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
 <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com>
 <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
 <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
 <ZfIuRMo8oKbR08Af@lothringen>
 <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
 <ZfLUU+XuQC7W79tf@lothringen>
 <d6c8e4fe-17bf-443d-a6f5-54470390e1fd@gmail.com>
 <ZfNHNvzpqf8DOZd8@boqun-archlinux>
 <de038bee-cecd-4e76-b0f4-5822b68e439d@gmail.com> <87v85olez3.ffs@tglx>
 <87sf0sldbi.ffs@tglx>
Date: Thu, 14 Mar 2024 22:58:49 +0100
Message-ID: <87plvwlbl2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 14 2024 at 22:21, Thomas Gleixner wrote:

> On Thu, Mar 14 2024 at 21:45, Thomas Gleixner wrote:
>> On Thu, Mar 14 2024 at 12:09, Florian Fainelli wrote:
>>> https://gist.github.com/ffainelli/cb562c1a60ef8e0e69e7d42143c48e8f
>>>
>>> this one is does include the tmigr events. Thanks!
>>
>> You need 8ca1836769d758e4fbf5851bb81e181c52193f5d too.
>
> So from the above trace it's clear where it goes south:
>
> [  236.318158]   <idle>-0         3..s.. 2928466us : tmigr_handle_remote: group=aecb05cb lvl=0
> [  236.326526]   <idle>-0         3d.s.. 2928467us : tmigr_handle_remote_cpu: cpu=0 parent=aecb05cb wakeup=9223372036854775807
> [  236.357809]   <idle>-0         3d.s.. 2928469us : tmigr_update_events: child=00000000 group=aecb05cb group_lvl=0 child_active=0 group_active=8 nextevt=3103000000 next_expiry=2934000000 child_evt_expiry=0 child_evtcpu=0
>
> [  236.377222]   <idle>-0         0dn... 2928471us : tmigr_cpu_active: cpu=0 parent=aecb05cb wakeup=9223372036854775807
> [  236.387765]   <idle>-0         0dn... 2928471us : tmigr_group_set_cpu_active: group=aecb05cb lvl=0 numa=0 active=9 migrator=8 parent=00000000 childmask=1
>
> [  236.401526]   <idle>-0         0d.... 2928477us : tmigr_update_events: child=00000000 group=aecb05cb group_lvl=0 child_active=0 group_active=8 nextevt=3103000000 next_expiry=2934000000 child_evt_expiry=0 child_evtcpu=0
> [  236.420940]   <idle>-0         0d.... 2928478us : tmigr_group_set_cpu_inactive: group=aecb05cb lvl=0 numa=0 active=8 migrator=8 parent=00000000 childmask=1
> [  236.434874]   <idle>-0         0d.... 2928478us : tmigr_cpu_idle: cpu=0 parent=aecb05cb nextevt=3103000000 wakeup=9223372036854775807
>
> [  236.446896]   <idle>-0         3d.... 2929469us : tmigr_group_set_cpu_inactive: group=aecb05cb lvl=0 numa=0 active=0 migrator=ff parent=00000000 childmask=8
> [  236.460916]   <idle>-0         3d.... 2929470us : tmigr_cpu_idle: cpu=3 parent=aecb05cb nextevt=9223372036854775807 wakeup=9223372036854775807
> [  236.473721]   <idle>-0         3d.... 2934471us : tmigr_cpu_new_timer_idle: cpu=3 parent=aecb05cb nextevt=9223372036854775807 wakeup=9223372036854775807
>
> CPU3 is the last active CPU and goes idle. So it should take care of the
> pending events, but it does not.
>
> This is the next trace entry where CPU0 magically comes back to life.
>
> [  236.487393]   <idle>-0         0d.s.. 162001359us : timer_cancel: timer=8c725d84
>
> 8ca1836769d758e4fbf5851bb81e181c52193f5d is related, but dos not fully
> explain the fail. I haven't yet spotted where this goes into lala land.

The first expiring pending global timer is this one:

[  236.112089] kworker/-1198      1d.... 2923481us : timer_start: timer=ffd09a61 function=process_timeout expires=4294670230 [timeout=10] bucket_expiry=4294670231 cpu=1 idx=23 flags=

Bucket expiry is the relevant number: 4294670231 (jiffies)

The last timer expiry happened about 1ms before the fail:

[  236.344917]   <idle>-0         3..s.. 2928468us : timer_expire_entry: timer=2f09af03 function=process_timeout now=4294670225 baseclk=4294670225

Jiffies at that point: 4294670225

AFAICT this is a HZ=1000 configuration.

4294670231 - 4294670225 = 6

So the relevant wakeup should be around 2934468us

which is damned close to the point where the last active CPU vanishes into idle:

> [  236.446896]   <idle>-0         3d.... 2929469us : tmigr_group_set_cpu_inactive: group=aecb05cb lvl=0 numa=0 active=0 migrator=ff parent=00000000 childmask=8
> [  236.460916]   <idle>-0         3d.... 2929470us : tmigr_cpu_idle: cpu=3 parent=aecb05cb nextevt=9223372036854775807 wakeup=9223372036854775807
> [  236.473721]   <idle>-0         3d.... 2934471us : tmigr_cpu_new_timer_idle: cpu=3 parent=aecb05cb nextevt=9223372036854775807 wakeup=9223372036854775807

Unless someone beats me to it, I'm going to continue staring at that
code tomorrow as my brain has started to melt by now.

Thanks,

        tglx

