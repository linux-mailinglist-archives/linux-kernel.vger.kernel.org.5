Return-Path: <linux-kernel+bounces-97617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87121876C81
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4656282B18
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9223B5FB99;
	Fri,  8 Mar 2024 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rewK1cN9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB35FB8A;
	Fri,  8 Mar 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709934725; cv=none; b=rK6OexFKfMV01q1dO3wjL9obgrY9DIFjeQkCvPKc3CE32kcflO287cajdNYMTBKmGFmt6wMIzcNHhvSRLGwW+JSBZa3CtgXtf1HqFOidfqSjUeStnwZCprlO6EVOWngDxC9pOYdvy4cpJR+SG7oaDB7iWg8Xn+leop5aGwHtsF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709934725; c=relaxed/simple;
	bh=dbXkGWO24AcaqW30+bWpUykQ8s/OPhFTkOUOiAbXrr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cS7IgJjHDFLkdkE67QdvpJEuSvP53I4ZQwcs0pI/fktVcloe5RaYkY9CT/axox26UK2SCZU1mBW+I185/HsLkwruvA6NV/5JlTVV4O0elfO/vVxr3nxamtuzIfmQX5rBKah0g1Af6jGs1mhDABldLe6oqYpHIg9+ZjcT0JauR0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rewK1cN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5666FC433F1;
	Fri,  8 Mar 2024 21:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709934725;
	bh=dbXkGWO24AcaqW30+bWpUykQ8s/OPhFTkOUOiAbXrr0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rewK1cN96yTC30A1Dsk2GivqNSpEhDRJI8qw2saB6PRX2GFjpd3iYtD5uMoBpEIsS
	 RlxNDbT6CirSso3TWQaUlHdPf4tCVUIg7H3ApN07G9GGg+Pb5OudVn8lbb6PhBf2x/
	 uhUPjIUF2QTCNjAMqdWYpIfqYbWXH+/RErw1VWSc2kySpzb5KYKLqwR55Gq9rGPmXO
	 WN46Mk/GyYaHHpGsHbHV5CDonjx+uETPDe/w0wxrcXQrwPHfLSJL0BtXJZwbgM4lbV
	 hUAr96R85X84byUqE91+cGf5QWPdTeQpfiZPfAGdbcSCiJf1DitM0MfJqHziNhFZjN
	 XNoZo2qV30lOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 06E5DCE0548; Fri,  8 Mar 2024 13:52:05 -0800 (PST)
Date: Fri, 8 Mar 2024 13:52:05 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
	frederic@kernel.org, boqun.feng@gmail.com, neeraj.iitr10@gmail.com,
	rcu@vger.kernel.org, rostedt@goodmis.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH] [RFC] rcu/tree: Reduce wake up for synchronize_rcu()
 common case
Message-ID: <d75fd0b2-f6e0-4102-a5d2-11c7c5487949@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240307234852.2132637-1-joel@joelfernandes.org>
 <CAEXW_YQ-TZB-1gpxvf7v+QAZhHtzV5waBA1VemtgEwNktSp=ww@mail.gmail.com>
 <ccbdf4d4-6972-430c-a479-0d20b318213b@paulmck-laptop>
 <ZespK0CrkVFCu6_p@pc636>
 <ZetNHb6MrmHkQKJN@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZetNHb6MrmHkQKJN@pc636>

On Fri, Mar 08, 2024 at 06:38:37PM +0100, Uladzislau Rezki wrote:
> On Fri, Mar 08, 2024 at 04:05:15PM +0100, Uladzislau Rezki wrote:
> > On Thu, Mar 07, 2024 at 04:06:06PM -0800, Paul E. McKenney wrote:
> > > On Thu, Mar 07, 2024 at 06:52:14PM -0500, Joel Fernandes wrote:
> > > > On Thu, Mar 7, 2024 at 6:48 PM Joel Fernandes (Google)
> > > > <joel@joelfernandes.org> wrote:
> > > > >
> > > > > In the synchronize_rcu() common case, we will have less than
> > > > > SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> > > > > is pointless just to free the last injected wait head since at that point,
> > > > > all the users have already been awakened.
> > > > >
> > > > > Introduce a new counter to track this and prevent the wakeup in the
> > > > > common case.
> > > > >
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > ---
> > > > 
> > > > Forgot to mention, this is based on the latest RCU -dev branch and
> > > > passes light rcutorture testing on all configs. Heavier rcutorture
> > > > testing (60 minutes) was performed on TREE03.
> > > 
> > > Very good, thank you!
> > > 
> > > Uladzislau, could you please pull this into the next series you send?
> > > I can then replace your commits in -rcu with the updated series.
> > > 
> > Absolutely. I will go through it and send out the next version!
> > 
> 
> Joel, i sent out the v6: [PATCH v6 0/6] Reduce synchronize_rcu() latency(v6)
> 
> Could you please rework the patch on latest tip once the series i sent is
> settled on Paul's dev?

It is there now.

							Thanx, Paul

> I have not sent your patch because it is not cleanly applied and needs some
> review.
> 
> Thank you in advance!
> 
> --
> Uladzislau Rezki

