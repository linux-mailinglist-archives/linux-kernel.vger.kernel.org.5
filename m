Return-Path: <linux-kernel+bounces-88430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EF786E182
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A043528366B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932AD67E74;
	Fri,  1 Mar 2024 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H/96Tmb7"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544073C6BF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 13:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709298313; cv=none; b=YcrrA1Kc7LkI1jNSM6hYOVfBt4fcWbeFk0Z0oc3GZRV7ZSFaxcZsDjhPtjbVC299m3u3MAmOmkKdu+jItI04jjFS7b/s0eCJLmisc+v8C0cNdVBIovsQbNIuoRtOYmBxZiSSjjmqGxpE4Rf8Yg4IzFuKAMq972DTQSwNVbdv6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709298313; c=relaxed/simple;
	bh=eiOHw3qZ8j+LmdiQ489pmHP2NA5E/VucLFQQLEqsHUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfY9WLRJOzLcyfkSJD03mMpbFxQdpAjMtkStabuqd9W+XlA9nCOxh8QRKJ6IfINCnIO0izkV96gNYrha7eMhuBVlR66p8A+vSAqe23I+LpFrfVYZeT5ZXzltk0C9TobQ/iLP2N56YByqYh6NqgpfoClfsoxEQf0h22N6Bd80ZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H/96Tmb7; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so537118966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 05:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709298308; x=1709903108; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUSkv4J7lY0gA86SRBrdJGFsFL5j/+V5FBtnGqWaqo4=;
        b=H/96Tmb7EMpSm7IEp25Cy3IENRAiHldsNmrAv/2Ne8AviThKLp4nTFqg+0KNSoG5oq
         dDJoNe1o3Yfb9KY5G534beDehJ+6pE0eNLs6446F4puD299EpyYWlkHYQKxv3XaZR5Yg
         Qx7duaHQ+ya8ozW/mvk6DcjciR8o96hlvhksgjgjd/I8P3gFYkXCASKNqGWC8bbph1cp
         fgyKcQOKXZa7SZG+CfMtoY3Nq8MGtFT5pt652Sc4cO3EOqdOmmxdwA1veXuHU7MLTKBJ
         UDE0o6w2n6D8t2/lVdzUvxAZ3TO5YRNOZcqVubiBSw6hpRydTkicfCWbnTiV8Y9m3GH7
         ka2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709298308; x=1709903108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUSkv4J7lY0gA86SRBrdJGFsFL5j/+V5FBtnGqWaqo4=;
        b=ixPuB8p+iwYQdPUdIwtJyB4646tEbt4vSvBjDLmv9rai3dzmnb7rK9OsYY6ZeEaeqe
         TqkM5tYsCZ9Yx4cIRJ5DFy0pWsTxvSk6lRhe6qyFzWzxrkb2uWyhFCM40I6TT5kOE4nj
         wyhMX2oco3xRfBRbfptPKh/6lFVZZVyBNp/ML5HEqHOufFYooq/VhXXoo2fxp4xUGJwi
         6I8dwLdVdBiMymTdcFX/rkdzPfjtlxqw8xVsb4M/0UQsMrvGWAdpizNCeiKABg1POfYy
         1KRP6V+cK8v2j4Lj2uILdHmpFvMxZ+13QA7sOMBJ84utFPTJNCe6hnXjRA+s4Pr0x1ar
         aQ/A==
X-Forwarded-Encrypted: i=1; AJvYcCX3NR5R9DzoAD3oucBH6pwem3sWgz+ttzigAJORadTXkdDBOWb+4xUfBtOJcwsDtK4ByRYr3xc6O2s+OL4MZDsNa0ZenpfGCS7Xz/6L
X-Gm-Message-State: AOJu0Ywt/g6W4YN8iOHsyA7/P+CBTrDiQJ21+lj1lkmi+DQaGOf8Nq9l
	q7Nh0bVmaOl65Issuv6IOI0jlhFWgTXdT8svNmLNTM3krXj23DId2zPtmJvsej0=
X-Google-Smtp-Source: AGHT+IEZ2gQ06v0u2rPS05ENVjEjkVLtDrsmQo4iigd5rRxSgq2aOrJCVD9mARAAfYfHn7jBZqC6Tg==
X-Received: by 2002:a17:906:3c13:b0:a44:b96:2809 with SMTP id h19-20020a1709063c1300b00a440b962809mr1689424ejg.24.1709298308557;
        Fri, 01 Mar 2024 05:05:08 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id qw16-20020a1709066a1000b00a3edb758561sm1674232ejc.129.2024.03.01.05.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:05:08 -0800 (PST)
