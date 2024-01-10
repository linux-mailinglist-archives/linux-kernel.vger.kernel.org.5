Return-Path: <linux-kernel+bounces-21965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE87282973E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AEB1C2649D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494093FB13;
	Wed, 10 Jan 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jI4R0W4W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hqY4IDiK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A0F405D0;
	Wed, 10 Jan 2024 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704882048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7RufLAkoxzZoArcRqZDUJRVRYSejYvMj2QfFs/COrt4=;
	b=jI4R0W4W8BjVrn3dTewNrF8jXerGbePZQxIRZdeu+eS+r2dF/I65u0BnoCkhD3pLtixIOg
	r5MX4DsJ8yWzLzThoVcDFpTbVD8Up67buN/UHegbDU8W1xTofM6aaFPmjinC5tFe9X745k
	KbeVfQYYGzady/0rx70+fu94+pECF4+hBzzxLUo0oRPc17veluEiA/MCPXwm8PWioSF22y
	lNDGdlPPnpruSGNAg1mCuin5jYoghVdYgfR/SvkjXbk1rXjsyQhdKejd+Ea8n96JU4H5tJ
	Xr9kCvAhdNMlvZa1EV2QfDVEoReC1fpFXlbDkZW0vr4IPnXpsE+lyly629VrBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704882048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7RufLAkoxzZoArcRqZDUJRVRYSejYvMj2QfFs/COrt4=;
	b=hqY4IDiKDeChNoVtN4UC+Jj6Iwjs4Gif/KPAkeGUDokbyJ8iHARwXs2LN7JV1zcV1v9QsT
	W5r1ZGsjdb4TBcDA==
To: Sreenath Vijayan <sreenath.vijayan@sony.com>, sreenath.vijayan@sony.com,
 rdunlap@infradead.org
Cc: anandakumar.balasubramaniam@sony.com, taichi.shimoyashiki@sony.com,
	pmladek@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org,
	jirislaby@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        senozhatsky@chromium.org, rostedt@goodmis.org
Subject: Re: [PATCH v2] tty/sysrq: Dump printk ring buffer messages via sysrq
In-Reply-To: <20240110155634.1685656-1-sreenath.vijayan@sony.com>
References: <20231221133953.1507021-1-sreenath.vijayan@sony.com>
 <20240110155634.1685656-1-sreenath.vijayan@sony.com>
Date: Wed, 10 Jan 2024 11:26:45 +0106
Message-ID: <874jfllcaq.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-01-10, Sreenath Vijayan <sreenath.vijayan@sony.com> wrote:
> When terminal is unresponsive, one cannot use dmesg to view printk
> ring buffer messages. Also, syslog services may be disabled,
> to check them after a reboot, especially on embedded systems.
> In this scenario, dump the printk ring buffer messages via sysrq
> by pressing sysrq+D.

Generally speaking, I like this idea. I also like that you do not
re-flood the kernel buffers and instead just print directly to the
consoles. (I wish sysrq+z with ftrace did that as well.)

Relying on a workqueue will really limit the usefulness of this
feature. Safe efforts could be made to print directly from the interrupt
context. But maybe this approach can be accepted for now as being
"better than nothing", which can be improved upon in the future (for
example, when atomic consoles are available).

Some more comments from me below...

> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index 02217e3c916b..62b3911f03b5 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -450,6 +452,51 @@ static const struct sysrq_key_op sysrq_unrt_op = {
>  	.enable_mask	= SYSRQ_ENABLE_RTNICE,
>  };
>  
> +static void dmesg_dump_callback(struct work_struct *work)
> +{
> +	struct kmsg_dump_iter iter;
> +	size_t len;
> +	char *buf;
> +	struct console *con;
> +	int cookie;
> +
> +	/* Size to be updated if PRINTK_MESSAGE_MAX changes */
> +	buf = kzalloc(2048, GFP_KERNEL);
> +	if (!buf)
> +		return;
> +
> +	kmsg_dump_rewind(&iter);
> +	while (kmsg_dump_get_line(&iter, 1, buf, 2048, &len)) {
> +		/*
> +		 * Since using printk() or pr_*() will append the message to the
> +		 * printk ring buffer, they cannot be used to display the retrieved
> +		 * message. Hence console_write() of serial drivers is used.
> +		 */
> +		console_lock();
> +		cookie = console_srcu_read_lock();
> +		for_each_console_srcu(con) {
> +			if ((console_srcu_read_flags(con) & CON_ENABLED) && con->write)
> +				con->write(con, buf, len);
> +		}
> +		console_srcu_read_unlock(cookie);
> +		console_unlock();
> +	}
> +	kfree(buf);
> +}

Rather than implementing all this in drivers/tty/sysrq.c it would
probably be better to just call a new function that is implemented in
kernel/printk/printk.c. Then you would have access to printk-private
items (such as the PRINTK_MESSAGE_MAX macro).

For example, sysrq+z just calls ftrace_dump(), which is implemented in
kernel/trace/trace.c.

John Ogness

