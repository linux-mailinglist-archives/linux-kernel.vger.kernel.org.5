Return-Path: <linux-kernel+bounces-53050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C897849FFE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FE4EB24E42
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72B03D392;
	Mon,  5 Feb 2024 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bX03+r4Y"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D323FE3F;
	Mon,  5 Feb 2024 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152117; cv=none; b=sNStvrxGBBjM1aLMxG90OxOUDMZA+D8Vm7/Z5oIaOg7/GooISpmyCwUpHqjHnw5TMcoX9EFPOFQTnuV5+NlqiuXHNhH/fKTxfEgPwTG0Zj77hrFoc3FZpJW3JZ3cVTCyOPSbABmJ/UgchW0Vba9jkdViYcmbHmwR8O5+I84hI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152117; c=relaxed/simple;
	bh=5qZXuupoFKUYVo8agP1h9S4qQ94D3Y2AcpLKcOkyjgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xmi2ofeC1tARMyDT3lUP5x7zrmgW8+FouReqcy6OE4alZi1adAOy+KaxruGQ0L8QPHPyr1vhzbnyyCaa+gD6BiFLpcdr47nclafNxTvSzpLepcO1c0GtNK/lT60imUgpIE8e9DtoEdbuMn14HsN4F9RI3ip03D+nMQQYPJfpvxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=bX03+r4Y; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707152104;
	bh=5qZXuupoFKUYVo8agP1h9S4qQ94D3Y2AcpLKcOkyjgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bX03+r4YYyhXn3EBekXNvG+e/IwreI0XjxsB2c/D3YHNexWE1rXBW/9rxe04wNE8r
	 RyvJi2VXchG1cMYwHilqXwJQvbdckvbJJiFPwM/BM95DGMJSsZ7W6G0FXJtfSNycKF
	 EF+7B1egyIUaDdxEkvAeH1lpoQqBWy3Ftcy8fsEvwhM4jUdygd63nzJaPtFbzAoE2M
	 hvMV66eyd5B5Tw99rlld5QpCciCGMbQQLR5XoZc3JFdU9QoVWmxIgpAVT8GJVZKt6E
	 NSb4CHhTDQLi3XTNFe/AubThDwo/7zWWQ0NK1rd2G7lNU+6w070XBR2MuWvtaXvlq1
	 tVOnLzTR1036g==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TTCD82rwmzXck;
	Mon,  5 Feb 2024 11:55:04 -0500 (EST)
Message-ID: <3c16bee0-70b7-420f-a085-c9e09e293fe2@efficios.com>
Date: Mon, 5 Feb 2024 11:55:08 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/6] tracing: Allow user-space mapping of the
 ring-buffer
To: Vincent Donnefort <vdonnefort@google.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com
References: <20240205163410.2296552-1-vdonnefort@google.com>
 <20240205163410.2296552-5-vdonnefort@google.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240205163410.2296552-5-vdonnefort@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-05 11:34, Vincent Donnefort wrote:
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
>    * Meta-page -- include/uapi/linux/trace_mmap.h for a description
>    * Subbuf ID 0
>    * Subbuf ID 1
>       ...
> 
> It is therefore easy to translate a subbuf ID into an offset in the
> mapping:
> 
>    reader_id = meta->reader->id;
>    reader_offset = meta->meta_page_size + reader_id * meta->subbuf_size;
> 
> When new data is available, the mapper must call a newly introduced ioctl:
> TRACE_MMAP_IOCTL_GET_READER. This will update the Meta-page reader ID to
> point to the next reader containing unread data.
> 
> Mapping will prevent snapshot and buffer size modifications.

How are the kernel linear mapping and the userspace mapping made coherent
on architectures with virtually aliasing data caches ?

Ref. https://lore.kernel.org/lkml/20240202210019.88022-1-mathieu.desnoyers@efficios.com/T/#t

Thanks,

Mathieu

