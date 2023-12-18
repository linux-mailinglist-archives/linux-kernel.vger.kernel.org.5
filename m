Return-Path: <linux-kernel+bounces-4251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C80138179DE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750EB2850B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574121E529;
	Mon, 18 Dec 2023 18:41:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9741EB3F;
	Mon, 18 Dec 2023 18:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2BBC433C7;
	Mon, 18 Dec 2023 18:41:44 +0000 (UTC)
Date: Mon, 18 Dec 2023 13:42:40 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] ring-buffer: Replace rb_time_cmpxchg() with
 rb_time_cmp_and_update()
Message-ID: <20231218134240.4ed0ecbd@gandalf.local.home>
In-Reply-To: <20231218101531.63d138df@gandalf.local.home>
References: <20231215165512.280088765@goodmis.org>
	<20231215165628.096822746@goodmis.org>
	<20231218232455.03aa6506f855109476e34212@kernel.org>
	<20231218101531.63d138df@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 10:15:31 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Basically I broke it into:
> 
> 1. Remove workaround exposure from the main logic. (this patch)
> 2. Remove the workaround. (next patch).
> 
> > 
> > Isn't this part actual change?  
> 
> This part is abstracted out from the main logic. Which is why I made this
> patch.
> 
> >   
> > >  static bool rb_time_cmp_and_update(rb_time_t *t, u64 expect, u64 set)
> > >  {
> > > -	return rb_time_cmpxchg(t, expect, set);
> > > +#ifdef RB_TIME_32
> > > +	return expect == READ_ONCE(t->time);  
> 
> And I need to make a v2 as the above is wrong. It should have been:
> 
> 	return expect == local64_read(&t->time);


My v2 version will also make 64 bit not guaranteed to update on return of
true. Which adds even more reason to separate out the two.

-- Steve

