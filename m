Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CC9773E42
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjHHQ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjHHQ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:26:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FC2892B;
        Tue,  8 Aug 2023 08:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A9FC6252A;
        Tue,  8 Aug 2023 12:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F82C433C8;
        Tue,  8 Aug 2023 12:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691496652;
        bh=pkrovgP4+Wn3orAqJdCz4u7ZpDIcXijXg4cZWRYrbuk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mWfXQTsMfEFI76jyUucwfKGd6dhrFw0lJYdFy7OlsaizWgQrn7tNIP+9e9+/bKFk2
         bXLf3fIAxNVl03SAFg1m93b4wfBGKSEqyee05SvjUSGrsYjDUtmUBo94mrKaPO9Fbh
         o6DoGip1L1fwlX/e6eTWvjWR3j9SS+Rnqmid6XVb63qE9yy2nu5naHZ8evWrjC49NY
         CNWz4E/g83wP6Ryg37h1sfjC5kKvDyBxndUiOeJZvVkBk2CAdRRpZ4ppazIjvDdcE9
         cPva2oxhfUV0BlbsWLeYO4rIMysdsZks2lXGEKx8DdXiNigUtj2B9uZwaWHgtn1b4F
         gRD2EGm/an5Xw==
Date:   Tue, 8 Aug 2023 21:10:46 +0900
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
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 4/5] ftrace: Add ftrace_partial_regs() for
 converting ftrace_regs to pt_regs
Message-Id: <20230808211046.45e1e964fa154278f467d6a8@kernel.org>
In-Reply-To: <169124751584.186149.17291016280237570755.stgit@devnote2>
References: <169124746774.186149.2326708176801468806.stgit@devnote2>
        <169124751584.186149.17291016280237570755.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  5 Aug 2023 23:58:35 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add ftrace_partial_regs() which converts the ftrace_regas to pt_regs.
> If the architecture defines its own ftrace_regs, this copies partial
> registers to pt_regs and returns it. If not, ftrace_regs is the same as
> pt_regs and ftrace_partial_regs() will return ftrace_regs::regs.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  arch/arm64/include/asm/ftrace.h |   11 +++++++++++
>  include/linux/ftrace.h          |   11 +++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
> index ab158196480c..b108cd6718cf 100644
> --- a/arch/arm64/include/asm/ftrace.h
> +++ b/arch/arm64/include/asm/ftrace.h
> @@ -137,6 +137,17 @@ ftrace_override_function_with_return(struct ftrace_regs *fregs)
>  	fregs->pc = fregs->lr;
>  }
>  
> +static __always_inline struct pt_regs *
> +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> +{
> +	memcpy(regs->regs, fregs->regs, sizeof(u64) * 10);
> +	regs->sp = fregs->sp;
> +	regs->pc = fregs->pc;
> +	regs->x[29] = fregs->fp;
> +	regs->x[30] = fregs->lr;

Oops, this is regs->regs[29] and regs->regs[30].

Thanks, 

> +	return regs;
> +}
> +
>  int ftrace_regs_query_register_offset(const char *name);
>  
>  int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index ce156c7704ee..f4fbc493aceb 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -139,6 +139,17 @@ static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs
>  	return arch_ftrace_get_regs(fregs);
>  }
>  
> +#if !defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS) || \
> +	defined(CONFIG_HAVE_PT_REGS_COMPAT_FTRACE_REGS)
> +
> +static __always_inline struct pt_regs *
> +ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
> +{
> +	return arch_ftrace_get_regs((struct ftrace_regs *)fregs);
> +}
> +
> +#endif /* !CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS || CONFIG_HAVE_PT_REGS_COMPAT_FTRACE_REGS */
> +
>  /*
>   * When true, the ftrace_regs_{get,set}_*() functions may be used on fregs.
>   * Note: this can be true even when ftrace_get_regs() cannot provide a pt_regs.
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
