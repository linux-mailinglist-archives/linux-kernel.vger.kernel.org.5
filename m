Return-Path: <linux-kernel+bounces-7198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC2681A315
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D0D1F21B22
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C3C41C97;
	Wed, 20 Dec 2023 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlO3L2ot"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5115741849;
	Wed, 20 Dec 2023 15:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709AAC433C7;
	Wed, 20 Dec 2023 15:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087444;
	bh=NBm+kC3WVKV2WWHdLcI/39MAil1fVNerDYbW6WWRtKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlO3L2otVNy7zl0LVfCZ6miZLjB/Z0Ve7IjUNonzMu+tyNNLoB0HvzP5qU703RlkZ
	 kJmI0K1yqafImZ7TaMqtDH214Hyd9ML5JZgc+OsEItxrLhdAjWyD6s3uRjVU3drske
	 lCttyUYlO609iLedKj1UElzM7iegbIsbsUjzC9Sby+qenszYV2BjYdGk1O5JtQn+Jx
	 5a+1DmcodvL8D7u3tJFNyVsGU8UO/VJLGKwtEC9AbzcTvxtje3uansP6RRdIL2oJux
	 ZUsqOV3xSB8ch6bPsWy6PdbQiYmWAW888swZrFIlqEEXn51GaUuytV8hLa6wuLfb13
	 NP8hL9ajYvSDA==
Date: Wed, 20 Dec 2023 16:50:41 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
Message-ID: <ZYMNUdbFIWaK6T1d@localhost.localdomain>
References: <20231218231916.11719-1-frederic@kernel.org>
 <20231218231916.11719-3-frederic@kernel.org>
 <65811051.d40a0220.75c79.66cf@mx.google.com>
 <ZYGFAtLNQsLUWGPr@lothringen>
 <65825924.050a0220.222f1.dc9d@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65825924.050a0220.222f1.dc9d@mx.google.com>

Le Tue, Dec 19, 2023 at 10:01:55PM -0500, Joel Fernandes a écrit :
> > (Though right now I'm missing the flush_smp_call_function_queue() call that flushes
> > the ttwu queue between sched_cpu_deactivate() and sched_cpu_wait_empty())
> 
> Possible. I saw your IRC message to Peter on that as well, thanks for
> following up. I need to find some time to look more into that, but that does
> sound concerning.

Found it! It's smpcfd_dying_cpu().

> > But note this patch does something different, it doesn't defer the runqueue
> > enqueue like ttwu queue does. It defers the whole actual wakeup. This means that the
> > decision as to where to queue the task is delegated to an online CPU. So it's
> > not the same constraints. Waking up a task _from_ a CPU that is active or not but
> > at least online is supposed to be fine.
> 
> Agreed, thanks for the clarifications. But along similar lines (and at the
> risk of oversimplifying), is it not possible to send an IPI to an online CPU
> to queue the hrtimer locally there if you detect that the current CPU is
> going down? In the other thread to Hilf, you mentioned the hrtimer infra has
> to have equal or earlier deadline, but you can just queue the hrtimer from
> the IPI handler and that should take care of it?

This is something that Thomas wanted to avoid IIRC, because the IPI can make
it miss the deadline. But I guess in the case of an offline CPU, it can be a
last resort.

> Let me know if I missed something which should make for some good holiday
> reading material. ;-)

Let me summarize the possible fixes we can have:

1) It's RCU's fault! We must check and fix all the wake ups performed by RCU
   from rcutree_report_cpu_dead(). But beware other possible wake-ups/timer
   enqueue from the outgoing CPU after hrtimers are migrated.

2) It's scheduler's fault! do_start_rt_bandwidth() should check if the current
   CPU is offline and place manually the timer to an online CPU (through an
   IPI? yuck)

3) It's hrtimer's fault! If the current CPU is offline, it must arrange for
   queueing to an online CPU. Not easy to do as we must find one whose next
   expiry is below/equal the scheduler timer. As a last resort, this could be
   force queued to any and then signalled through an IPI, even though it's
   something we've tried to avoid until now.

   Also It's hard for me to think about another way to fix the deadlock fixed
   by 5c0930ccaad5a74d74e8b18b648c5eb21ed2fe94. Hrtimers migration can't happen
   after rcutree_report_cpu_dead(), because it may use RCU...

None of the above look pretty anyway. Thoughts?

