Return-Path: <linux-kernel+bounces-18098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1B18258DE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398162850C5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7854732197;
	Fri,  5 Jan 2024 17:12:18 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D0331A8A;
	Fri,  5 Jan 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5763EC15;
	Fri,  5 Jan 2024 09:13:02 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.85.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58DD13F64C;
	Fri,  5 Jan 2024 09:12:13 -0800 (PST)
Date: Fri, 5 Jan 2024 17:12:10 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alan Maguire <alan.maguire@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v5 01/34] tracing: Add a comment about ftrace_regs
 definition
Message-ID: <ZZg4ahR5IDKwa6PU@FVFF77S0Q05N>
References: <170290509018.220107.1347127510564358608.stgit@devnote2>
 <170290510399.220107.17645951919819438730.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170290510399.220107.17645951919819438730.stgit@devnote2>

On Mon, Dec 18, 2023 at 10:11:44PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> To clarify what will be expected on ftrace_regs, add a comment to the
> architecture independent definition of the ftrace_regs.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  Changes in v3:
>   - Add instruction pointer
>  Changes in v2:
>   - newly added.
> ---
>  include/linux/ftrace.h |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index e8921871ef9a..8b48fc621ea0 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -118,6 +118,32 @@ extern int ftrace_enabled;
>  
>  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
>  
> +/**
> + * ftrace_regs - ftrace partial/optimal register set
> + *
> + * ftrace_regs represents a group of registers which is used at the
> + * function entry and exit. There are three types of registers.
> + *
> + * - Registers for passing the parameters to callee, including the stack
> + *   pointer. (e.g. rcx, rdx, rdi, rsi, r8, r9 and rsp on x86_64)
> + * - Registers for passing the return values to caller.
> + *   (e.g. rax and rdx on x86_64)
> + * - Registers for hooking the function call and return including the
> + *   frame pointer (the frame pointer is architecture/config dependent)
> + *   (e.g. rip, rbp and rsp for x86_64)
> + *
> + * Also, architecture dependent fields can be used for internal process.
> + * (e.g. orig_ax on x86_64)
> + *
> + * On the function entry, those registers will be restored except for
> + * the stack pointer, so that user can change the function parameters
> + * and instruction pointer (e.g. live patching.)
> + * On the function exit, only registers which is used for return values
> + * are restored.
> + *
> + * NOTE: user *must not* access regs directly, only do it via APIs, because
> + * the member can be changed according to the architecture.
> + */
>  struct ftrace_regs {
>  	struct pt_regs		regs;
>  };
> 

