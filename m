Return-Path: <linux-kernel+bounces-8879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0E081BD97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CC6288D76
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC3E634E5;
	Thu, 21 Dec 2023 17:50:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBB5BA2F;
	Thu, 21 Dec 2023 17:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44821C433C8;
	Thu, 21 Dec 2023 17:50:21 +0000 (UTC)
Date: Thu, 21 Dec 2023 12:51:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v9 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <20231221125124.49ee8201@gandalf.local.home>
In-Reply-To: <20231221173523.3015715-2-vdonnefort@google.com>
References: <20231221173523.3015715-1-vdonnefort@google.com>
	<20231221173523.3015715-2-vdonnefort@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Dec 2023 17:35:22 +0000
Vincent Donnefort <vdonnefort@google.com> wrote:

> @@ -739,6 +747,22 @@ static __always_inline bool full_hit(struct trace_buffer *buffer, int cpu, int f
>  	return (dirty * 100) > (full * nr_pages);
>  }
>  
> +static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
> +{
> +	if (unlikely(READ_ONCE(cpu_buffer->mapped))) {
> +		/* Ensure the meta_page is ready */
> +		smp_rmb();
> +		WRITE_ONCE(cpu_buffer->meta_page->entries,
> +			   local_read(&cpu_buffer->entries));
> +		WRITE_ONCE(cpu_buffer->meta_page->overrun,
> +			   local_read(&cpu_buffer->overrun));
> +		WRITE_ONCE(cpu_buffer->meta_page->subbufs_touched,
> +			   local_read(&cpu_buffer->pages_touched));
> +		WRITE_ONCE(cpu_buffer->meta_page->subbufs_lost,
> +			   local_read(&cpu_buffer->pages_lost));
> +	}
> +}
> +
>  /*
>   * rb_wake_up_waiters - wake up tasks waiting for ring buffer input
>   *
> @@ -749,6 +773,18 @@ static void rb_wake_up_waiters(struct irq_work *work)
>  {
>  	struct rb_irq_work *rbwork = container_of(work, struct rb_irq_work, work);
>  
> +	if (rbwork->is_cpu_buffer) {
> +		struct ring_buffer_per_cpu *cpu_buffer;
> +
> +		cpu_buffer = container_of(rbwork, struct ring_buffer_per_cpu,
> +					  irq_work);
> +		/*
> +		 * If the waiter is a cpu_buffer, this might be due to a
> +		 * userspace mapping. Let's update the meta-page.
> +		 */
> +		rb_update_meta_page(cpu_buffer);
> +	}
> +
>  	wake_up_all(&rbwork->waiters);
>  	if (rbwork->full_waiters_pending || rbwork->wakeup_full) {
>  		rbwork->wakeup_full = false;


I think this code would be cleaner if we did:

static void rb_update_meta_page(strucrt rb_irq_work *rbwork)
{
	struct ring_buffer_per_cpu *cpu_buffer;

	if (!rbwork->is_cpu_buffer)
		return;

	/*
	 * If the waiter is a cpu_buffer, this might be due to a
	 * userspace mapping. Let's update the meta-page.
	 */
	cpu_buffer = container_of(rbwork, struct ring_buffer_per_cpu,
				  irq_work);

	if (unlikely(READ_ONCE(cpu_buffer->mapped))) {

// I don't think we need the "unlikely"

		/* Ensure the meta_page is ready */
		smp_rmb();
		WRITE_ONCE(cpu_buffer->meta_page->entries,
			   local_read(&cpu_buffer->entries));
		WRITE_ONCE(cpu_buffer->meta_page->overrun,
			   local_read(&cpu_buffer->overrun));
		WRITE_ONCE(cpu_buffer->meta_page->subbufs_touched,
			   local_read(&cpu_buffer->pages_touched));
		WRITE_ONCE(cpu_buffer->meta_page->subbufs_lost,
			   local_read(&cpu_buffer->pages_lost));
	}
}

/*
 * rb_wake_up_waiters - wake up tasks waiting for ring buffer input
 *
 * Schedules a delayed work to wake up any task that is blocked on the
 * ring buffer waiters queue.
 */
static void rb_wake_up_waiters(struct irq_work *work)
{
	struct rb_irq_work *rbwork = container_of(work, struct rb_irq_work, work);

	rb_update_meta_page(cpu_buffer);

	wake_up_all(&rbwork->waiters);
	if (rbwork->full_waiters_pending || rbwork->wakeup_full) {
		rbwork->wakeup_full = false;
		rbwork->full_waiters_pending = false;
		wake_up_all(&rbwork->full_waiters);
	}
}


-- Steve

