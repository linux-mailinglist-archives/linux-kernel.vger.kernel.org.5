Return-Path: <linux-kernel+bounces-17091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32162824826
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A065128734F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7352428E08;
	Thu,  4 Jan 2024 18:27:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C9728DDA;
	Thu,  4 Jan 2024 18:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D712CC433C8;
	Thu,  4 Jan 2024 18:27:44 +0000 (UTC)
Date: Thu, 4 Jan 2024 13:28:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v9 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240104132850.061620d7@gandalf.local.home>
In-Reply-To: <20231221125813.673293a2@gandalf.local.home>
References: <20231221173523.3015715-1-vdonnefort@google.com>
	<20231221173523.3015715-2-vdonnefort@google.com>
	<20231221125813.673293a2@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 12:58:13 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 21 Dec 2023 17:35:22 +0000
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > @@ -5999,6 +6078,307 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
> >  }
> >  EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
> >    
> 
> The kernel developers have agreed to allow loop variables to be declared in
> loops. This will simplify these macros:
> 
> 
> 
> > +#define subbuf_page(off, start) \
> > +	virt_to_page((void *)(start + (off << PAGE_SHIFT)))
> > +
> > +#define foreach_subbuf_page(off, sub_order, start, page)	\
> > +	for (off = 0, page = subbuf_page(0, start);		\
> > +	     off < (1 << sub_order);				\
> > +	     off++, page = subbuf_page(off, start))  
> 
> #define foreach_subbuf_page(sub_order, start, page)		\
> 	for (int __off = 0, page = subbuf_page(0, (start));	\
> 	     __off < (1 << (sub_order));			\
> 	     __off++, page = subbuf_page(__off, (start)))

So it seems that you can't declare "int __off" with page there, but we
could have:

#define foreach_subbuf_page(sub_order, start, page)		\
	page = subbuf_page(0, (start));				\
	for (int __off = 0; __off < (1 << (sub_order));		\
	     __off++, page = subbuf_page(__off, (start)))


And that would work.

-- Steve

