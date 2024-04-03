Return-Path: <linux-kernel+bounces-130524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5AD89796B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C4D286BB8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7B01553B5;
	Wed,  3 Apr 2024 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKk5vsaL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4FD15539B;
	Wed,  3 Apr 2024 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174297; cv=none; b=qAZubBKyNxfK/7CWjT5sz59/IbI0u5Gm3w4iH+8kTA2j0qwW7FnMQ6X+9UyyrE6/Dw/13lcjbIXCIoXMdOXD6bJN4fOooci37nDu0qLgJjle8cZhz/KpRxHQa0i+BUHeXcBxowshcjia6ta6MBbSRYmW8eZx5sfC/HX9NQBzkjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174297; c=relaxed/simple;
	bh=hf4KgJLDDHiJkfJJRgfbtMzcLNXDxUFHuHYKNKAixKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxk33sgDXoYnce/C9e2aYkHHHI8IgbSYfk2bzPB9vTdAarBB0rPduNroYK/hgNhbedp/Gq7ia6mYDazyI07IwdSJA3B+Y7DDISRxzsHSQkLt3aEldFnxiHG7D2FKe32yWo2dp7z/iUiZh3VOpzHM+NoD8mI+am6cfWDJP0fqAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKk5vsaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D68C43390;
	Wed,  3 Apr 2024 19:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712174296;
	bh=hf4KgJLDDHiJkfJJRgfbtMzcLNXDxUFHuHYKNKAixKI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KKk5vsaLBfjvXqmkrZZxnvUDD9gjp5BQliOldUEMX2R+csPXjytY1xH3/WY9B9II5
	 5XNsNY+yeIIJZ/TX7Lc9ditkDhl2UuM2deQfLoQz4vxV3ZAHZgjKJi+d3IdfwErYIV
	 wRCrosuGAg3RuPTm0aikY+v6gVHAhfx9tvSfqC24w1eLx1glEZNElsq0xZVQSjhSkt
	 SwIm5NntKcT78FGHPrqOqnOwnLZtaqaIytuAAZFwHT0snCbBNBdBBiPxsY2jiMlxK3
	 GFWAaZMFApQz/9Vch1/jvCGJMzSsZifcTodv1V9a5cEl32rsBja2AnvCbKOpmZPkfF
	 3wMZ28wgH9mkQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5D790CE0D85; Wed,  3 Apr 2024 12:58:16 -0700 (PDT)
Date: Wed, 3 Apr 2024 12:58:16 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Chris Mason <clm@fb.com>
Subject: Re: [PATCH RFC ftrace] Asynchronous grace period for
 register_ftrace_direct()
Message-ID: <ec30815d-22c0-4a65-9b55-f9e10781d5b2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <7ed089be-c0c6-43b5-849a-05599cb32cfd@paulmck-laptop>
 <20240403152912.7f03c6db@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403152912.7f03c6db@gandalf.local.home>

On Wed, Apr 03, 2024 at 03:29:12PM -0400, Steven Rostedt wrote:
> On Wed, 3 Apr 2024 11:53:14 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > @@ -5366,6 +5366,13 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
> >  	}
> >  }
> >  
> > +static void register_ftrace_direct_cb(struct rcu_head *rhp)
> > +{
> > +	struct ftrace_hash *fhp = container_of(rhp, struct ftrace_hash, rcu);
> > +
> > +	free_ftrace_hash(fhp);
> > +}
> > +
> >  /**
> >   * register_ftrace_direct - Call a custom trampoline directly
> >   * for multiple functions registered in @ops
> > @@ -5464,10 +5471,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >   out_unlock:
> >  	mutex_unlock(&direct_mutex);
> >  
> > -	if (free_hash && free_hash != EMPTY_HASH) {
> > -		synchronize_rcu_tasks();
> > -		free_ftrace_hash(free_hash);
> > -	}
> > +	if (free_hash && free_hash != EMPTY_HASH)
> > +		call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);
> >  
> >  	if (new_hash)
> >  		free_ftrace_hash(new_hash);
> 
> I'm getting ready to go on PTO, but a quick glance doesn't look like this
> would cause any harm.

It is not urgent, as in v6.10 merge window at the earliest.  So if I
don't hear from you in a few weeks, I will re-send.  ;-)

							Thanx, Paul

