Return-Path: <linux-kernel+bounces-125285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6ED89236F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A0B1F23F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A433AC08;
	Fri, 29 Mar 2024 18:38:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC9225A8;
	Fri, 29 Mar 2024 18:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711737490; cv=none; b=lzaK2sgEjR79kX/f7TMnuYbFLVzQkf9Cly0/oFqJCiVFC3DS/tTyaRaehT+qEwMHDbt3xPJXvqNlvZiFK2E3fRQK5hhDczS8Ra0x//zPexR178MiYVRUEBGdsCfnaMQcADkMtvXh7a4iXkqCBoYPZB4LOne+Q7d+kWfsNlFTApM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711737490; c=relaxed/simple;
	bh=OG2bRo9kq/BnN8MwsBV8qP90ekyyndS4iDqRH1lNo1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjUuc/t9tem+2x7qZ3fvvyJSk3UTkGPDopHZkaSsDTKEdjvee4XyD+FSOlRALkAJCRmv2Hla+rC1tNfOC0vY+6djzl4rESxwIU3FxklgX1kCjuSRDX96mkaIYFvFPxGl7z/4DZP3gtWAk7e7rj2pOMCKD8cr5XGJPd8xnJiqrSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF8EC433F1;
	Fri, 29 Mar 2024 18:38:09 +0000 (UTC)
Date: Fri, 29 Mar 2024 14:40:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, linux-mm@kvack.org
Subject: Re: [PATCH v19 RESEND 3/5] tracing: Allow user-space mapping of the
 ring-buffer
Message-ID: <20240329144055.0ae2dd4b@gandalf.local.home>
In-Reply-To: <20240326100830.1326610-4-vdonnefort@google.com>
References: <20240326100830.1326610-1-vdonnefort@google.com>
	<20240326100830.1326610-4-vdonnefort@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 10:08:28 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> Currently, user-space extracts data from the ring-buffer via splice,
> which is handy for storage or network sharing. However, due to splice
> limitations, it is imposible to do real-time analysis without a copy.
> 
> A solution for that problem is to let the user-space map the ring-buffer
> directly.
> 
> The mapping is exposed via the per-CPU file trace_pipe_raw. The first
> element of the mapping is the meta-page. It is followed by each
> subbuffer constituting the ring-buffer, ordered by their unique page ID:
> 
>   * Meta-page -- include/uapi/linux/trace_mmap.h for a description
>   * Subbuf ID 0
>   * Subbuf ID 1
>      ...
> 
> It is therefore easy to translate a subbuf ID into an offset in the
> mapping:
> 
>   reader_id = meta->reader->id;
>   reader_offset = meta->meta_page_size + reader_id * meta->subbuf_size;
> 
> When new data is available, the mapper must call a newly introduced ioctl:
> TRACE_MMAP_IOCTL_GET_READER. This will update the Meta-page reader ID to
> point to the next reader containing unread data.
> 

Thanks for the update Vincent!

> Mapping will prevent snapshot and buffer size modifications.
> 
> CC: <linux-mm@kvack.org>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> index ffcd8dfcaa4f..d25b9d504a7c 100644
> --- a/include/uapi/linux/trace_mmap.h
> +++ b/include/uapi/linux/trace_mmap.h
> @@ -43,4 +43,6 @@ struct trace_buffer_meta {
>  	__u64	Reserved2;
>  };
>  
> +#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
> +
>  #endif /* _TRACE_MMAP_H_ */
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 233d1af39fff..0f37aa9860fd 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1191,6 +1191,12 @@ static void tracing_snapshot_instance_cond(struct trace_array *tr,
>  		return;
>  	}
>  
> +	if (tr->mapped) {
> +		trace_array_puts(tr, "*** BUFFER MEMORY MAPPED ***\n");
> +		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
> +		return;
> +	}
> +
>  	local_irq_save(flags);
>  	update_max_tr(tr, current, smp_processor_id(), cond_data);
>  	local_irq_restore(flags);
> @@ -1323,7 +1329,7 @@ static int tracing_arm_snapshot_locked(struct trace_array *tr)
>  	lockdep_assert_held(&trace_types_lock);
>  
>  	spin_lock(&tr->snapshot_trigger_lock);
> -	if (tr->snapshot == UINT_MAX) {
> +	if (tr->snapshot == UINT_MAX || tr->mapped) {
>  		spin_unlock(&tr->snapshot_trigger_lock);
>  		return -EBUSY;
>  	}
> @@ -6068,7 +6074,7 @@ static void tracing_set_nop(struct trace_array *tr)
>  {
>  	if (tr->current_trace == &nop_trace)
>  		return;
> -	
> +
>  	tr->current_trace->enabled--;
>  
>  	if (tr->current_trace->reset)
> @@ -8194,15 +8200,32 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>  	return ret;
>  }
>  
> -/* An ioctl call with cmd 0 to the ring buffer file will wake up all waiters */
>  static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>  	struct ftrace_buffer_info *info = file->private_data;
>  	struct trace_iterator *iter = &info->iter;
> +	int err;
> +
> +	if (cmd == TRACE_MMAP_IOCTL_GET_READER) {
> +		if (!(file->f_flags & O_NONBLOCK)) {
> +			err = ring_buffer_wait(iter->array_buffer->buffer,
> +					       iter->cpu_file,
> +					       iter->tr->buffer_percent,
> +					       NULL, NULL);
> +			if (err)
> +				return err;
> +		}
>  
> -	if (cmd)
> -		return -ENOIOCTLCMD;
> +		return ring_buffer_map_get_reader(iter->array_buffer->buffer,
> +						  iter->cpu_file);
> +	} else if (cmd) {
> +		return -ENOTTY;
> +	}
>  
> +	/*
> +	 * An ioctl call with cmd 0 to the ring buffer file will wake up all
> +	 * waiters
> +	 */
>  	mutex_lock(&trace_types_lock);
>  
>  	/* Make sure the waiters see the new wait_index */
> @@ -8214,6 +8237,94 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
>  	return 0;
>  }
>  
> +static vm_fault_t tracing_buffers_mmap_fault(struct vm_fault *vmf)
> +{
> +	return VM_FAULT_SIGBUS;
> +}

