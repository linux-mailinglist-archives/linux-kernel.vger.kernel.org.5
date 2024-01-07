Return-Path: <linux-kernel+bounces-18751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D3D826289
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63AE31F21EAC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 00:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9D015A3;
	Sun,  7 Jan 2024 00:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enPzEd0A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E644137F
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 00:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0552C433C7;
	Sun,  7 Jan 2024 00:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704588589;
	bh=+zMBNVNcBRxMqLOkvk51UWJra7kOFYLL5nN74pm91Gs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=enPzEd0A+HtzD82JzD/mCUvqz7T4CpIFes6VWTw/9MBEcKhJOwzUg3Q0yCREolsLp
	 NoMr/cmGCWeGbOmUSj8xX3HiVWFr8zBdw6Oik5316LjWtw5PUSLMvSc5z2id3O6g6z
	 iacvLO50QggUVOQGWIE2dVWDpq6FcXhPmHOn48qRhNcgB+RzaqtqIMCBo1GaPH5l0O
	 FF/SStRtyyHuAXbIpuI3XhPOWXGH7zUVeH1enpdmTct4rIiRFt3TIPeS+H71CtPUjO
	 chH/Fako32S/g7wQgrgYdBUrbPyeO/oPhjBCJ2OGMGnNB3Sqo0Q8bPslawhNwV6S8z
	 +8ZDeUmQGuDdw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 39788CE1466; Sat,  6 Jan 2024 16:49:49 -0800 (PST)
Date: Sat, 6 Jan 2024 16:49:49 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Prototype patch to avoid TREE07 rcu_torture_writer() stalls
Message-ID: <127b057c-446e-4b3f-bb04-d1c4efdded0f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a40344c8-a260-41f3-bd7a-6a63d8660489@paulmck-laptop>
 <ZZiIQvu+2CGufvOL@lothringen>
 <3da2e014-ed54-4b2a-9fde-99d6eef3e897@paulmck-laptop>
 <8c135e1a-5f66-42ae-9749-71a65f86dcbf@paulmck-laptop>
 <ZZnV0xt9ZhAu-vUh@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZZnV0xt9ZhAu-vUh@localhost.localdomain>

On Sat, Jan 06, 2024 at 11:36:03PM +0100, Frederic Weisbecker wrote:
> Le Sat, Jan 06, 2024 at 06:55:14AM -0800, Paul E. McKenney a écrit :
> > > Is this related?
> > > 
> > > But then the system picks itself up, dusts itself off, and goes along
> > > as if nothing had happened.
> > > 
> > > Maybe a long-running IRQ, NMI, or SMI?
> > 
> > Or, based on a recent bug chase of another type, high contention on
> > an IRQ-disabled spinlock?
> 
> Before checking the guest's dmesg, I should probably have checked the host's.
> It seems to report some softlockups, perhaps due to too many instances
> in parallel where memory is not that generous.

That would do it!

> Let me try to run as much time (250 hours) but with fewer instances in
> parallel.

I just today saw an extended stall on one instance of TREE03, also
RCU grace-period kthread starvation.  But this was in -next, which
is also having other yet-as-unanalyzed issues.

							Thanx, Paul

