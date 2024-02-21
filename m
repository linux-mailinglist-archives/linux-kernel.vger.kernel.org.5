Return-Path: <linux-kernel+bounces-75692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DFA85ED73
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C82FB22BE8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DD512D748;
	Wed, 21 Feb 2024 23:51:41 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE612C544
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559500; cv=none; b=ZhZ3qeE05PqVohij44CsDWCmuWKmz1+Semdn1Fp2JviLDxR7ZQ11fbaQwt7jffkGR4dL2gbhtKmn/9n4xT6NXFcBQmd4Ic1CKZm2nm80m29DKSATjHxpZEtE1SlkU55M4df4jbVReZRUtzz68vu8Be63e5UMK/O5rqTU4mEwZW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559500; c=relaxed/simple;
	bh=GEBGPPAlXg/DSVD8pbgIvIe1wHfhSDe11L2YQdQJz9A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iiTohWn4ExVEJrF8u/NvqLuOA+nlblw4w4hgskScIdK/5trktkteerqURPKnkLPZMRVlklyg5qZgUBYirzYwtqb64x0C3s4SIpJUXzxvFjmV1N5ok/YpCfeJu5rlKuxRukQx18nVBYCwNieqyeOMzxAV1LIyAkrFxUet4ZcObTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248B3C433F1;
	Wed, 21 Feb 2024 23:51:36 +0000 (UTC)
Date: Wed, 21 Feb 2024 18:53:24 -0500
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
Message-ID: <20240221185324.66986c9a@gandalf.local.home>
In-Reply-To: <87bk89e72r.fsf@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
	<20240213055554.1802415-30-ankur.a.arora@oracle.com>
	<20240221164334.6f8c69e8@gandalf.local.home>
	<87bk89e72r.fsf@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 15:22:20 -0800
Ankur Arora <ankur.a.arora@oracle.com> wrote:


> > I wonder if we should also add this information in /sys/kernel/tracing/README
> > so that it is easier to find on a machine.  
> 
> Yeah, there is a problem with the discovery. Seems a little out of place
> in tracing/README though.
> 
> How about something like this? Though this isn't really a model of clarity.

Could work, but I would also have it check the configs that are set in the
kernel, and only show the options that are available with the current
configs that are enabled in the kernel.

> 
>     --- a/kernel/trace/trace.c
>     +++ b/kernel/trace/trace.c
>     @@ -4292,7 +4292,7 @@ static void print_lat_help_header(struct seq_file *m)
>     {
>             seq_puts(m, "#                    _------=> CPU#            \n"
>                     "#                   / _-----=> irqs-off/BH-disabled\n"
>     -                   "#                  | / _----=> need-resched    \n"
>     +                   "#                  | / _----=> need-resched  [ l: lazy, n: now, p: preempt, b: l|n, L: l|p, N: n|p, B: l|n|p ]\n"
>                     "#                  || / _---=> hardirq/softirq \n"
>                     "#                  ||| / _--=> preempt-depth   \n"
>                     "#                  |||| / _-=> migrate-disable \n"
> 
> 
> Also, haven't looked at trace-cmd. Anything I should be sending a patch
> out for?

There's really nothing that explains it. But that probably should be fixed.

-- Steve


