Return-Path: <linux-kernel+bounces-7702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BA181ABBE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D12B26057
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F60E20EA;
	Thu, 21 Dec 2023 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB9bamtL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4B94685;
	Thu, 21 Dec 2023 00:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF990C433C8;
	Thu, 21 Dec 2023 00:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703118386;
	bh=pMf12RPVRVsD8MpTPZsg/+NtWOPshbccTITAOb1SP0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fB9bamtLNBsaz2y39dyCXeOdjCS4spdrfn6ll1W8swa7xctZnBqOyUmON9uK04kkq
	 6a4FuwrOKb0tnKgdPjjXW+26dno3YsVhMnR0CYoxRoM70iO5Fx6eFqHmtAAumNEc3I
	 ZkpNbj6DJGp3S64uA3Nj29or67cZ1YJWBKUr35fUT2exOLW25i1+RYx3exxAvhrCUQ
	 NHjT1cp/mPfHVwlZLKmaVxIttQYbVCGE6yBSvuURr/XKyVKry+YQ81/LNTJgJPsJp2
	 4PixLsl6cx9hm5Dw8Cougzy5E1a4mX+UhKqgo8VgZEqT28iLSP+d0LTzBtEWviOxHB
	 ugo47y7cNWN8A==
Date: Thu, 21 Dec 2023 09:26:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>, Kent Overstreet
 <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 15/15] tracing: Update subbuffer with kilobytes not
 page order
Message-Id: <20231221092621.c3d4ecc23b852d3c4183370d@kernel.org>
In-Reply-To: <20231219185631.809766769@goodmis.org>
References: <20231219185414.474197117@goodmis.org>
	<20231219185631.809766769@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 13:54:29 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Using page order for deciding what the size of the ring buffer sub buffers
> are is exposing a bit too much of the implementation. Although the sub
> buffers are only allocated in orders of pages, allow the user to specify
> the minimum size of each sub-buffer via kilobytes like they can with the
> buffer size itself.
> 
> If the user specifies 3 via:
> 
>   echo 3 > buffer_subbuf_size_kb
> 
> Then the sub-buffer size will round up to 4kb (on a 4kb page size system).
> 
> If they specify:
> 
>   echo 6 > buffer_subbuf_size_kb
> 
> The sub-buffer size will become 8kb.

I think this is better interface. Can we apply this earlier in the series
to avoid rewriting the document and test code?

Thank you,

