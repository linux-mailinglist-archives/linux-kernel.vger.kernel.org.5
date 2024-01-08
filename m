Return-Path: <linux-kernel+bounces-20143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CD2827A82
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEE92823AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B666A56466;
	Mon,  8 Jan 2024 22:12:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FA355776;
	Mon,  8 Jan 2024 22:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3031CC433C7;
	Mon,  8 Jan 2024 22:12:16 +0000 (UTC)
Date: Mon, 8 Jan 2024 17:13:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing user_events: Simplify user_event_parse_field()
 parsing
Message-ID: <20240108171312.475190cf@gandalf.local.home>
In-Reply-To: <20240108214744.GA100-beaub@linux.microsoft.com>
References: <20240108133723.031cf322@gandalf.local.home>
	<20240108214744.GA100-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jan 2024 21:47:44 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> > -	len = str_has_prefix(field, "__rel_loc ");
> > -	if (len)
> > -		goto skip_next;
> > +	if (!(len = str_has_prefix(field, "__data_loc unsigned ")) &&
> > +	    !(len = str_has_prefix(field, "__data_loc ")) &&
> > +	    !(len = str_has_prefix(field, "__rel_loc unsigned ")) &&
> > +	    !(len = str_has_prefix(field, "__rel_loc "))) {
> > +		goto parse;
> > +	}  
> 
> This now triggers a checkpatch error:
> ERROR: do not use assignment in if condition

What a horrible message.

> #1184: FILE: kernel/trace/trace_events_user.c:1184:
> +       if (!(len = str_has_prefix(field, "__data_loc unsigned ")) &&
> 
> I personally prefer to keep these files fully checkpatch clean.

I've stopped using checkpatch years ago because I disagreed with so much it :-p
  (Including this message)

> However, I did test these changes under the self-tests and it passed.
> 
> Do they bug you that much? :)

No big deal if you prefer the other way. I was just doing an audit of
str_has_prefix() to see what code could be cleaned up that uses it, and I
found this code.

If you prefer to limit your code to "checkpatch clean", I'll leave it alone.

-- Steve

