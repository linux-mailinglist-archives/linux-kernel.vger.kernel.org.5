Return-Path: <linux-kernel+bounces-25294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165CA82CCD1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 14:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0BF284A0E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 13:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2DF21116;
	Sat, 13 Jan 2024 13:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jE7vgett"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31401210F5;
	Sat, 13 Jan 2024 13:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07C7C433F1;
	Sat, 13 Jan 2024 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705153108;
	bh=SC7yxX48nNARM4zUOANK65x2NyUG2tY3vzPMRpzF+LM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jE7vgettR+MRr/hJePpzqL/3b14WDhBRhyrYPfY9Gb3wtzC7OTRCkuMoE1Gwd5102
	 +8qNv8U7UGCVrxOvoDmdr7FGSY13M3qryfAs98IaOqG4efcbgccIe0rgD9SW2grxOH
	 n0+odZa1vSn4gWFT6bt4EZRwhOdiUPOBPISXtjhEtMwrC1w9ojQv79QH8QwCm7csLF
	 +QInt34OnInHL0L8nR3rlGfRc9Td2F8gL0SK5po1QmJ4bI0blEk5qYymaUsELqzDTB
	 EvgJolaqSomy2Ct3sfY5Abvy3TZE2qZ8iHEXwzlA6d6sgX7ypFk764HQCjJwlYPfDi
	 71QMcnDZYd2TQ==
Date: Sat, 13 Jan 2024 22:38:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v11 1/5] ring-buffer: Zero ring-buffer sub-buffers
Message-Id: <20240113223824.3e9eed42cf10748e4255afde@kernel.org>
In-Reply-To: <20240111161712.1480333-2-vdonnefort@google.com>
References: <20240111161712.1480333-1-vdonnefort@google.com>
	<20240111161712.1480333-2-vdonnefort@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jan 2024 16:17:08 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> In preparation for the ring-buffer memory mapping where each subbuf will
> be accessible to user-space, zero all the page allocations.
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 173d2595ce2d..db73e326fa04 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1466,7 +1466,8 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  
>  		list_add(&bpage->list, pages);
>  
> -		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags,
> +		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
> +					mflags | __GFP_ZERO,
>  					cpu_buffer->buffer->subbuf_order);
>  		if (!page)
>  			goto free_pages;
> @@ -1551,7 +1552,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>  
>  	cpu_buffer->reader_page = bpage;
>  
> -	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, cpu_buffer->buffer->subbuf_order);
> +	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
> +				cpu_buffer->buffer->subbuf_order);
>  	if (!page)
>  		goto fail_free_reader;
>  	bpage->page = page_address(page);
> @@ -5525,7 +5527,8 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
>  	if (bpage->data)
>  		goto out;
>  
> -	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_NORETRY,
> +	page = alloc_pages_node(cpu_to_node(cpu),
> +				GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO,
>  				cpu_buffer->buffer->subbuf_order);
>  	if (!page) {
>  		kfree(bpage);
> -- 
> 2.43.0.275.g3460e3d667-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

