Return-Path: <linux-kernel+bounces-167049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1054D8BA3DD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D061C2302C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E0D1CD2A;
	Thu,  2 May 2024 23:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5ndd+Jw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6895C57C8D;
	Thu,  2 May 2024 23:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691640; cv=none; b=Nomv8Nzsh9X9qYuIdEAh8uTxYx93xMCeXrqCPmI4jM5IUYlAM5xqcBGmthOqvifMwfk656tt0m5ZoLSmK6nGmSIeBCNX3WdHFgeSJO0mdIOMyIQNCoCc+1rYfHt/kEi76usjSQ9yIN5G/NekxtnqhwFhgKJRumgGxkFzHppyTWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691640; c=relaxed/simple;
	bh=wiCkGMkZFCPY7COhhD+uOxIgwVixxh6eb67wr+gtu7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1cdA/fCSBjGeLoAybvkMP6IhXP8j3J1OtTFPwutMDoKxoYLOwPFkNDjSan7fDy+3KGxiXRL6C3PyyBzTpgI3krgJY1e7XXycHzWJ98eKSREWDwkGuTCtMF2e8kQBJdfeoFqM2Kejexg23HQINg0bmCzRqMjqoEvGeHqRIsKAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5ndd+Jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A6EC113CC;
	Thu,  2 May 2024 23:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714691640;
	bh=wiCkGMkZFCPY7COhhD+uOxIgwVixxh6eb67wr+gtu7w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=q5ndd+JwBcbC6EKT0ZPbC5WvglT2Pwi44cxl+JNRKy9OqcsiSJaaLjwyAk+BgRriZ
	 GHZZawpoiLGRwS6W1lp3mEoyHl2OtDmyVlMD2Pt3mEqlZg0vU8ZPiyDgy0rgsqiE4k
	 2Qpb8+c6L8+8NUsSWGll422q/4DWNgJJ1kNeJcT0vHCEdLPG+q0oLQQRCv6h1Fbwm3
	 38WmU8utWI2LsIGIBIivXqBC+Ddw0LJpFnCobDbX3bYjWzlPyRB4l6r/7V/ir+zQTJ
	 0oe06PII+JaMaOJ4196VygiDipZ7FFkBRl4E/vzmVT7dthtDVqVbeE9wK4Qy2koRYY
	 b0hTZeBEgpjYw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AA906CE0991; Thu,  2 May 2024 16:13:59 -0700 (PDT)
Date: Thu, 2 May 2024 16:13:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kuba@kernel.org, ast@kernel.org,
	clm@fb.com, mark.rutland@arm.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH resend ftrace] Asynchronous grace period for
 register_ftrace_direct()
Message-ID: <135a21d0-1622-418a-b49f-8338a4230ff4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ac05be77-2972-475b-9b57-56bef15aa00a@paulmck-laptop>
 <20240502110501.772941f7fdbc1650a9a3bea4@kernel.org>
 <82ae8a24-f9cf-4730-b0d7-43fb3bca2917@paulmck-laptop>
 <20240502173100.42c8a3f7@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502173100.42c8a3f7@gandalf.local.home>

On Thu, May 02, 2024 at 05:31:00PM -0400, Steven Rostedt wrote:
> On Wed, 1 May 2024 20:31:06 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Thu, May 02, 2024 at 11:05:01AM +0900, Masami Hiramatsu wrote:
> > > On Wed, 1 May 2024 16:12:37 -0700
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > >   
> > > > Note that the immediate pressure for this patch should be relieved by the
> > > > NAPI patch series [1], but this sort of problem could easily arise again.
> > > > 
> > > > When running heavy test workloads with KASAN enabled, RCU Tasks grace
> > > > periods can extend for many tens of seconds, significantly slowing
> > > > trace registration.  Therefore, make the registration-side RCU Tasks
> > > > grace period be asynchronous via call_rcu_tasks().  
> > > 
> > > Good catch! AFAICS, there is no reason to wait for synchronization
> > > when adding a new direct trampoline.
> > > This looks good to me.
> > > 
> > > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>  
> > 
> > Thank you very much!  I will apply this on my next rebase.
> 
> I can take it.
> 
> It's not a bug fix but just an performance improvement, so it can go into
> the next merge window.

Very good, and thank you!

I will drop it from RCU as soon as it shows up in either -next or in
mainline.

							Thanx, Paul

> -- Steve
> 
> 
> 
> > 
> > > Thank you,
> > >   
> > > > [1]
> > > > https://lore.kernel.org/all/cover.1710877680.git.yan@cloudflare.com/
> > > > 
> > > > Reported-by: Jakub Kicinski <kuba@kernel.org>
> > > > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > > > Reported-by: Chris Mason <clm@fb.com>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > Cc: <linux-trace-kernel@vger.kernel.org>
> > > > 
> > > > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > > > index 6c96b30f3d63b..32ea92934268c 100644
> > > > --- a/kernel/trace/ftrace.c
> > > > +++ b/kernel/trace/ftrace.c
> > > > @@ -5365,6 +5365,13 @@ static void
> > > > remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long }
> > > >  }
> > > >  
> > > > +static void register_ftrace_direct_cb(struct rcu_head *rhp)
> > > > +{
> > > > +	struct ftrace_hash *fhp = container_of(rhp, struct
> > > > ftrace_hash, rcu); +
> > > > +	free_ftrace_hash(fhp);
> > > > +}
> > > > +
> > > >  /**
> > > >   * register_ftrace_direct - Call a custom trampoline directly
> > > >   * for multiple functions registered in @ops
> > > > @@ -5463,10 +5470,8 @@ int register_ftrace_direct(struct ftrace_ops
> > > > *ops, unsigned long addr) out_unlock:
> > > >  	mutex_unlock(&direct_mutex);
> > > >  
> > > > -	if (free_hash && free_hash != EMPTY_HASH) {
> > > > -		synchronize_rcu_tasks();
> > > > -		free_ftrace_hash(free_hash);
> > > > -	}
> > > > +	if (free_hash && free_hash != EMPTY_HASH)
> > > > +		call_rcu_tasks(&free_hash->rcu,
> > > > register_ftrace_direct_cb); 
> > > >  	if (new_hash)
> > > >  		free_ftrace_hash(new_hash);  
> > > 
> > > 
> > > -- 
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>  
> 

