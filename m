Return-Path: <linux-kernel+bounces-14550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA2F821E87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61C51C2248F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D79A13AF4;
	Tue,  2 Jan 2024 15:16:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC87813FE2;
	Tue,  2 Jan 2024 15:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D46C433C8;
	Tue,  2 Jan 2024 15:16:12 +0000 (UTC)
Date: Tue, 2 Jan 2024 10:17:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Alexander Potapenko
 <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph
 Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko
 Carstens <hca@linux.ibm.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco
 Elver <elver@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, Pekka
 Enberg <penberg@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Vlastimil
 Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle
 <svens@linux.ibm.com>
Subject: Re: [PATCH v3 01/34] ftrace: Unpoison ftrace_regs in
 ftrace_ops_list_func()
Message-ID: <20240102101712.515e0fe3@gandalf.local.home>
In-Reply-To: <20231213233605.661251-2-iii@linux.ibm.com>
References: <20231213233605.661251-1-iii@linux.ibm.com>
	<20231213233605.661251-2-iii@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 00:24:21 +0100
Ilya Leoshkevich <iii@linux.ibm.com> wrote:

> Architectures use assembly code to initialize ftrace_regs and call
> ftrace_ops_list_func(). Therefore, from the KMSAN's point of view,
> ftrace_regs is poisoned on ftrace_ops_list_func entry(). This causes
> KMSAN warnings when running the ftrace testsuite.

BTW, why is this only a problem for s390 and no other architectures?

If it is only a s390 thing, then we should do this instead:

in include/linux/ftrace.h:

/* Add a comment here to why this is needed */
#ifndef ftrace_list_func_unpoison
# define ftrace_list_func_unpoison(fregs) do { } while(0)
#endif

In arch/s390/include/asm/ftrace.h:

/* Add a comment to why s390 is special */
# define ftrace_list_func_unpoison(fregs) kmsan_unpoison_memory(fregs, sizeof(*fregs))

> 
> Fix by trusting the architecture-specific assembly code and always
> unpoisoning ftrace_regs in ftrace_ops_list_func.
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I'm taking my ack away for this change in favor of what I'm suggesting now.

> Reviewed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  kernel/trace/ftrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8de8bec5f366..dfb8b26966aa 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7399,6 +7399,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  void arch_ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
>  			       struct ftrace_ops *op, struct ftrace_regs *fregs)
>  {
> +	kmsan_unpoison_memory(fregs, sizeof(*fregs));

And here have:

	ftrace_list_func_unpoison(fregs);

That way we only do it for archs that really need it, and do not affect
archs that do not.


I want to know why this only affects s390, because if we are just doing
this because "it works", it could be just covering up a symptom of
something else and not actually doing the "right thing".


-- Steve


>  	__ftrace_ops_list_func(ip, parent_ip, NULL, fregs);
>  }
>  #else


