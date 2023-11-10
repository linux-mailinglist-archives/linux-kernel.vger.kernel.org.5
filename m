Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF9F7E76D7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345653AbjKJBwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345556AbjKJBwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:52:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C444BD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:52:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D986C433C8;
        Fri, 10 Nov 2023 01:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699581120;
        bh=J9vQ+Kmgge+nJHe/X2kvlE4Nnc93Z4wgtGyi4UAgnyA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MRZSP5u5vGR4QKjCyUk61frnPioX1lYpIv+EIH8hWTF/+CXP8nFyJewLLDTuyGAwd
         4JjuLshv11p1PDK0yPjKixTDGtaU+RcihGk2yDjy1+jtUgLmOiP8PZeRpjYZALQsDK
         qw6BBPO3/6ikraVycSxMXKILEoLeqIIFogk6744Fs5hc/MRQbcJeZ7jVHkPcrndzrK
         FZI8VuKmkoJPLXO8IOH6I0gTteTH+jqH5AQM8fGLLNTuMFTShzTkGUNph1fr6iXflo
         3YbYXsMyH8P/MZaeXcfoPg0Sya2mMCEMQQUT+pr8maX6ZOQeZTQx6qa3upAANRqOjl
         dGEvAfO1xyI6g==
Date:   Fri, 10 Nov 2023 10:51:54 +0900
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
Subject: Re: [RFC PATCH v2 12/31] function_graph: Have the instances use
 their own ftrace_ops for filtering
Message-Id: <20231110105154.df937bf9f200a0c16806c522@kernel.org>
In-Reply-To: <169945360154.55307.2938894711228282149.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
        <169945360154.55307.2938894711228282149.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found strange behavior that if we set two or more probes on the same function,
its callback called twice or more. Also, the stacktrace failed.
And I found the root cause is here;

On Wed,  8 Nov 2023 23:26:42 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -910,9 +917,10 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  		 */
>  		ftrace_graph_return = return_run;
>  		ftrace_graph_entry = entry_run;
> -
> -		ret = ftrace_startup(&graph_ops, FTRACE_START_FUNC_RET);
> +		command = FTRACE_START_FUNC_RET;
>  	}
> +
> +	ret = ftrace_startup(&gops->ops, command);

So this patch registers ftrace_ops for each fgraph_ops to ftrace.
This means that the ftrace_graph_func() will be called twice or more
on the same function.
Thus should I call ftrace_startup() once when the first fgraph_ops
is registered? 
No, it's not enough. Actually each fgraph_ops can have different filters.
We need to define a shared filter and combine new filters to one and
use it. We also need to do it when a fgraph is unregistered.

Is there any function which makes a new filter from two (or more) filters?

Or, maybe we can make the common callback to find the previous ret entry on
the ret_stack and reuse it. (In this case we don't need loop on each
fgraph_array entry)

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
