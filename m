Return-Path: <linux-kernel+bounces-121829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E3688EE49
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEC7294DB6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799BD14F12A;
	Wed, 27 Mar 2024 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGCb8wxt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B61DDC5;
	Wed, 27 Mar 2024 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564262; cv=none; b=lXhpzik7AAw9ytAE0ahhbMgUEGHKJNNDoNufMr6UKLUki0CaDpLw2SutBCC9+R43PaJ9/+DzFlGqV67jDyBfkoD6Tl3YDEGOfIZ3QMg6xbV8/ldnRdKjgzd6b65r+JXKeKY+tSSv84QUmI4S1KQw1rv0JJs3LdKhXHigj+8fy+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564262; c=relaxed/simple;
	bh=KIaSMUnW8rnBI0ZsI+wibi1QfFtAfAE6yQr36OYF10g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxsVlGGwRQIYRJ/Srvk/+Sk1yNs08LHulGSCYsdybx808awX5OmktemhU+0ZfGcg5Evzf6wRIaoWZmIAKbs3UhMyeUQ+hMpusirc6kmy+6fjjDjbJ9I+v+Uyd5RfzNQ4+26AAzngg1oHTwUVL2zWaAe/40+r2s3rknyibLoMpxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGCb8wxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ECFC433C7;
	Wed, 27 Mar 2024 18:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711564262;
	bh=KIaSMUnW8rnBI0ZsI+wibi1QfFtAfAE6yQr36OYF10g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=XGCb8wxtLQ6y/bMpoHSbYA3F63dRC7ZDp5r+YYijYSbfwiahowf5EY6l2Vls5k0E0
	 6orcNieM1xvgbnogAcO+xCj0AIASE1sPHZljzRmLEOyo+P+DJqAK4DMHbrJiO7d9TL
	 wfYy639xHhO9Jh/XJW6QxvNnQ/lPztfMgaNubL39IKIznPuP8kbyQPkvGVYx8H0tZN
	 iFi8FaNMQ4DLPj4+D9PxiYEUMvhg8j1ZVt4Yzf3q6UbNWd5sJ8tuL8e3MWUJ+SWC6J
	 VCFgiAvX6A4HkQGMem4BA/eF1N3ICBJXX+d+wCz7pD1dq4jlTPKConrZX2+GfrW0VV
	 cWM96I1pdeDOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BC4EFCE0D67; Wed, 27 Mar 2024 11:31:01 -0700 (PDT)
Date: Wed, 27 Mar 2024 11:31:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Nikita Kiryushin <kiryushin@ancud.ru>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v4] rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer
 overflow
Message-ID: <608b2ed9-a7fa-482d-b1e5-e5c2ad5849c7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240327125132.600d62a3@gandalf.local.home>
 <20240327174747.612002-1-kiryushin@ancud.ru>
 <20240327135246.54cdb58e@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327135246.54cdb58e@gandalf.local.home>

On Wed, Mar 27, 2024 at 01:52:46PM -0400, Steven Rostedt wrote:
> On Wed, 27 Mar 2024 20:47:47 +0300
> Nikita Kiryushin <kiryushin@ancud.ru> wrote:
> 
> > There is a possibility of buffer overflow in
> > show_rcu_tasks_trace_gp_kthread() if counters, passed
> > to sprintf() are huge. Counter numbers, needed for this
> > are unrealistically high, but buffer overflow is still
> > possible.
> > 
> > Use snprintf() with buffer size instead of sprintf().
> > 
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Queued and pushed, thank you both!

							Thanx, Paul

> -- Steve
> 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: edf3775f0ad6 ("rcu-tasks: Add count for idle tasks on offline CPUs")
> > Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> > ---
> > v4: Change ARRAY_SIZE to sizeof() as more idiomatic
> > as Steven Rostedt <rostedt@goodmis.org> suggested
> > v3: Fixed commit message
> > v2: Use snprintf() as
> > Steven Rostedt <rostedt@goodmis.org> suggested.
> >  kernel/rcu/tasks.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 147b5945d67a..2a453de9f3d9 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -1994,7 +1994,7 @@ void show_rcu_tasks_trace_gp_kthread(void)
> >  {
> >  	char buf[64];
> >  
> > -	sprintf(buf, "N%lu h:%lu/%lu/%lu",
> > +	snprintf(buf, sizeof(buf), "N%lu h:%lu/%lu/%lu",
> >  		data_race(n_trc_holdouts),
> >  		data_race(n_heavy_reader_ofl_updates),
> >  		data_race(n_heavy_reader_updates),
> 

