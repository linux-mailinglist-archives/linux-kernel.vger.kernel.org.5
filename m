Return-Path: <linux-kernel+bounces-21555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6E7829116
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F089F284E4D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5951B3E494;
	Tue,  9 Jan 2024 23:57:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB95364B5;
	Tue,  9 Jan 2024 23:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B77C433F1;
	Tue,  9 Jan 2024 23:57:14 +0000 (UTC)
Date: Tue, 9 Jan 2024 18:58:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v10 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240109185813.5e071eab@gandalf.local.home>
In-Reply-To: <20240110084205.2943f88bf8b797b04297b0ae@kernel.org>
References: <20240105094729.2363579-1-vdonnefort@google.com>
	<20240105094729.2363579-2-vdonnefort@google.com>
	<20240109234230.e99da87104d58fee59ad75c6@kernel.org>
	<ZZ1ir0edlY3OzjyC@google.com>
	<20240110084205.2943f88bf8b797b04297b0ae@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jan 2024 08:42:05 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 9 Jan 2024 15:13:51 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > > @@ -388,6 +389,7 @@ struct rb_irq_work {
> > > >  	bool				waiters_pending;
> > > >  	bool				full_waiters_pending;
> > > >  	bool				wakeup_full;
> > > > +	bool				is_cpu_buffer;  
> > > 
> > > I think 'is_cpu_buffer' is a bit unclear (or generic),
> > > what about 'meta_page_update'?  
> > 
> > Hum not sure about that change. This was really to identify if parent of
> > rb_irq_work is a cpu_buffer or a trace_buffer. It can be a cpu_buffer regardless
> > of the need to update the meta-page.  
> 
> Yeah, I just meant that is "for_cpu_buffer", not "rb_irq_work is_cpu_buffer".
> So when reading the code, I just felt uncomfortable.
> 

How about "in_cpu_buffer" as that is what it is.

struct ring_buffer_per_cpu {
	struct rb_irq_work {
		bool	in_cpu_buffer;
	}
}

Would that make you feel more comfortable? ;-)

-- Steve


