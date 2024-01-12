Return-Path: <linux-kernel+bounces-24802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8235182C2C1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A681F22CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242773161;
	Fri, 12 Jan 2024 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3y1nE+Km";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WZEb6gDp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926C6EB73
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705073535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iM3HwRhzvPrfiWg1aI0QfH1zhPKXDcv1jxncJ33B+Ec=;
	b=3y1nE+Km5QRt+ZoZTcfYmD+hl/rmV8xjMpQUy0ZK0C2q3101XmFXZv7Ok11jP7t4wyhCIZ
	o+jYWioP2zrhJyay5mNOyLdK6MBPTO0owy+2t+aAPCxm3LmAnMsj25xJqiBL9aDBbv1sq2
	dH5JGu0f1ZE7cTfwe3NiUDOly685100LNi5qnq5Ym8ahVMVLcZ75Q/Ic8uzDiaWc/8sC6w
	ZXiX0GXez6lqJ80Wtng2SBtlxH9WB2Wl/+oCYJU+looSZnRtZRPK4KlsYJA5KMGuwKiGHU
	vx9mV+++LfqWJeLfmXIt9hLVjprSIIg7zVILj9DIfkjroR1SPHSlvH73v1U0ZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705073535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iM3HwRhzvPrfiWg1aI0QfH1zhPKXDcv1jxncJ33B+Ec=;
	b=WZEb6gDpCXhVvte4mljy4AJ+h/0L2s5NC7Fa3ezS5cK8R0cJdf4TAizYyQSsL84YovC+HO
	PQLbWg+Z3tvkpqDg==
To: kernel test robot <lkp@intel.com>, Thadeu Lima de Souza Cascardo
 <cascardo@canonical.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, "Paul E.
 McKenney" <paulmck@kernel.org>, Christian Brauner <brauner@kernel.org>
Subject: Re: fs/exec.c:1307:26: sparse: sparse: incorrect type in argument 1
 (different address spaces)
In-Reply-To: <202401111036.STMizmwE-lkp@intel.com>
References: <202401111036.STMizmwE-lkp@intel.com>
Date: Fri, 12 Jan 2024 16:32:14 +0100
Message-ID: <87jzoein41.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 11 2024 at 10:44, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   acc657692aed438e9931438f8c923b2b107aebf9
> commit: e362359ace6f87c201531872486ff295df306d13 posix-cpu-timers: Cleanup CPU timers before freeing them during exec
> date:   1 year, 5 months ago

I'm amused that it took 17 month ....

>>> fs/exec.c:1307:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
>   1305	
>   1306	#ifdef CONFIG_POSIX_TIMERS
>> 1307		spin_lock_irq(&me->sighand->siglock);
>   1308		posix_cpu_timers_exit(me);
>   1309		spin_unlock_irq(&me->sighand->siglock);
>   1310		exit_itimers(me);
>   1311		flush_itimer_signals();
>   1312	#endif

So this warning is clearly wrong because 'current->sighand->siglock' is
safe to dereference w/o RCU protection for 'current'.

The real issue is this commit:

   913292c97d75 ("sched.h: Annotate sighand_struct with __rcu")

which blindly 'fixed' a sparse warning in signal.c w/o even trying to
look at the consequences. There are 170+ instances of spin_[un]lock()
variants which should emit exactly the same warning...

I think the right fix is to annotate this legit case of derefencing
current->sighand->siglock so sparse knows that this is safe.

Thanks,

        tglx



