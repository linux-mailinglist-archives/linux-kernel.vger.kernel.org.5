Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF28C7929EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354967AbjIEQaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354702AbjIENgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5B0191;
        Tue,  5 Sep 2023 06:36:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5320F609EB;
        Tue,  5 Sep 2023 13:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EB5C433C7;
        Tue,  5 Sep 2023 13:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693920999;
        bh=3kc77G13Twj+OR0TFxL3rm0LAU3kzvn7sJGLwOT/KyE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lRkf1G5XXsvZRREsWN72KNgh+/Ex5d9uSNWnUgW47RcKOeS/1RnvKfVRAHRWjVV9n
         C8pI6KVoh6Sv2JZ7iMXNcazirIuStaBspyEO6wVMnPXbMjQq5eZZ3enw/w5NNaIAsL
         VlNH8aWpJQA86cIKdTqEgsuO6uZwTb1JXdL0nG0/Zzo5eMaM/4VH8yqDchJADtf7EE
         OQnA6Wq2hEwbRhzG1dWBS+lclquaArIHZBcR9083BoVPPV3WWfjjJFulbD2xU8MdY7
         WVSqBWb1aeHnNlKZ204YgJZKsEysOwQ1HVfc3yIWe9xNvHm+OU5JL15iliIpVa+axQ
         fjayyVd9IbAYA==
Date:   Tue, 5 Sep 2023 22:36:33 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Florent Revest <revest@chromium.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 4/9] fprobe: rethook: Use ftrace_regs in fprobe exit
 handler and rethook
Message-Id: <20230905223633.23cd4e6e8407c45b934be477@kernel.org>
In-Reply-To: <yt9d5y4pozrl.fsf@linux.ibm.com>
References: <169280372795.282662.9784422934484459769.stgit@devnote2>
        <169280377434.282662.7610009313268953247.stgit@devnote2>
        <20230904224038.4420a76ea15931aa40179697@kernel.org>
        <yt9d5y4pozrl.fsf@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Sep 2023 09:17:02 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:
> 
> > I found that this is not enough becuase s390/loongarch already implemented
> > their rethook, and as far as I can see, the s390 ftrace_regs does not save
> > the required registers for rethook. Thus, for such architecture, we need
> > another kconfig flag and keep using the pt_regs for rethook.
> 
> Looking into arch_rethook_trampoline() i think we save all required
> registers - which register do you think are missing? Or is there another
> function i should look at?

Yes, arch_rethook_trampoline() is good. It needs to save all registers.

In this series, I'm trying to change the pt_regs with ftrace_regs which will
reduce trampoline overhead if DYNAMIC_FTRACE_WITH_ARGS=y.

kprobe -> (pt_regs) -> rethook_try_hook()
fprobe -> (ftrace_regs) -> rethook_try_hook_ftrace() # new function

Thus, we need to ensure that the ftrace_regs which is saved in the ftrace
*without* FTRACE_WITH_REGS flags, can be used for hooking the function
return. I saw;

void arch_rethook_prepare(struct rethook_node *rh, struct pt_regs *regs, bool mcount)
{
        rh->ret_addr = regs->gprs[14];
        rh->frame = regs->gprs[15];

        /* Replace the return addr with trampoline addr */
        regs->gprs[14] = (unsigned long)&arch_rethook_trampoline;
}

gprs[15] is a stack pointer, so it is saved in ftrace_regs too, but what about
gprs[14]? (I guess it is a link register)
We need to read the gprs[14] and ensure that is restored to gpr14 when the
ftrace is exit even without FTRACE_WITH_REGS flag.

IOW, it is ftrace save regs/restore regs code issue. I need to check how the
function_graph implements it.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