> 
> and so on.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  Documentation/trace/ftrace.rst                | 46 ++++++++-----------
>  kernel/trace/trace.c                          | 38 +++++++++------
>  ...fer_order.tc => ringbuffer_subbuf_size.tc} | 18 ++++----
>  3 files changed, 54 insertions(+), 48 deletions(-)
>  rename tools/testing/selftests/ftrace/test.d/00basic/{ringbuffer_order.tc => ringbuffer_subbuf_size.tc} (85%)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 231d26ceedb0..933e7efb9f1b 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -203,32 +203,26 @@ of ftrace. Here is a list of some of the key files:
>  
>  	This displays the total combined size of all the trace buffers.
>  
> -  buffer_subbuf_order:
> -
> -	This sets or displays the sub buffer page size order. The ring buffer
> -	is broken up into several same size "sub buffers". An event can not be
> -	bigger than the size of the sub buffer. Normally, the sub buffer is
> -	the size of the architecture's page (4K on x86). The sub buffer also
> -	contains meta data at the start which also limits the size of an event.
> -	That means when the sub buffer is a page size, no event can be larger
> -	than the page size minus the sub buffer meta data.
> -
> -	The buffer_subbuf_order allows the user to change the size of the sub
> -	buffer. As the sub buffer is a set of pages by the power of 2, thus
> -	the sub buffer total size is defined by the order:
> -
> -	order		size
> -	----		----
> -	0		PAGE_SIZE
> -	1		PAGE_SIZE * 2
> -	2		PAGE_SIZE * 4
> -	3		PAGE_SIZE * 8
> -
> -	Changing the order will change the sub buffer size allowing for events
> -	to be larger than the page size.
> -
> -	Note: When changing the order, tracing is stopped and any data in the
> -	ring buffer and the snapshot buffer will be discarded.
> +  buffer_subbuf_size_kb:
> +
> +	This sets or displays the sub buffer size. The ring buffer is broken up
> +	into several same size "sub buffers". An event can not be bigger than
> +	the size of the sub buffer. Normally, the sub buffer is the size of the
> +	architecture's page (4K on x86). The sub buffer also contains meta data
> +	at the start which also limits the size of an event.  That means when
> +	the sub buffer is a page size, no event can be larger than the page
> +	size minus the sub buffer meta data.
> +
> +	Note, the buffer_subbuf_size_kb is a way for the user to specify the
> +	minimum size of the subbuffer. The kernel may make it bigger due to the
> +	implementation details, or simply fail the operation if the kernel can
> +	not handle the request.
> +
> +	Changing the sub buffer size allows for events to be larger than the
> +	page size.
> +
> +	Note: When changing the sub-buffer size, tracing is stopped and any
> +	data in the ring buffer and the snapshot buffer will be discarded.
>  
>    free_buffer:
>  
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 82303bd2bba1..46dbe22121e9 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9384,42 +9384,54 @@ static const struct file_operations buffer_percent_fops = {
>  };
>  
>  static ssize_t
> -buffer_order_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
> +buffer_subbuf_size_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
>  {
>  	struct trace_array *tr = filp->private_data;
> +	size_t size;
>  	char buf[64];
> +	int order;
>  	int r;
>  
> -	r = sprintf(buf, "%d\n", ring_buffer_subbuf_order_get(tr->array_buffer.buffer));
> +	order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
> +	size = (PAGE_SIZE << order) / 1024;
> +
> +	r = sprintf(buf, "%zd\n", size);
>  
>  	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
>  }
>  
>  static ssize_t
> -buffer_order_write(struct file *filp, const char __user *ubuf,
> -		   size_t cnt, loff_t *ppos)
> +buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
> +			 size_t cnt, loff_t *ppos)
>  {
>  	struct trace_array *tr = filp->private_data;
>  	unsigned long val;
>  	int old_order;
> +	int order;
> +	int pages;
>  	int ret;
>  
>  	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
>  	if (ret)
>  		return ret;
>  
> +	val *= 1024; /* value passed in is in KB */
> +
> +	pages = DIV_ROUND_UP(val, PAGE_SIZE);
> +	order = fls(pages - 1);
> +
>  	/* limit between 1 and 128 system pages */
> -	if (val < 0 || val > 7)
> +	if (order < 0 || order > 7)
>  		return -EINVAL;
>  
>  	/* Do not allow tracing while changing the order of the ring buffer */
>  	tracing_stop_tr(tr);
>  
>  	old_order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
> -	if (old_order == val)
> +	if (old_order == order)
>  		goto out;
>  
> -	ret = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, val);
> +	ret = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, order);
>  	if (ret)
>  		goto out;
>  
> @@ -9428,7 +9440,7 @@ buffer_order_write(struct file *filp, const char __user *ubuf,
>  	if (!tr->allocated_snapshot)
>  		goto out_max;
>  
> -	ret = ring_buffer_subbuf_order_set(tr->max_buffer.buffer, val);
> +	ret = ring_buffer_subbuf_order_set(tr->max_buffer.buffer, order);
>  	if (ret) {
>  		/* Put back the old order */
>  		cnt = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, old_order);
> @@ -9460,10 +9472,10 @@ buffer_order_write(struct file *filp, const char __user *ubuf,
>  	return cnt;
>  }
>  
> -static const struct file_operations buffer_order_fops = {
> +static const struct file_operations buffer_subbuf_size_fops = {
>  	.open		= tracing_open_generic_tr,
> -	.read		= buffer_order_read,
> -	.write		= buffer_order_write,
> +	.read		= buffer_subbuf_size_read,
> +	.write		= buffer_subbuf_size_write,
>  	.release	= tracing_release_generic_tr,
>  	.llseek		= default_llseek,
>  };
> @@ -9934,8 +9946,8 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
>  			tr, &buffer_percent_fops);
>  
> -	trace_create_file("buffer_subbuf_order", TRACE_MODE_WRITE, d_tracer,
> -			  tr, &buffer_order_fops);
> +	trace_create_file("buffer_subbuf_size_kb", TRACE_MODE_WRITE, d_tracer,
> +			  tr, &buffer_subbuf_size_fops);
>  
>  	create_trace_options_dir(tr);
>  
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_subbuf_size.tc
> similarity index 85%
> rename from tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc
> rename to tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_subbuf_size.tc
> index ecbcc810e6c1..d44d09a33a74 100644
> --- a/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_subbuf_size.tc
> @@ -1,7 +1,7 @@
>  #!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0
> -# description: Change the ringbuffer sub-buffer order
> -# requires: buffer_subbuf_order
> +# description: Change the ringbuffer sub-buffer size
> +# requires: buffer_subbuf_size_kb
>  # flags: instance
>  
>  get_buffer_data_size() {
> @@ -52,8 +52,8 @@ write_buffer() {
>  }
>  
>  test_buffer() {
> -	orde=$1
> -	page_size=$((4096<<order))
> +	size_kb=$1
> +	page_size=$((size_kb*1024))
>  
>  	size=`get_buffer_data_size`
>  
> @@ -82,14 +82,14 @@ test_buffer() {
>  	fi
>  }
>  
> -ORIG=`cat buffer_subbuf_order`
> +ORIG=`cat buffer_subbuf_size_kb`
>  
> -# Could test bigger orders than 3, but then creating the string
> +# Could test bigger sizes than 32K, but then creating the string
>  # to write into the ring buffer takes too long
> -for a in 0 1 2 3 ; do
> -	echo $a > buffer_subbuf_order
> +for a in 4 8 16 32 ; do
> +	echo $a > buffer_subbuf_size_kb
>  	test_buffer $a
>  done
>  
> -echo $ORIG > buffer_subbuf_order
> +echo $ORIG > buffer_subbuf_size_kb
>  
> -- 
> 2.42.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

