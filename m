Return-Path: <linux-kernel+bounces-139107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B161089FEA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A11B289C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9EA17F39F;
	Wed, 10 Apr 2024 17:33:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DD01802A8;
	Wed, 10 Apr 2024 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770417; cv=none; b=nzzDr8nSq5E7gIWzgUVJO3gd99aBpTmWm457FH9iam2Plknr356XLmk3BxxvpGj9dibC7S/OPYDPy/oBdqAm2MMFwrsa+wsLQbATyVZXfhmxzCr+rUWXDpQAOtWU1lfa5GKpC4zICjUh0LmyrCzh3CiKcSeRFUYM8tCtf+PwYcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770417; c=relaxed/simple;
	bh=DmWvcimBV0EwaDRiRQGTmsaNYqsgcCxqJIMpAyeTNcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i35c1JgwYgp/g2OLJJT+wR+A7ePi7IuFmug2LfdJB9b/fZ3Xts6JSKiOh5e5x2K/8qt0XfC2oQ//L2I939mXiyFKsB6Gaue2oynWz4ku+y9Y7gRGCpe6cUcwhky2yGRhXIwWNAnCL7OXmkBnlBLnuwyLCGxum6kaKuXFn4TIi5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735B2C433C7;
	Wed, 10 Apr 2024 17:33:36 +0000 (UTC)
Date: Wed, 10 Apr 2024 13:36:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, rdunlap@infradead.org
Subject: Re: [PATCH v20 1/5] ring-buffer: allocate sub-buffers with
 __GFP_COMP
Message-ID: <20240410133613.0a6bd6fb@gandalf.local.home>
In-Reply-To: <20240406173649.3210836-2-vdonnefort@google.com>
References: <20240406173649.3210836-1-vdonnefort@google.com>
	<20240406173649.3210836-2-vdonnefort@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Vincent,

Thanks for sending this. Nit: Subject should start with a capital:

  ring-buffer: Allocate sub-buffers with __GFP_COMP

-- Steve


On Sat,  6 Apr 2024 18:36:45 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> In preparation for the ring-buffer memory mapping, allocate compound
> pages for the ring-buffer sub-buffers to enable us to map them to
> user-space with vm_insert_pages().
> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 25476ead681b..cc9ebe593571 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1524,7 +1524,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
>  		list_add(&bpage->list, pages);
>  
>  		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
> -					mflags | __GFP_ZERO,
> +					mflags | __GFP_COMP | __GFP_ZERO,
>  					cpu_buffer->buffer->subbuf_order);
>  		if (!page)
>  			goto free_pages;
> @@ -1609,7 +1609,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
>  
>  	cpu_buffer->reader_page = bpage;
>  
> -	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
> +	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_COMP | __GFP_ZERO,
>  				cpu_buffer->buffer->subbuf_order);
>  	if (!page)
>  		goto fail_free_reader;
> @@ -5579,7 +5579,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
>  		goto out;
>  
>  	page = alloc_pages_node(cpu_to_node(cpu),
> -				GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO,
> +				GFP_KERNEL | __GFP_NORETRY | __GFP_COMP | __GFP_ZERO,
>  				cpu_buffer->buffer->subbuf_order);
>  	if (!page) {
>  		kfree(bpage);


