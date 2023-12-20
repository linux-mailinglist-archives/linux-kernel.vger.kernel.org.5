Return-Path: <linux-kernel+bounces-7071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D17381A13F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6981C203F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96033D3BD;
	Wed, 20 Dec 2023 14:39:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BDF3D38D;
	Wed, 20 Dec 2023 14:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046A1C433C8;
	Wed, 20 Dec 2023 14:39:29 +0000 (UTC)
Date: Wed, 20 Dec 2023 09:40:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>, Kent Overstreet
 <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 03/15] ring-buffer: Add interface for configuring
 trace sub buffer size
Message-ID: <20231220094030.5d13438b@gandalf.local.home>
In-Reply-To: <20231220232619.67f0b175578d14f9341fb30c@kernel.org>
References: <20231219185414.474197117@goodmis.org>
	<20231219185628.298324722@goodmis.org>
	<20231220232619.67f0b175578d14f9341fb30c@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 23:26:19 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 19 Dec 2023 13:54:17 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > +/**
> > + * ring_buffer_subbuf_order_set - set the size of ring buffer sub page.
> > + * @buffer: The ring_buffer to set the new page size.
> > + * @order: Order of the system pages in one sub buffer page
> > + *
> > + * By default, one ring buffer pages equals to one system page. This API can be
> > + * used to set new size of the ring buffer page. The size must be order of
> > + * system page size, that's why the input parameter @order is the order of
> > + * system pages that are allocated for one ring buffer page:
> > + *  0 - 1 system page
> > + *  1 - 2 system pages
> > + *  3 - 4 system pages
> > + *  ...  
> 
> Don't we have the max order of the pages?

Actually there is. I think it's 7?

Honestly, anything over 5 is probably too much. But hey.

> 
> > + *
> > + * Returns 0 on success or < 0 in case of an error.
> > + */
> > +int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
> > +{
> > +	int psize;
> > +
> > +	if (!buffer || order < 0)
> > +		return -EINVAL;
> > +
> > +	if (buffer->subbuf_order == order)
> > +		return 0;
> > +
> > +	psize = (1 << order) * PAGE_SIZE;
> > +	if (psize <= BUF_PAGE_HDR_SIZE)
> > +		return -EINVAL;
> > +
> > +	buffer->subbuf_order = order;
> > +	buffer->subbuf_size = psize - BUF_PAGE_HDR_SIZE;
> > +
> > +	/* Todo: reset the buffer with the new page size */
> > +  
> 
> I just wonder why there is no reallocate the sub buffers here.
> Is it OK to change the sub buffer page size and order while
> using the ring buffer?

Currently we disable the ring buffer to do the update.

-- Steve


