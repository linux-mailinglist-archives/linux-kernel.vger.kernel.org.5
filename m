Return-Path: <linux-kernel+bounces-103847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9929C87C55E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE631F21683
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F6749A;
	Thu, 14 Mar 2024 22:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pih3OuIG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QJTzQ2Zl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62964DF59;
	Thu, 14 Mar 2024 22:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710456715; cv=none; b=AzXLD41PkpKp19sLcJJD9v+gxtRjJDpG2YAv+gahSsmWxvnlfbVqP6H7tyBhxcNrRo01BMAZmSj0zlMekfmXgCBfFhsmvUJECI5MHc1He0rQjx4HPyEPMiMhkEdLpGtBzfO1wY6X6mSh26GYRYGSh9TKKQpzBZCjPTN4fsoYxBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710456715; c=relaxed/simple;
	bh=lfE9bu5HRXF5tO0qg8xsCSrAQraK0qItLSvD6agDm7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UeFwnOZAnr9iJ/u4lnkwyP6N9k78Wjw8BQL3NG73U0Wvv3MGrkAdQxRBKiIDhYrRAD88r8szwo9oiDYDEgtnMIv4UeGh/OUJT9zAWOIKFegZpJbpysb9a803IhNbrPLYKzvNdszAtNpN+FHuWjTmROyxX64SDb//49NqAvyqKsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pih3OuIG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QJTzQ2Zl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710456711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1x6BoiJ2R+wIuiaWxSk4Ux5uhLtUhIOpd/83aUhZwks=;
	b=Pih3OuIGQcS61QjoP2KuiE3390kbeQpxn9jx224nSXAfiXm/DFAqs1gIdULtefF/IvhZaW
	GzM1T0azw/jGvcVOobh4noA3MaieHLSPbdedWlIwKlBY6ZmDZvpVUHDN6TTrtXhzbTd7+n
	itZndrmMsEwIvo5rjhuCf5gJxQoeppijU+FJ1GSAKtYo/Nul7e2tuOjDlLRZKmr4VLhzBN
	xU/I3+wGyucQSX9IX8GnX9RQLIBOJmh27ZxQNmjqm6udQseFnXPljITNc1dKxrnQfV6l3T
	mMuPtFDhg6lnleujOHsR/H9ffW3IMMV13tTqKLsv7HC87R1Wpoo61MPOhWwtQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710456711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1x6BoiJ2R+wIuiaWxSk4Ux5uhLtUhIOpd/83aUhZwks=;
	b=QJTzQ2ZluUTsc5i71qrPP987FUBaJDN+dSu+Hca8zgsZ1hJB2fR3pPrGD2lw4yfF/Fbsly
	uGeLP0YHgtHjVSCQ==
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
In-Reply-To: <8f977bbb-d949-4e90-b3d2-b9815189b842@gmail.com>
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
 <87sf0sldbi.ffs@tglx> <8f977bbb-d949-4e90-b3d2-b9815189b842@gmail.com>
Date: Thu, 14 Mar 2024 23:51:50 +0100
Message-ID: <87msr0l94p.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 14 2024 at 14:53, Florian Fainelli wrote:
> On 3/14/24 14:21, Thomas Gleixner wrote:
>> 8ca1836769d758e4fbf5851bb81e181c52193f5d is related, but dos not fully
>> explain the fail. I haven't yet spotted where this goes into lala land.
>
> It was a lot harder to generate the same issue on cold boot against 
> 8ca1836769d758e4fbf5851bb81e181c52193f5d,

That's good as it points into the exactly right direction as far as I
can tell from the data we have, but I might be wrong at the end.

> however, just like against 36e40df35d2c1891fe58241640c7c95de4aa739b,
> it would happen resuming from suspend to DRAM whereby the CPU core(s)
> lost their power and had to be re-initialized. Eventually I got a cold
> boot log:
>
> https://gist.github.com/ffainelli/b5684585c78518a5492cbbf1c7dce16e

The picture is similar to the one before:

<idle>-0         2d.... 3016627us : tmigr_update_events: child=00000000 group=6b74d49d group_lvl=0 child_active=0 group_active=1 nextevt=3023000000 next_expiry=3023000000 child_evt_expiry=0 child_evtcpu=0
<idle>-0         2d.... 3016628us : tmigr_group_set_cpu_inactive: group=6b74d49d lvl=0 numa=0 active=1 migrator=1 parent=00000000 childmask=4
<idle>-0         2d.... 3016629us : tmigr_cpu_idle: cpu=2 parent=6b74d49d nextevt=3023000000 wakeup=9223372036854775807

<idle>-0         0d.... 3016684us : tmigr_group_set_cpu_inactive: group=6b74d49d lvl=0 numa=0 active=0 migrator=ff parent=00000000 childmask=1
<idle>-0         0d.... 3016685us : tmigr_cpu_idle: cpu=0 parent=6b74d49d nextevt=9223372036854775807 wakeup=9223372036854775807
<idle>-0         0d.... 3024623us : tmigr_cpu_new_timer_idle: cpu=0 parent=6b74d49d nextevt=9223372036854775807 wakeup=9223372036854775807

<idle>-0         1d.s.. 162080532us : timer_cancel: timer=2e281df7

Just a different CPU this time.

The first expiring timer:

kcompact-42        1d.... 2552891us : timer_start: timer=2e281df7 function=process_timeout expires=4294670348 [timeout=500] bucket_expiry=4294670352 cpu=1 idx=66 flags=

Last expiry before going south:

   <idle>-0         1..s.. 3006620us : timer_expire_entry: timer=6f47b280 function=process_timeout now=4294670302 baseclk=4294670302

4294670352 - 4294670302 = 50

3006620us + 50*1000us = 3056620us

So the previous observation of hitting the exact point of the last CPU
going idle does not matter.

What really bothers me is:

<idle>-0         2d.... 3016629us : tmigr_cpu_idle: cpu=2 parent=6b74d49d nextevt=3023000000 wakeup=9223372036854775807

which has an event between these events:

<idle>-0         0d.... 3016685us : tmigr_cpu_idle: cpu=0 parent=6b74d49d nextevt=9223372036854775807 wakeup=9223372036854775807
<idle>-0         0d.... 3024623us : tmigr_cpu_new_timer_idle: cpu=0 parent=6b74d49d nextevt=9223372036854775807 wakeup=9223372036854775807

But that event is before the next expiring timer. Confused, but Frederic
just told me on IRC he's on to something.

> Does the consistent ~159s mean anything?

I don't think so. It might be the limitation of the clockevent device,
the maximum sleep time restriction or some other unrelated event (device
interrupt, hrtimer) which happens to pop up after this time for some
reason.

But it's definitely not relevant to the problem itself. It's just the
thing which brings the machine back to life. Otherwise it might sit
there forever.

Thanks,

        tglx

