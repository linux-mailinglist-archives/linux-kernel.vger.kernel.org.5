Return-Path: <linux-kernel+bounces-137562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6AE89E3EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57B8283C69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A22157E9C;
	Tue,  9 Apr 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RpTeG0tB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA5C156C44;
	Tue,  9 Apr 2024 19:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692384; cv=none; b=JRWeTvKGsAGpfha37mnXh6mkdHTtfT2b1QhFj10o8YT+aZpprM6+gKSYybDpBBAAk/uO4YBq3gex7Lg0AlvBisI26pF3ohNEAcaywZtfGLCRJKXbNmZshR8K+i0D+hvvNKB+ziq9u6RnA5LMizDggClFr0vPONBsCph7K7MqXfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692384; c=relaxed/simple;
	bh=XW+KtnYyyhPI+nxpRegjNzGJfSwl/U1i3kUtyx5Mep4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEneJRg8+aK+50nafH/8X3ztDPv5lPFxp7JldIwTQmm8Ix9BrC4P5qoL2kdZsovd+1xvg3NXsHreE2E8TKbkc2uhhvibzZkIiAAUJZUiWjMYpXxJHU6Vd1/owDm1zr/4QUhkRuUSLJ7BDm8zNSff97I5cz4JSsFn8B6rvigg6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RpTeG0tB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D8EC433F1;
	Tue,  9 Apr 2024 19:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712692383;
	bh=XW+KtnYyyhPI+nxpRegjNzGJfSwl/U1i3kUtyx5Mep4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=RpTeG0tBEIJTjuIq17x1R8gEc3WgxT1hNqmB7Zw3BjUyT2D+jENR3b8PajOZ8tlvq
	 LrXaN0jRa4SWOhD7p5KWg5dFsuuDISROV6FSB8h2YtNG9D7foEXzGQS7YMP+efnKHV
	 d0gY80uakOeyivvOuh8gn/6hzrdoIln1QPoMOz5clJuE60IqajEMI7xSqclQJIe02X
	 isoNQS3iHjizmwUQyjNT9K9DT+bC6pJMU+dx6mR7cnYHq27h94LXXvMgdW3fpyFxCm
	 eHTuoQWHXQpxJTfrw8kBg1gFDevmYrEua/n0OkDi/BMTe0/0c60nDWv0He3hmf/8s3
	 74XYijkv+M+MA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 25223CE2D22; Tue,  9 Apr 2024 12:53:03 -0700 (PDT)
Date: Tue, 9 Apr 2024 12:53:03 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH 2/2] context_tracking, rcu: Rename RCU_DYNTICKS_IDX to
 CT_DYNTICKS_IDX
Message-ID: <1ef9d1f9-16a2-4ddc-abd5-6c3b7cde290f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240327112902.1184822-1-vschneid@redhat.com>
 <20240327112902.1184822-3-vschneid@redhat.com>
 <Zg6tYD-9AFPkOOsW@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zg6tYD-9AFPkOOsW@localhost.localdomain>

On Thu, Apr 04, 2024 at 03:38:40PM +0200, Frederic Weisbecker wrote:
> Le Wed, Mar 27, 2024 at 12:29:02PM +0100, Valentin Schneider a écrit :
> > The symbols relating to the CT_STATE part of context_tracking.state are now
> > all prefixed with CT_STATE.
> > 
> > The RCU dynticks counter part of that atomic variable still involves
> > symbols with different prefixes, align them all to be prefixed with
> > CT_DYNTICKS, as CT_DYNTICKS_MASK already is.
> > 
> > Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> 
> It used to be that RCU extended quiescent state and dynticks enter/exit
> were coupled. But this isn't the case anymore. Nowadays RCU stops watching
> some time later after dynticks is entered.

I knew that consolidation of atomic operations was too good to last...

> I wonder if we shouldn't take advantage of that cleanup for a meaning that
> really reflect that RCU stops watching from there.
> 
> Paul what do you think? CT_EQS_IDX ? CT_RCUEQS_IDX? CT_RCUOFF_IDX? ...?

"After what you just did?  You can just RCU off!!!"

Sorry, couldn't resist...

I am having a hard time getting too excited about the name.  I could
suggest CT_RCU_WATCHING_IDX, but that isn't exactly the shortest
possible name.

							Thanx, Paul

