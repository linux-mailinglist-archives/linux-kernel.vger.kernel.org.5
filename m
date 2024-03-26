Return-Path: <linux-kernel+bounces-120019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C8D88D05C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA8B323CFC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3842813D89D;
	Tue, 26 Mar 2024 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlzG0wQu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE541BDE2
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711490189; cv=none; b=Pun5fIC4iCK3T0IGDZIHpuZ1KmTsJ9e9AsXoKqimERmSun8nLGfqt1k7pfWiqu+C+g6z23pmcDxYadfvts1fLz47Mpcg8JJUOx30REEakwm6FVAs7ECKxhWxJ09tJ59WIDFwm7tYGABca0SuqRwnXayeoRTv413RLwvBlVeW3X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711490189; c=relaxed/simple;
	bh=rticaKSkNXtLAah/DcO10tnHpkHEUxzhAjmk2lHxWh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYIKK6wKRtMYeR2z2TRAHL9oNNSn5TqcEKgqgCJQXZxOUFyj1I+KIlF5Nr9052KuxCXkpB7xbf71RPZgYNmwmRqjrtKOjXEk+82r0hpeyclA7Jjof7XOHNy+XhvVftc8gbaGJu14SOhUy1hC75fjx354nZfIX89fnA/Pf/9C8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlzG0wQu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711490186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXRJlmHr8dNjmYlro5igs5sjTAMa+eNATefD7hFXNL8=;
	b=PlzG0wQuIefC8PuWRk9OrTZgtsP4tVxPoVkBpevaVVEW9Tt8EtLI9ZdT81hqYnvRK4wQGi
	XJYxkQVqsm43AfLgfSLuDdzq3GCUa+Wya1KpiFiKxER3iCbDWaEnfMWcsd/5H1yMG0MwCA
	yJrJe4ggd0P6UPzd+VRNmQX9pFLTDTU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-k5ZSi_inN7uxH4zw68H3hg-1; Tue,
 26 Mar 2024 17:56:23 -0400
X-MC-Unique: k5ZSi_inN7uxH4zw68H3hg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D45E3C28643;
	Tue, 26 Mar 2024 21:56:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.50])
	by smtp.corp.redhat.com (Postfix) with SMTP id BB38E3C22;
	Tue, 26 Mar 2024 21:56:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 26 Mar 2024 22:54:59 +0100 (CET)
Date: Tue, 26 Mar 2024 22:54:36 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 1/1] headers/deps: x86/fpu: Make task_struct::thread
 constant size
Message-ID: <20240326215435.GB4539@redhat.com>
References: <20240320131908.2708438-1-mingo@kernel.org>
 <20240320131908.2708438-2-mingo@kernel.org>
 <20240326174903.GA4539@redhat.com>
 <ZgMeH9p0BTnMfmOM@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgMeH9p0BTnMfmOM@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 03/26, Ingo Molnar wrote:
>
> * Oleg Nesterov <oleg@redhat.com> wrote:
>
> > > +static struct fpu x86_init_fpu __read_mostly;
> > > +
> > >  static void __init fpu__init_system_early_generic(void)
> > >  {
> > > +	{
> > > +		int this_cpu = smp_processor_id();
> > > +
> > > +		fpstate_reset(&x86_init_fpu);
> > > +		current->thread.fpu = &x86_init_fpu;
> > > +		per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
> > > +		x86_init_fpu.last_cpu = this_cpu;
> > > +	}
> >
> > Can't x86_init_fpu be declared inside the block above?
>
> As a function-local static? I think globals are better defined in a visible
> fashion, not hidden among local variables where they are easy to overlook.

OK, but please see below.

> Yeah. Something like the delta patch below?

LGTM. And the whole patch too, although I don't think I can review it ;)

but... Ingo, let me ask 2 stupid questions.

1. Can you split this patch? I mean, 1/2 should add something like

	struct fpu *x86_task_fpu(struct task_struct *task)
	{
		return &target->thread.fpu;
	}

    somewhere in arch/x86/include and update all the users of ->thread.fpu
    to use the new helper. No functional changes.

    This way 2/2 which actually turns .fpu into a pointer will be MUCH simpler.

2. Now, 2/2 should change the new helper above to

		return target->thread.fpu;

   But! why do we need the thread_struct.fpu pointer at all? Can't we simply have

	struct fpu *x86_task_fpu(struct task_struct *task)
	{
		return (void *)task + sizeof(*task);
	}

   ? This is what fpu_clone() (with your patch) does anyway.

   Yes, this needs some changes:

   	- exit_thread() - trivial

	- arch_dup_task_struct() clears thread.fpu, but I guess this is unnecessary

	- fpu_clone() initializes dst->thread.fpu, no longer needed

	- finally, fpu__init_system_early_generic() which initializes the
	  init_task.thread.fpu pointer.

	  But this doesn't look difficult? Although I don't understand the magic in
	  arch/x86/kernel/vmlinux.lds.S ...

Oleg.


