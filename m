Return-Path: <linux-kernel+bounces-57877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF30884DE82
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB182285287
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEE56A335;
	Thu,  8 Feb 2024 10:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvWQ4xVs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48821DFF2;
	Thu,  8 Feb 2024 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388994; cv=none; b=cHKo9pE/RfHHX8cUULhrGSOk2eugeqBDlS7ldtSrPcSrRSewrV3pxLXD8ycZpfM/+tZqfVCR5+vdIa8V7vHJhVQXtENH4lSmNjryqNIqNO+Yq4h703Ey85LatBRcjFjFIsnYUU4Y4pzyqScDrqiONWDENIPGgSFK76W/sIAVf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388994; c=relaxed/simple;
	bh=iOCEBde5YbT1K2IfyXz3DE1Ta6qmjsnHDk4nzvRYcvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tkd2ENWHFv8SK7iALgexbmR12cDcdyuPZOzPu+HEwWRwGbkD3U1UKHOzNBZbNrb/6wus69gAjmOxdXZev6dQXmCvIhJNfJWlQGG0qanZ/sBuYWvJcXXYlxm2VIwERB+KAynEp8iW4XxKx7Z4sQO0BTCnjF4o80IxuURTh11nLBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvWQ4xVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4696C433C7;
	Thu,  8 Feb 2024 10:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707388993;
	bh=iOCEBde5YbT1K2IfyXz3DE1Ta6qmjsnHDk4nzvRYcvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GvWQ4xVs30uQsyDRhy2StCPlc2GlE2b9LvsVXJuAqA8gD6xKbB/oZUQ8qhwMpsVUo
	 Jlt9yShDwNJV0jhJ9i8tQmxFf3mmVOiVwukNgruEJicqQvXsI4+wr0Ob6bG6mpdtbD
	 C0r/EzPqneVD4JLYc3Fd1u/Tfh3pRuQEt4Py+eh0tWi7MkD8ZStqYoRQ4DeNNYwytE
	 T3pjpUxzsVoNGAQG/uE1htxE3OPnrUzMy6jbNJIEv/vrVsBZ847teXZRtbuonjupae
	 KPZzCECiOJuyWIq7w6xYQko9u6lntV7OYWCSVvUM5mzmhUj7c0ghexxGEBfsQT3krR
	 QYw83XHNUCm4w==
Date: Thu, 8 Feb 2024 11:43:10 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH 2/2] rcu-tasks: Eliminate deadlocks involving do_exit()
 and RCU tasks
Message-ID: <ZcSwPifss+ho3hRt@lothringen>
References: <20240129225730.3168681-1-boqun.feng@gmail.com>
 <20240129225730.3168681-3-boqun.feng@gmail.com>
 <ZcQJ2Vec1_b5ooS_@pavilion.home>
 <ZcQzyhcaRUSRo8a9@pavilion.home>
 <ZcQ4GMEbLFtkCZXw@pavilion.home>
 <cc25e968-6f43-453e-be9e-2851db39218f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc25e968-6f43-453e-be9e-2851db39218f@paulmck-laptop>

On Thu, Feb 08, 2024 at 01:56:10AM -0800, Paul E. McKenney wrote:
> On Thu, Feb 08, 2024 at 03:10:32AM +0100, Frederic Weisbecker wrote:
> This ordering is not needed.  The lock orders addition to this
> list against removal from tasklist.  If we hold this lock, either
> the task is already on this list or our holding this lock prevents
> it from removing itself from the tasklist.
> 
> We have already scanned the task list, and we have already done
> whatever update we are worried about.
> 
> So, if the task was on the tasklist when we scanned, well and
> good.  If the task was created after we scanned the tasklist,
> then it cannot possibly access whatever we removed.
> 
> But please double-check!!!

Heh, right, another new pattern for me to discover :-/

C r-LOCK

{
}

P0(spinlock_t *LOCK, int *X, int *Y)
{
	int r1;
	int r2;
	
	r1 = READ_ONCE(*X);

	spin_lock(LOCK);
	r2 = READ_ONCE(*Y);
	spin_unlock(LOCK);
}

P1(spinlock_t *LOCK, int *X, int *Y)
{
	spin_lock(LOCK);
	WRITE_ONCE(*Y, 1);
	spin_unlock(LOCK);
	WRITE_ONCE(*X, 1);
}

exists (0:r1=1 /\ 0:r2=0) (* never *)


> 
> > > synchronize_rcu_tasks()                       do_exit()
> > > ----------------------                        ---------
> > > //for_each_process_thread()
> > > READ tasklist                                 WRITE rtpcp->rtp_exit_list
> > > LOCK rtpcp->lock                              UNLOCK rtpcp->lock
> > > smp_mb__after_unlock_lock()                   WRITE tasklist //unhash_process()
> > > READ rtpcp->rtp_exit_list
> > > 
> > > Does this work? Hmm, I'll play with litmus once I have a fresh brain...
> 
> First, thank you very much for the review!!!
> 
> > ie: does smp_mb__after_unlock_lock() order only what precedes the UNLOCK with
> > the UNLOCK itself? (but then the UNLOCK itself can be reordered with anything
> > that follows)? Or does it also order what follows the UNLOCK with the UNLOCK
> > itself? If both, then it looks ok, otherwise...
> 
> If you have this:
> 
> 	earlier_accesses();
> 	spin_lock(...);
> 	ill_considered_memory_accesses();
> 	smp_mb__after_unlock_lock();
> 	later_accesses();
> 
> Then earlier_accesses() will be ordered against later_accesses(), but
> ill_considered_memory_accesses() won't necessarily be ordered.  Also,
> any accesses before any prior release of that same lock will be ordered
> against later_accesses().
> 
> (In real life, ill_considered_memory_accesses() will be fully ordered
> against either spin_lock() on the one hand or smp_mb__after_unlock_lock()
> on the other, with x86 doing the first and PowerPC doing the second.
> So please try to avoid any ill_considered_memory_accesses().)

Thanks a lot for that explanation!


> 
> > Also on the other end, does LOCK/smp_mb__after_unlock_lock() order against what
> > precedes the LOCK? That also is necessary for the above to work.
> 
> It looks like an smp_mb__after_spinlock() would also be needed, for
> example, on ARMv8.
> 
> > Of course by the time I'm writing this email, litmus would have told me
> > already...
> 
> ;-) ;-) ;-)
> 
> But I believe that simple locking covers this case.  Famous last words...

Indeed, looks right!

Thanks!
> 							Thanx, Paul

