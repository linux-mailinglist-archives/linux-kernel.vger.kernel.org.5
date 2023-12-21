Return-Path: <linux-kernel+bounces-7712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C23E381ABE6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FBE284BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C65415B7;
	Thu, 21 Dec 2023 00:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddbNw5qm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F2110EB;
	Thu, 21 Dec 2023 00:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606A7C433C7;
	Thu, 21 Dec 2023 00:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703120232;
	bh=ywWOLVkIVc6XdDV+LveLMln1b3lK8GaP445VxOveI7I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ddbNw5qm86vGbt9lbsaxFFTR6bomwV0UJwYFrl2WL2pY7uJrkt52ZfQWF8Wls6zd0
	 XjNuwIWdeSBCjbeYtaCgVxJtTAmktTcA86YjXlO9vThklnxrgXrOS8VxwYWvPBWzXm
	 qYkijfG9Pp7X2HYc8cHmxaf+efHt32iiiojMwVPQOtm+dsJBe6mh3mnL5T9U+UM4WF
	 HV5oRPQMgJBeY8Z1ckmRlWchow68fS+TQCDGC9pDUbUjOz60v0jmjiM2Jc9cFKizkx
	 SKrdxMTYSzdRha5vf8DRHLjdal/wLgTPE1gdGlKLRRhb/tx7B3BBJCQG0JfTL2CIBZ
	 D6baohUg7asQA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E861FCE0ECF; Wed, 20 Dec 2023 16:57:11 -0800 (PST)
Date: Wed, 20 Dec 2023 16:57:11 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
Message-ID: <6b613378-e21a-426a-9989-46c3fb9c45a7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231218231916.11719-1-frederic@kernel.org>
 <20231218231916.11719-3-frederic@kernel.org>
 <65811051.d40a0220.75c79.66cf@mx.google.com>
 <ZYGFAtLNQsLUWGPr@lothringen>
 <65825924.050a0220.222f1.dc9d@mx.google.com>
 <ZYMNUdbFIWaK6T1d@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZYMNUdbFIWaK6T1d@localhost.localdomain>

On Wed, Dec 20, 2023 at 04:50:41PM +0100, Frederic Weisbecker wrote:
> Le Tue, Dec 19, 2023 at 10:01:55PM -0500, Joel Fernandes a écrit :
> > > (Though right now I'm missing the flush_smp_call_function_queue() call that flushes
> > > the ttwu queue between sched_cpu_deactivate() and sched_cpu_wait_empty())
> > 
> > Possible. I saw your IRC message to Peter on that as well, thanks for
> > following up. I need to find some time to look more into that, but that does
> > sound concerning.
> 
> Found it! It's smpcfd_dying_cpu().
> 
> > > But note this patch does something different, it doesn't defer the runqueue
> > > enqueue like ttwu queue does. It defers the whole actual wakeup. This means that the
> > > decision as to where to queue the task is delegated to an online CPU. So it's
> > > not the same constraints. Waking up a task _from_ a CPU that is active or not but
> > > at least online is supposed to be fine.
> > 
> > Agreed, thanks for the clarifications. But along similar lines (and at the
> > risk of oversimplifying), is it not possible to send an IPI to an online CPU
> > to queue the hrtimer locally there if you detect that the current CPU is
> > going down? In the other thread to Hilf, you mentioned the hrtimer infra has
> > to have equal or earlier deadline, but you can just queue the hrtimer from
> > the IPI handler and that should take care of it?
> 
> This is something that Thomas wanted to avoid IIRC, because the IPI can make
> it miss the deadline. But I guess in the case of an offline CPU, it can be a
> last resort.
> 
> > Let me know if I missed something which should make for some good holiday
> > reading material. ;-)
> 
> Let me summarize the possible fixes we can have:
> 
> 1) It's RCU's fault! We must check and fix all the wake ups performed by RCU
>    from rcutree_report_cpu_dead(). But beware other possible wake-ups/timer
>    enqueue from the outgoing CPU after hrtimers are migrated.
> 
> 2) It's scheduler's fault! do_start_rt_bandwidth() should check if the current
>    CPU is offline and place manually the timer to an online CPU (through an
>    IPI? yuck)
> 
> 3) It's hrtimer's fault! If the current CPU is offline, it must arrange for
>    queueing to an online CPU. Not easy to do as we must find one whose next
>    expiry is below/equal the scheduler timer. As a last resort, this could be
>    force queued to any and then signalled through an IPI, even though it's
>    something we've tried to avoid until now.
> 
>    Also It's hard for me to think about another way to fix the deadlock fixed
>    by 5c0930ccaad5a74d74e8b18b648c5eb21ed2fe94. Hrtimers migration can't happen
>    after rcutree_report_cpu_dead(), because it may use RCU...
> 
> None of the above look pretty anyway. Thoughts?

Make one of the surviving CPUs grab any leftover timers from the outgoing
CPU, possibly checking periodically.  Not pretty either, but three ugly
options deserve a fourth one!

							Thanx, Paul