If this is all it does, I don't believe it's needed.

> +
> +#ifdef CONFIG_TRACER_MAX_TRACE
> +static int get_snapshot_map(struct trace_array *tr)
> +{
> +	int err = 0;
> +
> +	/*
> +	 * Called with mmap_lock held. lockdep would be unhappy if we would now
> +	 * take trace_types_lock. Instead use the specific
> +	 * snapshot_trigger_lock.
> +	 */
> +	spin_lock(&tr->snapshot_trigger_lock);
> +
> +	if (tr->snapshot || tr->mapped == UINT_MAX)
> +		err = -EBUSY;
> +	else
> +		tr->mapped++;
> +
> +	spin_unlock(&tr->snapshot_trigger_lock);
> +
> +	/* Wait for update_max_tr() to observe iter->tr->mapped */
> +	if (tr->mapped == 1)
> +		synchronize_rcu();
> +
> +	return err;
> +
> +}
> +static void put_snapshot_map(struct trace_array *tr)
> +{
> +	spin_lock(&tr->snapshot_trigger_lock);
> +	if (!WARN_ON(!tr->mapped))
> +		tr->mapped--;
> +	spin_unlock(&tr->snapshot_trigger_lock);
> +}
> +#else
> +static inline int get_snapshot_map(struct trace_array *tr) { return 0; }
> +static inline void put_snapshot_map(struct trace_array *tr) { }
> +#endif
> +
> +static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
> +{
> +	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> +	struct trace_iterator *iter = &info->iter;
> +
> +	WARN_ON(ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file));
> +	put_snapshot_map(iter->tr);
> +}
> +
> +static void tracing_buffers_mmap_open(struct vm_area_struct *vma) { }

Same for the open.


> +
> +static const struct vm_operations_struct tracing_buffers_vmops = {
> +	.open		= tracing_buffers_mmap_open,
> +	.close		= tracing_buffers_mmap_close,
> +	.fault		= tracing_buffers_mmap_fault,
> +};

I replaced this with:

static const struct vm_operations_struct tracing_buffers_vmops = {
	.close		= tracing_buffers_mmap_close,
};

And it appears to work just fine. The mm code handles the NULL cases for
open and .fault.

Is there any reason to do something different than the mm defaults?

-- Steve

> +
> +static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct ftrace_buffer_info *info = filp->private_data;
> +	struct trace_iterator *iter = &info->iter;
> +	int ret = 0;
> +
> +	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
> +	    !(vma->vm_flags & VM_MAYSHARE))
> +		return -EPERM;
> +
> +	vm_flags_mod(vma,
> +		     VM_MIXEDMAP | VM_PFNMAP |
> +		     VM_DONTCOPY | VM_DONTDUMP | VM_DONTEXPAND | VM_IO,
> +		     VM_MAYWRITE);
> +
> +	vma->vm_ops = &tracing_buffers_vmops;
> +
> +	ret = get_snapshot_map(iter->tr);
> +	if (ret)
> +		return ret;
> +
> +	ret = ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file, vma);
> +	if (ret)
> +		put_snapshot_map(iter->tr);
> +
> +	return ret;
> +}
> +
>  static const struct file_operations tracing_buffers_fops = {
>  	.open		= tracing_buffers_open,
>  	.read		= tracing_buffers_read,
> @@ -8223,6 +8334,7 @@ static const struct file_operations tracing_buffers_fops = {
>  	.splice_read	= tracing_buffers_splice_read,
>  	.unlocked_ioctl = tracing_buffers_ioctl,
>  	.llseek		= no_llseek,
> +	.mmap		= tracing_buffers_mmap,
>  };
>  
>  static ssize_t
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 64450615ca0c..749a182dab48 100644
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


