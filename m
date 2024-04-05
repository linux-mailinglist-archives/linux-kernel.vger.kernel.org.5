Return-Path: <linux-kernel+bounces-132886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 403B8899B93
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29B71F243F6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3695616C427;
	Fri,  5 Apr 2024 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HznEYMMg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD1916C428
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315054; cv=none; b=h3IMfxZFtY9P5tfLBH8mD0KA9nlFPl8WV1bWuobRJBdaQ2KJy8fFeA1J3s67yF5qjssqhZfAwrKKIRuYYeh6gFWf1jArpBazYpC3TAN3/khSWJ0uaBHNEpMGVV7qpFZC4SufDedqOOhlXb6WYMrz8BMT7hHuV3ElJ/73fJnv9GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315054; c=relaxed/simple;
	bh=wBMV5p3J2JTZi1smUXpNuqqWSBvAhb9I78iswaEzVSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNukQ0PqNx3L3LJE/OJzC7qqD9SY+3bsfCdfAQvugbSvpi2NlrBOmCI7/W8HnW3rjf4sJ5OJKOve6IAtcsX9pyflUDpTfJ7U3BhfOpTI+HhvIfDHPq9fIzHWGDAvoGPONaVbUqNB+lGeSTWhkDj1NWoaW8kPMBBqdpfJvsGriUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HznEYMMg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712315051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SEi1RTqH8QtMZRPSPitoNGJj8IFtnVKgY7uUM21+oVQ=;
	b=HznEYMMgbkHldGkF0W1+VQeFhW7+eAtDKWvxbb6Mo2AUHa2M8dxGnCNRJMreRcmQMXzT0R
	FPVyeI3Zn02rmQuKD4sqi3/zJJCGe5sSgnpuJ05G5Dm/4Jgjbbl58R8Nx13hEfedqQWNi4
	tiDg0SZxNgOR4XTS1I0Aj6ayRB9y9V8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-434-rAG5sZ48NdmSfgSkG70qyQ-1; Fri,
 05 Apr 2024 07:04:07 -0400
X-MC-Unique: rAG5sZ48NdmSfgSkG70qyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 103431C06509;
	Fri,  5 Apr 2024 11:04:07 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.136])
	by smtp.corp.redhat.com (Postfix) with SMTP id 3459F202451F;
	Fri,  5 Apr 2024 11:04:00 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  5 Apr 2024 13:02:42 +0200 (CEST)
Date: Fri, 5 Apr 2024 13:02:30 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCHv2 1/3] uprobe: Add uretprobe syscall to speed up return
 probe
Message-ID: <20240405110230.GA22839@redhat.com>
References: <20240403100708.233575a8ac2a5bac2192d180@kernel.org>
 <Zg0lvUIB4WdRUGw_@krava>
 <20240403230937.c3bd47ee47c102cd89713ee8@kernel.org>
 <CAEf4BzZ2RFfz8PNgJ4ENZ0us4uX=DWhYFimXdtWms-VvGXOjgQ@mail.gmail.com>
 <20240404095829.ec5db177f29cd29e849169fa@kernel.org>
 <CAEf4BzYH60TwvBipHWB_kUqZZ6D-iUVnnFsBv06imRikK3o-bg@mail.gmail.com>
 <20240405005405.9bcbe5072d2f32967501edb3@kernel.org>
 <20240404161108.GG7153@redhat.com>
 <20240405102203.825c4a2e9d1c2be5b2bffe96@kernel.org>
 <Zg-8r63tPSkuhN7p@krava>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg-8r63tPSkuhN7p@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 04/05, Jiri Olsa wrote:
>
> On Fri, Apr 05, 2024 at 10:22:03AM +0900, Masami Hiramatsu wrote:
> >
> > I think this expects setjmp/longjmp as below
> >
> > foo() { <- retprobe1
> > 	setjmp()
> > 	bar() { <- retprobe2
> > 		longjmp()
> > 	}
> > } <- return to trampoline
> >
> > In this case, we need to skip retprobe2's instance.

Yes,

> > My concern is, if we can not find appropriate return instance, what happen?
> > e.g.
> >
> > foo() { <-- retprobe1
> >    bar() { # sp is decremented
> >        sys_uretprobe() <-- ??
> >     }
> > }
> >
> > It seems sys_uretprobe() will handle retprobe1 at that point instead of
> > SIGILL.
>
> yes, and I think it's fine, you get the consumer called in wrong place,
> but it's your fault and kernel won't crash

Agreed.

With or without this patch userpace can also do

	foo() { <-- retprobe1
		bar() {
			jump to xol_area
		}
	}

handle_trampoline() will handle retprobe1.

> this can be fixed by checking the syscall is called from the trampoline
> and prevent handle_trampoline call if it's not

Yes, but I still do not think this makes a lot of sense. But I won't argue.

And what should sys_uretprobe() do if it is not called from the trampoline?
I'd prefer force_sig(SIGILL) to punish the abuser ;) OK, OK, EINVAL.

I agree very much with Andrii,

       sigreturn()  exists only to allow the implementation of signal handlers.  It should never be
       called directly.  Details of the arguments (if any) passed to sigreturn() vary depending  on
       the architecture.

this is how sys_uretprobe() should be treated/documented.

sigreturn() can be "improved" too. Say, it could validate sigcontext->ip
and return -EINVAL if this addr is not valid. But why?

Oleg.


