Return-Path: <linux-kernel+bounces-81700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666F786792F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8512935A2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1141468E3;
	Mon, 26 Feb 2024 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esb96N7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163BB146013;
	Mon, 26 Feb 2024 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708958265; cv=none; b=tPNGND6FXzQi8CYTlYNDG007rhpAfVQZTmmG9gjDDTQISCE/EvU2lbz1YJzwzc84x9YO3Pc1Pxo6YPcuwYY8iSUEYzpBE5raRF6X4sgVMF4lzpK7UYz8DziMNCs6rNinA2THNnu9d1jszA6eCXxqBRoEA9CGvgnIKQWnMLeww20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708958265; c=relaxed/simple;
	bh=CgTdLy5NYaK57gAWbYSHp38qtWY9DVQqvCxXz0gj/Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slf3Jyg4acxhZlo86GCfkiVMlrdh/+r/eCvpUIVlNsmx/+JhbHYmNgCoo3OGVGa2eInI0wb6FxFUT8BWpVYaTJEnAm+rWreGtIdLLakInbkBxxMHNZ9PsAWngZqzJgOOPH2AI3inmxxf34K6AYd6NTj6MTdSMqTOzgS6/4hp5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esb96N7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B51C433B2;
	Mon, 26 Feb 2024 14:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708958264;
	bh=CgTdLy5NYaK57gAWbYSHp38qtWY9DVQqvCxXz0gj/Ww=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=esb96N7NFLftQHC3Sl8PHKq8CzkjlIftJg9TUlDelJOcwEjMcypU3YByHtaMGj0te
	 JSYCRuZh4CfT3P5E9wjfuXIkAdhN0lxjBLVQyu5HvVbXpzEIM5vgG3apuKxa+1fwX1
	 gprYgf1EA/MuksEffl+1LqsAex3B/4sDbjuvpVniadmnXm1U/JsolSGXRNhBSV18zB
	 HBVpiaRrJzWZmzE7mToTZjvLn02MbPxOD1pPue/OHaVeS+RgHbJRVJ2Xvl9pmPObur
	 XbsojY29fWlHu6KYixrggS4utj4PXSSqyL5XGqll3IsL6G9L7Z6kjc0PRY4Z8LQfk1
	 kbRF55KWV15gg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 12A4DCE088C; Mon, 26 Feb 2024 06:37:44 -0800 (PST)
Date: Mon, 26 Feb 2024 06:37:44 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v2 0/6] RCU tasks fixes for v6.9
Message-ID: <fd002697-2c2e-40e1-ad72-aa806b57e15f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <Zdd7x4Rmy_-WDqfl@localhost.localdomain>
 <cf84fb44-9620-40bc-a68d-051edf6823b8@paulmck-laptop>
 <ZdiOot2RJm1VuzSJ@lothringen>
 <8f992601-153e-4cc1-8e7e-6684823cd590@paulmck-laptop>
 <ZdyYdhZtNuJp3h-a@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdyYdhZtNuJp3h-a@localhost.localdomain>

On Mon, Feb 26, 2024 at 02:56:06PM +0100, Frederic Weisbecker wrote:
> Le Fri, Feb 23, 2024 at 04:43:04PM -0800, Paul E. McKenney a écrit :
> > I do indeed mean doing cond_resched() mid-stream.
> > 
> > One way to make this happen would be to do something like this:
> > 
> > struct task_struct_anchor {
> > 	struct list_head tsa_list;
> > 	struct list_head tsa_adjust_list;
> > 	atomic_t tsa_ref;  // Or use an appropriate API.
> > 	bool tsa_is_anchor;
> > }
> > 
> > Each task structure would contain one of these, though there are a
> > number of ways to conserve space if needed.
> > 
> > These anchors would be placed perhaps every 1,000 tasks or so.  When a
> > traversal encountered one, it could atomic_inc_not_zero() the reference
> > count, and if that succeeded, exit the RCU read-side critical section and
> > do a cond_resched().  It could then enter a new RCU read-side critical
> > section, drop the reference, and continue.
> > 
> > A traveral might container_of() its way from ->tsa_list to the
> > task_struct_anchor structure, then if ->tsa_is_anchor is false,
> > container_of() its way to the enclosing task structure.
> > 
> > How to maintain proper spacing of the anchors?
> > 
> > One way is to make the traversals do the checking.  If the space between a
> > pair of anchors was to large or too small, it could add the first of the
> > pair to a list to be adjusted.  This list could periodically be processed,
> > perhaps with more urgency if a huge gap had opened up.
> > 
> > Freeing an anchor requires decrementing the reference count, waiting for
> > it to go to zero, removing the anchor, waiting for a grace period (perhaps
> > asynchronously), and only then freeing the anchor.
> > 
> > Anchors cannot be moved, only added or removed.
> > 
> > So it is possible.  But is it reasonable?  ;-)
> 
> Wow! And this will need to be done both for process leaders (p->tasks)
> and for threads (p->thread_node) :-)

True enough!  Your point being?  ;-)

							Thanx, Paul

