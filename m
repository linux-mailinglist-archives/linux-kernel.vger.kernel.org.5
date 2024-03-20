Return-Path: <linux-kernel+bounces-108391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 020138809EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 348B6287B1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 02:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EE321100;
	Wed, 20 Mar 2024 02:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y4YV3rf9"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659D6101C6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 02:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710902789; cv=none; b=sIW/zhM61u+Y1vnn4aqYYbnzgANWL+5o2QGO6ImogNAK3QqpUOR1rnOy+OfXy9dHQbXbETkSPHKBh6h22MNnc+1iFGBGP5UfNAC6tsopNEZSkkqrdUEKxni3jPDRCs6NvYpu5CtSgmQ4ajFUsq32D3sBVO6q91kfVwESVf8gQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710902789; c=relaxed/simple;
	bh=mPO5wkSj7MvFl1OoBmiVEfQ8sWGvUJ1bNGgeytCyEMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8dn4x5uUhs0MkxYBEw36h6ubntHwaiRetenAp+sCUOhQSrOYdwO5DpMMH7IrHvJAO4+J7oDOI5Sw72PwbYVvJOJzlHOR2NPGm7Xu6NxkZIU5pCwqme2TWGQr4tztfkyyncfHzFftH7iSTEhmsmd8hJRYwwEU9JpBemV3J6afd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y4YV3rf9; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6adc557b6so5810774b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710902788; x=1711507588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cGTF9Nqn4Dca/jo1w4nba4BHLmqxxk4U39bw7VuO9FI=;
        b=Y4YV3rf9p6POl92vrJxrUsFclFbxS4vY9XfTQ1NcOsR7DFkjfW8b5mXrd+bI3CYbzE
         UdoT3eiFca4U4B/hyXuuv5k5HueQ4kt6MB4l0NlNvgXYoY5saqCUj5hRBaQHt+lwHFY2
         tsRnOJBBvynIcgRhOWSikLUnpil0KYkn02t7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710902788; x=1711507588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGTF9Nqn4Dca/jo1w4nba4BHLmqxxk4U39bw7VuO9FI=;
        b=aaDoanz/Srlf3zxJSPWGV6J07rBXUcZKcR2yDxoxbLpEQsk5zjJ14tDj7xiamjB2uY
         wC6xEbRPeb67hRpJy8E1bPXmHxXtpshplSCREgfZlTX0p8HnVecsa9XVPhPdNvg0Ijay
         MA8DbPaz8fskYiIKWgUcv8gDR7tXreDTQZClLTq+FhDuHhp2hAo6WhwOeHL7zbogmveF
         dbLXOdqa6EsPRqq8TRVye/ChEwpi0QDI0Anhwhrz6VgvNhMTXplSIU5e3Z4pdKrtX9Wi
         w4/RxK+T7izfvZut6P3rM0dkZPkEzpA6yEDXWzddIaD9wlvgFtvXrpXaaf0P5XOZMCWR
         pjHg==
X-Forwarded-Encrypted: i=1; AJvYcCW0ESts+xxTz6c6yt0mDtSku1v/gK92DKy8qWnQN5w/tYa36YB7+2kx2r9ZtYqw0tm/KBq6IEProPAgLwGw/y2xvrl0dlS+Au/KBnVK
X-Gm-Message-State: AOJu0YyadXesHleWq55+kSgdpJueOKcEovV137CGWt+94S1QsGpo/phA
	Kq4Z9h6SwrYV+WXssZRIGdJjZqlOnZ6GEYusCaIMELScwNEuFkdfhb+288Rmrg==
X-Google-Smtp-Source: AGHT+IHMO54sk1bZevLf6ifDyik54S8eAD4YWyeqV6LU2GS67mRVS0zXx3gGjb3AIaL23q+4sbrK8w==
X-Received: by 2002:a05:6a20:e68f:b0:1a3:5581:1692 with SMTP id mz15-20020a056a20e68f00b001a355811692mr14963645pzb.30.1710902787798;
        Tue, 19 Mar 2024 19:46:27 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kx16-20020a17090b229000b0029b77fbeb7fsm321684pjb.16.2024.03.19.19.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 19:46:26 -0700 (PDT)
