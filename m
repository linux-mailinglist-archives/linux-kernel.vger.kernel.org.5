Return-Path: <linux-kernel+bounces-137660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 987E189E597
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9BFB1C21ED1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB51158D87;
	Tue,  9 Apr 2024 22:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OquFZMZg"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180D615884B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712701129; cv=none; b=SAqAfReWjxWRuEk8V4NwVxSO5tflic0muNi4wCzhqWfuqRdAML7k1N4d0AAWZ/6/6elDTkNOHC8gFoUALMIkSe06galDSpRlw71W0gBUVwWea7F4G9xkeopT+LwBnRk3WGrCV0fNh7OnoHrEbewyj6oND1ul6vVaxdnKIyLsvxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712701129; c=relaxed/simple;
	bh=kQp/hvyGHh1SkSZ5gklhCTfn7rhxx+OeQkDZRYp1Nug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXdoCzzigtftYoI5moU3hk7hImQq3k0CxHd/uxt1YCou1gBH9c2lQgxv/sd2Bd+ecGDLT6xJ3o5uOqA1gFBKcep4LwRzyDAh7mEXZyQuIOSbJsv/tv+ZCagwXKiLu7jsL9cflewHOCQrFA8pKggRh/B+axnMj/cURtvDMun0eLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OquFZMZg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2232e30f4so54076985ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 15:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712701127; x=1713305927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F+JyR7XVHoRHZc6sojXb4+4iOMxV4P55AJcvcX75Hlk=;
        b=OquFZMZgTvKCVYELZbko8eqib+KvBGjts8jqA9LaDx87nJ2YlobYqxdYlxzsKAG5ze
         8UbeUbiV8s7AIJ+n0O3HVeeBpGD+xiMDRHkXdaTIqndXq0uH3itZu1/WFBi9TfiuTv9n
         fBG9TYqEliAZDgHjxtrvoK2BzHb/P0Z5b9hI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712701127; x=1713305927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+JyR7XVHoRHZc6sojXb4+4iOMxV4P55AJcvcX75Hlk=;
        b=KuiiBjDAm0mLRpTU0+193EdnjciFvPrRYDLuw29FvkvkExGXr8YWHqKEzIdjd4vJzQ
         ptw3SademoeW6xjC8tQB6X4NGfAw/SjGqILzvNmG6I9PIfrUWkPgJ3J5X7N7Nm6Khzgq
         T5q7Y68Ur/SGFtyli0csp2NjL4gZvnTsuC6p2upkM8ZgxPd2qsL90k7Azgqwvt/fYlAJ
         Tb/IN+ZhAeTWqhGa+QIzJAhOICNp0nm0VtU9Lu9yjZGNDdbZEAhOfhPwE/S6KTJPPSdF
         k2yrXNSIq4ImzgvOKMUVmu27XExncS/J9/03foD2G+7EC9/gd/nFrPjxkCKi/+3Djf2F
         ohnw==
X-Gm-Message-State: AOJu0Yy4aStAj24vfs4dBH4EuqSYzu2I9IR5yAwi4OikVr6ZTopTEJsF
	FWXvaHBTsSWh5NijwSGze+b8eerD9XbYhN5RRc9T/rLcMxcoNOajjN/51zGFUw==
X-Google-Smtp-Source: AGHT+IENZctdg8MkUuUiVzh50tzQyi+yJOAszWlX5nLtc5XoQbPa9E+CgbKpF8Y3/gmyeJNYOs1OWw==
X-Received: by 2002:a17:902:d4c1:b0:1e4:1873:843c with SMTP id o1-20020a170902d4c100b001e41873843cmr1191665plg.62.1712701127333;
        Tue, 09 Apr 2024 15:18:47 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090311cc00b001e223b9eb25sm9416376plh.153.2024.04.09.15.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 15:18:46 -0700 (PDT)
Date: Tue, 9 Apr 2024 15:18:45 -0700
From: Kees Cook <keescook@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [POC][RFC][PATCH 2/2] pstore/ramoops: Add ramoops.mem_name=
 command line option
Message-ID: <202404091514.B97720B8@keescook>
References: <20240409210254.660888920@goodmis.org>
 <20240409211351.234897475@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409211351.234897475@goodmis.org>

On Tue, Apr 09, 2024 at 05:02:56PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Add a method to find a region specified by memmap=nn*align:name for
> ramoops. Adding a kernel command line parameter:
> 
>   memmap=12M*4096:oops ramoops.mem_name=oops
> 
> Will use the size and location defined by the memmap parameter where it
> finds the memory and labels it "oops". The "oops" in the ramoops option
> is used to search for it.
> 
> This allows for arbitrary RAM to be used for ramoops if it is known that
> the memory is not cleared on kernel crashes or soft reboots.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  fs/pstore/ram.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index b1a455f42e93..c200388399fb 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -50,6 +50,11 @@ module_param_hw(mem_address, ullong, other, 0400);
>  MODULE_PARM_DESC(mem_address,
>  		"start of reserved RAM used to store oops/panic logs");
>  
> +static char *mem_name;
> +module_param_named(mem_name, mem_name, charp, 0400);
> +MODULE_PARM_DESC(mem_name,
> +		"name of kernel param that holds addr (builtin only)");
> +
>  static ulong mem_size;
>  module_param(mem_size, ulong, 0400);
>  MODULE_PARM_DESC(mem_size,
> @@ -914,6 +919,19 @@ static void __init ramoops_register_dummy(void)
>  {
>  	struct ramoops_platform_data pdata;
>  
> +#ifndef MODULE
> +	/* Only allowed when builtin */

Why only when builtin?

> +	if (mem_name) {
> +		u64 start;
> +		u64 size;
> +
> +		if (memmap_named(mem_name, &start, &size)) {
> +			mem_address = start;
> +			mem_size = size;
> +		}
> +	}
> +#endif

Otherwise this looks good, though I'd prefer some comments about what's
happening here.

(And in retrospect, separately, I probably need to rename "dummy" to
"commandline" or something, since it's gathering valid settings here...)

-- 
Kees Cook

