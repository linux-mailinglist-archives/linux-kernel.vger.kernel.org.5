Return-Path: <linux-kernel+bounces-26227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A5B82DD0C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5824EB2214B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1563F179BE;
	Mon, 15 Jan 2024 16:09:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B0E1799A;
	Mon, 15 Jan 2024 16:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F60BC433C7;
	Mon, 15 Jan 2024 16:09:40 +0000 (UTC)
Date: Mon, 15 Jan 2024 11:09:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v11 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240115110938.613380ca@rorschach.local.home>
In-Reply-To: <ZaVRO76JxaHjPwCi@google.com>
References: <20240111161712.1480333-1-vdonnefort@google.com>
	<20240111161712.1480333-3-vdonnefort@google.com>
	<20240115134303.1a673e37b8e7d35a33d8df52@kernel.org>
	<ZaVRO76JxaHjPwCi@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jan 2024 15:37:31 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> > > @@ -5418,6 +5446,11 @@ int ring_buffer_swap_cpu(struct trace_buffer *buffer_a,
> > >  	cpu_buffer_a = buffer_a->buffers[cpu];
> > >  	cpu_buffer_b = buffer_b->buffers[cpu];
> > >  
> > > +	if (READ_ONCE(cpu_buffer_a->mapped) || READ_ONCE(cpu_buffer_b->mapped)) {
> > > +		ret = -EBUSY;
> > > +		goto out;
> > > +	}  
> > 
> > Ah, this is not enough to stop snapshot. update_max_tr()@kernel/trace/trace.c
> > is used for swapping all CPU buffer and it does not use this function.
> > (but that should use this instead of accessing buffer directly...)
> > 
> > Maybe we need ring_buffer_swap() and it checks all cpu_buffer does not set
> > mapping bits.
> > 
> > Thank you,  
> 
> How about instead of having ring_buffer_swap_cpu() returning -EBUSY when mapped
> we have two functions to block any mapping that trace.c could call?
> 

No. The ring buffer logic should not care if the user of it is swapping
the entire ring buffer or not. It only cares if parts of the ring
buffer is being swapped or not. That's not the level of scope it should
care about. If we do not want a swap to happen in update_max_tr()
that's not ring_buffer.c's problem. The code to prevent that from
happening should be 100% in trace.c.

The trace.c code knows what's being mapped or not. The accounting to
keep a mapped buffer from being swapped should stay in trace.c, and not
add unnecessary implementation coupling between that and ring_buffer.c.

-- Steve

