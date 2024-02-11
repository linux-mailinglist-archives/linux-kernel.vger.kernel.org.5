Return-Path: <linux-kernel+bounces-60970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D69850BC6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 073E9B218AD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 22:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DF9149E18;
	Sun, 11 Feb 2024 22:31:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81516410;
	Sun, 11 Feb 2024 22:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707690719; cv=none; b=ZpdYaKK0gxTrxtKXRs0JIeo8zek/DI3sL7DHPi1WKdSP857c40bRYFcCM5uOFiPgbAwfV4L4p5MgkYTwWP3MB/ABSep5zE5FtZMdvAS1OOnQ28FSkoffuIiX4HCvwABpQpd0o/8yu2tUfgKAKe8lEh3ZTegA5/VU03gMsaycyQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707690719; c=relaxed/simple;
	bh=QpPQNeAHMer5KrkFxS0Sut6+SxBrUisr5nLi+22bvCs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMMUN0QQtm3i1LXlzusOp1gtT/pEEgQIatTtJadLmbB117ve8svMmYJUREtDMXJWH5y2BMpsTSYH7ReQzRoBNywVN1iT/+p3um2KxIFCW4v5maEU4qdl4RQejy5sSqVst9z2hj7K2DXjUfd5AScosVzE1nMaUnedSBo3rArngdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7978C433C7;
	Sun, 11 Feb 2024 22:31:57 +0000 (UTC)
Date: Sun, 11 Feb 2024 17:31:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v16 4/6] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <20240211173151.0d3f58c4@rorschach.local.home>
In-Reply-To: <20240209163448.944970-5-vdonnefort@google.com>
References: <20240209163448.944970-1-vdonnefort@google.com>
	<20240209163448.944970-5-vdonnefort@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Feb 2024 16:34:46 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> +static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
> +{
> +	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> +	struct trace_iterator *iter = &info->iter;
> +	struct trace_array __maybe_unused *tr = iter->tr;
> +
> +	ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file);
> +
> +#ifdef CONFIG_TRACER_MAX_TRACE
> +	spin_lock(&tr->snapshot_trigger_lock);
> +	if (!WARN_ON(!tr->mapped))
> +		tr->mapped--;
> +	spin_unlock(&tr->snapshot_trigger_lock);
> +#endif

You can add a section with the #ifdef *MAX_TRACE and use static inline
for these (or use an existing section):

#ifdef CONFIG_TRACER_MAX_TRACE
static void put_snapshot_map(struct trace_array *tr)
{
	spin_lock(&tr->snapshot_trigger_lock);
	if (!WARN_ON(!tr->mapped))
		tr->mapped--;
	spin_unlock(&tr->snapshot_trigger_lock);	
}
[..]
#else
static inline void put_snapshot_map(struct trace_array *tr) { }
[..]
#endif

> +}
> +
> +static void tracing_buffers_mmap_open(struct vm_area_struct *vma)
> +{
> +	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> +	struct trace_iterator *iter = &info->iter;
> +
> +	WARN_ON(ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file));
> +}
> +
> +static const struct vm_operations_struct tracing_buffers_vmops = {
> +	.open		= tracing_buffers_mmap_open,
> +	.close		= tracing_buffers_mmap_close,
> +	.fault		= tracing_buffers_mmap_fault,
> +};
> +
> +static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct ftrace_buffer_info *info = filp->private_data;
> +	struct trace_iterator *iter = &info->iter;
> +	struct trace_array __maybe_unused *tr = iter->tr;
> +	int ret = 0;
> +
> +	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC)
> +		return -EPERM;
> +
> +	vm_flags_mod(vma, VM_DONTCOPY | VM_DONTDUMP, VM_MAYWRITE);
> +	vma->vm_ops = &tracing_buffers_vmops;
> +
> +#ifdef CONFIG_TRACER_MAX_TRACE
> +	/*
> +	 * We hold mmap_lock here. lockdep would be unhappy if we would now take
> +	 * trace_types_lock. Instead use the specific snapshot_trigger_lock.
> +	 */
> +	spin_lock(&tr->snapshot_trigger_lock);
> +	if (tr->snapshot || tr->mapped == UINT_MAX) {
> +		spin_unlock(&tr->snapshot_trigger_lock);
> +		return -EBUSY;
> +	}
> +	tr->mapped++;
> +	spin_unlock(&tr->snapshot_trigger_lock);
> +
> +	/* Wait for update_max_tr() to observe iter->tr->mapped */
> +	if (tr->mapped == 1)
> +		synchronize_rcu();
> +#endif

The above could be:

static int get_snapshot_map(struct trace_array *tr)
{
	/*
	 * We hold mmap_lock here. lockdep would be unhappy if we would now take
	 * trace_types_lock. Instead use the specific snapshot_trigger_lock.
	 */
	spin_lock(&tr->snapshot_trigger_lock);
	if (tr->snapshot || tr->mapped == UINT_MAX) {
		spin_unlock(&tr->snapshot_trigger_lock);
		return -EBUSY;
	}
	tr->mapped++;
	spin_unlock(&tr->snapshot_trigger_lock);

	/* Wait for update_max_tr() to observe iter->tr->mapped */
	if (tr->mapped == 1)
		synchronize_rcu();

	return 0;
}
#else
static inline test_snapshot_map(struct trace_array *tr)
{
	return 0;
}
[..]

Then here just have:

	ret = test_snapshot_map(tr);
	if (ret < 0)
		return ret;


> +	ret = ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file);
> +#ifdef CONFIG_TRACER_MAX_TRACE
> +	if (ret) {
> +		spin_lock(&tr->snapshot_trigger_lock);
> +		iter->tr->mapped--;
> +		spin_unlock(&tr->snapshot_trigger_lock);
> +	}
> +#endif

and the above is just:

	if (ret)
		put_snapshot_map(tr);

-- Steve

> +	return ret;
> +}
> +
>  static const struct file_operations tracing_buffers_fops = {
>  	.open		= tracing_buffers_open,
>  	.read		= tracing_buffers_read,
> @@ -8681,6 +8794,7 @@ static const struct file_operations tracing_buffers_fops = {
>  	.splice_read	= tracing_buffers_splice_read,
>  	.unlocked_ioctl = tracing_buffers_ioctl,
>  	.llseek		= no_llseek,
> +	.mmap		= tracing_buffers_mmap,
>  };
>  
>  static ssize_t
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index bd312e9afe25..8a96e7a89e6b 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -336,6 +336,7 @@ struct trace_array {
>  	bool			allocated_snapshot;
>  	spinlock_t		snapshot_trigger_lock;
>  	unsigned int		snapshot;
> +	unsigned int		mapped;
>  	unsigned long		max_latency;
>  #ifdef CONFIG_FSNOTIFY
>  	struct dentry		*d_max_latency;


