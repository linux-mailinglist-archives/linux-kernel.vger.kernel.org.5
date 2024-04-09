Return-Path: <linux-kernel+bounces-137688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B539A89E5F3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDF7CB225BA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138A8158DAF;
	Tue,  9 Apr 2024 23:11:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B16C8564F;
	Tue,  9 Apr 2024 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704303; cv=none; b=ngKPQKkT178F2IJ/YZsQ8piHMMEDIpFqUQESE/eN7p3F9p7iy6E4N4cuM5ZsXKDeg20J2oMFkMSlR8TdNcWhQ1u/BuS9PmxZsoUdRyQmwYq5IJFv83QZLfDldnNNpcxLmwx9ms0e6MxjtXGLpwgSpF4FzNzkLQzkHCFo27a0QsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704303; c=relaxed/simple;
	bh=zqMvd3goUtBo22/1JXz1tlIsS734Ma7sGBUHXK3xrqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdwpLoW8hTl3BfIYdsDTge0LCuDKIp3O9DFfATKTflI3ufLJacUs4p6PUTp0wjVh8v0dVFfxAWtW8RVG4dcpZ98rC40Xm1UvIHzjB1KYx/wMKOb67WfRlaj+r8vICniaArYwqE0K3UqnUBQuEwfVByN7y+RK4yAhVA/pzSZIq5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F495C433C7;
	Tue,  9 Apr 2024 23:11:40 +0000 (UTC)
Date: Tue, 9 Apr 2024 19:14:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Ross
 Zwisler <zwisler@google.com>, wklin@google.com, Vineeth Remanan Pillai
 <vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 2/2] pstore/ramoops: Add ramoops.mem_name=
 command line option
Message-ID: <20240409191415.5a7b445f@gandalf.local.home>
In-Reply-To: <202404091514.B97720B8@keescook>
References: <20240409210254.660888920@goodmis.org>
	<20240409211351.234897475@goodmis.org>
	<202404091514.B97720B8@keescook>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 15:18:45 -0700
Kees Cook <keescook@chromium.org> wrote:

> > @@ -914,6 +919,19 @@ static void __init ramoops_register_dummy(void)
> >  {
> >  	struct ramoops_platform_data pdata;
> >  
> > +#ifndef MODULE
> > +	/* Only allowed when builtin */  
> 
> Why only when builtin?

Well, because the memory table that maps the found physical memory to a
lable is marked as __initdata, and will not be available after boot. If you
wanted it for a module, you would need some builtin code to find it.

> 
> > +	if (mem_name) {
> > +		u64 start;
> > +		u64 size;
> > +
> > +		if (memmap_named(mem_name, &start, &size)) {
> > +			mem_address = start;
> > +			mem_size = size;
> > +		}
> > +	}
> > +#endif  
> 
> Otherwise this looks good, though I'd prefer some comments about what's
> happening here.
> 
> (And in retrospect, separately, I probably need to rename "dummy" to
> "commandline" or something, since it's gathering valid settings here...)

Yeah, that was a bit confusing. I kept thinking "is this function stable?".

-- Steve

