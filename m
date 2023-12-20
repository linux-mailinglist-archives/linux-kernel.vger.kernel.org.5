Return-Path: <linux-kernel+bounces-6927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B075819F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA4A1F21898
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F3D25558;
	Wed, 20 Dec 2023 13:00:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417C425541;
	Wed, 20 Dec 2023 13:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EAAC433C8;
	Wed, 20 Dec 2023 13:00:28 +0000 (UTC)
Date: Wed, 20 Dec 2023 08:01:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Tzvetomir Stoyanov
 <tz.stoyanov@gmail.com>, Vincent Donnefort <vdonnefort@google.com>, "Kent
 Overstreet" <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 02/15] ring-buffer: Page size per ring buffer
Message-ID: <20231220080129.3453bca8@gandalf.local.home>
In-Reply-To: <84d3b41a72bd43dbb9d44921ef535c92@AcuMS.aculab.com>
References: <20231219185414.474197117@goodmis.org>
	<20231219185628.009147038@goodmis.org>
	<84d3b41a72bd43dbb9d44921ef535c92@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 08:48:02 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Steven Rostedt
> > Sent: 19 December 2023 18:54
> > From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
> > 
> > Currently the size of one sub buffer page is global for all buffers and
> > it is hard coded to one system page. In order to introduce configurable
> > ring buffer sub page size, the internal logic should be refactored to
> > work with sub page size per ring buffer.
> >   
> ...
> > -	nr_pages = DIV_ROUND_UP(size, BUF_PAGE_SIZE);
> > +	/* Default buffer page size - one system page */
> > +	buffer->subbuf_size = PAGE_SIZE - BUF_PAGE_HDR_SIZE;
> > +
> > +	/* Max payload is buffer page size - header (8bytes) */
> > +	buffer->max_data_size = buffer->subbuf_size - (sizeof(u32) * 2);
> > +
> > +	nr_pages = DIV_ROUND_UP(size, buffer->subbuf_size);  
> 
> While not new, does this really make any sense for systems with 64k pages?
> Wouldn't it be better to have units of 4k?

Unfortunately, it has to be PAGE_SIZE (and for now it's a power of 2 to
make masking easy). It's used for splice and will also be used for memory
mapping with user space.

> 
> ...
> > @@ -5102,14 +5110,14 @@ unsigned long ring_buffer_size(struct trace_buffer *buffer, int cpu)
> >  {
> >  	/*
> >  	 * Earlier, this method returned
> > -	 *	BUF_PAGE_SIZE * buffer->nr_pages
> > +	 *	buffer->subbuf_size * buffer->nr_pages
> >  	 * Since the nr_pages field is now removed, we have converted this to
> >  	 * return the per cpu buffer value.  
> 
> Overenthusiastic global replace...

Possibly, but the comment still applies, and should probably be removed, as
it's rather old (2012). It's basically just saying that the size use to be
calculated from buffer->nr_pages and now it's calculated by
buffer->buffers[cpu]->nr_pages.

I think I'll just add a patch to remove that comment.

Thanks,

-- Steve

