Return-Path: <linux-kernel+bounces-48608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CF5845EC9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761E01C25728
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACBB7C6D5;
	Thu,  1 Feb 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehzY6HQT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF7D7C6C4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809386; cv=none; b=oTw5Hjrb8y2q2XXD/sStTTcZGVAPVDa0PnSxMR9bvmf6Up/5FmYAa1QlX70GojvGNcdo+FAfE8KPH/A1oprAl1n2UWs1LcCVMUXMsBYqN4TJDKeFwSXjqu22d6a3v8VA5VYrlRqQIEjpVEhI4jMnIni/a5lwCkHw/8RBjgtuxH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809386; c=relaxed/simple;
	bh=26JRDELdEoaW+QL/CncCjrGKkR2p6/0I9DM2N8AaJHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtVu9ptFW1/lyO1AsQExHMm5VTfBN2VXjM3fZlpdHM32LScMT5pbQW17LFaWbkKNgEStSzPzlciOHL4Zqg1EjIESe6Hu7ag0FgzhhVOg0tsn61PEHhNMTDu7wzmxr/vJ/e48chQi980Cv9jJeGMKKTxQ3Rp15QZPJ0ER9kNZs/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehzY6HQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7193C433C7;
	Thu,  1 Feb 2024 17:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706809386;
	bh=26JRDELdEoaW+QL/CncCjrGKkR2p6/0I9DM2N8AaJHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ehzY6HQT/JRf7vz2D5NQO3k9euoht9RE8kpeVxe/YntuUHhrqiVA0sWOXJGoCzTak
	 CQPzx07Sb/7rSOix7ONCdFU1XYyqJqjRsjUYk34RDXVrfPQCF6j3nCGRiSUQWgIgnc
	 rKSsfYzLRAdo8iZng/9JcIZS3GPxpDcPiXhQsgMB5UmwptB827TUfGJt2HHWYzVvOR
	 +USO9I5CLoVjR3mhTgwRbBnWVzT1HVcAzpTc0ScAjnxDLU7Xl7+rE5qxwEe7akB5tE
	 71pzV1E/GL7oCzcS/p0lXv37QE5GtH9ywi973UfNmCWZNVMgvj8RkOKlwruNhPS3eb
	 snpdOeDhKqiaw==
Date: Thu, 1 Feb 2024 18:43:03 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v10 18/20] timers: Implement the hierarchical pull model
Message-ID: <ZbvYJysR7gnaQiNg@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZbuzMeKlCgebhJZ-@localhost.localdomain>
 <87bk90i2ja.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bk90i2ja.fsf@somnus>

Le Thu, Feb 01, 2024 at 05:15:37PM +0100, Anna-Maria Behnsen a écrit :
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > Le Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen a écrit :
> >> +static void tmigr_connect_child_parent(struct tmigr_group *child,
> >> +				       struct tmigr_group *parent)
> >> +{
> >> +	union tmigr_state childstate;
> >> +
> >> +	raw_spin_lock_irq(&child->lock);
> >> +	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
> >> +
> >> +	child->parent = parent;
> >> +	child->childmask = BIT(parent->num_children++);
> >> +
> >> +	raw_spin_unlock(&parent->lock);
> >> +	raw_spin_unlock_irq(&child->lock);
> >> +
> >> +	/*
> >> +	 * To prevent inconsistent states, active children need to be active in
> >> +	 * the new parent as well. Inactive children are already marked inactive
> >> +	 * in the parent group.
> >> +	 */
> >> +	childstate.state = atomic_read(&child->migr_state);
> >> +	if (childstate.migrator != TMIGR_NONE) {
> >
> > Is it possible here to connect a running online child (not one that we just
> > created) to a new parent?
> 
> connect_child_parent() is only executed for the just created ones. So,
> yes in theory this would be possible, but it doesn't happen as
> tmigr_setup_groups() takes care to make it right (hopefully :)). When a
> LVL0 group has some space left, only the connection between tmc and the
> LVL0 group is done in tmigr_setup_groups(). If there is no space left in
> LVL0 group, then a new group is created and depending on the levels
> which has to be created only executed for the new ones.
> 
> > If not, is it possible that a newly created child is
> > not TMIGR_NONE?
> 
> Yes. See tmigr_cpu_online(). When new groups have to be created starting
> from LVL0, then they are not active - so TMIGR_NONE is set. Activating
> the new online CPU is done afterwards.
> 
> But if it is required to add also a new level at the top, then it is
> mandatory to propagate the active state of the already existing child to
> the new parent. The connect_child_parent() is then also executed for the
> formerly top level group (child) to the newly created group (parent).

Ah and this is why we have the "if (childstate.migrator != TMIGR_NONE)"
branch, right?

> > Heh, I was about to say that it's impossible that timer_base_is_idle()
> > at this stage but actually if we run in nohz_full...
> >
> > It happens so that nohz_full is deactivated until rcutree_online_cpu()
> > which calls tick_dep_clear() but it's a pure coincidence that might
> > disappear one day. So yes, let's keep it that way.
> 
> I instrumented the code (with NOHZ FULL and NOHZ_IDLE) to make sure the
> timer migration hierarchy state 'idle' is in sync with the timer base
> 'idle'. And this was one part where it was possible that it runs out of
> sync as I remember correctly. But if I understood you correctly, this
> shouldn't happen at the moment?

Well, it's not supposed to :-)

Thanks.

> 
> Thanks,
> 
> 	Anna-Maria
> 

