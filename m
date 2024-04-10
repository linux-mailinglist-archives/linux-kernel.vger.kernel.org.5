Return-Path: <linux-kernel+bounces-139116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDD889FECE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1787E28595A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DB017F36D;
	Wed, 10 Apr 2024 17:41:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF62817994F;
	Wed, 10 Apr 2024 17:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770877; cv=none; b=LOQvebVVnbeD8ZpHiTs0qzDnGfuI6QmuJm1Y2nK7Bz1eGQqYNb0Zcv2l34Jokrpn2p8u5ctqXfXMVHySaKEsk7VGylFd8w6tFaP+oBqgleFDslna3fGWeRXbHi6Jet9caM0KKDdNISeVMFpM7S3gx8EVnEsZ29kl2FLQh79y7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770877; c=relaxed/simple;
	bh=0aKNApkH5cxJA6D2c8OOUEoVR19/Bs8/LdW506TRGlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3MBThtk9OJdI9XDAPtA1+vmPDeEjjFT/QLJ88VCQKGdnvtaLCz5mdMhbYPhH5PNzWAUW2RchUZt1Q3R1ZVLr74nb1AemWdyi9XYgwUls/ow+wluUwCbgx/zLdaky45dv52vxy/MRmn73I8U28e7/UXWDh6Gzrp7LDscFLXr6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB65C433F1;
	Wed, 10 Apr 2024 17:41:15 +0000 (UTC)
Date: Wed, 10 Apr 2024 13:43:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, rdunlap@infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v20 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20240410134352.66d35fbc@gandalf.local.home>
In-Reply-To: <20240406173649.3210836-3-vdonnefort@google.com>
References: <20240406173649.3210836-1-vdonnefort@google.com>
	<20240406173649.3210836-3-vdonnefort@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  6 Apr 2024 18:36:46 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> +int ring_buffer_map(struct trace_buffer *buffer, int cpu,
> +		    struct vm_area_struct *vma)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +	unsigned long flags, *subbuf_ids;
> +	int err = 0;
> +
> +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> +		return -EINVAL;
> +
> +	cpu_buffer = buffer->buffers[cpu];
> +
> +	mutex_lock(&cpu_buffer->mapping_lock);
> +
> +	if (cpu_buffer->mapped) {
> +		err = __rb_map_vma(cpu_buffer, vma);
> +		if (!err)
> +			err = __rb_inc_dec_mapped(cpu_buffer, true);
> +		mutex_unlock(&cpu_buffer->mapping_lock);
> +		return err;
> +	}
> +
> +	/* prevent another thread from changing buffer/sub-buffer sizes */
> +	mutex_lock(&buffer->mutex);
> +
> +	err = rb_alloc_meta_page(cpu_buffer);
> +	if (err)
> +		goto unlock;
> +
> +	/* subbuf_ids include the reader while nr_pages does not */
> +	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
> +	if (!subbuf_ids) {
> +		rb_free_meta_page(cpu_buffer);
> +		err = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	atomic_inc(&cpu_buffer->resize_disabled);
> +
> +	/*
> +	 * Lock all readers to block any subbuf swap until the subbuf IDs are
> +	 * assigned.
> +	 */
> +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
> +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> +
> +	err = __rb_map_vma(cpu_buffer, vma);
> +	if (!err) {
> +		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +		cpu_buffer->mapped = 1;
> +		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> +	} else {
> +		kfree(cpu_buffer->subbuf_ids);
> +		cpu_buffer->subbuf_ids = NULL;
> +		rb_free_meta_page(cpu_buffer);
> +	}
> +unlock:

Nit: For all labels, please add a space before them. Otherwise, diffs will
show "unlock" as the function and not "ring_buffer_map", making it harder
to find where the change is.

Same for the labels below.

-- Steve


> +	mutex_unlock(&buffer->mutex);
> +	mutex_unlock(&cpu_buffer->mapping_lock);
> +
> +	return err;
> +}
> +
> +int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +	unsigned long flags;
> +	int err = 0;
> +
> +	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> +		return -EINVAL;
> +
> +	cpu_buffer = buffer->buffers[cpu];
> +
> +	mutex_lock(&cpu_buffer->mapping_lock);
> +
> +	if (!cpu_buffer->mapped) {
> +		err = -ENODEV;
> +		goto out;
> +	} else if (cpu_buffer->mapped > 1) {
> +		__rb_inc_dec_mapped(cpu_buffer, false);
> +		goto out;
> +	}
> +
> +	mutex_lock(&buffer->mutex);
> +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +
> +	cpu_buffer->mapped = 0;
> +
> +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> +
> +	kfree(cpu_buffer->subbuf_ids);
> +	cpu_buffer->subbuf_ids = NULL;
> +	rb_free_meta_page(cpu_buffer);
> +	atomic_dec(&cpu_buffer->resize_disabled);
> +
> +	mutex_unlock(&buffer->mutex);
> +out:
> +	mutex_unlock(&cpu_buffer->mapping_lock);
> +
> +	return err;
> +}
> +
> +int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +	unsigned long reader_size;
> +	unsigned long flags;
> +
> +	cpu_buffer = rb_get_mapped_buffer(buffer, cpu);
> +	if (IS_ERR(cpu_buffer))
> +		return (int)PTR_ERR(cpu_buffer);
> +
> +	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +consume:
> +	if (rb_per_cpu_empty(cpu_buffer))
> +		goto out;
> +
> +	reader_size = rb_page_size(cpu_buffer->reader_page);
> +
> +	/*
> +	 * There are data to be read on the current reader page, we can
> +	 * return to the caller. But before that, we assume the latter will read
> +	 * everything. Let's update the kernel reader accordingly.
> +	 */
> +	if (cpu_buffer->reader_page->read < reader_size) {
> +		while (cpu_buffer->reader_page->read < reader_size)
> +			rb_advance_reader(cpu_buffer);
> +		goto out;
> +	}
> +
> +	if (WARN_ON(!rb_get_reader_page(cpu_buffer)))
> +		goto out;
> +
> +	goto consume;
> +out:
> +	/* Some archs do not have data cache coherency between kernel and user-space */
> +	flush_dcache_folio(virt_to_folio(cpu_buffer->reader_page->page));
> +
> +	rb_update_meta_page(cpu_buffer);
> +
> +	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> +	rb_put_mapped_buffer(cpu_buffer);
> +
> +	return 0;
> +}
> +
>  /*
>   * We only allocate new buffers, never free them if the CPU goes down.
>   * If we were to free the buffer, then the user would lose any trace that was in


