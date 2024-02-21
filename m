Return-Path: <linux-kernel+bounces-75560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C993585EB27
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E611F23107
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0D0126F05;
	Wed, 21 Feb 2024 21:41:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4EC3A29E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551711; cv=none; b=Pyu3vMWI4zc2i7yXyGLcNDFbobT+fJI6S4DaRlBN4GQaLJ9s6nUSIQmV94KaKkB/ktba5SSgBKGYTelpufotvSYRvSM8QAdzTFdQG+tWBdYbuZEz37vYw26OLt+OR1qVHLrxGMTrqmWt+4c+JK6ePHUAaNpDM+JTvsT1Jvs6QNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551711; c=relaxed/simple;
	bh=d7/joy0XNoKq7lVN0TkivAlL4rc7XS6A8yuuGogrW+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OT/743cK91EV8L7B4OoeKhBSmne6KiRb29pVzW00k0kcgS0L4NbFtod6zbtrKlwxAgHEsZrZWvsbbLdM6yeV40LToD7JaoGQ+ZrRGD9zKTLZQmlysKsU4Rl9E2ZM3a578WAdWp2LLsG33kUP/zC4iYeYYcj6wD/IbPqDinAAGhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C729C433C7;
	Wed, 21 Feb 2024 21:41:46 +0000 (UTC)
Date: Wed, 21 Feb 2024 16:43:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, peterz@infradead.org,
 torvalds@linux-foundation.org, paulmck@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
 jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
 richard@nod.at, mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
 Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 29/30] Documentation: tracing: add TIF_NEED_RESCHED_LAZY
Message-ID: <20240221164334.6f8c69e8@gandalf.local.home>
In-Reply-To: <20240213055554.1802415-30-ankur.a.arora@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
	<20240213055554.1802415-30-ankur.a.arora@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 21:55:53 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> Document various combinations of resched flags.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  Documentation/trace/ftrace.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 7e7b8ec17934..7f20c0bae009 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -1036,8 +1036,12 @@ explains which is which.
>  		be printed here.
>  
>    need-resched:
> -	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED is set,
> +	- 'B' all three, TIF_NEED_RESCHED, TIF_NEED_RESCHED_LAZY and PREEMPT_NEED_RESCHED are set,
> +	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED are set,
> +	- 'L' both TIF_NEED_RESCHED_LAZY and PREEMPT_NEED_RESCHED are set,
> +	- 'b' both TIF_NEED_RESCHED and TIF_NEED_RESCHED_LAZY are set,
>  	- 'n' only TIF_NEED_RESCHED is set,
> +	- 'l' only TIF_NEED_RESCHED_LAZY is set,
>  	- 'p' only PREEMPT_NEED_RESCHED is set,
>  	- '.' otherwise.
>  

I wonder if we should also add this information in /sys/kernel/tracing/README
so that it is easier to find on a machine.

-- Steve

