Return-Path: <linux-kernel+bounces-99447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CB8878878
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B47FB22C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E8F56443;
	Mon, 11 Mar 2024 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZULmN2V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B7155792;
	Mon, 11 Mar 2024 19:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710183681; cv=none; b=tDQ3VxHr4+6/tTcNRN86mvUTldbdgSn3jqNbyP0y3T7Rl4t2/a7TQwfe+WSUSpMcNfxJZnfeED/54wkUG84xDFSFHeUDByWPYKZ1PzA/r4U+qWBEtmHaaz4ECIL6rJPCO+y7Tkv7XWzeu3h2Kbel4tqgi72hyr8BA7hi8YVkiuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710183681; c=relaxed/simple;
	bh=nJrp1Y9l6Y09y6DGb2hHKl38I+DRlu4uhl9A1sfZhp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1hzaj9cIgm8w/9J+A1OYvL5DkJuXD0n3ec2IfyNp6oI7m+td64MY/zsY1TUWoHAlPiyZ1TFmVf+/JVHXrpT1KZzTqGuUMxiKnzO11PF/cTS6ZxLTglu1NCLfCiAhqqNKWPMKVn3klSFCAZ+hF/FhVQkhvnGLaMO7AYuBtLKtv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZULmN2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DFDC433F1;
	Mon, 11 Mar 2024 19:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710183681;
	bh=nJrp1Y9l6Y09y6DGb2hHKl38I+DRlu4uhl9A1sfZhp0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tZULmN2V0fMkFqidHaZ9A7yEiIKNZjQ1U74oLWYftcP+26hLhqdgrjShqkYLzAX7n
	 +vgwyE8WkMxMDMOJlSoxKAfike/K0jpmsewvrP1upZXEUWuVShp3hOqnld+TZ5Gal6
	 X3+VAMK/8GmfIEwlVaE0yH0ndMHYg/movgK+YBp0CJkwKIht/VbkzWJjDMPjQKQnU8
	 Lk4WglaIi2crRczw6Zc6Yj4WaVTdzmkYcb9QmFmTr3joRqc45KK9HUOkpJM3CIiLS8
	 2WvWB2xMFK15qX0NYt5ZJ+Toc8d4/jhRzW3aqQ1Fp/h9yYitxD+PYm/QlwIzwJaVDr
	 mlwYl14eqAdTQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 93F47CE0B68; Mon, 11 Mar 2024 12:01:20 -0700 (PDT)
Date: Mon, 11 Mar 2024 12:01:20 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	linux-arm-kernel@lists.infradead.org, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: smp: Avoid false positive CPU hotplug Lockdep-RCU
 splat
Message-ID: <d42e5844-5a53-4854-b464-b622686e9f8f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240307160951.3607374-1-stefan.wiehler@nokia.com>
 <Ze8sl01dgGTLcREs@shell.armlinux.org.uk>
 <c0001d35-a75a-4cdf-917b-8e1ec159502d@nokia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0001d35-a75a-4cdf-917b-8e1ec159502d@nokia.com>

On Mon, Mar 11, 2024 at 05:17:43PM +0100, Stefan Wiehler wrote:
> > So what do I do about this? I see you submitted this to the patch system
> > on the 8th March, but proposed a different approach on the 9th March. I
> > don't see evidence that Paul is happy with the original approach either
> > and there's no ack/r-b's on anything here.
> 
> I think we need to wait for feedback from Will Deacon regarding the new
> arch_spin_lock() based approach. So please abandon the original proposal in the
> patch system, at least for now…

I prefer the arch_spin_lock() version, but the other approach also works.
I agree with Stefan that it would also be good to get Will's feedback.

The downside of the arch_spin_lock() approach is that, in theory, it
prevents lockdep from seeing deadlocks involving that lock acquisition.
But in practice, that is a problem only if additional locks can be
acquired while that lock is held, and there are no such additional
locks, right?

The downside of the original approach is that it further complicates
RCU's interaction with offline CPUs, especially should people copy that
approach in other pieces of offline code.

So, again, I prefer the arch_spin_lock() approach.

							Thanx, Paul

