Return-Path: <linux-kernel+bounces-92294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818B1871E07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D2C1C22297
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF4D5811A;
	Tue,  5 Mar 2024 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI6XFNSQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BCA1B94A;
	Tue,  5 Mar 2024 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638592; cv=none; b=qtP4Ql0eTHAEcmLx6XJyfgTKVZoYi8eHXqkER0K6KMJSemzlSzb49zDJ/EzHQ7lRgviZwda4UnwyoJIoAB+rQjP5rdMF1eryqBL9G8H0XJWYGg60IfkygHiDRy9nb/cavK/veqMEALVjC4hOomqXWMVV4oboB0GpcGB6/dDCvpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638592; c=relaxed/simple;
	bh=vwD3BWS6M42qq7XJEJgBmFdf8+GmcvadJcolAH9VwJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKM9sFFBUoDpIo2/zgNHT5ilTIk1YZINYG1q50tInbjHTQS2jEVsNUfh1TKHJoCp7bkOm2fg1cMBI6sQPF8Im2CNBdkc9hlCzBPdpQ2+3agbpM31OSLSdz1BMJ0M6M7qoWfO0JJ1Meo00k1V5plNIlPUQzAnvMrQQpiiV3ycV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI6XFNSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CF3C433F1;
	Tue,  5 Mar 2024 11:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709638592;
	bh=vwD3BWS6M42qq7XJEJgBmFdf8+GmcvadJcolAH9VwJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XI6XFNSQgy+QLFvQeLImHR/yYJBq04ff3Okkuw30/56lD0lUitjo8M4QJzROS+8eb
	 ZDOvAp0DRIJz9I4FsZjKH95hyV/tHApIKs6qFo69ODQvRDm4K69WzCEh0bImM7zcVA
	 NPGW7yC9O7owkoXAyxveQgvbPAOU7eZ0PXOBImnVTvuG/rnCoHoDImX7HKfXfa1YbD
	 uXAIXLVVlYRGIz447OVoif9nGttoEg1D/oEv+q5s65wMksYO0J5jVKT2VrOmMPfQj4
	 tLl4SMQ/s95Ony0r2/KWfmkwCp/FYvHcXg0UcE9dvuRyMPkHOQYVxyCmLvSQsVlYV6
	 V4iS/LEOkBY2A==
Date: Tue, 5 Mar 2024 12:36:29 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <ZecDvTGKErRckb2G@lothringen>
References: <20240220183115.74124-1-urezki@gmail.com>
 <20240220183115.74124-3-urezki@gmail.com>
 <Zd0ZtNu+Rt0qXkfS@lothringen>
 <Zd91pR0fjiCUZTtP@pc636>
 <ZeW2w08WZo4yapQp@localhost.localdomain>
 <ZeX1cXWKv2kirDXg@pc638.lan>
 <ZeZRk-1Kx-s0Nz34@pavilion.home>
 <Zebn-MvZq7NkFjq-@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zebn-MvZq7NkFjq-@pc636>

On Tue, Mar 05, 2024 at 10:38:00AM +0100, Uladzislau Rezki wrote:
> On Mon, Mar 04, 2024 at 11:56:19PM +0100, Frederic Weisbecker wrote:
> > Le Mon, Mar 04, 2024 at 05:23:13PM +0100, Uladzislau Rezki a écrit :
> > > On Mon, Mar 04, 2024 at 12:55:47PM +0100, Frederic Weisbecker wrote:
> > > The easiest way is to drop the patch. To address it we can go with:
> > > 
> > > <snip>
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 31f3a61f9c38..9aa2cd46583e 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1661,16 +1661,8 @@ static void rcu_sr_normal_gp_cleanup(void)
> > >  	 * wait-head is released if last. The worker is not kicked.
> > >  	 */
> > >  	llist_for_each_safe(rcu, next, wait_tail->next) {
> > > -		if (rcu_sr_is_wait_head(rcu)) {
> > > -			if (!rcu->next) {
> > > -				rcu_sr_put_wait_head(rcu);
> > > -				wait_tail->next = NULL;
> > > -			} else {
> > > -				wait_tail->next = rcu;
> > > -			}
> > > -
> > > +		if (rcu_sr_is_wait_head(rcu))
> > >  			break;
> > > -		}
> > >  
> > >  		rcu_sr_normal_complete(rcu);
> > >  		// It can be last, update a next on this step.
> > > <snip>
> > > 
> > > i.e. the process of users from GP is still there. The work is triggered
> > > to perform a final complete(if there are users) + releasing wait-heads
> > > so we do not race anymore.
> > 
> > It's worth mentioning that this doesn't avoid scheduling the workqueue.
> > Except perhaps for the very first time rcu_sr_normal_gp_cleanup() is called,
> > the workqueue will always have to be scheduled at least in order to release the
> > wait_tail of the previous rcu_sr_normal_gp_cleanup() call.
> > 
> No, it does not avoid for sure :) I will add more explanation.
> 
> > But indeed you keep the optimization that performs the completions themselves
> > synchronously from the GP kthread if there aren't too many of them (which
> > probably is the case most of the time).
> > 
> > > I am OK with both cases. Dropping the patch will make it more simple
> > > for sure.
> > 
> > I am ok with both cases as well :-)
> > 
> > You choose. But note that the time spent doing the completions from the GP
> > kthread may come at the expense of delaying the start of the next grace period,
> > on which further synchronous RCU calls may in turn depend on...
> > 
> That is a true point. Therefore we do it with a fixed number which should not
> influence on a GP.

Sounds good!