Date: Fri, 1 Mar 2024 14:05:05 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH printk v2 21/26] printk: Coordinate direct printing in
 panic
Message-ID: <ZeHSgZs9I3Ihvpye@alley>
References: <20240218185726.1994771-1-john.ogness@linutronix.de>
 <20240218185726.1994771-22-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218185726.1994771-22-john.ogness@linutronix.de>

On Sun 2024-02-18 20:03:21, John Ogness wrote:
> Perform printing by nbcon consoles on the panic CPU from the
> printk() caller context in order to get panic messages printed
> as soon as possible.
> 
> If legacy and nbcon consoles are registered, the legacy consoles
> will no longer perform direct printing on the panic CPU until
> after the backtrace has been stored. This will give the safe
> nbcon consoles a chance to print the panic messages before
> allowing the unsafe legacy consoles to print.
> 
> If no nbcon consoles are registered, there is no change in
> behavior (i.e. legacy consoles will always attempt to print
> from the printk() caller context).

> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -370,6 +370,8 @@ void panic(const char *fmt, ...)
>  	 */
>  	atomic_notifier_call_chain(&panic_notifier_list, 0, buf);
>  
> +	printk_legacy_allow_panic_sync();

I would call this before the panic notifiers. They are known
to cause problems.

It was the reason to introduce "crash_kexec_post_notifiers" parameter.
Also there is a patchset which tries to somehow split them
by purpose, see
https://lore.kernel.org/all/20220427224924.592546-23-gpiccoli@igalia.com/

It brings another question whether to try flushing the legacy consoles
before calling the notifiers.

>  	panic_print_sys_info(false);
>  
>  	kmsg_dump(KMSG_DUMP_PANIC);
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2329,12 +2329,23 @@ int vprintk_store(int facility, int level,
>  	return ret;
>  }
>  
> +static bool legacy_allow_panic_sync;
> +
> +/*
> + * This acts as a one-way switch to allow legacy consoles to print from
> + * the printk() caller context on a panic CPU.
> + */
> +void printk_legacy_allow_panic_sync(void)
> +{
> +	legacy_allow_panic_sync = true;

I would flush the legacy consoles here. Otherwise it might be done
by another random printk() from the notifiers or by the even more
unsafe printk_console_flush_in_panic().

I mean to do something like:

	if (printing_via_unlock && console_trylock)
		console_unlock();

> +}
> +
>  asmlinkage int vprintk_emit(int facility, int level,
>  			    const struct dev_printk_info *dev_info,
>  			    const char *fmt, va_list args)
>  {
> +	bool do_trylock_unlock = printing_via_unlock;
>  	int printed_len;
> -	bool in_sched = false;
>  
>  	/* Suppress unimportant messages after panic happens */
>  	if (unlikely(suppress_printk))
> @@ -2350,15 +2361,43 @@ asmlinkage int vprintk_emit(int facility, int level,
>  
>  	if (level == LOGLEVEL_SCHED) {
>  		level = LOGLEVEL_DEFAULT;
> -		in_sched = true;
> +		/* If called from the scheduler, we can not call up(). */
> +		do_trylock_unlock = false;
>  	}
>  
>  	printk_delay(level);
>  
>  	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
>  
> -	/* If called from the scheduler, we can not call up(). */
> -	if (!in_sched && printing_via_unlock) {
> +	if (!have_boot_console && have_nbcon_console) {

Nit: The opposite order is more logic ;-)

	if (have_nbcon_console && !have_boot_console) {

> +		bool is_panic_context = this_cpu_in_panic();
> +
> +		/*
> +		 * In panic, the legacy consoles are not allowed to print from
> +		 * the printk calling context unless explicitly allowed. This
> +		 * gives the safe nbcon consoles a chance to print out all the
> +		 * panic messages first. This restriction only applies if
> +		 * there are nbcon consoles registered.
> +		 */
> +		if (is_panic_context)
> +			do_trylock_unlock &= legacy_allow_panic_sync;
> +
> +		/*
> +		 * There are situations where nbcon atomic printing should
> +		 * happen in the printk() caller context:
> +		 *
> +		 * - When this CPU is in panic.
> +		 *
> +		 * Note that if boot consoles are registered, the
> +		 * console_lock/console_unlock dance must be relied upon
> +		 * instead because nbcon consoles cannot print simultaneously
> +		 * with boot consoles.
> +		 */
> +		if (is_panic_context)
> +			nbcon_atomic_flush_all();
> +	}
> +
> +	if (do_trylock_unlock) {
>  		/*
>  		 * The caller may be holding system-critical or
>  		 * timing-sensitive locks. Disable preemption during

Otherwise, it looks good.

Best Regards,
Petr

