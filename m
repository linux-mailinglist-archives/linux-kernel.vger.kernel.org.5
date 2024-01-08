Return-Path: <linux-kernel+bounces-19050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AED826738
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 02:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 075B7B2129B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 01:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36318C09;
	Mon,  8 Jan 2024 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHWezbc4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689D8BE7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 01:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704678995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrZ5E7rRsnkdiBF4vqSGlathax6Dq7mNMmU4TVzIiFM=;
	b=XHWezbc41XqzB/W+0o4Yj4YKDuwase99hgUexszTtwshrzkacRqEFsJ2FdTKAas4AmxRkW
	x6AyzlkFN/blT8VdPCbgFF5HHiLVguMRZFuE8OiTWM5SvL7ysHfe0q7Bp6WxVzsclXmmyX
	HqhuhNdUUl4wqjhcd/IuuAkv+ExDRWQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-S81HB8pKPXCiYUqLv1fNCA-1; Sun, 07 Jan 2024 20:56:33 -0500
X-MC-Unique: S81HB8pKPXCiYUqLv1fNCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 431268489E7;
	Mon,  8 Jan 2024 01:56:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.129])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 98F912166B33;
	Mon,  8 Jan 2024 01:56:32 +0000 (UTC)
Date: Mon, 8 Jan 2024 09:56:29 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, pmladek@suse.com, gcc@gcc.gnu.org
Subject: Re: [PATCH] panic: suppress gnu_printf warning
Message-ID: <ZZtWTcK3enKIygWM@MiWiFi-R3L-srv>
References: <20240107091641.579849-1-bhe@redhat.com>
 <20240107102103.3c0ba0cfa4df37df4b59090e@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240107102103.3c0ba0cfa4df37df4b59090e@linux-foundation.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 01/07/24 at 10:21am, Andrew Morton wrote:
> On Sun,  7 Jan 2024 17:16:41 +0800 Baoquan He <bhe@redhat.com> wrote:
> 
> > with GCC 13.2.1 and W=1, there's compiling warning like this:
> > 
> > kernel/panic.c: In function ‘__warn’:
> > kernel/panic.c:676:17: warning: function ‘__warn’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> >   676 |                 vprintk(args->fmt, args->args);
> >       |                 ^~~~~~~
> > 
> > The normal __printf(x,y) adding can't fix it. So add workaround which
> > disables -Wsuggest-attribute=format to mute it.
> > 
> > ...
> >
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -666,8 +666,13 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
> >  		pr_warn("WARNING: CPU: %d PID: %d at %pS\n",
> >  			raw_smp_processor_id(), current->pid, caller);
> >  
> > +#pragma GCC diagnostic push
> > +#ifndef __clang__
> > +#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
> > +#endif
> >  	if (args)
> >  		vprintk(args->fmt, args->args);
> > +#pragma GCC diagnostic pop
> >  
> >  	print_modules();
> 
> __warn() clearly isn't such a candidate.  I'm suspecting that gcc's
> implementation of this warning is pretty crude.  Is it a new thing in
> gcc-13.2?  

Yeah, this isn't like other warnings in kernel. The compiler seems too
smart by look into the  parameter 'args' of 'struct warn_args*'.

> 
> A bit of context for gcc@gcc.gnu.org:
> 
> struct warn_args {
> 	const char *fmt;
> 	va_list args;
> };
> 
> ...
> 
> void __warn(const char *file, int line, void *caller, unsigned taint,
> 	    struct pt_regs *regs, struct warn_args *args)
> {
> 	disable_trace_on_warning();
> 
> 	if (file)
> 		pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
> 			raw_smp_processor_id(), current->pid, file, line,
> 			caller);
> 	else
> 		pr_warn("WARNING: CPU: %d PID: %d at %pS\n",
> 			raw_smp_processor_id(), current->pid, caller);
> 
> 	if (args)
> 		vprintk(args->fmt, args->args);
> 
> 	print_modules();
> 
> 	if (regs)
> 		show_regs(regs);
> 
> 	check_panic_on_warn("kernel");
> 
> 	if (!regs)
> 		dump_stack();
> 
> 	print_irqtrace_events(current);
> 
> 	print_oops_end_marker();
> 	trace_error_report_end(ERROR_DETECTOR_WARN, (unsigned long)caller);
> 
> 	/* Just a warning, don't kill lockdep. */
> 	add_taint(taint, LOCKDEP_STILL_OK);
> }
> 


