Return-Path: <linux-kernel+bounces-7303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 655BF81A53F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68431F286D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C3E4185C;
	Wed, 20 Dec 2023 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZenRPxE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F362BB0C;
	Wed, 20 Dec 2023 16:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEDAC433C8;
	Wed, 20 Dec 2023 16:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703090101;
	bh=GAuSm+5saiD4CFbJEwaSGE/Uy2Uu9w4mwdd+aoXOj1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mZenRPxEjqcqjPECJ6UIEYUSzjSioYORY9Roth+pXtdc0ogZlYIJRTvLF2YJF5cQG
	 qpFkPL5MxFq/HZl82Z1Y9nZfCkkn8uI+sTHV04J72XnYaonXRJf6rYOMw8UM05vzRA
	 ai5ttWpHYDLQEsowc2ybz2ny2LVW6sXfJzjs1L5YWT/lBd3leApB3dPiU3f55jL5cA
	 jqVx49wG4TfdLfeh4Ov5bndAlxGaS+NtCZn/2K/iECGHUbTYs8N1FtetjJ9U1FJJPu
	 PuET7/rGsTQBKMnZ6VUc4U4bjhxGKIoAr2RnTP9H2jKmXObTvZh+H3MF4RJs62Ojwi
	 gtimw6u2dEbIg==
Date: Thu, 21 Dec 2023 01:34:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>, Kent Overstreet
 <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 04/15] ring-buffer: Set new size of the ring buffer
 sub page
Message-Id: <20231221013456.cc03acc7b565cfa9a15cbe87@kernel.org>
In-Reply-To: <20231219185628.588995543@goodmis.org>
References: <20231219185414.474197117@goodmis.org>
	<20231219185628.588995543@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 13:54:18 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
> 
> There are two approaches when changing the size of the ring buffer
> sub page:
>  1. Destroying all pages and allocating new pages with the new size.
>  2. Allocating new pages, copying the content of the old pages before
>     destroying them.
> The first approach is easier, it is selected in the proposed
> implementation. Changing the ring buffer sub page size is supposed to
> not happen frequently. Usually, that size should be set only once,
> when the buffer is not in use yet and is supposed to be empty.
> 
> Link: https://lore.kernel.org/linux-trace-devel/20211213094825.61876-5-tz.stoyanov@gmail.com
> 

OK, this actually reallocate the sub buffers when a new order is set.
BTW, with this change, if we set a new order, the total buffer size will be
changed too? Or reserve the total size? I think either is OK but it should
be described in the document. (e.g. if it is changed, user should set the
order first and set the total size later.)

Thank you,

> Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 80 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 73 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 20fc0121735d..b928bd03dd0e 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -332,6 +332,7 @@ struct buffer_page {
>  	unsigned	 read;		/* index for next read */
>  	local_t		 entries;	/* entries on this page */
>  	unsigned long	 real_end;	/* real end of data */
> +	unsigned	 order;		/* order of the page */
>  	struct buffer_data_page *page;	/* Actual data page */
>  };
>  
> @@ -362,7 +363,7 @@ static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
>  
>  static void free_buffer_page(struct buffer_page *bpage)
>  {
> -	free_page((unsigned long)bpage->page);
> +	free_pages((unsigned long)bpage->page, bpage->order);
>  	kfree(bpage);
>  }
>  
> @@ -1460,10 +1461,12 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  
>  		list_add(&bpage->list, pages);
>  
> -		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags, 0);
> +		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu), mflags,
> +					cpu_buffer->buffer->subbuf_order);
>  		if (!page)
>  			goto free_pages;
>  		bpage->page = page_address(page);
> +		bpage->order = cpu_buffer->buffer->subbuf_order;
>  		rb_init_page(bpage->page);
>  
>  		if (user_thread && fatal_signal_pending(current))
> @@ -1542,7 +1545,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>  	rb_check_bpage(cpu_buffer, bpage);
>  
>  	cpu_buffer->reader_page = bpage;
> -	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, 0);
> +
> +	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL, cpu_buffer->buffer->subbuf_order);
>  	if (!page)
>  		goto fail_free_reader;
>  	bpage->page = page_address(page);
> @@ -1626,6 +1630,7 @@ struct trace_buffer *__ring_buffer_alloc(unsigned long size, unsigned flags,
>  		goto fail_free_buffer;
>  
>  	/* Default buffer page size - one system page */
> +	buffer->subbuf_order = 0;
>  	buffer->subbuf_size = PAGE_SIZE - BUF_PAGE_HDR_SIZE;
>  
>  	/* Max payload is buffer page size - header (8bytes) */
> @@ -5503,8 +5508,8 @@ void *ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
>  	if (bpage)
>  		goto out;
>  
> -	page = alloc_pages_node(cpu_to_node(cpu),
> -				GFP_KERNEL | __GFP_NORETRY, 0);
> +	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_NORETRY,
> +				cpu_buffer->buffer->subbuf_order);
>  	if (!page)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -5553,7 +5558,7 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu, void *data
>  	local_irq_restore(flags);
>  
>   out:
> -	free_page((unsigned long)bpage);
> +	free_pages((unsigned long)bpage, buffer->subbuf_order);
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_free_read_page);
>  
> @@ -5813,7 +5818,13 @@ EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_get);
>   */
>  int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  {
> +	struct ring_buffer_per_cpu **cpu_buffers;
> +	int old_order, old_size;
> +	int nr_pages;
>  	int psize;
> +	int bsize;
> +	int err;
> +	int cpu;
>  
>  	if (!buffer || order < 0)
>  		return -EINVAL;
> @@ -5825,12 +5836,67 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  	if (psize <= BUF_PAGE_HDR_SIZE)
>  		return -EINVAL;
>  
> +	bsize = sizeof(void *) * buffer->cpus;
> +	cpu_buffers = kzalloc(bsize, GFP_KERNEL);
> +	if (!cpu_buffers)
> +		return -ENOMEM;
> +
> +	old_order = buffer->subbuf_order;
> +	old_size = buffer->subbuf_size;
> +
> +	/* prevent another thread from changing buffer sizes */
> +	mutex_lock(&buffer->mutex);
> +	atomic_inc(&buffer->record_disabled);
> +
> +	/* Make sure all commits have finished */
> +	synchronize_rcu();
> +
>  	buffer->subbuf_order = order;
>  	buffer->subbuf_size = psize - BUF_PAGE_HDR_SIZE;
>  
> -	/* Todo: reset the buffer with the new page size */
> +	/* Make sure all new buffers are allocated, before deleting the old ones */
> +	for_each_buffer_cpu(buffer, cpu) {
> +		if (!cpumask_test_cpu(cpu, buffer->cpumask))
> +			continue;
> +
> +		nr_pages = buffer->buffers[cpu]->nr_pages;
> +		cpu_buffers[cpu] = rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
> +		if (!cpu_buffers[cpu]) {
> +			err = -ENOMEM;
> +			goto error;
> +		}
> +	}
> +
> +	for_each_buffer_cpu(buffer, cpu) {
> +		if (!cpumask_test_cpu(cpu, buffer->cpumask))
> +			continue;
> +
> +		rb_free_cpu_buffer(buffer->buffers[cpu]);
> +		buffer->buffers[cpu] = cpu_buffers[cpu];
> +	}
> +
> +	atomic_dec(&buffer->record_disabled);
> +	mutex_unlock(&buffer->mutex);
> +
> +	kfree(cpu_buffers);
>  
>  	return 0;
> +
> +error:
> +	buffer->subbuf_order = old_order;
> +	buffer->subbuf_size = old_size;
> +
> +	atomic_dec(&buffer->record_disabled);
> +	mutex_unlock(&buffer->mutex);
> +
> +	for_each_buffer_cpu(buffer, cpu) {
> +		if (!cpu_buffers[cpu])
> +			continue;
> +		kfree(cpu_buffers[cpu]);
> +	}
> +	kfree(cpu_buffers);
> +
> +	return err;
>  }
>  EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
>  
> -- 
> 2.42.0
> 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

