Return-Path: <linux-kernel+bounces-77630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F08860848
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8F61F23D87
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BD2BE6F;
	Fri, 23 Feb 2024 01:35:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826B5AD4B;
	Fri, 23 Feb 2024 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652102; cv=none; b=Re1/hvpzleCG46wCuJB0ZyvpqSFXZ9BCD1KTjNYR9BZVRMndt0eIKbzMWei+ESsuHKLvwilIg0KfRYqzSxH7z4WKiJLQDYdi1FB+naMz1pTNZY+wVI69+2s7UxIeSA+ypYO/t6cIVsMk3YKEl+c+8mTk1iaMA4D+nyaJIhJ3QLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652102; c=relaxed/simple;
	bh=bXEPELQj6UXcQp3AHH0JKTqXxOHMifJG9qOPbv1zezc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPH3cVwLZ/QGOzYB70rF4wK5d3LfNPEmSXi9+ky2gu0Tctd9tSqJ5EDGIrcK0KvQWjFnc1GDOuzdl8qXc3dGbVpn7WH0FW36aOUfLEjQnntrmmTTSS494VM3LurJlGlw2umQrx4YPofjkfRfmJr7YaeutK+4Lir+gf6Fr9k5V/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66D2C43390;
	Fri, 23 Feb 2024 01:35:00 +0000 (UTC)
Date: Thu, 22 Feb 2024 20:36:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann
 <arnd@arndb.de>, Douglas Anderson <dianders@chromium.org>, Ankur Arora
 <ankur.a.arora@oracle.com>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH rcu 3/4] arch: Select new NEED_TASKS_RCU Kconfig option
Message-ID: <20240222203651.410151c9@gandalf.local.home>
In-Reply-To: <20240223002627.1987886-3-paulmck@kernel.org>
References: <8c938bd5-6d62-4eff-9289-13b0d7ae8e17@paulmck-laptop>
	<20240223002627.1987886-3-paulmck@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 16:26:26 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Currently, if a Kconfig option depends on TASKS_RCU, it conditionally does
> "select TASKS_RCU if PREEMPTION".  This works, but requires any change in
> this enablement logic to be replicated across all such "select" clauses.
> A new NEED_TASKS_RCU Kconfig option has been created to allow this
> enablement logic to be in one place in kernel/rcu/Kconfig.
> 
> Therefore, select the new NEED_TASKS_RCU Kconfig option instead of the
> old TASKS_RCU option.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Ankur Arora <ankur.a.arora@oracle.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  arch/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index c91917b508736..154f994547632 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -55,7 +55,7 @@ config KPROBES
>  	depends on MODULES
>  	depends on HAVE_KPROBES
>  	select KALLSYMS
> -	select TASKS_RCU if PREEMPTION
> +	select NEED_TASKS_RCU
>  	help
>  	  Kprobes allows you to trap at almost any kernel address and
>  	  execute a callback function.  register_kprobe() establishes
> @@ -104,7 +104,7 @@ config STATIC_CALL_SELFTEST
>  config OPTPROBES
>  	def_bool y
>  	depends on KPROBES && HAVE_OPTPROBES
> -	select TASKS_RCU if PREEMPTION
> +	select NEED_TASKS_RCU
>  
>  config KPROBES_ON_FTRACE
>  	def_bool y


