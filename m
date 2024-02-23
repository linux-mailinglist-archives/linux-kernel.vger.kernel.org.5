Return-Path: <linux-kernel+bounces-77775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0F8860A17
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D24D1C22744
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFF011701;
	Fri, 23 Feb 2024 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm9Vb/ZA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7357A1119E;
	Fri, 23 Feb 2024 04:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708664221; cv=none; b=VDt+628UhMb/Q5n2JC+KFlr6by0wTaYQLaE0Zm5tIlQ9UPtk+k5s7u9loUsgiqFtT0QEoFVy97vgYGefremZKn2VHlw61i7oRdtpG6vLqrKESyvvi249oR1Rws603M4m5yliJOOmvhn8QSAX1ztyoZOR/AdzkUWWxXOaNOLyyCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708664221; c=relaxed/simple;
	bh=7x9O6YJuADgP4s+qZxFjc8202z6woBsZ+9FShLcBVi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM2kIYG/Qq7u+dCgCxrksHkTt2VOMjhoCzUk66gxt99bRPn4baHgnbvYnOXGbq67U4sNye5ESWZpZKXO2JZgWxLgVwhojjXXP/HmkRHz0On9GDGD2yfvJ49iIp1ATo/k7lNU+XlNQlBvpv3gfzeySPjJJAdr+Y6bC0oN1YupZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm9Vb/ZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7348C433F1;
	Fri, 23 Feb 2024 04:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708664220;
	bh=7x9O6YJuADgP4s+qZxFjc8202z6woBsZ+9FShLcBVi4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=fm9Vb/ZAMaDMDk8Z/RUM7GBOMS25QKtUcYkGxaG6+hk8ng3SBlwuGQCQ6HBJco0vI
	 KXiZGSQTS9n7FzvmlRMQaYXQan2W/3AgpHTQlgU4dxPPDxro6lxgLsb6dwFs2rBkpm
	 5t4cLZtfPU7l6yQN3YEJ2V2VkwIyxOU7m8r2z593H0e1n7gslBT7CgcfLnfASauJ4o
	 A7iU1WkbOj+gROoeAaO6uVnICfGpckkv+0DJafCC8Ot+tr8ivhQWX0h9G2XTWhXVlr
	 59kVKS0m6wiymigFw3708FyyRxsCP8cJFjsZcEf7t3x2G3741T+TR8P/2pZyCmilSt
	 UwIMcST4FxeHA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7EE09CE0B71; Thu, 22 Feb 2024 20:57:00 -0800 (PST)
Date: Thu, 22 Feb 2024 20:57:00 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Douglas Anderson <dianders@chromium.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH rcu 3/4] arch: Select new NEED_TASKS_RCU Kconfig option
Message-ID: <e022d9c2-0c22-4708-8e69-06583785f1ed@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <8c938bd5-6d62-4eff-9289-13b0d7ae8e17@paulmck-laptop>
 <20240223002627.1987886-3-paulmck@kernel.org>
 <20240222203651.410151c9@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222203651.410151c9@gandalf.local.home>

On Thu, Feb 22, 2024 at 08:36:51PM -0500, Steven Rostedt wrote:
> On Thu, 22 Feb 2024 16:26:26 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Currently, if a Kconfig option depends on TASKS_RCU, it conditionally does
> > "select TASKS_RCU if PREEMPTION".  This works, but requires any change in
> > this enablement logic to be replicated across all such "select" clauses.
> > A new NEED_TASKS_RCU Kconfig option has been created to allow this
> > enablement logic to be in one place in kernel/rcu/Kconfig.
> > 
> > Therefore, select the new NEED_TASKS_RCU Kconfig option instead of the
> > old TASKS_RCU option.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Ankur Arora <ankur.a.arora@oracle.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you!  I will apply on my next rebase.

							Thanx, Paul

> -- Steve
> 
> > ---
> >  arch/Kconfig | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index c91917b508736..154f994547632 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -55,7 +55,7 @@ config KPROBES
> >  	depends on MODULES
> >  	depends on HAVE_KPROBES
> >  	select KALLSYMS
> > -	select TASKS_RCU if PREEMPTION
> > +	select NEED_TASKS_RCU
> >  	help
> >  	  Kprobes allows you to trap at almost any kernel address and
> >  	  execute a callback function.  register_kprobe() establishes
> > @@ -104,7 +104,7 @@ config STATIC_CALL_SELFTEST
> >  config OPTPROBES
> >  	def_bool y
> >  	depends on KPROBES && HAVE_OPTPROBES
> > -	select TASKS_RCU if PREEMPTION
> > +	select NEED_TASKS_RCU
> >  
> >  config KPROBES_ON_FTRACE
> >  	def_bool y
> 

