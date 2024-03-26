Return-Path: <linux-kernel+bounces-119630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 338FA88CB59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB016B294A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF128627A;
	Tue, 26 Mar 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYcK9D3h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000401CFB5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475446; cv=none; b=nMvsI941XNezLnVJ4Eh58nWOjFfpKjKfq0QAnngwAonvaExsTkeo3saTGLsFm25c2xCut+jkMK3+UCRdgacKaJptaYSe56b88FeP5PL2XqQzSYyZaNzv+VVRAmSK1YuKAfyPer7QJJKky/tzGCWteIn50PicZEdjURKRO66ErQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475446; c=relaxed/simple;
	bh=ZgKMK8xswTHSw8bkndycLMlEayJd2LqASlPalDvSrvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjRX7+A7Tkm9ZFtiAv9qgFfeH92iT+6TEEXtni4dOftpUUmQE5XHpCs+U7ZRWGWD5+66GYWYuHIS04NsJaemGAW/9PRZXuPGmciATUaasz6HeI3Dt+1u/p80/6IVSmbx2uKB9p/ONAjw5cMxG+0F8oJbL9soPSEWgJne+tXxZDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYcK9D3h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711475443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OInvw2pLCNL9a/HYNNz1Jd3xF0ugYHZTriTHSuVCyz0=;
	b=LYcK9D3hQSBwcHlpFLwIkA/5lFgs9u5beLs9ms55EArzbVCAcVf7aw3RMefCYL5buGqDgg
	TSLxihvW45QMCv/nTEZTnNx0ojBzLpaiTS8Gx2hkz2CaQn4iWqyYN+5IH7wTRdMB0Dkxyp
	V+e5Jhbj+5WM5E32CWagq7usKo9rK8s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-mmcdDO0QN_iUXDYzsWu3UQ-1; Tue,
 26 Mar 2024 13:50:35 -0400
X-MC-Unique: mmcdDO0QN_iUXDYzsWu3UQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C4A438035A9;
	Tue, 26 Mar 2024 17:50:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.68])
	by smtp.corp.redhat.com (Postfix) with SMTP id BB232C66106;
	Tue, 26 Mar 2024 17:50:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 26 Mar 2024 18:49:10 +0100 (CET)
Date: Tue, 26 Mar 2024 18:49:03 +0100
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
Message-ID: <20240326174903.GA4539@redhat.com>
References: <20240320131908.2708438-1-mingo@kernel.org>
 <20240320131908.2708438-2-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320131908.2708438-2-mingo@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 03/20, Ingo Molnar wrote:
>
> --- a/arch/x86/kernel/fpu/init.c
> +++ b/arch/x86/kernel/fpu/init.c
> @@ -38,7 +38,7 @@ static void fpu__init_cpu_generic(void)
>  	/* Flush out any pending x87 state: */
>  #ifdef CONFIG_MATH_EMULATION
>  	if (!boot_cpu_has(X86_FEATURE_FPU))
> -		fpstate_init_soft(&current->thread.fpu.fpstate->regs.soft);
> +		fpstate_init_soft(current->thread.fpu->fpstate->regs.soft);
                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Typo? it should be

	&current->thread.fpu->fpstate->regs.soft

> +static struct fpu x86_init_fpu __read_mostly;
> +
>  static void __init fpu__init_system_early_generic(void)
>  {
> +	{
> +		int this_cpu = smp_processor_id();
> +
> +		fpstate_reset(&x86_init_fpu);
> +		current->thread.fpu = &x86_init_fpu;
> +		per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
> +		x86_init_fpu.last_cpu = this_cpu;
> +	}

Can't x86_init_fpu be declared inside the block above?

>  void __init fpu__init_system(void)
>  {
> -	fpstate_reset(&current->thread.fpu);
>  	fpu__init_system_early_generic();
> +	fpstate_reset(current->thread.fpu);

It seems that fpstate_reset(current->thread.fpu) is not needed after the
change in fpu__init_system_early_generic() above.

Oleg.


