Return-Path: <linux-kernel+bounces-18948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A8C82658B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF1AC28191F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 18:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B899D13FF8;
	Sun,  7 Jan 2024 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dwENUuli"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3E13FF0
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 18:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2FDC433C8;
	Sun,  7 Jan 2024 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1704651664;
	bh=sZPBGcFilnJgnQg/CYPYjTdMMjgjwjmQd4ivbtePeo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dwENUuliYF0nyFc92wP0odwzDw6aRV3mytuf+PZjrGFOYpUd7Ezxyeyxi0wk2Egpx
	 osKfrTzGM/WcEL+7B5syCr0rK7pRVC4IbMyNWOH8JVJqqPxICMNKtKrZpyoCg3FaRc
	 7NwZy+Vj0O8vpxN6eARxoDrgbjPmTUSe/5FtLDIk=
Date: Sun, 7 Jan 2024 10:21:03 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, pmladek@suse.com, gcc@gcc.gnu.org
Subject: Re: [PATCH] panic: suppress gnu_printf warning
Message-Id: <20240107102103.3c0ba0cfa4df37df4b59090e@linux-foundation.org>
In-Reply-To: <20240107091641.579849-1-bhe@redhat.com>
References: <20240107091641.579849-1-bhe@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun,  7 Jan 2024 17:16:41 +0800 Baoquan He <bhe@redhat.com> wrote:

> with GCC 13.2.1 and W=1, there's compiling warning like this:
> 
> kernel/panic.c: In function ‘__warn’:
> kernel/panic.c:676:17: warning: function ‘__warn’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
>   676 |                 vprintk(args->fmt, args->args);
>       |                 ^~~~~~~
> 
> The normal __printf(x,y) adding can't fix it. So add workaround which
> disables -Wsuggest-attribute=format to mute it.
> 
> ...
>
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -666,8 +666,13 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>  		pr_warn("WARNING: CPU: %d PID: %d at %pS\n",
>  			raw_smp_processor_id(), current->pid, caller);
>  
> +#pragma GCC diagnostic push
> +#ifndef __clang__
> +#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
> +#endif
>  	if (args)
>  		vprintk(args->fmt, args->args);
> +#pragma GCC diagnostic pop
>  
>  	print_modules();

__warn() clearly isn't such a candidate.  I'm suspecting that gcc's
implementation of this warning is pretty crude.  Is it a new thing in
gcc-13.2?  

A bit of context for gcc@gcc.gnu.org:

struct warn_args {
	const char *fmt;
	va_list args;
};

...

void __warn(const char *file, int line, void *caller, unsigned taint,
	    struct pt_regs *regs, struct warn_args *args)
{
	disable_trace_on_warning();

	if (file)
		pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
			raw_smp_processor_id(), current->pid, file, line,
			caller);
	else
		pr_warn("WARNING: CPU: %d PID: %d at %pS\n",
			raw_smp_processor_id(), current->pid, caller);

	if (args)
		vprintk(args->fmt, args->args);

	print_modules();

	if (regs)
		show_regs(regs);

	check_panic_on_warn("kernel");

	if (!regs)
		dump_stack();

	print_irqtrace_events(current);

	print_oops_end_marker();
	trace_error_report_end(ERROR_DETECTOR_WARN, (unsigned long)caller);

	/* Just a warning, don't kill lockdep. */
	add_taint(taint, LOCKDEP_STILL_OK);
}


