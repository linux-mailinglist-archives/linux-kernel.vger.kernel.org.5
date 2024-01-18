Return-Path: <linux-kernel+bounces-30231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30937831BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD44A282606
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630651DFF6;
	Thu, 18 Jan 2024 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0n0h9Rp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65FD64A;
	Thu, 18 Jan 2024 14:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589645; cv=none; b=FGSlYpQLj9zdRrFbXVAH5DHdaUgDphg0J6lvuSXIVs++nCdZgBB8+/3qCdKgeOR26/c5DPWZNoTZyY2TMe3+HeXL8+ciouT2isL5Gni/MzGnoVDnuq7vbciQ5NfqYwk0lHTquMsGs5hgDtAgIzikp1bTPQ3ER0LpeHv0BD7HTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589645; c=relaxed/simple;
	bh=1Jn0XHYRRXVuTax8LF9dSlbDnIyPC5KmcJWbAbWx/lM=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To; b=H/2hQGWfSqChPwgvDItGjXEAI5fUL3bJfhvyFMOwSrXLDyMVZScnMSnXeKEgD4dXNr+YubDLCxE6CQJ0GcVCwtT+9HuckWLJiRRVAwuj9GtaYlVp4qZvKTJeJy+HLtE+LpbWs2bTTtISKppXXlTBD+2yzC1JzXHyW5wNUvFqaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0n0h9Rp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161C3C433C7;
	Thu, 18 Jan 2024 14:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705589645;
	bh=1Jn0XHYRRXVuTax8LF9dSlbDnIyPC5KmcJWbAbWx/lM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Q0n0h9Rpr/p9IKT4pj93/ExJ1XtuDhOEazP63FMN5MJvLMP81iWxHO2vzsguzkqgN
	 YjwyFKlwuADYHXYXOSFcwD61AhSBJT/EI+/59E7b+eYdhE4M1+CBALaFfPjMJ4mnMI
	 jQcBHtPm0JaLi2Qf3Ehto79qJabYFvmAyVfPXJdlF5FO5Z3CpYldP+Yq9PMsP+nC49
	 /VrZFKeRY4KJn7q+Uqg6Q+OVAQEkAEJZtn+GPrvJ4jWWSk/YxKHLWQVaK/YhVaWp52
	 YQP/caufxaaL4pzdpkEr4On6XNGW3VrTL1Ut6cONnFGrH6FpYClvjsXiXs8F0FXbmS
	 QkaFNQs9AOlYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 97D09CE0546; Thu, 18 Jan 2024 06:54:04 -0800 (PST)
Date: Thu, 18 Jan 2024 06:54:04 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Zqiang <qiang.zhang1211@gmail.com>, quic_neeraju@quicinc.com,
	joel@joelfernandes.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Check rdp_gp->nocb_timer in
 __call_rcu_nocb_wake()
Message-ID: <280f9a31-218c-4afd-a568-28efab378580@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240117102616.18302-1-qiang.zhang1211@gmail.com>
 <ZafC_YkTJKsOropE@localhost.localdomain>
 <3b63cf39-3805-4c1d-b79b-fdd5aeb17db3@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b63cf39-3805-4c1d-b79b-fdd5aeb17db3@paulmck-laptop>

On Thu, Jan 18, 2024 at 06:51:57AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 17, 2024 at 01:07:25PM +0100, Frederic Weisbecker wrote:
> > Le Wed, Jan 17, 2024 at 06:26:16PM +0800, Zqiang a écrit :
> > > Currently, only rdp_gp->nocb_timer is used, for nocb_timer of
> > > no-rdp_gp structure, the timer_pending() is always return false,
> > > this commit therefore need to check rdp_gp->nocb_timer in
> > > __call_rcu_nocb_wake().
> > > 
> > > Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> > > ---
> > >  kernel/rcu/tree_nocb.h | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > index 54971afc3a9b..3f85577bddd4 100644
> > > --- a/kernel/rcu/tree_nocb.h
> > > +++ b/kernel/rcu/tree_nocb.h
> > > @@ -564,6 +564,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
> > >  	long lazy_len;
> > >  	long len;
> > >  	struct task_struct *t;
> > > +	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
> > >  
> > >  	// If we are being polled or there is no kthread, just leave.
> > >  	t = READ_ONCE(rdp->nocb_gp_kthread);
> > > @@ -608,7 +609,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
> > >  		smp_mb(); /* Enqueue before timer_pending(). */
> > >  		if ((rdp->nocb_cb_sleep ||
> > >  		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
> > > -		    !timer_pending(&rdp->nocb_timer)) {
> > > +		    !timer_pending(&rdp_gp->nocb_timer)) {
> > 
> > Hehe, good eyes ;-)
> > 
> > I had that change in mind but while checking that area further I actually
> > wondered what is the actual purpose of this RCU_NOCB_WAKE_FORCE thing. If
> > we reach that place, it means that the nocb_gp kthread should be awaken
> > already (or the timer pending), so what does a force wake up solve in that
> > case?
> > 
> > Paul, any recollection of that?
> 
> Huh.  We never actually do RCU_NOCB_WAKE_FORCE in v6.7, if I followed
> all the code paths correctly.
> 
> Historically, I have been worried about lost wakeups.  Also, there
> used to be code paths in which a wakeup was not needed, for example,
> because we knew that the ending of the current grace period would take
> care of things.  Unless there was some huge pile of callbacks, in which
> case an immediate wakeup could avoid falling behind a callback flood.
> 
> Given that rcutorture does test callback flooding, we appear to be OK,
> but maybe it is time to crank up the flooding more.
> 
> On the other hand, I have started seeing the (very) occasional OOM
> on TREE03.  (In addition to those that show up from time to time on the
> single-CPU TREE09 scenario.)

Oh, and queued for further review and testing, thank you both!

							Thanx, Paul

> > In the meantime:
> > 
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

