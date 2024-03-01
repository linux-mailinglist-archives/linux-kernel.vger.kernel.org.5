Return-Path: <linux-kernel+bounces-88639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E22386E4B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96FA2B22D02
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B27070030;
	Fri,  1 Mar 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EZod3tO4"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0C1F95F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709308198; cv=none; b=KaByxJybsC+36zUy3IcY6Is1fHkKpyA3TuFU9TVRlIFIL0hOG/BfI4rEkjvu3xHEWBrHsJPIAw/mj5D/i5OgRYzTvp7OPPNMyp60JeaWQ7G1HbrWzv5NgNOJxMuB24dIv0eXdgMWRZ6X2Pzp/bmsx3+ymKnMaJj/MHiNhrqqhuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709308198; c=relaxed/simple;
	bh=B32SD+v2fJY1qKDCGPDCH8R7sgMnBptIxaY0yF0bLMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsY830At50USrlfPK+3sFq1DbQMJYeNOKk6QrOyNdXhIk4H77sp+1s5Vn/T6o9e/ahZMFXIEntjtKij7cIY4rGbYQv5HPPzYasRWxneeptXIKkJmMlmj3Z0LZI9DotcSHSLE+h5mys++7QpH5WB5hX5v1PMJ89ygrgvWSWyRjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EZod3tO4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4429c556efso377018366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 07:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709308194; x=1709912994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VUzFdeN53i9tXm7MXEexoS0+mcu1uT+SkLKy7PDIFlc=;
        b=EZod3tO4AhibPQ7p5z5JbIj+zA7STJOz/jBKKK1u/YnYLAQx37SJcDA32vgwVt0WU6
         2GO3lpzHnE0uK3Q37rjdRiJHKmsvCTJCqWq/k+03qBZmxLZUjjk+YAa9cuUKQBlld7F7
         ShEIsUkKKMnvG7a2TGQvmbZPIHWWHrrvcDYnO9y07y/vVkD07Xnll9ddCNIicCz1zJyJ
         DuqVKXMvCSWqUKVHRIggEBbqiI9tBMR5W16w17C9xQpfWc7ulQpBkgqYUEux5TD8/AD4
         /KxoDGP7nhJixoV4q/b7cDYwX4afTxMCWcgMj/+pru4qCnPqV8ndQMV279fkKtIwuOS7
         +4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709308194; x=1709912994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUzFdeN53i9tXm7MXEexoS0+mcu1uT+SkLKy7PDIFlc=;
        b=EE0peiEeXGCblvmSCp2HUA9s8VH0frDD1Q7SDmJ8SLIhDjG6P6pvQz8I0HuYxrr1Md
         NnOIBqGmU5r1Dzq06sXWgKCndVmwZansXgYJhe/yHnP5W7kJAdg72i3yGJkk89w8sgb4
         Jz+lazf7gyFcvE4+DAELBBUKLRR+mBKFPV2EMOn+DkTx6/u5VsfrniYMFo8hdCQw6eZQ
         ujTnseuzJRPycQnqYEBhd6V+XAUID1/4OvRJ95hN28mrAAkrsMsp4HBvQqMFMkTcindY
         K+QS5NliXJituEvd7Xjf0LdlmwcE9BvG0RNGldqDKv4N60OJU/zE6FgStXMNXXXdn2bm
         E+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXs+6BuQFjRgQ7RKjem+GGrlcbwKfakVqXyTLQ2NwlTGqwZ/RBe/RpVl45AdALX358J0yxvNcmv2XSWk7KlJM51t4XqMh6QYhvtHUga
X-Gm-Message-State: AOJu0YwSQS7nCOOs928LaVhTGsts/gLGUk2Jy0Eze292I4Z/V8ZHVmKX
	ZhVq/bXtPna0XaA29Cs+ASbd+7GDXKroAaTx2Jkf0SwMxsOwefGmS1a2JhrjvLg=
X-Google-Smtp-Source: AGHT+IHDOHTD1ITVXnoJ61qj8yPgxmN6T4g2ue9+Fmw1/FPkJm86Sr71R9hYqb2Qw+Qpv5vJv+p9jw==
X-Received: by 2002:a17:906:4148:b0:a44:f89:a04e with SMTP id l8-20020a170906414800b00a440f89a04emr1878722ejk.35.1709308194170;
        Fri, 01 Mar 2024 07:49:54 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id vw3-20020a170907a70300b00a42ee2af521sm1795253ejc.137.2024.03.01.07.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 07:49:53 -0800 (PST)