> 
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> index 182e05a3004a..7330249257e7 100644
> --- a/include/uapi/linux/trace_mmap.h
> +++ b/include/uapi/linux/trace_mmap.h
> @@ -43,4 +43,6 @@ struct trace_buffer_meta {
>   	__u64	Reserved2;
>   };
>   
> +#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
> +
>   #endif /* _TRACE_MMAP_H_ */
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 4ebf4d0bd14c..36b62cf2fb3f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1175,6 +1175,12 @@ static void tracing_snapshot_instance_cond(struct trace_array *tr,
>   		return;
>   	}
>   
> +	if (tr->mapped) {
> +		trace_array_puts(tr, "*** BUFFER MEMORY MAPPED ***\n");
> +		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
> +		return;
> +	}
> +
>   	local_irq_save(flags);
>   	update_max_tr(tr, current, smp_processor_id(), cond_data);
>   	local_irq_restore(flags);
> @@ -1307,7 +1313,7 @@ static int tracing_arm_snapshot_locked(struct trace_array *tr)
>   	lockdep_assert_held(&trace_types_lock);
>   
>   	spin_lock(&tr->snapshot_trigger_lock);
> -	if (tr->snapshot == UINT_MAX) {
> +	if (tr->snapshot == UINT_MAX || tr->mapped) {
>   		spin_unlock(&tr->snapshot_trigger_lock);
>   		return -EBUSY;
>   	}
> @@ -6533,7 +6539,7 @@ static void tracing_set_nop(struct trace_array *tr)
>   {
>   	if (tr->current_trace == &nop_trace)
>   		return;
> -	
> +
>   	tr->current_trace->enabled--;
>   
>   	if (tr->current_trace->reset)
> @@ -8652,15 +8658,31 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>   	return ret;
>   }
>   
> -/* An ioctl call with cmd 0 to the ring buffer file will wake up all waiters */
>   static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>   {
>   	struct ftrace_buffer_info *info = file->private_data;
>   	struct trace_iterator *iter = &info->iter;
> +	int err;
> +
> +	if (cmd == TRACE_MMAP_IOCTL_GET_READER) {
> +		if (!(file->f_flags & O_NONBLOCK)) {
> +			err = ring_buffer_wait(iter->array_buffer->buffer,
> +					       iter->cpu_file,
> +					       iter->tr->buffer_percent);
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
>   	mutex_lock(&trace_types_lock);
>   
>   	iter->wait_index++;
> @@ -8673,6 +8695,97 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
>   	return 0;
>   }
>   
> +static vm_fault_t tracing_buffers_mmap_fault(struct vm_fault *vmf)
> +{
> +	struct ftrace_buffer_info *info = vmf->vma->vm_file->private_data;
> +	struct trace_iterator *iter = &info->iter;
> +	vm_fault_t ret = VM_FAULT_SIGBUS;
> +	struct page *page;
> +
> +	page = ring_buffer_map_fault(iter->array_buffer->buffer, iter->cpu_file,
> +				     vmf->pgoff);
> +	if (!page)
> +		return ret;
> +
> +	get_page(page);
> +	vmf->page = page;
> +	vmf->page->mapping = vmf->vma->vm_file->f_mapping;
> +	vmf->page->index = vmf->pgoff;
> +
> +	return 0;
> +}
> +
> +static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
> +{
> +	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> +	struct trace_iterator *iter = &info->iter;
> +	struct trace_array *tr = iter->tr;
> +
> +	ring_buffer_unmap(iter->array_buffer->buffer, iter->cpu_file);
> +
> +#ifdef CONFIG_TRACER_MAX_TRACE
> +	spin_lock(&tr->snapshot_trigger_lock);
> +	if (!WARN_ON(!tr->mapped))
> +		tr->mapped--;
> +	spin_unlock(&tr->snapshot_trigger_lock);
> +#endif
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
> +	struct trace_array *tr = iter->tr;
> +	int ret = 0;
> +
> +	if (vma->vm_flags & VM_WRITE)
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
> +	ret = ring_buffer_map(iter->array_buffer->buffer, iter->cpu_file);
> +#ifdef CONFIG_TRACER_MAX_TRACE
> +	if (ret) {
> +		spin_lock(&tr->snapshot_trigger_lock);
> +		iter->tr->mapped--;
> +		spin_unlock(&tr->snapshot_trigger_lock);
> +	}
> +#endif
> +	return ret;
> +}
> +
>   static const struct file_operations tracing_buffers_fops = {
>   	.open		= tracing_buffers_open,
>   	.read		= tracing_buffers_read,
> @@ -8681,6 +8794,7 @@ static const struct file_operations tracing_buffers_fops = {
>   	.splice_read	= tracing_buffers_splice_read,
>   	.unlocked_ioctl = tracing_buffers_ioctl,
>   	.llseek		= no_llseek,
> +	.mmap		= tracing_buffers_mmap,
>   };
>   
>   static ssize_t
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index bd312e9afe25..8a96e7a89e6b 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -336,6 +336,7 @@ struct trace_array {
>   	bool			allocated_snapshot;
>   	spinlock_t		snapshot_trigger_lock;
>   	unsigned int		snapshot;
> +	unsigned int		mapped;
>   	unsigned long		max_latency;
>   #ifdef CONFIG_FSNOTIFY
>   	struct dentry		*d_max_latency;

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


