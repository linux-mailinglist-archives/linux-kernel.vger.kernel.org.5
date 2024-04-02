Return-Path: <linux-kernel+bounces-128389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53755895A2B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D481F2132B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B640C159908;
	Tue,  2 Apr 2024 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czbIuNM1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1417BD4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712076458; cv=none; b=Bg/NhEqSXBfv2P34lN9+DKtscSxw+33kOmnxi4YvXxs8MS9CGsRvcbcsmVAKIIBWS/XarO6Nt/ZSNkbZGgALOGEh0+M2QIqLHU/nTbr8BefuhuAbc1yNZiW83ShruC+/PBvsIJW+ogrGVpCyJnsR5G6/M9bA4J+Mxrr2SCG30iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712076458; c=relaxed/simple;
	bh=hJ1GDaXq7VRG2pC36rEu0KysPFDAaxQq4vfTZyVpcMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OokjrkcXD74v7aj1Jsd8D7cuK6XZ91/zKqfvH166n/RXA02yooFmn+tK8p6tvqKslJerM54PqNQPgi7bGXTFcLCvc7pVWItF09AR8a8fLoq7vUs1ri8/M8X3zR7EquRWLwnYAEw4HsIjYwuDgojsB+TIi/hQ/3kFxEiXv81Pphw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czbIuNM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DACC433C7;
	Tue,  2 Apr 2024 16:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712076457;
	bh=hJ1GDaXq7VRG2pC36rEu0KysPFDAaxQq4vfTZyVpcMQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=czbIuNM1WuqAuvWgwuzeL9WkK0zLRECs8PqcNzU4PumCnYJsXmlfQaKBxgueGgNEF
	 RKyT40/15wU5vF/0o6Tp/HZDdk1ibxufWmhR6gH34xbJgrnUcjDOGqEFa/d8hDRTyz
	 KITaIr6fEOO64LBos+DaVgNdHSnhLGih7g7cJxyCw6Z0tYolDnjDMvPr5A4+dQOWWT
	 BS1IqPLL5+UBUMDS0IjSsD++JMvW12kSBhnYmX03gr204zzRy/OLrl7SA6nNO7khW8
	 3BhkB3gsnDNrWGBEw89DeVFyHZiHxThkbqQiKqxiie+x8reIMV3PIdsUYfvMhBK7WT
	 617hItteoif2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0C31DCE0FF2; Tue,  2 Apr 2024 09:47:37 -0700 (PDT)
Date: Tue, 2 Apr 2024 09:47:37 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 2/2] timers: Fix removed self-IPI on global timer's
 enqueue in nohz_full
Message-ID: <3f2597ea-81ba-4498-a0ee-84d7e4e3da59@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240318230729.15497-3-frederic@kernel.org>
 <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
 <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
 <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
 <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
 <797f44f9-701d-4fca-a9f4-d112a7178e7b@paulmck-laptop>
 <ZgstlCZn0l9wSv7H@pavilion.home>
 <ed13826a-d2d3-4999-8d9e-77dfc6245e1c@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed13826a-d2d3-4999-8d9e-77dfc6245e1c@paulmck-laptop>

On Mon, Apr 01, 2024 at 05:04:10PM -0700, Paul E. McKenney wrote:
> On Mon, Apr 01, 2024 at 11:56:36PM +0200, Frederic Weisbecker wrote:
> > Le Mon, Apr 01, 2024 at 02:26:25PM -0700, Paul E. McKenney a écrit :
> > > > > _ The RCU CPU Stall report. I strongly suspect the cause is the hrtimer
> > > > >   enqueue to an offline CPU. Let's solve that and we'll see if it still
> > > > >   triggers.
> > > > 
> > > > Sounds like a plan!
> > > 
> > > Just checking in on this one.  I did reproduce your RCU CPU stall report
> > > and also saw a TREE03 OOM that might (or might not) be related.  Please
> > > let me know if hammering TREE03 harder or adding some debug would help.
> > > Otherwise, I will assume that you are getting sufficient bug reports
> > > from your own testing to be getting along with.
> > 
> > Hehe, there are a lot indeed :-)
> > 
> > So there has been some discussion on CPUSET VS Hotplug, as a problem there
> > is likely the cause of the hrtimer warning you saw, which in turn might
> > be the cause of the RCU stalls.
> > 
> > Do you always see the hrtimer warning along the RCU stalls? Because if so, this
> > might help:
> > https://lore.kernel.org/lkml/20240401145858.2656598-1-longman@redhat.com/T/#m1bed4d298715d1a6b8289ed48e9353993c63c896
> 
> Not always, but why not give it a shot?

And no failures, though I would need to run much longer for this to
mean much.  These were wide-spectrum tests, so my next step will be to
run only TREE03 and TREE07.

							Thanx, Paul

