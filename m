Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F247E7E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345890AbjKJRoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235036AbjKJRnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:43:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0401F83E7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 23:17:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25074C433C8;
        Fri, 10 Nov 2023 07:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699600666;
        bh=mZiJ9Td++XlK5uAAB4qKyf/MCPDMIrq0nMmKby/gJag=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rbi08Qqr2TYOjwc5dSkoT6yW5Ku4Ne2FfD8IwpZR93OJiz1jWrYIox5Cnoar3kj+3
         lBiBZ8xC+m9BRFv1fIVcIvexFmpoBvH4yOZwMAuljOUP9cDO02npfNw/kXccfrP2Kl
         T22qfAchu/gD2tJkVCKHw8pKBPDrCdGQnVlcPI0DAPCp4Mj08pEsvTCOV8Vchc4xzO
         1hMtY62rTCv7SyL/F6seB8h3SWFqS5c+g5UqX29wbhVGUF/en0VQow0gD9XtvJxrwC
         S1mpeztcpbAp608Sh5ZZyrGOPbAr0i0DuI5zUBp8dr6PXVJc2QjG6ny86Lt9HSc5nL
         FSSqO3pckiE2Q==
Date:   Fri, 10 Nov 2023 16:17:39 +0900
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
Subject: Re: [RFC PATCH v2 26/31] fprobe: Rewrite fprobe on function-graph
 tracer
Message-Id: <20231110161739.f0ff9c50f20ebcfb57be6459@kernel.org>
In-Reply-To: <169945376173.55307.5892275268096520409.stgit@devnote2>
References: <169945345785.55307.5003201137843449313.stgit@devnote2>
        <169945376173.55307.5892275268096520409.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed,  8 Nov 2023 23:29:22 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> + */
> +static inline int __fprobe_handler(unsigned long ip, unsigned long parent_ip,
> +				   struct fprobe *fp, struct ftrace_regs *fregs,
> +				   void *data)
> +{
> +	int ret = 0;
>  
> +	if (fp->entry_handler) {
> +		if (fp->exit_handler && fp->entry_data_size)
> +			data += sizeof(unsigned long);
> +		else
> +			data = NULL;
> +		ret = fp->entry_handler(fp, ip, parent_ip, fregs, data);
> +	}
> +
> +	return ret;
> +}
> +
> +static inline int __fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
> +					  struct fprobe *fp, struct ftrace_regs *fregs,
> +					  void *data)
> +{
> +	int ret;
>  	/*
>  	 * This user handler is shared with other kprobes and is not expected to be
>  	 * called recursively. So if any other kprobe handler is running, this will
> @@ -108,45 +210,173 @@ static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
>  	 */
>  	if (unlikely(kprobe_running())) {
>  		fp->nmissed++;
> -		goto recursion_unlock;
> +		return 0;
>  	}
>  
>  	kprobe_busy_begin();
> -	__fprobe_handler(ip, parent_ip, ops, fregs);
> +	ret = __fprobe_handler(ip, parent_ip, fp, fregs, data);
>  	kprobe_busy_end();
> -
> -recursion_unlock:
> -	ftrace_test_recursion_unlock(bit);
> +	return ret;
>  }
>  
> -static void fprobe_exit_handler(struct rethook_node *rh, void *data,
> -				unsigned long ret_ip, struct pt_regs *regs)
> +static int fprobe_entry(unsigned long func, unsigned long ret_ip,
> +			struct ftrace_regs *fregs, struct fgraph_ops *gops)
>  {
> -	struct fprobe *fp = (struct fprobe *)data;
> -	struct fprobe_rethook_node *fpr;
> -	struct ftrace_regs *fregs = (struct ftrace_regs *)regs;
> -	int bit;
> +	struct fprobe_hlist_node *node, *first;
> +	unsigned long header;
> +	void *fgraph_data = NULL;
> +	struct fprobe *fp;
> +	int size, used, ret;
>  
> -	if (!fp || fprobe_disabled(fp))
> -		return;
> +	if (WARN_ON_ONCE(!fregs))
> +		return 0;
>  
> -	fpr = container_of(rh, struct fprobe_rethook_node, node);
> +	first = node = find_first_fprobe_node(func);
> +	if (unlikely(!first))
> +		return 0;
> +
> +	size = 0;
> +	hlist_for_each_entry_from_rcu(node, hlist) {
> +		if (node->addr != func)
> +			break;
> +		fp = READ_ONCE(node->fp);
> +		/*
> +		 * Since fprobe can be enabled until the next loop, we ignore the
> +		 * disabled flag in this loop.
> +		 */
> +		if (fp && fp->exit_handler)
> +			size += FPROBE_HEADER_SIZE + fp->entry_data_size;
> +	}
> +	node = first;
> +	/* size can be 0 because fp only has entry_handler. */
> +	if (size) {
> +		fgraph_data = fgraph_reserve_data(size);
> +		if (unlikely(!fgraph_data)) {
> +			hlist_for_each_entry_from_rcu(node, hlist) {
> +				if (node->addr != func)
> +					break;
> +				fp = READ_ONCE(node->fp);
> +				if (fp && !fprobe_disabled(fp))
> +					fp->nmissed++;
> +			}
> +			return 0;
> +		}
> +	}
>  
>  	/*
> -	 * we need to assure no calls to traceable functions in-between the
> -	 * end of fprobe_handler and the beginning of fprobe_exit_handler.
> +	 * TODO: recursion detection has been done in the fgraph. Thus we need
> +	 * to add a callback to increment missed counter.
>  	 */
> -	bit = ftrace_test_recursion_trylock(fpr->entry_ip, fpr->entry_parent_ip);
> -	if (bit < 0) {
> -		fp->nmissed++;
> +	used = 0;
> +	hlist_for_each_entry_from_rcu(node, hlist) {
> +		if (node->addr != func)
> +			break;
> +		fp = READ_ONCE(node->fp);
> +		if (!fp || fprobe_disabled(fp))
> +			continue;
> +
> +		if (fprobe_shared_with_kprobes(fp))
> +			ret = __fprobe_kprobe_handler(func, ret_ip,
> +					fp, fregs, fgraph_data + used);
> +		else
> +			ret = __fprobe_handler(func, ret_ip, fp,
> +					fregs, fgraph_data + used);


Since the fgraph callback is under rcu-locked but not preempt-disabled,
fprobe unittest fails. I need to add preempt_disable_notrace() and
preempt_enable_notrace() around this. Note that kprobe_busy_begin()/end()
also access to per-cpu variable, so it requires to disable preemption.

Thank you,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
