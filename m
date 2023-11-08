Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A1C7E60E8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 00:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjKHXPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 18:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjKHXPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 18:15:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3614425B2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 15:14:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF50C433C8;
        Wed,  8 Nov 2023 23:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699485298;
        bh=xVGspZHqa7ebm1mR2Tje10arpm85obbIl39AN2mQJ3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JyHigs05zwlZLjVYeubaXm76pgBss7x0rTEEg8qQq5pvGqxmVPH8K+1b/U5iPjLMF
         eq80OH7wQ7WcCeUGl9LwR2wNjaK2n+kvxggmWu2utzB12SevBs2Qrjl2CzX7uSgGCX
         gEVvso4TBccpElYNkwz71aghzlGy6GtS5zKIErjkCNdcH4OUas2lT7WB2DYdOhucqB
         c4pG7oF1s7g6FW3EsFteIUDJhSQCSDk0qK8/GoXOf+ayLcO5szMUeW+3MERQqYvsT4
         F/PACmNXnItGac+sb/EhotsiimmtwlysRckjNgFkSx9grT2nodbj0UJ6A0dl9e0BA3
         PcbkbI58gTazA==
Date:   Thu, 9 Nov 2023 08:14:52 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH v2 01/31] tracing: Add a comment about ftrace_regs
 definition
Message-Id: <20231109081452.fd6e091df9df1bc7c5ced38b@kernel.org>
In-Reply-To: <169945347160.55307.1488323435914144870.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
        <169945347160.55307.1488323435914144870.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Nov 2023 23:24:32 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> To clarify what will be expected on ftrace_regs, add a comment to the
> architecture independent definition of the ftrace_regs.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - newly added.
> ---
>  include/linux/ftrace.h |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index e8921871ef9a..b174af91d8be 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -118,6 +118,31 @@ extern int ftrace_enabled;
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
> + * - Registers for hooking the function return including the frame pointer
> + *   (the frame pointer is architecture/config dependent)
> + *   (e.g. rbp and rsp for x86_64)

Oops, I found the program counter/instruction pointer must be saved too.
This is used for live patching. One question is that if the IP is modified
at the return handler, what should we do? Return to the specified address?

Thanks,

> + *
> + * Also, architecture dependent fields can be used for internal process.
> + * (e.g. orig_ax on x86_64)
> + *
> + * On the function entry, those registers will be restored except for
> + * the stack pointer, so that user can change the function parameters.
> + * On the function exit, onlu registers which is used for return values
> + * are restored.
> + *
> + * NOTE: user *must not* access regs directly, only do it via APIs, because
> + * the member can be changed according to the architecture.
> + */
>  struct ftrace_regs {
>  	struct pt_regs		regs;
>  };
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
