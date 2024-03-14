Return-Path: <linux-kernel+bounces-103056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D856C87BA77
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA381F22B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607D56D1A1;
	Thu, 14 Mar 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RDGWtlw8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6fAbWKbp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104446CDD9;
	Thu, 14 Mar 2024 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408733; cv=none; b=AkK4sfjfDza9Nkw8e5fWJD1HzQ+ZszRzLwgJJGPsU3Nq67bcRJzbA2aBAVqWLYSN6wlNhKpduXhAIN+7eOygHq28b0tuiAiaXUR7PPcNo+FDYlsYTQigkZ5I/k0OiHvTGLdC1jucLyNcB6G4NC1w5T31DlnB0PqB68MpLcgdKT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408733; c=relaxed/simple;
	bh=M/nzFUOSc2rh7oJwV7qPJLnRaPKXjfIvQpCYmMzHJ7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cy3A9GBUd2NP6B7SVEACE2cKe0R66sdTkGPthwibCVFcyiIGn/ZNPGHBYRoXFGVjcSwfQTzuBnk3moZ/vRCIdQKMeRxCAQINgpkecG8ohcqAcQi3OVEfUnOv4RL6A/awHJmJfk1FpvVmMBZJ8wkEuQ+rX7rLWKWUaEqVHO7XtHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RDGWtlw8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6fAbWKbp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710408724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N8TrgMR8y7z0t4Qq091mxwCJeAMw03oWCq6ybsKg5Ys=;
	b=RDGWtlw8A+YnbXdaAO3Q5c4eHfTcOJxPBJxo4EX03YHnaY99mjxo/LjfQdgu6QLjuKQxri
	U6Ev56U2iMohUuur6AmqiwhCrG3EWmKYZ/rKLhnOz17lB2VCW4Yf0j1r/n/91YSz0ugzwQ
	ev/zucwjk6Yg8t65d9rh3NByIqdvxHaAASBp45hacmQCY2FnvFZkTyWcD9CKgoKoyLuv18
	pxOMgvaLEv/2Es/aMdB11LEOoQEPEAwZqrp/H3dObPIbvjin4OA+x7G8rw1u9ElVklSUMD
	IPfAXKHWsSWa3U3c7scpb1KmK7BIvCDkvGasxwIHmULv41+HxY9G7R6K7x2r7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710408724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N8TrgMR8y7z0t4Qq091mxwCJeAMw03oWCq6ybsKg5Ys=;
	b=6fAbWKbp6g+P2ZRGwii8GzEO9Do+uI8Vg+JfQ9E8ZGMIIKVhXA7QjJnbymUhsOgdlwQweQ
	37Ni6cZ2CbRC5eDA==
To: Boqun Feng <boqun.feng@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>
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
In-Reply-To: <ZfKaHQXdYCKrT3Yr@Boquns-Mac-mini.home>
References: <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
 <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux>
 <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
 <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com>
 <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
 <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
 <ZfIuRMo8oKbR08Af@lothringen>
 <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
 <ZfKHKtt4ar6HyRKu@Boquns-Mac-mini.home>
 <ZfKaHQXdYCKrT3Yr@Boquns-Mac-mini.home>
Date: Thu, 14 Mar 2024 10:32:03 +0100
Message-ID: <87il1pma5o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 13 2024 at 23:33, Boqun Feng wrote:
> but here:
>
> 	[  221.555265] kworker/-44        0d.... 3279414us : timer_start: timer=95703ccd function=process_timeout expires=4294670586 [timeout=10] bucket_expiry=4294670587 cpu=0 idx =59 flags=
>
> this is a normal timer.
>
> 	[  221.571298] rcu_sche-15        3d.... 3279417us : timer_start: timer=7e541f87 function=process_timeout expires=4294670579 [timeout=3] bucket_expiry=4294670580 cpu=3 idx= 52 flags=
> 	[  221.587241]   <idle>-0         1d.s.. 3283405us : timer_cancel: timer=7e541f87
> 	[  221.594488]   <idle>-0         1..s.. 3283407us : timer_expire_entry: timer=7e541f87 function=process_timeout now=4294670580 baseclk=4294670580
> 	[  221.607388] rcu_sche-15        3d.... 3283416us : timer_start: timer=7e541f87 function=process_timeout expires=4294670583 [timeout=3] bucket_expiry=4294670584 cpu=3 idx= 56 flags=
> 	[  221.623331]   <idle>-0         1d.s.. 3287404us : timer_cancel: timer=7e541f87
> 	[  221.630578]   <idle>-0         1..s.. 3287405us : timer_expire_entry: timer=7e541f87 function=process_timeout now=4294670584 baseclk=4294670584
> 	[  221.643475]   <idle>-0         0d.s.. 162361292us : timer_cancel: timer=95703ccd
> 	[  221.650896]   <idle>-0         0..s.. 162361292us : timer_expire_entry: timer=95703ccd function=process_timeout now=4294829657 baseclk=4294670587
>
> which got fired here.
>
> 	[  221.663967]   <idle>-0         0dns.. 162361296us : timer_cancel: timer=d03eaa1d
> 	[  221.671388]   <idle>-0         0.ns.. 162361297us : timer_expire_entry: timer=d03eaa1d function=process_timeout now=4294829657 baseclk=4294670856
>
> And looks to me CPU 0 is the tick_do_timer_cpu CPU, since it's the first
> one that got timers after a long wait and was doing a few catch-ups. Now
> the problem is why CPU 0 didn't program its hardware timer to expire at
> 4294670587? I.e. the earliest timer.

That's not the problem. It's not clear whether CPU0 was the last one
going idle. It doesn't look so:

> 	[  221.623331]   <idle>-0         1d.s.. 3287404us : timer_cancel: timer=7e541f87
> 	[  221.630578]   <idle>-0         1..s.. 3287405us : timer_expire_entry: timer=7e541f87 function=process_timeout now=4294670584 baseclk=4294670584

The timer in question is supposed to wake up 2 ticks later, so CPU1
should have armed it. But without the migration trace points enabled
this is all guess work.

Thanks,

        tglx