Date: Tue, 19 Mar 2024 19:46:26 -0700
From: Kees Cook <keescook@chromium.org>
To: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Cc: linux@armlinux.org.uk, arnd@arndb.de, rmk+kernel@armlinux.org.uk,
	haibo.li@mediatek.com, angelogioacchino.delregno@collabora.com,
	amergnat@baylibre.com, akpm@linux-foundation.org,
	dave.hansen@linux.intel.com, douzhaolei@huawei.com,
	gustavoars@kernel.org, jpoimboe@kernel.org,
	kepler.chenxin@huawei.com, kirill.shutemov@linux.intel.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	nixiaoming@huawei.com, peterz@infradead.org, wangbing6@huawei.com,
	wangfangpeng1@huawei.com, jannh@google.com, David.Laight@aculab.com
Subject: Re: [PATCH] ARM: unwind: improve unwinders for noreturn case
Message-ID: <202403191945.661DBCE8@keescook>
References: <1709516385-7778-1-git-send-email-xiaojiangfeng@huawei.com>
 <1710901169-22763-1-git-send-email-xiaojiangfeng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1710901169-22763-1-git-send-email-xiaojiangfeng@huawei.com>

On Wed, Mar 20, 2024 at 10:19:29AM +0800, Jiangfeng Xiao wrote:
> This is an off-by-one bug which is common in unwinders,
> due to the fact that the address on the stack points
> to the return address rather than the call address.
> 
> So, for example, when the last instruction of a function
> is a function call (e.g., to a noreturn function), it can
> cause the unwinder to incorrectly try to unwind from
> the function after the callee.
> 
> foo:
> ...
> 	bl	bar
> ... end of function and thus next function ...
> 
> which results in LR pointing into the next function.
> 
> Fixed this by subtracting 1 from frmae->pc in the call frame
> (but not exception frames) like ORC on x86 does.
> 
> Refer to the unwind_next_frame function in the unwind_orc.c
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Link: https://lkml.kernel.org/lkml/20240305175846.qnyiru7uaa7itqba@treble/
> Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
> ---
>  arch/arm/include/asm/stacktrace.h |  4 ----
>  arch/arm/kernel/stacktrace.c      |  2 --
>  arch/arm/kernel/traps.c           |  4 ++--
>  arch/arm/kernel/unwind.c          | 18 +++++++++++++++---
>  4 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/include/asm/stacktrace.h b/arch/arm/include/asm/stacktrace.h
> index 360f0d2..07e4c16 100644
> --- a/arch/arm/include/asm/stacktrace.h
> +++ b/arch/arm/include/asm/stacktrace.h
> @@ -21,9 +21,7 @@ struct stackframe {
>  	struct llist_node *kr_cur;
>  	struct task_struct *tsk;
>  #endif
> -#ifdef CONFIG_UNWINDER_FRAME_POINTER
>  	bool ex_frame;
> -#endif
>  };
>  
>  static __always_inline
> @@ -37,9 +35,7 @@ void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame)
>  		frame->kr_cur = NULL;
>  		frame->tsk = current;
>  #endif
> -#ifdef CONFIG_UNWINDER_FRAME_POINTER
>  		frame->ex_frame = in_entry_text(frame->pc);
> -#endif
>  }
>  
>  extern int unwind_frame(struct stackframe *frame);
> diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
> index 620aa82..1abd4f9 100644
> --- a/arch/arm/kernel/stacktrace.c
> +++ b/arch/arm/kernel/stacktrace.c
> @@ -154,9 +154,7 @@ static void start_stack_trace(struct stackframe *frame, struct task_struct *task
>  	frame->kr_cur = NULL;
>  	frame->tsk = task;
>  #endif
> -#ifdef CONFIG_UNWINDER_FRAME_POINTER
>  	frame->ex_frame = in_entry_text(frame->pc);
> -#endif
>  }
>  
>  void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 3bad79d..b64e442 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -84,10 +84,10 @@ void dump_backtrace_entry(unsigned long where, unsigned long from,
>  	printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
>  		loglvl, where, from);
>  #elif defined CONFIG_BACKTRACE_VERBOSE
> -	printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS)\n",
> +	pr_warn("%s[<%08lx>] (%ps) from [<%08lx>] (%pB)\n",
>  		loglvl, where, (void *)where, from, (void *)from);

This should stay printk("%s...", loglvl, ...) or loglvl should be
dropped when converting to pr_warn():

	pr_warn([<%08lx>] (%ps) from [<%08lx>] (%pB)\n",
		where, (void *)where, from, (void *)from);

Why did you want to force the "warn" log level?

>  #else
> -	printk("%s %ps from %pS\n", loglvl, (void *)where, (void *)from);
> +	pr_warn("%s %ps from %pB\n", loglvl, (void *)where, (void *)from);

Ditto.

-Kees

-- 
Kees Cook

