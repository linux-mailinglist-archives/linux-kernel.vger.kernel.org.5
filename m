Return-Path: <linux-kernel+bounces-3905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C39768174FB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 786BF1F2488D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F87842379;
	Mon, 18 Dec 2023 15:14:37 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E835B3D540;
	Mon, 18 Dec 2023 15:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D92AC433C7;
	Mon, 18 Dec 2023 15:14:35 +0000 (UTC)
Date: Mon, 18 Dec 2023 10:15:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] ring-buffer: Replace rb_time_cmpxchg() with
 rb_time_cmp_and_update()
Message-ID: <20231218101531.63d138df@gandalf.local.home>
In-Reply-To: <20231218232455.03aa6506f855109476e34212@kernel.org>
References: <20231215165512.280088765@goodmis.org>
	<20231215165628.096822746@goodmis.org>
	<20231218232455.03aa6506f855109476e34212@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 23:24:55 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Fri, 15 Dec 2023 11:55:13 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > There's only one place that performs a 64-bit cmpxchg for the timestamp
> > processing. The cmpxchg is only to set the write_stamp equal to the
> > before_stamp, and if it doesn't get set, then the next event will simply
> > be forced to add an absolute timestamp.
> > 
> > Given that 64-bit cmpxchg is expensive on 32-bit, and the current
> > workaround uses 3 consecutive 32-bit cmpxchg doesn't make it any faster.
> > It's best to just not do the cmpxchg as a simple compare works for the
> > accuracy of the timestamp. The only thing that will happen without the
> > cmpxchg is the prepended absolute timestamp on the next event which is not
> > that big of a deal as the path where this happens is seldom hit because it
> > requires an interrupt to happen between a few lines of code that also
> > writes an event into the same buffer.
> > 
> > With this change, the 32-bit rb_time_t workaround can be removed.
> >   
> 
> Hmm, but this patch itself is just moving rb_time_cmpxchg() in the new
> rb_time_cmp_and_update() function. The actual change has been done
> in the next patch.

Exactly. Which is why I said above "with this change, the 32-bit rb_time_t
workaround can be removed". It can't be removed without this change.

> I think there is no reason to split this from the
> second one...

I originally had it as one patch, but I disliked the removal of the
workaround touching the main logic code (which this patch does).

Basically I broke it into:

1. Remove workaround exposure from the main logic. (this patch)
2. Remove the workaround. (next patch).

> 
> Isn't this part actual change?

This part is abstracted out from the main logic. Which is why I made this
patch.

> 
> >  static bool rb_time_cmp_and_update(rb_time_t *t, u64 expect, u64 set)
> >  {
> > -	return rb_time_cmpxchg(t, expect, set);
> > +#ifdef RB_TIME_32
> > +	return expect == READ_ONCE(t->time);

And I need to make a v2 as the above is wrong. It should have been:

	return expect == local64_read(&t->time);

-- Steve


> > +#else
> > +	return local64_try_cmpxchg(&t->time, &expect, set);
> > +#endif
> >  }  

