Return-Path: <linux-kernel+bounces-79363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AF2862134
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5CC1C245F5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3E11373;
	Sat, 24 Feb 2024 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRFq04Cv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D7310F2;
	Sat, 24 Feb 2024 00:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734505; cv=none; b=jjxLI0/nLGIsqNzCQyxvKlBOUlaQZ6XWrp4pUjQWN9o00LCT0a9QMx8f8ciRC+C6mfpQEvi8Mouyomq97cRRHMlkZGbJQCRW3xWCqs+N3jP5tlvsMt4KC+q1A9FO896SOyB1JwRLdnumTmhZWwvxUj8xqdBzOL+5DXjQZkgDylk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734505; c=relaxed/simple;
	bh=NfXtG/1GMXbQ2yBn2k0Gm8LXQ6d0gmiTwMDv0HaP6Y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMDyYpY+gq6jzARRClsDkZDsJz2dM1sAOj6sV9wY2PK1+cGQil+Q0Ydp6D67yPTT+ZtcFC4HpDQdoGC/mkCAm24fJnNZ41Q2rjBt0rV6GD7v0xEauGRuH4UUasEycfY3nuMaSzyitLuj2tc8aq/fFyRBnrJfAUNsxsLBP3z9q2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRFq04Cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5DDC433C7;
	Sat, 24 Feb 2024 00:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708734504;
	bh=NfXtG/1GMXbQ2yBn2k0Gm8LXQ6d0gmiTwMDv0HaP6Y8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=VRFq04CvhZ3G0DEDfladC2Pth55Hp8itifcNJuADVOl65dYXrWqJgGghGyU5g/8wW
	 wglNojhhmItEA2QXQDxJLNeuA7qPa0WAjTxytJRXd05+8VCE3hiBazML8nBhPo5Iri
	 EAxSKfBcN4KoxXdOXooKVUSxpcb+kZb/psYzrl58GxusG+wTmvt176AwnL7CIwg0A7
	 CgbSciL1mV2MBIw2RufWmoNG6NUrhyRZEwOl+tc5tcGyuje026XKMpil2NODz4bF8/
	 AskIkeT1Ea0cTViK/hJ+2A061DM9JvpCJ5EOWBNOeV6OvNNgfw/h89c90z7xUhpR9E
	 ezyYZ0SpPKr/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 290F5CE1113; Fri, 23 Feb 2024 16:28:19 -0800 (PST)
Date: Fri, 23 Feb 2024 16:28:19 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 4/6] rcu-tasks: Maintain lists to eliminate
 RCU-tasks/do_exit() deadlocks
Message-ID: <dcea0803-7f9d-4d27-af68-1efb9015dbff@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <20240217012745.3446231-5-boqun.feng@gmail.com>
 <ZdiNXmO3wRvmzPsr@lothringen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdiNXmO3wRvmzPsr@lothringen>

On Fri, Feb 23, 2024 at 01:19:42PM +0100, Frederic Weisbecker wrote:
> On Fri, Feb 16, 2024 at 05:27:39PM -0800, Boqun Feng wrote:
> > -void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
> > +void exit_tasks_rcu_start(void)
> >  {
> > -	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
> > +	unsigned long flags;
> > +	struct rcu_tasks_percpu *rtpcp;
> > +	struct task_struct *t = current;
> > +
> > +	WARN_ON_ONCE(!list_empty(&t->rcu_tasks_exit_list));
> > +	preempt_disable();
> > +	rtpcp = this_cpu_ptr(rcu_tasks.rtpcpu);
> > +	t->rcu_tasks_exit_cpu = smp_processor_id();
> > +	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> > +	if (!rtpcp->rtp_exit_list.next)
> 
> And then you might want to turn that into a WARN_ONCE.

Excellent point, thank you!

I am queueing a separate patch for this with your Reported-by.  (This
change can lag behind, just in case this series needs to go in quickly.)

						Thanx, Paul

> Thanks.
> 
> > +		INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
> > +	list_add(&t->rcu_tasks_exit_list, &rtpcp->rtp_exit_list);
> > +	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> > +	preempt_enable();
> >  }

