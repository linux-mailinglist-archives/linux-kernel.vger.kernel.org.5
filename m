Return-Path: <linux-kernel+bounces-137387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 682CC89E156
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996051C22CDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AC6156866;
	Tue,  9 Apr 2024 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDHcMxhv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277A4156673;
	Tue,  9 Apr 2024 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682890; cv=none; b=ETAVrxv/fGpktR6Ehk9SyMfimKhVJkVlJasGjjObL6pnPN+/csqrA1TGrI4X2+7uQ7zJ7PWhchYqvaZUMW+IBu8Ko40hiypNdtH+HrnCouBhOqzGwFo+oLCux+kA3llINxIQ7k3F4XMxTLR0vtVXGUrrHmBpIrh70yYRD6P+vQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682890; c=relaxed/simple;
	bh=GkHJ9jo+Ci/4+KtYzx6R4BgUW5HeRJ7OAmzs+yMZfTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giEkFIIQYEP0TFUyYV1NFzt23Uv96GRVGGRQwmOP7JlUTzZ9Et9UoLJXnEIq8blRfZzsascHKkjcrgBy+lhxPFXyV/iKmL5CiDQqRhh+SwT6A2VVdcIopLg/IOCshO0nYTTybhoA4OurQ/Hnlie1TYtUVleHY3dwxT7lS0/9t2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDHcMxhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B222DC433C7;
	Tue,  9 Apr 2024 17:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712682889;
	bh=GkHJ9jo+Ci/4+KtYzx6R4BgUW5HeRJ7OAmzs+yMZfTk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EDHcMxhvkHhsLiQ/o6LfLrAa+JLTT99VaDpWNrtbGXIyxRfkAVQx12hQLehZtEVqU
	 HYWLw3H8NI/equst7byhpR+jeIHmHIqYdL9TZ+sF6bBjfZhrGiaA1dVPXXGZ1DOIql
	 jYUJvy9NNNisdvBDipknK6bzH5ThdHQ3nkdX+c5crKcM+UOqVtR5JstlABAQfRRgaw
	 W7lS24sy35iVOTnG8V0aUuIZSgNQ2SlRbLjrYKWr7LyB85kUfso31Fm9a3jMtikTUE
	 K8bxO4oPjrGjyNHr7wImL4lO0dJKRjRrH1fCUTiV1noD+lUrG3zePSYA0L+TO/jX8R
	 CFMDV2UucN2nA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5C91ECE074C; Tue,  9 Apr 2024 10:14:49 -0700 (PDT)
Date: Tue, 9 Apr 2024 10:14:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>, joel@joelfernandes.org,
	josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, neeraj.upadhyay@kernel.org
Subject: Re: [PATCH v2] rcu: Reduce synchronize_rcu() delays when all wait
 heads are in use
Message-ID: <01a8757a-1667-4b1d-817b-fa4a03f38f59@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240403105212.237354-1-Neeraj.Upadhyay@amd.com>
 <Zg8ezv2vzylVwg2q@pavilion.home>
 <0fae21aa-d9a1-48d1-85e1-ad746edae361@amd.com>
 <ZhUBGkcab10QM_uU@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhUBGkcab10QM_uU@pc636>

On Tue, Apr 09, 2024 at 10:49:30AM +0200, Uladzislau Rezki wrote:
> Hello, Neeraj, Frederic!
> 
> > 
> > On 4/5/2024 3:12 AM, Frederic Weisbecker wrote:
> > > Le Wed, Apr 03, 2024 at 04:22:12PM +0530, Neeraj Upadhyay a écrit :
> > >> When all wait heads are in use, which can happen when
> > >> rcu_sr_normal_gp_cleanup_work()'s callback processing
> > >> is slow, any new synchronize_rcu() user's rcu_synchronize
> > >> node's processing is deferred to future GP periods. This
> > >> can result in long list of synchronize_rcu() invocations
> > >> waiting for full grace period processing, which can delay
> > >> freeing of memory. Mitigate this problem by using first
> > >> node in the list as wait tail when all wait heads are in use.
> > >> While methods to speed up callback processing would be needed
> > >> to recover from this situation, allowing new nodes to complete
> > >> their grace period can help prevent delays due to a fixed
> > >> number of wait head nodes.
> > >>
> > >> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > > 
> > > Looking at it again, I'm not sure if it's a good idea to
> > > optimize the thing that far. It's already a tricky state machine
> > > to review and the workqueue has SR_NORMAL_GP_WAIT_HEAD_MAX - 1 = 4
> > > grace periods worth of time to execute. Such a tense situation may
> > > happen of course but, should we really work around that?
> > > 
> > > I let you guys judge. In the meantime, I haven't found correctness
> > 
> > I agree that this adds more complexity for handling a scenario
> > which is not expected to happen often. Also, this does not help
> > much to recover from the situation, as most of the callbacks are still
> > blocked on kworker execution. Intent was to keep the patch ready, in
> > case we see fixed SR_NORMAL_GP_WAIT_HEAD_MAX  as a blocking factor.
> > It's fine from my side if we want to hold off this one. Uladzislau
> > what do you think?
> > 
> I agree with Frederic and we discussed this patch with Neeraj! I think
> the state machine is a bit complex as of now. Let's hold off it so far.

There is always the next merge window, should it be required.

							Thanx, Paul