Date: Fri, 1 Mar 2024 16:49:52 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: flush was: Re: [PATCH printk v2 22/26] printk: nbcon: Implement
 emergency sections
Message-ID: <ZeH5IAKyNbwL9wek@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-23-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-23-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:22, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> In emergency situations (something has gone wrong but the
> system continues to operate), usually important information
> (such as a backtrace) is generated via printk(). Each
> individual printk record has little meaning. It is the
> collection of printk messages that is most often needed by
> developers and users.
> 
> In order to help ensure that the collection of printk messages
> in an emergency situation are all stored to the ringbuffer as
> quickly as possible, disable console output for that CPU while
> it is in the emergency situation. When exiting the emergency
> situation, trigger the consoles to be flushed.
> 
> Add per-CPU emergency nesting tracking because an emergency
> can arise while in an emergency situation.
> 
> Add functions to mark the beginning and end of emergency
> sections where the urgent messages are generated.
> 
> Do not print if the current CPU is in an emergency state.
> 
> Trigger console flushing when exiting all emergency nesting.
> 
> Note that the emergency state is not system-wide. While one CPU
> is in an emergency state, another CPU may continue to print
> console messages.
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1105,6 +1134,58 @@ void nbcon_atomic_flush_unsafe(void)
>  	__nbcon_atomic_flush_all(prb_next_reserve_seq(prb), true);
>  }
>  
> +/**
> + * nbcon_cpu_emergency_enter - Enter an emergency section where printk()
> + *	messages for that CPU are only stored
> + *
> + * Upon exiting the emergency section, all stored messages are flushed.
> + *
> + * Context:	Any context. Disables preemption.
> + *
> + * When within an emergency section, no printing occurs on that CPU. This
> + * is to allow all emergency messages to be dumped into the ringbuffer before
> + * flushing the ringbuffer. The actual printing occurs when exiting the
> + * outermost emergency section.
> + */
> +void nbcon_cpu_emergency_enter(void)
> +{
> +	unsigned int *cpu_emergency_nesting;
> +
> +	preempt_disable();
> +
> +	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> +	(*cpu_emergency_nesting)++;
> +}
> +
> +/**
> + * nbcon_cpu_emergency_exit - Exit an emergency section and flush the
> + *	stored messages
> + *
> + * Flushing only occurs when exiting all nesting for the CPU.
> + *
> + * Context:	Any context. Enables preemption.
> + */
> +void nbcon_cpu_emergency_exit(void)
> +{
> +	unsigned int *cpu_emergency_nesting;
> +	bool do_trigger_flush = false;
> +
> +	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
> +
> +	WARN_ON_ONCE(*cpu_emergency_nesting == 0);
> +
> +	if (*cpu_emergency_nesting == 1)
> +		do_trigger_flush = true;
> +
> +	/* Undo the nesting count of nbcon_cpu_emergency_enter(). */
> +	(*cpu_emergency_nesting)--;
> +
> +	preempt_enable();
> +
> +	if (do_trigger_flush)
> +		printk_trigger_flush();

Just an idea. printk_trigger_flush() calls defer_console_output().
It always moves the flushing into IRQ context.

It might make sense to add a flush() function which would try
to flush the messages directly from this context and
queue the IRQ work only when it fails. Something like:

void printk_emergency_flush()
{
	/* nbcon consoles could be flushed in any context. */
	if (have_nbcon_console)
		nbcon_flush_all();

	if (have_legacy_console) {
		if (console_trylock())
			console_unlock();
		else
			defer_console_output();
	}
}

But wait, nbcon_flush_all() might have troubles to get the per-console
lock because it would be called with NBCON_PRIO_NORMAL.


Wait, wait, wait.

defer_console_output() schedules wake_up_klogd_work_func(). It flushes
only legacy consoles. It means that even emergency messages would
need to wait for the printk kthread.

By other words, it seems that the emergency context does not have any
effect for nbcon consoles.

It brings a question if any code would need to acquire the emergency
context at all.

I quess that this does not work as expected.

Or do I miss anything, please?

Best Regards,
Petr

