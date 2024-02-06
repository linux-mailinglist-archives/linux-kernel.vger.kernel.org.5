Return-Path: <linux-kernel+bounces-54715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B83884B2CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472C428AC09
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC8012E1E3;
	Tue,  6 Feb 2024 10:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lW/aOBM0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453884EB46;
	Tue,  6 Feb 2024 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216795; cv=none; b=fZgeKjvtt2e0InrzYiytmqniuZyBDrKTDhnT8aV8X7tsuynCKv+I4chAoSa6U9/fx8XkS6FhZ7zULJhyDkvw6gI2TRo6F+r+ioNtMn6SiedNhJHZXN92zHTGW28dVd2EINidaSXIaVUCxHlPgajuliL85Z0gjbGRzeHINs2NmN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216795; c=relaxed/simple;
	bh=Jw80we5CtO+VxkV79VnROzych80YG1K0NYBVQWdtJA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJkM5cmF/kGU1hTTpjEgtdC3YoE+tZp8NKFz6FlpfTZpFKEDPzgwI9q4SqZnqaWtEqI0KpvCAQ1nWgXO0w0xadLgAiRVcJXT/rT29GTnBoIRyFNEjNr2rsn9Jj9qOozN/PgYPN3GMwhhhmQH39oVtvCILC087x1l3SKhSM7dKQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lW/aOBM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEA7C433C7;
	Tue,  6 Feb 2024 10:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707216794;
	bh=Jw80we5CtO+VxkV79VnROzych80YG1K0NYBVQWdtJA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lW/aOBM0QgorItLizvpr6oa7h1xAzOqlQ8RWA7zstrEHbIpXBp6Uc7hR//w7wsjAl
	 ms1z9tgbwKajIEb8DO6bLaMsZJ1mwAElb5wImFKe23J9ARXIA9d/lMzUyg4t7Ixw5z
	 Ls2dqfbVNo+EtPhXWlnETEO0z/zHuyqD2vYEjy8w=
Date: Tue, 6 Feb 2024 10:53:10 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhiguo Niu <niuzhiguo84@gmail.com>
Cc: Carlos Llamas <cmllamas@google.com>, Zhiguo Niu <zhiguo.niu@unisoc.com>,
	bvanassche@acm.org, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
	hongyu.jin@unisoc.com, stable@vger.kernel.org
Subject: Re: [PATCH V3] lockdep: fix deadlock issue between lockdep and rcu
Message-ID: <2024020613-abrasive-splashed-6fe3@gregkh>
References: <1706861676-26574-1-git-send-email-zhiguo.niu@unisoc.com>
 <Zb1IxNd54z2Ib1N3@google.com>
 <2024020233-wildland-blouse-2f2e@gregkh>
 <CAHJ8P3L8A4uUwDuD5WQkDGdsOB6jWBdPFzR98mCiAh-0LtM91A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHJ8P3L8A4uUwDuD5WQkDGdsOB6jWBdPFzR98mCiAh-0LtM91A@mail.gmail.com>

On Tue, Feb 06, 2024 at 06:37:05PM +0800, Zhiguo Niu wrote:
> hi Greg,
> 
> On Sat, Feb 3, 2024 at 5:36 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Feb 02, 2024 at 07:55:48PM +0000, Carlos Llamas wrote:
> > > On Fri, Feb 02, 2024 at 04:14:36PM +0800, Zhiguo Niu wrote:
> > > > There is a deadlock scenario between lockdep and rcu when
> > > > rcu nocb feature is enabled, just as following call stack:
> > > >
> > > >      rcuop/x
> > > > -000|queued_spin_lock_slowpath(lock = 0xFFFFFF817F2A8A80, val = ?)
> > > > -001|queued_spin_lock(inline) // try to hold nocb_gp_lock
> > > > -001|do_raw_spin_lock(lock = 0xFFFFFF817F2A8A80)
> > > > -002|__raw_spin_lock_irqsave(inline)
> > > > -002|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F2A8A80)
> > > > -003|wake_nocb_gp_defer(inline)
> > > > -003|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F30B680)
> > > > -004|__call_rcu_common(inline)
> > > > -004|call_rcu(head = 0xFFFFFFC082EECC28, func = ?)
> > > > -005|call_rcu_zapped(inline)
> > > > -005|free_zapped_rcu(ch = ?)// hold graph lock
> > > > -006|rcu_do_batch(rdp = 0xFFFFFF817F245680)
> > > > -007|nocb_cb_wait(inline)
> > > > -007|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F245680)
> > > > -008|kthread(_create = 0xFFFFFF80803122C0)
> > > > -009|ret_from_fork(asm)
> > > >
> > > >      rcuop/y
> > > > -000|queued_spin_lock_slowpath(lock = 0xFFFFFFC08291BBC8, val = 0)
> > > > -001|queued_spin_lock()
> > > > -001|lockdep_lock()
> > > > -001|graph_lock() // try to hold graph lock
> > > > -002|lookup_chain_cache_add()
> > > > -002|validate_chain()
> > > > -003|lock_acquire
> > > > -004|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F211D80)
> > > > -005|lock_timer_base(inline)
> > > > -006|mod_timer(inline)
> > > > -006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
> > > > -006|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F2A8680)
> > > > -007|__call_rcu_common(inline)
> > > > -007|call_rcu(head = 0xFFFFFFC0822E0B58, func = ?)
> > > > -008|call_rcu_hurry(inline)
> > > > -008|rcu_sync_call(inline)
> > > > -008|rcu_sync_func(rhp = 0xFFFFFFC0822E0B58)
> > > > -009|rcu_do_batch(rdp = 0xFFFFFF817F266680)
> > > > -010|nocb_cb_wait(inline)
> > > > -010|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F266680)
> > > > -011|kthread(_create = 0xFFFFFF8080363740)
> > > > -012|ret_from_fork(asm)
> > > >
> > > > rcuop/x and rcuop/y are rcu nocb threads with the same nocb gp thread.
> > > > This patch release the graph lock before lockdep call_rcu.
> > > >
> > > > Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
> > > > Cc: <stable@vger.kernel.org>

Oops, I missed this line ^^^

> > > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > > Cc: Waiman Long <longman@redhat.com>
> > > > Cc: Carlos Llamas <cmllamas@google.com>
> > > > Cc: Bart Van Assche <bvanassche@acm.org>
> > > > Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> > > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > > ---
> > > > changes of v3: correct code comments and add Cc tag.
> > > > changes of v2: update patch according to Boqun's suggestions.
> > > > ---
> > >
> > > It seems v3 should have collected the review tags from Boqun and Waiman.
> > > Also, I'm actually Cc'ing stable here. I hope that is enough.
> > > FWIW, this looks fine to me.
> > >
> > > Reviewed-by: Carlos Llamas <cmllamas@google.com>
> >
> >
> > <formletter>
> >
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> >
> > </formletter>
> 
> I see that many commits in mainline use Cc: <stable@vger.kernel.org>
> directly without other information,
> and I also find this information from above link: "Note, such tagging
> is unnecessary if the stable team can
> derive the appropriate versions from Fixes: tags."
> 
> In addition, this fixed commit "a0b0fd53e1e6 ("locking/lockdep: Free
> lock classes that are no longer in use")"
> was committed in 2019, so I am not very sure which start version
> should be added to stabe tag.
> Do you have any good suggestions?

Nope, you did this right, I missed it in the body of the changelog as
listed above, my apologies for the incorrect response here.

greg k-h

