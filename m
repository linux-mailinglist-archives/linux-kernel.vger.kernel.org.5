Return-Path: <linux-kernel+bounces-30216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D97831BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D161C20DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB991DDCC;
	Thu, 18 Jan 2024 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UC4J9KD5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CE3A53;
	Thu, 18 Jan 2024 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588866; cv=none; b=Tse9Jmuc3Se9G0KdHoQoPiygiCu6Qetx854mECegmIjl2RVFzUnvs007hJH6aZP/NeTKk51vCeXG6l8r0IwsjMKFNTyVBbkcP7vp1Sn9EaN8zv3MzQyKByO+15wzdPhAb/eeKVztTwugVBL651sBmNW4+JAGYzF/UAt1CPbbxXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588866; c=relaxed/simple;
	bh=jbr6rdJ/qeiYoL30WlSwpGj5SzBJllrSxz7PDcWI+jY=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Iu4X6JgJi0zz57ZDhDUd4nmKDWVhVmapkEmoWvPCG4NakKm2nl89tLpJjxYIWVhdfu2500wA7UxGqX4lAEs9AP6mSDTtqC/n3s0aV3EZfF4DURRtuUbGRjX6rx60GPyR1OhY35F3eKrxYhNDS0WGM5Mr/MmieLqVvJKdNBVKnQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UC4J9KD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4E4C433F1;
	Thu, 18 Jan 2024 14:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705588865;
	bh=jbr6rdJ/qeiYoL30WlSwpGj5SzBJllrSxz7PDcWI+jY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=UC4J9KD5DkWzus10ieCSPso1KKv+GxZN/efrkkYGlvJNq/8JzrklGZZzUcPtoBb63
	 nRapeeZ4STrBg/h272xm9P0M/cjCjO/a3PJukYYbM0pg12EIHLoWCdGBdlL7hrnTz6
	 Q0xQFpSNsaIyesZZax+USYwBtamZ7n8nt4Lc+KD7mGl2n9vzgQLBSZdivVJEoDINek
	 /ehG0nL5Z3nlJphQVJaxyRrt3m7B9Xr7rqZpVT9yiEjEp8Shq7F7UzYC5/uhNGqS0V
	 txOjVqMWDqHHtVyrPN5axaMQ2A8HHJjsxEhPI3vtmHEmQDJ4u9YFfKKh+K1oPTt9Db
	 4H95w7BbPSRPA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CB27ECE0546; Thu, 18 Jan 2024 06:41:04 -0800 (PST)
Date: Thu, 18 Jan 2024 06:41:04 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chen Zhongjin <chenzhongjin@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, yangjihong1@huawei.com,
	naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
	davem@davemloft.net, mhiramat@kernel.org, tglx@linutronix.de,
	peterz@infradead.org, pmladek@suse.com, dianders@chromium.org,
	npiggin@gmail.com, mpe@ellerman.id.au, jkl820.git@gmail.com,
	juerg.haefliger@canonical.com, rick.p.edgecombe@intel.com,
	eric.devolder@oracle.com, mic@digikod.net
Subject: Re: [PATCH] kprobes: Use synchronize_rcu_tasks_rude in
 kprobe_optimizer
Message-ID: <526b12e4-4bb0-47b1-bece-66b47bfc0a92@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240117061636.288412-1-chenzhongjin@huawei.com>
 <20240117123133.2e40438936167e6a4aec8b16@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117123133.2e40438936167e6a4aec8b16@linux-foundation.org>

On Wed, Jan 17, 2024 at 12:31:33PM -0800, Andrew Morton wrote:
> On Wed, 17 Jan 2024 06:16:36 +0000 Chen Zhongjin <chenzhongjin@huawei.com> wrote:
> 
> > There is a deadlock scenario in kprobe_optimizer():
> > 
> > pid A				pid B			pid C
> > kprobe_optimizer()		do_exit()		perf_kprobe_init()
> > mutex_lock(&kprobe_mutex)	exit_tasks_rcu_start()	mutex_lock(&kprobe_mutex)
> > synchronize_rcu_tasks()		zap_pid_ns_processes()	// waiting kprobe_mutex
> > // waiting tasks_rcu_exit_srcu	kernel_wait4()
> > 				// waiting pid C exit
> > 
> > To avoid this deadlock loop, use synchronize_rcu_tasks_rude() in kprobe_optimizer()
> > rather than synchronize_rcu_tasks(). synchronize_rcu_tasks_rude() can also promise
> > that all preempted tasks have scheduled, but it will not wait tasks_rcu_exit_srcu.

Hello, Chen Zhongjin,

Relying on the non-preemptability of the last portion of the do_exit()
function does appear to be the basis for a much better solution than
what we currently have.  So at the very least, thank you for the idea!!!
I feel a bit silly for not having thought of it myself.  ;-)

However, just invoking synchronize_rcu_tasks_rude() will be bad for both
energy efficiency and real-time response.  This is due to the fact that
synchronize_rcu_tasks_rude() sends an IPI to each and every online CPUs,
almost none of which will be in the non-preemptible tail of do_exit()
at any given time.  These additional unnecessary IPIs will drain battery
when they hit idle CPUs and degrade real-time response when they hit
CPUs running aggressive real-time applications.  Which might not make
people happy.

So, would you be willing to use RCU's do_exit() hooks and RCU's hook
into the scheduler (either rcu_note_context_switch() or rcu_tasks_qs(),
whichever would work better) maintain a per-CPU variable that is a
pointer to the task in the non-preemptible tail of do_exit() if there
is one or NULL otherwise?  This would get us the deadlock-avoidance
simplicity of your underlying idea, while avoiding (almost all of)
the energy-efficiency and real-time-response issues with your patch.

This does require a bit of memory-ordering care, so if you would prefer
that I do the implementation, just let me know.

(The memory-ordering trick is to use "smp_mb(); smp_load_acquire();" to
sample the counter and "smp_store_release(); smp_mb();" to update it.)

							Thanx, Paul

> > Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> 
> Thanks.  Should we backport this fix into earlier kernels?  If so, are
> we able to identify a suitable Fixes: target?

