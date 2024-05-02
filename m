Return-Path: <linux-kernel+bounces-166941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A84F8BA257
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1281F24ED4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 21:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCD4181BB2;
	Thu,  2 May 2024 21:30:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA83A15B971;
	Thu,  2 May 2024 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714685415; cv=none; b=Ayp9VkcJdk25x0R+U42DtsLN5du1l/ky1l47NLw+yzrAfZM3LnfIxKqL+y/rSQKrThicp4u8fuQGp1QbzFvw4i2ZRrsmhVhdMTfoxKnLdd3VtLZyysVWW7v2pKNXYiCnP0ihRsyF+2KKMtPNwGUG8dj5MOKPzv7+xTpHloWnbKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714685415; c=relaxed/simple;
	bh=bcr0gKy5E9J7hxWXCHjgabXQssBB8UXIM4ou5rtgVsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQ8QEIJWYVYopV85V//k5v06TNWhesruEd1GcvyOCgVlKAZewJ6yAw9DGvppYia2eBuCwsKfHK8f7EvlBP2w6sZ3FkP6osVTmDW+0XX5fmCG/owKVuz7LDMxk1I75teFZue64AMKPwKllnVel83eC2+PU4wi83MUXxHd0VQAsfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668AAC4AF14;
	Thu,  2 May 2024 21:30:14 +0000 (UTC)
Date: Thu, 2 May 2024 17:31:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kuba@kernel.org, ast@kernel.org,
 clm@fb.com, mark.rutland@arm.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH resend ftrace] Asynchronous grace period for
 register_ftrace_direct()
Message-ID: <20240502173100.42c8a3f7@gandalf.local.home>
In-Reply-To: <82ae8a24-f9cf-4730-b0d7-43fb3bca2917@paulmck-laptop>
References: <ac05be77-2972-475b-9b57-56bef15aa00a@paulmck-laptop>
	<20240502110501.772941f7fdbc1650a9a3bea4@kernel.org>
	<82ae8a24-f9cf-4730-b0d7-43fb3bca2917@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 May 2024 20:31:06 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Thu, May 02, 2024 at 11:05:01AM +0900, Masami Hiramatsu wrote:
> > On Wed, 1 May 2024 16:12:37 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >   
> > > Note that the immediate pressure for this patch should be relieved by the
> > > NAPI patch series [1], but this sort of problem could easily arise again.
> > > 
> > > When running heavy test workloads with KASAN enabled, RCU Tasks grace
> > > periods can extend for many tens of seconds, significantly slowing
> > > trace registration.  Therefore, make the registration-side RCU Tasks
> > > grace period be asynchronous via call_rcu_tasks().  
> > 
> > Good catch! AFAICS, there is no reason to wait for synchronization
> > when adding a new direct trampoline.
> > This looks good to me.
> > 
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>  
> 
> Thank you very much!  I will apply this on my next rebase.

I can take it.

It's not a bug fix but just an performance improvement, so it can go into
the next merge window.

-- Steve



> 
> > Thank you,
> >   
> > > [1]
> > > https://lore.kernel.org/all/cover.1710877680.git.yan@cloudflare.com/
> > > 
> > > Reported-by: Jakub Kicinski <kuba@kernel.org>
> > > Reported-by: Alexei Starovoitov <ast@kernel.org>
> > > Reported-by: Chris Mason <clm@fb.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > Cc: <linux-trace-kernel@vger.kernel.org>
> > > 
> > > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > > index 6c96b30f3d63b..32ea92934268c 100644
> > > --- a/kernel/trace/ftrace.c
> > > +++ b/kernel/trace/ftrace.c
> > > @@ -5365,6 +5365,13 @@ static void
> > > remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long }
> > >  }
> > >  
> > > +static void register_ftrace_direct_cb(struct rcu_head *rhp)
> > > +{
> > > +	struct ftrace_hash *fhp = container_of(rhp, struct
> > > ftrace_hash, rcu); +
> > > +	free_ftrace_hash(fhp);
> > > +}
> > > +
> > >  /**
> > >   * register_ftrace_direct - Call a custom trampoline directly
> > >   * for multiple functions registered in @ops
> > > @@ -5463,10 +5470,8 @@ int register_ftrace_direct(struct ftrace_ops
> > > *ops, unsigned long addr) out_unlock:
> > >  	mutex_unlock(&direct_mutex);
> > >  
> > > -	if (free_hash && free_hash != EMPTY_HASH) {
> > > -		synchronize_rcu_tasks();
> > > -		free_ftrace_hash(free_hash);
> > > -	}
> > > +	if (free_hash && free_hash != EMPTY_HASH)
> > > +		call_rcu_tasks(&free_hash->rcu,
> > > register_ftrace_direct_cb); 
> > >  	if (new_hash)
> > >  		free_ftrace_hash(new_hash);  
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>  


