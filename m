Return-Path: <linux-kernel+bounces-127060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6888F894650
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3291C21843
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D7E53E1E;
	Mon,  1 Apr 2024 20:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeqgudmR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E7446AC;
	Mon,  1 Apr 2024 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712004895; cv=none; b=B/AI2Jmqc6BdXdmWGuHZ6MGnBayRftrINybuq8mOMt0U8LpcTboHIpxU15HXWBDNIQu7Bi38gbl+Lh2TDd1PqIfTYtYI2w2DIqaslSSUQOTcLidAiC4rRGECp3sHXJIoTPDiwjG0ReibcAPhf7hDgc7vGHQRyVAbJ65mw0rl3RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712004895; c=relaxed/simple;
	bh=E9JguHsNU7j/kgZImtaedh14tO/jXcIwFQ8OvqxXEMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYcJRkBfFU/zbmCyP2LnUwmkrpUNXs5wbIjq9LIvbnhAY8kJj/a2orJsC60NdtH5cVNL3I/f9Vc0nvdCM9e4tss4SE5keBV6Mkx02pGMMLKQGqAn/EJZ2+OhqO9VafM+mCkc+69X66U7IkiZQgnFdVG8/xkadJqjvoxclzy2hLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeqgudmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9BDC433C7;
	Mon,  1 Apr 2024 20:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712004894;
	bh=E9JguHsNU7j/kgZImtaedh14tO/jXcIwFQ8OvqxXEMo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JeqgudmRo7/gPc1ODNHJbwBAmGbRcvUJ4fwbQj/ohC7zL0pKEzP6e16Uuj2I1G1Tz
	 IWQ/qk+RrjAXuIebyrlvOl44eJ80RtW74kTN9tBZJLbtZyC7S7J2LKSG4+fF4z5beT
	 OaxtD/YNpgzT6DDAr2ofhwkzgf2xQ2ekQNYaCa4Mm1pIGoD1Wed2faRK+E1Wm0lbI3
	 Ftg22RUDiQq/Gt1qFnzvU+bRhf1DIVNxS0rN6u/pvyN/046YpEqnKwTetnOi7sVxkf
	 z8gXSEUrxj7G2jGpFWb8a3XFLeWBZ8FKjlusFsFjS3pcPZlphx2uuJ8B40lISEdS0i
	 myO69AMiYDCjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 18871CE0738; Mon,  1 Apr 2024 13:54:54 -0700 (PDT)
Date: Mon, 1 Apr 2024 13:54:54 -0700
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
Subject: Re: [PATCH v3] rcu: Fix buffer overlow in print_cpu_stall_info()
Message-ID: <e8d0f4da-d3af-4bf2-9413-ac48bd2661d7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240401150540.6dab14fc@gandalf.local.home>
 <20240401194315.362090-1-kiryushin@ancud.ru>
 <20240401160312.7b03e568@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401160312.7b03e568@gandalf.local.home>

On Mon, Apr 01, 2024 at 04:03:12PM -0400, Steven Rostedt wrote:
> On Mon,  1 Apr 2024 22:43:15 +0300
> Nikita Kiryushin <kiryushin@ancud.ru> wrote:
> 
> > rcuc info output in print_cpu_stall_info() contains
> > posiible buffer overflow in the case of huge jiffies
> > difference. The situation seems improbable, but, buffer
> > overflow, still.
> > 
> > Also, unsigned jiffies difference printed as (signed)
> > %ld. This is intentional for debugging purposes, but
> > it is not obvious from the code.
> > 
> > Change sprintf to snprintf and add clarifying comment
> > about intention of %ld format.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: 245a62982502 ("rcu: Dump rcuc kthread status for CPUs not reporting quiescent state")
> > Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> > ---
> > v3: Change intention comment wording as
> > Steven Rostedt <rostedt@goodmis.org> suggested
> > v2: Remove signed to unsigned print format change as
> > Paul E. McKenney <paulmck@kernel.org> suggested, add format
> > intention clarification comment
> >  kernel/rcu/tree_stall.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > index 5d666428546b..320440b8384e 100644
> > --- a/kernel/rcu/tree_stall.h
> > +++ b/kernel/rcu/tree_stall.h
> > @@ -504,7 +504,8 @@ static void print_cpu_stall_info(int cpu)
> >  			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
> >  	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
> >  	if (rcuc_starved)
> > -		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
> > +		/* Print signed value, as negative means it is likely a bug */
> > +		snprintf(buf, sizeof(buf), " rcuc=%ld jiffies(starved)", j);
> >  	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%04x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
> >  	       cpu,
> >  	       "O."[!!cpu_online(cpu)],
> 
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Queued for v6.10, thank you both!

							Thanx, Paul

