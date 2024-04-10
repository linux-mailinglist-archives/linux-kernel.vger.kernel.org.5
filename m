Return-Path: <linux-kernel+bounces-137933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCF389E9C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0E81C214A7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEC217552;
	Wed, 10 Apr 2024 05:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yc3ueid+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD5C134DE;
	Wed, 10 Apr 2024 05:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712727028; cv=none; b=h8QapnyBJvzsPWRJLIDDxbXqQVq/jKu5hbzi2+08RA3hvVWy7anZgUVPl/SdmDyVGO+IpXqsYNSvLHzrD1FX+zvQChIj3HL+JCwh0FoPlvv3m9b8MybMxwUH8pAKlu0BonWqLUcPnWGpT7UAK2DVOC6REGSXhAv2mdxdFcBgqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712727028; c=relaxed/simple;
	bh=wt+c2JdAu2t/Oj9T3uqp+BpP80JAAfO6pS/ZlaP+kXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQa+N3qvJyRKn+nkrfbFpBrxvh8jWenL6P3pP02ILq1FjxPjnO4BO+U9fZ3CtSE4VBCT1hftyB0rFA9/naFZrbQt75zPwjIHWzNwNLI1+qXz+8nypHJ0SlR5Z93+kDCm1Xu5TwxO6KkW57953HTg++ySukchePaJMJUcdZHHCNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yc3ueid+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A17C433C7;
	Wed, 10 Apr 2024 05:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712727026;
	bh=wt+c2JdAu2t/Oj9T3uqp+BpP80JAAfO6pS/ZlaP+kXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yc3ueid+PbS6C9LNIsjvJX8owD7kPJQOHdZ1XOy8vINDYW0ATy8q7mLun+CqJERzW
	 3hYhY5gc0hIwo1xkFV7BM9k6GXqLNBlQtTe1DEH91jleQvSKPkiiB4L7ANMec8/JCk
	 g6B8SDAXl9MSvvIuWUaehdBE0jGYJ0zS1rKzXmf4=
Date: Wed, 10 Apr 2024 07:30:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: liu.yec@h3c.com
Cc: andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
	dianders@chromium.org, jason.wessel@windriver.com,
	jirislaby@kernel.org, kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH V10] kdb: Fix the deadlock issue in KDB debugging.
Message-ID: <2024041014-padlock-aggregate-4705@gregkh>
References: <20240409020326.2125332-1-liu.yec@h3c.com>
 <20240410020615.2885000-1-liu.yec@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410020615.2885000-1-liu.yec@h3c.com>

On Wed, Apr 10, 2024 at 10:06:15AM +0800, liu.yec@h3c.com wrote:
> From: LiuYe <liu.yeC@h3c.com>
> 
> Currently, if CONFIG_KDB_KEYBOARD is enabled, then kgdboc will
> attempt to use schedule_work() to provoke a keyboard reset when
> transitioning out of the debugger and back to normal operation.
> This can cause deadlock because schedule_work() is not NMI-safe.
> 
> The stack trace below shows an example of the problem. In this
> case the master cpu is not running from NMI but it has parked
> the slave CPUs using an NMI and the parked CPUs is holding
> spinlocks needed by schedule_work().
> 
> Example:
> BUG: spinlock lockup suspected on CPU#0. owner_cpu: 1
> CPU1: Call Trace:
> __schedule
> schedule
> schedule_hrtimeout_range_clock
> mutex_unlock
> ep_scan_ready_list
> schedule_hrtimeout_range
> ep_poll
> wake_up_q
> SyS_epoll_wait
> entry_SYSCALL_64_fastpath
> 
> CPU0: Call Trace:
> dump_stack
> spin_dump
> do_raw_spin_lock
> _raw_spin_lock
> try_to_wake_up
> wake_up_process
> insert_work
> __queue_work
> queue_work_on
> kgdboc_post_exp_handler
> kgdb_cpu_enter
> kgdb_handle_exception
> __kgdb_notify
> kgdb_notify
> notifier_call_chain
> notify_die
> do_int3
> int3
> 
> We fix the problem by using irq_work to call schedule_work()
> instead of calling it directly. This is because we cannot
> resynchronize the keyboard state from the hardirq context
> provided by irq_work. This must be done from the task context
> in order to call the input subsystem.
> 
> Therefore, we have to defer the work twice. First, safely
> switch from the debug trap context (similar to NMI) to the
> hardirq, and then switch from the hardirq to the system work queue.
> 
> Signed-off-by: LiuYe <liu.yeC@h3c.com>
> Co-developed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Signed-off-by: Greg KH <gregkh@linuxfoundation.org>

I have NOT signed off on this commit.  You just said that I made a legal
statement about this commit without that actually being true???

Sorry, but that is flat out not acceptable at all.  Please go work with
your company lawyers to figure out what you did and come back with an
explaination of exactly what this is and how it will not happen again.

greg k-h

